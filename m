Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 994B540364B
	for <lists+linux-pci@lfdr.de>; Wed,  8 Sep 2021 10:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348212AbhIHIsv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Sep 2021 04:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348047AbhIHIsu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Sep 2021 04:48:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDA5C061575
        for <linux-pci@vger.kernel.org>; Wed,  8 Sep 2021 01:47:43 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1mNtF6-0007Wo-8D; Wed, 08 Sep 2021 10:47:40 +0200
Message-ID: <125bd22edb69ce38a18bcc80c6507da28e8eb185.camel@pengutronix.de>
Subject: Re: [PATCH 1/3] PCI: imx: encapsulate the clock enable into one
 standalone function
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Date:   Wed, 08 Sep 2021 10:47:39 +0200
In-Reply-To: <1631084366-24785-1-git-send-email-hongxing.zhu@nxp.com>
References: <1631084366-24785-1-git-send-email-hongxing.zhu@nxp.com>
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

Am Mittwoch, dem 08.09.2021 um 14:59 +0800 schrieb Richard Zhu:
> No function changes, just encapsulate the i.MX PCIe clocks enable
> operations into one standalone function
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 82 +++++++++++++++++----------
>  1 file changed, 51 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 80fc98acf097..0264432e4c4a 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -143,6 +143,8 @@ struct imx6_pcie {
>  #define PHY_RX_OVRD_IN_LO_RX_DATA_EN		BIT(5)
>  #define PHY_RX_OVRD_IN_LO_RX_PLL_EN		BIT(3)
>  
> +static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie);
> +
I don't think this is strictly needed. Can you just move the placement
of the new imx6_pcie_clk_enable function in the file, such that we can
avoid the forward declaration?

>  static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, bool exp_val)
>  {
>  	struct dw_pcie *pci = imx6_pcie->pci;
> @@ -498,33 +500,12 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  		}
>  	}
>  
> -	ret = clk_prepare_enable(imx6_pcie->pcie_phy);
> -	if (ret) {
> -		dev_err(dev, "unable to enable pcie_phy clock\n");
> -		goto err_pcie_phy;
> -	}
> -
> -	ret = clk_prepare_enable(imx6_pcie->pcie_bus);
> +	ret = imx6_pcie_clk_enable(imx6_pcie);
>  	if (ret) {
> -		dev_err(dev, "unable to enable pcie_bus clock\n");
> -		goto err_pcie_bus;
> +		dev_err(dev, "unable to enable pcie clocks\n");
> +		goto err_clks;
>  	}
>  
> -	ret = clk_prepare_enable(imx6_pcie->pcie);
> -	if (ret) {
> -		dev_err(dev, "unable to enable pcie clock\n");
> -		goto err_pcie;
> -	}
> -
> -	ret = imx6_pcie_enable_ref_clk(imx6_pcie);
> -	if (ret) {
> -		dev_err(dev, "unable to enable pcie ref clock\n");
> -		goto err_ref_clk;
> -	}
> -
> -	/* allow the clocks to stabilize */
> -	usleep_range(200, 500);
> -
>  	/* Some boards don't have PCIe reset GPIO. */
>  	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
>  		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
> @@ -578,13 +559,7 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  
>  	return;
>  
> -err_ref_clk:
> -	clk_disable_unprepare(imx6_pcie->pcie);
> -err_pcie:
> -	clk_disable_unprepare(imx6_pcie->pcie_bus);
> -err_pcie_bus:
> -	clk_disable_unprepare(imx6_pcie->pcie_phy);
> -err_pcie_phy:
> +err_clks:
>  	if (imx6_pcie->vpcie && regulator_is_enabled(imx6_pcie->vpcie) > 0) {
>  		ret = regulator_disable(imx6_pcie->vpcie);
>  		if (ret)
> @@ -914,6 +889,51 @@ static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
>  	usleep_range(1000, 10000);
>  }
>  
> +static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
> +{
> +	struct dw_pcie *pci = imx6_pcie->pci;
> +	struct device *dev = pci->dev;
> +	int ret;
> +
> +	ret = clk_prepare_enable(imx6_pcie->pcie_phy);
> +	if (ret) {
> +		dev_err(dev, "unable to enable pcie_phy clock\n");
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(imx6_pcie->pcie_bus);
> +	if (ret) {
> +		dev_err(dev, "unable to enable pcie_bus clock\n");
> +		goto err_pcie_bus;
> +	}
> +
> +	ret = clk_prepare_enable(imx6_pcie->pcie);
> +	if (ret) {
> +		dev_err(dev, "unable to enable pcie clock\n");
> +		goto err_pcie;
> +	}
> +
> +	ret = imx6_pcie_enable_ref_clk(imx6_pcie);
> +	if (ret) {
> +		dev_err(dev, "unable to enable pcie ref clock\n");
> +		goto err_ref_clk;
> +	}
> +
> +	/* allow the clocks to stabilize */
> +	usleep_range(200, 500);
> +	return 0;
> +
> +err_ref_clk:
> +	clk_disable_unprepare(imx6_pcie->pcie);
> +err_pcie:
> +	clk_disable_unprepare(imx6_pcie->pcie_bus);
> +err_pcie_bus:
> +	clk_disable_unprepare(imx6_pcie->pcie_phy);
> +
> +	return ret;
> +
Superfluous newline.

Regards,
Lucas
 
> +}
> +
>  static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
>  {
>  	clk_disable_unprepare(imx6_pcie->pcie);


