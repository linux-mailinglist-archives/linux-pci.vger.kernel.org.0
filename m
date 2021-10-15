Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C39F42FACA
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 20:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242478AbhJOSQC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 14:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237653AbhJOSQC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 14:16:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6E9C061570
        for <linux-pci@vger.kernel.org>; Fri, 15 Oct 2021 11:13:55 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1mbRiJ-0000MK-T4; Fri, 15 Oct 2021 20:13:51 +0200
Message-ID: <b1c38eb0cbded46d5f3c087e641b18cdb4f500ac.camel@pengutronix.de>
Subject: Re: [RESEND v2 1/5] PCI: imx6: Encapsulate the clock enable into
 one standalone function
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Date:   Fri, 15 Oct 2021 20:13:50 +0200
In-Reply-To: <1634277941-6672-2-git-send-email-hongxing.zhu@nxp.com>
References: <1634277941-6672-1-git-send-email-hongxing.zhu@nxp.com>
         <1634277941-6672-2-git-send-email-hongxing.zhu@nxp.com>
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
> No function changes, just encapsulate the i.MX PCIe clocks enable
> operations into one standalone function
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 79 ++++++++++++++++-----------
>  1 file changed, 48 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 26f49f797b0f..1fa1dba6da81 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -470,38 +470,16 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
>  	return ret;
>  }
>  
> -static void imx7d_pcie_wait_for_phy_pll_lock(struct imx6_pcie *imx6_pcie)
> -{
> -	u32 val;
> -	struct device *dev = imx6_pcie->pci->dev;
> -
> -	if (regmap_read_poll_timeout(imx6_pcie->iomuxc_gpr,
> -				     IOMUXC_GPR22, val,
> -				     val & IMX7D_GPR22_PCIE_PHY_PLL_LOCKED,
> -				     PHY_PLL_LOCK_WAIT_USLEEP_MAX,
> -				     PHY_PLL_LOCK_WAIT_TIMEOUT))
> -		dev_err(dev, "PCIe PLL lock timeout\n");
> -}
> -
> -static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
> +static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
>  {
>  	struct dw_pcie *pci = imx6_pcie->pci;
>  	struct device *dev = pci->dev;
>  	int ret;
>  
> -	if (imx6_pcie->vpcie && !regulator_is_enabled(imx6_pcie->vpcie)) {
> -		ret = regulator_enable(imx6_pcie->vpcie);
> -		if (ret) {
> -			dev_err(dev, "failed to enable vpcie regulator: %d\n",
> -				ret);
> -			return;
> -		}
> -	}
> -
>  	ret = clk_prepare_enable(imx6_pcie->pcie_phy);
>  	if (ret) {
>  		dev_err(dev, "unable to enable pcie_phy clock\n");
> -		goto err_pcie_phy;
> +		return ret;
>  	}
>  
>  	ret = clk_prepare_enable(imx6_pcie->pcie_bus);
> @@ -524,6 +502,51 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  
>  	/* allow the clocks to stabilize */
>  	usleep_range(200, 500);
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
> +}
> +
> +static void imx7d_pcie_wait_for_phy_pll_lock(struct imx6_pcie *imx6_pcie)
> +{
> +	u32 val;
> +	struct device *dev = imx6_pcie->pci->dev;
> +
> +	if (regmap_read_poll_timeout(imx6_pcie->iomuxc_gpr,
> +				     IOMUXC_GPR22, val,
> +				     val & IMX7D_GPR22_PCIE_PHY_PLL_LOCKED,
> +				     PHY_PLL_LOCK_WAIT_USLEEP_MAX,
> +				     PHY_PLL_LOCK_WAIT_TIMEOUT))
> +		dev_err(dev, "PCIe PLL lock timeout\n");
> +}
> +
> +static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
> +{
> +	struct dw_pcie *pci = imx6_pcie->pci;
> +	struct device *dev = pci->dev;
> +	int ret;
> +
> +	if (imx6_pcie->vpcie && !regulator_is_enabled(imx6_pcie->vpcie)) {
> +		ret = regulator_enable(imx6_pcie->vpcie);
> +		if (ret) {
> +			dev_err(dev, "failed to enable vpcie regulator: %d\n",
> +				ret);
> +			return;
> +		}
> +	}
> +
> +	ret = imx6_pcie_clk_enable(imx6_pcie);
> +	if (ret) {
> +		dev_err(dev, "unable to enable pcie clocks\n");
> +		goto err_clks;
> +	}
>  
>  	/* Some boards don't have PCIe reset GPIO. */
>  	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
> @@ -578,13 +601,7 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
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


