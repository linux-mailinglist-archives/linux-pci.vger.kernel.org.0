Return-Path: <linux-pci+bounces-3910-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 350B9860B59
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 08:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BDA91C21819
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 07:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F0F1401D;
	Fri, 23 Feb 2024 07:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KzJ2TjQh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E456111CB3;
	Fri, 23 Feb 2024 07:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708673582; cv=none; b=nMdvwZvpVHc+8wbfdEbDqFHk/hv77i0yKruadnwMG1rnkXVMmirS+s7e69P2KhuvrdLqdX1KkK/kHMSXlfaBngTbi2cppkzS/A3Hc2Zq2/Cah63C23oAE/jR+z6YRSo2qWdJD/pQL0buXDVnBpkKszWmGzUk54bvAobyYdN8Wlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708673582; c=relaxed/simple;
	bh=R92CoumjcALDXEVxAClsxHfOGBrWk4jjP9zMssjhERw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FEcpYHyqU3swR4+5G+tgZ6tJCuNkn1+dI5Byoa/CupFjQXCf/bshAvudL/7MJnY8r3XyVJxoKyr1PnF2vq+mcWvWd+296ELfd7LLoZy13XSRb9SFi4AJdLLxls1PdAJS/ZVXQeJRZeoFCieCOPFe2nHjqSNwPCR8bV4W30VWeHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KzJ2TjQh; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708673580; x=1740209580;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=R92CoumjcALDXEVxAClsxHfOGBrWk4jjP9zMssjhERw=;
  b=KzJ2TjQhsX5GgS0rdjU+975MN2SkyNfCrFurCwnD9Dm+6XsF9TlLFgEr
   0s8a416H6XE61Dg0hhBzCssWOm7mXGsM6HbXTcQVxU2Poz5WiRuUonTU6
   AYL12GE8BqaZhRtxO12LyVHjAkB4K0Y2YFVrXYkYB1w1SSbrCQbUECGxc
   tupfscVxxQEaZFNIuYMSwq/UTp5rYtfZcuMF37fXvmPXRVqtV/TAfFGHT
   37b75CmeYpMKiXWh/5lKT2bGer5+3GNiocPjDb5mpGNIaxLXA7yC9rt43
   pVp4ZDltPawfyaoQXom9hftBe+Wbu7198lcUzNBX9D0Dn7JxG7OylxrX5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="2844900"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="2844900"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 23:32:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="10429348"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.255.30.59]) ([10.255.30.59])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 23:32:56 -0800
Message-ID: <31ee6660-ad4a-40b8-8503-ebc3ed06dd16@linux.intel.com>
Date: Fri, 23 Feb 2024 15:32:52 +0800
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
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <039a19e5-d1ff-47ae-aa35-3347c08acc13@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/23/2024 2:08 PM, Dan Carpenter wrote:
> On Fri, Feb 23, 2024 at 10:29:28AM +0800, Ethan Zhao wrote:
>>>> @@ -1326,6 +1336,21 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
>>>>    			head = (head - 2 + QI_LENGTH) % QI_LENGTH;
>>>>    		} while (head != tail);
>>>> +		/*
>>>> +		 * If got ITE, we need to check if the sid of ITE is one of the
>>>> +		 * current valid ATS invalidation target devices, if no, or the
>>>> +		 * target device isn't presnet, don't try this request anymore.
>>>> +		 * 0 value of ite_sid means old VT-d device, no ite_sid value.
>>>> +		 */
>>> This comment is kind of confusing.
>> Really confusing ? this is typo there, resnet-> "present"
>>
> Reading this comment again, the part about zero ite_sid values is
> actually useful, but what does "old" mean in "old VT-d device".  How old
> is it?  One year old?

I recite the description from Intel VT-d spec here

"A value of 0 in this field indicates that this is an older version of DMA
remapping hardware which does not provide additional details about
the Invalidation Time-out Error"

At least, the Intel VT-d spec 4.0 released 2022 June says the same thing.
as to how old, I didn't find docs older than that, really out of my radar.

