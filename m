Return-Path: <linux-pci+bounces-4071-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C99686871E
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 03:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 522C0284326
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 02:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8356FC6;
	Tue, 27 Feb 2024 02:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mPDv4pFx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D7436C;
	Tue, 27 Feb 2024 02:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709001044; cv=none; b=RofESql2fFFUPz4GQMzWTT37fzk1gCWAxWizw8XjmQOMnJuEK+6Biz2JSZ+s1CMeD7aTl3TpCqGYWDkzkuysCpfAjzATekglXLIGOLeU9BPGNedSfWnXWC6Ntra6uoKitxiMy2stDlrxJ2/rdBvGjEVxMTofQRQ4y332hxqw72g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709001044; c=relaxed/simple;
	bh=UagGQq26fo7AnvfpzpWjnBmT9Vl5hqO1p5x4gvxbh/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N7fd+7ygdBryZhSm4AuBa6S+B1sw3OVDUTKTrj5wxMU2kJRpNdT0ZCrYCcr/gNE1D3Na+OJRexyaxlQ/L3JHWexN9v6CNlbpOgxYThiFgCL2svGnVFHo0VQDUG9W6xlMVO8iUQokyyuN4cl3grqYt8PE1UaA2jEXglirY1zpTIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mPDv4pFx; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709001043; x=1740537043;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UagGQq26fo7AnvfpzpWjnBmT9Vl5hqO1p5x4gvxbh/I=;
  b=mPDv4pFxVEzNf77M1/B6ApNjlzuFfXZSaPkYc2JAhVlizQJNPfmJ4e7Y
   A/uu2T5P0cq7ORn+hqQ38LAGLJZSVJVh3l6Csp27cO05IP5ox9gtVDjXo
   9A4WqQvA1voLhUrjEEvZFkcDfqPj8qoK3sJFDYJMiCJJ1iMGJa3zf4YNm
   ZxXw+X8HPL2w+zbRdqG79bN1R1htby6fd4Ra18+9A33p95lDukzc96ZOy
   jcBIKJNGY21MmDNU6NqX6SZ1pRv23w8Te8QhpRxt+W88K+tGVBGK8gyJR
   nMLECP8/TSQz7cULqXHIQI/wTe5TN3assvk2Ie9F4QW0yrkX1pho00ddB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="13964226"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="13964226"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 18:30:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="7020310"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.124.229.115]) ([10.124.229.115])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 18:30:38 -0800
Message-ID: <ae9137f1-3e9b-4d84-956f-4e8c31d2e1bb@linux.intel.com>
Date: Tue, 27 Feb 2024 10:30:36 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 3/3] iommu/vt-d: improve ITE fault handling if target
 device isn't valid
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, baolu.lu@linux.intel.com,
 bhelgaas@google.com, robin.murphy@arm.com, jgg@ziepe.ca,
 kevin.tian@intel.com, dwmw2@infradead.org, will@kernel.org, lukas@wunner.de,
 yi.l.liu@intel.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20240226225234.GA211745@bhelgaas>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <20240226225234.GA211745@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/2024 6:52 AM, Bjorn Helgaas wrote:
> On Fri, Feb 23, 2024 at 10:29:28AM +0800, Ethan Zhao wrote:
>> On 2/22/2024 7:24 PM, Dan Carpenter wrote:
>>> On Thu, Feb 22, 2024 at 04:02:51AM -0500, Ethan Zhao wrote:
>>>> Because surprise removal could happen anytime, e.g. user could request safe
>>>> removal to EP(endpoint device) via sysfs and brings its link down to do
>>>> surprise removal cocurrently. such aggressive cases would cause ATS
>>>> invalidation request issued to non-existence target device, then deadly
>>>> loop to retry that request after ITE fault triggered in interrupt context.
>>>> this patch aims to optimize the ITE handling by checking the target device
>>>> presence state to avoid retrying the timeout request blindly, thus avoid
>>>> hard lockup or system hang.
>>>>
>>>> Devices are valid ATS invalidation request target only when they reside
>>>> in the iommu->device_rbtree (probed, not released) and present.
>>> "valid invalidation" is awkward wording.  Can we instead say:
>> If you read them together, sounds like tongue twister. but here "ATS
>> invalidation request target" is one term in PCIe spec.
> "ATS invalidation request target" does not appear in the PCIe spec.  I
> think you're trying to avoid sending ATS Invalidate Requests when you
> know they will not be completed.

