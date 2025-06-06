Return-Path: <linux-pci+bounces-29069-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B062AACFA79
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 02:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70CE51797E5
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 00:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E0618EB0;
	Fri,  6 Jun 2025 00:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ikpW6Ysl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D455E35946;
	Fri,  6 Jun 2025 00:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749171035; cv=none; b=uTA8pHkpLkwdji9p+3GDBxKdpgo99jyItSKA6bkUhFQoXGOTrEPaWm25Gez41nY71XUSigZvQ+KCt+dem5kr/UEpixt3bX9LuXVEUXEuvjeDqNgrVvfp4pxotQeai9aTSQ1bLWBGqzW+K6YUhcmg/2shnBCmTnY7FJsBaPvpiiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749171035; c=relaxed/simple;
	bh=qkj395VHNHXNovn1Y6RMPe3u8svEBSCFsvjao8b2E3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ghLnXqfD0/hWi8RAVoAelDd9sXsC19/yhQ++xHWfL5l1JtVytvFXxv1Xb86AsjEKGEXB2MlBzKpDmGYDF/TvPpmOjFkIlnBCGYpoIkCgj0n+V7BHdqTi2vB1maXZovALr8cQ7l/HXldcGKxCohptzK7T1IJmzst38A0HKMb6+Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ikpW6Ysl; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749171034; x=1780707034;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=qkj395VHNHXNovn1Y6RMPe3u8svEBSCFsvjao8b2E3g=;
  b=ikpW6YsloUTs+YCuQHZ5AKFBPWu2yy3GchdulTbvqY7NnUn+ZCl3M3/K
   ZWGko/is6VIqFogpqKIBZJ2Wpcz7ey1XGcDw9zYeEfcLSfD1Z5iGY2cgE
   FpnCFJg9Z/8ELpxKZxalJbeIgLrpVLx9DV3NdozGdmvocZV0VXcZsKlak
   gxuYCi/9XKuYJ+a/3Hsg50p09N0Af9O7yNt4g1FQR4FRlhUQbOK3KA5cd
   QskXmX5LQfzucJqwFJMXOEe1zUh3oIdagPOQwaup1A9FKrFQ3CtJO90ay
   kph+m+H0XuRx4tcILE58+RwI/mTZTEeTsscxDBVQNvzf0mx/F62RMx/UO
   A==;
X-CSE-ConnectionGUID: szg40TeVT4uFbpO98RffwA==
X-CSE-MsgGUID: XDmT+alQQt2nVnGXy2bi3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="51455951"
X-IronPort-AV: E=Sophos;i="6.16,213,1744095600"; 
   d="scan'208";a="51455951"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 17:50:32 -0700
X-CSE-ConnectionGUID: eHnAYG4gQ2qE3SNKA11o0A==
X-CSE-MsgGUID: Odm49DpAQ7iy9mJUcqZZjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,213,1744095600"; 
   d="scan'208";a="168839469"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 17:50:31 -0700
Received: from [10.124.222.132] (unknown [10.124.222.132])
	by linux.intel.com (Postfix) with ESMTP id 3C12020B5736;
	Thu,  5 Jun 2025 17:50:30 -0700 (PDT)
Message-ID: <2a296ad3-9f88-47e2-8821-0756d5ede76b@linux.intel.com>
Date: Thu, 5 Jun 2025 17:50:30 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 14/16] cxl/pci: Remove unnecessary CXL Endpoint
 handling helper functions
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
 <20250603172239.159260-15-terry.bowman@amd.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250603172239.159260-15-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/3/25 10:22 AM, Terry Bowman wrote:
