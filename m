Return-Path: <linux-pci+bounces-21789-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C45A3B033
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 04:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21B1B172294
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 03:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC4B189F3B;
	Wed, 19 Feb 2025 03:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/tE3AWb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C38A8C0B;
	Wed, 19 Feb 2025 03:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739937405; cv=none; b=Bx/QcU7bbMAHuDExlnoZQoV5KThAJ1QthdRHx9Ns10lvFFBucguIT3ZctogCnRy/adXnT7u7zJqIjA6UR3CvTfl+YfCzmEgfUislbQVFAi7xCTOi66hn6EH5ZXTwqk770bgPPvhpwWRcbJgyaOW6Dv5dOVOgRM0VA3nmjeAyAzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739937405; c=relaxed/simple;
	bh=i5IcOWQi0O8bxInU7mflve6qdpwNp+GrKXSYxYEM57s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sbRuZhdEtDnU3GpmcCFtZ/x0In1wG9HjrRr20yovqw21wxrddw1YuwNQrBjfeh76mLKpIlyj0qQB4qGH806s0aLf/FGPF7o0JesqzEFTLg6tQU9UA/cffUzUqUgFLL5JLK6Kv3V4Dfl445PoVlcbfm3yTtxY3wHHpFrOKfKuN8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/tE3AWb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA144C4CED1;
	Wed, 19 Feb 2025 03:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739937404;
	bh=i5IcOWQi0O8bxInU7mflve6qdpwNp+GrKXSYxYEM57s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=s/tE3AWbM5GT5p2/ZuZ4WwfbyXzJSizCAvKFCbsipvVELsg1r9AvXkg/D6KpdLMeT
	 846n4D5dBMkjtmZMQ7WY8bMF4mR3gbYz0DMgq4JKdecEjbc3DNuhA/ewAlOGMsdRpk
	 PWh27OuBkU9mePxAVgJt3UFtF6sKq2x558kpYWGioYane6f+bXb99Zj7+NCP6sZLJG
	 5C68y9dIV9OH37lpVvCrtCmg6icG4PB5eApB+9ABZMbmFmTWWh1Sx55jd712vQmIxP
	 bzBG2cq72fWsSctK3AJMfkJFNvcX2lNLpI10w/1KuUKoIzw+gnIJGFI54V+JRRkYD4
	 d6aBQhyjPx9UA==
Message-ID: <d914e3c5-f38c-4e2f-b46b-8edb1e8940d1@kernel.org>
Date: Tue, 18 Feb 2025 21:56:42 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI/PM: Put devices to low power state on shutdown
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 AceLan Kao <acelan.kao@canonical.com>,
 "Limonciello, Mario" <mario.limonciello@amd.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>, Kai-Heng Feng
 <kaihengf@nvidia.com>, mika.westerberg@linux.intel.com
References: <20241208074147.22945-1-kaihengf@nvidia.com>
 <69ddda46-62cc-445f-a1ef-f4651ec0b138@app.fastmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <69ddda46-62cc-445f-a1ef-f4651ec0b138@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/17/25 14:31, Mark Pearson wrote:
> Hi,
> 
> On Sun, Dec 8, 2024, at 2:41 AM, Kai-Heng Feng wrote:
>> Some laptops wake up after poweroff when HP Thunderbolt Dock G4 is
>> connected.
>>
>> The following error message can be found during shutdown:
>> pcieport 0000:00:1d.0: AER: Correctable error message received from
>> 0000:09:04.0
>> pcieport 0000:09:04.0: PCIe Bus Error: severity=Correctable, type=Data
>> Link Layer, (Receiver ID)
>> pcieport 0000:09:04.0:   device [8086:0b26] error
>> status/mask=00000080/00002000
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
>> +
>>   	/*
>>   	 * If this is a kexec reboot, turn off Bus Master bit on the
>>   	 * device to tell it to not continue to do DMA. Don't touch
>> -- 
>> 2.47.0
> 
> Just a note that we've tested this in the Lenovo Linux team and confirmed that it reduces the power draw on a powered off Z16 G2 by 0.6W.
> This is enough to bring Linux inline with Windows, and more importantly allow the platform to pass e-star energy certification (which it otherwise fails). We suspect other platforms will show similar benefits.
> 
> Let me know if there's anything we can do to help get this patch moving along - I think it's important.
> 
> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> 
> Mark
> 

Bjorn,

Anything else that you would like to see for this patch?
Or different direction you would like to see it go?

Thanks,

