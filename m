Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8903BEF98
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jul 2021 20:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbhGGSoq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Jul 2021 14:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbhGGSom (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jul 2021 14:44:42 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E2DC05BD37
        for <linux-pci@vger.kernel.org>; Wed,  7 Jul 2021 11:41:02 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id b13so4718932ybk.4
        for <linux-pci@vger.kernel.org>; Wed, 07 Jul 2021 11:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pjq68K1XDdrMRid36+NXEzKN+E5rJMC4yv5Dlhgjxiw=;
        b=RcmtI1++2nqYg0bUCJrCatETK+YcdFP4OB5hnlkp8kuV8ZaJNNaaiQxansQBo4QksK
         EM47S1ZSG0bdU77m3iUa7+uh9U5Oeo7U1r19zsrLc0DG1dy7D3rs0nfUXibTCLdlBcZm
         fW36vWGcp3WTpsyx7HJZqdPDllVZqaWJb0MVn8u/4gWNdScNnBwIr+lLTSrYGeNh3r9R
         ixgw5QsO1/xrxxO4gmemfkSF4otSeQox1F6fVyGgv1Gv/+gImkJh4Ugw+YrbIcQJe9oI
         Zt3CYIyXwsSk4VpqHn1VP/OFZXrbiTQ1u4RhAKiQek0txswpCcGzIHH9+SOi7i41b6ik
         cIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pjq68K1XDdrMRid36+NXEzKN+E5rJMC4yv5Dlhgjxiw=;
        b=RTj5GZ0SUzaRC0c3roFXmO1NkpyM5efL6h/jXod1MFVIbp7Vev27Q2+Rn/6fuQwg0Y
         lFsqilmPhwx/8a5Wr0p7mCX5ECo33V1rf/F5ibjDTrFX5AEIzkQDGEKl6FIFVHQwMvZ1
         IKruPV5gA83Bwv+RWvVIjhb8h23gYUEPqXdgBPKOG3ffzOV97n1fFdf9FzbNpfxd3evl
         /hGIAJW6sFp7WOGKmQqvbe5BM5vMkn+vANWuen1/wlGxOXkPkkQRstDRPZ9qc6xLDlH4
         qqrot7UePZbwgY44mXx/W+FBLtQPPwwMUoSBjA8Gfx1k8YZFgjQxIMWeTeoVAKhOwSRE
         1dWg==
X-Gm-Message-State: AOAM533sN51JCJEjD+MubQl3zYr81J8jb5my2itXu6BPcPkzvVCljBfk
        QmXCC5+oCsBGDm3qqp1Fx2O4UD+xZ1IFsus1EEjJ
X-Google-Smtp-Source: ABdhPJwq8HHtoEru1Mx5a0LV42Db65KP0nZWG/OlCoQb0tatAacm7OGpcEcfFvABezco+pTO5OZhvE+LM8mMVcy3wbc=
X-Received: by 2002:a25:3791:: with SMTP id e139mr33088463yba.16.1625683261175;
 Wed, 07 Jul 2021 11:41:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210705100503.1120643-1-chenhuacai@loongson.cn>
In-Reply-To: <20210705100503.1120643-1-chenhuacai@loongson.cn>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed, 7 Jul 2021 13:40:49 -0500
Message-ID: <CAErSpo7z+OsHxWEs7vWRgNCwhgG+o_4kfr8s3WP6PR6wm-ZW7A@mail.gmail.com>
Subject: Re: [PATCH] vgaarb: Rework default VGA device selection
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc linux-pci]

