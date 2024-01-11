Return-Path: <linux-pci+bounces-2019-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE4D82A61A
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 03:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6725282E5F
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 02:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADC419C;
	Thu, 11 Jan 2024 02:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iqt2EVyW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CA910E8;
	Thu, 11 Jan 2024 02:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704940605; x=1736476605;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0Va+P7X83oGoZ+4IUOYXS7EzUs4E4JPqjUEHp4bqu5U=;
  b=iqt2EVyWHlxzU65lLKMPUzmsIakxVC7t2J6VbqjVIKYA9LBKtH/Wqt3L
   eC6rT7FFXjwhBA7Rv3Ds3d0kfWNxwH7Q5c8h8Ou+t0T0q1c9Xyo89+uhM
   FO9wtoO0Y/pgO+fYQSwbDjoK9uGfQo4RBk/HFMQjG9UA59UYCRXhq1uko
   NyQeMdq9sjZKWoB5K47gukiTk09YgN6r1+G7Jen/9dOsarboNqkx40/4Y
   /kIflkiLPyg5gmUXUgQ9mXeacXRKsfT5o7XJhLcWLtDNub4zrcsTuufJG
   v+TTV+BzYgKcDticjnQIKFpNAWCiRGoy106dmNlkRQjECwUUKCMPmPoAO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="397588095"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="397588095"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 18:36:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="732046535"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="732046535"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga003.jf.intel.com with ESMTP; 10 Jan 2024 18:36:40 -0800
Message-ID: <65312590-01e1-4f53-a0dc-fc22f75379cd@linux.intel.com>
Date: Thu, 11 Jan 2024 10:31:25 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, linux-pci@vger.kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v10 5/5] iommu/vt-d: don't loop for timeout ATS
 Invalidation request forever
Content-Language: en-US
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, kevin.tian@intel.com,
 bhelgaas@google.com, dwmw2@infradead.org, will@kernel.org,
 robin.murphy@arm.com, lukas@wunner.de
References: <20231228170504.720794-1-haifeng.zhao@linux.intel.com>
 <20231228170504.720794-3-haifeng.zhao@linux.intel.com>
 <aba65111-47c1-4003-b9a9-19c908507c01@linux.intel.com>
 <53c563ad-b47b-4962-abc7-f0da3a7181d6@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <53c563ad-b47b-4962-abc7-f0da3a7181d6@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/10/24 4:40 PM, Ethan Zhao wrote:
> 
> On 1/10/2024 1:28 PM, Baolu Lu wrote:
>> On 12/29/23 1:05 AM, Ethan Zhao wrote:
>>> When the ATS Invalidation request timeout happens, the qi_submit_sync()
>>> will restart and loop for the invalidation request forever till it is
>>> done, it will block another Invalidation thread such as the fq_timer
>>> to issue invalidation request, cause the system lockup as following
>>>
>>> [exception RIP: native_queued_spin_lock_slowpath+92]
>>>
>>> RIP: ffffffffa9d1025c RSP: ffffb202f268cdc8 RFLAGS: 00000002
>>>
>>> RAX: 0000000000000101 RBX: ffffffffab36c2a0 RCX: 0000000000000000
>>>
>>> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffab36c2a0
>>>
>>> RBP: ffffffffab36c2a0 R8: 0000000000000001 R9: 0000000000000000
>>>
>>> R10: 0000000000000010 R11: 0000000000000018 R12: 0000000000000000
>>>
>>> R13: 0000000000000004 R14: ffff9e10d71b1c88 R15: ffff9e10d71b1980
>>>
>>> ORIG_RAX: ffffffffffffffff CS: 0010 SS: 0018
>>>
>>> (the left part of exception see the hotplug case of ATS capable device)
>>>
>>> If one endpoint device just no response to the ATS Invalidation request,
>>> but is not gone, it will bring down the whole system, to avoid such
>>> case, don't try the timeout ATS Invalidation request forever.
>>>
>>> Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
>>> ---
>>>   drivers/iommu/intel/dmar.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
>>> index 0a8d628a42ee..9edb4b44afca 100644
>>> --- a/drivers/iommu/intel/dmar.c
>>> +++ b/drivers/iommu/intel/dmar.c
>>> @@ -1453,7 +1453,7 @@ int qi_submit_sync(struct intel_iommu *iommu, 
>>> struct qi_desc *desc,
>>>       reclaim_free_desc(qi);
>>>       raw_spin_unlock_irqrestore(&qi->q_lock, flags);
>>>   -    if (rc == -EAGAIN)
>>> +    if (rc == -EAGAIN && type !=QI_DIOTLB_TYPE && type != 
>>> QI_DEIOTLB_TYPE)
>>>           goto restart;
>>>         if (iotlb_start_ktime)
>>
>> Above is also unnecessary if qi_check_fault() returns -ETIMEDOUT,
>> instead of -EAGAIN. Or did I miss anything?
> 
> It is pro if we fold it into qi_check_fault(), the con is we have to add
> 
> more parameter to qi_check_fault(), no need check invalidation type
> 
> of QI_DIOTLB_TYPE&QI_DEIOTLB_TYPE in qi_check_fault() ?

No need to check the request type as multiple requests might be batched
together in a single call. This is also the reason why I asked you to
add a flag bit to this helper and make the intention explicit, say,

"This includes requests to interact with a PCI endpoint. The device may
  become unavailable at any time, so do not attempt to retry if ITE is
  detected and the device has gone away."

Best regards,
baolu

