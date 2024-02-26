Return-Path: <linux-pci+bounces-3988-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9289866851
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 03:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B3A52817FC
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 02:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6320F4E2;
	Mon, 26 Feb 2024 02:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RhBdFQfF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472C6FC18;
	Mon, 26 Feb 2024 02:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708915712; cv=none; b=R5Ma5nfToBnaIhcN8eNaH+9XEbd9PGoAeOZwEP/aDs/4y7mmag1ia8l4HQNC3ITRvj9O0uQEmfEcrLM8CKX7bnjPsW9Ao1Iae5bxnRQ5QPfswVhHFh9lH65sxzBmaHwCRzs/zSQIh8ERBjvxwrUOA31uL2Bb4J3seQkJ2Tf2mjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708915712; c=relaxed/simple;
	bh=m13GnJ6jRnxtBNzF5syjVlJjm5bbUfD6PW5EC6Oq4CU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GW2ZE78+8l22IbdDeJ0lC0h0K94oQZGTFqdrChg/V+ri91Cu7GLOHTp1+OVqExmciyHsCyqyZKEOKyIP1sssUtn7XxcDnhTo8rIpWCZBnKURvIujaq9/uaw1JdbTvDLaFYVhZPeOnmtXbNTPwGuyueurgY1wqKPCSRyXS6VydKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RhBdFQfF; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708915710; x=1740451710;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=m13GnJ6jRnxtBNzF5syjVlJjm5bbUfD6PW5EC6Oq4CU=;
  b=RhBdFQfFpMPX0W41z+1NMJso7i+AFCit6+1FBUV0Ou0N7uJiGvm01r6B
   XNEiR2yeeWWvsukTcqLqolAB7b9GSFMRWus9lPj9erlljxn3wJmphDbdG
   Ct3tUhj7Y3PZp2CdJ5n8aic4zleFtaSZ9mYAS9lla3dorhmmdlQamoF5a
   YFN2tIOS5Bj5cmwaqCWjmvZxEQ5RmhrCiGwJKKyprVRoWKYze+ilgnmfO
   Y+TxzLimAfJJB/08AkTYbVcJsaWamt0yRtaUn7l1q4peeQ9ucnKp02Dgg
   3XmUHVShn+rgUJu9TYllObxek+8N131vznA6U/UBQ96Lz90IJFhPnumqk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="14615945"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="14615945"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 18:48:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="43994065"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.124.229.115]) ([10.124.229.115])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 18:48:26 -0800
Message-ID: <9b31ef51-51c9-42e4-b113-4d5e422b5173@linux.intel.com>
Date: Mon, 26 Feb 2024 10:48:23 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 3/3] iommu/vt-d: improve ITE fault handling if target
 device isn't valid
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: baolu.lu@linux.intel.com, bhelgaas@google.com, robin.murphy@arm.com,
 jgg@ziepe.ca, kevin.tian@intel.com, dwmw2@infradead.org, will@kernel.org,
 lukas@wunner.de, yi.l.liu@intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20240222090251.2849702-1-haifeng.zhao@linux.intel.com>
 <20240222090251.2849702-4-haifeng.zhao@linux.intel.com>
 <c655cd15-c883-483b-b698-b1b7ae360388@moroto.mountain>
 <2d1788da-521c-4531-a159-81d2fb801d6c@linux.intel.com>
 <039a19e5-d1ff-47ae-aa35-3347c08acc13@moroto.mountain>
 <31ee6660-ad4a-40b8-8503-ebc3ed06dd16@linux.intel.com>
 <f779be97-66c2-4520-91f2-a9a54e84017c@moroto.mountain>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <f779be97-66c2-4520-91f2-a9a54e84017c@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/23/2024 4:19 PM, Dan Carpenter wrote:
> On Fri, Feb 23, 2024 at 03:32:52PM +0800, Ethan Zhao wrote:
>> On 2/23/2024 2:08 PM, Dan Carpenter wrote:
>>> On Fri, Feb 23, 2024 at 10:29:28AM +0800, Ethan Zhao wrote:
>>>>>> @@ -1326,6 +1336,21 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
>>>>>>     			head = (head - 2 + QI_LENGTH) % QI_LENGTH;
>>>>>>     		} while (head != tail);
>>>>>> +		/*
>>>>>> +		 * If got ITE, we need to check if the sid of ITE is one of the
>>>>>> +		 * current valid ATS invalidation target devices, if no, or the
>>>>>> +		 * target device isn't presnet, don't try this request anymore.
>>>>>> +		 * 0 value of ite_sid means old VT-d device, no ite_sid value.
>>>>>> +		 */
>>>>> This comment is kind of confusing.
>>>> Really confusing ? this is typo there, resnet-> "present"
>>>>
>>> Reading this comment again, the part about zero ite_sid values is
>>> actually useful, but what does "old" mean in "old VT-d device".  How old
>>> is it?  One year old?
>> I recite the description from Intel VT-d spec here
>>
>> "A value of 0 in this field indicates that this is an older version of DMA
>> remapping hardware which does not provide additional details about
>> the Invalidation Time-out Error"
>>
> This is good.  Put that in the comment.  Otherwise it's not clear.  I

Sure.

