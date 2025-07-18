Return-Path: <linux-pci+bounces-32558-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D45B0A9E6
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 20:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB8AB3A6208
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 18:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5648E1E520A;
	Fri, 18 Jul 2025 18:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gfNgr1EW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6492E1A7AE3;
	Fri, 18 Jul 2025 18:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752861702; cv=none; b=ELUPDf8uROwTIH8PnpaXk+lDaLfVCr8+ifuWMhgmJDmLTNMEmGjFkOp/NkiNf2HTj+l2AX0HsNXEJykmrnXMRBEayAz+SG9rxx27snY8JmYVBGgZvmEcz4FD2Ad5kYUcRcc6OsVcRbNTYb4CdE6N4PJOUyB+uXGYFJED1IMdCSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752861702; c=relaxed/simple;
	bh=VBCS4PzehuzYafFcmXlBRn07mFF0e1YNXRHEI2jgWCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FdqYk4KA51lp9Qlg6JQMbHUsMm9ImppupEyFWqUf/LKID+PHyhzCmcfTzp0FdhLuhBHn1+NLCb7jieoSVjo2crrI4uCSobeS37E4ZzGj8pIfI3FPSVWTbUJAo47bMfLnOO12gykqQfSM78vgAr2NJ3AN+w/+mwkqeACTHMs6K9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gfNgr1EW; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752861700; x=1784397700;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VBCS4PzehuzYafFcmXlBRn07mFF0e1YNXRHEI2jgWCc=;
  b=gfNgr1EW5YsuB3+fICjJBTJdEvbKQn2dpyW5pOtg5LMIMJS1+JGlEYpp
   lZ8ZlokRR+8DhZD7SxvyMW91ysZIwUhmfokFVVAWYyEeKoL9E/Rq2MbdK
   c5Qw0bSIRiHv8+P52pVBlUKdLI+sI4tVgqK4V9/JaUmL+xwggByXF+r+j
   gxZn+Nxf0YqZFp69Bpl8uwF7h6jTkYDANVVdfYm319rVe1LOoPM/ysbJG
   9p5qVPMTYy18WSa6F5dPs3i6wyYt7o0N16tstUSGIkfpzHdBr8H2YzR9t
   XPR29LNeq/miIwMyu5v/Zv9G5mrs4Sx7JU/r7e6WKpkNhH/cgzVSy97NW
   Q==;
