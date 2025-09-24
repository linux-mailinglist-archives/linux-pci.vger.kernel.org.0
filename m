Return-Path: <linux-pci+bounces-36911-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 806D5B9CB6E
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 01:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 896851B27E04
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 23:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BC8273D6F;
	Wed, 24 Sep 2025 23:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F86ehh5+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA55611E;
	Wed, 24 Sep 2025 23:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758757709; cv=none; b=oQUt36HHDIWeENpbVBQvi49sVG9ba3gjbjGHQA9snKVCLARQx+4Y8GDDXjq9szQtdwO/xlDOs29QFlRSaHRPuVe3C68qL817fLMFKK1f0QVUOq2+fbJX26ZJJG/aKvkUxyp/mqvBlKrCIEI7PPezKKkn+PmovN2QRmCsgN9xQYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758757709; c=relaxed/simple;
	bh=WhjUmH6pVhrmr65bjdt4qxwE7j+BOahAh7bAwCu0juQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Yj9ud/GxGMlKjh8sypM6vqfvqvmd5rymzNtCRe/MxDdJLVBvMKb0dDgAZntK/rANVU2fhSsqcDFR652wVHvWoVIVJfKzc7DRQPEoxfMxL3K9b/iIdkyR4zUbfYnxLJcfUgwozcgN1aPjo0yHe2pclA8dOCpfPROu2gicrMaPl/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F86ehh5+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA69C4CEE7;
	Wed, 24 Sep 2025 23:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758757709;
	bh=WhjUmH6pVhrmr65bjdt4qxwE7j+BOahAh7bAwCu0juQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=F86ehh5+ie9GQ/pUou6FyEKwTrpVexaEzT7rvik40FeC9i9drso1aMFyoksmd6E6N
	 v0f5oGWcdU44KAUZyT4W0LCJIM/I0FryaFWUEiaNxrnI7uuxxODb5Tjk2OHn8nGo5C
	 6yJboMoKdtcAMgs+yKn7CzYz5hqPYVl0c/F28fkQiq82AkeWNTkTtyuLjfH6BNTLBk
	 F/e/QTemaqjBSaE/DiGCIJJ1inVtDANPPoKp5cgV3BwYnNV6EzcjoGOTnyyU2RDTfN
	 8hbNQ/fOfmXMG6s/CVWwau7u+xslo+kZAwEEpoyD3B6dFbQXyYLAuurkESG/WWfQJH
	 OijVhJF4tla/Q==
Date: Wed, 24 Sep 2025 18:48:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: Don't print stale information about resource
Message-ID: <20250924234828.GA2143336@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250924135641.3399-1-ilpo.jarvinen@linux.intel.com>

On Wed, Sep 24, 2025 at 04:56:41PM +0300, Ilpo Järvinen wrote:
> pbus_size_mem() logs the bridge window resource using pci_info() before
> the start and end fields of the resource have been updated which then
> prints stale information.
> 
> Set resource addresses earlier to make understanding logs easier.
> Regrettably, this results in setting the addresses multiple times but
> that seems unavoidable.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Applied to pci/resource for v6.18, thanks!

> ---
> 
> Based on top of pci/resource branch.
> 
>  drivers/pci/setup-bus.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index d264f16772b9..362ad108794d 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1317,6 +1317,7 @@ static void pbus_size_mem(struct pci_bus *bus, unsigned long type,
>  	resource_size_t children_add_align = 0;
>  	resource_size_t add_align = 0;
>  	resource_size_t relaxed_align;
> +	resource_size_t old_size;
>  
>  	if (!b_res)
>  		return;
> @@ -1387,20 +1388,24 @@ static void pbus_size_mem(struct pci_bus *bus, unsigned long type,
>  		}
>  	}
>  
> +	old_size = resource_size(b_res);
>  	win_align = window_alignment(bus, b_res->flags);
>  	min_align = calculate_mem_align(aligns, max_order);
>  	min_align = max(min_align, win_align);
> -	size0 = calculate_memsize(size, min_size, 0, 0, resource_size(b_res), min_align);
> +	size0 = calculate_memsize(size, min_size, 0, 0, old_size, min_align);
>  
> -	if (size0)
> +	if (size0) {
> +		resource_set_range(b_res, min_align, size0);
>  		b_res->flags &= ~IORESOURCE_DISABLED;
> +	}
>  
>  	if (bus->self && size0 &&
>  	    !pbus_upstream_space_available(bus, b_res, size0, min_align)) {
>  		relaxed_align = 1ULL << (max_order + __ffs(SZ_1M));
>  		relaxed_align = max(relaxed_align, win_align);
>  		min_align = min(min_align, relaxed_align);
> -		size0 = calculate_memsize(size, min_size, 0, 0, resource_size(b_res), win_align);
> +		size0 = calculate_memsize(size, min_size, 0, 0, old_size, win_align);
> +		resource_set_range(b_res, min_align, size0);
>  		pci_info(bus->self, "bridge window %pR to %pR requires relaxed alignment rules\n",
>  			 b_res, &bus->busn_res);
>  	}
> @@ -1408,7 +1413,7 @@ static void pbus_size_mem(struct pci_bus *bus, unsigned long type,
>  	if (realloc_head && (add_size > 0 || children_add_size > 0)) {
>  		add_align = max(min_align, add_align);
>  		size1 = calculate_memsize(size, min_size, add_size, children_add_size,
> -					  resource_size(b_res), add_align);
> +					  old_size, add_align);
>  
>  		if (bus->self && size1 &&
>  		    !pbus_upstream_space_available(bus, b_res, size1, add_align)) {
> @@ -1416,7 +1421,7 @@ static void pbus_size_mem(struct pci_bus *bus, unsigned long type,
>  			relaxed_align = max(relaxed_align, win_align);
>  			min_align = min(min_align, relaxed_align);
>  			size1 = calculate_memsize(size, min_size, add_size, children_add_size,
> -						  resource_size(b_res), win_align);
> +						  old_size, win_align);
>  			pci_info(bus->self,
>  				 "bridge window %pR to %pR requires relaxed alignment rules\n",
>  				 b_res, &bus->busn_res);
> 
> base-commit: 43b4f7cd064b2ae11742f33e2af195adae00c617
> -- 
> 2.39.5
> 

