Return-Path: <linux-pci+bounces-29781-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB2EAD96B2
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 22:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31E4C3B5A19
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 20:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5348423D2A4;
	Fri, 13 Jun 2025 20:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uoGnztti"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2E12397A4
	for <linux-pci@vger.kernel.org>; Fri, 13 Jun 2025 20:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749848166; cv=none; b=Hly1Ezr7/J0a1Gpnj8IPt7qhI0NkNbAWhkPg+ctZYr1UfQxh6sf8akQXmxFaJtkESdCk8Pu+cdM7auQ+k1h0viw53aGEOnfVRhT8nAQH0eHflzNgwPyidWWCiq1c6NHvgkE0lNJvqe1VhTJo5nQB7GhrgCEKIapKmdHWC3TxW/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749848166; c=relaxed/simple;
	bh=hM7uNOVwSoedrs18Tur22eXzJmdy4gsK6GsdA8mAXgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LOR13wLbdVhxKi5TMoxEtqqyCPJHAeQ2YqcBfH8OJ0zBElR7GegwyELzRLgi/5yo8lyz3EoBFEYCshIwj2lWnfoBKR8dSoDgLIS1M9Eo96fY9E1Yiba16E64QIwV9GWDErYQGPytLIVNoEhptdBSEO55lIjIYdpMd87VqY0STd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uoGnztti; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEAC4C4CEE3;
	Fri, 13 Jun 2025 20:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749848165;
	bh=hM7uNOVwSoedrs18Tur22eXzJmdy4gsK6GsdA8mAXgU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uoGnzttifNDyxoJT5cFHI7A/cCbSjj+uuSKlh7mVZ7g+Bw8U3eBVm5C9TkzKhi7jm
	 ywLUOGo7rplUZ++WEA8zd6ibHs58COWpvf4NuXJArVCv/EWjVOe1Uf1r3qwTb850Tj
	 a1b2s4as7FgF1s5pjzjwxyLhrx/3Axe8mSDLfJh2QOFR8RkPlRWMxio1fvOPOinIDY
	 7Eo9PIwWEcO/pHPCpaSVGIA2xehvN9AUKXi09VNxuiN/PFIX02672l+OEzwnX8Kkvw
	 QOowNad73AFFHyUu5WclXV4SZjiIUnmnXyf0ufdF1IndJWdk5c0sjYYd3gQsMkHUCg
	 aEDeLbPTHwANg==
Message-ID: <5ae2fa88-7144-4dd3-9ac6-58f155b2bc36@kernel.org>
Date: Fri, 13 Jun 2025 15:56:03 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/VGA: Look at all PCI display devices in VGA arbiter
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alex Williamson <alex.williamson@redhat.com>, mario.limonciello@amd.com,
 bhelgaas@google.com, Thomas Zimmermann <tzimmermann@suse.de>,
 linux-pci@vger.kernel.org, Hans de Goede <hansg@kernel.org>,
 Daniel Dadap <ddadap@nvidia.com>
References: <20250613203130.GA974345@bhelgaas>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20250613203130.GA974345@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

+Daniel Dadap from NV
+Hans

Here's the whole thread for you guys for context.
https://lore.kernel.org/linux-pci/20250613203130.GA974345@bhelgaas/T/#m7f7bbc3f048f43e698fec4cccc9e5a3bad6ee645

On 6/13/2025 3:31 PM, Bjorn Helgaas wrote:
> On Fri, Jun 13, 2025 at 02:31:10PM -0500, Mario Limonciello wrote:
>> On 6/13/2025 2:07 PM, Bjorn Helgaas wrote:
>>> On Thu, Jun 12, 2025 at 10:12:14PM -0500, Mario Limonciello wrote:
>>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>>
>>>> On an A+N mobile system the APU is not being selected by some desktop
>>>> environments for any rendering tasks. This is because the neither GPU
>>>> is being treated as "boot_vga" but that is what some environments use
>>>> to select a GPU [1].
>>>
>>> What is "A+N" and "APU"?
>>
>> A+N is meant to refer to an AMD APU + NVIDIA dGPU.
>> APU is an SoC that contains a lot more IP than just x86 cores.  In this
>> context it contains both integrated graphics and display IP.
> 
> So I guess "APU is not being selected" refers to the AMD APU?

