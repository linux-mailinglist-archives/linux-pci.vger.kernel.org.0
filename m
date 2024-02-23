Return-Path: <linux-pci+bounces-3905-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E3E8608D7
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 03:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C53F1F23474
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 02:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB785BE4E;
	Fri, 23 Feb 2024 02:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UA//yCiM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96430BE48;
	Fri, 23 Feb 2024 02:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708655380; cv=none; b=gPHsiw6l07Xju8oqG61stK7XCjrWc/Ifmaq7gOCxivGgxSsRu9yuuw71vpJkE+ix1dG157sgrlp6lIlShD93vMqaMWIRFyeAImbDq3ollOY/QOZaVTVwv8i/VjHI92+lt/HCM9R/Qlh+BhrfHSiWLpvmCCMSvqpwzgfQaNH1rGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708655380; c=relaxed/simple;
	bh=PonAp4P0aFtIcd+rOQ5XyV76Ss3r/bbPSNZvKReTEb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eNnDsvn11UgBwbp9jOl5ssNGD1q4Cm1PXiRXS9VyaYSAtaUMEOUt/Fn2NJxeQE9Fex6QyUobHVEgvND6Hg6HTkrNKigfiFkP/v6fdXuN5kUsO91m2SJ7oR2AeUE9fMd3gIHQpUblhitCprrYyngOvqf8zq9Py45K6H8qiHe3QZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UA//yCiM; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708655379; x=1740191379;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PonAp4P0aFtIcd+rOQ5XyV76Ss3r/bbPSNZvKReTEb4=;
  b=UA//yCiMBciyyFDeOhKkTyVk8cWAcRzTOmrnU9AvdkZMqqEf6+L6oa+t
   ssOJ6JPW+6txmZ/xRAM+1LXi8ZTuseDTz4QMq8XHMUJ9C2A5qeBoOLAUK
   FDBZM33/BdfxGjL0dBT/zKybXb8Abbe/U7G1Q8eX2I0VmqfybFEosHPI/
   1edqiVWLZhVjmWK+tKDxW8gOPUDkxu/UmWpTTnn901OwIwrE89rA9/1rY
   Vtfx3a8mxz/N7UgQswUEdvye7CdJ6LFR1EQnlPS7ccHs3o0jFLRoaREN9
   ikE+1/svfbTgJb9ZczLjYjnKL2JBLMYmRoc27vcNASl0Su0gjPx2LDf98
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="3110258"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="3110258"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 18:29:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="6171175"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.255.30.59]) ([10.255.30.59])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 18:29:32 -0800
Message-ID: <2d1788da-521c-4531-a159-81d2fb801d6c@linux.intel.com>
Date: Fri, 23 Feb 2024 10:29:28 +0800
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
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <c655cd15-c883-483b-b698-b1b7ae360388@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/22/2024 7:24 PM, Dan Carpenter wrote:
> I'm sorry, I'm coming into this late and this is the first time I have
> reviewed this patch.  I see that we are at v13, and I hate to come in
> with picky comments when a patch has already gone through 13
> revisions...

Never mind that. some are totally new.

> On Thu, Feb 22, 2024 at 04:02:51AM -0500, Ethan Zhao wrote:
>> Because surprise removal could happen anytime, e.g. user could request safe
>> removal to EP(endpoint device) via sysfs and brings its link down to do
>> surprise removal cocurrently. such aggressive cases would cause ATS
>> invalidation request issued to non-existence target device, then deadly
>> loop to retry that request after ITE fault triggered in interrupt context.
>> this patch aims to optimize the ITE handling by checking the target device
>> presence state to avoid retrying the timeout request blindly, thus avoid
>> hard lockup or system hang.
>>
>> Devices are valid ATS invalidation request target only when they reside
> "valid invalidation" is awkward wording.  Can we instead say:

If you read them together, sounds like tongue twister. but here "ATS
invalidation request target" is one term in PCIe spec.

>
> Devices should only be invalidated when they are in the
> iommu->device_rbtree (probed, not released) and present.
>
>> in the iommu->device_rbtre (probed, not released) and present.
>                              ^
> Missing e in _rbtree.

Yup.

>> Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
> This patch should have a Fixes tags and be backported to stable kernels.
> I think it goes back all the way...
>
> Fixes: 704126ad81b8 ("VT-d: handle Invalidation Queue Error to avoid system hang")

Sounds reasonable.

>
>> ---
>>   drivers/iommu/intel/dmar.c | 25 +++++++++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>>
>> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
>> index d14797aabb7a..d01d68205557 100644
>> --- a/drivers/iommu/intel/dmar.c
>> +++ b/drivers/iommu/intel/dmar.c
>> @@ -1273,6 +1273,9 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
>>   {
>>   	u32 fault;
>>   	int head, tail;
>> +	u64 iqe_err, ite_sid;
>> +	struct device *dev = NULL;
>> +	struct pci_dev *pdev = NULL;
>>   	struct q_inval *qi = iommu->qi;
>>   	int shift = qi_shift(iommu);
>>   
>> @@ -1317,6 +1320,13 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
>>   		tail = readl(iommu->reg + DMAR_IQT_REG);
>>   		tail = ((tail >> shift) - 1 + QI_LENGTH) % QI_LENGTH;
>>   
>> +		/*
>> +		 * SID field is valid only when the ITE field is Set in FSTS_REG
>> +		 * see Intel VT-d spec r4.1, section 11.4.9.9
>> +		 */
>> +		iqe_err = dmar_readq(iommu->reg + DMAR_IQER_REG);
>> +		ite_sid = DMAR_IQER_REG_ITESID(iqe_err);
>> +
>>   		writel(DMA_FSTS_ITE, iommu->reg + DMAR_FSTS_REG);
>>   		pr_info("Invalidation Time-out Error (ITE) cleared\n");
>>   
>> @@ -1326,6 +1336,21 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
>>   			head = (head - 2 + QI_LENGTH) % QI_LENGTH;
>>   		} while (head != tail);
>>   
>> +		/*
>> +		 * If got ITE, we need to check if the sid of ITE is one of the
>> +		 * current valid ATS invalidation target devices, if no, or the
>> +		 * target device isn't presnet, don't try this request anymore.
>> +		 * 0 value of ite_sid means old VT-d device, no ite_sid value.
>> +		 */
> This comment is kind of confusing.

Really confusing ? this is typo there, resnet-> "present"

>
> /*
>   * If we have an ITE, then we need to check whether the sid of the ITE
>   * is in the rbtree (meaning it is probed and not released), and that
>   * the PCI device is present.
>   */
>
> My comment is slightly shorter but I think it has the necessary
> information.
>
>> +		if (ite_sid) {
>> +			dev = device_rbtree_find(iommu, ite_sid);
>> +			if (!dev || !dev_is_pci(dev))
>> +				return -ETIMEDOUT;
> -ETIMEDOUT is weird.  The callers don't care which error code we return.
> Change this to -ENODEV or something

-ETIMEDOUT means prior ATS invalidation request hit timeout fault, and the
caller really cares about the returned value.

>
>> +			pdev = to_pci_dev(dev);
>> +			if (!pci_device_is_present(pdev) &&
>> +				ite_sid == pci_dev_id(pci_physfn(pdev)))
> The && confused me, but then I realized that probably "ite_sid ==
> pci_dev_id(pci_physfn(pdev))" is always true.  Can we delete that part?

Here is the fault handling, just double confirm nothing else goes wrong --
beyond the assumption.

>
> 		pdev = to_pci_dev(dev);
> 		if (!pci_device_is_present(pdev))
> 			return -ENODEV;
>
>
>> +				return -ETIMEDOUT;
> -ENODEV.

The ATS invalidation request could be sent from userland in later code,
the userland code will care about the returned value,  -ENODEV is one aspect
of the fact (target device not present), while -ETIMEDOUT is another
(timeout happened). we couldn't return them both.

>
>> +		}
>>   		if (qi->desc_status[wait_index] == QI_ABORT)
>>   			return -EAGAIN;
>>   	}
> Sorry, again for nit picking a v13 patch.  I'm not a domain expert but
> this patchset seems reasonable to me.

Though this is the v13, it is based on new rbtree code, you are welcome.

Thanks,
Ethan

> regards,
> dan carpenter

