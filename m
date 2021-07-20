Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5FE13D0469
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jul 2021 00:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbhGTVi6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jul 2021 17:38:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:53988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229667AbhGTVir (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Jul 2021 17:38:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 539616120A;
        Tue, 20 Jul 2021 22:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626819564;
        bh=t+CKoSrAOfvSe7mXkbhXmS4SNcbua5nIy9DHQJ0Dvy8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=V4BWg4f7vvc4a984VTUC0zXyVFCNS5nSuh0tykim2gu6KlmBKS/To4GGBBT2v8CWT
         RzJ85vRT/lTwGgMjK5WzIMA+IeppQ4ltuWLzH8jXUXpXgFToJZfpN46cm4wECEks3E
         Ty5RHR/C0rEmZuArkwzz44bJMTeKoeEfUjoRpl8XaOxdk8akS9oxXN64pTV+BRH5Rk
         o7S7w2eebUkgBA9epYOrnOwJ+/i8vP6bbSqI/MLdvKoncU+0M5ydcu6UPTkrxwASvl
         er5+JHVdVIqUkWyhxQnK18fN+ugaDEQ5ew2aSFFDciDgOFsr7r1ClKJKmZpRT5er24
         CLAkZVQ2gkutQ==
Date:   Tue, 20 Jul 2021 17:19:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] vgaarb: Rework default VGA device selection
Message-ID: <20210720221923.GA43331@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705100503.1120643-1-chenhuacai@loongson.cn>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 05, 2021 at 06:05:03PM +0800, Huacai Chen wrote:
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

I think maybe it *would* be a good idea to move this to drivers/pci,
and I think it would be nice to make the move the very first patch in
a series because I think there may be follow-ons, and it would be nice
to get more of the history in the new location after the break.

For example, if it's in drivers/pci, we can call the arbiter directly
from the enumeration/removal code instead of using a bus notifier.

I put this on a branch so you can see what it looks like:

  https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=review/vga

I tried to pull out as much stuff as I could into smaller patches so
this one is a little bit more understandable.

But we definitely need some work on the commit log.  The first three
paragraphs seem to describe the approach you *didn't* use.  We don't
need that.

But we *do* need an explanation of why we need this patch and how it
works.  Based on the patch, I assume the initcall ordering is
different on your system, which exposes a problem in
vga_arbiter_add_pci_device():

Looking at [1], I think that on your system, vga_arb_device_init()
runs before the VGA card is enumerated, so it doesn't set the card as
the default VGA device.

We do call vga_arbiter_add_pci_device() when we enumerate the device,
but it doesn't set the card as the default device either because the
bridge upstream from it doesn't support PCI_BRIDGE_CTL_VGA.

So the commit log needs to (1) explain why your initcall ordering is
unusual, and (2) explain the approach, which IIUC is basically to add
the vga_arb_select_default_device() functionality to
vga_arbiter_add_pci_device().

