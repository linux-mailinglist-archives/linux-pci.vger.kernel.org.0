Return-Path: <linux-pci+bounces-29785-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E55A1AD974A
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 23:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C812189F37A
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 21:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9002A239086;
	Fri, 13 Jun 2025 21:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E8xhhwwE"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7563E3595A
	for <linux-pci@vger.kernel.org>; Fri, 13 Jun 2025 21:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749849581; cv=none; b=XvD2c23XEzxdBdxMkFDt3uGG0Ub5UKDU2yqiieuRd9g4HSNCskQnzpgRHNSXiPc8mrp1sudD+s3G9u5+s6guG/w5SeYYRuDz7yrlyRLsMY709JzzoWgqP5wuRS6w4UINCLQCOMHaQYZT5M93ZH/mb2LVqrh1mljQEO1wz6JYSos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749849581; c=relaxed/simple;
	bh=qtsno7kuX4sr6O48EMXLuxIjFyJZy+Vy+St8d0exffQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iJkImdU84jH9VbmL5mhUJBU2bGBRvyGAL77uTtHWIhL7TQSMhvug2aH+A6ey4SJkdjLl/49ZY4Rx/dteZTOPmtOxFywtk+JlYoRS2ApHmSPyawRmj7TBKSK4ApYE9QkpEKdomTJn9DImaXfIATuUi2+l0QUOlP09sSv7arn6Vyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E8xhhwwE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749849576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C3vnDnx4yvvuwQPiNFeie7jOUskItGx2xXhiiLRjmnY=;
	b=E8xhhwwEDc8y3KnHoucgxa/tnyi7kzeRqRlFLzuChHflAoXLrncmtuGsGvV18HZQJIvXgV
	Wc5ayBifpu2AITnR6iTdJZst8hB7yIHuxgvBbU4DMnnXH8eQYgNfAPitptWCOqWOOLWyyY
	Cj2cVB71VaH4k7czsYdi/WqtVtjGFN8=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-c1O_S_swM_SlKSfRdkLptA-1; Fri, 13 Jun 2025 17:19:35 -0400
X-MC-Unique: c1O_S_swM_SlKSfRdkLptA-1
X-Mimecast-MFC-AGG-ID: c1O_S_swM_SlKSfRdkLptA_1749849574
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-86cf14fd106so39635839f.2
        for <linux-pci@vger.kernel.org>; Fri, 13 Jun 2025 14:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749849574; x=1750454374;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C3vnDnx4yvvuwQPiNFeie7jOUskItGx2xXhiiLRjmnY=;
        b=ihXEw8TJMsQzJMMpl8Y7HC9lpTzCi4PUsATvw37Z9Laru//ZUuqiAd72OQiH3RLaWq
         19AEXTnUNh4loooazRbcaCrAGrRpmQxFiZoWo1RNQWcFHY5tZKwWIw4bwDA+ySeF21EQ
         ZVpmVMWaY+UPp206gjVBHB/8lAjNbZ/9MrL+p4NTN3T34F/w/6iI3kC/AEC8dqpLkHMt
         xVz398fNFiUt++wqtoAtGMROcqsVUAfXcRj7e5Mjq6Dn0SJOyERnUsU1xi0Nsx/dAxhU
         Mvv6xCc8NjY//qubnr4UT5TlX4WXapIjPhDJr8wARauGgEKXkmls/6A+S/NjipXzR5n6
         yDBA==
X-Forwarded-Encrypted: i=1; AJvYcCWWGxk3n3JSj+SpWrGx8VEGNdVPnEwZNA2gdBA67yQqFRbTUb1j+TLf/EgjV57aTegQU0vuw6aXQDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfZwIWUeqNVZp1YvJ8ZM0KwTU6IHSJm7zGCWyi2JGdYEqQoDJO
	EcsVUBchyHAtW3xDuRAhxWASOyb8dMoPj3kzkSj2Eq4waLWCkdQxTx/4H4V8bXP9KR55LFe+/Q5
	LrTjYiYfDbdpShVx9AmOz6CUYKI4l/kXF7f8/2fAG2ncxPMCfODDO0+N4JwSEJw==
