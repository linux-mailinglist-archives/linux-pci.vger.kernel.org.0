Return-Path: <linux-pci+bounces-2771-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D340E841D8C
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 09:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32617B27DA8
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 08:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AD959163;
	Tue, 30 Jan 2024 08:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T065rq0R"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B441158ABC;
	Tue, 30 Jan 2024 08:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706602563; cv=none; b=Cxm7rgv+Tkp33REwI2rHCYIJJDr69lcJ3DFFCRvIcemctTABekC5anmV3oWbzmDczmMAMaBWteM7uxPeu0efeUU+L4qF6iIEWKI6CwC0wMMYOsMbewG/jVox8QhD0wJGi9q5VI2Hxkht2FbYnjY4HLYcJcf3UNhOkuaM2g0q10g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706602563; c=relaxed/simple;
	bh=w/ipZ2tpfckUhU8OSONcLchNKVSsXi2i9jMUEnMCFas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZkdRzm4uXzSi6favNLH/yeH9zr2sAOb9IAIMkrvD5G0ooP+coZeHT9YMR7Q0JML6XEy5Tfytzd05bympcfTxhAAs6OqjZaSQgrdnJFD3COY62dTGkbQMg/AmWdIMCFlJD9o/ltVvsVEqE63+ZAuDXkiQPTanI+ZvEG67v68JgUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T065rq0R; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706602561; x=1738138561;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=w/ipZ2tpfckUhU8OSONcLchNKVSsXi2i9jMUEnMCFas=;
  b=T065rq0Rwjdz0FGTaMLUkaiVy9XW71If7SjKPvOr//XaV9PbCidLjFQM
   kSog6i1DvZBXMomxTl8wND3mrsFaBFzflFK6ClW2BfW+YNvdG8Aif8yxp
   9LUm0+fxQJ+fqX6kPowHXu543+6ZwSSPy/aPdDLrYJAKGcgdggR5YR/IK
   DFbSqrSfR2pckyOUUxS119sy8hpkulhObLHzQsViwf1VjAi/cZvsXE+ZH
   oMdpp/Rf9phO2wLRifNwmVYt3SbJxWmUwpz7kCPoOP7uBadJG9J9X4xsT
   smVqCeqZqISutXpM+7rurhDUKV8YFrVUQBMWyKfhDhkiYBtq5eUtzFnm7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="393635837"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="393635837"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 00:15:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="961181350"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="961181350"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.249.174.131]) ([10.249.174.131])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 00:15:36 -0800
Message-ID: <500c4582-ec05-4a9e-9b68-d2ae19aed49b@linux.intel.com>
Date: Tue, 30 Jan 2024 16:15:33 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 5/5] iommu/vt-d: improve ITE fault handling if target
 device isn't present
To: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
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
 <0aee453c-e98f-4b72-8107-31d4731abcdb@linux.intel.com>
 <BN9PR11MB5276D3372267CE9246170FA78C7D2@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <BN9PR11MB5276D3372267CE9246170FA78C7D2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/30/2024 2:22 PM, Tian, Kevin wrote:
>> From: Ethan Zhao <haifeng.zhao@linux.intel.com>
>> Sent: Tuesday, January 30, 2024 1:13 PM
>>
>> On 1/29/2024 5:21 PM, Yi Liu wrote:
>>> On 2024/1/29 17:06, Tian, Kevin wrote:
>>>>> From: Ethan Zhao <haifeng.zhao@linux.intel.com>
>>>>> Sent: Monday, January 29, 2024 11:49 AM
>>>>>
>>>>> Because surprise removal could happen anytime, e.g. user could
>>>>> request safe
>>>>> removal to EP(endpoint device) via sysfs and brings its link down to do
>>>>> surprise removal cocurrently. such aggressive cases would cause ATS
>>>>> invalidation request issued to non-existence target device, then deadly
>>>>> loop to retry that request after ITE fault triggered in interrupt
>>>>> context.
>>>>> this patch aims to optimize the ITE handling by checking the target
>>>>> device
>>>>> presence state to avoid retrying the timeout request blindly, thus
>>>>> avoid
>>>>> hard lockup or system hang.
>>>>>
>>>>> Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
>>>>> ---
>>>>>    drivers/iommu/intel/dmar.c | 18 ++++++++++++++++++
>>>>>    1 file changed, 18 insertions(+)
>>>>>
>>>>> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
>>>>> index 814134e9aa5a..2e214b43725c 100644
>>>>> --- a/drivers/iommu/intel/dmar.c
>>>>> +++ b/drivers/iommu/intel/dmar.c
>>>>> @@ -1272,6 +1272,7 @@ static int qi_check_fault(struct intel_iommu
>>>>> *iommu, int index, int wait_index,
>>>>>    {
>>>>>        u32 fault;
>>>>>        int head, tail;
>>>>> +    u64 iqe_err, ite_sid;
>>>>>        struct q_inval *qi = iommu->qi;
>>>>>        int shift = qi_shift(iommu);
>>>>>
>>>>> @@ -1316,6 +1317,13 @@ static int qi_check_fault(struct intel_iommu
>>>>> *iommu, int index, int wait_index,
>>>>>            tail = readl(iommu->reg + DMAR_IQT_REG);
>>>>>            tail = ((tail >> shift) - 1 + QI_LENGTH) % QI_LENGTH;
>>>>>
>>>>> +        /*
>>>>> +         * SID field is valid only when the ITE field is Set in
>>>>> FSTS_REG
>>>>> +         * see Intel VT-d spec r4.1, section 11.4.9.9
>>>>> +         */
>>>>> +        iqe_err = dmar_readq(iommu->reg + DMAR_IQER_REG);
>>>>> +        ite_sid = DMAR_IQER_REG_ITESID(iqe_err);
>>>>> +
>>>>>            writel(DMA_FSTS_ITE, iommu->reg + DMAR_FSTS_REG);
>>>>>            pr_info("Invalidation Time-out Error (ITE) cleared\n");
>>>>>
>>>>> @@ -1325,6 +1333,16 @@ static int qi_check_fault(struct intel_iommu
>>>>> *iommu, int index, int wait_index,
>>>>>                head = (head - 2 + QI_LENGTH) % QI_LENGTH;
>>>>>            } while (head != tail);
>>>>>
>>>>> +        /*
>>>>> +         * If got ITE, we need to check if the sid of ITE is the
>>>>> same as
>>>>> +         * current ATS invalidation target device, if yes, don't
>>>>> try this
>>>>> +         * request anymore if the target device isn't present.
>>>>> +         * 0 value of ite_sid means old VT-d device, no ite_sid value.
>>>>> +         */
>>>>> +        if (pdev && ite_sid && !pci_device_is_present(pdev) &&
>>>>> +            ite_sid == pci_dev_id(pci_physfn(pdev)))
>>>>> +            return -ETIMEDOUT;
>>>>> +
>>>> since the hardware already reports source id leading to timeout,
>>>> can't we
>>>> just find the pci_dev according to reported ite_sid? this is a slow
>>>> path (either
>>>> due to device in bad state or removed) hence it's not necessary to
>>>> add more
>>>> intelligence to pass the pci_dev in, leading to only a partial fix
>>>> can be backported.
>>>>
>>>> It's also more future-proof, say if one day the driver allows
>>>> batching invalidation
>>>> requests for multiple devices then no need to pass in a list of devices.
>>>>
>>>> Then it's easier to backport a full fix.
>>> May consider pci_get_domain_bus_and_slot() or
>>> pci_find_bus()/pci_get_slot(). But I doubt if the pci_dev is still
>>> tracked
>>> in the bus or a kind of dev list in the device hot removal case. So Ethan
>>> may need to check.
>> Perhaps it is too late to call pci_find_bus() or
>> pci_get_domain_bus_and_slot() to get the
>>
>> device instance from this notifier registered as
>> BUS_NOTIFY_REMOVED_DEVICE
>>
>> action. if the device is still there in bus list, *must* be a bug of
>> device subsystem as
>>
>> *removed* device.
>>
> Ethan, looks your reply is not formatted well. Can you fix your mail
> client like how you write the commit msg?
Sorry for the mail format.
> Here we need consider two situations.
>
> One is that the device is not bound to a driver or bound to a driver
> which doesn't do active work to the device when it's removed. In
> that case one may observe the timeout situation only in the removal
> path as the stack dump in your patch02 shows.

When iommu_bus_notifier() got called for hotplug removal cases to
flush devTLB (ATS invalidation), driver was already unloaded.
whatever safe removal or surprise removal. so in theory no active
driver working there.

pciehp_ist()
  pciehp_disable_slot()
   remove_board()
    pciehp_unconfigure_device()
     pci_stop_and_remove_bus_device()
      pci_stop_bus_device()--->here unload driver
      pci_remove_bus_device()->here qi_flush_dev_iotlb() got called.

>
> patch02 can fix that case by checking whether the device is present
> to skip sending the invalidation requests. So the logic being discussed
> here doesn't matter.
>
> The 2nd situation is more tricky. The device might be bound to
> a driver which is doing active work to the device with in-fly
> ATS invalidation requests. In this case in-fly requests must be aborted
> before the driver can be detached from the removed device. Conceptually
> a device is removed from the bus only after its driver is detached.

Some tricky situations:

1. The ATS invalidation request is issued from driver driver, while it is
in handling, device is removed. this momment, the device instance still
exists in the bus list. yes, if searching it by BDF, could get it.

2. The ATS invalidation request is issued from iommu_bus_notifier()
for surprise removal reason, as shown in above calltrace, device was
already removed from bus list. if searching it by BDF, return NULL.

3. The ATS invlidation request is issued from iommu_bus_notifier()
for safe removal, when is in handling, device is removed or link
is down. also as #2, device was already removed from bus list.
if searching it by BDF. got NULL.
...

so, searching device by BDF, only works for the ATS invalidation
request is from device driver.

Thanks,
Ethan

>
>  From this angle you can still find the pci_dev from the bus when handling
> timeout error for in-fly invalidation requests. But I'm not a PCI person
> so let's wait for the inputs from Bjorn  and Lukas.
>
>

