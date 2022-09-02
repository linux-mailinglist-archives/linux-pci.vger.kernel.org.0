Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21675AB6EF
	for <lists+linux-pci@lfdr.de>; Fri,  2 Sep 2022 18:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235695AbiIBQyd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 12:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235498AbiIBQyc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 12:54:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F75109538
        for <linux-pci@vger.kernel.org>; Fri,  2 Sep 2022 09:54:31 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1oU9vr-0001Oe-FJ; Fri, 02 Sep 2022 18:54:15 +0200
Message-ID: <c3f2d312bf3f8c75ea345b1ceeefb3d3d0358883.camel@pengutronix.de>
Subject: Re: [PATCH v7 7/7] PCI: imx6: Add i.MX8MP PCIe support
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, p.zabel@pengutronix.de,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        shawnguo@kernel.org, vkoul@kernel.org,
        alexander.stein@ew.tq-group.com, marex@denx.de,
        richard.leitner@linux.dev
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Date:   Fri, 02 Sep 2022 18:54:14 +0200
In-Reply-To: <1662109086-15881-8-git-send-email-hongxing.zhu@nxp.com>
References: <1662109086-15881-1-git-send-email-hongxing.zhu@nxp.com>
         <1662109086-15881-8-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Freitag, dem 02.09.2022 um 16:58 +0800 schrieb Richard Zhu:
> Add i.MX8MP PCIe support.
> To avoid codes duplication when find the syscon regmap, add the iomux
> gpr syscon compatible into drvdata.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Tested-by: Marek Vasut <marex@denx.de>
> Tested-by: Richard Leitner <richard.leitner@skidata.com>
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 6e5debdbc55b..facc8e7b01c2 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -51,6 +51,7 @@ enum imx6_pcie_variants {
>  	IMX7D,
>  	IMX8MQ,
>  	IMX8MM,
> +	IMX8MP,
>  };
>  
>  #define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
> @@ -61,6 +62,7 @@ struct imx6_pcie_drvdata {
>  	enum imx6_pcie_variants variant;
>  	u32 flags;
>  	int dbi_length;
> +	const char *gpr;
>  };
>  
>  struct imx6_pcie {
> @@ -150,7 +152,8 @@ struct imx6_pcie {
>  static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
>  {
>  	WARN_ON(imx6_pcie->drvdata->variant != IMX8MQ &&
> -		imx6_pcie->drvdata->variant != IMX8MM);
> +		imx6_pcie->drvdata->variant != IMX8MM &&
> +		imx6_pcie->drvdata->variant != IMX8MP);
>  	return imx6_pcie->controller_id == 1 ? IOMUXC_GPR16 : IOMUXC_GPR14;
>  }
>  
> @@ -301,6 +304,7 @@ static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
>  {
>  	switch (imx6_pcie->drvdata->variant) {
>  	case IMX8MM:
> +	case IMX8MP:
>  		/*
>  		 * The PHY initialization had been done in the PHY
>  		 * driver, break here directly.
> @@ -558,6 +562,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
>  		break;
>  	case IMX8MM:
>  	case IMX8MQ:
> +	case IMX8MP:
>  		ret = clk_prepare_enable(imx6_pcie->pcie_aux);
>  		if (ret) {
>  			dev_err(dev, "unable to enable pcie_aux clock\n");
> @@ -602,6 +607,7 @@ static void imx6_pcie_disable_ref_clk(struct imx6_pcie *imx6_pcie)
>  		break;
>  	case IMX8MM:
>  	case IMX8MQ:
> +	case IMX8MP:
>  		clk_disable_unprepare(imx6_pcie->pcie_aux);
>  		break;
>  	default:
> @@ -669,6 +675,7 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
>  		reset_control_assert(imx6_pcie->pciephy_reset);
>  		fallthrough;
>  	case IMX8MM:
> +	case IMX8MP:
>  		reset_control_assert(imx6_pcie->apps_reset);
>  		break;
>  	case IMX6SX:
> @@ -744,6 +751,7 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  		break;
>  	case IMX6Q:		/* Nothing to do */
>  	case IMX8MM:
> +	case IMX8MP:
>  		break;
>  	}
>  
> @@ -793,6 +801,7 @@ static void imx6_pcie_ltssm_enable(struct device *dev)
>  	case IMX7D:
>  	case IMX8MQ:
>  	case IMX8MM:
> +	case IMX8MP:
>  		reset_control_deassert(imx6_pcie->apps_reset);
>  		break;
>  	}
> @@ -812,6 +821,7 @@ static void imx6_pcie_ltssm_disable(struct device *dev)
>  	case IMX7D:
>  	case IMX8MQ:
>  	case IMX8MM:
> +	case IMX8MP:
>  		reset_control_assert(imx6_pcie->apps_reset);
>  		break;
>  	}
> @@ -1179,6 +1189,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  		}
>  		break;
>  	case IMX8MM:
> +	case IMX8MP:
>  		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
>  		if (IS_ERR(imx6_pcie->pcie_aux))
>  			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_aux),
> @@ -1216,7 +1227,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  
>  	/* Grab GPR config register range */
>  	imx6_pcie->iomuxc_gpr =
> -		 syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
> +		 syscon_regmap_lookup_by_compatible(imx6_pcie->drvdata->gpr);
>  	if (IS_ERR(imx6_pcie->iomuxc_gpr)) {
>  		dev_err(dev, "unable to find iomuxc registers\n");
>  		return PTR_ERR(imx6_pcie->iomuxc_gpr);
> @@ -1295,12 +1306,14 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  		.flags = IMX6_PCIE_FLAG_IMX6_PHY |
>  			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE,
>  		.dbi_length = 0x200,
> +		.gpr = "fsl,imx6q-iomuxc-gpr",
>  	},
>  	[IMX6SX] = {
>  		.variant = IMX6SX,
>  		.flags = IMX6_PCIE_FLAG_IMX6_PHY |
>  			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE |
>  			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
> +		.gpr = "fsl,imx6q-iomuxc-gpr",
>  	},
>  	[IMX6QP] = {
>  		.variant = IMX6QP,
> @@ -1308,17 +1321,26 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE |
>  			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
>  		.dbi_length = 0x200,
> +		.gpr = "fsl,imx6q-iomuxc-gpr",
>  	},
>  	[IMX7D] = {
>  		.variant = IMX7D,
>  		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
> +		.gpr = "fsl,imx7d-iomuxc-gpr",
>  	},
>  	[IMX8MQ] = {
>  		.variant = IMX8MQ,
> +		.gpr = "fsl,imx8mq-iomuxc-gpr",
>  	},
>  	[IMX8MM] = {
>  		.variant = IMX8MM,
>  		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
> +		.gpr = "fsl,imx8mm-iomuxc-gpr",
> +	},
> +	[IMX8MP] = {
> +		.variant = IMX8MP,
> +		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
> +		.gpr = "fsl,imx8mp-iomuxc-gpr",
>  	},
>  };
>  
> @@ -1329,6 +1351,7 @@ static const struct of_device_id imx6_pcie_of_match[] = {
>  	{ .compatible = "fsl,imx7d-pcie",  .data = &drvdata[IMX7D],  },
>  	{ .compatible = "fsl,imx8mq-pcie", .data = &drvdata[IMX8MQ], },
>  	{ .compatible = "fsl,imx8mm-pcie", .data = &drvdata[IMX8MM], },
> +	{ .compatible = "fsl,imx8mp-pcie", .data = &drvdata[IMX8MP], },
>  	{},
>  };
>  


