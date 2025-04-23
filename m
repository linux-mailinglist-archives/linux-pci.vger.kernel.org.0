Return-Path: <linux-pci+bounces-26549-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D436FA98FAD
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 17:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4329917785E
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 15:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28BF28B504;
	Wed, 23 Apr 2025 15:04:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D5C28B4EA;
	Wed, 23 Apr 2025 15:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420671; cv=none; b=tWMdu4lhAnXUhxdTltqBiU/gvGFG21OWbi903OE3/cYvEehHLeyY/oDqL8Z0CqUQkwaKAcw6mIVf170lI6gASk7tqQPmuQxrKfxIOsV2Bh3PNtgzrY6Sx6vuuFMNrdbhTLrcGWgYmeLNL7hcajL+CxIJ9Z5RYEGOcoFQYWlvBA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420671; c=relaxed/simple;
	bh=9+dU8d6BECW527yMCJHvmyeubm1e25s0P7ApBYeztVU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JDBpbEhTfMzG4AlaWpPSvhvYSvSFvFD6koDHICtMmdbVmcD2Df2UEBxXFKjxF3UIkJct7JRqJRy/T5XDXci43hJUQGAVY6UYysEqsVQ9voYxXzWCL39xaHfN5KjhUltb8ZH+fyLOr/dmR4BYiec3t42bpruI2ivKS8wy+oU1dBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZjMjB4DbTz6M4l3;
	Wed, 23 Apr 2025 23:00:14 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 2DE911402ED;
	Wed, 23 Apr 2025 23:04:24 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 23 Apr
 2025 17:04:23 +0200
Date: Wed, 23 Apr 2025 16:04:21 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>, <ming.li@zohomail.com>,
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH v8 03/16] CXL/AER: Introduce Kfifo for forwarding CXL
 errors
Message-ID: <20250423160421.000063cf@huawei.com>
In-Reply-To: <20250327014717.2988633-4-terry.bowman@amd.com>
References: <20250327014717.2988633-1-terry.bowman@amd.com>
	<20250327014717.2988633-4-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 26 Mar 2025 20:47:04 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> CXL error handling will soon be moved from the AER driver into the CXL
> driver. This requires a notification mechanism for the AER driver to share
> the AER interrupt details with CXL driver. The notification is required for
> the CXL drivers to then handle CXL RAS errors.
> 
> Add a kfifo work queue to be used by the AER driver and CXL driver. The AER
> driver will be the sole kfifo producer adding work. The cxl_core will be
> the sole kfifo consumer removing work. Add the boilerplate kfifo support.
> 
> Add CXL work queue handler registration functions in the AER driver. Export
> the functions allowing CXL driver to access. Implement the registration
> functions for the CXL driver to assign or clear the work handler function.
> 
> Create a work queue handler function, cxl_prot_err_work_fn(), as a stub for
> now. The CXL specific handling will be added in future patch.
> 
> Introduce 'struct cxl_prot_err_info'. This structure caches CXL error
> details used in completing error handling. This avoid duplicating some
> function calls and allows the error to be treated generically when
> possible.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

It's been a while since I messed around with work queues, but
don't we need to initialize the work_struct somewhere?

DECLARE_WORK() probably similar to cxl_cper_prot_err_work.

Having both the pointer and the instance of the work struct called
cxl_prot_err_work is confusing me...


> ---
>  drivers/cxl/core/ras.c | 54 +++++++++++++++++++++++++++++++++++++++++-
>  drivers/cxl/cxlpci.h   |  3 +++
>  drivers/pci/pcie/aer.c | 39 ++++++++++++++++++++++++++++++
>  include/linux/aer.h    | 37 +++++++++++++++++++++++++++++
>  4 files changed, 132 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 485a831695c7..ecb60a5962de 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -5,6 +5,7 @@
>  #include <linux/aer.h>
>  #include <cxl/event.h>
>  #include <cxlmem.h>
> +#include <cxlpci.h>
>  #include "trace.h"
>  
>  static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
> @@ -107,13 +108,64 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
>  }
>  static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
>  
> +int cxl_create_prot_err_info(struct pci_dev *_pdev, int severity,
> +			     struct cxl_prot_error_info *err_info)
> +{
> +	struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(_pdev);
> +	struct cxl_dev_state *cxlds;
> +
> +	if (!pdev || !err_info) {
> +		pr_warn_once("Error: parameter is NULL");
> +		return -ENODEV;
> +	}
> +
> +	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT) &&
> +	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END)) {
> +		pci_warn_once(pdev, "Error: Unsupported device type (%X)", pci_pcie_type(pdev));
> +		return -ENODEV;
> +	}
> +
> +	cxlds = pci_get_drvdata(pdev);
> +	struct device *dev __free(put_device) = get_device(&cxlds->cxlmd->dev);
> +
> +	if (!dev)
> +		return -ENODEV;
> +
> +	*err_info = (struct cxl_prot_error_info){ 0 };
> +	err_info->ras_base = cxlds->regs.ras;
> +	err_info->severity = severity;
> +	err_info->pdev = pdev;
> +	err_info->dev = dev;
> +
> +	return 0;
> +}
> +
> +struct work_struct cxl_prot_err_work;

This is the one I'm not seeing initialized anywhere...