[1] https://lore.kernel.org/linux-pci/20210518193100.GA148462@bjorn-Precision-5520/

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
> +	struct acpi_device *adev = ACPI_COMPANION(dev);
> +
> +	return adev && !strcmp(acpi_device_hid(adev), ACPI_VIDEO_HID);
> +}
> +#else
> +static bool vga_arb_integrated_gpu(struct device *dev)
> +{
> +	return false;
> +}
> +#endif
> +
> +static void vga_arb_update_default_device(struct vga_device *vgadev)
> +{
> +	struct pci_dev *pdev = vgadev->pdev;
> +	struct device *dev = &pdev->dev;
> +	struct vga_device *vgadev_default;
> +#if defined(CONFIG_X86) || defined(CONFIG_IA64)
> +	int i;
> +	unsigned long flags;
> +	u64 base = screen_info.lfb_base;
> +	u64 size = screen_info.lfb_size;
> +	u64 limit;
> +	resource_size_t start, end;
> +#endif
> +
> +	/* Deal with VGA default device. Use first enabled one
> +	 * by default if arch doesn't have it's own hook
> +	 */
> +	if (!vga_default_device()) {
> +		if ((vgadev->owns & VGA_RSRC_LEGACY_MASK) == VGA_RSRC_LEGACY_MASK)
> +			vgaarb_info(dev, "setting as boot VGA device\n");
> +		else
> +			vgaarb_info(dev, "setting as boot device (VGA legacy resources not available)\n");
> +		vga_set_default_device(pdev);
> +	}
> +
> +	vgadev_default = vgadev_find(vga_default);
> +
> +	/* Overridden by a better device */
> +	if (vgadev_default && ((vgadev_default->owns & VGA_RSRC_LEGACY_MASK) == 0)
> +		&& ((vgadev->owns & VGA_RSRC_LEGACY_MASK) == VGA_RSRC_LEGACY_MASK)) {
> +		vgaarb_info(dev, "overriding boot VGA device\n");
> +		vga_set_default_device(pdev);
> +	}
> +
> +	if (vga_arb_integrated_gpu(dev)) {
> +		vgaarb_info(dev, "overriding boot VGA device\n");
> +		vga_set_default_device(pdev);
> +	}
> +
> +#if defined(CONFIG_X86) || defined(CONFIG_IA64)
> +	if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
> +		base |= (u64)screen_info.ext_lfb_base << 32;
> +
> +	limit = base + size;
> +
> +	/*
> +	 * Override vga_arbiter_add_pci_device()'s I/O based detection
> +	 * as it may take the wrong device (e.g. on Apple system under
> +	 * EFI).
> +	 *
> +	 * Select the device owning the boot framebuffer if there is
> +	 * one.
> +	 */
> +
> +	/* Does firmware framebuffer belong to us? */
> +	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
> +		flags = pci_resource_flags(vgadev->pdev, i);
> +
> +		if ((flags & IORESOURCE_MEM) == 0)
> +			continue;
> +
> +		start = pci_resource_start(vgadev->pdev, i);
> +		end  = pci_resource_end(vgadev->pdev, i);
> +
> +		if (!start || !end)
> +			continue;
> +
> +		if (base < start || limit >= end)
> +			continue;
> +
> +		if (vgadev->pdev != vga_default_device())
> +			vgaarb_info(dev, "overriding boot device\n");
> +		vga_set_default_device(vgadev->pdev);
> +	}
> +#endif
> +}
> +
>  /*
>   * Rules for using a bridge to control a VGA descendant decoding: if a bridge
>   * has only one VGA descendant then it can be used to control the VGA routing
> @@ -643,6 +734,11 @@ static void vga_arbiter_check_bridge_sharing(struct vga_device *vgadev)
>  		}
>  		new_bus = new_bus->parent;
>  	}
> +
> +	if (vgadev->bridge_has_one_vga == true)
> +		vgaarb_info(&vgadev->pdev->dev, "bridge control possible\n");
> +	else
> +		vgaarb_info(&vgadev->pdev->dev, "no bridge control possible\n");
>  }
>  
>  /*
> @@ -713,15 +809,7 @@ static bool vga_arbiter_add_pci_device(struct pci_dev *pdev)
>  		bus = bus->parent;
>  	}
>  
> -	/* Deal with VGA default device. Use first enabled one
> -	 * by default if arch doesn't have it's own hook
> -	 */
> -	if (vga_default == NULL &&
> -	    ((vgadev->owns & VGA_RSRC_LEGACY_MASK) == VGA_RSRC_LEGACY_MASK)) {
> -		vgaarb_info(&pdev->dev, "setting as boot VGA device\n");
> -		vga_set_default_device(pdev);
> -	}
> -
> +	vga_arb_update_default_device(vgadev);
>  	vga_arbiter_check_bridge_sharing(vgadev);
>  
>  	/* Add to the list */
> @@ -1451,111 +1539,10 @@ static struct miscdevice vga_arb_device = {
>  	MISC_DYNAMIC_MINOR, "vga_arbiter", &vga_arb_device_fops
>  };
>  
> -#if defined(CONFIG_ACPI)
> -static bool vga_arb_integrated_gpu(struct device *dev)
> -{
> -	struct acpi_device *adev = ACPI_COMPANION(dev);
> -
> -	return adev && !strcmp(acpi_device_hid(adev), ACPI_VIDEO_HID);
> -}
> -#else
> -static bool vga_arb_integrated_gpu(struct device *dev)
> -{
> -	return false;
> -}
> -#endif
> -
> -static void __init vga_arb_select_default_device(void)
> -{
> -	struct pci_dev *pdev, *found = NULL;
> -	struct vga_device *vgadev;
> -
> -#if defined(CONFIG_X86) || defined(CONFIG_IA64)
> -	u64 base = screen_info.lfb_base;
> -	u64 size = screen_info.lfb_size;
> -	u64 limit;
> -	resource_size_t start, end;
> -	unsigned long flags;
> -	int i;
> -
> -	if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
> -		base |= (u64)screen_info.ext_lfb_base << 32;
> -
> -	limit = base + size;
> -
> -	list_for_each_entry(vgadev, &vga_list, list) {
> -		struct device *dev = &vgadev->pdev->dev;
> -		/*
> -		 * Override vga_arbiter_add_pci_device()'s I/O based detection
> -		 * as it may take the wrong device (e.g. on Apple system under
> -		 * EFI).
> -		 *
> -		 * Select the device owning the boot framebuffer if there is
> -		 * one.
> -		 */
> -
> -		/* Does firmware framebuffer belong to us? */
> -		for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
> -			flags = pci_resource_flags(vgadev->pdev, i);
> -
> -			if ((flags & IORESOURCE_MEM) == 0)
> -				continue;
> -
> -			start = pci_resource_start(vgadev->pdev, i);
> -			end  = pci_resource_end(vgadev->pdev, i);
> -
> -			if (!start || !end)
> -				continue;
> -
> -			if (base < start || limit >= end)
> -				continue;
> -
> -			if (!vga_default_device())
> -				vgaarb_info(dev, "setting as boot device\n");
> -			else if (vgadev->pdev != vga_default_device())
> -				vgaarb_info(dev, "overriding boot device\n");
> -			vga_set_default_device(vgadev->pdev);
> -		}
> -	}
> -#endif
> -
> -	if (!vga_default_device()) {
> -		list_for_each_entry_reverse(vgadev, &vga_list, list) {
> -			struct device *dev = &vgadev->pdev->dev;
> -			u16 cmd;
> -
> -			pdev = vgadev->pdev;
> -			pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> -			if (cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
> -				found = pdev;
> -				if (vga_arb_integrated_gpu(dev))
> -					break;
> -			}
> -		}
> -	}
> -
> -	if (found) {
> -		vgaarb_info(&found->dev, "setting as boot device (VGA legacy resources not available)\n");
> -		vga_set_default_device(found);
> -		return;
> -	}
> -
> -	if (!vga_default_device()) {
> -		vgadev = list_first_entry_or_null(&vga_list,
> -						  struct vga_device, list);
> -		if (vgadev) {
> -			struct device *dev = &vgadev->pdev->dev;
> -			vgaarb_info(dev, "setting as boot device (VGA legacy resources not available)\n");
> -			vga_set_default_device(vgadev->pdev);
> -		}
> -	}
> -}
> -
>  static int __init vga_arb_device_init(void)
>  {
>  	int rc;
>  	struct pci_dev *pdev;
> -	struct vga_device *vgadev;
>  
>  	rc = misc_register(&vga_arb_device);
>  	if (rc < 0)
> @@ -1571,18 +1558,6 @@ static int __init vga_arb_device_init(void)
>  			       PCI_ANY_ID, pdev)) != NULL)
>  		vga_arbiter_add_pci_device(pdev);
>  
> -	list_for_each_entry(vgadev, &vga_list, list) {
> -		struct device *dev = &vgadev->pdev->dev;
> -
> -		if (vgadev->bridge_has_one_vga)
> -			vgaarb_info(dev, "bridge control possible\n");
> -		else
> -			vgaarb_info(dev, "no bridge control possible\n");
> -	}
> -
> -	vga_arb_select_default_device();
> -
> -	pr_info("loaded\n");
>  	return rc;
>  }
>  subsys_initcall(vga_arb_device_init);
> -- 
> 2.27.0
> 
