Return-Path: <linux-pci+bounces-29767-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9373BAD94FD
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 21:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6B4A166421
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 19:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2734F23E356;
	Fri, 13 Jun 2025 19:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmtYNoOM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0291123958A
	for <linux-pci@vger.kernel.org>; Fri, 13 Jun 2025 19:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749841642; cv=none; b=dH1mao72RsWPzgRj9hXyQbM0+MSZGOTpifX2+rQ+yYBbfTqerqgxFCjvEiAcUfqu4jrK7CihCacjoRbKXyXO+nsjhmiT/HZNFsRARW/Rmgi2H5qeJ4+t4r/DTm2n3Hwr9fQl8Hnqg8S9aJthmMLuhKFCClPeXRUnI5AjyHEP6xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749841642; c=relaxed/simple;
	bh=4x5xpmju8VkMUTfXFsWxyL3lX9/7bH+IIKQtmSn+WPY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lzCi/DZL0btCwn3FD7E08od2Ww5gEegrUanD98bVyerzvNu/jMWNRMrzHbIyLbBp5xDuM4pIrSgEfDBm9Qo8MWlZfuC68cUTUXplHetfgmnTDUREAKnCiGL2yQNXLNUMtY7/j5diYAR4UgBz/c9vq+nvjiE+7SO7BSdVViz7Hy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmtYNoOM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53029C4CEE3;
	Fri, 13 Jun 2025 19:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749841640;
	bh=4x5xpmju8VkMUTfXFsWxyL3lX9/7bH+IIKQtmSn+WPY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YmtYNoOMBEr1lAosavHb1wc6FjkBrmnDrKMETNj0cc7quD4L1D0RJI2duVuPVbmSm
	 2QsCKPRLMSSBLUwrSBwZ7N3gV8n1+J2D9UObSsuo5hkTIVapLKbbknncJ2M7bn177z
	 g1On7q1iOOpUBjWjJzlcYBu057ORSJWlHSb3zpBoyFjfCzyzkeSVUg2klcJs8ooyrZ
	 smQIytP93+DojssTUlNuB3IOrFGV6Yk/Ht8G6ZOWDpr+4oF78tqafz23ldCnkdDYsl
	 ZNKRJFREBS2IvBzWqfdh5WzJvxwaB97HfLbC/7bhmSZISb+DwpxykdQZTNi7pX4S01
	 m0QqPDRyO8c1g==
Date: Fri, 13 Jun 2025 14:07:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, bhelgaas@google.com,
	Thomas Zimmermann <tzimmermann@suse.de>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/VGA: Look at all PCI display devices in VGA arbiter
Message-ID: <20250613190718.GA968774@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613031215.615885-1-superm1@kernel.org>

On Thu, Jun 12, 2025 at 10:12:14PM -0500, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> On an A+N mobile system the APU is not being selected by some desktop
> environments for any rendering tasks. This is because the neither GPU
> is being treated as "boot_vga" but that is what some environments use
> to select a GPU [1].

What is "A+N" and "APU"?

I didn't quite follow the second sentence.  I guess you're saying some
userspace environments use the "boot_vga" sysfs file to select a GPU?
And on this A+N system, neither device has the file?

> The VGA arbiter driver only looks at devices that report as PCI display
> VGA class devices. Neither GPU on the system is a display VGA class
> device:
> 
> c5:00.0 3D controller: NVIDIA Corporation Device 2db9 (rev a1)
> c6:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] Device 150e (rev d1)
> 
> So neither device gets the boot_vga sysfs file. The vga_is_boot_device()
> function already has some handling for integrated GPUs by looking at the
> ACPI HID entries, so if all PCI display class devices are looked at it
> actually can detect properly with this device ordering.  However if there
> is a different ordering it could flag the wrong device.
> 
> Modify the VGA arbiter code and matching sysfs file entries to examine all
> PCI display class devices. After every device is added to the arbiter list
> make a pass on all devices and explicitly check whether one is integrated.
> 
> This will cause all GPUs to gain a `boot_vga` file, but the correct device
> (APU in this case) will now show `1` and the incorrect device shows `0`.
> Userspace then picks the right device as well.

