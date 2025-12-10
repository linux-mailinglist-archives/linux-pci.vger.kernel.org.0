Return-Path: <linux-pci+bounces-42911-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C5CCB4105
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 22:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 000F7300FB06
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 21:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF8F322B70;
	Wed, 10 Dec 2025 21:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3ELAxdY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B722F8BD1;
	Wed, 10 Dec 2025 21:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765402204; cv=none; b=HF3IAFi2HBJBFSZY4BadZ7I5VVjYhz0n+dLGqh1J0dSsAN61Ye4XrZ7hl2ceWlgv8K4nOLxOkQs5HAVAR0W1eoHt2zq/sLMUzunesqNIGPHrRUHk4SNZPEuc9qRJocWLmHUZJEaBKh4pMIGv9IqlsliR+tmHmLVKV2skr4r5+80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765402204; c=relaxed/simple;
	bh=/p4vU9wPYlH2uVTHiPk+j/EvZ4vL7UAVHTXYH0qeE5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZMvHwAOQRhsSoaTq1ABj3jlzvcBkhMaR/WX47kopX/X2g9KnBPTAcM/xbMUunYecW51gqzblsOFQmOmchGjY2R9c61AozVXdLyCnJboEgOh1JUAfNpcVWhkzOebnqXKM2bmRHpMFx/d1RU4A5IOwslQ5roGLS53aHy0Yk8o1Sqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3ELAxdY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA06C4CEF1;
	Wed, 10 Dec 2025 21:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765402203;
	bh=/p4vU9wPYlH2uVTHiPk+j/EvZ4vL7UAVHTXYH0qeE5Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=J3ELAxdYGsD/BqpTvio1oCkPfYBC0uVZe8OKhZVK9wWQHQfF1Z5uWXaDXqrUgDVcn
	 QvfnUGv6Rb5xtnKNzH/Kbrg2f0QXGpWvxobMb01Fre2iHJxjhql2omSCxhcWhS9k8V
	 wefkegR8fikoqzaZH63SkyXvuYsI2cy6z+4FlndiIgQt2+wIYra1rVGknA9uO6wj9H
	 yRhFNGO5sUWtiMSY+VFMPhpWLvm4T/vS5qSsEK6aD0Jmwv4Di07jObBt1ED9a+zufp
	 YDtUBFX4xOLNLligMDKmTUpBbTJgM5zPF320I8erQXiCPNd1oNFOaSTN1+1Tt59+/7
	 mfUp3GvTYdZ2A==
Date: Wed, 10 Dec 2025 15:30:02 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH 1/1] PCI: Use resource_set_range() that correctly sets
 ->end
Message-ID: <20251210213002.GA3540876@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251208145654.5294-1-ilpo.jarvinen@linux.intel.com>

On Mon, Dec 08, 2025 at 04:56:54PM +0200, Ilpo Järvinen wrote:
> __pci_read_base() sets resource start and end addresses when resource
> is larger than 4G but pci_bus_addr_t or resource_size_t are not capable
> of representing 64-bit PCI addresses. This creates a problematic
> resource that has non-zero flags but the start and end addresses do not
> yield to resource size of 0 but 1.
> 
> Replace custom resource addresses setup with resource_set_range()
> that correctly sets end address as -1 which results in resource_size()
> returning 0.
> 
> For consistency, also use resource_set_range() in the other branch that
> does size based resource setup.
> 
> Fixes: 23b13bc76f35 ("PCI: Fail safely if we can't handle BARs larger than 4GB")
> Link: https://lore.kernel.org/all/20251207215359.28895-1-ansuelsmth@gmail.com/T/#m990492684913c5a158ff0e5fc90697d8ad95351b
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Cc: stable@vger.kernel.org
> Cc: Christian Marangi <ansuelsmth@gmail.com>

Applied to pci/resource for v6.20, thanks!

> ---
>  drivers/pci/probe.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 124d2d309c58..b8294a2f11f9 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -287,8 +287,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
>  		if ((sizeof(pci_bus_addr_t) < 8 || sizeof(resource_size_t) < 8)
>  		    && sz64 > 0x100000000ULL) {
>  			res->flags |= IORESOURCE_UNSET | IORESOURCE_DISABLED;
> -			res->start = 0;
> -			res->end = 0;
> +			resource_set_range(res, 0, 0);
>  			pci_err(dev, "%s: can't handle BAR larger than 4GB (size %#010llx)\n",
>  				res_name, (unsigned long long)sz64);
>  			goto out;
> @@ -297,8 +296,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
>  		if ((sizeof(pci_bus_addr_t) < 8) && l) {
>  			/* Above 32-bit boundary; try to reallocate */
>  			res->flags |= IORESOURCE_UNSET;
> -			res->start = 0;
> -			res->end = sz64 - 1;
> +			resource_set_range(res, 0, sz64);
>  			pci_info(dev, "%s: can't handle BAR above 4GB (bus address %#010llx)\n",
>  				 res_name, (unsigned long long)l64);
>  			goto out;
> 
> base-commit: 43dfc13ca972988e620a6edb72956981b75ab6b0
> -- 
> 2.39.5
> 

