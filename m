Return-Path: <linux-pci+bounces-29957-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFEAADD904
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 19:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C78147A3916
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 17:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B932FA62E;
	Tue, 17 Jun 2025 17:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvGpVrwX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41BF2FA62C
	for <linux-pci@vger.kernel.org>; Tue, 17 Jun 2025 17:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750179699; cv=none; b=IQMaRR4Q4T0ED31NTZ8idr68y8gkd4ARb2lmEoZafzL/xErRz0hNsrZeuOjKxIcpRJCiBFPQ/fQ8NgMtEtbaKu+CYe7J9EGgDqLhJkQHYXPEo6kvKNa7B6KZp+iCHuzTUUziq/PYW1ZGRbVaWZapIqeUAyV+X/KFgjvtG6hd36k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750179699; c=relaxed/simple;
	bh=hrHVQterk2m8oCFmDhZjj5dT9FmJN3GCiWABn3RBbVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sywcb+kUCf0eHieOpzBMJQ8vVLReZXrgzEXa9nkb2OCCrI4RlSD4xkDoWWLIDKYyed6/B+zUv3zYrHPmUytrPwqstrqxrQRtEjUCHzZw1x2bsIwB2Ingif+dH5c9TBJd55XWUj0hufm8iVL+ON3b4vSxvf+nxJgmGFN9VYtrVlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvGpVrwX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC6C0C4CEE3;
	Tue, 17 Jun 2025 17:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750179699;
	bh=hrHVQterk2m8oCFmDhZjj5dT9FmJN3GCiWABn3RBbVc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GvGpVrwXcvrVlZ0kCXr1TUwbS7Wchy4vjiIfUv/jwbLpvtUzmXZ5rsNCKxzDgGk1A
	 W5KtnfyDVcqqHr/EEu8BI9a3m8s158gQoiT7dIOyxDYuuppNUWiA2yTlJloDdZMXht
	 VafzE2LXFV/uHVHgP5had4LMBhWyaMXXjCFeFVsYuvFikDMx6GEBkHoYU+ik/uQupV
	 ixQV4q/UvbZNv7jsj0oQsBbpOlLbCTT/VGBTGuUyJJpE7MraDSkij6wM0G4xNKPLQn
	 j+5tp5HlUZ7vJJIok60KvKLXAUBuTJBP2SbAmeqgdMRWvqRGZCY++VJF5ffQyNyZwR
	 xEH2d1Ykgo0DA==
Message-ID: <794844d0-6cc6-4efe-b91f-8b0af8251d80@kernel.org>
Date: Tue, 17 Jun 2025 12:01:37 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/VGA: Look at all PCI display devices in VGA arbiter
To: Daniel Dadap <ddadap@nvidia.com>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>, mario.limonciello@amd.com,
 bhelgaas@google.com, Thomas Zimmermann <tzimmermann@suse.de>,
 linux-pci@vger.kernel.org, Hans de Goede <hansg@kernel.org>
References: <20250613203130.GA974345@bhelgaas>
 <5ae2fa88-7144-4dd3-9ac6-58f155b2bc36@kernel.org>
 <aEycaB9Hq5ZLMVaO@ddadap-lakeline.nvidia.com> <aE0fFIxCmauAHtNM@wunner.de>
 <aFAyzETfBySFRhQC@ddadap-lakeline.nvidia.com> <aFBs_PyM0XAZPb2z@wunner.de>
 <aFGPXDfOkjiy_6HH@ddadap-lakeline.nvidia.com>
 <1b166e77-4151-426b-ab80-b4c34303ca8d@kernel.org>
 <aFGZhIS4IPxyjPCE@ddadap-lakeline.nvidia.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <aFGZhIS4IPxyjPCE@ddadap-lakeline.nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/17/25 11:36 AM, Daniel Dadap wrote:
