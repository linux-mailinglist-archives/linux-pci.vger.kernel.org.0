Return-Path: <linux-pci+bounces-37235-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91556BAACBD
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 02:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422C51C387E
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 00:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F355190473;
	Tue, 30 Sep 2025 00:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mTfpx1mb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25568192B75;
	Tue, 30 Sep 2025 00:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759192022; cv=none; b=DoFlRAXzVr0fy38Rry7ZmrtUKWgaxOnM1ssXov5/LUortO3pQ2Y0gFyIHM5g5dzh41oanggcXJoHGuqXkiu6o7jL/cXAoPAp7i1zWpIfSbW8nCldB41AZVwz6RaCpcqm6pLzFChVuX3IUfdK8TLEXWi7MU7W8JMfmvjOo7611NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759192022; c=relaxed/simple;
	bh=SHTvx8Nimb6ustRnRsJna2nD3Dahm31GuFPQ1C5380U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pwj39fvCx4gYdLEgmPdbqqw8PYPGjDtxFGFFkGQD0wQbeqxqJuWsH9Z2JNAzGmBNKnQ0OdR603IAdbKXP7JU2dQqsLz8Reh3JQzEhpjIPZ4t1U9MVB/29vRlg4Y1QOZtlRY0HXR/Gp2xTYnc9vwXeXjlWghf/KtDUukprDVsLN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mTfpx1mb; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759192020; x=1790728020;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SHTvx8Nimb6ustRnRsJna2nD3Dahm31GuFPQ1C5380U=;
  b=mTfpx1mbP3ql1qRwLBUZ5/Law7sqVL5+8mJ1Imk/pefSmKubkqzLaVhK
   fTTWPq4SKc4AZAwwDtZ7i6Xktblg0H+MAewi8QIuMcjCX9xEyBjS8aQhv
   5k0uQ9anpd69WO4l4v80z31S2wWmXLmBVIOS+p2aHy8J9ZeqMG+P92vNs
   K004lBi5zK+FWJ846zZyX1RlqbqZHzJZeGB5AdcEGFpm1/4PmxqUfdKFK
   shzG0/Z1xs0yPxv3wku+OwA/jEXUa16FFpbhiMXp/Ra86gCZg3CZbk4Re
   yaU3Wdfa5nmTNaXVZGTylw928e0VgIQHjI1JHW5yZqLI2NpXtmK+bBF6d
   A==;
X-CSE-ConnectionGUID: 0YbubtHaTuiQv3AKqNcEPg==
X-CSE-MsgGUID: sAOS1d60ReuGyWj8jgpgHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="61485362"
X-IronPort-AV: E=Sophos;i="6.18,302,1751266800"; 
   d="scan'208";a="61485362"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 17:26:59 -0700
X-CSE-ConnectionGUID: ozNDHWdfTHmwy0IffrVh7g==
X-CSE-MsgGUID: 12VK6v2cQjmZb0Ozs1EbhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,302,1751266800"; 
   d="scan'208";a="178410157"
Received: from tslove-mobl4.amr.corp.intel.com (HELO [10.125.109.142]) ([10.125.109.142])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 17:26:59 -0700
Message-ID: <d3d3ab84-8cdd-4386-82dd-de8149159985@intel.com>
Date: Mon, 29 Sep 2025 17:26:57 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 23/25] CXL/PCI: Introduce CXL uncorrectable protocol
 error recovery
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
 <20250925223440.3539069-24-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250925223440.3539069-24-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/25/25 3:34 PM, Terry Bowman wrote:
