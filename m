Return-Path: <linux-pci+bounces-4654-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A56FF8761B1
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 11:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C979F1C217FB
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 10:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F4953E36;
	Fri,  8 Mar 2024 10:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azDcURbX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB31E53E06;
	Fri,  8 Mar 2024 10:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709892904; cv=none; b=qIwwLUM/gJmj9CmG+gZKaEshLJMn4bNHdlGrfW8k25U5rDo+FCZnqt9iA16eSt3yOAeneDTZ45ou17OPs0NlKAfN74VpHD1fmFWRc4P/Bjk+pUyh3JFgZgtvBDpAqrEBlQpw/2pJGYZodEzfjXt5j37uKMlWXzK2Z1K3MmjVWXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709892904; c=relaxed/simple;
	bh=RUpDGa9Rs6fU9BfFMEQzpLXZ5dNRS4tLDMMkYMlz10A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSeoERtHMgxgk+6T3vCbV1tCemrzOGkG2jyUPunhBoK01hpQifgg8a85BF2k4BvInK+h/Q6FOnsIXsoLsR07P083chhm7W0yjbmHrHuABX9f75CkGwYoJ4GpclFpMYFciFuqZByogEHdaV3RVDWnI2hVW5wxj/BJzjDabPE/7kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azDcURbX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A22C43390;
	Fri,  8 Mar 2024 10:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709892902;
	bh=RUpDGa9Rs6fU9BfFMEQzpLXZ5dNRS4tLDMMkYMlz10A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=azDcURbX6wPyiSgOborkCmRq1aJLfraoxkXDDCyOkkcYhnoXZDktTO4rQSTj2dLBe
	 dJyVsKXRTCz/lpY0R/pg0Fna7y6mJQ0sOZ/8erlJ8i5bkRb1ZbKoYhUYoXRYYRzCl5
	 JWTjw0y7oj3egZys2daT0GDqqSaE5qK64Ov8Eq5yheZKKxT/smpklskIw2FAfVizd4
	 o00HzVVqduydu9paV8JKrl3GeFrsMPItPrGb/q2mSQ4JWv3c6VDOF0FYOVdqrpIyG7
	 8eCvrYxjUo+UqIYvKsfO3jC1szqnpt5hr0wSLCamo2pzzw+pERPuYfsU/vF372xN6V
	 f1AC8A3XsX6nA==
Date: Fri, 8 Mar 2024 11:14:51 +0100
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
Message-ID: <ZerlG5W-hUFIYY8b@ryzen>
References: <20240304-pci-dbi-rework-v9-0-29d433d99cda@linaro.org>
 <20240304-pci-dbi-rework-v9-8-29d433d99cda@linaro.org>
 <Zeo0996FscpDSnjL@ryzen>
 <20240308054152.GD3789@thinkpad>
 <ZerSwdxAnN2mUxf0@ryzen>
 <20240308094606.GG3789@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308094606.GG3789@thinkpad>

