Return-Path: <linux-pci+bounces-37234-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE92BAAC0D
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 01:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C10711920976
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 23:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197001D88A4;
	Mon, 29 Sep 2025 23:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YdlcjDpZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EE5CA4E;
	Mon, 29 Sep 2025 23:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759188757; cv=none; b=NqVlTWKN/4U5smQug+gKMz1G3pvC3IU3KkrKGytf4ly87CKFJ4rgnBVLykqDZcMxWYpP87wEJQnAdtl3V4MrNfmbtTueB3FzGjN3O25VFsgwNzwWQ38N3ASzkioTV+VWgjU9Qw7fu6O67jYIfC79Q5VMrFCv9bjdgDJlXbvhpx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759188757; c=relaxed/simple;
	bh=AywZA446o/QqxUcU6jahntUDSyzL7XK+xwOHnfdq+Ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L3k3XR0ETaQkMjy4VsTpHek0kgDs3cLzp4MXBxdiiiMVCXNY1GChbDQNpLAo+yw1nNh3EREK0l/ahSizZk/LfMcCKqOozXp1U+YIJf8OYMYX4yaGllkT37sBN/tG5kbUG6U/W6lf29g9FAFvBla2KTKd7+RJDt+fH4qOSRqaZ9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YdlcjDpZ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759188754; x=1790724754;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AywZA446o/QqxUcU6jahntUDSyzL7XK+xwOHnfdq+Ak=;
  b=YdlcjDpZnMh+Lz+Ze3eZy/ugvyn/4e97QROTdNkrvmsGDaLDahrOZ5ul
   6qd+8XASZrOysudcpAQpT41//2VcRPyPveMJ1pZvynl16tbdssIeaLwMU
   k9utIEzhfHE9iII10QrntFfSWk7Gebw9SKL/wc7kTGgC7LV0x2k1NRBsE
   XuzQHPAV0lWAWsQlKj2VH5e+9SmH7hqKUAdTVAITDvKD8bwhpdxHv5uGm
   UatifcEVrhWs+CvmSfGnftFu+1/KGF8fHJBIpdHHHWabJSbsKyWZ8uRT1
   sTvh+i+nMSagGuBYPoM93eVFRkrtU2yv88Vj11V0So4lFC5yCqonIUc/y
   Q==;
X-CSE-ConnectionGUID: ENOwkkHmSkCu3CI3D09T+g==
X-CSE-MsgGUID: lkfxvnyxRPu4yC1wtBpU4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="78862122"
X-IronPort-AV: E=Sophos;i="6.18,302,1751266800"; 
   d="scan'208";a="78862122"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 16:32:33 -0700
X-CSE-ConnectionGUID: sliCS1nRQbm8o+b+iW+32Q==
X-CSE-MsgGUID: G1Fl3+BISfeOc1ZpA83EAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,302,1751266800"; 
   d="scan'208";a="182646937"
