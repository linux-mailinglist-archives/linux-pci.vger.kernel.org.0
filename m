Return-Path: <linux-pci+bounces-21223-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F22A316A6
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 21:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50C2E188217F
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 20:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB4D263885;
	Tue, 11 Feb 2025 20:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="boBRfP+y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C25263887;
	Tue, 11 Feb 2025 20:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739305734; cv=none; b=J7Xs1BZSzSdlxO9vQno6sMxUQ7GlGyF3hKIMduQ1L/M7usVKDgsVrDWhHJAStFdgAFfQNqTBKKRzX5ZySKZY6IgXSjNkedapS2zeZX/7nWr4DFi9kMgJcaKGvh9chutjN+Cx0EQNdpWnWPRYY3OZxHJHhVEe40SfE0keUkfDaDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739305734; c=relaxed/simple;
	bh=PX7vcQehulYjUxO96URhpjYX9qkoRA7ShNBEOIiDB4U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=B8838LKkDWk61kWr0rYJnW+OiTCgmBCpcOnUVoG1iuR4tAF7zobxgwdSWhnDAJN5x4cQh2stgFFAe7/w4wmD9H3NYZCpuAMC8UFgyOhdC0ufsBUfUsqMCVNNc6o/6EkAAtMVW54xTrHOq9ckixwsC9Yfk6XkPGmYvTH6i31uyu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=boBRfP+y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1559FC4CEDD;
	Tue, 11 Feb 2025 20:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739305733;
	bh=PX7vcQehulYjUxO96URhpjYX9qkoRA7ShNBEOIiDB4U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=boBRfP+ykjuBZBfjext0v/gN2GEAGLIAgO3XTAUHavN3yWqS0QOZ7oD7I5rIjH5vb
	 AQdztzIsV+66i9kUHwQU9bU/oqLR2eDNUVj1kJHrvaD4dDyLuE0Mev+pFW+g1xFGjl
	 +5O8CD6eo7dFyJ6wUnW7r7dPSObo59njjMxQs6bnXm8y9p6VLaMpxCFhH2H5KuA6CG
	 qqhKyf1VlO0FBOSRuj6TrqYecSkZFWyKCamhosDhfYesfEAU/77uh6dY480YEvGwPZ
	 FZNkroUylKHfEYvgcVWXFFP+0vqYEj3u0MP6Zcl2R7FmIBAp0Jmq915FeFt0bRO247
	 M5ly8ckyr/tVA==
Date: Tue, 11 Feb 2025 14:28:51 -0600
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
Subject: Re: [PATCH v7 05/17] PCI/AER: Add CXL PCIe Port correctable error
 support in AER service driver
Message-ID: <20250211202851.GA53986@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211192444.2292833-6-terry.bowman@amd.com>

On Tue, Feb 11, 2025 at 01:24:32PM -0600, Terry Bowman wrote:
> The AER service driver supports handling Downstream Port Protocol Errors in
> Restricted CXL host (RCH) mode also known as CXL1.1. It needs the same
> functionality for CXL PCIe Ports operating in Virtual Hierarchy (VH)
> mode.[1]
> 
> CXL and PCIe Protocol Error handling have different requirements that
> necessitate a separate handling path. The AER service driver may try to
> recover PCIe uncorrectable non-fatal errors (UCE). The same recovery is not
> suitable for CXL PCIe Port devices because of potential for system memory
> corruption. Instead, CXL Protocol Error handling must use a kernel panic
> in the case of a fatal or non-fatal UCE. The AER driver's PCIe Protocol
> Error handling does not panic the kernel in response to a UCE.
> 
> Introduce a separate path for CXL Protocol Error handling in the AER
> service driver. This will allow CXL Protocol Errors to use CXL specific
> handling instead of PCIe handling. Add the CXL specific changes without
> affecting or adding functionality in the PCIe handling.
> 
> Make this update alongside the existing Downstream Port RCH error handling
> logic, extending support to CXL PCIe Ports in VH mode.
> 
> Remove is_internal_error(). is_internal_error() was used to determine if
> an AER error was a CXL error. Instead, now rely on pcie_is_cxl_port() to
> indicate the error is a CXL error.
> 
> The uncorrectable error (UCE) handling will be added in a future patch.
> 
> [1] CXL 3.1 Spec, 12.2.2 CXL Root Ports, Downstream Switch Ports, and
> Upstream Switch Ports
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/pcie/aer.c | 47 ++++++++++++++++++++++++++++--------------
>  1 file changed, 32 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index f99a1c6fb274..34ec0958afff 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -989,14 +989,6 @@ static bool cxl_error_is_native(struct pci_dev *dev)
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
> @@ -1033,9 +1025,23 @@ static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>  	 * RCH's downstream port. Check and handle them in the CXL.mem
>  	 * device driver.
>  	 */
> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
> -	    is_internal_error(info))
> -		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
> +		return pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
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
> @@ -1053,9 +1059,13 @@ static bool handles_cxl_errors(struct pci_dev *dev)
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
> @@ -1073,6 +1083,10 @@ static void cxl_enable_internal_errors(struct pci_dev *dev)
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
> @@ -1110,8 +1124,11 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>  
>  static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>  {
> -	cxl_handle_error(dev, info);
> -	pci_aer_handle_error(dev, info);
> +	if (handles_cxl_errors(dev))
> +		cxl_handle_error(dev, info);
> +	else
> +		pci_aer_handle_error(dev, info);
> +
>  	pci_dev_put(dev);
>  }
>  
> -- 
> 2.34.1
> 

