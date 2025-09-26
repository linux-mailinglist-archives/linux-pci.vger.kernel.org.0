Return-Path: <linux-pci+bounces-37148-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 514C1BA55ED
	for <lists+linux-pci@lfdr.de>; Sat, 27 Sep 2025 00:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DC651C05448
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 22:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EB826C3B6;
	Fri, 26 Sep 2025 22:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xho4YV8N"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9C323C51D;
	Fri, 26 Sep 2025 22:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758927368; cv=none; b=YxdwU1M+mBpm+A00ePufZjFhaUgxKuRrYvumnjEgSVCNZh3JXn7eVBYgk0XUffjW7U7c9cBZSiSTGghqgC8YiE+M2jBiQIC/rtNIhmfJiYNjUakJB+INIfmUwSFCWn1OvoBGYH+2tBzG2CsxVK+JC0cmMCRblqCFCcgm4jmmHAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758927368; c=relaxed/simple;
	bh=1KarEp2nkL8Uz707BkDaeArI5woDEtlh04V1gdN3V4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DtSmOOTaEiW3nfGDGWeibkBu8KUE7u5jVMSGJM+Mj4qwr3S+Xc6aCpgsIe/dWbCoYzdfDjoqHtN0rXJemwWNLE2uW5F/S+yO9HcSspBeq0JF6CgNXZG7bDrw0wKyvwshFzJ+sXjPRH887gEjtvDQwXXzwubpIR9dgFgw9MkJVYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xho4YV8N; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758927367; x=1790463367;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1KarEp2nkL8Uz707BkDaeArI5woDEtlh04V1gdN3V4Y=;
  b=Xho4YV8N34bCpIOuZgVJTxKyOFNA9ryUazNRozQtIq2UqtTHTJB6ro46
   VAJzRTJ69nD5p1AD3koDWm/L5pz1LAO+Bb7r8dIO5Ke1Sum7jsNrYfheN
   EE+rT/upinz/L0jv0Ryghu0pw4mjpXBoYWuTo/4g1b/H3Fa2FiXicPAqe
   bag/+8VEFhaVU7ySAfIV5vb3UlO36NcwKT1kkMfeEITN+PjiHxGfrycoG
   hoRC3xpWPOoTNpGSJwiFOLUYbGODLFXU8CIpaNYJkq5Y12DxHJl9XyU44
   Mf/5Zb2sH0bQRdgH2H96/saaYfzZ4aIQbTu8yLEJvrN5iiteDOlzdfoi8
   Q==;
X-CSE-ConnectionGUID: z7z0I3TrQMq+O00ZbmJVNA==
X-CSE-MsgGUID: qoD+n+2zTG69exFklguQAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11565"; a="61375316"
X-IronPort-AV: E=Sophos;i="6.18,296,1751266800"; 
   d="scan'208";a="61375316"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 15:56:06 -0700
X-CSE-ConnectionGUID: 4FhWfwHFRUSLf3cMB7zbGQ==
X-CSE-MsgGUID: 8T7KhRgWRPuMiwYpdafpow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,296,1751266800"; 
   d="scan'208";a="201409726"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.109.69]) ([10.125.109.69])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 15:56:03 -0700
Message-ID: <f895e2c8-c060-4a11-9123-ad19a4a2ef21@intel.com>
Date: Fri, 26 Sep 2025 15:56:02 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 18/25] CXL/AER: Introduce aer_cxl_vh.c in AER driver
 for forwarding CXL errors
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
 <20250925223440.3539069-19-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250925223440.3539069-19-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/25/25 3:34 PM, Terry Bowman wrote:
