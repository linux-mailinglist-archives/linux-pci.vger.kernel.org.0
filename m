Return-Path: <linux-pci+bounces-35069-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B65B3ADF0
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 01:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A94B9583EA1
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 23:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A42226F297;
	Thu, 28 Aug 2025 23:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ni5BgJBS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA2079DA;
	Thu, 28 Aug 2025 23:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422344; cv=none; b=opEGgds5b0jytZhnw3rIUp4XNiF2SQ3nvNhNzSpuYZbX/jAyU2ykWp2R/HRTIf1FTSxzQElxuF69JM248FeiR/x2NxW1C+vwHnmOYEn98MVYkxl10SO3so4iOvy5+7PwiFhdeB2Y0Y9YjtaUAtRrDOPPiYZCckPVqSRptXkyLZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422344; c=relaxed/simple;
	bh=u3H89Z//3PoP+OudmHnpD3JeJZ7fOD3tDr+8SP0s0Jo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AtxdWr6lsIrYKMKjin6xQsumUqjhiPMTqY1Aa89OzYX+My9mHUsTdktC7yCUidPKXL/FDgF8HaOV2plkzL53B9mFHyt87Jsw7lqaLSCy65AegJ0veV88jpG3M2VhLDqi96is/8usyi5DI4LvMrOEuHH81x6DYvxCs7HhEtWN1lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ni5BgJBS; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756422342; x=1787958342;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=u3H89Z//3PoP+OudmHnpD3JeJZ7fOD3tDr+8SP0s0Jo=;
  b=Ni5BgJBSHsM/8wM7do0Ep4wqtZY/6f2lekbUJbbvcixlwMojphL7ZlQT
   BLsMWWEa67EvPK+H1cWK5ei+NG0bsAzawV7gA4EKRrngWMKGNFtqH2/M0
   MkH+OUp7MsLFJ0GJUULVLlM0gt/PuNUvzoNQaLp7UuxBukR+95KcUsjZl
   dUUiKdiKc/IPeXs6EyoGyroZhrlI+kJ9dW1rU1emOZlTqaBUSu1PZlZlF
   OraJh9znM1Yxwv22+IMORnsmAhz8BH5FxT2+/VzFN50zLQVN/NwlgGLI2
   DPVkSSc5jBIuJtaQMaBE2raEzC18xVFKQE/3aMbWoW8I+LPdDEo8WgEZ4
   w==;
X-CSE-ConnectionGUID: GqOocF6fQh+okOpeSzl8WQ==
X-CSE-MsgGUID: ImIThOvbRMuen/NEehr9Tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="76156937"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="76156937"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 16:05:37 -0700
X-CSE-ConnectionGUID: pb39M6eLSn+xwlxuwyGpCA==
X-CSE-MsgGUID: s/G4WcwVQFm5TP4utTsNSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="170624482"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.118.49]) ([10.247.118.49])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 16:05:28 -0700
Message-ID: <d327d8c5-0633-4556-a021-56afff421a64@intel.com>
Date: Thu, 28 Aug 2025 16:05:20 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 15/23] cxl/pci: Map CXL Endpoint Port and CXL Switch
 Port RAS registers
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250827013539.903682-1-terry.bowman@amd.com>
 <20250827013539.903682-16-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250827013539.903682-16-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/26/25 6:35 PM, Terry Bowman wrote:
> CXL Endpoint (EP) Ports may include Root Ports (RP) or Downstream Switch
> Ports (DSP). CXL RPs and DSPs contain RAS registers that require memory
> mapping to enable RAS logging. This initialization is currently missing and
> must be added for CXL RPs and DSPs.
> 
> Update cxl_dport_init_ras_reporting() to support RP and DSP RAS mapping.
> Add alongside the existing Restricted CXL Host Downstream Port RAS mapping.
> 
> Update cxl_endpoint_port_probe() to invoke cxl_dport_init_ras_reporting().
> This will initiate the RAS mapping for CXL RPs and DSPs when each CXL EP is
> created and added to the EP port.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
> Changes in v10->v11:
> - Use local pointer for readability in cxl_switch_port_init_ras() (Jonathan Cameron)
> - Rename port to be ep in cxl_endpoint_port_init_ras() (Dave Jiang)
> - Rename dport to be parent_dport in cxl_endpoint_port_init_ras()
>   and cxl_switch_port_init_ras() (Dave Jiang)
> - Port helper changes were in cxl/port.c, now in core/ras.c (Dave Jiang)
> ---
>  drivers/cxl/core/core.h |  7 ++++++
>  drivers/cxl/core/ras.c  | 47 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h       |  2 ++
>  drivers/cxl/cxlpci.h    |  4 ----
>  drivers/cxl/mem.c       |  4 +++-
>  drivers/cxl/port.c      |  5 +++++
>  6 files changed, 64 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 2c81a43d7b05..2fa76a913264 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -146,6 +146,9 @@ int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
>  #ifdef CONFIG_CXL_RAS
>  int cxl_ras_init(void);
>  void cxl_ras_exit(void);
> +void cxl_switch_port_init_ras(struct cxl_port *port);
> +void cxl_endpoint_port_init_ras(struct cxl_port *ep);
> +void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
>  #else
>  static inline int cxl_ras_init(void)
>  {
> @@ -155,6 +158,10 @@ static inline int cxl_ras_init(void)
>  static inline void cxl_ras_exit(void)
>  {
>  }
> +static inline void cxl_switch_port_init_ras(struct cxl_port *port) { }
> +static inline void cxl_endpoint_port_init_ras(struct cxl_port *ep) { }
> +static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
> +						struct device *host) { }
>  #endif // CONFIG_CXL_RAS
>  
>  int cxl_gpf_port_setup(struct cxl_dport *dport);
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 69559043b772..42b6e0b092d5 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -284,6 +284,53 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
>  
> +static void cxl_uport_init_ras_reporting(struct cxl_port *port,
> +					 struct device *host)
> +{
> +	struct cxl_register_map *map = &port->reg_map;
> +
> +	map->host = host;
> +	if (cxl_map_component_regs(map, &port->uport_regs,
> +				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
> +		dev_dbg(&port->dev, "Failed to map RAS capability\n");
> +}
> +
> +void cxl_switch_port_init_ras(struct cxl_port *port)
> +{
> +	struct cxl_dport *parent_dport = port->parent_dport;
> +
> +	if (is_cxl_root(to_cxl_port(port->dev.parent)))
> +		return;
> +
> +	/* May have parent DSP or RP */
> +	if (parent_dport && dev_is_pci(parent_dport->dport_dev)) {
> +		struct pci_dev *pdev = to_pci_dev(parent_dport->dport_dev);
> +
> +		if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
> +		    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM))
> +			cxl_dport_init_ras_reporting(parent_dport, &port->dev);
> +	}
> +
> +	cxl_uport_init_ras_reporting(port, &port->dev);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_switch_port_init_ras, "CXL");
> +
> +void cxl_endpoint_port_init_ras(struct cxl_port *ep)
> +{
> +	struct cxl_dport *parent_dport;
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(ep->uport_dev);
> +	struct cxl_port *parent_port __free(put_cxl_port) =
> +		cxl_mem_find_port(cxlmd, &parent_dport);
> +
> +	if (!parent_dport || !dev_is_pci(parent_dport->dport_dev)) {
> +		dev_err(&ep->dev, "CXL port topology not found\n");
> +		return;
> +	}
> +
> +	cxl_dport_init_ras_reporting(parent_dport, cxlmd->cxlds->dev);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_endpoint_port_init_ras, "CXL");
> +
>  static void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>  {
>  	void __iomem *addr;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 8f6224ac6785..32fccad9a7f6 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -586,6 +586,7 @@ struct cxl_dax_region {
>   * @parent_dport: dport that points to this port in the parent
>   * @decoder_ida: allocator for decoder ids
>   * @reg_map: component and ras register mapping parameters
> + * @uport_regs: mapped component registers
>   * @nr_dports: number of entries in @dports
>   * @hdm_end: track last allocated HDM decoder instance for allocation ordering
>   * @commit_end: cursor to track highest committed decoder for commit ordering
> @@ -606,6 +607,7 @@ struct cxl_port {
>  	struct cxl_dport *parent_dport;
>  	struct ida decoder_ida;
>  	struct cxl_register_map reg_map;
> +	struct cxl_component_regs uport_regs;
>  	int nr_dports;
>  	int hdm_end;
>  	int commit_end;
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index ad24d81e9eaa..a6da0abfa506 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -84,7 +84,6 @@ void read_cdat_data(struct cxl_port *port);
>  void cxl_cor_error_detected(struct pci_dev *pdev);
>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  				    pci_channel_state_t state);
> -void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
>  #else
>  static inline void cxl_cor_error_detected(struct pci_dev *pdev) { }
>  
> @@ -93,9 +92,6 @@ static inline pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  {
>  	return PCI_ERS_RESULT_NONE;
>  }
> -
> -static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
> -						struct device *host) { }
>  #endif
>  
>  #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 6e6777b7bafb..f7dc0ba8905d 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -7,6 +7,7 @@
>  
>  #include "cxlmem.h"
>  #include "cxlpci.h"
> +#include "core/core.h"
>  
>  /**
>   * DOC: cxl mem
> @@ -166,7 +167,8 @@ static int cxl_mem_probe(struct device *dev)
>  	else
>  		endpoint_parent = &parent_port->dev;
>  
> -	cxl_dport_init_ras_reporting(dport, dev);
> +	if (dport->rch)
> +		cxl_dport_init_ras_reporting(dport, dev);

So the endpoint port probe calls this via cxl_endpoint_port_init_ras(), and if it's RCH the memedev probe also calls this. Trying to understand why it happens for both drivers for the RCH case... 

>  
>  	scoped_guard(device, endpoint_parent) {
>  		if (!endpoint_parent->driver) {
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index fe4b593331da..e66c7f2e1955 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -6,6 +6,7 @@
>  
>  #include "cxlmem.h"
>  #include "cxlpci.h"
> +#include "core/core.h"
>  
>  /**
>   * DOC: cxl port
> @@ -71,6 +72,8 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>  
>  	cxl_switch_parse_cdat(port);
>  
> +	cxl_switch_port_init_ras(port);
> +
>  	cxlhdm = devm_cxl_setup_hdm(port, NULL);
>  	if (!IS_ERR(cxlhdm))
>  		return devm_cxl_enumerate_decoders(cxlhdm, NULL);
> @@ -125,6 +128,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	if (rc)
>  		return rc;
>  
> +	cxl_endpoint_port_init_ras(port);
> +
>  	/*
>  	 * Now that all endpoint decoders are successfully enumerated, try to
>  	 * assemble regions from committed decoders


