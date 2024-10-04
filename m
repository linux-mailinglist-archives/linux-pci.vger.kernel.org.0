Return-Path: <linux-pci+bounces-13814-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56984990252
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 13:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D25501F23C0A
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 11:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B505C155C95;
	Fri,  4 Oct 2024 11:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkLn9LI1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BC3148316
	for <linux-pci@vger.kernel.org>; Fri,  4 Oct 2024 11:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728042364; cv=none; b=UZyvGnz/OILTmYLRG3yXa0SUO8+3jl31OBF4Y9mTJu53n0tYDV6TuycypUID5ntPv32PWJc/1Rs7u8mIngZ7sSP4r/6GlikeZxpo3eN3CYTN9dB8uXsM+TeplomqAnDNnbFk3Rg/GGOsyhs9fXJSSQSH7LmBCsZLWnKo2Ja+k3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728042364; c=relaxed/simple;
	bh=S9hudLpCYZjFUUOdJMkHG5VZVROJfJ7S1WnrS+sqIH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mv2W9XW2AoYBLt1aGpzV5fIGl9P3AREY91s7nQzwan1uHzGd9PAjTa5lcp2PC2yxBANFr26r/LwdnEmSC7rcoJBuSkaoqf7sFtsAR/wWleKE0IpXd6Zg7LPNDbE2afDvQn/acPhGWssvyBJlq1Taj/QFlhtt2UIuhzu0Wyw5K/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkLn9LI1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5158C4CEC6;
	Fri,  4 Oct 2024 11:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728042364;
	bh=S9hudLpCYZjFUUOdJMkHG5VZVROJfJ7S1WnrS+sqIH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kkLn9LI1Qe8gKL0NcKoO8Wgt6FZuZHAB72autowRJV7APuB+/7k+ps+edo/Y/7wLm
	 MVdCr46y5VXITe/bcDIC7fbr98711kQo91iTzGFGcVkJI5BHPm0Opb+rIoBqaqMzKf
	 Qnci+cJLwT7E9Gp2gQjhe9flyDXd0Stb7iuwHNU5l+/hiFp0vr6rfkxs0pFm/uU41Y
	 T70MbtsCRWXDAX32yFd2OBgPPfgkSVPq9rbahwenZFIugadq8mh5ybTo9DosKpUMWj
	 8Ux3kmtaMjX4DCjzXHMu7u7H2EREsKX7hf8QfXMaQAUpyRGCRrsL3g4VI5nOIS+G6M
	 eP9jL4Ru1DqWw==
Date: Fri, 4 Oct 2024 13:45:58 +0200
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
Subject: Re: [PATCH v3 3/7] PCI: endpoint: Introduce pci_epc_map_align()
Message-ID: <Zv_Vdg03tvG84Txq@ryzen.lan>
References: <20241004050742.140664-1-dlemoal@kernel.org>
 <20241004050742.140664-4-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004050742.140664-4-dlemoal@kernel.org>

