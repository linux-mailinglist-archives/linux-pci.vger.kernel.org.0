Return-Path: <linux-pci+bounces-37073-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A35FBA23D4
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 04:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DA851C27FE9
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 02:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D4D262FD1;
	Fri, 26 Sep 2025 02:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eY6FtYva"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBAF262FC7;
	Fri, 26 Sep 2025 02:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758854674; cv=none; b=dq71W9SFeMvu2cnDEZVaSFpgHZGxJ8FUcb/DK1NU086quxO2r1zAuxKXSZTpzErMwzNp0F42C5eKsNlY/oCPP7+m1HPqklUb8Cg/rDfxuAhBYyECZfyD5ceqLbBevkMA91QGPk9/d2RRNIJ01CGe7lttwcBFAz5PdC/P/pfgdsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758854674; c=relaxed/simple;
	bh=WGgd9HbXf3muDxpRoOGtKDqq/H+jWq+KkhqeNuZt26k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oNwAWP4IvV6Dl2ZZ7yVl1xKtRYBLrZ7Ia3qX2+7Md2nl+piDsKvlTGtD8aQbbkqxO6ZikKasLjhwb1ppFu9x6Nbdc7AUkf1g9WA9QuHPm5I1mPRBqKGATEp29+RDNTqSrgH6tsUXwrTgT1HGZAYdtm0p0l3G8+zySHxAqviOknQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eY6FtYva; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CEC2C4CEF0;
	Fri, 26 Sep 2025 02:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758854672;
	bh=WGgd9HbXf3muDxpRoOGtKDqq/H+jWq+KkhqeNuZt26k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=eY6FtYvabCSorn6RAdJj1vjmjePcCz7dFiqVxMmcfJH4sgooxBzvUdNi1Q+eKdZ+b
	 OODafboTEd+3Lwtn6jvOGIUfjca2owH71ZvCcGLnEVSmd8BGHzPHBCoaEdrxyX3uku
	 wSP7OIKfNbXHMh+87f1Ml6x9vh4tuf8f5pJzoS/OKbT9tK0VozyKp+RwgEVt+F6N88
	 tHGSSGzfngiMMOnL5/OIQsIWQ82v4MkIhO6zRzvEYyQ7vqDfXo5MXzbl0SqAfMQJKw
	 BEvv3mKXe4qjZIbGBV94KMFy/TWBHkc9ARHEv5938VWDcwP1EnW0uKL6TC8E3ToEuO
	 heZBsyIpAt8ZA==
Date: Thu, 25 Sep 2025 21:44:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: Frank Li <frank.li@nxp.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] PCI: imx6: Add a method to handle CLKREQ#
 override active low
Message-ID: <20250926024430.GA2217977@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU2PR04MB884007655AC6BAF8AFD9AD198C1EA@DU2PR04MB8840.eurprd04.prod.outlook.com>

On Fri, Sep 26, 2025 at 02:19:37AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > On Tue, Sep 23, 2025 at 03:39:13PM +0800, Richard Zhu wrote:
> > > The CLKREQ# is an open drain, active low signal that is driven low by
> > > the card to request reference clock. It's an optional signal added in
> > > PCIe CEM r4.0, sec 2. Thus, this signal wouldn't be driven low if it's
> > > reserved.
> > >
> > > Since the reference clock controlled by CLKREQ# may be required by
> > > i.MX PCIe host too. To make sure this clock is ready even when the
> > > CLKREQ# isn't driven low by the card(e.x the scenario described
> > > above), force CLKREQ# override active low for i.MX PCIe host during
> > initialization.
> > >
> > > The CLKREQ# override can be cleared safely when supports-clkreq is
> > > present and PCIe link is up later. Because the CLKREQ# would be driven
> > > low by the card at this time.
> > 
> > What happens if we clear the CLKREQ# override (so the host doesn't assert
> > it), and the link is up but the card never asserts CLKREQ# (since it's an
> > optional signal)?
> > 
> > Does the i.MX host still work?
>
> The CLKREQ# override active low only be cleared when link is up and
>  supports-clkreq is present. In the other words, there is a remote endpoint
>  device, and the CLKREQ# would be driven active low by this endpoint device.

