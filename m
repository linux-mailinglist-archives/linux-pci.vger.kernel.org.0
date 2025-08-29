Return-Path: <linux-pci+bounces-35074-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D18D1B3AFEC
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 02:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C9913AA874
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 00:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE51413B7A3;
	Fri, 29 Aug 2025 00:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X8oJ6Gth"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D23D1FDA;
	Fri, 29 Aug 2025 00:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756428230; cv=none; b=ZKPXaYoDKx2eOQhcKebwdkDaIDsn5XeBXtoq1IkyPqHnI+uLVPUMY4dD8EQO0G6lGJdAXMCkljp2jiuOXcgIbjfIWvhB5IU7oCtWlF1bU08/z1rcr31ZDHLop0mxmHrQ9HXFXcmWbPLxrkM/vbodUkUK1vCWQtI0crqN5+rB/EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756428230; c=relaxed/simple;
	bh=HMZc9RcsAPYD5lqXAglT75h0GVT5vN+vvUgGqJeGZ28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N38ROHZQcQ1OeeOHfgSu/Wx0R8u9ilT017a1qlDf3oXSCknhYFCJX8J/ZuF+eVk+p619TUZ649OrtaeXfUNTj91vW3sReYT6gbhaa5fnsp2ITDYd5O5Y5C7l3g3iATFxGidJvEUgXSdxs47aGApDCLvF8gd+tHcbuxXBLQpErs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X8oJ6Gth; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756428229; x=1787964229;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HMZc9RcsAPYD5lqXAglT75h0GVT5vN+vvUgGqJeGZ28=;
  b=X8oJ6Gthl9qhdX0UQAFplyKDTSdn+IgTs6Y6RYx3j49HgYRzDxfKNpHK
   rDa/nwlhebKZ75bXQLRkjMRvfRluWp6yNAUo9D8cSQ87+4gsv3Bwh9+eV
   xKzkLSOaCbrLATUrEBaVmVttdgetzMi/MCMH+hdgv5NmtSXWSIx+N5ouF
   6obBxdiBTsaLW5lpYEXITt5mc8H/OjlG5elNs5j5B8wqCU2FbcXwntAsK
   2qBAWWGe6b5x9t21WXWfhXUT20YD2HNgK3R9g1Jz3Dr3o76UlufXKbz2Y
   J5GYCplj7TvIQ36CZoS8VKLYtInF+6V8NPwaP4OtPA3QflU02FwORsUjX
   Q==;
X-CSE-ConnectionGUID: WAyW0t0jSOmqkBMfVWc2sw==
X-CSE-MsgGUID: OpKzfqiBTouKLgezUYLnSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="58775921"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="58775921"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 17:43:47 -0700
X-CSE-ConnectionGUID: rCZc4IfLQ4Gii4y1lR5HsA==
X-CSE-MsgGUID: qo8uxVKjQNC3kL6WBay3uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="174422570"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.118.49]) ([10.247.118.49])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 17:43:37 -0700
Message-ID: <2312cd83-9faa-458b-9960-72760c769101@intel.com>
Date: Thu, 28 Aug 2025 17:43:31 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 18/23] PCI/AER: Dequeue forwarded CXL error
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
 <20250827013539.903682-19-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250827013539.903682-19-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/26/25 6:35 PM, Terry Bowman wrote:
> The AER driver is now designed to forward CXL protocol errors to the CXL

I would rephrase it to:
The AER driver enqueues the CXL protocol error info to the created kfifo for the CXL driver to consume.
 
