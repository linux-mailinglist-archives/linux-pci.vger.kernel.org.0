Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93BC57315C
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jul 2022 10:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbiGMImO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jul 2022 04:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235637AbiGMIlc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2022 04:41:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F478EF9E3
        for <linux-pci@vger.kernel.org>; Wed, 13 Jul 2022 01:41:15 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1oBXvg-0004GD-PG; Wed, 13 Jul 2022 10:41:08 +0200
Message-ID: <2cfe481fdbd074ef6ff7e95bf32b5c99e6a26aca.camel@pengutronix.de>
Subject: Re: [PATCH v14 11/17] PCI: imx6: Move regulator enable out of
 imx6_pcie_deassert_core_reset()
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, bhelgaas@google.com,
        robh+dt@kernel.org, broonie@kernel.org, lorenzo.pieralisi@arm.com,
        festevam@gmail.com, francesco.dolcini@toradex.com
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Date:   Wed, 13 Jul 2022 10:41:07 +0200
In-Reply-To: <1656645935-1370-12-git-send-email-hongxing.zhu@nxp.com>
References: <1656645935-1370-1-git-send-email-hongxing.zhu@nxp.com>
         <1656645935-1370-12-git-send-email-hongxing.zhu@nxp.com>
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
> Move regulator enable out of imx6_pcie_deassert_core_reset(), since the
> regulator_enable() has nothing to do in with
> imx6_pcie_deassert_core_reset().
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Ah, so you are doing things in two steps. Disregard my first comment on
the last patch then.

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 36 ++++++++++++---------------
>  1 file changed, 16 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index f72eb609769b..0b168f0d57b8 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -712,19 +712,10 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  	struct device *dev = pci->dev;
>  	int ret;
>  
> -	if (imx6_pcie->vpcie) {
> -		ret = regulator_enable(imx6_pcie->vpcie);
> -		if (ret) {
> -			dev_err(dev, "failed to enable vpcie regulator: %d\n",
> -				ret);
> -			return ret;
> -		}
> -	}
> -
>  	ret = imx6_pcie_clk_enable(imx6_pcie);
>  	if (ret) {
>  		dev_err(dev, "unable to enable pcie clocks: %d\n", ret);
> -		goto err_clks;
> +		return ret;
>  	}
>  
>  	switch (imx6_pcie->drvdata->variant) {
> @@ -783,15 +774,6 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  	}
>  
>  	return 0;
> -
> -err_clks:
> -	if (imx6_pcie->vpcie) {
> -		ret = regulator_disable(imx6_pcie->vpcie);
> -		if (ret)
> -			dev_err(dev, "failed to disable vpcie regulator: %d\n",
> -				ret);
> -	}
> -	return ret;
>  }
>  
>  static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6_pcie)
> @@ -916,15 +898,29 @@ static int imx6_pcie_host_init(struct pcie_port *pp)
>  
>  	imx6_pcie_assert_core_reset(imx6_pcie);
>  	imx6_pcie_init_phy(imx6_pcie);
> +	if (imx6_pcie->vpcie) {
> +		ret = regulator_enable(imx6_pcie->vpcie);
> +		if (ret) {
> +			dev_err(dev, "failed to enable vpcie regulator: %d\n",
> +				ret);
> +			return ret;

If the regulator enable fails, you don't roll back the PHY init and
core reset. This seems harmless now, but might have unintended
consequences if the PHY code changes. I think it should be safe to move
the regulator enable before the PHY init and core reset assert to avoid
introducing more failure cleanup paths here.

Regards,
Lucas

> +		}
> +	}
> +
>  	ret = imx6_pcie_deassert_core_reset(imx6_pcie);
>  	if (ret < 0) {
>  		dev_err(dev, "pcie deassert core reset failed: %d\n", ret);
> -		return ret;
> +		goto err_reg_disable;
>  	}
>  
>  	imx6_setup_phy_mpll(imx6_pcie);
>  
>  	return 0;
> +
> +err_reg_disable:
> +	if (imx6_pcie->vpcie)
> +		regulator_disable(imx6_pcie->vpcie);
> +	return ret;
>  }
>  
>  static const struct dw_pcie_host_ops imx6_pcie_host_ops = {


