Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D0A573202
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jul 2022 11:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbiGMJEi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jul 2022 05:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236043AbiGMJEg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2022 05:04:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26694E7AF2
        for <linux-pci@vger.kernel.org>; Wed, 13 Jul 2022 02:04:33 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1oBYIC-0008Su-7I; Wed, 13 Jul 2022 11:04:24 +0200
Message-ID: <c090c39d171b3bd248dc613c120660f07efc6b6c.camel@pengutronix.de>
Subject: Re: [PATCH v14 16/17] PCI: imx6: Move the imx6_pcie_ltssm_disable()
 earlier
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, bhelgaas@google.com,
        robh+dt@kernel.org, broonie@kernel.org, lorenzo.pieralisi@arm.com,
        festevam@gmail.com, francesco.dolcini@toradex.com
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Date:   Wed, 13 Jul 2022 11:04:22 +0200
In-Reply-To: <1656645935-1370-17-git-send-email-hongxing.zhu@nxp.com>
References: <1656645935-1370-1-git-send-email-hongxing.zhu@nxp.com>
         <1656645935-1370-17-git-send-email-hongxing.zhu@nxp.com>
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
> Move the imx6_pcie_ltssm_disable() earlier and place it just behind the
> imx6_pcie_ltssm_enable(), since it might not be only used by suspend
> callback directly.
> To be symmetric with imx6_pcie_ltssm_enable(), add the IMX6Q switch
> case in the imx6_pcie_ltssm_disable().
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 39 ++++++++++++++-------------
>  1 file changed, 20 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 79a05e190016..1cf8bf9035f2 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -805,6 +805,26 @@ static void imx6_pcie_ltssm_enable(struct device *dev)
>  	}
>  }
>  
> +static void imx6_pcie_ltssm_disable(struct device *dev)
> +{
> +	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
> +
> +	switch (imx6_pcie->drvdata->variant) {
> +	case IMX6Q:
> +	case IMX6SX:
> +	case IMX6QP:
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +				   IMX6Q_GPR12_PCIE_CTL_2, 0);
> +		break;
> +	case IMX7D:
> +	case IMX8MM:
> +		reset_control_assert(imx6_pcie->apps_reset);
> +		break;
This is missing the IMX8MQ case.

> +	default:
> +		dev_err(dev, "ltssm_disable not supported\n");

Drop the default, we want a compile time warning if a variant isn't
covered by this switch statement.

Regards,
Lucas

> +	}
> +}
> +
>  static int imx6_pcie_start_link(struct dw_pcie *pci)
>  {
>  	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
> @@ -947,25 +967,6 @@ static const struct dw_pcie_ops dw_pcie_ops = {
>  };
>  
>  #ifdef CONFIG_PM_SLEEP
> -static void imx6_pcie_ltssm_disable(struct device *dev)
> -{
> -	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
> -
> -	switch (imx6_pcie->drvdata->variant) {
> -	case IMX6SX:
> -	case IMX6QP:
> -		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -				   IMX6Q_GPR12_PCIE_CTL_2, 0);
> -		break;
> -	case IMX7D:
> -	case IMX8MM:
> -		reset_control_assert(imx6_pcie->apps_reset);
> -		break;
> -	default:
> -		dev_err(dev, "ltssm_disable not supported\n");
> -	}
> -}
> -
>  static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
>  {
>  	struct device *dev = imx6_pcie->pci->dev;


