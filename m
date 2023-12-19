Return-Path: <linux-pci+bounces-1159-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAD48181B0
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 07:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E583C286311
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 06:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E97847B;
	Tue, 19 Dec 2023 06:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zl69Towr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C9FC12F;
	Tue, 19 Dec 2023 06:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702969050; x=1734505050;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mSVq0ei1ZhTbZAEPnMZGOZvh41JnBeY5FmyS+VcWbM4=;
  b=Zl69TowrA76NgkFcEE1w8yHLJbXBST2xqMo6mxvGDl2AZKPPVoocWHER
   jevkKihNTFcu9UsdzpYIPOdt3REhZhEhs/X5V9usNFnWT7+3y8DOM1pFp
   BecX+QiqdgdCZZU33++Ywui0RtGY7Qln4BK8wMyGe2TkDaYg/2zlKtX1s
   mQzPdfiLEKcoOt18otaHN9e6Ch+CyiKG0lgIyWQz0jDfrjKzWqCC6dSrz
   TSymDH/Kf/vnzV+UY2iWz5nggM79Vqj+cslkuVbwD8b+YqgoCKseLMEfT
   665U27aTva1mvTnwYUD9tgVY3/LW2c67yD1CTyxQvBIoy7naDPE+ARA92
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="459957340"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="459957340"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 22:57:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="841784776"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="841784776"
Received: from xshi3x-mobl.ccr.corp.intel.com (HELO [10.255.31.117]) ([10.255.31.117])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 22:57:26 -0800
Message-ID: <f7dfdec4-ec52-44b0-9e04-bdcc3af2ba25@linux.intel.com>
Date: Tue, 19 Dec 2023 14:57:22 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, linux-pci@vger.kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iommu/vt-d: don's issue devTLB flush request when
 device is disconnected
Content-Language: en-US
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, bhelgaas@google.com,
 dwmw2@infradead.org, will@kernel.org, robin.murphy@arm.com, lukas@wunner.de
References: <20231217114902.3836260-1-haifeng.zhao@linux.intel.com>
 <20231217114902.3836260-3-haifeng.zhao@linux.intel.com>
 <ac0fd341-7def-485e-9f32-530cf8a83273@linux.intel.com>
 <a275032f-cb1d-4ccc-9418-9567aba6b343@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <a275032f-cb1d-4ccc-9418-9567aba6b343@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023/12/19 14:49, Ethan Zhao wrote:
>>> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
>>> index 74e8e4c17e81..182eb5df244d 100644
>>> --- a/drivers/iommu/intel/pasid.c
>>> +++ b/drivers/iommu/intel/pasid.c
>>> @@ -476,6 +476,23 @@ devtlb_invalidation_with_pasid(struct 
>>> intel_iommu *iommu,
>>>   {
>>>       struct device_domain_info *info;
>>>       u16 sid, qdep, pfsid;
>>> +    struct pci_dev *pdev;
>>> +
>>> +    pdev = to_pci_dev(dev);
>>> +    if (!pdev)
>>> +        return;
>>> +
>>> +    /*
>>> +     * If endpoint device's link was brough down by user's pci 
>>> configuration
>>> +     * access to it's hotplug capable slot link control register, as 
>>> sequence
>>> +     * response for DLLSC, pciehp_ist() will set the device 
>>> error_state to
>>> +     * pci_channel_io_perm_failure. Checking device's state here to 
>>> avoid
>>> +     * issuing meaningless devTLB flush request to it, that might 
>>> cause lockup
>>> +     * warning or deadlock because too long time waiting in 
>>> interrupt context.
>>> +     */
>>> +
>>> +    if (pci_dev_is_disconnected(pdev))
>>> +        return;
>>>         info = dev_iommu_priv_get(dev);
>>>       if (!info || !info->ats_enabled)
>>
>> It's likely better to check the device status after verifying
>> ats_enabled. How about below change?
>>
>> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
>> index 74e8e4c17e81..fa19c6cdfd8b 100644
>> --- a/drivers/iommu/intel/pasid.c
>> +++ b/drivers/iommu/intel/pasid.c
>> @@ -481,6 +481,9 @@ devtlb_invalidation_with_pasid(struct intel_iommu 
>> *iommu,
>>         if (!info || !info->ats_enabled)
>>                 return;
>>
>> +       if (pci_dev_is_disconnected(to_pci_dev(dev)))
> 
> I like this kind of simplicity, but rationalist always brings me back to 
> the no-error(ugly)
> 
> style.  🙂

The rational is that Intel IOMMU driver only supports PCI ATS. So if
device is marked as ATS supported, then it must be a PCI device.
Therefore, it's safe to convert it to pci_device with to_pci_dev().

If you move this up before ATS checking, then you need to check
dev_is_pci().

Best regards,
baolu

