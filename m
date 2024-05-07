Return-Path: <linux-pci+bounces-7205-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2908BF33F
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 02:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DFBDB26DA2
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 00:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0AC137917;
	Tue,  7 May 2024 23:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSeM+TyS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51624137914;
	Tue,  7 May 2024 23:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715125842; cv=none; b=g+Kfr9znZ9PouKSIU79aNrTt11YiHx2qGUUBiR22JjjX8Zl3QRnobXobxWZePuo+B/lUATtiPRkxvi4LNBUmkQFeoWgP4a0C3m4cS7RQfP8UdIfv97OfrDDC7kx3rVNEH91OQ0DXG1vY/AW8KJoHqmgkSamuJR0RGddUSDhLJXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715125842; c=relaxed/simple;
	bh=oG7+0ZCyZm24Lqt8LWQpHI92xG7urlM0akIn+VMXPEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6J8vBILrL54aF3OQrsoXJLygzRAuBt5P7mfMGDOpq2oOxLGLOrQsAFgFQbt+vQx5msoM68fduXQ0PQBGn8x7KgSFd2J88JbmBit+v+yey1cVrDXSVg+jNrLmByjGWD9QLh7LzMAufm5mNF1nttJcekDk0X8yQGTiVPDDSALSsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSeM+TyS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07153C2BBFC;
	Tue,  7 May 2024 23:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715125841;
	bh=oG7+0ZCyZm24Lqt8LWQpHI92xG7urlM0akIn+VMXPEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JSeM+TySV6hF608wKKSwUeB3CiXAzppecrkHJooIvet3CSpKc6VfMebrbG27Amy8j
	 xBSM4URRIQacNojT7UQZP+iYTg+EWya0Fx5sFl1AF70hVY7SAmnmv9BQj5hQ0ITlJ6
	 1slaSamvOisX9Ql9IF9AE28myRxb71lS556Ic7C8n2kyDDXfipZ95AqVFAz5p6PjuB
	 BY3yALk7z6DAwluPLuCfvLE247kPI4a8e7Sn2KWzprXO/b6lIbTfln/D5/5RqN5kJw
	 gKtEOf/EHdWpLhr1EyZZcUfmfBiaxGcomQax0+zentkPlOZXVKLoHCXm8/8XpTjIeQ
	 gOPLCnCedWPqQ==
Date: Wed, 8 May 2024 01:50:35 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Damien Le Moal <dlemoal@kernel.org>,
	Jon Lin <jon.lin@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 11/14] PCI: dw-rockchip: Add endpoint mode support
Message-ID: <Zjq-SxFxHtXChgXe@ryzen.lan>
References: <20240430-rockchip-pcie-ep-v1-v2-0-a0f5ee2a77b6@kernel.org>
 <20240430-rockchip-pcie-ep-v1-v2-11-a0f5ee2a77b6@kernel.org>
 <20240504173201.GH4315@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240504173201.GH4315@thinkpad>

Hello Mani,

On Sat, May 04, 2024 at 11:02:01PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Apr 30, 2024 at 02:01:08PM +0200, Niklas Cassel wrote:
> > The PCIe controller in rk3568 and rk3588 can operate in endpoint mode.
> > This endpoint mode support heavily leverages the existing code in
> > pcie-designware-ep.c.
> > 
> > Add support for endpoint mode to the existing pcie-dw-rockchip glue
> > driver.
> > 
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> >  drivers/pci/controller/dwc/Kconfig            |  17 ++-
> >  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 177 ++++++++++++++++++++++++++
> >  2 files changed, 191 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > index 8afacc90c63b..9fae0d977271 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -311,16 +311,27 @@ config PCIE_RCAR_GEN4_EP
> >  	  SoCs. To compile this driver as a module, choose M here: the module
> >  	  will be called pcie-rcar-gen4.ko. This uses the DesignWare core.
> >  
> > +config PCIE_ROCKCHIP_DW
> > +	bool
> > +
> >  config PCIE_ROCKCHIP_DW_HOST
> > -	bool "Rockchip DesignWare PCIe controller"
> > -	select PCIE_DW
> > +	bool "Rockchip DesignWare PCIe controller (host mode)"
> >  	select PCIE_DW_HOST
> >  	depends on PCI_MSI
> >  	depends on ARCH_ROCKCHIP || COMPILE_TEST
> >  	depends on OF
> >  	help
> >  	  Enables support for the DesignWare PCIe controller in the
> > -	  Rockchip SoC except RK3399.
> > +	  Rockchip SoC (except RK3399) to work in host mode.
> 
> Just curious. RK3399 is an exception because lack of driver support or it
> doesn't support EP mode at all?

