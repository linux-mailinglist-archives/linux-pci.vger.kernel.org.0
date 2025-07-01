Return-Path: <linux-pci+bounces-31209-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9758AF05FB
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 23:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DC321892D7C
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 21:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AAA26D4E5;
	Tue,  1 Jul 2025 21:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gVk44d8l"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4013261591;
	Tue,  1 Jul 2025 21:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751406839; cv=none; b=BI7icuuw/8Aj8u5ONa7Qxf2BiTQkDFzrdIuNUf6qrjwdSIHiuUi4cOvEBUVlNZdUxN62g0GBVF2PmA0xCQIduFsctmtA/3Sh76PezV4iGU8aUE+ajaFVJuGMJ985uFCzwnLhjnJknyFs6aLjkQyDE7Z5Tkhe9RPQ4nKxlwzN2QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751406839; c=relaxed/simple;
	bh=0qww2M1sVO+Dzb7ZZPPpEEm/V/oVXWDVVozwG3o3DXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a3eHUq0zWwzMZmhe/aWoACe4bHJ/ua+uOW6+enTOTA4ArGwyGcP1dUQ0fTRdEfbSgmWIEQYv8inOnh7wlg+ybWaJWiJ5MGSL3J5fCCe9joYFRObK0dZ2rLHkELu5v5+YZv/4UL6zIHpV8s2VHaxympjoJ9VyjwrYWv/Q0caE0Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gVk44d8l; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751406837; x=1782942837;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0qww2M1sVO+Dzb7ZZPPpEEm/V/oVXWDVVozwG3o3DXQ=;
  b=gVk44d8l3FCoMIAW66RETESSv7il6XbfAbM/894JM2NcF2j9+q/8Tk3h
   6ojU705NNUlV6ObXlpdm0Jw0h6DMNhTbrPUX3ApTLTgLPaG8dV2uIhC83
   x7FTL1vFYkT8dL7UnCQF8iUDRxCv3uzL+NfrlZAWxDgHHOZ8ZgWmVHOp0
   dTuU4Zj5n6PokehKFEhv/rV8G6cDDXAQVWvvtboAJXmMres4HIzMTxKjl
   yfr1gGe5UzLQ65n+drA57AfdUPQYxyElukszxWTRbpinE5wqoa03+YECr
   5zRuXyhtHVoHAsFQPY34vfO/VtzBm7s8MrR6PS6W5XngPaoQg62jjCkpu
   g==;
X-CSE-ConnectionGUID: Wk3eE/f9ReqsD3VqTzFt9w==
X-CSE-MsgGUID: vvzwW6ETTdmh/znySRuc0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="57466664"
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; 
   d="scan'208";a="57466664"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 14:53:56 -0700
X-CSE-ConnectionGUID: rYTDNAVARiCj9xhzQMTaFQ==
X-CSE-MsgGUID: UXoB5eLzQ+qvRb/ui0MjFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; 
   d="scan'208";a="157926125"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.109.179]) ([10.125.109.179])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 14:53:54 -0700
Message-ID: <f6ce1309-5c80-4778-ac8c-b4c0450995a2@intel.com>
Date: Tue, 1 Jul 2025 14:53:54 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 05/17] CXL/AER: Introduce kfifo for forwarding CXL
 errors
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
 <20250626224252.1415009-6-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250626224252.1415009-6-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/26/25 3:42 PM, Terry Bowman wrote:
> CXL error handling will soon be moved from the AER driver into the CXL
> driver. This requires a notification mechanism for the AER driver to share
> the AER interrupt with the CXL driver. The notification will be used
> as an indication for the CXL drivers to handle and log the CXL RAS errors.
> 
> First, introduce cxl/core/native_ras.c to contain changes for the CXL
> driver's RAS native handling. This as an alternative to dropping the
> changes into existing cxl/core/ras.c file with purpose to avoid #ifdefs.
> Introduce CXL Kconfig CXL_NATIVE_RAS, dependent on PCIEAER_CXL, to
> conditionally compile the new file.
> 
> Add a kfifo work queue to be used by the AER driver and CXL driver. The AER
> driver will be the sole kfifo producer adding work and the cxl_core will be
> the sole kfifo consumer removing work. Add the boilerplate kfifo support.
> 
> Add CXL work queue handler registration functions in the AER driver. Export
> the functions allowing CXL driver to access. Implement registration
> functions for the CXL driver to assign or clear the work handler function.
> 
> Introduce 'struct cxl_proto_err_info' to serve as the kfifo work data. This
> will contain the erring device's PCI SBDF details used to rediscover the
> device after the CXL driver dequeues the kfifo work. The device rediscovery
> will be introduced along with the CXL handling in future patches.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/cxl/Kconfig           | 14 ++++++++
>  drivers/cxl/core/Makefile     |  1 +
>  drivers/cxl/core/core.h       |  8 +++++
>  drivers/cxl/core/native_ras.c | 26 +++++++++++++++

With the addition of a new file to cxl_core, can you please also fix up tools/testing/cxl/Kbuild?

DJ

