Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B92912A000
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2019 11:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfLXKK3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Dec 2019 05:10:29 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:56368 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfLXKK3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Dec 2019 05:10:29 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBOAA8eI096351;
        Tue, 24 Dec 2019 04:10:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577182208;
        bh=MzpQwSRlWp3D6Tohz9Pt7HsIANNx0KCV8CI4TAZS0DI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=E89ih72FMNkNcvLnDnPxbzowCmHlI1AeygJHwWr0WetMkmWNkoZLxPApB5jkYSgCs
         r/09DEEFDO3LVIhduLY17F0ed0/GtNal9o4jWCPuUssJO3QXh2/gN/4ZsUi3y+LfP8
         aYmSgAkdU8k357xym+RWhv5h6Nk3GKqWtXFEojs8=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBOAA8tQ115465
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Dec 2019 04:10:08 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 24
 Dec 2019 04:10:08 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 24 Dec 2019 04:10:08 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBOAA4ei100519;
        Tue, 24 Dec 2019 04:10:05 -0600
Subject: Re: [PATCH v2 2/3] phy: amlogic: Add Amlogic AXG PCIE PHY Driver
To:     Remi Pommarel <repk@triplefau.lt>, Yue Wang <yue.wang@Amlogic.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     Jerome Brunet <jbrunet@baylibre.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>
References: <20191223214529.20377-1-repk@triplefau.lt>
 <20191223214529.20377-3-repk@triplefau.lt>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <0bf30bee-500c-db91-6647-42ff09e9c8e0@ti.com>
