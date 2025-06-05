Return-Path: <linux-pci+bounces-29054-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92475ACF750
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 20:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA88D17B55E
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 18:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6224D27B51A;
	Thu,  5 Jun 2025 18:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cSKAISS2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A723627A46A;
	Thu,  5 Jun 2025 18:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749148662; cv=none; b=rbdQj6N2XmzdLTgj5M9LkAMYjfHLLfg/2mlmg3NPWNBzjhvtfv7xC/wUSOYqrugf7hgNo3nlC2ewxL/DsVzJyUU9EEFdFYeVeG1Pe580Wb5OmwjBSt4PuHiCLB+FOgwrcyJk+rGHD6lrNj+dCqKXsHi3EGSEvJieNudRJPCi1Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749148662; c=relaxed/simple;
	bh=S4sUC15Mace13WAZDAtAsOHoOZX4leNGTKotohTjG0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JwooZKwNPRADqC+GXDdvh/FOB6GMUFX4/Xd0Joi2r45xoKeu/sT0k/f1r0HLSmkO2nEEIgFo3fbEubnt5kY539PI44NDJd8xRW0Cz19GSxb7EJPweXpBIcT/kYiw0L6bnNP2gmAc5yXHnyyjQkfIpnizvYs4wVp+RgXTcR+U9j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cSKAISS2; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749148660; x=1780684660;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=S4sUC15Mace13WAZDAtAsOHoOZX4leNGTKotohTjG0w=;
  b=cSKAISS2nSKDDsTpJgC7ycexwHgk1CfvazR3St01LtxMjjenqmiB9+3s
   TyWcXTrzx/Xuy8lsmn3AkispVCGXq3m4Qi9Eyh1z7ZAeXY4arf11fyLnQ
   I9mnsYEG3nhuGK6uAT1kaa3t8IPa7cclykhyVBX+BaNtS4/GnS6oOM+/E
   eBOhUbeBNbbKv/fAcvAorZwG2B/C4GHzJSXVuzPZkYS397+HOnMmnV4T6
   Hwp8qgMZ5PQbKW7tCVtYAWi+tFDS22rQUQV2lMQ+08whBChAWaV6EwMOg
   LP22vjFKUuDYwz8Sp2tnsArpo2y2fGC8+MhXZLHqH11YZ5/soLtmwU6Ng
   A==;
X-CSE-ConnectionGUID: VJW9FVZrT9ivcM2mmJuh1w==
X-CSE-MsgGUID: JnMrCn84Qlea0g59pANGjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="54950209"
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; 
   d="scan'208";a="54950209"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 11:37:40 -0700
X-CSE-ConnectionGUID: X0z2z7rJQPWu+5U/0sD/zQ==
X-CSE-MsgGUID: hIJplFQSTEqnGEDZzI1kuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; 
   d="scan'208";a="150853473"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 11:37:40 -0700
Received: from [10.124.222.23] (unknown [10.124.222.23])
	by linux.intel.com (Postfix) with ESMTP id 9CF4220B5736;
	Thu,  5 Jun 2025 11:37:38 -0700 (PDT)
Message-ID: <9496f540-04eb-407f-a5ed-eac6a5e8f549@linux.intel.com>
Date: Thu, 5 Jun 2025 11:37:38 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 11/16] cxl/pci: Update __cxl_handle_cor_ras() to return
 early if no RAS errors
To: Terry Bowman <terry.bowman@amd.com>, PradeepVineshReddy.Kodamati@amd.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, bp@alien8.de,
 ming.li@zohomail.com, shiju.jose@huawei.com, dan.carpenter@linaro.org,
 Smita.KoralahalliChannabasappa@amd.com, kobayashi.da-06@fujitsu.com,
 yanfei.xu@intel.com, rrichter@amd.com, peterz@infradead.org, colyli@suse.de,
 uaisheng.ye@intel.com, fabio.m.de.francesco@linux.intel.com,
 ilpo.jarvinen@linux.intel.com, yazen.ghannam@amd.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-12-terry.bowman@amd.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250603172239.159260-12-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/3/25 10:22 AM, Terry Bowman wrote:
> __cxl_handle_cor_ras() is missing logic to leave the function early in the
> case there is no RAS error. Update __cxl_handle_cor_ras() to exit early in
> the case there is no RAS errors detected after applying the mask.
>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>   drivers/cxl/core/pci.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 0f4c07fd64a5..f5f87c2c3fd5 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -677,10 +677,11 @@ static void __cxl_handle_cor_ras(struct device *dev, u64 serial,
>   
>   	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
>   	status = readl(addr);
> -	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
> -		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> -		trace_cxl_aer_correctable_error(dev, serial, status);
> -	}
> +	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK))
> +		return;
> +	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> +
> +	trace_cxl_aer_correctable_error(dev, serial, status);
>   }
>   
>   static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


