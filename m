Return-Path: <linux-pci+bounces-25294-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9BFA7C20C
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 19:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA8DD7A7517
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 17:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909001FF1BF;
	Fri,  4 Apr 2025 17:04:35 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424F9155A4D;
	Fri,  4 Apr 2025 17:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743786275; cv=none; b=WPlpQWc8F04B01FPJO16ibxoAzzF/tZQ4YZaC0+6L6HZtwjsP2eLyLBEmYTrB3S9J+cZAJDqCIU1yJrG0e3sP6KHG5eQDLgIW4gNZzL/qOdYH8IIeXpsoZwqaVOxHhZROIbdNBZ6TyYFHcyy34iEpEEeHpIH/xaUjFP3QRjGRaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743786275; c=relaxed/simple;
	bh=S+F5mAwfTpIVQu7lxOV72ou/n1b8WaVKlkaR3zTALV0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PDn3D12u18EuYiPfPu9aWF/PP/cM3h5x3y8CgFOgXyhzXpgWzXblXuHHX5KkDcVfX5u6+xWu1784IDILIYGo+aY9RD4P7Xwdp8ekRWp3bJ1YCMVek0HANuatZEEPVsvVIcUvFTtXWFGxHb64srIQIutYCarngybb4t3Lc/Husj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZTlH43krVz6K9HT;
	Sat,  5 Apr 2025 01:00:48 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9095E1402C7;
	Sat,  5 Apr 2025 01:04:29 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Apr
 2025 19:04:28 +0200
Date: Fri, 4 Apr 2025 18:04:27 +0100
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
Subject: Re: [PATCH v8 16/16] CXL/PCI: Disable CXL protocol errors during
 CXL Port cleanup
Message-ID: <20250404180427.00007602@huawei.com>
In-Reply-To: <20250327014717.2988633-17-terry.bowman@amd.com>
References: <20250327014717.2988633-1-terry.bowman@amd.com>
	<20250327014717.2988633-17-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 26 Mar 2025 20:47:17 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> During CXL device cleanup the CXL PCIe Port device interrupts may remain
> enabled. This can potentialy allow unnecessary interrupt processing on
> behalf of the CXL errors while the device is destroyed.
> 
> Disable CXL protocol errors by setting the CXL devices' AER mask register.
> 
> Introduce pci_aer_mask_internal_errors() similar to pci_aer_unmask_internal_errors().
> 
> Next, introduce cxl_disable_prot_errors() to call pci_aer_mask_internal_errors().
> Register cxl_disable_prot_errors() to run at CXL device cleanup.
> Register for CXL Root Ports, CXL Downstream Ports, CXL Upstream Ports, and
> CXL Endpoints.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

A few small comments in here.  I haven't looked through all the rest of the series
as out of time today but this one caught my eye.
>  
> @@ -223,7 +238,7 @@ static void cxl_endpoint_port_init_ras(struct cxl_port *port)
>  	struct device *cxlmd_dev __free(put_device) = &cxlmd->dev;
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  
> -	if (!dport || !dev_is_pci(dport->dport_dev)) {
> +	if (!dport || !dev_is_pci(dport->dport_dev) || !dev_is_pci(cxlds->dev)) {
>  		dev_err(&port->dev, "CXL port topology not found\n");
>  		return;
>  	}
> @@ -232,6 +247,7 @@ static void cxl_endpoint_port_init_ras(struct cxl_port *port)
>  
>  	cxl_assign_error_handlers(cxlmd_dev, &cxl_ep_error_handlers);
>  	cxl_enable_prot_errors(cxlds->dev);
> +	devm_add_action_or_reset(cxlds->dev, cxl_disable_prot_errors, cxlds->dev);

This can fail (at least in theory).  Should at least scream that oddly we've
disabled error handling interrupts if it is hard to return anything cleanly.

Same for all the other cases.
>  }
>  
>  #else
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index d3068f5cc767..d1ef0c676ff8 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -977,6 +977,31 @@ void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL_NS_GPL(pci_aer_unmask_internal_errors, "CXL");
>  
> +/**
> + * pci_aer_mask_internal_errors - mask internal errors
> + * @dev: pointer to the pcie_dev data structure
> + *
> + * Masks internal errors in the Uncorrectable and Correctable Error
> + * Mask registers.
> + *
> + * Note: AER must be enabled and supported by the device which must be
> + * checked in advance, e.g. with pcie_aer_is_native().
> + */
> +void pci_aer_mask_internal_errors(struct pci_dev *dev)
> +{
> +	int aer = dev->aer_cap;
> +	u32 mask;
> +
> +	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, &mask);
> +	mask |= PCI_ERR_UNC_INTN;
> +	pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, mask);
> +
It does an extra clear we don't need, but....
	pci_clear_and_set_config_dword(dev, aer + PCI_ERR_UNCOR_MASK,
				       0, PCI_ERR_UNC_INTN);

	is at very least shorter than the above 3 lines.

> +	pci_read_config_dword(dev, aer + PCI_ERR_COR_MASK, &mask);
> +	mask |= PCI_ERR_COR_INTERNAL;
> +	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
> +}
> +EXPORT_SYMBOL_NS_GPL(pci_aer_mask_internal_errors, "CXL");
> +
>  static bool is_cxl_mem_dev(struct pci_dev *dev)
>  {
>  	/*
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index a65fe324fad2..f0c84db466e5 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -101,5 +101,6 @@ int cper_severity_to_aer(int cper_severity);
>  void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
>  		       int severity, struct aer_capability_regs *aer_regs);
>  void pci_aer_unmask_internal_errors(struct pci_dev *dev);
> +void pci_aer_mask_internal_errors(struct pci_dev *dev);
>  #endif //_AER_H_
>  


