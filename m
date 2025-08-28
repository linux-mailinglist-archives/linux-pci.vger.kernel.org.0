Return-Path: <linux-pci+bounces-35036-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A91A9B3A46A
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 17:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50D4D466537
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 15:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A9A22CBCB;
	Thu, 28 Aug 2025 15:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cIH9V08N"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C4022B584;
	Thu, 28 Aug 2025 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756394908; cv=none; b=ItGTBGS308tbPMm1+f+/1KQvvdfj2shqQflvs7nzx9nVFbMk2xxAwOgtffdjQaYR1f77nduof1nZ9IB+suPvxoC0d4VcZ5d5R9Hi8MZkaEmQZhnfeEG6UIUPsjMHotet403ZCSRtHdM8m903t6HSRJVnRKFwsbylPV8iBap5WEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756394908; c=relaxed/simple;
	bh=iClcbCa9JB2d1027k7WRKvCy1HhhhYYbblhgnKX/53o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZhvwEcc7AeY7x+yfVrriwLvl8TXbkuaK/V35KDAChwbC+4adseTbx8GNmNP06TTcHhztgJaGC/vvecT98BhOh4bzR/5rfruwIi0h8rtYr+f/GMgR3PaCmzozAMiiKYggcCFN/tN8wCeXvbHWcPqwIXZwQJdkRJjNmgkZGIDrGCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cIH9V08N; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756394907; x=1787930907;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iClcbCa9JB2d1027k7WRKvCy1HhhhYYbblhgnKX/53o=;
  b=cIH9V08NsIilhhWMIKCfOPJrL/ab2r10PAOUIbSrrKbVspeVjzhSElCE
   pvZMRGKl61DDEF6Ll/hdFbgIFGO7bXTD65TN+TP/0iy29dVfZ5Ws78BOm
   0/M+94fHgd7JBD/mEwlP81puagzmItodHXJ/61dUASMFT3TnA1eaWxin6
   PpKTw8YeLCZpzo2HldWVINMQ5AMhG+VaWw7n6MeRjutd5tX/pELNk5UK1
   oII1kyPx52DNcbKX/JpKa6dX+bhJLDhcixVoCybJocAsDNJ07G1n5Txjr
   RmlKu/hfMh8AjoV0ucGaPGlrTBQ092bUzlCJGsODodlvv1fNM+FUZDyDH
   w==;
X-CSE-ConnectionGUID: Xgbcxg6uSla/aU87yIf32A==
X-CSE-MsgGUID: AMWUVBXLRfGG5+V5zYwrmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="76269003"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="76269003"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 08:28:26 -0700
X-CSE-ConnectionGUID: YTVs03eDQjmSDgE/qvpC6Q==
X-CSE-MsgGUID: cC1wVzf6SayOIlRWoutfLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="170317184"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.118.49]) ([10.247.118.49])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 08:28:15 -0700
Message-ID: <6e0f0a5e-38a8-47d6-aa56-63c5313fdf64@intel.com>
Date: Thu, 28 Aug 2025 08:28:10 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 03/23] cxl/pci: Remove unnecessary CXL Endpoint
 handling helper functions
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250827013539.903682-1-terry.bowman@amd.com>
 <20250827013539.903682-4-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250827013539.903682-4-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/26/25 6:35 PM, Terry Bowman wrote:
> The CXL driver's cxl_handle_endpoint_cor_ras()/cxl_handle_endpoint_ras()
> are unnecessary helper functions used only for Endpoints. Remove these
> functions as they are not common for all CXL devices and do not provide
> value for EP handling.
> 
> Rename __cxl_handle_ras to cxl_handle_ras() and __cxl_handle_cor_ras()
> to cxl_handle_cor_ras().
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> 
> ---
> 
> Changes in v10->v11:
> - None
> ---
>  drivers/cxl/core/ras.c | 22 ++++++----------------
>  1 file changed, 6 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index c4f0fa7e40aa..544a0d8773fa 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -200,7 +200,7 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
>  
> -static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
> +static void cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
>  {
>  	void __iomem *addr;
>  	u32 status;
> @@ -236,14 +236,14 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>  static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
>  				      struct cxl_dport *dport)
>  {
> -	return __cxl_handle_cor_ras(cxlds, dport->regs.ras);
> +	return cxl_handle_cor_ras(cxlds, dport->regs.ras);
>  }
>  
>  /*
>   * Log the state of the RAS status registers and prepare them to log the
>   * next error status. Return 1 if reset needed.
>   */
> -static bool __cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
> +static bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
>  {
>  	u32 hl[CXL_HEADERLOG_SIZE_U32];
>  	void __iomem *addr;
> @@ -279,7 +279,7 @@ static bool __cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base
>  static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
>  				  struct cxl_dport *dport)
>  {
> -	return __cxl_handle_ras(cxlds, dport->regs.ras);
> +	return cxl_handle_ras(cxlds, dport->regs.ras);
>  }
>  
>  /*
> @@ -355,16 +355,6 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
>  		cxl_handle_rdport_ras(cxlds, dport);
>  }
>  
> -static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
> -{
> -	return __cxl_handle_cor_ras(cxlds, cxlds->regs.ras);
> -}
> -
> -static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
> -{
> -	return __cxl_handle_ras(cxlds, cxlds->regs.ras);
> -}
> -
>  void cxl_cor_error_detected(struct pci_dev *pdev)
>  {
>  	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> @@ -381,7 +371,7 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
>  		if (cxlds->rcd)
>  			cxl_handle_rdport_errors(cxlds);
>  
> -		cxl_handle_endpoint_cor_ras(cxlds);
> +		cxl_handle_cor_ras(cxlds, cxlds->regs.ras);
>  	}
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
> @@ -410,7 +400,7 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  		 * chance the situation is recoverable dump the status of the RAS
>  		 * capability registers and bounce the active state of the memdev.
>  		 */
> -		ue = cxl_handle_endpoint_ras(cxlds);
> +		ue = cxl_handle_ras(cxlds, cxlds->regs.ras);
>  	}
>  
>  


