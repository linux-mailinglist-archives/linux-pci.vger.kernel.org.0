Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A705730DD
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jul 2022 10:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235545AbiGMIVq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jul 2022 04:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235384AbiGMIVJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2022 04:21:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4E184EC6
        for <linux-pci@vger.kernel.org>; Wed, 13 Jul 2022 01:17:38 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1oBXYq-0008P4-DS; Wed, 13 Jul 2022 10:17:32 +0200
Message-ID: <20ce8aae480ba224392ec86b279a72bd4cc0e573.camel@pengutronix.de>
Subject: Re: [PATCH v14 05/17] PCI: imx6: Factor out ref clock disable to
 match enable
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, bhelgaas@google.com,
        robh+dt@kernel.org, broonie@kernel.org, lorenzo.pieralisi@arm.com,
        festevam@gmail.com, francesco.dolcini@toradex.com
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Date:   Wed, 13 Jul 2022 10:17:31 +0200
In-Reply-To: <1656645935-1370-6-git-send-email-hongxing.zhu@nxp.com>
References: <1656645935-1370-1-git-send-email-hongxing.zhu@nxp.com>
         <1656645935-1370-6-git-send-email-hongxing.zhu@nxp.com>
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
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> The PCIe ref clocks are specific to different variants.  The enables are
> already split out into imx6_pcie_enable_ref_clk(), but the disables were
> combined with the more generic bus/phy/pcie clock disables in
> imx6_pcie_clk_disable().
> 
> Split out the variant-specific disables into imx6_pcie_disable_ref_clk() to
> match imx6_pcie_enable_ref_clk().
> 
> No functional change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Acked-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 38f208eea2d7..f458461880dc 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -580,12 +580,8 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
>  	return ret;
>  }
>  
> -static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
> +static void imx6_pcie_disable_ref_clk(struct imx6_pcie *imx6_pcie)
>  {
> -	clk_disable_unprepare(imx6_pcie->pcie);
> -	clk_disable_unprepare(imx6_pcie->pcie_phy);
> -	clk_disable_unprepare(imx6_pcie->pcie_bus);
> -
>  	switch (imx6_pcie->drvdata->variant) {
>  	case IMX6SX:
>  		clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
> @@ -595,8 +591,8 @@ static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
>  				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
>  				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
>  		break;
> -	case IMX8MQ:
>  	case IMX8MM:
> +	case IMX8MQ:
>  		clk_disable_unprepare(imx6_pcie->pcie_aux);
>  		break;
>  	default:
> @@ -604,6 +600,14 @@ static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
>  	}
>  }
>  
> +static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
> +{
> +	clk_disable_unprepare(imx6_pcie->pcie);
> +	clk_disable_unprepare(imx6_pcie->pcie_phy);
> +	clk_disable_unprepare(imx6_pcie->pcie_bus);
> +	imx6_pcie_disable_ref_clk(imx6_pcie);
> +}
> +
>  static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
>  {
>  	struct device *dev = imx6_pcie->pci->dev;


