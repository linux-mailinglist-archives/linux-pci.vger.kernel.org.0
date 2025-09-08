Return-Path: <linux-pci+bounces-35700-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBD7B49C63
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 23:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C7483BC0A6
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 21:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5233C2E22BA;
	Mon,  8 Sep 2025 21:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2EcAQI4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB6D2E11CB;
	Mon,  8 Sep 2025 21:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757368280; cv=none; b=onzCjjchmklxFx9JvP7ak2wW3UPsynX3ICiyg4gTxTQash/Yi2SktOpIsqh0FerEug6ZFEnmAoYT8eBzFoaO1f+WzKql+C9R6VdTAdjS52RWumUi7pPvU9FF59zD4kgo+Dqq4ONcclLYEemTD2d1eGA1ugBvWzJhXecvMThzx0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757368280; c=relaxed/simple;
	bh=W8758e9YAd06up1Ixs7nyG1LeD8H6uoYeow7ODyD6Oc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CFWNliGXSWTPmDmtixjdfn6Cbjz7Rd7YmHofqD3runTRWDGLV0MKlQ8JR1kz8c7zFIOkbYEOYuGKlsJfSukkU6aj89/mi6WAc0MqDFrCgXPadoQMWSPNY9+bsIDYG3im0t1RW0HpFXvy2Uww8pv4N4bOWo0YGZAbmO1a2z8Ego0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2EcAQI4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D15C4CEF1;
	Mon,  8 Sep 2025 21:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757368279;
	bh=W8758e9YAd06up1Ixs7nyG1LeD8H6uoYeow7ODyD6Oc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d2EcAQI4KXEVgjerAEUfLsLydRmwA3nSZ4X8z8N+0q5k8MGiIr/VeIwtECZF64r+X
	 Mj8+4jpOkjUOxHizq4jmjeZWrqIUV2MoBwzw8M9xtgQXwUQ/CcsMPo+thChSrqq/l/
	 iV3npnfzqFLd0Mz6VBLJC4tWrzw30KLLOUEb6LU/mmg/OdBBSUUAAp4YiY441TmYd8
	 717UX5ZY2qgqaNGWNbGCTNxB33yGjZDcp8oYXw8abs8FmVxA4NeFbmtRQ+fo7rhb2E
	 OrUrmkmeM+q9qC0eT2ReR6x26yKcWaZ6V0mNaDL5hP1ga3Z85lQIIweUvPWaRnZF19
	 0ic7Totx4haXQ==
Message-ID: <077f4b06-9c54-4289-ab8c-2bf6e29086dc@kernel.org>
Date: Mon, 8 Sep 2025 16:51:15 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/11] PCI: PM: Disable device wakeups when halting
 system through S4 flow
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 "open list:HIBERNATION (aka Software Suspend, aka swsusp)"
 <linux-pm@vger.kernel.org>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 "open list:SCSI SUBSYSTEM" <linux-scsi@vger.kernel.org>,
 "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
 "open list:TRACING" <linux-trace-kernel@vger.kernel.org>,
 AceLan Kao <acelan.kao@canonical.com>, Kai-Heng Feng <kaihengf@nvidia.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 =?UTF-8?Q?Merthan_Karaka=C5=9F?= <m3rthn.k@gmail.com>,
 Eric Naim <dnaim@cachyos.org>
References: <20250908213436.GA1465429@bhelgaas>
Content-Language: en-US
From: "Mario Limonciello (kernel.org)" <superm1@kernel.org>
In-Reply-To: <20250908213436.GA1465429@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/8/2025 4:34 PM, Bjorn Helgaas wrote:
> In subject, s|PCI: PM:|PCI/PM:| to follow previous practice.

👍

> 
> On Sun, Aug 17, 2025 at 09:00:55PM -0500, Mario Limonciello (AMD) wrote:
>> PCI devices can be programmed as a wakeup source from low power states
>> by sysfs.  However when using the S4 flow to go into S5 these wakeup
>> sources should be disabled to avoid what users would perceive as
>> spurious wakeup events.
> 
> Is the "can be programmed vis sysfs" part relevant here?

No, I can drop that part of the sentence.

> 
> I think S4 and S5 are ACPI sleep states not applicable to all
> platforms.  Is it relevant that we got here via ACPI?

But a non-ACPI system would still run the exact same callbacks for 
hibernation wouldn't it?

In general you can 's,S4,hibernation,; s,s5,shutdown,' and it would be 
accurate.
> 
> I assume non-ACPI systems can also exercise this path.  Is there a way
> to describe this scenario in a way that would apply to all systems?
> 
> I'm not sure what "using the S4 flow to go in to S5" means.

It means to run the hibernate related device callbacks instead of the 
shutdown related device callbacks.

I suppose anywhere in the series that is not ACPI specific (besides this 
patch) I should clarify this as well.

> 
> It would be nice to have a spec reference or some sort of rationale
> for the requirement to disable all wakeup sources in SYSTEM_HALT and
> SYSTEM_POWER_OFF.

I didn't observe it in the PCI path, but I did see that in USB that if 
you leave them enabled they stay enabled when the system is shutdown.
For example if a USB mouse was connected and a wakeup source it could 
wakeup from S5 too.

So this patch was aiming for congruence between the two subsystems.

I would hypothesize that means that a dock could wake a system from S5 
on a hotplug event, which I don't believe is intended behavior.

> 
>> Tested-by: Eric Naim <dnaim@cachyos.org>
>> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
>> ---
>> v5:
>>   * Re-order
>>   * Add tags
>> v4:
>>   * https://lore.kernel.org/linux-pci/20250616175019.3471583-1-superm1@kernel.org/
>> ---
>>   drivers/pci/pci-driver.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>> index 63665240ae87f..f201d298d7173 100644
>> --- a/drivers/pci/pci-driver.c
>> +++ b/drivers/pci/pci-driver.c
>> @@ -1139,6 +1139,10 @@ static int pci_pm_poweroff(struct device *dev)
>>   	struct pci_dev *pci_dev = to_pci_dev(dev);
>>   	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>>   
>> +	if (device_may_wakeup(dev) &&
>> +	    (system_state == SYSTEM_HALT || system_state == SYSTEM_POWER_OFF))
>> +		device_set_wakeup_enable(dev, false);
> 
> I guess the suggestion is that we can't wake up at all from
> SYSTEM_HALT or SYSTEM_POWER_OFF?  Would both be considered S5?

Correct.

> 
> Does this mean we need a physical power button push to start up again?
> I guess ACPI r6.5, sec 16.1.5 kind of suggests that: "hardware does
> allow a transition to S0 due to power button press or a Remote Start."

Correct.

> 
>>   	if (pci_has_legacy_pm_support(pci_dev))
>>   		return pci_legacy_suspend(dev, PMSG_HIBERNATE);
>>   
>> -- 
>> 2.43.0
>>


