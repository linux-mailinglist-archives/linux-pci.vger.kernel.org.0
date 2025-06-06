Return-Path: <linux-pci+bounces-29068-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06751ACFA77
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 02:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D7EA16F0DB
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 00:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742A21BF58;
	Fri,  6 Jun 2025 00:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C4yiLV8/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FEC5223;
	Fri,  6 Jun 2025 00:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749171010; cv=none; b=qYlGmn1pFnVCc4m6B8/nUMD/zBAKNT03IxU4JO1dB64uDFeXJMFtwUNeVnEJ9kBdmItwq4NDNqblhQXLCpintwh0IpjRcty2325JvahVZzx6FnECQJZVNU1zn42uqImnAurPy4l/0JaNoUlyVfBZcZiMq1zc07iuGOhUZ54y5ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749171010; c=relaxed/simple;
	bh=l6/dSE7lhq+PApCpkALkuE2ib38xUftFWZEoWPaxZ4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oMbL5hcAf5LxKGjF3thfbkSFH+tz6JOaAR4usxWrNCvVDVP0cnuF3+o8++5B149gLBUU7REkYChyjVyar2kL+68iHUozVuxgo98NOJGDHlm+ixWqvYjE9SdbKNrpF/3Ih5lcwgoDNDVumOFCqVjBaC2ExUeqQnt7MQmFv7oogik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C4yiLV8/; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749171007; x=1780707007;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=l6/dSE7lhq+PApCpkALkuE2ib38xUftFWZEoWPaxZ4g=;
  b=C4yiLV8/vkJ53rvuYRSTibs3nQEwBIQoB71a6H8T5cMMFKeQ/TDF4Rsv
   jyAY3dPmVoSnRDjgi7Y42jN8zJwH/FfO2llmm1WfKRKpQ2CW5AFLvE5A/
   MAdfOt9jIpOBujXPJ6E9Keja23gg02jWZRUFy3Xu+5MP+ZDr5oUrYrLFK
   OKF9BH+pWKJnot9G6+Sy4sN0qwnaZkNf3zEWJu9sHbuxqNrhLLLmUsIKd
   2nEsmg7SxE+5yM4caMpppxko1DAoaiCnNAaHX5D6zGwAnFT1gxSFb2trw
   ybpwXubeERijMcTSF/b1C1LsRk9ArvJzwIGkMMzl5bHpFWtLvIiN2WmNG
   w==;
X-CSE-ConnectionGUID: vK41ebxRTp+8mNfiXvc3Cw==
X-CSE-MsgGUID: I6XD67iLSu+pptEM7KRudg==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="51223615"
X-IronPort-AV: E=Sophos;i="6.16,213,1744095600"; 
   d="scan'208";a="51223615"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 17:50:06 -0700
X-CSE-ConnectionGUID: HxvL3G2sTFeoRHy9AoxN4Q==
X-CSE-MsgGUID: pZBDMQ/IRBWen0TuWOYLow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,213,1744095600"; 
   d="scan'208";a="146651112"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 17:50:06 -0700
Received: from [10.124.222.132] (unknown [10.124.222.132])
	by linux.intel.com (Postfix) with ESMTP id E397B20B5736;
	Thu,  5 Jun 2025 17:50:04 -0700 (PDT)
Message-ID: <36c3b63c-58d8-4911-8757-9aa9a74cb0ac@linux.intel.com>
Date: Thu, 5 Jun 2025 17:50:04 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 13/16] cxl/pci: Introduce CXL Port protocol error
 handlers
To: Terry Bowman <terry.bowman@amd.com>, PradeepVineshReddy.Kodamati@amd.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, bp@alien8.de,
 ming.li@zohomail.com, shiju.jose@huawei.com, dan.carpenter@linaro.org,
 Smita.KoralahalliChannabasappa@amd.com, kobayashi.da-06@fujitsu.com,
 yanfei.xu@intel.com, rrichter@amd.com, peterz@infradead.org, colyli@suse.de,
 uaisheng.ye@intel.com, fabio.m.de.francesco@linux.intel.com,
 ilpo.jarvinen@linux.intel.com, yazen.ghannam@amd.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-14-terry.bowman@amd.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250603172239.159260-14-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/3/25 10:22 AM, Terry Bowman wrote:
> Introduce CXL error handlers for CXL Port devices.
>
> Add functions cxl_port_cor_error_detected() and cxl_port_error_detected().
> These will serve as the handlers for all CXL Port devices. Introduce
> cxl_get_ras_base() to provide the RAS base address needed by the handlers.
>
> Update cxl_handle_prot_error() to call the CXL Port or CXL Endpoint handler
> depending on which CXL device reports the error.
>
> Implement pci_get_ras_base() to return the cached RAS register address of a
> CXL Root Port, CXL Downstream Port, or CXL Upstream Port.
>
> Update the AER driver's is_cxl_error() to remove the filter PCI type check
> because CXL Port devices are now supported.
>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>   drivers/cxl/core/core.h |  2 +
>   drivers/cxl/core/pci.c  | 61 ++++++++++++++++++++++++++
>   drivers/cxl/core/port.c |  4 +-
>   drivers/cxl/core/ras.c  | 96 ++++++++++++++++++++++++++++++++++++-----
>   drivers/cxl/cxl.h       |  5 +++
>   drivers/pci/pcie/aer.c  |  5 ---
>   6 files changed, 155 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index c73f39d14dd7..23d15eef01d2 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -122,6 +122,8 @@ void cxl_ras_exit(void);
>   int cxl_gpf_port_setup(struct cxl_dport *dport);
>   int cxl_acpi_get_extended_linear_cache_size(struct resource *backing_res,
>   					    int nid, resource_size_t *size);
> +struct cxl_port *find_cxl_port(struct device *dport_dev,
> +			       struct cxl_dport **dport);
>   
>   #ifdef CONFIG_CXL_FEATURES
>   size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index e094ef518e0a..b6836825e8df 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -753,6 +753,67 @@ static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
>   
>   #ifdef CONFIG_PCIEAER_CXL
>   
> +static void __iomem *cxl_get_ras_base(struct device *dev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	void __iomem *ras_base;
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
> +		ras_base = dport ? dport->regs.ras : NULL;
> +		break;
> +	}
> +	case PCI_EXP_TYPE_UPSTREAM:
> +	{
> +		struct cxl_port *port;
> +		struct device *dev __free(put_device) = bus_find_device(&cxl_bus_type, NULL,
> +									&pdev->dev, match_uport);
> +
> +		if (!dev || !is_cxl_port(dev)) {
> +			pci_err(pdev, "Failed to find the CXL device");
> +			return NULL;
> +		}
> +
> +		port = to_cxl_port(dev);
> +		ras_base = port ? port->uport_regs.ras : NULL;
> +		break;
> +	}
> +	default:
> +	{
> +		pci_warn_once(pdev, "Error: Unsupported device type (%X)", pci_pcie_type(pdev));
> +		return NULL;
> +	}
> +	}
> +
> +	return ras_base;
> +}
> +
> +void cxl_port_cor_error_detected(struct device *dev)
> +{
> +	void __iomem *ras_base = cxl_get_ras_base(dev);
> +
> +	__cxl_handle_cor_ras(dev, 0, ras_base);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_port_cor_error_detected, "CXL");
> +
> +pci_ers_result_t cxl_port_error_detected(struct device *dev)
> +{
> +	void __iomem *ras_base = cxl_get_ras_base(dev);
> +
> +	return  __cxl_handle_ras(dev, 0, ras_base);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_port_error_detected, "CXL");
> +
>   static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
>   					  struct cxl_dport *dport)
>   {
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index eb46c6764d20..07b9bb0f601f 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1341,8 +1341,8 @@ static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
>   	return NULL;
>   }
>   
> -static struct cxl_port *find_cxl_port(struct device *dport_dev,
> -				      struct cxl_dport **dport)
> +struct cxl_port *find_cxl_port(struct device *dport_dev,
> +			       struct cxl_dport **dport)
>   {
>   	struct cxl_find_port_ctx ctx = {
>   		.dport_dev = dport_dev,
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 664f532cc838..6093e70ece37 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -140,20 +140,85 @@ static pci_ers_result_t cxl_merge_result(enum pci_ers_result orig,
>   	return orig;
>   }
>   
> -static int cxl_report_error_detected(struct pci_dev *pdev, void *data)
> +int match_uport(struct device *dev, const void *data)
>   {
> -	pci_ers_result_t vote, *result = data;
> -	struct cxl_dev_state *cxlds;
> +	const struct device *uport_dev = data;
> +	struct cxl_port *port;
>   
> -	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT) &&
> -	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END))
> +	if (!is_cxl_port(dev))
>   		return 0;
>   
> -	cxlds = pci_get_drvdata(pdev);
> -	struct device *dev __free(put_device) = get_device(&cxlds->cxlmd->dev);
> +	port = to_cxl_port(dev);
> +
> +	return port->uport_dev == uport_dev;
> +}
> +EXPORT_SYMBOL_NS_GPL(match_uport, "CXL");
> +
> +/* Return 'struct device*' responsible for freeing pdev's CXL resources */
> +static struct device *get_pci_cxl_host_dev(struct pci_dev *pdev)
> +{
> +	struct device *host_dev;
> +
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_ROOT_PORT:
> +	case PCI_EXP_TYPE_DOWNSTREAM:
> +	{
> +		struct cxl_dport *dport = NULL;
> +		struct cxl_port *port = find_cxl_port(&pdev->dev, &dport);
> +
> +		if (!dport || !dport->dport_dev)
> +			return NULL;
> +
> +		host_dev = &port->dev;
> +		break;
> +	}
> +	case PCI_EXP_TYPE_UPSTREAM:
> +	{
> +		struct cxl_port *port;
> +		struct device *cxl_dev = bus_find_device(&cxl_bus_type, NULL,
> +							 &pdev->dev, match_uport);
> +
> +		if (!cxl_dev || !is_cxl_port(cxl_dev))
> +			return NULL;
> +
> +		port = to_cxl_port(cxl_dev);
> +		host_dev = &port->dev;
> +		break;
> +	}
> +	case PCI_EXP_TYPE_ENDPOINT:
> +	case PCI_EXP_TYPE_RC_END:
> +	{
> +		struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +
> +		if (!cxlds)
> +			return NULL;
> +
> +		host_dev = get_device(&cxlds->cxlmd->dev);
> +		break;
> +	}
> +	default:
> +	{
> +		pci_warn_once(pdev, "Error: Unsupported device type (%X)", pci_pcie_type(pdev));
> +		return NULL;
> +	}
> +	}
> +
> +	return host_dev;
> +}
> +
> +static int cxl_report_error_detected(struct pci_dev *pdev, void *data)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device *host_dev __free(put_device) = get_pci_cxl_host_dev(pdev);
> +	pci_ers_result_t vote, *result = data;
>   
>   	device_lock(&pdev->dev);
> -	vote = cxl_error_detected(&pdev->dev);
> +	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT) ||
> +	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END)) {
> +		vote = cxl_error_detected(dev);
> +	} else {
> +		vote = cxl_port_error_detected(dev);
> +	}
>   	*result = cxl_merge_result(*result, vote);
>   	device_unlock(&pdev->dev);
>   
> @@ -244,14 +309,18 @@ static struct pci_dev *sbdf_to_pci(struct cxl_prot_error_info *err_info)
>   static void cxl_handle_prot_error(struct cxl_prot_error_info *err_info)
>   {
>   	struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(sbdf_to_pci(err_info));
> -	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> -	struct device *cxlmd_dev __free(put_device) = get_device(&cxlds->cxlmd->dev);
>   
>   	if (!pdev) {
>   		pr_err("Failed to find the CXL device\n");
>   		return;
>   	}
>   
> +	struct device *host_dev __free(put_device) = get_pci_cxl_host_dev(pdev);
> +	if (!host_dev) {
> +		pr_err("Failed to find the CXL device's host\n");
> +		return;
> +	}
> +
>   	/*
>   	 * Internal errors of an RCEC indicate an AER error in an
>   	 * RCH's downstream port. Check and handle them in the CXL.mem
> @@ -261,6 +330,7 @@ static void cxl_handle_prot_error(struct cxl_prot_error_info *err_info)
>   		return pcie_walk_rcec(pdev, cxl_rch_handle_error_iter, err_info);
>   
>   	if (err_info->severity == AER_CORRECTABLE) {
> +		struct device *dev = &pdev->dev;
>   		int aer = pdev->aer_cap;
>   
>   		if (aer)
> @@ -268,7 +338,11 @@ static void cxl_handle_prot_error(struct cxl_prot_error_info *err_info)
>   						       aer + PCI_ERR_COR_STATUS,
>   						       0, PCI_ERR_COR_INTERNAL);
>   
> -		cxl_cor_error_detected(&pdev->dev);
> +		if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT) ||
> +		    (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END))
> +			cxl_cor_error_detected(dev);
> +		else
> +			cxl_port_cor_error_detected(dev);
>   
>   		pcie_clear_device_status(pdev);
>   	} else {
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 6fd9a42eb304..2c1c00466a25 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -801,6 +801,9 @@ int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
>   void cxl_cor_error_detected(struct device *dev);
>   pci_ers_result_t cxl_error_detected(struct device *dev);
>   
> +void cxl_port_cor_error_detected(struct device *dev);
> +pci_ers_result_t cxl_port_error_detected(struct device *dev);
> +
>   /**
>    * struct cxl_endpoint_dvsec_info - Cached DVSEC info
>    * @mem_enabled: cached value of mem_enabled in the DVSEC at init time
> @@ -915,6 +918,8 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>   
>   bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
>   
> +int match_uport(struct device *dev, const void *data);
> +
>   /*
>    * Unit test builds overrides this to __weak, find the 'strong' version
>    * of these symbols in tools/testing/cxl/.
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 6e88331c6303..5efe5a718960 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1018,11 +1018,6 @@ static bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
>   	if (!info || !info->is_cxl)
>   		return false;
>   
> -	/* Only CXL Endpoints are currently supported */
> -	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT) &&
> -	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_EC))
> -		return false;
> -
>   	return is_internal_error(info);
>   }
>   

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


