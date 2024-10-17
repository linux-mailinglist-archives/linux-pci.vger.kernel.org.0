Return-Path: <linux-pci+bounces-14758-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C20339A1F14
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 11:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40BC5B24D70
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 09:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7B41D9682;
	Thu, 17 Oct 2024 09:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIN/UOb+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44699165F08;
	Thu, 17 Oct 2024 09:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158761; cv=none; b=Spd5ZnfoH2eLUHx0SbHiIY1a7wSX4rxR8NGmYvtWc5BEx+5VJ8bys289g4yL3o9WqF2lrQIFC1Y8R2mFe0AkHjP3LFLNOc1tEVjLFenTA3lWi0c701EQo+A1zz0Rh8ye0vzYuvEPuKJGPWMJn9NPDO3oYCHfekiVU+5MzROs1h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158761; c=relaxed/simple;
	bh=uukEasIQNFgjyA46j6yP84HfXniUu+fVrEHA2EgplSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPGhqlWZnDcmuL+BV0Mz9obIz4LpXgspFot8nQRCLrzla6k5tuBDxszVJ5SRqvlqK21WwpCMubmiSZz0uAkN7sT1h5rO46MhqyGVLoBc9AKQuyOEkilGEt/xQBmlBosnTpF5Vm9j5CxP3OTK5kmro/s5MLnjUEQKa1eejF0Vin0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIN/UOb+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B701EC4CED1;
	Thu, 17 Oct 2024 09:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729158760;
	bh=uukEasIQNFgjyA46j6yP84HfXniUu+fVrEHA2EgplSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PIN/UOb+jYQdtHShMKSEAPVkRiEk3O+matAyczVNRM/9cCII3p41QM1Vh1LRUWBew
	 Dkn62I7kl0iao9jlrXinm4nG/n/JeU0HsxGwZa4befRw/12t8EferCYJLCDGMWCPuW
	 9GvNu2F6dm39IZqm4WXmzDfbkSuDhhmhB2KN2YB4nXU8uOAdFrPju31DH/TI/ZQQ6C
	 puvtBGDxKIlbvV/8g6rxVp/3lTvuu55B/FJU3DTudJwfr63QjuvkLWgA5AxANfFoBT
	 Y4ZzJDH3db3zdHHx0rhAStjm5NU9ktl7uCMBhkMtwelN+LutLnQRbI6gvE/fBzwfaF
	 lGdtEzb3OxwSg==
Date: Thu, 17 Oct 2024 11:52:34 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>
Subject: Re: [PATCH v5 06/14] PCI: rockchip-ep: Fix MSI IRQ data mapping
Message-ID: <ZxDeYqfti0iiK8D2@ryzen.lan>
References: <20241017015849.190271-1-dlemoal@kernel.org>
 <20241017015849.190271-7-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017015849.190271-7-dlemoal@kernel.org>

On Thu, Oct 17, 2024 at 10:58:41AM +0900, Damien Le Moal wrote:
> The call to rockchip_pcie_prog_ep_ob_atu() used to map the PCI address
> of MSI data to the memory window allocated on probe for IRQs is done
> in rockchip_pcie_ep_send_msi_irq() assuming a fixed alignment to a
> 256B boundary of the PCI address.  This is not correct as the alignment
> constraint for the RK3399 PCI mapping depends on the number of bits of
> address changing in the mapped region. This leads to an unstable system
> which sometimes work and sometimes does not (crashing on paging faults
> when memcpy_toio() or memcpy_fromio() are used).
> 
> Similar to regular data mapping, the MSI data mapping must thus be
> handled according to the information provided by
> rockchip_pcie_ep_align_addr(). Modify rockchip_pcie_ep_send_msi_irq()
> to use rockchip_pcie_ep_align_addr() to correctly program entry 0 of
> the ATU for sending MSI IRQs.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/pci/controller/pcie-rockchip-ep.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
> index f6959f9b94b7..dcd1b5415602 100644
> --- a/drivers/pci/controller/pcie-rockchip-ep.c
> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> @@ -379,9 +379,10 @@ static int rockchip_pcie_ep_send_msi_irq(struct rockchip_pcie_ep *ep, u8 fn,
>  {
>  	struct rockchip_pcie *rockchip = &ep->rockchip;
>  	u32 flags, mme, data, data_mask;
> +	size_t irq_pci_size, offset;
> +	u64 irq_pci_addr;
>  	u8 msi_count;
>  	u64 pci_addr;
> -	u32 r;
>  
>  	/* Check MSI enable bit */
>  	flags = rockchip_pcie_read(&ep->rockchip,
> @@ -417,18 +418,21 @@ static int rockchip_pcie_ep_send_msi_irq(struct rockchip_pcie_ep *ep, u8 fn,
>  				       PCI_MSI_ADDRESS_LO);
>  
>  	/* Set the outbound region if needed. */
> -	if (unlikely(ep->irq_pci_addr != (pci_addr & PCIE_ADDR_MASK) ||
> +	irq_pci_size = ~PCIE_ADDR_MASK + 1;
> +	irq_pci_addr = rockchip_pcie_ep_align_addr(ep->epc,
> +						   pci_addr & PCIE_ADDR_MASK,
> +						   &irq_pci_size, &offset);
> +	if (unlikely(ep->irq_pci_addr != irq_pci_addr ||
>  		     ep->irq_pci_fn != fn)) {
> -		r = rockchip_ob_region(ep->irq_phys_addr);
> -		rockchip_pcie_prog_ep_ob_atu(rockchip, fn, r,
> -					     ep->irq_phys_addr,
> -					     pci_addr & PCIE_ADDR_MASK,
> -					     ~PCIE_ADDR_MASK + 1);
> -		ep->irq_pci_addr = (pci_addr & PCIE_ADDR_MASK);
> +		rockchip_pcie_prog_ep_ob_atu(rockchip, fn,
> +					rockchip_ob_region(ep->irq_phys_addr),
> +					ep->irq_phys_addr,
> +					irq_pci_addr, irq_pci_size);
> +		ep->irq_pci_addr = irq_pci_addr;
>  		ep->irq_pci_fn = fn;
>  	}
>  
> -	writew(data, ep->irq_cpu_addr + (pci_addr & ~PCIE_ADDR_MASK));
> +	writew(data, ep->irq_cpu_addr + offset + (pci_addr & ~PCIE_ADDR_MASK));
>  	return 0;
>  }
>  
> -- 
> 2.47.0
> 

Nice catch.

For DWC, in dw_pcie_ep_raise_msi_irq()
https://github.com/torvalds/linux/blob/v6.12-rc3/drivers/pci/controller/dwc/pcie-designware-ep.c#L519-L522

and in dw_pcie_ep_raise_msix_irq()
https://github.com/torvalds/linux/blob/v6.12-rc3/drivers/pci/controller/dwc/pcie-designware-ep.c#L603-L606

We also make sure that the address that we map is aligned,
and then write to the correct offset within that mapping:
ep->msi_mem + aligned_offset;
in order to write to the actual MSI address.

To me, it looks like doing a similar change as this patch does,
to dw_pcie_ep_raise_msi_irq() and dw_pcie_ep_raise_msix_irq(),
would make the PCI endpoint code more consistent overall.

Thoughts?


Kind regards,
Niklas

