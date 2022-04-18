Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC09504EE0
	for <lists+linux-pci@lfdr.de>; Mon, 18 Apr 2022 12:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237709AbiDRKll (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Apr 2022 06:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiDRKlk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Apr 2022 06:41:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A363E15A31;
        Mon, 18 Apr 2022 03:39:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B272611F1;
        Mon, 18 Apr 2022 10:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89F3C385A8;
        Mon, 18 Apr 2022 10:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650278340;
        bh=kI59jYqj7rPLfRHyWTPL69LKjL3lZ4/Nnt35pCVLnBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jp7IJKFwT6c2TCPMTwuMO6BXKiO408/DU1GjgWcyArka9l8DEGMqGvJYSBQy9NUEx
         4MmsgFzxTyWL+FcJIRdARmZh0u46tsirEFTy2pkjEPMD9SOYdFbBvnHVlKvjTxQJ02
         XFqXCe/TB3NfBg+5+4GJzx2g9DXkO/l0NRke+PmWpNEFuJGLc3pufqwKuVZtWZgeNL
         BYeTqAmpETJzWlnhKNI1mIbkf68xILN/r78GDb86ZzZq7GDzwt8eFMA4JsDW9vZIiC
         NdP/FOCtjC7Qj+njg9e0x/zgZqhRIIaM4dalY2amSIb9kPBd6p+Za4pvdu6lAJTHhE
         1KHdkNdia9Vxg==
Date:   Mon, 18 Apr 2022 16:08:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     linux-rockchip@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [RFC/RFT 3/6] phy: rockchip: Support pcie v3
Message-ID: <Yl0/v2101wx6hy7B@matsya>
References: <20220416135458.104048-1-linux@fw-web.de>
 <20220416135458.104048-4-linux@fw-web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220416135458.104048-4-linux@fw-web.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 16-04-22, 15:54, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> RK3568 supports PCIe v3 using not Combphy like PCIe v2 on rk3566.
> It use a dedicated pcie-phy. Add support for this.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> driver was taken from linux 5.10 based on in
> https://github.com/JeffyCN/mirrors
> which now has disappeared
> ---
>  drivers/phy/rockchip/Kconfig                  |   9 +
>  drivers/phy/rockchip/Makefile                 |   1 +
>  .../phy/rockchip/phy-rockchip-snps-pcie3.c    | 278 ++++++++++++++++++
>  include/dt-bindings/phy/phy-snps-pcie3.h      |  21 ++
>  include/linux/phy/pcie.h                      |  12 +
>  5 files changed, 321 insertions(+)
>  create mode 100644 drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
>  create mode 100644 include/dt-bindings/phy/phy-snps-pcie3.h
>  create mode 100644 include/linux/phy/pcie.h
> 
> diff --git a/drivers/phy/rockchip/Kconfig b/drivers/phy/rockchip/Kconfig
> index 9022e395c056..94360fc96a6f 100644
> --- a/drivers/phy/rockchip/Kconfig
> +++ b/drivers/phy/rockchip/Kconfig
> @@ -83,6 +83,15 @@ config PHY_ROCKCHIP_PCIE
>  	help
>  	  Enable this to support the Rockchip PCIe PHY.
>  
> +config PHY_ROCKCHIP_SNPS_PCIE3
> +	tristate "Rockchip Snps PCIe3 PHY Driver"
> +	depends on (ARCH_ROCKCHIP && OF) || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	select GENERIC_PHY
> +	select MFD_SYSCON
> +	help
> +	  Enable this to support the Rockchip snps PCIe3 PHY.
> +
>  config PHY_ROCKCHIP_TYPEC
>  	tristate "Rockchip TYPEC PHY Driver"
>  	depends on OF && (ARCH_ROCKCHIP || COMPILE_TEST)
> diff --git a/drivers/phy/rockchip/Makefile b/drivers/phy/rockchip/Makefile
> index a5041efb5b8f..7eab129230d1 100644
> --- a/drivers/phy/rockchip/Makefile
> +++ b/drivers/phy/rockchip/Makefile
> @@ -8,5 +8,6 @@ obj-$(CONFIG_PHY_ROCKCHIP_INNO_HDMI)	+= phy-rockchip-inno-hdmi.o
>  obj-$(CONFIG_PHY_ROCKCHIP_INNO_USB2)	+= phy-rockchip-inno-usb2.o
>  obj-$(CONFIG_PHY_ROCKCHIP_NANENG_COMBO_PHY)	+= phy-rockchip-naneng-combphy.o
>  obj-$(CONFIG_PHY_ROCKCHIP_PCIE)		+= phy-rockchip-pcie.o
> +obj-$(CONFIG_PHY_ROCKCHIP_SNPS_PCIE3)	+= phy-rockchip-snps-pcie3.o
>  obj-$(CONFIG_PHY_ROCKCHIP_TYPEC)	+= phy-rockchip-typec.o
>  obj-$(CONFIG_PHY_ROCKCHIP_USB)		+= phy-rockchip-usb.o
> diff --git a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
> new file mode 100644
> index 000000000000..992b9709a97a
> --- /dev/null
> +++ b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
> @@ -0,0 +1,278 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Rockchip PCIE3.0 phy driver
> + *
> + * Copyright (C) 2020 Rockchip Electronics Co., Ltd.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/phy/pcie.h>
> +#include <linux/phy/phy.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +#include <dt-bindings/phy/phy-snps-pcie3.h>
> +
> +/* Register for RK3568 */
> +#define GRF_PCIE30PHY_CON1 0x4
> +#define GRF_PCIE30PHY_CON6 0x18
> +#define GRF_PCIE30PHY_CON9 0x24
> +#define GRF_PCIE30PHY_STATUS0 0x80
> +#define SRAM_INIT_DONE(reg) (reg & BIT(14))
> +
> +/* Register for RK3588 */
> +#define PHP_GRF_PCIESEL_CON 0x100
> +#define RK3588_PCIE3PHY_GRF_CMN_CON0 0x0
> +#define RK3588_PCIE3PHY_GRF_PHY0_STATUS1 0x904
> +#define RK3588_PCIE3PHY_GRF_PHY1_STATUS1 0xa04
> +#define RK3588_SRAM_INIT_DONE(reg) (reg & BIT(0))
> +
> +struct rockchip_p3phy_ops;
> +
> +struct rockchip_p3phy_priv {
> +	const struct rockchip_p3phy_ops *ops;
> +	void __iomem *mmio;
> +	/* mode: RC, EP */
> +	int mode;
> +	/* pcie30_phymode: Aggregation, Bifurcation */
> +	int pcie30_phymode;
> +	struct regmap *phy_grf;
> +	struct regmap *pipe_grf;
> +	struct reset_control *p30phy;
> +	struct phy *phy;
> +	struct clk_bulk_data *clks;
> +	int num_clks;
> +	bool is_bifurcation;
> +};
> +
> +struct rockchip_p3phy_ops {
> +	int (*phy_init)(struct rockchip_p3phy_priv *priv);
> +};
> +
> +static int rockchip_p3phy_set_mode(struct phy *phy, enum phy_mode mode, int submode)
> +{
> +	struct rockchip_p3phy_priv *priv = phy_get_drvdata(phy);
> +
> +	/* Actually We don't care EP/RC mode, but just record it */
> +	switch (submode) {
> +	case PHY_MODE_PCIE_RC:
> +		priv->mode = PHY_MODE_PCIE_RC;
> +		break;
> +	case PHY_MODE_PCIE_EP:
> +		priv->mode = PHY_MODE_PCIE_EP;
> +		break;
> +	case PHY_MODE_PCIE_BIFURCATION:
> +		priv->is_bifurcation = true;
> +		break;
> +	default:
> +		pr_info("%s, invalid mode\n", __func__);

this should be err log, also make it dev_err pls

> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rockchip_p3phy_rk3568_init(struct rockchip_p3phy_priv *priv)
> +{
> +	int ret = 0;

initialization seems superfluous

> +	u32 reg;
> +
> +	/* Deassert PCIe PMA output clamp mode */
> +	regmap_write(priv->phy_grf, GRF_PCIE30PHY_CON9,
> +		     (0x1 << 15) | (0x1 << 31));

magic numbers.. sounds like BIT(15) and BIT(31)


> +	/* Set bifurcation if needed, and it doesn't care RC/EP */
> +	if (priv->is_bifurcation) {
> +		regmap_write(priv->phy_grf, GRF_PCIE30PHY_CON6,
> +			     0x1 | (0xf << 16));
> +		regmap_write(priv->phy_grf, GRF_PCIE30PHY_CON1,
> +			     (0x1 << 15) | (0x1 << 31));
> +	}
> +
> +	reset_control_deassert(priv->p30phy);
> +
> +	ret = regmap_read_poll_timeout(priv->phy_grf,
> +				       GRF_PCIE30PHY_STATUS0,
> +				       reg, SRAM_INIT_DONE(reg),
> +				       0, 500);
> +	if (ret)
> +		pr_err("%s: lock failed 0x%x, check input refclk and power supply\n",
> +		       __func__, reg);

dev_err() pls

> +	return ret;
> +}
> +
> +static const struct rockchip_p3phy_ops rk3568_ops = {
> +	.phy_init = rockchip_p3phy_rk3568_init,
> +};
> +
> +static int rockchip_p3phy_rk3588_init(struct rockchip_p3phy_priv *priv)
> +{
> +	int ret = 0;

superfluous init again
-- 
~Vinod