Date:   Tue, 24 Dec 2019 15:42:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20191223214529.20377-3-repk@triplefau.lt>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 24/12/19 3:15 AM, Remi Pommarel wrote:
> This adds support for the PCI PHY found in the Amlogic AXG SoC Family.
> This will allow to mutualize code in pci-meson.c between AXG and G12A
> SoC.
> 
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> ---
>  drivers/phy/amlogic/Kconfig              |  11 ++
>  drivers/phy/amlogic/Makefile             |   1 +
>  drivers/phy/amlogic/phy-meson-axg-pcie.c | 163 +++++++++++++++++++++++
>  3 files changed, 175 insertions(+)
>  create mode 100644 drivers/phy/amlogic/phy-meson-axg-pcie.c
> 
> diff --git a/drivers/phy/amlogic/Kconfig b/drivers/phy/amlogic/Kconfig
> index 1eeb75d018e3..2a3935169ef4 100644
> --- a/drivers/phy/amlogic/Kconfig
> +++ b/drivers/phy/amlogic/Kconfig
> @@ -60,6 +60,17 @@ config PHY_MESON_G12A_USB3_PCIE
>  	  in Meson G12A SoCs.
>  	  If unsure, say N.
>  
> +config PHY_MESON_AXG_PCIE
> +	tristate "Meson AXG PCIE PHY driver"
> +	default ARCH_MESON
> +	depends on OF && (ARCH_MESON || COMPILE_TEST)
> +	select GENERIC_PHY
> +	select REGMAP_MMIO
> +	help
> +	  Enable this to support the Meson MIPI + PCIE PHY found
> +	  in Meson AXG SoCs.
> +	  If unsure, say N.
> +
>  config PHY_MESON_AXG_MIPI_PCIE
>  	tristate "Meson AXG MIPI + PCIE PHY driver"
>  	default ARCH_MESON
> diff --git a/drivers/phy/amlogic/Makefile b/drivers/phy/amlogic/Makefile
> index 2167330a0ae8..5fd3a6dca0a5 100644
> --- a/drivers/phy/amlogic/Makefile
> +++ b/drivers/phy/amlogic/Makefile
> @@ -4,4 +4,5 @@ obj-$(CONFIG_PHY_MESON_GXL_USB2)	+= phy-meson-gxl-usb2.o
>  obj-$(CONFIG_PHY_MESON_G12A_USB2)	+= phy-meson-g12a-usb2.o
>  obj-$(CONFIG_PHY_MESON_GXL_USB3)	+= phy-meson-gxl-usb3.o
>  obj-$(CONFIG_PHY_MESON_G12A_USB3_PCIE)	+= phy-meson-g12a-usb3-pcie.o
> +obj-$(CONFIG_PHY_MESON_AXG_PCIE)	+= phy-meson-axg-pcie.o
>  obj-$(CONFIG_PHY_MESON_AXG_MIPI_PCIE)	+= phy-meson-axg-mipi-pcie.o
> diff --git a/drivers/phy/amlogic/phy-meson-axg-pcie.c b/drivers/phy/amlogic/phy-meson-axg-pcie.c
> new file mode 100644
> index 000000000000..559c42c1524d
> --- /dev/null
> +++ b/drivers/phy/amlogic/phy-meson-axg-pcie.c
> @@ -0,0 +1,163 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Amlogic AXG PCIE PHY driver
> + *
> + * Copyright (C) 2019 Remi Pommarel <repk@triplefau.lt>
> + */
> +#include <linux/module.h>
> +#include <linux/phy/phy.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +#include <linux/platform_device.h>
> +#include <linux/bitfield.h>
> +#include <dt-bindings/phy/phy.h>
> +
> +#define MESON_PCIE_REG0 0x00
> +#define		MESON_PCIE_COMMON_CLK	BIT(4)
> +#define		MESON_PCIE_PORT_SEL	GENMASK(3, 2)
> +#define		MESON_PCIE_CLK		BIT(1)
> +#define		MESON_PCIE_POWERDOWN	BIT(0)
> +
> +#define MESON_PCIE_TWO_X1		FIELD_PREP(MESON_PCIE_PORT_SEL, 0x3)
> +#define MESON_PCIE_COMMON_REF_CLK	FIELD_PREP(MESON_PCIE_COMMON_CLK, 0x1)
> +#define MESON_PCIE_PHY_INIT		(MESON_PCIE_TWO_X1 |		\
> +					 MESON_PCIE_COMMON_REF_CLK)
> +#define MESON_PCIE_RESET_DELAY		500
> +
> +struct phy_axg_pcie_priv {
> +	struct phy *phy;
> +	struct regmap *regmap;
> +	struct reset_control *reset;
> +};
> +
> +static const struct regmap_config phy_axg_pcie_regmap_conf = {
> +	.reg_bits = 8,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.max_register = MESON_PCIE_REG0,
> +};
> +
> +static int phy_axg_pcie_power_on(struct phy *phy)
> +{
> +	struct phy_axg_pcie_priv *priv = phy_get_drvdata(phy);
> +
> +	regmap_update_bits(priv->regmap, MESON_PCIE_REG0,
> +			   MESON_PCIE_POWERDOWN, 0);
> +	return 0;
> +}
> +
> +static int phy_axg_pcie_power_off(struct phy *phy)
> +{
> +	struct phy_axg_pcie_priv *priv = phy_get_drvdata(phy);
> +
> +	regmap_update_bits(priv->regmap, MESON_PCIE_REG0,
> +			   MESON_PCIE_POWERDOWN, 1);
> +	return 0;
> +}
> +
> +static int phy_axg_pcie_init(struct phy *phy)
> +{
> +	struct phy_axg_pcie_priv *priv = phy_get_drvdata(phy);
> +
> +	regmap_write(priv->regmap, MESON_PCIE_REG0, MESON_PCIE_PHY_INIT);
> +	return reset_control_reset(priv->reset);
> +}
> +
> +static int phy_axg_pcie_exit(struct phy *phy)
> +{
> +	struct phy_axg_pcie_priv *priv = phy_get_drvdata(phy);
> +
> +	return reset_control_reset(priv->reset);
> +}
> +
> +static int phy_axg_pcie_reset(struct phy *phy)
> +{
> +	struct phy_axg_pcie_priv *priv = phy_get_drvdata(phy);
> +	int ret = 0;
> +
> +	ret = reset_control_assert(priv->reset);
> +	if (ret != 0)
> +		goto out;
> +	udelay(MESON_PCIE_RESET_DELAY);
> +
> +	ret = reset_control_deassert(priv->reset);
> +	if (ret != 0)
> +		goto out;
> +	udelay(MESON_PCIE_RESET_DELAY);
> +
> +out:
> +	return ret;
> +}
> +
> +static const struct phy_ops phy_axg_pcie_ops = {
> +	.init = phy_axg_pcie_init,
> +	.exit = phy_axg_pcie_exit,
> +	.power_on = phy_axg_pcie_power_on,
> +	.power_off = phy_axg_pcie_power_off,
> +	.reset = phy_axg_pcie_reset,
> +	.owner = THIS_MODULE,
> +};
> +
> +static int phy_axg_pcie_probe(struct platform_device *pdev)
> +{
> +	struct phy_provider *pphy;
> +	struct device *dev = &pdev->dev;
> +	struct phy_axg_pcie_priv *priv;
> +	struct device_node *np = dev->of_node;
> +	struct resource *res;
> +	void __iomem *base;
> +	int ret;
> +
> +	priv = devm_kmalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->phy = devm_phy_create(dev, np, &phy_axg_pcie_ops);
> +	if (IS_ERR(priv->phy)) {
> +		ret = PTR_ERR(priv->phy);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "failed to create PHY\n");
> +		return ret;
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	priv->regmap = devm_regmap_init_mmio(dev, base,
> +					     &phy_axg_pcie_regmap_conf);
> +	if (IS_ERR(priv->regmap))
> +		return PTR_ERR(priv->regmap);
> +
> +	priv->reset = devm_reset_control_array_get(dev, false, false);
> +	if (IS_ERR(priv->reset))
> +		return PTR_ERR(priv->reset);
> +
> +	phy_set_drvdata(priv->phy, priv);
> +	dev_set_drvdata(dev, priv);
> +	pphy = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +
> +	return PTR_ERR_OR_ZERO(pphy);
> +}
> +
> +static const struct of_device_id phy_axg_pcie_of_match[] = {
> +	{
> +		.compatible = "amlogic,axg-pcie-phy",

dt binding documentation for this too is missing in this series?

Thanks
Kishon
