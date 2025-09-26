Return-Path: <linux-pci+bounces-37137-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8977ABA52B0
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 23:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA4893B9CB5
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 21:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D65528689A;
	Fri, 26 Sep 2025 21:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PAD3Jxly"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEEA2765CE;
	Fri, 26 Sep 2025 21:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758921050; cv=none; b=XpNeHVcciNeqKS6tIlglJcSO4ngO7Fc+o3TIo9ch+VO2p8BEZcxTVueXHCEZA4IlfNJxUDxNiYYLebctCkS2QgslDwNy+pVJBxph3s2xxtEHaDX7Cf7AqDr6QMi+4vGiH2NPt82IAxaoumTX38QwgH1lP+n/bGBZ+8PurPNcJag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758921050; c=relaxed/simple;
	bh=/YHvA6ltIw9Rvt68svMkqrNasabIn6qnnJx+l8JxsSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hWywnk8irxNG+epL0Wsk5h7PIo0rj3NGoMIthnRoBnsq2CpsvPbPEYgnk1vpmX2yimCmlcMvKuH8cgivRGxZJvOiUf+NA1AoeGdiUU2b9lHF8IucwAWuj2S8NjQJpnI9v+nqqBuyjtxcGLL2PH+BP+WSSAmrWQ4F+zkJAKS7EPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PAD3Jxly; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758921048; x=1790457048;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/YHvA6ltIw9Rvt68svMkqrNasabIn6qnnJx+l8JxsSM=;
  b=PAD3JxlynOFPzVe0CjlnOOjJnIa/QxKqG1JRMyoCl8XLu5yIVr7GxC7w
   frLDbbPnGtVZeDPGYTuVVxecKCIfPJ5M4tJgI6+tSxG2Jiq+vEuQquAZ8
   yhqXYmmYoPY46wi0LtIHjig7CWkqMpTybvEogBgMYS10MN1y/m0Jksu14
   GMe6BqlN7p3KsQ1aQUC5qwwxsVCSCM7h9S3chCRA0w8XceAhFOFlucsWG
   L5Wq2JvnPaG+kC3IAM7qPEMvxitk0H7J7h0Lh81wl0eeoqakdWAZAgnCA
   V98ofEZue25fLGfhHQVv91hlb3pe0+sFe56OxlAKSAPt8Idl9RnO4y+zZ
   w==;
X-CSE-ConnectionGUID: rBTj/zyoQt+pCdFLVgdRcQ==
X-CSE-MsgGUID: RPmVxf/rTves62bYayFpKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65070754"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="65070754"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 14:10:47 -0700
X-CSE-ConnectionGUID: YYjtx1glTDyIxqk1drR1Xg==
X-CSE-MsgGUID: KyGtcbH1QDiQAQaP+ZXsiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,296,1751266800"; 
   d="scan'208";a="177303405"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.109.69]) ([10.125.109.69])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 14:10:45 -0700