Yeah that's right.

> 
>>> I didn't quite follow the second sentence.  I guess you're saying some
>>> userspace environments use the "boot_vga" sysfs file to select a GPU?
>>> And on this A+N system, neither device has the file?
>>
>> Yeah.  Specifically this problem happens in Xorg that the library it uses
>> (libpciaccess) looks for a boot_vga file.  That file isn't found on either
>> GPU and so Xorg picks the first GPU it finds in the PCI heirarchy which
>> happens to be the NVIDIA GPU.
>>
>>>> The VGA arbiter driver only looks at devices that report as PCI display
>>>> VGA class devices. Neither GPU on the system is a display VGA class
>>>> device:
>>>>
>>>> c5:00.0 3D controller: NVIDIA Corporation Device 2db9 (rev a1)
>>>> c6:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] Device 150e (rev d1)
>>>>
>>>> So neither device gets the boot_vga sysfs file. The vga_is_boot_device()
>>>> function already has some handling for integrated GPUs by looking at the
>>>> ACPI HID entries, so if all PCI display class devices are looked at it
>>>> actually can detect properly with this device ordering.  However if there
>>>> is a different ordering it could flag the wrong device.
>>>>
>>>> Modify the VGA arbiter code and matching sysfs file entries to examine all
>>>> PCI display class devices. After every device is added to the arbiter list
>>>> make a pass on all devices and explicitly check whether one is integrated.
>>>>
>>>> This will cause all GPUs to gain a `boot_vga` file, but the correct device
>>>> (APU in this case) will now show `1` and the incorrect device shows `0`.
>>>> Userspace then picks the right device as well.
>>>
>>> What determines whether the APU is the "correct" device?
>>
>> In this context is the one that is physically connected to the eDP panel.
>> When the "wrong" one is selected then it is used for rendering.
> 
> How does the code figure out which is connected to the eDP panel?  I
> didn't see anything in the patch that I can relate to this.  This
> needs to be something people who are not AMD and NVIDIA experts can
> figure out in five years.

In this case we're using the vga_arb_integrated_gpu() to tell which GPU 
has ACPI_VIDEO_HID added to it.  That is; it's a proxy from ACPI.

> 
> It feels like we're fixing a point problem and next month's system
> might have the opposite issue, and we won't know how to make both
> systems work.

Actually quite the contrary.  I wrote this patch for a Strix A+N system 
from 2025, but I just got a bug report at drm/amd that is showing very 
high power consumption on an A+N system from 2023.

I'm still waiting for further details from the reporter (including 
testing this patch) but I want to call out a few things:

* It was on Ubuntu - which is known to have code to default to Xorg when 
it sees NVIDIA.
* In that case the N GPU comes first on the PCI hierarchy (just like 
this one).
* The NVIDIA GPU never goes into a low power state.
* That case has both the integrated GPU and NVIDIA GPU as "VGA" devices.

So I feel it's actually a really good litmus test for the logic 
introduced in this patch.

If you would like to look more on it:
https://gitlab.freedesktop.org/drm/amd/-/issues/4303

