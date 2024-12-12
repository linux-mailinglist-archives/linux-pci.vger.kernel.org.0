Return-Path: <linux-pci+bounces-18327-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EB79EFB6C
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 19:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E358F16D30A
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 18:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AD3188917;
	Thu, 12 Dec 2024 18:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="IX2EIkZz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8ED2F2F;
	Thu, 12 Dec 2024 18:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029286; cv=none; b=k2BC0w8FwATQD+dQq6QAZnqtNCu9y3XXAy0b4K8zmHVwvXfNyERiJXaryholTwHla5NuisizSlx7x/eJGE5nsPxW31YHU3142StCQU20ewveqSh6k2LWBjwEfa485okEGORvLV5Ebl3TUDJ9GYOpG15gN6cIfRsOA3Ocr+a7vsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029286; c=relaxed/simple;
	bh=OrjzFJN/CbVucg/CI/XOG1GVGz/rQiD63cla65FMAY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aDmojuShEnmgSA8PWOZ8cIcJvreQnw9+hqbU8VPzes6armKZVYewovNo0WXn2Rx69tQKD1T96w4fQGAH1tBL20Jcmrw9EmP3n43ZPY/NE25MArn+U8K+1ZmG2e9XLXCoEiIwI8Xqulu6pzv93tJonJkwL+XaXxPNg7dY5tOBp7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=IX2EIkZz; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.178.10] (host-212-18-30-247.customer.m-online.net [212.18.30.247])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id DC0662FC0048;
	Thu, 12 Dec 2024 19:47:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1734029273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D3GMr2UsqW3TqiFxtHc9SubYQAbAyGF/4IV5YduLqcc=;
	b=IX2EIkZzotOce90AwfDPjIe2n3UGjDNeCvDnjk4GV/URfL0KbrYzbIMM7vnA+fkcjNrkZF
	7Cz39IcQO7RhoxVCMwufgiwd6Yjd7T3rdI4LQ43eYbQsACI8FSteLAm48mdSYXWgtBC9oA
	Q5y8HLZcm80oNY+b5834lA2o2E1Z45U=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <6a809349-016a-42bf-b139-544aeec543aa@tuxedocomputers.com>
Date: Thu, 12 Dec 2024 19:47:52 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: Avoid putting some root ports into D3 on some
 Ryzen chips
To: Mario Limonciello <mario.limonciello@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: ggo@tuxedocomputers.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241209193614.535940-1-wse@tuxedocomputers.com>
 <215cd12e-6327-4aa6-ac93-eac2388e7dab@amd.com>
 <23c6140b-946e-4c63-bba4-a7be77211948@tuxedocomputers.com>
 <823c393d-49f6-402b-ae8b-38ff44aeabc4@amd.com>
 <2b38ea7b-d50e-4070-80b6-65a66d460152@tuxedocomputers.com>
 <e0ee3415-4670-4c0c-897a-d5f70e0f65eb@amd.com>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <e0ee3415-4670-4c0c-897a-d5f70e0f65eb@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Am 11.12.24 um 22:24 schrieb Mario Limonciello:
> On 12/11/2024 06:47, Werner Sembach wrote:
>> Hi,
>>
>> Am 10.12.24 um 17:00 schrieb Mario Limonciello:
>>> On 12/10/2024 09:24, Werner Sembach wrote:
>>>> Hi,
>>>>
>>>> Am 09.12.24 um 20:45 schrieb Mario Limonciello:
>>>>> On 12/9/2024 13:36, Werner Sembach wrote:
>>>>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>>>>
>>>>>> commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>>>>>> sets the policy that all PCIe ports are allowed to use D3. When
>>>>>> the system is suspended if the port is not power manageable by the
>>>>>> platform and won't be used for wakeup via a PME this sets up the
>>>>>> policy for these ports to go into D3hot.
>>>>>>
>>>>>> This policy generally makes sense from an OSPM perspective but it leads
>>>>>> to problems with wakeup from suspend on the TUXEDO Sirius 16 Gen 1 with
>>>>>> an unupdated BIOS.
>>>>>>
>>>>>> - On family 19h model 44h (PCI 0x14b9) this manifests as a missing wakeup
>>>>>>    interrupt.
>>>>>> - On family 19h model 74h (PCI 0x14eb) this manifests as a system hang.
>>>>>>
>>>>>> On the affected Device + BIOS combination, add a quirk for the PCI device
>>>>>> ID used by the problematic root port on both chips to ensure that these
>>>>>> root ports are not put into D3hot at suspend.
>>>>>>
>>>>>> This patch is based on
>>>>>> https://lore.kernel.org/linux-pci/20230708214457.1229-2- 
>>>>>> mario.limonciello@amd.com/
>>>>>> but with the added condition both in the documentation and in the code to
>>>>>> apply only to the TUXEDO Sirius 16 Gen 1 with the original unpatched BIOS.
>>>>>>
>>>>>> Co-developed-by: Georg Gottleuber <ggo@tuxedocomputers.com>
>>>>>> Signed-off-by: Georg Gottleuber <ggo@tuxedocomputers.com>
>>>>>> Co-developed-by: Werner Sembach <wse@tuxedocomputers.com>
>>>>>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>>>>>> Cc: stable@vger.kernel.org # 6.1+
>>>>>> Reported-by: Iain Lane <iain@orangesquash.org.uk>
>>>>>> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from- 
>>>>>> suspend-with-external-USB-keyboard/m-p/5217121
>>>>>> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>>> ---
>>>>>>   drivers/pci/quirks.c | 31 +++++++++++++++++++++++++++++++
>>>>>>   1 file changed, 31 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>>>>> index 76f4df75b08a1..2226dca56197d 100644
>>>>>> --- a/drivers/pci/quirks.c
>>>>>> +++ b/drivers/pci/quirks.c
>>>>>> @@ -3908,6 +3908,37 @@ static void 
>>>>>> quirk_apple_poweroff_thunderbolt(struct pci_dev *dev)
>>>>>>   DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_INTEL,
>>>>>> PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C,
>>>>>>                      quirk_apple_poweroff_thunderbolt);
>>>>>> +
>>>>>> +/*
>>>>>> + * Putting PCIe root ports on Ryzen SoCs with USB4 controllers into D3hot
>>>>>> + * may cause problems when the system attempts wake up from s2idle.
>>>>>> + *
>>>>>> + * On family 19h model 44h (PCI 0x14b9) this manifests as a missing wakeup
>>>>>> + * interrupt.
>>>>>> + * On family 19h model 74h (PCI 0x14eb) this manifests as a system hang.
>>>>>> + *
>>>>>> + * This fix is still required on the TUXEDO Sirius 16 Gen1 with the 
>>>>>> original
>>>>>> + * unupdated BIOS.
>>>>>> + */
>>>>>> +static const struct dmi_system_id quirk_ryzen_rp_d3_dmi_table[] = {
>>>>>> +    {
>>>>>> +        .matches = {
>>>>>> +            DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
>>>>>> +            DMI_MATCH(DMI_BOARD_NAME, "APX958"),
>>>>>> +            DMI_MATCH(DMI_BIOS_VERSION, "V1.00A00"),
>>>>>> +        },
>>>>>> +    },
>>>>>> +    {}
>>>>>> +};
>>>>>> +
>>>>>> +static void quirk_ryzen_rp_d3(struct pci_dev *pdev)
>>>>>> +{
>>>>>> +    if (dmi_check_system(quirk_ryzen_rp_d3_dmi_table) &&
>>>>>> +        !acpi_pci_power_manageable(pdev))
>>>>>> +        pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
>>>>>> +}
>>>>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x14b9, quirk_ryzen_rp_d3);
>>>>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x14eb, quirk_ryzen_rp_d3);
>>>>>>   #endif
>>>>>>     /*
>>>>>
>>>>> Wait, what is wrong with:
>>>>>
>>>>> commit 7d08f21f8c630 ("x86/PCI: Avoid PME from D3hot/D3cold for AMD 
>>>>> Rembrandt and Phoenix USB4")
>>>>>
>>>>> Is that not activating on your system for some reason?
>>>>
>>>> Doesn't seem so, tested with the old BIOS and 6.13-rc2 and had blackscreen 
>>>> on wakeup.
>>>
>>> OK, I think we need to dig a layer deeper to see which root port is causing 
>>> problems to understand this.
>>>
>>>>
>>>> With a newer BIOS for that device suspend and resume however works.
>>>>
>>>
>>> Is there any reason that people would realistically be staying on the old 
>>> BIOS and instead we need to carry this quirk in the kernel for eternity?
>> Fear of device bricking or not knowing an update is available.
>
> The not knowing is solved by publishing firmware to LVFS.
>
> Most "popular" distributions include fwupd, regularly check for updates and 
> will notify users through the MOTD or a graphical application that there is 
> something available.
>
>>>
>>> With the Linux ecosystem for BIOS updates through fwupd + LVFS it's not a 
>>> very big barrier to entry to do an update like it was 20 years ago.
>> Sadly fwupd/LVFS does not support executing arbitrary efi binaries/nsh 
>> scripts which still is the main form ODMs provide bios updates.
>
> It's tangential to this thread; but generally ODMs will provide you a capsule 
> if you ask for one.

I already evaluated this a while back with the results:

If the BIOS is an AMI one you can get a capsule, but this capsule might 
overwrite DMI strings or the vendor boot logo if not flashed with the AMI 
flasher and extra flags (sadly I was not able to find out what these flags do 
under the hood to give fwupd the same capabilities). Also these capsules often 
not include Intel ME and EC firmware updates and certain bios version might only 
work with certain EC firmwares.

Last I checked in with the ODM that uses Insyde BIOSes we where not able to get 
a capsule update. I don't know if that is an ODM or Insyde problem.

For the rest I will come back to this on Monday as I'm currently away from the 
testing device, thanks for all the feedback so far.

>
> Anyhow if you are providing scripts and random EFI binaries in order to get 
> things updated, that explains why this is a large enough chunk of people to 
> justify a patch like this.
>
>>>
>>>> Looking in the patch the device id's are different (0x162e, 0x162f, 0x1668, 
>>>> and 0x1669).
>>>>
>>>
>>> TUXEDO Sirius 16 Gen1 is Phoenix based, right?  So at a minimum you 
>>> shouldn't be including PCI IDs from Rembrandt (0x14b9)
>> Thanks for the hint, I can delete that then.
>>>
>>> Here is the topology from a Phoenix system on my side:
>>>
>>> https://gist.github.com/superm1/85bf0c053008435458bdb39418e109d8
>>
>> Sorry for the noob question: How do I get that format? it's not lspci - tvnn 
>> on my system
>
> No worry.
>
> Having looked at a lot of s2idle bugs I've found it's generally helpful to 
> know what ACPI companion is assigned to devices and what are parents.
>
> So it's actually created by this function in the s2idle issue triage script, 
> amd_s2idle.py.
>
> https://gitlab.freedesktop.org/drm/amd/-/blob/master/scripts/amd_s2idle.py#L1945
>
> And while on the topic, does your "broken" BIOS report this from that script?
>
> '''
> Platform may hang resuming.  Upgrade your firmware or add pcie_port_pm=off to 
> kernel command line if you have problems
> '''
>
>>
>> But i think this contains the same information:
>>
>> $ lspci -Pnn
>> 00:00.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Phoenix Root 
>> Complex [1022:14e8]
>> 00:00.2 IOMMU [0806]: Advanced Micro Devices, Inc. [AMD] Phoenix IOMMU 
>> [1022:14e9]
>> 00:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Phoenix Dummy 
>> Host Bridge [1022:14ea]
>> 00:01.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Phoenix GPP 
>> Bridge [1022:14ed]
>> 00:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Phoenix Dummy 
>> Host Bridge [1022:14ea]
>> 00:02.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Phoenix GPP 
>> Bridge [1022:14ee]
>> 00:02.2 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Phoenix GPP 
>> Bridge [1022:14ee]
>> 00:02.3 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Phoenix GPP 
>> Bridge [1022:14ee]
>> 00:02.4 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Phoenix GPP 
>> Bridge [1022:14ee]
>> 00:03.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Phoenix Dummy 
>> Host Bridge [1022:14ea]
>> 00:03.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Family 19h 
>> USB4/Thunderbolt PCIe tunnel [1022:14ef]
>> 00:04.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Phoenix Dummy 
>> Host Bridge [1022:14ea]
>> 00:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Phoenix Dummy 
>> Host Bridge [1022:14ea]
>> 00:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Phoenix 
>> Internal GPP Bridge to Bus [C:A] [1022:14eb]
>> 00:08.2 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Phoenix 
>> Internal GPP Bridge to Bus [C:A] [1022:14eb]
>> 00:08.3 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Phoenix 
>> Internal GPP Bridge to Bus [C:A] [1022:14eb]
>> 00:14.0 SMBus [0c05]: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller 
>> [1022:790b] (rev 71)
>> 00:14.3 ISA bridge [0601]: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge 
>> [1022:790e] (rev 51)
>> 00:18.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Phoenix Data 
>> Fabric; Function 0 [1022:14f0]
>> 00:18.1 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Phoenix Data 
>> Fabric; Function 1 [1022:14f1]
>> 00:18.2 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Phoenix Data 
>> Fabric; Function 2 [1022:14f2]
>> 00:18.3 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Phoenix Data 
>> Fabric; Function 3 [1022:14f3]
>> 00:18.4 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Phoenix Data 
>> Fabric; Function 4 [1022:14f4]
>> 00:18.5 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Phoenix Data 
>> Fabric; Function 5 [1022:14f5]
>> 00:18.6 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Phoenix Data 
>> Fabric; Function 6 [1022:14f6]
>> 00:18.7 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Phoenix Data 
>> Fabric; Function 7 [1022:14f7]
>> 00:01.1/00.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD/ATI] Navi 
>> 10 XL Upstream Port of PCI Express Switch [1002:1478] (rev 12)
>> 00:01.1/00.0/00.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD/ ATI] 
>> Navi 10 XL Downstream Port of PCI Express Switch [1002:1479] (rev 12)
>> 00:01.1/00.0/00.0/00.0 VGA compatible controller [0300]: Advanced Micro 
>> Devices, Inc. [AMD/ATI] Navi 33 [Radeon RX 7600/7600 XT/7600M XT/7600S/7700S 
>> / PRO W7600] [1002:7480] (rev c7)
>> 00:01.1/00.0/00.0/00.1 Audio device [0403]: Advanced Micro Devices, Inc. 
>> [AMD/ATI] Navi 31 HDMI/DP Audio [1002:ab30]
>> 00:02.1/00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. 
>> RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller [10ec:8168] 
>> (rev 15)
>> 00:02.2/00.0 Network controller [0280]: Intel Corporation Wi-Fi 6E(802.11ax) 
>> AX210/AX1675* 2x2 [Typhoon Peak] [8086:2725] (rev 1a)
>> 00:02.4/00.0 Non-Volatile memory controller [0108]: Samsung Electronics Co 
>> Ltd NVMe SSD Controller SM981/PM981/PM983 [144d:a808]
>> 00:08.1/00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. 
>> [AMD/ATI] Phoenix1 [1002:15bf] (rev c1)
>> 00:08.1/00.1 Audio device [0403]: Advanced Micro Devices, Inc. [AMD/ATI] 
>> Rembrandt Radeon High Definition Audio Controller [1002:1640]
>> 00:08.1/00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] 
>> Phoenix CCP/PSP 3.0 Device [1022:15c7]
>> 00:08.1/00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Device 
>> [1022:15b9]
>> 00:08.1/00.4 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Device 
>> [1022:15ba]
>> 00:08.1/00.5 Multimedia controller [0480]: Advanced Micro Devices, Inc. [AMD] 
>> ACP/ACP3X/ACP6x Audio Coprocessor [1022:15e2] (rev 63)
>> 00:08.1/00.6 Audio device [0403]: Advanced Micro Devices, Inc. [AMD] Family 
>> 17h/19h/1ah HD Audio Controller [1022:15e3]
>> 00:08.2/00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, 
>> Inc. [AMD] Phoenix Dummy Function [1022:14ec]
>> 00:08.2/00.1 Signal processing controller [1180]: Advanced Micro Devices, 
>> Inc. [AMD] AMD IPU Device [1022:1502]
>> 00:08.3/00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, 
>> Inc. [AMD] Phoenix Dummy Function [1022:14ec]
>> 00:08.3/00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Device 
>> [1022:15c0]
>> 00:08.3/00.4 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Device 
>> [1022:15c1]
>> 00:08.3/00.5 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Pink 
>> Sardine USB4/Thunderbolt NHI controller #1 [1022:1668]
>>
>>>
>>> That's why 7d08f21f8c630 intentionally matches the NHI and then changes the 
>>> root port right above that instead of all the root ports - because that is 
>>> where the problem was.
>> For some reason it doesn't seem to trigger on my system (added debug output) 
>> I will look further into it why that happens.
>
> You never see this message in your logs at suspend time (even on a "fixed" BIOS)?
>
> "quirk: disabling D3cold for suspend"
>
> I'm /suspecting/ you do see it, but you're having problems with another root 
> port.
>
> I mentioned this in my previous iterations of patches that eventually landed 
> on that quirk, but Windows and Linux handle root ports differently at suspend 
> time and that could be why it's exposing your BIOS bug.
>
> If you can please narrow down which root ports actually need the quirk for 
> your side (feel free to do a similar style to 7d08f21f8c630) I think we could 
> land on something more narrow and upstreamable.
>
> At a minimum what you're doing today is covering both Rembrandt and Phoenix 
> and it should only apply to Phoenix.
>

