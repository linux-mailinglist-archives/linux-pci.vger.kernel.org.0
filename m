Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620CA62F326
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 12:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbiKRLCr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 06:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241362AbiKRLCn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 06:02:43 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D28F98259
        for <linux-pci@vger.kernel.org>; Fri, 18 Nov 2022 03:02:42 -0800 (PST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1ovz8g-0006My-FH; Fri, 18 Nov 2022 12:02:30 +0100
Message-ID: <dda2cd20b823b002e4b2dccb69741707785a2474.camel@pengutronix.de>
Subject: Re: [PATCH v2] soc: imx: imx8mp-blk-ctrl: Add PCIe SYSPLL
 configurations
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, marcel.ziswiler@toradex.com,
        marex@denx.de, tharvey@gateworks.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, shawnguo@kernel.org,
        alexander.stein@ew.tq-group.com, richard.leitner@linux.dev
Cc:     devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Date:   Fri, 18 Nov 2022 12:02:27 +0100
In-Reply-To: <1668740199-31956-1-git-send-email-hongxing.zhu@nxp.com>
References: <1668740199-31956-1-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Freitag, dem 18.11.2022 um 10:56 +0800 schrieb Richard Zhu:
> Add PCIe SYSPLL configurations, thus the internal SYSPLL can be used as
> i.MX8MP PCIe reference clock.
> 
> The following properties of PHY dts node should be changed accordingly.
>   - Set 'fsl,refclk-pad-mode' as '<IMX8_PCIE_REFCLK_PAD_OUTPUT>'.
>   - Change 'clocks' to '<&clk IMX8MP_CLK_HSIO_AXI>'.

This is still not what I meant. There is no direct relation between the
PCIe PHY domain being powered up and the PCIe PLL being needed. The PLL
really only needs to be active when the reference clock isn't sourced
externally. So the HSIO blk-ctrl should expose a proper clock for the
PLL. As the PLL is effectively fixed rate it should be enough to expose
get_rate, prepare and unprepare clk ops.

The PHY should then point at the blk-ctrl as the reference clock
source.

Regards,
Lucas

> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
> v1->v2:
> Refer to Lucas' comments, don't expose IMX8MP_CLK_HSIO_ROOT to dts node.
> https://patchwork.ozlabs.org/project/linux-pci/patch/1666590189-1364-1-git-send-email-hongxing.zhu@nxp.com/
> 
> Use <&clk IMX8MP_CLK_HSIO_AXI> as referrence clock source when internal
> clock mode is used by i.MX8MP PCIe module.
> 
> Verified on i.MX8MP EVK board with removing R131/R132/R137/R138, and
> populating R135/R136.
> ---
>  drivers/soc/imx/imx8mp-blk-ctrl.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/soc/imx/imx8mp-blk-ctrl.c b/drivers/soc/imx/imx8mp-blk-ctrl.c
> index 0e3b6ba22f94..5ad20a8ea25e 100644
> --- a/drivers/soc/imx/imx8mp-blk-ctrl.c
> +++ b/drivers/soc/imx/imx8mp-blk-ctrl.c
> @@ -21,6 +21,16 @@
>  #define  USB_CLOCK_MODULE_EN	BIT(1)
>  #define  PCIE_PHY_APB_RST	BIT(4)
>  #define  PCIE_PHY_INIT_RST	BIT(5)
> +#define GPR_REG2		0x8
> +#define  P_PLL_MASK		GENMASK(5, 0)
> +#define  M_PLL_MASK		GENMASK(15, 6)
> +#define  S_PLL_MASK		GENMASK(18, 16)
> +#define  P_PLL			(0xc << 0)
> +#define  M_PLL			(0x320 << 6)
> +#define  S_PLL			(0x4 << 16)
> +#define GPR_REG3		0xc
> +#define  PLL_CKE		BIT(17)
> +#define  PLL_RST		BIT(31)
>  
>  struct imx8mp_blk_ctrl_domain;
>  
> @@ -86,6 +96,18 @@ static void imx8mp_hsio_blk_ctrl_power_on(struct imx8mp_blk_ctrl *bc,
>  	case IMX8MP_HSIOBLK_PD_PCIE_PHY:
>  		regmap_set_bits(bc->regmap, GPR_REG0,
>  				PCIE_PHY_APB_RST | PCIE_PHY_INIT_RST);
> +
> +		/* Set the PLL configurations, P = 12, M = 800, S = 4. */
> +		regmap_update_bits(bc->regmap, GPR_REG2,
> +				   P_PLL_MASK | M_PLL_MASK | S_PLL_MASK,
> +				   P_PLL | M_PLL | S_PLL);
> +		udelay(1);
> +
> +		regmap_update_bits(bc->regmap, GPR_REG3, PLL_RST, PLL_RST);
> +		udelay(10);
> +
> +		/* Set 1b'1 to pll_cke of GPR_REG3 */
> +		regmap_update_bits(bc->regmap, GPR_REG3, PLL_CKE, PLL_CKE);
>  		break;
>  	default:
>  		break;


