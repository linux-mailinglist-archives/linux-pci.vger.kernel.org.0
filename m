Return-Path: <linux-pci+bounces-30878-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DC8AEAAC7
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 01:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A388B1C4160D
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 23:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7952264A4;
	Thu, 26 Jun 2025 23:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NTSAqt2R"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECD321B185;
	Thu, 26 Jun 2025 23:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750981334; cv=none; b=iCjFsL0oL2Y7W0rfi03SXAFTR3+/rxdrpFulYc+e4L5vdqft0xWo8SyjGMwi5LuvALtUiWmtcHNdU7dUOUfZsa+cApofX0ZWlv4/AJViSI5teIKh4gD1YpW5eaaPcFtoGOYwg0vLXvgFjjw715MSG3CnC7NPSf7nQqqZNPgkMs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750981334; c=relaxed/simple;
	bh=20ENUKKaDhBTcuSnX7PmINtzXdNnRUJdtMRJtu470JM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D1VJvPF8BJR+nSzcvUK7VHKo3JmxR1R/F9jcKeu5nCVTkPa2a2zU0peGNqXnc2lHsmhaYAY+4XVR2IqTmIrGcPELr9u19DAb2KFPwTwnkvxDegjzmB8epd9Xv2wg9Cysz4h8tBFENENxxhD1ZBlNWr3od3TDYPS75efNeJ1OCc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NTSAqt2R; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750981333; x=1782517333;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=20ENUKKaDhBTcuSnX7PmINtzXdNnRUJdtMRJtu470JM=;
  b=NTSAqt2RPMNKaNiQrb+aW9olh4f/slux+COl7ixwMGvRFkm6OqrqdiKI
   +u71ETl6Bol3L8lpOFP47ZBnk8Px4P5RkHOaW65T1qNjnjMMMaxb4h9WG
   JMUIk3vLFVudwpQPVFP+LdVH9RKvMTuj5ydFSYPx/fm4G2xeJf8JcWIgS
   tQagVKmavZHALBbB2oR2XvCDP8V3pbCwEapX83NUXLEYMNteqtooOa6Bl
   qvO8eeQUxEljvIeBY3oWHzOu/g0/5xnudg7AsykADsmwSp3OoX+FSLCJc
   WXAK7g3yg3uezjppLugH9/32cCdjAymor20+uMYV9QIf15+kesBQM4IuC
   A==;
X-CSE-ConnectionGUID: joLh5jZiR0q2glvKjv80hw==
X-CSE-MsgGUID: ck0LQyFFR9K6bAruwQdHmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="53257953"
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="53257953"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 16:42:12 -0700
X-CSE-ConnectionGUID: twthP8X7RPemcSyZIMFBSA==
X-CSE-MsgGUID: buXNv0jRRn2jGOY36Dm6dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="153368384"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 16:42:10 -0700
Received: from [10.124.220.215] (unknown [10.124.220.215])
	by linux.intel.com (Postfix) with ESMTP id 7106420B5736;
	Thu, 26 Jun 2025 16:42:09 -0700 (PDT)
Message-ID: <214c9b73-6e62-40c0-a805-56127269941a@linux.intel.com>
Date: Thu, 26 Jun 2025 16:42:09 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 04/17] CXL/AER: Introduce CXL specific AER driver file
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, dan.j.williams@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com, linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-5-terry.bowman@amd.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250626224252.1415009-5-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/26/25 3:42 PM, Terry Bowman wrote:
> The CXL AER error handling logic currently resides in the AER driver file,
> drivers/pci/pcie/aer.c. CXL specific changes are conditionally compiled
> using #ifdefs.
>
> Improve the AER driver maintainability by separating the CXL specific logic
> from the AER driver's core functionality and removing the #ifdefs.
> Introduce drivers/pci/pcie/cxl_aer.c and move the CXL AER logic into the
> new file.
>
> Update the makefile to conditionally compile the CXL file using the
> existing CONFIG_PCIEAER_CXL Kconfig.
>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---

After moving the code , you seem to have updated it with your own
changes. May be you split it into two patches.

