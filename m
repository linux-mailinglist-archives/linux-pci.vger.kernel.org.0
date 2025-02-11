Return-Path: <linux-pci+bounces-21218-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5887EA31691
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 21:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C770018870CF
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 20:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576CC26217C;
	Tue, 11 Feb 2025 20:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0ggKZxi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CE71D8DF6;
	Tue, 11 Feb 2025 20:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739305525; cv=none; b=GqC7J0aBW56dEG2oxj6Uj8j9sDQWkq3REiD2YsGzlxlJn8kiXL/HbzwB8d5qo58ueT1Ifqc80LRlIIi5+gjzKtNh3fgatglGTF5vclDu2b5Wrdv2Zzc7IJgXOZHlqR/yg4v+2J0jlzZ2XQNhbPf7VduxVE5YHJxEB/KWs1NBLdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739305525; c=relaxed/simple;
	bh=xzP6GLQeTmYS7XcczI9XGU2DuKAgN9+oh6WSsla3hLM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JnJdKiXJ05GOe0ogcOsTvDzEeFRbBVcETUFdetbXQVaRCht6ZlfHkmrWtCLkHf9tOIo2yiRTkmjAtF3qLgbGI980AZPbHrAL1CZm72DcoqYdJ7U2CT/LpRzU0SH/pjuQ7Evqi1weavb+eVrMOrayKBUl+xDBWdmLR1yM8I7ggL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0ggKZxi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73694C4CEDD;
	Tue, 11 Feb 2025 20:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739305524;
	bh=xzP6GLQeTmYS7XcczI9XGU2DuKAgN9+oh6WSsla3hLM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=B0ggKZxiZOiMssnAJQUxpjQ6yoXRH5qRxIYwrgA9jlKMeH5AX9aHtTnRdJDELa1MK
	 Ls91mvr3HAxmkGF+qQ9QtlSjJ1LQQhQEYqCsySvc2etUG6edgxrT4PPhXZw0ZDl+cA
	 wBMCZK86FibynV66cBOdthZorWrarlhc2f7riKqx32SDvx9XKRnMqzm5jNk0LHfBUd
	 DvwaO8PibLvbMUQarQBUfwmm9ACp+B6oCqxBwVQodrJZnj2cJTNOe+7dgC/EBZT+cn
	 WUIxwD4PWvJcaO37A3rqU+ZgVqPJy09gMRdNlISXH3n9bKGGf73bt+9Hi74JFD9eJH
	 j7mIiOfP//enQ==
Date: Tue, 11 Feb 2025 14:25:23 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Terry Bowman <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
	ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
	rrichter@amd.com, nathan.fontenot@amd.com,
	Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
	ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
Subject: Re: [PATCH v7 16/17] PCI/AER: Enable internal errors for CXL
 Upstream and Downstream Switch Ports
Message-ID: <20250211202523.GA53686@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211192444.2292833-17-terry.bowman@amd.com>

On Tue, Feb 11, 2025 at 01:24:43PM -0600, Terry Bowman wrote:
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

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I'd say this is really a CXL-centric change, given that
pci_aer_unmask_internal_errors() is only used for CXL and it's
exported in the CXL namespace.  So I would use

  cxl/pci: ...

in the subject.

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
> -- 
> 2.34.1
> 

