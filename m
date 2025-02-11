Return-Path: <linux-pci+bounces-21234-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47850A31855
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 22:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9D8A3A4CCF
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 21:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D73268681;
	Tue, 11 Feb 2025 21:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AkMUGVTD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A94267AED;
	Tue, 11 Feb 2025 21:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739311163; cv=none; b=dH4PA7WwjtcKGo3aev/QJwrtL3O8pp9xGHFNjfNs3Xi+cz/D1EUrRNn8pnHIwmmo7fg5rLGxS8V/amWJUr+zA5tDpPQIrZLIs564AoExzVxY6Rxs9cfC0mbJeDLgkWusaFTVQUVLS+ERlpoe+XJbLwLjblrbuWxEUH/Xex5lGls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739311163; c=relaxed/simple;
	bh=HHNG9dS8Ep/HZFpPcUrUCKf0Y5dfT3JzOw9HYMuGiCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FnxVegBQ8DfezAAU7wSSN9ypxHH8WWYO3s8ZLMPDvXpzkwtQMUPD3/v9ULB0d3gMzpNIVRsL+SO+XD5Tcr4JAMzgwuiz62OK6HazYZuxJQhRw+6WoSyUkM8rfwVb/xYwjNzBimWioGtjnKuOTOTw/DCWSfYr538CMMFq6UNT8ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AkMUGVTD; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739311161; x=1770847161;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=HHNG9dS8Ep/HZFpPcUrUCKf0Y5dfT3JzOw9HYMuGiCw=;
  b=AkMUGVTDYKLT2dB8W4y6LBvL2VEqJ/gnEEG+VXmuM6W8E9LiENUMzKcL
   15V719ShvqW4QWhQZ4nfKBVHaTJCCnJS0Uoxo22RdWVClTDbi7oXKlDz9
   dgJY/9AZOctBfFvQIKkWmka2n8FEgZuK4YGXy+F9hagC3N9M9m3fZa6vu
   8qqUIFOTXgzRCr3OLOwf3qZkqIpvXiOMj3PX4B4fKD6OVoxMeyKWlnl8q
   zTp5P3SoNcvbk+4vKhL9/RMWibpB2jGGXq3A/HVrKta/oceUbJuRwBQAq
   Db0ZV5gaOeL3EswiUgqA1J0I27x0svJLZssWTrsHJ9/z8zf1NldHKAoJr
   Q==;
X-CSE-ConnectionGUID: y62BIXO+S6SGj42t2rdH+A==
X-CSE-MsgGUID: JdRoPYHnSIyJrMve9cK/2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="43714221"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="43714221"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 13:59:21 -0800
X-CSE-ConnectionGUID: DR5lJ5ZLT5OuyJChBuPEvQ==
X-CSE-MsgGUID: /ugxUpNkSvG7nj4daDEh0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113115735"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.125.108.65]) ([10.125.108.65])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 13:59:18 -0800
Message-ID: <8cb2bf50-2689-4268-b3db-05553dd22e72@intel.com>
Date: Tue, 11 Feb 2025 14:59:17 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/17] PCI/AER: Add CXL PCIe Port uncorrectable error
 recovery in AER service driver
