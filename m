Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFD85A792A
	for <lists+linux-pci@lfdr.de>; Wed, 31 Aug 2022 10:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiHaIgz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Aug 2022 04:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiHaIgz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Aug 2022 04:36:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9875180F43
        for <linux-pci@vger.kernel.org>; Wed, 31 Aug 2022 01:36:53 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1oTJDE-0008Cf-KV; Wed, 31 Aug 2022 10:36:40 +0200
Message-ID: <cbf7cc48acb1c772bea8594aa4017f56b4d1074e.camel@pengutronix.de>
Subject: Re: [PATCH v5 5/7] soc: imx: imx8mp-blk-ctrl: handle PCIe PHY resets
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, p.zabel@pengutronix.de,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        shawnguo@kernel.org, vkoul@kernel.org,
        alexander.stein@ew.tq-group.com, marex@denx.de,
        richard.leitner@linux.dev
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Date:   Wed, 31 Aug 2022 10:36:39 +0200
In-Reply-To: <1661845564-11373-6-git-send-email-hongxing.zhu@nxp.com>
References: <1661845564-11373-1-git-send-email-hongxing.zhu@nxp.com>
         <1661845564-11373-6-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Dienstag, dem 30.08.2022 um 15:46 +0800 schrieb Richard Zhu:
> From: Lucas Stach <l.stach@pengutronix.de>
> 
> Dessert the PHY reset when powering up the domain and put it back
> into reset when the domain is powered down.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

According to patch submission guidelines you need to add your own sign-
off when integrating this patch into your series. Please add in the
next revision.

Regards,
Lucas

> ---
>  drivers/soc/imx/imx8mp-blk-ctrl.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/soc/imx/imx8mp-blk-ctrl.c b/drivers/soc/imx/imx8mp-blk-ctrl.c
> index 4ca2ede6871b..6c939d68ba9a 100644
> --- a/drivers/soc/imx/imx8mp-blk-ctrl.c
> +++ b/drivers/soc/imx/imx8mp-blk-ctrl.c
> @@ -18,6 +18,8 @@
>  #define GPR_REG0		0x0
>  #define  PCIE_CLOCK_MODULE_EN	BIT(0)
>  #define  USB_CLOCK_MODULE_EN	BIT(1)
> +#define  PCIE_PHY_APB_RST	BIT(4)
> +#define  PCIE_PHY_INIT_RST	BIT(5)
>  
>  struct imx8mp_blk_ctrl_domain;
>  
> @@ -75,6 +77,10 @@ static void imx8mp_hsio_blk_ctrl_power_on(struct imx8mp_blk_ctrl *bc,
>  	case IMX8MP_HSIOBLK_PD_PCIE:
>  		regmap_set_bits(bc->regmap, GPR_REG0, PCIE_CLOCK_MODULE_EN);
>  		break;
> +	case IMX8MP_HSIOBLK_PD_PCIE_PHY:
> +		regmap_set_bits(bc->regmap, GPR_REG0,
> +				PCIE_PHY_APB_RST | PCIE_PHY_INIT_RST);
> +		break;
>  	default:
>  		break;
>  	}
> @@ -90,6 +96,10 @@ static void imx8mp_hsio_blk_ctrl_power_off(struct imx8mp_blk_ctrl *bc,
>  	case IMX8MP_HSIOBLK_PD_PCIE:
>  		regmap_clear_bits(bc->regmap, GPR_REG0, PCIE_CLOCK_MODULE_EN);
>  		break;
> +	case IMX8MP_HSIOBLK_PD_PCIE_PHY:
> +		regmap_clear_bits(bc->regmap, GPR_REG0,
> +				  PCIE_PHY_APB_RST | PCIE_PHY_INIT_RST);
> +		break;
>  	default:
>  		break;
>  	}