> 
>> Without this patch the net outcome ends up being that the APU display
>> hardware drives the eDP but the desktop is rendered using the N dGPU. There
>> is a lot of latency in doing it this way, and worse off the N dGPU stays
>> powered on at all times.  It never enters into runtime PM.
> 
>>>> +{
>>>> +	struct pci_dev *candidate = vga_default_device();
>>>> +	struct vga_device *vgadev;
>>>> +
>>>> +	list_for_each_entry(vgadev, &vga_list, list) {
>>>> +		if (vga_is_boot_device(vgadev)) {
>>>> +			/* check if one is an integrated GPU, use that if so */
>>>> +			if (candidate) {
>>>> +				if (vga_arb_integrated_gpu(&candidate->dev))
>>>> +					break;
>>>> +				if (vga_arb_integrated_gpu(&vgadev->pdev->dev)) {
>>>> +					candidate = vgadev->pdev;
>>>> +					break;
>>>> +				}
>>>> +			} else
>>>> +				candidate = vgadev->pdev;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	if (candidate)
>>>> +		vga_set_default_device(candidate);
>>>> +}
>>>
>>> It looks like this is related to the integrated GPU code in
>>> vga_is_boot_device().  Can this be done by updating the logic there,
>>> so it's more clear what change this patch makes?
>>>
>>> It seems like this patch would change the selection in a way that
>>> makes some of the vga_is_boot_device() comments obsolete.  E.g., "We
>>> select the default VGA device in this order"?  Or "we use the *last*
>>> [integrated GPU] because that was the previous behavior"?
>>>
>>> The end of vga_is_boot_device() mentions non-legacy (non-VGA) devices,
>>> but I don't remember now how we ever got there because
>>> vga_arb_device_init() and pci_notify() only call
>>> vga_arbiter_add_pci_device() for VGA devices.
>>
>> Sure I'll review the comments and update.  As for moving the logic I didn't
>> see an obvious way to do this.  This code is "tie-breaker" code in the case
>> that two GPUs are otherwise ranked equally.
> 
> How do we break the tie?  I guess we use the first one we find?

My expectation is that only one will be given the HID ACPI_VIDEO_HID by 
ACPI; that is vga_arb_integrated_gpu() should only return for one of them.

> 
> The comment in vga_is_boot_device() says we expect only a single
> integrated GPU, but I guess this system breaks that assumption?

No; only the integrated GPU in the APU has ACPI_VIDEO_HID.

> 
> And in the absence of other clues, vga_is_boot_device() decides that
> every integrated GPU it finds should be the default, so the last one
> wins?  But now we want the first one to win?

Hopefully you see exactly why I don't see a way to do this without a tie 
breaker round.  vga_is_boot_device() looks for things that it thinks are 
"better" and will mark one as the default device based on heuristics.

Now that we're looking at more devices (display devices) there are more 
things that will meet those heuristics and thus we need a second pass.

> 
>>>> -	while ((pdev =
>>>> -		pci_get_subsys(PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
>>>> -			       PCI_ANY_ID, pdev)) != NULL) {
>>>> -		if (pci_is_vga(pdev))
>>>> -			vga_arbiter_add_pci_device(pdev);
>>>> -	}
>>>> +	while ((pdev = pci_get_base_class(PCI_BASE_CLASS_DISPLAY, pdev)))
>>>> +		vga_arbiter_add_pci_device(pdev);
>>>
>>> I guess pci_get_base_class(PCI_BASE_CLASS_DISPLAY) is sort of a source
>>> code optimization and this one-line change would be equivalent?
>>>
>>>     -		if (pci_is_vga(pdev))
>>>     +		if (pci_is_display(pdev))
>>>     			vga_arbiter_add_pci_device(pdev);
>>>
>>> If so, I think I prefer the one-liner because then everything in this
>>> file would use pci_is_display() and we wouldn't have to figure out the
>>> equivalent-ness of pci_get_base_class(PCI_BASE_CLASS_DISPLAY).
>>
>> pci_get_base_class() is a search function.  It only really makes sense for
>> iterating.
> 
> Right I'm saying that if you do this:
> 
>          while ((pdev =
>                  pci_get_subsys(PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
>                                 PCI_ANY_ID, pdev)) != NULL) {
>                  if (pci_is_display(pdev))
>                          vga_arbiter_add_pci_device(pdev);
>          }
> 
> the patch is a bit smaller and we don't have to look up
> pci_get_base_class() and confirm that it returns things for which
> pci_is_display() is true.  That's just a little more analysis.
> 
> Bjorn

Got it; will KISS.