What determines whether the APU is the "correct" device?

> Link: https://github.com/robherring/libpciaccess/commit/b2838fb61c3542f107014b285cbda097acae1e12 [1]
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> RFC->v1:
>  * Add tag
>  * Drop unintended whitespace change
>  * Use vgaarb_dbg instead of vgaarb_info
> ---
>  drivers/pci/pci-sysfs.c |  2 +-
>  drivers/pci/vgaarb.c    | 48 +++++++++++++++++++++++++++--------------
>  include/linux/pci.h     | 15 +++++++++++++
>  3 files changed, 48 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 268c69daa4d57..c314ee1b3f9ac 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1707,7 +1707,7 @@ static umode_t pci_dev_attrs_are_visible(struct kobject *kobj,
>  	struct device *dev = kobj_to_dev(kobj);
>  	struct pci_dev *pdev = to_pci_dev(dev);
>  
> -	if (a == &dev_attr_boot_vga.attr && pci_is_vga(pdev))
> +	if (a == &dev_attr_boot_vga.attr && pci_is_display(pdev))
>  		return a->mode;
>  
>  	return 0;
> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> index 78748e8d2dbae..0eb1274d52169 100644
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
> @@ -140,6 +140,7 @@ void vga_set_default_device(struct pci_dev *pdev)
>  	if (vga_default == pdev)
>  		return;
>  
> +	vgaarb_dbg(&pdev->dev, "selecting as VGA boot device\n");

I guess this is essentially a move of the vgaarb_info() message from
vga_arbiter_add_pci_device() to here?  If so, I think I would preserve
the _info() level.  Including non-VGA devices is fairly subtle and I
don't think we need to discard potentially useful information about
what we're doing.

>  	pci_dev_put(vga_default);
>  	vga_default = pci_dev_get(pdev);
>  }
> @@ -751,6 +752,31 @@ static void vga_arbiter_check_bridge_sharing(struct vga_device *vgadev)
>  		vgaarb_info(&vgadev->pdev->dev, "no bridge control possible\n");
>  }
>  
> +static
> +void vga_arbiter_select_default_device(void)

Signature on one line.

> +{
> +	struct pci_dev *candidate = vga_default_device();
> +	struct vga_device *vgadev;
> +
> +	list_for_each_entry(vgadev, &vga_list, list) {
> +		if (vga_is_boot_device(vgadev)) {
> +			/* check if one is an integrated GPU, use that if so */
> +			if (candidate) {
> +				if (vga_arb_integrated_gpu(&candidate->dev))
> +					break;
> +				if (vga_arb_integrated_gpu(&vgadev->pdev->dev)) {
> +					candidate = vgadev->pdev;
> +					break;
> +				}
> +			} else
> +				candidate = vgadev->pdev;
> +		}
> +	}
> +
> +	if (candidate)
> +		vga_set_default_device(candidate);
> +}

It looks like this is related to the integrated GPU code in
vga_is_boot_device().  Can this be done by updating the logic there,
so it's more clear what change this patch makes?

It seems like this patch would change the selection in a way that
makes some of the vga_is_boot_device() comments obsolete.  E.g., "We
select the default VGA device in this order"?  Or "we use the *last*
[integrated GPU] because that was the previous behavior"?

The end of vga_is_boot_device() mentions non-legacy (non-VGA) devices,
but I don't remember now how we ever got there because
vga_arb_device_init() and pci_notify() only call
vga_arbiter_add_pci_device() for VGA devices.