> driver. Update the CXL driver with functionality to dequeue the forwarded
> CXL error from the kfifo. Also, update the CXL driver to begin the protocol
> error handling processing using the work received from the FIFO.
> 
> Update function cxl_proto_err_work_fn() to dequeue work forwarded by the
> AER service driver. This will begin the CXL protocol error processing with
> a call to cxl_handle_proto_error().
> 
> Introduce logic to take the SBDF values from 'struct cxl_proto_error_info'
> and use in discovering the erring PCI device. The call to pci_get_domain_bus_and_slot()
> will return a reference counted 'struct pci_dev *'. This will serve as
> reference count to prevent releasing the CXL Endpoint's mapped RAS while
> handling the error. Use scope base __free() to put the reference count.
> This will change when adding support for CXL port devices in the future.
> 
> Implement cxl_handle_proto_error() to differentiate between Restricted CXL
> Host (RCH) protocol errors and CXL virtual host (VH) protocol errors.
> Maintain the existing RCH handling. Export the AER driver's pcie_walk_rcec()
> allowing the CXL driver to walk the RCEC's secondary bus.
> 
> VH correctable error (CE) processing will call the CXL CE handler. VH
> uncorrectable errors (UCE) will call cxl_do_recovery(), implemented as a
> stub for now and to be updated in future patch. Export pci_aer_clean_fatal_status()
> and pci_clean_device_status() used to clean up AER status after handling.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> ---
> Changes in v10->v11:
> - Reword patch commit message to remove RCiEP details (Jonathan)
> - Add #include <linux/bitfield.h> (Terry)
> - is_cxl_rcd() - Fix short comment message wrap  (Jonathan)
> - is_cxl_rcd() - Combine return calls into 1  (Jonathan)
> - cxl_handle_proto_error() - Move comment earlier  (Jonathan)
> - Usse FIELD_GET() in discovering class code (Jonathan)
> - Remove BDF from cxl_proto_err_work_data. Use 'struct pci_dev *' (Dan)
> ---
>  drivers/cxl/core/ras.c  | 68 ++++++++++++++++++++++++++++++++++-------
>  drivers/pci/pci.c       |  1 +
>  drivers/pci/pci.h       |  7 -----
>  drivers/pci/pcie/aer.c  |  1 +
>  drivers/pci/pcie/rcec.c |  1 +
>  include/linux/aer.h     |  2 ++
>  include/linux/pci.h     | 10 ++++++
>  7 files changed, 72 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index b285448c2d9c..a2e95c49f965 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -118,17 +118,6 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
>  }
>  static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
>  
> -int cxl_ras_init(void)
> -{
> -	return cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
> -}
> -
> -void cxl_ras_exit(void)
> -{
> -	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
> -	cancel_work_sync(&cxl_cper_prot_err_work);
> -}
> -
>  static pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base);
>  static void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base);
>  
> @@ -331,6 +320,10 @@ void cxl_endpoint_port_init_ras(struct cxl_port *ep)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_endpoint_port_init_ras, "CXL");
>  
> +static void cxl_do_recovery(struct device *dev)
> +{
> +}
> +
>  static void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>  {
>  	void __iomem *addr;
> @@ -472,3 +465,56 @@ pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
>  	return rc;
>  }
>  EXPORT_SYMBOL_NS_GPL(pci_error_detected, "CXL");
> +
> +static void cxl_handle_proto_error(struct cxl_proto_err_work_data *err_info)
> +{
> +	struct pci_dev *pdev = err_info->pdev;
> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);

So this function is called from the workqueue thread to consume data from the kfifo right? Do we need to take the device lock of the pdev to ensure that a driver is bound to the device before we attempt to retrieve the data? And do we also need to verify that the driver bound is the cxl_pci driver (and not something like vfio_pci)? Otherwise I think assuming the drv data is cxl_dev_state may cause crash.

DJ

> +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> +	struct device *host_dev __free(put_device) = get_device(&cxlmd->dev);
> +> +	if (err_info->severity == AER_CORRECTABLE) {
> +		int aer = pdev->aer_cap;
> +
> +		if (aer)
> +			pci_clear_and_set_config_dword(pdev,
> +						       aer + PCI_ERR_COR_STATUS,
> +						       0, PCI_ERR_COR_INTERNAL);
> +
> +		cxl_cor_error_detected(&cxlmd->dev);
> +
> +		pcie_clear_device_status(pdev);
> +	} else {
> +		cxl_do_recovery(&cxlmd->dev);
> +	}
> +}
> +
> +static void cxl_proto_err_work_fn(struct work_struct *work)
> +{
> +	struct cxl_proto_err_work_data wd;
> +
> +	while (cxl_proto_err_kfifo_get(&wd))
> +		cxl_handle_proto_error(&wd);
> +}
> +
> +static struct work_struct cxl_proto_err_work;
> +static DECLARE_WORK(cxl_proto_err_work, cxl_proto_err_work_fn);
> +
> +int cxl_ras_init(void)
> +{
> +	if (cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work))
> +		pr_err("Failed to initialize CXL RAS CPER\n");
> +
> +	cxl_register_proto_err_work(&cxl_proto_err_work);
> +
> +	return 0;
> +}
> +
> +void cxl_ras_exit(void)
> +{
> +	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
> +	cancel_work_sync(&cxl_cper_prot_err_work);
> +
> +	cxl_unregister_proto_err_work();
> +	cancel_work_sync(&cxl_proto_err_work);
> +}
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d775ed37a79b..2c9827690cb3 100644
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
> index cfa75903dd3f..69ff7c2d214f 100644
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
> index 627d89ccea9c..45abe1622316 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -288,6 +288,7 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
>  	if (status)
>  		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);
>  }
> +EXPORT_SYMBOL_GPL(pci_aer_clear_fatal_status);
>  
>  /**
>   * pci_aer_raw_clear_status - Clear AER error registers.
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
> index f8eb32805957..1f79f0be4bf7 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -66,12 +66,14 @@ struct cxl_proto_err_work_data {
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
> index 3dcab36c437f..3407d687459d 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1804,6 +1804,9 @@ extern bool pcie_ports_native;
>  
>  int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
>  			  bool use_lt);
> +void pcie_walk_rcec(struct pci_dev *rcec,
> +		    int (*cb)(struct pci_dev *, void *),
> +		    void *userdata);
>  #else
>  #define pcie_ports_disabled	true
>  #define pcie_ports_native	false
> @@ -1814,8 +1817,15 @@ static inline int pcie_set_target_speed(struct pci_dev *port,
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


