Return-Path: <linux-pci+bounces-37145-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF5BBA549B
	for <lists+linux-pci@lfdr.de>; Sat, 27 Sep 2025 00:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EA5D62858E
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 22:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D12275AE1;
	Fri, 26 Sep 2025 22:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DwUWlGUJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97221EA7EC;
	Fri, 26 Sep 2025 22:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758924296; cv=none; b=OSuWTF90HPQLa7GzBiyNZpKDyBpgMO+wBorED+yexUvwtgB2Y2R73YCeM6l08ubEbCrI8BMSO9Y54tzApsd8l+XVhXQmCtFQfxVyMhCU9+6RF/VQLfgtVVNp02UXayi2mLk1oPp+AypIXxEN3IGHKxPscw2VgIk+tRrQOk4zEhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758924296; c=relaxed/simple;
	bh=iChzTYBRg7LwBhlljIu9DrgmCDInscnIZ0h7DSQ/6eU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aS64JoWV8FS5aiTuWTlhA/2XrpLZ6y/0e9y2Ur+bYWvrktdvKC4NaMZdfIScbNDz9/3aI4X7U5bnOVPnidtGSxAtXwdpSpF8cgyh3J71vKuYWZQ8p+DiAvBR4tCO2lTb78bK33rPKBnFXT7d0J9UbP6A4ZIYfdCVbGWSjqdQw+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DwUWlGUJ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758924294; x=1790460294;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iChzTYBRg7LwBhlljIu9DrgmCDInscnIZ0h7DSQ/6eU=;
  b=DwUWlGUJZo4yzghI/jJT3CYifkWh8BRs231wB/+VFCAKFo6frgH/c5ZU
   ZgvVmvAMmjIvcyO+BKgsC4kpquhSijbsYN0DrxCsx9LMnEBgtTiRdXGn3
   pkt28qHNnRFBtsCkGkhYa0GwefcyrPwMhc0Z7fz0a2rdI+p4iYCyHrD05
   QsM93mku/cDZvzdyQLtHwBtB6LRPWLlWLvaHJLtdATP5k8jPxTfx+J2Ez
   11MG1tnWqWsa4ejyiwzrDwEvvm/agqCXOGom9+mXoIGs+miuMJszNWC0A
   Wq6wjUOiScrkTQygYoIzrQjXF9D1IDHOvNfcu27KXM7QZBIcYT9Pumw21
   w==;
X-CSE-ConnectionGUID: S83n9HQuQ4+Lf6YLSmI/MA==
X-CSE-MsgGUID: EFKCVLc+RianP5NT7PSjiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11565"; a="61430595"
X-IronPort-AV: E=Sophos;i="6.18,296,1751266800"; 
   d="scan'208";a="61430595"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 15:04:53 -0700
X-CSE-ConnectionGUID: iwyVSgFVSW6LP5x66o6DCw==
X-CSE-MsgGUID: 25bAP5EUSSWKpQSxajt+dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,296,1751266800"; 
   d="scan'208";a="177772816"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.109.69]) ([10.125.109.69])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 15:04:52 -0700
Message-ID: <beecc304-f201-4fa2-b2a7-810c82668be2@intel.com>
Date: Fri, 26 Sep 2025 15:04:51 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 17/25] cxl/pci: Introduce CXL Endpoint protocol error
 handlers
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
 <20250925223440.3539069-18-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250925223440.3539069-18-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/25/25 3:34 PM, Terry Bowman wrote:
