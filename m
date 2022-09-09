Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276605B343B
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 11:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbiIIJkJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 05:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbiIIJkE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 05:40:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266986AA35;
        Fri,  9 Sep 2022 02:40:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CBC361F69;
        Fri,  9 Sep 2022 09:40:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C70C433C1;
        Fri,  9 Sep 2022 09:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662716401;
        bh=cevScZsIdSwjkUMfj4ulFl7wvWml3gyTQzGKvLzrQ7I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fwF/gdmQ9+k3mab+mrLgbA6cUeZpGrInxekmdiPV2eeffKufh4MhN5awPS4q54vh6
         s7KJRTFTQKBOsngUQ5wB5F2yII239JW3ovcq2+4uB+FDN4Ncfez1ShZgzXFG1qWw8T
         mV1jlqorzAirCX6fj1AB5Sfk0/+0VSDtQxWKSjXzCuooCR5CNaOM7DziZ5x1s85hFc
         rPPo2h9yv+4Xqk2dxUjEuxaEFd0lpFxwriffW01/D5O51l3lB5/6hH0cX4DnUlD/qi
         rqy+V8naa53n80VdgMsDnMyAC8l3BinOmqb8doUq24q2EZfAj+b9eyCRdVRMlVWfZh
         4mHs0PelnfLLg==
Date:   Fri, 9 Sep 2022 11:39:53 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     p.zabel@pengutronix.de, l.stach@pengutronix.de,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        shawnguo@kernel.org, vkoul@kernel.org,
        alexander.stein@ew.tq-group.com, marex@denx.de,
        richard.leitner@linux.dev, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: Re: [PATCH v6 7/7] PCI: imx6: Add i.MX8MP PCIe support
Message-ID: <YxsJ6W/d/bR+Jjjs@lpieralisi>
References: <1662004960-14071-1-git-send-email-hongxing.zhu@nxp.com>
 <1662004960-14071-8-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1662004960-14071-8-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 01, 2022 at 12:02:40PM +0800, Richard Zhu wrote:
> Add i.MX8MP PCIe support.
> To avoid codes duplication when find the syscon regmap, add the iomux
> gpr syscon compatible into drvdata.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Tested-by: Marek Vasut <marex@denx.de>
> Tested-by: Richard Leitner <richard.leitner@skidata.com>
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)

Don't know if should pull this patch, if it goes via other trees:

Acked-by: Lorenzo Pieralisi <lpieralisi@kernel.org>

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 6e5debdbc55b..3018f9d1c1b8 100644
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
> +	char gpr[128];
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
> -- 
> 2.25.1
> 
> 
> -- 
> linux-phy mailing list
> linux-phy@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/linux-phy
