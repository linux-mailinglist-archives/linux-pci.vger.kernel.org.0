Return-Path: <linux-pci+bounces-2021-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0733C82A696
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 04:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9222E281E3C
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 03:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF836ECD;
	Thu, 11 Jan 2024 03:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fz4wC12F"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871AFEC0;
	Thu, 11 Jan 2024 03:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704944666; x=1736480666;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+mcRZBSNIFD1FoXGwOfvw1rQeALKmooHSTDFMzMgnD8=;
  b=fz4wC12FzYRCIZVklJJuztKPjliCNKE2QdPSwklh65Je4YtSt7R7cgHT
   1qV/WbQzwQojUusJDeORIoy69clfMG0kJGu/WFju6ztUMfxmtQMM7mPPY
   YYUxM52Oj3XtBSx/cVMsuFx3++5TLa8XUsDYNDxsigiu3ILWGdphLPKdX
   WoHjRIRCkgHm48FmM/8dJzZrGTUiuDsN2DA5zkJQvOSrGwq2t5lzwaI3O
   jdGIcugCFn57X0zH3RLvdlsYnoIoWCyVfPYwUETWyHtguAJuNe5JmHbMS
   F2PVkUE7p1OiH64HK/RYKQ3e6cMxun2qg++8qBFIqAij4LTi9c7ZiWuCU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="20211687"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="20211687"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 19:44:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="905796267"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="905796267"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.93.8.238]) ([10.93.8.238])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 19:44:21 -0800
Message-ID: <b13e1463-75d9-4cf6-af25-b1c76db0c924@linux.intel.com>
Date: Thu, 11 Jan 2024 11:44:18 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v10 5/5] iommu/vt-d: don't loop for timeout ATS
 Invalidation request forever
To: Baolu Lu <baolu.lu@linux.intel.com>, kevin.tian@intel.com,
 bhelgaas@google.com, dwmw2@infradead.org, will@kernel.org,
 robin.murphy@arm.com, lukas@wunner.de
Cc: linux-pci@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20231228170504.720794-1-haifeng.zhao@linux.intel.com>
 <20231228170504.720794-3-haifeng.zhao@linux.intel.com>
 <aba65111-47c1-4003-b9a9-19c908507c01@linux.intel.com>
 <53c563ad-b47b-4962-abc7-f0da3a7181d6@linux.intel.com>
 <65312590-01e1-4f53-a0dc-fc22f75379cd@linux.intel.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <65312590-01e1-4f53-a0dc-fc22f75379cd@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/11/2024 10:31 AM, Baolu Lu wrote:
> On 1/10/24 4:40 PM, Ethan Zhao wrote:
>>
>> On 1/10/2024 1:28 PM, Baolu Lu wrote:
>>> On 12/29/23 1:05 AM, Ethan Zhao wrote:
>>>> When the ATS Invalidation request timeout happens, the 
>>>> qi_submit_sync()
>>>> will restart and loop for the invalidation request forever till it is
>>>> done, it will block another Invalidation thread such as the fq_timer
>>>> to issue invalidation request, cause the system lockup as following
>>>>
>>>> [exception RIP: native_queued_spin_lock_slowpath+92]
>>>>
>>>> RIP: ffffffffa9d1025c RSP: ffffb202f268cdc8 RFLAGS: 00000002
>>>>
>>>> RAX: 0000000000000101 RBX: ffffffffab36c2a0 RCX: 0000000000000000
>>>>
>>>> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffab36c2a0
>>>>
>>>> RBP: ffffffffab36c2a0 R8: 0000000000000001 R9: 0000000000000000
>>>>
>>>> R10: 0000000000000010 R11: 0000000000000018 R12: 0000000000000000
>>>>
>>>> R13: 0000000000000004 R14: ffff9e10d71b1c88 R15: ffff9e10d71b1980
>>>>
>>>> ORIG_RAX: ffffffffffffffff CS: 0010 SS: 0018
>>>>
>>>> (the left part of exception see the hotplug case of ATS capable 
>>>> device)
>>>>
>>>> If one endpoint device just no response to the ATS Invalidation 
>>>> request,
>>>> but is not gone, it will bring down the whole system, to avoid such
>>>> case, don't try the timeout ATS Invalidation request forever.
>>>>
>>>> Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
>>>> ---
>>>>   drivers/iommu/intel/dmar.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
>>>> index 0a8d628a42ee..9edb4b44afca 100644
>>>> --- a/drivers/iommu/intel/dmar.c
>>>> +++ b/drivers/iommu/intel/dmar.c
>>>> @@ -1453,7 +1453,7 @@ int qi_submit_sync(struct intel_iommu *iommu, 
>>>> struct qi_desc *desc,
>>>>       reclaim_free_desc(qi);
>>>>       raw_spin_unlock_irqrestore(&qi->q_lock, flags);
>>>>   -    if (rc == -EAGAIN)
>>>> +    if (rc == -EAGAIN && type !=QI_DIOTLB_TYPE && type != 
>>>> QI_DEIOTLB_TYPE)
>>>>           goto restart;
>>>>         if (iotlb_start_ktime)
>>>
>>> Above is also unnecessary if qi_check_fault() returns -ETIMEDOUT,
>>> instead of -EAGAIN. Or did I miss anything?
>>
>> It is pro if we fold it into qi_check_fault(), the con is we have to add
>>
>> more parameter to qi_check_fault(), no need check invalidation type
>>
>> of QI_DIOTLB_TYPE&QI_DEIOTLB_TYPE in qi_check_fault() ?
>
> No need to check the request type as multiple requests might be batched
> together in a single call. This is also the reason why I asked you to
> add a flag bit to this helper and make the intention explicit, say,
>
> "This includes requests to interact with a PCI endpoint. The device may
>  become unavailable at any time, so do not attempt to retry if ITE is
>  detected and the device has gone away."

That is to say, the usage of this function finally becomes that way,

the user space interface could submit request with mixed iotlb & devtlb

invalidation together in the queue or seperated iotlb/devtlb invalidation.

we depend on caller to pass the QI_OPT_CHECK_ENDPOINT as option

bit to bail out even there is other iotlb invalidation in the same batch ?

then is user's call to choose retry the iotbl /devtlb invalidation or not.

if the caller hits the case the endpoint dead, the caller will get 
-ETIMEDOUT/

-ENOTCONN as returned value, but no real ITE in its interested list, to

tell userland user what happened, we fake a DMA_FSTS_ITE for user ?

given we wouldn't read a ITE from DMA_FSTS_REG that moment.


1. checking the first request for devTLB invalidation will miss chance to

    check endpoint state if the iotlb & devtlb invalidation were mixed.

    here explict option bit would be better.  while valid pdev does the

    same thing.  so if pdev passed, no need to check for QI_DIOTLB_TYPE

    || QI_EIOTLB_TYPE in qi_submit_sync() & qi_check_fault().


2. seems not perfect to drop or retry whole batch of request if there is

   devtlb invalidation within the batch, let caller to choose the later 
action

   is simpler than making the qi_submit_sync() too complex.


3. fake a DMA_FSTS_ITE for user's interested list on behalf of hardware

   is better than no error/ fault feedback to user even it is predicted not

   happened yet.


my cents.


Thanks,

Ethan



>
> Best regards,
> baolu