>  drivers/cxl/core/port.c       |  2 ++
>  drivers/cxl/core/ras.c        |  1 +
>  drivers/cxl/cxlpci.h          |  1 +
>  drivers/pci/pci.h             |  4 +++
>  drivers/pci/pcie/aer.c        |  7 ++--
>  drivers/pci/pcie/cxl_aer.c    | 60 +++++++++++++++++++++++++++++++++++
>  include/linux/aer.h           | 31 ++++++++++++++++++
>  11 files changed, 153 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/cxl/core/native_ras.c
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 48b7314afdb8..57274de54a45 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -233,4 +233,18 @@ config CXL_MCE
>  	def_bool y
>  	depends on X86_MCE && MEMORY_FAILURE
>  
> +config CXL_NATIVE_RAS
> +	bool "CXL: Enable CXL RAS native handling"
> +	depends on PCIEAER_CXL
> +	default CXL_BUS
> +	help
> +	  Enable native CXL RAS protocol error handling and logging in the CXL
> +	  drivers. This functionality relies on the AER service driver being
> +	  enabled, as the AER interrupt is used to inform the operating system
> +	  of CXL RAS protocol errors. The platform must be configured to
> +	  utilize AER reporting for interrupts.
> +
> +	  If unsure, or if this kernel is meant for production environments,
> +	  say Y.
> +
>  endif
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 79e2ef81fde8..16f5832e5cc4 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -21,3 +21,4 @@ cxl_core-$(CONFIG_CXL_REGION) += region.o
>  cxl_core-$(CONFIG_CXL_MCE) += mce.o
>  cxl_core-$(CONFIG_CXL_FEATURES) += features.o
>  cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
> +cxl_core-$(CONFIG_CXL_NATIVE_RAS) += native_ras.o
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 29b61828a847..4c08bb92e2f9 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -123,6 +123,14 @@ int cxl_gpf_port_setup(struct cxl_dport *dport);
>  int cxl_acpi_get_extended_linear_cache_size(struct resource *backing_res,
>  					    int nid, resource_size_t *size);
>  
> +#ifdef CONFIG_PCIEAER_CXL
> +void cxl_native_ras_init(void);
> +void cxl_native_ras_exit(void);
> +#else
> +static inline void cxl_native_ras_init(void) { };
> +static inline void cxl_native_ras_exit(void) { };
> +#endif
> +
>  #ifdef CONFIG_CXL_FEATURES
>  struct cxl_feat_entry *
>  cxl_feature_info(struct cxl_features_state *cxlfs, const uuid_t *uuid);
> diff --git a/drivers/cxl/core/native_ras.c b/drivers/cxl/core/native_ras.c
> new file mode 100644
> index 000000000000..011815ddaae3
> --- /dev/null
> +++ b/drivers/cxl/core/native_ras.c
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2025 AMD Corporation. All rights reserved. */
> +
> +#include <linux/pci.h>
> +#include <linux/aer.h>
> +#include <cxl/event.h>
> +#include <cxlmem.h>
> +#include <core/core.h>
> +
> +static void cxl_proto_err_work_fn(struct work_struct *work)
> +{
> +}
> +
> +static struct work_struct cxl_proto_err_work;
> +static DECLARE_WORK(cxl_proto_err_work, cxl_proto_err_work_fn);
> +
> +void cxl_native_ras_init(void)
> +{
> +	cxl_register_proto_err_work(&cxl_proto_err_work);
> +}
> +
> +void cxl_native_ras_exit(void)
> +{
> +	cxl_unregister_proto_err_work();
> +	cancel_work_sync(&cxl_proto_err_work);
> +}
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index eb46c6764d20..8e8f21197c86 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -2345,6 +2345,8 @@ static __init int cxl_core_init(void)
>  	if (rc)
>  		goto err_ras;
>  
> +	cxl_native_ras_init();
> +
>  	return 0;
>  
>  err_ras:
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 485a831695c7..962dc94fed8c 100644
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
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 54e219b0049e..6f1396ef7b77 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -4,6 +4,7 @@
>  #define __CXL_PCI_H__
>  #include <linux/pci.h>
>  #include "cxl.h"
> +#include "linux/aer.h"
>  
>  #define CXL_MEMORY_PROGIF	0x10
>  
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 91b583cf18eb..29c11c7136d3 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -1032,9 +1032,13 @@ static inline void pci_restore_aer_state(struct pci_dev *dev) { }
>  #ifdef CONFIG_PCIEAER_CXL
>  void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info);
>  void cxl_rch_enable_rcec(struct pci_dev *rcec);
> +bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info);
> +void forward_cxl_error(struct pci_dev *pdev, struct aer_err_info *aer_err_info);
>  #else
>  static inline void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info) { }
>  static inline void cxl_rch_enable_rcec(struct pci_dev *rcec) { }
> +static inline bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info) { return false; }
> +static inline void forward_cxl_error(struct pci_dev *pdev, struct aer_err_info *aer_err_info) { }
>  #endif
>  
>  #ifdef CONFIG_ACPI
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 0b4d721980ef..8417a49c71f2 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1130,8 +1130,11 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>  
>  static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>  {
> -	cxl_rch_handle_error(dev, info);
> -	pci_aer_handle_error(dev, info);
> +	if (is_cxl_error(dev, info))
> +		forward_cxl_error(dev, info);
> +	else
> +		pci_aer_handle_error(dev, info);
> +
>  	pci_dev_put(dev);
>  }
>  
> diff --git a/drivers/pci/pcie/cxl_aer.c b/drivers/pci/pcie/cxl_aer.c
> index b2ea14f70055..846ab55d747c 100644
> --- a/drivers/pci/pcie/cxl_aer.c
> +++ b/drivers/pci/pcie/cxl_aer.c
> @@ -3,8 +3,11 @@
>  
>  #include <linux/pci.h>
>  #include <linux/aer.h>
> +#include <linux/kfifo.h>
>  #include "../pci.h"
>  
> +#define CXL_ERROR_SOURCES_MAX          128
> +
>  /**
>   * pci_aer_unmask_internal_errors - unmask internal errors
>   * @dev: pointer to the pci_dev data structure
> @@ -64,6 +67,19 @@ static bool is_internal_error(struct aer_err_info *info)
>  	return info->status & PCI_ERR_UNC_INTN;
>  }
>  
> +bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
> +{
> +	if (!info || !info->is_cxl)
> +		return false;
> +
> +	/* Only CXL Endpoints are currently supported */
> +	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT) &&
> +	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_EC))
> +		return false;
> +
> +	return is_internal_error(info);
> +}
> +
>  static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>  {
>  	struct aer_err_info *info = (struct aer_err_info *)data;
> @@ -136,3 +152,47 @@ void cxl_rch_enable_rcec(struct pci_dev *rcec)
>  	pci_info(rcec, "CXL: Internal errors unmasked");
>  }
>  
> +static DEFINE_KFIFO(cxl_proto_err_fifo, struct cxl_proto_err_work_data,
> +		    CXL_ERROR_SOURCES_MAX);
> +static DEFINE_SPINLOCK(cxl_proto_err_fifo_lock);
> +struct work_struct *cxl_proto_err_work;
> +
> +void cxl_register_proto_err_work(struct work_struct *work)
> +{
> +	guard(spinlock)(&cxl_proto_err_fifo_lock);
> +	cxl_proto_err_work = work;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_register_proto_err_work, "CXL");
> +
> +void cxl_unregister_proto_err_work(void)
> +{
> +	guard(spinlock)(&cxl_proto_err_fifo_lock);
> +	cxl_proto_err_work = NULL;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_unregister_proto_err_work, "CXL");
> +
> +int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd)
> +{
> +	return kfifo_get(&cxl_proto_err_fifo, wd);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_proto_err_kfifo_get, "CXL");
> +
> +void forward_cxl_error(struct pci_dev *pdev, struct aer_err_info *aer_err_info)
> +{
> +	struct cxl_proto_err_work_data wd;
> +
> +	wd.err_info = (struct cxl_proto_error_info) {
> +		.severity = aer_err_info->severity,
> +		.devfn = pdev->devfn,
> +		.bus = pdev->bus->number,
> +		.segment = pci_domain_nr(pdev->bus)
> +	};
> +
> +	if (!kfifo_put(&cxl_proto_err_fifo, wd)) {
> +		dev_err_ratelimited(&pdev->dev, "CXL kfifo overflow\n");
> +		return;
> +	}
> +
> +	schedule_work(cxl_proto_err_work);
> +}
> +
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 02940be66324..24c3d9e18ad5 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -10,6 +10,7 @@
>  
>  #include <linux/errno.h>
>  #include <linux/types.h>
> +#include <linux/workqueue_types.h>
>  
>  #define AER_NONFATAL			0
>  #define AER_FATAL			1
> @@ -53,6 +54,26 @@ struct aer_capability_regs {
>  	u16 uncor_err_source;
>  };
>  
> +/**
> + * struct cxl_proto_err_info - Error information used in CXL error handling
> + * @severity: AER severity
> + * @function: Device's PCI function
> + * @device: Device's PCI device
> + * @bus: Device's PCI bus
> + * @segment: Device's PCI segment
> + */
> +struct cxl_proto_error_info {
> +	int severity;
> +
> +	u8 devfn;
> +	u8 bus;
> +	u16 segment;
> +};
> +
> +struct cxl_proto_err_work_data {
> +	struct cxl_proto_error_info err_info;
> +};
> +
>  #if defined(CONFIG_PCIEAER)
>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>  int pcie_aer_is_native(struct pci_dev *dev);
> @@ -64,6 +85,16 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>  #endif
>  
> +#if defined(CONFIG_PCIEAER_CXL)
> +void cxl_register_proto_err_work(struct work_struct *work);
> +void cxl_unregister_proto_err_work(void);
> +int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd);
> +#else
> +static inline void cxl_register_proto_err_work(struct work_struct *work) { }
> +static inline void cxl_unregister_proto_err_work(void) { }
> +static inline int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd) { return 0; }
> +#endif
> +
>  void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  		    struct aer_capability_regs *aer);
>  int cper_severity_to_aer(int cper_severity);


