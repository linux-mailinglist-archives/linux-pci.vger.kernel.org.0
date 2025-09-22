Return-Path: <linux-pci+bounces-36613-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46631B8F152
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 08:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40CD67AB90E
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 06:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFC4248F69;
	Mon, 22 Sep 2025 06:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtkR8yio"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31FC2441A0;
	Mon, 22 Sep 2025 06:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758521566; cv=none; b=HOl+vrfS8kS5uG4165VxVu7bGm/His1V0j8e56h2wOICQ9llEUGqZh8ekWxVmVSSRrLTpYsByvO6gkwbk9yjHXoSS/LsoJ/pvRkwbj6Arh/Z3DbAnnqhEGTcXBf6+2m6VWIAhR3C38zyB4LNlV6tqJ/r54HwYSDcgDVeuXkTx98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758521566; c=relaxed/simple;
	bh=3UerwbZ38Y6F51/AVZvwT7fXNyINz/eAUpivcoyBoKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFS0h263HgTHk8XTpnWJHGa8vFMH/wZ9wFtOQoo6lMCVezeDObDBoeI4OKnfxk7f2O8tII7yfpgMxLSm9srM43LJ8DCpPTdv7zJ7hppPy6hHkY/BK0urTjxBenFSIZhimRIh1kNdSMeYWxUeVfSTqZmN7XDGBO3nXItsk1KQEqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtkR8yio; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34ED8C4CEF0;
	Mon, 22 Sep 2025 06:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758521565;
	bh=3UerwbZ38Y6F51/AVZvwT7fXNyINz/eAUpivcoyBoKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FtkR8yioGMhFkuF+Cn1wzH4ievrnmc6BCRXFotZptl2hU5vAkAIKzb6bxFPJl1/5V
	 t4Mn1u5euXTtsl6AZUiQoeTQxskVNc45ObI32dW7n0Te3qyvGjRzhenrKBLO5oHYKl
	 yUKTm4Sv3J7vPNKLXw44JzFxh23XziKUMADmJi2MTFy4Jsv2SnxqwWjSA4XwdmqybH
	 zELfSwj198PjLJt2gM0PVjIdfM9qO99QCK9ZGD/5Wis0BX6pNvKy85B9mHiUi1S1A1
	 cogT9I5lshWFzf1pOdPgdgwi/Sqwx0jL/p8E70994AcP5fUyojYjW0lHrviiFFZB5+
	 mPj2bZghG6pFg==
Date: Mon, 22 Sep 2025 11:42:36 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, jingoohan1@gmail.com, l.stach@pengutronix.de, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] PCI: imx6: Add a method to handle CLKREQ#
 override active low
Message-ID: <hsmebnz6opoj45zztdd2svmdtrwwwrngjaidpltbunnkdvvdqz@lhyejtlwkkes>
References: <20250922023741.906024-1-hongxing.zhu@nxp.com>
 <20250922023741.906024-3-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250922023741.906024-3-hongxing.zhu@nxp.com>

On Mon, Sep 22, 2025 at 10:37:41AM +0800, Richard Zhu wrote:
> The CLKREQ# is an open drain, active low signal that is driven low by
> the card to request reference clock. It's an optional signal added in
> PCIe CEM r4.0, sec 2. Thus, this signal wouldn't be driven low if it's
> reserved.
> 
> Since the reference clock controlled by CLKREQ# may be required by i.MX
> PCIe host too. To make sure this clock is ready even when the CLKREQ#
> isn't driven low by the card(e.x the scenario described above), force
> CLKREQ# override active low for i.MX PCIe host during initialization.
> 
> The CLKREQ# override can be cleared safely when supports-clkreq is
> present and PCIe link is up later. Because the CLKREQ# would be driven
> low by the card at this time.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 35 +++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 80e48746bbaf..a73632b47e2d 100644
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

This should be:

	imx95_pcie_clkreq_override(imx_pcie, true);

refer below...

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

Just noticed this discrepancy. 'imx8mm_pcie_enable_ref_clk(, false)' is enabling
the CLKREQ# override, thereby enabling the refclk. But only for imx8mm, this
helper is called as imx8mm_pcie_enable_ref_clk(). But for imx95, the equivalent
function is called as imx95_pcie_clr_clkreq_override(). This is causing
confusion.

Maybe you should just call both functions as:

	imx8mm_pcie_clkreq_override(imx_pcie, bool enable);
	imx95_pcie_clkreq_override(imx_pcie, bool enable);

Then,

	imx8mm_pcie_clr_clkreq_override(struct imx_pcie *imx_pcie)
	{
		imx8mm_pcie_clkreq_override(imx_pcie, false)
	}

	imx95_pcie_clr_clkreq_override(struct imx_pcie *imx_pcie)
	{
		imx95_pcie_clkreq_override(imx_pcie, false)
	}

and populate the clr_clkreq_override() callback.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

