Return-Path: <linux-pci+bounces-21252-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB1DA31A64
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 01:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 958883A2C91
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 00:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8F72111;
	Wed, 12 Feb 2025 00:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ISounDlG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA868184F;
	Wed, 12 Feb 2025 00:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739319671; cv=none; b=qyd9+/b6iFJbTboHC5KKOFb2lYMSEcOYXGMMTC94T/SylWkSCC69omMOi2V/WDkJCLDCIgs0w/Y3VUA8n4RGGUy56CIaFtnCUXzoc5KhSFSZkOBawhPocCVfH9p/ln3qx5Cf2gcyRtkefYk04feBU1kHYq9ZmC4hxLOsVoIs/VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739319671; c=relaxed/simple;
	bh=/CEXSrTmZdPl+/S4+AGhkhg8flAiL0XXWEFHbXDGdm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ice10kF8wbbk1FEZAyw8JszqkKgPIYKAW3z5UhWu7PpZSpN/VaI5Cbcgk3/Ytg1bvt+oLTuS0cBXBPQntR5IzsehioNK6JFWzOWto3T4yJB0MDIO0wfa/Fp+oUoWGps8Qfiuf1qPROsS9cpGx7EzG3gf8ogC9zbQ058wRVLdIfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ISounDlG; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739319670; x=1770855670;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=/CEXSrTmZdPl+/S4+AGhkhg8flAiL0XXWEFHbXDGdm0=;
  b=ISounDlG5nDnOpWtw17DMeN12MbLkS7lY73STCER33yEByr5DdmdRzuV
   jVKXICqmntpwujGlSplZo1IuECb18rMTIaQsrNNGnlGAbu+r/g5cREJzR
   A1h3WcW3TjwZ9mkN1Y8PpHtCGaBFPzIuw9cRjo8lw8fdPBUGQXPbcjBvt
   uLmjsqIZaL3Fz+uOUyCCXrn0mD88gQric/eWm7CMnZ/E5ZEr/3dxzN+Vq
   9fnFDl9s3yuHyebrpM0tibKXrG81H2a/0hil2kdDtVbXHr3QrfuMi+ygz
   bQW3TrThvAEntWex6rquhI98YvJfY2kgbjGZFliSVqxSkIvWkFFHKm/q/
   g==;
X-CSE-ConnectionGUID: eibws3IOTeSRs3JF14SXHg==
X-CSE-MsgGUID: gNjDZJoNRg6NR4RetBsp8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="50946496"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="50946496"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 16:21:09 -0800
X-CSE-ConnectionGUID: oZPxr2i+QMeDf29dIurdpw==
X-CSE-MsgGUID: 6zCyBx5LRjO7QHisyheGyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="112652781"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.125.108.65]) ([10.125.108.65])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 16:21:07 -0800
Message-ID: <0f8f7891-5d2a-4470-8427-6282f7bc3351@intel.com>
Date: Tue, 11 Feb 2025 17:21:04 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 14/17] cxl/pci: Update CXL Port RAS logging to also
 display PCIe SBDF
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
 <20250211192444.2292833-15-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250211192444.2292833-15-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/11/25 12:24 PM, Terry Bowman wrote:
> CXL RAS errors are currently logged using the associated CXL port's name
> returned from devname(). They are typically named with 'port1', 'port2',
> etc. to indicate the hierarchial location in the CXL topology. But, this
> doesn't clearly indicate the CXL card or slot reporting the error.
> 
> Update the logging to also log the corresponding PCIe devname. This will
> give a PCIe SBDF or ACPI object name (in case of CXL HB). This will provide
> details helping users understand which physical slot and card has the
> error.
> 
> Below is example output after making these changes.
> 
> Correctable error example output:
> cxl_port_aer_correctable_error: device=port1 (0000:0c:00.0) parent=root0 (pci0000:0c) status='Received Error From Physical Layer'
> 
> Uncorrectable error example output:
> cxl_port_aer_uncorrectable_error: device=port1 (0000:0c:00.0) parent=root0 (pci0000:0c) status: 'Memory Byte Enable Parity Error' first_error: 'Memory Byte Enable Parity Error'
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

