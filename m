Return-Path: <linux-pci+bounces-26712-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F805A9B63E
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 20:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 252994A86DF
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 18:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A32294A0D;
	Thu, 24 Apr 2025 18:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FG0wZFj7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73464294A0A
	for <linux-pci@vger.kernel.org>; Thu, 24 Apr 2025 18:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745518811; cv=none; b=rgXqho2h4WZAJpOOUxJ1jRZlPPmPfeu6P4vAzfi4gLBszyqEHbidkNAxfyA8WF07Trbj2QGcfCK7zaYLi3wEe3wsk9sXUlAHtlgNGR3WOFJg3t0yNqH83P1QEB4THLSAAPPDXyRFRKlujlbpdpO2qNjD3YMlnu2vBDPFI3rY8Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745518811; c=relaxed/simple;
	bh=b7tgNkZupRIMsLwi02FbD2f9XF7rt1RDs8p3/XiX+Kk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FtFF2k2MzE+nX4eUzbYGtgDF8PmvqlN3Jaf+R50hbccMZ7jG0tgYPf0cXhU+xm4KeR+gb+jWD+ueGXGjvmAhW1nWD0EDSsPpHCs50J6X2B737TSL45IXNNKp0i0E+ynbkTl2nBcSKV8yAz2WcCnuDoEd0YBZVCsqUCfQLODk8aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FG0wZFj7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC451C4CEE3;
	Thu, 24 Apr 2025 18:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745518811;
	bh=b7tgNkZupRIMsLwi02FbD2f9XF7rt1RDs8p3/XiX+Kk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FG0wZFj7Le+58aTE4yjiS8TYeb2BbGuZqTcWSHz/IPQjuSdKyhOJzOiMLtc6kGPAi
	 CHFHOFH2iFspG/4oC5bvn5Mg2AOqWH6vHbIvFvJqi7UsmJG070yiCK8nxmaEnqAFwh
	 OPEToOAFLDbz58/2y6t+2vGNGfaYgZLlIZXHg7mJY1Hm+pThX67S/l9oNz9Mmb1EE9
	 Fl/HKGQhJurbdCtfe7NwnkIGVqV72CWnzoetEknV5mze06wn4quAURyJxAfhv2odHu
	 SfzW9aNmKLrK/q04IPOohzd4vIPu/Dlc/58LkW/tC506QMuxFfYTkcJzKIUq16wy2W
	 bITqoYE/i2n2Q==
Message-ID: <a83ee1c6-ebf2-4fa5-b1b7-229d1093788d@kernel.org>
Date: Thu, 24 Apr 2025 13:20:09 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: Explicitly put devices into D0 when initializing
To: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
 mario.limonciello@amd.com, bhelgaas@google.com,
 huang.ying.caritas@gmail.com, stern@rowland.harvard.edu
Cc: linux-pci@vger.kernel.org, linux-pm@kernel.vger.org,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <20250424043232.1848107-1-superm1@kernel.org>
 <18b0cabc-6f84-45f2-97db-4f5e2a938aad@intel.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <18b0cabc-6f84-45f2-97db-4f5e2a938aad@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/24/2025 10:07 AM, Wysocki, Rafael J wrote:
> On 4/24/2025 6:31 AM, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> AMD BIOS team has root caused an issue that NVME storage failed to come
>> back from suspend to a lack of a call to _REG when NVME device was 
>> probed.
>>
>> commit 112a7f9c8edbf ("PCI/ACPI: Call _REG when transitioning D-states")
>> added support for calling _REG when transitioning D-states, but this only
>> works if the device actually "transitions" D-states.
>>
>> commit 967577b062417 ("PCI/PM: Keep runtime PM enabled for unbound PCI
>> devices") added support for runtime PM on PCI devices, but never actually
>> 'explicitly' sets the device to D0.
>>
>> To make sure that devices are in D0 and that platform methods such as
>> _REG are called, explicitly set all devices into D0 during 
>> initialization.
>>
>> Fixes: 967577b062417 ("PCI/PM: Keep runtime PM enabled for unbound PCI 
>> devices")
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v2:
>>   * Move runtime PM calls after setting to D0
>>   * Use pci_pm_power_up_and_verify_state()
> 
> You could give me a credit for this suggestion.

Sorry about that, absolutely!  I believe b4 can still pick it up.

Suggested-by: Rafael J. Wysocki <rafael@kernel.org>

> 
> Anyways
> 
> Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>
> 
> 
>> ---
>>   drivers/pci/pci-driver.c |  6 ------
>>   drivers/pci/pci.c        | 13 ++++++++++---
>>   drivers/pci/pci.h        |  1 +
>>   3 files changed, 11 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>> index c8bd71a739f72..082918ce03d8a 100644
>> --- a/drivers/pci/pci-driver.c
>> +++ b/drivers/pci/pci-driver.c
>> @@ -555,12 +555,6 @@ static void pci_pm_default_resume(struct pci_dev 
>> *pci_dev)
>>       pci_enable_wake(pci_dev, PCI_D0, false);
>>   }
>> -static void pci_pm_power_up_and_verify_state(struct pci_dev *pci_dev)
>> -{
>> -    pci_power_up(pci_dev);
>> -    pci_update_current_state(pci_dev, PCI_D0);
>> -}
>> -
>>   static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
>>   {
>>       pci_pm_power_up_and_verify_state(pci_dev);
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index e77d5b53c0cec..8d125998b30b7 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -3192,6 +3192,12 @@ void pci_d3cold_disable(struct pci_dev *dev)
>>   }
>>   EXPORT_SYMBOL_GPL(pci_d3cold_disable);
>> +void pci_pm_power_up_and_verify_state(struct pci_dev *pci_dev)
>> +{
>> +    pci_power_up(pci_dev);
>> +    pci_update_current_state(pci_dev, PCI_D0);
>> +}
>> +
>>   /**
>>    * pci_pm_init - Initialize PM functions of given PCI device
>>    * @dev: PCI device to handle.
>> @@ -3202,9 +3208,6 @@ void pci_pm_init(struct pci_dev *dev)
>>       u16 status;
>>       u16 pmc;
>> -    pm_runtime_forbid(&dev->dev);
>> -    pm_runtime_set_active(&dev->dev);
>> -    pm_runtime_enable(&dev->dev);
>>       device_enable_async_suspend(&dev->dev);
>>       dev->wakeup_prepared = false;
>> @@ -3266,6 +3269,10 @@ void pci_pm_init(struct pci_dev *dev)
>>       pci_read_config_word(dev, PCI_STATUS, &status);
>>       if (status & PCI_STATUS_IMM_READY)
>>           dev->imm_ready = 1;
>> +    pci_pm_power_up_and_verify_state(dev);
>> +    pm_runtime_forbid(&dev->dev);
>> +    pm_runtime_set_active(&dev->dev);
>> +    pm_runtime_enable(&dev->dev);
>>   }
>>   static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index b81e99cd4b62a..49165b739138b 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -148,6 +148,7 @@ void pci_dev_adjust_pme(struct pci_dev *dev);
>>   void pci_dev_complete_resume(struct pci_dev *pci_dev);
>>   void pci_config_pm_runtime_get(struct pci_dev *dev);
>>   void pci_config_pm_runtime_put(struct pci_dev *dev);
>> +void pci_pm_power_up_and_verify_state(struct pci_dev *pci_dev);
>>   void pci_pm_init(struct pci_dev *dev);
>>   void pci_ea_init(struct pci_dev *dev);
>>   void pci_msi_init(struct pci_dev *dev);