>   drivers/pci/pci.h          |   8 +++
>   drivers/pci/pcie/Makefile  |   1 +
>   drivers/pci/pcie/aer.c     | 138 -------------------------------------
>   drivers/pci/pcie/cxl_aer.c | 138 +++++++++++++++++++++++++++++++++++++
>   include/linux/pci_ids.h    |   2 +
>   5 files changed, 149 insertions(+), 138 deletions(-)
>   create mode 100644 drivers/pci/pcie/cxl_aer.c
>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index a0d1e59b5666..91b583cf18eb 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -1029,6 +1029,14 @@ static inline void pci_save_aer_state(struct pci_dev *dev) { }
>   static inline void pci_restore_aer_state(struct pci_dev *dev) { }
>   #endif
>   
> +#ifdef CONFIG_PCIEAER_CXL
> +void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info);
> +void cxl_rch_enable_rcec(struct pci_dev *rcec);
> +#else
> +static inline void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info) { }
> +static inline void cxl_rch_enable_rcec(struct pci_dev *rcec) { }
> +#endif
> +
>   #ifdef CONFIG_ACPI
>   bool pci_acpi_preserve_config(struct pci_host_bridge *bridge);
>   int pci_acpi_program_hp_params(struct pci_dev *dev);
> diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
> index 173829aa02e6..cd2cb925dbd5 100644
> --- a/drivers/pci/pcie/Makefile
> +++ b/drivers/pci/pcie/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o bwctrl.o
>   
>   obj-y				+= aspm.o
>   obj-$(CONFIG_PCIEAER)		+= aer.o err.o tlp.o
> +obj-$(CONFIG_PCIEAER_CXL)	+= cxl_aer.o
>   obj-$(CONFIG_PCIEAER_INJECT)	+= aer_inject.o
>   obj-$(CONFIG_PCIE_PME)		+= pme.o
>   obj-$(CONFIG_PCIE_DPC)		+= dpc.o
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index a2df9456595a..0b4d721980ef 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1094,144 +1094,6 @@ static bool find_source_device(struct pci_dev *parent,
>   	return true;
>   }
>   
> -#ifdef CONFIG_PCIEAER_CXL
> -
> -/**
> - * pci_aer_unmask_internal_errors - unmask internal errors
> - * @dev: pointer to the pci_dev data structure
> - *
> - * Unmask internal errors in the Uncorrectable and Correctable Error
> - * Mask registers.
> - *
> - * Note: AER must be enabled and supported by the device which must be
> - * checked in advance, e.g. with pcie_aer_is_native().
> - */
> -static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
> -{
> -	int aer = dev->aer_cap;
> -	u32 mask;
> -
> -	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, &mask);
> -	mask &= ~PCI_ERR_UNC_INTN;
> -	pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, mask);
> -
> -	pci_read_config_dword(dev, aer + PCI_ERR_COR_MASK, &mask);
> -	mask &= ~PCI_ERR_COR_INTERNAL;
> -	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
> -}
> -
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
> -{
> -	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
> -
> -	return (pcie_ports_native || host->native_aer);
> -}
> -
> -static bool is_internal_error(struct aer_err_info *info)
> -{
> -	if (info->severity == AER_CORRECTABLE)
> -		return info->status & PCI_ERR_COR_INTERNAL;
> -
> -	return info->status & PCI_ERR_UNC_INTN;
> -}
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
>   
>   /**
>    * pci_aer_handle_error - handle logging error into an event log
> diff --git a/drivers/pci/pcie/cxl_aer.c b/drivers/pci/pcie/cxl_aer.c
> new file mode 100644
> index 000000000000..b2ea14f70055
> --- /dev/null
> +++ b/drivers/pci/pcie/cxl_aer.c
> @@ -0,0 +1,138 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2025 AMD Corporation. All rights reserved. */
> +
> +#include <linux/pci.h>
> +#include <linux/aer.h>
> +#include "../pci.h"
> +
> +/**
> + * pci_aer_unmask_internal_errors - unmask internal errors
> + * @dev: pointer to the pci_dev data structure
> + *
> + * Unmask internal errors in the Uncorrectable and Correctable Error
> + * Mask registers.
> + *
> + * Note: AER must be enabled and supported by the device which must be
> + * checked in advance, e.g. with pcie_aer_is_native().
> + */
> +static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
> +{
> +	int aer = dev->aer_cap;
> +	u32 mask;
> +
> +	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, &mask);
> +	mask &= ~PCI_ERR_UNC_INTN;
> +	pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, mask);
> +
> +	pci_read_config_dword(dev, aer + PCI_ERR_COR_MASK, &mask);
> +	mask &= ~PCI_ERR_COR_INTERNAL;
> +	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
> +}
> +
> +static bool is_cxl_mem_dev(struct pci_dev *dev)
> +{
> +	/*
> +	 * The capability, status, and control fields in Device 0,
> +	 * Function 0 DVSEC control the CXL functionality of the
> +	 * entire device (CXL 3.2, 8.1.3).
> +	 */
> +	if (dev->devfn != PCI_DEVFN(0, 0))
> +		return false;
> +
> +	/*
> +	 * CXL Memory Devices must have the 502h class code set (CXL
> +	 * 3.2, 8.1.12.1).
> +	 */
> +	if (FIELD_GET(PCI_CLASS_CODE_MASK, dev->class) != PCI_CLASS_MEMORY_CXL)
> +		return false;
> +
> +	return true;
> +}
> +
> +static bool cxl_error_is_native(struct pci_dev *dev)
> +{
> +	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
> +
> +	return (pcie_ports_native || host->native_aer);
> +}
> +
> +static bool is_internal_error(struct aer_err_info *info)
> +{
> +	if (info->severity == AER_CORRECTABLE)
> +		return info->status & PCI_ERR_COR_INTERNAL;
> +
> +	return info->status & PCI_ERR_UNC_INTN;
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
> +
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index e2d71b6fdd84..31b3935bf189 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -12,6 +12,8 @@
>   
>   /* Device classes and subclasses */
>   
> +#define PCI_CLASS_CODE_MASK             0xFFFF00
> +
>   #define PCI_CLASS_NOT_DEFINED		0x0000
>   #define PCI_CLASS_NOT_DEFINED_VGA	0x0001
>   

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


