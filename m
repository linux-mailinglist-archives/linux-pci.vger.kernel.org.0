Return-Path: <linux-pci+bounces-40278-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCE7C32A43
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 19:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 632CC18C39E3
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 18:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE6033C523;
	Tue,  4 Nov 2025 18:30:02 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F2321CC56;
	Tue,  4 Nov 2025 18:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762281002; cv=none; b=m1wWhNKp2Aa+I+y2XFCGN3xxPZLU6gNK+LVoMum+SeyUxOpSeYUwkgFEo+odX5f3mpJyQiigQZGX+ZQObynI760T28v4jIHTse2goLcR04lNVAu/kb/3jUQm57ZcFX4C4HZDuiDOWXEv28DrJylb3sYkyhmeQbtIEVUtIwdME84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762281002; c=relaxed/simple;
	bh=0acjzFoF5T4Tl6lSXfrDZXy+pgAwGwLsMlnIY0RBylw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nWhHz/DFCOJrp0VwiJ0s5tkEzmxHmu0XbL0oqEDNQoDGSczv/hlR5IKC+ePnQGK0KEIf+aEzSJI5J2TUP7gM83dZr4b+fjJCDNqIrlooPSwsD0T9n7PVUM9i3lVDhnJc63u6nNoHJv23Y3J2yYkBsqgyxZF9I/SPYpeuIQEtt5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4d1H2k0WKWz6L55x;
	Wed,  5 Nov 2025 02:26:06 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 3277614033F;
	Wed,  5 Nov 2025 02:29:56 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 4 Nov
 2025 18:29:55 +0000
Date: Tue, 4 Nov 2025 18:29:53 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [RESEND v13 19/25] cxl/pci: Introduce CXL protocol error
 handlers for Endpoints
Message-ID: <20251104182953.00006a16@huawei.com>
In-Reply-To: <20251104170305.4163840-20-terry.bowman@amd.com>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
	<20251104170305.4163840-20-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 4 Nov 2025 11:02:59 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> CXL Endpoint protocol errors are currently handled by generic PCI error
> handlers. However, uncorrectable errors (UCEs) require CXL.mem protocol-
> specific handling logic that the PCI handlers cannot provide.
> 
> Add dedicated CXL protocol error handlers for CXL Endpoints. Rename the
> existing cxl_error_handlers to pci_error_handlers to better reflect their
> purpose and maintain naming consistency. Update the PCI error handlers to
> invoke the new CXL protocol handlers when the endpoint is operating in
> CXL.mem mode.
> 
> Implement cxl_handle_ras() to return PCI_ERS_RESULT_NONE or
> PCI_ERS_RESULT_PANIC. Remove unnecessary result checks from the previous
> endpoint UCE handler since CXL UCE recovery is not implemented in this
> patch.
> 
> Add device lock assertions to protect against concurrent device or RAS
> register removal during error handling. Two devices require locking for
> CXL endpoints:
> 
> 1. The PCI device (pdev->dev) - RAS registers are allocated and mapped
>    using devm_* functions with this device as the host. Locking prevents
>    the RAS registers from being unmapped until after error handling
>    completes.
> 
> 2. The CXL memory device (cxlmd->dev) - Holds a reference to the RAS
>    registers accessed during error handling. Locking prevents the memory
>    device and its RAS register references from being removed during error
>    handling.
> 
> The lock assertions added here will be satisfied by device locks
> introduced in a subsequent patch. A future patch will extend the CXL UCE
> handler to support full UCE recovery.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
Hi Terry,

A few comments inline.

Thanks,

Jonathan


> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index cb712772de5c..beb142054bda 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -128,6 +128,11 @@ void cxl_ras_exit(void)
>  	cancel_work_sync(&cxl_cper_prot_err_work);
>  }
>  
> +static bool is_pcie_endpoint(struct pci_dev *pdev)
> +{
> +	return pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT;
> +}

Not used that I can see. Maybe should be in a different patch?


