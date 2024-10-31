Return-Path: <linux-pci+bounces-15737-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D768F9B8041
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 17:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 062F71C2196D
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 16:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF2519CCEA;
	Thu, 31 Oct 2024 16:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gGuWtCPt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE724CA6B;
	Thu, 31 Oct 2024 16:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730392643; cv=none; b=Ds3kV/VEcgcapU4T3Z998p4Fg87l9Zs/U36mecfjHYi/8daZ5xSwobA7wNj71/b3Pz30z4y17son9RWJcoTTsI2MGu2hV5rYrcy4BMkm84gBbEJdlNnjepkwarXRQ7GFn2xHFMsJY2o1PxPVNhhM3Bq1ZVhXpRb6vyTxdsDhp2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730392643; c=relaxed/simple;
	bh=CWuytdwFjVNhOZ5aXDIDvQbiDmrTte+EhXq6nl7T+IQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=O/FqcyYkKA2pdXzPb1Mylae3aSXVRMh6fOwDwdpAUT+vwuQQKqQZRedC7gxA2X959VYG2nSoKh0/cymKBxOE+6HH7Rw2upLDpb6iMHpvY/yz7ZDuXKKXWFT4E6erjZxT+eY3SDjeWePw3cDX0AgbLgd7DzxJ0F8QjeVmt6aY/EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gGuWtCPt; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730392641; x=1761928641;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=CWuytdwFjVNhOZ5aXDIDvQbiDmrTte+EhXq6nl7T+IQ=;
  b=gGuWtCPtrrHmGptXCm+fQ+M6zwXXicH0oMl0sU2sWY1C0K7g9kvL1yyj
   RMEl5jrSLvhEVVBcPgQgThjgGXqdVAXwAJV1VbpySeDlsbw9VZ1Dd07L4
   MGteav02A+0nvMoBcXCHtVrWFZGrbX1vQ4zFqf9BIXOfmFKM4sTFL8AYz
   qKqUZqmAUVqPsAvfTvSRNQy8q8jfURxQsplFjJc5+Vf9GYmaOLB/8c/0M
   qMsQyNEUsAEEfVN7InU5DX0rHOLYYHmX3sVkOhmPDY8Gdx4ziexKbgp4t
   9rsCkf34ArNHmsVydFXOCvfZJmvF8NzilZARewOj8bVF5pyuMbvPPzRhz
   w==;
X-CSE-ConnectionGUID: MqjzAEyGTtm3MKw2atOtEA==
X-CSE-MsgGUID: CQuv9RFvThGBhFwodsc+Bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="32980106"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="32980106"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 09:37:18 -0700
X-CSE-ConnectionGUID: IQ+MNz/hQPinjJ0TXR7bkg==
X-CSE-MsgGUID: hEk4zaQETkmywsQMJ/qirw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="82577912"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.108.232]) ([10.125.108.232])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 09:37:17 -0700
Message-ID: <9e602b57-c064-43a3-ab57-343773c07863@intel.com>
Date: Thu, 31 Oct 2024 09:37:15 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/14] PCI/AER: Add CXL PCIe port correctable error
 support in AER service driver
To: Terry Bowman <terry.bowman@amd.com>, ming4.li@intel.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com
References: <20241025210305.27499-1-terry.bowman@amd.com>
 <20241025210305.27499-6-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241025210305.27499-6-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/25/24 2:02 PM, Terry Bowman wrote:
> The AER service driver doesn't currently handle CXL protocol errors
> reported by CXL root ports, CXL upstream switch ports, and CXL downstream
> switch ports. Consequently, RAS protocol errors from CXL PCIe port devices
> are not properly logged or handled.
> 
> These errors are reported to the OS via the root port's AER correctable
> and uncorrectable internal error fields. While the AER driver supports
> handling downstream port protocol errors in restricted CXL host (RCH) mode
> also known as CXL1.1, it lacks the same functionality for CXL PCIe ports
> operating in virtual hierarchy (VH) mode.
> 
> To address this gap, update the AER driver to handle CXL PCIe port device
> protocol correctable errors (CE).
> 
> Make this update alongside the existing downstream port RCH error handling
> logic, extending support to CXL PCIe ports in VH mode.
> 
> is_internal_error() is currently limited by CONFIG_PCIEAER_CXL kernel
> config. Update is_internal_error()'s function declaration such that it is
> always available regardless if CONFIG_PCIEAER_CXL kernel config is enabled
> or disabled.
> 
> The uncorrectable error (UCE) handling will be added in a future patch.
> 
> [1] CXL 3.1 Spec, 12.2.2 CXL Root Ports, Downstream Switch Ports, and
> Upstream Switch Ports
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

