Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01AC7B8193
	for <lists+linux-pci@lfdr.de>; Wed,  4 Oct 2023 16:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242731AbjJDOBK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Oct 2023 10:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242747AbjJDOBJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Oct 2023 10:01:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D1AD8;
        Wed,  4 Oct 2023 07:01:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76ADAC433C8;
        Wed,  4 Oct 2023 14:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696428064;
        bh=ZXfdVsNac93kNUS4gIvDRTAkfJjEGoRUuo+eHBQdlrk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Q2Kyno5RZ4oCSaQTGQLDY+x4/1Ucb0kiGgSJiAP00lVdDiNXqDfgBnPja1ASnP0c8
         SI09gqkq6yQ2RnvxXkIOVZ2pl7xB1phV01hclnTT8E0fXbz3Vtf7J91b1lE0tNE2Zb
         vb0FX5r9s8DvYC2CDCHJnpy3dNKZ+5DTCMdGHWcoP7sawxk5mzJgI02x1GvusiDQon
         Os8fkceU1jck+ycS+U9pMj1S4WJ7bb3IQ0+yNT2ivUnquaZzXQI7Ym+QwDzbq/6hMU
         Addw4/HhUGz3DwpJSWfUl03cj051xDzfqd5q0HhQ2Ltqq6MBLocqrZ8J8cImbwaWRn
         LFM0bTS0UrMaQ==
Date:   Wed, 4 Oct 2023 09:01:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH pci-next v6 1/2] PCI/VGA: Make the
 vga_is_firmware_default() less arch-dependent
