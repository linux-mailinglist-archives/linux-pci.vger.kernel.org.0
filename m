Return-Path: <linux-pci+bounces-2754-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FD4841B4E
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 06:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A6128619C
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 05:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4D537701;
	Tue, 30 Jan 2024 05:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lXMxQMcE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260FD381A2;
	Tue, 30 Jan 2024 05:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706591569; cv=none; b=q8guHjR+vM6pm5DHFofhWXrwunlcX2IqDQsLqSzNhpbPwBgUliHnSz45oCZSDMIQGdmsjZ8xrWCDOU3QDmK3EELPX8KAtJf0rhqbjVVqSDiaBU92nLwvIKVFUOTJ0K6rUUF2EIZ2tPZKPQF7/md1FGKh9k0WSQ2N+agpHL7biPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706591569; c=relaxed/simple;
	bh=Ab2x+RjnadAuhoF56GiPfWyJFkxamyXXz4zU9qJcU7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BrJup3p1jwsi1Z2UjqwgG8TBlobRcWrEU5uGCcqFiegBp2bUCZU+B/cWi+PvsdLMcd2tPmXiJVNCf41lStsVs8YAahDn+BF8n+lhnUQeztcfPUrhKUo5n/9EcU2V1tQIuzCVatxL//0ipdOP//Umy9+huohhF3UvEo9aWyD0i5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lXMxQMcE; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706591567; x=1738127567;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ab2x+RjnadAuhoF56GiPfWyJFkxamyXXz4zU9qJcU7o=;
  b=lXMxQMcEwOSU6WYKFhMnB+Zs0KpYH8Xn2LO07enS3sufs0o9jWPjMVCc
   b+d1i3vq/Mbw1/LEPfsTXHA9GqK0bAy40TLmLiVl8CBTRQaRfV2ddyLvf
   xEQL1yKr/V+uAYxRfVR2MYLkhWkm43zmYticBKkRjbSiaSxAYAoY4fYrL
   Hm+P5BlGNTKN0Vh2/gL+x8akzCcmaVz3Y1zMkYYla0UAobmQdYG6QNOrU
   7C5Qnb5tFY3bYzySVPG4sjmxB3s0ZLiS+IZ2P3dyARaVEuT0WFK5oVB6T
   PBiIsc0UB9JjUjUd758j9YD+nUP0dYW5kImLUVhY7flfZjNFu62Zast9J
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="24650451"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="24650451"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 21:12:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="737656154"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="737656154"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.238.130.190]) ([10.238.130.190])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 21:12:42 -0800
Message-ID: <0aee453c-e98f-4b72-8107-31d4731abcdb@linux.intel.com>
Date: Tue, 30 Jan 2024 13:12:39 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 5/5] iommu/vt-d: improve ITE fault handling if target
 device isn't present
To: Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>
Cc: "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "will@kernel.org" <will@kernel.org>, "lukas@wunner.de" <lukas@wunner.de>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20240129034924.817005-1-haifeng.zhao@linux.intel.com>
 <20240129034924.817005-6-haifeng.zhao@linux.intel.com>
 <BN9PR11MB52761CC3E5F08D4B7BAD7F918C7E2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <7adec292-9d38-41ab-a982-bd840b24f3ab@intel.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <7adec292-9d38-41ab-a982-bd840b24f3ab@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/29/2024 5:21 PM, Yi Liu wrote:
