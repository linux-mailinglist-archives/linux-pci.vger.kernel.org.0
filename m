Return-Path: <linux-pci+bounces-2034-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D9682A883
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 08:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C53A1C2604D
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 07:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DA1D287;
	Thu, 11 Jan 2024 07:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l85o4fNk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CA0DF68;
	Thu, 11 Jan 2024 07:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704959104; x=1736495104;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=MSJWbLVfC2fCCQp18M9iUiX9jnEfcndJ21Mjt5OMNLw=;
  b=l85o4fNkGHKLxppwDgyOPbMT7Y8UIEus+Ib/uZVlOY5/A1AR4ADH/wUq
   jPhWD7fmfWVySII/bDWzW00Wwk/a2LgCsh+P8hpSCDtS5+W0B0/AEswQn
   WtBubuVz9ObkKmlq17YXMYktV0b4SumLTUhMTJKyk0EO10MZMs+HqKgiW
   3AxMfg2J42qixKzAR5DjqjsaOnM29Gu0TCbaDs2k4IACffiIxHB4R1KJe
   fqewaud3KPYJlsjeS8pyrAe2qEnPoyVFL/GR52sFmw8dYUkln7b58Vv43
   ssH1aatt391WP3GFDPrbh84bZux/pGvH4GKjFA2Xw8AXKBvpXX/M6Pj7/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="6128709"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="6128709"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 23:45:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="905859548"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="905859548"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.93.8.238]) ([10.93.8.238])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 23:44:57 -0800
Message-ID: <0c0458c2-2468-4591-8767-5e1f0a5b0e78@linux.intel.com>
Date: Thu, 11 Jan 2024 15:44:54 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v10 5/5] iommu/vt-d: don't loop for timeout ATS
 Invalidation request forever
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
To: kevin.tian@intel.com, bhelgaas@google.com, baolu.lu@linux.intel.com,
 dwmw2@infradead.org, will@kernel.org, robin.murphy@arm.com, lukas@wunner.de
Cc: linux-pci@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20231228170504.720794-1-haifeng.zhao@linux.intel.com>
 <20231228170504.720794-3-haifeng.zhao@linux.intel.com>
In-Reply-To: <20231228170504.720794-3-haifeng.zhao@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/29/2023 1:05 AM, Ethan Zhao wrote:
> When the ATS Invalidation request timeout happens, the qi_submit_sync()
> will restart and loop for the invalidation request forever till it is
> done, it will block another Invalidation thread such as the fq_timer
> to issue invalidation request, cause the system lockup as following
>
> [exception RIP: native_queued_spin_lock_slowpath+92]
>
> RIP: ffffffffa9d1025c RSP: ffffb202f268cdc8 RFLAGS: 00000002
>
> RAX: 0000000000000101 RBX: ffffffffab36c2a0 RCX: 0000000000000000
>
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffab36c2a0
>
> RBP: ffffffffab36c2a0 R8: 0000000000000001 R9: 0000000000000000
>
> R10: 0000000000000010 R11: 0000000000000018 R12: 0000000000000000
>
> R13: 0000000000000004 R14: ffff9e10d71b1c88 R15: ffff9e10d71b1980
>
> ORIG_RAX: ffffffffffffffff CS: 0010 SS: 0018
>
> (the left part of exception see the hotplug case of ATS capable device)
>
> If one endpoint device just no response to the ATS Invalidation request,
> but is not gone, it will bring down the whole system, to avoid such
> case, don't try the timeout ATS Invalidation request forever.
>
> Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
> ---
>   drivers/iommu/intel/dmar.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 0a8d628a42ee..9edb4b44afca 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1453,7 +1453,7 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
>   	reclaim_free_desc(qi);
>   	raw_spin_unlock_irqrestore(&qi->q_lock, flags);
>   
> -	if (rc == -EAGAIN)
> +	if (rc == -EAGAIN && type !=QI_DIOTLB_TYPE && type != QI_DEIOTLB_TYPE)
>   		goto restart;
>   
>   	if (iotlb_start_ktime)

mark, only break the loop when the sid of ITE is the same as current target

pdev.  need check the target dev is pf or vf.

The ITE is possible left by previous devtlb invalidation request for 
other device.


Thanks,

Ethan


