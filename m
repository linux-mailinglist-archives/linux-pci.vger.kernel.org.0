Return-Path: <linux-pci+bounces-36880-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 91355B9B083
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 19:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 47D744E2D83
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 17:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89552D9EDC;
	Wed, 24 Sep 2025 17:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFCaOhKC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770C7280339;
	Wed, 24 Sep 2025 17:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758734256; cv=none; b=oJlI99Epalo+Pi9nqfdClZx7vU0NnWIONtFnrpMqTCf7A5KNPPK3kT2EvCtB+QF84eb5gNcizYbLZbxcWrx5qvMw3vfUnEOFrZvRohfMN3G55yRc3NFA+E4seDK9Hn3egLV7K0MGO5jzryNIDoJVtJzPiOaEyKxDsK+vqM5uDOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758734256; c=relaxed/simple;
	bh=6EfsuJ86xU5VrZhl+eMWcxcX40tYXGwCniEzDpwjBmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3iJZgqVQbOxbcIRJ6EqyBKlBq11QdufCn6w3y80nKlCzVl0BDxN3O84aVmHP0fdOdbqKx9oa7tEzx+VXVuZFzfYNWsKRvLSIDfkzW41w+BT9CVadd+6ELjoCNJeYZWCbeLLzr6SsgfZ735IFHNuYLIji6j5p3m+pu1dBzfcy8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFCaOhKC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A999C4CEE7;
	Wed, 24 Sep 2025 17:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758734256;
	bh=6EfsuJ86xU5VrZhl+eMWcxcX40tYXGwCniEzDpwjBmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tFCaOhKC6NEWo+n3BLcIHA4hvU8UGHeY3JO9NPANw4S7MKbGl2PPL7MiBtbgRm1+6
	 +arDtzfvbbP7KOnNJPtDnvJFHXnTUDE7fkoZzMNCzZWmnhvOb7Vx6Hd0oaWZBYFHZX
	 lQvEzyaRscXDoqbYK5XLxrgPlGducUyo2hB8Y8EFxcV4d4igSqzbs2TG7Vwyaol2MY
	 x6eNc5A7aUCPPEaaELWmi4y+Njtg3pHJuTYVq/1429jE496+kv3Za7OedZOtt3f0XS
	 am+cOcNhVqXSvu+46+NY8oHoNKauJqeSnFWmjGhIwGNViuk3RX2OnWmq9m+QX6hLTA
	 1sXZDfi5++BMw==
Date: Wed, 24 Sep 2025 22:47:27 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ntb@lists.linux.dev, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/3] PCI: endpoint: Add helper function
 pci_epf_get_bar_required_size()
Message-ID: <qg75qzd34b3bxmqn46g4iefd5x2icdmentg34bep2b55jniq7r@ofwzmgy2l7hj>
References: <20250915-vntb_msi_doorbell-v2-0-ca71605e3444@nxp.com>
 <20250915-vntb_msi_doorbell-v2-1-ca71605e3444@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250915-vntb_msi_doorbell-v2-1-ca71605e3444@nxp.com>

On Mon, Sep 15, 2025 at 06:22:44PM -0400, Frank Li wrote:
> Introduce pci_epf_get_bar_required_size() to retrieve the required BAR
> size. Prepare for adding support to set an MMIO address to a specific BAR.
> 
> No functional changes.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change in v2
> - new patch
> ---
>  drivers/pci/endpoint/pci-epf-core.c | 52 ++++++++++++++++++++++++-------------
>  1 file changed, 34 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index d54e18872aefc07c655c94c104a347328ff7a432..4281067d4a62da6fbf6c2fb807b0f1b5afd1f45b 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -248,6 +248,36 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
>  }
>  EXPORT_SYMBOL_GPL(pci_epf_free_space);
>  
> +static size_t

s/size_t/int to return errno.

> +pci_epf_get_bar_required_size(struct pci_epf *epf, size_t size,

Rename this helper to pci_epf_align_bar_size() and pass 'size' pointer.

> +			      enum pci_barno bar,
> +			      const struct pci_epc_features *epc_features,
> +			      enum pci_epc_interface_type type)
> +{
> +	u64 bar_fixed_size = epc_features->bar[bar].fixed_size;
> +
> +	if (size < 128)
> +		size = 128;
> +
> +	/* According to PCIe base spec, min size for a resizable BAR is 1 MB. */
> +	if (epc_features->bar[bar].type == BAR_RESIZABLE && size < SZ_1M)
> +		size = SZ_1M;
> +
> +	if (epc_features->bar[bar].type == BAR_FIXED && bar_fixed_size) {
> +		if (size > bar_fixed_size) {
> +			dev_err(&epf->dev,
> +				"requested BAR size is larger than fixed size\n");
> +			return 0;

Return value of 0 should not be considered as an error. Return the errno here,
which is -ENOMEM.

> +		}
> +		size = bar_fixed_size;
> +	} else {
> +		/* BAR size must be power of two */
> +		size = roundup_pow_of_two(size);
> +	}
> +
> +	return size;

return 0;

> +}
> +
>  /**
>   * pci_epf_alloc_space() - allocate memory for the PCI EPF register space
>   * @epf: the EPF device to whom allocate the memory
> @@ -264,7 +294,6 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>  			  const struct pci_epc_features *epc_features,
>  			  enum pci_epc_interface_type type)
>  {
> -	u64 bar_fixed_size = epc_features->bar[bar].fixed_size;
>  	size_t aligned_size, align = epc_features->align;
>  	struct pci_epf_bar *epf_bar;
>  	dma_addr_t phys_addr;
> @@ -272,24 +301,11 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>  	struct device *dev;
>  	void *space;
>  
> -	if (size < 128)
> -		size = 128;
> -
> -	/* According to PCIe base spec, min size for a resizable BAR is 1 MB. */
> -	if (epc_features->bar[bar].type == BAR_RESIZABLE && size < SZ_1M)
> -		size = SZ_1M;
> +	size = pci_epf_get_bar_required_size(epf, size, bar,
> +					     epc_features, type);
>  
> -	if (epc_features->bar[bar].type == BAR_FIXED && bar_fixed_size) {
> -		if (size > bar_fixed_size) {
> -			dev_err(&epf->dev,
> -				"requested BAR size is larger than fixed size\n");
> -			return NULL;
> -		}
> -		size = bar_fixed_size;
> -	} else {
> -		/* BAR size must be power of two */
> -		size = roundup_pow_of_two(size);
> -	}
> +	if (size == 0)
> +		return NULL;

	int ret;

	ret = pci_epf_align_bar_size(..., &size, ...);
	if (ret < 0)
		return NULL;

- Mani

-- 
மணிவண்ணன் சதாசிவம்

