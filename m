Return-Path: <linux-pci+bounces-32462-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42567B096CE
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 00:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8AD41621F9
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 22:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2535023D2A9;
	Thu, 17 Jul 2025 22:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pj67LuAv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F2921ABAE;
	Thu, 17 Jul 2025 22:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752790077; cv=none; b=tTvRx62HQDPPHANFHYZbWQdjtQGcFo+yQCdRckdBf0Dl4U5caLMFDlg2z/L5XEX6vp8BK2NGpjBRJfqjm3kc6Rd/hYOApZSFu1Hwu/YppRjNJ1lTwNZ5mJXvaTHR8L0ZQUG1JiTfD6ES4J3pnyMHgARA0+RtH2GtRZv+P0BdClU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752790077; c=relaxed/simple;
	bh=wxmKwPKt7YyQmzgS73wPh50IyTeU3Q6Z662k+mZTHlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SXsooZhGdjll1NQzMuKOm6wvhfzrOFalP8OTdaEJgsZaXgaPrpTyiTglt9FYQdFy/3+bBXeLpTguKAosYOvx8Eltvp59MCj06OzxCcJFx6wi4tCCRjb368z9U8wU3vJjUamRhRU0OyWFnA9SXNJLiIrivcpPMe906/aaaUQpK3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pj67LuAv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973C7C4CEF0;
	Thu, 17 Jul 2025 22:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752790076;
	bh=wxmKwPKt7YyQmzgS73wPh50IyTeU3Q6Z662k+mZTHlI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pj67LuAvbhO/LsN35JLWQH8WJJbM2lzKV7WxJ2BCMGTDB/JnIi2hBhtCGCD0dOfCe
	 gfMRu6YUZcqxGdJO86FB+uxQkxSMMZuLHN+eZUpz4zHwizQ+ufTHKCjUuqcyqof76k
	 6bp0IW8biQW3EbAZIZoHK4Pqj8d8gndWJ+cIjDkHrqRlwEzlCL3h66EP80+B5uYPEa
	 rbZsRj3EU8jE3DiIGiUFbRriCDS55zAJ60Q0F2syaRV0KRl/hAHaEgWx+SBBotQpZP
	 cxLfemnHbhGdqOVjp7FoBoqgcGC28XVJlXPsgEQpfTN6werBRFmj/ts8Zo7vjpKgPk
	 fChFOeVYBXO0Q==
Message-ID: <446a24c4-7667-4f2f-9751-80888746ca90@kernel.org>
Date: Thu, 17 Jul 2025 17:07:53 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] PCI: Put PCIe ports with downstream devices into
 D3 at hibernate
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, Bjorn Helgaas
 <bhelgaas@google.com>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 "open list:HIBERNATION (aka Software Suspend, aka swsusp)"
 <linux-pm@vger.kernel.org>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 "open list:SCSI SUBSYSTEM" <linux-scsi@vger.kernel.org>,
 "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 AceLan Kao <acelan.kao@canonical.com>, Kai-Heng Feng <kaihengf@nvidia.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Denis Benato <benato.denis96@gmail.com>, =?UTF-8?Q?Merthan_Karaka=C5=9F?=
 <m3rthn.k@gmail.com>
References: <20250717215552.GA2655127@bhelgaas>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20250717215552.GA2655127@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks for looking.

On 7/17/25 4:55 PM, Bjorn Helgaas wrote:
> On Mon, Jun 16, 2025 at 12:50:16PM -0500, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> For the suspend flow PCIe ports that have downstream devices are put into
>> the appropriate D3 state when children are not in D0. For the hibernate
>> flow, PCIe ports with downstream devices stay in D0 however. This can
>> lead to PCIe ports that are remained powered on needlessly during
>> hibernate.
> 
> I suppose by "appropriate D3 state", you mean the Port is put in
> D3cold if all children are in D3cold, or D3hot if they are all in
> D1-D3hot?  PM-illiterate folks like me need some help to know what is
> "appropriate" :)

Yeah I was avoiding typing that all out; but I'll add the extra detail 
in the next spin.

> 
> This refers specifically to "PCIe ports", but it looks like the code
> applies to PCI bridges in general, so maybe it should just say
> "bridges"?

Yeah it applies to bridges in general, will reword.

> 
> s/ports that are remained powered on/ports that remain powered on/
> (or "bridges that remain powered on")
> 
👍

