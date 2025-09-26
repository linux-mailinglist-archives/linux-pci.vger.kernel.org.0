Return-Path: <linux-pci+bounces-37151-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 758BBBA561B
	for <lists+linux-pci@lfdr.de>; Sat, 27 Sep 2025 01:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 887291B23C82
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 23:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CD02BE024;
	Fri, 26 Sep 2025 23:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QZR6x4T8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DBE8834;
	Fri, 26 Sep 2025 23:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758929216; cv=none; b=kb2ynRZdDSEMtSt2B6p2Y6Xn+s4w0Y8hSduMQX1QOhfAEd4pn8gYWRtUYclnkuTsibIiWORqhgzKsTvuoJK0QsWVo81SCzsSi6qRSkspL5qgBWq+FQ131BBuhLz1rr/CAoROS+Swxffizp2tc43eaqjXuwMeLdV2GqhmxIArfGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758929216; c=relaxed/simple;
	bh=pJeIjqGBwe+U7kx0K3qcjUZt2mpDEceDRMGQq8WSAAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ni23oCCI/Ayh3+2zzwZb5oJLbumOs+De5WtyzTvD933Tp20EXkwu6aD/T1BkBP9sL12yoJOB/Se4B6YNzNqq/T+vWGEpx8FZ/Q9Oj4aUo9W6MrV5//yB8X8nxXFRjv0a4MsD+TbO86nKdazypgb5oFkU+VGxcjiAvJQs15Uf3cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QZR6x4T8; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758929214; x=1790465214;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pJeIjqGBwe+U7kx0K3qcjUZt2mpDEceDRMGQq8WSAAI=;
  b=QZR6x4T8hchMhWQZauUXQu3YJADzJMSpzBIFGKFhe4pwxLB/ws97D8AU
   hLUNMjNAvY7G+zLrBk70GoJt8jYBwXtxmTuyPFEJuwK0by7ru3ZQzzGCY
   o7DmhloNk3Zk6NMmlHR58T5Ir7NZpiWbtRchjbTyAHqbEdJuLeEkVYo6r
   Cf1DBnV82tOdxXxsjt74/q5UezcQfkaUYLsgaO5yCJICP7SzwVpoDe4TG
   d8dTVJXwlOORfR2Q33OY3MOcgFSCHvIZ4MEj36/3ygHXpvfg1QnRXLoyh
   xEp0OHSFbW9uFYqD94LKvHjOI8YZiqx6n3heQLalpLhXKS3LqI4fg0rP5
   Q==;
X-CSE-ConnectionGUID: jzqc9fX4SrmT948YfpU0ag==
X-CSE-MsgGUID: NWoxRKKfTMmy+6DIpCzvgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11565"; a="60303571"
X-IronPort-AV: E=Sophos;i="6.18,296,1751266800"; 
   d="scan'208";a="60303571"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 16:26:53 -0700
X-CSE-ConnectionGUID: 5ic3nTkeSFe3NlSdTZpRbQ==
X-CSE-MsgGUID: CCDPoB8nSI+r90I5QBd41w==
X-ExtLoop1: 1
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.109.69]) ([10.125.109.69])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 16:26:50 -0700
Message-ID: <f028d71d-0f0c-49e4-a90d-57176fcb7d45@intel.com>
Date: Fri, 26 Sep 2025 16:26:49 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 20/25] PCI/AER: Dequeue forwarded CXL error
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
 <20250925223440.3539069-21-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250925223440.3539069-21-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/25/25 3:34 PM, Terry Bowman wrote:
> The AER driver is now designed to forward CXL protocol errors to the CXL
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
> Changes in v11->v12:
> - Add guard for CE case in cxl_handle_proto_error() (Dave)
> 
> Changes in v10->v11:
> - Reword patch commit message to remove RCiEP details (Jonathan)
> - Add #include <linux/bitfield.h> (Terry)
> - is_cxl_rcd() - Fix short comment message wrap  (Jonathan)
> - is_cxl_rcd() - Combine return calls into 1  (Jonathan)
> - cxl_handle_proto_error() - Move comment earlier  (Jonathan)
> - Usse FIELD_GET() in discovering class code (Jonathan)
> - Remove BDF from cxl_proto_err_work_data. Use 'struct
> pci_dev *' (Dan)
> ---
>  drivers/cxl/core/ras.c  | 72 ++++++++++++++++++++++++++++++++++-------
>  drivers/pci/pci.c       |  1 +
>  drivers/pci/pci.h       |  7 ----
>  drivers/pci/pcie/aer.c  |  1 +
>  drivers/pci/pcie/rcec.c |  1 +
>  include/linux/aer.h     |  2 ++
>  include/linux/pci.h     |  9 ++++++
>  7 files changed, 75 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 39472d82d586..9acfe24ba3bb 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -117,17 +117,6 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
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
>  static void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base);
>  static pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base);
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
> @@ -472,3 +465,60 @@ pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
>  	return rc;
>  }
>  EXPORT_SYMBOL_NS_GPL(pci_error_detected, "CXL");
> +
> +static void cxl_handle_proto_error(struct cxl_proto_err_work_data *err_info)
> +{
> +	struct pci_dev *pdev = err_info->pdev;
> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);

