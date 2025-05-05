Return-Path: <linux-pci+bounces-27195-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD885AA9CF1
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 22:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31B1D17D2B1
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 20:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5118619C546;
	Mon,  5 May 2025 20:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMHBz1XQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4831865E3
	for <linux-pci@vger.kernel.org>; Mon,  5 May 2025 20:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746475272; cv=none; b=KYY9T32idCL+jg4OMbfCptnxUsy0EhPlGdunAoGJCY5sJL0Xo5ZteQXJFwyASASmz2Gg3nfy/3Bh2onpAL7+mXKpaqw/C1WzdXoiKPIm9WHBLIIxBGg7BvOVLL9wy9SXTPw2s/kA+3bg0/rJwVQbeC/TzkbX4mtLXT/a9dR9P3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746475272; c=relaxed/simple;
	bh=P9TxQSDgnb1FyG3Y3k5GUcFihDb6ndOOLETMXnemihU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nZIm38sMtawU0MLTB3xSzGnr1YxgxWSP5k5liyoInA16Yxwy++KvcyjfP0kWAUhJfaJ2wAScic+N1kc35pboGRTa9uxoQDbgVqEXwu1oV5T8tlmqXkvzHIj/XzSrptmyjnwXN3aZ2j/CkWOonMJmu9qYYANlsMz2VTQ0R0ALIHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QMHBz1XQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE31C4CEE4;
	Mon,  5 May 2025 20:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746475271;
	bh=P9TxQSDgnb1FyG3Y3k5GUcFihDb6ndOOLETMXnemihU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QMHBz1XQfAs0zWkJrGxAGd7lt7ib2FIpnPsVyUWvG2b5AGmR5WmaRtGVMkyxC4265
	 0WDxYNyH/Ptfif2+cbTK+cGH6RNDIB71ZOCYbS3+eMGEJeVozYx/tR8c4rmpCW6vGf
	 agsbDPSYVevst/iUf7DO2RHdM1Cr6vtE4m3hzh9IyOCCj7bcH1pXn31ZKqOg9xrm7g
	 NNsiBar4i26/Sl6qli8xNExqChfk7fPPmxyWczebvk0WN5+04M96t+jslcIG0SMc1Z
	 IUVWal62I7wwEeJf+13nqIWUxk20tWU++UrTgwF4G/VVFeHzcTrShLVd+Oa1TF7d5k
	 Qe8AGT474cVxA==
Message-ID: <61b8d5e1-2e42-477d-bde5-4040f3d9c092@kernel.org>
Date: Mon, 5 May 2025 15:01:09 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: Explicitly put devices into D0 when initializing
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, "Perry, David" <david.perry@amd.com>,
 bhelgaas@google.com, rafael.j.wysocki@intel.com,
 huang.ying.caritas@gmail.com, stern@rowland.harvard.edu
References: <20250424043232.1848107-1-superm1@kernel.org>
 <1944cb5c-2352-456d-bf4a-5b39d7ae0fe5@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <1944cb5c-2352-456d-bf4a-5b39d7ae0fe5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/5/2025 2:20 PM, Perry, David wrote:
> Verified the patch on AMD reference board.
> 
> Tested-By: David Perry <david.perry@amd.com>

Thanks Dave.

> 
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

Bjorn,

We now have some positive testing reports from this on

* Intel system (Denis Benato)
* Dell system (Yijun Shen)
* AMD reference system (Dave Perry)

Any comments?

>> v2:
>>   * Move runtime PM calls after setting to D0
>>   * Use pci_pm_power_up_and_verify_state()
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