RK3399 is an exception because it uses a non-DWC PCIe controller.
RK3399 has support for both RC and EP mode, see:
CONFIG_PCIE_ROCKCHIP_HOST
drivers/pci/controller/pcie-rockchip.c
and
CONFIG_PCIE_ROCKCHIP_EP
drivers/pci/controller/pcie-rockchip-ep.c


> 
> > +
> > +config PCIE_ROCKCHIP_DW_EP
> > +	bool "Rockchip DesignWare PCIe controller (endpoint mode)"
> > +	select PCIE_DW_EP
> > +	depends on ARCH_ROCKCHIP || COMPILE_TEST
> > +	depends on OF
> > +	help
> > +	  Enables support for the DesignWare PCIe controller in the
> > +	  Rockchip SoC (except RK3399) to work in endpoint mode.
> >  
> >  config PCI_EXYNOS
> >  	tristate "Samsung Exynos PCIe controller"
> > diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > index f38d267e4e64..7614c20c7112 100644
> > --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > @@ -34,10 +34,16 @@
> >  #define to_rockchip_pcie(x) dev_get_drvdata((x)->dev)
> >  
> >  #define PCIE_CLIENT_RC_MODE		HIWORD_UPDATE_BIT(0x40)
> > +#define PCIE_CLIENT_EP_MODE		HIWORD_UPDATE(0xf0, 0x0)
> >  #define PCIE_CLIENT_ENABLE_LTSSM	HIWORD_UPDATE_BIT(0xc)
> > +#define PCIE_CLIENT_DISABLE_LTSSM	HIWORD_UPDATE(0x0c, 0x8)
> > +#define PCIE_CLIENT_INTR_STATUS_MISC	0x10
> > +#define PCIE_CLIENT_INTR_MASK_MISC	0x24
> >  #define PCIE_SMLH_LINKUP		BIT(16)
> >  #define PCIE_RDLH_LINKUP		BIT(17)
> >  #define PCIE_LINKUP			(PCIE_SMLH_LINKUP | PCIE_RDLH_LINKUP)
> > +#define PCIE_RDLH_LINK_UP_CHGED		BIT(1)
> > +#define PCIE_LINK_REQ_RST_NOT_INT	BIT(2)
> >  #define PCIE_L0S_ENTRY			0x11
> >  #define PCIE_CLIENT_GENERAL_CONTROL	0x0
> >  #define PCIE_CLIENT_INTR_STATUS_LEGACY	0x8
> > @@ -159,6 +165,12 @@ static void rockchip_pcie_enable_ltssm(struct rockchip_pcie *rockchip)
> >  				 PCIE_CLIENT_GENERAL_CONTROL);
> >  }
> >  
> > +static void rockchip_pcie_disable_ltssm(struct rockchip_pcie *rockchip)
> > +{
> > +	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_DISABLE_LTSSM,
> > +				 PCIE_CLIENT_GENERAL_CONTROL);
> > +}
> > +
> >  static int rockchip_pcie_link_up(struct dw_pcie *pci)
> >  {
> >  	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
> > @@ -195,6 +207,13 @@ static int rockchip_pcie_start_link(struct dw_pcie *pci)
> >  	return 0;
> >  }
> >  
> > +static void rockchip_pcie_stop_link(struct dw_pcie *pci)
> > +{
> > +	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
> > +
> > +	rockchip_pcie_disable_ltssm(rockchip);
> > +}
> > +
> >  static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
> >  {
> >  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > @@ -220,6 +239,59 @@ static const struct dw_pcie_host_ops rockchip_pcie_host_ops = {
> >  	.init = rockchip_pcie_host_init,
> >  };
> >  
> > +static void rockchip_pcie_ep_init(struct dw_pcie_ep *ep)
> > +{
> > +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > +	enum pci_barno bar;
> > +
> > +	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
> > +		dw_pcie_ep_reset_bar(pci, bar);
> > +};
> > +
> > +static int rockchip_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> > +				   unsigned int type, u16 interrupt_num)
> > +{
> > +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > +
> > +	switch (type) {
> > +	case PCI_IRQ_INTX:
> > +		return dw_pcie_ep_raise_intx_irq(ep, func_no);
> > +	case PCI_IRQ_MSI:
> > +		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> > +	case PCI_IRQ_MSIX:
> > +		return dw_pcie_ep_raise_msix_irq(ep, func_no, interrupt_num);
> > +	default:
> > +		dev_err(pci->dev, "UNKNOWN IRQ type\n");
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct pci_epc_features rockchip_pcie_epc_features = {
> > +	.linkup_notifier = true,
> > +	.msi_capable = true,
> > +	.msix_capable = true,
> > +	.align = SZ_64K,
> > +	.bar[BAR_0] = { .type = BAR_FIXED, .fixed_size = SZ_1M, },
> > +	.bar[BAR_1] = { .type = BAR_FIXED, .fixed_size = SZ_1M, },
> > +	.bar[BAR_2] = { .type = BAR_FIXED, .fixed_size = SZ_1M, },
> > +	.bar[BAR_3] = { .type = BAR_FIXED, .fixed_size = SZ_1M, },
> > +	.bar[BAR_4] = { .type = BAR_RESERVED, },
> 
> You have documented the reason for this in cover letter. But it'd be good if you
> do the same in commit message also.

Will do!

It appears that rk3568 does not have ATU and DMA regs mapped to BAR4
(or any other BAR).

I will create a separate "static const struct pci_epc_features"
for rk3568.


> 
> > +	.bar[BAR_5] = { .type = BAR_FIXED, .fixed_size = SZ_1M, },
> > +};
> > +
> > +static const struct pci_epc_features *
> > +rockchip_pcie_get_features(struct dw_pcie_ep *ep)
> > +{
> > +	return &rockchip_pcie_epc_features;
> > +}
> > +
> > +static const struct dw_pcie_ep_ops rockchip_pcie_ep_ops = {
> > +	.init = rockchip_pcie_ep_init,
> > +	.raise_irq = rockchip_pcie_raise_irq,
> > +	.get_features = rockchip_pcie_get_features,
> > +};
> > +
> >  static int rockchip_pcie_clk_init(struct rockchip_pcie *rockchip)
> >  {
> >  	struct device *dev = rockchip->pci.dev;
> > @@ -284,8 +356,39 @@ static void rockchip_pcie_phy_deinit(struct rockchip_pcie *rockchip)
> >  static const struct dw_pcie_ops dw_pcie_ops = {
> >  	.link_up = rockchip_pcie_link_up,
> >  	.start_link = rockchip_pcie_start_link,
> > +	.stop_link = rockchip_pcie_stop_link,
> >  };
> >  
> > +static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
> > +{
> > +	struct rockchip_pcie *rockchip = arg;
> > +	struct dw_pcie *pci = &rockchip->pci;
> > +	struct device *dev = pci->dev;
> > +	u32 reg, val;
> > +
> > +	reg = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_STATUS_MISC);
> > +
> > +	dev_dbg(dev, "PCIE_CLIENT_INTR_STATUS_MISC: %#x\n", reg);
> > +	dev_dbg(dev, "LTSSM_STATUS: %#x\n", rockchip_pcie_ltssm(rockchip));
> > +
> > +	if (reg & PCIE_LINK_REQ_RST_NOT_INT) {
> > +		dev_dbg(dev, "hot reset or link-down reset\n");
> 
> 'hot reset' means the host doing a hot reset?

Hot reset means that LTSSM state machine is in state "Hot Reset".

I don't know all the reasons why the state machine can go to this state
by heart, but from the Databook:

"A Downstream Port (DSP) can hot reset an Upstream Port (USP) by sending
two consecutive TS1 ordered sets with the hot reset bit asserted"

"There is no difference in the handling of a link-down reset or a hot reset;
the controller asserts the link_req_rst_not output requesting the
DWC_pcie_clkrst.v module to reset the controller."



Kind regards,
Niklas