The pci_dev device lock needs to be held and cxl_pci_drv_bound() needs to be checked before this is called.

> +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> +	struct device *host_dev __free(put_device) = get_device(&cxlmd->dev);
> +
> +	if (err_info->severity == AER_CORRECTABLE) {
> +		int aer = pdev->aer_cap;
> +
> +		guard(device)(&pdev->dev);
> +
> +		if (aer)
> +			pci_clear_and_set_config_dword(pdev,
> +						       aer + PCI_ERR_COR_STATUS,
> +						       0, PCI_ERR_COR_INTERNAL);
> +
> +		if (!cxl_pci_drv_bound(pdev))
> +			return;
> +
> +		cxl_cor_error_detected(&cxlmd->dev);
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
> index 1a4f61caa0db..c8f17233a18e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2328,6 +2328,7 @@ void pcie_clear_device_status(struct pci_dev *dev)
>  	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
>  	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
>  }
> +EXPORT_SYMBOL_NS_GPL(pcie_clear_device_status, "CXL");
>  #endif>  
>  /**
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 22e8f9a18a09..189b22ab2b1b 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -692,16 +692,10 @@ static inline bool pci_dpc_recovered(struct pci_dev *pdev) { return false; }
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
> @@ -1081,7 +1075,6 @@ void pci_restore_aer_state(struct pci_dev *dev);
>  static inline void pci_no_aer(void) { }
>  static inline void pci_aer_init(struct pci_dev *d) { }
>  static inline void pci_aer_exit(struct pci_dev *d) { }
> -static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
>  static inline int pci_aer_clear_status(struct pci_dev *dev) { return -EINVAL; }
>  static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
>  static inline void pci_save_aer_state(struct pci_dev *dev) { }
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index ccefbcfe5145..e018531f5982 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -288,6 +288,7 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
>  	if (status)
>  		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);
>  }
> +EXPORT_SYMBOL_GPL(pci_aer_clear_fatal_status);

Not seeing this being used anywhee. Should this go to a different patch?

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

Not seeing this being used in this patch either.

DJ

>  
>  void pci_rcec_init(struct pci_dev *dev)
>  {
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 6b2c87d1b5b6..64aef69fb546 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -66,6 +66,7 @@ struct cxl_proto_err_work_data {
>  
>  #if defined(CONFIG_PCIEAER)
>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
> +void pci_aer_clear_fatal_status(struct pci_dev *dev);
>  int pcie_aer_is_native(struct pci_dev *dev);
>  void pci_aer_unmask_internal_errors(struct pci_dev *dev);
>  #else
> @@ -73,6 +74,7 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>  {
>  	return -EINVAL;
>  }
> +static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>  static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
>  #endif
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index bc3a7b6d0f94..b8e36bde346c 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1825,6 +1825,9 @@ extern bool pcie_ports_native;
>  
>  int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
>  			  bool use_lt);
> +void pcie_walk_rcec(struct pci_dev *rcec,
> +		    int (*cb)(struct pci_dev *, void *),
> +		    void *userdata);
>  #else
>  #define pcie_ports_disabled	true
>  #define pcie_ports_native	false
> @@ -1835,8 +1838,14 @@ static inline int pcie_set_target_speed(struct pci_dev *port,
>  {
>  	return -EOPNOTSUPP;
>  }
> +
> +static inline void pcie_walk_rcec(struct pci_dev *rcec,
> +				  int (*cb)(struct pci_dev *, void *),
> +				  void *userdata) { }
>  #endif
>  
> +void pcie_clear_device_status(struct pci_dev *dev);
> +
>  #define PCIE_LINK_STATE_L0S		(BIT(0) | BIT(1)) /* Upstr/dwnstr L0s */
>  #define PCIE_LINK_STATE_L1		BIT(2)	/* L1 state */
>  #define PCIE_LINK_STATE_L1_1		BIT(3)	/* ASPM L1.1 state */


