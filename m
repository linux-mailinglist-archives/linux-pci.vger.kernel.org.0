Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BE5525215
	for <lists+linux-pci@lfdr.de>; Thu, 12 May 2022 18:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245599AbiELQIw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 May 2022 12:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245007AbiELQIv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 May 2022 12:08:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B3E0A60D85;
        Thu, 12 May 2022 09:08:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85395106F;
        Thu, 12 May 2022 09:08:50 -0700 (PDT)
Received: from lpieralisi (unknown [10.57.2.156])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 596513F73D;
        Thu, 12 May 2022 09:08:48 -0700 (PDT)
Date:   Thu, 12 May 2022 17:08:45 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     p.zabel@pengutronix.de, l.stach@pengutronix.de,
        bhelgaas@google.com, robh@kernel.org, shawnguo@kernel.org,
        vkoul@kernel.org, alexander.stein@ew.tq-group.com,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: Re: [PATCH v2 7/7] PCI: imx6: Add the iMX8MP PCIe support
Message-ID: <20220512160845.GB2506@lpieralisi>
References: <1646644054-24421-1-git-send-email-hongxing.zhu@nxp.com>
 <1646644054-24421-8-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646644054-24421-8-git-send-email-hongxing.zhu@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 07, 2022 at 05:07:34PM +0800, Richard Zhu wrote:
> Add the i.MX8MP PCIe support.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)

I expect this series will eventually go via the imx6 platform tree.

To avoid you waiting for me when this series is deemed acceptable:

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

I will mark it as "handled elsewhere" in the PCI tree patchwork.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index bb662f90d4f3..4d34f0c88550 100644
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
> @@ -379,6 +380,7 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
>  		reset_control_assert(imx6_pcie->pciephy_reset);
>  		fallthrough;
>  	case IMX8MM:
> +	case IMX8MP:
>  		reset_control_assert(imx6_pcie->apps_reset);
>  		break;
>  	case IMX6SX:
> @@ -407,7 +409,8 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
>  static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
>  {
>  	WARN_ON(imx6_pcie->drvdata->variant != IMX8MQ &&
> -		imx6_pcie->drvdata->variant != IMX8MM);
> +		imx6_pcie->drvdata->variant != IMX8MM &&
> +		imx6_pcie->drvdata->variant != IMX8MP);
>  	return imx6_pcie->controller_id == 1 ? IOMUXC_GPR16 : IOMUXC_GPR14;
>  }
>  
> @@ -448,6 +451,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
>  		break;
>  	case IMX8MM:
>  	case IMX8MQ:
> +	case IMX8MP:
>  		ret = clk_prepare_enable(imx6_pcie->pcie_aux);
>  		if (ret) {
>  			dev_err(dev, "unable to enable pcie_aux clock\n");
> @@ -503,6 +507,7 @@ static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
>  
>  	switch (imx6_pcie->drvdata->variant) {
>  	case IMX8MM:
> +	case IMX8MP:
>  		if (phy_power_on(imx6_pcie->phy))
>  			dev_err(dev, "unable to power on PHY\n");
>  		break;
> @@ -603,6 +608,7 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  		reset_control_deassert(imx6_pcie->pciephy_reset);
>  		break;
>  	case IMX8MM:
> +	case IMX8MP:
>  		if (phy_init(imx6_pcie->phy))
>  			dev_err(dev, "waiting for phy ready timeout!\n");
>  		break;
> @@ -678,6 +684,7 @@ static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
>  {
>  	switch (imx6_pcie->drvdata->variant) {
>  	case IMX8MM:
> +	case IMX8MP:
>  		/*
>  		 * The PHY initialization had been done in the PHY
>  		 * driver, break here directly.
> @@ -823,6 +830,7 @@ static void imx6_pcie_ltssm_enable(struct device *dev)
>  	case IMX7D:
>  	case IMX8MQ:
>  	case IMX8MM:
> +	case IMX8MP:
>  		reset_control_deassert(imx6_pcie->apps_reset);
>  		break;
>  	}
> @@ -938,6 +946,7 @@ static void imx6_pcie_host_exit(struct pcie_port *pp)
>  		imx6_pcie_clk_disable(imx6_pcie);
>  		switch (imx6_pcie->drvdata->variant) {
>  		case IMX8MM:
> +		case IMX8MP:
>  			if (phy_power_off(imx6_pcie->phy))
>  				dev_err(dev, "unable to power off phy\n");
>  			phy_exit(imx6_pcie->phy);
> @@ -972,6 +981,7 @@ static void imx6_pcie_ltssm_disable(struct device *dev)
>  		break;
>  	case IMX7D:
>  	case IMX8MM:
> +	case IMX8MP:
>  		reset_control_assert(imx6_pcie->apps_reset);
>  		break;
>  	default:
> @@ -1028,6 +1038,7 @@ static int imx6_pcie_suspend_noirq(struct device *dev)
>  	imx6_pcie_clk_disable(imx6_pcie);
>  	switch (imx6_pcie->drvdata->variant) {
>  	case IMX8MM:
> +	case IMX8MP:
>  		if (phy_power_off(imx6_pcie->phy))
>  			dev_err(dev, "unable to power off PHY\n");
>  		phy_exit(imx6_pcie->phy);
> @@ -1177,6 +1188,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  		}
>  		break;
>  	case IMX8MM:
> +	case IMX8MP:
>  		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
>  		if (IS_ERR(imx6_pcie->pcie_aux))
>  			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_aux),
> @@ -1327,6 +1339,10 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  		.variant = IMX8MM,
>  		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
>  	},
> +	[IMX8MP] = {
> +		.variant = IMX8MP,
> +		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
> +	},
>  };
>  
>  static const struct of_device_id imx6_pcie_of_match[] = {
> @@ -1336,6 +1352,7 @@ static const struct of_device_id imx6_pcie_of_match[] = {
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