> On 2024/1/29 17:06, Tian, Kevin wrote:
>>> From: Ethan Zhao <haifeng.zhao@linux.intel.com>
>>> Sent: Monday, January 29, 2024 11:49 AM
>>>
>>> Because surprise removal could happen anytime, e.g. user could 
>>> request safe
>>> removal to EP(endpoint device) via sysfs and brings its link down to do
>>> surprise removal cocurrently. such aggressive cases would cause ATS
>>> invalidation request issued to non-existence target device, then deadly
>>> loop to retry that request after ITE fault triggered in interrupt 
>>> context.
>>> this patch aims to optimize the ITE handling by checking the target 
>>> device
>>> presence state to avoid retrying the timeout request blindly, thus 
>>> avoid
>>> hard lockup or system hang.
>>>
>>> Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
>>> ---
>>>   drivers/iommu/intel/dmar.c | 18 ++++++++++++++++++
>>>   1 file changed, 18 insertions(+)
>>>
>>> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
>>> index 814134e9aa5a..2e214b43725c 100644
>>> --- a/drivers/iommu/intel/dmar.c
>>> +++ b/drivers/iommu/intel/dmar.c
>>> @@ -1272,6 +1272,7 @@ static int qi_check_fault(struct intel_iommu
>>> *iommu, int index, int wait_index,
>>>   {
>>>       u32 fault;
>>>       int head, tail;
>>> +    u64 iqe_err, ite_sid;
>>>       struct q_inval *qi = iommu->qi;
>>>       int shift = qi_shift(iommu);
>>>
>>> @@ -1316,6 +1317,13 @@ static int qi_check_fault(struct intel_iommu
>>> *iommu, int index, int wait_index,
>>>           tail = readl(iommu->reg + DMAR_IQT_REG);
>>>           tail = ((tail >> shift) - 1 + QI_LENGTH) % QI_LENGTH;
>>>
>>> +        /*
>>> +         * SID field is valid only when the ITE field is Set in 
>>> FSTS_REG
>>> +         * see Intel VT-d spec r4.1, section 11.4.9.9
>>> +         */
>>> +        iqe_err = dmar_readq(iommu->reg + DMAR_IQER_REG);
>>> +        ite_sid = DMAR_IQER_REG_ITESID(iqe_err);
>>> +
>>>           writel(DMA_FSTS_ITE, iommu->reg + DMAR_FSTS_REG);
>>>           pr_info("Invalidation Time-out Error (ITE) cleared\n");
>>>
>>> @@ -1325,6 +1333,16 @@ static int qi_check_fault(struct intel_iommu
>>> *iommu, int index, int wait_index,
>>>               head = (head - 2 + QI_LENGTH) % QI_LENGTH;
>>>           } while (head != tail);
>>>
>>> +        /*
>>> +         * If got ITE, we need to check if the sid of ITE is the 
>>> same as
>>> +         * current ATS invalidation target device, if yes, don't 
>>> try this
>>> +         * request anymore if the target device isn't present.
>>> +         * 0 value of ite_sid means old VT-d device, no ite_sid value.
>>> +         */
>>> +        if (pdev && ite_sid && !pci_device_is_present(pdev) &&
>>> +            ite_sid == pci_dev_id(pci_physfn(pdev)))
>>> +            return -ETIMEDOUT;
>>> +
>>
>> since the hardware already reports source id leading to timeout, 
>> can't we
>> just find the pci_dev according to reported ite_sid? this is a slow 
>> path (either
>> due to device in bad state or removed) hence it's not necessary to 
>> add more
>> intelligence to pass the pci_dev in, leading to only a partial fix 
>> can be backported.
>>
>> It's also more future-proof, say if one day the driver allows 
>> batching invalidation
>> requests for multiple devices then no need to pass in a list of devices.
>>
>> Then it's easier to backport a full fix.
>
> May consider pci_get_domain_bus_and_slot() or
> pci_find_bus()/pci_get_slot(). But I doubt if the pci_dev is still 
> tracked
> in the bus or a kind of dev list in the device hot removal case. So Ethan
> may need to check.

Perhaps it is too late to call pci_find_bus() or 
pci_get_domain_bus_and_slot() to get the

device instance from this notifier registered as BUS_NOTIFY_REMOVED_DEVICE

action. if the device is still there in bus list, *must* be a bug of 
device subsystem as

*removed* device.

but if we call iommu_release_device() in iommu_bus_notifier() for 
BUS_NOTIFY_DEL_DEVICE

action, there should be opportuniy to get the device instance, but that 
change need

more evaluation about side effect.

furthermore, iommu never cross domain number per context table 
defination in VT-d

spec, not mean, domain number in a system never will be !0, per my 
understanding.


Thanks,

Ethan

>
> Regards,
> Yi Liu
>

