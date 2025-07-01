Return-Path: <linux-pci+bounces-31210-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D309AF06C4
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 01:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAE4D4A249A
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 23:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F0126E6EA;
	Tue,  1 Jul 2025 23:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XuUPTyKl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302CB26D4C2;
	Tue,  1 Jul 2025 23:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751411092; cv=none; b=P/JhwH4MX6YGHf4k//FVhSKfY6g3UHqi6KL/fMUMqZIc+Kjy/qQLSNuGuqHc3fwj1g+CnpFWquxECjZsp8LRFRtqpc+bd/m9ROYfx1be4i5Iqf3A04/2gFLJpPsnoVm1vMFs52rWnaytV3pTLG7Gq4Pjj6ncmNTWJtTNF5m6/MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751411092; c=relaxed/simple;
	bh=QfTS1vdT3WO7A8PVB/BFUwf6s7tcj1RfzXEg+ONwomE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jJVJHo/d+LKv6DreeRlrzTd5JFXc9m4daFujW+rrKaLpouUThsQcM2vmzAIzapfUjb0XFU8IfnX+oTBVaupnVHxygTgPHbHloQVrIo0RDtAIG+E2pl5x6cWBcim+N1qqfDz03iAP8BzcjZjMDdzbtT1s6nIMJRdm2jpyP1Y+G30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XuUPTyKl; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751411090; x=1782947090;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QfTS1vdT3WO7A8PVB/BFUwf6s7tcj1RfzXEg+ONwomE=;
  b=XuUPTyKlJurTzO2FBlxcVNITf8hsvde1JuxfXwuVbTMwB0ZSmmYZBovK
   Gxku3C4detLfV07vffgdSeiSOIsJmCeGe8d5D/Z0UWeX7v5dQ1SfaGpmV
   soAiqzR1tEL7y5fvoVk3yuXrlmJpg/PSXZ4D6q0KWx7eoVOtHIphhSJSW
   2+P4f6hAIwE9Wqgqo8wCVmZpF1P1WPOvLm0Mpih+3VzZI8mlI19bEaRvn
   GKJUVdinBB+UhyxfqSBZ5nlgZ34m/CaE4d176l+/d9N3dZ7FCyeO38V7Z
   WDkDYtlwoUnjURrupNpvDCl7ks4Wq4gXO8+HI1Manrc/TqUslKbJaObGo
   w==;
X-CSE-ConnectionGUID: leHMBWFATnGaXhv04szNvQ==
X-CSE-MsgGUID: OjJ1uqTIQ4CZrt2SsWChlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="53836692"
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; 
   d="scan'208";a="53836692"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 16:04:49 -0700
X-CSE-ConnectionGUID: qNp2ulYzR0igfCeU51rmAg==
X-CSE-MsgGUID: FSYposqrTXOZuPzqEBnTNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; 
   d="scan'208";a="184943101"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.109.179]) ([10.125.109.179])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 16:04:48 -0700
Message-ID: <8d0949db-fa5d-4e8a-a904-61cb78ccb176@intel.com>
Date: Tue, 1 Jul 2025 16:04:47 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 06/17] PCI/AER: Dequeue forwarded CXL error
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
 <20250626224252.1415009-7-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250626224252.1415009-7-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/26/25 3:42 PM, Terry Bowman wrote:
> The AER driver is now designed to forward CXL protocol errors to the CXL
> driver. Update the CXL driver with functionality to dequeue the forwarded
> CXL error from the kfifo. Also, update the CXL driver to begin the protocol
> error handling processing using the work received from the FIFO.
> 
> Introduce function cxl_proto_err_work_fn() to dequeue work forwarded by the
> AER service driver. This will begin the CXL protocol error processing with
> a call to cxl_handle_proto_error().
> 
> Update cxl/core/native_ras.c by adding cxl_rch_handle_error_iter() that was
> previously in the AER driver. Add check that Endpoint is bound to a CXL
> driver.
> 
> Introduce logic to take the SBDF values from 'struct cxl_proto_error_info'
> and use in discovering the erring PCI device. The call to pci_get_domain_bus_and_slot()
> will return a reference counted 'struct pci_dev *'. This will serve as
> reference count to prevent releasing the CXL Endpoint's mapped RAS while
> handling the error. Use scope base __free() to put the reference count.
> This will change when adding support for CXL port devices in the future.
> 
> Implement cxl_handle_proto_error() to differentiate between Restricted CXL
> Host (RCH) protocol errors and CXL virtual host (VH) protocol errors. RCH
> errors will be processed with a call to walk the associated Root Complex
> Event Collector's (RCEC) secondary bus looking for the Root Complex
> Integrated Endpoint (RCiEP) to handle the RCH error. Export pcie_walk_rcec()
> so the CXL driver can walk the RCEC's downstream bus, searching for the
> RCiEP.
> 
> VH correctable error (CE) processing will call the CXL CE handler. VH
> uncorrectable errors (UCE) will call cxl_do_recovery(), implemented as a
> stub for now and to be updated in future patch. Export pci_aer_clean_fatal_status()
> and pci_clean_device_status() used to clean up AER status after handling.
> 
> Maintain the locking logic found in the original AER driver. Replace the
> existing device_lock() in cxl_rch_handle_error_iter() to use guard(device)
> lock for maintainability. CE errors did not include locking in previous driver
> implementation. Leave the updated CE handling path as-is.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Couple minor comments below. Otherwise
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/native_ras.c | 87 +++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlpci.h          |  1 +
>  drivers/cxl/pci.c             |  6 +++
>  drivers/pci/pci.c             |  1 +
>  drivers/pci/pci.h             |  7 ---
>  drivers/pci/pcie/aer.c        |  1 +
>  drivers/pci/pcie/cxl_aer.c    | 41 -----------------
>  drivers/pci/pcie/rcec.c       |  1 +
>  include/linux/aer.h           |  2 +
>  include/linux/pci.h           | 10 ++++
>  10 files changed, 109 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/cxl/core/native_ras.c b/drivers/cxl/core/native_ras.c
> index 011815ddaae3..5bd79d5019e7 100644
> --- a/drivers/cxl/core/native_ras.c
> +++ b/drivers/cxl/core/native_ras.c
> @@ -6,9 +6,96 @@
>  #include <cxl/event.h>
>  #include <cxlmem.h>
>  #include <core/core.h>
> +#include <cxlpci.h>
> +
> +static void cxl_do_recovery(struct pci_dev *pdev)
> +{
> +}
> +
> +static bool is_cxl_rcd(struct pci_dev *pdev)
> +{
> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END)
> +		return false;
> +
> +	/*
> +	 * The capability, status, and control fields in Device 0,
> +	 * Function 0 DVSEC control the CXL functionality of the
> +	 * entire device (CXL 3.2, 8.1.3).
> +	 */
> +	if (pdev->devfn != PCI_DEVFN(0, 0))
> +		return false;
> +
> +	/*
> +	 * CXL Memory Devices must have the 502h class code set (CXL
> +	 * 3.2, 8.1.12.1).
> +	 */
> +	if (FIELD_GET(PCI_CLASS_CODE_MASK, pdev->class) != PCI_CLASS_MEMORY_CXL)
> +		return false;
> +
> +	return true;

return FIELD_GET(PCI_CLASS_CODE_MASK, pdev->class) == PCI_CLASS_MEMORY_CXL;

