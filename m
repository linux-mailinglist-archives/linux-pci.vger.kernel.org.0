Return-Path: <linux-pci+bounces-26572-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8E8A995AA
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 18:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E38E23BD32F
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 16:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB68280A46;
	Wed, 23 Apr 2025 16:44:49 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDAD202961;
	Wed, 23 Apr 2025 16:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745426689; cv=none; b=r2VJyBaWMKLqJPuBhYr7MuRLz7j6DD2YC4kQe/9oeD3MeQ0RQPWqJPclQoas+LOHqGV/Xp4GNMPkCuIFXc0kLxN/XW6hKKt3VoMCPy24yX5xrwlmEHeJdyYTDU5YN6nlDNjZyZGUdPaG6GLOXZDPm3W5vDz33CfoeWMDk89Z+QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745426689; c=relaxed/simple;
	bh=J3dGqqQso8uMlF4GZUv6nHab0F7TwN763ay9JpuS+4o=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P6s1xKHENPtbijbGWU1Lo3P5winNFXcjM9w+914Y388URwQomSzyJwd3bOUGmd2u/KCsuSwN4FpXVmId17x90aaJ+wsoRHvwYx3ZlMqJPwwuTeJ8IvsdHw1wNf069sEWFlMBNzdAxTc66rM1bLZnpDaQI/YvLQiACBsuUMGMAzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZjPzm5sVNz6L57y;
	Thu, 24 Apr 2025 00:43:00 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 937251400DB;
	Thu, 24 Apr 2025 00:44:44 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 23 Apr
 2025 18:44:43 +0200
Date: Wed, 23 Apr 2025 17:44:42 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>, <ming.li@zohomail.com>,
	<PradeepVineshReddy.Kodamati@amd.com>, <shiju.jose@huawei.com>
Subject: Re: [PATCH v8 11/16] cxl/pci: Unifi CXL trace logging for CXL
 Endpoints and CXL Ports
Message-ID: <20250423174442.000039b0@huawei.com>
In-Reply-To: <20250327014717.2988633-12-terry.bowman@amd.com>
References: <20250327014717.2988633-1-terry.bowman@amd.com>
	<20250327014717.2988633-12-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 26 Mar 2025 20:47:12 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

Unify.


> CXL currently has separate trace routines for CXL Port errors and CXL
> Endpoint errors. This is inconvnenient for the user because they must
> enable 2 sets of trace routines. Make updates to the trace logging such
> that a single trace routine logs both CXL Endpoint and CXL Port protocol
> errors.
> 
> Also, CXL RAS errors are currently logged using the associated CXL port's
> name returned from devname(). They are typically named with 'port1',
> 'port2', etc. to indicate the hierarchial location in the CXL topology.
> But, this doesn't clearly indicate the CXL card or slot reporting the
> error.
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

I'm not sure the pcie parent is adding much... Why bother with that?

Shiju, is this going to affect rasdaemon handling?

I'd assume we can't just rename fields in the tracepoints and
combining them will also presumably make a mess?

Jonathan


> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/cxl/core/pci.c   |  29 ++++++------
>  drivers/cxl/core/ras.c   |  14 +++---
>  drivers/cxl/core/trace.h | 100 +++++++++++++--------------------------
>  3 files changed, 55 insertions(+), 88 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 4770810b2138..10b2abfb0e64 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -650,14 +650,14 @@ void read_cdat_data(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
>  
> -static void __cxl_handle_cor_ras(struct device *dev,
> -				 void __iomem *ras_base)
> +static void __cxl_handle_cor_ras(struct device *cxl_dev, struct device *pcie_dev,
> +				 u64 serial, void __iomem *ras_base)
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
> @@ -667,12 +667,12 @@ static void __cxl_handle_cor_ras(struct device *dev,
>  		return;
>  	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
>  
> -	trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
> +	trace_cxl_aer_correctable_error(cxl_dev, pcie_dev, serial, status);
>  }
>  
>  static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
>  {
> -	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
> +	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, NULL, cxlds->serial, cxlds->regs.ras);
>  }
>  
>  /* CXL spec rev3.0 8.2.4.16.1 */
> @@ -696,7 +696,8 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>   * Log the state of the RAS status registers and prepare them to log the
>   * next error status. Return 1 if reset needed.
>   */
> -static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
> +static pci_ers_result_t __cxl_handle_ras(struct device *cxl_dev, struct device *pcie_dev,
> +					 u64 serial, void __iomem *ras_base)
>  {
>  	u32 hl[CXL_HEADERLOG_SIZE_U32];
>  	void __iomem *addr;
> @@ -704,14 +705,14 @@ static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>  	u32 fe;
>  
>  	if (!ras_base) {
> -		dev_warn_once(dev, "CXL RAS register block is not mapped");
> -		return false;
> +		dev_warn_once(cxl_dev, "CXL RAS register block is not mapped");
> +		return PCI_ERS_RESULT_NONE;
>  	}
>  
>  	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
>  	status = readl(addr);
>  	if (!(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK))
> -		return false;
> +		return PCI_ERS_RESULT_NONE;
>  
>  	/* If multiple errors, log header points to first error from ctrl reg */
>  	if (hweight32(status) > 1) {
> @@ -725,15 +726,15 @@ static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>  	}
>  
>  	header_log_copy(ras_base, hl);
> -	trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
> +	trace_cxl_aer_uncorrectable_error(cxl_dev, pcie_dev, serial, status, fe, hl);
>  	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>  
> -	return true;
> +	return PCI_ERS_RESULT_PANIC;
>  }
>  
>  static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
>  {
> -	return __cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
> +	return __cxl_handle_ras(&cxlds->cxlmd->dev, NULL, cxlds->serial, cxlds->regs.ras);
>  }
>  
>  #ifdef CONFIG_PCIEAER_CXL
> @@ -741,13 +742,13 @@ static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
>  static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
>  					  struct cxl_dport *dport)
>  {
> -	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, dport->regs.ras);
> +	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, NULL, cxlds->serial, dport->regs.ras);
>  }
>  
>  static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
>  				       struct cxl_dport *dport)
>  {
> -	return __cxl_handle_ras(&cxlds->cxlmd->dev, dport->regs.ras);
> +	return __cxl_handle_ras(&cxlds->cxlmd->dev, NULL, cxlds->serial, dport->regs.ras);
>  }
>  
>  /*
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 1f94fc08e72b..f18cb568eabd 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -13,7 +13,7 @@ static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
>  {
>  	u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
>  
> -	trace_cxl_port_aer_correctable_error(&pdev->dev, status);
> +	trace_cxl_aer_correctable_error(&pdev->dev, &pdev->dev, 0, status);
>  }
>  
>  static void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
> @@ -28,8 +28,8 @@ static void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
>  	else
>  		fe = status;
>  
> -	trace_cxl_port_aer_uncorrectable_error(&pdev->dev, status, fe,
> -					       ras_cap.header_log);
> +	trace_cxl_aer_uncorrectable_error(&pdev->dev, &pdev->dev, 0,
> +					  status, fe, ras_cap.header_log);
>  }
>  
>  static void cxl_cper_trace_corr_prot_err(struct pci_dev *pdev,
> @@ -42,7 +42,8 @@ static void cxl_cper_trace_corr_prot_err(struct pci_dev *pdev,
>  	if (!cxlds)
>  		return;
>  
> -	trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
> +	trace_cxl_aer_correctable_error(&cxlds->cxlmd->dev, &pdev->dev,
> +					cxlds->serial, status);
>  }
>  
>  static void cxl_cper_trace_uncorr_prot_err(struct pci_dev *pdev,
> @@ -62,8 +63,9 @@ static void cxl_cper_trace_uncorr_prot_err(struct pci_dev *pdev,
>  	else
>  		fe = status;
>  
> -	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe,
> -					  ras_cap.header_log);
> +	trace_cxl_aer_uncorrectable_error(&cxlds->cxlmd->dev, &pdev->dev,
> +					  cxlds->serial, status,
> +					  fe, ras_cap.header_log);
>  }
>  
>  static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index 25ebfbc1616c..399e0b8bf0f2 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -48,49 +48,26 @@
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
> +	TP_PROTO(struct device *cxl_dev, struct device *pcie_dev, u64 serial,
> +		 u32 status, u32 fe, u32 *hl),
> +	TP_ARGS(cxl_dev, pcie_dev, serial, status, fe, hl),
>  	TP_STRUCT__entry(
> -		__string(memdev, dev_name(&cxlmd->dev))
> -		__string(host, dev_name(cxlmd->dev.parent))
> +		__string(cxl_name, dev_name(cxl_dev))
> +		__string(cxl_parent_name, dev_name(cxl_dev->parent))
> +		__string(pcie_name, dev_name(pcie_dev))
> +		__string(pcie_parent_name, dev_name(pcie_dev->parent))
>  		__field(u64, serial)
>  		__field(u32, status)
>  		__field(u32, first_error)
>  		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
>  	),
>  	TP_fast_assign(
> -		__assign_str(memdev);
> -		__assign_str(host);
> -		__entry->serial = cxlmd->cxlds->serial;
> +		__assign_str(cxl_name);
> +		__assign_str(cxl_parent_name);
> +		__assign_str(pcie_name);
> +		__assign_str(pcie_parent_name);
> +		__entry->serial = serial;
>  		__entry->status = status;
>  		__entry->first_error = fe;
>  		/*
> @@ -99,10 +76,11 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
>  		 */
>  		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
>  	),
> -	TP_printk("memdev=%s host=%s serial=%lld: status: '%s' first_error: '%s'",
> -		  __get_str(memdev), __get_str(host), __entry->serial,
> -		  show_uc_errs(__entry->status),
> -		  show_uc_errs(__entry->first_error)
> +	TP_printk("device=%s (%s) parent=%s (%s) serial: %lld status: '%s' first_error: '%s'",
> +		__get_str(cxl_name), __get_str(pcie_name),
> +		__get_str(cxl_parent_name), __get_str(pcie_parent_name),
> +		__entry->serial, show_uc_errs(__entry->status),
> +		show_uc_errs(__entry->first_error)
>  	)
>  );
>  
> @@ -124,43 +102,29 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
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
> +	TP_PROTO(struct device *cxl_dev, struct device *pcie_dev, u64 serial, u32 status),
> +	TP_ARGS(cxl_dev, pcie_dev, serial, status),
>  	TP_STRUCT__entry(
> -		__string(memdev, dev_name(&cxlmd->dev))
> -		__string(host, dev_name(cxlmd->dev.parent))
> +		__string(cxl_name, dev_name(cxl_dev))
> +		__string(cxl_parent_name, dev_name(cxl_dev->parent))
> +		__string(pcie_name, dev_name(pcie_dev))
> +		__string(pcie_parent_name, dev_name(pcie_dev->parent))
>  		__field(u64, serial)
>  		__field(u32, status)
>  	),
>  	TP_fast_assign(
> -		__assign_str(memdev);
> -		__assign_str(host);
> -		__entry->serial = cxlmd->cxlds->serial;
> +		__assign_str(cxl_name);
> +		__assign_str(cxl_parent_name);
> +		__assign_str(pcie_name);
> +		__assign_str(pcie_parent_name);
> +		__entry->serial = serial;
>  		__entry->status = status;
>  	),
> -	TP_printk("memdev=%s host=%s serial=%lld: status: '%s'",
> -		  __get_str(memdev), __get_str(host), __entry->serial,
> -		  show_ce_errs(__entry->status)
> +	TP_printk("device=%s (%s) parent=%s (%s) serieal=%lld status='%s'",
> +		__get_str(cxl_name), __get_str(pcie_name),
> +		__get_str(cxl_parent_name), __get_str(pcie_parent_name),
> +		__entry->serial, show_ce_errs(__entry->status)
>  	)
>  );
>  


