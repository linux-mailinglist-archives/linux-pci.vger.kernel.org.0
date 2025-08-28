Return-Path: <linux-pci+bounces-35062-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAFDB3AC0C
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 22:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0BB55803B9
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 20:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A136D28B7DE;
	Thu, 28 Aug 2025 20:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ex6zUZIy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8735329A30D;
	Thu, 28 Aug 2025 20:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756414435; cv=none; b=dCXb7oAr0rNi+/KKqPPBwgkDigwquDnnq5loXv/IIcS43wkeTnYGYqYQsoUeFh9+Bvfk5Qu0+kkiBu6qXsXVv9iLHUfX4C1PGbgs472VrzkDxa5hOqEG8OLqSX8YPScseA+m3u4CvKnadKKx1+g/D/dHWKYPEjuBmj6ffx9dWcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756414435; c=relaxed/simple;
	bh=93QGENlBd8jRA9wsb0bLUUKYp8Y4mEvYkrHJeEPpnnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cyyzJbp6WPQq2K41qXvlVHcdDr17zZ2kfrnKHn5YW+9CcLFTIWkcwjoynXPth+HvryOue2M3M+1FUp0RVJMjG+ShYLUvLh61vl7qL0oThLGmFVOdIV/3EZBHNLrlKkrrI6PRw4WSPO0PUbFud7Po4lfAhUINd1aXdQ/YxDaJaNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ex6zUZIy; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756414433; x=1787950433;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=93QGENlBd8jRA9wsb0bLUUKYp8Y4mEvYkrHJeEPpnnI=;
  b=ex6zUZIyAS8eJjIQkYEmgXBR62Jx6o0ynJo867SXA1TYcdGfxtNjqlKz
   Df7S+IXhbKJ7p4eyloyD3a9LUi4HNJH8lXFXCwJBkW76Ujd8kLcBPyyVH
   DSLcJ5F90W6iwR7ToFtW5ACKHjX96HSH7ft/U0x/4UA+sxauDvM9G72im
   deTRS8+20Qs7i+CmG2jYkjTpuNyi09QxLUQMSdNROCLwfFwMi9Okxf2+/
   usldjMcU929BGSGXCCNXA9pFCE9iVJbCl+DUeGtpYfuJ5XPMNccK0Aoyb
   e6q4iHVnRy0dGADX4cNebqk/qZltt+NfbzdTJo1TiugT0t/0PIO2D0Cs6
   A==;
X-CSE-ConnectionGUID: A1hVl5QwRbCz5vafENKoag==
X-CSE-MsgGUID: ZBgukBwBT02I068W4YLhJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="46270243"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="46270243"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 13:53:50 -0700
X-CSE-ConnectionGUID: H0Mmf1MJQ7GpS3KMHDeCFw==
X-CSE-MsgGUID: 8Vk/q/bVTCSDsWqUpShz2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="175502134"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.118.49]) ([10.247.118.49])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 13:53:41 -0700
Message-ID: <9e01d94c-7990-4599-9eee-ac0f337d6e2d@intel.com>
Date: Thu, 28 Aug 2025 13:53:35 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 06/23] CXL/AER: Introduce rch_aer.c into AER driver
 for handling CXL RCH errors
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
 <20250827013539.903682-7-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250827013539.903682-7-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/26/25 6:35 PM, Terry Bowman wrote:
> The restricted CXL Host (RCH) AER error handling logic currently resides
> in the AER driver file, drivers/pci/pcie/aer.c. CXL specific changes are
> conditionally compiled using #ifdefs.
> 
> Improve the AER driver maintainability by separating the RCH specific logic
> from the AER driver's core functionality and removing the ifdefs. Introduce
> drivers/pci/pcie/rch_aer.c for moving the RCH AER logic into.
> 
> Move the CXL logic into the new file but leave helper functions in aer.c
> for now as they will be moved in future patch for CXL virtual hierarchy
> handling.
> 
> 2 changes are required to maintain compilation after the move. Change
> cxl_rch_handle_error() & cxl_rch_enable_rcec() to be non-static inorder for
> accessing from the AER driver in aer.c.
> 
> Introduce CONFIG_CXL_RCH_RAS in cxl/Kconfig. Update pcie/pcie/Makefile to
> conditionally compile rch_aer.c file using CONFIG_CXL_RCH_RAS.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> ---
> Changes in v10->v11:
> - Remove changes in code-split and move to earlier, new patch
> - Add #include <linux/bitfield.h> to cxl_ras.c
> - Move cxl_rch_handle_error() & cxl_rch_enable_rcec() declarations from pci.h
> to aer.h, more localized.
> - Introduce CONFIG_CXL_RCH_RAS, includes Makefile changes, ras.c ifdef changes
> ---
>  drivers/cxl/Kconfig        |   9 +++-
>  drivers/cxl/core/ras.c     |   3 ++
>  drivers/pci/pci.h          |  20 +++++++
>  drivers/pci/pcie/Makefile  |   1 +
>  drivers/pci/pcie/aer.c     | 108 +++----------------------------------
>  drivers/pci/pcie/rch_aer.c |  99 ++++++++++++++++++++++++++++++++++