Assume an endpoint designed to CEM r2.0.  CLKREQ# doesn't exist in CEM
r2.0, so even if the endpoint is present and the link is up, the
endpoint will not assert CLKREQ#.

Will the i.MX host still work?

IIUC, CLKREQ# is required for ASPM L1 PM Substates.  Maybe the CLKREQ#
override should only be cleared if the endpoint advertises L1 PM
Substates support?

Sorry, I'm just really confused about this.  Here's another question:
Even if the endpoint is designed to CEM r4.0, it supports L1 PM
Substates, and it asserts CLKREQ#, my understanding is that the
endpoint won't assert CLKREQ# *all* the time.  For example, when the
link enters L1, the device deasserts CLKREQ# (CEM r5.0, sec 2.8.2).

What happens to the i.MX host when the endpoint isn't asserting
CLKREQ#?  I guess i.MX doesn't need refclk in that situation?

> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  drivers/pci/controller/dwc/pci-imx6.c | 43
> > > ++++++++++++++++++++++++++-
> > >  1 file changed, 42 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > > b/drivers/pci/controller/dwc/pci-imx6.c
> > > index 80e48746bbaf..6b03b1111d06 100644
> > > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > > @@ -52,6 +52,8 @@
> > >  #define IMX95_PCIE_REF_CLKEN			BIT(23)
> > >  #define IMX95_PCIE_PHY_CR_PARA_SEL		BIT(9)
> > >  #define IMX95_PCIE_SS_RW_REG_1			0xf4
> > > +#define IMX95_PCIE_CLKREQ_OVERRIDE_EN		BIT(8)
> > > +#define IMX95_PCIE_CLKREQ_OVERRIDE_VAL		BIT(9)
> > >  #define IMX95_PCIE_SYS_AUX_PWR_DET		BIT(31)
> > >
> > >  #define IMX95_PE0_GEN_CTRL_1			0x1050
> > > @@ -136,6 +138,7 @@ struct imx_pcie_drvdata {
> > >  	int (*enable_ref_clk)(struct imx_pcie *pcie, bool enable);
> > >  	int (*core_reset)(struct imx_pcie *pcie, bool assert);
> > >  	int (*wait_pll_lock)(struct imx_pcie *pcie);
> > > +	void (*clr_clkreq_override)(struct imx_pcie *pcie);
> > >  	const struct dw_pcie_host_ops *ops;
> > >  };
> > >
> > > @@ -149,6 +152,7 @@ struct imx_pcie {
> > >  	struct gpio_desc	*reset_gpiod;
> > >  	struct clk_bulk_data	*clks;
> > >  	int			num_clks;
> > > +	bool			supports_clkreq;
> > >  	struct regmap		*iomuxc_gpr;
> > >  	u16			msi_ctrl;
> > >  	u32			controller_id;
> > > @@ -239,6 +243,16 @@ static unsigned int imx_pcie_grp_offset(const
> > struct imx_pcie *imx_pcie)
> > >  	return imx_pcie->controller_id == 1 ? IOMUXC_GPR16 : IOMUXC_GPR14;
> > > }
> > >
> > > +static void  imx95_pcie_clkreq_override(struct imx_pcie *imx_pcie,
> > > +bool enable) {
> > > +	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_1,
> > > +			   IMX95_PCIE_CLKREQ_OVERRIDE_EN,
> > > +			   enable ? IMX95_PCIE_CLKREQ_OVERRIDE_EN : 0);
> > > +	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_1,
> > > +			   IMX95_PCIE_CLKREQ_OVERRIDE_VAL,
> > > +			   enable ? IMX95_PCIE_CLKREQ_OVERRIDE_VAL : 0); }
> > > +
> > >  static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)  {
> > >  	/*
> > > @@ -685,7 +699,7 @@ static int imx6q_pcie_enable_ref_clk(struct
> > imx_pcie *imx_pcie, bool enable)
> > >  	return 0;
> > >  }
> > >
> > > -static int imx8mm_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool
> > > enable)
> > > +static void imx8mm_pcie_clkreq_override(struct imx_pcie *imx_pcie,
> > > +bool enable)
> > >  {
> > >  	int offset = imx_pcie_grp_offset(imx_pcie);
> > >
> > > @@ -695,6 +709,11 @@ static int imx8mm_pcie_enable_ref_clk(struct
> > imx_pcie *imx_pcie, bool enable)
> > >  	regmap_update_bits(imx_pcie->iomuxc_gpr, offset,
> > >  			   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
> > >  			   enable ? IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN : 0);
> > > +}
> > > +
> > > +static int imx8mm_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool
> > > +enable) {
> > > +	imx8mm_pcie_clkreq_override(imx_pcie, enable);
> > >  	return 0;
> > >  }
> > >
> > > @@ -1298,6 +1317,16 @@ static void imx_pcie_host_exit(struct
> > dw_pcie_rp *pp)
> > >  		regulator_disable(imx_pcie->vpcie);
> > >  }
> > >
> > > +static void imx8mm_pcie_clr_clkreq_override(struct imx_pcie
> > > +*imx_pcie) {
> > > +	imx8mm_pcie_clkreq_override(imx_pcie, false); }
> > > +
> > > +static void imx95_pcie_clr_clkreq_override(struct imx_pcie *imx_pcie)
> > > +{
> > > +	imx95_pcie_clkreq_override(imx_pcie, false); }
> > > +
> > >  static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)  {
> > >  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp); @@ -1322,6 +1351,12
> > @@
> > > static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
> > >  		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
> > >  		dw_pcie_dbi_ro_wr_dis(pci);
> > >  	}
> > > +
> > > +	/* Clear CLKREQ# override if supports_clkreq is true and link is up */
> > > +	if (dw_pcie_link_up(pci) && imx_pcie->supports_clkreq) {
> > > +		if (imx_pcie->drvdata->clr_clkreq_override)
> > > +			imx_pcie->drvdata->clr_clkreq_override(imx_pcie);
> > > +	}
> > >  }
> > >
> > >  /*
> > > @@ -1745,6 +1780,8 @@ static int imx_pcie_probe(struct platform_device
> > *pdev)
> > >  	pci->max_link_speed = 1;
> > >  	of_property_read_u32(node, "fsl,max-link-speed",
> > > &pci->max_link_speed);
> > >
> > > +	imx_pcie->supports_clkreq =
> > > +		of_property_read_bool(node, "supports-clkreq");
> > >  	imx_pcie->vpcie = devm_regulator_get_optional(&pdev->dev, "vpcie");
> > >  	if (IS_ERR(imx_pcie->vpcie)) {
> > >  		if (PTR_ERR(imx_pcie->vpcie) != -ENODEV) @@ -1873,6 +1910,7 @@
> > > static const struct imx_pcie_drvdata drvdata[] = {
> > >  		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
> > >  		.init_phy = imx8mq_pcie_init_phy,
> > >  		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
> > > +		.clr_clkreq_override = imx8mm_pcie_clr_clkreq_override,
> > >  	},
> > >  	[IMX8MM] = {
> > >  		.variant = IMX8MM,
> > > @@ -1883,6 +1921,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
> > >  		.mode_off[0] = IOMUXC_GPR12,
> > >  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> > >  		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
> > > +		.clr_clkreq_override = imx8mm_pcie_clr_clkreq_override,
> > >  	},
> > >  	[IMX8MP] = {
> > >  		.variant = IMX8MP,
> > > @@ -1893,6 +1932,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
> > >  		.mode_off[0] = IOMUXC_GPR12,
> > >  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> > >  		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
> > > +		.clr_clkreq_override = imx8mm_pcie_clr_clkreq_override,
> > >  	},
> > >  	[IMX8Q] = {
> > >  		.variant = IMX8Q,
> > > @@ -1913,6 +1953,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
> > >  		.core_reset = imx95_pcie_core_reset,
> > >  		.init_phy = imx95_pcie_init_phy,
> > >  		.wait_pll_lock = imx95_pcie_wait_for_phy_pll_lock,
> > > +		.clr_clkreq_override = imx95_pcie_clr_clkreq_override,
> > >  	},
> > >  	[IMX8MQ_EP] = {
> > >  		.variant = IMX8MQ_EP,
> > > --
> > > 2.37.1
> > >

