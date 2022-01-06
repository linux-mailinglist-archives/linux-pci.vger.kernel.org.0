Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E0748678B
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jan 2022 17:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241150AbiAFQVE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jan 2022 11:21:04 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37972 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241154AbiAFQVD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jan 2022 11:21:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 523EAB82293;
        Thu,  6 Jan 2022 16:21:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC0DC36AEB;
        Thu,  6 Jan 2022 16:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641486059;
        bh=+eu0kFS5XuECOf38/1qOb3kYT6FMacBFZqWduz0+JaA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QQxVbOuDAyqEEdJWiTrDtvzwG7bjz4d5kmj08f9Rd/17nSlrIgtMEO/xCK2KHFS5U
         wd4RlZ9rXyZQX3UwecojYbZGSF62eIlOWNoEfcInxlYwbGeP0e+Fcpy9RUxZQl5o/y
         zu66aTxlMYgtTw1w6O4xGA8LMSHtuOtH2IM3IvkwSrJNiL5faP5NoUm6yRyGA53d1a
         UTvsA/AomGGHkcctJ49LmPd9vEc9TWH05OpnfHNT8lQ2Ct8o2+bp+AUp2uTJ+xSskS
         2U2SwNCaG/hW5PwvlDRvE6EmtTBZyyzObR0KzL9bogebqWYtlppfVdAECplJimvHyU
         n12jBhUb3VcPw==
Date:   Thu, 6 Jan 2022 10:20:58 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>
Subject: Re: [PATCH v8 04/10] vgaarb: Move framebuffer detection to
 ADD_DEVICE path
