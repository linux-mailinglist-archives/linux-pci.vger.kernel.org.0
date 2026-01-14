Return-Path: <linux-pci+bounces-44881-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5378AD21C6E
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 00:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AAB1301E909
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 23:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404613939B2;
	Wed, 14 Jan 2026 23:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iy8axRq2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D74357A4B;
	Wed, 14 Jan 2026 23:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768433853; cv=none; b=lMT3TPuMnaNpx1MNl8OY4EWah4xhwR0rzZ2qxQC37AFwZIK8YcdvtazLAt1kg3tEdjTlGPlrDXELTCaRhzdtRqwtn5i5PiBREWNss22lDRypPRlduATTaysSqyQav+sdDjSDYuco2h6OCz/s7dE8v8s+wPjKFTMsksB6uAR/zmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768433853; c=relaxed/simple;
	bh=8rKgazMg6X6TubKtgDbIoRE4vCEadhzJlomYGOarwZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U568VutIEgwFPWIhDBJC4hVHBOtyYDQro4Tuik3P9uRRd/oVBeFeBVLUWClKNen99qM2pD1FiJKRiP2gQfiPZIO5TOhcb1OtVbZCnJAEQL8TD7WewGqH81vALZrJkhqtOGtz9AKhheHNynsILOr/t18ZXsUSGXMqN8+1rgASk78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iy8axRq2; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768433840; x=1799969840;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8rKgazMg6X6TubKtgDbIoRE4vCEadhzJlomYGOarwZQ=;
  b=Iy8axRq24FwdinFp9R+7YvKzKXFp3rRyyGez1pj+45Kz3RaWs+mYY/M9
   yRoHGG1df8se9VcXgvR6jc6TlQMzKowXedHeSp/gs4ouwMnOlKzZvypsj
   KFH3+gShJZFR+n8bg2e7l4UWU6XajSWermLv9rcB1MKhQn4IobLM7N26J
   EPzl0YRC5yZvRsyu7grM0qvryxKSfb7AG1hYRAMA0ENvoEgX4zeX1/HbU
   AFbOP6YHIs9k/f4xI7LJIVs4ES6asWhep7ZhxToFx69YZ8qiNpCvy5c3z
   /E5A4AJx9XEqcUKWNwgK1yEbOqvxJJHc7UZOGtkvmChMBojYkN0PUXEp+
   w==;
X-CSE-ConnectionGUID: zSWzrmC0Tl2raRaohynr0A==
X-CSE-MsgGUID: EuRvp/c1RK+ucSXUYxlR2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="81188409"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="81188409"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 15:37:13 -0800
X-CSE-ConnectionGUID: jstB4ndnT3uG4yqGdlPdOg==
X-CSE-MsgGUID: Qn7+jVzKRtu+8mVlGmdSLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="203947086"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.111.5]) ([10.125.111.5])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 15:37:12 -0800
Message-ID: <e3fd4ada-bcbe-4d7c-9ffe-4518b68292be@intel.com>
Date: Wed, 14 Jan 2026 16:37:11 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 31/34] PCI: Introduce CXL Port protocol error handlers
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
 <20260114182055.46029-32-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260114182055.46029-32-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/14/26 11:20 AM, Terry Bowman wrote:
> Add CXL protocol error handlers for CXL Port devices (Root Ports,
> Downstream Ports, and Upstream Ports). Implement cxl_port_cor_error_detected()
> and cxl_port_error_detected() to handle correctable and uncorrectable errors
> respectively.
> 
> Introduce cxl_get_ras_base() to retrieve the cached RAS register base
> address for a given CXL port. This function supports CXL Root Ports,
> Downstream Ports, Upstream Ports, and Endpoints by returning their
> previously mapped RAS register addresses.
> 
> Update the AER driver's is_cxl_error() to recognize CXL Port devices in
> addition to CXL Endpoints, as both now have CXL-specific error handlers.
> 
> Future patch(es) will include port error handling changes to support
> Endpoint protocol errors.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> > ---
> 
> Changes in v13->v14:
> - Add Dave Jiang's review-by

Doesn't look like that happened?