With the commit log update from what Jonathan suggested,
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/pci/pcie/aer.c | 59 ++++++++++++++++++++++++++++--------------
>  1 file changed, 39 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 53e9a11f6c0f..1d3e5b929661 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -941,8 +941,15 @@ static bool find_source_device(struct pci_dev *parent,
>  	return true;
>  }
>  
> -#ifdef CONFIG_PCIEAER_CXL
> +static bool is_internal_error(struct aer_err_info *info)
> +{
> +	if (info->severity == AER_CORRECTABLE)
> +		return info->status & PCI_ERR_COR_INTERNAL;
>  
> +	return info->status & PCI_ERR_UNC_INTN;
> +}
> +
> +#ifdef CONFIG_PCIEAER_CXL
>  /**
>   * pci_aer_unmask_internal_errors - unmask internal errors
>   * @dev: pointer to the pcie_dev data structure
> @@ -994,14 +1001,6 @@ static bool cxl_error_is_native(struct pci_dev *dev)
>  	return (pcie_ports_native || host->native_aer);
>  }
>  
> -static bool is_internal_error(struct aer_err_info *info)
> -{
> -	if (info->severity == AER_CORRECTABLE)
> -		return info->status & PCI_ERR_COR_INTERNAL;
> -
> -	return info->status & PCI_ERR_UNC_INTN;
> -}
> -
>  static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>  {
>  	struct aer_err_info *info = (struct aer_err_info *)data;
> @@ -1033,14 +1032,23 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>  
>  static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>  {
> -	/*
> -	 * Internal errors of an RCEC indicate an AER error in an
> -	 * RCH's downstream port. Check and handle them in the CXL.mem
> -	 * device driver.
> -	 */
> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
> -	    is_internal_error(info))
> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
>  		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
> +
> +	if (info->severity == AER_CORRECTABLE) {
> +		struct pci_driver *pdrv = dev->driver;
> +		int aer = dev->aer_cap;
> +
> +		if (aer)
> +			pci_write_config_dword(dev, aer + PCI_ERR_COR_STATUS,
> +					       info->status);
> +
> +		if (pdrv && pdrv->cxl_err_handler &&
> +		    pdrv->cxl_err_handler->cor_error_detected)
> +			pdrv->cxl_err_handler->cor_error_detected(dev);
> +
> +		pcie_clear_device_status(dev);
> +	}
>  }
>  
>  static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
> @@ -1058,9 +1066,13 @@ static bool handles_cxl_errors(struct pci_dev *dev)
>  {
>  	bool handles_cxl = false;
>  
> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
> -	    pcie_aer_is_native(dev))
> +	if (!pcie_aer_is_native(dev))
> +		return false;
> +
> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
>  		pcie_walk_rcec(dev, handles_cxl_error_iter, &handles_cxl);
> +	else
> +		handles_cxl = pcie_is_cxl_port(dev);
>  
>  	return handles_cxl;
>  }
> @@ -1078,6 +1090,10 @@ static void cxl_enable_internal_errors(struct pci_dev *dev)
>  static inline void cxl_enable_internal_errors(struct pci_dev *dev) { }
>  static inline void cxl_handle_error(struct pci_dev *dev,
>  				    struct aer_err_info *info) { }
> +static bool handles_cxl_errors(struct pci_dev *dev)
> +{
> +	return false;
> +}
>  #endif
>  
>  /**
> @@ -1115,8 +1131,11 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>  
>  static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>  {
> -	cxl_handle_error(dev, info);
> -	pci_aer_handle_error(dev, info);
> +	if (is_internal_error(info) && handles_cxl_errors(dev))
> +		cxl_handle_error(dev, info);
> +	else
> +		pci_aer_handle_error(dev, info);
> +
>  	pci_dev_put(dev);
>  }
>  


