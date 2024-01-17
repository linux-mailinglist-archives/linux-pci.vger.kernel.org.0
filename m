Return-Path: <linux-pci+bounces-2243-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CCB82FFE0
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 06:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E816228907C
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 05:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D70F63D5;
	Wed, 17 Jan 2024 05:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QQEkDJ9B"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A6A6AB8;
	Wed, 17 Jan 2024 05:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705469890; cv=none; b=kdLf+6CB3AKf2kB2mjJKW0WpoL/kzMRPTWeasNtDky9tPq+tLDtOXwlGdhsIfqfDYvKbJkOf5S0ruzL4HIEFxYah6z267x4btooSs6fZJToEj4YqdFOo4AGppgJKwr74HTG392DXDiIqa+3TIbFidlDoTjgmg0gJNGJsiDG0wB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705469890; c=relaxed/simple;
	bh=srH4A6f1ftjr1JV1Di/wO1iO+t3WVZQRxI0O/xNLAgs=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:From:To:Cc:References:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=m/i/DC57/kSeEQo6kkMPFrVY29ydgsuZYXAlDpHrcGqww5xAMm12MepRPU3k0h6+8z82/RaVsHIPO4EC5MT3XrnWfMgjVTv+cZQNg27AgR0ZG+4efSMrHAt3GjMPuZFThlHySYB+finqkhhu7G1VAwc6bSZ6AFibpp1WUjnolMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QQEkDJ9B; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705469889; x=1737005889;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=srH4A6f1ftjr1JV1Di/wO1iO+t3WVZQRxI0O/xNLAgs=;
  b=QQEkDJ9BAFQDpFZYTF0pWpHypVxq2X9dISuMYTyRCrbRNk5ULtD/3BSZ
   1nyhJ4XSScza09jBWEJu4Ihe8/qvW1cNmJqtZB+5X5AJ2OY34JhM73ZJw
   hIvFwlmHpZs8lY4V7zMsOF9Ww66WG3QhE4ijS8oNfSoFcq1oq3r4lhl2r
   PKzQqRcXT6u0lZ/3CZVNGT38RRmRQnl4wPR1XgCwwHcMNS5K89wUB3olT
   001alAANZCj9nO0EXwJ4wCe9joMw+C/5t+sY0gQoemPwruVj6m34zdNV3
   lj7erNRa4mY83GkremkkX3LzQ4+Nn2zsx2hVF0pQk8SCrT3y2dLtCy3Tn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="7168805"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="7168805"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 21:38:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="903415031"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="903415031"
Received: from zgao13-mobl1.ccr.corp.intel.com (HELO [10.254.209.39]) ([10.254.209.39])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 21:38:05 -0800
Message-ID: <dcd27bc8-5eca-41ae-bb86-fd8e657ccfed@linux.intel.com>
Date: Wed, 17 Jan 2024 13:38:03 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v10 0/5] fix vt-d hard lockup when hotplug ATS capable
 device
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, kevin.tian@intel.com,
 bhelgaas@google.com, dwmw2@infradead.org, will@kernel.org,
 robin.murphy@arm.com, lukas@wunner.de
Cc: linux-pci@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20231228170206.720675-1-haifeng.zhao@linux.intel.com>
 <1a2a4069-c737-4a3c-a2f6-cce06823331b@linux.intel.com>
 <3ee904e9-8a93-4bd9-8df7-6294885589e4@linux.intel.com>
 <42f7848a-0262-4871-b5dc-0e87beebfd11@linux.intel.com>
