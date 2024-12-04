Return-Path: <linux-pci+bounces-17697-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 089DF9E42B2
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 19:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6FEB169E56
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 18:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D10217F3C;
	Wed,  4 Dec 2024 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIZUXp7a"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B978320E009;
	Wed,  4 Dec 2024 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733333634; cv=none; b=cgN03vcKF83plCR2mQ29XcNSiXdLJbnz4bFktbJQJEe4WgOivcBWZLe0kPCyUxrwqL7ECFzYZdsXPeCdnkRtVB0AloElFqhBWNsWpPcm2VW2v1dT0CX8R2384s4ySjeBF3qIqJbG+8jRi3yZ5Mo+gbR1zjGg93iiHvT7Fv7iAEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733333634; c=relaxed/simple;
	bh=S9wgLBdQCQxPX0irZU/BRqEDD9Qby6+QgEAJXBPx01k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Gkm1ct5tZl+RbvmYB3JLMVS3CNm5oXyd3lnhk4SYkv0ICeYOYhoF0fdQVfCVXblkZqWvPmxUu1+TIHlcPcMtxKlXnPMyuJ1oB1ikTI6q4ErAdBn9/VgNQ8PQ2xnqyHEZab7wyJIwUAydm85NgZnCu1D8CaCXL5fCGAU1oTACBkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIZUXp7a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD8FC4CECD;
	Wed,  4 Dec 2024 17:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733333634;
	bh=S9wgLBdQCQxPX0irZU/BRqEDD9Qby6+QgEAJXBPx01k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=vIZUXp7app6GQ5UuAaWCteb+CCEHYrj1NAgC9RzOiAmh4Bf6N4x5yWLlrm66+7Pvg
	 nIEIhcVEeNCQFIY5sU4Lb1/m9kXItOicceC5m8yPvWXX8lJwJlHzYCnRkUyIroSuFk
	 TMmPb8AKnNEWtMSJL4t1VaO26mjieMgwgXY9uuhbI5mAZfiDSQjevd3pF15VDFqoMd
	 /nmSH1w1OZaBQjVUJyXTAT2ibeoiOgLvy5Idd09zB7Uzi+il8AvylgM45UPgHgYlb8
	 aXNA5YhEEKpixnD5LgA4s+nvPfWMCz3ZskqU+m7mXjsvtPn9b21kX0YI0t6BTbsIA2
	 OTwP4py33A8Pg==
Date: Wed, 4 Dec 2024 11:33:52 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>, stable@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 1/6] PCI: dwc: ep: iATU registers must be written
 after the BAR_MASK
Message-ID: <20241204173352.GA3006363@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127103016.3481128-9-cassel@kernel.org>

In subject, maybe "Write BAR_MASK before iATU registers"

I guess writing BAR_MASK is really configuring the *size* of the BAR?
Maybe the size is the important semantic connection with iATU config?

On Wed, Nov 27, 2024 at 11:30:17AM +0100, Niklas Cassel wrote:
> The DWC Databook description for the LWR_TARGET_RW and LWR_TARGET_HW fields
> in the IATU_LWR_TARGET_ADDR_OFF_INBOUND_i registers state that:
> "Field size depends on log2(BAR_MASK+1) in BAR match mode."

Can we include a databook revision and section here to help future
maintainers?

> I.e. only the upper bits are writable, and the number of writable bits is
> dependent on the configured BAR_MASK.
> 
> If we do not write the BAR_MASK before writing the iATU registers, we are
> relying the reset value of the BAR_MASK being larger than the requested
> size of the first set_bar() call. The reset value of the BAR_MASK is SoC
> dependent.
> 
> Thus, if the first set_bar() call requests a size that is larger than the
> reset value of the BAR_MASK, the iATU will try to write to read-only bits,
> which will cause the iATU to end up redirecting to a physical address that
> is different from the address that was intended.
> 
> Thus, we should always write the iATU registers after writing the BAR_MASK.

Apparently we write BAR_MASK and the iATU registers in the wrong
order?  I assume dw_pcie_ep_inbound_atu() writes the iATU registers.

I can't quite connect the commit log with the code change.  I assume
the dw_pcie_ep_writel_dbi2() and dw_pcie_ep_writel_dbi() writes update
BAR_MASK?

And I guess the problem is that the previous code does:

  dw_pcie_ep_inbound_atu        # iATU
  dw_pcie_ep_writel_dbi2        # BAR_MASK (?)
  dw_pcie_ep_writel_dbi

and the new code basically does this:

  if (ep->epf_bar[bar]) {
    dw_pcie_ep_writel_dbi2      # BAR_MASK (?)
    dw_pcie_ep_writel_dbi
  }
  dw_pcie_ep_inbound_atu        # iATU
  ep->epf_bar[bar] = epf_bar

so the first time we call dw_pcie_ep_set_bar(), we write BAR_MASK
before iATU, and if we call dw_pcie_ep_set_bar() again, we skip the 
BAR_MASK update?

> Cc: stable@vger.kernel.org
> Fixes: f8aed6ec624f ("PCI: dwc: designware: Add EP mode support")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 28 ++++++++++---------
>  1 file changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index f3ac7d46a855..bad588ef69a4 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -222,19 +222,10 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	if ((flags & PCI_BASE_ADDRESS_MEM_TYPE_64) && (bar & 1))
>  		return -EINVAL;
>  
> -	reg = PCI_BASE_ADDRESS_0 + (4 * bar);
> -
> -	if (!(flags & PCI_BASE_ADDRESS_SPACE))
> -		type = PCIE_ATU_TYPE_MEM;
> -	else
> -		type = PCIE_ATU_TYPE_IO;
> -
> -	ret = dw_pcie_ep_inbound_atu(ep, func_no, type, epf_bar->phys_addr, bar);
> -	if (ret)
> -		return ret;
> -
>  	if (ep->epf_bar[bar])
> -		return 0;
> +		goto config_atu;
> +
> +	reg = PCI_BASE_ADDRESS_0 + (4 * bar);
>  
>  	dw_pcie_dbi_ro_wr_en(pci);
>  
> @@ -246,9 +237,20 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  		dw_pcie_ep_writel_dbi(ep, func_no, reg + 4, 0);
>  	}
>  
> -	ep->epf_bar[bar] = epf_bar;
>  	dw_pcie_dbi_ro_wr_dis(pci);
>  
> +config_atu:
> +	if (!(flags & PCI_BASE_ADDRESS_SPACE))
> +		type = PCIE_ATU_TYPE_MEM;
> +	else
> +		type = PCIE_ATU_TYPE_IO;
> +
> +	ret = dw_pcie_ep_inbound_atu(ep, func_no, type, epf_bar->phys_addr, bar);
> +	if (ret)
> +		return ret;
> +
> +	ep->epf_bar[bar] = epf_bar;
> +
>  	return 0;
>  }
>  
> -- 
> 2.47.0
> 

