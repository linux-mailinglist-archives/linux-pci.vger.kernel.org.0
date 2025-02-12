Return-Path: <linux-pci+bounces-21255-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89417A31AA7
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 01:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 748C2188797B
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 00:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB623111AD;
	Wed, 12 Feb 2025 00:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cnQS+/mF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE67101E6;
	Wed, 12 Feb 2025 00:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739320849; cv=none; b=bXYyYx2xjPLGbFN2RY0M2IPy5Te1h8CPDC2LoIEC2De/Z8faccUF5C/gQfgI8U8SaZszfLpcEmS1NRMi23EOavqApNlh8uhNAZJNoLeK+0dls7f90vciBP1BWR2YiR6oNVS/qxulDl3kI90CSfC5MlD5U8poXcvRRTM3m9kgxuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739320849; c=relaxed/simple;
	bh=uPz4Rvng21434DWps/FQmF8howOn/6OJsqcHZ7irxWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fqZbiSOp/ROD9+Fb/w7Gxu4c6Z2V+RpN5HCSQvcvV9C5IbyjpNjRhNpPJHXo2xW1u+qP3imGoLf7iDZB7+kCoT+L928gwMoyn6r4ATPoZ7Mds873aY7yzOrHfVT4hebZmlcNTY2OSc2/c/wLHZLzah1g6o2ZVCbVxyQiD1vxC5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cnQS+/mF; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739320848; x=1770856848;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=uPz4Rvng21434DWps/FQmF8howOn/6OJsqcHZ7irxWA=;
  b=cnQS+/mFCrPLMc4FQNm/G7dOvRO1vWjuTpx+AgZ/kH5ZxdiBzc0A8H2E
   7hxS9znR57CeCw6Evk4KnvJDMV34miy1FfzpDCwqj7JdoEET1b7619h5a
   PUaYH2EIIIv4ybGHc+95ZRDPAcb7FpTwH/9WtiWnoAAedagPZwzjAgnzg
   8uoWOxjKxM7Va35lGExm6VEv+4z5GCkTl3o414ReSubuAhNG7B7Y9Xdgd
   gir/q/402xNEwc0GZ1ggFZqqRqkblT7UmIWrndf6gnEr1CmUCnN5Zx7LZ
   O+kxega0+YlqHBVt19SL9kOr9U21t/2T4+iFg2q3hvvWtJNP0nroBs0YG
   w==;
X-CSE-ConnectionGUID: cp5ajXC4QrueXGnuWzdyjQ==
X-CSE-MsgGUID: jeGw07JLSlKCAODD3ACc/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="50601934"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="50601934"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 16:40:47 -0800
X-CSE-ConnectionGUID: M2+HyNXbRmqKMjf7s7+NVw==
X-CSE-MsgGUID: yGICoRKnTE6xifg9m1cGTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="117747498"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.125.108.65]) ([10.125.108.65])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 16:40:45 -0800
Message-ID: <e10dcf39-f684-4aaa-874c-4a30207fa099@intel.com>
Date: Tue, 11 Feb 2025 17:40:42 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 16/17] PCI/AER: Enable internal errors for CXL Upstream
 and Downstream Switch Ports
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
 <20250211192444.2292833-17-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250211192444.2292833-17-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/11/25 12:24 PM, Terry Bowman wrote:
> The AER service driver enables PCIe Uncorrectable Internal Errors (UIE) and
> Correctable Internal errors (CIE) for CXL Root Ports. The UIE and CIE are
> used in reporting CXL Protocol Errors. The same UIE/CIE enablement is
> needed for CXL Upstream Switch Ports and CXL Downstream Switch Ports
> inorder to notify the associated Root Port and OS.[1]
> 
> Export the AER service driver's pci_aer_unmask_internal_errors() function
> to CXL namespace.
> 
> Remove the function's dependency on the CONFIG_PCIEAER_CXL kernel config
> because it is now an exported function.
> 
> Call pci_aer_unmask_internal_errors() during RAS initialization in:
> cxl_uport_init_ras_reporting() and cxl_dport_init_ras_reporting().
> 
> [1] PCIe Base Spec r6.2-1.0, 6.2.3.2.2 Masking Individual Errors
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/pci.c | 2 ++
>  drivers/pci/pcie/aer.c | 3 ++-
>  include/linux/aer.h    | 1 +
>  3 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 03ae21a944e0..36e686a31045 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -912,6 +912,7 @@ void cxl_uport_init_ras_reporting(struct cxl_port *port)
>  
>  	cxl_assign_port_error_handlers(pdev);
>  	devm_add_action_or_reset(&port->dev, cxl_clear_port_error_handlers, pdev);
> +	pci_aer_unmask_internal_errors(pdev);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_uport_init_ras_reporting, "CXL");
>  
> @@ -959,6 +960,7 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
>  	cxl_assign_port_error_handlers(pdev);
>  	devm_add_action_or_reset(&port->dev, cxl_clear_port_error_handlers, pdev);
>  	put_device(&port->dev);
> +	pci_aer_unmask_internal_errors(pdev);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
>  
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index ee38db08d005..8e3a60411610 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -948,7 +948,7 @@ static bool find_source_device(struct pci_dev *parent,
>   * Note: AER must be enabled and supported by the device which must be
>   * checked in advance, e.g. with pcie_aer_is_native().
>   */
> -static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
> +void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>  {
>  	int aer = dev->aer_cap;
>  	u32 mask;
> @@ -961,6 +961,7 @@ static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>  	mask &= ~PCI_ERR_COR_INTERNAL;
>  	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
>  }
> +EXPORT_SYMBOL_NS_GPL(pci_aer_unmask_internal_errors, "CXL");
>  
>  static bool is_cxl_mem_dev(struct pci_dev *dev)
>  {
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 947b63091902..a54545796edc 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -61,5 +61,6 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  int cper_severity_to_aer(int cper_severity);
>  void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
>  		       int severity, struct aer_capability_regs *aer_regs);
> +void pci_aer_unmask_internal_errors(struct pci_dev *dev);
>  #endif //_AER_H_
>  