X-Gm-Gg: ASbGnctdqz+8dIYun8cql5IeSI48sZ9ot9X2cQPZllzxLITkHBGkcO1X+OBPCeMDACk
	wSbCH6WhKTbnCLsTIgQlYHxs8uA7j+ZeHHo2mERTqG+5eQBhJ5hvhEMezkOoOy6q+adDuf3dJWA
	T+UxhH6lg5Slqo/DdSCIjI69FORyX5FI70tHqpSRXK+SvhryNvz7heyBtW44XaxgQqcUqxZnUWq
	UPJooSKk64TcMTKFPrtewzgi2FSYjgLrVTOPqh/FMg1EsT6zD6Y2ZEMfAfYxLAP8APCpne/MG+m
	Zjl/fngyAX4uX95eYQ+G3kgwrw==
X-Received: by 2002:a05:6602:2cc9:b0:873:13c6:f381 with SMTP id ca18e2360f4ac-875dedecba6mr27456639f.4.1749849574158;
        Fri, 13 Jun 2025 14:19:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7sO8F3vH3USfDGRouNpbHRr31Ji1IuxDt+B/EQAMv0+5aesuPy5wryTDVqLqGddfoAsRJUQ==
X-Received: by 2002:a05:6602:2cc9:b0:873:13c6:f381 with SMTP id ca18e2360f4ac-875dedecba6mr27455839f.4.1749849573587;
        Fri, 13 Jun 2025 14:19:33 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50149b9d485sm488111173.43.2025.06.13.14.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 14:19:31 -0700 (PDT)
Date: Fri, 13 Jun 2025 15:19:29 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, mario.limonciello@amd.com,
 bhelgaas@google.com, Thomas Zimmermann <tzimmermann@suse.de>,
 linux-pci@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] PCI/VGA: Look at all PCI display devices in VGA arbiter
Message-ID: <20250613151929.3c944c3c.alex.williamson@redhat.com>
In-Reply-To: <3a0a7aeb-436d-442a-bede-9e760a69fa47@kernel.org>
References: <20250613190718.GA968774@bhelgaas>
	<3a0a7aeb-436d-442a-bede-9e760a69fa47@kernel.org>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Jun 2025 14:31:10 -0500
Mario Limonciello <superm1@kernel.org> wrote:

