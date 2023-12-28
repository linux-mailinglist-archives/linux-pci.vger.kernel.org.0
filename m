Return-Path: <linux-pci+bounces-1496-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4510281F8A7
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 14:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02D411F2432A
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 13:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED9E79CF;
	Thu, 28 Dec 2023 13:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ecqsIWj3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDB979C6;
	Thu, 28 Dec 2023 13:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703769014; x=1735305014;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+h48D15/TNyIh+MOL0pe6S5/Owyp+lm7qG0IVc8QWuw=;
  b=ecqsIWj3/SlvYxiJdvQQ+jMFkjwvrob97Z5f24GKDHLN0Y2E1TNbOXSI
   tbB65H+6Rkjit3obz2CpR0EnuzqlrDGNFcphJcfCPmdDgp3nYoR6kTjFX
   uWmFBp4KvhdXtWl+cKBXgau33ZmA3OLzJ6TcBjaF8qhqKoUFjx2sRdQzf
   kQ9a6lT1Wa8OoNNP5wb176u2L5S8/g63yMr7TgGQDC7AO1DKNXsJj5MVz
   e/t/iGFWmqYpaEShk3h7HxXRrMA72H2SwrGEnNA4TGCV3a6v6lEG1dFR2
   1UIchmJ2zJ8hATbMFiSJfTl28CdvHk6/PiYNcB5tnPHLmtpvCUeW3CN3T
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="376701617"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="376701617"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 05:10:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="848946415"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="848946415"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.249.169.62]) ([10.249.169.62])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 05:10:10 -0800
Message-ID: <bb3a8a4c-6dad-4347-9076-0f28d1e23de3@linux.intel.com>
Date: Thu, 28 Dec 2023 21:10:08 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v9 5/5] iommu/vt-d: don't loop for timeout ATS
 Invalidation request forever
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "lukas@wunner.de" <lukas@wunner.de>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20231228001646.587653-1-haifeng.zhao@linux.intel.com>
 <20231228001646.587653-6-haifeng.zhao@linux.intel.com>
 <BN9PR11MB527651C1A108721CFF057BCF8C9EA@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <BN9PR11MB527651C1A108721CFF057BCF8C9EA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/28/2023 4:38 PM, Tian, Kevin wrote:
>> From: Ethan Zhao <haifeng.zhao@linux.intel.com>
>> Sent: Thursday, December 28, 2023 8:17 AM
>>
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
>> #12 [ffffb202f268cdc8] native_queued_spin_lock_slowpath at
>> ffffffffa9d1025c
>>
>> #13 [ffffb202f268cdc8] do_raw_spin_lock at ffffffffa9d121f1
>>
>> #14 [ffffb202f268cdd8] _raw_spin_lock_irqsave at ffffffffaa51795b
>>
>> #15 [ffffb202f268cdf8] iommu_flush_dev_iotlb at ffffffffaa20df48
>>
>> #16 [ffffb202f268ce28] iommu_flush_iova at ffffffffaa20e182
>>
>> #17 [ffffb202f268ce60] iova_domain_flush at ffffffffaa220e27
>>
>> #18 [ffffb202f268ce70] fq_flush_timeout at ffffffffaa221c9d
>>
>> #19 [ffffb202f268cea8] call_timer_fn at ffffffffa9d46661
>>
>> #20 [ffffb202f268cf08] run_timer_softirq at ffffffffa9d47933
>>
>> #21 [ffffb202f268cf98] __softirqentry_text_start at ffffffffaa8000e0
>>
>> #22 [ffffb202f268cff0] asm_call_sysvec_on_stack at ffffffffaa60114f
>> --- ---
>> (the left part of exception see the hotplug case of ATS capable device)
>>
>> If one endpoint device just no response to the ATS Invalidation request,
>> but is not gone, it will bring down the whole system, to avoid such
>> case, don't try the timeout ATS Invalidation request forever.
>>
>> Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
>> ---
>>   drivers/iommu/intel/dmar.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
>> index 76903a8bf963..206ab0b7294f 100644
>> --- a/drivers/iommu/intel/dmar.c
>> +++ b/drivers/iommu/intel/dmar.c
>> @@ -1457,7 +1457,7 @@ int qi_submit_sync(struct intel_iommu *iommu,
>> struct qi_desc *desc,
>>   	reclaim_free_desc(qi);
>>   	raw_spin_unlock_irqrestore(&qi->q_lock, flags);
>>
>> -	if (rc == -EAGAIN)
>> +	if (rc == -EAGAIN && type !=QI_DIOTLB_TYPE && type !=
>> QI_DEIOTLB_TYPE)
>>   		goto restart;
>>
> this change is moot.
>
> -EAGAIN is set only when hardware detects a ATS invalidation completion
> timeout in qi_check_fault(). so above just essentially kills the restart logic.

This change is intended to break the restar login when device-TLB

invalidation timeout happens, we don't know how long the ITE took

if the device is just no reponse.

>
> I'd wait for the maintainer of this driver to comment. this part doesn't
> look good but there might be some history reason so carefulness must
> be paid.

I would like to know the reason a hole is left here to hang the driver

forever.

Thanks,

Ethan


