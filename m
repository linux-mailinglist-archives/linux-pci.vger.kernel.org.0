Return-Path: <linux-pci+bounces-7928-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF78B8D247D
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 21:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F07EF1C2700D
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 19:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5026DD0D;
	Tue, 28 May 2024 19:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQ4KGqCF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D0F172BAD
	for <linux-pci@vger.kernel.org>; Tue, 28 May 2024 19:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716923865; cv=none; b=I72213VRw29ZKYvg70l9FXUVwhuETqKGDO553aQwauS6TJtR11OnpgXkkZl78WJm1sOwQNLPJp0GyjB1dZ5Ea3cRu4T3gwO58gqPn+CeAvc1nXxK050HZoYqbfxeYVPUDYWi2SVSRXJJwfZgGVi2IvAUJ8vWjx60nUMLLh4D5Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716923865; c=relaxed/simple;
	bh=YO3qy8qtbKjyfELilJE826Wdv7bqgbTHF+umCLuBpJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WW3jfzotzwyBQKgm43s67Q/usFqwQ3Yd3TPOhJoB7EFVGFGyA3e0c2pTTw2sGpaMl+PYx5proDpRgpDvAj6yXdj9Em+qHixCfShY/K+Sc5hvFz9wn/JyHmtDDoj9P1X9/XVXb9MXaCXPj0KTYt3NYi2DbPOt/wP5W8KhS9/+l48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQ4KGqCF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BA3C3277B;
	Tue, 28 May 2024 19:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716923865;
	bh=YO3qy8qtbKjyfELilJE826Wdv7bqgbTHF+umCLuBpJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eQ4KGqCFk+uaGCSUUV9xLPN8ZZLoj7wzNdsJmr7smtaeXBr/XkcJjsA3B6SnZ+2Fk
	 A0m/rACT78kmjmQH8C6U+ECQooMzqf+AsHhipGjjkvQtDaRznNflXL/LN5WCptpQXW
	 RBV0KSy/5MRyqvhaWBducrzFAjKw460SnlhpuwynweG9zXtiPG9y/MlSfOdCU4BuEx
	 fsKmRTStxjWxnh2kO8QuEgJItTbGq9eQzi9OIYPObPKSdy3H6PW1UVf0P2bzGThrD0
	 kuiCg5OdLJdA2Kixd9knTmfn/vGnWMXuX3IWKD3uEWo8gtsb+EsdXmtFifFdmDPDBr
	 j5zk5yXUfdpnw==
Date: Tue, 28 May 2024 21:17:40 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: dwc: ep: Add dw_pcie_ep_deinit_notify()
Message-ID: <ZlYt1DvhcK-ePwXU@ryzen.lan>
References: <20240528130035.1472871-6-cassel@kernel.org>
 <20240528155534.GA312623@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528155534.GA312623@bhelgaas>

On Tue, May 28, 2024 at 10:55:34AM -0500, Bjorn Helgaas wrote:
> On Tue, May 28, 2024 at 03:00:37PM +0200, Niklas Cassel wrote:
> > Add a DWC specific wrapper function (dw_pcie_ep_deinit_notify()) around
> > pci_epc_deinit_notify(), similar to how we have a wrapper function
> > (dw_pcie_ep_init_notify()) around pci_epc_init_notify().
> > 
> > This will allow the DWC glue drivers to use the same API layer for init
> > and deinit notification.
> > 
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware-ep.c | 13 +++++++++++++
> >  drivers/pci/controller/dwc/pcie-designware.h    |  5 +++++
> >  2 files changed, 18 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index 2063cf2049e5..3c9079651dff 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -39,6 +39,19 @@ void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
> >  }
> >  EXPORT_SYMBOL_GPL(dw_pcie_ep_init_notify);
> >  
> > +/**
> > + * dw_pcie_ep_deinit_notify - Notify EPF drivers about EPC deinitialization
> > + *			      complete
> > + * @ep: DWC EP device
> > + */
> > +void dw_pcie_ep_deinit_notify(struct dw_pcie_ep *ep)
> > +{
> > +	struct pci_epc *epc = ep->epc;
> > +
> > +	pci_epc_deinit_notify(epc);
> > +}
> > +EXPORT_SYMBOL_GPL(dw_pcie_ep_deinit_notify);
> 
> What is the value of this wrapper?  
> 
> I see that dw_pcie_ep_deinit_notify() would be parallel to
> dw_pcie_ep_init_notify() and dw_pcie_ep_linkup(), but none of these
> has any DWC-specific content other than the fact that
> pcie-designware.h provides stubs for the non-CONFIG_PCIE_DW_EP case.

Exactly what you are saying, consistency with the existing design.

To me, it seems a bit weird to use:
dw_pcie_ep_init_notify() to notify init completion, and then to use
pci_epc_deinit_notify() to notify deinit completion.

deinit notify callback should basically undo what the init notify callback
did, so it would make sense that the naming of the API calls are similar.


> 
> What if we added stubs to pci-epc.h pci_epc_init_notify(),
> pci_epc_deinit_notify(), pci_epc_linkup(), and pci_epc_linkdown() for
> the non-CONFIG_PCI_ENDPOINT case instead?  Then we might be able to
> drop all these DWC-specific wrappers.

The PCI endpoint subsystem currently does not provide any stubs at all,
so that would be a bigger change compared to this small patch.
(And considering that the pci/endpoint branch does not build, I opted
for the smaller patch.)

Your suggestion would of course work as well, but if we go that route,
then we should probably add stubs for all functions in both
include/linux/pci-epc.h and include/linux/pci-epf.h.
As long as the DWC glue drivers use the same "API layer" for init and
deinit notification, I'm happy :)


Kind regards,
Niklas

