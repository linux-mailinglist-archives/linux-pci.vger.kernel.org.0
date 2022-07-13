Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6714B573210
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jul 2022 11:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236060AbiGMJH2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jul 2022 05:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236061AbiGMJHY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2022 05:07:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D32BF421E
        for <linux-pci@vger.kernel.org>; Wed, 13 Jul 2022 02:07:19 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1oBYKr-0000bg-3E; Wed, 13 Jul 2022 11:07:09 +0200
Message-ID: <eb64cbf58ae6b6fd1e6b993f15e2c5871f4e1650.camel@pengutronix.de>
Subject: Re: [PATCH v14 17/17] PCI: imx6: Reformat suspend callback to keep
 symmetric with resume
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, bhelgaas@google.com,
        robh+dt@kernel.org, broonie@kernel.org, lorenzo.pieralisi@arm.com,
        festevam@gmail.com, francesco.dolcini@toradex.com
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Date:   Wed, 13 Jul 2022 11:07:08 +0200
In-Reply-To: <1656645935-1370-18-git-send-email-hongxing.zhu@nxp.com>
References: <1656645935-1370-1-git-send-email-hongxing.zhu@nxp.com>
         <1656645935-1370-18-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Freitag, dem 01.07.2022 um 11:25 +0800 schrieb Richard Zhu:
> Create imx6_pcie_stop_link() and imx6_pcie_host_exit() functions.
> Encapsulate clocks, regulators disables and PHY uninitialization into
> imx6_pcie_host_exit().
> To keep suspend/resume symmetric as much as possible, invoke these two
> new created functions in suspend callback.
> 
> To be symmetric with imx6_pcie_host_exit(), move imx6_pcie_clk_enable()
> to imx6_pcie_host_init() from imx6_pcie_deassert_core_reset().
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 60 ++++++++++++++++-----------
>  1 file changed, 36 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 1cf8bf9035f2..bf8992a6c238 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -703,13 +703,6 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  {
>  	struct dw_pcie *pci = imx6_pcie->pci;
>  	struct device *dev = pci->dev;
> -	int ret;
> -
> -	ret = imx6_pcie_clk_enable(imx6_pcie);
> -	if (ret) {
> -		dev_err(dev, "unable to enable pcie clocks: %d\n", ret);
> -		return ret;
> -	}
>  
>  	switch (imx6_pcie->drvdata->variant) {
>  	case IMX8MQ:
> @@ -905,6 +898,14 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
>  	return 0;
>  }
>  
> +static void imx6_pcie_stop_link(struct dw_pcie *pci)
> +{
> +	struct device *dev = pci->dev;
> +
> +	/* Turn off PCIe LTSSM */
> +	imx6_pcie_ltssm_disable(dev);
> +}
> +
>  static int imx6_pcie_host_init(struct pcie_port *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -922,11 +923,17 @@ static int imx6_pcie_host_init(struct pcie_port *pp)
>  			return ret;
>  		}
>  	}
> +	ret = imx6_pcie_clk_enable(imx6_pcie);
> +	if (ret) {
> +		dev_err(dev, "unable to enable pcie clocks: %d\n", ret);
> +		goto err_reg_disable;
> +	}
> +
>  	if (imx6_pcie->phy) {
>  		ret = phy_power_on(imx6_pcie->phy);
>  		if (ret) {
>  			dev_err(dev, "pcie phy power up failed.\n");
> -			goto err_reg_disable;
> +			goto err_clk_disable;
>  		}
>  	}
>  
> @@ -947,17 +954,33 @@ static int imx6_pcie_host_init(struct pcie_port *pp)
>  
>  	return 0;
>  
> -err_clk_disable:
> -	imx6_pcie_clk_disable(imx6_pcie);
>  err_phy_off:
>  	if (imx6_pcie->phy)
>  		phy_power_off(imx6_pcie->phy);
> +err_clk_disable:
> +	imx6_pcie_clk_disable(imx6_pcie);
>  err_reg_disable:
>  	if (imx6_pcie->vpcie)
>  		regulator_disable(imx6_pcie->vpcie);
>  	return ret;
>  }
>  
> +static void imx6_pcie_host_exit(struct pcie_port *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
> +
> +	if (imx6_pcie->phy) {
> +		if (phy_power_off(imx6_pcie->phy))
> +			dev_err(pci->dev, "unable to power off PHY\n");
> +		phy_exit(imx6_pcie->phy);
> +	}
> +	imx6_pcie_clk_disable(imx6_pcie);
> +
> +	if (imx6_pcie->vpcie)
> +		regulator_disable(imx6_pcie->vpcie);
> +}
> +
>  static const struct dw_pcie_host_ops imx6_pcie_host_ops = {
>  	.host_init = imx6_pcie_host_init,
>  };
> @@ -1007,25 +1030,14 @@ static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
>  static int imx6_pcie_suspend_noirq(struct device *dev)
>  {
>  	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
> +	struct pcie_port *pp = &imx6_pcie->pci->pp;
>  
>  	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_SUPPORTS_SUSPEND))
>  		return 0;
>  
>  	imx6_pcie_pm_turnoff(imx6_pcie);
> -	imx6_pcie_ltssm_disable(dev);
> -	imx6_pcie_clk_disable(imx6_pcie);
> -	switch (imx6_pcie->drvdata->variant) {
> -	case IMX8MM:
> -		if (phy_power_off(imx6_pcie->phy))
> -			dev_err(dev, "unable to power off PHY\n");
> -		phy_exit(imx6_pcie->phy);
> -		break;
> -	default:
> -		break;
> -	}
> -
> -	if (imx6_pcie->vpcie)
> -		regulator_disable(imx6_pcie->vpcie);
> +	imx6_pcie_stop_link(imx6_pcie->pci);
> +	imx6_pcie_host_exit(pp);
>  
>  	return 0;
>  }


