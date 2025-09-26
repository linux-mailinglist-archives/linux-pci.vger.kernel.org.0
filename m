Return-Path: <linux-pci+bounces-37131-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF299BA520B
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 22:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B61F87B1E8C
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 20:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A1C286424;
	Fri, 26 Sep 2025 20:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MTneAObT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F54B2848A2;
	Fri, 26 Sep 2025 20:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758919490; cv=none; b=NUtplwuIQvGdtsjxyVuYatvXl9JSjN8tjvA/5nuF6c6hw6VMwVkk1xjiWcIioxSqzYInJli9qHZJlCxOjti6MM9PcEk6GlK3zXIBMSKrMW2jnAydFfkg6w+BVGZWA0LxZciwyoZw4OAflvvhksaqcay+53LdYwP2bRvEt6qtKEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758919490; c=relaxed/simple;
	bh=P97z80np4fcFxZYmgFRrZzy7mGGDoWxlnkfca4HEkvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d17mmCyAbkDTnWV3VVLYi69beyFXrpgFRxXOF5ClaYx4q5kfZGlHIi5OhbzZ/wDzgm35KSiDER77Q6OeSSv/CeRPc+kCYyj8NkvqWgyJC3cnV0DKTCsMPbYfWEtjdGa18Yi1rc4nCpfkT6UiBOQwc8aoUXwVkPN6q2ZPoKNTV5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MTneAObT; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758919489; x=1790455489;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=P97z80np4fcFxZYmgFRrZzy7mGGDoWxlnkfca4HEkvo=;
  b=MTneAObTFBKDClAQp43gCPms4H8ZJFXgzdF2VlSiqkeSH3O70QMXwhUf
   Vox5O15irSUY/43cbRGzwMql3yxtdr0jCiYpb13bst3ExHn1SNLJhTgGU
   lW6Sw+hZ11GDZnhlSAb6VMKEvw6nTe6XkonEBuCx2J6/3UEz0/rnaS1AF
   RKrif/WAFcl9JNdeOS22tCaAJPEuXWbCBOJF1kEY1Jd7sV85Dhf/ZA6zg
   d4OHdzQ802jX4lU/o4RiL55z3A5iCyuskg3WgPjIpjgvTHNRb8JApSE92
   1w3LWiqfHXFTvq5RJ5tunBFUHMhhi8iHskZ4hm0fPGKjfEueXR+MOVJ9C
   g==;
X-CSE-ConnectionGUID: c2ec7T3xQrCU1mbTR29YrQ==
X-CSE-MsgGUID: B02JLmVUQoKUhUI9luJoVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11565"; a="61426207"
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="61426207"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 13:44:48 -0700
X-CSE-ConnectionGUID: AlwjjeU3QZqAfVsq7FGCHw==
X-CSE-MsgGUID: UX4AtovyRk6qhDD0Ft4ICw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="208640314"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.109.69]) ([10.125.109.69])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 13:44:45 -0700
Message-ID: <44212e87-1c70-4bc7-b3ec-7435729a5157@intel.com>
Date: Fri, 26 Sep 2025 13:44:43 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 13/25] cxl/pci: Unify CXL trace logging for CXL
 Endpoints and CXL Ports
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250925223440.3539069-1-terry.bowman@amd.com>
 <20250925223440.3539069-14-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250925223440.3539069-14-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/25/25 3:34 PM, Terry Bowman wrote:
> CXL currently has separate trace routines for CXL Port errors and CXL
> Endpoint errors. This is inconvenient for the user because they must enable
> 2 sets of trace routines. Make updates to the trace logging such that a
> single trace routine logs both CXL Endpoint and CXL Port protocol errors.
> 
> Keep the trace log fields 'memdev' and 'host'. While these are not accurate
> for non-Endpoints the fields will remain as-is to prevent breaking
> userspace RAS trace consumers.
> 
> Add serial number parameter to the trace logging. This is used for EPs
> and 0 is provided for CXL port devices without a serial number.
> 
> Leave the correctable and uncorrectable trace routines' TP_STRUCT__entry()
> unchanged with respect to member data types and order.
> 
> Below is output of correctable and uncorrectable protocol error logging.
> CXL Root Port and CXL Endpoint examples are included below.
> 
> Root Port:
> cxl_aer_correctable_error: memdev=0000:0c:00.0 host=pci0000:0c serial: 0 status='CRC Threshold Hit'
> cxl_aer_uncorrectable_error: memdev=0000:0c:00.0 host=pci0000:0c serial: 0 status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
> 
> Endpoint:
> cxl_aer_correctable_error: memdev=mem3 host=0000:0f:00.0 serial=0 status='CRC Threshold Hit'
> cxl_aer_uncorrectable_error: memdev=mem3 host=0000:0f:00.0 serial: 0 status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Shiju Jose <shiju.jose@huawei.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> 
> Changes in v11 -> v12:
> - Correct parameters to call trace_cxl_aer_correctable_error()
> - Add reviewed-by for Jonathan and Shiju
> 
> Changes in v10->v11:
> - Updated CE and UCE trace routines to maintain consistent TP_Struct ABI
> and unchanged TP_printk() logging.
> ---
>  drivers/cxl/core/ras.c   | 34 ++++++++++----------
>  drivers/cxl/core/trace.h | 68 +++++++---------------------------------
>  2 files changed, 29 insertions(+), 73 deletions(-)
> 
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index c66d37d65241..8a3fbc41b51f 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -13,7 +13,7 @@ static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
>  {
>  	u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
>  
> -	trace_cxl_port_aer_correctable_error(&pdev->dev, status);
> +	trace_cxl_aer_correctable_error(&pdev->dev, status, 0);
>  }
>  
>  static void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
> @@ -28,8 +28,8 @@ static void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
>  	else
>  		fe = status;
>  
> -	trace_cxl_port_aer_uncorrectable_error(&pdev->dev, status, fe,
> -					       ras_cap.header_log);
> +	trace_cxl_aer_uncorrectable_error(&pdev->dev, status, fe,
> +					  ras_cap.header_log, 0);
>  }
>  
>  static void cxl_cper_trace_corr_prot_err(struct cxl_memdev *cxlmd,
> @@ -37,7 +37,7 @@ static void cxl_cper_trace_corr_prot_err(struct cxl_memdev *cxlmd,
>  {
>  	u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
>  
> -	trace_cxl_aer_correctable_error(cxlmd, status);
> +	trace_cxl_aer_correctable_error(&cxlmd->dev, status, cxlmd->cxlds->serial);
>  }
>  
>  static void
> @@ -45,6 +45,7 @@ cxl_cper_trace_uncorr_prot_err(struct cxl_memdev *cxlmd,
>  			       struct cxl_ras_capability_regs ras_cap)
>  {
>  	u32 status = ras_cap.uncor_status & ~ras_cap.uncor_mask;
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	u32 fe;
>  
>  	if (hweight32(status) > 1)
> @@ -53,8 +54,9 @@ cxl_cper_trace_uncorr_prot_err(struct cxl_memdev *cxlmd,
>  	else
>  		fe = status;
>  
> -	trace_cxl_aer_uncorrectable_error(cxlmd, status, fe,
> -					  ras_cap.header_log);
> +	trace_cxl_aer_uncorrectable_error(&cxlmd->dev, status, fe,
> +					  ras_cap.header_log,
> +					  cxlds->serial);
>  }
>  
>  static int match_memdev_by_parent(struct device *dev, const void *uport)
> @@ -126,8 +128,8 @@ void cxl_ras_exit(void)
>  	cancel_work_sync(&cxl_cper_prot_err_work);
>  }
>  
> -static void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base);
> -static bool cxl_handle_ras(struct device *dev, void __iomem *ras_base);
> +static void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base);
> +static bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base);
>  
>  #ifdef CONFIG_CXL_RCH_RAS
>  static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
> @@ -237,9 +239,9 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
>  
>  	pci_print_aer(pdev, severity, &aer_regs);
>  	if (severity == AER_CORRECTABLE)
> -		cxl_handle_cor_ras(&cxlds->cxlmd->dev, dport->regs.ras);
> +		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial, dport->regs.ras);
>  	else
> -		cxl_handle_ras(&cxlds->cxlmd->dev, dport->regs.ras);
> +		cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial, dport->regs.ras);
>  }
>  #else
>  static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
> @@ -281,7 +283,7 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
>  
> -static void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
> +static void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>  {
>  	void __iomem *addr;
>  	u32 status;
> @@ -295,7 +297,7 @@ static void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
>  	status = readl(addr);
>  	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
>  		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> -		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
> +		trace_cxl_aer_correctable_error(dev, status, serial);
>  	}
>  }
>  
> @@ -320,7 +322,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>   * Log the state of the RAS status registers and prepare them to log the
>   * next error status. Return 1 if reset needed.
>   */
> -static bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
> +static bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>  {
>  	u32 hl[CXL_HEADERLOG_SIZE_U32];
>  	void __iomem *addr;
> @@ -349,7 +351,7 @@ static bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>  	}
>  
>  	header_log_copy(ras_base, hl);
> -	trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
> +	trace_cxl_aer_uncorrectable_error(dev, status, fe, hl, serial);
>  	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>  
>  	return true;
> @@ -371,7 +373,7 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
>  		if (cxlds->rcd)
>  			cxl_handle_rdport_errors(cxlds);
>  
> -		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
> +		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
>  	}
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
> @@ -400,7 +402,7 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  		 * chance the situation is recoverable dump the status of the RAS
>  		 * capability registers and bounce the active state of the memdev.
>  		 */
> -		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
> +		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
>  	}
>  
>  
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index a53ec4798b12..60b49beb5e3f 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -48,40 +48,13 @@
>  	{ CXL_RAS_UC_IDE_RX_ERR, "IDE Rx Error" }			  \
>  )
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
>  TRACE_EVENT(cxl_aer_uncorrectable_error,
> -	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status, u32 fe, u32 *hl),
> -	TP_ARGS(cxlmd, status, fe, hl),
> +	TP_PROTO(const struct device *cxlmd, u32 status, u32 fe, u32 *hl,
> +		 u64 serial),
> +	TP_ARGS(cxlmd, status, fe, hl, serial),
>  	TP_STRUCT__entry(
> -		__string(memdev, dev_name(&cxlmd->dev))
> -		__string(host, dev_name(cxlmd->dev.parent))
> +		__string(memdev, dev_name(cxlmd))
> +		__string(host, dev_name(cxlmd->parent))
>  		__field(u64, serial)
>  		__field(u32, status)
>  		__field(u32, first_error)
> @@ -90,7 +63,7 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
>  	TP_fast_assign(
>  		__assign_str(memdev);
>  		__assign_str(host);
> -		__entry->serial = cxlmd->cxlds->serial;
> +		__entry->serial = serial;
>  		__entry->status = status;
>  		__entry->first_error = fe;
>  		/*
> @@ -124,38 +97,19 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
>  	{ CXL_RAS_CE_PHYS_LAYER_ERR, "Received Error From Physical Layer" }	\
>  )
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
>  TRACE_EVENT(cxl_aer_correctable_error,
> -	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status),
> -	TP_ARGS(cxlmd, status),
> +	TP_PROTO(const struct device *cxlmd, u32 status, u64 serial),
> +	TP_ARGS(cxlmd, status, serial),
>  	TP_STRUCT__entry(
> -		__string(memdev, dev_name(&cxlmd->dev))
> -		__string(host, dev_name(cxlmd->dev.parent))
> +		__string(memdev, dev_name(cxlmd))
> +		__string(host, dev_name(cxlmd->parent))
>  		__field(u64, serial)
>  		__field(u32, status)
>  	),
>  	TP_fast_assign(
>  		__assign_str(memdev);
>  		__assign_str(host);
> -		__entry->serial = cxlmd->cxlds->serial;
> +		__entry->serial = serial;
>  		__entry->status = status;
>  	),
>  	TP_printk("memdev=%s host=%s serial=%lld: status: '%s'",