Received: from spandruv-mobl4.amr.corp.intel.com (HELO [10.125.109.116]) ([10.125.109.116])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 16:32:32 -0700
Message-ID: <1a78d263-eff4-4f85-b3a3-cdf3a0c7c906@intel.com>
Date: Mon, 29 Sep 2025 16:32:31 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 21/25] CXL/PCI: Introduce CXL Port protocol error
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
 <20250925223440.3539069-22-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250925223440.3539069-22-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/25/25 3:34 PM, Terry Bowman wrote:
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
> 
> Changes in v11->v12:
> - Add call to cxl_pci_drv_bound() in cxl_handle_proto_error() and
>   pci_to_cxl_dev()
> - Change cxl_error_detected() -> cxl_cor_error_detected()
> - Remove NULL variable assignments
> - Replace bus_find_device() with find_cxl_port_by_uport() for upstream
>   port searches.
> 
> Changes in v10->v11:
> - None
> ---
>  drivers/cxl/core/core.h       |  10 +++
>  drivers/cxl/core/port.c       |   7 +-
>  drivers/cxl/core/ras.c        | 159 ++++++++++++++++++++++++++++++++--
>  drivers/pci/pcie/aer_cxl_vh.c |   5 +-
>  4 files changed, 170 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 9ceff8acf844..3197a71bf7b8 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -156,6 +156,8 @@ pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
>  void pci_cor_error_detected(struct pci_dev *pdev);
>  void cxl_cor_error_detected(struct device *dev);
>  pci_ers_result_t cxl_error_detected(struct device *dev);
> +void cxl_port_cor_error_detected(struct device *dev);
> +pci_ers_result_t cxl_port_error_detected(struct device *dev);
>  #else
>  static inline int cxl_ras_init(void)
>  {
> @@ -180,9 +182,17 @@ static inline pci_ers_result_t cxl_error_detected(struct device *dev)
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
> +struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev);
>  
>  struct cxl_hdm;
>  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 56fa4ac33e8b..f34a44abb2c9 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1357,8 +1357,8 @@ static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
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
> @@ -1561,7 +1561,7 @@ static int match_port_by_uport(struct device *dev, const void *data)
>   * Function takes a device reference on the port device. Caller should do a
>   * put_device() when done.
>   */
> -static struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
> +struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
>  {
>  	struct device *dev;
>  
> @@ -1570,6 +1570,7 @@ static struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
>  		return to_cxl_port(dev);
>  	return NULL;
>  }
> +EXPORT_SYMBOL_NS_GPL(find_cxl_port_by_uport, "CXL");

Why export this in this commit? Not seeing usage outside of core/ras.c.

>  
>  static int update_decoder_targets(struct device *dev, void *data)
>  {
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 9acfe24ba3bb..7e8d63c32d72 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -250,6 +250,129 @@ static void cxl_dport_map_ras(struct cxl_dport *dport)
>  		dev_dbg(dev, "Failed to map RAS capability.\n");
>  }
>  
> +static void __iomem *cxl_get_ras_base(struct device *dev)
I think this can be a pci_dev for input

> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_ROOT_PORT:
> +	case PCI_EXP_TYPE_DOWNSTREAM:
> +	{
> +		struct cxl_dport *dport;
> +		struct cxl_port *port __free(put_cxl_port) = find_cxl_port(&pdev->dev, &dport);
> +
> +		if (!dport || !dport->dport_dev) {
Is it possible to have a 'cxl_dport' but not a dport->dport_dev?

> +			pci_err(pdev, "Failed to find the CXL device");
> +			return NULL;
> +		}
> +
> +		return dport->regs.ras;
> +	}
> +	case PCI_EXP_TYPE_UPSTREAM:
> +	{
> +		struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_uport(&pdev->dev);
> +
> +		if (!port) {
> +			pci_err(pdev, "Failed to find the CXL device");
> +			return NULL;
> +		}
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

I think this should return a pci_dev right?

Also, are you using this function to verify that it belongs to a valid CXL port hierarchy? Otherwise you are just returning &pdev->dev looks like?

It seems like you can rename pci_to_cxl_dev() to has_cxl_port(). And later on you can do:

struct pci_dev *pdev __free(pci_dev_put) = has_cxl_port(err_info->pdev) ? pci_dev_get(err_info->pdev) : NULL;

And then you can pass in pdev to all the calls after after checking to make sure pdev isn't NULL.

> +{
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_ROOT_PORT:
> +	case PCI_EXP_TYPE_DOWNSTREAM:
> +	{
> +		struct cxl_dport *dport;
> +		struct cxl_port *port __free(put_cxl_port) = find_cxl_port(&pdev->dev, &dport);
> +
> +		if (!port) {
> +			pci_err(pdev, "Failed to find the CXL device");
> +			return NULL;
> +		}
> +
> +		return dport->dport_dev;
> +	}
> +	case PCI_EXP_TYPE_UPSTREAM:
> +	{
> +		struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_uport(&pdev->dev);
> +
> +		if (!port) {
> +			pci_err(pdev, "Failed to find the CXL device");
> +			return NULL;
> +		}
> +
> +		return port->uport_dev;
> +	}
> +	case PCI_EXP_TYPE_ENDPOINT:
> +	{
> +		struct cxl_dev_state *cxlds;
> +
> +		if (!cxl_pci_drv_bound(pdev))
> +			return NULL;
> +
> +		cxlds = pci_get_drvdata(pdev);
> +		return cxlds->dev;
> +	}
> +	}
> +
> +	pci_warn_once(pdev, "Error: Unsupported device type (%X)", pci_pcie_type(pdev));
> +	return NULL;
> +}
> +
> +/*
> + * Return 'struct device *' responsible for freeing pdev's CXL resources.
> + * Caller is responsible for reference count decrementing the return
> + * 'struct device *'.
> + *
> + * dev: Find the host of this dev
> + */
> +static struct device *get_cxl_host_dev(struct device *dev)

