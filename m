Return-Path: <linux-pci+bounces-44862-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5868BD21392
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 21:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BA80302FA38
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 20:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB9C3559FC;
	Wed, 14 Jan 2026 20:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PSFiUMsx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE2832B991;
	Wed, 14 Jan 2026 20:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768423901; cv=none; b=Fn/+3vXF28CzY1JIDutFuf1wjC3ZOtWHk/Z1l34i5lBFC57VDvKxpuEMuVl/763qBk0VjLwL+DXv8TY0iEsHWMFzoLUpKowaRMlUrNTKlvP0e18cf9lQeZraPx0npNbH8UQ6g5SINELtckg3eFA1vBOzY4bR/jGfMgZoebQlKVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768423901; c=relaxed/simple;
	bh=LzLmy2t7M9JxpD4QdAiGMry5dDLWTmCnY9k2ipc3Szs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bF/EiO2sTG1mFkWmTvVYxftlD/xCHzBxsW8WiSo+u5+4hU7HByiQJjnpjJI6+NAP/dQRqUcmMA4tDxTAm46DXC8oNUehKjtpJhICCeSbFtyL2UQkqZRjjT9rheC2B8vtRS3bewNFsOOb52xbPCIQ0HhHrMDtUflzWcuZ+Ww5iG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PSFiUMsx; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768423899; x=1799959899;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LzLmy2t7M9JxpD4QdAiGMry5dDLWTmCnY9k2ipc3Szs=;
  b=PSFiUMsxszDXoN67EsqBeDZvTdE97XtNFbZpWoRIYhR8hpR14ZzmxOvF
   Ve5NdZ05p8N6UXMvZ03bTXmXAvC/HoyYEsd17JLGyro2Er8HGdPTIAs4/
   6atv0X5Yl+RFNz2q7WLZFcl9lr28t05o/KysDt1X0CInzfmy9wAWVbCLx
   EK0jTOU7O105xOVwJAypxRn+ALiIXSYXxLHE6rgDnEB/+vgW9h2z3oI83
   QrZ6Y2gRRH7xz/d+gVlSpKenOrQOtCASd8TroMKbLCc/CKHAVwxX9J7Ji
   RSgD/4Qf1SCyLccALEWhZPshDvBa6RSMX70U0vE0StnAQiY+vCUCb28cK
   w==;
X-CSE-ConnectionGUID: HUPIMUWbTg2E39o7gKAQPA==
X-CSE-MsgGUID: QCIblIKyTj2F2cY5N08KOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69641038"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="69641038"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 12:51:38 -0800
X-CSE-ConnectionGUID: coImAfNZQki1iDb2P4BceA==
X-CSE-MsgGUID: SzITSOa6TpymGHD1Xm8UyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="209635990"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.111.5]) ([10.125.111.5])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 12:51:36 -0800
Message-ID: <a69592f3-9158-4d59-99db-e0116f0d50d4@intel.com>
Date: Wed, 14 Jan 2026 13:51:35 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 07/34] cxl/pci: Remove CXL VH handling in
 CONFIG_PCIEAER_CXL conditional blocks from core/pci.c
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, vishal.l.verma@intel.com, alucerop@amd.com,
 ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260114182055.46029-1-terry.bowman@amd.com>
 <20260114182055.46029-8-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260114182055.46029-8-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/14/26 11:20 AM, Terry Bowman wrote:
> From: Dave Jiang <dave.jiang@intel.com>
> 
> Create new config CONFIG_CXL_RAS and put all CXL RAS items behind the
> config. The config will depend on CPER and PCIE AER to build. Move the
> related VH RAS code from core/pci.c to core/ras.c.
> 
> Restricted CXL host (RCH) RAS functions will be moved in a future patch.
> 
> Cc: Robert Richter <rrichter@amd.com>
> Cc: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Terry, missing your sign off as well.

