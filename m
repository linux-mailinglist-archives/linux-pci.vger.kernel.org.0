Return-Path: <linux-pci+bounces-27760-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A29EAB7631
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 21:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26288189D896
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 19:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A93F293732;
	Wed, 14 May 2025 19:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qks3wIkT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63C420311;
	Wed, 14 May 2025 19:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747252391; cv=none; b=YSxE6Mj4xP17MQwqvnR0Oc1T1GW+O8/32IYrLByR+tYEZHZp50PQ8IrXGWDck+4HgbjQtobx6eTNrMU9xA5X53KdkKXHI9Gmbe5426fAJKqhv15721MDDq/oadEF0SSCMe/YEKolGCAczFei/+Gm3bXz1c7gnpu5Udb++bAex0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747252391; c=relaxed/simple;
	bh=edV31lDf13nHYBn3fZUgok0YY+ziTTMaoeXYhyTImGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LW0dy39ihjadK39IROdJBtEGaqjYmwPd+dkWX/D0WthzL9Dr+uBiqds5Q2Zu86Z2F7XFg5hI6GajECBg0Eh8Xiv5nZ0w/wovZeK5BxwkDe82X1uBZH2uhGDC2wxZ7bdv1bz8lPuCLoOJvrEqgxlXcAv3cTpRwYGRFt46HLexiSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qks3wIkT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7949CC4CEE3;
	Wed, 14 May 2025 19:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747252391;
	bh=edV31lDf13nHYBn3fZUgok0YY+ziTTMaoeXYhyTImGY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qks3wIkTX4bh6aqc1DYNlpraBXFfvMtMN0UZ6lmcGsyL8nud8r0+T3+Ud6C40jfnO
	 z3qquFdh/cM2BFVrEE91XagPyn9wI1snXlqXkpTJho0k2/gFevzVZLXatumEYJCs/c
	 5Jbkyi6zjPkbWRlhYWYvLZsFzuM3zkY62v1JK098OfIhXNwR3ZS/wZKJBmF3kmF3z2
	 69mQi8yg+1ESfo5p/S/6uZiczzCY5BU5nSKS3DKxH8dWRLTv4Peqv2Se5eGOvQPXIM
	 lsS9TxzJmjYD2uU50nYPT6rweLIzC5k+rA8nNyKbE6kAdT/1EUA1oz58nlBtB5R3E/
	 CyMGjpFwonYbQ==
Message-ID: <384a2c60-2f25-4a1d-b8a6-3ea4ea34e2c2@kernel.org>
Date: Wed, 14 May 2025 14:53:09 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: Prevent power state transition of erroneous
 device
To: Denis Benato <benato.denis96@gmail.com>, Raag Jadav
 <raag.jadav@intel.com>, rafael@kernel.org, mahesh@linux.ibm.com,
 oohall@gmail.com, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 ilpo.jarvinen@linux.intel.com, lukas@wunner.de,
 aravind.iddamsetty@linux.intel.com
References: <20250504090444.3347952-1-raag.jadav@intel.com>
 <7dbb64ee-3683-4b47-b17d-288447da746e@gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <7dbb64ee-3683-4b47-b17d-288447da746e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/14/2025 11:29 AM, Denis Benato wrote:
> Hello,
> 
> Lately I am experiencing a few problems related to either (one of or both) PCI and/or thunderbolt and Mario Limonciello pointed me to this patch.
> 
> you can follow an example of my problems in this [1] bug report.
> 
> I tested this patch on top of 6.14.6 and this patch comes with a nasty regression: s2idle resume breaks all my three GPUs, while for example the sound of a YT video resumes fine.
> 
> You can see the dmesg here: https://pastebin.com/Um7bmdWi
> 
> I will also say that, on the bright side, this patch makes my laptop behave better on boot as the amdgpu plugged on the thunderbolt port is always enabled on power on, while without this patch it is random if it will be active immediately after laptop has been turned on.
> 

Just for clarity - if you unplug your eGPU enclosure before suspend is 
everything OK?  IE this patch only has an impact to the USB4/TBT3 PCIe 
tunnels?