On Mon, Jul 5, 2021 at 5:04 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> Currently, vga_arb_device_init() selects the first probed VGA device
> with VGA legacy resources enabled as the default device. However, some
> BMC-based VGA cards (e.g., AST2500 and HiSilicon D05) don't enable VGA
> legacy resources because their built-in upstream bridges don't support
> PCI_BRIDGE_CTL_VGA. This makes "no default VGA card" and breaks X.org
> auto-detection.
>
> Commit a37c0f48950b56f6ef2e ("vgaarb: Select a default VGA device even
> if there's no legacy VGA") try to solve this problem but fails on some
> platforms, because it relies on the initcall order:
>
> We should call vga_arb_device_init() after PCI enumeration, otherwise it
> may fail to select the default VGA device. Since vga_arb_device_init()
> and PCI enumeration function (i.e., pcibios_init() or acpi_init()) are
> both wrapped by subsys_initcall(), their sequence is not assured. So, it
> is possible to use subsys_initcall_sync() instead of subsys_initcall()
> to wrap vga_arb_device_init().
>
> However, the above approach still has drawbacks, it cannot handle the
> cases that a VGA card is hot-plugged, or the gpu driver is compiled as a
> module.
>
> So, as suggested by Bjorn Helgaas, this patch rework the selection:
> 1, Remove direct vga_arb_select_default_device() calls in vga_arb_
>    device_init().
> 2, Rename vga_arb_select_default_device() to vga_arb_update_default_
>    device(), which selects the first probed VGA device as the default
>    (whether legacy resources enabled or not), and update the default
>    device if a better one is found (device with legacy resources enabled
>    is better, device owns the firmware framebuffer is even better).
> 3, Every time a new VGA device is probed, vga_arbiter_add_pci_device()
>    is called, and vga_arb_update_default_device() is also called. So the
>    hotplug case and the module case can also be handled.
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/gpu/vga/vgaarb.c | 219 +++++++++++++++++----------------------
>  1 file changed, 97 insertions(+), 122 deletions(-)
>
> diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
> index 949fde433ea2..07770aae3aaf 100644
> --- a/drivers/gpu/vga/vgaarb.c
> +++ b/drivers/gpu/vga/vgaarb.c
> @@ -586,6 +586,97 @@ void vga_put(struct pci_dev *pdev, unsigned int rsrc)
>  }
>  EXPORT_SYMBOL(vga_put);
>
> +#if defined(CONFIG_ACPI)
> +static bool vga_arb_integrated_gpu(struct device *dev)
> +{
> +       struct acpi_device *adev = ACPI_COMPANION(dev);
> +
> +       return adev && !strcmp(acpi_device_hid(adev), ACPI_VIDEO_HID);
> +}
> +#else
> +static bool vga_arb_integrated_gpu(struct device *dev)
> +{
> +       return false;
> +}
> +#endif
> +
> +static void vga_arb_update_default_device(struct vga_device *vgadev)
> +{
> +       struct pci_dev *pdev = vgadev->pdev;
> +       struct device *dev = &pdev->dev;
> +       struct vga_device *vgadev_default;
> +#if defined(CONFIG_X86) || defined(CONFIG_IA64)
> +       int i;
> +       unsigned long flags;
> +       u64 base = screen_info.lfb_base;
> +       u64 size = screen_info.lfb_size;
> +       u64 limit;
> +       resource_size_t start, end;
> +#endif
> +
> +       /* Deal with VGA default device. Use first enabled one
> +        * by default if arch doesn't have it's own hook
> +        */
> +       if (!vga_default_device()) {
> +               if ((vgadev->owns & VGA_RSRC_LEGACY_MASK) == VGA_RSRC_LEGACY_MASK)
> +                       vgaarb_info(dev, "setting as boot VGA device\n");
> +               else
> +                       vgaarb_info(dev, "setting as boot device (VGA legacy resources not available)\n");
> +               vga_set_default_device(pdev);
> +       }
> +
> +       vgadev_default = vgadev_find(vga_default);
> +
> +       /* Overridden by a better device */
> +       if (vgadev_default && ((vgadev_default->owns & VGA_RSRC_LEGACY_MASK) == 0)
> +               && ((vgadev->owns & VGA_RSRC_LEGACY_MASK) == VGA_RSRC_LEGACY_MASK)) {
> +               vgaarb_info(dev, "overriding boot VGA device\n");
> +               vga_set_default_device(pdev);
> +       }
> +
> +       if (vga_arb_integrated_gpu(dev)) {
> +               vgaarb_info(dev, "overriding boot VGA device\n");
> +               vga_set_default_device(pdev);
> +       }
> +
> +#if defined(CONFIG_X86) || defined(CONFIG_IA64)
> +       if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
> +               base |= (u64)screen_info.ext_lfb_base << 32;
> +
> +       limit = base + size;
> +
> +       /*
> +        * Override vga_arbiter_add_pci_device()'s I/O based detection
> +        * as it may take the wrong device (e.g. on Apple system under
> +        * EFI).
> +        *
> +        * Select the device owning the boot framebuffer if there is
> +        * one.
> +        */
> +
> +       /* Does firmware framebuffer belong to us? */
> +       for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
> +               flags = pci_resource_flags(vgadev->pdev, i);
> +
> +               if ((flags & IORESOURCE_MEM) == 0)
> +                       continue;
> +
> +               start = pci_resource_start(vgadev->pdev, i);
> +               end  = pci_resource_end(vgadev->pdev, i);
> +
> +               if (!start || !end)
> +                       continue;
> +
> +               if (base < start || limit >= end)
> +                       continue;
> +
> +               if (vgadev->pdev != vga_default_device())
> +                       vgaarb_info(dev, "overriding boot device\n");
> +               vga_set_default_device(vgadev->pdev);
> +       }
> +#endif
> +}
> +
>  /*
>   * Rules for using a bridge to control a VGA descendant decoding: if a bridge
>   * has only one VGA descendant then it can be used to control the VGA routing
> @@ -643,6 +734,11 @@ static void vga_arbiter_check_bridge_sharing(struct vga_device *vgadev)
>                 }
>                 new_bus = new_bus->parent;
>         }
> +
> +       if (vgadev->bridge_has_one_vga == true)
> +               vgaarb_info(&vgadev->pdev->dev, "bridge control possible\n");
> +       else
> +               vgaarb_info(&vgadev->pdev->dev, "no bridge control possible\n");
>  }
>
>  /*
> @@ -713,15 +809,7 @@ static bool vga_arbiter_add_pci_device(struct pci_dev *pdev)
>                 bus = bus->parent;
>         }
>
> -       /* Deal with VGA default device. Use first enabled one
> -        * by default if arch doesn't have it's own hook
> -        */
> -       if (vga_default == NULL &&
> -           ((vgadev->owns & VGA_RSRC_LEGACY_MASK) == VGA_RSRC_LEGACY_MASK)) {
> -               vgaarb_info(&pdev->dev, "setting as boot VGA device\n");
> -               vga_set_default_device(pdev);
> -       }
> -
> +       vga_arb_update_default_device(vgadev);
>         vga_arbiter_check_bridge_sharing(vgadev);
>
>         /* Add to the list */
> @@ -1451,111 +1539,10 @@ static struct miscdevice vga_arb_device = {
>         MISC_DYNAMIC_MINOR, "vga_arbiter", &vga_arb_device_fops
>  };
>
> -#if defined(CONFIG_ACPI)
> -static bool vga_arb_integrated_gpu(struct device *dev)
> -{
> -       struct acpi_device *adev = ACPI_COMPANION(dev);
> -
> -       return adev && !strcmp(acpi_device_hid(adev), ACPI_VIDEO_HID);
> -}
> -#else
> -static bool vga_arb_integrated_gpu(struct device *dev)
> -{
> -       return false;
> -}
> -#endif
> -
> -static void __init vga_arb_select_default_device(void)
> -{
> -       struct pci_dev *pdev, *found = NULL;
> -       struct vga_device *vgadev;
> -
> -#if defined(CONFIG_X86) || defined(CONFIG_IA64)
> -       u64 base = screen_info.lfb_base;
> -       u64 size = screen_info.lfb_size;
> -       u64 limit;
> -       resource_size_t start, end;
> -       unsigned long flags;
> -       int i;
> -
> -       if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
> -               base |= (u64)screen_info.ext_lfb_base << 32;
> -
> -       limit = base + size;
> -
> -       list_for_each_entry(vgadev, &vga_list, list) {
> -               struct device *dev = &vgadev->pdev->dev;
> -               /*
> -                * Override vga_arbiter_add_pci_device()'s I/O based detection
> -                * as it may take the wrong device (e.g. on Apple system under
> -                * EFI).
> -                *
> -                * Select the device owning the boot framebuffer if there is
> -                * one.
> -                */
> -
> -               /* Does firmware framebuffer belong to us? */
> -               for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
> -                       flags = pci_resource_flags(vgadev->pdev, i);
> -
> -                       if ((flags & IORESOURCE_MEM) == 0)
> -                               continue;
> -
> -                       start = pci_resource_start(vgadev->pdev, i);
> -                       end  = pci_resource_end(vgadev->pdev, i);
> -
> -                       if (!start || !end)
> -                               continue;
> -
> -                       if (base < start || limit >= end)
> -                               continue;
> -
> -                       if (!vga_default_device())
> -                               vgaarb_info(dev, "setting as boot device\n");
> -                       else if (vgadev->pdev != vga_default_device())
> -                               vgaarb_info(dev, "overriding boot device\n");
> -                       vga_set_default_device(vgadev->pdev);
> -               }
> -       }
> -#endif
> -
> -       if (!vga_default_device()) {
> -               list_for_each_entry_reverse(vgadev, &vga_list, list) {
> -                       struct device *dev = &vgadev->pdev->dev;
> -                       u16 cmd;
> -
> -                       pdev = vgadev->pdev;
> -                       pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> -                       if (cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
> -                               found = pdev;
> -                               if (vga_arb_integrated_gpu(dev))
> -                                       break;
> -                       }
> -               }
> -       }
> -
> -       if (found) {
> -               vgaarb_info(&found->dev, "setting as boot device (VGA legacy resources not available)\n");
> -               vga_set_default_device(found);
> -               return;
> -       }
> -
> -       if (!vga_default_device()) {
> -               vgadev = list_first_entry_or_null(&vga_list,
> -                                                 struct vga_device, list);
> -               if (vgadev) {
> -                       struct device *dev = &vgadev->pdev->dev;
> -                       vgaarb_info(dev, "setting as boot device (VGA legacy resources not available)\n");
> -                       vga_set_default_device(vgadev->pdev);
> -               }
> -       }
> -}
> -
>  static int __init vga_arb_device_init(void)
>  {
>         int rc;
>         struct pci_dev *pdev;
> -       struct vga_device *vgadev;
>
>         rc = misc_register(&vga_arb_device);
>         if (rc < 0)
> @@ -1571,18 +1558,6 @@ static int __init vga_arb_device_init(void)
>                                PCI_ANY_ID, pdev)) != NULL)
>                 vga_arbiter_add_pci_device(pdev);
>
> -       list_for_each_entry(vgadev, &vga_list, list) {
> -               struct device *dev = &vgadev->pdev->dev;
> -
> -               if (vgadev->bridge_has_one_vga)
> -                       vgaarb_info(dev, "bridge control possible\n");
> -               else
> -                       vgaarb_info(dev, "no bridge control possible\n");
> -       }
> -
> -       vga_arb_select_default_device();
> -
> -       pr_info("loaded\n");
>         return rc;
>  }
>  subsys_initcall(vga_arb_device_init);
> --
> 2.27.0
>
