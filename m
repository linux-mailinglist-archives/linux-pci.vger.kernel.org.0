Return-Path: <linux-pci+bounces-1983-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB2282954F
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 09:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3B2C1C244B5
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 08:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685C3360AD;
	Wed, 10 Jan 2024 08:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E1Z4rsQn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8813B190;
	Wed, 10 Jan 2024 08:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704876010; x=1736412010;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=arvWo2uRI+1qQXnGO14U7UceSTXshKY9j9jK/LSmEZ4=;
  b=E1Z4rsQnb7/1YLX8JXhL1bd9kM6vqW4G1ncJseP/gK314UCdkLViy00J
   tN3cRSP0cqBE7cGubFY65IsFhjw+iZLfrjR3kGA6Pz1krQvCGSTpU3eJ2
   EHW6TN0jBuEtgkpVyKjA6UDCYSTwVMEzYl2VPfo7xKUbIpSLK0bZXtEaS
   mrFGypWOgcYbbYYswSk3dTukwDigJA5pqf9RIlYTDPQl0QxJAjrJuE8SG
   2GkIZufV0jjrb52Z7IGlvjyHrvEi2qkGDsf6GkZpYQ2uHlbq60rtz9BW0
   6XDvoU1DQMnP+jJYagFF5u/OP+qO13g5kl50dO0z7a/bXPi68ncZ1T6ly
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5203546"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="5203546"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 00:40:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="1029079465"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="1029079465"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.93.11.157]) ([10.93.11.157])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 00:40:07 -0800
Message-ID: <53c563ad-b47b-4962-abc7-f0da3a7181d6@linux.intel.com>
Date: Wed, 10 Jan 2024 16:40:02 +0800
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
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <aba65111-47c1-4003-b9a9-19c908507c01@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/10/2024 1:28 PM, Baolu Lu wrote:
> On 12/29/23 1:05 AM, Ethan Zhao wrote:
>> When the ATS Invalidation request timeout happens, the qi_submit_sync()
>> will restart and loop for the invalidation request forever till it is
>> done, it will block another Invalidation thread such as the fq_timer
>> to issue invalidation request, cause the system lockup as following
>>
>> [exception RIP: native_queued_spin_lock_slowpath+92]
>>
>> RIP: ffffffffa9d1025c RSP: ffffb202f268cdc8 RFLAGS: 00000002
>>
>> RAX: 0000000000000101 RBX: ffffffffab36c2a0 RCX: 0000000000000000
>>
>> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffab36c2a0
>>
>> RBP: ffffffffab36c2a0 R8: 0000000000000001 R9: 0000000000000000
>>
>> R10: 0000000000000010 R11: 0000000000000018 R12: 0000000000000000
>>
>> R13: 0000000000000004 R14: ffff9e10d71b1c88 R15: ffff9e10d71b1980
>>
>> ORIG_RAX: ffffffffffffffff CS: 0010 SS: 0018
>>
>> (the left part of exception see the hotplug case of ATS capable device)
>>
>> If one endpoint device just no response to the ATS Invalidation request,
>> but is not gone, it will bring down the whole system, to avoid such
>> case, don't try the timeout ATS Invalidation request forever.
>>
>> Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
>> ---
>>   drivers/iommu/intel/dmar.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
>> index 0a8d628a42ee..9edb4b44afca 100644
>> --- a/drivers/iommu/intel/dmar.c
>> +++ b/drivers/iommu/intel/dmar.c
>> @@ -1453,7 +1453,7 @@ int qi_submit_sync(struct intel_iommu *iommu, 
>> struct qi_desc *desc,
>>       reclaim_free_desc(qi);
>>       raw_spin_unlock_irqrestore(&qi->q_lock, flags);
>>   -    if (rc == -EAGAIN)
>> +    if (rc == -EAGAIN && type !=QI_DIOTLB_TYPE && type != 
>> QI_DEIOTLB_TYPE)
>>           goto restart;
>>         if (iotlb_start_ktime)
>
> Above is also unnecessary if qi_check_fault() returns -ETIMEDOUT,
> instead of -EAGAIN. Or did I miss anything?

It is pro if we fold it into qi_check_fault(), the con is we have to add

more parameter to qi_check_fault(), no need check invalidation type

of QI_DIOTLB_TYPE&QI_DEIOTLB_TYPE in qi_check_fault() ?


Thanks,

Ethan

>
> Best regards,
> baolu

