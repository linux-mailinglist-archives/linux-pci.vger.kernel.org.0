Return-Path: <linux-pci+bounces-35163-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 135C1B3C610
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 02:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C52245A3FE7
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 00:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDA7208A7;
	Sat, 30 Aug 2025 00:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ar+b33xL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28554A01;
	Sat, 30 Aug 2025 00:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756513049; cv=none; b=EUA15BZSVl7YfA7fkDOIJ9Wa24Vt2NcJKDGdtnbfIB7bZrHE4ednBAY2a0/+BlCR/UEGgzMmZ6bWAU+uYaOQ6667OEmmQAYtMSwUMbFfyDYjv9RuJt7wVttvRaC+R9I0EwN9Kt2QiqY92DCj6qZa8ZBKcgmpti9XqON8vh5m430=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756513049; c=relaxed/simple;
	bh=7+XIWx8GPk+ely0gvld70sdQiq4ArEbDJmpyXpbiUJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qBIE03wEQJjq8/7K27YlBBItXPf8HQ8CfCUhIT2kCPhKqH9KmLmSVjYlN8JW1PEf62lJsDAi7Ntf6FGuWjaRYmFgnsVcCJx4p46GOzRtgNRD82oc5QC4pPXDDPy9R3KUg1qhvCDMrq6Cvemlbp0kX/coaDdDUPCeQDbyjmggBG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ar+b33xL; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756513048; x=1788049048;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7+XIWx8GPk+ely0gvld70sdQiq4ArEbDJmpyXpbiUJw=;
  b=Ar+b33xL3DWCEWVkIW/noRbo5/5svGMGT56fMT++GWxGKYm6QtNpufde
   ULRQq3E4zUJX0lNPAh8pcp+sdoidmpy7TgZ6fykfDCKU0KCVmbf+86F7f
   5RH+o8g1FRLm5M15i3b7Vss76zMAQBOcYJfu+MGGOJfGA5k5O1ZhIi+ma
   EVglbowDaDGz+9fXkDGtkGFEDrlOW+zEepx+EtmuP+cTgtkbYYiMpbVBu
   a2U7rWhl+QzdXk4CEv86jGAjEAxINBO6w6szYEH371fOPtjpNMSHxcMTo
   ILpybjMVmErAdKQSCgbYLVADvwwLiG2hiCm/yjiurI9q1joNa428xIMNU
   w==;
X-CSE-ConnectionGUID: 1BpzqoGuQ1yQGA9D22Audw==
X-CSE-MsgGUID: kPwv5DjiTGaN4XtKkMbn+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11537"; a="69907533"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="69907533"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 17:17:28 -0700
X-CSE-ConnectionGUID: 99TnGo17TEe7ZGUlg52iWA==
X-CSE-MsgGUID: 2erQC3sVSKa2Pe50vlMYXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="207648615"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.118.59]) ([10.247.118.59])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 17:17:18 -0700
Message-ID: <b61a163d-5d5f-437d-95de-b0b57769a6ce@intel.com>
Date: Fri, 29 Aug 2025 17:17:11 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 19/23] CXL/PCI: Introduce CXL Port protocol error
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
References: <20250827013539.903682-1-terry.bowman@amd.com>
 <20250827013539.903682-20-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250827013539.903682-20-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/26/25 6:35 PM, Terry Bowman wrote:
> Introduce CXL error handlers for CXL Port devices.
> 
> Add functions cxl_port_cor_error_detected() and cxl_port_error_detected().
> These will serve as the handlers for all CXL Port devices. Introduce
> cxl_get_ras_base() to provide the RAS base address needed by the handlers.
> 
> Update cxl_handle_proto_error() to call the CXL Port or CXL Endpoint
> handler depending on which CXL device reports the error.
> 
> Implement cxl_get_ras_base() to return the cached RAS register address of a
> CXL Root Port, CXL Downstream Port, or CXL Upstream Port.
> 
> Introduce get_pci_cxl_host_dev() to return the host responsible for
> releasing the RAS mapped resources. CXL endpoints do not use a host to
> manage its resources, allow for NULL in the case of an EP. Use reference
> count increment on the host to prevent resource release. Make the caller
> responsible for the reference decrement.
> 
> Update the AER driver's is_cxl_error() PCI type check because CXL Port
> devices are now supported.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> ---
> Changes in v10->v11:
> - None
> ---
>  drivers/cxl/core/core.h    |   9 ++
>  drivers/cxl/core/port.c    |   4 +-
>  drivers/cxl/core/ras.c     | 176 +++++++++++++++++++++++++++++++++++--
>  drivers/pci/pcie/cxl_aer.c |   5 +-
>  4 files changed, 186 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 6e3e7f2e0e2d..7e66fbb07b8a 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -155,6 +155,8 @@ pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
>  void pci_cor_error_detected(struct pci_dev *pdev);
>  void cxl_cor_error_detected(struct device *dev);
>  pci_ers_result_t cxl_error_detected(struct device *dev);
> +void cxl_port_cor_error_detected(struct device *dev);
> +pci_ers_result_t cxl_port_error_detected(struct device *dev);
>  #else
>  static inline int cxl_ras_init(void)
>  {
> @@ -179,9 +181,16 @@ static inline pci_ers_result_t cxl_error_detected(struct device *dev)
>  {
>  	return PCI_ERS_RESULT_NONE;
>  }
> +static inline void cxl_port_cor_error_detected(struct device *dev) { }
> +static inline pci_ers_result_t cxl_port_error_detected(struct device *dev)
> +{
> +	return PCI_ERS_RESULT_NONE;
> +}
>  #endif // CONFIG_CXL_RAS
>  
>  int cxl_gpf_port_setup(struct cxl_dport *dport);
> +struct cxl_port *find_cxl_port(struct device *dport_dev,
> +			       struct cxl_dport **dport);
>  
>  #ifdef CONFIG_CXL_FEATURES
>  struct cxl_feat_entry *
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 29197376b18e..758fb73374c1 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1335,8 +1335,8 @@ static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
>  	return NULL;
>  }
>  
> -static struct cxl_port *find_cxl_port(struct device *dport_dev,
> -				      struct cxl_dport **dport)
> +struct cxl_port *find_cxl_port(struct device *dport_dev,
> +			       struct cxl_dport **dport)
>  {
>  	struct cxl_find_port_ctx ctx = {
>  		.dport_dev = dport_dev,
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index a2e95c49f965..536ca9c815ce 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -251,6 +251,154 @@ static void cxl_dport_map_ras(struct cxl_dport *dport)
>  		dev_dbg(dev, "Failed to map RAS capability.\n");
>  }
>  
> +static int match_uport(struct device *dev, const void *data)
> +{
> +	const struct device *uport_dev = data;
> +	struct cxl_port *port;
> +
> +	if (!is_cxl_port(dev))
> +		return 0;
> +
> +	port = to_cxl_port(dev);
> +
> +	return port->uport_dev == uport_dev;
> +}

Just heads up, there's a find_cxl_port_by_uport() coming with the deferred dport init series that you can use instead. Just FYI.

> +
> +static void __iomem *cxl_get_ras_base(struct device *dev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_ROOT_PORT:
> +	case PCI_EXP_TYPE_DOWNSTREAM:
> +	{
> +		struct cxl_dport *dport = NULL;
> +		struct cxl_port *port __free(put_cxl_port) = find_cxl_port(&pdev->dev, &dport);
> +
> +		if (!dport || !dport->dport_dev) {
> +			pci_err(pdev, "Failed to find the CXL device");
> +			return NULL;
> +		}
> +
> +		if (!dport)
> +			return NULL;
> +
> +		return dport->regs.ras;
> +	}
> +	case PCI_EXP_TYPE_UPSTREAM:
> +	{
> +		struct cxl_port *port;
> +		struct device *port_dev __free(put_device) =
> +			bus_find_device(&cxl_bus_type, NULL,
> +					&pdev->dev, match_uport);
> +
> +		if (!port_dev || !is_cxl_port(port_dev)) {
> +			pci_err(pdev, "Failed to find the CXL device");
> +			return NULL;
> +		}
> +
> +		port = to_cxl_port(port_dev);
> +		if (!port)
> +			return NULL;
> +
> +		return port->uport_regs.ras;
> +	}
> +	}
> +
> +	dev_warn_once(dev, "Error: Unsupported device type (%X)", pci_pcie_type(pdev));
> +	return NULL;
> +}
> +
> +static struct device *pci_to_cxl_dev(struct pci_dev *pdev)
> +{
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_ROOT_PORT:
> +	case PCI_EXP_TYPE_DOWNSTREAM:
> +	{
> +		struct cxl_dport *dport = NULL;
> +		struct cxl_port *port __free(put_cxl_port) =
> +			find_cxl_port(&pdev->dev, &dport);
> +
> +		if (!dport) {
I think you can just check 'port' here right? and then you don't need to set dport to NULL.

> +			pci_err(pdev, "Failed to find the CXL device");
> +			return NULL;
> +		}
> +
> +		return dport->dport_dev;
> +	}
> +	case PCI_EXP_TYPE_UPSTREAM:
> +	{
> +		struct cxl_port *port;
> +		struct device *port_dev __free(put_device) =
> +			bus_find_device(&cxl_bus_type, NULL,
> +					&pdev->dev, match_uport);
> +
> +		if (!port_dev || !is_cxl_port(port_dev)) {
> +			pci_err(pdev, "Failed to find the CXL device");
> +			return NULL;
> +		}
> +
> +		port = to_cxl_port(port_dev);
> +		if (!port)
> +			return NULL;
> +
> +		return port->uport_dev;
> +	}
> +	case PCI_EXP_TYPE_ENDPOINT:
> +	{
> +		struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);

With this function called through cxl_proto_err_work_fn() and not the AER handling stack, I have concerns of if a driver is bound to the endpoint, and if the pci driver bound to the endpoint is cxl_pci for cxlds to be valid.

> +
> +		return cxlds->dev;
> +	}
> +	}
> +
> +	pci_warn_once(pdev, "Error: Unsupported device type (%X)", pci_pcie_type(pdev));
> +	return NULL;
> +}
> +
> +
> +/*
> + * Return 'struct device *' responsible for freeing pdev's CXL resources.
> + * Caller is responsible for reference count decrementing the return
> + * 'struct device *'.
> + *
> + * dev: Find the host of this dev
> + */
> +static struct device *get_cxl_host_dev(struct device *dev)
> +{> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_ROOT_PORT:
> +	case PCI_EXP_TYPE_DOWNSTREAM:
> +	{
> +		struct cxl_dport *dport = NULL;

No need to set to NULL. dport not used.

DJ

> +		struct cxl_port *port = find_cxl_port(&pdev->dev, &dport);
> +
> +		if (!port)
> +			return NULL;
> +
> +		return &port->dev;
> +	}> +	case PCI_EXP_TYPE_UPSTREAM:
> +	{
> +		struct device *port_dev = bus_find_device(&cxl_bus_type, NULL,
> +							  &pdev->dev, match_uport);
> +
> +		if (!port_dev || !is_cxl_port(port_dev))
> +			return NULL;
> +
> +		return port_dev;
> +	}
> +	/* Endpoint resources are managed by endpoint itself */
> +	case PCI_EXP_TYPE_ENDPOINT:
> +		return NULL;
> +	}
> +
> +	dev_warn_once(dev, "Error: Unsupported device type (%X)", pci_pcie_type(pdev));
> +	return NULL;
> +}
> +
>  /**
>   * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
>   * @dport: the cxl_dport that needs to be initialized
> @@ -399,6 +547,22 @@ static pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial, void __io
>  	return PCI_ERS_RESULT_PANIC;
>  }
>  
> +void cxl_port_cor_error_detected(struct device *dev)
> +{
> +	void __iomem *ras_base = cxl_get_ras_base(dev);
> +
> +	cxl_handle_cor_ras(dev, 0, ras_base);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_port_cor_error_detected, "CXL");
> +
> +pci_ers_result_t cxl_port_error_detected(struct device *dev)
> +{
> +	void __iomem *ras_base = cxl_get_ras_base(dev);
> +
> +	return cxl_handle_ras(dev, 0, ras_base);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_port_error_detected, "CXL");
> +
>  void cxl_cor_error_detected(struct device *dev)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
> @@ -469,9 +633,8 @@ EXPORT_SYMBOL_NS_GPL(pci_error_detected, "CXL");
>  static void cxl_handle_proto_error(struct cxl_proto_err_work_data *err_info)
>  {
>  	struct pci_dev *pdev = err_info->pdev;
> -	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> -	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> -	struct device *host_dev __free(put_device) = get_device(&cxlmd->dev);
> +	struct device *dev = pci_to_cxl_dev(pdev);
> +	struct device *host_dev __free(put_device) = get_cxl_host_dev(&pdev->dev);
>  
>  	if (err_info->severity == AER_CORRECTABLE) {
>  		int aer = pdev->aer_cap;
> @@ -481,11 +644,14 @@ static void cxl_handle_proto_error(struct cxl_proto_err_work_data *err_info)
>  						       aer + PCI_ERR_COR_STATUS,
>  						       0, PCI_ERR_COR_INTERNAL);
>  
> -		cxl_cor_error_detected(&cxlmd->dev);
> +		if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT)
> +			cxl_error_detected(&pdev->dev);
> +		else
> +			cxl_port_cor_error_detected(dev);
>  
>  		pcie_clear_device_status(pdev);
>  	} else {
> -		cxl_do_recovery(&cxlmd->dev);
> +		cxl_do_recovery(dev);
>  	}
>  }
>  
> diff --git a/drivers/pci/pcie/cxl_aer.c b/drivers/pci/pcie/cxl_aer.c
> index 74e6d2d04ab6..6eeff0b78b47 100644
> --- a/drivers/pci/pcie/cxl_aer.c
> +++ b/drivers/pci/pcie/cxl_aer.c
> @@ -68,7 +68,10 @@ bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
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
>  	return is_internal_error(info);


