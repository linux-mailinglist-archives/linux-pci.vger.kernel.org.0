Return-Path: <linux-pci+bounces-4175-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 286E386AAA2
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 10:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 483201C253CE
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 09:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A20A2E84F;
	Wed, 28 Feb 2024 09:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LaSmTbZ9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FD92E419;
	Wed, 28 Feb 2024 09:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110818; cv=none; b=D7p6bkxxqeX9gPdhxwNm929XdZHc59CZjDs9QHTe3KI778iM8TN/p2j67x33vyz/aT2scMXhRnnS0iXplNxqsuho8aw3wntF1bOELPuv5KqJgLA2rlaNnJSPLoCIfov7VqCKtLDoIgs/PQA+BpdYZxfpI3ZgESiWPSO4t8LMrW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110818; c=relaxed/simple;
	bh=vsh9jGxQjjvBWK3B4oQcW0pqzFbEoSreLHkQicRRkn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XqbSYHmtI/d4Tys9la7W1jF2p00xaxPm/3Ghvge9UjKiYIquv1WL4nZ5A4lNH/Gq5w572AY5g3JAmaIEVRB34DoLCwS3IxN0p7Ohz0HbpAvTbXQj1g3ewYTchezQyiiI6+v9JE0n/0il1sYKDirisU5wGLzoKHhSAt+zMYlt44Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LaSmTbZ9; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709110816; x=1740646816;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vsh9jGxQjjvBWK3B4oQcW0pqzFbEoSreLHkQicRRkn8=;
  b=LaSmTbZ9SBV3mflqI845r+3zLA8QyMSxE4v3mNpFY3IYyc6cTcI7+BJu
   el755Ws326R1VlwsOWV+MaS+nxSt2SadeL/hnsY21gF3Kbdhpxy4DJ3OR
   8aD6b8S9bsV3K9raqG6mfRzMCqmsp2DOZDf/W0zwaue+o5JfljG2M1P/L
   gkI1cSVjgIG+kjPPG2vD8hgq7YaS/Iq2d4L4+Z0salhDesgE8F0GZiRAC
   HXLExSWG1cwHLKBIMrDkoIN5qi8i1aL34gLVRS7DWWGL7h0tevYa4Enzk
   +wfiogOPgTtSNSNx7PaloJAKFGIxARHqNC1+cORh5vwbKzNCILIVu1bh0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3421075"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="3421075"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 01:00:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="7396998"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.124.229.115]) ([10.124.229.115])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 01:00:12 -0800
Message-ID: <eac3e9e7-657f-4de2-b9ed-878ffc2b93cb@linux.intel.com>
Date: Wed, 28 Feb 2024 17:00:09 +0800
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
>
> It is impossible to reliably determine whether a device will be
> present and able to complete an Invalidate Request.  No matter what
> you check to determine that a device is present *now*, it may be
> removed before an Invalidate Request reaches it.
>
> If an Invalidate Request to a non-existent device causes a "deadly
> loop" (I'm not sure what that means) or a hard lockup or a system
> hang, something is wrong with the hardware.  There should be a

The hardware might be innocent, here in the qi_submit_sync() &
qi_check_fault() will retry the timeout request forever if the
target device is gone or the target device always takes too much
time to reponse. there is dead loop here.

This patch aims to break the dead loop for case device is not
present anymore.

But for those devices takes too much time to complete. I am
working on other patches, not in this patchset.


Thanks,
Ethan

> mechanism to recover from a timeout in that situation.
>
> You can avoid sending Invalidate Requests to devices that have been
> removed, and that will reduce the number of timeout cases.  But if you
> rely on a check like pci_device_is_present() or
> pci_dev_is_disconnected(), there is *always* an unavoidable race
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