>> Adjust the pci_pm_poweroff_noirq() to follow the same flow as
>> pci_pm_suspend_noirq() in that PCIe ports that are power manageable should
>> without downstream devices in D0 should be put into their appropriate
>> sleep state.
> 
> Extra "should" in this sentence, I guess?
> (s/power manageable should/power manageable/)
> 
> Also "PCIe ports" here, maybe should be "bridges"?

👍

> 
>> Cc: AceLan Kao <acelan.kao@canonical.com>
>> Cc: Kai-Heng Feng <kaihengf@nvidia.com>
>> Cc: Mark Pearson <mpearson-lenovo@squebb.ca>
>> Cc: Denis Benato <benato.denis96@gmail.com>
>> Cc: Merthan Karakaş <m3rthn.k@gmail.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v4:
>>   * Use helper even when CONFIG_SUSPEND not set (LKP robot)
>> v3:
>>   * Split out common code between suspend_noirq() and poweroff_noirq()
>>     to a helper function
>>   * https://lore.kernel.org/linux-pm/20250609024619.407257-1-superm1@kernel.org/T/#me6db0fb946e3d604a8f3d455128844ed802c82bb
>> ---
>>   drivers/pci/pci-driver.c | 94 ++++++++++++++++++++++++++--------------
>>   1 file changed, 61 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>> index 0d4c67829958b..f7a0c23515718 100644
>> --- a/drivers/pci/pci-driver.c
>> +++ b/drivers/pci/pci-driver.c
>> @@ -759,6 +759,56 @@ static void pci_pm_complete(struct device *dev)
>>   
>>   #endif /* !CONFIG_PM_SLEEP */
>>   
>> +#if defined(CONFIG_SUSPEND) || defined(CONFIG_HIBERNATE_CALLBACKS)
>> +/**
>> + * pci_pm_set_prepare_bus_pm
>> + * @pci_dev: pci device
>> + *
>> + * Prepare the device to go into a low power state by saving state
>> + * and configure bus PM policy.
> 
> I guess "configure bus PM policy" must mean "if this device is in D0,
> set skip_bus_pm = true for the device and any upstream bridge so we
> won't change their power state"?
> 
>> + * Return: TRUE for bus PM will be used
>> + *         FALSE for bus PM will be skipped
>> + */
>> +static bool pci_pm_set_prepare_bus_pm(struct pci_dev *pci_dev)
> 
> The "pci_pm_set_prepare_bus_pm" name doesn't immediately suggest a
> property that can be true or false.  It complicates things a bit when
> a bool function has side effects in addition to giving a yes/no or
> true/false answer.  Not sure whether or how this could be improved.

Yeah it's an unfortunate side effect of the refactor.  I'll look through 
it once again and see if I can find a more logical way to do it.

> 
> And it's a little confusing that we return false when we set
> skip_bus_pm = true (mostly).  It's tough to keep track of what
> true/false means.

How about if it was:

static void pci_pm_prepare_bus_pm(struct pci_dev *pci_dev, bool *skip);