> On 6/13/2025 2:07 PM, Bjorn Helgaas wrote:
> > On Thu, Jun 12, 2025 at 10:12:14PM -0500, Mario Limonciello wrote:  
> >> From: Mario Limonciello <mario.limonciello@amd.com>
> >>
> >> On an A+N mobile system the APU is not being selected by some desktop
> >> environments for any rendering tasks. This is because the neither GPU
> >> is being treated as "boot_vga" but that is what some environments use
> >> to select a GPU [1].  
> > 
> > What is "A+N" and "APU"?  
> 
> A+N is meant to refer to an AMD APU + NVIDIA dGPU.
> APU is an SoC that contains a lot more IP than just x86 cores.  In this 
> context it contains both integrated graphics and display IP.
> 
> > 
> > I didn't quite follow the second sentence.  I guess you're saying some
> > userspace environments use the "boot_vga" sysfs file to select a GPU?
> > And on this A+N system, neither device has the file?  
> 
> Yeah.  Specifically this problem happens in Xorg that the library it 
> uses (libpciaccess) looks for a boot_vga file.  That file isn't found on 
> either GPU and so Xorg picks the first GPU it finds in the PCI heirarchy 
> which happens to be the NVIDIA GPU.
> 
> >   
> >> The VGA arbiter driver only looks at devices that report as PCI display
> >> VGA class devices. Neither GPU on the system is a display VGA class
> >> device:
> >>
> >> c5:00.0 3D controller: NVIDIA Corporation Device 2db9 (rev a1)
> >> c6:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] Device 150e (rev d1)
> >>
> >> So neither device gets the boot_vga sysfs file. The vga_is_boot_device()
> >> function already has some handling for integrated GPUs by looking at the
> >> ACPI HID entries, so if all PCI display class devices are looked at it
> >> actually can detect properly with this device ordering.  However if there
> >> is a different ordering it could flag the wrong device.
> >>
> >> Modify the VGA arbiter code and matching sysfs file entries to examine all
> >> PCI display class devices. After every device is added to the arbiter list
> >> make a pass on all devices and explicitly check whether one is integrated.
> >>
> >> This will cause all GPUs to gain a `boot_vga` file, but the correct device
> >> (APU in this case) will now show `1` and the incorrect device shows `0`.
> >> Userspace then picks the right device as well.  
> > 
> > What determines whether the APU is the "correct" device?  
> 
> In this context is the one that is physically connected to the eDP 
> panel.  When the "wrong" one is selected then it is used for rendering.
> 
> Without this patch the net outcome ends up being that the APU display 
> hardware drives the eDP but the desktop is rendered using the N dGPU. 
> There is a lot of latency in doing it this way, and worse off the N dGPU 
> stays powered on at all times.  It never enters into runtime PM.
> 
> >   
> >> Link: https://github.com/robherring/libpciaccess/commit/b2838fb61c3542f107014b285cbda097acae1e12 [1]
> >> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >> RFC->v1:
> >>   * Add tag
> >>   * Drop unintended whitespace change
> >>   * Use vgaarb_dbg instead of vgaarb_info
> >> ---
> >>   drivers/pci/pci-sysfs.c |  2 +-
> >>   drivers/pci/vgaarb.c    | 48 +++++++++++++++++++++++++++--------------
> >>   include/linux/pci.h     | 15 +++++++++++++
> >>   3 files changed, 48 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> >> index 268c69daa4d57..c314ee1b3f9ac 100644
> >> --- a/drivers/pci/pci-sysfs.c
> >> +++ b/drivers/pci/pci-sysfs.c
> >> @@ -1707,7 +1707,7 @@ static umode_t pci_dev_attrs_are_visible(struct kobject *kobj,
> >>   	struct device *dev = kobj_to_dev(kobj);
> >>   	struct pci_dev *pdev = to_pci_dev(dev);
> >>   
> >> -	if (a == &dev_attr_boot_vga.attr && pci_is_vga(pdev))
> >> +	if (a == &dev_attr_boot_vga.attr && pci_is_display(pdev))
> >>   		return a->mode;
> >>   
> >>   	return 0;
> >> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> >> index 78748e8d2dbae..0eb1274d52169 100644
> >> --- a/drivers/pci/vgaarb.c
> >> +++ b/drivers/pci/vgaarb.c
> >> @@ -140,6 +140,7 @@ void vga_set_default_device(struct pci_dev *pdev)
> >>   	if (vga_default == pdev)
> >>   		return;
> >>   
> >> +	vgaarb_dbg(&pdev->dev, "selecting as VGA boot device\n");  
> > 
> > I guess this is essentially a move of the vgaarb_info() message from
> > vga_arbiter_add_pci_device() to here?  If so, I think I would preserve
> > the _info() level.  Including non-VGA devices is fairly subtle and I
> > don't think we need to discard potentially useful information about
> > what we're doing.  
> 
> Thanks - that was my original RFC before I sent this as PATCH but Thomas 
> had suggested to decrease to debug.  I'll restore in the next spin.
> 
> >   
> >>   	pci_dev_put(vga_default);
> >>   	vga_default = pci_dev_get(pdev);
> >>   }
> >> @@ -751,6 +752,31 @@ static void vga_arbiter_check_bridge_sharing(struct vga_device *vgadev)
> >>   		vgaarb_info(&vgadev->pdev->dev, "no bridge control possible\n");
> >>   }
> >>   
> >> +static
> >> +void vga_arbiter_select_default_device(void)  
> > 
> > Signature on one line.
> >   
> 
> Ack
> 
> >> +{
> >> +	struct pci_dev *candidate = vga_default_device();
> >> +	struct vga_device *vgadev;
> >> +
> >> +	list_for_each_entry(vgadev, &vga_list, list) {
> >> +		if (vga_is_boot_device(vgadev)) {
> >> +			/* check if one is an integrated GPU, use that if so */
> >> +			if (candidate) {
> >> +				if (vga_arb_integrated_gpu(&candidate->dev))
> >> +					break;
> >> +				if (vga_arb_integrated_gpu(&vgadev->pdev->dev)) {
> >> +					candidate = vgadev->pdev;
> >> +					break;
> >> +				}
> >> +			} else
> >> +				candidate = vgadev->pdev;
> >> +		}
> >> +	}
> >> +
> >> +	if (candidate)
> >> +		vga_set_default_device(candidate);
> >> +}  
> > 
> > It looks like this is related to the integrated GPU code in
> > vga_is_boot_device().  Can this be done by updating the logic there,
> > so it's more clear what change this patch makes?
> > 
> > It seems like this patch would change the selection in a way that
> > makes some of the vga_is_boot_device() comments obsolete.  E.g., "We
> > select the default VGA device in this order"?  Or "we use the *last*
> > [integrated GPU] because that was the previous behavior"?
> > 
> > The end of vga_is_boot_device() mentions non-legacy (non-VGA) devices,
> > but I don't remember now how we ever got there because
> > vga_arb_device_init() and pci_notify() only call
> > vga_arbiter_add_pci_device() for VGA devices.  
> 
> Sure I'll review the comments and update.  As for moving the logic I 
> didn't see an obvious way to do this.  This code is "tie-breaker" code 
> in the case that two GPUs are otherwise ranked equally.
> 
> >   
> >>   /*
> >>    * Currently, we assume that the "initial" setup of the system is not sane,
> >>    * that is, we come up with conflicting devices and let the arbiter's
> >> @@ -816,23 +842,17 @@ static bool vga_arbiter_add_pci_device(struct pci_dev *pdev)
> >>   		bus = bus->parent;
> >>   	}
> >>   
> >> -	if (vga_is_boot_device(vgadev)) {
> >> -		vgaarb_info(&pdev->dev, "setting as boot VGA device%s\n",
> >> -			    vga_default_device() ?
> >> -			    " (overriding previous)" : "");
> >> -		vga_set_default_device(pdev);
> >> -	}
> >> -
> >>   	vga_arbiter_check_bridge_sharing(vgadev);
> >>   
> >>   	/* Add to the list */
> >>   	list_add_tail(&vgadev->list, &vga_list);
> >>   	vga_count++;
> >> -	vgaarb_info(&pdev->dev, "VGA device added: decodes=%s,owns=%s,locks=%s\n",
> >> +	vgaarb_dbg(&pdev->dev, "VGA device added: decodes=%s,owns=%s,locks=%s\n",  
> > 
> > Looks like an unrelated change.  
> 
> Yeah it was going with the theme from Thomas' comment to decrease to 
> debug.  I'll put it back to info.
> 
> >   
> >>   		vga_iostate_to_str(vgadev->decodes),
> >>   		vga_iostate_to_str(vgadev->owns),
> >>   		vga_iostate_to_str(vgadev->locks));
> >>   
> >> +	vga_arbiter_select_default_device();
> >>   	spin_unlock_irqrestore(&vga_lock, flags);
> >>   	return true;
> >>   fail:
> >> @@ -1499,8 +1519,8 @@ static int pci_notify(struct notifier_block *nb, unsigned long action,
> >>   
> >>   	vgaarb_dbg(dev, "%s\n", __func__);
> >>   
> >> -	/* Only deal with VGA class devices */
> >> -	if (!pci_is_vga(pdev))
> >> +	/* Only deal with display devices */
> >> +	if (!pci_is_display(pdev))
> >>   		return 0;  
> > 
> > Are there any other pci_is_vga() users that might want
> > pci_is_display() instead?  virtio_gpu_pci_quirk()?  
> 
> +AlexW for comments on potential virtio changes here.

I can't comment on virtio_gpu, Cc +Gerd for that.

I do however take issue with the premise of this patch.  The VGA
arbiter is for adjusting VGA routing.  If neither device is VGA, why
are they registering with the VGA arbiter and what sense does it make
to create a boot_vga sysfs attribute of a non-VGA device?

It seems like we're trying to adapt the kernel to create a facade for
userspace when userspace should be falling back to some other means of
determining a primary graphical device.  For instance, is there
something in UEFI that could indicate the console?  ACPI?  DT?

It's also a bit concerning that we're making a policy decision here
that the integrated graphics is the "boot VGA" device, among two
non-VGA devices.  I think vgaarb has a similar legacy policy decision
for VGA devices that it's stuck with, but it's not clear to me that
reiterating the policy selection here is still correct.  Thanks,

Alex

> 
> If there are sensible changes they should be another patch, and also 
> I'll split the creation of pci_is_display() helper to it's own patch.
> >   
> >>   	/*
> >> @@ -1548,12 +1568,8 @@ static int __init vga_arb_device_init(void)
> >>   
> >>   	/* Add all VGA class PCI devices by default */
> >>   	pdev = NULL;
> >> -	while ((pdev =
> >> -		pci_get_subsys(PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
> >> -			       PCI_ANY_ID, pdev)) != NULL) {
> >> -		if (pci_is_vga(pdev))
> >> -			vga_arbiter_add_pci_device(pdev);
> >> -	}
> >> +	while ((pdev = pci_get_base_class(PCI_BASE_CLASS_DISPLAY, pdev)))
> >> +		vga_arbiter_add_pci_device(pdev);  
> > 
> > I guess pci_get_base_class(PCI_BASE_CLASS_DISPLAY) is sort of a source
> > code optimization and this one-line change would be equivalent?
> > 
> >    -		if (pci_is_vga(pdev))
> >    +		if (pci_is_display(pdev))
> >    			vga_arbiter_add_pci_device(pdev);
> > 
> > If so, I think I prefer the one-liner because then everything in this
> > file would use pci_is_display() and we wouldn't have to figure out the
> > equivalent-ness of pci_get_base_class(PCI_BASE_CLASS_DISPLAY).  
> 
> pci_get_base_class() is a search function.  It only really makese sense 
> for iterating.
> 
> 
> >   
> >>   	pr_info("loaded\n");
> >>   	return rc;
> >> diff --git a/include/linux/pci.h b/include/linux/pci.h
> >> index 05e68f35f3923..e77754e43c629 100644
> >> --- a/include/linux/pci.h
> >> +++ b/include/linux/pci.h
> >> @@ -744,6 +744,21 @@ static inline bool pci_is_vga(struct pci_dev *pdev)
> >>   	return false;
> >>   }
> >>   
> >> +/**
> >> + * pci_is_display - Check if a PCI device is a display controller
> >> + * @pdev: Pointer to the PCI device structure
> >> + *
> >> + * This function determines whether the given PCI device corresponds
> >> + * to a display controller. Display controllers are typically used
> >> + * for graphical output and are identified based on their class code.
> >> + *
> >> + * Return: true if the PCI device is a display controller, false otherwise.
> >> + */
> >> +static inline bool pci_is_display(struct pci_dev *pdev)
> >> +{
> >> +	return (pdev->class >> 16) == PCI_BASE_CLASS_DISPLAY;
> >> +}  
> > 
> > Could use in vga_switcheroo_client_probe_defer(), IS_GFX_DEVICE(),
> > vfio_pci_is_intel_display(), i915_gfx_present(), get_bound_vga().
> > Arguable whether it's worth changing them, but I guess it's nice to
> > test for the same thing the same way.
> > 
> > Bjorn  
> 
> Sure - this makes a stronger argument to add pci_is_display helper in 
> it's own patch instead of with this one.  I'll intend to have the first 
> patch introduce the helper and replace all existing users with it.
> 