> assumed "old" meant released or something.
>
>
>> At least, the Intel VT-d spec 4.0 released 2022 June says the same thing.
>> as to how old, I didn't find docs older than that, really out of my radar.
>>
>>>>> /*
>>>>>     * If we have an ITE, then we need to check whether the sid of the ITE
>>>>>     * is in the rbtree (meaning it is probed and not released), and that
>>>>>     * the PCI device is present.
>>>>>     */
>>>>>
>>>>> My comment is slightly shorter but I think it has the necessary
>>>>> information.
>>>>>
>>>>>> +		if (ite_sid) {
>>>>>> +			dev = device_rbtree_find(iommu, ite_sid);
>>>>>> +			if (!dev || !dev_is_pci(dev))
>>>>>> +				return -ETIMEDOUT;
>>>>> -ETIMEDOUT is weird.  The callers don't care which error code we return.
>>>>> Change this to -ENODEV or something
>>>> -ETIMEDOUT means prior ATS invalidation request hit timeout fault, and the
>>>> caller really cares about the returned value.
>>>>
>>> I don't really care about the return value and if you say it should be
>>> -ETIMEDOUT, then you're the expert.  However, I don't see anything in
>>> linux-next which cares about the return values except -EAGAIN.
>>> This function is only called from qi_submit_sync() which checks for
>>> -EAGAIN.  Then I did a git grep.
>>>
>>> $ git grep qi_submit_sync
>>> drivers/iommu/intel/dmar.c:int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
>>> drivers/iommu/intel/dmar.c:     qi_submit_sync(iommu, &desc, 1, 0);
>>> drivers/iommu/intel/dmar.c:     qi_submit_sync(iommu, &desc, 1, 0);
>>> drivers/iommu/intel/dmar.c:     qi_submit_sync(iommu, &desc, 1, 0);
>>> drivers/iommu/intel/dmar.c:     qi_submit_sync(iommu, &desc, 1, 0);
>>> drivers/iommu/intel/dmar.c:     qi_submit_sync(iommu, &desc, 1, 0);
>>> drivers/iommu/intel/dmar.c:     qi_submit_sync(iommu, &desc, 1, 0);
>>> drivers/iommu/intel/dmar.c:     qi_submit_sync(iommu, &desc, 1, 0);
>>> drivers/iommu/intel/iommu.h:int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
>>> drivers/iommu/intel/iommu.h: * Options used in qi_submit_sync:
>>> drivers/iommu/intel/irq_remapping.c:    return qi_submit_sync(iommu, &desc, 1, 0);
>>> drivers/iommu/intel/pasid.c:    qi_submit_sync(iommu, &desc, 1, 0);
>>> drivers/iommu/intel/svm.c:      qi_submit_sync(iommu, desc, 3, QI_OPT_WAIT_DRAIN);
>>> drivers/iommu/intel/svm.c:      qi_submit_sync(iommu, &desc, 1, 0);
>>> drivers/iommu/intel/svm.c:              qi_submit_sync(iommu, &desc, 1, 0);
>>>
>>> Only qi_flush_iec() in irq_remapping.c cares about the return.  Then I
>>> traced those callers back and nothing cares about -ETIMEOUT.
>>>
>>> Are you refering to patches that haven't ben merged yet?
>> Yes, patches under working, not the code running on your boxes.
>>
>> -ETIMEOUT & -ENODEV, they both describe the error that is happenning, someone
>> prefers -ETIMEOUT, they would like to know the request was timeout, and someone
>> perfers -ENODEV, they know the target device is gone, ever existed.
> Okay.  I obviously can't comment on patches that I haven't seen but,
> sure, it sounds reasonable.
>
>>>>>> +			pdev = to_pci_dev(dev);
>>>>>> +			if (!pci_device_is_present(pdev) &&
>>>>>> +				ite_sid == pci_dev_id(pci_physfn(pdev)))
>>>>> The && confused me, but then I realized that probably "ite_sid ==
>>>>> pci_dev_id(pci_physfn(pdev))" is always true.  Can we delete that part?
>>>> Here is the fault handling, just double confirm nothing else goes wrong --
>>>> beyond the assumption.
>>>>
>>> Basically for that to ever be != it would need some kind of memory
>>> corruption?  I feel like in that situation, the more conservative thing
>>> is to give up.  If the PCI device is not present then just give up.
>> memory corruption, buggy BIOS tables, faked request ...something out
>> of imagination, after confirmed the device is what it claimed to be, if
>> not present, then give up to retry the request.
> This is not correct.  We looked up the device based on the ite_sid so
> we know what the device id is, unless we experience catastrophic memory
> corruption.
>
> +                       dev = device_rbtree_find(iommu, ite_sid);
>                                                          ^^^^^^^
> We looked it up here.
>
> +                       if (!dev || !dev_is_pci(dev))
> +                               return -ETIMEDOUT;
> +                       pdev = to_pci_dev(dev);
> +                       if (!pci_device_is_present(pdev) &&
> +                               ite_sid == pci_dev_id(pci_physfn(pdev)))
>                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Unless the device_rbtree_find() is returning garbage then these things
> must be true.
>
> +                               return -ETIMEDOUT;
>
> I tried to double check how we were storing devices into the rbtree,
> but then I discovered that the device_rbtree_find() doesn't exist in
> linux-next and this patch breaks the build.

This patchset is based on Baolu's rbtree patchset,
https://lkml.org/lkml/2024/2/15/147
I mentioned that in the cover-letter (and the base commit tag).

>
> This is very frustrating thing.  But let's say a buggy BIOS could mess

Buggy BIOS dmar table etc doesn't corrupt the rbtree, but might feed rbtree
with inconsistent info about iommu and pci device.

e.g. the device exists, present, but in fact, the device doesn't belong to the
iommu the BIOS table claimed, if devTLB invalidation sent to such target, we
will get ITE too, but here it isn't be handled. we will deal with that case in
other patches.

The key used to index rbtree is device_domain_info->bus, device_domain_info->
devfn, see intel_iommu_probe_device(), these values not always be the same
as pdev, such as the device is vmd/VF etc, here we only handle the case we intend
to handle ---the hot removal of physical device.

Thanks,
Ethan

> up the rbtree.  In that situation, we would still want to change the &&
> to an ||.  If the divice is not present and^W or the rbtree is corrupted
> then return an error.  But don't do this.  If the memory is corrupted we
> are already screwed and there is no way the system can really recover
> in any reasonable way.
>
> regards,
> dan carpenter
>

