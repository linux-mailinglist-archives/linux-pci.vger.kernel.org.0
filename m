Return-Path: <linux-pci+bounces-14517-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF9799DF3B
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 09:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 984FFB211E6
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 07:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0486158A1F;
	Tue, 15 Oct 2024 07:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZq7O5J+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC959474
	for <linux-pci@vger.kernel.org>; Tue, 15 Oct 2024 07:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728977047; cv=none; b=E13WFy/wqmfby0WVjecamE1H+fbS4DHxIG0bZRlHMyFMHKLMPDHRcU8TXXXoewhxoOgVF6dOl9/9kz+SH1HlEIoHdUb7G6s79z5l72lagt2eyf1msMwmGgk8ePgERlkzeFF49OdWbBFlgh7FBjZPsSAKzD1V6h4YMDwdlCZ7E6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728977047; c=relaxed/simple;
	bh=Aqs9GrLTQ7nCcLc337tYvBUgMHQu+bNkJyiIvMNNmd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QeEz7oIYloGDXM55XP6iARJwk/BkYqZhTJ53zUmC2DKrgA0/P1Wt8v/eRJQG+qL2xvNjfyLZ2JBIOAsF/zxJlV4oRKmwAjFt/G1gtyhDokWpCrjh40wfPDym4dqgJ2kDhhFsVV7VtDxKu8VCkXpa06vBR9gNx59D73kHu2T6tYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZq7O5J+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4F9C4CECE;
	Tue, 15 Oct 2024 07:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728977047;
	bh=Aqs9GrLTQ7nCcLc337tYvBUgMHQu+bNkJyiIvMNNmd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZZq7O5J+TaRFoWidzJTTZqBm5wxIn0NP1zK1jrzRzwphAq1zzZ7MJacWtltreK1Da
	 A6/qrfSG5+0VSGjg4pRkexoncjoEIoT68EC2t8WfYzGBYHoJsU/depd3BjVLne2Uui
	 Oe2HOughWYX1UKbQLTdBBL+n5+fMvDafpEEp5TWR4M/SjuhMF5kAm3ZQo00ppBMi4M
	 i1gW1Qt/8qke0Ct0H6NteJ/UdO7sCF6jUCc0UyNrcRaLDxj034R4rQNQ1oSvVG+Gpw
	 ne9fsJ5pmPi4QvzUSBok7oAuIA3Arr+8YcA7Us40mxCfovkWdTpeaEnH59TNSnKKUt
	 u7jf/VGtK/umA==
Date: Tue, 15 Oct 2024 09:24:01 +0200
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
Subject: Re: [PATCH] PCI: endpoint: Improve pci_epc_ops::align_addr()
 interface
Message-ID: <Zw4YkSVpbRVA5KEr@ryzen.lan>
References: <20241015064718.111952-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015064718.111952-1-dlemoal@kernel.org>

Hello Damien,

On Tue, Oct 15, 2024 at 03:47:18PM +0900, Damien Le Moal wrote:
> The PCI endpoint controller operation interface for the align_addr()
> operation uses the phys_addr_t type for the PCI address argument and
> return a value using this type. This is not ideal as PCI addresses are
> bus addresses, not memory physical addresses. Replace the use of
> phys_addr_t for this operation with the generic u64 type. To be
> consistent with this change the Designware driver implementation of this
> operation (function dw_pcie_ep_align_addr()) is also changed.
> 
> Fixes: e98c99e2ccad ("PCI: endpoint: Introduce pci_epc_mem_map()/unmap()")
> Fixes: cb6b7158fdf5 ("PCI: dwc: endpoint: Implement the pci_epc_ops::align_addr() operation")
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 6 +++---
>  include/linux/pci-epc.h                         | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 

(snip)

> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index f4b8dc37e447..ff208fd4526b 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -93,8 +93,8 @@ struct pci_epc_ops {
>  			   struct pci_epf_bar *epf_bar);
>  	void	(*clear_bar)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  			     struct pci_epf_bar *epf_bar);
> -	phys_addr_t (*align_addr)(struct pci_epc *epc, phys_addr_t pci_addr,
> -				  size_t *size, size_t *offset);
> +	u64	(*align_addr)(struct pci_epc *epc, u64 pci_addr, size_t *size,
> +			      size_t *offset);
>  	int	(*map_addr)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  			    phys_addr_t addr, u64 pci_addr, size_t size);
>  	void	(*unmap_addr)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> -- 
> 2.47.0
> 

1) You seem to have missed to update:
"phys_addr_t pci_addr" and "phys_addr_t map_pci_addr"
in struct pci_epc_map (in include/linux/pci-epc.h).


2) You seem to have missed my comment on v6:
> + * @align_addr: operation to get the mapping address, mapping size and offset
> + *		into a controller memory window needed to map an RC PCI address
> + *		region

I think this text should be more clear that it is about the PCI address.
Perhaps something like:
Operation to get the PCI address to map and the size of the mapping,
in order to satisfy address translation requirements of the controller.


3) The problem with using u64 is that it will be 64-bit even on 32-bit
systems.

Looking at:
https://github.com/torvalds/linux/blob/master/Documentation/core-api/dma-api-howto.rst#cpu-and-dma-addresses
and
https://github.com/torvalds/linux/blob/master/include/linux/pci.h#L820-L824

makes me think that dma_addr_t is a better choice than u64 in this case.

pci_bus_addr_t is probably an even better choice, but it doesn't seem
to be used outside drivers/pci/ core code, and it is simply defined to
have the same size as dma_addr_t (CONFIG_ARCH_DMA_ADDR_T_64BIT) anyway.


Kind regards,
Niklas

