Return-Path: <linux-pci+bounces-29048-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2ED9ACF4AE
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 18:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C4FC173E00
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 16:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9B11F4CAC;
	Thu,  5 Jun 2025 16:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WBw36CIs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9525546BF;
	Thu,  5 Jun 2025 16:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749142157; cv=none; b=pP0Vk9DvU7Ne0rq1+wsXbKnj0Oy6XMuVfecsEH++wPC8V7UA2lVD9Mi+DpyUFcAIgC7FbhHtefpni6bYG1T9xECoQdJof4yZk4FHqKzW6xxz5eXIdi036RMjwpJ5nLkGgwZIEY5RBfTLw+4lHM/Epl0rQQRoWHacniTrmWy78ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749142157; c=relaxed/simple;
	bh=5INK5Y26AD3T4VyspB8k2q0xzgY9rPqcSEToekV0KPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jkHwL1KLdnxBWDHxKLhJLRJWJagajuP6t+GDTP+sSn/wpqguc3XSE+KVyps+o0jQk9/D2tISTs49GI4w7pdQTpbRlZsqh3UF9sYhViroI8ifkH6oNzIe9rS1a6lvgtRVvkLQ88fvJYb2jxAXISa2hz3sR86ks4V4MQAzSsjH4r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WBw36CIs; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749142155; x=1780678155;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=5INK5Y26AD3T4VyspB8k2q0xzgY9rPqcSEToekV0KPY=;
  b=WBw36CIsp1dc+/dGbZfwua9sx27fdLuAd4OaYvxQkaw6+4PWA1Jll5dW
   9B51sfoV+swNnTrJR0q53p2CoSdSv5TfOCut9VfgAjhQOGJhr8qZR9UsP
   4efbQCitOKa9GhPX0+xI8uGFvcCS2x8F8FctZTxgnrxBO2aEDuIkiJ+cV
   5TDKG8yXOAh64OclFUBJcZJTCEw/oam4zH6bInjggauWgiWC20jYc7Fpi
   JZfbUv3lGm7lGDZEg3fJO7IgGzAKujEB5qt9RpQw9isxuRG61d+cPvW5F
   T89QkXCra/Mc3e345kQcZKrGucKC0bojyKsFoN/9ov1dl8kjvkDlllCcR
   w==;
X-CSE-ConnectionGUID: bowdD3t0QPO1lAO8AgnmCA==
X-CSE-MsgGUID: vYcyL6KiRBefKwPxPFPLcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="51347239"
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; 
   d="scan'208";a="51347239"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 09:49:14 -0700
X-CSE-ConnectionGUID: z59/7yAETauDjOJAs5oi3A==
X-CSE-MsgGUID: f2pwzR7LTyqAqdzZPpkAig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; 
   d="scan'208";a="146152899"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 09:49:15 -0700
Received: from [10.124.222.23] (unknown [10.124.222.23])
	by linux.intel.com (Postfix) with ESMTP id 2C7EB20B5736;
	Thu,  5 Jun 2025 09:49:13 -0700 (PDT)
Message-ID: <24296383-f676-4bf7-8616-a4fba5b7ac57@linux.intel.com>
Date: Thu, 5 Jun 2025 09:49:12 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 10/16] cxl/pci: Unify CXL trace logging for CXL
 Endpoints and CXL Ports
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
 <20250603172239.159260-11-terry.bowman@amd.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250603172239.159260-11-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/3/25 10:22 AM, Terry Bowman wrote:
> CXL currently has separate trace routines for CXL Port errors and CXL
> Endpoint errors. This is inconvenient for the user because they must enable
> 2 sets of trace routines. Make updates to the trace logging such that a
> single trace routine logs both CXL Endpoint and CXL Port protocol errors.
>
> Rename the 'host' field from the CXL Endpoint trace to 'parent' in the
> unified trace routines. 'host' does not correctly apply to CXL Port
> devices. Parent is more general and applies to CXL Port devices and CXL
> Endpoints.
>
> Add serial number parameter to the trace logging. This is used for EPs
> and 0 is provided for CXL port devices without a serial number.
>
> Below is output of correctable and uncorrectable protocol error logging.
> CXL Root Port and CXL Endpoint examples are included below.
>
> Root Port:
> cxl_aer_correctable_error: device=0000:0c:00.0 parent=pci0000:0c serial: 0 status='CRC Threshold Hit'
> cxl_aer_uncorrectable_error: device=0000:0c:00.0 parent=pci0000:0c serial: 0 status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
>
> Endpoint:
> cxl_aer_correctable_error: device=mem3 parent=0000:0f:00.0 serial=0 status='CRC Threshold Hit'
> cxl_aer_uncorrectable_error: device=mem3 parent=0000:0f:00.0 serial: 0 status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---


Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>


