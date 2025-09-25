Return-Path: <linux-pci+bounces-37066-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 020F3BA1FB6
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 01:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A21538432F
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 23:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BF72EB5DE;
	Thu, 25 Sep 2025 23:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="klg4NMV5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554351F8AC8;
	Thu, 25 Sep 2025 23:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758843381; cv=none; b=BX8SwmvQCH2gaCX864nWiNb5NyUFLlEgkjEIKIAwgtiKm7FDB7ydbBt4hXpmr56eNU+zuTm2kL/eN3w4WW/4VZFhu4+CjOkaOYqZx/EEQdtOtWJZGPg52FBV4QvAiZxBWkztirfDsGOdT4s9bIWNgoZrLWxMxmvouxLNHLskMBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758843381; c=relaxed/simple;
	bh=L7xtPuj+G6Io/SmsjeP0L+RJNZsdC/1ktlEGvHxEo/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VJ9Z4KKzhrCnmdFecahydSRExVdCmlE+2w/nol6/XnVtODRw6q2ccVzsiZahsL9tELuNUmPmwy3kDPg6TNmN9X8f077OMyFBGDyqXHv2TNDHQ24tqef2WhNnqz1yhCm/UBzT7cHI/HEf/5PRRVCxDwiWTM4FaI7Mh1tx18cFjfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=klg4NMV5; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758843380; x=1790379380;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=L7xtPuj+G6Io/SmsjeP0L+RJNZsdC/1ktlEGvHxEo/A=;
  b=klg4NMV5RWkkYmpz5fPenbX2WwrTuVHQsZHIsOJ/YwZLWqBJwsAMHHB0
   vC9zVlIUR8dijJResgYN9rYKsPFvr47XufJeqiCxOuIfQMyP2NO8lJYTJ
   zYZpXx8cfXZeNJ0JTNtZDs3AvtPZTJ7CoC5ED3zIMZ5GsBVakQllYtRc3
   uIFKNaK6LlNS7eAwBs7S4R270BmULCo+TlXqLNPwWPlML4aFhx+O4aytj
   EFcMH6RrG9NOCldSDD7k3LpUHcagfvCk01ZiIoRMd8j6u6nhaW8exD1jl
   7lG6kGMFKPli37WtSWEnkpoMkoiRD76hjxIZYXmhMziRO0GwVjRBOoLRM
   A==;
X-CSE-ConnectionGUID: eVDg2uJUTUGNik/hLIrZSg==
X-CSE-MsgGUID: 1X1B1po8SyGzdtNU+wcO/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="83783337"
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="83783337"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 16:36:17 -0700
X-CSE-ConnectionGUID: MeZMQOTdRpqd2XSQN7p/4A==
X-CSE-MsgGUID: UrX1bYc8SCyphaXgPsYZeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="182627602"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.109.4]) ([10.125.109.4])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 16:36:15 -0700
Message-ID: <6ef7d09e-dd8b-4e0c-b8d8-0b52262a1a50@intel.com>
Date: Thu, 25 Sep 2025 16:36:14 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 06/25] CXL/AER: Introduce aer_cxl_rch.c into AER
 driver for handling CXL RCH errors
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
 <20250925223440.3539069-7-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250925223440.3539069-7-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/25/25 3:34 PM, Terry Bowman wrote:
