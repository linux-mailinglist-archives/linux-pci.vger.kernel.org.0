Return-Path: <linux-pci+bounces-21249-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AFAA31A37
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 01:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F01B3A7E08
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 00:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCA310E0;
	Wed, 12 Feb 2025 00:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MPMxE80F"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CE31367;
	Wed, 12 Feb 2025 00:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739319088; cv=none; b=T7GorUi6noUhqsgju/FrjVUYeQoDE0UzVluv/Dq3wGxV1iuhILfZ7tu2UjuSwqWtKYfTWO9fw8ZodseRpZFfr1ZgQPfO4PjL6p2F0FwatmsANu2iJcKIQ09YcgYEnJUh8NiRtdjo3TaiQY0zRGtQS7VT0dBrwmHLVw9ZUYiHo2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739319088; c=relaxed/simple;
	bh=CnLzc4amrVwGIMg/9TKICSJ+uuTpvMPjYaiU839PggE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UaLrIyN1GEyhjeWIPT87SBZp4Jho6UeHBQdYDRCv+KxqCllxEZfREiDus3cusNwYamfJfI/Snboe6hy9WuXIaTgAaEDsKZKePPiW8YjQQqCS9hSisftiDI6+gWTlQjXT0v9RXOnxal636JN4Qwiog8ADWjyQjarDgOHQDH64bw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MPMxE80F; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739319086; x=1770855086;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=CnLzc4amrVwGIMg/9TKICSJ+uuTpvMPjYaiU839PggE=;
  b=MPMxE80F51wwO+wHUXhrgyZ39rYB+0MJVt3UzIFNyJfyj48XrlyMvPaR
   kt/bmTrKB+YaH3i12mMIFmX4ci3RoIprgyMHDQWXMqRJe3yzfBpe4WSlX
   EBtQtyV+r3k/km+6PA67sGrd0+6yN4/6I3abq9se+EqUR6dol7xooMqpY
   7cLkPMYaN7sVi1S0NElxgSj3XIHWhHeCdSYWwkmT3FdI5zNZS+LITcJl0
   SVZVCPgwZdwjSVE+X58/QLbUlI35tkgXDoJGPdEnXWnKttQWQrPPGJuSg
   fyYKGulc+Q0dQMhZQb6+KHhgOdIp7UgnrlLqgwtVdSH1gFR52FRWDFQ33
   A==;
X-CSE-ConnectionGUID: r/saEoFRTM2KThJpCfuRjg==
X-CSE-MsgGUID: QLgXi2npTkeSC5se6kOPzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="50599067"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="50599067"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 16:11:25 -0800
X-CSE-ConnectionGUID: lg14CeiTR5mbT6H6E2foDw==
X-CSE-MsgGUID: gM0nUw4kQRicjsbZVAvJ1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="112625183"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.125.108.65]) ([10.125.108.65])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 16:11:24 -0800
Message-ID: <dc7bc625-0a14-4d25-9211-2e0639f02566@intel.com>
Date: Tue, 11 Feb 2025 17:11:23 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/17] cxl/pci: Add error handler for CXL PCIe Port RAS
 errors
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
 <20250211192444.2292833-13-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250211192444.2292833-13-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/11/25 12:24 PM, Terry Bowman wrote:
> Introduce correctable and uncorrectable (UCE) CXL PCIe Port Protocol Error
> handlers.
> 
> The handlers will be called with a 'struct pci_dev' parameter
> indicating the CXL Port device requiring handling. The CXL PCIe Port
> device's underlying 'struct device' will match the port device in the
> CXL topology.
> 
> Use the PCIe Port's device object to find the matching CXL Upstream Switch
> Port, CXL Downstream Switch Port, or CXL Root Port in the CXL topology. The
> matching CXL Port device should contain a cached reference to the RAS
> register block. The cached RAS block will be used in handling the error.
> 
> Invoke the existing __cxl_handle_ras() or __cxl_handle_cor_ras() using
> a reference to the RAS registers as a parameter. These functions will use
> the RAS register reference to indicate an error and clear the device's RAS
> status.
> 
> Update __cxl_handle_ras() to return PCI_ERS_RESULT_PANIC in the case
> an error is present in the RAS status. Otherwise, return
> PCI_ERS_RESULT_NONE.

