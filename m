Return-Path: <linux-pci+bounces-21220-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FB4A31696
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 21:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 407E73A7D56
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 20:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86ED4262D39;
	Tue, 11 Feb 2025 20:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tu6/x393"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCF9262D0F;
	Tue, 11 Feb 2025 20:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739305566; cv=none; b=kTbtDhtMRZ4+RdFDHXi5URrVeK30MlbCYuBhQMnQx+Ob/iK7ECA0/FgE3eAIKkIO+i0AeP1csNfSDsqZa/llpqsgqU2OTnj+IfOQ+XdoP+RjVnkisWkQEevSff/G4t/Vr6528jY1GWm5TWaGqeUCyDJAq1/hNmojyhkFjV4vIRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739305566; c=relaxed/simple;
	bh=Ycf8GeNK3oJr/THE/xV8tWmOvGVer0MVw/oFS1f1YUY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sRWh+20inJaXKf5RUKa2B3qSFBsgPQMyZZN7TialFtIXzgEQ/NDMNUuw9W2xCy7U6eINjXollI87pUymgSX2m2Kx11spaZBGB90xh/02G87TC0zjLHR4sSmlazstdK9tK7rOrUy4YWSLiIW3fKGfvbmZDGAiBMBLcVmjdjAW6cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tu6/x393; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1104DC4CEE9;
	Tue, 11 Feb 2025 20:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739305566;
	bh=Ycf8GeNK3oJr/THE/xV8tWmOvGVer0MVw/oFS1f1YUY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Tu6/x393RDmdnScd7oljfVOGSdDGjpQuVUQXALt41aAnfdnFJNmMXfAd1EvYMiGUQ
	 bbDEGKKEeP+VcnIkmWIg1fYT+p70CV0FRpYrI4F+mnNuAlooSFp3k3W7Sncoie8qlo
	 cw9AVa6w0stNltXYI9Ie//eBoXwCdQAO9l2Xp1exeQmsfABRsWTA7EKA2ddiihqY+N
	 Jcw13Je3K4NOdDVDUem90VETrgw5IrjMU9BlL9eXUIYwXt2nfFuxh7ACLAvYSehZCZ
	 jB71FS6+FlwsXLEk6hJzTGxgb8LZlfLa0xO+iLDCzJgUpPn0jfiE1ZS6Cy72yZPCDR
	 wg22LZ7Nee2ew==
Date: Tue, 11 Feb 2025 14:26:04 -0600
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
Subject: Re: [PATCH v7 02/17] PCI/AER: Rename AER driver's interfaces to also
 indicate CXL PCIe Port support
Message-ID: <20250211202604.GA53817@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211192444.2292833-3-terry.bowman@amd.com>

On Tue, Feb 11, 2025 at 01:24:29PM -0600, Terry Bowman wrote:
> The AER service driver already includes support for Restricted CXL host
> (RCH) Downstream Port Protocol Error handling. The current implementation
> is based on CXL1.1 using a Root Complex Event Collector.
> 
> Rename function interfaces and parameters where necessary to include
> virtual hierarchy (VH) mode CXL PCIe Port error handling alongside the RCH
> handling.[1] The CXL PCIe Port Protocol Error handling support will be
> added in a future patch.
> 
> Limit changes to renaming variable and function names. No functional
> changes are added.
> 
> [1] CXL 3.1 Spec, 9.12.2 CXL Virtual Hierarchy
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/pcie/aer.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 508474e17183..6e8de77d0fc4 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1024,7 +1024,7 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>  	return 0;
>  }
>  
> -static void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
> +static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>  {
>  	/*
>  	 * Internal errors of an RCEC indicate an AER error in an
> @@ -1047,30 +1047,30 @@ static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
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
> @@ -1108,7 +1108,7 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
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
> -- 
> 2.34.1
> 