> 
>> +{
>> +	if (!pci_dev->state_saved) {
>> +		pci_save_state(pci_dev);
>> +
>> +		/*
>> +		 * If the device is a bridge with a child in D0 below it,
>> +		 * it needs to stay in D0, so check skip_bus_pm to avoid
>> +		 * putting it into a low-power state in that case.
>> +		 */
>> +		if (!pci_dev->skip_bus_pm && pci_power_manageable(pci_dev))
>> +			pci_prepare_to_sleep(pci_dev);
>> +	}
>> +
>> +	pci_dbg(pci_dev, "PCI PM: Sleep power state: %s\n",
>> +		pci_power_name(pci_dev->current_state));
>> +
>> +	if (pci_dev->current_state == PCI_D0) {
>> +		pci_dev->skip_bus_pm = true;
>> +		/*
>> +		 * Per PCI PM r1.2, table 6-1, a bridge must be in D0 if any
>> +		 * downstream device is in D0, so avoid changing the power state
>> +		 * of the parent bridge by setting the skip_bus_pm flag for it.
>> +		 */
>> +		if (pci_dev->bus->self)
>> +			pci_dev->bus->self->skip_bus_pm = true;
>> +	}
>> +
>> +	if (pci_dev->skip_bus_pm && pm_suspend_no_platform()) {
>> +		pci_dbg(pci_dev, "PCI PM: Skipped\n");
>> +		return FALSE;
>> +	}
>> +
>> +	pci_pm_set_unknown_state(pci_dev);
>> +
>> +	return TRUE;
> 
> "true" and "false" instead of "TRUE" and "FALSE".
> 

👍

>> +}
>> +#endif /* CONFIG_SUSPEND || CONFIG_HIBERNATE_CALLBACKS */
>> +
>>   #ifdef CONFIG_SUSPEND
>>   static void pcie_pme_root_status_cleanup(struct pci_dev *pci_dev)
>>   {
>> @@ -878,38 +928,8 @@ static int pci_pm_suspend_noirq(struct device *dev)
>>   		}
>>   	}
>>   
>> -	if (!pci_dev->state_saved) {
>> -		pci_save_state(pci_dev);
>> -
>> -		/*
>> -		 * If the device is a bridge with a child in D0 below it,
>> -		 * it needs to stay in D0, so check skip_bus_pm to avoid
>> -		 * putting it into a low-power state in that case.
>> -		 */
>> -		if (!pci_dev->skip_bus_pm && pci_power_manageable(pci_dev))
>> -			pci_prepare_to_sleep(pci_dev);
>> -	}
>> -
>> -	pci_dbg(pci_dev, "PCI PM: Suspend power state: %s\n",
>> -		pci_power_name(pci_dev->current_state));
>> -
>> -	if (pci_dev->current_state == PCI_D0) {
>> -		pci_dev->skip_bus_pm = true;
>> -		/*
>> -		 * Per PCI PM r1.2, table 6-1, a bridge must be in D0 if any
>> -		 * downstream device is in D0, so avoid changing the power state
>> -		 * of the parent bridge by setting the skip_bus_pm flag for it.
>> -		 */
>> -		if (pci_dev->bus->self)
>> -			pci_dev->bus->self->skip_bus_pm = true;
>> -	}
>> -
>> -	if (pci_dev->skip_bus_pm && pm_suspend_no_platform()) {
>> -		pci_dbg(pci_dev, "PCI PM: Skipped\n");
>> +	if (!pci_pm_set_prepare_bus_pm(pci_dev))
>>   		goto Fixup;
>> -	}
>> -
>> -	pci_pm_set_unknown_state(pci_dev);
> 
> This part looks like it's mostly factoring this code out to
> pci_pm_set_prepare_bus_pm().  Would it be practical to split that
> factoring to a patch that makes no functional change?  I'm wondering
> if that would make the functional change smaller and easier to
> understand.

Yeah I think you're right.  I'll try to split it in two patches.

> 
>>   	/*
>>   	 * Some BIOSes from ASUS have a bug: If a USB EHCI host controller's
>> @@ -1136,6 +1156,8 @@ static int pci_pm_poweroff(struct device *dev)
>>   	struct pci_dev *pci_dev = to_pci_dev(dev);
>>   	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>>   
>> +	pci_dev->skip_bus_pm = false;
>> +
>>   	if (pci_has_legacy_pm_support(pci_dev))
>>   		return pci_legacy_suspend(dev, PMSG_HIBERNATE);
>>   
>> @@ -1199,8 +1221,8 @@ static int pci_pm_poweroff_noirq(struct device *dev)
>>   			return error;
>>   	}
>>   
>> -	if (!pci_dev->state_saved && !pci_has_subordinate(pci_dev))
>> -		pci_prepare_to_sleep(pci_dev);
>> +	if (!pci_pm_set_prepare_bus_pm(pci_dev))
>> +		goto Fixup;
>>   
>>   	/*
>>   	 * The reason for doing this here is the same as for the analogous code
>> @@ -1209,6 +1231,7 @@ static int pci_pm_poweroff_noirq(struct device *dev)
>>   	if (pci_dev->class == PCI_CLASS_SERIAL_USB_EHCI)
>>   		pci_write_config_word(pci_dev, PCI_COMMAND, 0);
>>   
>> +Fixup:
>>   	pci_fixup_device(pci_fixup_suspend_late, pci_dev);
>>   
>>   	return 0;
>> @@ -1218,10 +1241,15 @@ static int pci_pm_restore_noirq(struct device *dev)
>>   {
>>   	struct pci_dev *pci_dev = to_pci_dev(dev);
>>   	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>> +	pci_power_t prev_state = pci_dev->current_state;
>> +	bool skip_bus_pm = pci_dev->skip_bus_pm;
>>   
>>   	pci_pm_default_resume_early(pci_dev);
>>   	pci_fixup_device(pci_fixup_resume_early, pci_dev);
>>   
>> +	if (!skip_bus_pm && prev_state == PCI_D3cold)
>> +		pci_pm_bridge_power_up_actions(pci_dev);
>> +
>>   	if (pci_has_legacy_pm_support(pci_dev))
>>   		return 0;
>>   
>> -- 
>> 2.43.0
>>

