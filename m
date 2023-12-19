Return-Path: <linux-pci+bounces-1163-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBCE818281
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 08:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95A861C2314A
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 07:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDCA8BE1;
	Tue, 19 Dec 2023 07:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QHgmxkzs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08825C2C4;
	Tue, 19 Dec 2023 07:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702971900; x=1734507900;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oV68SGNe+vc2xYJaXlGSKXiIrjmzjkYlkJyXhdnx6dI=;
  b=QHgmxkzsti9ADANpA6mVRJN3beo/aX64M05D9dOKMxQ+d5cTnKVFh3/6
   UMk2edqTWZzmbmH3HLX84JvxrYh6UdI/p0UahHDsz5tfjEis2Dj6iB3wH
   sUe/t+kuB/p/t4sUfGgqAfM/1ixlrzK2NoQq6X4TUA6Qfn9dlVOvLkLhu
   Qt/yhb8ubjvlQddvN0XcuZsQffzL6O5axdrAhIO08L1VjN4i+F20XnYku
   gr+buREnEKKkP9VUo4UIAFQS9v51Nt02awfSdMJAloygiFBWPRz4oYH4M
   GJc/6yzFq4w6tiIpNDiYc85cNmeySlbr30T+RoR7wIADUzrVpEqxJDUqZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="9069243"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="9069243"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 23:44:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="769138683"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="769138683"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.93.26.36]) ([10.93.26.36])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 23:44:56 -0800
Message-ID: <b8be9496-096e-40f2-a942-2cf756b5f0ef@linux.intel.com>
Date: Tue, 19 Dec 2023 15:44:53 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] iommu/vt-d: don's issue devTLB flush request when
 device is disconnected
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: linux-pci@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, bhelgaas@google.com, dwmw2@infradead.org,
 will@kernel.org, robin.murphy@arm.com, lukas@wunner.de
References: <20231217114902.3836260-1-haifeng.zhao@linux.intel.com>
 <20231217114902.3836260-3-haifeng.zhao@linux.intel.com>
 <ac0fd341-7def-485e-9f32-530cf8a83273@linux.intel.com>
 <a275032f-cb1d-4ccc-9418-9567aba6b343@linux.intel.com>
 <f7dfdec4-ec52-44b0-9e04-bdcc3af2ba25@linux.intel.com>
 <2fa95471-e22e-46b7-8f23-f4e6abbbd69b@linux.intel.com>
 <53591775-b93c-4963-b57b-8027e39a6ecc@linux.intel.com>
 <fa317b2b-b1b8-4776-a122-ae7993bd3c41@linux.intel.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <fa317b2b-b1b8-4776-a122-ae7993bd3c41@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/19/2023 3:35 PM, Baolu Lu wrote:
> On 2023/12/19 15:27, Ethan Zhao wrote:
>> Baolu,
>>
>> On 12/19/2023 3:16 PM, Ethan Zhao wrote:
>>>
>>> On 12/19/2023 2:57 PM, Baolu Lu wrote:
>>>> On 2023/12/19 14:49, Ethan Zhao wrote:
>>>>>>> diff --git a/drivers/iommu/intel/pasid.c 
>>>>>>> b/drivers/iommu/intel/pasid.c
>>>>>>> index 74e8e4c17e81..182eb5df244d 100644
>>>>>>> --- a/drivers/iommu/intel/pasid.c
>>>>>>> +++ b/drivers/iommu/intel/pasid.c
>>>>>>> @@ -476,6 +476,23 @@ devtlb_invalidation_with_pasid(struct 
>>>>>>> intel_iommu *iommu,
>>>>>>>   {
>>>>>>>       struct device_domain_info *info;
>>>>>>>       u16 sid, qdep, pfsid;
>>>>>>> +    struct pci_dev *pdev;
>>>>>>> +
>>>>>>> +    pdev = to_pci_dev(dev);
>>>>>>> +    if (!pdev)
>>>>>>> +        return;
>>>>>>> +
>>>>>>> +    /*
>>>>>>> +     * If endpoint device's link was brough down by user's pci 
>>>>>>> configuration
>>>>>>> +     * access to it's hotplug capable slot link control 
>>>>>>> register, as sequence
>>>>>>> +     * response for DLLSC, pciehp_ist() will set the device 
>>>>>>> error_state to
>>>>>>> +     * pci_channel_io_perm_failure. Checking device's state 
>>>>>>> here to avoid
>>>>>>> +     * issuing meaningless devTLB flush request to it, that 
>>>>>>> might cause lockup
>>>>>>> +     * warning or deadlock because too long time waiting in 
>>>>>>> interrupt context.
>>>>>>> +     */
>>>>>>> +
>>>>>>> +    if (pci_dev_is_disconnected(pdev))
>>>>>>> +        return;
>>>>>>>         info = dev_iommu_priv_get(dev);
>>>>>>>       if (!info || !info->ats_enabled)
>>>>>>
>>>>>> It's likely better to check the device status after verifying
>>>>>> ats_enabled. How about below change?
>>>>>>
>>>>>> diff --git a/drivers/iommu/intel/pasid.c 
>>>>>> b/drivers/iommu/intel/pasid.c
>>>>>> index 74e8e4c17e81..fa19c6cdfd8b 100644
>>>>>> --- a/drivers/iommu/intel/pasid.c
>>>>>> +++ b/drivers/iommu/intel/pasid.c
>>>>>> @@ -481,6 +481,9 @@ devtlb_invalidation_with_pasid(struct 
>>>>>> intel_iommu *iommu,
>>>>>>         if (!info || !info->ats_enabled)
>>>>>>                 return;
>>>>>>
>>>>>> +       if (pci_dev_is_disconnected(to_pci_dev(dev)))
>>>>>
>>>>> I like this kind of simplicity, but rationalist always brings me 
>>>>> back to the no-error(ugly)
>>>>>
>>>>> style.  🙂
>>>>
>>>> The rational is that Intel IOMMU driver only supports PCI ATS. So if
>>>> device is marked as ATS supported, then it must be a PCI device.
>>>> Therefore, it's safe to convert it to pci_device with to_pci_dev().
>>>
>>> Fair engough !
>>>
>>>
>> May I use  your reviewed-by sign in next version after that ?
>
> I am not sure about the changes in the PCI subsystem. Since the code

IC


Thanks,

Ethan

> here calls the new interface from that subsystem, I need acked-by on
> that change before proceeding.
>
> Best regards,
> baolu

