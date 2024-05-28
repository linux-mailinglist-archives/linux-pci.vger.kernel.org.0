Return-Path: <linux-pci+bounces-7943-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F25748D2558
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 22:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28BC5B27990
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 19:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A1831A60;
	Tue, 28 May 2024 19:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOQBOr2r"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7F017798C
	for <linux-pci@vger.kernel.org>; Tue, 28 May 2024 19:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716926143; cv=none; b=WnubrFK9Wr/oFUKnT776H4sueQEmWOnxqCLnVL9xpjkB/3QYHaEH5o8Ks2XHVraUzlcSclr7jJsYuvh+omDp3g5wxk6qO3RjuiPwQyiyOfiuPLB9h6hlDH57IuXEga24kFCgX3r09hngzot0DD1wfFDNH1CDz6IFRPPji4HjTX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716926143; c=relaxed/simple;
	bh=18yW8PStQ2AHZ1VMXE4Z8x2DL+8KVR+3nAgq6rkN8hY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FAdThnblj/ScwXTV5Nm5mdnlPCyXoSvO2jOrVznjBLPOT6sp7GKrJ/eBNUE/Oa7HlmA+Il4+j1MRF8V2fIX6mTVRW8ousxDEAUomPtE4fNS/M0tx+EtRRdzUO3XlHHYl/5TF/1nrw2upK0pGe/JPqhCwUCBtfUSS/Xl4uNb2SgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOQBOr2r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77FFEC3277B;
	Tue, 28 May 2024 19:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716926142;
	bh=18yW8PStQ2AHZ1VMXE4Z8x2DL+8KVR+3nAgq6rkN8hY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EOQBOr2rX1uR1RYxWgG9J3iaTTbNOTnjCN613Gpk31aAIitKPUQZwLbVfER4Nv5Fi
	 dqY0kYjgoYDqpLc6YLAKZTwH8zGXCt02okHr6kEgeGVhJa5tu+b0j6+BKTyLOhe8k3
	 R/kFBbpFYwwXdmllHucwFaGQI1TFdqYWLkS4U9peC7JiOOwpyaFDc+fuwHf1KQ47us
	 CWtRdUqcaAfgxYxowfQyR6C706IKZlGnQKFWrp2nzk9Ev0zZzRAEkDS0yDwmuHZAIu
	 fywoxv7Y/Ab4jBfR0xfY0RmuRBABt35KKVSok6b3iLdnygnE18v7mnwNM3Dqmny3V9
	 H8sauTZaBlX4Q==
Date: Tue, 28 May 2024 14:55:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: dwc: ep: Add dw_pcie_ep_deinit_notify()
Message-ID: <20240528195539.GA458945@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlYt1DvhcK-ePwXU@ryzen.lan>

On Tue, May 28, 2024 at 09:17:40PM +0200, Niklas Cassel wrote:
> On Tue, May 28, 2024 at 10:55:34AM -0500, Bjorn Helgaas wrote:
> > On Tue, May 28, 2024 at 03:00:37PM +0200, Niklas Cassel wrote:
> > > Add a DWC specific wrapper function (dw_pcie_ep_deinit_notify()) around
> > > pci_epc_deinit_notify(), similar to how we have a wrapper function
> > > (dw_pcie_ep_init_notify()) around pci_epc_init_notify().
> > > 
> > > This will allow the DWC glue drivers to use the same API layer for init
> > > and deinit notification.
> > > 
> > > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-designware-ep.c | 13 +++++++++++++
> > >  drivers/pci/controller/dwc/pcie-designware.h    |  5 +++++
> > >  2 files changed, 18 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > index 2063cf2049e5..3c9079651dff 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > @@ -39,6 +39,19 @@ void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
> > >  }
> > >  EXPORT_SYMBOL_GPL(dw_pcie_ep_init_notify);
> > >  
> > > +/**
> > > + * dw_pcie_ep_deinit_notify - Notify EPF drivers about EPC deinitialization
> > > + *			      complete
> > > + * @ep: DWC EP device
> > > + */
> > > +void dw_pcie_ep_deinit_notify(struct dw_pcie_ep *ep)
> > > +{
> > > +	struct pci_epc *epc = ep->epc;
> > > +
> > > +	pci_epc_deinit_notify(epc);
> > > +}
> > > +EXPORT_SYMBOL_GPL(dw_pcie_ep_deinit_notify);
> > 
> > What is the value of this wrapper?  
> > 
> > I see that dw_pcie_ep_deinit_notify() would be parallel to
> > dw_pcie_ep_init_notify() and dw_pcie_ep_linkup(), but none of these
> > has any DWC-specific content other than the fact that
> > pcie-designware.h provides stubs for the non-CONFIG_PCIE_DW_EP case.
> 
> Exactly what you are saying, consistency with the existing design.
> 
> To me, it seems a bit weird to use:
> dw_pcie_ep_init_notify() to notify init completion, and then to use
> pci_epc_deinit_notify() to notify deinit completion.
> 
> deinit notify callback should basically undo what the init notify callback
> did, so it would make sense that the naming of the API calls are similar.
> 
> > What if we added stubs to pci-epc.h pci_epc_init_notify(),
> > pci_epc_deinit_notify(), pci_epc_linkup(), and pci_epc_linkdown() for
> > the non-CONFIG_PCI_ENDPOINT case instead?  Then we might be able to
> > drop all these DWC-specific wrappers.
> 
> The PCI endpoint subsystem currently does not provide any stubs at all,
> so that would be a bigger change compared to this small patch.
> (And considering that the pci/endpoint branch does not build, I opted
> for the smaller patch.)

> Your suggestion would of course work as well, but if we go that route,
> then we should probably add stubs for all functions in both
> include/linux/pci-epc.h and include/linux/pci-epf.h.
> As long as the DWC glue drivers use the same "API layer" for init and
> deinit notification, I'm happy :)

The cadence, rcar, and rockchip drivers use pci_epc_init_notify() with
no wrapper.

A bunch of DWC-based drivers (artpec6, dra7xx, imx6, keembay, ks, ls,
qcom, rcar_gen4, etc) use the dw_pcie_ep_init_notify() wrapper.

ls and qcom even use *both*: pci_epc_linkdown() but
dw_pcie_ep_linkup().

Personally I would drop the dw_*() wrappers.  It's a bigger patch but
not any more complicated, and the result is consistency across both
DWC and the non-DWC drivers.

I don't know if we need to add stubs for *all* the functions.  I'd
probably defer that until we trip over them.

Bjorn

