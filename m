Return-Path: <linux-pci+bounces-27288-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1933DAACC43
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 19:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 298E91C40406
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 17:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A88171A1;
	Tue,  6 May 2025 17:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eetZRf5H"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F113B665
	for <linux-pci@vger.kernel.org>; Tue,  6 May 2025 17:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746552769; cv=none; b=QWboHjJw37bFM4nm3yGQuuzklWLMW0LDWeUuHQPqC5vTsgxLIciP7oPuowLyW1UW1os5c0ch1J3/nt9O0WTb69/wNJamvI62yOJFruh+7SVIe1cpDvqIcp97Z25JpHbZpcjJxQKbKkf9UT9iqBCmXfuRxn1AlvyMcA6BGrydILs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746552769; c=relaxed/simple;
	bh=sgoCOCUhMuIf5IyWaEbaE7f2NrBH90vdbq25aHPBvLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YTDfo7ZneMEu1H/ZcynNoPT/e88XwK+YssCGzqFWaR9AbG0PmSNQ9C/7tBDxiCbjhoMZ1k1wPR+NH1P0OEhRFrSa1NRCXRWAxIbSXSw+YZltO0epziQZ3J8oM3yMWbmltWr6uzWhAQzGdda/7n5hABxR+Q/+OcPPmWDOUBTZuXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eetZRf5H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E5CC4CEE4;
	Tue,  6 May 2025 17:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746552769;
	bh=sgoCOCUhMuIf5IyWaEbaE7f2NrBH90vdbq25aHPBvLk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eetZRf5HDWOxt3nNYmq5fgYPE+OuNrW0g/CzGeRE4/I8UgE2atVes6GMsch9d2LqN
	 NtUIsnTS1sB3Y3F9xWxhk/0RUMGxnZJfCEWx4AkoF2AyqfIMJejfu82uNlxaxuuqZa
	 yHl5noRRarfzq/7PN94IWStgiEvWiTcaqHxEeACaMH6+zkrmrBtk7+/8qQcOON/P7/
	 JtIZyilZg7QXIzFVfR3OZLsbvnyPq7wjU+fIx1l2ph1BiekHSjl31vqD6WCo4VvOKZ
	 UDBK5TyAmv7KMh/VTEcn07ZwhVCFRYtzfrYJCe38rgX46q58EeHDgdfiHg6dP4wDvl
	 CJUCyomL2TXQw==
Message-ID: <68fdf9e1-8f27-46a6-a8a2-11ffb84726c9@kernel.org>
Date: Tue, 6 May 2025 12:32:47 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI/PM: Put devices to low power state on shutdown
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Kai-Heng Feng <kaihengf@nvidia.com>
Cc: bhelgaas@google.com, AceLan Kao <acelan.kao@canonical.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Denis Benato <benato.denis96@gmail.com>, =?UTF-8?Q?Merthan_Karaka=C5=9F?=
 <m3rthn.k@gmail.com>, linux-pci@vger.kernel.org
References: <20250506041934.1409302-1-superm1@kernel.org>
 <CAJZ5v0jXYgLsMHyD7EQwAf47=HnU7MCpC7+Th7nnonqV-q2qJQ@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAJZ5v0jXYgLsMHyD7EQwAf47=HnU7MCpC7+Th7nnonqV-q2qJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/6/2025 10:50 AM, Rafael J. Wysocki wrote:
> On Tue, May 6, 2025 at 6:19 AM Mario Limonciello <superm1@kernel.org> wrote:
>>
>> From: Kai-Heng Feng <kaihengf@nvidia.com>
>>
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
>>
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
> 
> That's fine as long as you assume that ->shutdown() is only used for
> implementing ACPI S5, but it is not.

I suppose you're meaning things like:

kernel_restart_prepare()
->device_shutdown()
->->each device's shutdown() CB
->->each driver's shutdown() CB

Is there somewhere "better" to do this so it's truly only tied to S5?

> 
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219036
>> Cc: AceLan Kao <acelan.kao@canonical.com>
>> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
>> Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
>> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> Tested-by: Denis Benato <benato.denis96@gmail.com>
>> Tested-by: Merthan Karakaş <m3rthn.k@gmail.com>
>> Link: https://lore.kernel.org/r/20241208074147.22945-1-kaihengf@nvidia.com
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v3:
>>   * Pick up tags
>>   * V2 was waiting for Rafael to review, rebase on pci/next and resend.
> 
> Is this change going to break kexec?

There is an explicit check in the below code for kexec_in_progress, so 
my expectation was that kexec kept working.  I didn't explicitly test 
this myself when I tested KH's change before sending it again.

KH, Did you double check that on your side?

> 
>> ---
>>   drivers/pci/pci-driver.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>> index 0c5bdb8c2c07b..5bbe8af996390 100644
>> --- a/drivers/pci/pci-driver.c
>> +++ b/drivers/pci/pci-driver.c
>> @@ -510,6 +510,14 @@ static void pci_device_shutdown(struct device *dev)
>>          if (drv && drv->shutdown)
>>                  drv->shutdown(pci_dev);
>>
>> +       /*
>> +        * If driver already changed device's power state, it can mean the
>> +        * wakeup setting is in place, or a workaround is used. Hence keep it
>> +        * as is.
>> +        */
>> +       if (!kexec_in_progress && pci_dev->current_state == PCI_D0)
>> +               pci_prepare_to_sleep(pci_dev);
>> +
>>          /*
>>           * If this is a kexec reboot, turn off Bus Master bit on the
>>           * device to tell it to not continue to do DMA. Don't touch
>> --


