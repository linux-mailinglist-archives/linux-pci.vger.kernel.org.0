Return-Path: <linux-pci+bounces-15809-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4C69B9768
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 19:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 464631F209B6
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 18:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FCA1CCECB;
	Fri,  1 Nov 2024 18:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdyLiWfS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F23196D80
	for <linux-pci@vger.kernel.org>; Fri,  1 Nov 2024 18:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730485524; cv=none; b=Cti1aXkHso6o2qTpVWPPmWfaGwm9GRenXIrur9jk3fL3Rhgc3Lb5txOJTWTbPipkch8mYVePIhF/DUQqWRE3ht06voRWk2P4PH2NBgytVb1YAcQvi+iXHVvtew4SEkHJVle0TM6JD4M79Cn2rvG2rVlp7UVA7yyrIAwP1Ms4wZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730485524; c=relaxed/simple;
	bh=VCyOwB2/zoWuLwCYECC3X1DA5uyo6rcm0HLt+af/Sys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSj47fZh6sUs3g801n+H4lwT/oQ51SUQl2sQ3UIYKwaaBwPvNcRSQyO7eWUVxIAhpYQc3FqDsoSDvDtd//pNrx4sJe6GBXTmz8tpj8Y+sSplx/UEFB7Sh5Hm+skh9m2qLZp2Km8FNfPQXzxv20tI/O2tFjbW7Y6gV3irQC8BfDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdyLiWfS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC621C4CECD;
	Fri,  1 Nov 2024 18:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730485524;
	bh=VCyOwB2/zoWuLwCYECC3X1DA5uyo6rcm0HLt+af/Sys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sdyLiWfSGWeO/ScAAcFNYqHIoSUfvzdI+5fhNhARnvyaoB2rUfWNscIUw1eJvh+TJ
	 eB5NZwP/R6P04NwQOjjuAxspGeJvqnnOMQvhUdsjN3zlpgc6mKYcetSnoa5f4NnSYj
	 SupIJZKC+VUnd3ZK/OFXTJma2FB7ptHJ7egbpNTsLEsdzaR0c67C4UMF/iMBLa+ng0
	 gShB16SnCcYs3CZmWd0S+ukGj2ldmHKqZFyCSabcWAll/7Xo18G/6RalmoR+ZZ8Gp9
	 pTScTmpRqiE8F8oC4UqF+m1jmdMHMHN/wSc3bopXtsjJYwrzlXpeo8T7FpXRTEuYVc
	 wnJVp0Dp1eo4Q==
Date: Fri, 1 Nov 2024 19:25:18 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: dwc: ep: Use align addr function for
 dw_pcie_ep_raise_{msi,msix}_irq()
Message-ID: <ZyUdDqLwirSZEmvw@x1-carbon>
References: <20241031202849.GA1266008@bhelgaas>
 <7c30ed21-5d48-414a-a943-68ff74b4f23e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c30ed21-5d48-414a-a943-68ff74b4f23e@kernel.org>

On Fri, Nov 01, 2024 at 07:36:51AM +0900, Damien Le Moal wrote:
> On 11/1/24 05:28, Bjorn Helgaas wrote:
> > On Thu, Oct 17, 2024 at 03:20:55PM +0200, Niklas Cassel wrote:
> >> Use the dw_pcie_ep_align_addr() function to calculate the alignment in
> >> dw_pcie_ep_raise_{msi,msix}_irq() instead of open coding the same.
> >>
> >> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> >> ---
> >>  .../pci/controller/dwc/pcie-designware-ep.c    | 18 +++++++++---------
> >>  1 file changed, 9 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> >> index 20f67fd85e83..9bafa62bed1d 100644
> >> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> >> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> >> @@ -503,7 +503,8 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
> >>  	u32 msg_addr_lower, msg_addr_upper, reg;
> >>  	struct dw_pcie_ep_func *ep_func;
> >>  	struct pci_epc *epc = ep->epc;
> >> -	unsigned int aligned_offset;
> >> +	size_t msi_mem_size = epc->mem->window.page_size;
> >> +	size_t offset;
> >>  	u16 msg_ctrl, msg_data;
> >>  	bool has_upper;
> >>  	u64 msg_addr;
> >> @@ -531,14 +532,13 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
> >>  	}
> >>  	msg_addr = ((u64)msg_addr_upper) << 32 | msg_addr_lower;
> >>  
> >> -	aligned_offset = msg_addr & (epc->mem->window.page_size - 1);
> >> -	msg_addr = ALIGN_DOWN(msg_addr, epc->mem->window.page_size);
> >> +	msg_addr = dw_pcie_ep_align_addr(epc, msg_addr, &msi_mem_size, &offset);
> >>  	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
> >> -				  epc->mem->window.page_size);
> >> +				  msi_mem_size);
> > 
> > I haven't worked through this; just double checking that this is
> > correct.  Previously we did ALIGN_DOWN() here, but
> > dw_pcie_ep_align_addr() uses ALIGN() (not ALIGN_DOWN()).  Similar
> > below in dw_pcie_ep_raise_msix_irq().
> 
> The ALIGN() in dw_pcie_ep_align_addr() is for the mapping size. The address is
> aligned down manually:
> 
> 	return pci_addr & ~mask;
> 
> So it is the same. We could change dw_pcie_ep_align_addr() to do:
> 
> 	return ALIGN_DOWN(pci_addr, epc->mem->window.page_size);
> 
> But given that the offset calculation needs the alignment mask anyway, using
> the mask variable directly seems natural.

I agree.


> 
> So this is functionnally identical for the PCI address being mapped, and it is
> even better for the mapping size since this was passing
> epc->mem->window.page_size before but if the PCI address range crosses over a
> page_size boundary, we actually need 2 x page_size as the mapping size...
> 
> Which makes me realized that there is something still wrong: the memory being
> mapped (ep->msi_mem) is at most one page:
> 
> 	ep->msi_mem = pci_epc_mem_alloc_addr(epc, &ep->msi_mem_phys,
> 					     epc->mem->window.page_size);
> 	if (!ep->msi_mem) {
> 		ret = -ENOMEM;
> 		dev_err(dev, "Failed to reserve memory for MSI/MSI-X\n");
> 		goto err_exit_epc_mem;
> 	}
> 
> But we may need up to 2 pages depending on the PCI address we get for the
> MSI/MSIX. So we need to fix that as well I think.
> 
> Niklas, thoughts ?

Hmm.. the MSI data that we want to map is just two bytes.
It is just that the minimum mapping we can do is epc->mem->window.page_size.

On e.g. rk3588 the page_size is 64k.

I guess that we might be unlucky and get the MSI data at an offset that is
at the end of the page.

But considering that we just need 2 bytes (for MSI, 4 bytes for MSI-X),
and that the PCI word size is 4 bytes, I don't see a problem with the
current code.


While the allocation of the msi_mem should still be page_size:
ep->msi_mem = pci_epc_mem_alloc_addr(epc, &ep->msi_mem_phys,
                                     epc->mem->window.page_size);

I guess that we could change dw_pcie_ep_raise_msi_irq() from:
size_t msi_mem_size = epc->mem->window.page_size;
to:
size_t msi_mem_size = 2;

and change dw_pcie_ep_raise_msix_irq() from:
size_t msi_mem_size = epc->mem->window.page_size;
to:
size_t msi_mem_size = 4;

To make the code strictly more correct for a reader, but I
don't think that there is a problem with the current code.


Kind regards,
Niklas

