Return-Path: <linux-pci+bounces-18717-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C669F6AA5
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 17:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09E497A5CCA
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 16:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552441F2C52;
	Wed, 18 Dec 2024 16:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="lcxP2NnY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162911B0422;
	Wed, 18 Dec 2024 15:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734537604; cv=none; b=ChLpAxOmy2K++FLA1JeDGYvcTl4evz2uAj5QyT6wBwRgvCVByzwsbizfm5kT0BS0I6ZgvILKJeGPsX4r6ZgVIDBAWlchjF6yjEqiQjhuw7p9VqBuVCNJ3NHATPcVo8Zl8tTHAbGyBZHAcnwZh6cU9DFr/4juxPeEZnrRtiFvPoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734537604; c=relaxed/simple;
	bh=zSDEzurTrixLK4QAI8e0UJ0PnQqoTsxwVqrGhZLTadg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZLk2N4qfkS9YMWdZGqiZHL219oZcUlT/UahV+kPxN+wiqrY1Vy+EBQQ5GEV4wGS4PweL2pnKogY7HOD+EwGteTcHCMQjzhnbdf62DlXS8SaPv/tqQjS0OFtF5QN4PoOOG6yqPQZwQn6FmTnQKMw7ZnWqjqMxXMIsquDi0VsN62M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=lcxP2NnY; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.116] (p5de4533f.dip0.t-ipconnect.de [93.228.83.63])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 748962FC0055;
	Wed, 18 Dec 2024 16:59:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1734537597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZqB6ZFbdNdxtHGL3p7m46qrgjCNBrJgnwNgYe3IrfQQ=;
	b=lcxP2NnYoDutq8PdLeCg2GbmNKHut7oS1HHSYcQabeVYOI4T08mzvvWUaR1HDQfQPmnbc3
	KByrL8jqS8ZghXK+1DYYOVhQEp0V+U1BKfyrQy1ztGx9MjfTNl2jwjLROxoHmeceAVtGYg
	g0CkdClRVDm/w7xSlBWqsP/YzZFW8Iw=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <9487791a-784e-451b-a88c-7c578a6ead2e@tuxedocomputers.com>
Date: Wed, 18 Dec 2024 16:59:56 +0100
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
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <85537504-f107-44aa-9b6d-f61eb067b330@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Am 18.12.24 um 15:06 schrieb Mario Limonciello:
> On 12/18/2024 04:34, Werner Sembach wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend") sets the
>> policy that all PCIe ports are allowed to use D3.  When the system is
>> suspended if the port is not power manageable by the platform and won't be
>> used for wakeup via a PME this sets up the policy for these ports to go
>> into D3hot.
>>
>> This policy generally makes sense from an OSPM perspective but it leads to
>> problems with wakeup from suspend on the TUXEDO Sirius 16 Gen 1 with a
>> specific old BIOS. This manifests as a system hang.
>>
>> On the affected Device + BIOS combination, add a quirk for the PCI device
>> ID used by the problematic root port on to ensure that these root ports are
>> not put into D3hot at suspend.
>>
>> This patch is based on
>> https://lore.kernel.org/linux-pci/20230708214457.1229-2-mario.limonciello@amd.com/ 
>>
>> but with the added condition both in the documentation and in the code to
>> apply only to the TUXEDO Sirius 16 Gen 1 with a specific old BIOS.
>>
>> Co-developed-by: Georg Gottleuber <ggo@tuxedocomputers.com>
>> Signed-off-by: Georg Gottleuber <ggo@tuxedocomputers.com>
>> Co-developed-by: Werner Sembach <wse@tuxedocomputers.com>
>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>> Cc: stable@vger.kernel.org # 6.1+
>> Reported-by: Iain Lane <iain@orangesquash.org.uk>
>> Closes: 
>> https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
>
> These two tag (Reported-by and Closes) should be stripped because this is now 
> for very different hardware.
Ack will remove in next version
>
>> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/pci/quirks.c | 26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 76f4df75b08a1..68075a6a5283c 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -3908,6 +3908,32 @@ static void quirk_apple_poweroff_thunderbolt(struct 
>> pci_dev *dev)
>>   DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_INTEL,
>>                      PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C,
>>                      quirk_apple_poweroff_thunderbolt);
>> +
>> +/*
>> + * Putting PCIe root ports on Ryzen SoCs with USB4 controllers into D3hot
>> + * may cause problems when the system attempts wake up from s2idle.
>> + *
>> + * On the TUXEDO Sirius 16 Gen 1 with a specific old BIOS this manifests as
>> + * a system hang.
>> + */
>> +static const struct dmi_system_id quirk_ryzen_rp_d3_dmi_table[] = {
>> +    {
>> +        .matches = {
>> +            DMI_EXACT_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
>> +            DMI_EXACT_MATCH(DMI_BOARD_NAME, "APX958"),
>> +            DMI_EXACT_MATCH(DMI_BIOS_VERSION, "V1.00A00_20240108"),
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
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x14eb, quirk_ryzen_rp_d3);
>
> So it needs to be applied to /all/ the root ports PID 0x14eb, not just one of 
> them?
Don't know, I will look into it (I think because of the 
!acpi_pci_power_manageable(pdev) it is applied to two of the three on the device)
>
>>   #endif
>>     /*
>

