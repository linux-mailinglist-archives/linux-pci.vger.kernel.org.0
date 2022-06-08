Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED18542861
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 09:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiFHHuM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 03:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234025AbiFHHs4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 03:48:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805497E1F1
        for <linux-pci@vger.kernel.org>; Wed,  8 Jun 2022 00:14:17 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1nyptD-00052C-Iv; Wed, 08 Jun 2022 09:14:03 +0200
Message-ID: <4efc78897fb07be99bde2921f69ae6aefd13bef2.camel@pengutronix.de>
Subject: Re: [PATCH v9 3/8] PCI: imx6: Move imx6_pcie_clk_disable() earlier
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, bhelgaas@google.com,
        robh+dt@kernel.org, broonie@kernel.org, lorenzo.pieralisi@arm.com,
        jingoohan1@gmail.com, festevam@gmail.com,
        francesco.dolcini@toradex.com
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Date:   Wed, 08 Jun 2022 09:14:02 +0200
In-Reply-To: <1651801629-30223-4-git-send-email-hongxing.zhu@nxp.com>
References: <1651801629-30223-1-git-send-email-hongxing.zhu@nxp.com>
         <1651801629-30223-4-git-send-email-hongxing.zhu@nxp.com>
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
> Just move the imx6_pcie_clk_disable() to an earlier place without function
> changes, since it wouldn't be only used in imx6_pcie_suspend_noirq() later.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 48 +++++++++++++--------------
>  1 file changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 1d3a8a7cafc2..9b0eac64badc 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -529,6 +529,30 @@ static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
>  	return ret;
>  }
>  
> +static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
> +{
> +	clk_disable_unprepare(imx6_pcie->pcie);
> +	clk_disable_unprepare(imx6_pcie->pcie_phy);
> +	clk_disable_unprepare(imx6_pcie->pcie_bus);
> +
> +	switch (imx6_pcie->drvdata->variant) {
> +	case IMX6SX:
> +		clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
> +		break;
> +	case IMX7D:
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
> +				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
> +		break;
> +	case IMX8MQ:
> +	case IMX8MM:
> +		clk_disable_unprepare(imx6_pcie->pcie_aux);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
>  static void imx7d_pcie_wait_for_phy_pll_lock(struct imx6_pcie *imx6_pcie)
>  {
>  	u32 val;
> @@ -961,30 +985,6 @@ static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
>  	usleep_range(1000, 10000);
>  }
>  
> -static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
> -{
> -	clk_disable_unprepare(imx6_pcie->pcie);
> -	clk_disable_unprepare(imx6_pcie->pcie_phy);
> -	clk_disable_unprepare(imx6_pcie->pcie_bus);
> -
> -	switch (imx6_pcie->drvdata->variant) {
> -	case IMX6SX:
> -		clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
> -		break;
> -	case IMX7D:
> -		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
> -				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
> -		break;
> -	case IMX8MQ:
> -	case IMX8MM:
> -		clk_disable_unprepare(imx6_pcie->pcie_aux);
> -		break;
> -	default:
> -		break;
> -	}
> -}
> -
>  static int imx6_pcie_suspend_noirq(struct device *dev)
>  {
>  	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);


