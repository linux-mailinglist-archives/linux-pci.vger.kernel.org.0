Return-Path: <linux-pci+bounces-18900-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E20119F9105
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 12:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFD58189274A
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 11:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2546376F1;
	Fri, 20 Dec 2024 11:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="beg0W5Zy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8DE2AE96;
	Fri, 20 Dec 2024 11:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734693613; cv=none; b=tCcpcUp8fBTcbV/99OIqYbmIQxQweNN+/UdQ5pWA/DIEBieZGYHl+5QN2CSx2Et0aiQob72hLFzoZy+jRDkl4M6D8Zr9lTYOqTB77llJUk7lyhW0uTJFLA4lcF9wxJF30wIwealQsZqGDsmLUFEOeZFZwyxlOrYMuj4LDb49QL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734693613; c=relaxed/simple;
	bh=YF7EsqMT3El0FHJ5R56AeCPlOUgaWH5OeaF8Uz3o0mQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LTW2sAV4H2C1X/RK1iHn3li+BqPttEuEcRTdis73jnRzvew7ls0vxyFtqauI1KE624uu7hmw7kmyjhq5bNazQ4F70VY59XnRyzdMftzeg/wB4HePN2tjUHdCZE9Pg0jZL8gHfGK8mnNYPHaWkwxfh7eFp4HeLe6zr/084ygNH6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=beg0W5Zy; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.116] (p5de4533f.dip0.t-ipconnect.de [93.228.83.63])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 634C32FC0061;
	Fri, 20 Dec 2024 12:20:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1734693606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3YKtkGRlIukNA4YN0gTb2KxFoKrpzwYrV/CcnwVIFAU=;
	b=beg0W5ZyH/l+M9+S+rpV7jFlYs5TB4Ul2MdDISPPzc8aTcnqNpO18NW5CkVLTXXGtdUiqo
	GH7k65Xy7+E8yFHHsgglDuTIbJ68/e1ezzhfapmCHRm80Hn6pdAEZAGDd6YCcUVdY+cGD1
	igNm1Syk6S+hKGnnlB3J5PLvP9Iuvl8=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <2b5b05e4-5913-45ee-846d-9980e17d4df6@tuxedocomputers.com>
Date: Fri, 20 Dec 2024 12:20:06 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: Avoid putting some root ports into D3 on some
 Ryzen chips
To: Mario Limonciello <mario.limonciello@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241218103433.384027-1-wse@tuxedocomputers.com>
 <85537504-f107-44aa-9b6d-f61eb067b330@amd.com>
 <9487791a-784e-451b-a88c-7c578a6ead2e@tuxedocomputers.com>
 <dfd46eef-1ca3-48ef-b1c2-fa5601e5fd02@tuxedocomputers.com>
 <0ab38bf7-874d-43cb-8236-1f46697df3a5@amd.com>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <0ab38bf7-874d-43cb-8236-1f46697df3a5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Am 19.12.24 um 21:54 schrieb Mario Limonciello:
