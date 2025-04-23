Return-Path: <linux-pci+bounces-26536-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F4DA98B3C
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 15:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6011016B5B4
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 13:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7285F17B506;
	Wed, 23 Apr 2025 13:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBTK9IV7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FDA18859B;
	Wed, 23 Apr 2025 13:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745415260; cv=none; b=JNWwZJ09OJdGxp5bVx8MQRdV1CDWxp/QTBrvACsXdCeJSB80q0JL0v9dTZa6SkDtsVmfQAoy08CbXumTns6xFjspsCMElWZ9ynlBG8GzawvI0QVF/yv5LE0WZyaAoJemOeMpFqPF0kNka60hhoOwsO5a47KQUNMP9l4B2k3DlSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745415260; c=relaxed/simple;
	bh=ueUfGPiRe8CWFt/O1EQf5z5vxeIPa9k232U3/o+JgxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WkqT5H0rWKXLwb2UbDuZKkUv5pURBQupSXFKWzadlCvyT4CzCy7PaasKyYhRw67rh3PLvyDLG+9nNPyG9NlYgx8m06BvkHxEJSp7+/v44qL7eCrm9WV22SGhjJq0QqeGRcA7WQ3xeAL9jMhV+eJrFx/AMY9R/ah3c+mswGFI1Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBTK9IV7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C41EC4CEE2;
	Wed, 23 Apr 2025 13:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745415256;
	bh=ueUfGPiRe8CWFt/O1EQf5z5vxeIPa9k232U3/o+JgxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kBTK9IV7mbg1F9P+I6yRAqsmiDAfQ8VwP0UPACt3x4Q58QN21dpx8SfxQMOhJ/Oae
	 u3bpfrgDsBMFmm//YSdnlxsTtAYc3YMXpsP1CbRTU468E0IVifsKRyhlql+rxVydF2
	 BAtOe4q+finogOh41KWxU3JrHBvKtzKrgny2a71XD0g+yXLSLoY7TKp4VxM4+ucMgg
	 7BDeSUIRQWhSsq//ZxZ8mDR199dZVnGpBfgXV+39fMFzf2gMHvWUf2T7TRcU4VvmoC
	 AuBFNONti3ADtZPvbU/gE7qsBUBP4rnH/pqvXaytDr6ai16jJn74lR9d6+FHfpU/j8
	 bG0i9iXLi3Fiw==
Date: Wed, 23 Apr 2025 15:34:09 +0200
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
Subject: Re: [PATCH v4 1/2] PCI: endpoint: improve fixed_size bar handling
 when allocating space
Message-ID: <aAjsUXiK5PK7S6Jd@ryzen>
References: <20250422-pci-ep-size-alignment-v4-0-6bd58443fee9@baylibre.com>
 <20250422-pci-ep-size-alignment-v4-1-6bd58443fee9@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422-pci-ep-size-alignment-v4-1-6bd58443fee9@baylibre.com>

On Tue, Apr 22, 2025 at 04:54:19PM +0200, Jerome Brunet wrote:
> When trying to allocate space for an endpoint function on a BAR with a
> fixed size, the size saved in the 'struct pci_epf_bar' should be the fixed
> size. This is expected by pci_epc_set_bar().
> 
> However, if the fixed_size is smaller that the alignment, the size saved
> in the 'struct pci_epf_bar' matches the alignment and it is a problem for
> pci_epc_set_bar().
> 
> To solve this, continue to allocate space that match the iATU alignment
> requirement, saving it as .aligned_size, then save the size that matches
> what is present in the BAR.
> 
> Fixes: 2a9a801620ef ("PCI: endpoint: Add support to specify alignment for buffers allocated to BARs")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/pci/endpoint/pci-epf-core.c | 21 ++++++++++++++-------
>  include/linux/pci-epf.h             |  3 +++
>  2 files changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index 394395c7f8decfa2010469655a4bd58a002993fd..982db6c1fbe77653f6a74a31df5c4e997507d2d8 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -236,12 +236,13 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
>  	}
>  
>  	dev = epc->dev.parent;
> -	dma_free_coherent(dev, epf_bar[bar].size, addr,
> +	dma_free_coherent(dev, epf_bar[bar].aligned_size, addr,
>  			  epf_bar[bar].phys_addr);
>  
>  	epf_bar[bar].phys_addr = 0;
>  	epf_bar[bar].addr = NULL;
>  	epf_bar[bar].size = 0;
> +	epf_bar[bar].aligned_size = 0;
>  	epf_bar[bar].barno = 0;
>  	epf_bar[bar].flags = 0;
>  }
> @@ -264,7 +265,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>  			  enum pci_epc_interface_type type)
>  {
>  	u64 bar_fixed_size = epc_features->bar[bar].fixed_size;
> -	size_t align = epc_features->align;
> +	size_t aligned_size, align = epc_features->align;
>  	struct pci_epf_bar *epf_bar;
>  	dma_addr_t phys_addr;
>  	struct pci_epc *epc;
> @@ -285,12 +286,17 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
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
> +	 * if, for example, the fixed size of a BAR is smaller than align.
> +	 */
> +	aligned_size = align ? ALIGN(size, align) : size;
>  
>  	if (type == PRIMARY_INTERFACE) {
>  		epc = epf->epc;
> @@ -301,7 +307,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>  	}
>  
>  	dev = epc->dev.parent;
> -	space = dma_alloc_coherent(dev, size, &phys_addr, GFP_KERNEL);
> +	space = dma_alloc_coherent(dev, aligned_size, &phys_addr, GFP_KERNEL);
>  	if (!space) {
>  		dev_err(dev, "failed to allocate mem space\n");
>  		return NULL;
> @@ -310,6 +316,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>  	epf_bar[bar].phys_addr = phys_addr;
>  	epf_bar[bar].addr = space;
>  	epf_bar[bar].size = size;
> +	epf_bar[bar].aligned_size = aligned_size;
>  	epf_bar[bar].barno = bar;
>  	if (upper_32_bits(size) || epc_features->bar[bar].only_64bit)
>  		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index 879d19cebd4fc6d8df9d724e3a52fa7fbd61e535..23b0878c2665db1c21e6e83543c33149ab1e0009 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -114,6 +114,8 @@ struct pci_epf_driver {
>   * @phys_addr: physical address that should be mapped to the BAR
>   * @addr: virtual address corresponding to the @phys_addr
>   * @size: the size of the address space present in BAR
> + * @aligned_size: the size actually allocated to accommodate the iATU alignment
> + *                requirement.

Nit: Since none of the other lines end with a full stop.
Perhaps add one for all lines, or continue not having it for all lines.

Regardless:
Reviewed-by: Niklas Cassel <cassel@kernel.org>

