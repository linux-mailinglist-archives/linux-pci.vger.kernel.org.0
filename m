Return-Path: <linux-pci+bounces-10175-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD45E92EF20
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 20:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8283B1F236FE
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 18:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1599316EB55;
	Thu, 11 Jul 2024 18:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZygdmSj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9F816EB47;
	Thu, 11 Jul 2024 18:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720723725; cv=none; b=OegOGU06SvUvw0iIWp2M5WFYKelI35Zezklam36Bmvyt6SWLhOppke6e6U4SAyEslqiM93imGAhTusryKxcxnixwTHavGjdSnqbJcde/ltaOKVBXLfrbiEed8BS8Df7ul6KgtU5rMEGoKcjyu+ZF5uTUr/siFzNCMA8u7qopNCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720723725; c=relaxed/simple;
	bh=xImh/e9JhSxNtzbEgiJpo+w6gMpGyqEXopSKCcJ76JE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oSBnDCjDtyEc1giFbc4oNF8ox+s8aLQVF8i9xzmzVibSNrfxGk9TG7Purwyl2f4nvYfBNvl/PI0mEWR4wjQ8Z56ufxW936bOIfQ049/baHOwKWkFNyiSw4QYlsYtMoihRJZTATJiBiZ7fxFXSMWNTaAjiqCYNPn5ie0cSSiwwks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZygdmSj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C3AC116B1;
	Thu, 11 Jul 2024 18:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720723724;
	bh=xImh/e9JhSxNtzbEgiJpo+w6gMpGyqEXopSKCcJ76JE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=LZygdmSjEBpl4BTzHjE4t6PNNOmKPMRI7FZ/b1BLxrLEXxaj8fb4aIjEFQNjxcYoz
	 PS6pWF6WsLll9Lm97lHZxJUp5EMg0QhRasnMH++9lIhSWQE9EiYRulC6i3E29wKIJm
	 EgQ/e6l6JHagNIE9p2YTnS0RKbuxF0+SYDd6fwSoYifX5W4kL91Xywnx3dSdzIBr/2
	 iYuBu5xUHRJteBQbjTGqISKKM2NpN7GsRB0WzDkoa5ecwVxOIrpxaaLvuz8nK5cImL
	 K8rELPM3xoktpef/j0j0HJ8Cu7qBURte99paPdTDbtyH1qAe4CDpYNTgJ8WwUF+KxO
	 0gLOhoseGdpMg==
Date: Thu, 11 Jul 2024 13:48:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
	quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
	quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
	quic_parass@quicinc.com, Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v7 2/4] PCI: qcom-ep: Add support for D-state change
 notification
Message-ID: <20240711184842.GA285502@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a56de2dc-30a0-a292-c03c-16ec5393eea8@quicinc.com>

On Thu, Jul 11, 2024 at 11:57:35AM +0530, Krishna Chaitanya Chundru wrote:
> On 7/10/2024 5:41 PM, Bjorn Helgaas wrote:
> > On Wed, Jul 10, 2024 at 04:38:15PM +0530, Krishna chaitanya chundru wrote:
> > > Add support to pass D-state change notification to Endpoint
> > > function driver.
> ...

> > I don't understand the connection between PERST# state and the device
> > D state.  D3cold is defined to mean main power is absent.  Is the
> > endpoint firmware still running when main power is absent?
>
> Host as part of its d3cold sequence will assert the perst. so we are
> reading perst to know the link the state.

I think it's true that when the device is in D3cold, PERST# will be
asserted (PCIe CEM r5.0, sec 2.2.3, fig 2-6).

But I don't think it's necessarily true that when PERST# is asserted,
the device is in D3cold.  For example, PCIe Mini CEM r2.1, sec
3.2.5.3, says "The system may also use PERST# to cause a warm reset of
the add-in card."  In a warm reset, the component remains powered up,
i.e., it is not in D3cold (PCIe r6.0, sec 6.6.1).

I would think the endpoint firmware would be able to directly read the
state of main power or the LTSSM state of the link, without having to
use PERST# to infer it.

I guess the ultimate point of figuring out D3hot vs D3cold is to
figure out whether to use PME or WAKE#?  I'm a little bit dubious
about that being racy, as I mentioned elsewhere.  If there were a way
to attempt PME and fall back to WAKE# if you can determine that PME
failed, maybe that would be safer and obviate the need for the D-state
tracking?

> Qcom devices are drawing power from the PCIe, so even when PCIe is in
> D3cold endpoint firmware can still run.
> 
> - Krishna Chaitanya.
> > > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> > > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > > ---
> > >   drivers/pci/controller/dwc/pcie-qcom-ep.c | 8 +++++++-
> > >   1 file changed, 7 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > > index 236229f66c80..817fad805c51 100644
> > > --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > > +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > > @@ -648,6 +648,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
> > >   	struct device *dev = pci->dev;
> > >   	u32 status = readl_relaxed(pcie_ep->parf + PARF_INT_ALL_STATUS);
> > >   	u32 mask = readl_relaxed(pcie_ep->parf + PARF_INT_ALL_MASK);
> > > +	pci_power_t state;
> > >   	u32 dstate, val;
> > >   	writel_relaxed(status, pcie_ep->parf + PARF_INT_ALL_CLEAR);
> > > @@ -671,11 +672,16 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
> > >   		dstate = dw_pcie_readl_dbi(pci, DBI_CON_STATUS) &
> > >   					   DBI_CON_STATUS_POWER_STATE_MASK;
> > >   		dev_dbg(dev, "Received D%d state event\n", dstate);
> > > -		if (dstate == 3) {
> > > +		state = dstate;
> > > +		if (dstate == PCI_D3hot) {
> > >   			val = readl_relaxed(pcie_ep->parf + PARF_PM_CTRL);
> > >   			val |= PARF_PM_CTRL_REQ_EXIT_L1;
> > >   			writel_relaxed(val, pcie_ep->parf + PARF_PM_CTRL);
> > > +
> > > +			if (gpiod_get_value(pcie_ep->reset))
> > > +				state = PCI_D3cold;
> > >   		}
> > > +		pci_epc_dstate_notify(pci->ep.epc, state);
> > >   	} else if (FIELD_GET(PARF_INT_ALL_LINK_UP, status)) {
> > >   		dev_dbg(dev, "Received Linkup event. Enumeration complete!\n");
> > >   		dw_pcie_ep_linkup(&pci->ep);
> > > 
> > > -- 
> > > 2.42.0
> > > 