I wonder if this should be cxl_rch_aer.c to be clear that it's cxl related code. 

DJ

>  6 files changed, 138 insertions(+), 102 deletions(-)
>  create mode 100644 drivers/pci/pcie/rch_aer.c
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 1c7c8989fd8b..028201e24523 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -235,5 +235,12 @@ config CXL_MCE
>  
>  config CXL_RAS
>  	def_bool y
> -	depends on ACPI_APEI_GHES && PCIEAER_CXL
> +	depends on ACPI_APEI_GHES && PCIEAER && CXL_PCI
> +
> +config CXL_RCH_RAS
> +	bool "CXL: Restricted CXL Host (RCH) protocol error handling"
> +	def_bool n
> +	depends on CXL_RAS
> +	help
> +	  RAS support for Restricted CXL Host (RCH) defined in CXL1.1.
>  endif
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index f42f9a255ef8..c9f2f0335bfd 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -126,6 +126,9 @@ void cxl_ras_exit(void)
>  	cancel_work_sync(&cxl_cper_prot_err_work);
>  }
>  
> +static bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base);
> +static void cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base);
> +
>  #ifdef CONFIG_CXL_RCH_RAS
>  static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
>  {
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 12215ee72afb..c8a0c0ec0073 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -1159,4 +1159,24 @@ static inline int pci_msix_write_tph_tag(struct pci_dev *pdev, unsigned int inde
>  	(PCI_CONF1_ADDRESS(bus, dev, func, reg) | \
>  	 PCI_CONF1_EXT_REG(reg))
>  
> +struct aer_err_info;
> +
> +#ifdef CONFIG_CXL_RCH_RAS
> +void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info);
> +void cxl_rch_enable_rcec(struct pci_dev *rcec);
> +#else
> +static inline void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info) { }
> +static inline void cxl_rch_enable_rcec(struct pci_dev *rcec) { }
> +#endif
> +
> +#ifdef CONFIG_CXL_RAS
> +void pci_aer_unmask_internal_errors(struct pci_dev *dev);
> +bool cxl_error_is_native(struct pci_dev *dev);
> +bool is_internal_error(struct aer_err_info *info);
> +#else
> +static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
> +static inline bool cxl_error_is_native(struct pci_dev *dev) { return false; }
> +static inline bool is_internal_error(struct aer_err_info *info) { return false; }
> +#endif
> +
>  #endif /* DRIVERS_PCI_H */
> diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
> index 173829aa02e6..07c299dbcdd7 100644
> --- a/drivers/pci/pcie/Makefile
> +++ b/drivers/pci/pcie/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o bwctrl.o
>  
>  obj-y				+= aspm.o
>  obj-$(CONFIG_PCIEAER)		+= aer.o err.o tlp.o
> +obj-$(CONFIG_CXL_RCH_RAS)	+= rch_aer.o
>  obj-$(CONFIG_PCIEAER_INJECT)	+= aer_inject.o
>  obj-$(CONFIG_PCIE_PME)		+= pme.o
>  obj-$(CONFIG_PCIE_DPC)		+= dpc.o
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 7fe9f883f5c5..29de7ee861f7 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1098,7 +1098,7 @@ static bool find_source_device(struct pci_dev *parent,
>   * Note: AER must be enabled and supported by the device which must be
>   * checked in advance, e.g. with pcie_aer_is_native().
>   */
> -static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
> +void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>  {
>  	int aer = dev->aer_cap;
>  	u32 mask;
> @@ -1111,119 +1111,25 @@ static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>  	mask &= ~PCI_ERR_COR_INTERNAL;
>  	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
>  }
> +EXPORT_SYMBOL_NS_GPL(pci_aer_unmask_internal_errors, "CXL");
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
> diff --git a/drivers/pci/pcie/rch_aer.c b/drivers/pci/pcie/rch_aer.c
> new file mode 100644
> index 000000000000..bfe071eebf67
> --- /dev/null
> +++ b/drivers/pci/pcie/rch_aer.c
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


