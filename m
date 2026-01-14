Return-Path: <linux-pci+bounces-44873-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D33D2178D
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 22:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F29E3011A6B
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 21:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B58C3A8FF9;
	Wed, 14 Jan 2026 21:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nnGNqyAA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDF23587C0;
	Wed, 14 Jan 2026 21:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768427742; cv=none; b=Gr1INVDZ+FmC6LjEb6iT3DiZ5uPD77zMZjPPGxPiBOiP6Dy7tKhWARhzW4RMdTt6VEMyCuZ5rG4wuHYaexyq6i+RgdbI865BTBFYIoeCRbKmJjIXVmFAP3qWN65oMfWfRNOQ8hZ8AoZN0rlrGQMyfvMLnFM35+9ks/NqOGZfLIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768427742; c=relaxed/simple;
	bh=I6Px+RrAENui+ogNikf0bieFPGuFc8D/K48Nc+ZS9pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tPoIVRVB6unq+z5v9XzEU6UG3u0xozuZuBZ7fuw2u9QkHTAhPNyf2RtHb5zH62x9TxbOV4mKCSwOze3RDbUQ1lvH6S9S31iRLMHFotslWCs2e2i2gHrjcDcISu2BO4fq1x+/QqFhflJ/3SlPB+UwSYxUWdlloYRDhJgXyBxZKnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nnGNqyAA; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768427737; x=1799963737;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=I6Px+RrAENui+ogNikf0bieFPGuFc8D/K48Nc+ZS9pw=;
  b=nnGNqyAAr96dtqNjOVQrEU3niT/Nm0kTkmRwNTrHeIA0g6oBVTsR7dhc
   R0y23MGmeKP990jEHnMovJQCb0kcKnWqHmYpCl5tpMhYszpyIYtpQXsAP
   /sjAGkvEnPcl2drxplp50+zEUQUziVdLDj8GYZ5gJY33aBpJeOedzKsPB
   lQXZes68UO73pMMXesFHLTyNFT7Vj/BY1B99Zhz1YeiWu67IXnyL8Q6rU
   gePeBniLhkNUv/F4l+Jynp0ZxSETHKuPPqnqiP9hw/cZAIQC49GX9SOKL
   2sjJR0N2IqdIi48IAzPtajt1HeFVJhMO5MmDmRjgmfTq6uygxfUW+4FSI
   Q==;
X-CSE-ConnectionGUID: r7iDl/KeQ7qeCreiRV4Tgw==
X-CSE-MsgGUID: YqWIv31iRKSMV7LgDy47jA==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69902341"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="69902341"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 13:55:34 -0800
X-CSE-ConnectionGUID: U6kaZdoaRc2g3btBKeozgg==
X-CSE-MsgGUID: p4V1e6RNSCmjhR/bV2mhlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="205056627"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.111.5]) ([10.125.111.5])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 13:55:32 -0800
Message-ID: <fe1039f8-a267-4c72-9c42-71a338b25cf1@intel.com>
Date: Wed, 14 Jan 2026 14:55:31 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 24/34] cxl/port: Move endpoint component register
 management to cxl_port
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, vishal.l.verma@intel.com, alucerop@amd.com,
 ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260114182055.46029-1-terry.bowman@amd.com>
 <20260114182055.46029-25-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260114182055.46029-25-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/14/26 11:20 AM, Terry Bowman wrote:
> From: Dan Williams <dan.j.williams@intel.com>
> 
> In preparation for generic protocol error handling across CXL endpoints,
> whether they be memory expander class devices or accelerators, drop the
> endpoint component management from cxl_dev_state.
> 
> Organize all CXL port component management through the common cxl_port
> driver.
> 
> Note that the end game is that drivers/cxl/core/ras.c loses all
> dependencies on a 'struct cxl_dev_state' parameter and operates only on
> port resources. The removal of component register mapping from cxl_pci is
> an incremental step towards that.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Terry Bowman <terry.bowman@amd.com>