> +
>  int cxl_ras_init(void)
>  {
> -	return cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
> +	int rc;
> +
> +	rc = cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
> +	if (rc) {
> +		pr_err("Failed to register CPER kfifo with AER driver");
> +		return rc;
> +	}
> +
> +	rc = cxl_register_prot_err_work(&cxl_prot_err_work, cxl_create_prot_err_info);
> +	if (rc) {
> +		pr_err("Failed to register kfifo with AER driver");
> +		return rc;
> +	}
> +
> +	return rc;
>  }
>  
>  void cxl_ras_exit(void)
>  {
>  	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
>  	cancel_work_sync(&cxl_cper_prot_err_work);
> +
> +	cxl_unregister_prot_err_work();
> +	cancel_work_sync(&cxl_prot_err_work);
>  }
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 54e219b0049e..92d72c0423ab 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -4,6 +4,7 @@
>  #define __CXL_PCI_H__
>  #include <linux/pci.h>
>  #include "cxl.h"
> +#include "linux/aer.h"
>  
>  #define CXL_MEMORY_PROGIF	0x10
>  
> @@ -135,4 +136,6 @@ void read_cdat_data(struct cxl_port *port);
>  void cxl_cor_error_detected(struct pci_dev *pdev);
>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  				    pci_channel_state_t state);
> +int cxl_create_prot_err_info(struct pci_dev *_pdev, int severity,
> +			     struct cxl_prot_error_info *err_info);
>  #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 83f2069f111e..46123b70f496 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -110,6 +110,16 @@ struct aer_stats {
>  static int pcie_aer_disable;
>  static pci_ers_result_t aer_root_reset(struct pci_dev *dev);
>  
> +#if defined(CONFIG_PCIEAER_CXL)
> +#define CXL_ERROR_SOURCES_MAX          128
> +static DEFINE_KFIFO(cxl_prot_err_fifo, struct cxl_prot_err_work_data,
> +		    CXL_ERROR_SOURCES_MAX);
> +static DEFINE_SPINLOCK(cxl_prot_err_fifo_lock);
> +struct work_struct *cxl_prot_err_work;
> +static int (*cxl_create_prot_err_info)(struct pci_dev*, int severity,
> +				       struct cxl_prot_error_info*);
> +#endif
> +
>  void pci_no_aer(void)
>  {
>  	pcie_aer_disable = 1;
> @@ -1577,6 +1587,35 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>  	return rc ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
>  }
>  
> +
> +#if defined(CONFIG_PCIEAER_CXL)
> +int cxl_register_prot_err_work(struct work_struct *work,
> +			       int (*_cxl_create_prot_err_info)(struct pci_dev*, int,
> +								struct cxl_prot_error_info*))
> +{
> +	guard(spinlock)(&cxl_prot_err_fifo_lock);
> +	cxl_prot_err_work = work;
> +	cxl_create_prot_err_info = _cxl_create_prot_err_info;
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_register_prot_err_work, "CXL");
> +
> +int cxl_unregister_prot_err_work(void)
> +{
> +	guard(spinlock)(&cxl_prot_err_fifo_lock);
> +	cxl_prot_err_work = NULL;
> +	cxl_create_prot_err_info = NULL;
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_unregister_prot_err_work, "CXL");
> +
> +int cxl_prot_err_kfifo_get(struct cxl_prot_err_work_data *wd)
> +{
> +	return kfifo_get(&cxl_prot_err_fifo, wd);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_prot_err_kfifo_get, "CXL");
> +#endif
> +
>  static struct pcie_port_service_driver aerdriver = {
>  	.name		= "aer",
>  	.port_type	= PCIE_ANY_PORT,
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 947b63091902..761d6f5cd792 100644
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
> @@ -45,6 +46,24 @@ struct aer_capability_regs {
>  	u16 uncor_err_source;
>  };
>  
> +/**
> + * struct cxl_prot_err_info - Error information used in CXL error handling
> + * @pdev: PCI device with CXL error
> + * @dev: CXL device with error. From CXL topology using ACPI/platform discovery
> + * @ras_base: Mapped address of CXL RAS registers
> + * @severity: CXL AER/RAS severity: AER_CORRECTABLE, AER_FATAL, AER_NONFATAL
> + */
> +struct cxl_prot_error_info {
> +	struct pci_dev *pdev;
> +	struct device *dev;
> +	void __iomem *ras_base;
> +	int severity;
> +};
> +
> +struct cxl_prot_err_work_data {
> +	struct cxl_prot_error_info err_info;
> +};
> +
>  #if defined(CONFIG_PCIEAER)
>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>  int pcie_aer_is_native(struct pci_dev *dev);
> @@ -56,6 +75,24 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>  #endif
>  
> +#if defined(CONFIG_PCIEAER_CXL)
> +int cxl_register_prot_err_work(struct work_struct *work,
> +			       int (*_cxl_create_proto_err_info)(struct pci_dev*, int,
> +								 struct cxl_prot_error_info*));
> +int cxl_unregister_prot_err_work(void);
> +int cxl_prot_err_kfifo_get(struct cxl_prot_err_work_data *wd);
> +#else
> +static inline int
> +cxl_register_prot_err_work(struct work_struct *work,
> +			   int (*_cxl_create_proto_err_info)(struct pci_dev*, int,
> +							     struct cxl_prot_error_info*))
> +{
> +	return 0;
> +}
> +static inline int cxl_unregister_prot_err_work(void) { return 0; }
> +static inline int cxl_prot_err_kfifo_get(struct cxl_prot_err_work_data *wd) { return 0; }
> +#endif
> +
>  void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  		    struct aer_capability_regs *aer);
>  int cper_severity_to_aer(int cper_severity);


