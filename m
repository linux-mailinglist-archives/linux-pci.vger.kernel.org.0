Return-Path: <linux-pci+bounces-26409-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BABA97063
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 17:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 817733A8EFA
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 15:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1FE290083;
	Tue, 22 Apr 2025 15:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDJaqasw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9F428FFFC;
	Tue, 22 Apr 2025 15:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745335128; cv=none; b=K14quZ/j2Wmyj9uphPahoBCTIOlF76g0Jp5lhiz0I12dXq/E7mJS1U7yaYNclT52odPxapc0hURgd5XY4EkoubxW8dTrJioPUcGx/UDdSUNnqJ8iVHOE7idFUZsjVq94EezChpVY/u558vXWrjkp51aXeKN4+NZfbESmqz3qgcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745335128; c=relaxed/simple;
	bh=+uhI1MTtLQzUsupFZmaVIdMRmJvOYO+hWinoKLHSAeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QKL2NTOsbMJxWq9KtP5YvLqU0XulOOR8UIy6mF+viuBW7dTR/jkdAwXxB0U5dv4Sl1BySROdgHPVfBCmafBcwEtodzYN5qGzONnyPOYXVJF5pkJD7hY/Af2NTFwOrZONrplDdadLb1SMjOqnYLyiDM4yeozD1cb9PtKK3Kk6BWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDJaqasw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6987BC4CEE9;
	Tue, 22 Apr 2025 15:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745335128;
	bh=+uhI1MTtLQzUsupFZmaVIdMRmJvOYO+hWinoKLHSAeA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZDJaqaswFOATzSYmTY2+jeJM/TttKiNAJn6XqM0j3B7HFP3TwLdaCN9qEjI/IAA5X
	 o6SYxbwNyvBdxf5dRJzCqt271rMfPNpscR+uvD0YR2mCsI4vSJNsJzNNZRtaXzxTuZ
	 eosrxUii2do1MWy2bsgdCh4tnPQDeyqmmgBG5Br4OGp65HWbA7oL6OM+MxdR75o5V3
	 54VqkKw5LEE+KOAODmC48nn+OkTDzN3QzCaSU8Ey9g6vlzkyl5xVoyp4p+lYAYc2qx
	 cXkEa/UDdhhFKnXEszdJpPquMghOP94SQHwItQUqVjO+SrsdVLwZ49KegctBkOEh0c
	 t/fFDdTiIva/w==
Message-ID: <f95750db-a857-4ba3-9c2d-c48caa9ff16e@kernel.org>
Date: Tue, 22 Apr 2025 10:18:46 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI/PM: Put devices to low power state on shutdown'
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: bhelgaas@google.com, mika.westerberg@linux.intel.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 AceLan Kao <acelan.kao@canonical.com>, linux-pm@vger.kernel.org,
 Kai-Heng Feng <kaihengf@nvidia.com>, Bjorn Helgaas <helgaas@kernel.org>
References: <20250219184646.GA226882@bhelgaas>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20250219184646.GA226882@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/2025 12:46 PM, Bjorn Helgaas wrote:
> [+to Rafael, +cc linux-pm]
> 
> On Sun, Dec 08, 2024 at 03:41:47PM +0800, Kai-Heng Feng wrote:
>> Some laptops wake up after poweroff when HP Thunderbolt Dock G4 is
>> connected.
>>
>> The following error message can be found during shutdown:
>> pcieport 0000:00:1d.0: AER: Correctable error message received from 0000:09:04.0
>> pcieport 0000:09:04.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
>> pcieport 0000:09:04.0:   device [8086:0b26] error status/mask=00000080/00002000
>> pcieport 0000:09:04.0:    [ 7] BadDLLP
>>
>> Calling aer_remove() during shutdown can quiesce the error message,
>> however the spurious wakeup still happens.
> 
> aer_remove() disables AER interrupts, so I guess there must be a
> non-AER interrupt being generated during shutdown?
> 
> If so, AER is a red herring and including the AER details above is a
> distraction from whatever the real interrupt cause is.
> 
>> The issue won't happen if the device is in D3 before system shutdown, so
>> putting device to low power state before shutdown to solve the issue.
>>
>> ACPI Spec 6.5, "7.4.2.5 System \_S4 State" says "Devices states are
>> compatible with the current Power Resource states. In other words, all
>> devices are in the D3 state when the system state is S4."
>>
>> The following "7.4.2.6 System \_S5 State (Soft Off)" states "The S5
>> state is similar to the S4 state except that OSPM does not save any
>> context." so it's safe to assume devices should be at D3 for S5.
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219036
>> Cc: AceLan Kao <acelan.kao@canonical.com>
>> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
>> Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
>> ---
>>   drivers/pci/pci-driver.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>> index 35270172c833..248e0c9fd161 100644
>> --- a/drivers/pci/pci-driver.c
>> +++ b/drivers/pci/pci-driver.c
>> @@ -510,6 +510,14 @@ static void pci_device_shutdown(struct device *dev)
>>   	if (drv && drv->shutdown)
>>   		drv->shutdown(pci_dev);
>>   
>> +	/*
>> +	 * If driver already changed device's power state, it can mean the
>> +	 * wakeup setting is in place, or a workaround is used. Hence keep it
>> +	 * as is.
>> +	 */
>> +	if (!kexec_in_progress && pci_dev->current_state == PCI_D0)
>> +		pci_prepare_to_sleep(pci_dev);
> 
> 
> I don't know enough to draw inferences about PCI_D0 meaning a wakeup
> setting is in place or a workaround being used.  That doesn't seem
> like enough to be useful for me to maintain this in the future.  But
> my power management understanding is pretty meager.
> 
> Would like an ack from Rafael for this.

Rafael,

Can you take a look at this patch and provide your thoughts?

Thanks!
> 
>>   	/*
>>   	 * If this is a kexec reboot, turn off Bus Master bit on the
>>   	 * device to tell it to not continue to do DMA. Don't touch
>> -- 
>> 2.47.0
>>
> 


