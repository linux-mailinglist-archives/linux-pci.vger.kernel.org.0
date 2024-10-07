Return-Path: <linux-pci+bounces-13940-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3DE9926D4
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 10:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C06171C22210
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 08:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E34188703;
	Mon,  7 Oct 2024 08:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zw2XUJV+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A7517C203
	for <linux-pci@vger.kernel.org>; Mon,  7 Oct 2024 08:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728289404; cv=none; b=tXcvp3jqAyID3ykBzOpFF0Rk6KOJeSxdcKy4lUiSVQ5dd2HQDVRpSSHGEYZoXJiMNfp+32WEx+0e7WFBg2IqmipmSsAVopXVc/eQdn+nxJKX5YPxFcc2a+RDHRQ/9gj+H0i76PF4+aqMbdDc3ruTkquvdNOA5egOjiNknr6Nwds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728289404; c=relaxed/simple;
	bh=UsRL1Egvtgwli1Ibmy1cZT9ccDJi12om28uR2KCPYPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rm/GOaTjoaNWc1/Hd7GVf4t/fRk2pJb3BKeKF7v0PWOBDKO04jpvmm6NGzmKDlOqEhU43tjGIOEC0KoyXMEtJ+yU/ErlJGuwkjvHySdos/OnH8fPyXBI9KEY59yurKYjU2S6HfggFv+A6Ob9Rb8ISkdxGR+WUjg1pSIDHGF15Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zw2XUJV+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA5EC4CEC6;
	Mon,  7 Oct 2024 08:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728289403;
	bh=UsRL1Egvtgwli1Ibmy1cZT9ccDJi12om28uR2KCPYPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zw2XUJV+5erRYRKQN7ffebDJAZ1lhTVS7HtZnrm0qHwYTfWaAqOnSd0JEGDV1gRTQ
	 RKIF1vI7a3fLGnvPBQXqvp2nxoT8uKy51M59BaHKfQ29wGGL5+c3UzDTAo6qd7Cz1i
	 4oVQ/dx80rg4BZEigaLAfjpmc3e4Wn2XdUjxXhhtj6xIU8PH6awH9bBSZ5dhRVdJL8
	 Jz6nGWU0TA8w3rJaVTV0+r/U4yipIZA3TV8BlLgvBj/UQNJLx8bktbNhib8UvHwXIJ
	 oa7Ws/7PYg4/7pxXEwB3b+eNG4H1ng7go1ICZ3NpkBBvt4qbAbCNfmaWSk6zJtDHm7
	 AWo2VXCrf6m8g==
Date: Mon, 7 Oct 2024 10:23:17 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>
Subject: Re: [PATCH v4 2/7] PCI: endpoint: Improve pci_epc_mem_alloc_addr()
Message-ID: <ZwOadSYUowBGsp6f@ryzen>
References: <20241007040319.157412-1-dlemoal@kernel.org>
 <20241007040319.157412-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007040319.157412-3-dlemoal@kernel.org>

On Mon, Oct 07, 2024 at 01:03:14PM +0900, Damien Le Moal wrote:
> There is no point in attempting to allocate memory from an endpoint
> controller memory window if the requested size is larger than the memory
> window size. Add a check to skip bitmap_find_free_region() calls for
> such case. This check can be done without the mem->lock mutex held as
> memory window sizes are constant and never modified at runtime.
> Also change the final return to return NULL to simplify the code.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/pci/endpoint/pci-epc-mem.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
> index a9c028f58da1..218a60e945db 100644
> --- a/drivers/pci/endpoint/pci-epc-mem.c
> +++ b/drivers/pci/endpoint/pci-epc-mem.c
> @@ -178,7 +178,7 @@ EXPORT_SYMBOL_GPL(pci_epc_mem_exit);
>  void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
>  				     phys_addr_t *phys_addr, size_t size)
>  {
> -	void __iomem *virt_addr = NULL;
> +	void __iomem *virt_addr;
>  	struct pci_epc_mem *mem;
>  	unsigned int page_shift;
>  	size_t align_size;
> @@ -188,10 +188,13 @@ void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
>  
>  	for (i = 0; i < epc->num_windows; i++) {
>  		mem = epc->windows[i];
> -		mutex_lock(&mem->lock);
> +		if (size > mem->window.size)
> +			continue;
> +
>  		align_size = ALIGN(size, mem->window.page_size);
>  		order = pci_epc_mem_get_order(mem, align_size);
>  
> +		mutex_lock(&mem->lock);
>  		pageno = bitmap_find_free_region(mem->bitmap, mem->pages,
>  						 order);
>  		if (pageno >= 0) {
> @@ -211,7 +214,7 @@ void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
>  		mutex_unlock(&mem->lock);
>  	}
>  
> -	return virt_addr;
> +	return NULL;
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_mem_alloc_addr);
>  
> -- 
> 2.46.2
> 

Reviewed-by: Niklas Cassel <cassel@kernel.org>

