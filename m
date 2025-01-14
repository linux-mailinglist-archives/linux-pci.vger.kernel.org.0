Return-Path: <linux-pci+bounces-19719-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DD0A1052C
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 12:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2936165028
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 11:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D37428EC83;
	Tue, 14 Jan 2025 11:20:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1672628EC81;
	Tue, 14 Jan 2025 11:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736853616; cv=none; b=N7sctalQKj6UO4PWU3MEDUldpPgOWPZADuxs5Oek7gAxJ12fCvx1xbAM8il+8IRGmv6nnudlE9HeJ7Lz/Y/1oI3qVgArLfUAI2z1ezi6lMYxQwOFEMh6T+WGY5Hrh2KvTJbxND5ZCCh9UemNfM6KKsQ8uHWjTALbdAosHLrwCmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736853616; c=relaxed/simple;
	bh=NpvpajmbrS04XL8WksqCx+pwslDua4mTHgIgalfJwI0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bLHi4jWifL+YBOX06VPRxPMSddGW0ILIhBjiMtOzxTnQVQENqvaKHUEFEr3Sbouu+Zf9SxnYPJS3IA1CuJXfd/tg+3h0Cg43Xb28Y4T8j+WkXnuUdLZs53KFobJW6eIbTbHhheqyQEO1WnxNisdjVh4+zb5OqOrcoxo3xkwPu2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YXRTJ2gMDz6L5Bm;
	Tue, 14 Jan 2025 19:18:44 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1A3B31402C6;
	Tue, 14 Jan 2025 19:20:11 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 14 Jan
 2025 12:20:10 +0100
Date: Tue, 14 Jan 2025 11:20:08 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Li Ming <ming.li@zohomail.com>
CC: Terry Bowman <terry.bowman@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<nifan.cxl@gmail.com>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<PradeepVineshReddy.Kodamati@amd.com>, <alucerop@amd.com>
Subject: Re: [PATCH v5 05/16] PCI/AER: Add CXL PCIe Port correctable error
 support in AER service driver
Message-ID: <20250114112008.0000167f@huawei.com>
In-Reply-To: <cb087065-f2f3-481c-84cf-aca2c5fd5ac4@zohomail.com>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
	<20250107143852.3692571-6-terry.bowman@amd.com>
	<cb087065-f2f3-481c-84cf-aca2c5fd5ac4@zohomail.com>
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

On Tue, 14 Jan 2025 14:54:23 +0800
Li Ming <ming.li@zohomail.com> wrote:

> On 1/7/2025 10:38 PM, Terry Bowman wrote:
> > The AER service driver supports handling Downstream Port Protocol Errors in
> > Restricted CXL host (RCH) mode also known as CXL1.1. It needs the same
> > functionality for CXL PCIe Ports operating in Virtual Hierarchy (VH)
> > mode.[1]
> >
> > CXL and PCIe Protocol Error handling have different requirements that
> > necessitate a separate handling path. The AER service driver may try to
> > recover PCIe uncorrectable non-fatal errors (UCE). The same recovery is not
> > suitable for CXL PCIe Port devices because of potential for system memory
> > corruption. Instead, CXL Protocol Error handling must use a kernel panic
> > in the case of a fatal or non-fatal UCE. The AER driver's PCIe Protocol
> > Error handling does not panic the kernel in response to a UCE.
> >
> > Introduce a separate path for CXL Protocol Error handling in the AER
> > service driver. This will allow CXL Protocol Errors to use CXL specific
> > handling instead of PCIe handling. Add the CXL specific changes without
> > affecting or adding functionality in the PCIe handling.
> >
> > Make this update alongside the existing Downstream Port RCH error handling
> > logic, extending support to CXL PCIe Ports in VH mode.
> >
> > is_internal_error() is currently limited by CONFIG_PCIEAER_CXL kernel
> > config. Update is_internal_error()'s function declaration such that it is
> > always available regardless if CONFIG_PCIEAER_CXL kernel config is enabled
> > or disabled.
> >
> > The uncorrectable error (UCE) handling will be added in a future patch.
> >
> > [1] CXL 3.1 Spec, 12.2.2 CXL Root Ports, Downstream Switch Ports, and
> > Upstream Switch Ports
> >
> > Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > ---
> >  drivers/pci/pcie/aer.c | 61 +++++++++++++++++++++++++++---------------
> >  1 file changed, 40 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index f8b3350fcbb4..62be599e3bee 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -942,8 +942,15 @@ static bool find_source_device(struct pci_dev *parent,
> >  	return true;
> >  }
> >  
> > -#ifdef CONFIG_PCIEAER_CXL
> > +static bool is_internal_error(struct aer_err_info *info)
> > +{
> > +	if (info->severity == AER_CORRECTABLE)
> > +		return info->status & PCI_ERR_COR_INTERNAL;
> >  
> > +	return info->status & PCI_ERR_UNC_INTN;
> > +}
> > +
> > +#ifdef CONFIG_PCIEAER_CXL
> >  /**
> >   * pci_aer_unmask_internal_errors - unmask internal errors
> >   * @dev: pointer to the pcie_dev data structure
> > @@ -995,14 +1002,6 @@ static bool cxl_error_is_native(struct pci_dev *dev)
> >  	return (pcie_ports_native || host->native_aer);
> >  }
> >  
> > -static bool is_internal_error(struct aer_err_info *info)
> > -{
> > -	if (info->severity == AER_CORRECTABLE)
> > -		return info->status & PCI_ERR_COR_INTERNAL;
> > -
> > -	return info->status & PCI_ERR_UNC_INTN;
> > -}
> > -
> >  static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
> >  {
> >  	struct aer_err_info *info = (struct aer_err_info *)data;
> > @@ -1034,14 +1033,23 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
> >  
> >  static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
> >  {
> > -	/*
> > -	 * Internal errors of an RCEC indicate an AER error in an
> > -	 * RCH's downstream port. Check and handle them in the CXL.mem
> > -	 * device driver.
> > -	 */
> > -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
> > -	    is_internal_error(info))
> > -		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
> > +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
> > +		return pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
> > +
> > +	if (info->severity == AER_CORRECTABLE) {
> > +		struct pci_driver *pdrv = dev->driver;
> > +		int aer = dev->aer_cap;
> > +
> > +		if (aer)
> > +			pci_write_config_dword(dev, aer + PCI_ERR_COR_STATUS,
> > +					       info->status);
> > +
> > +		if (pdrv && pdrv->cxl_err_handler &&
> > +		    pdrv->cxl_err_handler->cor_error_detected)
> > +			pdrv->cxl_err_handler->cor_error_detected(dev);
> > +
> > +		pcie_clear_device_status(dev);
> > +	}
> >  }
> >  
> >  static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
> > @@ -1059,9 +1067,13 @@ static bool handles_cxl_errors(struct pci_dev *dev)
> >  {
> >  	bool handles_cxl = false;
> >  
> > -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
> > -	    pcie_aer_is_native(dev))
> > +	if (!pcie_aer_is_native(dev))
> > +		return false;
> > +
> > +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
> >  		pcie_walk_rcec(dev, handles_cxl_error_iter, &handles_cxl);
> > +	else
> > +		handles_cxl = pcie_is_cxl_port(dev);  
> 
> My understanding is if a cxl RP/USP/DSP is working on PCIe mode, they are also possible to expose a DVSEC ID 3(CXL r3.1 section 9.12.3). In such case, the AER handler should be pci_aer_handle_error() rather than cxl_handle_error().
> 
> pcie_is_cxl_port() only checks if there is a DVSEC ID 3, but I think it should also check if the cxl port is working on CXL mode, does it make more sense?
> 
> 
Good spot.

Agreed a check on the mode makes sense.

Jonathan

> Ming
> 
> >  
> >  	return handles_cxl;
> >  }
> > @@ -1079,6 +1091,10 @@ static void cxl_enable_internal_errors(struct pci_dev *dev)
> >  static inline void cxl_enable_internal_errors(struct pci_dev *dev) { }
> >  static inline void cxl_handle_error(struct pci_dev *dev,
> >  				    struct aer_err_info *info) { }
> > +static bool handles_cxl_errors(struct pci_dev *dev)
> > +{
> > +	return false;
> > +}
> >  #endif
> >  
> >  /**
> > @@ -1116,8 +1132,11 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
> >  
> >  static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
> >  {
> > -	cxl_handle_error(dev, info);
> > -	pci_aer_handle_error(dev, info);
> > +	if (is_internal_error(info) && handles_cxl_errors(dev))
> > +		cxl_handle_error(dev, info);
> > +	else
> > +		pci_aer_handle_error(dev, info);
> > +
> >  	pci_dev_put(dev);
> >  }
> >    
> 
> 
> 


