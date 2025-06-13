Return-Path: <linux-pci+bounces-29778-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF18AD964A
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 22:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E45F7A3837
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 20:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0AF21C176;
	Fri, 13 Jun 2025 20:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMXa9Nev"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAFEC148
	for <linux-pci@vger.kernel.org>; Fri, 13 Jun 2025 20:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749846692; cv=none; b=DVm0ONClFxrLcbTifMnGCOU6OflYBDCul09+WL3xSGQ/nRjXy18w5dq4rZ1rveTfQDs7rdmdOcmA4jV4SACS8Sx8ryTDXQtbniVLFH4gmmtrQgIBPL/XZvkMvJNY9U8G30IXEjBM7S+1KRemEfKaSpC8FhMIct4We4t3Ip42Xw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749846692; c=relaxed/simple;
	bh=WbvN2cb/4l9Mu1HdR3ViiuYjkFUGASOVYTNOjSYuPbk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uyODiHu9mKGQ5w8lo9XgkUWaQo4PnASl8tHSePqctnAB8cd5DDh823oufxK6kFLpQQQSxrEDPYX8xzjVeC2p8RpElVWjew6pDknPyHxQBRpLxe/F3sOUJUF3exRnEj2WsvNHLRIO6siJ+nv6OgcWt+qDGdBq6XJd3JUC2Y8+fdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMXa9Nev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3732BC4CEE3;
	Fri, 13 Jun 2025 20:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749846692;
	bh=WbvN2cb/4l9Mu1HdR3ViiuYjkFUGASOVYTNOjSYuPbk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bMXa9NevcmyzMPL0QfEkvShqU8GxJkegtuTAdyMxQ7vVul8shbNJYused2921tuaf
	 EPu4HLYGc7f9yWvtraE9OcoEtckWlYauugN8T2zOmTdAGEde7l425NJ/Z+QGUUFS35
	 G6R5g4HylY/uWrDmxjcNpMvv+7ovGpl89Ekh526m57bB260BkALlnOkr38sR61SSYg
	 GfrNQRdoqKwO25UJKU/oLf4PR5IMRrQuq5R2mJtfo/fMfstZEX7+R8uJxgAR33IWOM
	 kOiIH79MDcPTzr0lpAn9cbHrlt+F35NB0pLkmxFtexvxb00PQM+hlhO27pzFwlAbXo
	 +iBV3RsQcQGLQ==
Date: Fri, 13 Jun 2025 15:31:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <superm1@kernel.org>
Cc: Alex Williamson <alex.williamson@redhat.com>, mario.limonciello@amd.com,
	bhelgaas@google.com, Thomas Zimmermann <tzimmermann@suse.de>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/VGA: Look at all PCI display devices in VGA arbiter
Message-ID: <20250613203130.GA974345@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a0a7aeb-436d-442a-bede-9e760a69fa47@kernel.org>

On Fri, Jun 13, 2025 at 02:31:10PM -0500, Mario Limonciello wrote:
> On 6/13/2025 2:07 PM, Bjorn Helgaas wrote:
> > On Thu, Jun 12, 2025 at 10:12:14PM -0500, Mario Limonciello wrote:
> > > From: Mario Limonciello <mario.limonciello@amd.com>
> > > 
> > > On an A+N mobile system the APU is not being selected by some desktop
> > > environments for any rendering tasks. This is because the neither GPU
> > > is being treated as "boot_vga" but that is what some environments use
> > > to select a GPU [1].
> > 
> > What is "A+N" and "APU"?
> 
> A+N is meant to refer to an AMD APU + NVIDIA dGPU.
> APU is an SoC that contains a lot more IP than just x86 cores.  In this
> context it contains both integrated graphics and display IP.

So I guess "APU is not being selected" refers to the AMD APU?

