Return-Path: <linux-pci+bounces-3812-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2AB85D5E7
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 11:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB7341C21090
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 10:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AEB2E3EB;
	Wed, 21 Feb 2024 10:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTtTTzAk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B273F1EB45;
	Wed, 21 Feb 2024 10:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708512169; cv=none; b=Ay4zEJyh9L08f7LD8/Z3w1Wql9ZiZYUcRyZ8dXlhuHfR5n5hS/WBe4fE3zScJwbHdsBEhnU8vm15N6UNKYvarwshJkHNT/g6wjt/5QOf236R83FtGBbhmqTdHhYbcV+cX5DesvmIEi+153ENhxF18wZzb2tV9deL9Dj91aDRfNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708512169; c=relaxed/simple;
	bh=KLZBJdcF9biH0WRi4jGDqDVkVcZbbFEdykM15vAw0ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8ed18Y46SzOOie5YhxwvYj3j7TSd94XZFCRYd90LtT29zIiU/jJutJIZDj0EryRecvU3911HwPra8F2qBIcOZ4shr3LoRB2qoFbz3DLGjequTuYjj1f+T7qVBkVNRijPlTSzCAeBs4k0teuFb+UQhtEI4r3aMiltrMLTZ72opA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTtTTzAk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF08C433F1;
	Wed, 21 Feb 2024 10:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708512169;
	bh=KLZBJdcF9biH0WRi4jGDqDVkVcZbbFEdykM15vAw0ow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LTtTTzAkMSa2q/Vc+OjCcXFqE4L9WJz2bThCwT+fk21o1v4vf/B+1KFplaev8LRe1
	 WdvUndqCrQx0Rty+xNQqFrvyF2xaQbNlFFxt/qFrZ1cVbjWxeRjYEFr6AImKmvWEU4
	 VH4K8pxz+PZEf0NS4+cJl2L8u7mDdxl0lmaA9VlHaiYKljjn1vYUNivQWYlPEPownn
	 Et71oiAKwrTMOUiJenHE9eKzaHulfju5ROFMpNPANNPCgg4xSUKn1VHefeiI9tSYuB
	 ilMNM7+6mQ4RMQeNmO8Uojg5XJiJ6jB9t9Nwpg8DJwtCRT1pdPYUmXIfndT0aXS116
	 cajVx8qP+banA==
Date: Wed, 21 Feb 2024 11:42:41 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: bhelgaas@google.com, cassel@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, festevam@gmail.com, helgaas@kernel.org,
	hongxing.zhu@nxp.com, imx@lists.linux.dev, kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
	kw@linux.com, l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH v11 10/14] PCI: imx6: Add iMX95 PCIe Root Complex support
Message-ID: <ZdXTof/fSOuBw4MW@lpieralisi>
References: <20240220161924.3871774-1-Frank.Li@nxp.com>
 <20240220161924.3871774-11-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220161924.3871774-11-Frank.Li@nxp.com>

On Tue, Feb 20, 2024 at 11:19:20AM -0500, Frank Li wrote:
> Add iMX95 PCIe Root Complex support.
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     Change from v8 to v9
>     - Add mani's review tag
>     
>     Change from v7 to v8
>     - Update commit subject
>     - add const from regmap
>     - remove unnessary logic in imx6_pcie_deassert_core_reset()
>     
>     Change from v4 to v7
>     - none
>     Change from v1 to v3
>     - none
> 
>  drivers/pci/controller/dwc/pci-imx6.c | 82 +++++++++++++++++++++++++--
>  1 file changed, 77 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 71ce6b7ac1de0..582ba00d628a1 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -42,6 +42,25 @@
>  #define IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE	GENMASK(11, 8)
>  #define IMX8MQ_PCIE2_BASE_ADDR			0x33c00000
>  
> +#define IMX95_PCIE_PHY_GEN_CTRL			0x0
> +#define IMX95_PCIE_REF_USE_PAD			BIT(17)
> +
> +#define IMX95_PCIE_PHY_MPLLA_CTRL		0x10
> +#define IMX95_PCIE_PHY_MPLL_STATE		BIT(30)

These two defines are unused, I will remove them.

> +#define IMX95_PCIE_SS_RW_REG_0			0xf0
> +#define IMX95_PCIE_REF_CLKEN			BIT(23)
> +#define IMX95_PCIE_PHY_CR_PARA_SEL		BIT(9)
> +
> +#define IMX95_PE0_GEN_CTRL_1			0x1050
> +#define IMX95_PCIE_DEVICE_TYPE			GENMASK(3, 0)
> +
> +#define IMX95_PE0_GEN_CTRL_3			0x1058
> +#define IMX95_PCIE_LTSSM_EN			BIT(0)
> +
> +#define IMX95_PE0_PM_STS			0x1064
> +#define IMX95_PCIE_PM_LINKST_IN_L2		BIT(14)

These two defines are unused. I will remove them.