>   drivers/cxl/core/pci.c   | 18 +++++----
>   drivers/cxl/core/ras.c   | 14 ++++---
>   drivers/cxl/core/trace.h | 84 +++++++++-------------------------------
>   3 files changed, 37 insertions(+), 79 deletions(-)
>
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 186a5a20b951..0f4c07fd64a5 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -664,7 +664,7 @@ void read_cdat_data(struct cxl_port *port)
>   }
>   EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
>   
> -static void __cxl_handle_cor_ras(struct device *dev,
> +static void __cxl_handle_cor_ras(struct device *dev, u64 serial,
>   				 void __iomem *ras_base)
>   {
>   	void __iomem *addr;
> @@ -679,13 +679,13 @@ static void __cxl_handle_cor_ras(struct device *dev,
>   	status = readl(addr);
>   	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
>   		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> -		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
> +		trace_cxl_aer_correctable_error(dev, serial, status);
>   	}
>   }
>   
>   static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
>   {
> -	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
> +	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
>   }
>   
>   /* CXL spec rev3.0 8.2.4.16.1 */
> @@ -709,7 +709,8 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>    * Log the state of the RAS status registers and prepare them to log the
>    * next error status. Return 1 if reset needed.
>    */
> -static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
> +static bool __cxl_handle_ras(struct device *dev, u64 serial,
> +			     void __iomem *ras_base)
>   {
>   	u32 hl[CXL_HEADERLOG_SIZE_U32];
>   	void __iomem *addr;
> @@ -738,7 +739,7 @@ static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>   	}
>   
>   	header_log_copy(ras_base, hl);
> -	trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
> +	trace_cxl_aer_uncorrectable_error(dev, serial, status, fe, hl);
>   	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>   
>   	return true;
> @@ -746,7 +747,8 @@ static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>   
>   static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
>   {
> -	return __cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
> +
> +	return __cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
>   }
>   
>   #ifdef CONFIG_PCIEAER_CXL
> @@ -754,13 +756,13 @@ static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
>   static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
>   					  struct cxl_dport *dport)
>   {
> -	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, dport->regs.ras);
> +	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial, dport->regs.ras);
>   }
>   
>   static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
>   				       struct cxl_dport *dport)
>   {
> -	return __cxl_handle_ras(&cxlds->cxlmd->dev, dport->regs.ras);
> +	return __cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial, dport->regs.ras);
>   }
>   
>   /*
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 715f7221ea3a..0ef8c2068c0c 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -13,7 +13,7 @@ static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
>   {
>   	u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
>   
> -	trace_cxl_port_aer_correctable_error(&pdev->dev, status);
> +	trace_cxl_aer_correctable_error(&pdev->dev, 0, status);
>   }
>   
>   static void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
> @@ -28,8 +28,8 @@ static void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
>   	else
>   		fe = status;
>   
> -	trace_cxl_port_aer_uncorrectable_error(&pdev->dev, status, fe,
> -					       ras_cap.header_log);
> +	trace_cxl_aer_uncorrectable_error(&pdev->dev, 0, status, fe,
> +					  ras_cap.header_log);
>   }
>   
>   static void cxl_cper_trace_corr_prot_err(struct pci_dev *pdev,
> @@ -42,7 +42,8 @@ static void cxl_cper_trace_corr_prot_err(struct pci_dev *pdev,
>   	if (!cxlds)
>   		return;
>   
> -	trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
> +	trace_cxl_aer_correctable_error(&cxlds->cxlmd->dev, cxlds->serial,
> +					status);
>   }
>   
>   static void cxl_cper_trace_uncorr_prot_err(struct pci_dev *pdev,
> @@ -62,8 +63,9 @@ static void cxl_cper_trace_uncorr_prot_err(struct pci_dev *pdev,
>   	else
>   		fe = status;
>   
> -	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe,
> -					  ras_cap.header_log);
> +	trace_cxl_aer_uncorrectable_error(&cxlds->cxlmd->dev,
> +					  cxlds->serial, status,
> +					  fe, ras_cap.header_log);
>   }
>   
>   static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index 25ebfbc1616c..8c91b0f3d165 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -48,49 +48,22 @@
>   	{ CXL_RAS_UC_IDE_RX_ERR, "IDE Rx Error" }			  \
>   )
>   
> -TRACE_EVENT(cxl_port_aer_uncorrectable_error,
> -	TP_PROTO(struct device *dev, u32 status, u32 fe, u32 *hl),
> -	TP_ARGS(dev, status, fe, hl),
> -	TP_STRUCT__entry(
> -		__string(device, dev_name(dev))
> -		__string(host, dev_name(dev->parent))
> -		__field(u32, status)
> -		__field(u32, first_error)
> -		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
> -	),
> -	TP_fast_assign(
> -		__assign_str(device);
> -		__assign_str(host);
> -		__entry->status = status;
> -		__entry->first_error = fe;
> -		/*
> -		 * Embed the 512B headerlog data for user app retrieval and
> -		 * parsing, but no need to print this in the trace buffer.
> -		 */
> -		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
> -	),
> -	TP_printk("device=%s host=%s status: '%s' first_error: '%s'",
> -		  __get_str(device), __get_str(host),
> -		  show_uc_errs(__entry->status),
> -		  show_uc_errs(__entry->first_error)
> -	)
> -);
> -
>   TRACE_EVENT(cxl_aer_uncorrectable_error,
> -	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status, u32 fe, u32 *hl),
> -	TP_ARGS(cxlmd, status, fe, hl),
> +	TP_PROTO(struct device *dev, u64 serial, u32 status, u32 fe,
> +		 u32 *hl),
> +	TP_ARGS(dev, serial, status, fe, hl),
>   	TP_STRUCT__entry(
> -		__string(memdev, dev_name(&cxlmd->dev))
> -		__string(host, dev_name(cxlmd->dev.parent))
> +		__string(name, dev_name(dev))
> +		__string(parent, dev_name(dev->parent))
>   		__field(u64, serial)
>   		__field(u32, status)
>   		__field(u32, first_error)
>   		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
>   	),
>   	TP_fast_assign(
> -		__assign_str(memdev);
> -		__assign_str(host);
> -		__entry->serial = cxlmd->cxlds->serial;
> +		__assign_str(name);
> +		__assign_str(parent);
> +		__entry->serial = serial;
>   		__entry->status = status;
>   		__entry->first_error = fe;
>   		/*
> @@ -99,8 +72,8 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
>   		 */
>   		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
>   	),
> -	TP_printk("memdev=%s host=%s serial=%lld: status: '%s' first_error: '%s'",
> -		  __get_str(memdev), __get_str(host), __entry->serial,
> +	TP_printk("device=%s parent=%s serial=%lld status='%s' first_error='%s'",
> +		  __get_str(name), __get_str(parent), __entry->serial,
>   		  show_uc_errs(__entry->status),
>   		  show_uc_errs(__entry->first_error)
>   	)
> @@ -124,42 +97,23 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
>   	{ CXL_RAS_CE_PHYS_LAYER_ERR, "Received Error From Physical Layer" }	\
>   )
>   
> -TRACE_EVENT(cxl_port_aer_correctable_error,
> -	TP_PROTO(struct device *dev, u32 status),
> -	TP_ARGS(dev, status),
> -	TP_STRUCT__entry(
> -		__string(device, dev_name(dev))
> -		__string(host, dev_name(dev->parent))
> -		__field(u32, status)
> -	),
> -	TP_fast_assign(
> -		__assign_str(device);
> -		__assign_str(host);
> -		__entry->status = status;
> -	),
> -	TP_printk("device=%s host=%s status='%s'",
> -		  __get_str(device), __get_str(host),
> -		  show_ce_errs(__entry->status)
> -	)
> -);
> -
>   TRACE_EVENT(cxl_aer_correctable_error,
> -	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status),
> -	TP_ARGS(cxlmd, status),
> +	TP_PROTO(struct device *dev, u64 serial, u32 status),
> +	TP_ARGS(dev, serial, status),
>   	TP_STRUCT__entry(
> -		__string(memdev, dev_name(&cxlmd->dev))
> -		__string(host, dev_name(cxlmd->dev.parent))
> +		__string(name, dev_name(dev))
> +		__string(parent, dev_name(dev->parent))
>   		__field(u64, serial)
>   		__field(u32, status)
>   	),
>   	TP_fast_assign(
> -		__assign_str(memdev);
> -		__assign_str(host);
> -		__entry->serial = cxlmd->cxlds->serial;
> +		__assign_str(name);
> +		__assign_str(parent);
> +		__entry->serial = serial;
>   		__entry->status = status;
>   	),
> -	TP_printk("memdev=%s host=%s serial=%lld: status: '%s'",
> -		  __get_str(memdev), __get_str(host), __entry->serial,
> +	TP_printk("device=%s parent=%s serial=%lld status='%s'",
> +		  __get_str(name), __get_str(parent), __entry->serial,
>   		  show_ce_errs(__entry->status)
>   	)
>   );

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


