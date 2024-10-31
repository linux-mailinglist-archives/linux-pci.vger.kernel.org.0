Return-Path: <linux-pci+bounces-15726-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B29939B7FE1
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 17:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 715AE2810AC
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 16:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4F31BBBE0;
	Thu, 31 Oct 2024 16:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Epjb2Ij5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCCD1BBBD6;
	Thu, 31 Oct 2024 16:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730391679; cv=none; b=houYJ9LE/tRg5+ZVhON9OOsHg5Neb/sVreL56YWyuXTsF8gKfWk5dRAaNAAK2AzDT0HlabpQgWC/M4NUNOsEdhTbv3FIiw8E+9Vc7p++XIZu4lzHe5EZCM8Bwtfsw1SI2x0PHzjreiO1ccUGDr7Q/7SQUHW8RUjyBuOvXA+z22s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730391679; c=relaxed/simple;
	bh=CdXx1JIY5Fppr8hDxAedta9mTqEBilxS5Z9Y6Eqje2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aQlQesRXV+b9RqAXNLmS0cSjT7jK7iY4IiRIJH4aTbzvzfKnJwHZIPNbS9l0oJEif2Im0Pznl/oKb6uqfuU0d6Kqrsdg2Kbk04emmdDYEY5zaKwM9BdMi3DNXVAERl7anL9KwqPAsnDnqf71tzemO98PZcG7tgrGtKqvVuQAmV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Epjb2Ij5; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730391677; x=1761927677;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=CdXx1JIY5Fppr8hDxAedta9mTqEBilxS5Z9Y6Eqje2w=;
  b=Epjb2Ij538rvP53P6InM6BW64Ec4BObvV+5BIqvhZytp+RxBdzuamu7U
   muiJYKrBtx9rteHlM/2LDWd1ej9hYQK8gWS7J6hC7f7oN9i53hLpYQTMy
   Q+qmfYn/OBF0Ke5s5fnsLlCw+rFgAWXYYA+XDPA511oo37n2773Bz/6zc
   ya41sdDARq2m7niUfKkuuINrF5p3GfjoUPW3d9V1ElBPLBT2X6N3WGgMN
   qzSM9xGiYJ/hZqQ7LPGUxKS7rXhd7Mp0u76OndGmQ+LIRp0M++cEZ/Air
   k6QBAKnpGfWG043H9y0zVlUHFfO+x8Jpr5aBoFhAJi1nEhcMN2fCjDLKx
   g==;
X-CSE-ConnectionGUID: FlUuuLjmTnegOI12apSvbA==
X-CSE-MsgGUID: bpSexOP4RC+bxAGOIFkqbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="30032105"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="30032105"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 09:21:15 -0700
X-CSE-ConnectionGUID: M4UqB8K+S0Gk5DO42/vtnw==
X-CSE-MsgGUID: HMUn+UNyQRiKaB5oNU9rOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="113458555"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.108.232]) ([10.125.108.232])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 09:21:13 -0700
Message-ID: <32ee3523-9234-4e51-9199-5cbbabb5a0ed@intel.com>
Date: Thu, 31 Oct 2024 09:21:12 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/14] PCI/AER: Rename AER driver's interfaces to also
 indicate CXL PCIe port support
To: Terry Bowman <terry.bowman@amd.com>, ming4.li@intel.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com
References: <20241025210305.27499-1-terry.bowman@amd.com>
 <20241025210305.27499-3-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241025210305.27499-3-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/25/24 2:02 PM, Terry Bowman wrote:
> The AER service driver already includes support for CXL restricted host
> (RCH) downstream port error handling. The current implementation is based
> on CXL1.1 using a root complex event collector.
> 
> Rename function interfaces and parameters where necessary to include
> virtual hierarchy (VH) mode CXL PCIe port error handling alongside the RCH
> handling.[1] The CXL PCIe port error handling will be added in a future
> patch.
> 
> Limit changes to renaming variable and function names. No functional
> changes are added.
> 
> [1] CXL 3.1 Spec, 9.12.2 CXL Virtual Hierarchy
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/pci/pcie/aer.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 13b8586924ea..fe6edf26279e 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1029,7 +1029,7 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>  	return 0;
>  }
>  
> -static void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
> +static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>  {
>  	/*
>  	 * Internal errors of an RCEC indicate an AER error in an
> @@ -1052,30 +1052,30 @@ static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
>  	return *handles_cxl;
>  }
>  
> -static bool handles_cxl_errors(struct pci_dev *rcec)
> +static bool handles_cxl_errors(struct pci_dev *dev)
>  {
>  	bool handles_cxl = false;
>  
> -	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC &&
> -	    pcie_aer_is_native(rcec))
> -		pcie_walk_rcec(rcec, handles_cxl_error_iter, &handles_cxl);
> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
> +	    pcie_aer_is_native(dev))
> +		pcie_walk_rcec(dev, handles_cxl_error_iter, &handles_cxl);
>  
>  	return handles_cxl;
>  }
>  
> -static void cxl_rch_enable_rcec(struct pci_dev *rcec)
> +static void cxl_enable_internal_errors(struct pci_dev *dev)
>  {
> -	if (!handles_cxl_errors(rcec))
> +	if (!handles_cxl_errors(dev))
>  		return;
>  
> -	pci_aer_unmask_internal_errors(rcec);
> -	pci_info(rcec, "CXL: Internal errors unmasked");
> +	pci_aer_unmask_internal_errors(dev);
> +	pci_info(dev, "CXL: Internal errors unmasked");
>  }
>  
>  #else
> -static inline void cxl_rch_enable_rcec(struct pci_dev *dev) { }
> -static inline void cxl_rch_handle_error(struct pci_dev *dev,
> -					struct aer_err_info *info) { }
> +static inline void cxl_enable_internal_errors(struct pci_dev *dev) { }
> +static inline void cxl_handle_error(struct pci_dev *dev,
> +				    struct aer_err_info *info) { }
>  #endif
>  
>  /**
> @@ -1113,7 +1113,7 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>  
>  static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>  {
> -	cxl_rch_handle_error(dev, info);
> +	cxl_handle_error(dev, info);
>  	pci_aer_handle_error(dev, info);
>  	pci_dev_put(dev);
>  }
> @@ -1491,7 +1491,7 @@ static int aer_probe(struct pcie_device *dev)
>  		return status;
>  	}
>  
> -	cxl_rch_enable_rcec(port);
> +	cxl_enable_internal_errors(port);
>  	aer_enable_rootport(rpc);
>  	pci_info(port, "enabled with IRQ %d\n", dev->irq);
>  	return 0;


