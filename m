Return-Path: <linux-pci+bounces-26573-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E56A995B0
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 18:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DA1A1887255
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 16:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF1E263F4B;
	Wed, 23 Apr 2025 16:47:49 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449D721FF5F;
	Wed, 23 Apr 2025 16:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745426869; cv=none; b=KFt/Opjjm/OzQfUQhgAFv1u6Q+saIxvQ54EyfbmVvP27KZTMhZVFwv/T/xE7V2uoPeybJzp9QxSZol2mM948xtWPDlNZgrzFQBRLxSzpo+tlfuureOVPnjwM/D0Do3xCy1NyF/HIxG/rOk3hbjE/XhhYcg812sxqzC6L8epWZyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745426869; c=relaxed/simple;
	bh=mQdv7YXx38FAo3qeUV7ML8j/h/JcDNvwpN1YRlhBNCg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bpUPrpom80g0LKIzzLy28WjG1/bJQjnjTpVhyt7oRRjlU5x3PX1LF6Oyy85Z3d6aBxIHeSzlJvu4qYw+tnHSOxfJ7637HNmYfbszryke04ZTm9PLojJ1cA7ShkTYKtIvKJ1q4ClQRcRrWDMRyrftdjuKTNeAf3yf9Zs3m6Pgr70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZjPzx065yz6K9Pb;
	Thu, 24 Apr 2025 00:43:09 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 709C414020A;
	Thu, 24 Apr 2025 00:47:43 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 23 Apr
 2025 18:47:42 +0200
Date: Wed, 23 Apr 2025 17:47:41 +0100
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
Subject: Re: [PATCH v8 12/16] cxl/pci: Assign CXL Port protocol error
 handlers
Message-ID: <20250423174741.000004b1@huawei.com>
In-Reply-To: <20250327014717.2988633-13-terry.bowman@amd.com>
References: <20250327014717.2988633-1-terry.bowman@amd.com>
	<20250327014717.2988633-13-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 26 Mar 2025 20:47:13 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> Introduce CXL error handlers for CXL Port devices. These are needed