> The CXL driver's cxl_handle_endpoint_cor_ras()/cxl_handle_endpoint_ras()
> are unnecessary helper functions used only for Endpoints. Remove these
> functions as they are not common for all CXL devices and do not provide
> value for EP handling.
>
> Rename __cxl_handle_ras to cxl_handle_ras() and __cxl_handle_cor_ras()
> to cxl_handle_cor_ras().
>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>   drivers/cxl/core/pci.c | 32 ++++++++++++--------------------
>   1 file changed, 12 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index b6836825e8df..b36a58607041 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -664,8 +664,8 @@ void read_cdat_data(struct cxl_port *port)
>   }
>   EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
>   
> -static void __cxl_handle_cor_ras(struct device *dev, u64 serial,
> -				 void __iomem *ras_base)
> +static void cxl_handle_cor_ras(struct device *dev, u64 serial,
> +			       void __iomem *ras_base)
>   {
>   	void __iomem *addr;
>   	u32 status;
> @@ -684,11 +684,6 @@ static void __cxl_handle_cor_ras(struct device *dev, u64 serial,
>   	trace_cxl_aer_correctable_error(dev, serial, status);
>   }
>   
> -static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
> -{
> -	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
> -}
> -
>   /* CXL spec rev3.0 8.2.4.16.1 */
>   static void header_log_copy(void __iomem *ras_base, u32 *log)
>   {
> @@ -710,8 +705,8 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>    * Log the state of the RAS status registers and prepare them to log the
>    * next error status. Return 1 if reset needed.
>    */
> -static pci_ers_result_t __cxl_handle_ras(struct device *dev, u64 serial,
> -					 void __iomem *ras_base)
> +static pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial,
> +				       void __iomem *ras_base)
>   {
>   	u32 hl[CXL_HEADERLOG_SIZE_U32];
>   	void __iomem *addr;
> @@ -746,11 +741,6 @@ static pci_ers_result_t __cxl_handle_ras(struct device *dev, u64 serial,
>   	return PCI_ERS_RESULT_PANIC;
>   }
>   
> -static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
> -{
> -	return __cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
> -}
> -
>   #ifdef CONFIG_PCIEAER_CXL
>   
>   static void __iomem *cxl_get_ras_base(struct device *dev)
> @@ -802,7 +792,7 @@ void cxl_port_cor_error_detected(struct device *dev)
>   {
>   	void __iomem *ras_base = cxl_get_ras_base(dev);
>   
> -	__cxl_handle_cor_ras(dev, 0, ras_base);
> +	cxl_handle_cor_ras(dev, 0, ras_base);
>   }
>   EXPORT_SYMBOL_NS_GPL(cxl_port_cor_error_detected, "CXL");
>   
> @@ -810,20 +800,20 @@ pci_ers_result_t cxl_port_error_detected(struct device *dev)
>   {
>   	void __iomem *ras_base = cxl_get_ras_base(dev);
>   
> -	return  __cxl_handle_ras(dev, 0, ras_base);
> +	return  cxl_handle_ras(dev, 0, ras_base);
>   }
>   EXPORT_SYMBOL_NS_GPL(cxl_port_error_detected, "CXL");
>   
>   static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
>   					  struct cxl_dport *dport)
>   {
> -	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial, dport->regs.ras);
> +	return cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial, dport->regs.ras);
>   }
>   
>   static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
>   				       struct cxl_dport *dport)
>   {
> -	return __cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial, dport->regs.ras);
> +	return cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial, dport->regs.ras);
>   }
>   
>   /*
> @@ -921,7 +911,8 @@ void cxl_cor_error_detected(struct device *dev)
>   		if (cxlds->rcd)
>   			cxl_handle_rdport_errors(cxlds);
>   
> -		cxl_handle_endpoint_cor_ras(cxlds);
> +		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial,
> +				   cxlds->regs.ras);
>   	}
>   }
>   EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
> @@ -958,7 +949,8 @@ pci_ers_result_t cxl_error_detected(struct device *dev)
>   		 * chance the situation is recoverable dump the status of the RAS
>   		 * capability registers and bounce the active state of the memdev.
>   		 */
> -		ue = cxl_handle_endpoint_ras(cxlds);
> +		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial,
> +				    cxlds->regs.ras);
>   	}
>   
>   	return ue;

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


