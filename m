Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A995428B6
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 09:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbiFHH6X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 03:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiFHH6D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 03:58:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9A81E225B
        for <linux-pci@vger.kernel.org>; Wed,  8 Jun 2022 00:27:08 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1nyq5j-0007gI-Ff; Wed, 08 Jun 2022 09:26:59 +0200
Message-ID: <2427cef355dc1b9d1667a2c80448d2e23b97c447.camel@pengutronix.de>
Subject: Re: [PATCH v9 5/8] PCI: imx6: Refine the regulator usage
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, bhelgaas@google.com,
        robh+dt@kernel.org, broonie@kernel.org, lorenzo.pieralisi@arm.com,
        jingoohan1@gmail.com, festevam@gmail.com,
        francesco.dolcini@toradex.com
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Date:   Wed, 08 Jun 2022 09:26:58 +0200
In-Reply-To: <1651801629-30223-6-git-send-email-hongxing.zhu@nxp.com>
References: <1651801629-30223-1-git-send-email-hongxing.zhu@nxp.com>
         <1651801629-30223-6-git-send-email-hongxing.zhu@nxp.com>
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
> The driver should undo any enables it did itself. The regulator disable
> shouldn't be basing decisions on regulator_is_enabled().
> 
> To keep the balance of the regulator usage counter, disable the regulator
> just behind of imx6_pcie_assert_core_reset() in resume and shutdown.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 7005a7910003..3ce3993d5797 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -369,8 +369,6 @@ static int imx6_pcie_attach_pd(struct device *dev)
>  
>  static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
>  {
> -	struct device *dev = imx6_pcie->pci->dev;
> -
>  	switch (imx6_pcie->drvdata->variant) {
>  	case IMX7D:
>  	case IMX8MQ:
> @@ -400,14 +398,6 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
>  				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 0 << 16);
>  		break;
>  	}
> -
> -	if (imx6_pcie->vpcie && regulator_is_enabled(imx6_pcie->vpcie) > 0) {
> -		int ret = regulator_disable(imx6_pcie->vpcie);
> -
> -		if (ret)
> -			dev_err(dev, "failed to disable vpcie regulator: %d\n",
> -				ret);
> -	}
>  }
>  
>  static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
> @@ -580,7 +570,7 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  	struct device *dev = pci->dev;
>  	int ret, err;
>  
> -	if (imx6_pcie->vpcie && !regulator_is_enabled(imx6_pcie->vpcie)) {
> +	if (imx6_pcie->vpcie) {
>  		ret = regulator_enable(imx6_pcie->vpcie);
>  		if (ret) {
>  			dev_err(dev, "failed to enable vpcie regulator: %d\n",
> @@ -653,7 +643,7 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  	return 0;
>  
>  err_clks:
> -	if (imx6_pcie->vpcie && regulator_is_enabled(imx6_pcie->vpcie) > 0) {
> +	if (imx6_pcie->vpcie) {
>  		ret = regulator_disable(imx6_pcie->vpcie);
>  		if (ret)
>  			dev_err(dev, "failed to disable vpcie regulator: %d\n",
> @@ -1026,6 +1016,9 @@ static int imx6_pcie_resume_noirq(struct device *dev)
>  		return 0;
>  
>  	imx6_pcie_assert_core_reset(imx6_pcie);
> +	if (imx6_pcie->vpcie)
> +		regulator_disable(imx6_pcie->vpcie);
> +
This one looks misplaced. Surely you want the regulator to be on when
resuming the PCIe subsystem. Isn't this just papering over a wrong
usage count here, because there is no regulator_disable in
imx6_pcie_suspend_noirq, where I would expect this to happen?

Regards,
Lucas

>  	imx6_pcie_init_phy(imx6_pcie);
>  	imx6_pcie_deassert_core_reset(imx6_pcie);
>  	dw_pcie_setup_rc(pp);
> @@ -1259,6 +1252,8 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
>  
>  	/* bring down link, so bootloader gets clean state in case of reboot */
>  	imx6_pcie_assert_core_reset(imx6_pcie);
> +	if (imx6_pcie->vpcie)
> +		regulator_disable(imx6_pcie->vpcie);
>  }
>  
>  static const struct imx6_pcie_drvdata drvdata[] = {