missing sign off

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> 
> ---
> 
> Changes in v13 -> v14:
> - New patch
> - Update log message for cxl_ras_unmask() failure (Dan)
> ---
>  drivers/cxl/core/ras.c |  6 ++--
>  drivers/cxl/cxlmem.h   |  4 +--
>  drivers/cxl/pci.c      | 63 +-----------------------------------------
>  drivers/cxl/port.c     | 54 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 60 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 76ac567724e3..b37108f60c56 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -247,6 +247,7 @@ bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>  void cxl_cor_error_detected(struct pci_dev *pdev)
>  {
>  	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
>  	struct device *dev = &cxlds->cxlmd->dev;
>  
>  	scoped_guard(device, dev) {
> @@ -261,7 +262,7 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
>  			cxl_handle_rdport_errors(cxlds);
>  
>  		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial,
> -				   cxlds->regs.ras);
> +				   cxlmd->endpoint->regs.ras);
>  	}
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
> @@ -291,10 +292,9 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  		 * capability registers and bounce the active state of the memdev.
>  		 */
>  		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial,
> -				    cxlds->regs.ras);
> +				    cxlmd->endpoint->regs.ras);
>  	}
>  
> -
>  	switch (state) {
>  	case pci_channel_io_normal:
>  		if (ue) {
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 434031a0c1f7..ab7201ef3ea6 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -415,7 +415,7 @@ struct cxl_dpa_partition {
>   * @dev: The device associated with this CXL state
>   * @cxlmd: The device representing the CXL.mem capabilities of @dev
>   * @reg_map: component and ras register mapping parameters
> - * @regs: Parsed register blocks
> + * @regs: Class device "Device" registers
>   * @cxl_dvsec: Offset to the PCIe device DVSEC
>   * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
>   * @media_ready: Indicate whether the device media is usable
> @@ -431,7 +431,7 @@ struct cxl_dev_state {
>  	struct device *dev;
>  	struct cxl_memdev *cxlmd;
>  	struct cxl_register_map reg_map;
> -	struct cxl_regs regs;
> +	struct cxl_device_regs regs;
>  	int cxl_dvsec;
>  	bool rcd;
>  	bool media_ready;
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index b7f694bda913..acb0eb2a13c3 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -535,52 +535,6 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  	return cxl_setup_regs(map);
>  }
>  
> -static int cxl_pci_ras_unmask(struct pci_dev *pdev)
> -{
> -	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> -	void __iomem *addr;
> -	u32 orig_val, val, mask;
> -	u16 cap;
> -	int rc;
> -
> -	if (!cxlds->regs.ras) {
> -		dev_dbg(&pdev->dev, "No RAS registers.\n");
> -		return 0;
> -	}
> -
> -	/* BIOS has PCIe AER error control */
> -	if (!pcie_aer_is_native(pdev))
> -		return 0;
> -
> -	rc = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &cap);
> -	if (rc)
> -		return rc;
> -
> -	if (cap & PCI_EXP_DEVCTL_URRE) {
> -		addr = cxlds->regs.ras + CXL_RAS_UNCORRECTABLE_MASK_OFFSET;
> -		orig_val = readl(addr);
> -
> -		mask = CXL_RAS_UNCORRECTABLE_MASK_MASK |
> -		       CXL_RAS_UNCORRECTABLE_MASK_F256B_MASK;
> -		val = orig_val & ~mask;
> -		writel(val, addr);
> -		dev_dbg(&pdev->dev,
> -			"Uncorrectable RAS Errors Mask: %#x -> %#x\n",
> -			orig_val, val);
> -	}
> -
> -	if (cap & PCI_EXP_DEVCTL_CERE) {
> -		addr = cxlds->regs.ras + CXL_RAS_CORRECTABLE_MASK_OFFSET;
> -		orig_val = readl(addr);
> -		val = orig_val & ~CXL_RAS_CORRECTABLE_MASK_MASK;
> -		writel(val, addr);
> -		dev_dbg(&pdev->dev, "Correctable RAS Errors Mask: %#x -> %#x\n",
> -			orig_val, val);
> -	}
> -
> -	return 0;
> -}
> -
>  static void free_event_buf(void *buf)
>  {
>  	kvfree(buf);
> @@ -912,13 +866,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	unsigned int i;
>  	bool irq_avail;
>  
> -	/*
> -	 * Double check the anonymous union trickery in struct cxl_regs
> -	 * FIXME switch to struct_group()
> -	 */
> -	BUILD_BUG_ON(offsetof(struct cxl_regs, memdev) !=
> -		     offsetof(struct cxl_regs, device_regs.memdev));
> -
>  	rc = pcim_enable_device(pdev);
>  	if (rc)
>  		return rc;
> @@ -942,7 +889,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> -	rc = cxl_map_device_regs(&map, &cxlds->regs.device_regs);
> +	rc = cxl_map_device_regs(&map, &cxlds->regs);
>  	if (rc)
>  		return rc;
>  
> @@ -957,11 +904,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	else if (!cxlds->reg_map.component_map.ras.valid)
>  		dev_dbg(&pdev->dev, "RAS registers not found\n");
>  
> -	rc = cxl_map_component_regs(&cxlds->reg_map, &cxlds->regs.component,
> -				    BIT(CXL_CM_CAP_CAP_ID_RAS));
> -	if (rc)
> -		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
> -
>  	rc = cxl_pci_type3_init_mailbox(cxlds);
>  	if (rc)
>  		return rc;
> @@ -1052,9 +994,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> -	if (cxl_pci_ras_unmask(pdev))
> -		dev_dbg(&pdev->dev, "No RAS reporting unmasked\n");
> -
>  	pci_save_state(pdev);
>  
>  	return rc;
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 0d6e010e21ca..d76b4b532064 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
> +#include <linux/aer.h>
>  #include <linux/device.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> @@ -72,6 +73,55 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>  	return 0;
>  }
>  
> +static int cxl_ras_unmask(struct cxl_port *port)
> +{
> +	struct pci_dev *pdev;
> +	void __iomem *addr;
> +	u32 orig_val, val, mask;
> +	u16 cap;
> +	int rc;
> +
> +	if (!dev_is_pci(port->uport_dev))
> +		return 0;
> +	pdev = to_pci_dev(port->uport_dev);
> +
> +	if (!port->regs.ras) {
> +		pci_dbg(pdev, "No RAS registers.\n");
> +		return 0;
> +	}
> +
> +	/* BIOS has PCIe AER error control */
> +	if (!pcie_aer_is_native(pdev))
> +		return 0;
> +
> +	rc = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &cap);
> +	if (rc)
> +		return rc;
> +
> +	if (cap & PCI_EXP_DEVCTL_URRE) {
> +		addr = port->regs.ras + CXL_RAS_UNCORRECTABLE_MASK_OFFSET;
> +		orig_val = readl(addr);
> +
> +		mask = CXL_RAS_UNCORRECTABLE_MASK_MASK |
> +		       CXL_RAS_UNCORRECTABLE_MASK_F256B_MASK;
> +		val = orig_val & ~mask;
> +		writel(val, addr);
> +		pci_dbg(pdev, "Uncorrectable RAS Errors Mask: %#x -> %#x\n",
> +			orig_val, val);
> +	}
> +
> +	if (cap & PCI_EXP_DEVCTL_CERE) {
> +		addr = port->regs.ras + CXL_RAS_CORRECTABLE_MASK_OFFSET;
> +		orig_val = readl(addr);
> +		val = orig_val & ~CXL_RAS_CORRECTABLE_MASK_MASK;
> +		writel(val, addr);
> +		pci_dbg(pdev, "Correctable RAS Errors Mask: %#x -> %#x\n",
> +			orig_val, val);
> +	}
> +
> +	return 0;
> +}
> +
>  static int cxl_endpoint_port_probe(struct cxl_port *port)
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
> @@ -102,6 +152,10 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	if (dport->rch)
>  		devm_cxl_dport_ras_setup(dport);
>  
> +	devm_cxl_port_ras_setup(port);
> +	if (cxl_ras_unmask(port))
> +		dev_dbg(&port->dev, "failed to unmask RAS interrupts\n");
> +
>  	/*
>  	 * Now that all endpoint decoders are successfully enumerated, try to
>  	 * assemble regions from committed decoders


