Return-Path: <linux-pci+bounces-32557-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B04DB0A9DA
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 19:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B25B51C82FB4
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 17:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264142E7BAE;
	Fri, 18 Jul 2025 17:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Me//MvHA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170FE2DECAA;
	Fri, 18 Jul 2025 17:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752861367; cv=none; b=WPEYx0OFMYE07SlZT7KoSIrUMDIt6t5y7zGXqc/2C5y7ZpOMLUmm3GL0IagPZm34GxIS05KU83ypvKA117SER83caiWOyHWvDxRoKzJLmkJwEUVtPspnr1/g0CaUF8I5HGC0/rZ3/vACVFNFbhRMdPIv73AyIDYcudbhbzZJi3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752861367; c=relaxed/simple;
	bh=McAH1OCwdXwhqAQAklIqbVHdXdpc4H25iE07cWBLS0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oY+ZOjU/qQKJ8JD3YeHFTfbYhsnIFPb3H5rqNotiKVIobcZ6eS91brKI83nMaHboDEyc5htXus7B13PQ62h2V62av+3FgoXHkARSKsmm5R0V4+gB4aZiAI3gZrhSxIrlapTIwQsvZlKSyBDQ6aqmXr9YmstTZcyIsHv5cTDnOKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Me//MvHA; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752861366; x=1784397366;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=McAH1OCwdXwhqAQAklIqbVHdXdpc4H25iE07cWBLS0c=;
  b=Me//MvHAdJQTNx+YbsEFVll63C/tk67wkHkMRrDXmcUyBxAegGzpkNhx
   7ZOh4fPojHXeRfEkbTvJVFP+w9y8F2QkUYOXZul3m4K7JEsqRcerMH418
   FT+beZ1RrNCcr+70EbL7CLxSXQUwHLWbiUDaaAgrkkKLQTPToB1pXsrRq
   FZVEm6ecxwz1SeYsPdyynkOz+rR/DCBLB5wu4eFEtNDgzzZf/l1u0yNoC
   e9/TXXHT+gEuU2JcDRgPJ/dNVIpLjXhlrdFQG8oH2U2SrjGlDnzJXKOLZ
   mWAPh6595NZ+dK8syoidAp55LjyDFsKKW+MckgcP6Cy3vzKTtBwxv9tas
   g==;
X-CSE-ConnectionGUID: zjK/Y5C3QUiQFda2fkwcRA==
X-CSE-MsgGUID: RmAVUWrhR5+KCkS2OPnFBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="65852936"
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="65852936"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 10:56:05 -0700
X-CSE-ConnectionGUID: RlfGcGgCTCyKroBUfmu2rA==
X-CSE-MsgGUID: SWel8q8cSBizg2Up7Qw9EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="158809285"
Received: from unknown (HELO [10.247.118.125]) ([10.247.118.125])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 10:55:56 -0700
Message-ID: <d1885619-fc34-4b72-9538-34f1993a538a@intel.com>
Date: Fri, 18 Jul 2025 10:55:49 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 01/17] cxl/pci: Remove unnecessary CXL Endpoint
 handling helper functions
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
 <20250626224252.1415009-2-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250626224252.1415009-2-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/26/25 3:42 PM, Terry Bowman wrote:
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
> ---
>  drivers/cxl/core/pci.c | 26 ++++++++------------------
>  1 file changed, 8 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index b50551601c2e..06464a25d8bd 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -664,8 +664,8 @@ void read_cdat_data(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
>  
> -static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
> -				 void __iomem *ras_base)
> +static void cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
> +			       void __iomem *ras_base)
>  {
>  	void __iomem *addr;
>  	u32 status;
> @@ -681,11 +681,6 @@ static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
>  	}
>  }
>  
> -static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
> -{
> -	return __cxl_handle_cor_ras(cxlds, cxlds->regs.ras);
> -}
> -
>  /* CXL spec rev3.0 8.2.4.16.1 */
>  static void header_log_copy(void __iomem *ras_base, u32 *log)
>  {
> @@ -707,8 +702,8 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>   * Log the state of the RAS status registers and prepare them to log the
>   * next error status. Return 1 if reset needed.
>   */
> -static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
> -				  void __iomem *ras_base)
> +static bool cxl_handle_ras(struct cxl_dev_state *cxlds,
> +			   void __iomem *ras_base)
>  {
>  	u32 hl[CXL_HEADERLOG_SIZE_U32];
>  	void __iomem *addr;
> @@ -741,11 +736,6 @@ static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
>  	return true;
>  }
>  
> -static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
> -{
> -	return __cxl_handle_ras(cxlds, cxlds->regs.ras);
> -}
> -
>  #ifdef CONFIG_PCIEAER_CXL
>  
>  static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
> @@ -824,13 +814,13 @@ EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
>  static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
>  					  struct cxl_dport *dport)
>  {
> -	return __cxl_handle_cor_ras(cxlds, dport->regs.ras);
> +	return cxl_handle_cor_ras(cxlds, dport->regs.ras);
>  }
>  
>  static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
>  				       struct cxl_dport *dport)
>  {
> -	return __cxl_handle_ras(cxlds, dport->regs.ras);
> +	return cxl_handle_ras(cxlds, dport->regs.ras);
>  }
>  
>  /*
> @@ -927,7 +917,7 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
>  		if (cxlds->rcd)
>  			cxl_handle_rdport_errors(cxlds);
>  
> -		cxl_handle_endpoint_cor_ras(cxlds);
> +		cxl_handle_cor_ras(cxlds, cxlds->regs.ras);
>  	}
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
> @@ -956,7 +946,7 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  		 * chance the situation is recoverable dump the status of the RAS
>  		 * capability registers and bounce the active state of the memdev.
>  		 */
> -		ue = cxl_handle_endpoint_ras(cxlds);
> +		ue = cxl_handle_ras(cxlds, cxlds->regs.ras);
>  	}
>  
>  


