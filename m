Return-Path: <linux-pci+bounces-25408-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C35CA7E51E
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 17:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E2B03B3931
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 15:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F211FF7D1;
	Mon,  7 Apr 2025 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqhfbebs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F931FF7A1;
	Mon,  7 Apr 2025 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744040163; cv=none; b=Jza3WVPX1TKazNWs5uusV0bKYBg3FyI2dl6Iisg0oG1jmM1BoLorBeqk7GXjXNG1TzCyVLFMpJwEPOVKc+XUqE05vGo6iFebAy4no/rKb0AbPPt2eWwzwXzF9rj6ojg30H2R6q3FzNNnx0wvIJNqkOdvQviiPN3VGFOkcFwHTu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744040163; c=relaxed/simple;
	bh=vxoIfOH3hv+8JcQzJTe2JCQ2H+ulfHSIZy2SW/nfLss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5tHFBMBSbaLYf+y8ZvweDpgSQwGimjFs4NKG9oSNQbEiduyJGEZhNXtr/sFptyJUxk3b9jE339qI6BwMPa1FkbZ9Kob3QEvAsFrDbRX1YlUlgoT4L6ZqwK+hYsJWqvGM7sKsJs266+vJReUzqgPeOS67XIGji4QLmZ+HKmcb5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqhfbebs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5740CC4CEDD;
	Mon,  7 Apr 2025 15:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744040163;
	bh=vxoIfOH3hv+8JcQzJTe2JCQ2H+ulfHSIZy2SW/nfLss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hqhfbebs3x7d/GCPZcnQpCNFvIZ976SbyTsrHJ1Y/fneZ6Ex5mUrI2YzWo5ApBnFg
	 hvaIToBRaRC1n0Sa1cxX2tu6tXj9PLKhaoYdAYLSTxmFbTyNTDCA5DfjGOw/uckaxS
	 KkBf9o/Af5iXoNGTT4yOlYpvtnX/M5ON8RDEKI5MzAcmWdkNRcMakKFjpNbJgZ0rXh
	 FnMLV0DdAQfSPLvGF65KBxWj8PkXK5IyrG/X/484QsEpcfpM9TahsgXAhAz8vP+VP3
	 HF22onlmXjZQouFmEW1f9BNwgbDHvhliKJgC16bGB3JM+aYwXfCeYLq0HW8NIKdnNk
	 wGNJ2WDKCXTeA==
Date: Mon, 7 Apr 2025 17:35:56 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/3] PCI: endpoint: improve fixed_size bar handling
 when allocating space
Message-ID: <Z_Pw3I2xO7BMSGWW@ryzen>
References: <20250407-pci-ep-size-alignment-v3-0-865878e68cc8@baylibre.com>
 <20250407-pci-ep-size-alignment-v3-2-865878e68cc8@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407-pci-ep-size-alignment-v3-2-865878e68cc8@baylibre.com>

Hello Jerome,

On Mon, Apr 07, 2025 at 04:39:08PM +0200, Jerome Brunet wrote:
> When trying to allocate space for an endpoint function on a BAR with a
> fixed size, the size saved in the 'struct pci_epf_bar' should be the fixed
> size. This is expected by pci_epc_set_bar().
> 
> However, if the fixed_size is smaller that the alignment, the size saved
> in the 'struct pci_epf_bar' matches the alignment and it is a problem for
> pci_epc_set_bar().
> 
> To solve this, continue to allocate space that match the iATU alignment
> requirement but save the size that matches what is present in the BAR.
> 
> Fixes: 2a9a801620ef ("PCI: endpoint: Add support to specify alignment for buffers allocated to BARs")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/pci/endpoint/pci-epf-core.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index b7deb0ee1760b23a24f49abf3baf53ea2f273476..fb902b751e1c965c902c5199d57969ae0a757c2e 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -225,6 +225,7 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
>  	struct device *dev;
>  	struct pci_epf_bar *epf_bar;
>  	struct pci_epc *epc;
> +	size_t size;
>  
>  	if (!addr)
>  		return;
> @@ -237,9 +238,12 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
>  		epf_bar = epf->sec_epc_bar;
>  	}
>  
> +	size = epf_bar[bar].size;
> +	if (epc_features->align)
> +		size = ALIGN(size, epc_features->align);

Personally, I think that you should just save the aligned_size / mem_size /
backing_mem_size as a new struct member, as that avoids the risk that someone
later modifies pci_epf_alloc_space() but forgets to update
pci_epf_free_space() accordingly.

But I will leave the decision to the PCI endpoint maintainers.


Kind regards,
Niklas


> +
>  	dev = epc->dev.parent;
> -	dma_free_coherent(dev, epf_bar[bar].size, addr,
> -			  epf_bar[bar].phys_addr);
> +	dma_free_coherent(dev, size, addr, epf_bar[bar].phys_addr);
>  
>  	epf_bar[bar].phys_addr = 0;
>  	epf_bar[bar].addr = NULL;
> @@ -266,7 +270,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>  			  enum pci_epc_interface_type type)
>  {
>  	u64 bar_fixed_size = epc_features->bar[bar].fixed_size;
> -	size_t align = epc_features->align;
> +	size_t aligned_size, align = epc_features->align;
>  	struct pci_epf_bar *epf_bar;
>  	dma_addr_t phys_addr;
>  	struct pci_epc *epc;
> @@ -287,12 +291,17 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>  			return NULL;
>  		}
>  		size = bar_fixed_size;
> +	} else {
> +		/* BAR size must be power of two */
> +		size = roundup_pow_of_two(size);
>  	}
>  
> -	if (align)
> -		size = ALIGN(size, align);
> -	else
> -		size = roundup_pow_of_two(size);
> +	/*
> +	 * Allocate enough memory to accommodate the iATU alignment requirement.
> +	 * In most cases, this will be the same as .size but it might be different
> +	 * if, for example, the fixed size of a BAR is smaller than align
> +	 */
> +	aligned_size = align ? ALIGN(size, align) : size;
>  
>  	if (type == PRIMARY_INTERFACE) {
>  		epc = epf->epc;
> @@ -303,7 +312,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>  	}
>  
>  	dev = epc->dev.parent;
> -	space = dma_alloc_coherent(dev, size, &phys_addr, GFP_KERNEL);
> +	space = dma_alloc_coherent(dev, aligned_size, &phys_addr, GFP_KERNEL);
>  	if (!space) {
>  		dev_err(dev, "failed to allocate mem space\n");
>  		return NULL;
> 
> -- 
> 2.47.2
> 

