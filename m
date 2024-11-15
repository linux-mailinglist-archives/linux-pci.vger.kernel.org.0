Return-Path: <linux-pci+bounces-16832-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E44589CDA49
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 09:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B86F1F21D53
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 08:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B11288DA;
	Fri, 15 Nov 2024 08:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkdyC5LW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440182B9B7
	for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 08:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731658540; cv=none; b=uHgXst3wpc9Xn3P89+5E+/poaHx6N84jz8z3DeQ01snSe+WaP0FegdGhUP0ZjnfgWBRZrMcQDtJFK/3m9CZB6ydjqJCFN0353qY7OIkrdRsgayb0mctVrYTA5HPmF3prrHM8gQjRfjfIZ35YGkVvQgLMbNlRnp+KGlUDKrNQFJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731658540; c=relaxed/simple;
	bh=qb1EqVjy+N6VtdnAaxbLLICIMKpDLDUxnqmDHbT7RsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7NiMXnhg2Wk9nnzqySt7pkgMtSoLFvvWu9Lsrq0+VnEmx3yOdZES1lHJPiWe7tV4zqVHERJ7IjAyVE3yYJL7+2HtE2Dzkzg8AYZpH3ud5+dXMZXYBPUbXGeFggHJd/xHMC5rI3zmRynt/fUwgLBj8nNcGDCCNN+6ZxiOjik0fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkdyC5LW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98DEDC4CECF;
	Fri, 15 Nov 2024 08:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731658539;
	bh=qb1EqVjy+N6VtdnAaxbLLICIMKpDLDUxnqmDHbT7RsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CkdyC5LWo4W6lwv6CrLNVysqfsQmMUHrY0vdSH3Okfh8kiwdgyRCiWLlGFoEAnrjn
	 +lybZFX0YGkUz3sPiznvmG0HYM9sP5U1I9LMZzaiMdCfVOqrhpeMq1ZSyPhWhiZmFW
	 EqveRvPrqwWlokhr9i3uL44Nj1xql+7TNX760VP9Nw1VXnGojvMC8MA/4tbx8h/0Mv
	 NIOtpZVZ8I5n+M0+/fkZRU+QjeGD3sHQPpob7im9Vvk0B0J6+aiM23E1nRvH/4GUj3
	 xSrCowOC5BctPfmP00HvefNqkMBjsgoW333dTH24QzrB88laoR4ITRNXwodJ7KCCQG
	 80YFkAJJpeYJw==
Date: Fri, 15 Nov 2024 09:15:34 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jesper Nilsson <jesper.nilsson@axis.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI: dwc: ep: Improve alignment check in
 dw_pcie_prog_ep_inbound_atu()
Message-ID: <ZzcDJo_U0zz3OQe7@ryzen>
References: <20241114110326.1891331-5-cassel@kernel.org>
 <20241114110326.1891331-8-cassel@kernel.org>
 <ZzYxslV+c1QxsJCM@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzYxslV+c1QxsJCM@lizhi-Precision-Tower-5810>

On Thu, Nov 14, 2024 at 12:21:54PM -0500, Frank Li wrote:
> On Thu, Nov 14, 2024 at 12:03:29PM +0100, Niklas Cassel wrote:
> 
> according to patch, subject look like
> 
> "Add 'address' alignment to 'size' check in dw_pcie_prog_ep_inbound_atu()."

Sure.


> 
> > dw_pcie_prog_ep_inbound_atu() is used to program an inbound iATU in
> > "BAR Match Mode".
> >
> > While a memory address returned by kmalloc() is guaranteed to be naturally
> > aligned (aligned to the size of the allocation), it is not guaranteed that
> > the address that is supplied to pci_epc_set_bar() (and thus the addres that
> > is supplied to dw_pcie_prog_ep_inbound_atu()) is naturally aligned.
> 
> short sentence may be better
> 
> The memory address returned by kmalloc() is guaranteed to be naturally
> aligned (aligned to the size of the allocation), but it may not align when
> pass to pci_epc_set_bar().

I do not think that this is better.

The memory address returned by kmalloc() is naturally aligned, and will still
be naturally aligned when passed to pci_epc_set_bar().

The problem is if the address supplied to pci_epc_set_bar() did not come from
something that was kmalloc():ed. E.g. the ITS address.

I can rephrase this sentence to make that clearer in v2.


Kind regards,
Niklas


> 
> >
> > See the register description for IATU_LWR_TARGET_ADDR_OFF_INBOUND_i,
> > specifically fields LWR_TARGET_RW and LWR_TARGET_HW in the DWC Databook.
> >
> > "Field size depends on log2(BAR_MASK+1) in BAR match mode."
> >
> > I.e. only the upper bits are writable, and the number of writable bits is
> > dependent on the configured BAR_MASK.
> >
> > Add a check to ensure that the physical address programmed in the iATU is
> > aligned to the size of the BAR (BAR_MASK+1), as without this, we can get
> > hard to debug errors, as we could write to bits that are read-only (without
> > getting a write error), which could cause the iATU to end up redirecting to
> > a physical address that is different from the address that we intended.
> >
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware-ep.c | 8 +++++---
> >  drivers/pci/controller/dwc/pcie-designware.c    | 5 +++--
> >  drivers/pci/controller/dwc/pcie-designware.h    | 2 +-
> >  3 files changed, 9 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index 507e40bd18c8f..4ad6ebd2ea320 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -128,7 +128,8 @@ static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> >  }
> >
> >  static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
> > -				  dma_addr_t cpu_addr, enum pci_barno bar)
> > +				  dma_addr_t cpu_addr, enum pci_barno bar,
> > +				  size_t size)
> >  {
> >  	int ret;
> >  	u32 free_win;
> > @@ -145,7 +146,7 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
> >  	}
> >
> >  	ret = dw_pcie_prog_ep_inbound_atu(pci, func_no, free_win, type,
> > -					  cpu_addr, bar);
> > +					  cpu_addr, bar, size);
> >  	if (ret < 0) {
> >  		dev_err(pci->dev, "Failed to program IB window\n");
> >  		return ret;
> > @@ -229,7 +230,8 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> >  	else
> >  		type = PCIE_ATU_TYPE_IO;
> >
> > -	ret = dw_pcie_ep_inbound_atu(ep, func_no, type, epf_bar->phys_addr, bar);
> > +	ret = dw_pcie_ep_inbound_atu(ep, func_no, type, epf_bar->phys_addr, bar,
> > +				     size);
> >  	if (ret)
> >  		return ret;
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index 6d6cbc8b5b2c6..3c683b6119c39 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -597,11 +597,12 @@ int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
> >  }
> >
> >  int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> > -				int type, u64 cpu_addr, u8 bar)
> > +				int type, u64 cpu_addr, u8 bar, size_t size)
> >  {
> >  	u32 retries, val;
> >
> > -	if (!IS_ALIGNED(cpu_addr, pci->region_align))
> > +	if (!IS_ALIGNED(cpu_addr, pci->region_align) ||
> > +	    !IS_ALIGNED(cpu_addr, size))
> >  		return -EINVAL;
> >
> >  	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_LOWER_TARGET,
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index 347ab74ac35aa..fc08727116725 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -491,7 +491,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
> >  int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
> >  			     u64 cpu_addr, u64 pci_addr, u64 size);
> >  int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> > -				int type, u64 cpu_addr, u8 bar);
> > +				int type, u64 cpu_addr, u8 bar, size_t size);
> >  void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index);
> >  void dw_pcie_setup(struct dw_pcie *pci);
> >  void dw_pcie_iatu_detect(struct dw_pcie *pci);
> > --
> > 2.47.0
> >