>  /*
>   * Currently, we assume that the "initial" setup of the system is not sane,
>   * that is, we come up with conflicting devices and let the arbiter's
> @@ -816,23 +842,17 @@ static bool vga_arbiter_add_pci_device(struct pci_dev *pdev)
>  		bus = bus->parent;
>  	}
>  
> -	if (vga_is_boot_device(vgadev)) {
> -		vgaarb_info(&pdev->dev, "setting as boot VGA device%s\n",
> -			    vga_default_device() ?
> -			    " (overriding previous)" : "");
> -		vga_set_default_device(pdev);
> -	}
> -
>  	vga_arbiter_check_bridge_sharing(vgadev);
>  
>  	/* Add to the list */
>  	list_add_tail(&vgadev->list, &vga_list);
>  	vga_count++;
> -	vgaarb_info(&pdev->dev, "VGA device added: decodes=%s,owns=%s,locks=%s\n",
> +	vgaarb_dbg(&pdev->dev, "VGA device added: decodes=%s,owns=%s,locks=%s\n",

Looks like an unrelated change.

>  		vga_iostate_to_str(vgadev->decodes),
>  		vga_iostate_to_str(vgadev->owns),
>  		vga_iostate_to_str(vgadev->locks));
>  
> +	vga_arbiter_select_default_device();
>  	spin_unlock_irqrestore(&vga_lock, flags);
>  	return true;
>  fail:
> @@ -1499,8 +1519,8 @@ static int pci_notify(struct notifier_block *nb, unsigned long action,
>  
>  	vgaarb_dbg(dev, "%s\n", __func__);
>  
> -	/* Only deal with VGA class devices */
> -	if (!pci_is_vga(pdev))
> +	/* Only deal with display devices */
> +	if (!pci_is_display(pdev))
>  		return 0;

Are there any other pci_is_vga() users that might want
pci_is_display() instead?  virtio_gpu_pci_quirk()?

>  	/*
> @@ -1548,12 +1568,8 @@ static int __init vga_arb_device_init(void)
>  
>  	/* Add all VGA class PCI devices by default */
>  	pdev = NULL;
> -	while ((pdev =
> -		pci_get_subsys(PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
> -			       PCI_ANY_ID, pdev)) != NULL) {
> -		if (pci_is_vga(pdev))
> -			vga_arbiter_add_pci_device(pdev);
> -	}
> +	while ((pdev = pci_get_base_class(PCI_BASE_CLASS_DISPLAY, pdev)))
> +		vga_arbiter_add_pci_device(pdev);

I guess pci_get_base_class(PCI_BASE_CLASS_DISPLAY) is sort of a source
code optimization and this one-line change would be equivalent?

  -		if (pci_is_vga(pdev))
  +		if (pci_is_display(pdev))
  			vga_arbiter_add_pci_device(pdev);

If so, I think I prefer the one-liner because then everything in this
file would use pci_is_display() and we wouldn't have to figure out the
equivalent-ness of pci_get_base_class(PCI_BASE_CLASS_DISPLAY).

>  	pr_info("loaded\n");
>  	return rc;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 05e68f35f3923..e77754e43c629 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -744,6 +744,21 @@ static inline bool pci_is_vga(struct pci_dev *pdev)
>  	return false;
>  }
>  
> +/**
> + * pci_is_display - Check if a PCI device is a display controller
> + * @pdev: Pointer to the PCI device structure
> + *
> + * This function determines whether the given PCI device corresponds
> + * to a display controller. Display controllers are typically used
> + * for graphical output and are identified based on their class code.
> + *
> + * Return: true if the PCI device is a display controller, false otherwise.
> + */
> +static inline bool pci_is_display(struct pci_dev *pdev)
> +{
> +	return (pdev->class >> 16) == PCI_BASE_CLASS_DISPLAY;
> +}

Could use in vga_switcheroo_client_probe_defer(), IS_GFX_DEVICE(),
vfio_pci_is_intel_display(), i915_gfx_present(), get_bound_vga().
Arguable whether it's worth changing them, but I guess it's nice to
test for the same thing the same way.

Bjorn