On Fri, Oct 04, 2024 at 02:07:38PM +0900, Damien Le Moal wrote:
> Some endpoint controllers have requirements on the alignment of the
> controller physical memory address that must be used to map a RC PCI
> address region. For instance, the rockchip endpoint controller uses
> at most the lower 20 bits of a physical memory address region as the
> lower bits of an RC PCI address. For mapping a PCI address region of
> size bytes starting from pci_addr, the exact number of address bits
> used is the number of address bits changing in the address range
> [pci_addr..pci_addr + size - 1].
> 
> For this example, this creates the following constraints:
> 1) The offset into the controller physical memory allocated for a
>    mapping depends on the mapping size *and* the starting PCI address
>    for the mapping.
> 2) A mapping size cannot exceed the controller windows size (1MB) minus
>    the offset needed into the allocated physical memory, which can end
>    up being a smaller size than the desired mapping size.
> 
> Handling these constraints independently of the controller being used
> in an endpoint function driver is not possible with the current EPC
> API as only the ->align field in struct pci_epc_features is provided
> and used for BAR (inbound ATU mappings) mapping. A new API is needed
> for function drivers to discover mapping constraints and handle
> non-static requirements based on the RC PCI address range to access.
> 
> Introduce the function pci_epc_map_align() and the endpoint controller
> operation ->map_align to allow endpoint function drivers to obtain the
> size and the offset into a controller address region that must be
> allocated and mapped to access an RC PCI address region. The size
> of the mapping provided by pci_epc_map_align() can then be used as the
> size argument for the function pci_epc_mem_alloc_addr().
> The offset into the allocated controller memory provided can be used to
> correctly handle data transfers.
> 
> For endpoint controllers that have PCI address alignment constraints,
> pci_epc_map_align() may indicate upon return an effective PCI address
> region mapping size that is smaller (but not 0) than the requested PCI
> address region size. For such case, an endpoint function driver must
> handle data accesses over the desired PCI address range in fragments,
> by repeatedly using pci_epc_map_align() over the PCI address range.
> 
> The controller operation ->map_align is optional: controllers that do
> not have any alignment constraints for mapping a RC PCI address region
> do not need to implement this operation. For such controllers,
> pci_epc_map_align() always returns the mapping size as equal to the
> requested size of the PCI region and an offset equal to 0.
> 
> The new structure struct pci_epc_map is introduced to represent a
> mapping start PCI address, mapping effective size, the size and offset
> into the controller memory needed for mapping the PCI address region as
> well as the physical and virtual CPU addresses of the mapping (phys_base
> and virt_base fields). For convenience, the physical and virtual CPU
> addresses within that mapping to access the target RC PCI address region
> are also provided (phys_addr and virt_addr fields).
> 
> Co-developed-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/pci/endpoint/pci-epc-core.c | 56 +++++++++++++++++++++++++++++
>  include/linux/pci-epc.h             | 37 +++++++++++++++++++
>  2 files changed, 93 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index b854f1bab26f..48dd3c28ac4c 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -435,6 +435,62 @@ void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_unmap_addr);
>  
> +/**
> + * pci_epc_map_align() - Get the offset into and the size of a controller memory
> + *			 address region needed to map a RC PCI address region
> + * @epc: the EPC device on which address is allocated
> + * @func_no: the physical endpoint function number in the EPC device
> + * @vfunc_no: the virtual endpoint function number in the physical function
> + * @pci_addr: The RC PCI address to map
> + * @pci_size: the number of bytes to map starting from @pci_addr
> + * @map: populate here the actual size and offset into the controller memory
> + *       that must be allocated for the mapping
> + *
> + * If defined, invoke the controller map_align operation to obtain the size and
> + * the offset into a controller address region that must be allocated to map
> + * @pci_size bytes of the RC PCI address space starting from @pci_addr.
> + *
> + * On return, @map->pci_size indicates the effective size of the mapping that
> + * can be handled by the controller. This size may be smaller than the requested
> + * @pci_size. In such case, the endpoint function driver must handle the mapping
> + * using several fragments. The offset into the controller memory for the
> + * effective mapping of the RC PCI address range
> + * @pci_addr..@pci_addr+@map->pci_size is indicated by @map->map_ofst.
> + *
> + * If the target controller does not define a map_align operation, it is assumed
> + * that the controller has no PCI address mapping alignment constraint.
> + */
> +int pci_epc_map_align(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +		      u64 pci_addr, size_t pci_size, struct pci_epc_map *map)
> +{
> +	int ret;
> +
> +	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
> +		return -EINVAL;
> +
> +	if (!pci_size || !map)
> +		return -EINVAL;
> +
> +	memset(map, 0, sizeof(*map));
> +	map->pci_addr = pci_addr;

Since the kdoc says that @map->pci_size might be smaller than the requested size,
I assume that you are only temporarily storing pci_size in map here, and that
map_align() might overwrite this value. Perhaps add a comment here that explains
that map_align() might/will overwrite this value.


> +	map->pci_size = pci_size;
> +
> +	if (!epc->ops->map_align) {
> +		/* Assume that the EP controller has no alignment constraint */
> +		map->map_pci_addr = pci_addr;
> +		map->map_size = pci_size;
> +		map->map_ofst = 0;
> +		return 0;
> +	}
> +
> +	mutex_lock(&epc->lock);
> +	ret = epc->ops->map_align(epc, func_no, vfunc_no, map);
> +	mutex_unlock(&epc->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pci_epc_map_align);
> +
>  /**
>   * pci_epc_map_addr() - map CPU address to PCI address
>   * @epc: the EPC device on which address is allocated
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index 42ef06136bd1..9df8a83e8d10 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -32,11 +32,44 @@ pci_epc_interface_string(enum pci_epc_interface_type type)
>  	}
>  }
>  
> +/**
> + * struct pci_epc_map - information about EPC memory for mapping a RC PCI
> + *                      address range
> + * @pci_addr: start address of the RC PCI address range to map
> + * @pci_size: size of the RC PCI address range mapped from @pci_addr
> + * @map_pci_addr: RC PCI address used as the first address mapped (may be lower
> + *                than @pci_addr)
> + * @map_size: size of the controller memory needed for mapping the RC PCI address
> + *            range @pci_addr..@pci_addr+@pci_size
> + * @map_ofst: offset into the mapped controller memory to access @pci_addr
> + * @phys_base: base physical address of the allocated EPC memory for mapping the
> + *             RC PCI address range
> + * @phys_addr: physical address at which @pci_addr is mapped
> + * @virt_base: base virtual address of the allocated EPC memory for mapping the
> + *             RC PCI address range
> + * @virt_addr: virtual address at which @pci_addr is mapped
> + */
> +struct pci_epc_map {
> +	phys_addr_t	pci_addr;
> +	size_t		pci_size;
> +
> +	phys_addr_t	map_pci_addr;
> +	size_t		map_size;
> +	phys_addr_t	map_ofst;
> +
> +	phys_addr_t	phys_base;
> +	phys_addr_t	phys_addr;
> +	void __iomem	*virt_base;
> +	void __iomem	*virt_addr;
> +};
> +
>  /**
>   * struct pci_epc_ops - set of function pointers for performing EPC operations
>   * @write_header: ops to populate configuration space header
>   * @set_bar: ops to configure the BAR
>   * @clear_bar: ops to reset the BAR
> + * @map_align: operation to get the size and offset into a controller memory
> + *             window needed to map an RC PCI address region
>   * @map_addr: ops to map CPU address to PCI address
>   * @unmap_addr: ops to unmap CPU address and PCI address
>   * @set_msi: ops to set the requested number of MSI interrupts in the MSI
> @@ -61,6 +94,8 @@ struct pci_epc_ops {
>  			   struct pci_epf_bar *epf_bar);
>  	void	(*clear_bar)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  			     struct pci_epf_bar *epf_bar);
> +	int	(*map_align)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +			    struct pci_epc_map *map);
>  	int	(*map_addr)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  			    phys_addr_t addr, u64 pci_addr, size_t size);
>  	void	(*unmap_addr)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> @@ -241,6 +276,8 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  		    struct pci_epf_bar *epf_bar);
>  void pci_epc_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  		       struct pci_epf_bar *epf_bar);
> +int pci_epc_map_align(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +		      u64 pci_addr, size_t size, struct pci_epc_map *map);
>  int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  		     phys_addr_t phys_addr,
>  		     u64 pci_addr, size_t size);
> -- 
> 2.46.2
> 

Reviewed-by: Niklas Cassel <cassel@kernel.org>

