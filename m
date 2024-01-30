Return-Path: <linux-pci+bounces-2774-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB84E841E2D
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 09:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42CB01F2D488
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 08:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6224957898;
	Tue, 30 Jan 2024 08:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F25//X80"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A234358107;
	Tue, 30 Jan 2024 08:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706604214; cv=none; b=fWofRS2Z9MsoP8MYrENEFSjRn1KrdYrHg1Od8rii+4Ex72jPIyVw1P+W1+f53eKXexyC921J30fcLbg2hlc7IWJkKVr6X6LLFiSiNY8hKyftVU0mjWHryY2QibceJRlfe/bHG4moy/1IJq6XgAbHfXsBy+GeHGq2Xgl6AoNQzTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706604214; c=relaxed/simple;
	bh=3hucEwre3IXpzmeThg4nvJFd2P50v8TXk2UnpY1Saqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UxvJHcC9Pn4GLOhTNHu8xqj9m85lmjXc6Mg/beWfuRGLEgCl+8qKgldVr5nGmNB/jkKZp9GN/YVBXtZy05Fq0Cm8IPPjx+uPBd7OTWzkj3OejBd9GZH1zUO4E0Nj5SyuVbsWEU+94ZirLkr9/wH3OZQIzySeMaK4MOWKRISZBEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F25//X80; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706604212; x=1738140212;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3hucEwre3IXpzmeThg4nvJFd2P50v8TXk2UnpY1Saqc=;
  b=F25//X80Bn4pjh7l5kAiJdY07723ZeiWM4iC7arwcNNxx3xCRMvpcUeD
   DHSTOqCv3HKOlMPrgksmwzcCzdxTqw64VH+dNTeagTE1fUcPNe+jrtlNO
   xIL7bNEMI/Hm7WUlLVYpE5VdyDY318/THzwR7x2G5gT4/BZQ1YHb9dfph
   M4PeU6m5u5SR8tUTnbrOwCY5/7QwPoTOmQa4P+qlQGaQ/OaLtfR4tKvDw
   BBciFIDf//bMTmitZm/+2Nx3/VRI6fbqIhOMH4hXrE0xfipczVWOHUjy2
   LhjJh94qkvL0eQ66rRsfVZYSStbhgI0hnaX+mBLjTOZZBRq4xD6butiKc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="9949288"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="9949288"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 00:43:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="29834271"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.249.174.131]) ([10.249.174.131])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 00:43:29 -0800
Message-ID: <2e43c304-2851-45d4-bbaa-ea1087e85161@linux.intel.com>
Date: Tue, 30 Jan 2024 16:43:25 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 5/5] iommu/vt-d: improve ITE fault handling if target
 device isn't present
To: Baolu Lu <baolu.lu@linux.intel.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>
Cc: "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "will@kernel.org" <will@kernel.org>, "lukas@wunner.de" <lukas@wunner.de>,
 "Liu, Yi L" <yi.l.liu@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20240129034924.817005-1-haifeng.zhao@linux.intel.com>
 <20240129034924.817005-6-haifeng.zhao@linux.intel.com>
 <BN9PR11MB52761CC3E5F08D4B7BAD7F918C7E2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <46e0c704-cc77-4d23-9503-0d6d5d07bb26@linux.intel.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <46e0c704-cc77-4d23-9503-0d6d5d07bb26@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/29/2024 10:48 PM, Baolu Lu wrote:
> On 2024/1/29 17:06, Tian, Kevin wrote:
>>> From: Ethan Zhao<haifeng.zhao@linux.intel.com>
>>> Sent: Monday, January 29, 2024 11:49 AM
>>>
>>> Because surprise removal could happen anytime, e.g. user could 
>>> request safe
>>> removal to EP(endpoint device) via sysfs and brings its link down to do
>>> surprise removal cocurrently. such aggressive cases would cause ATS
>>> invalidation request issued to non-existence target device, then deadly
>>> loop to retry that request after ITE fault triggered in interrupt 
>>> context.
>>> this patch aims to optimize the ITE handling by checking the target 
>>> device
>>> presence state to avoid retrying the timeout request blindly, thus 
>>> avoid
>>> hard lockup or system hang.
>>>
>>> Signed-off-by: Ethan Zhao<haifeng.zhao@linux.intel.com>
>>> ---
>>>   drivers/iommu/intel/dmar.c | 18 ++++++++++++++++++
>>>   1 file changed, 18 insertions(+)
>>>
>>> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
>>> index 814134e9aa5a..2e214b43725c 100644
>>> --- a/drivers/iommu/intel/dmar.c
>>> +++ b/drivers/iommu/intel/dmar.c
>>> @@ -1272,6 +1272,7 @@ static int qi_check_fault(struct intel_iommu
>>> *iommu, int index, int wait_index,
>>>   {
>>>       u32 fault;
>>>       int head, tail;
>>> +    u64 iqe_err, ite_sid;
>>>       struct q_inval *qi = iommu->qi;
>>>       int shift = qi_shift(iommu);
>>>
>>> @@ -1316,6 +1317,13 @@ static int qi_check_fault(struct intel_iommu
>>> *iommu, int index, int wait_index,
>>>           tail = readl(iommu->reg + DMAR_IQT_REG);
>>>           tail = ((tail >> shift) - 1 + QI_LENGTH) % QI_LENGTH;
>>>
>>> +        /*
>>> +         * SID field is valid only when the ITE field is Set in 
>>> FSTS_REG
>>> +         * see Intel VT-d spec r4.1, section 11.4.9.9
>>> +         */
>>> +        iqe_err = dmar_readq(iommu->reg + DMAR_IQER_REG);
>>> +        ite_sid = DMAR_IQER_REG_ITESID(iqe_err);
>>> +
>>>           writel(DMA_FSTS_ITE, iommu->reg + DMAR_FSTS_REG);
>>>           pr_info("Invalidation Time-out Error (ITE) cleared\n");
>>>
>>> @@ -1325,6 +1333,16 @@ static int qi_check_fault(struct intel_iommu
>>> *iommu, int index, int wait_index,
>>>               head = (head - 2 + QI_LENGTH) % QI_LENGTH;
>>>           } while (head != tail);
>>>
>>> +        /*
>>> +         * If got ITE, we need to check if the sid of ITE is the 
>>> same as
>>> +         * current ATS invalidation target device, if yes, don't 
>>> try this
>>> +         * request anymore if the target device isn't present.
>>> +         * 0 value of ite_sid means old VT-d device, no ite_sid value.
>>> +         */
>>> +        if (pdev && ite_sid && !pci_device_is_present(pdev) &&
>>> +            ite_sid == pci_dev_id(pci_physfn(pdev)))
>>> +            return -ETIMEDOUT;
>>> +
>> since the hardware already reports source id leading to timeout, 
>> can't we
>> just find the pci_dev according to reported ite_sid? this is a slow 
>> path (either
>> due to device in bad state or removed) hence it's not necessary to 
>> add more
>> intelligence to pass the pci_dev in, leading to only a partial fix 
>> can be backported.
>>
>> It's also more future-proof, say if one day the driver allows 
>> batching invalidation
>> requests for multiple devices then no need to pass in a list of devices.
>
> I have ever thought about this solution and gave up in the end due to
> the locking issue.
>
> A batch of qi requests must be handled in the spin lock critical region
> to enforce that only one batch of requests is submitted at a time.
> Searching pci_dev in this locking region might result in nested locking
> issues, and I haven't found a good solution for this yet.
>
You said async-interrupt model is a bad idea, how bad is it ? I wonder if
the hardware and VT-d spec definition could support it pefectly or not.
at least, would never get in trouble about balance timeout & wakeup
watchdog.

Yes, the VT-d DMAR driver wasn't inited as async-interrupt model from
begnining...

Thanks,
Ethan
  

> Unless someone can bring up a better solution, perhaps we have to live
> in a world where only single device TLB invalidation request in a batch
> could be submitted to the queue.
>
> Best regards,
> baolu