> Populate the cxl_do_recovery() function with uncorrectable protocol error (UCE)
> handling. Follow similar design as found in PCIe error driver,
> pcie_do_recovery(). One difference is cxl_do_recovery() will treat all UCEs
> as fatal with a kernel panic. This is to prevent corruption on CXL memory.
> 
> Introduce cxl_walk_port(). Make this analogous to pci_walk_bridge() but walking
> CXL ports instead. This will iterate through the CXL topology from the
> erroring device through the downstream CXL Ports and Endpoints.
> 
> Export pci_aer_clear_fatal_status() for CXL to use if a UCE is not found.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> ---
> 
> Changes in v11->v12:
> - Cleaned up port discovery in cxl_do_recovery() (Dave)
> - Added PCI_EXP_TYPE_RC_END to type check in cxl_report_error_detected()
> 
> Changes in v10->v11:
> - pci_ers_merge_results() - Move to earlier patch
> ---
>  drivers/cxl/core/ras.c | 111 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 111 insertions(+)
> 
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 7e8d63c32d72..45f92defca64 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -443,8 +443,119 @@ void cxl_endpoint_port_init_ras(struct cxl_port *ep)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_endpoint_port_init_ras, "CXL");
>  
> +static int cxl_report_error_detected(struct device *dev, void *data)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	pci_ers_result_t vote, *result = data;
> +
> +	guard(device)(dev);
> +
> +	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT) ||
> +	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END)) {
> +		if (!cxl_pci_drv_bound(pdev))
> +			return 0;
> +
> +		vote = cxl_error_detected(dev);
> +	} else {
> +		vote = cxl_port_error_detected(dev);
> +	}
> +
> +	*result = pci_ers_merge_result(*result, vote);
> +
> +	return 0;
> +}
> +
> +static int match_port_by_parent_dport(struct device *dev, const void *dport_dev)
> +{
> +	struct cxl_port *port;
> +
> +	if (!is_cxl_port(dev))
> +		return 0;
> +
> +	port = to_cxl_port(dev);
> +
> +	return port->parent_dport->dport_dev == dport_dev;
> +}
> +
> +static void cxl_walk_port(struct device *port_dev,
> +			  int (*cb)(struct device *, void *),
> +			  void *userdata)
> +{
> +	struct cxl_dport *dport = NULL;
> +	struct cxl_port *port;
> +	unsigned long index;
> +
> +	if (!port_dev)
> +		return;
> +
> +	port = to_cxl_port(port_dev);
> +	if (port->uport_dev && dev_is_pci(port->uport_dev))
> +		cb(port->uport_dev, userdata);

Could use some comments on what is being walked. Also an explanation of what is happening here would be good.

If this is an endpoint port, this would be the PCI endpoint device.
If it's a switch port, then this is the upstream port.
If it's a root port, this is skipped.

> +
> +	xa_for_each(&port->dports, index, dport)
> +	{
> +		struct device *child_port_dev __free(put_device) =
> +			bus_find_device(&cxl_bus_type, &port->dev, dport->dport_dev,
> +					match_port_by_parent_dport);
> +
> +		cb(dport->dport_dev, userdata);

This is going through all the downstream ports
> +
> +		cxl_walk_port(child_port_dev, cxl_report_error_detected, userdata);
> +	}
> +
> +	if (is_cxl_endpoint(port))
> +		cb(port->uport_dev->parent, userdata);

And this is the downstream parent port of the endpoint device

Why not move this before the xa_for_each() and return early? endpoint ports don't have dports, no need to even try to run that block above.

So in the current implementation,
1. Endpoint. It checks the device, and then it checks the downstream parent port for errors. Is checking the parent dport necessary?
2. Switch. It checks the upstream port, then it checks all the downstream ports for errors.
3. Root port. It checks all the downstream ports for errors.
Is this the correct understanding of what this function does?

> +}
> +
>  static void cxl_do_recovery(struct device *dev)
>  {
> +	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct cxl_port *port = NULL;
> +
> +	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
> +	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)) {
> +		struct cxl_dport *dport;
> +		struct cxl_port *rp_port __free(put_cxl_port) = find_cxl_port(&pdev->dev, &dport);
> +
> +		port = rp_port;
> +
> +	} else	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM) {
> +		struct cxl_port *us_port __free(put_cxl_port) = find_cxl_port_by_uport(&pdev->dev);
> +
> +		port = us_port;
> +
> +	} else	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT) ||
> +		    (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END)) {
> +		struct cxl_dev_state *cxlds;
> +
> +		if (!cxl_pci_drv_bound(pdev))
> +			return;

Need to have the pci dev lock before checking driver bound.

DJ
> +
> +		cxlds = pci_get_drvdata(pdev);
> +		port = cxlds->cxlmd->endpoint;
> +	}
> +
> +	if (!port) {
> +		dev_err(dev, "Failed to find the CXL device\n");
> +		return;
> +	}
> +
> +	cxl_walk_port(&port->dev, cxl_report_error_detected, &status);
> +	if (status == PCI_ERS_RESULT_PANIC)
> +		panic("CXL cachemem error.");
> +
> +	/*
> +	 * If we have native control of AER, clear error status in the device
> +	 * that detected the error.  If the platform retained control of AER,
> +	 * it is responsible for clearing this status.  In that case, the
> +	 * signaling device may not even be visible to the OS.
> +	 */
> +	if (cxl_error_is_native(pdev)) {
> +		pcie_clear_device_status(pdev);
> +		pci_aer_clear_nonfatal_status(pdev);
> +		pci_aer_clear_fatal_status(pdev);
> +	}
>  }
>  
>  static void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)


