Return-Path: <linux-pci+bounces-19638-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB32A09926
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2025 19:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFF1F188C46A
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2025 18:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80BF21323A;
	Fri, 10 Jan 2025 18:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="Xn+vmo0Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5371E25E3;
	Fri, 10 Jan 2025 18:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736532958; cv=none; b=IR9JPtuOjoxMk0r7RjDgDMjmGz4cgy/iRSLZY/R4ntNwqKSfXIEKqrKLRHBPoLEga8A4JvYaSXxmGUpXwwl1/Dx2XF52OyJvgU93mYAZD/RBNIqIKegLv6OoxqbHRSoQGiy6Ywxs3ZHSyfcyETyTghhx+JkPLzB1dWGh9i9KRk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736532958; c=relaxed/simple;
	bh=DnrV+q0iaYcIfoksUP7dfAeDZNaP55N+uw951IzTRY0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IP7f6vS/D+9jPpmJZOYmENEwsPqDRmMFwpoZ5opnE21ovuluK2F3xF6de8VRnF8OtG5oAwwCsgPR4lR1CBgkOj9TtDlscvcKCTbxhoTXY0hAa5cUOEzMjvS6OLq+c5fp3qlwSdwTZ5Lcz0YGzokivEHFRDlXztqiuP84mxu5/OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=Xn+vmo0Y; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.116] (pd9e5946e.dip0.t-ipconnect.de [217.229.148.110])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 0384C2FC007B;
	Fri, 10 Jan 2025 19:15:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1736532952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3JNMahitkaE5Klc8v27CqOyCA4F6FU17OIHXQ2172Gk=;
	b=Xn+vmo0Y8lZTruVTa3Sk3io8JAkKkofqoGLVLZazq3ggXu23ETpS5MKohhddU5MKbWiiJZ
	Pz92ZUijnW1USTroYdFWRcTu9nx42ivkAKDR4JPCyZyTMjMCGt/tNlRgOqZ7YwhvsAgDOK
	dnbHXTYcC0HwIMemnPjaY3CoC0F6Mko=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <a769622e-9e5b-4ad8-9474-5c5f935270b2@tuxedocomputers.com>
Date: Fri, 10 Jan 2025 19:15:51 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] PCI: Avoid putting some root ports into D3 on TUXEDO
 Sirius Gen1
From: Werner Sembach <wse@tuxedocomputers.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241220113618.779699-1-wse@tuxedocomputers.com>
 <959c10ce-9f84-4dd5-8506-9d094f0d6762@amd.com>
 <8b28076c-7273-429e-97a9-05a8c670f171@tuxedocomputers.com>
Content-Language: en-US
In-Reply-To: <8b28076c-7273-429e-97a9-05a8c670f171@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Am 10.01.25 um 18:15 schrieb Werner Sembach:
>
> Am 08.01.25 um 22:26 schrieb Mario Limonciello:
>> On 12/20/2024 05:35, Werner Sembach wrote:
>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>
>>> commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend") sets the
>>> policy that all PCIe ports are allowed to use D3.  When the system is
>>> suspended if the port is not power manageable by the platform and won't be
>>> used for wakeup via a PME this sets up the policy for these ports to go
>>> into D3hot.
>>>
>>> This policy generally makes sense from an OSPM perspective but it leads to
>>> problems with wakeup from suspend on the TUXEDO Sirius 16 Gen 1 with a
>>> specific old BIOS. This manifests as a system hang.
>>>
>>> On the affected Device + BIOS combination, add a quirk for the root port of
>>> the problematic controller to ensure that these root ports are not put into
>>> D3hot at suspend.
>>>
>>> This patch is based on
>>> https://lore.kernel.org/linux-pci/20230708214457.1229-2-mario.limonciello@amd.com/ 
>>>
>>> but with the added condition both in the documentation and in the code to
>>> apply only to the TUXEDO Sirius 16 Gen 1 with a specific old BIOS and only
>>> the affected root ports.
>>>
>>> Co-developed-by: Georg Gottleuber <ggo@tuxedocomputers.com>
>>> Signed-off-by: Georg Gottleuber <ggo@tuxedocomputers.com>
>>> Co-developed-by: Werner Sembach <wse@tuxedocomputers.com>
>>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>>> Cc: stable@vger.kernel.org # 6.1+
>>> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>
>> So I don't think this should have my S-o-b.  At most it should Suggested-by: 
>> or Co-developed-by: since it was based on my original patch.
> kk
>>
>>> ---
>>>   drivers/pci/quirks.c | 30 ++++++++++++++++++++++++++++++
>>
>> I think a better location for this is arch/x86/pci/fixup.c, similar to how we 
>> have https://git.kernel.org/torvalds/c/7d08f21f8c630
>>
>> thoughts?
>
> Fine with me
>
> I will make a v5
In fixup.c i don't have access to acpi_pci_power_manageable, but since 
DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1502, quirk_ryzen_rp_d3); matches 
to only one device anyways can i just skip it?
>
>>
>>>   1 file changed, 30 insertions(+)
>>>
>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>> index 76f4df75b08a1..d2f45c3e24c0a 100644
>>> --- a/drivers/pci/quirks.c
>>> +++ b/drivers/pci/quirks.c
>>
>>> @@ -3908,6 +3908,36 @@ static void quirk_apple_poweroff_thunderbolt(struct 
>>> pci_dev *dev)
>>>   DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_INTEL,
>>>                      PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C,
>>>                      quirk_apple_poweroff_thunderbolt);
>>> +
>>> +/*
>>> + * Putting PCIe root ports on Ryzen SoCs with USB4 controllers into D3hot
>>> + * may cause problems when the system attempts wake up from s2idle.
>>> + *
>>> + * On the TUXEDO Sirius 16 Gen 1 with a specific old BIOS this manifests as
>>> + * a system hang.
>>> + */
>>> +static const struct dmi_system_id quirk_ryzen_rp_d3_dmi_table[] = {
>>> +    {
>>> +        .matches = {
>>> +            DMI_EXACT_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
>>> +            DMI_EXACT_MATCH(DMI_BOARD_NAME, "APX958"),
>>> +            DMI_EXACT_MATCH(DMI_BIOS_VERSION, "V1.00A00_20240108"),
>>> +        },
>>> +    },
>>> +    {}
>>> +};
>>> +
>>> +static void quirk_ryzen_rp_d3(struct pci_dev *pdev)
>>> +{
>>> +    struct pci_dev *root_pdev;
>>> +
>>> +    if (dmi_check_system(quirk_ryzen_rp_d3_dmi_table)) {
>>> +        root_pdev = pcie_find_root_port(pdev);
>>> +        if (root_pdev && !acpi_pci_power_manageable(root_pdev))
>>> +            root_pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
>>> +    }
>>> +}
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1502, quirk_ryzen_rp_d3);
>>>   #endif
>>>     /*
>>

