Return-Path: <linux-pci+bounces-1414-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD5581EBC9
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 04:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1812B1F214DA
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 03:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065CD23C9;
	Wed, 27 Dec 2023 03:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bih9EM+3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAF27464;
	Wed, 27 Dec 2023 03:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703646672; x=1735182672;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=ic5p65YwJaFgI53HOX8SILyahR+vq0xdwAXMLhbWmHQ=;
  b=Bih9EM+3z11eBwZfamy9VZgct6XEHQmeU1fp/Zy0SFisiSKFtuRKIeV9
   Pk+JMwtb9EWKxI1wFJScRFh0PpmNGVTGdvkr/qdUF7Waxq3Naw2kqIGa/
   GAY3qLoS0l5zDe6EtAm/pKhqGKxn4Yur28m6/sNOGwAVIwUZoq0qvbHJJ
   VsGrgWFWzZNaMNoo5lohH6/ydsRANlTJAH4So+2dzgxL7/nuZUXm/l5of
   fF4FoBi3PD7uzI6Uj7VOGJg1OomcfRS7KREZvOjPbtM6iteDC9DStQr0R
   mC3Mnp1CZy7M4xXps06ZFu0QD7L+EVkeBj/8kXCRNLo+fwZQTw4jbIFh+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="396135618"
X-IronPort-AV: E=Sophos;i="6.04,307,1695711600"; 
   d="scan'208";a="396135618"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 19:11:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="1025280121"
X-IronPort-AV: E=Sophos;i="6.04,307,1695711600"; 
   d="scan'208";a="1025280121"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.255.28.66]) ([10.255.28.66])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 19:11:08 -0800
Message-ID: <c659a328-ff5f-4750-9cbe-b18fc9ffe7e6@linux.intel.com>
Date: Wed, 27 Dec 2023 11:11:06 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v8 5/5] iommu/vt-d: don't loop for timeout device-TLB
 invalidation request forever
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
To: bhelgaas@google.com, baolu.lu@linux.intel.com, dwmw2@infradead.org,
 will@kernel.org, robin.murphy@arm.com, lukas@wunner.de
Cc: linux-pci@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20231227025923.536148-1-haifeng.zhao@linux.intel.com>
 <20231227025923.536148-6-haifeng.zhao@linux.intel.com>
In-Reply-To: <20231227025923.536148-6-haifeng.zhao@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/27/2023 10:59 AM, Ethan Zhao wrote:
> When the device-TLB invalidation (ATS invalidation) timeout happens, the
> qi_submit_sync() will restart and loop for the invalidation request
> forever till it is done, it will block another invalidation thread such
> as the fq_timer to issue invalidation request, cause the system lockup as
> following
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

Wrong past, please ignore this series.


Thanks,

Ethan


>
> --- ---
>
> (the left part of exception see the hotplug case of ATS capable device)
>
> If one endpoint device just no response to the device-TLB invalidation
> request, but is not gone, it will bring down the whole system, to avoid
> such case, don't try the timeout device-TLB request forever.
>
> and as synchronous program model of current qi_submit_sync() implementation
> we couldn't wait for the enough time as PCIe spec said 1min+50%, just break
> it in current sync model. (PCIe spec r6.1, sec 10.3.1)
>
> Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
> ---
>   drivers/iommu/intel/dmar.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 76903a8bf963..206ab0b7294f 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1457,7 +1457,7 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
>   	reclaim_free_desc(qi);
>   	raw_spin_unlock_irqrestore(&qi->q_lock, flags);
>   
> -	if (rc == -EAGAIN)
> +	if (rc == -EAGAIN && type !=QI_DIOTLB_TYPE && type != QI_DEIOTLB_TYPE)
>   		goto restart;
>   
>   	if (iotlb_start_ktime)