> +
>  #define to_imx6_pcie(x)	dev_get_drvdata((x)->dev)
>  
>  enum imx6_pcie_variants {
> @@ -52,6 +71,7 @@ enum imx6_pcie_variants {
>  	IMX8MQ,
>  	IMX8MM,
>  	IMX8MP,
> +	IMX95,
>  	IMX8MQ_EP,
>  	IMX8MM_EP,
>  	IMX8MP_EP,
> @@ -63,6 +83,7 @@ enum imx6_pcie_variants {
>  #define IMX6_PCIE_FLAG_HAS_PHYDRV			BIT(3)
>  #define IMX6_PCIE_FLAG_HAS_APP_RESET		BIT(4)
>  #define IMX6_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
> +#define IMX6_PCIE_FLAG_HAS_SERDES		BIT(6)
>  
>  #define imx6_check_flag(pci, val)     (pci->drvdata->flags & val)
>  
> @@ -179,6 +200,24 @@ static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
>  	return imx6_pcie->controller_id == 1 ? IOMUXC_GPR16 : IOMUXC_GPR14;
>  }
>  
> +static int imx95_pcie_init_phy(struct imx6_pcie *imx6_pcie)
> +{
> +	regmap_update_bits(imx6_pcie->iomuxc_gpr,
> +			IMX95_PCIE_SS_RW_REG_0,
> +			IMX95_PCIE_PHY_CR_PARA_SEL,
> +			IMX95_PCIE_PHY_CR_PARA_SEL);
> +
> +	regmap_update_bits(imx6_pcie->iomuxc_gpr,
> +			   IMX95_PCIE_PHY_GEN_CTRL,
> +			   IMX95_PCIE_REF_USE_PAD, 0);
> +	regmap_update_bits(imx6_pcie->iomuxc_gpr,
> +			   IMX95_PCIE_SS_RW_REG_0,
> +			   IMX95_PCIE_REF_CLKEN,
> +			   IMX95_PCIE_REF_CLKEN);
> +
> +	return 0;
> +}
> +
>  static void imx6_pcie_configure_type(struct imx6_pcie *imx6_pcie)
>  {
>  	const struct imx6_pcie_drvdata *drvdata = imx6_pcie->drvdata;
> @@ -575,6 +614,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
>  				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
>  		break;
>  	case IMX7D:
> +	case IMX95:
>  		break;
>  	case IMX8MM:
>  	case IMX8MM_EP:
> @@ -1279,12 +1319,32 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  		return PTR_ERR(imx6_pcie->turnoff_reset);
>  	}
>  
> +	if (imx6_pcie->drvdata->gpr) {
>  	/* Grab GPR config register range */
> -	imx6_pcie->iomuxc_gpr =
> -		 syscon_regmap_lookup_by_compatible(imx6_pcie->drvdata->gpr);
> -	if (IS_ERR(imx6_pcie->iomuxc_gpr)) {
> -		dev_err(dev, "unable to find iomuxc registers\n");
> -		return PTR_ERR(imx6_pcie->iomuxc_gpr);
> +		imx6_pcie->iomuxc_gpr =
> +			 syscon_regmap_lookup_by_compatible(imx6_pcie->drvdata->gpr);
> +		if (IS_ERR(imx6_pcie->iomuxc_gpr))
> +			return dev_err_probe(dev, PTR_ERR(imx6_pcie->iomuxc_gpr),
> +					     "unable to find iomuxc registers\n");
> +	}
> +
> +	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_SERDES)) {
> +		void __iomem *off = devm_platform_ioremap_resource_byname(pdev, "app");
> +
> +		if (IS_ERR(off))
> +			return dev_err_probe(dev, PTR_ERR(off),
> +					     "unable to find serdes registers\n");
> +
> +		static const struct regmap_config regmap_config = {
> +			.reg_bits = 32,
> +			.val_bits = 32,
> +			.reg_stride = 4,
> +		};
> +
> +		imx6_pcie->iomuxc_gpr = devm_regmap_init_mmio(dev, off, &regmap_config);
> +		if (IS_ERR(imx6_pcie->iomuxc_gpr))
> +			return dev_err_probe(dev, PTR_ERR(imx6_pcie->iomuxc_gpr),
> +					     "unable to find iomuxc registers\n");
>  	}
>  
>  	/* Grab PCIe PHY Tx Settings */
> @@ -1457,6 +1517,17 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  		.mode_off[0] = IOMUXC_GPR12,
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  	},
> +	[IMX95] = {
> +		.variant = IMX95,
> +		.flags = IMX6_PCIE_FLAG_HAS_SERDES,
> +		.clk_names = imx8mq_clks,
> +		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
> +		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
> +		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
> +		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
> +		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
> +		.init_phy = imx95_pcie_init_phy,
> +	},
>  	[IMX8MQ_EP] = {
>  		.variant = IMX8MQ_EP,
>  		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
> @@ -1501,6 +1572,7 @@ static const struct of_device_id imx6_pcie_of_match[] = {
>  	{ .compatible = "fsl,imx8mq-pcie", .data = &drvdata[IMX8MQ], },
>  	{ .compatible = "fsl,imx8mm-pcie", .data = &drvdata[IMX8MM], },
>  	{ .compatible = "fsl,imx8mp-pcie", .data = &drvdata[IMX8MP], },
> +	{ .compatible = "fsl,imx95-pcie", .data = &drvdata[IMX95], },
>  	{ .compatible = "fsl,imx8mq-pcie-ep", .data = &drvdata[IMX8MQ_EP], },
>  	{ .compatible = "fsl,imx8mm-pcie-ep", .data = &drvdata[IMX8MM_EP], },
>  	{ .compatible = "fsl,imx8mp-pcie-ep", .data = &drvdata[IMX8MP_EP], },
> -- 
> 2.34.1
> 