> - Update commit message & headline (Bjorn)
> - Refactor cxl_port_error_detected()/cxl_port_cor_error_detected() to
>   one line (Jonathan)
> - Remove cxl_walk_port() (Dan)
> - Remove cxl_pci_drv_bound(). Check for 'is_cxl' parent port is
>   sufficient (Dan)
> - Remove device_lock_if()
> - Combined CE and UCE here (Terry)
> 
> Changes in v12->v13:
> - Move get_pci_cxl_host_dev() and cxl_handle_proto_error() to Dequeue
>   patch (Terry)
> - Remove EP case in cxl_get_ras_base(), not used. (Terry)
> - Remove check for dport->dport_dev (Dave)
> - Remove whitespace (Terry)
> 
> Changes in v11->v12:
> - Add call to cxl_pci_drv_bound() in cxl_handle_proto_error() and
>   pci_to_cxl_dev()
> - Change cxl_error_detected() -> cxl_cor_error_detected()
> - Remove NULL variable assignments
> - Replace bus_find_device() with find_cxl_port_by_uport() for upstream
>   port searches.
> 
> Changes in v10->v11:
> - None
> ---
>  drivers/cxl/core/ras.c        | 101 +++++++++++++++++++++++++++++++++-
>  drivers/pci/pci.c             |   1 +
>  drivers/pci/pci.h             |   2 -
>  drivers/pci/pcie/aer.c        |   1 +
>  drivers/pci/pcie/aer_cxl_vh.c |   5 +-
>  include/linux/aer.h           |   2 +
>  include/linux/pci.h           |   2 +
>  7 files changed, 109 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 0c640b84ad70..96ce85cc0a46 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -200,6 +200,67 @@ static struct cxl_port *get_cxl_port(struct pci_dev *pdev)
>  	return NULL;
>  }
>  
> +static void __iomem *cxl_get_ras_base(struct device *dev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_ROOT_PORT:
> +	case PCI_EXP_TYPE_DOWNSTREAM:
> +	{
> +		struct cxl_dport *dport;
> +		struct cxl_port *port __free(put_cxl_port) = find_cxl_port(&pdev->dev, &dport);
> +
> +		if (!dport) {
> +			pci_err(pdev, "Failed to find the CXL device");
> +			return NULL;
> +		}
> +		return dport->regs.ras;
> +	}
> +	case PCI_EXP_TYPE_UPSTREAM:
> +	{
> +		struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_uport(&pdev->dev);
> +
> +		if (!port) {
> +			pci_err(pdev, "Failed to find the CXL device");
> +			return NULL;
> +		}
> +		return port->regs.ras;
> +	}
> +	}
> +	dev_warn_once(dev, "Error: Unsupported device type (%#x)", pci_pcie_type(pdev));
> +	return NULL;
> +}
> +
> +static pci_ers_result_t cxl_port_error_detected(struct device *dev);
> +
> +static void cxl_do_recovery(struct pci_dev *pdev)
> +{
> +	struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
To minimize errors, move this line to right above when you check !port. It's acceptable to do inline declaration when it comes cleanup macros. 

DJ
> +	pci_ers_result_t status;
> +
> +	if (!port) {
> +		pci_err(pdev, "Failed to find the CXL device\n");
> +		return;
> +	}
> +
> +	status = cxl_port_error_detected(&pdev->dev);
> +	if (status == PCI_ERS_RESULT_PANIC)
> +		panic("CXL cachemem error.");
> +
> +	/*
> +	 * If we have native control of AER, clear error status in the device
> +	 * that detected the error.  If the platform retained control of AER,
> +	 * it is responsible for clearing this status.  In that case, the
> +	 * signaling device may not even be visible to the OS.
> +	 */
> +	if (pcie_aer_is_native(pdev)) {
> +		pcie_clear_device_status(pdev);
> +		pci_aer_clear_nonfatal_status(pdev);
> +		pci_aer_clear_fatal_status(pdev);
> +	}
> +}
> +
>  void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>  {
>  	void __iomem *addr;
> @@ -214,7 +275,10 @@ void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>  		return;
>  	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
>  
> -	trace_cxl_aer_correctable_error(dev, status, serial);
> +	if (is_cxl_memdev(dev))
> +		trace_cxl_aer_correctable_error(dev, status, serial);
> +	else
> +		trace_cxl_port_aer_correctable_error(dev, status);
>  }
>  
>  /* CXL spec rev3.0 8.2.4.16.1 */
> @@ -265,12 +329,27 @@ bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>  	}
>  
>  	header_log_copy(ras_base, hl);
> -	trace_cxl_aer_uncorrectable_error(dev, status, fe, hl, serial);
> +
> +	if (is_cxl_memdev(dev))
> +		trace_cxl_aer_uncorrectable_error(dev, status, fe, hl, serial);
> +	else
> +		trace_cxl_port_aer_uncorrectable_error(dev, status, fe, hl);
> +
>  	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>  
>  	return true;
>  }
>  
> +static void cxl_port_cor_error_detected(struct device *dev)
> +{
> +	cxl_handle_cor_ras(dev, 0, cxl_get_ras_base(dev));
> +}
> +
> +static pci_ers_result_t cxl_port_error_detected(struct device *dev)
> +{
> +	return cxl_handle_ras(dev, 0, cxl_get_ras_base(dev));
> +}
> +
>  void cxl_cor_error_detected(struct pci_dev *pdev)
>  {
>  	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> @@ -346,6 +425,24 @@ EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
>  
>  static void cxl_handle_proto_error(struct cxl_proto_err_work_data *err_info)
>  {
> +	struct pci_dev *pdev = err_info->pdev;
> +
> +	if (err_info->severity == AER_CORRECTABLE) {
> +
> +		if (!pcie_aer_is_native(pdev))
> +			return;
> +
> +		if (pdev->aer_cap)
> +			pci_clear_and_set_config_dword(pdev,
> +						       pdev->aer_cap + PCI_ERR_COR_STATUS,
> +						       0, PCI_ERR_COR_INTERNAL);
> +
> +		cxl_port_cor_error_detected(&pdev->dev);
> +
> +		pcie_clear_device_status(pdev);
> +	} else {
> +		cxl_do_recovery(pdev);
> +	}
>  }
>  
>  static void cxl_proto_err_work_fn(struct work_struct *work)
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 13dbb405dc31..b7bfefdaf990 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2248,6 +2248,7 @@ void pcie_clear_device_status(struct pci_dev *dev)
>  	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
>  	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
>  }
> +EXPORT_SYMBOL_GPL(pcie_clear_device_status);
>  #endif
>  
>  /**
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index dbc547db208a..8bb703524f52 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -229,7 +229,6 @@ void pci_refresh_power_state(struct pci_dev *dev);
>  int pci_power_up(struct pci_dev *dev);
>  void pci_disable_enabled_device(struct pci_dev *dev);
>  int pci_finish_runtime_suspend(struct pci_dev *dev);
> -void pcie_clear_device_status(struct pci_dev *dev);
>  void pcie_clear_root_pme_status(struct pci_dev *dev);
>  bool pci_check_pme_status(struct pci_dev *dev);
>  void pci_pme_wakeup_bus(struct pci_bus *bus);
> @@ -1196,7 +1195,6 @@ void pci_restore_aer_state(struct pci_dev *dev);
>  static inline void pci_no_aer(void) { }
>  static inline void pci_aer_init(struct pci_dev *d) { }
>  static inline void pci_aer_exit(struct pci_dev *d) { }
> -static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
>  static inline int pci_aer_clear_status(struct pci_dev *dev) { return -EINVAL; }
>  static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
>  static inline void pci_save_aer_state(struct pci_dev *dev) { }
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index c2030d32a19c..dd7c49651612 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -298,6 +298,7 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
>  	if (status)
>  		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);
>  }
> +EXPORT_SYMBOL_GPL(pci_aer_clear_fatal_status);
>  
>  /**
>   * pci_aer_raw_clear_status - Clear AER error registers.
> diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
> index 0f616f5fafcf..aa69e504302f 100644
> --- a/drivers/pci/pcie/aer_cxl_vh.c
> +++ b/drivers/pci/pcie/aer_cxl_vh.c
> @@ -34,7 +34,10 @@ bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
>  	if (!info || !info->is_cxl)
>  		return false;
>  
> -	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
> +	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT) &&
> +	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT) &&
> +	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_UPSTREAM) &&
> +	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM))
>  		return false;
>  
>  	return is_aer_internal_error(info);
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index f351e41dd979..c1aef7859d0a 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -65,6 +65,7 @@ struct cxl_proto_err_work_data {
>  
>  #if defined(CONFIG_PCIEAER)
>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
> +void pci_aer_clear_fatal_status(struct pci_dev *dev);
>  int pcie_aer_is_native(struct pci_dev *dev);
>  void pci_aer_unmask_internal_errors(struct pci_dev *dev);
>  #else
> @@ -72,6 +73,7 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>  {
>  	return -EINVAL;
>  }
> +static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>  static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
>  #endif
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index ee05d5925b13..1ef4743bf151 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1921,8 +1921,10 @@ static inline void pci_hp_unignore_link_change(struct pci_dev *pdev) { }
>  
>  #ifdef CONFIG_PCIEAER
>  bool pci_aer_available(void);
> +void pcie_clear_device_status(struct pci_dev *dev);
>  #else
>  static inline bool pci_aer_available(void) { return false; }
> +static inline void pcie_clear_device_status(struct pci_dev *dev) { }
>  #endif
>  
>  bool pci_ats_disabled(void);