> CXL virtual hierarchy (VH) RAS handling for CXL Port devices will be added
> soon. This requires a notification mechanism for the AER driver to share
> the AER interrupt with the CXL driver. The notification will be used as an
> indication for the CXL drivers to handle and log the CXL RAS errors.
> 
> Note, 'CXL protocol error' terminology will refer to CXL VH and not
> CXL RCH errors unless specifically noted going forward.
> 
> Introduce a new file in the AER driver to handle the CXL protocol errors
> named pci/pcie/aer_cxl_vh.c.
> 
> Add a kfifo work queue to be used by the AER and CXL drivers. The AER
> driver will be the sole kfifo producer adding work and the cxl_core will be
> the sole kfifo consumer removing work. Add the boilerplate kfifo support.
> Encapsulate the kfifo, RW semaphore, and work pointer in a single structure.
> 
> Add CXL work queue handler registration functions in the AER driver. Export
> the functions allowing CXL driver to access. Implement registration
> functions for the CXL driver to assign or clear the work handler function.
> Synchronize accesses using the RW semaphore.
> 
> Introduce 'struct cxl_proto_err_work_data' to serve as the kfifo work data.
> This will contain a reference to the erring PCI device and the error
> severity. This will be used when the work is dequeued by the cxl_core driver.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> 
> Changes in v11->v12:
> - Rename drivers/pci/pcie/cxl_aer.c to drivers/pci/pcie/aer_cxl_vh.c (Lukas)
> 
> Changes in v10->v11:
> - cxl_error_detected() - Change handlers' scoped_guard() to guard() (Jonathan)
> - cxl_error_detected() - Remove extra line (Shiju)
> - Changes moved to core/ras.c (Terry)
> - cxl_error_detected(), remove 'ue' and return with function call. (Jonathan)
> - Remove extra space in documentation for PCI_ERS_RESULT_PANIC definition
> - Move #include "pci.h from cxl.h to core.h (Terry)
> - Remove unnecessary includes of cxl.h and core.h in mem.c (Terry)
> ---
>  drivers/pci/pci.h             |  4 ++
>  drivers/pci/pcie/Makefile     |  1 +
>  drivers/pci/pcie/aer.c        | 25 ++-------
>  drivers/pci/pcie/aer_cxl_vh.c | 95 +++++++++++++++++++++++++++++++++++
>  include/linux/aer.h           | 17 +++++++
>  5 files changed, 121 insertions(+), 21 deletions(-)
>  create mode 100644 drivers/pci/pcie/aer_cxl_vh.c
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index f7631f40e57c..22e8f9a18a09 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -1234,8 +1234,12 @@ static inline void cxl_rch_enable_rcec(struct pci_dev *rcec) { }
>  
>  #ifdef CONFIG_CXL_RAS
>  bool is_internal_error(struct aer_err_info *info);
> +bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info);
> +void cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info);
>  #else
>  static inline bool is_internal_error(struct aer_err_info *info) { return false; }
> +static inline bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info) { return false; }
> +static inline void cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info) { }
>  #endif
>  
>  #endif /* DRIVERS_PCI_H */
> diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
> index 970e7cbc5b34..72992b3ea417 100644
> --- a/drivers/pci/pcie/Makefile
> +++ b/drivers/pci/pcie/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o bwctrl.o
>  obj-y				+= aspm.o
>  obj-$(CONFIG_PCIEAER)		+= aer.o err.o tlp.o
>  obj-$(CONFIG_CXL_RCH_RAS)	+= aer_cxl_rch.o
> +obj-$(CONFIG_CXL_RAS)		+= aer_cxl_vh.o
>  obj-$(CONFIG_PCIEAER_INJECT)	+= aer_inject.o
>  obj-$(CONFIG_PCIE_PME)		+= pme.o
>  obj-$(CONFIG_PCIE_DPC)		+= dpc.o
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 6ba8f84add70..ccefbcfe5145 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1093,8 +1093,6 @@ static bool find_source_device(struct pci_dev *parent,
>  	return true;
>  }
>  
> -#ifdef CONFIG_CXL_RAS
> -
>  /**
>   * pci_aer_unmask_internal_errors - unmask internal errors
>   * @dev: pointer to the pci_dev data structure
> @@ -1120,24 +1118,6 @@ void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(pci_aer_unmask_internal_errors);
>  
> -bool cxl_error_is_native(struct pci_dev *dev)
> -{
> -	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
> -
> -	return (pcie_ports_native || host->native_aer);
> -}
> -EXPORT_SYMBOL_NS_GPL(cxl_error_is_native, "CXL");
> -
> -bool is_internal_error(struct aer_err_info *info)
> -{
> -	if (info->severity == AER_CORRECTABLE)
> -		return info->status & PCI_ERR_COR_INTERNAL;
> -
> -	return info->status & PCI_ERR_UNC_INTN;
> -}
> -EXPORT_SYMBOL_NS_GPL(is_internal_error, "CXL");
> -#endif /* CONFIG_CXL_RAS */
> -
>  /**
>   * pci_aer_handle_error - handle logging error into an event log
>   * @dev: pointer to pci_dev data structure of error source device
> @@ -1174,7 +1154,10 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>  static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>  {
>  	cxl_rch_handle_error(dev, info);
> -	pci_aer_handle_error(dev, info);
> +	if (is_cxl_error(dev, info))
> +		cxl_forward_error(dev, info);
> +	else
> +		pci_aer_handle_error(dev, info);
>  	pci_dev_put(dev);
>  }
>  
> diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
> new file mode 100644
> index 000000000000..8c0979299446
> --- /dev/null
> +++ b/drivers/pci/pcie/aer_cxl_vh.c
> @@ -0,0 +1,95 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2025 AMD Corporation. All rights reserved. */
> +
> +#include <linux/pci.h>
> +#include <linux/aer.h>
> +#include <linux/pci.h>
> +#include <linux/bitfield.h>
> +#include <linux/kfifo.h>
> +#include "../pci.h"
> +
> +#define CXL_ERROR_SOURCES_MAX          128
> +
> +struct cxl_proto_err_kfifo {
> +	struct work_struct *work;
> +	struct rw_semaphore rw_sema;
> +	DECLARE_KFIFO(fifo, struct cxl_proto_err_work_data,
> +		      CXL_ERROR_SOURCES_MAX);
> +};
> +
> +static struct cxl_proto_err_kfifo cxl_proto_err_kfifo = {
> +	.rw_sema = __RWSEM_INITIALIZER(cxl_proto_err_kfifo.rw_sema)
> +};
> +
> +bool cxl_error_is_native(struct pci_dev *dev)
> +{
> +	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
> +
> +	return (pcie_ports_native || host->native_aer);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_error_is_native, "CXL");
> +
> +bool is_internal_error(struct aer_err_info *info)
> +{
> +	if (info->severity == AER_CORRECTABLE)
> +		return info->status & PCI_ERR_COR_INTERNAL;
> +
> +	return info->status & PCI_ERR_UNC_INTN;
> +}
> +EXPORT_SYMBOL_NS_GPL(is_internal_error, "CXL");
> +
> +bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
> +{
> +	if (!info || !info->is_cxl)
> +		return false;
> +
> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
> +		return false;
> +
> +	return is_internal_error(info);
> +}
> +EXPORT_SYMBOL_NS_GPL(is_cxl_error, "CXL");
> +
> +void cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info)
> +{
> +	struct cxl_proto_err_work_data wd = (struct cxl_proto_err_work_data) {
> +		.severity = info->severity,
> +		.pdev = pdev
> +	};
> +
> +	guard(rwsem_write)(&cxl_proto_err_kfifo.rw_sema);
> +
> +	if (!cxl_proto_err_kfifo.work) {
> +		dev_warn_once(&pdev->dev, "CXL driver is not registered for kfifo");
> +		return;
> +	}
> +
> +	if (!kfifo_put(&cxl_proto_err_kfifo.fifo, wd)) {
> +		dev_err_ratelimited(&pdev->dev, "CXL kfifo overflow\n");
> +		return;
> +	}
> +
> +	schedule_work(cxl_proto_err_kfifo.work);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_forward_error, "CXL");
> +
> +void cxl_register_proto_err_work(struct work_struct *work)
> +{
> +	guard(rwsem_write)(&cxl_proto_err_kfifo.rw_sema);
> +	cxl_proto_err_kfifo.work = work;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_register_proto_err_work, "CXL");
> +
> +void cxl_unregister_proto_err_work(void)
> +{
> +	guard(rwsem_write)(&cxl_proto_err_kfifo.rw_sema);
> +	cxl_proto_err_kfifo.work = NULL;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_unregister_proto_err_work, "CXL");
> +
> +int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd)
> +{
> +	guard(rwsem_read)(&cxl_proto_err_kfifo.rw_sema);
> +	return kfifo_get(&cxl_proto_err_kfifo.fifo, wd);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_proto_err_kfifo_get, "CXL");
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 2ef820563996..6b2c87d1b5b6 100644
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
> @@ -53,6 +54,16 @@ struct aer_capability_regs {
>  	u16 uncor_err_source;
>  };
>  
> +/**
> + * struct cxl_proto_err_work_data - Error information used in CXL error handling
> + * @severity: AER severity
> + * @pdev: PCI device detecting the error
> + */
> +struct cxl_proto_err_work_data {
> +	int severity;
> +	struct pci_dev *pdev;
> +};
> +
>  #if defined(CONFIG_PCIEAER)
>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>  int pcie_aer_is_native(struct pci_dev *dev);
> @@ -68,8 +79,14 @@ static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
>  
>  #ifdef CONFIG_CXL_RAS
>  bool cxl_error_is_native(struct pci_dev *dev);
> +int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd);
> +void cxl_register_proto_err_work(struct work_struct *work);
> +void cxl_unregister_proto_err_work(void);
>  #else
>  static inline bool cxl_error_is_native(struct pci_dev *dev) { return false; }
> +static inline int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd) { return 0; }
> +static inline void cxl_register_proto_err_work(struct work_struct *work) { }
> +static inline void cxl_unregister_proto_err_work(void) { }
>  #endif
>  
>  void pci_print_aer(struct pci_dev *dev, int aer_severity,


