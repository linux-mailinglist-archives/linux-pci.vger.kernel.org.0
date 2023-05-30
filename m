Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2062A716E86
	for <lists+linux-pci@lfdr.de>; Tue, 30 May 2023 22:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjE3URb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 May 2023 16:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjE3URa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 May 2023 16:17:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26BAF7;
        Tue, 30 May 2023 13:17:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F6F261463;
        Tue, 30 May 2023 20:17:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59222C433EF;
        Tue, 30 May 2023 20:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685477848;
        bh=42kHNuWnr2NU1MRlrzNdvQutpo6umm6bTAEU71ctpEw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Wxtjib3qGYadfyYFl+JHdGXCHJkF21/tawbmw6oi1A2W5U3NB0mqdS5rA2lGdt2oF
         x2J4yZcHyNHKtZ5uH1LVjgE/NzV0FSJFRlp8cKd7sSL7nZXmeueTs+i0WhD/NQ0PXm
         aGl/LgmSfjgloljW60Db0858f24nVLIOa9kUhOPAQ20EyfdSq8rTpXpL2YCCY/LXsu
         zMZNQ9TkoJB2a/uXnEg/6XYoByXgVXAVSzfE94OsjR5KEReuicyKuUsIhKYRPoARPD
         Fvpn3AWLCw4Oy7Bruykxv18mXDwH7eoseXWMzg3ep3EiGWT0PdpxrdDWQrPczv5Ywq
         ZixVq0mWOHorQ==
Date:   Tue, 30 May 2023 15:17:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        loongson-kernel@lists.loongnix.cn, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Li Yi <liyi@loongson.cn>
Subject: Re: [PATCH] pci/vgaarb: make vga_is_firmware_default() arch
 independent
Message-ID: <ZHZZ1qETtCOlmkXU@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529154504.2117953-1-suijingfeng@loongson.cn>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 29, 2023 at 11:45:04PM +0800, Sui Jingfeng wrote:
> The vga_is_firmware_default() function will work on non-x86 architectures
> as long as the arch has UEFI GOP support, which passes the firmware
> framebuffer base address and size.
> 
> This patch makes the vga_is_firmware_default() function arch-independent.
> This could help the VGAARB subsystem make the right choice for multiple
> GPU systems. Usually an integrated one and a discrete one for desktop
> computers. Depending on the firmware framebuffer being put into which
> GPU's VRAM, VGAARB could inherit the firmware's choice, which in turn,
> is the exact choice of the user.

Is there a system that needs this change?  If so, the commit log
should mention it.

It's definitely nice to remove #ifdefs, but it's better if we have an
actual reason and some testing of another arch that makes use of this.

Also, take a look at the git history and match the subject line and
commit log style (prefix, capitalization, imperative voice).

> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
>  drivers/pci/vgaarb.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> index 5a696078b382..f81b6c54e327 100644
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
> @@ -61,7 +61,6 @@ static bool vga_arbiter_used;
>  static DEFINE_SPINLOCK(vga_lock);
>  static DECLARE_WAIT_QUEUE_HEAD(vga_wait_queue);
>  
> -
>  static const char *vga_iostate_to_str(unsigned int iostate)
>  {
>  	/* Ignore VGA_RSRC_IO and VGA_RSRC_MEM */
> @@ -545,7 +544,6 @@ EXPORT_SYMBOL(vga_put);
>  
>  static bool vga_is_firmware_default(struct pci_dev *pdev)
>  {
> -#if defined(CONFIG_X86) || defined(CONFIG_IA64)
>  	u64 base = screen_info.lfb_base;
>  	u64 size = screen_info.lfb_size;
>  	struct resource *r;
> @@ -571,7 +569,7 @@ static bool vga_is_firmware_default(struct pci_dev *pdev)
>  
>  		return true;
>  	}
> -#endif
> +
>  	return false;
>  }
>  
> @@ -865,8 +863,7 @@ static bool vga_arbiter_del_pci_device(struct pci_dev *pdev)
>  }
>  
>  /* this is called with the lock */
> -static inline void vga_update_device_decodes(struct vga_device *vgadev,
> -					     int new_decodes)
> +static void vga_update_device_decodes(struct vga_device *vgadev, int new_decodes)

I don't mind removing the "inline" here, but it shouldn't be combined
with the rest of the patch.  When it's combined, I can't tell whether
there's a reason we need this change or if it's just a cleanup.

>  {
>  	struct device *dev = &vgadev->pdev->dev;
>  	int old_decodes, decodes_removed, decodes_unlocked;
> -- 
> 2.25.1
> 