On Fri, Mar 08, 2024 at 03:16:06PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Mar 08, 2024 at 09:56:33AM +0100, Niklas Cassel wrote:
> > On Fri, Mar 08, 2024 at 11:11:52AM +0530, Manivannan Sadhasivam wrote:
> > > On Thu, Mar 07, 2024 at 10:43:19PM +0100, Niklas Cassel wrote:
> > > > On Mon, Mar 04, 2024 at 02:52:20PM +0530, Manivannan Sadhasivam wrote:
> > > > > The PCIe link can go to LINK_DOWN state in one of the following scenarios:
> > > > > 
> > > > > 1. Fundamental (PERST#)/hot/warm reset
> > > > > 2. Link transition from L2/L3 to L0
> > > > > 
> > > > > In those cases, LINK_DOWN causes some non-sticky DWC registers to loose the
> > > > > state (like REBAR, PTM_CAP etc...). So the drivers need to reinitialize
> > > > > them to function properly once the link comes back again.
> > > > > 
> > > > > This is not a problem for drivers supporting PERST# IRQ, since they can
> > > > > reinitialize the registers in the PERST# IRQ callback. But for the drivers
> > > > > not supporting PERST#, there is no way they can reinitialize the registers
> > > > > other than relying on LINK_DOWN IRQ received when the link goes down. So
> > > > > let's add a DWC generic API dw_pcie_ep_linkdown() that reinitializes the
> > > > > non-sticky registers and also notifies the EPF drivers about link going
> > > > > down.
> > > > > 
> > > > > This API can also be used by the drivers supporting PERST# to handle the
> > > > > scenario (2) mentioned above.
> > > > > 
> > > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > > ---
> > > > >  drivers/pci/controller/dwc/pcie-designware-ep.c | 111 ++++++++++++++----------
> > > > >  drivers/pci/controller/dwc/pcie-designware.h    |   5 ++
> > > > >  2 files changed, 72 insertions(+), 44 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > > index 278bdc9b2269..fed4c2936c78 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > > @@ -14,14 +14,6 @@
> > > > >  #include <linux/pci-epc.h>
> > > > >  #include <linux/pci-epf.h>
> > > > >  
> > > > > -void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
> > > > > -{
> > > > > -	struct pci_epc *epc = ep->epc;
> > > > > -
> > > > > -	pci_epc_linkup(epc);
> > > > > -}
> > > > > -EXPORT_SYMBOL_GPL(dw_pcie_ep_linkup);
> > > > > -
> > > > >  void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
> > > > >  {
> > > > >  	struct pci_epc *epc = ep->epc;
> > > > > @@ -603,19 +595,56 @@ static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
> > > > >  	return 0;
> > > > >  }
> > > > >  
> > > > > +static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
> > > > > +{
> > > > > +	unsigned int offset, ptm_cap_base;
> > > > > +	unsigned int nbars;
> > > > > +	u32 reg, i;
> > > > > +
> > > > > +	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
> > > > > +	ptm_cap_base = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_PTM);
> > > > > +
> > > > > +	dw_pcie_dbi_ro_wr_en(pci);
> > > > > +
> > > > > +	if (offset) {
> > > > > +		reg = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
> > > > > +		nbars = (reg & PCI_REBAR_CTRL_NBAR_MASK) >>
> > > > > +			PCI_REBAR_CTRL_NBAR_SHIFT;
> > > > > +
> > > > > +		for (i = 0; i < nbars; i++, offset += PCI_REBAR_CTRL)
> > > > > +			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, 0x0);
> > > > 
> > > > If you look at PCI_REBAR_CAP, you will see that it is sticky,
> > > > but you have to actually read the databook to see that:
> > > > 
> > > > "The RESBAR_CTRL_REG_BAR_SIZE field is automatically updated
> > > > when you write to RESBAR_CAP_REG_0_REG through the DBI."
> > > > 
> > > > So the reason why we need to write this register, even though
> > > > it is sticky, is to update the RESBAR_CTRL_REG_BAR_SIZE register,
> > > > which is not sticky :)
> > > > 
> > > > (Perhaps we should add that as a comment?)
> > > > 
> > > 
> > > Yeah, makes sense.
> > 
> > Note that I add a (unrelated) comment related to REBAR_CAP in this patch:
> > https://lore.kernel.org/linux-pci/20240307111520.3303774-1-cassel@kernel.org/T/#u
> > 
> > But once we move/add code to dw_pcie_ep_init_non_sticky_registers(), I think
> > that it might be a good "rule" to have a small comment for each write in
> > dw_pcie_ep_init_non_sticky_registers() which explains why the code should be
> > in dw_pcie_ep_init_non_sticky_registers() instead of dw_pcie_ep_init_registers(),
> > even if it just a small:
> > 
> > /* Field PCI_XXX_YYY.ZZZ is non-sticky */
> > writel_dbi(pci, offset + PCI_XXX_YYY, 0);
> > 
> 
> Why? The function name itself suggests that we are reinitializing non-sticky
> registers. So a comment for each write is overkill.

So that you know which field it is in the register that you are writing which
you care about (which field it is that is non-sticky).

But I see your point, perhaps it is overkill.


Kind regards,
Niklas