> On Tue, Jun 17, 2025 at 11:06:00AM -0500, Mario Limonciello wrote:
>> On 6/17/25 10:53 AM, Daniel Dadap wrote:
>>> On Mon, Jun 16, 2025 at 09:14:04PM +0200, Lukas Wunner wrote:
>>>> On Mon, Jun 16, 2025 at 10:05:48AM -0500, Daniel Dadap wrote:
>>>>> On Sat, Jun 14, 2025 at 09:04:52AM +0200, Lukas Wunner wrote:
>>>>>> On Fri, Jun 13, 2025 at 04:47:20PM -0500, Daniel Dadap wrote:
>>>>>>> Ideally we'd be able to actually query which GPU is connected to
>>>>>>> the panel at the time we're making this determination, but I don't
>>>>>>> think there's a uniform way to do this at the moment. Selecting the
>>>>>>> integrated GPU seems like a reasonable heuristic, since I'm not
>>>>>>> aware of any systems where the internal panel defaults to dGPU
>>>>>>> connection, since that would defeat the purpose of having a hybrid
>>>>>>> GPU system in the first place
>>>>>>
>>>>>> Intel-based dual-GPU MacBook Pros boot with the panel switched to the
>>>>>> dGPU by default.  This is done for Windows compatibility because Apple
>>>>>> never bothered to implement dynamic GPU switching on Windows.
>>>>>>
>>>>>> The boot firmware can be told to switch the panel to the iGPU via an
>>>>>> EFI variable, but that's not something the kernel can or should depend on.
>>>>>>
>>>>>> MacBook Pros introduced since 2013/2014 hide the iGPU if the panel is
>>>>>> switched to the dGPU on boot, but the kernel is now unhiding it since
>>>>>> 71e49eccdca6.
>>>>>
>>>>> This is good to know. Is vga_switcheroo initialized by the time the code
>>>>> in this patch runs? If so, maybe we should query switcheroo to determine
>>>>> the GPU which is connected to the panel and favor that one, then fall
>>>>> back to the "iGPU is probably right" heuristic otherwise.
>>>>
>>>> Right now vga_switcheroo doesn't seem to provide a function to query the
>>>> current mux state.
>>>>
>>>> The driver for the mux on MacBook Pros, apple_gmux.c, can be modular,
>>>> so may be loaded fairly late.
>>>
>>> Yeah, that's what I was afraid of.
>>>
>>>>
>>>> Personally I'm booting my MacBook Pro via EFI, so the GPU in use is
>>>> whatever efifb is talking to.  However it is possible to boot these
>>>> machines in a legacy CSM mode and I don't know what the situation
>>>> looks like in that case.
>>>>
>>>
>>> Skimming through the code, this seems like the sort of thing that the
>>> existing check in vga_is_firmware_default() is testing. I'm not familiar
>>> enough with the relevant code to intuitively know whether it is supposed
>>> to work for UEFI or legacy VGA or both (I think both?).
>>>
>>> Mario, on the affected system, what does vga_is_firmware_default() return
>>> on each of the GPUs? (I'd expect it to return true for the iGPU and false
>>> for the dGPU, but I think the (boot_vga && boot_vga->is_firmware_default)
>>> test would cause vga_is_boot_device() to return false if the vga_default
>>> is passed into it a second time. That made sense for the way that the
>>> function was originally called, to test if the passed-in vgadev is any
>>> "better" than vga_default, and from a quick skim it doesn't seem like it
>>> would get called multiple times in the new code either, but I worry that
>>> if someone else decides they need to call vga_is_boot_device() a second
>>> time in the future it might return a false result for vga_default.)
>>>
>>
>> Right "now" on an unpatched kernel it won't run 'at all' because
>> vga_arb_device_init() only matches VGA class devices.
>>
>> Both GPUs are not VGA compatible, which is what lead to the patch in this
>> thread starting to match display class devices too.
>>
>>
> 
> Sure, I was curious what vga_is_firmware_default() returns for each of
> the GPUs when run, regardless of whether or not it's currently being run
> in the existing code - I'm wondering if vga_is_firmware_default() can be
> a better tie breaker (or at least a first line tie breaker) than the one
> you have now which tests for iGPU. I kind of went off on a tangent about
> vga_is_boot_device() being possibly unreliable for a second time caller
> when I was checking the callers of vga_is_firmware_default().
> 

