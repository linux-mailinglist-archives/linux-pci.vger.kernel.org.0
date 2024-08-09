Return-Path: <linux-pci+bounces-11565-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6248594D7DE
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 22:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94D791C22A33
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 20:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1D21607A3;
	Fri,  9 Aug 2024 20:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSN8kmxT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213B41D551;
	Fri,  9 Aug 2024 20:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723234194; cv=none; b=R2MCvLClsQsBmOrTm/G7Gm9FKMoTql3cVn12AERquk0UjQpr2CCpe5+Fusy+L+KdDOlOXSQyY7QTe0oiM4wlmkX1Ix2JUeA4ntBhrwh9dZw/nhlrWA961jr22nHQaRD0jiOLl48hgdlDXWeZjAQoB/MWd/T1Se6oYK50WoegUI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723234194; c=relaxed/simple;
	bh=TWxH6MDJR9vRLD6TqLUh9ECs1rCynCgT1oMUueBC3RM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kL9Uqp+g0Cjd71q6GUnA6mNh0jNDJwGi4RP5Ctiq5kByrRn2XJxkwNQ0nQP+DoLLRgXsGBuJjSLpC5XaW4ar7yQ2VuOkqn4b8sFbq4UwlOdxZ+K1zmZS9GuNPB5RIkeXV+rX40BHJ5KUcaHV97zVVbd3FzlhxcIh7MUO7p2SptE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sSN8kmxT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0C0C32782;
	Fri,  9 Aug 2024 20:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723234193;
	bh=TWxH6MDJR9vRLD6TqLUh9ECs1rCynCgT1oMUueBC3RM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=sSN8kmxTVsrWlr2igibsenVZPmn5OL7VoacyHOU+SJMd8MhnxzQSP02RE26i06UpJ
	 hplG+16G3uUgovdzBXMS1NBc+H+7Az/7hFlZyHdE6HrTUn4p/Jvji4Y+6sPVSmREbU
	 u6GNVdhnqptx8tK/eTKptzdX+Njv3kbEl3Yq3Ifq5pbsBr1LRZxwZOqF7e/wPqs4LN
	 Yjij0yX81+HmBupuxTp/2MR1DSNgmEr0mTyiBDnoXP0N8mzjR7UZiwTDw+a/Rnkop+
	 7fW09DtM25aKRzqme4eU+32qcXFIQ5Pnrc/lTfxnMyRGHEKtxy+wbEmvusj4i8Uj+R
	 Tpb821IpSJ+UQ==
Date: Fri, 9 Aug 2024 15:09:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Dave Airlie <airlied@redhat.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: Deprecate pcim_iomap_regions() in favor of
 pcim_iomap_region()
Message-ID: <20240809200951.GA212090@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807083018.8734-2-pstanner@redhat.com>

On Wed, Aug 07, 2024 at 10:30:18AM +0200, Philipp Stanner wrote:
> pcim_iomap_regions() is a complicated function that uses a bit mask to
> determine the BARs the user wishes to request and ioremap. Almost all
> users only ever set a single bit in that mask, making that mechanism
> questionable.
> 
> pcim_iomap_region() is now available as a more simple replacement.
> 
> Make pcim_iomap_region() a public function.
> 
> Mark pcim_iomap_regions() as deprecated.
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

Both applied (second with Thomas' reviewed-by and Dave's ack) to
pci/devres for v6.12, thanks!

> ---
>  drivers/pci/devres.c | 8 ++++++--
>  include/linux/pci.h  | 2 ++
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
> index 3780a9f9ec00..89ec26ea1501 100644
> --- a/drivers/pci/devres.c
> +++ b/drivers/pci/devres.c
> @@ -728,7 +728,7 @@ EXPORT_SYMBOL(pcim_iounmap);
>   * Mapping and region will get automatically released on driver detach. If
>   * desired, release manually only with pcim_iounmap_region().
>   */
> -static void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
> +void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
>  				       const char *name)
>  {
>  	int ret;
> @@ -761,6 +761,7 @@ static void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
>  
>  	return IOMEM_ERR_PTR(ret);
>  }
> +EXPORT_SYMBOL(pcim_iomap_region);
>  
>  /**
>   * pcim_iounmap_region - Unmap and release a PCI BAR
> @@ -783,7 +784,7 @@ static void pcim_iounmap_region(struct pci_dev *pdev, int bar)
>  }
>  
>  /**
> - * pcim_iomap_regions - Request and iomap PCI BARs
> + * pcim_iomap_regions - Request and iomap PCI BARs (DEPRECATED)
>   * @pdev: PCI device to map IO resources for
>   * @mask: Mask of BARs to request and iomap
>   * @name: Name associated with the requests
> @@ -791,6 +792,9 @@ static void pcim_iounmap_region(struct pci_dev *pdev, int bar)
>   * Returns: 0 on success, negative error code on failure.
>   *
>   * Request and iomap regions specified by @mask.
> + *
> + * This function is DEPRECATED. Do not use it in new code.
> + * Use pcim_iomap_region() instead.
>   */
>  int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name)
>  {
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 4cf89a4b4cbc..fc30176d28ca 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2292,6 +2292,8 @@ static inline void pci_fixup_device(enum pci_fixup_pass pass,
>  void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen);
>  void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr);
>  void __iomem * const *pcim_iomap_table(struct pci_dev *pdev);
> +void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
> +				       const char *name);
>  int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name);
>  int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
>  				   const char *name);
> -- 
> 2.45.2
> 

