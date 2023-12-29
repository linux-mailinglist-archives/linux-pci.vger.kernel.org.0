Return-Path: <linux-pci+bounces-1542-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B66AD81FE91
	for <lists+linux-pci@lfdr.de>; Fri, 29 Dec 2023 10:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71B8C284A9E
	for <lists+linux-pci@lfdr.de>; Fri, 29 Dec 2023 09:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8CF107B9;
	Fri, 29 Dec 2023 09:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VJqpknZz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB6B10A0A;
	Fri, 29 Dec 2023 09:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703841548; x=1735377548;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vNb64AnC3cBHyUn7yY6RO10YqcqqNyC1Y4V4OzI0I1E=;
  b=VJqpknZzNkzPe1SwG0zatNbHtOr49uUQr7hjUf2Sap7I8H/GlZlWc6u4
   UBih2rCT8Xf/T7weQw4sgC1YizfM7n7KhBO4y/q1Gj5mgXy1rKcVy5CzK
   zYU18ReieICih6Vp6JvM1enJaBNtWb3sm1EwZMpaeCz5odi//Bu67Z2MO
   nmCmRcM0Rvw9Vjmwt4wtT47jIZ9ImRhH1gLAoKFfT2xh5lxmlagj+JjRx
   vEuktX9+I61YIaz15aa/f2IdawnB4TQwxpWFYSbNmkCUNhYQW8u0KsqhZ
   im6PssioBUfs4OsvF9JNQ1cZ62WhuKxqvqciOfrS2PTRUl1FvoyqZgadp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="376792035"
X-IronPort-AV: E=Sophos;i="6.04,314,1695711600"; 
   d="scan'208";a="376792035"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 01:19:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="1110138041"
X-IronPort-AV: E=Sophos;i="6.04,314,1695711600"; 
   d="scan'208";a="1110138041"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.93.26.117]) ([10.93.26.117])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 01:19:05 -0800
Message-ID: <3ea89ca4-c6b2-469f-81fd-00bea2e9cac0@linux.intel.com>
Date: Fri, 29 Dec 2023 17:19:03 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v9 2/5] iommu/vt-d: break out ATS Invalidation if
 target device is gone
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "lukas@wunner.de" <lukas@wunner.de>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20231228001646.587653-1-haifeng.zhao@linux.intel.com>
 <20231228001646.587653-3-haifeng.zhao@linux.intel.com>
 <BN9PR11MB5276D70FD60FD1E0733B35AE8C9EA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <17725ef5-d777-420b-9586-4aade103282e@linux.intel.com>
 <BN9PR11MB5276ED0949E04BD25A4F91428C9DA@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <BN9PR11MB5276ED0949E04BD25A4F91428C9DA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/29/2023 4:06 PM, Tian, Kevin wrote:
>> From: Ethan Zhao <haifeng.zhao@linux.intel.com>
>> Sent: Thursday, December 28, 2023 9:03 PM
>>
>> On 12/28/2023 4:30 PM, Tian, Kevin wrote:
>>>> From: Ethan Zhao <haifeng.zhao@linux.intel.com>
>>>> Sent: Thursday, December 28, 2023 8:17 AM
>>>>
>>>> For those endpoint devices connect to system via hotplug capable ports,
>>>> users could request a warm reset to the device by flapping device's link
>>>> through setting the slot's link control register, as pciehp_ist() DLLSC
>>>> interrupt sequence response, pciehp will unload the device driver and
>>>> then power it off. thus cause an IOMMU device-TLB invalidation (Intel
>>>> VT-d spec, or ATS Invalidation in PCIe spec r6.1) request for device to
>>>> be sent and a long time completion/timeout waiting in interrupt context.
>>> is above describing the behavior of safe removal or surprise removal?
>> bring the link down is a kind of surprise removal for hotplug capable
>>
>> device.
> then it's better to make it clear from beginning that this is about surprise
> removal in which device is removed and cannot respond to on-going
> ATS invalidation request incurred in the removal process.
>
> safe removal should be immune from this problem as the device is still
> responsive in the whole removal process.
>
>>>> [ 4223.822628] Call Trace:
>>>> [ 4223.822628]  qi_flush_dev_iotlb+0xb1/0xd0
>>>> [ 4223.822628]  __dmar_remove_one_dev_info+0x224/0x250
>>>> [ 4223.822629]  dmar_remove_one_dev_info+0x3e/0x50
>>>> [ 4223.822629]  intel_iommu_release_device+0x1f/0x30
>>>> [ 4223.822629]  iommu_release_device+0x33/0x60
>>>> [ 4223.822629]  iommu_bus_notifier+0x7f/0x90
>>>> [ 4223.822630]  blocking_notifier_call_chain+0x60/0x90
>>>> [ 4223.822630]  device_del+0x2e5/0x420
>>>> [ 4223.822630]  pci_remove_bus_device+0x70/0x110
>>>> [ 4223.822630]  pciehp_unconfigure_device+0x7c/0x130
> I'm curious why this doesn't occur earlier when the device is
> detached from the driver. At that point presumably the device
> should be detached from the DMA domain which involves
> ATS invalidation too.
>
>>>>    	while (qi->desc_status[wait_index] != QI_DONE) {
>>>> +		/*
>>>> +		 * if the device-TLB invalidation target device is gone, don't
>>>> +		 * wait anymore, it might take up to 1min+50%, causes
>>>> system
>>>> +		 * hang. (see Implementation Note in PCIe spec r6.1 sec
>>>> 10.3.1)
>>>> +		 */
>>>> +		if ((type == QI_DIOTLB_TYPE || type == QI_DEIOTLB_TYPE)
>>>> && pdev)
>>>> +			if (!pci_device_is_present(pdev))
>>>> +				break;
>>> I'm not sure it's the right thing to do. Such check should be put in the
>>> caller which has the device pointer and can already know it's absent
>>> to not call those cache invalidation helpers.
>> Here is to handle such case, the invalidation request is sent, but the
>>
>> device is just pulled out at that moment.
>>
> one problem - the caller could pass multiple descriptors while type
> only refers to the 1st descriptor.

If the other invalidation request mixed together with ATS invalidation

in the descriptors passed to qi_submit_sync(), would be problem,

so far to Intel VT-d driver, I didn't see such kind of usage, perhaps

will see it later, no one could prevent that.

>
> btw is it an Intel specific problem? A quick glance at smmu driver
> suggests the same problem too:
>
>    arm_smmu_atc_inv_domain()
>      arm_smmu_cmdq_batch_submit()
>        arm_smmu_cmdq_issue_cmdlist()
>          arm_smmu_cmdq_poll_until_sync()
>            __arm_smmu_cmdq_poll_until_consumed()
>
> /*
>   * Wait until the SMMU cons index passes llq->prod.
>   * Must be called with the cmdq lock held in some capacity.
>   */
> static int __arm_smmu_cmdq_poll_until_consumed(struct arm_smmu_device *smmu,
>                                                 struct arm_smmu_ll_queue *llq)
>
> is there a more general way to solve it?

Surprise removal could happen anytime, depends on user,

no preparation could be done, so called 'surprise' :(


Thanks,

Ethan