I wonder if there's any benefit in identifying if the PCIe device is USP or DSP...

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/pci.c   | 39 +++++++++++++++++++------------------
>  drivers/cxl/core/trace.h | 42 +++++++++++++++++++++++++---------------
>  2 files changed, 46 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 9a3090dae46a..f154dcf6dfda 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -652,14 +652,14 @@ void read_cdat_data(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
>  
> -static void __cxl_handle_cor_ras(struct device *dev,
> +static void __cxl_handle_cor_ras(struct device *cxl_dev, struct device *pcie_dev,
>  				 void __iomem *ras_base)
>  {
>  	void __iomem *addr;
>  	u32 status;
>  
>  	if (!ras_base) {
> -		dev_warn_once(dev, "CXL RAS register block is not mapped");
> +		dev_warn_once(cxl_dev, "CXL RAS register block is not mapped");
>  		return;
>  	}
>  
> @@ -669,15 +669,15 @@ static void __cxl_handle_cor_ras(struct device *dev,
>  		return;
>  	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
>  
> -	if (is_cxl_memdev(dev))
> -		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
> -	else if (is_cxl_port(dev))
> -		trace_cxl_port_aer_correctable_error(dev, status);
> +	if (is_cxl_memdev(cxl_dev))
> +		trace_cxl_aer_correctable_error(to_cxl_memdev(cxl_dev), status);
> +	else if (is_cxl_port(cxl_dev))
> +		trace_cxl_port_aer_correctable_error(cxl_dev, pcie_dev, status);
>  }
>  
>  static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
>  {
> -	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
> +	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, NULL, cxlds->regs.ras);
>  }
>  
>  /* CXL spec rev3.0 8.2.4.16.1 */
> @@ -701,7 +701,8 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>   * Log the state of the RAS status registers and prepare them to log the
>   * next error status. Return 1 if reset needed.
>   */
> -static pci_ers_result_t __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
> +static pci_ers_result_t __cxl_handle_ras(struct device *cxl_dev, struct device *pcie_dev,
> +					 void __iomem *ras_base)
>  {
>  	u32 hl[CXL_HEADERLOG_SIZE_U32];
>  	void __iomem *addr;
> @@ -709,7 +710,7 @@ static pci_ers_result_t __cxl_handle_ras(struct device *dev, void __iomem *ras_b
>  	u32 fe;
>  
>  	if (!ras_base) {
> -		dev_warn_once(dev, "CXL RAS register block is not mapped");
> +		dev_warn_once(cxl_dev, "CXL RAS register block is not mapped");
>  		return PCI_ERS_RESULT_NONE;
>  	}
>  
> @@ -730,10 +731,10 @@ static pci_ers_result_t __cxl_handle_ras(struct device *dev, void __iomem *ras_b
>  	}
>  
>  	header_log_copy(ras_base, hl);
> -	if (is_cxl_memdev(dev))
> -		trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
> -	else if (is_cxl_port(dev))
> -		trace_cxl_port_aer_uncorrectable_error(dev, status, fe, hl);
> +	if (is_cxl_memdev(cxl_dev))
> +		trace_cxl_aer_uncorrectable_error(to_cxl_memdev(cxl_dev), status, fe, hl);
> +	else if (is_cxl_port(cxl_dev))
> +		trace_cxl_port_aer_uncorrectable_error(cxl_dev, pcie_dev, status, fe, hl);
>  
>  	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>  
> @@ -742,7 +743,7 @@ static pci_ers_result_t __cxl_handle_ras(struct device *dev, void __iomem *ras_b
>  
>  static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
>  {
> -	return __cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
> +	return __cxl_handle_ras(&cxlds->cxlmd->dev, NULL, cxlds->regs.ras);
>  }
>  
>  #ifdef CONFIG_PCIEAER_CXL
> @@ -814,7 +815,7 @@ static void __iomem *cxl_pci_port_ras(struct pci_dev *pdev, struct device **dev)
>  		struct cxl_dport *dport = NULL;
>  
>  		port = find_cxl_port(&pdev->dev, &dport);
> -		if (!port) {
> +		if (!port || !is_cxl_port(&port->dev)) {
>  			pci_err(pdev, "Failed to find root/dport in CXL topology\n");
>  			return NULL;
>  		}
> @@ -848,7 +849,7 @@ static void cxl_port_cor_error_detected(struct pci_dev *pdev)
>  	struct device *dev;
>  	void __iomem *ras_base = cxl_pci_port_ras(pdev, &dev);
>  
> -	__cxl_handle_cor_ras(dev, ras_base);
> +	__cxl_handle_cor_ras(dev, &pdev->dev, ras_base);
>  }
>  
>  static pci_ers_result_t cxl_port_error_detected(struct pci_dev *pdev)
> @@ -856,7 +857,7 @@ static pci_ers_result_t cxl_port_error_detected(struct pci_dev *pdev)
>  	struct device *dev;
>  	void __iomem *ras_base = cxl_pci_port_ras(pdev, &dev);
>  
> -	return __cxl_handle_ras(dev, ras_base);
> +	return __cxl_handle_ras(dev, &pdev->dev, ras_base);
>  }
>  
>  void cxl_uport_init_ras_reporting(struct cxl_port *port)
> @@ -909,13 +910,13 @@ EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
>  static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
>  					  struct cxl_dport *dport)
>  {
> -	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, dport->regs.ras);
> +	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, NULL, dport->regs.ras);
>  }
>  
>  static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
>  				       struct cxl_dport *dport)
>  {
> -	return __cxl_handle_ras(&cxlds->cxlmd->dev, dport->regs.ras);
> +	return __cxl_handle_ras(&cxlds->cxlmd->dev, NULL, dport->regs.ras);
>  }
>  
>  /*
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index b536233ac210..a74803f4aa22 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -49,18 +49,22 @@
>  )
>  
>  TRACE_EVENT(cxl_port_aer_uncorrectable_error,
> -	TP_PROTO(struct device *dev, u32 status, u32 fe, u32 *hl),
> -	TP_ARGS(dev, status, fe, hl),
> +	TP_PROTO(struct device *cxl_dev, struct device *pcie_dev, u32 status, u32 fe, u32 *hl),
> +	TP_ARGS(cxl_dev, pcie_dev, status, fe, hl),
>  	TP_STRUCT__entry(
> -		__string(devname, dev_name(dev))
> -		__string(parent, dev_name(dev->parent))
> +		__string(cxl_name, dev_name(cxl_dev))
> +		__string(cxl_parent_name, dev_name(cxl_dev->parent))
> +		__string(pcie_name, dev_name(pcie_dev))
> +		__string(pcie_parent_name, dev_name(pcie_dev->parent))
>  		__field(u32, status)
>  		__field(u32, first_error)
>  		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
>  	),
>  	TP_fast_assign(
> -		__assign_str(devname);
> -		__assign_str(parent);
> +		__assign_str(cxl_name);
> +		__assign_str(cxl_parent_name);
> +		__assign_str(pcie_name);
> +		__assign_str(pcie_parent_name);
>  		__entry->status = status;
>  		__entry->first_error = fe;
>  		/*
> @@ -69,8 +73,9 @@ TRACE_EVENT(cxl_port_aer_uncorrectable_error,
>  		 */
>  		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
>  	),
> -	TP_printk("device=%s parent=%s status: '%s' first_error: '%s'",
> -		__get_str(devname), __get_str(parent),
> +	TP_printk("device=%s (%s) parent=%s (%s) status: '%s' first_error: '%s'",
> +		__get_str(cxl_name), __get_str(pcie_name),
> +		__get_str(cxl_parent_name), __get_str(pcie_parent_name),
>  		show_uc_errs(__entry->status),
>  		show_uc_errs(__entry->first_error)
>  	)
> @@ -125,20 +130,25 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
>  )
>  
>  TRACE_EVENT(cxl_port_aer_correctable_error,
> -	TP_PROTO(struct device *dev, u32 status),
> -	TP_ARGS(dev, status),
> +	TP_PROTO(struct device *cxl_dev, struct device *pcie_dev, u32 status),
> +	TP_ARGS(cxl_dev, pcie_dev, status),
>  	TP_STRUCT__entry(
> -		__string(devname, dev_name(dev))
> -		__string(parent, dev_name(dev->parent))
> +		__string(cxl_name, dev_name(cxl_dev))
> +		__string(cxl_parent_name, dev_name(cxl_dev->parent))
> +		__string(pcie_name, dev_name(pcie_dev))
> +		__string(pcie_parent_name, dev_name(pcie_dev->parent))
>  		__field(u32, status)
>  	),
>  	TP_fast_assign(
> -		__assign_str(devname);
> -		__assign_str(parent);
> +		__assign_str(cxl_name);
> +		__assign_str(cxl_parent_name);
> +		__assign_str(pcie_name);
> +		__assign_str(pcie_parent_name);
>  		__entry->status = status;
>  	),
> -	TP_printk("device=%s parent=%s status='%s'",
> -		__get_str(devname), __get_str(parent),
> +	TP_printk("device=%s (%s) parent=%s (%s) status='%s'",
> +		__get_str(cxl_name), __get_str(pcie_name),
> +		__get_str(cxl_parent_name), __get_str(pcie_parent_name),
>  		show_ce_errs(__entry->status)
>  	)
>  );


