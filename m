Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F91573133
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jul 2022 10:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbiGMIej (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jul 2022 04:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234501AbiGMIe3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2022 04:34:29 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5B3A44CE
        for <linux-pci@vger.kernel.org>; Wed, 13 Jul 2022 01:34:28 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1oBXp8-0003AZ-3C; Wed, 13 Jul 2022 10:34:22 +0200
Message-ID: <6f0cd4c69e0eba3e5da513cfbbe5f162e650a8f1.camel@pengutronix.de>
Subject: Re: [PATCH v14 10/17] PCI: imx6: Turn off regulator when system is
 in suspend mode
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, bhelgaas@google.com,
        robh+dt@kernel.org, broonie@kernel.org, lorenzo.pieralisi@arm.com,
        festevam@gmail.com, francesco.dolcini@toradex.com
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Date:   Wed, 13 Jul 2022 10:34:20 +0200
In-Reply-To: <1656645935-1370-11-git-send-email-hongxing.zhu@nxp.com>
References: <1656645935-1370-1-git-send-email-hongxing.zhu@nxp.com>
         <1656645935-1370-11-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
> The driver should undo any enables it did itself. The regulator disable
> shouldn't be basing decisions on regulator_is_enabled().
> 
> Move the regulator_disable to the suspend function, turn off regulator when
> the system is in suspend mode.
> 
> To keep the balance of the regulator usage counter, disable the regulator
> in shutdown.
> 
> Link: https://lore.kernel.org/r/1655189942-12678-6-git-send-email-hongxing.z
> hu@nxp.com
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 2b42c37f1617..f72eb609769b 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -670,8 +670,6 @@ static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
>  
>  static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
>  {
> -	struct device *dev = imx6_pcie->pci->dev;
> -
>  	switch (imx6_pcie->drvdata->variant) {
>  	case IMX7D:
>  	case IMX8MQ:
> @@ -702,14 +700,6 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
>  		break;
>  	}
>  
> -	if (imx6_pcie->vpcie && regulator_is_enabled(imx6_pcie->vpcie) > 0) {
> -		int ret = regulator_disable(imx6_pcie->vpcie);
> -
> -		if (ret)
> -			dev_err(dev, "failed to disable vpcie regulator: %d\n",
> -				ret);
> -	}
> -
>  	/* Some boards don't have PCIe reset GPIO. */
>  	if (gpio_is_valid(imx6_pcie->reset_gpio))
>  		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
> @@ -722,7 +712,7 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  	struct device *dev = pci->dev;
>  	int ret;
>  
> -	if (imx6_pcie->vpcie && !regulator_is_enabled(imx6_pcie->vpcie)) {
> +	if (imx6_pcie->vpcie) {
>  		ret = regulator_enable(imx6_pcie->vpcie);
>  		if (ret) {
>  			dev_err(dev, "failed to enable vpcie regulator: %d\n",

The regulator really has nothing to do with the core reset. Please move
this regulator enable into imx6_pcie_host_init().

> @@ -795,7 +785,7 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  	return 0;
>  
>  err_clks:
> -	if (imx6_pcie->vpcie && regulator_is_enabled(imx6_pcie->vpcie) > 0) {
> +	if (imx6_pcie->vpcie) {
>  		ret = regulator_disable(imx6_pcie->vpcie);
>  		if (ret)
>  			dev_err(dev, "failed to disable vpcie regulator: %d\n",
> @@ -1022,6 +1012,9 @@ static int imx6_pcie_suspend_noirq(struct device *dev)
>  		break;
>  	}
>  
> +	if (imx6_pcie->vpcie)
> +		regulator_disable(imx6_pcie->vpcie);
> +
>  	return 0;
>  }
>  
> @@ -1268,6 +1261,8 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
>  
>  	/* bring down link, so bootloader gets clean state in case of reboot */
>  	imx6_pcie_assert_core_reset(imx6_pcie);
> +	if (imx6_pcie->vpcie)
> +		regulator_disable(imx6_pcie->vpcie);

This looks like a separate change, not mentioned in the commit message.
I'm not sure if we should do this. Shutdown is supposed to just stop
the device, which is already achieved by
imx6_pcie_assert_core_reset(). 

If we would want to do a full cleanup here we would also need to
disable clocks and get the reset GPIO into asserted state. I don't
think we want to do all of this here.

Regards,
Lucas
>  }
>  
>  static const struct imx6_pcie_drvdata drvdata[] = {