Maybe a comment on why the change?

> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/cxl/core/pci.c | 81 +++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 77 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index af809e7cbe3b..3f13d9dfb610 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -699,7 +699,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>   * Log the state of the RAS status registers and prepare them to log the
>   * next error status. Return 1 if reset needed.
>   */
> -static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
> +static pci_ers_result_t __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>  {
>  	u32 hl[CXL_HEADERLOG_SIZE_U32];
>  	void __iomem *addr;
> @@ -708,13 +708,13 @@ static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>  
>  	if (!ras_base) {
>  		dev_warn_once(dev, "CXL RAS register block is not mapped");
> -		return false;
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
> @@ -733,7 +733,7 @@ static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>  
>  	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>  
> -	return true;
> +	return PCI_ERS_RESULT_PANIC;
>  }
>  
>  static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
> @@ -782,6 +782,79 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>  	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
>  }
>  
> +static int match_uport(struct device *dev, const void *data)
> +{
> +	const struct device *uport_dev = data;
> +	struct cxl_port *port;
> +
> +	if (!is_cxl_port(dev))
> +		return 0;
> +
> +	port = to_cxl_port(dev);
> +
> +	return port->uport_dev == uport_dev;
> +}
> +
> +static void __iomem *cxl_pci_port_ras(struct pci_dev *pdev, struct device **dev)
> +{
> +	void __iomem *ras_base;
> +
> +	if (!pdev || !*dev) {
> +		pr_err("Failed, parameter is NULL");
> +		return NULL;
> +	}
> +
> +	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
> +	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)) {

Can probably just do a switch block here for the type?

> +		struct cxl_port *port __free(put_cxl_port);
> +		struct cxl_dport *dport = NULL;
> +
> +		port = find_cxl_port(&pdev->dev, &dport);

Just declare port inline:

struct cxl_port *port __free(put_cxl_port) =
		find_cxl_port(&pdev->dev, &dport);

> +		if (!port) {
> +			pci_err(pdev, "Failed to find root/dport in CXL topology\n");
> +			return NULL;
> +		}
> +
> +		ras_base = dport ? dport->regs.ras : NULL;
> +		*dev = &port->dev;
> +	} else if (pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM) {
> +		struct device *port_dev __free(put_device);

same comment here as above

DJ

> +		struct cxl_port *port;
> +
> +		port_dev = bus_find_device(&cxl_bus_type, NULL, &pdev->dev,
> +					   match_uport);
> +		if (!port_dev || !is_cxl_port(port_dev)) {
> +			pci_err(pdev, "Failed to find uport in CXL topology\n");
> +			return NULL;
> +		}
> +
> +		port = to_cxl_port(port_dev);
> +		ras_base = port ? port->uport_regs.ras : NULL;
> +		*dev = port_dev;
> +	} else {
> +		pci_err(pdev, "Unsupported device type\n");
> +		ras_base = NULL;
> +	}
> +
> +	return ras_base;
> +}
> +
> +static void cxl_port_cor_error_detected(struct pci_dev *pdev)
> +{
> +	struct device *dev;
> +	void __iomem *ras_base = cxl_pci_port_ras(pdev, &dev);
> +
> +	__cxl_handle_cor_ras(dev, ras_base);
> +}
> +
> +static pci_ers_result_t cxl_port_error_detected(struct pci_dev *pdev)
> +{
> +	struct device *dev;
> +	void __iomem *ras_base = cxl_pci_port_ras(pdev, &dev);
> +
> +	return __cxl_handle_ras(dev, ras_base);
> +}
> +
>  void cxl_uport_init_ras_reporting(struct cxl_port *port)
>  {
>  


