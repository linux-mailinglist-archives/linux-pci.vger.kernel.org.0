Return-Path: <linux-pci+bounces-19021-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3139A9FC177
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 19:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310221885346
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 18:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A14212D9C;
	Tue, 24 Dec 2024 18:53:55 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FCE2144A4;
	Tue, 24 Dec 2024 18:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735066434; cv=none; b=e8Lab0ZY+xgtD6DryQKgoi8vkc21CIJrYZvI9tfpS6rFlqi2PED0UbaNtqWUsi2DddFn9satLuxTaDluNsj0YHfNU9fhXZKjPEWqJw3bKP948zxdhkGxHECGbDQqix9MhsdPwmcU9SsefkwxoEJtE/iD2/l/KeakpnCFAT8gxTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735066434; c=relaxed/simple;
	bh=uWZjHf7PMvN7cRXyNz3KxU0cW/qU46CjDp/IS8DOugo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HS2qxQVbVb9qIwRwx+VmGcrtJx92H0smMeUgZJ3XiC8hvRhj/ducPlsBQImeUTOrFxGWYSzMZb3Z7qFG61YXIsO2ltcs7DDFwF+vcmvxcbar5eXpCp/UtxsxpTwrhsEyg4cUONLJ5u/TGWi0HL+Sf7G4EcAcqDiJ8YVD6nEUQpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YHkTb3jvyz6K5ql;
	Wed, 25 Dec 2024 02:49:55 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 20852140133;
	Wed, 25 Dec 2024 02:53:49 +0800 (CST)
Received: from localhost (10.48.156.150) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Dec
 2024 19:53:48 +0100
Date: Tue, 24 Dec 2024 18:53:46 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <ming4.li@intel.com>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>, <PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH v4 15/15] PCI/AER: Enable internal errors for CXL
 Upstream and Downstream Switch Ports
Message-ID: <20241224185346.00000886@huawei.com>
In-Reply-To: <20241211234002.3728674-16-terry.bowman@amd.com>
References: <20241211234002.3728674-1-terry.bowman@amd.com>
	<20241211234002.3728674-16-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 11 Dec 2024 17:40:02 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> The AER service driver enables PCIe Uncorrectable Internal Errors (UIE) and
> Correctable Internal errors (CIE) for CXL Root Ports and CXL RCEC's. The
> UIE and CIE are used in reporting CXL Protocol Errors. The same UIE/CIE
> enablement is needed for CXL PCIe Upstream and Downstream Ports inorder to
> notify the associated Root Port and OS.[1]
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
Whilst I'm in favor of just enabling this across all devices I guess
I can cope with this more minimal form and it will create fewer bug
reports :).
It is a little messy because we are tweaking it from the 'wrong' driver
but I guess that is fine.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

And on that note, happy Christmas / holidays etc all. My backlog
of review looks much less scary now but I need a beer!

Jonathan



> ---
>  drivers/cxl/core/pci.c | 2 ++
>  drivers/pci/pcie/aer.c | 5 +++--
>  include/linux/aer.h    | 1 +
>  3 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 9734a4c55b29..740ac5d8809f 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -886,6 +886,7 @@ void cxl_uport_init_ras_reporting(struct cxl_port *port)
>  
>  	cxl_assign_port_error_handlers(pdev);
>  	devm_add_action_or_reset(port->uport_dev, cxl_clear_port_error_handlers, pdev);
> +	pci_aer_unmask_internal_errors(pdev);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_uport_init_ras_reporting, CXL);
>  
> @@ -920,6 +921,7 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
>  
>  	cxl_assign_port_error_handlers(pdev);
>  	devm_add_action_or_reset(dport_dev, cxl_clear_port_error_handlers, pdev);
> +	pci_aer_unmask_internal_errors(pdev);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, CXL);
>  
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 861521872318..0fa1b1ed48c9 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -949,7 +949,6 @@ static bool is_internal_error(struct aer_err_info *info)
>  	return info->status & PCI_ERR_UNC_INTN;
>  }
>  
> -#ifdef CONFIG_PCIEAER_CXL
>  /**
>   * pci_aer_unmask_internal_errors - unmask internal errors
>   * @dev: pointer to the pcie_dev data structure
> @@ -960,7 +959,7 @@ static bool is_internal_error(struct aer_err_info *info)
>   * Note: AER must be enabled and supported by the device which must be
>   * checked in advance, e.g. with pcie_aer_is_native().
>   */
> -static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
> +void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>  {
>  	int aer = dev->aer_cap;
>  	u32 mask;
> @@ -973,7 +972,9 @@ static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>  	mask &= ~PCI_ERR_COR_INTERNAL;
>  	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
>  }
> +EXPORT_SYMBOL_NS_GPL(pci_aer_unmask_internal_errors, CXL);
>  
> +#ifdef CONFIG_PCIEAER_CXL
>  static bool is_cxl_mem_dev(struct pci_dev *dev)
>  {
>  	/*
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 4b97f38f3fcf..093293f9f12b 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -55,5 +55,6 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  int cper_severity_to_aer(int cper_severity);
>  void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
>  		       int severity, struct aer_capability_regs *aer_regs);
> +void pci_aer_unmask_internal_errors(struct pci_dev *dev);
>  #endif //_AER_H_
>  


