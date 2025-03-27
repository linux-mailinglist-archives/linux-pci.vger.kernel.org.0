Return-Path: <linux-pci+bounces-24870-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF54A7391C
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 18:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 915DC1779EE
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 17:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD609183CA6;
	Thu, 27 Mar 2025 17:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DggovowI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985D3161302;
	Thu, 27 Mar 2025 17:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743095284; cv=none; b=kUSQ8K2MfSF+A/FbU7LcQ3r9uhLkl7wIZJu/BsDyQFCNq1x83DRzkHMgfGyJB+Qx7LqCUE6qSlUrhmMQqajiPkcEAcVr8FALgxcyF+wl012hMcMgEBqob4iEeVjUzjc1VR8WgSJnMco9uZFe66xwVWQNrNsu59YHPxTXogrtYyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743095284; c=relaxed/simple;
	bh=TF0IXwuKo6252D3KFgSv9anh+pSOkAocOgawPYSgWLY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=imimT2ShJwHiIpPXiESvEzCGIysbUK684tIiUGYeyPauOH8Vbz0oJP6aqsS5SDm66JHp8j67bSlq/a4qzjK3QILj0aZ9yZgZMPTjt4HP8M/QNeVsmizUz5953j9GkMAlanpXbulSzxo/WLocwa6C8dtYONoCLRWyFi5eLS1aihk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DggovowI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C4FC4CEDD;
	Thu, 27 Mar 2025 17:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743095284;
	bh=TF0IXwuKo6252D3KFgSv9anh+pSOkAocOgawPYSgWLY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=DggovowIE/Kq4oZSqwCqMOGHPS6UTDfuFZ+zOw/4xNvrfUyOHVC+thEVZnQwxqA4q
	 mD5Z6Vgr7y29XAYfpHqHNcBCHAJVEVF2T3cyxdhxleDBy62JxZG7QmvgMzNRf7fIee
	 PwFIf2tNOTvv+0INeJ8ZbDccyn2v2Vx3eMMh3jAIQ44NzOpOAmChztj899E/cBN99M
	 7yZtIhY6g6VwfIOMdhZ/1TWDOByeWeaF6kHZWkI5Ire67D3bBBanx3hzQf18TdVJch
	 rlHbYYX5tRSVKHLKjSqXdb3gpavn+z2OC7w8vPVSXDVw1DENFM7e2pBqnZBIHb6jhx
	 wGFi6Z5qYMl9g==
Date: Thu, 27 Mar 2025 12:08:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Terry Bowman <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
	ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
	rrichter@amd.com, nathan.fontenot@amd.com,
	Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
	ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
Subject: Re: [PATCH v8 03/16] CXL/AER: Introduce Kfifo for forwarding CXL
 errors
Message-ID: <20250327170802.GA1435872@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327014717.2988633-4-terry.bowman@amd.com>

On Wed, Mar 26, 2025 at 08:47:04PM -0500, Terry Bowman wrote:
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
> ...

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

This is CXL code, so your call, but I'm always skeptical about testing
for NULL and basically ignoring a code defect that got us here with a
NULL pointer.  I would rather take the NULL pointer dereference fault
and force a fix in the caller.

> +	}
> +
> +	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT) &&
> +	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END)) {
> +		pci_warn_once(pdev, "Error: Unsupported device type (%X)", pci_pcie_type(pdev));
> +		return -ENODEV;

Similar.  A pci_warn_once() here seems like a debugging aid during
development, not necessarily a production kind of thing.

Thanks for printing the type.  I would use "%#x" to make it clear that
it's hex.  There are about 1900 %X uses compared with 33K
%x uses, but maybe you have a reason to capitalize it?

> +	}
> +
> +	cxlds = pci_get_drvdata(pdev);
> +	struct device *dev __free(put_device) = get_device(&cxlds->cxlmd->dev);
> +
> +	if (!dev)
> +		return -ENODEV;
> +
> +	*err_info = (struct cxl_prot_error_info){ 0 };

Neat, I hadn't seen this idiom.

> +	err_info->ras_base = cxlds->regs.ras;
> +	err_info->severity = severity;
> +	err_info->pdev = pdev;
> +	err_info->dev = dev;
> +
> +	return 0;
> +}
> +
> +struct work_struct cxl_prot_err_work;
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

What does the "_" in "_pdev" signify?  Looks unnecessarily different
than the decls above.

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

Space before "*" in the parameters.

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

Ditto.  Rewrap to fit in 80 columns, unindent this function pointer
decl to make it fit.  Same below in aer.h.

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

What does the "prot" in "cxl_prot_error_info" refer to?

There's basically no error info here other than "severity".

I guess "dev" and "pdev" are separate devices (otherwise you would
just use "&pdev->dev"), but I don't have any intuition about how they
might be related, which is a little disconcerting.

I would have thought that "ras_base" would be a property of "dev" (the
CXL device) and wouldn't need to be separate.

From above, I guess "ras_base" is a property of cxlds, not
cxlds->cxlmd->dev.  Maybe we should be keeping &cxlds here instead and
letting the consumer look up cxlds->cxlmd->dev?

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
> -- 
> 2.34.1
> 