In-Reply-To: <42f7848a-0262-4871-b5dc-0e87beebfd11@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/17/2024 1:26 PM, Ethan Zhao wrote:
>
> On 1/17/2024 11:24 AM, Baolu Lu wrote:
>> On 2024/1/15 15:58, Ethan Zhao wrote:
>>> -static int qi_check_fault(struct intel_iommu *iommu, int index, int 
>>> wait_index)
>>> +static int qi_check_fault(struct intel_iommu *iommu, int index, int 
>>> wait_index,
>>> +                  pci_dev *target_pdev)
>>>   {
>>>          u32 fault;
>>>          int head, tail;
>>> +       u64 iqe_err, ice_sid;
>>>          struct q_inval *qi = iommu->qi;
>>>          int shift = qi_shift(iommu);
>>>
>>>          if (qi->desc_status[wait_index] == QI_ABORT)
>>>                  return -EAGAIN;
>>>
>>> +       /*
>>> +        * If the ATS invalidation target device is gone this moment 
>>> (surprise
>>> +        * removed, died, no response) don't try this request again. 
>>> this
>>> +        * request will not get valid result anymore. but the 
>>> request was
>>> +        * already submitted to hardware and we predict to get a ITE in
>>> +        * followed batch of request, if so, it will get handled then.
>>> +        */
>>
>> We can't leave the ITE triggered by this request for the next one, which
>> has no context about why this happened. Perhaps move below code down to
>> the segment that handles ITEs.
>
> Here, the invalidation request has been issued to hardware but target 
> device
>
> gone, we can't loop and wait for the ITE for this request to happen, 
> and we
>
> bail out here because we hold lock_irqsave lock , the ITE still could 
> happen
>
> with later batch request in the future,  though it is not triggered by 
> that request,
>
> but it could still be cleaned/handled. move it to the fault() segment 
> ?,there means

That moment, the ITE was triggered by previous requests, they are not in 
current

context, also shouldn't be retried, they have response time over expected.

but triggered ITE fault blocks this patch request, we should retry this 
batch request.

we just clean the fault and retry it.  nothing missed.


Thanks,

Ethan

>
> ITE already happened, no need to check target presence anymore.
>
> did I miss something about the context lost ?
>
>>
>> Another concern is about qi_dump_fault(), which pr_err's the fault
>> message as long as the register is set. Some faults are predictable,
>> such as cache invalidation for surprise-removed devices. Unconditionally
>> reporting errors with pr_err() may lead the user to believe that a more
>> serious hardware error has occurred. Probably we can refine this part of
>> the code as well.
>
> Agree, may refine them in seperated series ?
>
> loop and always retry IQE, ICE don't make sense per my understanding.  if
>
> IQE happened retry it will always reproduce the fault, because request 
> is the same.
>
> we could fix them together in other patches.
>
>
> Thanks,
>
> Ethan
>
>>
>> Others look sane to me.
>>
>>> +       if (target_pdev && !pci_device_is_present(target_pdev))
>>> +               return -EINVAL;
>>> +
>>>          fault = readl(iommu->reg + DMAR_FSTS_REG);
>>>          if (fault & (DMA_FSTS_IQE | DMA_FSTS_ITE | DMA_FSTS_ICE))
>>>                  qi_dump_fault(iommu, fault);
>>> @@ -1315,6 +1327,13 @@ static int qi_check_fault(struct intel_iommu 
>>> *iommu, int index, int wait_index)
>>>                  tail = readl(iommu->reg + DMAR_IQT_REG);
>>>                  tail = ((tail >> shift) - 1 + QI_LENGTH) % QI_LENGTH;
>>>
>>> +               /*
>>> +                * SID field is valid only when the ITE field is Set 
>>> in FSTS_REG
>>> +                * see Intel VT-d spec r4.1, section 11.4.9.9
>>> +                */
>>> +               iqe_err = dmar_readq(iommu->reg + DMAR_IQER_REG);
>>> +               ice_sid = DMAR_IQER_REG_ITESID(iqe_err);
>>> +
>>>                  writel(DMA_FSTS_ITE, iommu->reg + DMAR_FSTS_REG);
>>>                  pr_info("Invalidation Time-out Error (ITE) 
>>> cleared\n");
>>>
>>> @@ -1324,6 +1343,16 @@ static int qi_check_fault(struct intel_iommu 
>>> *iommu, int index, int wait_index)
>>>                          head = (head - 2 + QI_LENGTH) % QI_LENGTH;
>>>                  } while (head != tail);
>>>
>>> +               /*
>>> +                * If got ITE, we need to check if the sid of ITE is 
>>> the same as
>>> +                * current ATS invalidation target device, if yes, 
>>> don't try this
>>> +                * request anymore, the target device has a response 
>>> time beyound
>>> +                * expected. 0 value of ice_sid means old device, no 
>>> ice_sid value.
>>> +                */
>>> +               if (target_pdev && ice_sid && ice_sid ==
>>> +                   pci_dev_id(pci_physfn(target_pdev))
>>> +                               return -ETIMEDOUT;
>>> +
>>>                  if (qi->desc_status[wait_index] == QI_ABORT)
>>>                          return -EAGAIN;
>>>          }
>>
>> Best regards,
>> baolu
>

