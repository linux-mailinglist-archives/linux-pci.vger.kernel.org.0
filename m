Return-Path: <linux-pci+bounces-17705-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B224B9E4772
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 23:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2117418803D3
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 22:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A853F194C86;
	Wed,  4 Dec 2024 22:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Op6mzCz1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4FE194096;
	Wed,  4 Dec 2024 22:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733350037; cv=none; b=eV7ITJJ4Yf0xKTS/ZNIY9YfYuY7zJGO2eQ3LJaT5+wqmX7jskVQmEFuecfMgkUvg/lzy/34tj8WlIPItnrqX+oEQsitYlKiajTKjlly82hIHAgFBXbRNRVhHmeWHaRh8ip3HeIJnb7UEH6nUUGJY9/iMVRJy9GMe9D4hUsos1GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733350037; c=relaxed/simple;
	bh=0NK5fQhfJILN0TmhkBr2bI0x1f488pGh3da65yqbmFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=imwOeAOaScwGwL3PkTYcxMVQzxrjS9tiPwXbr5baXV878VoOiWRigFHoeBBFB1Z9Hp3WyN80km3MLfC9tuKTJ1PVqMTpkIhOMnBdXJWNf0e7AJY4C72cHWf+T3pVQ0dvGBWCbZTUC0t6oywbhESeUDO6Z9uDZgLGhgX06cCCPuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Op6mzCz1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD8FC4CECD;
	Wed,  4 Dec 2024 22:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733350037;
	bh=0NK5fQhfJILN0TmhkBr2bI0x1f488pGh3da65yqbmFQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Op6mzCz1FvyZlml6vvKnA9GU9VbNHkr2o+biDrWlxtvNU9wyXGmOZMjK0XHUo6v4Q
	 B2MIC5XXbopePloosKHH+2BK7FqKn1xe3D40PKwZDv/TMTMZP2o+FzHX/q6T9fYP5N
	 ib8lPshlmJBxKXdTTWx/ST/q/AdvKKZ18TGCBRYcpslx30fPfgd3JlNeugD2RkDwgz
	 2lb9rx2Ju+3aM+2J5uaWecNHJlJflUBimk7jLaGy7kG2Hu/iFORWFcBg3AePU9WH+3
	 /ZWTt83ftjE6P4FOb/sGFa+oM6m2z4+poIVSRS0D3fAKiUIfVIALwflTcpV8M5dfiT
	 Icf2+jhJxRHBg==
Date: Wed, 4 Dec 2024 16:07:15 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Improve parameter docu for request APIs
Message-ID: <20241204220715.GA3023116@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203100023.31152-2-pstanner@redhat.com>

On Tue, Dec 03, 2024 at 11:00:24AM +0100, Philipp Stanner wrote:
> PCI region request functions have a @name parameter (sometimes called
> "res_name"). It is used in a log message to inform drivers about request
> collisions, i.e., when another driver has requested that region already.
> 
> This message is only useful when it contains the actual owner of the
> region, i.e., which driver requested it. So far, a great many drivers
> misuse the @name parameter and just pass pci_name(), which doesn't
> result in useful debug information.
> 
> Rename "res_name" to "name".
> 
> Detail @name's purpose in the docstrings.
> 
> Improve formatting a bit.
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

Applied to pci/resource for v6.14, thanks!