Message-ID: <20231004140102.GA709356@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2209054-4e66-a084-c0bc-d35a7fd2fdad@loongson.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 04, 2023 at 08:55:04PM +0800, Sui Jingfeng wrote:
> On 2023/10/3 23:54, Bjorn Helgaas wrote:
> > On Mon, Oct 02, 2023 at 08:05:10PM +0800, Sui Jingfeng wrote:
> > > Currently, the vga_is_firmware_default() function only works on x86 and
> > > ia64, it is a no-op on the rest of the architectures. This patch completes
> > > the implementation for it, the added code tries to capture the PCI (e) VGA
> > > device that owns the firmware framebuffer, since only one GPU could own
> > > the firmware fb, things are almost done once we have determined the boot
> > > VGA device. As the PCI resource relocation do have a influence on the
> > > results of identification, we make it available on architectures where PCI
> > > resource relocation does happen at first. Because this patch is more
> > > important for those architectures(such as arm, arm64, loongarch, mips and
> > > risc-v etc).
> >
> > There's a little too much going on this this patch.  The problem is
> > very simple: currently we compare firmware BAR assignments with BARs
> > that may have been reassigned by Linux.
> > 
> > What if we did something like the patch below?  I think it will be
> > less confusing if we only have one copy of the code related to
> > screen_info.
> > 
> > > Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> > > ---
> > >   drivers/pci/vgaarb.c | 76 ++++++++++++++++++++++++++++++++++++++++++++
> > >   1 file changed, 76 insertions(+)
> > > 
> > > diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> > > index 5e6b1eb54c64..02821c0f4cd0 100644
> > > --- a/drivers/pci/vgaarb.c
> > > +++ b/drivers/pci/vgaarb.c
> > > @@ -60,6 +60,9 @@ static bool vga_arbiter_used;
> > >   static DEFINE_SPINLOCK(vga_lock);
> > >   static DECLARE_WAIT_QUEUE_HEAD(vga_wait_queue);
> > > +/* The PCI(e) VGA device which owns the firmware framebuffer */
> > > +static struct pci_dev *pdev_boot_vga;
> > > +
> > >   static const char *vga_iostate_to_str(unsigned int iostate)
> > >   {
> > >   	/* Ignore VGA_RSRC_IO and VGA_RSRC_MEM */
> > > @@ -582,6 +585,9 @@ static bool vga_is_firmware_default(struct pci_dev *pdev)
> > >   		return true;
> > >   	}
> > > +#else
> > > +	if (pdev_boot_vga && pdev_boot_vga == pdev)
> > > +		return true;
> > >   #endif
> > >   	return false;
> > >   }
> > > @@ -1557,3 +1563,73 @@ static int __init vga_arb_device_init(void)
> > >   	return rc;
> > >   }
> > >   subsys_initcall_sync(vga_arb_device_init);
> > > +
> > > +/*
> > > + * Get the physical address range that the firmware framebuffer occupies.
> > > + *
> > > + * Note that the global screen_info is arch-specific, thus CONFIG_SYSFB is
> > > + * chosen as compile-time conditional to suppress linkage problems on non-x86
> > > + * architectures.
> > > + *
> > > + * Returns true on success, otherwise return false.
> > > + */
> > > +static bool vga_arb_get_firmware_fb_range(u64 *start, u64 *end)
> > > +{
> > > +	u64 fb_start = 0;
> > > +	u64 fb_size = 0;
> > > +	u64 fb_end;
> > > +
> > > +#if defined(CONFIG_X86) || defined(CONFIG_IA64) || defined(CONFIG_SYSFB)
> > > +	fb_start = screen_info.lfb_base;
> > > +	if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
> > > +		fb_start |= (u64)screen_info.ext_lfb_base << 32;
> > > +
> > > +	fb_size = screen_info.lfb_size;
> > > +#endif
> > > +
> > > +	/* No firmware framebuffer support */
> > > +	if (!fb_start || !fb_size)
> > > +		return false;
> > > +
> > > +	fb_end = fb_start + fb_size - 1;
> > > +
> > > +	*start = fb_start;
> > > +	*end = fb_end;
> > > +
> > > +	return true;
> > > +}
> > > +
> > > +/*
> > > + * Identify the PCI VGA device that contains the firmware framebuffer
> > > + */
> > > +static void pci_boot_vga_capturer(struct pci_dev *pdev)
> > > +{
> > > +	u64 fb_start, fb_end;
> > > +	struct resource *res;
> > > +	unsigned int i;
> > > +
> > > +	if (pdev_boot_vga)
> > > +		return;
> > > +
> > > +	if (!vga_arb_get_firmware_fb_range(&fb_start, &fb_end))
> > > +		return;
> > > +
> > > +	pci_dev_for_each_resource(pdev, res, i) {
> > > +		if (resource_type(res) != IORESOURCE_MEM)
> > > +			continue;
> > > +
> > > +		if (!res->start || !res->end)
> > > +			continue;
> > > +
> > > +		if (res->start <= fb_start && fb_end <= res->end) {
> > > +			pdev_boot_vga = pdev;
> > > +
> > > +			vgaarb_info(&pdev->dev,
> > > +				    "BAR %u: %pR contains firmware FB [0x%llx-0x%llx]\n",
> > > +				    i, res, fb_start, fb_end);
> > > +			break;
> > > +		}
> > > +	}
> > > +}
> > > +DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA,
> > > +			       8, pci_boot_vga_capturer);
> > 
> > PCI/VGA: Match firmware framebuffer before BAR reassignment
> > 
> > vga_is_firmware_default() decides a device is the firmware default VGA
> > device if it has a BAR that contains the framebuffer described by
> > screen_info.
> > 
> > Previously this was unreliable because the screen_info framebuffer address
> > comes from firmware, and the Linux PCI core may reassign device BARs before
> > vga_is_firmware_default() runs.  This reassignment means the BAR may not
> > match the screen_info values, but we still want to select the device as the
> > firmware default.
> > 
> > Make vga_is_firmware_default() more reliable by running it as a quirk so it
> > happens before any BAR reassignment.
> > 
> > diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> > index 5e6b1eb54c64..4a53e76caddd 100644
> > --- a/drivers/pci/vgaarb.c
> > +++ b/drivers/pci/vgaarb.c
> > @@ -60,6 +60,8 @@ static bool vga_arbiter_used;
> >   static DEFINE_SPINLOCK(vga_lock);
> >   static DECLARE_WAIT_QUEUE_HEAD(vga_wait_queue);
> > +static struct pci_dev *vga_firmware_device;
> > +
> >   static const char *vga_iostate_to_str(unsigned int iostate)
> >   {
> >   	/* Ignore VGA_RSRC_IO and VGA_RSRC_MEM */
> > @@ -560,6 +562,7 @@ static bool vga_is_firmware_default(struct pci_dev *pdev)
> >   	u64 base = screen_info.lfb_base;
> >   	u64 size = screen_info.lfb_size;
> >   	struct resource *r;
> > +	unsigned int i;
> >   	u64 limit;
> >   	/* Select the device owning the boot framebuffer if there is one */
> > @@ -570,7 +573,7 @@ static bool vga_is_firmware_default(struct pci_dev *pdev)
> >   	limit = base + size;
> >   	/* Does firmware framebuffer belong to us? */
> > -	pci_dev_for_each_resource(pdev, r) {
> > +	pci_dev_for_each_resource(pdev, r, i) {
> >   		if (resource_type(r) != IORESOURCE_MEM)
> >   			continue;
> > @@ -580,6 +583,8 @@ static bool vga_is_firmware_default(struct pci_dev *pdev)
> >   		if (base < r->start || limit >= r->end)
> >   			continue;
> > +		vgaarb_info(&pdev->dev, "BAR %u: %pR contains firmware framebuffer [%#010llx-%#010llx]\n",
> > +			    i, r, base, limit - 1);
> >   		return true;
> >   	}
> >   #endif
> > @@ -623,7 +628,7 @@ static bool vga_is_boot_device(struct vga_device *vgadev)
> >   	if (boot_vga && boot_vga->is_firmware_default)
> >   		return false;
> > -	if (vga_is_firmware_default(pdev)) {
> > +	if (pdev == vga_firmware_device) {
> >   		vgadev->is_firmware_default = true;
> >   		return true;
> >   	}
> > @@ -1557,3 +1562,14 @@ static int __init vga_arb_device_init(void)
> >   	return rc;
> >   }
> >   subsys_initcall_sync(vga_arb_device_init);
> > +
> > +static void vga_match_firmware_framebuffer(struct pci_dev *pdev)
> > +{
> > +	if (vga_firmware_device)
> > +		return;
> > +
> > +	if (vga_is_firmware_default(pdev))
> > +		vga_firmware_device = pdev;
> > +}
> > +DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA,
> > +			       8, vga_match_firmware_framebuffer);
> 
> 
> Q: What if we did something like the patch below?
> 
> A:
> 
> But the vga_is_firmware_default() function only works on X86 and IA64,
> you patch doesn't solve the problems on ARM64 and LoongArch.

Yes, that's true.  Ideally a patch solves a single problem.  This one
solves an issue for x86 and ia64.  A subsequent patch can solve the
problems on ARM64 and LoongArch.  Doing them separately means that
each patch is easier to understand and if we accidentally break
something, a bisection can give more specific information about what
broke.

Bjorn