Message-ID: <883ee74a-0f11-414e-be62-1d5bdbfb1edd@intel.com>
Date: Fri, 26 Sep 2025 14:10:44 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 15/25] cxl/pci: Map CXL Endpoint Port and CXL Switch
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
References: <20250925223440.3539069-1-terry.bowman@amd.com>
 <20250925223440.3539069-16-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250925223440.3539069-16-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/25/25 3:34 PM, Terry Bowman wrote:
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
> Make a call to cxl_port_setup_regs() in cxl_port_add(). This will probe the
> Upstream Port's CXL capabilities' physical location to be used in mapping
> the RAS registers.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> ---
> 
> Changes in v11->v12:
> - Add check for dport_parent->rch before calling cxl_dport_init_ras_reporting().
> RCH dports are initialized from cxl_dport_init_ras_reporting cxl_mem_probe().
> 
> Changes in v10->v11:
> - Use local pointer for readability in cxl_switch_port_init_ras() (Jonathan Cameron)
> - Rename port to be ep in cxl_endpoint_port_init_ras() (Dave Jiang)
> - Rename dport to be parent_dport in cxl_endpoint_port_init_ras()
>   and cxl_switch_port_init_ras() (Dave Jiang)
> - Port helper changes were in cxl/port.c, now in core/ras.c (Dave
> Jiang)
> ---
>  drivers/cxl/core/core.h |  7 ++++++
>  drivers/cxl/core/port.c |  1 +
>  drivers/cxl/core/ras.c  | 48 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h       |  2 ++
>  drivers/cxl/cxlpci.h    |  4 ----
>  drivers/cxl/mem.c       |  4 +++-
>  drivers/cxl/port.c      |  5 +++++
>  7 files changed, 66 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 9f4eb7e2feba..8c51a2631716 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -147,6 +147,9 @@ int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
>  #ifdef CONFIG_CXL_RAS
>  int cxl_ras_init(void);
>  void cxl_ras_exit(void);
> +void cxl_switch_port_init_ras(struct cxl_port *port);
> +void cxl_endpoint_port_init_ras(struct cxl_port *ep);
> +void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
>  #else
>  static inline int cxl_ras_init(void)
>  {
> @@ -156,6 +159,10 @@ static inline int cxl_ras_init(void)
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
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index d5f71eb1ade8..bd4be046888a 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -870,6 +870,7 @@ static int cxl_port_add(struct cxl_port *port,
>  			return rc;
>  
>  		port->component_reg_phys = component_reg_phys;
> +		cxl_port_setup_regs(port, port->component_reg_phys);

This was actually moved previously to delay the port register probe. It now happens when the first dport is discovered. See the end of __devm_cxl_add_dport().

>  	} else {
>  		rc = dev_set_name(dev, "root%d", port->id);
>  		if (rc)
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 97a5a5c3910f..14a434bd68f0 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -283,6 +283,54 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
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
> +	if (parent_dport && dev_is_pci(parent_dport->dport_dev) &&
> +	    !parent_dport->rch) {
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
> +	if (!parent_dport || !dev_is_pci(parent_dport->dport_dev) || parent_dport->rch) {
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
> index 259ed4b676e1..b7654d40dc9e 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -599,6 +599,7 @@ struct cxl_dax_region {
>   * @parent_dport: dport that points to this port in the parent
>   * @decoder_ida: allocator for decoder ids
>   * @reg_map: component and ras register mapping parameters
> + * @uport_regs: mapped component registers
>   * @nr_dports: number of entries in @dports
>   * @hdm_end: track last allocated HDM decoder instance for allocation ordering
>   * @commit_end: cursor to track highest committed decoder for commit ordering
> @@ -620,6 +621,7 @@ struct cxl_port {
>  	struct cxl_dport *parent_dport;
>  	struct ida decoder_ida;
>  	struct cxl_register_map reg_map;
> +	struct cxl_component_regs uport_regs;
>  	int nr_dports;
>  	int hdm_end;
>  	int commit_end;
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 0c8b6ee7b6de..3882a089ae77 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -82,7 +82,6 @@ void read_cdat_data(struct cxl_port *port);
>  void cxl_cor_error_detected(struct pci_dev *pdev);
>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  				    pci_channel_state_t state);
> -void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
>  #else
>  static inline void cxl_cor_error_detected(struct pci_dev *pdev) { }
>  
> @@ -91,9 +90,6 @@ static inline pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  {
>  	return PCI_ERS_RESULT_NONE;
>  }
> -
> -static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
> -						struct device *host) { }
>  #endif
>  
>  #endif /* __CXL_PCI_H__ */

I think this change broke cxl_test:

  CC [M]  test/mem.o
test/mock.c: In function ‘__wrap_cxl_dport_init_ras_reporting’:
test/mock.c:266:17: error: implicit declaration of function ‘cxl_dport_init_ras_reporting’ [-Wimplicit-function-declaration]
  266 |                 cxl_dport_init_ras_reporting(dport, host);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


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
>  
>  	scoped_guard(device, endpoint_parent) {
>  		if (!endpoint_parent->driver) {
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 51c8f2f84717..2d12890b66fe 100644
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
> @@ -65,6 +66,8 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>  	/* Cache the data early to ensure is_visible() works */
>  	read_cdat_data(port);
>  
> +	cxl_switch_port_init_ras(port);

This is probably not the right place to do it because you have no dports yet with the new delayed dport setup. I would init the uport when the register gets probed in __devm_cxl_add_dport(), and init the dport on per dport basis as they are discovered. So maybe in cxl_port_add_dport(). This is where the old dport stuff in the switch probe got moved to.

> +
>  	return 0;
>  }
>  
> @@ -86,6 +89,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	if (rc)
>  		return rc;
>  
> +	cxl_endpoint_port_init_ras(port);
> +
>  	/*
>  	 * Now that all endpoint decoders are successfully enumerated, try to
>  	 * assemble regions from committed decoders


