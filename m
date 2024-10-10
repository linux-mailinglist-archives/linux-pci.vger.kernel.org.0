Return-Path: <linux-pci+bounces-14224-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 760679991F0
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 21:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 874ED1C262E5
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 19:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5D619CD17;
	Thu, 10 Oct 2024 19:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhZj38Ls"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A34A1925B6;
	Thu, 10 Oct 2024 19:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728587497; cv=none; b=MNzGNflpkK6wQWAjibbzOdn7Wsto+aAkm/ohULzbEO/vaF3MilATsAIegCB0QLr4+aOk9Iga3Z1EbR/H2IFriJSfwbOrLUZscPhnSvq5TvzdAv/QfAxgxTGW3hX+kTKvSwbY15ZvQmkXGezu6sd6QKSOxd8gelnGJ03UsBWeMls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728587497; c=relaxed/simple;
	bh=r8HhG9Dpfw304yRuKhN7YX4GSw7YfgMwFFG06xYAPZU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HW9NMZJQz+n6ojk4NOtW3Io2K3Cp3LqTu3DnSBmB/hvx9Wgrgb+0d+JrTFNvffsRC94+sRCKY9OfVvh35w/ugDnqZmnMPdtjXwKDD7R/vgpsrOW7VWsASv+0b90x4Wy6uoMkpjvF40V/DXZuCO9fG/idyvcl84QA3Cww0CZXWCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhZj38Ls; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DD1C4CEC5;
	Thu, 10 Oct 2024 19:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728587497;
	bh=r8HhG9Dpfw304yRuKhN7YX4GSw7YfgMwFFG06xYAPZU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=LhZj38LsNOF90G5cEKy1yrkiBO+a8lRNiDYw3v6qApwjWi0kbjK3TsPKXQKyH2ONY
	 AcvtyfzBtyPwTDEh25LsqLGwxIrk6zJHju/zCeVFpqABnuxbhhCTrrAJEDsS01CioF
	 ttiTDAVANxZS5hHRtgoSjLRj8dlCTiBW6v4jjU+CmrZsd6+jLcy311GKjocuUDHN56
	 WYRRU1sF6TrctGy7Nc2Gygc67WEQVEIeAsN9q/mkiSZ7dZeLt52StzXTuYdtR2dHIE
	 FqUF+jF2uf1A9EWX5Uk4OwvdWk87tkSM51aWxDpKKJbu6mznBfn7jg6kxhP7FOMu0L
	 iCFhzoyOEinkA==
Date: Thu, 10 Oct 2024 14:11:35 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Terry Bowman <terry.bowman@amd.com>
Cc: ming4.li@intel.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, mahesh@linux.ibm.com, oohall@gmail.com,
	Benjamin.Cheatham@amd.com, rrichter@amd.com,
	nathan.fontenot@amd.com, smita.koralahallichannabasappa@amd.com
Subject: Re: [PATCH 03/15] cxl/aer/pci: Refactor AER driver's existing
 interfaces to support CXL PCIe ports
Message-ID: <20241010191135.GA571342@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008221657.1130181-4-terry.bowman@amd.com>

I would describe this more as "renaming" than "refactoring".

On Tue, Oct 08, 2024 at 05:16:45PM -0500, Terry Bowman wrote:
> The AER service driver already includes support for CXL restricted host
> (RCH) downstream port error handling. The current implementation is based
> CXl1.1 using a root complex event collector.
> 
> Update the function interfaces and parameters where necessary to add
> virtual hierarchy (VH) mode CXL PCIe port error handling alongside the RCH
> handling. The CXL PCIe port error handling will be added in a future patch.

"Virtual Hierarchy mode" sounds like something defined by the spec.
If so, add a citation and capitalize it the same way it's used in the
spec.

Same for "restricted host", at least in terms of styling.  That
support was added previously, so a citation probably isn't necessary
here, but since this is part of *adding* VH support, hints about VH
will be more helpful.

> Limit changes to refactoring variable and function names. No
> functional changes are added.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/pci/pcie/aer.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 1e72829a249f..dc8b17999001 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1030,7 +1030,7 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>  	return 0;
>  }
>  
> -static void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
> +static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>  {
>  	/*
>  	 * Internal errors of an RCEC indicate an AER error in an
> @@ -1053,30 +1053,30 @@ static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
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
>  void register_cxl_port_hndlrs(struct cxl_port_err_hndlrs *_cxl_port_hndlrs)
> @@ -1134,7 +1134,7 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>  
>  static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>  {
> -	cxl_rch_handle_error(dev, info);
> +	cxl_handle_error(dev, info);
>  	pci_aer_handle_error(dev, info);
>  	pci_dev_put(dev);
>  }
> @@ -1512,7 +1512,7 @@ static int aer_probe(struct pcie_device *dev)
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

