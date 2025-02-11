Return-Path: <linux-pci+bounces-21242-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAF4A31989
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 00:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A71341887D2E
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 23:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65849268FC4;
	Tue, 11 Feb 2025 23:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lrCVnEth"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712E9267AFD;
	Tue, 11 Feb 2025 23:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739316491; cv=none; b=giM8loF6lnKFsCbfciOxThrsknMZMCzF4WYCZBkM3h21CmY0kcK87bcRIu1gNsM86ZGq7Ds82LyRAbLyj+7Ntt37vul6S/HD0murRAH1koFvldboCSqdp+vGLh6uzdiJdBaZiYEr8Yx+8xsVtnV0u9aBYnxF88PcnW5QiQe3LWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739316491; c=relaxed/simple;
	bh=4Dh0CToGuCsBSeXp8/ndnbhtxzc0MTEztaQouIwLxF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TXdSnBlbt+tbca0FueELGGnOId7saCVsV6tMChHPDoN2keV/xgdoQ4P0KbA6ZQZPExM0KOwC98VxFasT424e4CbVdrR1l/DPAxFuvK4sIFF0+oGEMsyMoMaaSXzoXjJeghy98r+TP+1KTrPL+QVyRf8fvyyHmLD6Pmblq8Ue8M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lrCVnEth; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739316490; x=1770852490;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=4Dh0CToGuCsBSeXp8/ndnbhtxzc0MTEztaQouIwLxF8=;
  b=lrCVnEth55AZ9lYg6gJio2nyG7opeAknbVQLvzpPq8l8Iwr3T3Nuvc/3
   T3shiQCCNofKaP99/XHdIQ9dfploUjnHanuHerFrClIvYI1GAPZHAvd1e
   HSqBZs4WCY7vYgrY/tdhqfqwH6BMlTQX5wtH/M0W8oZCS+Wm6w1nfC5C8
   MeUIvnkVCV0VTnM0lF7i35KiYdnLytiV+KrJFZdNowgrMDPrLOpey6I3t
   FRpbbTb+foX8vq/eatP51WdvR4zbGcHtkQqnf+qoD+iz554kaSlosBL0v
   ydTz7LGQCF2VKu3o/ITVXqf7CQgBZl/n1qVCC0audXiEydzSHMrWxE5sn
   g==;
X-CSE-ConnectionGUID: rzHmk3dfSw2byk0FvzPtIg==
X-CSE-MsgGUID: RhNmCodMS+WipEwbg7T4ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="57491990"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="57491990"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 15:28:09 -0800
X-CSE-ConnectionGUID: +i8SWOH5Qy29azynRTw/UQ==
X-CSE-MsgGUID: iRTd9DKNST2wLMHilOnOoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="143498429"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.125.108.65]) ([10.125.108.65])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 15:28:07 -0800
Message-ID: <962aeb8c-fd1b-4356-9c0b-cd8dd21c421d@intel.com>
Date: Tue, 11 Feb 2025 16:28:04 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/17] cxl/pci: Add log message and add type check in
 existing RAS handlers
To: Terry Bowman <terry.bowman@amd.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-11-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250211192444.2292833-11-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/11/25 12:24 PM, Terry Bowman wrote:
> The CXL RAS handlers do not currently log if the RAS registers are
> unmapped. This is needed in order to help debug CXL error handling. Update
> the CXL driver to log a warning message if the RAS register block is
> unmapped.
> 
> Also, add type check before processing EP or RCH DP.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/pci.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 69bb030aa8e1..af809e7cbe3b 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -658,15 +658,19 @@ static void __cxl_handle_cor_ras(struct device *dev,
>  	void __iomem *addr;
>  	u32 status;
>  
> -	if (!ras_base)
> +	if (!ras_base) {
> +		dev_warn_once(dev, "CXL RAS register block is not mapped");
>  		return;
> +	}
>  
>  	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
>  	status = readl(addr);
> -	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
> -		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> +	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK))
> +		return;
> +	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> +
> +	if (is_cxl_memdev(dev))
>  		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
> -	}
>  }
>  
>  static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
> @@ -702,8 +706,10 @@ static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>  	u32 status;
>  	u32 fe;
>  
> -	if (!ras_base)
> +	if (!ras_base) {
> +		dev_warn_once(dev, "CXL RAS register block is not mapped");
>  		return false;
> +	}
>  
>  	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
>  	status = readl(addr);
> @@ -722,7 +728,9 @@ static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>  	}
>  
>  	header_log_copy(ras_base, hl);
> -	trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
> +	if (is_cxl_memdev(dev))
> +		trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
> +
>  	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>  
>  	return true;