> ---
>  drivers/pci/devres.c | 12 ++++----
>  drivers/pci/pci.c    | 69 +++++++++++++++++++++-----------------------
>  2 files changed, 39 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
> index 3b59a86a764b..ffaffa880b88 100644
> --- a/drivers/pci/devres.c
> +++ b/drivers/pci/devres.c
> @@ -101,7 +101,7 @@ static inline void pcim_addr_devres_clear(struct pcim_addr_devres *res)
>   * @bar: BAR the range is within
>   * @offset: offset from the BAR's start address
>   * @maxlen: length in bytes, beginning at @offset
> - * @name: name associated with the request
> + * @name: name of the resource requestor
>   * @req_flags: flags for the request, e.g., for kernel-exclusive requests
>   *
>   * Returns: 0 on success, a negative error code on failure.
> @@ -723,7 +723,7 @@ EXPORT_SYMBOL(pcim_iounmap);
>   * pcim_iomap_region - Request and iomap a PCI BAR
>   * @pdev: PCI device to map IO resources for
>   * @bar: Index of a BAR to map
> - * @name: Name associated with the request
> + * @name: Name of the resource requestor
>   *
>   * Returns: __iomem pointer on success, an IOMEM_ERR_PTR on failure.
>   *
> @@ -790,7 +790,7 @@ EXPORT_SYMBOL(pcim_iounmap_region);
>   * pcim_iomap_regions - Request and iomap PCI BARs (DEPRECATED)
>   * @pdev: PCI device to map IO resources for
>   * @mask: Mask of BARs to request and iomap
> - * @name: Name associated with the requests
> + * @name: Name of the resource requestor
>   *
>   * Returns: 0 on success, negative error code on failure.
>   *
> @@ -857,7 +857,7 @@ static int _pcim_request_region(struct pci_dev *pdev, int bar, const char *name,
>   * pcim_request_region - Request a PCI BAR
>   * @pdev: PCI device to requestion region for
>   * @bar: Index of BAR to request
> - * @name: Name associated with the request
> + * @name: Name of the resource requestor
>   *
>   * Returns: 0 on success, a negative error code on failure.
>   *
> @@ -876,7 +876,7 @@ EXPORT_SYMBOL(pcim_request_region);
>   * pcim_request_region_exclusive - Request a PCI BAR exclusively
>   * @pdev: PCI device to requestion region for
>   * @bar: Index of BAR to request
> - * @name: Name associated with the request
> + * @name: Name of the resource requestor
>   *
>   * Returns: 0 on success, a negative error code on failure.
>   *
> @@ -932,7 +932,7 @@ static void pcim_release_all_regions(struct pci_dev *pdev)
>  /**
>   * pcim_request_all_regions - Request all regions
>   * @pdev: PCI device to map IO resources for
> - * @name: name associated with the request
> + * @name: Name of the resource requestor
>   *
>   * Returns: 0 on success, negative error code on failure.
>   *
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 0b29ec6e8e5e..cb96d12571a8 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3941,15 +3941,14 @@ EXPORT_SYMBOL(pci_release_region);
>   * __pci_request_region - Reserved PCI I/O and memory resource
>   * @pdev: PCI device whose resources are to be reserved
>   * @bar: BAR to be reserved
> - * @res_name: Name to be associated with resource.
> + * @name: Name of the resource requestor
>   * @exclusive: whether the region access is exclusive or not
>   *
>   * Returns: 0 on success, negative error code on failure.
>   *
> - * Mark the PCI region associated with PCI device @pdev BAR @bar as
> - * being reserved by owner @res_name.  Do not access any
> - * address inside the PCI regions unless this call returns
> - * successfully.
> + * Mark the PCI region associated with PCI device @pdev BAR @bar as being
> + * reserved by owner @name. Do not access any address inside the PCI regions
> + * unless this call returns successfully.
>   *
>   * If @exclusive is set, then the region is marked so that userspace
>   * is explicitly not allowed to map the resource via /dev/mem or
> @@ -3959,13 +3958,13 @@ EXPORT_SYMBOL(pci_release_region);
>   * message is also printed on failure.
>   */
>  static int __pci_request_region(struct pci_dev *pdev, int bar,
> -				const char *res_name, int exclusive)
> +				const char *name, int exclusive)
>  {
>  	if (pci_is_managed(pdev)) {
>  		if (exclusive == IORESOURCE_EXCLUSIVE)
> -			return pcim_request_region_exclusive(pdev, bar, res_name);
> +			return pcim_request_region_exclusive(pdev, bar, name);
>  
> -		return pcim_request_region(pdev, bar, res_name);
> +		return pcim_request_region(pdev, bar, name);
>  	}
>  
>  	if (pci_resource_len(pdev, bar) == 0)
> @@ -3973,11 +3972,11 @@ static int __pci_request_region(struct pci_dev *pdev, int bar,
>  
>  	if (pci_resource_flags(pdev, bar) & IORESOURCE_IO) {
>  		if (!request_region(pci_resource_start(pdev, bar),
> -			    pci_resource_len(pdev, bar), res_name))
> +			    pci_resource_len(pdev, bar), name))
>  			goto err_out;
>  	} else if (pci_resource_flags(pdev, bar) & IORESOURCE_MEM) {
>  		if (!__request_mem_region(pci_resource_start(pdev, bar),
> -					pci_resource_len(pdev, bar), res_name,
> +					pci_resource_len(pdev, bar), name,
>  					exclusive))
>  			goto err_out;
>  	}
> @@ -3994,14 +3993,13 @@ static int __pci_request_region(struct pci_dev *pdev, int bar,
>   * pci_request_region - Reserve PCI I/O and memory resource
>   * @pdev: PCI device whose resources are to be reserved
>   * @bar: BAR to be reserved
> - * @res_name: Name to be associated with resource
> + * @name: Name of the resource requestor
>   *
>   * Returns: 0 on success, negative error code on failure.
>   *
> - * Mark the PCI region associated with PCI device @pdev BAR @bar as
> - * being reserved by owner @res_name.  Do not access any
> - * address inside the PCI regions unless this call returns
> - * successfully.
> + * Mark the PCI region associated with PCI device @pdev BAR @bar as being
> + * reserved by owner @name. Do not access any address inside the PCI regions
> + * unless this call returns successfully.
>   *
>   * Returns 0 on success, or %EBUSY on error.  A warning
>   * message is also printed on failure.
> @@ -4011,9 +4009,9 @@ static int __pci_request_region(struct pci_dev *pdev, int bar,
>   * when pcim_enable_device() has been called in advance. This hybrid feature is
>   * DEPRECATED! If you want managed cleanup, use the pcim_* functions instead.
>   */
> -int pci_request_region(struct pci_dev *pdev, int bar, const char *res_name)
> +int pci_request_region(struct pci_dev *pdev, int bar, const char *name)
>  {
> -	return __pci_request_region(pdev, bar, res_name, 0);
> +	return __pci_request_region(pdev, bar, name, 0);
>  }
>  EXPORT_SYMBOL(pci_request_region);
>  
> @@ -4036,13 +4034,13 @@ void pci_release_selected_regions(struct pci_dev *pdev, int bars)
>  EXPORT_SYMBOL(pci_release_selected_regions);
>  
>  static int __pci_request_selected_regions(struct pci_dev *pdev, int bars,
> -					  const char *res_name, int excl)
> +					  const char *name, int excl)
>  {
>  	int i;
>  
>  	for (i = 0; i < PCI_STD_NUM_BARS; i++)
>  		if (bars & (1 << i))
> -			if (__pci_request_region(pdev, i, res_name, excl))
> +			if (__pci_request_region(pdev, i, name, excl))
>  				goto err_out;
>  	return 0;
>  
> @@ -4059,7 +4057,7 @@ static int __pci_request_selected_regions(struct pci_dev *pdev, int bars,
>   * pci_request_selected_regions - Reserve selected PCI I/O and memory resources
>   * @pdev: PCI device whose resources are to be reserved
>   * @bars: Bitmask of BARs to be requested
> - * @res_name: Name to be associated with resource
> + * @name: Name of the resource requestor
>   *
>   * Returns: 0 on success, negative error code on failure.
>   *
> @@ -4069,9 +4067,9 @@ static int __pci_request_selected_regions(struct pci_dev *pdev, int bars,
>   * DEPRECATED! If you want managed cleanup, use the pcim_* functions instead.
>   */
>  int pci_request_selected_regions(struct pci_dev *pdev, int bars,
> -				 const char *res_name)
> +				 const char *name)
>  {
> -	return __pci_request_selected_regions(pdev, bars, res_name, 0);
> +	return __pci_request_selected_regions(pdev, bars, name, 0);
>  }
>  EXPORT_SYMBOL(pci_request_selected_regions);
>  
> @@ -4079,7 +4077,7 @@ EXPORT_SYMBOL(pci_request_selected_regions);
>   * pci_request_selected_regions_exclusive - Request regions exclusively
>   * @pdev: PCI device to request regions from
>   * @bars: bit mask of BARs to request
> - * @res_name: name to be associated with the requests
> + * @name: Name of the resource requestor
>   *
>   * Returns: 0 on success, negative error code on failure.
>   *
> @@ -4089,9 +4087,9 @@ EXPORT_SYMBOL(pci_request_selected_regions);
>   * DEPRECATED! If you want managed cleanup, use the pcim_* functions instead.
>   */
>  int pci_request_selected_regions_exclusive(struct pci_dev *pdev, int bars,
> -					   const char *res_name)
> +					   const char *name)
>  {
> -	return __pci_request_selected_regions(pdev, bars, res_name,
> +	return __pci_request_selected_regions(pdev, bars, name,
>  			IORESOURCE_EXCLUSIVE);
>  }
>  EXPORT_SYMBOL(pci_request_selected_regions_exclusive);
> @@ -4114,12 +4112,11 @@ EXPORT_SYMBOL(pci_release_regions);
>  /**
>   * pci_request_regions - Reserve PCI I/O and memory resources
>   * @pdev: PCI device whose resources are to be reserved
> - * @res_name: Name to be associated with resource.
> + * @name: Name of the resource requestor
>   *
> - * Mark all PCI regions associated with PCI device @pdev as
> - * being reserved by owner @res_name.  Do not access any
> - * address inside the PCI regions unless this call returns
> - * successfully.
> + * Mark all PCI regions associated with PCI device @pdev as being reserved by
> + * owner @name. Do not access any address inside the PCI regions unless this
> + * call returns successfully.
>   *
>   * Returns 0 on success, or %EBUSY on error.  A warning
>   * message is also printed on failure.
> @@ -4129,22 +4126,22 @@ EXPORT_SYMBOL(pci_release_regions);
>   * when pcim_enable_device() has been called in advance. This hybrid feature is
>   * DEPRECATED! If you want managed cleanup, use the pcim_* functions instead.
>   */
> -int pci_request_regions(struct pci_dev *pdev, const char *res_name)
> +int pci_request_regions(struct pci_dev *pdev, const char *name)
>  {
>  	return pci_request_selected_regions(pdev,
> -			((1 << PCI_STD_NUM_BARS) - 1), res_name);
> +			((1 << PCI_STD_NUM_BARS) - 1), name);
>  }
>  EXPORT_SYMBOL(pci_request_regions);
>  
>  /**
>   * pci_request_regions_exclusive - Reserve PCI I/O and memory resources
>   * @pdev: PCI device whose resources are to be reserved
> - * @res_name: Name to be associated with resource.
> + * @name: Name of the resource requestor
>   *
>   * Returns: 0 on success, negative error code on failure.
>   *
>   * Mark all PCI regions associated with PCI device @pdev as being reserved
> - * by owner @res_name.  Do not access any address inside the PCI regions
> + * by owner @name. Do not access any address inside the PCI regions
>   * unless this call returns successfully.
>   *
>   * pci_request_regions_exclusive() will mark the region so that /dev/mem
> @@ -4158,10 +4155,10 @@ EXPORT_SYMBOL(pci_request_regions);
>   * when pcim_enable_device() has been called in advance. This hybrid feature is
>   * DEPRECATED! If you want managed cleanup, use the pcim_* functions instead.
>   */
> -int pci_request_regions_exclusive(struct pci_dev *pdev, const char *res_name)
> +int pci_request_regions_exclusive(struct pci_dev *pdev, const char *name)
>  {
>  	return pci_request_selected_regions_exclusive(pdev,
> -				((1 << PCI_STD_NUM_BARS) - 1), res_name);
> +				((1 << PCI_STD_NUM_BARS) - 1), name);
>  }
>  EXPORT_SYMBOL(pci_request_regions_exclusive);
>  
> -- 
> 2.47.0
> 

