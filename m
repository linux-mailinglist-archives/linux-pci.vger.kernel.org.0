Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5755731C1
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jul 2022 10:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiGMI6y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jul 2022 04:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234489AbiGMI6x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2022 04:58:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970C02AC77
        for <linux-pci@vger.kernel.org>; Wed, 13 Jul 2022 01:58:52 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1oBYCk-0007Nc-Iw; Wed, 13 Jul 2022 10:58:46 +0200
Message-ID: <4f49f28d15ad859e34aeeb714b5ddd5d6eba4b4a.camel@pengutronix.de>
Subject: Re: [PATCH v14 14/17] PCI: imx6: Do not hide phy driver callbacks
 and refine the error handling
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, bhelgaas@google.com,
        robh+dt@kernel.org, broonie@kernel.org, lorenzo.pieralisi@arm.com,
        festevam@gmail.com, francesco.dolcini@toradex.com
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Date:   Wed, 13 Jul 2022 10:58:45 +0200
In-Reply-To: <1656645935-1370-15-git-send-email-hongxing.zhu@nxp.com>
References: <1656645935-1370-1-git-send-email-hongxing.zhu@nxp.com>
         <1656645935-1370-15-git-send-email-hongxing.zhu@nxp.com>
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
> - Move the phy_power_on() to host_init from imx6_pcie_clk_enable().
> - Move the phy_init() to host_init from imx6_pcie_deassert_core_reset().
> 
> Refine the error handling in imx6_pcie_host_init() accordingly.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 34 +++++++++++++++++----------
>  1 file changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 5a06fbca82d6..0b2a5256fb0d 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -639,14 +639,6 @@ static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
>  		goto err_ref_clk;
>  	}
>  
> -	switch (imx6_pcie->drvdata->variant) {
> -	case IMX8MM:
> -		if (phy_power_on(imx6_pcie->phy))
> -			dev_err(dev, "unable to power on PHY\n");
> -		break;
> -	default:
> -		break;
> -	}
>  	/* allow the clocks to stabilize */
>  	usleep_range(200, 500);
>  	return 0;
> @@ -723,10 +715,6 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  	case IMX8MQ:
>  		reset_control_deassert(imx6_pcie->pciephy_reset);
>  		break;
> -	case IMX8MM:
> -		if (phy_init(imx6_pcie->phy))
> -			dev_err(dev, "waiting for phy ready timeout!\n");
> -		break;
>  	case IMX7D:
>  		reset_control_deassert(imx6_pcie->pciephy_reset);
>  
> @@ -762,6 +750,7 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  		usleep_range(200, 500);
>  		break;
>  	case IMX6Q:		/* Nothing to do */
> +	case IMX8MM:
>  		break;
>  	}
>  
> @@ -913,17 +902,36 @@ static int imx6_pcie_host_init(struct pcie_port *pp)
>  			return ret;
>  		}
>  	}
> +	if (imx6_pcie->phy) {
> +		ret = phy_power_on(imx6_pcie->phy);
> +		if (ret) {
> +			dev_err(dev, "pcie phy power up failed.\n");
> +			goto err_reg_disable;
> +		}
> +	}
>  
>  	ret = imx6_pcie_deassert_core_reset(imx6_pcie);
>  	if (ret < 0) {
>  		dev_err(dev, "pcie deassert core reset failed: %d\n", ret);
> -		goto err_reg_disable;
> +		goto err_phy_off;
>  	}
>  
> +	if (imx6_pcie->phy) {
> +		ret = phy_init(imx6_pcie->phy);
> +		if (ret) {
> +			dev_err(dev, "waiting for phy ready timeout!\n");
> +			goto err_clk_disable;
> +		}
> +	}

Wouldn't it be more logical to put this into imx6_pcie_init_phy()?

Regards,
Lucas

>  	imx6_setup_phy_mpll(imx6_pcie);
>  
>  	return 0;
>  
> +err_clk_disable:
> +	imx6_pcie_clk_disable(imx6_pcie);
> +err_phy_off:
> +	if (imx6_pcie->phy)
> +		phy_power_off(imx6_pcie->phy);
>  err_reg_disable:
>  	if (imx6_pcie->vpcie)
>  		regulator_disable(imx6_pcie->vpcie);