> On 12/19/2024 14:46, Werner Sembach wrote:
>>
>> Am 18.12.24 um 16:59 schrieb Werner Sembach:
>>>
>>> Am 18.12.24 um 15:06 schrieb Mario Limonciello:
>>>> On 12/18/2024 04:34, Werner Sembach wrote:
>>>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>>>
>>>>> commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend") sets the
>>>>> policy that all PCIe ports are allowed to use D3.  When the system is
>>>>> suspended if the port is not power manageable by the platform and won't be
>>>>> used for wakeup via a PME this sets up the policy for these ports to go
>>>>> into D3hot.
>>>>>
>>>>> This policy generally makes sense from an OSPM perspective but it leads to
>>>>> problems with wakeup from suspend on the TUXEDO Sirius 16 Gen 1 with a
>>>>> specific old BIOS. This manifests as a system hang.
>>>>>
>>>>> On the affected Device + BIOS combination, add a quirk for the PCI device
>>>>> ID used by the problematic root port on to ensure that these root ports are
>>>>> not put into D3hot at suspend.
>>>>>
>>>>> This patch is based on
>>>>> https://lore.kernel.org/linux-pci/20230708214457.1229-2- 
>>>>> mario.limonciello@amd.com/
>>>>> but with the added condition both in the documentation and in the code to
>>>>> apply only to the TUXEDO Sirius 16 Gen 1 with a specific old BIOS.
>>>>>
>>>>> Co-developed-by: Georg Gottleuber <ggo@tuxedocomputers.com>
>>>>> Signed-off-by: Georg Gottleuber <ggo@tuxedocomputers.com>
>>>>> Co-developed-by: Werner Sembach <wse@tuxedocomputers.com>
>>>>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>>>>> Cc: stable@vger.kernel.org # 6.1+
>>>>> Reported-by: Iain Lane <iain@orangesquash.org.uk>
>>>>> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from- 
>>>>> suspend-with-external-USB-keyboard/m-p/5217121
>>>>
>>>> These two tag (Reported-by and Closes) should be stripped because this is 
>>>> now for very different hardware.
>>> Ack will remove in next version
>>>>
>>>>> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>> ---
>>>>>   drivers/pci/quirks.c | 26 ++++++++++++++++++++++++++
>>>>>   1 file changed, 26 insertions(+)
>>>>>
>>>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>>>> index 76f4df75b08a1..68075a6a5283c 100644
>>>>> --- a/drivers/pci/quirks.c
>>>>> +++ b/drivers/pci/quirks.c
>>>>> @@ -3908,6 +3908,32 @@ static void quirk_apple_poweroff_thunderbolt(struct 
>>>>> pci_dev *dev)
>>>>>   DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_INTEL,
>>>>>                      PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C,
>>>>>                      quirk_apple_poweroff_thunderbolt);
>>>>> +
>>>>> +/*
>>>>> + * Putting PCIe root ports on Ryzen SoCs with USB4 controllers into D3hot
>>>>> + * may cause problems when the system attempts wake up from s2idle.
>>>>> + *
>>>>> + * On the TUXEDO Sirius 16 Gen 1 with a specific old BIOS this manifests as
>>>>> + * a system hang.
>>>>> + */
>>>>> +static const struct dmi_system_id quirk_ryzen_rp_d3_dmi_table[] = {
>>>>> +    {
>>>>> +        .matches = {
>>>>> +            DMI_EXACT_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
>>>>> +            DMI_EXACT_MATCH(DMI_BOARD_NAME, "APX958"),
>>>>> +            DMI_EXACT_MATCH(DMI_BIOS_VERSION, "V1.00A00_20240108"),
>>>>> +        },
>>>>> +    },
>>>>> +    {}
>>>>> +};
>>>>> +
>>>>> +static void quirk_ryzen_rp_d3(struct pci_dev *pdev)
>>>>> +{
>>>>> +    if (dmi_check_system(quirk_ryzen_rp_d3_dmi_table) &&
>>>>> +        !acpi_pci_power_manageable(pdev))
>>>>> +        pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
>>>>> +}
>>>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x14eb, quirk_ryzen_rp_d3);
>>>>
>>>> So it needs to be applied to /all/ the root ports PID 0x14eb, not just one 
>>>> of them?
>>> Don't know, I will look into it (I think because of the ! 
>>> acpi_pci_power_manageable(pdev) it is applied to two of the three on the 
>>> device)
>>
>> I tried it like this now:
>>
>> static void quirk_ryzen_rp_d3(struct pci_dev *pdev)
>> {
>>      struct pci_dev *root_pdev;
>>
>>      if (dmi_check_system(quirk_ryzen_rp_d3_dmi_table)) {
>>          root_pdev = pcie_find_root_port(pdev);
>>          if (root_pdev && !acpi_pci_power_manageable(root_pdev))
>>              root_pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
>>      }
>> }
>> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1668, quirk_ryzen_rp_d3);
>> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1669, quirk_ryzen_rp_d3);
>>
>> but that doesn't work.
>
> OK; that means it's more root ports indeed than just the ones above the USB4 
> controllers.

Turns out its just a different root controller and with

DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1502, quirk_ryzen_rp_d3);

instead of

DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1668, quirk_ryzen_rp_d3);
DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1669, quirk_ryzen_rp_d3);

it works.

I will now try the other fix with

DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1502, quirk_ryzen_rp_d3);

>
>>
>>>>
>>>>>   #endif
>>>>>     /*
>>>>
>

