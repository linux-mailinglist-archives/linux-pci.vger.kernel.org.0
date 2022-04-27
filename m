Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4624D511F9E
	for <lists+linux-pci@lfdr.de>; Wed, 27 Apr 2022 20:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239422AbiD0PWQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Apr 2022 11:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239392AbiD0PWP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Apr 2022 11:22:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8225D2E4ED8
        for <linux-pci@vger.kernel.org>; Wed, 27 Apr 2022 08:19:03 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1njjRG-0008Jr-Tv; Wed, 27 Apr 2022 17:18:47 +0200
Message-ID: <87c9d9a3905f68bbf5be25558fe769ae314c46b2.camel@pengutronix.de>
Subject: Re: [PATCH v2 3/7] phy: freescale: imx8m-pcie: Add iMX8MP PCIe PHY
 support
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Hongxing Zhu <hongxing.zhu@nxp.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>
Cc:     "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Date:   Wed, 27 Apr 2022 17:18:45 +0200
In-Reply-To: <AS8PR04MB8676020964A9A0322AD543FA8CF39@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1646644054-24421-1-git-send-email-hongxing.zhu@nxp.com>
         <1646644054-24421-4-git-send-email-hongxing.zhu@nxp.com>
         <fb1cb6eebdb95def2d48b38ddc3b95398fde99d4.camel@pengutronix.de>
         <AS8PR04MB8676020964A9A0322AD543FA8CF39@AS8PR04MB8676.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
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

Hi Richard,

