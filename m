Return-Path: <linux-pci+bounces-1972-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 113EB82935C
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 06:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A030E288CAA
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 05:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6CEDDD4;
	Wed, 10 Jan 2024 05:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z6Nic5D3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E45DDA9;
	Wed, 10 Jan 2024 05:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704864833; x=1736400833;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YGke+ibjmKZatt4nYaBojbGAiAATE/h9fTo0wo5i5ew=;
  b=Z6Nic5D3NxleHGoLTktT6gxn4l9nJtqcb/1zA+y7fW14xqt/wsnNpaaT
   H7g8xPk3PZQMYoihcTRYaSd65+QtHzY+HkFk8A79AKJuFHiVtQZgGnu21
   hqsqiXd7GboyiVa0nN5CArQEAWbyb+2LN0ayL1O+XunDcmaPmbhDTci2h
   Q6mOmK62gHNyNbzAn6yKGAf7XnynTVqf1cTgwiue54C0QVW3OAIAfv/7s
   8J+ZPhY3sMnLKlpb3El7S0HkSQwaH6HS7nZGtNiM+KDsaAFzS8OkoMRc3
   j6+55shce60g6r3aFu+el5A3XBzkfMkaH2DZdVZxjOYWGpXHzPpE/qEkI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="462698659"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="462698659"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 21:33:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="1113321247"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="1113321247"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga005.fm.intel.com with ESMTP; 09 Jan 2024 21:33:50 -0800
Message-ID: <aba65111-47c1-4003-b9a9-19c908507c01@linux.intel.com>
Date: Wed, 10 Jan 2024 13:28:36 +0800
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
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231228170504.720794-3-haifeng.zhao@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/29/23 1:05 AM, Ethan Zhao wrote:
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

Above is also unnecessary if qi_check_fault() returns -ETIMEDOUT,
instead of -EAGAIN. Or did I miss anything?

Best regards,
baolu

