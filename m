Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3CA42FAE9
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 20:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237653AbhJOS1J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 14:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhJOS1J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 14:27:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6047BC061570
        for <linux-pci@vger.kernel.org>; Fri, 15 Oct 2021 11:25:02 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1mbRt5-0001TP-0o; Fri, 15 Oct 2021 20:24:59 +0200
Message-ID: <39cae5a1e33d489bd390be9e7e4df67d788eb7be.camel@pengutronix.de>
Subject: Re: [RESEND v2 4/5] PCI: imx6: Fix the clock reference handling
 unbalance when link never came up
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Date:   Fri, 15 Oct 2021 20:24:58 +0200
In-Reply-To: <1634277941-6672-5-git-send-email-hongxing.zhu@nxp.com>
References: <1634277941-6672-1-git-send-email-hongxing.zhu@nxp.com>
         <1634277941-6672-5-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Freitag, dem 15.10.2021 um 14:05 +0800 schrieb Richard Zhu:
> When link never came up, driver probe would be failed with error -110.
> To keep usage counter balance of the clocks, disable the previous
> enabled clocks when link is down.
> Move definitions of the imx6_pcie_clk_disable() function to the proper
> place. Because it wouldn't be used in imx6_pcie_suspend_noirq() only.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 47 ++++++++++++++-------------
>  1 file changed, 24 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index cc837f8bf6d4..d6a5d99ffa52 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -514,6 +514,29 @@ static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
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
> @@ -853,6 +876,7 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
>  		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0),
>  		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG1));
>  	imx6_pcie_reset_phy(imx6_pcie);
> +	imx6_pcie_clk_disable(imx6_pcie);

Same comment as with the previous patch. We should not cram in more
error handling in the imx6_pcie_start_link function, but rather move
out all the error handling to be after dw_pcie_host_init. Even the
already existing phy reset here seems misplaced and should be moved
out.

Regards,
Lucas

>  	if (imx6_pcie->vpcie && regulator_is_enabled(imx6_pcie->vpcie) > 0)
>  		regulator_disable(imx6_pcie->vpcie);
>  	return ret;
> @@ -941,29 +965,6 @@ static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
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


