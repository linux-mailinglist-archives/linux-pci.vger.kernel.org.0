Return-Path: <linux-pci+bounces-35186-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C37B3B3CB80
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 16:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4909B7B9CA6
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 14:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A7922A817;
	Sat, 30 Aug 2025 14:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTeigE4g"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6BF19D07A;
	Sat, 30 Aug 2025 14:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756565200; cv=none; b=OEn2AqXrCtxxPtRAB776UkDoIU4ju29wZc3WVoqcMI/xNUwaaHUD9RqGv+HvPWJp5NCTNKsv7OVfM4bWEk7R70xeEMyzpm+GJRtVbkQz3EOshq9Dy7eqlCb1XudU+QwNGSQHuEgmsRJpnA3HQy3sSdQ+Qc3bO06zMWQ6G/ydWKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756565200; c=relaxed/simple;
	bh=2WcIhwSMie7S1HSZ7ETv9VnQ4DQgCWjEy2j48E0PTzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5X3RsQTBHeDR46D+9be/LarHKxGZzwEuadWX0Kjg+XXysgyNSEOuLbCXX7ECC374bYZpUUbyYscOJtMuxHeoPxzVbC2cg71EpNPl3NUjbwIKf2bD7UyG2xPDsIUsiP3cwtqnXEHRMuLakb1z1LNTDMfietk/fg7wgTzk6u7zgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTeigE4g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1806DC4CEEB;
	Sat, 30 Aug 2025 14:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756565200;
	bh=2WcIhwSMie7S1HSZ7ETv9VnQ4DQgCWjEy2j48E0PTzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aTeigE4g/aCNOBjWj8Mod1jHAsP64MW5b9jcA1DdW/Ca/TiM3VjUC+SXvOdvLjP2y
	 hv0zijmIP2RxHDlexEKILNyY9OL/YsHQ5rjcmWLKnRrnxgtb1ZFBtaoP/aZxcFil41
	 Oxq/wW7ppP6oPDpaRFRMpCadEOLKTtlh/OwQwUc9Xfu9p4dUqdv/4bK1X6V0QCls7V
	 d8Wv9OjCTW6bQ7xLZl1kV8onE/i6dNSUHxxtO3XZYSd6wWXdmnV5zbjoPd6M/IPD6q
	 bq7LcndFF6oeqenM12WBSaTZ5bHXN3Ok+mcxNKg0QMR39IAZLGKi+lGLAcVArMnKJ7
	 PPUbVcKelMKYw==
Date: Sat, 30 Aug 2025 20:16:33 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ntb@lists.linux.dev
Subject: Re: [PATCH 1/2] PCI: endpoint: Enhance pci_epf_alloc_space() and
 rename to pci_epf_set_inbound_space()
Message-ID: <udt2t2c43nw5de5q5vu2etknbnhrr3m5mqjk72nuyiurk46kbp@e47e5kvk2m22>
References: <20250815-vntb_msi_doorbell-v1-0-32df6c4bf96c@nxp.com>
 <20250815-vntb_msi_doorbell-v1-1-32df6c4bf96c@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250815-vntb_msi_doorbell-v1-1-32df6c4bf96c@nxp.com>

On Fri, Aug 15, 2025 at 06:20:53PM GMT, Frank Li wrote:
> Enhance pci_epf_alloc_space() to handle setting any physical address as
> inbound memory space, such as an MSI message base address. The function
> already accounts for different alignment requirements for different BARs,
> so reuse this logic and rename the function to pci_epf_set_inbound_space().
> 

I don't think combining both APIs is a good idea. One allocates space for
inbound memory/populates epf_bar and another reuses existing memory/populates
epf_bar. Combining both, logically makes little sense and another makes the code
messy.

If you want to reuse the alignment checks and epf_bar setting from
pci_epf_alloc_space(), then create a separate helper(s) out of it and call from
both APIs.

> Make pci_epf_alloc_space() inline and call pci_epf_set_inbound_space() with
> from_space set to true to maintain compatibility.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> ---
>  drivers/pci/endpoint/pci-epf-core.c | 69 ++++++++++++++++++++++++++++++-------
>  include/linux/pci-epc.h             |  5 ---
>  include/linux/pci-epf.h             | 35 ++++++++++++++++---
>  3 files changed, 87 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index d54e18872aefc07c655c94c104a347328ff7a432..5b802b1ea3e28a32e38f4ab6a649cb97a2f29b95 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -249,20 +249,26 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
>  EXPORT_SYMBOL_GPL(pci_epf_free_space);
>  
>  /**
> - * pci_epf_alloc_space() - allocate memory for the PCI EPF register space
> + * pci_epf_set_inbound_space() - set memory for the PCI EPF inbound address space
>   * @epf: the EPF device to whom allocate the memory
>   * @size: the size of the memory that has to be allocated
>   * @bar: the BAR number corresponding to the allocated register space
>   * @epc_features: the features provided by the EPC specific to this EPF
>   * @type: Identifies if the allocation is for primary EPC or secondary EPC
> + * @from_memory: allocate from system memory
> + * @inbound_addr: Any physical address space such as MSI message address that
> + *                work as inbound address space. from_memory need be false.
>   *
>   * Invoke to allocate memory for the PCI EPF register space.
>   * Flag PCI_BASE_ADDRESS_MEM_TYPE_64 will automatically get set if the BAR
>   * can only be a 64-bit BAR, or if the requested size is larger than 2 GB.
>   */
> -void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
> -			  const struct pci_epc_features *epc_features,
> -			  enum pci_epc_interface_type type)
> +int pci_epf_set_inbound_space(struct pci_epf *epf, size_t size,
> +			      enum pci_barno bar,
> +			      const struct pci_epc_features *epc_features,
> +			      enum pci_epc_interface_type type,
> +			      bool from_memory,
> +			      dma_addr_t inbound_addr)
>  {
>  	u64 bar_fixed_size = epc_features->bar[bar].fixed_size;
>  	size_t aligned_size, align = epc_features->align;
> @@ -270,7 +276,32 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>  	dma_addr_t phys_addr;
>  	struct pci_epc *epc;
>  	struct device *dev;
> -	void *space;
> +	void *space = NULL;
> +	dma_addr_t up;
> +
> +	up = inbound_addr + size - 1;
> +
> +	/*
> +	 *  Bits:            15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0
> +	 *  Inbound_addr:    U  U  U  U  U  U  0 X X X X X X X X X
> +	 *  Up:              U  U  U  U  U  U  1 X X X X X X X X X
> +	 *
> +	 *  U means address bits have not change in Range [Inbound_Addr, Up]
> +	 *  X means bit 0 or 1.
> +	 *
> +	 *  Inbound_addr^Up  0  0  0  0  0  0  1 X X X X X X X X X
> +	 *  Find first bit 1 pos from MSB, 2 ^ pos windows will cover
> +	 *  [Inbound_Addr, Up] range.

On what basis this size calculation is used?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