>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
>  
> -pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
> -				    pci_channel_state_t state)
> +void pci_cor_error_detected(struct pci_dev *pdev)
> +{
> +	struct cxl_dev_state *cxlds;
> +
> +	device_lock_assert(&pdev->dev);
> +	if (!cxl_pci_drv_bound(pdev))
> +		return;
> +
> +	cxlds = pci_get_drvdata(pdev);
> +	guard(device)(&cxlds->cxlmd->dev);
> +
> +	cxl_cor_error_detected(&pdev->dev);
> +}
> +EXPORT_SYMBOL_NS_GPL(pci_cor_error_detected, "CXL");

Similarly to below.  I'm not keen on exporting such generic PCI
sounding functions even in the CXL namespace.

> +
> +pci_ers_result_t cxl_error_detected(struct device *dev)
>  {
> -	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> -	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> -	struct device *dev = &cxlmd->dev;
> -	bool ue;
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  
> -	guard(device)(dev);
> +	device_lock_assert(cxlds->dev);
> +	device_lock_assert(&cxlmd->dev);
>  
>  	if (!dev->driver) {
> -		dev_warn(&pdev->dev,
> +		dev_warn(cxlds->dev,
>  			 "%s: memdev disabled, abort error handling\n",
>  			 dev_name(dev));
>  		return PCI_ERS_RESULT_DISCONNECT;
> @@ -289,32 +308,34 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  
>  	if (cxlds->rcd)
>  		cxl_handle_rdport_errors(cxlds);
> +
I'd drop this blank line addition as it doesn't matter much and it does
add noise to the patch.

>  	/*
>  	 * A frozen channel indicates an impending reset which is fatal to
>  	 * CXL.mem operation, and will likely crash the system. On the off
>  	 * chance the situation is recoverable dump the status of the RAS
>  	 * capability registers and bounce the active state of the memdev.
>  	 */

Mind you - I think this comment wants to go away as it's talking about code
that is no longer here.


> -	ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
> -
> -	switch (state) {
> -	case pci_channel_io_normal:
> -		if (ue) {
> -			device_release_driver(dev);
> -			return PCI_ERS_RESULT_NEED_RESET;
> -		}
> -		return PCI_ERS_RESULT_CAN_RECOVER;
> -	case pci_channel_io_frozen:
> -		dev_warn(&pdev->dev,
> -			 "%s: frozen state error detected, disable CXL.mem\n",
> -			 dev_name(dev));
> -		device_release_driver(dev);
> -		return PCI_ERS_RESULT_NEED_RESET;
> -	case pci_channel_io_perm_failure:
> -		dev_warn(&pdev->dev,
> -			 "failure state error detected, request disconnect\n");
> -		return PCI_ERS_RESULT_DISCONNECT;
> -	}
> -	return PCI_ERS_RESULT_NEED_RESET;
> +	return cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
> +
> +pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
> +				    pci_channel_state_t error)
> +{
> +	struct cxl_dev_state *cxlds;
> +	pci_ers_result_t rc;
> +
> +	device_lock_assert(&pdev->dev);
> +	if (!cxl_pci_drv_bound(pdev))
> +		return PCI_ERS_RESULT_NONE;
> +
> +	cxlds = pci_get_drvdata(pdev);
> +	guard(device)(&cxlds->cxlmd->dev);
> +
> +	rc = cxl_error_detected(&cxlds->cxlmd->dev);
> +	if (rc == PCI_ERS_RESULT_PANIC)
> +		panic("CXL cachemem error.");
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(pci_error_detected, "CXL");

Whilst the symbol is namespaced, I'm not sure I want to see
an exported CXL specific function that sounds so generic pci.

Maybe cxl_pci_error_detected() or something like that?

> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index a0a491e7b5b9..3526e6d75f79 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -79,21 +79,10 @@ struct cxl_dev_state;
>  void read_cdat_data(struct cxl_port *port);
>  
>  #ifdef CONFIG_CXL_RAS
> -void cxl_cor_error_detected(struct pci_dev *pdev);
> -pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
> -				    pci_channel_state_t state);
>  void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
>  void cxl_uport_init_ras_reporting(struct cxl_port *port,
>  				  struct device *host);
>  #else
> -static inline void cxl_cor_error_detected(struct pci_dev *pdev) { }
> -
> -static inline pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
> -						  pci_channel_state_t state)
> -{
> -	return PCI_ERS_RESULT_NONE;
> -}
> -
>  static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
>  						struct device *host) { }
>  static inline void cxl_uport_init_ras_reporting(struct cxl_port *port,


