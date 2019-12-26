Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC38812AB58
	for <lists+linux-pci@lfdr.de>; Thu, 26 Dec 2019 10:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfLZJjl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Dec 2019 04:39:41 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41801 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbfLZJjl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Dec 2019 04:39:41 -0500
Received: by mail-wr1-f68.google.com with SMTP id c9so23230033wrw.8
        for <linux-pci@vger.kernel.org>; Thu, 26 Dec 2019 01:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=6tFX9VQC8fyAZfaMEUBMpT9KzF/teVvyYFXqyHBPl3Q=;
        b=kDY0e3PdGrWqCBQgiyLpPxXS11V97HLNrGGHneTO5pAGkbHswhE04XrKRgMf//QDJc
         T/CwMdTe26WwqU+EAFAGQE7LuaWlmKdmvSy6kog7o/obn890NYcA0YW1AX3W/SNLJb0N
         u3MIO075rDTs1lbcDtg8XPZ2fP7OZSs3uotq3zn8Z77XHlrRZ0WHe+skEeWkXRapaDe3
         MW4C3g7kb6IWFZts2L/Dx5/yKtiKG8A7mXHW9LSYXDpD6APSo6xBzAg47qgNLVDDYy3L
         +70Uirr7nMmQibaTKz/0Dj7kK0FU+c8ULqEJoElvCEMh8IF9z70P55d2K9N+PuegSmYR
         /AGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=6tFX9VQC8fyAZfaMEUBMpT9KzF/teVvyYFXqyHBPl3Q=;
        b=qMlmvDfNWqijdCJoCyt7FPXJtnIbuoyA50/sBWYvOsTAuHPxrpoXMpYE2/LiLNtqpg
         uLIcDZaugpBEgTbLggpT9ocl0IoDDIBlqC+YGhj4re7f6sRN9MCEBAnVT2ZjLQ64tm5o
         hFsbt/mXvKwLoVT8Gico1q6wrluoriDzqYm43YMy/vYPSqytC4TgAabrfUGdLtCJxXw6
         aW0eiYicffrVH2dO0X+SBL99b2hayvqg7IeOjCa1fQl7GjoK0Gsi3qUtOCvpd5toqhKX
         URPIy0XCfoFqrjWv148O8xTuKCoYWNRN9/tTdn5bTp2+5vY2JiuymMFdn+wh4/yk2cdu
         pN5g==
X-Gm-Message-State: APjAAAXZCxXcjaC19vdk+Wll07pA/8xa7Zqi3QS9Z37CKZ9HNpFltUeC
        EedOH5cuNkN/9RzhD7sWz7rb9Q==
X-Google-Smtp-Source: APXvYqw+1ezdlIkOYmVE1bETJtysJHSk8wNlZuxOuByhXTcTWshJfOzNkxefsIx1ieJlfQtvhaA2qw==
X-Received: by 2002:adf:cf06:: with SMTP id o6mr43855958wrj.349.1577353177888;
        Thu, 26 Dec 2019 01:39:37 -0800 (PST)
Received: from localhost ([2a01:e0a:1a5:7ee0:1e09:f4bb:719a:3028])
        by smtp.gmail.com with ESMTPSA id u1sm7779485wmc.5.2019.12.26.01.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 01:39:37 -0800 (PST)
References: <20191223214529.20377-1-repk@triplefau.lt> <20191223214529.20377-2-repk@triplefau.lt>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Remi Pommarel <repk@triplefau.lt>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Yue Wang <yue.wang@Amlogic.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v2 1/3] phy: amlogic: Add Amlogic AXG MIPI/PCIE PHY Driver
In-reply-to: <20191223214529.20377-2-repk@triplefau.lt>
Date:   Thu, 26 Dec 2019 10:39:36 +0100
Message-ID: <1jeewrpgrr.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Mon 23 Dec 2019 at 22:45, Remi Pommarel <repk@triplefau.lt> wrote:

> This adds support for the MIPI PHY also needed for PCIE found in the
> Amlogic AXG SoC Family.
>
> MIPI or PCIE selection is done by the #phy-cells, making the mode
> static and exclusive.
>
> For now only PCIE fonctionality is supported.
>
> This PHY will be used to replace the mipi_enable clock gating logic
> which was mistakenly added in the clock subsystem. This also activate
> a non documented band gap bit in those registers that allows reliable
> PCIE clock signal generation on AXG platforms.
>
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> ---
>  drivers/phy/amlogic/Kconfig                   |  11 ++
>  drivers/phy/amlogic/Makefile                  |   1 +
>  drivers/phy/amlogic/phy-meson-axg-mipi-pcie.c | 176 ++++++++++++++++++
>  3 files changed, 188 insertions(+)
>  create mode 100644 drivers/phy/amlogic/phy-meson-axg-mipi-pcie.c
>
> diff --git a/drivers/phy/amlogic/Kconfig b/drivers/phy/amlogic/Kconfig
> index af774ac2b934..1eeb75d018e3 100644
> --- a/drivers/phy/amlogic/Kconfig
> +++ b/drivers/phy/amlogic/Kconfig
> @@ -59,3 +59,14 @@ config PHY_MESON_G12A_USB3_PCIE
>  	  Enable this to support the Meson USB3 + PCIE Combo PHY found
>  	  in Meson G12A SoCs.
>  	  If unsure, say N.
> +
> +config PHY_MESON_AXG_MIPI_PCIE
> +	tristate "Meson AXG MIPI + PCIE PHY driver"
> +	default ARCH_MESON
> +	depends on OF && (ARCH_MESON || COMPILE_TEST)
> +	select GENERIC_PHY
> +	select MFD_SYSCON
> +	help
> +	  Enable this to support the Meson MIPI + PCIE PHY found
> +	  in Meson AXG SoCs.
> +	  If unsure, say N.
> diff --git a/drivers/phy/amlogic/Makefile b/drivers/phy/amlogic/Makefile
> index 11d1c42ac2be..2167330a0ae8 100644
> --- a/drivers/phy/amlogic/Makefile
> +++ b/drivers/phy/amlogic/Makefile
> @@ -4,3 +4,4 @@ obj-$(CONFIG_PHY_MESON_GXL_USB2)	+= phy-meson-gxl-usb2.o
>  obj-$(CONFIG_PHY_MESON_G12A_USB2)	+= phy-meson-g12a-usb2.o
>  obj-$(CONFIG_PHY_MESON_GXL_USB3)	+= phy-meson-gxl-usb3.o
>  obj-$(CONFIG_PHY_MESON_G12A_USB3_PCIE)	+= phy-meson-g12a-usb3-pcie.o
> +obj-$(CONFIG_PHY_MESON_AXG_MIPI_PCIE)	+= phy-meson-axg-mipi-pcie.o
> diff --git a/drivers/phy/amlogic/phy-meson-axg-mipi-pcie.c b/drivers/phy/amlogic/phy-meson-axg-mipi-pcie.c
> new file mode 100644
> index 000000000000..006aa8cdfc47
> --- /dev/null
> +++ b/drivers/phy/amlogic/phy-meson-axg-mipi-pcie.c
> @@ -0,0 +1,176 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Amlogic AXG MIPI + PCIE PHY driver
> + *
> + * Copyright (C) 2019 Remi Pommarel <repk@triplefau.lt>
> + */
> +#include <linux/module.h>
> +#include <linux/phy/phy.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/platform_device.h>
> +#include <dt-bindings/phy/phy.h>
> +
> +#define HHI_MIPI_CNTL0 0x00
> +#define		HHI_MIPI_CNTL0_COMMON_BLOCK	GENMASK(31, 28)
> +#define		HHI_MIPI_CNTL0_ENABLE		BIT(29)
> +#define		HHI_MIPI_CNTL0_BANDGAP		BIT(26)
> +#define		HHI_MIPI_CNTL0_DECODE_TO_RTERM	GENMASK(15, 12)
> +#define		HHI_MIPI_CNTL0_OUTPUT_EN	BIT(3)
> +
> +#define HHI_MIPI_CNTL1 0x01
> +#define		HHI_MIPI_CNTL1_CH0_CML_PDR_EN	BIT(12)
> +#define		HHI_MIPI_CNTL1_LP_ABILITY	GENMASK(5, 4)
> +#define		HHI_MIPI_CNTL1_LP_RESISTER	BIT(3)
> +#define		HHI_MIPI_CNTL1_INPUT_SETTING	BIT(2)
> +#define		HHI_MIPI_CNTL1_INPUT_SEL	BIT(1)
> +#define		HHI_MIPI_CNTL1_PRBS7_EN		BIT(0)
> +
> +#define HHI_MIPI_CNTL2 0x02
> +#define		HHI_MIPI_CNTL2_CH_PU		GENMASK(31, 25)
> +#define		HHI_MIPI_CNTL2_CH_CTL		GENMASK(24, 19)
> +#define		HHI_MIPI_CNTL2_CH0_DIGDR_EN	BIT(18)
> +#define		HHI_MIPI_CNTL2_CH_DIGDR_EN	BIT(17)
> +#define		HHI_MIPI_CNTL2_LPULPS_EN	BIT(16)
> +#define		HHI_MIPI_CNTL2_CH_EN(n)		BIT(15 - (n))
> +#define		HHI_MIPI_CNTL2_CH0_LP_CTL	GENMASK(10, 1)
> +
> +struct phy_axg_mipi_pcie_priv {
> +	struct phy *phy;
> +	unsigned int mode;
> +	struct regmap *regmap;
> +};
> +
> +static const struct regmap_config phy_axg_mipi_pcie_regmap_conf = {
> +	.reg_bits = 8,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.max_register = HHI_MIPI_CNTL2,
> +};
> +
> +static int phy_axg_mipi_pcie_power_on(struct phy *phy)
> +{
> +	struct phy_axg_mipi_pcie_priv *priv = phy_get_drvdata(phy);
> +
> +	/* MIPI not supported yet */
> +	if (priv->mode != PHY_TYPE_PCIE)
> +		return 0;
> +
> +	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0,
> +			   HHI_MIPI_CNTL0_BANDGAP, HHI_MIPI_CNTL0_BANDGAP);
> +
> +	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0,
> +			   HHI_MIPI_CNTL0_ENABLE, HHI_MIPI_CNTL0_ENABLE);
> +	return 0;
> +}
> +
> +static int phy_axg_mipi_pcie_power_off(struct phy *phy)
> +{
> +	struct phy_axg_mipi_pcie_priv *priv = phy_get_drvdata(phy);
> +
> +	/* MIPI not supported yet */
> +	if (priv->mode != PHY_TYPE_PCIE)
> +		return 0;
> +
> +	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0,
> +			   HHI_MIPI_CNTL0_BANDGAP, 0);
> +	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0,
> +			   HHI_MIPI_CNTL0_ENABLE, 0);
> +	return 0;
> +}
> +
> +static int phy_axg_mipi_pcie_init(struct phy *phy)
> +{
> +	return 0;
> +}
> +
> +static int phy_axg_mipi_pcie_exit(struct phy *phy)
> +{
> +	return 0;
> +}
> +
> +static const struct phy_ops phy_axg_mipi_pcie_ops = {
> +	.init = phy_axg_mipi_pcie_init,
> +	.exit = phy_axg_mipi_pcie_exit,
> +	.power_on = phy_axg_mipi_pcie_power_on,
> +	.power_off = phy_axg_mipi_pcie_power_off,
> +	.owner = THIS_MODULE,
> +};
> +
> +static struct phy *phy_axg_mipi_pcie_xlate(struct device *dev,
> +					   struct of_phandle_args *args)
> +{
> +	struct phy_axg_mipi_pcie_priv *priv = dev_get_drvdata(dev);
> +	unsigned int mode;
> +
> +	if (args->args_count != 1) {
> +		dev_err(dev, "invalid number of arguments\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	mode = args->args[0];
> +
> +	/* MIPI mode is not supported yet */
> +	if (mode != PHY_TYPE_PCIE) {
> +		dev_err(dev, "invalid phy mode select argument\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	priv->mode = mode;
> +	return priv->phy;
> +}
> +
> +static int phy_axg_mipi_pcie_probe(struct platform_device *pdev)
> +{
> +	struct phy_provider *pphy;
> +	struct device *dev = &pdev->dev;
> +	struct phy_axg_mipi_pcie_priv *priv;
> +	struct device_node *np = dev->of_node;
> +	int ret;
> +
> +	priv = devm_kmalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	/* Get the hhi system controller node */
> +	priv->regmap = syscon_node_to_regmap(of_get_parent(dev->of_node));
> +	if (IS_ERR(priv->regmap)) {
> +		dev_err(dev, "failed to get HHI regmap\n");
> +		return PTR_ERR(priv->regmap);
> +	}

Remi,

Unless we are absolutely sure this will be *AXG ONLY*, I would
prefer if you get the registers without the syscon.

Having it introduce some kind of dependency between the 2 which is
likely to make this driver SoC specific.

It was clearly wrong for the clock controller to map these regiters, and
if there is a possibility that this driver is used on other SoCs, I
would prefer if we did not carry that mistake over. I would prefer if we
fixed the clock controller so you don't need syscon here.

> +
> +	priv->phy = devm_phy_create(dev, np, &phy_axg_mipi_pcie_ops);
> +	if (IS_ERR(priv->phy)) {
> +		ret = PTR_ERR(priv->phy);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "failed to create PHY\n");
> +		return ret;
> +	}
> +
> +	phy_set_drvdata(priv->phy, priv);
> +	dev_set_drvdata(dev, priv);
> +	pphy = devm_of_phy_provider_register(dev, phy_axg_mipi_pcie_xlate);
> +
> +	return PTR_ERR_OR_ZERO(pphy);
> +}
> +
> +static const struct of_device_id phy_axg_mipi_pcie_of_match[] = {
> +	{
> +		.compatible = "amlogic,axg-mipi-pcie-phy",
> +	},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, phy_axg_mipi_pcie_of_match);
> +
> +static struct platform_driver phy_axg_mipi_pcie_driver = {
> +	.probe = phy_axg_mipi_pcie_probe,
> +	.driver = {
> +		.name = "phy-axg-mipi-pcie",
> +		.of_match_table = phy_axg_mipi_pcie_of_match,
> +	},
> +};
> +module_platform_driver(phy_axg_mipi_pcie_driver);
> +
> +MODULE_AUTHOR("Remi Pommarel <repk@triplefau.lt>");
> +MODULE_DESCRIPTION("Amlogic AXG MIPI + PCIE PHY driver");
> +MODULE_LICENSE("GPL v2");