> CXL Endpoint protocol errors are currently handled using PCI error
> handlers. The CXL Endpoint requires CXL specific handling in the case of
> uncorrectable error (UCE) handling not provided by the PCI handlers.
> 
> Add CXL specific handlers for CXL Endpoints. Rename the existing
> cxl_error_handlers to be pci_error_handlers to more correctly indicate
> the error type and follow naming consistency.
> 
> The PCI handlers will be called if the CXL device is not trained for
> alternate protocol (CXL). Update the CXL Endpoint PCI handlers to call the
> CXL UCE handlers.
> 
> The existing EP UCE handler includes checks for various results. These are
> no longer needed because CXL UCE recovery will not be attempted. Implement
> cxl_handle_ras() to return PCI_ERS_RESULT_NONE or PCI_ERS_RESULT_PANIC. The
> CXL UCE handler is called by cxl_do_recovery() that acts on the return
> value. In the case of the PCI handler path, call panic() if the result is
> PCI_ERS_RESULT_PANIC.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> ---
> 
> Changes in v11->v12:
> - None
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
>  drivers/cxl/core/core.h |  17 +++++++
>  drivers/cxl/core/ras.c  | 110 +++++++++++++++++++---------------------
>  drivers/cxl/cxlpci.h    |  15 ------
>  drivers/cxl/pci.c       |   9 ++--
>  4 files changed, 75 insertions(+), 76 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 8c51a2631716..74c64d458f12 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -6,6 +6,7 @@
>  
>  #include <cxl/mailbox.h>
>  #include <linux/rwsem.h>
> +#include <linux/pci.h>
>  
>  extern const struct device_type cxl_nvdimm_bridge_type;
>  extern const struct device_type cxl_nvdimm_type;
> @@ -150,6 +151,11 @@ void cxl_ras_exit(void);
>  void cxl_switch_port_init_ras(struct cxl_port *port);
>  void cxl_endpoint_port_init_ras(struct cxl_port *ep);
>  void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
> +pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
> +				    pci_channel_state_t error);
> +void pci_cor_error_detected(struct pci_dev *pdev);
> +void cxl_cor_error_detected(struct device *dev);
> +pci_ers_result_t cxl_error_detected(struct device *dev);
>  #else
>  static inline int cxl_ras_init(void)
>  {
> @@ -163,6 +169,17 @@ static inline void cxl_switch_port_init_ras(struct cxl_port *port) { }
>  static inline void cxl_endpoint_port_init_ras(struct cxl_port *ep) { }
>  static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
>  						struct device *host) { }
> +static inline pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
> +						  pci_channel_state_t error)
> +{
> +	return PCI_ERS_RESULT_NONE;
> +}
> +static inline void pci_cor_error_detected(struct pci_dev *pdev) { }
> +static inline void cxl_cor_error_detected(struct device *dev) { }
> +static inline pci_ers_result_t cxl_error_detected(struct device *dev)
> +{
> +	return PCI_ERS_RESULT_NONE;
> +}
>  #endif // CONFIG_CXL_RAS
>  
>  int cxl_gpf_port_setup(struct cxl_dport *dport);
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 14a434bd68f0..39472d82d586 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -129,7 +129,7 @@ void cxl_ras_exit(void)
>  }
>  
>  static void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base);
> -static bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base);
> +static pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base);
>  
>  #ifdef CONFIG_CXL_RCH_RAS
>  static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
> @@ -371,7 +371,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>   * Log the state of the RAS status registers and prepare them to log the
>   * next error status. Return 1 if reset needed.
>   */
> -static bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
> +static pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>  {
>  	u32 hl[CXL_HEADERLOG_SIZE_U32];
>  	void __iomem *addr;
> @@ -380,13 +380,13 @@ static bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_bas
>  
>  	if (!ras_base) {
>  		dev_warn_once(dev, "CXL RAS register block is not mapped");
> -		return false;
> +		return PCI_ERS_RESULT_NONE;
>  	}
>  
>  	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
>  	status = readl(addr);
>  	if (!(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK))
> -		return false;
> +		return PCI_ERS_RESULT_NONE;
>  
>  	/* If multiple errors, log header points to first error from ctrl reg */
>  	if (hweight32(status) > 1) {
> @@ -403,76 +403,72 @@ static bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_bas
>  	trace_cxl_aer_uncorrectable_error(dev, status, fe, hl, serial);
>  	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>  
> -	return true;
> +	return PCI_ERS_RESULT_PANIC;
>  }
>  
> -void cxl_cor_error_detected(struct pci_dev *pdev)
> +void cxl_cor_error_detected(struct device *dev)

Why change the input parameter to 'struct device' to just convert it back in the first parameter? I understand that later on cxl_handle_proto_error() will pass in a 'dev', but since it's going to be a pci_dev anyways, can you just pass in a pci_dev instead of doing all this back and forth?

>  {
> +	struct pci_dev *pdev = to_pci_dev(dev);
>  	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> -	struct device *dev = &cxlds->cxlmd->dev;
> +	struct device *cxlmd_dev = &cxlds->cxlmd->dev;
>  
> -	scoped_guard(device, dev) {
> -		if (!dev->driver) {
> -			dev_warn(&pdev->dev,
> -				 "%s: memdev disabled, abort error handling\n",
> -				 dev_name(dev));
> -			return;
> -		}
> +	guard(device)(cxlmd_dev);
>  
> -		if (cxlds->rcd)
> -			cxl_handle_rdport_errors(cxlds);
> -
> -		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
> +	if (!cxlmd_dev->driver) {
> +		dev_warn(&pdev->dev, "%s: memdev disabled, abort error handling", dev_name(dev));
> +		return;
>  	}
> +
> +	if (cxlds->rcd)
> +		cxl_handle_rdport_errors(cxlds);
> +
> +	cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
>  
> -pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
> -				    pci_channel_state_t state)
> +void pci_cor_error_detected(struct pci_dev *pdev)
>  {
> +	cxl_cor_error_detected(&pdev->dev);
> +}
> +EXPORT_SYMBOL_NS_GPL(pci_cor_error_detected, "CXL");
> +
> +pci_ers_result_t cxl_error_detected(struct device *dev)

Same comment as above.

DJ

> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
>  	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> -	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> -	struct device *dev = &cxlmd->dev;
> -	bool ue;
> +	struct device *cxlmd_dev = &cxlds->cxlmd->dev;
>  
> -	scoped_guard(device, dev) {
> -		if (!dev->driver) {
> -			dev_warn(&pdev->dev,
> -				 "%s: memdev disabled, abort error handling\n",
> -				 dev_name(dev));
> -			return PCI_ERS_RESULT_DISCONNECT;
> -		}
> +	guard(device)(cxlmd_dev);
>  
> -		if (cxlds->rcd)
> -			cxl_handle_rdport_errors(cxlds);
> -		/*
> -		 * A frozen channel indicates an impending reset which is fatal to
> -		 * CXL.mem operation, and will likely crash the system. On the off
> -		 * chance the situation is recoverable dump the status of the RAS
> -		 * capability registers and bounce the active state of the memdev.
> -		 */
> -		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
> -	}
> -
> -
> -	switch (state) {
> -	case pci_channel_io_normal:
> -		if (ue) {
> -			device_release_driver(dev);
> -			return PCI_ERS_RESULT_NEED_RESET;
> -		}
> -		return PCI_ERS_RESULT_CAN_RECOVER;
> -	case pci_channel_io_frozen:
> +	if (!dev->driver) {
>  		dev_warn(&pdev->dev,
> -			 "%s: frozen state error detected, disable CXL.mem\n",
> +			 "%s: memdev disabled, abort error handling\n",
>  			 dev_name(dev));
> -		device_release_driver(dev);
> -		return PCI_ERS_RESULT_NEED_RESET;
> -	case pci_channel_io_perm_failure:
> -		dev_warn(&pdev->dev,
> -			 "failure state error detected, request disconnect\n");
>  		return PCI_ERS_RESULT_DISCONNECT;
>  	}
> -	return PCI_ERS_RESULT_NEED_RESET;
> +
> +	if (cxlds->rcd)
> +		cxl_handle_rdport_errors(cxlds);
> +
> +	/*
> +	 * A frozen channel indicates an impending reset which is fatal to
> +	 * CXL.mem operation, and will likely crash the system. On the off
> +	 * chance the situation is recoverable dump the status of the RAS
> +	 * capability registers and bounce the active state of the memdev.
> +	 */
> +	return cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
> +
> +pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
> +				    pci_channel_state_t error)
> +{
> +	pci_ers_result_t rc;
> +
> +	rc = cxl_error_detected(&pdev->dev);
> +	if (rc == PCI_ERS_RESULT_PANIC)
> +		panic("CXL cachemem error.");
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(pci_error_detected, "CXL");
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 3882a089ae77..189cd8fabc2c 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -77,19 +77,4 @@ static inline bool cxl_pci_flit_256(struct pci_dev *pdev)
>  int devm_cxl_port_enumerate_dports(struct cxl_port *port);
>  struct cxl_dev_state;
>  void read_cdat_data(struct cxl_port *port);
> -
> -#ifdef CONFIG_CXL_RAS
> -void cxl_cor_error_detected(struct pci_dev *pdev);
> -pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
> -				    pci_channel_state_t state);
> -#else
> -static inline void cxl_cor_error_detected(struct pci_dev *pdev) { }
> -
> -static inline pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
> -						  pci_channel_state_t state)
> -{
> -	return PCI_ERS_RESULT_NONE;
> -}
> -#endif
> -
>  #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index bd95be1f3d5c..71fb8709081e 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -16,6 +16,7 @@
>  #include "cxlpci.h"
>  #include "cxl.h"
>  #include "pmu.h"
> +#include "core/core.h"
>  
>  /**
>   * DOC: cxl pci
> @@ -1112,11 +1113,11 @@ static void cxl_reset_done(struct pci_dev *pdev)
>  	}
>  }
>  
> -static const struct pci_error_handlers cxl_error_handlers = {
> -	.error_detected	= cxl_error_detected,
> +static const struct pci_error_handlers pci_error_handlers = {
> +	.error_detected	= pci_error_detected,
>  	.slot_reset	= cxl_slot_reset,
>  	.resume		= cxl_error_resume,
> -	.cor_error_detected	= cxl_cor_error_detected,
> +	.cor_error_detected	= pci_cor_error_detected,
>  	.reset_done	= cxl_reset_done,
>  };
>  
> @@ -1124,7 +1125,7 @@ static struct pci_driver cxl_pci_driver = {
>  	.name			= KBUILD_MODNAME,
>  	.id_table		= cxl_mem_pci_tbl,
>  	.probe			= cxl_pci_probe,
> -	.err_handler		= &cxl_error_handlers,
> +	.err_handler		= &pci_error_handlers,
>  	.dev_groups		= cxl_rcd_groups,
>  	.driver	= {
>  		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,


