Return-Path: <linux-pci+bounces-2842-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035FB842EB1
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 22:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 359191C21B7A
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 21:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC05678B4C;
	Tue, 30 Jan 2024 21:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3bgtw3f"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B4314F61
	for <linux-pci@vger.kernel.org>; Tue, 30 Jan 2024 21:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706650664; cv=none; b=ol/jC3C1XJA+V0XU17AfciLfrE++uKRZmS5p4RwZ93mCvK38pFifNPp5sQz3RSEQLpq7Xme1wDf8aEz/egF7pE3mB8vaP7k6/Z1YVJY3xHXObThg7Ic0jVAmDJTJiYPjqBusClNqOWibPius9w5SnMZRSpCiSxvBRf3+ajqB7QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706650664; c=relaxed/simple;
	bh=Uax2ZCgxgcsu5NjsDLNXuRL9t/YRrqXst4f1rGME1/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTlCNxY7X9/hVED2Sr8dcVfvWCxq2DGmNqWfVCi1Uj8Q59H0UG0sZ1CRAW+Rigx1v36OzoQ2RAYgK2LQR0kQU6aXR0f3d00UKd20pECWb0hObO46o9ExvxyZrEVCYm4lJ3QSxQm9RFlAqKxkVoxnquNGRttnAL/3PCCj2HTU9e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3bgtw3f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A752C433F1;
	Tue, 30 Jan 2024 21:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706650663;
	bh=Uax2ZCgxgcsu5NjsDLNXuRL9t/YRrqXst4f1rGME1/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g3bgtw3f/jGsv5F74o1tNlTDOFmYVF7mxraq2bHypFhF7BukAZkgwTJmhxPrHUoKR
	 Co/wLim8pJjZWQZSi/nM+IN8/yx8nvXH3ppcB+mxONZ6i5I9hg2y9SB4h+MAWc6z1F
	 jzyNwXBguPqSFN3CL0XlP8ltsCwWNg9iFNobpYsHYRw53LKbz+4Y3UqkSHoTWhjUA5
	 OlE4WpRSgFT6GN9+AIniGfXwAJhqCoaS8jvp+Anibvrr0T8FtK/YcZ0OeFiJ1rbdD6
	 iDCnbY9jB1L2Ec2OSJILSvs7qHVC99cNi+JYzw5/8HjS/oB8US8oyaxaRvaNmUImjv
	 GL0gRGn8aN5VQ==
Date: Tue, 30 Jan 2024 22:37:32 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/3] PCI: endpoint: improve pci_epf_alloc_space()
Message-ID: <ZblsHCzCx7JNBFe9@x1-carbon>
References: <20240130193214.713739-1-cassel@kernel.org>
 <20240130193214.713739-3-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130193214.713739-3-cassel@kernel.org>

On Tue, Jan 30, 2024 at 08:32:10PM +0100, Niklas Cassel wrote:
> pci_epf_alloc_space() already performs checks on the requested BAR size,
> and will allocate and set epf_bar->size to a size higher than the
> requested BAR size if some constraint deems it necessary.
> 
> However, other than pci_epf_alloc_space() performing these roundups,
> there are checks and roundups in two different places in pci-epf-test.c.
> 
> And further checks are proposed to other endpoint function drivers, see:
> https://lore.kernel.org/linux-pci/20240108151015.2030469-1-Frank.Li@nxp.com/
> 
> Having these checks spread out at different places in the EPF driver
> (and potentially in multiple EPF drivers) is not maintainable and makes
> the code hard to follow.
> 
> Since pci_epf_alloc_space() already performs roundups, move the checks and
> roundups performed by pci-epf-test.c to pci_epf_alloc_space().
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c |  8 --------
>  drivers/pci/endpoint/pci-epf-core.c           | 10 +++++++++-
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 15bfa7d83489..981894e40681 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -841,12 +841,6 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
>  	}
>  	test_reg_size = test_reg_bar_size + msix_table_size + pba_size;
>  
> -	if (epc_features->bar_fixed_size[test_reg_bar]) {
> -		if (test_reg_size > bar_size[test_reg_bar])
> -			return -ENOMEM;
> -		test_reg_size = bar_size[test_reg_bar];
> -	}
> -
>  	base = pci_epf_alloc_space(epf, test_reg_size, test_reg_bar,
>  				   epc_features, PRIMARY_INTERFACE);
>  	if (!base) {
> @@ -888,8 +882,6 @@ static void pci_epf_configure_bar(struct pci_epf *epf,
>  		bar_fixed_64bit = !!(epc_features->bar_fixed_64bit & (1 << i));
>  		if (bar_fixed_64bit)
>  			epf_bar->flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
> -		if (epc_features->bar_fixed_size[i])
> -			bar_size[i] = epc_features->bar_fixed_size[i];
>  	}
>  }
>  
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index e44f4078fe8b..37d9651d2026 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -260,6 +260,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>  			  const struct pci_epc_features *epc_features,
>  			  enum pci_epc_interface_type type)
>  {
> +	u64 bar_fixed_size = epc_features->bar_fixed_size[bar];
>  	size_t align = epc_features->align;
>  	struct pci_epf_bar *epf_bar;
>  	dma_addr_t phys_addr;
> @@ -270,7 +271,14 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>  	if (size < 128)
>  		size = 128;
>  
> -	if (align)
> +	if (bar_fixed_size && size > bar_fixed_size) {
> +		dev_err(dev, "requested BAR size is larger than fixed size\n");
> +		return NULL;
> +	}
> +
> +	if (bar_fixed_size)
> +		size = bar_fixed_size;
> +	else if (align)
>  		size = ALIGN(size, align);
>  	else
>  		size = roundup_pow_of_two(size);

We actually need to perform the alignment even for fixed size BARs too,
since some platforms have fixed_size_bars that are smaller than the
iATU MIN REGION.

Will fix in v2.


Kind regards,
Niklas

