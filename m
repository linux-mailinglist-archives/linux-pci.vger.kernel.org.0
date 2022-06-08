Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCB1542930
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 10:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiFHIRb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 04:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbiFHIQE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 04:16:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD04426D274
        for <linux-pci@vger.kernel.org>; Wed,  8 Jun 2022 00:44:48 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1nyqMr-0002o3-H8; Wed, 08 Jun 2022 09:44:41 +0200
Message-ID: <323f9352fcf22c040417b16e57647695a48c1395.camel@pengutronix.de>
Subject: Re: [PATCH v9 7/8] PCI: imx6: Move the phy driver callbacks to the
 proper places
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, bhelgaas@google.com,
        robh+dt@kernel.org, broonie@kernel.org, lorenzo.pieralisi@arm.com,
        jingoohan1@gmail.com, festevam@gmail.com,
        francesco.dolcini@toradex.com
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Date:   Wed, 08 Jun 2022 09:44:40 +0200
In-Reply-To: <1651801629-30223-8-git-send-email-hongxing.zhu@nxp.com>
References: <1651801629-30223-1-git-send-email-hongxing.zhu@nxp.com>
         <1651801629-30223-8-git-send-email-hongxing.zhu@nxp.com>
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

Am Freitag, dem 06.05.2022 um 09:47 +0800 schrieb Richard Zhu:
> To make it more reasonable, move the phy_power_on/phy_init callbacks to
> the proper places.
> - move the phy_power_on() out of imx6_pcie_clk_enable().
> - move the phy_init() out of imx6_pcie_deassert_core_reset().
> 
> In order to save power consumption, turn off the clocks and regulators when
> the imx6_pcie_host_init() return error.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 77 +++++++++++++++++++++------
>  1 file changed, 61 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index d122c12193a6..f0ffd9011975 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -497,14 +497,6 @@ static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
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
> @@ -597,10 +589,7 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  	switch (imx6_pcie->drvdata->variant) {
>  	case IMX8MQ:
>  		reset_control_deassert(imx6_pcie->pciephy_reset);
> -		break;
>  	case IMX8MM:
> -		if (phy_init(imx6_pcie->phy))
> -			dev_err(dev, "waiting for phy ready timeout!\n");

This looks fishy. You now fall-through from the 8MQ case to the 8MM
case, just to break there. Please move the 8MM case down to the 6QP
case that also doesn't need to do anything here.

>  		break;
>  	case IMX7D:
>  		reset_control_deassert(imx6_pcie->pciephy_reset);
> @@ -918,15 +907,38 @@ static int imx6_pcie_host_init(struct pcie_port *pp)
>  
>  	imx6_pcie_assert_core_reset(imx6_pcie);
>  	imx6_pcie_init_phy(imx6_pcie);
> +	if (imx6_pcie->phy != NULL) {

Same comment as on the last patch: drop the "!= NULL".

> +		ret = phy_power_on(imx6_pcie->phy);
> +		if (ret) {
> +			dev_err(dev, "pcie phy power up failed.\n");
> +			return ret;
> +		}
> +	}
> +
>  	ret = imx6_pcie_deassert_core_reset(imx6_pcie);
>  	if (ret < 0) {
>  		dev_err(dev, "pcie host init failed: %d.\n", ret);
> -		return ret;
> +		goto err_exit0;

This label is not very descriptive. Please rename to something like
err_phy_off or something like that.

> +	} else if (imx6_pcie->phy != NULL) {

The else path isn't needed here. If there was an error you already
moved the contol flow to the error label. So drop the else and again
have this block under a simple "if (imx6_pcie->phy)" statement.

> +		ret = phy_init(imx6_pcie->phy);
> +		if (ret) {
> +			dev_err(dev, "waiting for phy ready timeout!\n");
> +			goto err_exit1;

Again, please give those labels a more descriptive name.

All of the above comments also apply to the changes in
imx6_pcie_resume_noirq.

Regards,
Lucas

> +		}
>  	}
>  
>  	imx6_setup_phy_mpll(imx6_pcie);
>  
>  	return 0;
> +
> +err_exit1:
> +	imx6_pcie_clk_disable(imx6_pcie);
> +	if (imx6_pcie->vpcie)
> +		regulator_disable(imx6_pcie->vpcie);
> +err_exit0:
> +	if (imx6_pcie->phy != NULL)
> +		phy_power_off(imx6_pcie->phy);
> +	return ret;
>  }
>  
>  static const struct dw_pcie_host_ops imx6_pcie_host_ops = {
> @@ -1031,14 +1043,47 @@ static int imx6_pcie_resume_noirq(struct device *dev)
>  		regulator_disable(imx6_pcie->vpcie);
>  
>  	imx6_pcie_init_phy(imx6_pcie);
> -	imx6_pcie_deassert_core_reset(imx6_pcie);
> -	dw_pcie_setup_rc(pp);
> +	if (imx6_pcie->phy != NULL) {
> +		ret = phy_power_on(imx6_pcie->phy);
> +		if (ret) {
> +			dev_err(dev, "pcie phy power up failed.\n");
> +			return ret;
> +		}
> +	}
> +
> +	ret = imx6_pcie_deassert_core_reset(imx6_pcie);
> +	if (ret < 0) {
> +		dev_err(dev, "pcie deassert core reset failed: %d.\n", ret);
> +		goto err_exit0;
> +	} else if (imx6_pcie->phy != NULL) {
> +		ret = phy_init(imx6_pcie->phy);
> +		if (ret) {
> +			dev_err(dev, "pcie phy init failed.\n");
> +			goto err_exit1;
> +		}
> +	}
>  
> +	dw_pcie_setup_rc(pp);
>  	ret = imx6_pcie_start_link(imx6_pcie->pci);
> -	if (ret < 0)
> -		dev_info(dev, "pcie link is down after resume.\n");
> +	if (ret < 0) {
> +		/*
> +		 * Return ret directly, since there are error exit
> +		 * handle in imx6_pcie_start_link()
> +		 */
> +		dev_err(dev, "pcie link is down after resume.\n");
> +		return ret;
> +	}
>  
>  	return 0;
> +
> +err_exit1:
> +	imx6_pcie_clk_disable(imx6_pcie);
> +	if (imx6_pcie->vpcie)
> +		regulator_disable(imx6_pcie->vpcie);
> +err_exit0:
> +	if (imx6_pcie->phy != NULL)
> +		phy_power_off(imx6_pcie->phy);
> +	return ret;
>  }
>  #endif
>  


