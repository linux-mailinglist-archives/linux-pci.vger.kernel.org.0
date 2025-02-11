Return-Path: <linux-pci+bounces-21238-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4DDA318F4
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 23:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58E5116A46D
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 22:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2792F27293C;
	Tue, 11 Feb 2025 22:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DVgM1Fvn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2903272936;
	Tue, 11 Feb 2025 22:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739313633; cv=none; b=iA+DZSCCh5GSJioMjnPdpPB5BCX8rrslq+80ZvG/kqFEfxh2qdTS6Lej9YYqnneWo7lJH4SUjBeSoIv1CZ+wqr7VIQhaX07vWGIGthONhevyxoBh0IeEijIxlBEL7GLEFIwTTnpUw/Q72XfrMokTcWzuPeqDW/xw1/q0BB3lhOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739313633; c=relaxed/simple;
	bh=lxY7YWs23ALTUlbu00zkYyApnWvBoO3seZeWzyxudFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Mu9+0kAfbrbcAPfrfQtuWeUOWEZtENquOZauuUdk0wo0imlfwwWXrVPtXUiRjSWHYddQqrDmdSF8ws4BapARLFGwtib3oSOS6w3qyZlbxfnwLUfwZCLLXzOkPq6DXwgE9JeqO2c/FHjJKgpPXNMy2zDINaISV6OHAbTAJ8En13Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DVgM1Fvn; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739313631; x=1770849631;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=lxY7YWs23ALTUlbu00zkYyApnWvBoO3seZeWzyxudFc=;
  b=DVgM1FvnGgHDW/vc//KPAzoyh9KiCcQNeRo6pZGCY6vQsJ3MVwY/3C59
   pkPEc1I2IzS3K9Alxw5pVhNFmWZAGA4fngkiuMjqXijybdxOa+F9bKZQU
   nP7wlzDi3PkamJEWsEwT0WM6DzRlmed54d1As2WqEMFOqdrae9FbR3JAD
   Wr6lduP8LKtDPXolYg8kE6wTJxqLYSrn/VbGLB8DjqOyyVI3jJyokrhnX
   hzWVdTqVjb00V58KIre8gZ7y9FYhA9jiICPaIWdqfkmNuhPPZdEXRukx4
   DkLuKu2yCzZ2aaTIrxseRF+IRec5L3EqufIB4VE9qsq8IH0AvqtVCfVS/
   w==;
X-CSE-ConnectionGUID: 393WiFU4RWSy0MheVcxa1Q==
X-CSE-MsgGUID: ayIDvFlJRnmLMh7G6Twkow==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="40074988"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="40074988"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 14:40:30 -0800
X-CSE-ConnectionGUID: TWlsenWFRReCOYH/rumA3g==
X-CSE-MsgGUID: Cj2k7IsIQlKWeK/CDpyvhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="112469516"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.125.108.65]) ([10.125.108.65])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 14:40:28 -0800
Message-ID: <f0040956-a09b-4a9d-999b-80db4917f336@intel.com>
Date: Tue, 11 Feb 2025 15:40:27 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/17] cxl/pci: Map CXL PCIe Root Port and Downstream
 Switch Port RAS registers
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
 <20250211192444.2292833-8-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250211192444.2292833-8-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/11/25 12:24 PM, Terry Bowman wrote:
> The CXL mem driver (cxl_mem) currently maps and caches a pointer to RAS
> registers for the endpoint's Root Port. The same needs to be done for
> each of the CXL Downstream Switch Ports and CXL Root Ports found between
> the endpoint and CXL Host Bridge.
> 
> Introduce cxl_init_ep_ports_aer() to be called for each CXL Port in the
> sub-topology between the endpoint and the CXL Host Bridge. This function
> will determine if there are CXL Downstream Switch Ports or CXL Root Ports
> associated with this Port. The same check will be added in the future for
> upstream switch ports.
> 
> Move the RAS register map logic from cxl_dport_map_ras() into
> cxl_dport_init_ras_reporting(). This eliminates the need for the helper
> function, cxl_dport_map_ras().
> 
> cxl_init_ep_ports_aer() calls cxl_dport_init_ras_reporting() to map
> the RAS registers for CXL Downstream Switch Ports and CXL Root Ports.
> 
> cxl_dport_init_ras_reporting() must check for previously mapped registers
> before mapping. This is required because multiple Endpoints under a CXL
> switch may share an upstream CXL Root Port, CXL Downstream Switch Port,
> or CXL Downstream Switch Port. Ensure the RAS registers are only mapped
> once.
> 
> Introduce a mutex for synchronizing accesses to the cached RAS mapping.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>

