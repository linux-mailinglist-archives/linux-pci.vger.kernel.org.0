Return-Path: <linux-pci+bounces-13818-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E279902BE
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 14:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 833B4B20431
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 12:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807D315A84D;
	Fri,  4 Oct 2024 12:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHGgIdaQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CECF15A849
	for <linux-pci@vger.kernel.org>; Fri,  4 Oct 2024 12:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728043927; cv=none; b=uyJI7kEiXfBnEgTa3DosMOdTARuL5Ia6Yr9mVzd/OTej6sO48kFJUhfWByK2h/+8qyBel7/R+u8SDvWwSb+CEVNWk8v1zm3rCiXn6CgWWTlNDjuu87BaTQePkfSVZVvjKPVeKCF3xvKpHUhYPzUsZcEtYdz90ZN3UaF0AFqH8YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728043927; c=relaxed/simple;
	bh=D/kQEOXBV72/ZIRSeXEcF2Uq/w24vsBdd1YMa5noJiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjWVnDXLGGP/ohs7U0xETA9fRqrScdnRqP8gI93JnkI3Kq4mFXANcjGb6mMZ3lZM5oTDr/LfZXEM8jHyv5pooNth8PzgUK807vQRmbUda3p+RoNE0zqeST8/NcshJUWDRaOyrM9Z5tDdQ4p0tSd7to2wEVZnkoZD5ZCAN9/VuMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHGgIdaQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72391C4CEC6;
	Fri,  4 Oct 2024 12:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728043926;
	bh=D/kQEOXBV72/ZIRSeXEcF2Uq/w24vsBdd1YMa5noJiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nHGgIdaQH3N8Nvw0/trU9qkoW1vCheGlXAvQ23/+QDw/ofBbzNX0ZUhgrwytrYAg1
	 ftnQjY/vva/wJDbx4dUXj3hSGamXj4dewWH5pqxAMOUFqrUWzg66SL8IKFQFE8CXx2
	 CZmfiZkW+vDd0VsZvQhe4JMtKujAbGDkl4Fqp+3216Z0lpAkUejfSQ+wjvKcNqzrnu
	 ixnTSuxs8WbjExqo6NZPFMPEFcTHTPfVMjbt8XQhiIV5imIFbCWKbgfpwd8+4dDAYe
	 kr5YmRiL6O6Ee7u7ETE94ahdXxwDQaAKwJxuckKBHSDf4dgVWYqO6jnNbcNG8jKEP4
	 KeT3ZExVoQcdg==
Date: Fri, 4 Oct 2024 14:12:01 +0200
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
Subject: Re: [PATCH v3 7/7] PCI: dwc: endpoint: Define the .map_align()
 controller operation
Message-ID: <Zv_bkb35eNK1Sqcp@ryzen.lan>
References: <20241004050742.140664-1-dlemoal@kernel.org>
 <20241004050742.140664-8-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004050742.140664-8-dlemoal@kernel.org>

On Fri, Oct 04, 2024 at 02:07:42PM +0900, Damien Le Moal wrote:
> The function dw_pcie_prog_outbound_atu() used to program outbound ATU
> entries for mapping RC PCI addresses to local CPU addresses does not
> allow PCI addresses that are not aligned to struct dw_pcie->region_align
> (generally 64K).

I think that you should just remove the "generally 64K". This is totally
dependent on the hardware configuration set when synthesizing the DWC PCIe
controller.

See e.g. drivers/misc/pci_endpoint_test.c:
.alignment = SZ_4K,
.alignment = SZ_64K,
.alignment = 256,

In fact, the most common one, from looking at what the different PCI device
and vendor IDs, seems to be 4k.

Perhaps simply mention that the pci->region_align contains the value that was
read/determined from iATU hardware registers during detection time of the iATU
(done by dw_pcie_iatu_detect()), so this code is actually generic for all DWC
PCIe controllers, and should thus work regardless of the hardware configuration
used when synthesizing the DWC PCIe controller.


> 
> Handle this constraint by defining the endpoint controller .map_align()
> operation to calculate a mapping size and the offset into the mapping
> based on the requested RC PCI address and size to map.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 43ba5c6738df..501e527c188e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -268,6 +268,20 @@ static int dw_pcie_find_index(struct dw_pcie_ep *ep, phys_addr_t addr,
>  	return -EINVAL;
>  }
>  
> +static int dw_pcie_ep_map_align(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +				struct pci_epc_map *map)
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
> +	.map_align		= dw_pcie_ep_map_align,
>  	.map_addr		= dw_pcie_ep_map_addr,
>  	.unmap_addr		= dw_pcie_ep_unmap_addr,
>  	.set_msi		= dw_pcie_ep_set_msi,
> -- 
> 2.46.2
> 

Reviewed-by: Niklas Cassel <cassel@kernel.org>

