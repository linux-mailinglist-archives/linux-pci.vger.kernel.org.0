Return-Path: <linux-pci+bounces-36884-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C13F2B9B6CD
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 20:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2DAD4E7D35
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 18:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DDC2EC095;
	Wed, 24 Sep 2025 18:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jby5UX8s"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CBA22B5A5;
	Wed, 24 Sep 2025 18:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737404; cv=none; b=DSTpvHvwMmZJCK3n1PxfyZGYG4rmY+O5AemXinofek59uKFxABTOxlwl7LlRUsjbb3kaU5RsC+MiHMYlNj2eWtnHwAIOdscnhD3pFw+0Wj+VvTqFo2BoTDmekkdpTxzxo221Wie2JMvq/yayW8r44BvDVUDPf+wJojAlIxV2gcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737404; c=relaxed/simple;
	bh=013OuVuk9BY3uPMbWS193y/MtbSkgfxCeOC89aQxZ+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kvt/v28EghrfDIEkTwbpldLINoiYY57Ru90Bly60fiYUEJCE7vwfs7BpliUmhg2VZCyvCLL8bBwdzZ7YWANVJvN3zb9kB0Fa0qYuz2W7sBx+RYpnNV1PnDTx9S+NnsriT31xTYM85Q8ODmsvWubyNQD1HzwIzYsijEbNGiTyqVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jby5UX8s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50BD6C4CEE7;
	Wed, 24 Sep 2025 18:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758737404;
	bh=013OuVuk9BY3uPMbWS193y/MtbSkgfxCeOC89aQxZ+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jby5UX8shQe9oMIt/3d2ULML/jSFmUQD8fgsG0c78V+t3STKNyBBXKPxLoZHFIjgr
	 IQ8iGg2B+/we99Y6PmylVmrLa2RmF09XPwNUzLVacEbNvCg3JDV/xpqx6hYSzJJdYY
	 DO7g7GsWsIJM5TNHNWjis9QVTK07e5Zgx5KOdjBDvG4Mk53jsqG7f8ka49ALmSu7iU
	 ahzaBWKSaGWGtJzA7g18e+7RaTimZl+F+lScZvYU0TGz2//t0IH7O3X4aHDgu43fBM
	 ZcWuo2jLLoqaMDw4lI5xkGLup1cOGjr11H3IzJKDsAr3uvgZVddwwM13Q7ihXDov7z
	 tlSENZ1SSIqjQ==
Date: Wed, 24 Sep 2025 23:39:56 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ntb@lists.linux.dev, imx@lists.linux.dev
Subject: Re: [PATCH v2 2/3] PCI: endpoint: Add API pci_epf_set_inbound_space()
Message-ID: <bmz36usaey7skutdukgryq22sgvyidfnmtx6z4zrpcvrgpvcdh@4l47wob6grkn>
References: <20250915-vntb_msi_doorbell-v2-0-ca71605e3444@nxp.com>
 <20250915-vntb_msi_doorbell-v2-2-ca71605e3444@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250915-vntb_msi_doorbell-v2-2-ca71605e3444@nxp.com>

On Mon, Sep 15, 2025 at 06:22:45PM -0400, Frank Li wrote:
> Add pci_epf_set_inbound_space() to allow setting any physical address as
> inbound memory space, such as an MSI message base address.
> 
> Since PCI BAR size must be a power of two, the input MMIO range
> [inbound_addr, inbound_addr + size) is mapped by finding n such that
> [base, base + 2^n) covers the range.

> The base address is also required
> to be aligned to 2^n.
>

Where does this alignment restriction gets checked?
 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change in v2
> - add new API pci_epf_set_inbound_space()
> - fix bits 8 * size_of(dma_addr_t);
> ---
>  drivers/pci/endpoint/pci-epf-core.c | 86 +++++++++++++++++++++++++++++++++++++
>  include/linux/pci-epf.h             |  6 +++
>  2 files changed, 92 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index 4281067d4a62da6fbf6c2fb807b0f1b5afd1f45b..cd10e8619d03c7e2ffe48e437b0aecf0e8a499f4 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -344,6 +344,92 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>  }
>  EXPORT_SYMBOL_GPL(pci_epf_alloc_space);
>  
> +/**
> + * pci_epf_set_inbound_space() - set MMIO for the PCI EPF register space

This is just assigning the memory for @bar in epf_bar. So, how about,
pci_epf_assign_bar_space()?

'Assign PCI EPF BAR space'

> + * @epf: the EPF device to whom allocate the memory
> + * @size: the size of the memory that has to be allocated

s/allocated/assigned since this API is not allocating the space.

> + * @bar: the BAR number corresponding to the allocated register space
> + * @epc_features: the features provided by the EPC specific to this EPF
> + * @type: Identifies if the allocation is for primary EPC or secondary EPC
> + * @inbound_addr: Any physical address space such as MSI message address that

s/inbound_addr/bar_addr

"Address to be assigned for the @bar"

> + *		work as inbound address space. from_memory need be false.
> + *
> + * Invoke to allocate memory for the PCI EPF register space.

s/allocate/assign

> + * Flag PCI_BASE_ADDRESS_MEM_TYPE_64 will automatically get set if the BAR
> + * can only be a 64-bit BAR, or if the requested size is larger than 2 GB.
> + */
> +int pci_epf_set_inbound_space(struct pci_epf *epf, size_t size,
> +			      enum pci_barno bar,
> +			      const struct pci_epc_features *epc_features,
> +			      enum pci_epc_interface_type type,
> +			      dma_addr_t inbound_addr)
> +{
> +	size_t aligned_size, align = epc_features->align;
> +	struct pci_epf_bar *epf_bar;
> +	struct pci_epc *epc;
> +	dma_addr_t up;
> +	int pos;
> +
> +	if (!size)
> +		return -EINVAL;
> +
> +	up = inbound_addr + size - 1;

s/up/limit?

> +
> +	/*
> +	 *  Bits:		15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0
> +	 *  Inbound_addr:	U  U  U  U  U  U  0 X X X X X X X X X
> +	 *  Up:			U  U  U  U  U  U  1 X X X X X X X X X
> +	 *
> +	 *  U means address bits have not change in Range [Inbound_Addr, Up]
> +	 *  X means bit 0 or 1.
> +	 *
> +	 *  Inbound_addr^Up  0  0  0  0  0  0  1 X X X X X X X X X
> +	 *  Find first bit 1 pos from MSB, 2 ^ pos windows will cover
> +	 *  [Inbound_Addr, Up] range.
> +	 */
> +	for (pos = 8 * sizeof(dma_addr_t) - 1; pos > 0; pos--)
> +		if ((up ^ inbound_addr) & BIT_ULL(pos))
> +			break;
> +
> +	if (pos == 8 * sizeof(dma_addr_t) - 1)
> +		return -EINVAL;
> +
> +	size = pci_epf_get_bar_required_size(epf, BIT_ULL(pos + 1), bar,
> +					     epc_features, type);
> +
> +	if (size == 0)
> +		return -EINVAL;
> +
> +	/*
> +	 * Allocate enough memory to accommodate the iATU alignment

s/iATU/EPC

> +	 * requirement.  In most cases, this will be the same as .size but
> +	 * it might be different if, for example, the fixed size of a BAR
> +	 * is smaller than align.
> +	 */
> +	aligned_size = align ? ALIGN(size, align) : size;

This should be handled inside the above API.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