Couple minor comments below.
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/pci.c | 42 ++++++++++++++++++++----------------------
>  drivers/cxl/cxl.h      |  6 ++----
>  drivers/cxl/mem.c      | 31 +++++++++++++++++++++++++++++--
>  3 files changed, 51 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index a5c65f79db18..143c853a52c4 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -24,6 +24,8 @@ static unsigned short media_ready_timeout = 60;
>  module_param(media_ready_timeout, ushort, 0644);
>  MODULE_PARM_DESC(media_ready_timeout, "seconds to wait for media ready");
>  
> +static DEFINE_MUTEX(ras_init_mutex);
> +
>  struct cxl_walk_context {
>  	struct pci_bus *bus;
>  	struct cxl_port *port;
> @@ -749,18 +751,6 @@ static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
>  	}
>  }
>  
> -static void cxl_dport_map_ras(struct cxl_dport *dport)
> -{
> -	struct cxl_register_map *map = &dport->reg_map;
> -	struct device *dev = dport->dport_dev;
> -
> -	if (!map->component_map.ras.valid)
> -		dev_dbg(dev, "RAS registers not found\n");
> -	else if (cxl_map_component_regs(map, &dport->regs.component,
> -					BIT(CXL_CM_CAP_CAP_ID_RAS)))
> -		dev_dbg(dev, "Failed to map RAS capability.\n");
> -}
> -
>  static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>  {
>  	void __iomem *aer_base = dport->regs.dport_aer;
> @@ -788,22 +778,30 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>  /**
>   * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
>   * @dport: the cxl_dport that needs to be initialized
> - * @host: host device for devm operations
>   */
> -void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
> +void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
>  {
> -	dport->reg_map.host = host;
> -	cxl_dport_map_ras(dport);
> -
> -	if (dport->rch) {
> -		struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport->dport_dev);
> -
> -		if (!host_bridge->native_aer)
> -			return;
> +	struct device *dport_dev = dport->dport_dev;
> +	struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport_dev);
>  
> +	dport->reg_map.host = dport_dev;
> +	if (dport->rch && host_bridge->native_aer) {
>  		cxl_dport_map_rch_aer(dport);
>  		cxl_disable_rch_root_ints(dport);
>  	}
> +
> +	/* dport may have more than 1 downstream EP. Check if already mapped. */
> +	mutex_lock(&ras_init_mutex);

I think you can just call guard() here and not deal with unlock?

> +	if (dport->regs.ras) {
> +		mutex_unlock(&ras_init_mutex);
> +		return;
> +	}
> +
> +	if (cxl_map_component_regs(&dport->reg_map, &dport->regs.component,
> +				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
> +		dev_err(dport_dev, "Failed to map RAS capability\n");
> +	mutex_unlock(&ras_init_mutex);
> +
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 6baec4ba9141..82d0a8555a11 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -754,11 +754,9 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>  					 resource_size_t rcrb);
>  
>  #ifdef CONFIG_PCIEAER_CXL
> -void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport);
> -void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
> +void cxl_dport_init_ras_reporting(struct cxl_dport *dport);
>  #else
> -static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
> -						struct device *host) { }
> +static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport) { }
>  #endif
>  
>  struct cxl_decoder *to_cxl_decoder(struct device *dev);
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 9675243bd05b..8c1144bbc058 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -45,6 +45,31 @@ static int cxl_mem_dpa_show(struct seq_file *file, void *data)
>  	return 0;
>  }
>  
> +static bool dev_is_cxl_pci(struct device *dev, u32 pcie_type)
> +{
> +	struct pci_dev *pdev;
> +
> +	if (!dev || !dev_is_pci(dev))
> +		return false;
> +
> +	pdev = to_pci_dev(dev);
> +
> +	return (pci_pcie_type(pdev) == pcie_type);
> +}

dev_is_pcie_type()?

DJ

> +
> +static void cxl_init_ep_ports_aer(struct cxl_ep *ep)
> +{
> +	struct cxl_dport *dport = ep->dport;
> +
> +	if (dport) {
> +		struct device *dport_dev = dport->dport_dev;
> +
> +		if (dev_is_cxl_pci(dport_dev, PCI_EXP_TYPE_DOWNSTREAM) ||
> +		    dev_is_cxl_pci(dport_dev, PCI_EXP_TYPE_ROOT_PORT))
> +			cxl_dport_init_ras_reporting(dport);
> +	}
> +}
> +
>  static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>  				 struct cxl_dport *parent_dport)
>  {
> @@ -52,6 +77,9 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>  	struct cxl_port *endpoint, *iter, *down;
>  	int rc;
>  
> +	if (parent_dport->rch)
> +		cxl_dport_init_ras_reporting(parent_dport);
> +
>  	/*
>  	 * Now that the path to the root is established record all the
>  	 * intervening ports in the chain.
> @@ -62,6 +90,7 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>  
>  		ep = cxl_ep_load(iter, cxlmd);
>  		ep->next = down;
> +		cxl_init_ep_ports_aer(ep);
>  	}
>  
>  	/* Note: endpoint port component registers are derived from @cxlds */
> @@ -166,8 +195,6 @@ static int cxl_mem_probe(struct device *dev)
>  	else
>  		endpoint_parent = &parent_port->dev;
>  
> -	cxl_dport_init_ras_reporting(dport, dev);
> -
>  	scoped_guard(device, endpoint_parent) {
>  		if (!endpoint_parent->driver) {
>  			dev_err(dev, "CXL port topology %s not enabled\n",