>
>>> /*
>>>    * If we have an ITE, then we need to check whether the sid of the ITE
>>>    * is in the rbtree (meaning it is probed and not released), and that
>>>    * the PCI device is present.
>>>    */
>>>
>>> My comment is slightly shorter but I think it has the necessary
>>> information.
>>>
>>>> +		if (ite_sid) {
>>>> +			dev = device_rbtree_find(iommu, ite_sid);
>>>> +			if (!dev || !dev_is_pci(dev))
>>>> +				return -ETIMEDOUT;
>>> -ETIMEDOUT is weird.  The callers don't care which error code we return.
>>> Change this to -ENODEV or something
>> -ETIMEDOUT means prior ATS invalidation request hit timeout fault, and the
>> caller really cares about the returned value.
>>
> I don't really care about the return value and if you say it should be
> -ETIMEDOUT, then you're the expert.  However, I don't see anything in
> linux-next which cares about the return values except -EAGAIN.
> This function is only called from qi_submit_sync() which checks for
> -EAGAIN.  Then I did a git grep.
>
> $ git grep qi_submit_sync
> drivers/iommu/intel/dmar.c:int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
> drivers/iommu/intel/dmar.c:     qi_submit_sync(iommu, &desc, 1, 0);
> drivers/iommu/intel/dmar.c:     qi_submit_sync(iommu, &desc, 1, 0);
> drivers/iommu/intel/dmar.c:     qi_submit_sync(iommu, &desc, 1, 0);
> drivers/iommu/intel/dmar.c:     qi_submit_sync(iommu, &desc, 1, 0);
> drivers/iommu/intel/dmar.c:     qi_submit_sync(iommu, &desc, 1, 0);
> drivers/iommu/intel/dmar.c:     qi_submit_sync(iommu, &desc, 1, 0);
> drivers/iommu/intel/dmar.c:     qi_submit_sync(iommu, &desc, 1, 0);
> drivers/iommu/intel/iommu.h:int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
> drivers/iommu/intel/iommu.h: * Options used in qi_submit_sync:
> drivers/iommu/intel/irq_remapping.c:    return qi_submit_sync(iommu, &desc, 1, 0);
> drivers/iommu/intel/pasid.c:    qi_submit_sync(iommu, &desc, 1, 0);
> drivers/iommu/intel/svm.c:      qi_submit_sync(iommu, desc, 3, QI_OPT_WAIT_DRAIN);
> drivers/iommu/intel/svm.c:      qi_submit_sync(iommu, &desc, 1, 0);
> drivers/iommu/intel/svm.c:              qi_submit_sync(iommu, &desc, 1, 0);
>
> Only qi_flush_iec() in irq_remapping.c cares about the return.  Then I
> traced those callers back and nothing cares about -ETIMEOUT.
>
> Are you refering to patches that haven't ben merged yet?

Yes, patches under working, not the code running on your boxes.

-ETIMEOUT & -ENODEV, they both describe the error that is happenning, someone
prefers -ETIMEOUT, they would like to know the request was timeout, and someone
perfers -ENODEV, they know the target device is gone, ever existed.

>>>> +			pdev = to_pci_dev(dev);
>>>> +			if (!pci_device_is_present(pdev) &&
>>>> +				ite_sid == pci_dev_id(pci_physfn(pdev)))
>>> The && confused me, but then I realized that probably "ite_sid ==
>>> pci_dev_id(pci_physfn(pdev))" is always true.  Can we delete that part?
>> Here is the fault handling, just double confirm nothing else goes wrong --
>> beyond the assumption.
>>
> Basically for that to ever be != it would need some kind of memory
> corruption?  I feel like in that situation, the more conservative thing
> is to give up.  If the PCI device is not present then just give up.

memory corruption, buggy BIOS tables, faked request ...something out
of imagination, after confirmed the device is what it claimed to be, if
not present, then give up to retry the request.

Thanks,
Ethan

>
> regards,
> dan carpenter
>

