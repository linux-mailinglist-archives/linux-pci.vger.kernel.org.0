Return-Path: <linux-pci+bounces-34413-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80261B2E6B2
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 22:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDAA77A88C6
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 20:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3739C2D2494;
	Wed, 20 Aug 2025 20:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tEf1V7sy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B02C2D23B1;
	Wed, 20 Aug 2025 20:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755722138; cv=none; b=lDiPN6Kcbok6cgKQcRkmuzb/H+S4CcoSiDEc82wZimaPo5toW5FkUnt3Qe/lw/Jxv8G7vhmVmIFZPQ2yTKQm/wIzfBcZdTopeoxi82oXDsYWhWFywA+/C0plcw19ifprTBFne6pqHg2MsxyIulXXU3ij93mmbH57mL9PktN9Hq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755722138; c=relaxed/simple;
	bh=TsKHYxNZLLNav2fl4VlSgG/S6ch3wqYz+Pns7R4RxD0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bifK8bw6dhbx1J04zuuUJWH+27dDw0/j3Bd1DuM0ekzcrxmtPhqabsLzWznr6UTTbwx76OE7f8F9Munqxf6t0uOAROmFehntRnyFiMCxPIF5/L2SOD+ov/CMdcccuokxrKwCtz77q4JGATKifVH6U5LdahvU1roS4eAeXhdrDc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tEf1V7sy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B738C4CEE7;
	Wed, 20 Aug 2025 20:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755722137;
	bh=TsKHYxNZLLNav2fl4VlSgG/S6ch3wqYz+Pns7R4RxD0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tEf1V7syOSrPzXUXLULwOAU4Rkjql9oMaQBC6Gwq3yNFOJOO7Bj+g0HBiN9WpMFRL
	 WgxoS9fajMm8VOQLwWG7B+45FaorAbW6VNVcePZS/+B+6rgCHP1U8iuj/pIJe8Wzq+
	 ih69AN7Cci3vJwwNBroHTt7UJtHl+ehko9DMi/4quqvF7WgTS/dvOZlBB4syFmHLBI
	 JurFBvSQ+UMEchxxzU5ESUlqSPONBknCwg+Ij1+MguCl48xEXEVTsRJPbQRLtj0Li8
	 yC1NVsKWKZD6ZycoK8wPPlAeImllbbJOMW3PVD5r8OuoOmdr1QGxgi+eUtAQQzvGav
	 D0xctMv3Yel8w==
Date: Wed, 20 Aug 2025 15:35:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] PCI: imx6: Add a method to handle CLKREQ#
 override active low
Message-ID: <20250820203536.GA639059@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820081048.2279057-3-hongxing.zhu@nxp.com>

On Wed, Aug 20, 2025 at 04:10:48PM +0800, Richard Zhu wrote:
> The CLKREQ# is an open drain, active low signal that is driven low by
> the card to request reference clock.
> 
> Since the reference clock may be required by i.MX PCIe host too. To make
> sure this clock is available even when the CLKREQ# isn't driven low by
> the card(e.x no card connected), force CLKREQ# override active low for
> i.MX PCIe host during initialization.
> 
> The CLKREQ# override can be cleared safely when supports-clkreq is
> present and PCIe link is up later. Because the CLKREQ# would be driven
> low by the card in this case.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 35 +++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 80e48746bbaf6..a73632b47e2d3 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -52,6 +52,8 @@
>  #define IMX95_PCIE_REF_CLKEN			BIT(23)
>  #define IMX95_PCIE_PHY_CR_PARA_SEL		BIT(9)
>  #define IMX95_PCIE_SS_RW_REG_1			0xf4
> +#define IMX95_PCIE_CLKREQ_OVERRIDE_EN		BIT(8)
> +#define IMX95_PCIE_CLKREQ_OVERRIDE_VAL		BIT(9)
>  #define IMX95_PCIE_SYS_AUX_PWR_DET		BIT(31)
>  
>  #define IMX95_PE0_GEN_CTRL_1			0x1050
> @@ -136,6 +138,7 @@ struct imx_pcie_drvdata {
>  	int (*enable_ref_clk)(struct imx_pcie *pcie, bool enable);
>  	int (*core_reset)(struct imx_pcie *pcie, bool assert);
>  	int (*wait_pll_lock)(struct imx_pcie *pcie);
> +	void (*clr_clkreq_override)(struct imx_pcie *pcie);
>  	const struct dw_pcie_host_ops *ops;
>  };
>  
> @@ -149,6 +152,7 @@ struct imx_pcie {
>  	struct gpio_desc	*reset_gpiod;
>  	struct clk_bulk_data	*clks;
>  	int			num_clks;
> +	bool			supports_clkreq;
>  	struct regmap		*iomuxc_gpr;
>  	u16			msi_ctrl;
>  	u32			controller_id;
> @@ -267,6 +271,13 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
>  			   IMX95_PCIE_REF_CLKEN,
>  			   IMX95_PCIE_REF_CLKEN);
>  
> +	/* Force CLKREQ# low by override */
> +	regmap_update_bits(imx_pcie->iomuxc_gpr,
> +			   IMX95_PCIE_SS_RW_REG_1,
> +			   IMX95_PCIE_CLKREQ_OVERRIDE_EN |
> +			   IMX95_PCIE_CLKREQ_OVERRIDE_VAL,
> +			   IMX95_PCIE_CLKREQ_OVERRIDE_EN |
> +			   IMX95_PCIE_CLKREQ_OVERRIDE_VAL);
>  	return 0;
>  }
>  
> @@ -1298,6 +1309,18 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
>  		regulator_disable(imx_pcie->vpcie);
>  }
>  
> +static void imx8mm_pcie_clr_clkreq_override(struct imx_pcie *imx_pcie)
> +{
> +	imx8mm_pcie_enable_ref_clk(imx_pcie, false);
> +}
> +
> +static void imx95_pcie_clr_clkreq_override(struct imx_pcie *imx_pcie)
> +{
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_1,
> +			   IMX95_PCIE_CLKREQ_OVERRIDE_EN |
> +			   IMX95_PCIE_CLKREQ_OVERRIDE_VAL, 0);
> +}
> +
>  static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -1322,6 +1345,12 @@ static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
>  		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
>  		dw_pcie_dbi_ro_wr_dis(pci);
>  	}
> +
> +	/* Clear CLKREQ# override if supports_clkreq is true and link is up */
> +	if (dw_pcie_link_up(pci) && imx_pcie->supports_clkreq) {
> +		if (imx_pcie->drvdata->clr_clkreq_override)
> +			imx_pcie->drvdata->clr_clkreq_override(imx_pcie);

It seems racy to clear the override when the link is up.

Since it sounds like the i.MX host requires refclock all the time, why
not keep the override permanently?

Obviously it must be ok to keep the override for a while, because
there is some interval between the link coming up and the call of
.clr_clkreq_override().

Would something bad happen if we *never* called
.clr_clkreq_override()?

Bjorn