Message-ID: <20220106162058.GA284940@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H4BTAKdRwv+Wq7QRfMQRajQYzz3CqjvoGTrKujn47F3Yg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 06, 2022 at 02:44:42PM +0800, Huacai Chen wrote:
> On Thu, Jan 6, 2022 at 8:07 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > Previously we selected a device that owns the boot framebuffer as the
> > default device in vga_arb_select_default_device().  This was only done in
> > the vga_arb_device_init() subsys_initcall, so devices enumerated later,
> > e.g., by pcibios_init(), were not eligible.
> >
> > Fix this by moving the framebuffer device selection from
> > vga_arb_select_default_device() to vga_arbiter_add_pci_device(), which is
> > called after every PCI device is enumerated, either by the
> > vga_arb_device_init() subsys_initcall or as an ADD_DEVICE notifier.
> >
> > Note that if vga_arb_select_default_device() found a device owning the boot
> > framebuffer, it unconditionally set it to be the default VGA device, and no
> > subsequent device could replace it.
> >
> > Link: https://lore.kernel.org/r/20211015061512.2941859-7-chenhuacai@loongson.cn
> > Based-on-patch-by: Huacai Chen <chenhuacai@loongson.cn>
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Bruno Pr�mont <bonbons@linux-vserver.org>
> > ---
> >  drivers/gpu/vga/vgaarb.c | 37 +++++++++++++++++--------------------
> >  1 file changed, 17 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
> > index b0ae0f177c6f..aefa4f406f7d 100644
> > --- a/drivers/gpu/vga/vgaarb.c
> > +++ b/drivers/gpu/vga/vgaarb.c
> > @@ -72,6 +72,7 @@ struct vga_device {
> >         unsigned int io_norm_cnt;       /* normal IO count */
> >         unsigned int mem_norm_cnt;      /* normal MEM count */
> >         bool bridge_has_one_vga;
> > +       bool is_framebuffer;    /* BAR covers firmware framebuffer */
> >         unsigned int (*set_decode)(struct pci_dev *pdev, bool decode);
> >  };
> >
> > @@ -565,10 +566,9 @@ void vga_put(struct pci_dev *pdev, unsigned int rsrc)
> >  }
> >  EXPORT_SYMBOL(vga_put);
> >
> > -static void __init vga_select_framebuffer_device(struct pci_dev *pdev)
> > +static bool vga_is_framebuffer_device(struct pci_dev *pdev)
> >  {
> >  #if defined(CONFIG_X86) || defined(CONFIG_IA64)
> > -       struct device *dev = &pdev->dev;
> >         u64 base = screen_info.lfb_base;
> >         u64 size = screen_info.lfb_size;
> >         u64 limit;
> > @@ -583,15 +583,6 @@ static void __init vga_select_framebuffer_device(struct pci_dev *pdev)
> >
> >         limit = base + size;
> >
> > -       /*
> > -        * Override vga_arbiter_add_pci_device()'s I/O based detection
> > -        * as it may take the wrong device (e.g. on Apple system under
> > -        * EFI).
> > -        *
> > -        * Select the device owning the boot framebuffer if there is
> > -        * one.
> > -        */
> > -
> >         /* Does firmware framebuffer belong to us? */
> >         for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
> >                 flags = pci_resource_flags(pdev, i);
> > @@ -608,13 +599,10 @@ static void __init vga_select_framebuffer_device(struct pci_dev *pdev)
> >                 if (base < start || limit >= end)
> >                         continue;
> >
> > -               if (!vga_default_device())
> > -                       vgaarb_info(dev, "setting as boot device\n");
> > -               else if (pdev != vga_default_device())
> > -                       vgaarb_info(dev, "overriding boot device\n");
> > -               vga_set_default_device(pdev);
> > +               return true;
> >         }
> >  #endif
> > +       return false;
> >  }
> >
> >  static bool vga_arb_integrated_gpu(struct device *dev)
> > @@ -635,6 +623,7 @@ static bool vga_arb_integrated_gpu(struct device *dev)
> >  static bool vga_is_boot_device(struct vga_device *vgadev)
> >  {
> >         struct vga_device *boot_vga = vgadev_find(vga_default_device());
> > +       struct pci_dev *pdev = vgadev->pdev;
> >
> >         /*
> >          * We select the default VGA device in this order:
> > @@ -645,6 +634,18 @@ static bool vga_is_boot_device(struct vga_device *vgadev)
> >          *   Other device (see vga_arb_select_default_device())
> >          */
> >
> > +       /*
> > +        * We always prefer a firmware framebuffer, so if we've already
> > +        * found one, there's no need to consider vgadev.
> > +        */
> > +       if (boot_vga && boot_vga->is_framebuffer)
> > +               return false;
> > +
> > +       if (vga_is_framebuffer_device(pdev)) {
> > +               vgadev->is_framebuffer = true;
> > +               return true;
> > +       }
> Maybe it is better to rename vga_is_framebuffer_device() to
> vga_is_firmware_device() and rename is_framebuffer to
> is_fw_framebuffer?

That's a great point, thanks!

The "framebuffer" term is way too generic.  *All* VGA devices have a
framebuffer, so it adds no information.  This is really about finding
the device that was used by firmware.

I renamed:

  vga_is_framebuffer_device() -> vga_is_firmware_default()
  vga_device.is_framebuffer   -> vga_device.is_firmware_default

I updated my local branch and pushed it to:
https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=pci/vga
with head 0f4caffa1297 ("vgaarb: Replace full MIT license text with
SPDX identifier").

I don't maintain drivers/gpu/vga/vgaarb.c, so this branch is just for
reference.  It'll ultimately be up to the DRM folks to handle this.

I'll wait for any other comments or testing reports before reposting.

> >         /*
> >          * A legacy VGA device has MEM and IO enabled and any bridges
> >          * leading to it have PCI_BRIDGE_CTL_VGA enabled so the legacy
> > @@ -1531,10 +1532,6 @@ static void __init vga_arb_select_default_device(void)
> >         struct pci_dev *pdev, *found = NULL;
> >         struct vga_device *vgadev;
> >
> > -       list_for_each_entry(vgadev, &vga_list, list) {
> > -               vga_select_framebuffer_device(vgadev->pdev);
> > -       }
> > -
> >         if (!vga_default_device()) {
> >                 list_for_each_entry_reverse(vgadev, &vga_list, list) {
> >                         struct device *dev = &vgadev->pdev->dev;
> > --
> > 2.25.1
> >