That's actually a really good point.  Here's the diff I tried.

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index 78748e8d2dba..b4e085806544 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -816,6 +816,8 @@ static bool vga_arbiter_add_pci_device(struct 
pci_dev *pdev)
                 bus = bus->parent;
         }

+       pci_info(pdev, "is firmware default: %d\n", 
vga_is_firmware_default(pdev));
+
         if (vga_is_boot_device(vgadev)) {
                 vgaarb_info(&pdev->dev, "setting as boot VGA device%s\n",
                             vga_default_device() ?
@@ -1500,7 +1502,7 @@ static int pci_notify(struct notifier_block *nb, 
unsigned long action,
         vgaarb_dbg(dev, "%s\n", __func__);

         /* Only deal with VGA class devices */
-       if (!pci_is_vga(pdev))
+       if (!pci_is_display(pdev))
                 return 0;

         /*
@@ -1551,7 +1553,7 @@ static int __init vga_arb_device_init(void)
         while ((pdev =
                 pci_get_subsys(PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
                                PCI_ANY_ID, pdev)) != NULL) {
-               if (pci_is_vga(pdev))
+               if (pci_is_display(pdev))
                         vga_arbiter_add_pci_device(pdev);
         }

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 05e68f35f392..077e90a2af37 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -744,6 +744,22 @@ static inline bool pci_is_vga(struct pci_dev *pdev)
         return false;
  }

+
+/**
+ * pci_is_display - Check if a PCI device is a display controller
+ * @pdev: Pointer to the PCI device structure
+ *
+ * This function determines whether the given PCI device corresponds
+ * to a display controller. Display controllers are typically used
+ * for graphical output and are identified based on their class code.
+ *
+ * Return: true if the PCI device is a display controller, false otherwise.
+ */
+static inline bool pci_is_display(struct pci_dev *pdev)
+{
+       return (pdev->class >> 16) == PCI_BASE_CLASS_DISPLAY;
+}
+
  #define for_each_pci_bridge(dev, bus)                          \
         list_for_each_entry(dev, &bus->devices, bus_list)       \
                 if (!pci_is_bridge(dev)) {} else

On 6.16-rc2 with that applied:

$ lspci | grep "\[03"
c6:00.0 3D controller [0302]: NVIDIA Corporation Device (rev a1)
c7:00.0 Display controller [0380]: Advanced Micro Devices, Inc. 
[AMD/ATI] Device (rev d1)

$ sudo dmesg | grep "firmware default"
[    0.379664] pci 0000:c6:00.0: is firmware default: 0
[    0.379664] pci 0000:c7:00.0: is firmware default: 1

Which actually means that the existing code when making a second pass 
the correct GPU *is* getting set using that as a tie breaker.

$ sudo dmesg | grep arb
[    0.379664] pci 0000:c6:00.0: vgaarb: setting as boot VGA device
[    0.379664] pci 0000:c6:00.0: vgaarb: bridge control possible
[    0.379664] pci 0000:c6:00.0: vgaarb: VGA device added: 
decodes=io+mem,owns=none,locks=none
[    0.379664] pci 0000:c7:00.0: vgaarb: setting as boot VGA device 
(overriding previous)
[    0.379664] pci 0000:c7:00.0: vgaarb: bridge control possible
[    0.379664] pci 0000:c7:00.0: vgaarb: VGA device added: 
decodes=io+mem,owns=none,locks=none
[    0.379664] vgaarb: loaded
[    4.108302] amdgpu 0000:c7:00.0: vgaarb: deactivate vga console

IE if changing pci_dev_attrs_are_visible() to show for all display 
devices it /should/ work without the logic changes I had.

