Return-Path: <linux-pci+bounces-18033-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EAE9EB4BE
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 16:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BF012859A6
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 15:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71DC1B86DC;
	Tue, 10 Dec 2024 15:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="fLmO+WP+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8B91BAEDC;
	Tue, 10 Dec 2024 15:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733844282; cv=none; b=ncdWXykV5QzARz0/n+y6vzQqu1jlOcg9iQiuFxbRdeDZ5vw8HZpA4TOw2LP+IkaNDgj/93qKUIsRL7T6ndcPk0jfwPWmuDanZS8t2WMLaWB1NeXH4LP8VOTZa/vkkO3Cs9dFHQcCbOFGe8UNhL93TP8HVBSDa9v9sRdxaGUHW+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733844282; c=relaxed/simple;
	bh=/BVYgvICudEhAwFQSU+Phi5FXVop6n7H/2wXdatDDWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ivl3h1/0VnGUxa7CcUp7yqDgPdceJfk3GWuD81beNOvrH6f6BxuIX3+DkCL4QQpuDa+RYsPCpXD37bpWYEAIV9Hwga6o58A9x4k6uuqFc8gTQB256cG6dIwRFsJrjNV5ty8LKMuXdmikrem/FkVuyt5Q01/TQPWSEEk/G6I5YQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=fLmO+WP+; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.115] (p5de4533f.dip0.t-ipconnect.de [93.228.83.63])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id CD4442FC0048;
	Tue, 10 Dec 2024 16:24:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1733844276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zsr0X6xg978gSx8RmYSoz7J5LABxKxLrDZ/nRgBOiCQ=;
	b=fLmO+WP+ZNdCns6CfqIRm1C7DBUn8IeoCu9jVtP66tF25baScIQDASe7JtesXwvGXuTiE4
	0I1YCjUirdXJtbjh0Tu6xqgOse+1f/u1wwvRsIqYrIolhkqOyHuqz/6Tqc+R0dA79gxEaS
	Z/AoUotTBPRrZN9rMhtBSoGXRzxz52k=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <23c6140b-946e-4c63-bba4-a7be77211948@tuxedocomputers.com>
Date: Tue, 10 Dec 2024 16:24:35 +0100
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
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <215cd12e-6327-4aa6-ac93-eac2388e7dab@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Am 09.12.24 um 20:45 schrieb Mario Limonciello:
> On 12/9/2024 13:36, Werner Sembach wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>> sets the policy that all PCIe ports are allowed to use D3.  When
>> the system is suspended if the port is not power manageable by the
>> platform and won't be used for wakeup via a PME this sets up the
>> policy for these ports to go into D3hot.
>>
>> This policy generally makes sense from an OSPM perspective but it leads
>> to problems with wakeup from suspend on the TUXEDO Sirius 16 Gen 1 with
>> an unupdated BIOS.
>>
>> - On family 19h model 44h (PCI 0x14b9) this manifests as a missing wakeup
>>    interrupt.
>> - On family 19h model 74h (PCI 0x14eb) this manifests as a system hang.
>>
>> On the affected Device + BIOS combination, add a quirk for the PCI device
>> ID used by the problematic root port on both chips to ensure that these
>> root ports are not put into D3hot at suspend.
>>
>> This patch is based on
>> https://lore.kernel.org/linux-pci/20230708214457.1229-2-mario.limonciello@amd.com/ 
>>
>> but with the added condition both in the documentation and in the code to
>> apply only to the TUXEDO Sirius 16 Gen 1 with the original unpatched BIOS.
>>
>> Co-developed-by: Georg Gottleuber <ggo@tuxedocomputers.com>
>> Signed-off-by: Georg Gottleuber <ggo@tuxedocomputers.com>
>> Co-developed-by: Werner Sembach <wse@tuxedocomputers.com>
>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>> Cc: stable@vger.kernel.org # 6.1+
>> Reported-by: Iain Lane <iain@orangesquash.org.uk>
>> Closes: 
>> https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
>> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/pci/quirks.c | 31 +++++++++++++++++++++++++++++++
>>   1 file changed, 31 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 76f4df75b08a1..2226dca56197d 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -3908,6 +3908,37 @@ static void quirk_apple_poweroff_thunderbolt(struct 
>> pci_dev *dev)
>>   DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_INTEL,
>>                      PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C,
>>                      quirk_apple_poweroff_thunderbolt);
>> +
>> +/*
>> + * Putting PCIe root ports on Ryzen SoCs with USB4 controllers into D3hot
>> + * may cause problems when the system attempts wake up from s2idle.
>> + *
>> + * On family 19h model 44h (PCI 0x14b9) this manifests as a missing wakeup
>> + * interrupt.
>> + * On family 19h model 74h (PCI 0x14eb) this manifests as a system hang.
>> + *
>> + * This fix is still required on the TUXEDO Sirius 16 Gen1 with the original
>> + * unupdated BIOS.
>> + */
>> +static const struct dmi_system_id quirk_ryzen_rp_d3_dmi_table[] = {
>> +    {
>> +        .matches = {
>> +            DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
>> +            DMI_MATCH(DMI_BOARD_NAME, "APX958"),
>> +            DMI_MATCH(DMI_BIOS_VERSION, "V1.00A00"),
>> +        },
>> +    },
>> +    {}
>> +};
>> +
>> +static void quirk_ryzen_rp_d3(struct pci_dev *pdev)
>> +{
>> +    if (dmi_check_system(quirk_ryzen_rp_d3_dmi_table) &&
>> +        !acpi_pci_power_manageable(pdev))
>> +        pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
>> +}
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x14b9, quirk_ryzen_rp_d3);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x14eb, quirk_ryzen_rp_d3);
>>   #endif
>>     /*
>
> Wait, what is wrong with:
>
> commit 7d08f21f8c630 ("x86/PCI: Avoid PME from D3hot/D3cold for AMD Rembrandt 
> and Phoenix USB4")
>
> Is that not activating on your system for some reason?

Doesn't seem so, tested with the old BIOS and 6.13-rc2 and had blackscreen on 
wakeup.

With a newer BIOS for that device suspend and resume however works.

Looking in the patch the device id's are different (0x162e, 0x162f, 0x1668, and 
0x1669).


