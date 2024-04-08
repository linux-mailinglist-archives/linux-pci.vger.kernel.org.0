Return-Path: <linux-pci+bounces-5879-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E86B89BCED
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 12:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 077EA285DA2
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 10:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318FA52F8E;
	Mon,  8 Apr 2024 10:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAPrg+vz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37C552F82;
	Mon,  8 Apr 2024 10:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712571807; cv=none; b=PldBBv1OywN+lAzWXUjzeeTwdtNJGE3m3uM/CcPY9gGXtYcCEellRegxpTFquIqE4gMiquo1i/FL1WA0Pcl6g52PJIiv05Y97oyfe9L8SbxXtam4C93SA5yaAO9s6cVN8O17V2sk5tvlfF4Euj+GuLA/UI+I1GichZM9V/AMfH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712571807; c=relaxed/simple;
	bh=defNepUeNvybDxA+Wcux2NfPpGp5OU/cEgHKGppWtpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4SaiabWixKYKNwLEO4vsG352rRDE6c3w+bn60cPn+QUPlPhbhdTDYZ8fvE8EjND6tuqdJ8aG/YgFmvIvBxY73zgoHrJWAGGNP6SYZW+dBULTTOsxEFwP9hLIzJm1GeC+Ndo5H3gYQ479QOZ0pE6o0d0AOHEv+OThDxjFxX94uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAPrg+vz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE42AC433C7;
	Mon,  8 Apr 2024 10:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712571806;
	bh=defNepUeNvybDxA+Wcux2NfPpGp5OU/cEgHKGppWtpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EAPrg+vz9vTL8BRa2VrU7ReqAihVd/FPmXJpiQPsYyenZCWAkINg9JFQiR9owc32h
	 T87XUqhIIrk3HsOuTGnZBGPKj1nqnjDroseCR08NpC7TFvtp7vaCX5lLsNx2KGKBW7
	 KOIBoVYlo/jilRYigckQWUr0Lpq8OyZRVt5/fXGplIw1Gvd52ZxH+AjZBVQp3pB7Fj
	 EwaEBOKvWNyCG4rFJ7u+T36J4ojsGJ43GLw9TAz7Yi1R06KpDym6WVQRWQTPpcBCYM
	 fcXoiZtsB1aPdYLi8tZE0N/Q5DdXYkxoZi9DalXL4o8VasPuv/COWVIPQvOvPRfzqo
	 H7ZW1kb1cIduQ==
Date: Mon, 8 Apr 2024 12:23:20 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: helgaas@kernel.org, bhelgaas@google.com, gustavo.pimentel@synopsys.com,
	imx@lists.linux.dev, jdmason@kudzu.us, jingoohan1@gmail.com,
	kw@linux.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lpieralisi@kernel.org, mani@kernel.org,
	robh@kernel.org
Subject: Re: [PATCH v3 1/1] PCI: dwc: Fix index 0 incorrectly being
 interpreted as a free ATU slot
Message-ID: <ZhPFmFYorWa-sfLp@ryzen>
References: <20240326193540.3610570-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326193540.3610570-1-Frank.Li@nxp.com>

On Tue, Mar 26, 2024 at 03:35:40PM -0400, Frank Li wrote:
> When PERST# assert and deassert happens on the PERST# supported platforms,
> the both iATU0 and iATU6 will map inbound window to BAR0. DMA will access
> to the area that was previously allocated (iATU0) for BAR0, instead of the
> new area (iATU6) for BAR0.

Nit: If we want additional clarity, we could also add:
""
Right now, we dodge the bullet because both iATU0 and iATU6 should currently
translate inbound accesses to BAR0 to the same allocated memory area. However,
having two separate inbound mappings for the same BAR is a disaster waiting to
happen.
""

If the maintainers feel like this additional information is important, I think
it could be added while applying. (But I also think that the existing commit
message is detailed enough to be applied as is.)


> 
> The mapping between PCI BAR and iATU inbound window are maintained in the
> dw_pcie_ep::bar_to_atu[] array. While allocating a new inbound iATU map for
> a BAR, dw_pcie_ep_inbound_atu() API will first check for the availability
> of the existing mapping in the array and if it is not found (i.e., value in
> the array indexed by the BAR is found to be 0), then it will allocate a new
> map value using find_first_zero_bit().
> 
> The issue here is, the existing logic failed to consider the fact that the
> map value '0' is a valid value for BAR0. Because, find_first_zero_bit()
> will return '0' as the map value for BAR0 (note that it returns the first
> zero bit position).
> 
> Due to this, when PERST# assert + deassert happens on the PERST# supported
> platforms, the inbound window allocation restarts from BAR0 and the
> existing logic to find the BAR mapping will return '6' for BAR0 instead of
> '0' due to the fact that it considers '0' as an invalid map value.
> 
> So fix this issue by always incrementing the map value before assigning to
> bar_to_atu[] array and then decrementing it while fetching. This will make
> sure that the map value '0' always represents the invalid mapping."
> 
> Reported-by: Niklas Cassel <Niklas.Cassel@wdc.com>
> Closes: https://lore.kernel.org/linux-pci/ZXsRp+Lzg3x%2Fnhk3@x1-carbon/
> Tested-by: Niklas Cassel <niklas.cassel@wdc.com>
> Fixes: 4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() update inbound map address")
> Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     Change from v2 to v3
>     - Add impact in commit message
>     - Add mani's detail description
>     - Fix Closes link
>     
>     Change from v1 to v2
>     - update subject
>     - use free_win + 1 solution
>     - still leave MAX_IATU_IN as 256. I am not sure if there are platfrom have
>     256 ATU. Suppose it only use max 6 in current EP framework.
>     - @Niklas, can you help test it. My platform become unstable today.
> 
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 5befed2dc02b7..ba932bafdb230 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -139,7 +139,7 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
>  	if (!ep->bar_to_atu[bar])
>  		free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
>  	else
> -		free_win = ep->bar_to_atu[bar];
> +		free_win = ep->bar_to_atu[bar] - 1;
>  
>  	if (free_win >= pci->num_ib_windows) {
>  		dev_err(pci->dev, "No free inbound window\n");
> @@ -153,7 +153,11 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
>  		return ret;
>  	}
>  
> -	ep->bar_to_atu[bar] = free_win;
> +	/*
> +	 * Always increment free_win before assignment, since value 0 is used to identify
> +	 * unallocated mapping.
> +	 */
> +	ep->bar_to_atu[bar] = free_win + 1;
>  	set_bit(free_win, ep->ib_window_map);
>  
>  	return 0;
> @@ -190,7 +194,10 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	enum pci_barno bar = epf_bar->barno;
> -	u32 atu_index = ep->bar_to_atu[bar];
> +	u32 atu_index = ep->bar_to_atu[bar] - 1;
> +
> +	if (!ep->bar_to_atu[bar])
> +		return;
>  
>  	__dw_pcie_ep_reset_bar(pci, func_no, bar, epf_bar->flags);
>  
> -- 
> 2.34.1
> 

