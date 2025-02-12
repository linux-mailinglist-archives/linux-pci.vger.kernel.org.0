Return-Path: <linux-pci+bounces-21254-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0F6A31A92
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 01:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 074A13A7549
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 00:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C247A1876;
	Wed, 12 Feb 2025 00:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BeFSKblM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84FF27181C;
	Wed, 12 Feb 2025 00:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739320729; cv=none; b=lAQotGd3SBEIeg/11wOOZWhcdjXIdEYT1P2i3Qkiuo/XAXkrq8P2BPx9IEkZgCfIa4cggf4JpuX3DskHJMw1eRqZCXh4OLuRbsaj+f6MEmGwJM8QHzWNFehLPZQB379ftDRzuzUk4xZqI4njbP7sLrKGwiV9z8J9DPGMOy0rFK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739320729; c=relaxed/simple;
	bh=fs7OcnbgqNAiF22YqGfv3O9/7euoT7hAlnEhgGfYJVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=J9Jr7e8yl73hkUeoPeVsPVOAJe7N/dSs0WI8SUy3ZnU3eGKsOz0Gk51XuSCegsEX98Hr+TICdzBdmOfdKW5MWTpldhCL2Fy8eOAiQmYFWz/ezOscUzNumpt7wZ0753VO0FB1jf+Y584657HhX6B0ifSVakvPHWadqyaUebZ7nRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BeFSKblM; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739320728; x=1770856728;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=fs7OcnbgqNAiF22YqGfv3O9/7euoT7hAlnEhgGfYJVY=;
  b=BeFSKblMGC0KfG+5la0HQf1Cq1M9xzDjjwpwidaK5AeRWqxzb4mgRfWn
   yCLu1AaY/Zt7my+zmyg4zeuLzHCdxrQP2NIod2BpTJLsNDUrszz+jzos+
   9lCMj2InjP7i11ory7kRSaphIyNR3DP1+AfaUYpn1Cv/Sfc2CpD0C+8rj
   2JmgwX7ddLRGHNUNLkXm7iB9b3Pw2YOg7t5RYHUadP4I9K+5nfSo0w6R3
   0guPEOMQMb7eoUkKEwTLMf7pzrOQaHJ0ibirP11P7SvK4WccFJSSG0NIq
   AB9zI2OXhFEj561jEZdzAfe+4UcVeJ7l8EerV1OIA1inecFn6giyhBzOo
   g==;
X-CSE-ConnectionGUID: bgbeqb8SQ9GxCscllpVF5w==
X-CSE-MsgGUID: jgj/6+RIQoyqK1U/RGktKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="50601585"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="50601585"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 16:38:47 -0800
X-CSE-ConnectionGUID: 0vAlJZARQEiA+1ST2ifdkA==
X-CSE-MsgGUID: uvm0CYTCS7OlmxFE2ofcCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="117747099"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.125.108.65]) ([10.125.108.65])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 16:38:45 -0800
Message-ID: <8ef3f351-a5f4-4e25-a514-73788ba5510e@intel.com>
Date: Tue, 11 Feb 2025 17:38:44 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 15/17] cxl/pci: Add support to assign and clear
 pci_driver::cxl_err_handlers
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
 <20250211192444.2292833-16-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250211192444.2292833-16-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/11/25 12:24 PM, Terry Bowman wrote:
> pci_driver::cxl_err_handlers are not currently assigned handler callbacks.
> The handlers can't be set in the pci_driver static definition because the
> CXL PCIe Port devices are bound to the portdrv driver which is not CXL
> driver aware.
> 
> Add cxl_assign_port_error_handlers() in the cxl_core module. This
> function will assign the default handlers for a CXL PCIe Port device.
> 
> When the CXL Port (cxl_port or cxl_dport) is destroyed the device's
> pci_driver::cxl_err_handlers must be set to NULL indicating they should no
> longer be used.
> 
> Create cxl_clear_port_error_handlers() and register it to be called
> when the CXL Port device (cxl_port or cxl_dport) is destroyed.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/pci.c | 59 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 57 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index f154dcf6dfda..03ae21a944e0 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -860,8 +860,39 @@ static pci_ers_result_t cxl_port_error_detected(struct pci_dev *pdev)
>  	return __cxl_handle_ras(dev, &pdev->dev, ras_base);
>  }
>  
> +static const struct cxl_error_handlers cxl_port_error_handlers = {
> +	.error_detected	= cxl_port_error_detected,
> +	.cor_error_detected = cxl_port_cor_error_detected,
> +};
> +
> +static void cxl_assign_port_error_handlers(struct pci_dev *pdev)
> +{
> +	struct pci_driver *pdrv;
> +
> +	if (!pdev || !pdev->driver || !get_device(&pdev->dev))
> +		return;
> +
> +	pdrv = pdev->driver;
> +	pdrv->cxl_err_handler = &cxl_port_error_handlers;
> +	put_device(&pdev->dev);
> +}
> +
> +static void cxl_clear_port_error_handlers(void *data)
> +{
> +	struct pci_dev *pdev = data;
> +	struct pci_driver *pdrv;
> +
> +	if (!pdev || !pdev->driver || !get_device(&pdev->dev))
> +		return;
> +
> +	pdrv = pdev->driver;
> +	pdrv->cxl_err_handler = NULL;
> +	put_device(&pdev->dev);
> +}
> +
>  void cxl_uport_init_ras_reporting(struct cxl_port *port)
>  {
> +	struct pci_dev *pdev = to_pci_dev(port->uport_dev);
>  
>  	/* uport may have more than 1 downstream EP. Check if already mapped. */
>  	mutex_lock(&ras_init_mutex);
> @@ -872,9 +903,15 @@ void cxl_uport_init_ras_reporting(struct cxl_port *port)
>  
>  	port->reg_map.host = &port->dev;
>  	if (cxl_map_component_regs(&port->reg_map, &port->uport_regs,
> -				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
> +				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
>  		dev_err(&port->dev, "Failed to map RAS capability\n");
> +		mutex_unlock(&ras_init_mutex);
> +		return;
> +	}
>  	mutex_unlock(&ras_init_mutex);
> +
> +	cxl_assign_port_error_handlers(pdev);
> +	devm_add_action_or_reset(&port->dev, cxl_clear_port_error_handlers, pdev);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_uport_init_ras_reporting, "CXL");
>  
> @@ -886,6 +923,8 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
>  {
>  	struct device *dport_dev = dport->dport_dev;
>  	struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport_dev);
> +	struct pci_dev *pdev = to_pci_dev(dport_dev);
> +	struct cxl_port *port;
>  
>  	dport->reg_map.host = dport_dev;
>  	if (dport->rch && host_bridge->native_aer) {
> @@ -901,9 +940,25 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
>  	}
>  
>  	if (cxl_map_component_regs(&dport->reg_map, &dport->regs.component,
> -				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
> +				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
>  		dev_err(dport_dev, "Failed to map RAS capability\n");
> +		mutex_unlock(&ras_init_mutex);
> +		return;
> +	}
>  	mutex_unlock(&ras_init_mutex);
> +
> +	if (dport->rch)
> +		return;
> +
> +	port = find_cxl_port(dport_dev, NULL);
> +	if (!port) {
> +		dev_err(dport_dev, "Failed to find upstream port\n");
> +		return;
> +	}
> +
> +	cxl_assign_port_error_handlers(pdev);
> +	devm_add_action_or_reset(&port->dev, cxl_clear_port_error_handlers, pdev);
> +	put_device(&port->dev);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
>  