X-CSE-ConnectionGUID: TCMm0d+WSfm1yV8jJpVihQ==
X-CSE-MsgGUID: 10JG/Q/SQnarqqrzqT3ujQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="54264022"
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="54264022"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 11:01:39 -0700
X-CSE-ConnectionGUID: fJvT1S4hR9y4c5iCpknn3w==
X-CSE-MsgGUID: s3YNyZnRQ3urgaMAl3NbsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="189101076"
Received: from unknown (HELO [10.247.118.125]) ([10.247.118.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 11:01:30 -0700
Message-ID: <7f7113db-7928-4c62-aa7d-69ab2cc6213e@intel.com>
Date: Fri, 18 Jul 2025 11:01:26 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 08/17] cxl/pci: Move RAS initialization to cxl_port
 driver
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
 <20250626224252.1415009-9-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250626224252.1415009-9-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/26/25 3:42 PM, Terry Bowman wrote:
> The cxl_port driver is intended to manage CXL Endpoint Ports and CXL Switch
> Ports. Move existing RAS initialization to the cxl_port driver.
> 
> Restricted CXL Host (RCH) Downstream Port RAS initialization currently
> resides in cxl/core/pci.c. The PCI source file is not otherwise associated
> with CXL Port management.
> 
> Additional CXL Port RAS initialization will be added in future patches to
> support a CXL Port device's CXL errors.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/pci.c  | 73 --------------------------------------
>  drivers/cxl/core/regs.c |  2 ++
>  drivers/cxl/cxl.h       |  6 ++++
>  drivers/cxl/port.c      | 78 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 86 insertions(+), 73 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 06464a25d8bd..35c9c50534bf 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -738,79 +738,6 @@ static bool cxl_handle_ras(struct cxl_dev_state *cxlds,
>  
>  #ifdef CONFIG_PCIEAER_CXL
>  
> -static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
> -{
> -	resource_size_t aer_phys;
> -	struct device *host;
> -	u16 aer_cap;
> -
> -	aer_cap = cxl_rcrb_to_aer(dport->dport_dev, dport->rcrb.base);
> -	if (aer_cap) {
> -		host = dport->reg_map.host;
> -		aer_phys = aer_cap + dport->rcrb.base;
> -		dport->regs.dport_aer = devm_cxl_iomap_block(host, aer_phys,
> -						sizeof(struct aer_capability_regs));
> -	}
> -}
> -
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
> -static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
> -{
> -	void __iomem *aer_base = dport->regs.dport_aer;
> -	u32 aer_cmd_mask, aer_cmd;
> -
> -	if (!aer_base)
> -		return;
> -
> -	/*
> -	 * Disable RCH root port command interrupts.
> -	 * CXL 3.0 12.2.1.1 - RCH Downstream Port-detected Errors
> -	 *
> -	 * This sequence may not be necessary. CXL spec states disabling
> -	 * the root cmd register's interrupts is required. But, PCI spec
> -	 * shows these are disabled by default on reset.
> -	 */
> -	aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
> -			PCI_ERR_ROOT_CMD_NONFATAL_EN |
> -			PCI_ERR_ROOT_CMD_FATAL_EN);
> -	aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
> -	aer_cmd &= ~aer_cmd_mask;
> -	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
> -}
> -
> -/**
> - * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
> - * @dport: the cxl_dport that needs to be initialized
> - * @host: host device for devm operations
> - */
> -void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
> -{
> -	dport->reg_map.host = host;
> -	cxl_dport_map_ras(dport);
> -
> -	if (dport->rch) {
> -		struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport->dport_dev);
> -
> -		if (!host_bridge->native_aer)
> -			return;
> -
> -		cxl_dport_map_rch_aer(dport);
> -		cxl_disable_rch_root_ints(dport);
> -	}
> -}
> -EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
> -
>  static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
>  					  struct cxl_dport *dport)
>  {
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 5ca7b0eed568..b8e767a9571c 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -199,6 +199,7 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>  
>  	return ret_val;
>  }
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, "CXL");
>  
>  int cxl_map_component_regs(const struct cxl_register_map *map,
>  			   struct cxl_component_regs *regs,
> @@ -517,6 +518,7 @@ u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb)
>  
>  	return offset;
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_rcrb_to_aer, "CXL");
>  
>  static resource_size_t cxl_rcrb_to_linkcap(struct device *dev, struct cxl_dport *dport)
>  {
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 3f1695c96abc..c57c160f3e5e 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -313,6 +313,12 @@ int cxl_setup_regs(struct cxl_register_map *map);
>  struct cxl_dport;
>  resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>  					   struct cxl_dport *dport);
> +
> +u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb);
> +
> +void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
> +				   resource_size_t length);
> +
>  int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
>  
>  #define CXL_RESOURCE_NONE ((resource_size_t) -1)
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index fe4b593331da..021f35145c65 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -6,6 +6,7 @@
>  
>  #include "cxlmem.h"
>  #include "cxlpci.h"
> +#include "cxl.h"
>  
>  /**
>   * DOC: cxl port
> @@ -57,6 +58,83 @@ static int discover_region(struct device *dev, void *unused)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PCIEAER_CXL
> +
> +static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
> +{
> +	resource_size_t aer_phys;
> +	struct device *host;
> +	u16 aer_cap;
> +
> +	aer_cap = cxl_rcrb_to_aer(dport->dport_dev, dport->rcrb.base);
> +	if (aer_cap) {
> +		host = dport->reg_map.host;
> +		aer_phys = aer_cap + dport->rcrb.base;
> +		dport->regs.dport_aer = devm_cxl_iomap_block(host, aer_phys,
> +						sizeof(struct aer_capability_regs));
> +	}
> +}
> +
> +static void cxl_dport_map_ras(struct cxl_dport *dport)
> +{
> +	struct cxl_register_map *map = &dport->reg_map;
> +	struct device *dev = dport->dport_dev;
> +
> +	if (!map->component_map.ras.valid)
> +		dev_dbg(dev, "RAS registers not found\n");
> +	else if (cxl_map_component_regs(map, &dport->regs.component,
> +					BIT(CXL_CM_CAP_CAP_ID_RAS)))
> +		dev_dbg(dev, "Failed to map RAS capability.\n");
> +}
> +
> +static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
> +{
> +	void __iomem *aer_base = dport->regs.dport_aer;
> +	u32 aer_cmd_mask, aer_cmd;
> +
> +	if (!aer_base)
> +		return;
> +
> +	/*
> +	 * Disable RCH root port command interrupts.
> +	 * CXL 3.2 12.2.1.1 - RCH Downstream Port-detected Errors
> +	 *
> +	 * This sequence may not be necessary. CXL spec states disabling
> +	 * the root cmd register's interrupts is required. But, PCI spec
> +	 * shows these are disabled by default on reset.
> +	 */
> +	aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
> +			PCI_ERR_ROOT_CMD_NONFATAL_EN |
> +			PCI_ERR_ROOT_CMD_FATAL_EN);
> +	aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
> +	aer_cmd &= ~aer_cmd_mask;
> +	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
> +}
> +
> +/**
> + * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
> + * @dport: the cxl_dport that needs to be initialized
> + * @host: host device for devm operations
> + */
> +void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
> +{
> +	dport->reg_map.host = host;
> +	cxl_dport_map_ras(dport);
> +
> +	if (dport->rch) {
> +		struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport->dport_dev);
> +
> +		if (!host_bridge->native_aer)
> +			return;
> +
> +		cxl_dport_map_rch_aer(dport);
> +		cxl_disable_rch_root_ints(dport);
> +	}
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
> +
> +#endif /* CONFIG_PCIEAER_CXL */
> +
>  static int cxl_switch_port_probe(struct cxl_port *port)
>  {
>  	struct cxl_hdm *cxlhdm;