Am Montag, dem 18.04.2022 um 04:55 +0000 schrieb Hongxing Zhu:
> > -----Original Message-----
> > From: Lucas Stach <l.stach@pengutronix.de>
> > Sent: 2022年4月15日 4:59
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>; p.zabel@pengutronix.de;
> > bhelgaas@google.com; lorenzo.pieralisi@arm.com; robh@kernel.org;
> > shawnguo@kernel.org; vkoul@kernel.org; alexander.stein@ew.tq-group.com
> > Cc: linux-phy@lists.infradead.org; devicetree@vger.kernel.org;
> > linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; kernel@pengutronix.de; dl-linux-imx
> > <linux-imx@nxp.com>
> > Subject: Re: [PATCH v2 3/7] phy: freescale: imx8m-pcie: Add iMX8MP PCIe PHY
> > support
> > 
> > Am Montag, dem 07.03.2022 um 17:07 +0800 schrieb Richard Zhu:
> > > Add the i.MX8MP PCIe PHY support
> > > 
> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > ---
> > >  drivers/phy/freescale/phy-fsl-imx8m-pcie.c | 205
> > > ++++++++++++++++-----
> > >  1 file changed, 163 insertions(+), 42 deletions(-)
> > > 
> > > diff --git a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> > > b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> > > index 04b1aafb29f4..3d01da4323a6 100644
> > > --- a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> > > +++ b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> > > @@ -11,6 +11,8 @@
> > >  #include <linux/mfd/syscon.h>
> > >  #include <linux/mfd/syscon/imx7-iomuxc-gpr.h>
> > >  #include <linux/module.h>
> > > +#include <linux/of_address.h>
> > > +#include <linux/of_device.h>
> > >  #include <linux/phy/phy.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/regmap.h>
> > > @@ -30,12 +32,10 @@
> > >  #define IMX8MM_PCIE_PHY_CMN_REG065	0x194
> > >  #define  ANA_AUX_RX_TERM		(BIT(7) | BIT(4))
> > >  #define  ANA_AUX_TX_LVL			GENMASK(3, 0)
> > > -#define IMX8MM_PCIE_PHY_CMN_REG75	0x1D4
> > > -#define  PCIE_PHY_CMN_REG75_PLL_DONE	0x3
> > > +#define IMX8MM_PCIE_PHY_CMN_REG075	0x1D4
> > > +#define  ANA_PLL_DONE			0x3
> > 
> > Why do you drop the register prefix from the name here?
> To prevent the codes from exceeding the 80 columns and align with the other
>  bit definitions, drop the prefix and keep the bit definitions as short as
>  possible.
> 
> > 
> > >  #define PCIE_PHY_TRSV_REG5		0x414
> > > -#define  PCIE_PHY_TRSV_REG5_GEN1_DEEMP	0x2D
> > >  #define PCIE_PHY_TRSV_REG6		0x418
> > > -#define  PCIE_PHY_TRSV_REG6_GEN2_DEEMP	0xF
> > > 
> > >  #define IMX8MM_GPR_PCIE_REF_CLK_SEL	GENMASK(25, 24)
> > >  #define IMX8MM_GPR_PCIE_REF_CLK_PLL
> > 	FIELD_PREP(IMX8MM_GPR_PCIE_REF_CLK_SEL, 0x3)
> > > @@ -46,16 +46,43 @@
> > >  #define IMX8MM_GPR_PCIE_SSC_EN		BIT(16)
> > >  #define IMX8MM_GPR_PCIE_AUX_EN_OVERRIDE	BIT(9)
> > > 
> > > +#define IMX8MP_GPR_REG0			0x0
> > > +#define IMX8MP_GPR_CLK_MOD_EN		BIT(0)
> > > +#define IMX8MP_GPR_PHY_APB_RST		BIT(4)
> > > +#define IMX8MP_GPR_PHY_INIT_RST		BIT(5)
> > > +#define IMX8MP_GPR_REG1			0x4
> > > +#define IMX8MP_GPR_PM_EN_CORE_CLK	BIT(0)
> > > +#define IMX8MP_GPR_PLL_LOCK		BIT(13)
> > > +#define IMX8MP_GPR_REG2			0x8
> > > +#define IMX8MP_GPR_P_PLL_MASK		GENMASK(5, 0)
> > > +#define IMX8MP_GPR_M_PLL_MASK		GENMASK(15, 6)
> > > +#define IMX8MP_GPR_S_PLL_MASK		GENMASK(18, 16)
> > > +#define IMX8MP_GPR_P_PLL		(0xc << 0)
> > > +#define IMX8MP_GPR_M_PLL		(0x320 << 6)
> > > +#define IMX8MP_GPR_S_PLL		(0x4 << 16)
> > > +#define IMX8MP_GPR_REG3			0xc
> > > +#define IMX8MP_GPR_PLL_CKE		BIT(17)
> > > +#define IMX8MP_GPR_PLL_RST		BIT(31)
> > > +
> > > +enum imx8_pcie_phy_type {
> > > +	IMX8MM,
> > > +	IMX8MP,
> > > +};
> > > +
> > >  struct imx8_pcie_phy {
> > >  	void __iomem		*base;
> > > +	struct device		*dev;
> > >  	struct clk		*clk;
> > >  	struct phy		*phy;
> > > +	struct regmap		*hsio_blk_ctrl;
> > >  	struct regmap		*iomuxc_gpr;
> > >  	struct reset_control	*reset;
> > > +	struct reset_control	*perst;
> > >  	u32			refclk_pad_mode;
> > >  	u32			tx_deemph_gen1;
> > >  	u32			tx_deemph_gen2;
> > >  	bool			clkreq_unused;
> > > +	enum imx8_pcie_phy_type	variant;
> > >  };
> > > 
> > >  static int imx8_pcie_phy_init(struct phy *phy) @@ -67,6 +94,87 @@
> > > static int imx8_pcie_phy_init(struct phy *phy)
> > >  	reset_control_assert(imx8_phy->reset);
> > > 
> > >  	pad_mode = imx8_phy->refclk_pad_mode;
> > > +	switch (imx8_phy->variant) {
> > > +	case IMX8MM:
> > > +		/* Tune PHY de-emphasis setting to pass PCIe compliance. */
> > > +		if (imx8_phy->tx_deemph_gen1)
> > > +			writel(imx8_phy->tx_deemph_gen1,
> > > +			       imx8_phy->base + PCIE_PHY_TRSV_REG5);
> > > +		if (imx8_phy->tx_deemph_gen2)
> > > +			writel(imx8_phy->tx_deemph_gen2,
> > > +			       imx8_phy->base + PCIE_PHY_TRSV_REG6);
> > > +		break;
> > > +	case IMX8MP:
> > > +		reset_control_assert(imx8_phy->perst);
> > 
> > Could you tell us something more about this reset. What exactly is it resetting.
> > Do we really need to assert it before starting the HSIO PLL?
> Yes, this reset should be asserted, otherwise, the PCIe wouldn't work.
> I'm asking more details of this reset bit from design team, and would update
>  later after I get the response.
> 
> > AFAICS the PLL should be pretty much independent of the PHY.
> Agree.
> 
> > 
> > Do we need to enable this PLL when the PHY gets an external refclock? I
> > couldn't test it yet, but I suspect that the HSIO PLL is only needed as an
> > internal reference, when the i.MX8MP is the refclock source, either through
> > the PHY pads or via a clkout from the PLL.
> > 
> Refer to my experience, the HSIO PLL should be enabled firstly.
> 
> > > +		/* Set P=12,M=800,S=4 and must set ICP=2'b01. */
> > > +		regmap_update_bits(imx8_phy->hsio_blk_ctrl, IMX8MP_GPR_REG2,
> > > +				   IMX8MP_GPR_P_PLL_MASK |
> > > +				   IMX8MP_GPR_M_PLL_MASK |
> > > +				   IMX8MP_GPR_S_PLL_MASK,
> > > +				   IMX8MP_GPR_P_PLL |
> > > +				   IMX8MP_GPR_M_PLL |
> > > +				   IMX8MP_GPR_S_PLL);
> > > +		/* wait greater than 1/F_FREF =1/2MHZ=0.5us */
> > > +		udelay(1);
> > > +
> > > +		regmap_update_bits(imx8_phy->hsio_blk_ctrl, IMX8MP_GPR_REG3,
> > > +				   IMX8MP_GPR_PLL_RST,
> > > +				   IMX8MP_GPR_PLL_RST);
> > > +		udelay(10);
> > > +
> > > +		/* Set 1 to pll_cke of GPR_REG3 */
> > > +		regmap_update_bits(imx8_phy->hsio_blk_ctrl, IMX8MP_GPR_REG3,
> > > +				   IMX8MP_GPR_PLL_CKE,
> > > +				   IMX8MP_GPR_PLL_CKE);
> > > +
> > > +		/* Lock time should be greater than 300cycle=300*0.5us=150us */
> > > +		ret = regmap_read_poll_timeout(imx8_phy->hsio_blk_ctrl,
> > > +					     IMX8MP_GPR_REG1, val,
> > > +					     val & IMX8MP_GPR_PLL_LOCK,
> > > +					     10, 1000);
> > > +		if (ret) {
> > > +			dev_err(imx8_phy->dev, "PCIe PLL lock timeout\n");
> > > +			return ret;
> > > +		}
> > > +
> > > +		/* pcie_clock_module_en */
> > > +		regmap_update_bits(imx8_phy->hsio_blk_ctrl, IMX8MP_GPR_REG0,
> > > +				   IMX8MP_GPR_CLK_MOD_EN,
> > > +				   IMX8MP_GPR_CLK_MOD_EN);
> > 
> > You shouldn't need to touch this bit. The HSIO blk-ctrl already enables this bit
> > when the PCIe power-domain is powered up.
> Okay, got that.
> 
> > 
> > > +		udelay(10);
> > > +
> > > +		reset_control_deassert(imx8_phy->reset);
> > > +		reset_control_deassert(imx8_phy->perst);
> > > +
> > > +		/* release pcie_phy_apb_reset and pcie_phy_init_resetn */
> > > +		regmap_update_bits(imx8_phy->hsio_blk_ctrl, IMX8MP_GPR_REG0,
> > > +				   IMX8MP_GPR_PHY_APB_RST |
> > > +				   IMX8MP_GPR_PHY_INIT_RST,
> > > +				   IMX8MP_GPR_PHY_APB_RST |
> > > +				   IMX8MP_GPR_PHY_INIT_RST);
> > 
> > Not sure about those yet. We might want to toggle them via a virtual PD in the
> > HSIO blk-ctrl.
> Refer to my understand, these reset should be a part of power-up sequence of
>  the PHY. It's reasonable to toggle them via a PD.

So I had a chance to look into why this series isn't working for me
some more.

It seems the full PHY initialization fails, as the complete PHY MMIO
region reads back as 0xff. This hints at either a missing clock, or
(more likely) the register interface of the PHY being held in reset.
Note that I'm running upstream TF-A and the Barebox bootloader, so this
might be a missing initialization somewhere, that is done by downstream
TF-A or U-Boot.

Sadly the above bits are also not documented in the RM, but are marked
as reserved. By chance, do you know about any other secondary
clocks/resets that may have an impact on PCIe?

Regards,
Lucas

