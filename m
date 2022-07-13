Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7FD5730BF
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jul 2022 10:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbiGMIRd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jul 2022 04:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235223AbiGMIRH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2022 04:17:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37F7ED168
        for <linux-pci@vger.kernel.org>; Wed, 13 Jul 2022 01:14:04 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1oBXVK-0007F4-Gg; Wed, 13 Jul 2022 10:13:54 +0200
Message-ID: <45a3906d333ab9d6331bc7f089be4914a33b8c7a.camel@pengutronix.de>
Subject: Re: [PATCH v14 01/17] PCI: imx6: Move imx6_pcie_grp_offset(),
 imx6_pcie_configure_type() earlier
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, bhelgaas@google.com,
        robh+dt@kernel.org, broonie@kernel.org, lorenzo.pieralisi@arm.com,
        festevam@gmail.com, francesco.dolcini@toradex.com
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Date:   Wed, 13 Jul 2022 10:13:53 +0200
In-Reply-To: <1656645935-1370-2-git-send-email-hongxing.zhu@nxp.com>
References: <1656645935-1370-1-git-send-email-hongxing.zhu@nxp.com>
         <1656645935-1370-2-git-send-email-hongxing.zhu@nxp.com>
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
> Move imx6_pcie_grp_offset() and imx6_pcie_configure_type() earlier in the
> file since they depend on nothing and are used by several other functions
> that will be moved earlier.  No functional change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Acked-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 50 +++++++++++++--------------
>  1 file changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 7a285fb0f619..8653ca8cbfb9 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -146,6 +146,31 @@ struct imx6_pcie {
>  #define PHY_RX_OVRD_IN_LO_RX_DATA_EN		BIT(5)
>  #define PHY_RX_OVRD_IN_LO_RX_PLL_EN		BIT(3)
>  
> +static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
> +{
> +	WARN_ON(imx6_pcie->drvdata->variant != IMX8MQ &&
> +		imx6_pcie->drvdata->variant != IMX8MM);
> +	return imx6_pcie->controller_id == 1 ? IOMUXC_GPR16 : IOMUXC_GPR14;
> +}
> +
> +static void imx6_pcie_configure_type(struct imx6_pcie *imx6_pcie)
> +{
> +	unsigned int mask, val;
> +
> +	if (imx6_pcie->drvdata->variant == IMX8MQ &&
> +	    imx6_pcie->controller_id == 1) {
> +		mask = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE;
> +		val  = FIELD_PREP(IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
> +				  PCI_EXP_TYPE_ROOT_PORT);
> +	} else {
> +		mask = IMX6Q_GPR12_DEVICE_TYPE;
> +		val  = FIELD_PREP(IMX6Q_GPR12_DEVICE_TYPE,
> +				  PCI_EXP_TYPE_ROOT_PORT);
> +	}
> +
> +	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, mask, val);
> +}
> +
>  static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, bool exp_val)
>  {
>  	struct dw_pcie *pci = imx6_pcie->pci;
> @@ -415,13 +440,6 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
>  					imx6_pcie->gpio_active_high);
>  }
>  
> -static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
> -{
> -	WARN_ON(imx6_pcie->drvdata->variant != IMX8MQ &&
> -		imx6_pcie->drvdata->variant != IMX8MM);
> -	return imx6_pcie->controller_id == 1 ? IOMUXC_GPR16 : IOMUXC_GPR14;
> -}
> -
>  static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
>  {
>  	struct dw_pcie *pci = imx6_pcie->pci;
> @@ -617,24 +635,6 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  	}
>  }
>  
> -static void imx6_pcie_configure_type(struct imx6_pcie *imx6_pcie)
> -{
> -	unsigned int mask, val;
> -
> -	if (imx6_pcie->drvdata->variant == IMX8MQ &&
> -	    imx6_pcie->controller_id == 1) {
> -		mask   = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE;
> -		val    = FIELD_PREP(IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
> -				    PCI_EXP_TYPE_ROOT_PORT);
> -	} else {
> -		mask = IMX6Q_GPR12_DEVICE_TYPE;
> -		val  = FIELD_PREP(IMX6Q_GPR12_DEVICE_TYPE,
> -				  PCI_EXP_TYPE_ROOT_PORT);
> -	}
> -
> -	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, mask, val);
> -}
> -
>  static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
>  {
>  	switch (imx6_pcie->drvdata->variant) {


