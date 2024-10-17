Return-Path: <linux-pci+bounces-14824-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A54D49A2CB9
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 20:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48BC31F21AEC
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 18:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF38920100C;
	Thu, 17 Oct 2024 18:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AG7BxolG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAB01D63CD
	for <linux-pci@vger.kernel.org>; Thu, 17 Oct 2024 18:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729191245; cv=none; b=GUPvpBkXiLQHt0LQbQtbEluo54/xreqQTpXEsqlGsTgoN6vaD3CJkI/aFVz8sKVUbGFL81NKXKFRyuy0UffQWF2ZFGiHmqFomsd9E7wQB1sxWHRWhvcpn4xNcIoBKBbU0vvthh1xoDemuWIpI4enSDZJJAZNNgaL5nR/TpyfF1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729191245; c=relaxed/simple;
	bh=qDhYWRaEVpOxbalYdgepCinwBjGMND+OWBzEM4Fp1so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2+g0JqEWomMEVNquanoYAgezCYV0F18Kd1vCFjmR/DW0ZxRwJoqFXAxRDpVk+lhcqHzX9191h/0xFAyLbF/BUzGNH1XuPemJVzhlmT74f3k6DBifMFvmAKLiFi4aSzQvrN1aM3I0tHVR94rceS8q9L/DAfKKg1upDEZanMkuNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AG7BxolG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A663C4CEC3;
	Thu, 17 Oct 2024 18:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729191245;
	bh=qDhYWRaEVpOxbalYdgepCinwBjGMND+OWBzEM4Fp1so=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AG7BxolGlHITZDsbhSSmBgoVcrMAeQMdlOOJyBb58DoRaWdHTwG83G/nWsamzUqTy
	 jypYYb2jJHgHx0HfIRKyOTzIfDywWfVfYQ4Fc2PA5UgW8qkVBABRz90LKlDtWrJSYV
	 +rMaIpeVV36hR66LZWWublr/YaofY3pAOPSUBnENby0Xi1mxgZpYQlldU60pP3PlRn
	 KGwEgzgGXdL1zQOSSLLLJ+NCupdPZqRIxuBtv5Io4AxNaTtc8D+tWLtGJuqRZlHeOz
	 6uQDcCyy6WFe5W3ywQQNF+scl759kby3NlhuyzTYmtgX0SeDyCkqPW6M6h/0tqpVdh
	 vqYi4C8GcPNgw==
Date: Thu, 17 Oct 2024 20:54:01 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: dwc: ep: Use align addr function for
 dw_pcie_ep_raise_{msi,msix}_irq()
Message-ID: <ZxFdSSqbefIiZLN-@ryzen.lan>
References: <20241017132052.4014605-4-cassel@kernel.org>
 <20241017132052.4014605-6-cassel@kernel.org>
 <ZxEvFT4+X35/NxWn@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxEvFT4+X35/NxWn@lizhi-Precision-Tower-5810>

Hello Frank,

On Thu, Oct 17, 2024 at 11:36:53AM -0400, Frank Li wrote:
> On Thu, Oct 17, 2024 at 03:20:55PM +0200, Niklas Cassel wrote:
> > Use the dw_pcie_ep_align_addr() function to calculate the alignment in
> > dw_pcie_ep_raise_{msi,msix}_irq() instead of open coding the same.
> >
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> >  .../pci/controller/dwc/pcie-designware-ep.c    | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index 20f67fd85e83..9bafa62bed1d 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -503,7 +503,8 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
> >  	u32 msg_addr_lower, msg_addr_upper, reg;
> >  	struct dw_pcie_ep_func *ep_func;
> >  	struct pci_epc *epc = ep->epc;
> > -	unsigned int aligned_offset;
> > +	size_t msi_mem_size = epc->mem->window.page_size;
> > +	size_t offset;
> >  	u16 msg_ctrl, msg_data;
> >  	bool has_upper;
> >  	u64 msg_addr;
> > @@ -531,14 +532,13 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
> >  	}
> >  	msg_addr = ((u64)msg_addr_upper) << 32 | msg_addr_lower;
> >
> > -	aligned_offset = msg_addr & (epc->mem->window.page_size - 1);
> > -	msg_addr = ALIGN_DOWN(msg_addr, epc->mem->window.page_size);
> > +	msg_addr = dw_pcie_ep_align_addr(epc, msg_addr, &msi_mem_size, &offset);
> >  	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
> > -				  epc->mem->window.page_size);
> > +				  msi_mem_size);
> >  	if (ret)
> >  		return ret;
> >
> > -	writel(msg_data | (interrupt_num - 1), ep->msi_mem + aligned_offset);
> > +	writel(msg_data | (interrupt_num - 1), ep->msi_mem + offset);
> >
> >  	dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->msi_mem_phys);
> >
> > @@ -589,8 +589,9 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
> >  	struct pci_epf_msix_tbl *msix_tbl;
> >  	struct dw_pcie_ep_func *ep_func;
> >  	struct pci_epc *epc = ep->epc;
> > +	size_t msi_mem_size = epc->mem->window.page_size;
> > +	size_t offset;
> >  	u32 reg, msg_data, vec_ctrl;
> > -	unsigned int aligned_offset;
> 
> why not direct use 'aligned_offset' ? just change  to size_t.

Because I think that that name was really bad.
aligned_offset sounds like the offset is aligned, but that is not the case.

Now when we have a dw_pcie_ep_align_addr() function, I think that simply
calling the variable offset is less ambiguous. Anyone who isn't sure what
the offset represents can simply read the documentation for the .align_addr
endpoint controller operation.


Kind regards,
Niklas

