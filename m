Return-Path: <linux-pci+bounces-14533-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E71C99E2A8
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 11:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8422B23DFB
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 09:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBFE1BE854;
	Tue, 15 Oct 2024 09:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxXn0iJA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FD61D014E
	for <linux-pci@vger.kernel.org>; Tue, 15 Oct 2024 09:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728984061; cv=none; b=BehoEj69QFM6KZQY70daLYRNagkdeBC8OU77bEKZ5K0bvrui5uhEx9YkXj4ErPy1+IJPXhtIh3avEpkdQ4/cQ1Kwx3ba8UqCOg/RzwR8jcaLw9KT/WYUHH0rKntRRD7q29psqUeSgPEcG/QwDeHl8IyL5otDvwaH9fso8DpvBBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728984061; c=relaxed/simple;
	bh=YnhwqwGB0TxreHfwjU5Hc7Iv1rs6wpmBFNzPpZ8DerY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OllbPG3/nL5xe5qTcHdpBSta8SKarNY623ipxmpTcKMQyuerhXNA4MCUwOyHYZxOxpOzb844/C515f4LqM4/tMQw0Lb9pxJ2fSuKt+YHn+hC6l9S39hT5EuA6PgHYPGnanONoE5NFZ5SXpACd/YOTM6g0VQLXJNFjtCzdXjmqVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxXn0iJA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893C8C4CEC6;
	Tue, 15 Oct 2024 09:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728984060;
	bh=YnhwqwGB0TxreHfwjU5Hc7Iv1rs6wpmBFNzPpZ8DerY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sxXn0iJAkY6PalI21njgzvZZOSgpmIuLzde1GxopIKYiaqnQVyNsd0hFI2kYM9IdV
	 g9M03xXgzcmFeB3YiPqWyloz+QBr10BzWr+WjOweaUm7aBdGr8ewR8wuIaw0N6Kgiq
	 T0aFqKFbCFBLTqD5y6hqLW0TMciiBsX9Q5k0IvKPZ42kioSPkdtFUaKkaT08KF+SiG
	 3DOXfyhOhjGHy5KQ3fVmtDBpzJw/vfYky7zg33Sa0pU086pcW1hiouGl5GxmF4W6hm
	 QacKZ7vkrsMGwnljdHYczY8dFm5UOAAIEzi+z1KvCc8ZYA7U8oeDuxVCniqQr7s6oT
	 hiC1w0922GByA==
Date: Tue, 15 Oct 2024 11:20:56 +0200
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
Subject: Re: [PATCH v2] PCI: endpoint: Improve pci_epc_ops::align_addr()
 interface
Message-ID: <Zw4z-K8YCGM4aIzD@ryzen.lan>
References: <20241015090712.112674-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015090712.112674-1-dlemoal@kernel.org>

On Tue, Oct 15, 2024 at 06:07:12PM +0900, Damien Le Moal wrote:
> The PCI endpoint controller operation interface for the align_addr()
> operation uses the phys_addr_t type for the PCI address argument and
> return a value using this type. This is not ideal as PCI addresses are
> bus addresses, not regular memory physical addresses. Replace the use of
> phys_addr_t for this operation with the generic u64 type. To be
> consistent with this change the Designware driver implementation of this
> operation (function dw_pcie_ep_align_addr()) as well as the type of PCI
> address fields of struct pci_epc_map are also changed.
> 
> Fixes: e98c99e2ccad ("PCI: endpoint: Introduce pci_epc_mem_map()/unmap()")
> Fixes: cb6b7158fdf5 ("PCI: dwc: endpoint: Implement the pci_epc_ops::align_addr() operation")
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
> Changes from v1:
>  - Also updated the type of the pci_addr and map_pci_addr fields of
>    struct pci_epc_map.
> 
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 6 +++---
>  include/linux/pci-epc.h                         | 8 ++++----
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 0ada60487c25..df1460ed63d9 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -268,12 +268,12 @@ static int dw_pcie_find_index(struct dw_pcie_ep *ep, phys_addr_t addr,
>  	return -EINVAL;
>  }
>  
> -static phys_addr_t dw_pcie_ep_align_addr(struct pci_epc *epc,
> -			phys_addr_t pci_addr, size_t *pci_size, size_t *offset)
> +static u64 dw_pcie_ep_align_addr(struct pci_epc *epc, u64 pci_addr,
> +				 size_t *pci_size, size_t *offset)
>  {
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> -	phys_addr_t mask = pci->region_align - 1;
> +	u64 mask = pci->region_align - 1;
>  	size_t ofst = pci_addr & mask;
>  
>  	*pci_size = ALIGN(ofst + *pci_size, ep->page_size);
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index f4b8dc37e447..de8cc3658220 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -49,10 +49,10 @@ pci_epc_interface_string(enum pci_epc_interface_type type)
>   * @virt_addr: virtual address at which @pci_addr is mapped
>   */
>  struct pci_epc_map {
> -	phys_addr_t	pci_addr;
> +	u64		pci_addr;
>  	size_t		pci_size;
>  
> -	phys_addr_t	map_pci_addr;
> +	u64		map_pci_addr;
>  	size_t		map_size;
>  
>  	phys_addr_t	phys_base;
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

Reviewed-by: Niklas Cassel <cassel@kernel.org>