The errors after resume in amdgpu /look/ like the device is "missing" 
from the bus or otherwise not responding.

I think it would be helpful to capture the kernel log with a baseline of 
6.14.6 but without this patch for comparison of what this patch is 
actually causing.

> 
> [1] https://lore.kernel.org/all/965c9753-f14b-4a87-9f6d-8798e09ad6f5@gmail.com/
> 
> On 5/4/25 11:04, Raag Jadav wrote:
> 
>> If error flags are set on an AER capable device, most likely either the
>> device recovery is in progress or has already failed. Neither of the
>> cases are well suited for power state transition of the device, since
>> this can lead to unpredictable consequences like resume failure, or in
>> worst case the device is lost because of it. Leave the device in its
>> existing power state to avoid such issues.
>>
>> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
>> ---
>>
>> v2: Synchronize AER handling with PCI PM (Rafael)
>> v3: Move pci_aer_in_progress() to pci_set_low_power_state() (Rafael)
>>      Elaborate "why" (Bjorn)
>>
>> More discussion on [1].
>> [1] https://lore.kernel.org/all/CAJZ5v0g-aJXfVH+Uc=9eRPuW08t-6PwzdyMXsC6FZRKYJtY03Q@mail.gmail.com/
>>
>>   drivers/pci/pci.c      | 12 ++++++++++++
>>   drivers/pci/pcie/aer.c | 11 +++++++++++
>>   include/linux/aer.h    |  2 ++
>>   3 files changed, 25 insertions(+)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 4d7c9f64ea24..25b2df34336c 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -9,6 +9,7 @@
>>    */
>>   
>>   #include <linux/acpi.h>
>> +#include <linux/aer.h>
>>   #include <linux/kernel.h>
>>   #include <linux/delay.h>
>>   #include <linux/dmi.h>
>> @@ -1539,6 +1540,17 @@ static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state, bool
>>   	   || (state == PCI_D2 && !dev->d2_support))
>>   		return -EIO;
>>   
>> +	/*
>> +	 * If error flags are set on an AER capable device, most likely either
>> +	 * the device recovery is in progress or has already failed. Neither of
>> +	 * the cases are well suited for power state transition of the device,
>> +	 * since this can lead to unpredictable consequences like resume
>> +	 * failure, or in worst case the device is lost because of it. Leave the
>> +	 * device in its existing power state to avoid such issues.
>> +	 */
>> +	if (pci_aer_in_progress(dev))
>> +		return -EIO;
>> +
>>   	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>>   	if (PCI_POSSIBLE_ERROR(pmcsr)) {
>>   		pci_err(dev, "Unable to change power state from %s to %s, device inaccessible\n",
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index a1cf8c7ef628..4040770df4f0 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -237,6 +237,17 @@ int pcie_aer_is_native(struct pci_dev *dev)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(pcie_aer_is_native, "CXL");
>>   
>> +bool pci_aer_in_progress(struct pci_dev *dev)
>> +{
>> +	u16 reg16;
>> +
>> +	if (!pcie_aer_is_native(dev))
>> +		return false;
>> +
>> +	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &reg16);
>> +	return !!(reg16 & PCI_EXP_AER_FLAGS);
>> +}
>> +
>>   static int pci_enable_pcie_error_reporting(struct pci_dev *dev)
>>   {
>>   	int rc;
>> diff --git a/include/linux/aer.h b/include/linux/aer.h
>> index 02940be66324..e6a380bb2e68 100644
>> --- a/include/linux/aer.h
>> +++ b/include/linux/aer.h
>> @@ -56,12 +56,14 @@ struct aer_capability_regs {
>>   #if defined(CONFIG_PCIEAER)
>>   int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>>   int pcie_aer_is_native(struct pci_dev *dev);
>> +bool pci_aer_in_progress(struct pci_dev *dev);
>>   #else
>>   static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>>   {
>>   	return -EINVAL;
>>   }
>>   static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>> +static inline bool pci_aer_in_progress(struct pci_dev *dev) { return false; }
>>   #endif
>>   
>>   void pci_print_aer(struct pci_dev *dev, int aer_severity,


