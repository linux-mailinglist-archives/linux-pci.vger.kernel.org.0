Return-Path: <linux-pci+bounces-29107-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 683BCAD072A
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 19:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA862188CEF9
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 17:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AD5289371;
	Fri,  6 Jun 2025 17:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UnlS228e"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00CA1DCB09;
	Fri,  6 Jun 2025 17:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749229482; cv=none; b=fB/i2aVgy5s/GLQhnHJGY50VFwjdTMmeZfkAwLXODZjFO3OCIwtq0gO6NGsreqQBGo+6f5ar1CaJHpPUgATQETY3UxyMIKjYJAh1Kzldyb0NgcoObyLfRjyud3I3GNIoRgJYrixt5hA5xIFJCwbJxmEsQNin82U0/Ddp5JkpUX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749229482; c=relaxed/simple;
	bh=FEti/6W5+cDXHM7QPLkOIy38jOqcHarb3UBqmuZzjew=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oiQhUaVlZyUm82C1igGyXLy0cWJRyiD9WBYb3zAzL0eXcGGpdI/VTq0K7ZIqTAQ6BhsKCpO845IFTL2guB5NIvp6IeKwmkKoUOgzeMgxtlhJC1pCVd6JskfM4bcfpgBXholWNHXx0SqpWkfWH3I6iQVzoQ6MTVZUEFeNG7rH840=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UnlS228e; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749229481; x=1780765481;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=FEti/6W5+cDXHM7QPLkOIy38jOqcHarb3UBqmuZzjew=;
  b=UnlS228eVJL5S0/ZD9AbJIzZjtqNbNPez5gqARx4LzaaPtp2jov1jUg1
   Lw4oDj1c0d2HNFgeIFx+jweP7TYjNbGwjcZcsDnbso72BpiBhhD6LH+E8
   +E0KIDpN4/4TieeJbNt+wnWo46BU3jfWglAG4bNUUP8tBbCTaH87qWhO6
   p2FOMQDN4k0Xj1CAJEJ180BNNFsN30bbQoM+97GONY4gzP1ZreCFqBP6e
   3zStMSTIhOSWy+2GgY+cw92z5MIMbdk8Odb/zDpocYE8wswHun6wBU9E/
   0gdDby0Sc9TnrPyrq6Q6s/W1nh+/bM+Ou9rIsEi5rmnWTOp++3zrCe0VX
   Q==;
X-CSE-ConnectionGUID: IkXZx9TUQfWmYgM2TqaIgg==
X-CSE-MsgGUID: wym7mCKLRbKo2XjDUCBjyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="54016754"
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; 
   d="scan'208";a="54016754"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 10:04:40 -0700
X-CSE-ConnectionGUID: PKAX6cfjSFql/99WlRiN3g==
X-CSE-MsgGUID: rqdu907nSV2MNjXZf+Nc7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; 
   d="scan'208";a="146851621"
Received: from spandruv-desk1.amr.corp.intel.com (HELO [10.125.111.33]) ([10.125.111.33])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 10:04:38 -0700
Message-ID: <6856e071-79ff-4b95-95ef-ebacadfabfbc@intel.com>
Date: Fri, 6 Jun 2025 10:04:35 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 06/16] cxl/pci: Move RAS initialization to cxl_port
 driver
To: Terry Bowman <terry.bowman@amd.com>, PradeepVineshReddy.Kodamati@amd.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 bhelgaas@google.com, bp@alien8.de, ming.li@zohomail.com,
 shiju.jose@huawei.com, dan.carpenter@linaro.org,
 Smita.KoralahalliChannabasappa@amd.com, kobayashi.da-06@fujitsu.com,
 yanfei.xu@intel.com, rrichter@amd.com, peterz@infradead.org, colyli@suse.de,
 uaisheng.ye@intel.com, fabio.m.de.francesco@linux.intel.com,
 ilpo.jarvinen@linux.intel.com, yazen.ghannam@amd.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-7-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250603172239.159260-7-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/3/25 10:22 AM, Terry Bowman wrote:
> The cxl_port driver is intended to manage CXL Endpoint Ports and CXL Switch
> Ports. Move existing RAS initialization to the cxl_port driver.
> 
> Restricted CXL Host (RCH) Downstream Port RAS initialization currently
> resides in cxl/core/pci.c. The PCI source file is not otherwise associated
> with CXL Port management.
> 
> Additional CXL Port RAS initialization will be added in future patches to
> support a CXL Port device's CXL errors.

Is this the part that Jonathan recommended moving to cxl/core/ras.c?

DJ

> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/cxl/core/pci.c  | 73 --------------------------------------
>  drivers/cxl/core/regs.c |  2 ++
>  drivers/cxl/cxl.h       |  6 ++++
>  drivers/cxl/port.c      | 78 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 86 insertions(+), 73 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index b50551601c2e..317cd0a91ffe 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -748,79 +748,6 @@ static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
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
> index ba08b77b65da..0dc43bfba76a 100644
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
> index fe4b593331da..7b61f09347a5 100644
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
> +	 * CXL 3.0 12.2.1.1 - RCH Downstream Port-detected Errors
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