> 
> ---
> 
> Changes in v13->v14:
> - None
> 
> Changes in v12->v13:
> - None
> 
> Changes in v11->v12:
> - None
> 
> Changes in v10->v11:
> - New patch
> - Updated by Terry Bowman to use (ACPI_APEI_GHES && PCIEAER_CXL) dependency
>   in Kconfig. Otherwise checks will be reauired for CONFIG_PCIEAER because
>   AER driver functions are called.
> ---
>  drivers/cxl/Kconfig       |   4 +
>  drivers/cxl/core/Makefile |   2 +-
>  drivers/cxl/core/core.h   |  31 +++++++
>  drivers/cxl/core/pci.c    | 189 +-------------------------------------
>  drivers/cxl/core/ras.c    | 176 +++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |   8 --
>  drivers/cxl/cxlpci.h      |  16 ++++
>  tools/testing/cxl/Kbuild  |   2 +-
>  8 files changed, 233 insertions(+), 195 deletions(-)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 48b7314afdb8..217888992c88 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -233,4 +233,8 @@ config CXL_MCE
>  	def_bool y
>  	depends on X86_MCE && MEMORY_FAILURE
>  
> +config CXL_RAS
> +	def_bool y
> +	depends on ACPI_APEI_GHES && PCIEAER && CXL_PCI
> +
>  endif
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 5ad8fef210b5..b2930cc54f8b 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -14,9 +14,9 @@ cxl_core-y += pci.o
>  cxl_core-y += hdm.o
>  cxl_core-y += pmu.o
>  cxl_core-y += cdat.o
> -cxl_core-y += ras.o
>  cxl_core-$(CONFIG_TRACING) += trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += region.o
>  cxl_core-$(CONFIG_CXL_MCE) += mce.o
>  cxl_core-$(CONFIG_CXL_FEATURES) += features.o
>  cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
> +cxl_core-$(CONFIG_CXL_RAS) += ras.o
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 1fb66132b777..bc818de87ccc 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -144,8 +144,39 @@ int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c);
>  int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
>  					struct access_coordinate *c);
>  
> +#ifdef CONFIG_CXL_RAS
>  int cxl_ras_init(void);
>  void cxl_ras_exit(void);
> +bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base);
> +void cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base);
> +#else
> +static inline int cxl_ras_init(void)
> +{
> +	return 0;
> +}
> +
> +static inline void cxl_ras_exit(void)
> +{
> +}
> +
> +static inline bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
> +{
> +	return false;
> +}
> +static inline void cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base) { }
> +#endif /* CONFIG_CXL_RAS */
> +
> +/* Restricted CXL Host specific RAS functions */
> +#ifdef CONFIG_CXL_RAS
> +void cxl_dport_map_rch_aer(struct cxl_dport *dport);
> +void cxl_disable_rch_root_ints(struct cxl_dport *dport);
> +void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds);
> +#else
> +static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
> +static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { }
> +static inline void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
> +#endif /* CONFIG_CXL_RAS */
> +
>  int cxl_gpf_port_setup(struct cxl_dport *dport);
>  
>  struct cxl_hdm;
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 51bb0f372e40..e132fff80979 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -632,81 +632,8 @@ void read_cdat_data(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
>  
> -static void cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
> -			       void __iomem *ras_base)
> -{
> -	void __iomem *addr;
> -	u32 status;
> -
> -	if (!ras_base)
> -		return;
> -
> -	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
> -	status = readl(addr);
> -	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
> -		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> -		trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
> -	}
> -}
> -
> -/* CXL spec rev3.0 8.2.4.16.1 */
> -static void header_log_copy(void __iomem *ras_base, u32 *log)
> -{
> -	void __iomem *addr;
> -	u32 *log_addr;
> -	int i, log_u32_size = CXL_HEADERLOG_SIZE / sizeof(u32);
> -
> -	addr = ras_base + CXL_RAS_HEADER_LOG_OFFSET;
> -	log_addr = log;
> -
> -	for (i = 0; i < log_u32_size; i++) {
> -		*log_addr = readl(addr);
> -		log_addr++;
> -		addr += sizeof(u32);
> -	}
> -}
> -
> -/*
> - * Log the state of the RAS status registers and prepare them to log the
> - * next error status. Return 1 if reset needed.
> - */
> -static bool cxl_handle_ras(struct cxl_dev_state *cxlds,
> -			   void __iomem *ras_base)
> -{
> -	u32 hl[CXL_HEADERLOG_SIZE_U32];
> -	void __iomem *addr;
> -	u32 status;
> -	u32 fe;
> -
> -	if (!ras_base)
> -		return false;
> -
> -	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
> -	status = readl(addr);
> -	if (!(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK))
> -		return false;
> -
> -	/* If multiple errors, log header points to first error from ctrl reg */
> -	if (hweight32(status) > 1) {
> -		void __iomem *rcc_addr =
> -			ras_base + CXL_RAS_CAP_CONTROL_OFFSET;
> -
> -		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
> -				   readl(rcc_addr)));
> -	} else {
> -		fe = status;
> -	}
> -
> -	header_log_copy(ras_base, hl);
> -	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe, hl);
> -	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
> -
> -	return true;
> -}
> -
> -#ifdef CONFIG_PCIEAER_CXL
> -
> -static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
> +#ifdef CONFIG_CXL_RAS
> +void cxl_dport_map_rch_aer(struct cxl_dport *dport)
>  {
>  	resource_size_t aer_phys;
>  	struct device *host;
> @@ -721,19 +648,7 @@ static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
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
> -static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
> +void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>  {
>  	void __iomem *aer_base = dport->regs.dport_aer;
>  	u32 aer_cmd_mask, aer_cmd;
> @@ -757,28 +672,6 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>  	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
>  }
>  
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
>  /*
>   * Copy the AER capability registers using 32 bit read accesses.
>   * This is necessary because RCRB AER capability is MMIO mapped. Clear the
> @@ -827,7 +720,7 @@ static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
>  	return false;
>  }
>  
> -static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
> +void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
>  {
>  	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>  	struct aer_capability_regs aer_regs;
> @@ -852,82 +745,8 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
>  	else
>  		cxl_handle_ras(cxlds, dport->regs.ras);
>  }
> -
> -#else
> -static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
>  #endif
>  
> -void cxl_cor_error_detected(struct pci_dev *pdev)
> -{
> -	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> -	struct device *dev = &cxlds->cxlmd->dev;
> -
> -	scoped_guard(device, dev) {
> -		if (!dev->driver) {
> -			dev_warn(&pdev->dev,
> -				 "%s: memdev disabled, abort error handling\n",
> -				 dev_name(dev));
> -			return;
> -		}
> -
> -		if (cxlds->rcd)
> -			cxl_handle_rdport_errors(cxlds);
> -
> -		cxl_handle_cor_ras(cxlds, cxlds->regs.ras);
> -	}
> -}
> -EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
> -
> -pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
> -				    pci_channel_state_t state)
> -{
> -	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> -	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> -	struct device *dev = &cxlmd->dev;
> -	bool ue;
> -
> -	scoped_guard(device, dev) {
> -		if (!dev->driver) {
> -			dev_warn(&pdev->dev,
> -				 "%s: memdev disabled, abort error handling\n",
> -				 dev_name(dev));
> -			return PCI_ERS_RESULT_DISCONNECT;
> -		}
> -
> -		if (cxlds->rcd)
> -			cxl_handle_rdport_errors(cxlds);
> -		/*
> -		 * A frozen channel indicates an impending reset which is fatal to
> -		 * CXL.mem operation, and will likely crash the system. On the off
> -		 * chance the situation is recoverable dump the status of the RAS
> -		 * capability registers and bounce the active state of the memdev.
> -		 */
> -		ue = cxl_handle_ras(cxlds, cxlds->regs.ras);
> -	}
> -
> -
> -	switch (state) {
> -	case pci_channel_io_normal:
> -		if (ue) {
> -			device_release_driver(dev);
> -			return PCI_ERS_RESULT_NEED_RESET;
> -		}
> -		return PCI_ERS_RESULT_CAN_RECOVER;
> -	case pci_channel_io_frozen:
> -		dev_warn(&pdev->dev,
> -			 "%s: frozen state error detected, disable CXL.mem\n",
> -			 dev_name(dev));
> -		device_release_driver(dev);
> -		return PCI_ERS_RESULT_NEED_RESET;
> -	case pci_channel_io_perm_failure:
> -		dev_warn(&pdev->dev,
> -			 "failure state error detected, request disconnect\n");
> -		return PCI_ERS_RESULT_DISCONNECT;
> -	}
> -	return PCI_ERS_RESULT_NEED_RESET;
> -}
> -EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
> -
>  static int cxl_flit_size(struct pci_dev *pdev)
>  {
>  	if (cxl_pci_flit_256(pdev))
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 2731ba3a0799..b933030b8e1e 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -5,6 +5,7 @@
>  #include <linux/aer.h>
>  #include <cxl/event.h>
>  #include <cxlmem.h>
> +#include <cxlpci.h>
>  #include "trace.h"
>  
>  static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
> @@ -124,3 +125,178 @@ void cxl_ras_exit(void)
>  	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
>  	cancel_work_sync(&cxl_cper_prot_err_work);
>  }
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
> +void cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
> +{
> +	void __iomem *addr;
> +	u32 status;
> +
> +	if (!ras_base)
> +		return;
> +
> +	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
> +	status = readl(addr);
> +	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
> +		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> +		trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
> +	}
> +}
> +
> +/* CXL spec rev3.0 8.2.4.16.1 */
> +static void header_log_copy(void __iomem *ras_base, u32 *log)
> +{
> +	void __iomem *addr;
> +	u32 *log_addr;
> +	int i, log_u32_size = CXL_HEADERLOG_SIZE / sizeof(u32);
> +
> +	addr = ras_base + CXL_RAS_HEADER_LOG_OFFSET;
> +	log_addr = log;
> +
> +	for (i = 0; i < log_u32_size; i++) {
> +		*log_addr = readl(addr);
> +		log_addr++;
> +		addr += sizeof(u32);
> +	}
> +}
> +
> +/*
> + * Log the state of the RAS status registers and prepare them to log the
> + * next error status. Return 1 if reset needed.
> + */
> +bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
> +{
> +	u32 hl[CXL_HEADERLOG_SIZE_U32];
> +	void __iomem *addr;
> +	u32 status;
> +	u32 fe;
> +
> +	if (!ras_base)
> +		return false;
> +
> +	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
> +	status = readl(addr);
> +	if (!(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK))
> +		return false;
> +
> +	/* If multiple errors, log header points to first error from ctrl reg */
> +	if (hweight32(status) > 1) {
> +		void __iomem *rcc_addr =
> +			ras_base + CXL_RAS_CAP_CONTROL_OFFSET;
> +
> +		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
> +				   readl(rcc_addr)));
> +	} else {
> +		fe = status;
> +	}
> +
> +	header_log_copy(ras_base, hl);
> +	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe, hl);
> +	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
> +
> +	return true;
> +}
> +
> +void cxl_cor_error_detected(struct pci_dev *pdev)
> +{
> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +	struct device *dev = &cxlds->cxlmd->dev;
> +
> +	scoped_guard(device, dev) {
> +		if (!dev->driver) {
> +			dev_warn(&pdev->dev,
> +				 "%s: memdev disabled, abort error handling\n",
> +				 dev_name(dev));
> +			return;
> +		}
> +
> +		if (cxlds->rcd)
> +			cxl_handle_rdport_errors(cxlds);
> +
> +		cxl_handle_cor_ras(cxlds, cxlds->regs.ras);
> +	}
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
> +
> +pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
> +				    pci_channel_state_t state)
> +{
> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> +	struct device *dev = &cxlmd->dev;
> +	bool ue;
> +
> +	scoped_guard(device, dev) {
> +		if (!dev->driver) {
> +			dev_warn(&pdev->dev,
> +				 "%s: memdev disabled, abort error handling\n",
> +				 dev_name(dev));
> +			return PCI_ERS_RESULT_DISCONNECT;
> +		}
> +
> +		if (cxlds->rcd)
> +			cxl_handle_rdport_errors(cxlds);
> +		/*
> +		 * A frozen channel indicates an impending reset which is fatal to
> +		 * CXL.mem operation, and will likely crash the system. On the off
> +		 * chance the situation is recoverable dump the status of the RAS
> +		 * capability registers and bounce the active state of the memdev.
> +		 */
> +		ue = cxl_handle_ras(cxlds, cxlds->regs.ras);
> +	}
> +
> +
> +	switch (state) {
> +	case pci_channel_io_normal:
> +		if (ue) {
> +			device_release_driver(dev);
> +			return PCI_ERS_RESULT_NEED_RESET;
> +		}
> +		return PCI_ERS_RESULT_CAN_RECOVER;
> +	case pci_channel_io_frozen:
> +		dev_warn(&pdev->dev,
> +			 "%s: frozen state error detected, disable CXL.mem\n",
> +			 dev_name(dev));
> +		device_release_driver(dev);
> +		return PCI_ERS_RESULT_NEED_RESET;
> +	case pci_channel_io_perm_failure:
> +		dev_warn(&pdev->dev,
> +			 "failure state error detected, request disconnect\n");
> +		return PCI_ERS_RESULT_DISCONNECT;
> +	}
> +	return PCI_ERS_RESULT_NEED_RESET;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index ba17fa86d249..42a76a7a088f 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -803,14 +803,6 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>  					 struct device *dport_dev, int port_id,
>  					 resource_size_t rcrb);
>  
> -#ifdef CONFIG_PCIEAER_CXL
> -void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport);
> -void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
> -#else
> -static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
> -						struct device *host) { }
> -#endif
> -
>  struct cxl_decoder *to_cxl_decoder(struct device *dev);
>  struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
>  struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index cdb7cf3dbcb4..6f9c78886fd9 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -76,7 +76,23 @@ static inline bool cxl_pci_flit_256(struct pci_dev *pdev)
>  
>  struct cxl_dev_state;
>  void read_cdat_data(struct cxl_port *port);
> +
> +#ifdef CONFIG_CXL_RAS
>  void cxl_cor_error_detected(struct pci_dev *pdev);
>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  				    pci_channel_state_t state);
> +void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
> +#else
> +static inline void cxl_cor_error_detected(struct pci_dev *pdev) { }
> +
> +static inline pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
> +						  pci_channel_state_t state)
> +{
> +	return PCI_ERS_RESULT_NONE;
> +}
> +
> +static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
> +						struct device *host) { }
> +#endif
> +
>  #endif /* __CXL_PCI_H__ */
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index 0e151d0572d1..b7ea66382f3b 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -57,12 +57,12 @@ cxl_core-y += $(CXL_CORE_SRC)/pci.o
>  cxl_core-y += $(CXL_CORE_SRC)/hdm.o
>  cxl_core-y += $(CXL_CORE_SRC)/pmu.o
>  cxl_core-y += $(CXL_CORE_SRC)/cdat.o
> -cxl_core-y += $(CXL_CORE_SRC)/ras.o
>  cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
>  cxl_core-$(CONFIG_CXL_MCE) += $(CXL_CORE_SRC)/mce.o
>  cxl_core-$(CONFIG_CXL_FEATURES) += $(CXL_CORE_SRC)/features.o
>  cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += $(CXL_CORE_SRC)/edac.o
> +cxl_core-$(CONFIG_CXL_RAS) += $(CXL_CORE_SRC)/ras.o
>  cxl_core-y += config_check.o
>  cxl_core-y += cxl_core_test.o
>  cxl_core-y += cxl_core_exports.o


