Return-Path: <linux-pci+bounces-32687-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B34B0CD01
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 23:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6FDA18820D9
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 21:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885EB22D785;
	Mon, 21 Jul 2025 21:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lqRdCICL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5461B4242;
	Mon, 21 Jul 2025 21:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753135007; cv=none; b=oTjH+q9vBK7p8M/n6xPihq7oUZXb8ifMeBaaoT9NOxadQU2uOlHA0VHeVFGxi3vbJGRWG7sM1dGb1AVHeKxN7Gg8cwJ/jDganieFpe9juyR5VlRB4fbmgQvXxApjUct8jWy4/a6yhAiFibkWNr2rKKyzbgeaHdEn6/AfviK7lkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753135007; c=relaxed/simple;
	bh=bAnc8ZFiiDDj8PUvd1jg/alvXW50RDf/rLRtkE0vaWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M1ZkPmXyuucPk/ERFO6vMfttfF+wgbZaZ8uzhTu99V3C+6T0h2fqkx2722hgjirN2zkRpz4Ec4ZT8Vn6NT8BuyT6SIyPrPVi/wRMzxuRTZbZaWNsqsE8VAi5NS7WGnHSYScM7BMhalSfjyOpYfqMpQ2x3BrWpr1zo4Qmpi5HZ3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lqRdCICL; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753135005; x=1784671005;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bAnc8ZFiiDDj8PUvd1jg/alvXW50RDf/rLRtkE0vaWA=;
  b=lqRdCICLB2u1tK7dGATzQ0VLnIRa8tWFNWsBm/L5LTEO9ysdb74pffu/
   4BoDvVgLl6Dz8PpS4X/AFrY5axQG7jqfKvn4mnqvifRS6/LQN3k8YVgUO
   /3V4Ks1yP/VDWJevQMbQ+a8KBfB3Yo+d2wWqDFysHKeTT9S//mSz+PRmU
   4SZXcBvoJOTRCRM7pyDSOtk5QStlxEiQkOe17cTz7ES/kK8/91cRBPT3s
   e8Y1ueaEdXs2ulfam/e+aCXQX6ridWlndVbxH9Jti6ZpviHbC/IExp3tk
   h7WkXWy5QQX8b1VY12A/2baZWzsP8OpbLWm7hjVkIjtMyxvQpkIlRnju8
   g==;
X-CSE-ConnectionGUID: PiXI9NQZRqu2e8c3KyHXSw==
X-CSE-MsgGUID: HCicCs27TbSrIJw+vhdGmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="55073516"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="55073516"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 14:56:44 -0700
X-CSE-ConnectionGUID: S/mtya/zRMS6jlk7lrkJfA==
X-CSE-MsgGUID: L5PvRFbLTo+6BV16lm1e/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="163514795"
Received: from vverma7-mobl3.amr.corp.intel.com (HELO [10.247.118.153]) ([10.247.118.153])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 14:56:36 -0700
Message-ID: <d81c3ce6-94c6-463d-a5f8-f5607ec74cf8@intel.com>
Date: Mon, 21 Jul 2025 14:56:30 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 11/17] cxl/pci: Log message if RAS registers are
 unmapped
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-12-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250626224252.1415009-12-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/26/25 3:42 PM, Terry Bowman wrote:
> The CXL RAS handlers do not currently log if the RAS registers are
> unmapped. This is needed in order to help debug CXL error handling. Update
> the CXL driver to log a warning message if the RAS register block is
> unmapped during RAS error handling.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/pci.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 9b464f9c55c1..c9a4b528e0b8 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -670,8 +670,10 @@ static void cxl_handle_cor_ras(struct device *dev,
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
> @@ -709,8 +711,10 @@ static bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
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


