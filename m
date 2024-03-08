Return-Path: <linux-pci+bounces-4647-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85104876064
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 09:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 086081F24525
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 08:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8076553376;
	Fri,  8 Mar 2024 08:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkUnjNkP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE1952F8F;
	Fri,  8 Mar 2024 08:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709888204; cv=none; b=lU+2X2InWneGYzKsWCO9E4lHLH7RRcVdOUen6wMujmui+NGQ8nooUbcbi04LYSXU/ni9skWMbjhrbW3qLpXpQ5poNVQAdKyoOxSG6Ct31wPJgZjw0GEthncvrxt00i/l6siGkceRRrGwUnB0u4zJfat+nVGpoJnda83uDzlrSWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709888204; c=relaxed/simple;
	bh=J4bX5OiJi6RfDlV1yRXpVjfgTtrgKXI42Kvd2JlHSRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jjg3L1rJ41QaSeMOukU87W3j9kAD+dz8/yZLzEhna38qj7zETEzKqFD2zSS0pm48pS8qcwjPFoJbw8VqnD4KBJlUeFEbpLXxtAV7tiG/IWLvgUQcV38qhBvhyCwz3G2auFTl1Ew1YdcLRDotUCj2+r5muPKWA6uAn1f6CLiYHU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkUnjNkP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ECFDC433C7;
	Fri,  8 Mar 2024 08:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709888203;
	bh=J4bX5OiJi6RfDlV1yRXpVjfgTtrgKXI42Kvd2JlHSRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nkUnjNkPxbAeCR9BEcZdVU5y2Y2jG5YUv4q2H1r7SjG3mghGjn+XC9AN7gH6FqaA7
	 TIAOCsfx1ycqbxcnRTnfsSFxLWsXqAq3Mh2UWACRb9SmQujBgQM2XjEYLLIM7uzUUu
	 NA8AsN5qkpkjhRG4JAJqADVEkImK0SGtiNgc6ymi8oV9FMfWltBvpVlEhm+O+tp3ys
	 ZmyrIghXMDm8hYekfaLefzniEYfpgD/P1hj/8pRZCNrJA0GIUpI9EkgQVDl6Bkfe/s
	 9h+0jBN8Jr0tx2Hk2jMbBMZWvENSJaqH8f6E2psy1h3zw84eC14i08yXHyJt4BysAL
	 /2bp3BQQ30dEw==
Date: Fri, 8 Mar 2024 09:56:33 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@axis.com
Subject: Re: [PATCH v9 08/10] PCI: dwc: ep: Add a generic
 dw_pcie_ep_linkdown() API to handle LINK_DOWN event
Message-ID: <ZerSwdxAnN2mUxf0@ryzen>
References: <20240304-pci-dbi-rework-v9-0-29d433d99cda@linaro.org>
 <20240304-pci-dbi-rework-v9-8-29d433d99cda@linaro.org>
 <Zeo0996FscpDSnjL@ryzen>
 <20240308054152.GD3789@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308054152.GD3789@thinkpad>

On Fri, Mar 08, 2024 at 11:11:52AM +0530, Manivannan Sadhasivam wrote:
> On Thu, Mar 07, 2024 at 10:43:19PM +0100, Niklas Cassel wrote:
> > On Mon, Mar 04, 2024 at 02:52:20PM +0530, Manivannan Sadhasivam wrote:
> > > The PCIe link can go to LINK_DOWN state in one of the following scenarios:
> > > 
> > > 1. Fundamental (PERST#)/hot/warm reset
> > > 2. Link transition from L2/L3 to L0
> > > 
> > > In those cases, LINK_DOWN causes some non-sticky DWC registers to loose the
> > > state (like REBAR, PTM_CAP etc...). So the drivers need to reinitialize
> > > them to function properly once the link comes back again.
> > > 
> > > This is not a problem for drivers supporting PERST# IRQ, since they can
> > > reinitialize the registers in the PERST# IRQ callback. But for the drivers
> > > not supporting PERST#, there is no way they can reinitialize the registers
> > > other than relying on LINK_DOWN IRQ received when the link goes down. So
> > > let's add a DWC generic API dw_pcie_ep_linkdown() that reinitializes the
> > > non-sticky registers and also notifies the EPF drivers about link going
> > > down.
> > > 
> > > This API can also be used by the drivers supporting PERST# to handle the
> > > scenario (2) mentioned above.
> > > 
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-designware-ep.c | 111 ++++++++++++++----------
> > >  drivers/pci/controller/dwc/pcie-designware.h    |   5 ++
> > >  2 files changed, 72 insertions(+), 44 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > index 278bdc9b2269..fed4c2936c78 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > @@ -14,14 +14,6 @@
> > >  #include <linux/pci-epc.h>
> > >  #include <linux/pci-epf.h>
> > >  
> > > -void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
> > > -{
> > > -	struct pci_epc *epc = ep->epc;
> > > -
> > > -	pci_epc_linkup(epc);
> > > -}
> > > -EXPORT_SYMBOL_GPL(dw_pcie_ep_linkup);
> > > -
> > >  void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
> > >  {
> > >  	struct pci_epc *epc = ep->epc;
> > > @@ -603,19 +595,56 @@ static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
> > >  	return 0;
> > >  }
> > >  
> > > +static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
> > > +{
> > > +	unsigned int offset, ptm_cap_base;
> > > +	unsigned int nbars;
> > > +	u32 reg, i;
> > > +
> > > +	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
> > > +	ptm_cap_base = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_PTM);
> > > +
> > > +	dw_pcie_dbi_ro_wr_en(pci);
> > > +
> > > +	if (offset) {
> > > +		reg = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
> > > +		nbars = (reg & PCI_REBAR_CTRL_NBAR_MASK) >>
> > > +			PCI_REBAR_CTRL_NBAR_SHIFT;
> > > +
> > > +		for (i = 0; i < nbars; i++, offset += PCI_REBAR_CTRL)
> > > +			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, 0x0);
> > 
> > If you look at PCI_REBAR_CAP, you will see that it is sticky,
> > but you have to actually read the databook to see that:
> > 
> > "The RESBAR_CTRL_REG_BAR_SIZE field is automatically updated
> > when you write to RESBAR_CAP_REG_0_REG through the DBI."
> > 
> > So the reason why we need to write this register, even though
> > it is sticky, is to update the RESBAR_CTRL_REG_BAR_SIZE register,
> > which is not sticky :)
> > 
> > (Perhaps we should add that as a comment?)
> > 
> 
> Yeah, makes sense.

Note that I add a (unrelated) comment related to REBAR_CAP in this patch:
https://lore.kernel.org/linux-pci/20240307111520.3303774-1-cassel@kernel.org/T/#u

But once we move/add code to dw_pcie_ep_init_non_sticky_registers(), I think
that it might be a good "rule" to have a small comment for each write in
dw_pcie_ep_init_non_sticky_registers() which explains why the code should be
in dw_pcie_ep_init_non_sticky_registers() instead of dw_pcie_ep_init_registers(),
even if it just a small:

/* Field PCI_XXX_YYY.ZZZ is non-sticky */
writel_dbi(pci, offset + PCI_XXX_YYY, 0);


Kind regards,
Niklas

