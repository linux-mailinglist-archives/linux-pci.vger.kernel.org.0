Return-Path: <linux-pci+bounces-14309-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE00F99A3BC
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 14:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56BBC1F262BB
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 12:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B8A216A1F;
	Fri, 11 Oct 2024 12:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AU6rg5/z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736E8215026
	for <linux-pci@vger.kernel.org>; Fri, 11 Oct 2024 12:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728649197; cv=none; b=QNCe+7vVduSq2kGFH7/oqf/nPVXjFhrTk6pXrVsgovBs6O8uPxnVMY/fQEhAgi/vTpNloh3yaVzbnwLxDG1L80h6ci29vbOHmJSP1zyvQwcqpMtxjy/zgkRl7G27YJJKjI6kHc1QDnGAvKUb0rqYj5AQ1CpEtuwwUhjaWB4pjnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728649197; c=relaxed/simple;
	bh=8frkqHspwtYgdjGC4V5jgJNxl+2wXirskl3xM5xICLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HuYVY98KYT5OmYGP1Fa6lq6KDdSIwsc06WioD4/tIFukvrDUN+LfOsJtRPko5FrBGN6MieRQyxjcyTysbDVteiPgS8zfNS34D7P7viEipjZNLCiDOXCrv23FXLtJ4BJcsipmx9incNpTmuW8DRfgIYqZDQopZrYwIE24KK4F1To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AU6rg5/z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989FBC4CECC;
	Fri, 11 Oct 2024 12:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728649197;
	bh=8frkqHspwtYgdjGC4V5jgJNxl+2wXirskl3xM5xICLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AU6rg5/zhekzGfTpYAScGUh6pnBp1AVXuR4LqlTbFQHKnAseQ0RwXw6pPKSFfq+gc
	 COaFjqEuYgtvtFsaBJJ0/+AJk8FielVx751jupzLtm4zSL76GFT1OCRAtHi1kFKl5D
	 pDHVIykkwe4lv6wSA6u/gGK5s2juk+YfpOfpWtyHssw5wlx7jErNmbZmK/bth6f7S6
	 jV3n5Nmh5rHIqIgkztOnOs7Idm6PEkmxDtyOzx4Zz4W877QFe1Ubz6b0OJMDUYrrlr
	 0OIVPACbGoGs2EOQpggNzBPaVTsCrLNDQIhfR1N6nnIitUqiwo8qjn6Ywcq9LLp4d1
	 T+CUQBeImeIAg==
Date: Fri, 11 Oct 2024 14:19:51 +0200
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
Subject: Re: [PATCH v5 6/6] PCI: dwc: endpoint: Implement the
 pci_epc_ops::get_mem_map() operation
Message-ID: <ZwkX5-5YZSE41ByM@ryzen.lan>
References: <20241011120115.89756-1-dlemoal@kernel.org>
 <20241011120115.89756-7-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011120115.89756-7-dlemoal@kernel.org>

On Fri, Oct 11, 2024 at 09:01:15PM +0900, Damien Le Moal wrote:
> The function dw_pcie_prog_outbound_atu() used to program outbound ATU
> entries for mapping RC PCI addresses to local CPU addresses does not
> allow PCI addresses that are not aligned to the value of region_align
> of struct dw_pcie. This value is determined from the iATU hardware
> registers during probing of the iATU (done by dw_pcie_iatu_detect()).
> This value is thus valid for all DWC PCIe controllers, and valid
> regardless of the hardware configuration used when synthesizing the
> DWC PCIe controller.
> 
> Implement the ->get_mem_map() endpoint controller operation to allow
> this mapping alignment to be transparently handled by endpoint function
> drivers through the function pci_epc_mem_map().
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 43ba5c6738df..b65f4f0f5856 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -268,6 +268,20 @@ static int dw_pcie_find_index(struct dw_pcie_ep *ep, phys_addr_t addr,
>  	return -EINVAL;
>  }
>  
> +static int dw_pcie_ep_get_mem_map(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +				  struct pci_epc_map *map)
> +{
> +	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	size_t mask = pci->region_align - 1;
> +
> +	map->map_pci_addr = map->pci_addr & ~mask;
> +	map->map_ofst = map->pci_addr & mask;
> +	map->map_size = ALIGN(map->map_ofst + map->pci_size, ep->page_size);
> +
> +	return 0;
> +}
> +
>  static void dw_pcie_ep_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  				  phys_addr_t addr)
>  {
> @@ -444,6 +458,7 @@ static const struct pci_epc_ops epc_ops = {
>  	.write_header		= dw_pcie_ep_write_header,
>  	.set_bar		= dw_pcie_ep_set_bar,
>  	.clear_bar		= dw_pcie_ep_clear_bar,
> +	.get_mem_map		= dw_pcie_ep_get_mem_map,
>  	.map_addr		= dw_pcie_ep_map_addr,
>  	.unmap_addr		= dw_pcie_ep_unmap_addr,
>  	.set_msi		= dw_pcie_ep_set_msi,
> -- 
> 2.47.0
> 

Reviewed-by: Niklas Cassel <cassel@kernel.org>

