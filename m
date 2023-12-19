Return-Path: <linux-pci+bounces-1162-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A61818258
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 08:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C81BA1C218F1
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 07:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4177883B;
	Tue, 19 Dec 2023 07:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aj7ReWed"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BB3C14E;
	Tue, 19 Dec 2023 07:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702971361; x=1734507361;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=omKaiFok3XxGSxlMUBsc0D82rlenJr+xlJ/7MpZfcGc=;
  b=aj7ReWedIGIVlAi4TnanaWAr1yu32r74/rUADNmeMogZsprcDnlBCrTJ
   qe4+sV0kGMNobRB+/fiBIAw613eEu8X5QtJfiO7ec5ry+9vIogJ3Q2GPF
   3Mp+iEZld9nmGIE9JFVj3JGqPOPLzNcVF+DVlPHvpNhlTzIYBHCDmO6T2
   2yVSdcWT4a51w9txdtdy+XLLvpNagOAbVNv9UwzsjWC10Kl7bqihkubaZ
   +eINaXbg5a09vSFWzBguVXCX22IihET9Bw1hIQDfnYc41zJ595c2Gtnko
   yoWgjTnuJima/bAyBVeNGmE5Do0aSbdgBzWJJ2ssKRrHzr3IOdj+2REXj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="462070937"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="462070937"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 23:36:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="804806655"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="804806655"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.255.31.117]) ([10.255.31.117])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 23:35:59 -0800
Message-ID: <fa317b2b-b1b8-4776-a122-ae7993bd3c41@linux.intel.com>
Date: Tue, 19 Dec 2023 15:35:57 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, linux-pci@vger.kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, bhelgaas@google.com,
 dwmw2@infradead.org, will@kernel.org, robin.murphy@arm.com, lukas@wunner.de
Subject: Re: [PATCH v3 2/2] iommu/vt-d: don's issue devTLB flush request when
 device is disconnected
Content-Language: en-US
To: Ethan Zhao <haifeng.zhao@linux.intel.com>
References: <20231217114902.3836260-1-haifeng.zhao@linux.intel.com>
 <20231217114902.3836260-3-haifeng.zhao@linux.intel.com>
 <ac0fd341-7def-485e-9f32-530cf8a83273@linux.intel.com>
 <a275032f-cb1d-4ccc-9418-9567aba6b343@linux.intel.com>
 <f7dfdec4-ec52-44b0-9e04-bdcc3af2ba25@linux.intel.com>
 <2fa95471-e22e-46b7-8f23-f4e6abbbd69b@linux.intel.com>
 <53591775-b93c-4963-b57b-8027e39a6ecc@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <53591775-b93c-4963-b57b-8027e39a6ecc@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023/12/19 15:27, Ethan Zhao wrote:
> Baolu,
> 
> On 12/19/2023 3:16 PM, Ethan Zhao wrote:
>>
>> On 12/19/2023 2:57 PM, Baolu Lu wrote:
>>> On 2023/12/19 14:49, Ethan Zhao wrote:
>>>>>> diff --git a/drivers/iommu/intel/pasid.c 
>>>>>> b/drivers/iommu/intel/pasid.c
>>>>>> index 74e8e4c17e81..182eb5df244d 100644
>>>>>> --- a/drivers/iommu/intel/pasid.c
>>>>>> +++ b/drivers/iommu/intel/pasid.c
>>>>>> @@ -476,6 +476,23 @@ devtlb_invalidation_with_pasid(struct 
>>>>>> intel_iommu *iommu,
>>>>>>   {
>>>>>>       struct device_domain_info *info;
>>>>>>       u16 sid, qdep, pfsid;
>>>>>> +    struct pci_dev *pdev;
>>>>>> +
>>>>>> +    pdev = to_pci_dev(dev);
>>>>>> +    if (!pdev)
>>>>>> +        return;
>>>>>> +
>>>>>> +    /*
>>>>>> +     * If endpoint device's link was brough down by user's pci 
>>>>>> configuration
>>>>>> +     * access to it's hotplug capable slot link control register, 
>>>>>> as sequence
>>>>>> +     * response for DLLSC, pciehp_ist() will set the device 
>>>>>> error_state to
>>>>>> +     * pci_channel_io_perm_failure. Checking device's state here 
>>>>>> to avoid
>>>>>> +     * issuing meaningless devTLB flush request to it, that might 
>>>>>> cause lockup
>>>>>> +     * warning or deadlock because too long time waiting in 
>>>>>> interrupt context.
>>>>>> +     */
>>>>>> +
>>>>>> +    if (pci_dev_is_disconnected(pdev))
>>>>>> +        return;
>>>>>>         info = dev_iommu_priv_get(dev);
>>>>>>       if (!info || !info->ats_enabled)
>>>>>
>>>>> It's likely better to check the device status after verifying
>>>>> ats_enabled. How about below change?
>>>>>
>>>>> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
>>>>> index 74e8e4c17e81..fa19c6cdfd8b 100644
>>>>> --- a/drivers/iommu/intel/pasid.c
>>>>> +++ b/drivers/iommu/intel/pasid.c
>>>>> @@ -481,6 +481,9 @@ devtlb_invalidation_with_pasid(struct 
>>>>> intel_iommu *iommu,
>>>>>         if (!info || !info->ats_enabled)
>>>>>                 return;
>>>>>
>>>>> +       if (pci_dev_is_disconnected(to_pci_dev(dev)))
>>>>
>>>> I like this kind of simplicity, but rationalist always brings me 
>>>> back to the no-error(ugly)
>>>>
>>>> style.  🙂
>>>
>>> The rational is that Intel IOMMU driver only supports PCI ATS. So if
>>> device is marked as ATS supported, then it must be a PCI device.
>>> Therefore, it's safe to convert it to pci_device with to_pci_dev().
>>
>> Fair engough !
>>
>>
> May I use  your reviewed-by sign in next version after that ?

I am not sure about the changes in the PCI subsystem. Since the code
here calls the new interface from that subsystem, I need acked-by on
that change before proceeding.

Best regards,
baolu