I meant "ATS Invalidation Request" here is one term in PCIe spec, 'valid'
is used to describe the word 'target'.

This patch isn't intended to work as the same logic as patch [2/3], this
aims to break the blindly dead loop not to retry the timeout request after
ITE fault happened.

>
> It is impossible to reliably determine whether a device will be
> present and able to complete an Invalidate Request.  No matter what
> you check to determine that a device is present *now*, it may be
> removed before an Invalidate Request reaches it.

Here we check to see if the ITE fault was caused by device is not present.
The opposite logic, not predict the future, but find the cause of the fault
already happened, if pci_device_is_present() tells us the device isn't
there, it is reliable I think.

>
> If an Invalidate Request to a non-existent device causes a "deadly
> loop" (I'm not sure what that means) or a hard lockup or a system

There is a dead loop here to blindly retry to timeout request if
ITE happened, we want to break that loop if the target device was
gone.

> hang, something is wrong with the hardware.  There should be a
> mechanism to recover from a timeout in that situation.
>
> You can avoid sending Invalidate Requests to devices that have been

That logic works for simple safe /surprise removal as described in
patch[2/3], no race there that case at all.

> removed, and that will reduce the number of timeout cases.  But if you
> rely on a check like pci_device_is_present() or
> pci_dev_is_disconnected(), there is *always* an unavoidable race

We are not relying on pci_device_is_present() here in this patch to close
the race window between aggressive surprise removal and ATS invalidation
Request, we are doing post-fault handling here.

Thanks,
Ethan

> between a device removal and the Invalidate Request.
>
>>>> @@ -1273,6 +1273,9 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
>>>>    {
>>>>    	u32 fault;
>>>>    	int head, tail;
>>>> +	u64 iqe_err, ite_sid;
>>>> +	struct device *dev = NULL;
>>>> +	struct pci_dev *pdev = NULL;
>>>>    	struct q_inval *qi = iommu->qi;
>>>>    	int shift = qi_shift(iommu);
>>>> @@ -1317,6 +1320,13 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
>>>>    		tail = readl(iommu->reg + DMAR_IQT_REG);
>>>>    		tail = ((tail >> shift) - 1 + QI_LENGTH) % QI_LENGTH;
>>>> +		/*
>>>> +		 * SID field is valid only when the ITE field is Set in FSTS_REG
>>>> +		 * see Intel VT-d spec r4.1, section 11.4.9.9
>>>> +		 */
>>>> +		iqe_err = dmar_readq(iommu->reg + DMAR_IQER_REG);
>>>> +		ite_sid = DMAR_IQER_REG_ITESID(iqe_err);
>>>> +
>>>>    		writel(DMA_FSTS_ITE, iommu->reg + DMAR_FSTS_REG);
>>>>    		pr_info("Invalidation Time-out Error (ITE) cleared\n");
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
>>>> +			pdev = to_pci_dev(dev);
>>>> +			if (!pci_device_is_present(pdev) &&
>>>> +				ite_sid == pci_dev_id(pci_physfn(pdev)))
>>> The && confused me, but then I realized that probably "ite_sid ==
>>> pci_dev_id(pci_physfn(pdev))" is always true.  Can we delete that part?
>> Here is the fault handling, just double confirm nothing else goes wrong --
>> beyond the assumption.
>>
>>> 		pdev = to_pci_dev(dev);
>>> 		if (!pci_device_is_present(pdev))
>>> 			return -ENODEV;
>>>
>>>
>>>> +				return -ETIMEDOUT;
>>> -ENODEV.
>> The ATS invalidation request could be sent from userland in later code,
>> the userland code will care about the returned value,  -ENODEV is one aspect
>> of the fact (target device not present), while -ETIMEDOUT is another
>> (timeout happened). we couldn't return them both.
>>
>>>> +		}
>>>>    		if (qi->desc_status[wait_index] == QI_ABORT)
>>>>    			return -EAGAIN;
>>>>    	}
>>> Sorry, again for nit picking a v13 patch.  I'm not a domain expert but
>>> this patchset seems reasonable to me.
>> Though this is the v13, it is based on new rbtree code, you are welcome.
>>
>> Thanks,
>> Ethan
>>
>>> regards,
>>> dan carpenter