> +}
> +
> +static int cxl_rch_handle_error_iter(struct pci_dev *pdev, void *data)
> +{
> +	struct cxl_proto_error_info *err_info = data;
> +
> +	guard(device)(&pdev->dev);
> +
> +	if (!is_cxl_rcd(pdev) || !cxl_pci_drv_bound(pdev))
> +		return 0;
> +
> +	if (err_info->severity == AER_CORRECTABLE)
> +		cxl_cor_error_detected(pdev);
> +	else
> +		cxl_error_detected(pdev, pci_channel_io_frozen);
> +
> +	return 1;
> +}
> +
> +static void cxl_handle_proto_error(struct cxl_proto_error_info *err_info)
> +{
> +	struct pci_dev *pdev __free(pci_dev_put) =
> +		pci_get_domain_bus_and_slot(err_info->segment,
> +					    err_info->bus,
> +					    err_info->devfn);
> +
> +	if (!pdev) {
> +		pr_err("Failed to find the CXL device (SBDF=%x:%x:%x:%x)\n",
> +		       err_info->segment, err_info->bus, PCI_SLOT(err_info->devfn),
> +		       PCI_FUNC(err_info->devfn));
> +		return;
> +	}
> +
> +	/*
> +	 * Internal errors of an RCEC indicate an AER error in an
> +	 * RCH's downstream port. Check and handle them in the CXL.mem
> +	 * device driver.
> +	 */
> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_EC)
> +		return pcie_walk_rcec(pdev, cxl_rch_handle_error_iter, err_info);
> +
> +	if (err_info->severity == AER_CORRECTABLE) {
> +		int aer = pdev->aer_cap;
> +
> +		if (aer)
> +			pci_clear_and_set_config_dword(pdev,
> +						       aer + PCI_ERR_COR_STATUS,
> +						       0, PCI_ERR_COR_INTERNAL);
> +
> +		cxl_cor_error_detected(pdev);
> +
> +		pcie_clear_device_status(pdev);
> +	} else {
> +		cxl_do_recovery(pdev);
> +	}
> +}
>  
>  static void cxl_proto_err_work_fn(struct work_struct *work)
>  {
> +	struct cxl_proto_err_work_data wd;
> +
> +	while (cxl_proto_err_kfifo_get(&wd))
> +		cxl_handle_proto_error(&wd.err_info);
>  }
>  
>  static struct work_struct cxl_proto_err_work;
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 6f1396ef7b77..ed3c9701b79f 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -136,4 +136,5 @@ void read_cdat_data(struct cxl_port *port);
>  void cxl_cor_error_detected(struct pci_dev *pdev);
>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  				    pci_channel_state_t state);
> +bool cxl_pci_drv_bound(struct pci_dev *pdev);
>  #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index bd100ac31672..cae049f9ae3e 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1131,6 +1131,12 @@ static struct pci_driver cxl_pci_driver = {
>  	},
>  };
>  
> +bool cxl_pci_drv_bound(struct pci_dev *pdev)
> +{
> +	return (pdev->driver == &cxl_pci_driver);

Maybe () not needed?

DJ

> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_pci_drv_bound, "CXL");
> +
>  #define CXL_EVENT_HDR_FLAGS_REC_SEVERITY GENMASK(1, 0)
>  static void cxl_handle_cper_event(enum cxl_event_type ev_type,
>  				  struct cxl_cper_event_rec *rec)
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e9448d55113b..8d78d882bf78 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2328,6 +2328,7 @@ void pcie_clear_device_status(struct pci_dev *dev)
>  	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
>  	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
>  }
> +EXPORT_SYMBOL_NS_GPL(pcie_clear_device_status, "CXL");
>  #endif
>  
>  /**
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 29c11c7136d3..c7fc86d93bea 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -671,16 +671,10 @@ static inline bool pci_dpc_recovered(struct pci_dev *pdev) { return false; }
>  void pci_rcec_init(struct pci_dev *dev);
>  void pci_rcec_exit(struct pci_dev *dev);
>  void pcie_link_rcec(struct pci_dev *rcec);
> -void pcie_walk_rcec(struct pci_dev *rcec,
> -		    int (*cb)(struct pci_dev *, void *),
> -		    void *userdata);
>  #else
>  static inline void pci_rcec_init(struct pci_dev *dev) { }
>  static inline void pci_rcec_exit(struct pci_dev *dev) { }
>  static inline void pcie_link_rcec(struct pci_dev *rcec) { }
> -static inline void pcie_walk_rcec(struct pci_dev *rcec,
> -				  int (*cb)(struct pci_dev *, void *),
> -				  void *userdata) { }
>  #endif
>  
>  #ifdef CONFIG_PCI_ATS
> @@ -1022,7 +1016,6 @@ void pci_restore_aer_state(struct pci_dev *dev);
>  static inline void pci_no_aer(void) { }
>  static inline void pci_aer_init(struct pci_dev *d) { }
>  static inline void pci_aer_exit(struct pci_dev *d) { }
> -static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
>  static inline int pci_aer_clear_status(struct pci_dev *dev) { return -EINVAL; }
>  static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
>  static inline void pci_save_aer_state(struct pci_dev *dev) { }
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 8417a49c71f2..5999d90dfdcb 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -287,6 +287,7 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
>  	if (status)
>  		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);
>  }
> +EXPORT_SYMBOL_GPL(pci_aer_clear_fatal_status);
>  
>  /**
>   * pci_aer_raw_clear_status - Clear AER error registers.
> diff --git a/drivers/pci/pcie/cxl_aer.c b/drivers/pci/pcie/cxl_aer.c
> index 846ab55d747c..939438a7161a 100644
> --- a/drivers/pci/pcie/cxl_aer.c
> +++ b/drivers/pci/pcie/cxl_aer.c
> @@ -80,47 +80,6 @@ bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
>  	return is_internal_error(info);
>  }
>  
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
> -void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
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
>  static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
>  {
>  	bool *handles_cxl = data;
> diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c
> index d0bcd141ac9c..fb6cf6449a1d 100644
> --- a/drivers/pci/pcie/rcec.c
> +++ b/drivers/pci/pcie/rcec.c
> @@ -145,6 +145,7 @@ void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct pci_dev *, void *),
>  
>  	walk_rcec(walk_rcec_helper, &rcec_data);
>  }
> +EXPORT_SYMBOL_NS_GPL(pcie_walk_rcec, "CXL");
>  
>  void pci_rcec_init(struct pci_dev *dev)
>  {
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 24c3d9e18ad5..0aafcc678e45 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -76,12 +76,14 @@ struct cxl_proto_err_work_data {
>  
>  #if defined(CONFIG_PCIEAER)
>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
> +void pci_aer_clear_fatal_status(struct pci_dev *dev);
>  int pcie_aer_is_native(struct pci_dev *dev);
>  #else
>  static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>  {
>  	return -EINVAL;
>  }
> +static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>  #endif
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 79878243b681..79326358f641 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1801,6 +1801,9 @@ extern bool pcie_ports_native;
>  
>  int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
>  			  bool use_lt);
> +void pcie_walk_rcec(struct pci_dev *rcec,
> +		    int (*cb)(struct pci_dev *, void *),
> +		    void *userdata);
>  #else
>  #define pcie_ports_disabled	true
>  #define pcie_ports_native	false
> @@ -1811,8 +1814,15 @@ static inline int pcie_set_target_speed(struct pci_dev *port,
>  {
>  	return -EOPNOTSUPP;
>  }
> +
> +static inline void pcie_walk_rcec(struct pci_dev *rcec,
> +				  int (*cb)(struct pci_dev *, void *),
> +				  void *userdata) { }
> +
>  #endif
>  
> +void pcie_clear_device_status(struct pci_dev *dev);
> +
>  #define PCIE_LINK_STATE_L0S		(BIT(0) | BIT(1)) /* Upstr/dwnstr L0s */
>  #define PCIE_LINK_STATE_L1		BIT(2)	/* L1 state */
>  #define PCIE_LINK_STATE_L1_1		BIT(3)	/* ASPM L1.1 state */