To: Terry Bowman <terry.bowman@amd.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-7-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250211192444.2292833-7-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/11/25 12:24 PM, Terry Bowman wrote:
> Existing recovery procedure for PCIe uncorrectable errors (UCE) does not
> apply to CXL devices. Recovery can not be used for CXL devices because of
> potential corruption on what can be system memory. Also, current PCIe UCE
> recovery, in the case of a Root Port (RP) or Downstream Switch Port (DSP),
> does not begin at the RP/DSP but begins at the first downstream device.
> This will miss handling CXL Protocol Errors in a CXL RP or DSP. A separate
> CXL recovery is needed because of the different handling requirements
> 
> Add a new function, cxl_do_recovery() using the following.
> 
> Add cxl_walk_bridge() to iterate the detected error's sub-topology.
> cxl_walk_bridge() is similar to pci_walk_bridge() but the CXL flavor
> will begin iteration at the RP or DSP rather than beginning at the
> first downstream device.
> 
> pci_walk_bridge() is candidate to possibly reuse cxl_walk_bridge() but
> needs further investigation. This will be left for future improvement
> to make the CXL and PCI handling paths more common.
> 
> Add cxl_report_error_detected() as an analog to report_error_detected().
> It will call pci_driver::cxl_err_handlers for each iterated downstream
> device. The pci_driver::cxl_err_handler's UCE handler returns a boolean
> indicating if there was a UCE error detected during handling.
> 
> cxl_do_recovery() uses the status from cxl_report_error_detected() to
> determine how to proceed. Non-fatal CXL UCE errors will be treated as
> fatal. If a UCE was present during handling then cxl_do_recovery()
> will kernel panic.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/pci/pci.h      |  3 +++
>  drivers/pci/pcie/aer.c |  4 +++
>  drivers/pci/pcie/err.c | 58 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h    |  3 +++
>  4 files changed, 68 insertions(+)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 01e51db8d285..deb193b387af 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -722,6 +722,9 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  		pci_channel_state_t state,
>  		pci_ers_result_t (*reset_subordinates)(struct pci_dev *pdev));
>  
> +/* CXL error reporting and handling */
> +void cxl_do_recovery(struct pci_dev *dev);
> +
>  bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
>  int pcie_retrain_link(struct pci_dev *pdev, bool use_lt);
>  
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 34ec0958afff..ee38db08d005 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1012,6 +1012,8 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>  			err_handler->error_detected(dev, pci_channel_io_normal);
>  		else if (info->severity == AER_FATAL)
>  			err_handler->error_detected(dev, pci_channel_io_frozen);
> +
> +		cxl_do_recovery(dev);
>  	}
>  out:
>  	device_unlock(&dev->dev);
> @@ -1041,6 +1043,8 @@ static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>  			pdrv->cxl_err_handler->cor_error_detected(dev);
>  
>  		pcie_clear_device_status(dev);
> +	} else {
> +		cxl_do_recovery(dev);
>  	}
>  }
>  
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 31090770fffc..05f2d1ef4c36 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -24,6 +24,9 @@
>  static pci_ers_result_t merge_result(enum pci_ers_result orig,
>  				  enum pci_ers_result new)
>  {
> +	if (new == PCI_ERS_RESULT_PANIC)
> +		return PCI_ERS_RESULT_PANIC;
> +
>  	if (new == PCI_ERS_RESULT_NO_AER_DRIVER)
>  		return PCI_ERS_RESULT_NO_AER_DRIVER;
>  
> @@ -276,3 +279,58 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  
>  	return status;
>  }
> +
> +static void cxl_walk_bridge(struct pci_dev *bridge,
> +			    int (*cb)(struct pci_dev *, void *),
> +			    void *userdata)
> +{
> +	if (cb(bridge, userdata))
> +		return;
> +
> +	if (bridge->subordinate)
> +		pci_walk_bus(bridge->subordinate, cb, userdata);
> +}
> +
> +static int cxl_report_error_detected(struct pci_dev *dev, void *data)
> +{
> +	const struct cxl_error_handlers *cxl_err_handler;
> +	pci_ers_result_t vote, *result = data;
> +	struct pci_driver *pdrv;
> +
> +	device_lock(&dev->dev);
> +	pdrv = dev->driver;
> +	if (!pdrv || !pdrv->cxl_err_handler ||
> +	    !pdrv->cxl_err_handler->error_detected)
> +		goto out;
> +
> +	cxl_err_handler = pdrv->cxl_err_handler;
> +	vote = cxl_err_handler->error_detected(dev);
> +	*result = merge_result(*result, vote);
> +out:
> +	device_unlock(&dev->dev);
> +	return 0;
> +}
> +
> +void cxl_do_recovery(struct pci_dev *dev)
> +{
> +	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
> +	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
> +
> +	cxl_walk_bridge(dev, cxl_report_error_detected, &status);
> +	if (status == PCI_ERS_RESULT_PANIC)
> +		panic("CXL cachemem error.");
> +
> +	/*
> +	 * If we have native control of AER, clear error status in the device
> +	 * that detected the error.  If the platform retained control of AER,
> +	 * it is responsible for clearing this status.  In that case, the
> +	 * signaling device may not even be visible to the OS.
> +	 */
> +	if (host->native_aer || pcie_ports_native) {
> +		pcie_clear_device_status(dev);
> +		pci_aer_clear_nonfatal_status(dev);
> +		pci_aer_clear_fatal_status(dev);
> +	}
> +
> +	pci_info(dev, "CXL uncorrectable error.\n");
> +}
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 82a0401c58d3..5b539b5bf0d1 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -864,6 +864,9 @@ enum pci_ers_result {
>  
>  	/* No AER capabilities registered for the driver */
>  	PCI_ERS_RESULT_NO_AER_DRIVER = (__force pci_ers_result_t) 6,
> +
> +	/* System is unstable, panic  */
> +	PCI_ERS_RESULT_PANIC = (__force pci_ers_result_t) 7,
>  };
>  
>  /* PCI bus error event callbacks */