> The restricted CXL Host (RCH) AER error handling logic currently resides
> in the AER driver file, drivers/pci/pcie/aer.c. CXL specific changes are
> conditionally compiled using #ifdefs.
> 
> Improve the AER driver maintainability by separating the RCH specific logic
> from the AER driver's core functionality and removing the ifdefs. Introduce
> drivers/pci/pcie/aer_cxl_rch.c for moving the RCH AER logic into.
> Conditionally compile the file using the CONFIG_CXL_RCH_RAS Kconfig.
> 
> Move the CXL logic into the new file but leave helper functions in aer.c
> for now as they will be moved in future patch for CXL virtual hierarchy
> handling. Export the handler functions as needed. Export
> pci_aer_unmask_internal_errors() allowing for all subsystems to use.
> Avoid multiple declaration moves and export cxl_error_is_native() now to
> allow for cxl_core access.
> 
> Inorder to maintain compilation after the move other changes are required.
> Change cxl_rch_handle_error() & cxl_rch_enable_rcec() to be non-static
> inorder for accessing from the AER driver in aer.c.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Seems straight forward enough
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> 
> ---
> 
> Changes in v11->v12:
> - Rename drivers/pci/pcie/cxl_rch.c to drivers/pci/pcie/aer_cxl_rch.c (Lukas)
> - Removed forward declararation of 'struct aer_err_info' in pci/pci.h (Terry)
> 
> Changes in v10->v11:
> - Remove changes in code-split and move to earlier, new patch
> - Add #include <linux/bitfield.h> to cxl_ras.c
> - Move cxl_rch_handle_error() & cxl_rch_enable_rcec() declarations from pci.h
> to aer.h, more localized.
> - Introduce CONFIG_CXL_RCH_RAS, includes Makefile changes, ras.c
> ifdef changes
> ---
>  drivers/pci/pci.h              |  14 +++++
>  drivers/pci/pcie/Makefile      |   1 +
>  drivers/pci/pcie/aer.c         | 108 +++------------------------------
>  drivers/pci/pcie/aer_cxl_rch.c |  99 ++++++++++++++++++++++++++++++
>  include/linux/aer.h            |   8 +++
>  5 files changed, 129 insertions(+), 101 deletions(-)
>  create mode 100644 drivers/pci/pcie/aer_cxl_rch.c
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 34f65d69662e..0c7178d0ef9d 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -1201,4 +1201,18 @@ static inline int pci_msix_write_tph_tag(struct pci_dev *pdev, unsigned int inde
>  	(PCI_CONF1_ADDRESS(bus, dev, func, reg) | \
>  	 PCI_CONF1_EXT_REG(reg))
>  
> +#ifdef CONFIG_CXL_RCH_RAS
> +void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info);
> +void cxl_rch_enable_rcec(struct pci_dev *rcec);
> +#else
> +static inline void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info) { }
> +static inline void cxl_rch_enable_rcec(struct pci_dev *rcec) { }
> +#endif
> +
> +#ifdef CONFIG_CXL_RAS
> +bool is_internal_error(struct aer_err_info *info);
> +#else
> +static inline bool is_internal_error(struct aer_err_info *info) { return false; }
> +#endif
> +
>  #endif /* DRIVERS_PCI_H */
> diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
> index 173829aa02e6..970e7cbc5b34 100644
> --- a/drivers/pci/pcie/Makefile
> +++ b/drivers/pci/pcie/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o bwctrl.o
>  
>  obj-y				+= aspm.o
>  obj-$(CONFIG_PCIEAER)		+= aer.o err.o tlp.o
> +obj-$(CONFIG_CXL_RCH_RAS)	+= aer_cxl_rch.o
>  obj-$(CONFIG_PCIEAER_INJECT)	+= aer_inject.o
>  obj-$(CONFIG_PCIE_PME)		+= pme.o
>  obj-$(CONFIG_PCIE_DPC)		+= dpc.o
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 7a1dc2a3460b..6e5c9efe2920 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1099,7 +1099,7 @@ static bool find_source_device(struct pci_dev *parent,
>   * Note: AER must be enabled and supported by the device which must be
>   * checked in advance, e.g. with pcie_aer_is_native().
>   */
> -static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
> +void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>  {
>  	int aer = dev->aer_cap;
>  	u32 mask;
> @@ -1112,119 +1112,25 @@ static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>  	mask &= ~PCI_ERR_COR_INTERNAL;
>  	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
>  }
> +EXPORT_SYMBOL_GPL(pci_aer_unmask_internal_errors);
>  
> -static bool is_cxl_mem_dev(struct pci_dev *dev)
> -{
> -	/*
> -	 * The capability, status, and control fields in Device 0,
> -	 * Function 0 DVSEC control the CXL functionality of the
> -	 * entire device (CXL 3.0, 8.1.3).
> -	 */
> -	if (dev->devfn != PCI_DEVFN(0, 0))
> -		return false;
> -
> -	/*
> -	 * CXL Memory Devices must have the 502h class code set (CXL
> -	 * 3.0, 8.1.12.1).
> -	 */
> -	if ((dev->class >> 8) != PCI_CLASS_MEMORY_CXL)
> -		return false;
> -
> -	return true;
> -}
> -
> -static bool cxl_error_is_native(struct pci_dev *dev)
> +bool cxl_error_is_native(struct pci_dev *dev)
>  {
>  	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
>  
>  	return (pcie_ports_native || host->native_aer);
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_error_is_native, "CXL");
>  
> -static bool is_internal_error(struct aer_err_info *info)
> +bool is_internal_error(struct aer_err_info *info)
>  {
>  	if (info->severity == AER_CORRECTABLE)
>  		return info->status & PCI_ERR_COR_INTERNAL;
>  
>  	return info->status & PCI_ERR_UNC_INTN;
>  }
> -
> -static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
> -{
> -	struct aer_err_info *info = (struct aer_err_info *)data;
> -	const struct pci_error_handlers *err_handler;
> -
> -	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
> -		return 0;
> -
> -	/* Protect dev->driver */
> -	device_lock(&dev->dev);
> -
> -	err_handler = dev->driver ? dev->driver->err_handler : NULL;
> -	if (!err_handler)
> -		goto out;
> -
> -	if (info->severity == AER_CORRECTABLE) {
> -		if (err_handler->cor_error_detected)
> -			err_handler->cor_error_detected(dev);
> -	} else if (err_handler->error_detected) {
> -		if (info->severity == AER_NONFATAL)
> -			err_handler->error_detected(dev, pci_channel_io_normal);
> -		else if (info->severity == AER_FATAL)
> -			err_handler->error_detected(dev, pci_channel_io_frozen);
> -	}
> -out:
> -	device_unlock(&dev->dev);
> -	return 0;
> -}
> -
> -static void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
> -{
> -	/*
> -	 * Internal errors of an RCEC indicate an AER error in an
> -	 * RCH's downstream port. Check and handle them in the CXL.mem
> -	 * device driver.
> -	 */
> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
> -	    is_internal_error(info))
> -		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
> -}
> -
> -static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
> -{
> -	bool *handles_cxl = data;
> -
> -	if (!*handles_cxl)
> -		*handles_cxl = is_cxl_mem_dev(dev) && cxl_error_is_native(dev);
> -
> -	/* Non-zero terminates iteration */
> -	return *handles_cxl;
> -}
> -
> -static bool handles_cxl_errors(struct pci_dev *rcec)
> -{
> -	bool handles_cxl = false;
> -
> -	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC &&
> -	    pcie_aer_is_native(rcec))
> -		pcie_walk_rcec(rcec, handles_cxl_error_iter, &handles_cxl);
> -
> -	return handles_cxl;
> -}
> -
> -static void cxl_rch_enable_rcec(struct pci_dev *rcec)
> -{
> -	if (!handles_cxl_errors(rcec))
> -		return;
> -
> -	pci_aer_unmask_internal_errors(rcec);
> -	pci_info(rcec, "CXL: Internal errors unmasked");
> -}
> -
> -#else
> -static inline void cxl_rch_enable_rcec(struct pci_dev *dev) { }
> -static inline void cxl_rch_handle_error(struct pci_dev *dev,
> -					struct aer_err_info *info) { }
> -#endif
> +EXPORT_SYMBOL_NS_GPL(is_internal_error, "CXL");
> +#endif /* CONFIG_CXL_RAS */
>  
>  /**
>   * pci_aer_handle_error - handle logging error into an event log
> diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rch.c
> new file mode 100644
> index 000000000000..bfe071eebf67
> --- /dev/null
> +++ b/drivers/pci/pcie/aer_cxl_rch.c
> @@ -0,0 +1,99 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2025 AMD Corporation. All rights reserved. */
> +
> +#include <linux/pci.h>
> +#include <linux/aer.h>
> +#include <linux/bitfield.h>
> +#include "../pci.h"
> +
> +static bool is_cxl_mem_dev(struct pci_dev *dev)
> +{
> +	/*
> +	 * The capability, status, and control fields in Device 0,
> +	 * Function 0 DVSEC control the CXL functionality of the
> +	 * entire device (CXL 3.0, 8.1.3).
> +	 */
> +	if (dev->devfn != PCI_DEVFN(0, 0))
> +		return false;
> +
> +	/*
> +	 * CXL Memory Devices must have the 502h class code set (CXL
> +	 * 3.0, 8.1.12.1).
> +	 */
> +	if ((dev->class >> 8) != PCI_CLASS_MEMORY_CXL)
> +		return false;
> +
> +	return true;
> +}
> +
> +static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
> +{
> +	struct aer_err_info *info = (struct aer_err_info *)data;
> +	const struct pci_error_handlers *err_handler;
> +
> +	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
> +		return 0;
> +
> +	/* Protect dev->driver */
> +	device_lock(&dev->dev);
> +
> +	err_handler = dev->driver ? dev->driver->err_handler : NULL;
> +	if (!err_handler)
> +		goto out;
> +
> +	if (info->severity == AER_CORRECTABLE) {
> +		if (err_handler->cor_error_detected)
> +			err_handler->cor_error_detected(dev);
> +	} else if (err_handler->error_detected) {
> +		if (info->severity == AER_NONFATAL)
> +			err_handler->error_detected(dev, pci_channel_io_normal);
> +		else if (info->severity == AER_FATAL)
> +			err_handler->error_detected(dev, pci_channel_io_frozen);
> +	}
> +out:
> +	device_unlock(&dev->dev);
> +	return 0;
> +}
> +
> +void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
> +{
> +	/*
> +	 * Internal errors of an RCEC indicate an AER error in an
> +	 * RCH's downstream port. Check and handle them in the CXL.mem
> +	 * device driver.
> +	 */
> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
> +	    is_internal_error(info))
> +		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
> +}
> +
> +static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
> +{
> +	bool *handles_cxl = data;
> +
> +	if (!*handles_cxl)
> +		*handles_cxl = is_cxl_mem_dev(dev) && cxl_error_is_native(dev);
> +
> +	/* Non-zero terminates iteration */
> +	return *handles_cxl;
> +}
> +
> +static bool handles_cxl_errors(struct pci_dev *rcec)
> +{
> +	bool handles_cxl = false;
> +
> +	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC &&
> +	    pcie_aer_is_native(rcec))
> +		pcie_walk_rcec(rcec, handles_cxl_error_iter, &handles_cxl);
> +
> +	return handles_cxl;
> +}
> +
> +void cxl_rch_enable_rcec(struct pci_dev *rcec)
> +{
> +	if (!handles_cxl_errors(rcec))
> +		return;
> +
> +	pci_aer_unmask_internal_errors(rcec);
> +	pci_info(rcec, "CXL: Internal errors unmasked");
> +}
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 02940be66324..2ef820563996 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -56,12 +56,20 @@ struct aer_capability_regs {
>  #if defined(CONFIG_PCIEAER)
>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>  int pcie_aer_is_native(struct pci_dev *dev);
> +void pci_aer_unmask_internal_errors(struct pci_dev *dev);
>  #else
>  static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>  {
>  	return -EINVAL;
>  }
>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
> +static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
> +#endif
> +
> +#ifdef CONFIG_CXL_RAS
> +bool cxl_error_is_native(struct pci_dev *dev);
> +#else
> +static inline bool cxl_error_is_native(struct pci_dev *dev) { return false; }
>  #endif
>  
>  void pci_print_aer(struct pci_dev *dev, int aer_severity,