> to handle and log CXL protocol errors.
> 
> Update cxl_create_prot_err_info() with support for CXL Root Ports (RP), CXL
> Upstream Switch Ports (USP) and CXL Downstreasm Switch ports (DSP).
> 
> Add functions cxl_port_error_detected() and cxl_port_cor_error_detected().
> 
> Add cxl_assign_error_handlers() and use to assign the CXL Port error
> handlers for CXL RP, CXL USP, and CXL DSP. Make the assignments in
> cxl_uport_init_ras() and cxl_dport_init_ras() after mapping RAS registers.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/cxl/core/core.h |  2 ++
>  drivers/cxl/core/pci.c  | 23 +++++++++++++
>  drivers/cxl/core/port.c |  4 +--
>  drivers/cxl/core/ras.c  | 76 +++++++++++++++++++++++++++++++++--------
>  drivers/cxl/cxl.h       |  5 +++
>  drivers/cxl/port.c      | 29 ++++++++++++++--
>  6 files changed, 120 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 15699299dc11..5ce7269e5f13 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -122,6 +122,8 @@ void cxl_ras_exit(void);
>  int cxl_gpf_port_setup(struct device *dport_dev, struct cxl_port *port);
>  int cxl_acpi_get_extended_linear_cache_size(struct resource *backing_res,
>  					    int nid, resource_size_t *size);
> +struct cxl_port *find_cxl_port(struct device *dport_dev,
> +			       struct cxl_dport **dport);
>  
>  #ifdef CONFIG_CXL_FEATURES
>  size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 10b2abfb0e64..9ed6f700e132 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -739,6 +739,29 @@ static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
>  
>  #ifdef CONFIG_PCIEAER_CXL
>  
> +
> +void cxl_port_cor_error_detected(struct device *cxl_dev,
> +				 struct cxl_prot_error_info *err_info)
> +{
> +	void __iomem *ras_base = err_info->ras_base;
> +	struct device *pci_dev = &err_info->pdev->dev;
> +	u64 serial = 0;
> +
> +	__cxl_handle_cor_ras(cxl_dev, pci_dev, serial, ras_base);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_port_cor_error_detected, "CXL");
> +
> +pci_ers_result_t cxl_port_error_detected(struct device *cxl_dev,
> +					 struct cxl_prot_error_info *err_info)
> +{
> +	void __iomem *ras_base = err_info->ras_base;
> +	struct device *pci_dev = &err_info->pdev->dev;
> +	u64 serial = 0;

Maybe just put that directly in the call?  Or is it usefull to hvae
it here as a form of documentation?

> +
> +	return  __cxl_handle_ras(cxl_dev, pci_dev, serial, ras_base);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_port_error_detected, "CXL");
> +
>  static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
>  					  struct cxl_dport *dport)
>  {

> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index f18cb568eabd..fe38e76f2d1a 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -110,34 +110,80 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
>  }
>  static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
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
> +
>  int cxl_create_prot_err_info(struct pci_dev *_pdev, int severity,
>  			     struct cxl_prot_error_info *err_info)
>  {
>  	struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(_pdev);
> -	struct cxl_dev_state *cxlds;
>  
>  	if (!pdev || !err_info) {
>  		pr_warn_once("Error: parameter is NULL");
>  		return -ENODEV;
>  	}
>  
> -	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT) &&
> -	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END)) {
> +	*err_info = (struct cxl_prot_error_info){ 0 };
> +	err_info->severity = severity;
> +	err_info->pdev = pdev;
Can maybe carry forward earlier suggestion for at least these two fields.

	*err_info = (struct cxl_prot_error_info) {
		.severity = ...

	};
> +
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_ROOT_PORT:
> +	case PCI_EXP_TYPE_DOWNSTREAM:
> +	{
> +		struct cxl_dport *dport = NULL;
> +		struct cxl_port *port __free(put_cxl_port) =
> +			find_cxl_port(&pdev->dev, &dport);
> +
> +		if (!port || !is_cxl_port(&port->dev))
> +			return -ENODEV;
> +
> +		err_info->ras_base = dport ? dport->regs.ras : NULL;
> +		err_info->dev = &port->dev;
> +		break;
> +	}
> +	case PCI_EXP_TYPE_UPSTREAM:
> +	{
> +		struct cxl_port *port;
> +		struct device *port_dev __free(put_device) =
> +			bus_find_device(&cxl_bus_type, NULL, &pdev->dev,
> +					match_uport);
> +
> +		if (!port_dev || !is_cxl_port(port_dev))
> +			return -ENODEV;
> +
> +		port = to_cxl_port(port_dev);
> +		err_info->ras_base = port ? port->uport_regs.ras : NULL;
> +		err_info->dev = port_dev;
> +		break;
> +	}
> +	case PCI_EXP_TYPE_ENDPOINT:
> +	case PCI_EXP_TYPE_RC_END:
> +	{
> +		struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +		struct cxl_memdev *cxlmd = cxlds->cxlmd;
> +		struct device *dev __free(put_device) = get_device(&cxlmd->dev);
> +
> +		err_info->ras_base = cxlds->regs.ras;
> +		err_info->dev = &cxlds->cxlmd->dev;
> +		break;
> +	}
> +	default:
> +	{
>  		pci_warn_once(pdev, "Error: Unsupported device type (%X)", pci_pcie_type(pdev));
>  		return -ENODEV;
>  	}
> -
> -	cxlds = pci_get_drvdata(pdev);
> -	struct device *dev __free(put_device) = get_device(&cxlds->cxlmd->dev);
> -
> -	if (!dev)
> -		return -ENODEV;
> -
> -	*err_info = (struct cxl_prot_error_info){ 0 };
> -	err_info->ras_base = cxlds->regs.ras;
> -	err_info->severity = severity;
> -	err_info->pdev = pdev;
> -	err_info->dev = dev;
> +	}
>  
>  	return 0;
>  }