> > I didn't quite follow the second sentence.  I guess you're saying some
> > userspace environments use the "boot_vga" sysfs file to select a GPU?
> > And on this A+N system, neither device has the file?
> 
> Yeah.  Specifically this problem happens in Xorg that the library it uses
> (libpciaccess) looks for a boot_vga file.  That file isn't found on either
> GPU and so Xorg picks the first GPU it finds in the PCI heirarchy which
> happens to be the NVIDIA GPU.
> 
> > > The VGA arbiter driver only looks at devices that report as PCI display
> > > VGA class devices. Neither GPU on the system is a display VGA class
> > > device:
> > > 
> > > c5:00.0 3D controller: NVIDIA Corporation Device 2db9 (rev a1)
> > > c6:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] Device 150e (rev d1)
> > > 
> > > So neither device gets the boot_vga sysfs file. The vga_is_boot_device()
> > > function already has some handling for integrated GPUs by looking at the
> > > ACPI HID entries, so if all PCI display class devices are looked at it
> > > actually can detect properly with this device ordering.  However if there
> > > is a different ordering it could flag the wrong device.
> > > 
> > > Modify the VGA arbiter code and matching sysfs file entries to examine all
> > > PCI display class devices. After every device is added to the arbiter list
> > > make a pass on all devices and explicitly check whether one is integrated.
> > > 
> > > This will cause all GPUs to gain a `boot_vga` file, but the correct device
> > > (APU in this case) will now show `1` and the incorrect device shows `0`.
> > > Userspace then picks the right device as well.
> > 
> > What determines whether the APU is the "correct" device?
> 
> In this context is the one that is physically connected to the eDP panel.
> When the "wrong" one is selected then it is used for rendering.

How does the code figure out which is connected to the eDP panel?  I
didn't see anything in the patch that I can relate to this.  This
needs to be something people who are not AMD and NVIDIA experts can
figure out in five years.

It feels like we're fixing a point problem and next month's system
might have the opposite issue, and we won't know how to make both
systems work.

> Without this patch the net outcome ends up being that the APU display
> hardware drives the eDP but the desktop is rendered using the N dGPU. There
> is a lot of latency in doing it this way, and worse off the N dGPU stays
> powered on at all times.  It never enters into runtime PM.

> > > +{
> > > +	struct pci_dev *candidate = vga_default_device();
> > > +	struct vga_device *vgadev;
> > > +
> > > +	list_for_each_entry(vgadev, &vga_list, list) {
> > > +		if (vga_is_boot_device(vgadev)) {
> > > +			/* check if one is an integrated GPU, use that if so */
> > > +			if (candidate) {
> > > +				if (vga_arb_integrated_gpu(&candidate->dev))
> > > +					break;
> > > +				if (vga_arb_integrated_gpu(&vgadev->pdev->dev)) {
> > > +					candidate = vgadev->pdev;
> > > +					break;
> > > +				}
> > > +			} else
> > > +				candidate = vgadev->pdev;
> > > +		}
> > > +	}
> > > +
> > > +	if (candidate)
> > > +		vga_set_default_device(candidate);
> > > +}
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
> Sure I'll review the comments and update.  As for moving the logic I didn't
> see an obvious way to do this.  This code is "tie-breaker" code in the case
> that two GPUs are otherwise ranked equally.

How do we break the tie?  I guess we use the first one we find?

The comment in vga_is_boot_device() says we expect only a single
integrated GPU, but I guess this system breaks that assumption?

And in the absence of other clues, vga_is_boot_device() decides that
every integrated GPU it finds should be the default, so the last one
wins?  But now we want the first one to win?

> > > -	while ((pdev =
> > > -		pci_get_subsys(PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
> > > -			       PCI_ANY_ID, pdev)) != NULL) {
> > > -		if (pci_is_vga(pdev))
> > > -			vga_arbiter_add_pci_device(pdev);
> > > -	}
> > > +	while ((pdev = pci_get_base_class(PCI_BASE_CLASS_DISPLAY, pdev)))
> > > +		vga_arbiter_add_pci_device(pdev);
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
> pci_get_base_class() is a search function.  It only really makes sense for
> iterating.

Right I'm saying that if you do this:

        while ((pdev =
                pci_get_subsys(PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
                               PCI_ANY_ID, pdev)) != NULL) {
                if (pci_is_display(pdev))
                        vga_arbiter_add_pci_device(pdev);
        }

the patch is a bit smaller and we don't have to look up
pci_get_base_class() and confirm that it returns things for which
pci_is_display() is true.  That's just a little more analysis.

Bjorn

