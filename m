Return-Path: <linux-pci+bounces-13813-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5937A990251
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 13:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0434D1F21940
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 11:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC5214A4E7;
	Fri,  4 Oct 2024 11:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtcYvbDO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256A21D5AD8
	for <linux-pci@vger.kernel.org>; Fri,  4 Oct 2024 11:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728042334; cv=none; b=TPILiZXcD588c5ESf0Uu9oFm9HYVPf5fZj+w/kkyQdhFaC/nhck719wsFXOJxL9PJoR1keR6bluS2PBJAUvtpVA+WpWgL+e7/hsfYcaa/EuL4fQEBMGxR2fTH7mEK3BTtjRTCzJN4NSLaV22R+uos70lHA1ofY/LsBDj4yXdbkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728042334; c=relaxed/simple;
	bh=/wRPsVjpoCluQAabsarxc843Qr9VkfhycfYZKlJ5yBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jk6p1mk4+OMuk8kf+sNIbOljWndoY/NahIOz+JUGnEVjIPXYNLuq50x42GLWCXD5JDWJ3xbDrw5L+NJGNhTXBXNZAhNNiM70Ym6bSgTxLq+gTlEAi10iVnAneXx0rRla6aDVUCybz7E/jJv3X20EAqI7Z8phJ277HS6Dn+FgNgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtcYvbDO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55293C4CEC6;
	Fri,  4 Oct 2024 11:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728042333;
	bh=/wRPsVjpoCluQAabsarxc843Qr9VkfhycfYZKlJ5yBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gtcYvbDO9Wil4jLYuUFsVsU1Iw+9Lrc7k2E9uswWPsh0eGUFlQLAAIvzPHjCTJe5R
	 26Ca2dcFwwpt8cUI/o2l78jsNBfNSyQmLTDmVvr7ITXq9+Y9UlIJlWfIE1Rj1N8bxx
	 Ql+hEbDWgNLtz8GQhWvSxH+PL5gAZYFBho2rSQ7s27aOdHO+By6iZ090WVm+9kMImQ
	 F61rPW4/H9qNf6k60w0U/Lo0FFwaiw7bFQ9P5a3PldS6cpApaUD43kTKZOj0wpLpRj
	 f7YIV7864ddOt23KkQRPF5dFPb2UF8NLiuO5s043KbudrEiGxK3X4uyduYQNHq/c1U
	 B9tgSOSr9gK9A==
Date: Fri, 4 Oct 2024 13:45:28 +0200
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
Subject: Re: [PATCH v3 2/7] PCI: endpoint: Improve pci_epc_mem_alloc_addr()
Message-ID: <Zv_VWL630rLJFR5B@ryzen.lan>
References: <20241004050742.140664-1-dlemoal@kernel.org>
 <20241004050742.140664-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004050742.140664-3-dlemoal@kernel.org>

On Fri, Oct 04, 2024 at 02:07:37PM +0900, Damien Le Moal wrote:
> There is no point in attempting to allocate memory from an endpoint
> controller memory window if the requested size is larger than the window
> size. Add a check to skip bitmap_find_free_region() calls for such case.
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

Perhaps mention in the commit message why it is safe to move the mutex_lock() ?


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

