Return-Path: <linux-pci+bounces-37150-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EF0BA55FD
	for <lists+linux-pci@lfdr.de>; Sat, 27 Sep 2025 01:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3287627903
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 23:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C3E283FEE;
	Fri, 26 Sep 2025 23:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nBqZK3mt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07782433AD;
	Fri, 26 Sep 2025 23:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758927744; cv=none; b=VvtNQs6TQePNVpcBAdMkLC/v48qk+NfJxnIRaY4oYmrmxa3aVnkqItnewlPlQXNMuhBQCSEl91+DqfIElbfWbu6wlUxCSCdAFW5t53Wfs/9qtV6lUKbFYcC2LGO4dOZTQgGgsK3vI688fMR5qCMx1LTE+2daGtZqEGyUSw6G4Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758927744; c=relaxed/simple;
	bh=Eyetisk6s5VHsLtg6NTy/80N0Hbeg9iRL2InhbuGKy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EYiFI12p5+7wo2oLiFdREAwVLgFW73/vQvMsJ8xlST47HbzRWWqV6tRCGE4waugJ9wgTDvSo0QvyJsQSxIf98wRBS5Tx/cnRE3rmxrIXEly3MkpKnKsLh20Q4dd1PIFXx1pxoYRnacMUG9bkvzfQygYgVYpCzJw3Dlp/P2FFrKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nBqZK3mt; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758927744; x=1790463744;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Eyetisk6s5VHsLtg6NTy/80N0Hbeg9iRL2InhbuGKy0=;
  b=nBqZK3mtZxgf73f+a1QBjRN9k4YP8SCukdON+1DdElToY9uCv+0c5yQw
   rnoYzCeW8b6YEZsBbLV+8Z+t4xeC+XRWp08BpuBYP5SpPCEtDzVNo1RB8
   VsmC8AE7IlGfYXAFRE3GpjiBIhI78qlfYXLwfogBoqwa+zS5ZaAZpmwYi
   SkMvbv8TIfDrARc+YJubqn4DUGud++IX8ZylDOIjQ5VD5bl2N4qEoRrFF
   7FS6q8QzNMWtP4zFhg5ufDRGJ3Cg6QL+NhiHchsNjK98KH3g3n7+VLKQY
   5n8ygWQ//H5IJUmjj2wDePb+E3meD3cFt7KCUenwqrA5F+mm9uj4UQano
   Q==;
X-CSE-ConnectionGUID: KVq4KO62QSidR48m3P3Ovw==
X-CSE-MsgGUID: mJsTDviIQyasfUYRV8blsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61316590"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61316590"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 16:02:23 -0700
X-CSE-ConnectionGUID: YYMcrR1kQ0SNRQMQOxpUJQ==
X-CSE-MsgGUID: X1rHzDBLQ7yCskQyl1kdjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,296,1751266800"; 
   d="scan'208";a="214860844"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.109.69]) ([10.125.109.69])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 16:02:21 -0700
Message-ID: <591729d6-eef8-4a6d-ab01-b70270e63d1f@intel.com>
Date: Fri, 26 Sep 2025 16:02:20 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 19/25] cxl: Introduce cxl_pci_drv_bound() to check for
 bound driver
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
 <20250925223440.3539069-20-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250925223440.3539069-20-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/25/25 3:34 PM, Terry Bowman wrote:
> CXL devices handle protocol errors via driver-specific callbacks rather
> than the generic pci_driver::err_handlers by default. The callbacks are
> implemented in the cxl_pci driver and are not part of struct pci_driver, so
> cxl_core must verify that a device is actually bound to the cxl_pci
> module's driver before invoking the callbacks (the device could be bound
> to another driver, e.g. VFIO).
> 
> However, cxl_core can not reference symbols in the cxl_pci module because
> it creates a circular dependency. This prevents cxl_core from checking the
> EP's bound driver and calling the callbacks.
> 
> To fix this, move drivers/cxl/pci.c into drivers/cxl/core/pci_drv.c and
> build it as part of the cxl_core module. Compile into cxl_core using
> CXL_PCI and CXL_CORE Kconfig dependencies. This removes the standalone cxl_pci
> module, consolidates the cxl_pci driver code into cxl_core, and eliminates
> the circular dependency so cxl_core can safely perform bound-driver checks
> and invoke the CXL PCI callbacks.
> 
> Introduce cxl_pci_drv_bound() to return boolean depending on if the PCI EP
> parameter is bound to a CXL driver instance. This will be used in future
> patch when dequeuing work from the kfifo.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> 
> Changes in v11 -> v12:
> - New patch
> ---
>  drivers/cxl/Kconfig                   |  6 +++---
>  drivers/cxl/Makefile                  |  2 --
>  drivers/cxl/core/Makefile             |  1 +
>  drivers/cxl/core/core.h               |  9 +++++++++
>  drivers/cxl/{pci.c => core/pci_drv.c} | 16 ++++++++--------
>  drivers/cxl/core/port.c               |  3 +++
>  6 files changed, 24 insertions(+), 13 deletions(-)
>  rename drivers/cxl/{pci.c => core/pci_drv.c} (99%)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 028201e24523..9ee76bae02d5 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -20,7 +20,7 @@ menuconfig CXL_BUS
>  if CXL_BUS
>  
>  config CXL_PCI
> -	tristate "PCI manageability"
> +	bool "PCI manageability"
>  	default CXL_BUS
>  	help
>  	  The CXL specification defines a "CXL memory device" sub-class in the
> @@ -29,12 +29,12 @@ config CXL_PCI
>  	  memory to be mapped into the system address map (Host-managed Device
>  	  Memory (HDM)).
>  
> -	  Say 'y/m' to enable a driver that will attach to CXL memory expander
> +	  Say 'y' to enable a driver that will attach to CXL memory expander
>  	  devices enumerated by the memory device class code for configuration
>  	  and management primarily via the mailbox interface. See Chapter 2.3
>  	  Type 3 CXL Device in the CXL 2.0 specification for more details.
>  
> -	  If unsure say 'm'.
> +	  If unsure say 'y'.
>  
>  config CXL_MEM_RAW_COMMANDS
>  	bool "RAW Command Interface for Memory Devices"
> diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> index 2caa90fa4bf2..ff6add88b6ae 100644
> --- a/drivers/cxl/Makefile
> +++ b/drivers/cxl/Makefile
> @@ -12,10 +12,8 @@ obj-$(CONFIG_CXL_PORT) += cxl_port.o
>  obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
>  obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
>  obj-$(CONFIG_CXL_MEM) += cxl_mem.o
> -obj-$(CONFIG_CXL_PCI) += cxl_pci.o
>  
>  cxl_port-y := port.o
>  cxl_acpi-y := acpi.o
>  cxl_pmem-y := pmem.o security.o
>  cxl_mem-y := mem.o
> -cxl_pci-y := pci.o
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index b2930cc54f8b..91f43c3f2292 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -20,3 +20,4 @@ cxl_core-$(CONFIG_CXL_MCE) += mce.o
>  cxl_core-$(CONFIG_CXL_FEATURES) += features.o
>  cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
>  cxl_core-$(CONFIG_CXL_RAS) += ras.o
> +cxl_core-$(CONFIG_CXL_PCI) += pci_drv.o
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 74c64d458f12..9ceff8acf844 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -202,4 +202,13 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>  		    u16 *return_code);
>  #endif
>  
> +#ifdef CONFIG_CXL_PCI
> +bool cxl_pci_drv_bound(struct pci_dev *pdev);
> +int cxl_pci_driver_init(void);
> +void cxl_pci_driver_exit(void);
> +#else
> +static inline bool cxl_pci_drv_bound(struct pci_dev *pdev) { return false; };
> +static inline int cxl_pci_driver_init(void) { return 0; }
> +static inline void cxl_pci_driver_exit(void) { }
> +#endif
>  #endif /* __CXL_CORE_H__ */
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/core/pci_drv.c
> similarity index 99%
> rename from drivers/cxl/pci.c
> rename to drivers/cxl/core/pci_drv.c
> index 71fb8709081e..746b5017d336 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/core/pci_drv.c
> @@ -1132,6 +1132,12 @@ static struct pci_driver cxl_pci_driver = {
>  	},
>  };
>  
> +bool cxl_pci_drv_bound(struct pci_dev *pdev)
> +{
> +	return (pdev->driver == &cxl_pci_driver);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_pci_drv_bound, "CXL");
> +
>  #define CXL_EVENT_HDR_FLAGS_REC_SEVERITY GENMASK(1, 0)
>  static void cxl_handle_cper_event(enum cxl_event_type ev_type,
>  				  struct cxl_cper_event_rec *rec)
> @@ -1178,7 +1184,7 @@ static void cxl_cper_work_fn(struct work_struct *work)
>  }
>  static DECLARE_WORK(cxl_cper_work, cxl_cper_work_fn);
>  
> -static int __init cxl_pci_driver_init(void)
> +int __init cxl_pci_driver_init(void)
>  {
>  	int rc;
>  
> @@ -1193,15 +1199,9 @@ static int __init cxl_pci_driver_init(void)
>  	return rc;
>  }
>  
> -static void __exit cxl_pci_driver_exit(void)
> +void cxl_pci_driver_exit(void)
>  {
>  	cxl_cper_unregister_work(&cxl_cper_work);
>  	cancel_work_sync(&cxl_cper_work);
>  	pci_unregister_driver(&cxl_pci_driver);
>  }
> -
> -module_init(cxl_pci_driver_init);
> -module_exit(cxl_pci_driver_exit);
> -MODULE_DESCRIPTION("CXL: PCI manageability");
> -MODULE_LICENSE("GPL v2");
> -MODULE_IMPORT_NS("CXL");
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index bd4be046888a..56fa4ac33e8b 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -2502,6 +2502,8 @@ static __init int cxl_core_init(void)
>  	if (rc)
>  		goto err_ras;
>  
> +	cxl_pci_driver_init();
> +
>  	return 0;
>  
>  err_ras:
> @@ -2517,6 +2519,7 @@ static __init int cxl_core_init(void)
>  
>  static void cxl_core_exit(void)
>  {
> +	cxl_pci_driver_exit();
>  	cxl_ras_exit();
>  	cxl_region_exit();
>  	bus_unregister(&cxl_bus_type);