get_cxl_port_dev()?

> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_ROOT_PORT:
> +	case PCI_EXP_TYPE_DOWNSTREAM:
> +	{
> +		struct cxl_dport *dport;
> +		struct cxl_port *port __free(put_cxl_port) = find_cxl_port(&pdev->dev, &dport);
> +
> +		if (!port) {
> +			pci_err(pdev, "Failed to find the CXL device");
> +			return NULL;
> +		}
> +
> +		return &port->dev;
> +	}
> +	case PCI_EXP_TYPE_UPSTREAM:
> +	{
> +		struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_uport(&pdev->dev);
> +
> +		if (!port) {
> +			pci_err(pdev, "Failed to find the CXL device");
> +			return NULL;
> +		}
> +
> +		return &port->dev;
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
> @@ -399,6 +522,22 @@ static pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial, void __io
>  	return PCI_ERS_RESULT_PANIC;
>  }
>  
> +void cxl_port_cor_error_detected(struct device *dev)

pci_dev?

> +{
> +	void __iomem *ras_base = cxl_get_ras_base(dev);
> +
> +	cxl_handle_cor_ras(dev, 0, ras_base);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_port_cor_error_detected, "CXL");
> +
> +pci_ers_result_t cxl_port_error_detected(struct device *dev)

pci_dev?

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
> @@ -469,9 +608,8 @@ EXPORT_SYMBOL_NS_GPL(pci_error_detected, "CXL");
>  static void cxl_handle_proto_error(struct cxl_proto_err_work_data *err_info)
>  {
>  	struct pci_dev *pdev = err_info->pdev;
> -	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> -	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> -	struct device *host_dev __free(put_device) = get_device(&cxlmd->dev);
> +	struct device *dev = pci_to_cxl_dev(pdev);
> +	struct device *host_dev __free(put_device) = get_cxl_host_dev(&pdev->dev);

At this point, host_dev is not being used anywhere. Belongs in a different patch?

>  
>  	if (err_info->severity == AER_CORRECTABLE) {
>  		int aer = pdev->aer_cap;
> @@ -483,13 +621,20 @@ static void cxl_handle_proto_error(struct cxl_proto_err_work_data *err_info)
>  						       aer + PCI_ERR_COR_STATUS,
>  						       0, PCI_ERR_COR_INTERNAL);
>  
> -		if (!cxl_pci_drv_bound(pdev))
> -			return;
> +		if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT) {
> +
> +			if (!cxl_pci_drv_bound(pdev))
> +				return;
> +
> +			cxl_cor_error_detected(dev);

Using dev w/o checking if it's NULL. pci_to_cxl_dev() can return NULL.

DJ

> +
> +		} else {
> +			cxl_port_cor_error_detected(dev);
> +		}
>  
> -		cxl_cor_error_detected(&cxlmd->dev);
>  		pcie_clear_device_status(pdev);
>  	} else {
> -		cxl_do_recovery(&cxlmd->dev);
> +		cxl_do_recovery(dev);
>  	}
>  }
>  
> diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
> index 8c0979299446..dbd7cb5d1a0a 100644
> --- a/drivers/pci/pcie/aer_cxl_vh.c
> +++ b/drivers/pci/pcie/aer_cxl_vh.c
> @@ -43,7 +43,10 @@ bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
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


