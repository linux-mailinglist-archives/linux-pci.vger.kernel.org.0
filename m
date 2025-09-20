Return-Path: <linux-pci+bounces-36569-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5C6B8C16D
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 09:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EE83A80BA8
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 07:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC6F233134;
	Sat, 20 Sep 2025 07:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTmPoAQi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863DE34BA52;
	Sat, 20 Sep 2025 07:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758353839; cv=none; b=ViQKHqEv9MLhqjCzlHRBPbC3ou+zoiSeNlVVRHVaYEZVp2rETMnEmunFIWZuXafZo1oA/Ca7Zc31HyFt9d59+j9qf4emUGQdTuFvPbPo/dtnX3OM4ULlOr1FieKC2be5Of8c1A0Qa8P/FC672L0oif/t0YbbVRyTiXzu9ojRCa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758353839; c=relaxed/simple;
	bh=GXoeXO8k9Luo47HuYsKuJ/VbXUiTDkuCn8oRQSvIc/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mxu/j2WG8IgxWecxXkleyXn9TxcALFgRMC4XVRbHtyPGwID9SrCkBEgNaZIuV8Fsy1apWeOfxvUGdHW3TcesVEHd2tBZOacFv75YfzwOoWiSdCJXipKdf27n1tdOUchkwEKIBGpuJWG3+z08treC+5OerzgqgvUtfFJVaxmkL4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTmPoAQi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A32C4CEEB;
	Sat, 20 Sep 2025 07:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758353839;
	bh=GXoeXO8k9Luo47HuYsKuJ/VbXUiTDkuCn8oRQSvIc/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iTmPoAQiElG7qvJc2ufXiuVr2dOcBcWezyRyDspcodrcaq9dxMFFJDVD/2EEWOZi/
	 kbooih2FPzMceDrWpdDfni8QZDUNrcV+x8axOQWXOF30I/WQU8Jkd9JbX4N/VV/qWm
	 vtMla+OCjcXSk8ISe5u3MHbuRFt5GnTE2OoeOxA/3RHYjO9j5B9jbEEEm1ELD/SfcB
	 jKewCEHu1V1r07zQK7LQ6pf6g3u84JEzr5yMdDseWqMuBzttIGY+tKj9oTolqgI3fe
	 ZuPY5Ba/YNmXVDDPcTIQK7/t9yD3geYTGu1JHXObto+N0GaswbkUusGalHAyUItA7G
	 wECvkTE1ax0fg==
Date: Sat, 20 Sep 2025 13:07:09 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/3] PCI: imx6: Add external reference clock input
 mode support
Message-ID: <c524y4ymsozmktpptjrpkav62yykrqztyx4hkrgmbmbrewxio2@bczi3zufjede>
References: <20250918032555.3987157-1-hongxing.zhu@nxp.com>
 <20250918032555.3987157-4-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250918032555.3987157-4-hongxing.zhu@nxp.com>

On Thu, Sep 18, 2025 at 11:25:55AM +0800, Richard Zhu wrote:
> i.MX95 PCIes have two reference clock inputs: one from internal PLL, the
> other from off chip crystal oscillator. The "extref" clock refers to a
> reference clock from an external crystal oscillator.
> 
> Add external reference clock input mode support for i.MX95 PCIes.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 80e48746bbaf..e2ca8b036253 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -149,6 +149,7 @@ struct imx_pcie {
>  	struct gpio_desc	*reset_gpiod;
>  	struct clk_bulk_data	*clks;
>  	int			num_clks;
> +	bool			enable_ext_refclk;
>  	struct regmap		*iomuxc_gpr;
>  	u16			msi_ctrl;
>  	u32			controller_id;
> @@ -241,6 +242,8 @@ static unsigned int imx_pcie_grp_offset(const struct imx_pcie *imx_pcie)
>  
>  static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
>  {
> +	bool ext = imx_pcie->enable_ext_refclk;
> +
>  	/*
>  	 * ERR051624: The Controller Without Vaux Cannot Exit L23 Ready
>  	 * Through Beacon or PERST# De-assertion
> @@ -259,13 +262,12 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
>  			IMX95_PCIE_PHY_CR_PARA_SEL,
>  			IMX95_PCIE_PHY_CR_PARA_SEL);
>  
> -	regmap_update_bits(imx_pcie->iomuxc_gpr,
> -			   IMX95_PCIE_PHY_GEN_CTRL,
> -			   IMX95_PCIE_REF_USE_PAD, 0);
> -	regmap_update_bits(imx_pcie->iomuxc_gpr,
> -			   IMX95_PCIE_SS_RW_REG_0,
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_GEN_CTRL,
> +			   ext ? IMX95_PCIE_REF_USE_PAD : 0,
> +			   IMX95_PCIE_REF_USE_PAD);
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_0,
>  			   IMX95_PCIE_REF_CLKEN,
> -			   IMX95_PCIE_REF_CLKEN);
> +			   ext ? 0 : IMX95_PCIE_REF_CLKEN);
>  
>  	return 0;
>  }
> @@ -1606,7 +1608,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  	struct imx_pcie *imx_pcie;
>  	struct device_node *np;
>  	struct device_node *node = dev->of_node;
> -	int ret, domain;
> +	int i, ret, domain;
>  	u16 val;
>  
>  	imx_pcie = devm_kzalloc(dev, sizeof(*imx_pcie), GFP_KERNEL);
> @@ -1657,6 +1659,10 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  	if (imx_pcie->num_clks < 0)
>  		return dev_err_probe(dev, imx_pcie->num_clks,
>  				     "failed to get clocks\n");
> +	imx_pcie->enable_ext_refclk = false;

Default value is 'false'. So no need to initialize.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

