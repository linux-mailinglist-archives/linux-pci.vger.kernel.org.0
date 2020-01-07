Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9F4413233F
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2020 11:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgAGKIt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jan 2020 05:08:49 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56154 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgAGKIt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Jan 2020 05:08:49 -0500
Received: by mail-wm1-f66.google.com with SMTP id q9so18264209wmj.5
        for <linux-pci@vger.kernel.org>; Tue, 07 Jan 2020 02:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=EBsCPTse1nt4u+am6F0iVanlxGySwPooZK6E7bwxkd8=;
        b=D7aIPA7gCw1/JlpaDYyEfck03ELbTH8H/WUz5FMzs+L2Z2bYi/x+atshveQS4uqD/W
         f/cFpBbrKYkWHe1RXgT+3ib1QG3VPh4UlzGhsuZn7Me2CDeP+/BcFRW4DDvtWFOriCPt
         QCNhL8hLXFluJSe+EJwPC6Mjmmtg8ooVq5E0cm79VJMIPvrLO5ACZfN2RpbkiZeRoKaq
         QVWGFHR4TESskMJoIEDJzdHxYt4sRqfW39I8nIQHnoNkubBsOkfKcZp2x8OhEBDr56K9
         zRY1K+2j9OQRy/haGvwV5Wi50MO1G6he9Gfg/6hLTRF0ejUWXZ3cnCBWty5UZ1bGdRyY
         m9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=EBsCPTse1nt4u+am6F0iVanlxGySwPooZK6E7bwxkd8=;
        b=XrMhJKdwQ4INIi61YW8HKFGLe3olRU2V9ycCXmReUYt9qkhBUoEOQuDMpGVghQwXAB
         cpRXJSOxgNF274CcsTy+5TfcKIp9qtvklTIvhKXefR2pIRSbIDxOKUaDWFcZ8hapEXQ5
         8LP+jgcMO5VIFqvI4cqw39L2esb/bYywYt5EjnNi/9W4gT4S1Sx4K/aBBrUKTF2gZWSp
         i+jm+lV41+8Q8LlPYGsPUVpz0uQoc3I2GTvZFwpExE1D0TKzP1sFE7VAlq9i4CdQTKbz
         /kt5WjnaPSwFIFSre1a0SwF6z3CONoN7QHKwgq8kWxeyTZ1cbJPxaGB2GWktunANpDVy
         IZjQ==
X-Gm-Message-State: APjAAAWRzxy/iakFRphAd5TVqO7JDe88UEHj7UHKmB6YpAEkcoz2h9A7
        KvZo6AOuJFYtxdE6Hl0zHgY+MQ==
X-Google-Smtp-Source: APXvYqx/9OmvRjpm93sB0dSaUYT78HckHFE7SyLEgq7eos2rFdx9uCPtnTHpxADasmlolBUJoD97qA==
X-Received: by 2002:a05:600c:2549:: with SMTP id e9mr40358175wma.6.1578391726264;
        Tue, 07 Jan 2020 02:08:46 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z3sm75915294wrs.94.2020.01.07.02.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 02:08:45 -0800 (PST)
References: <20191223214529.20377-1-repk@triplefau.lt> <20191223214529.20377-2-repk@triplefau.lt> <1jeewrpgrr.fsf@starbuckisacylon.baylibre.com> <20191226201146.GA1803@voidbox>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Remi Pommarel <repk@triplefau.lt>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Yue Wang <yue.wang@amlogic.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v2 1/3] phy: amlogic: Add Amlogic AXG MIPI/PCIE PHY Driver
In-reply-to: <20191226201146.GA1803@voidbox>
Date:   Tue, 07 Jan 2020 11:08:44 +0100
Message-ID: <1j7e23shn7.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Thu 26 Dec 2019 at 21:11, Remi Pommarel <repk@triplefau.lt> wrote:

> On Thu, Dec 26, 2019 at 10:39:36AM +0100, Jerome Brunet wrote:
>> 
>> On Mon 23 Dec 2019 at 22:45, Remi Pommarel <repk@triplefau.lt> wrote:
>> 
>> > This adds support for the MIPI PHY also needed for PCIE found in the
>> > Amlogic AXG SoC Family.
>> >
>> > MIPI or PCIE selection is done by the #phy-cells, making the mode
>> > static and exclusive.
>> >
>> > For now only PCIE fonctionality is supported.
>> >
>> > This PHY will be used to replace the mipi_enable clock gating logic
>> > which was mistakenly added in the clock subsystem. This also activate
>> > a non documented band gap bit in those registers that allows reliable
>> > PCIE clock signal generation on AXG platforms.
>> >
>> > Signed-off-by: Remi Pommarel <repk@triplefau.lt>
>> > ---
>> >  drivers/phy/amlogic/Kconfig                   |  11 ++
>> >  drivers/phy/amlogic/Makefile                  |   1 +
>> >  drivers/phy/amlogic/phy-meson-axg-mipi-pcie.c | 176 ++++++++++++++++++
>> >  3 files changed, 188 insertions(+)
>> >  create mode 100644 drivers/phy/amlogic/phy-meson-axg-mipi-pcie.c
>> >
>> > diff --git a/drivers/phy/amlogic/Kconfig b/drivers/phy/amlogic/Kconfig
>> > index af774ac2b934..1eeb75d018e3 100644
>> > --- a/drivers/phy/amlogic/Kconfig
>> > +++ b/drivers/phy/amlogic/Kconfig
>> > @@ -59,3 +59,14 @@ config PHY_MESON_G12A_USB3_PCIE
>> >  	  Enable this to support the Meson USB3 + PCIE Combo PHY found
>> >  	  in Meson G12A SoCs.
>> >  	  If unsure, say N.
>> > +
>> > +config PHY_MESON_AXG_MIPI_PCIE
>> > +	tristate "Meson AXG MIPI + PCIE PHY driver"
>> > +	default ARCH_MESON
>> > +	depends on OF && (ARCH_MESON || COMPILE_TEST)
>> > +	select GENERIC_PHY
>> > +	select MFD_SYSCON
>> > +	help
>> > +	  Enable this to support the Meson MIPI + PCIE PHY found
>> > +	  in Meson AXG SoCs.
>> > +	  If unsure, say N.
>> > diff --git a/drivers/phy/amlogic/Makefile b/drivers/phy/amlogic/Makefile
>> > index 11d1c42ac2be..2167330a0ae8 100644
>> > --- a/drivers/phy/amlogic/Makefile
>> > +++ b/drivers/phy/amlogic/Makefile
>> > @@ -4,3 +4,4 @@ obj-$(CONFIG_PHY_MESON_GXL_USB2)	+= phy-meson-gxl-usb2.o
>> >  obj-$(CONFIG_PHY_MESON_G12A_USB2)	+= phy-meson-g12a-usb2.o
>> >  obj-$(CONFIG_PHY_MESON_GXL_USB3)	+= phy-meson-gxl-usb3.o
>> >  obj-$(CONFIG_PHY_MESON_G12A_USB3_PCIE)	+= phy-meson-g12a-usb3-pcie.o
>> > +obj-$(CONFIG_PHY_MESON_AXG_MIPI_PCIE)	+= phy-meson-axg-mipi-pcie.o
>> > diff --git a/drivers/phy/amlogic/phy-meson-axg-mipi-pcie.c b/drivers/phy/amlogic/phy-meson-axg-mipi-pcie.c
>> > new file mode 100644
>> > index 000000000000..006aa8cdfc47
>> > --- /dev/null
>> > +++ b/drivers/phy/amlogic/phy-meson-axg-mipi-pcie.c
>> > @@ -0,0 +1,176 @@
>> > +// SPDX-License-Identifier: GPL-2.0
>> > +/*
>> > + * Amlogic AXG MIPI + PCIE PHY driver
>> > + *
>> > + * Copyright (C) 2019 Remi Pommarel <repk@triplefau.lt>
>> > + */
>> > +#include <linux/module.h>
>> > +#include <linux/phy/phy.h>
>> > +#include <linux/regmap.h>
>> > +#include <linux/mfd/syscon.h>
>> > +#include <linux/platform_device.h>
>> > +#include <dt-bindings/phy/phy.h>
>> > +
>> > +#define HHI_MIPI_CNTL0 0x00
>> > +#define		HHI_MIPI_CNTL0_COMMON_BLOCK	GENMASK(31, 28)
>> > +#define		HHI_MIPI_CNTL0_ENABLE		BIT(29)
>> > +#define		HHI_MIPI_CNTL0_BANDGAP		BIT(26)
>> > +#define		HHI_MIPI_CNTL0_DECODE_TO_RTERM	GENMASK(15, 12)
>> > +#define		HHI_MIPI_CNTL0_OUTPUT_EN	BIT(3)
>> > +
>> > +#define HHI_MIPI_CNTL1 0x01
>> > +#define		HHI_MIPI_CNTL1_CH0_CML_PDR_EN	BIT(12)
>> > +#define		HHI_MIPI_CNTL1_LP_ABILITY	GENMASK(5, 4)
>> > +#define		HHI_MIPI_CNTL1_LP_RESISTER	BIT(3)
>> > +#define		HHI_MIPI_CNTL1_INPUT_SETTING	BIT(2)
>> > +#define		HHI_MIPI_CNTL1_INPUT_SEL	BIT(1)
>> > +#define		HHI_MIPI_CNTL1_PRBS7_EN		BIT(0)
>> > +
>> > +#define HHI_MIPI_CNTL2 0x02
>> > +#define		HHI_MIPI_CNTL2_CH_PU		GENMASK(31, 25)
>> > +#define		HHI_MIPI_CNTL2_CH_CTL		GENMASK(24, 19)
>> > +#define		HHI_MIPI_CNTL2_CH0_DIGDR_EN	BIT(18)
>> > +#define		HHI_MIPI_CNTL2_CH_DIGDR_EN	BIT(17)
>> > +#define		HHI_MIPI_CNTL2_LPULPS_EN	BIT(16)
>> > +#define		HHI_MIPI_CNTL2_CH_EN(n)		BIT(15 - (n))
>> > +#define		HHI_MIPI_CNTL2_CH0_LP_CTL	GENMASK(10, 1)
>> > +
>> > +struct phy_axg_mipi_pcie_priv {
>> > +	struct phy *phy;
>> > +	unsigned int mode;
>> > +	struct regmap *regmap;
>> > +};
>> > +
>> > +static const struct regmap_config phy_axg_mipi_pcie_regmap_conf = {
>> > +	.reg_bits = 8,
>> > +	.val_bits = 32,
>> > +	.reg_stride = 4,
>> > +	.max_register = HHI_MIPI_CNTL2,
>> > +};
>> > +
>> > +static int phy_axg_mipi_pcie_power_on(struct phy *phy)
>> > +{
>> > +	struct phy_axg_mipi_pcie_priv *priv = phy_get_drvdata(phy);
>> > +
>> > +	/* MIPI not supported yet */
>> > +	if (priv->mode != PHY_TYPE_PCIE)
>> > +		return 0;
>> > +
>> > +	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0,
>> > +			   HHI_MIPI_CNTL0_BANDGAP, HHI_MIPI_CNTL0_BANDGAP);
>> > +
>> > +	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0,
>> > +			   HHI_MIPI_CNTL0_ENABLE, HHI_MIPI_CNTL0_ENABLE);
>> > +	return 0;
>> > +}
>> > +
>> > +static int phy_axg_mipi_pcie_power_off(struct phy *phy)
>> > +{
>> > +	struct phy_axg_mipi_pcie_priv *priv = phy_get_drvdata(phy);
>> > +
>> > +	/* MIPI not supported yet */
>> > +	if (priv->mode != PHY_TYPE_PCIE)
>> > +		return 0;
>> > +
>> > +	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0,
>> > +			   HHI_MIPI_CNTL0_BANDGAP, 0);
>> > +	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0,
>> > +			   HHI_MIPI_CNTL0_ENABLE, 0);
>> > +	return 0;
>> > +}
>> > +
>> > +static int phy_axg_mipi_pcie_init(struct phy *phy)
>> > +{
>> > +	return 0;
>> > +}
>> > +
>> > +static int phy_axg_mipi_pcie_exit(struct phy *phy)
>> > +{
>> > +	return 0;
>> > +}
>> > +
>> > +static const struct phy_ops phy_axg_mipi_pcie_ops = {
>> > +	.init = phy_axg_mipi_pcie_init,
>> > +	.exit = phy_axg_mipi_pcie_exit,
>> > +	.power_on = phy_axg_mipi_pcie_power_on,
>> > +	.power_off = phy_axg_mipi_pcie_power_off,
>> > +	.owner = THIS_MODULE,
>> > +};
>> > +
>> > +static struct phy *phy_axg_mipi_pcie_xlate(struct device *dev,
>> > +					   struct of_phandle_args *args)
>> > +{
>> > +	struct phy_axg_mipi_pcie_priv *priv = dev_get_drvdata(dev);
>> > +	unsigned int mode;
>> > +
>> > +	if (args->args_count != 1) {
>> > +		dev_err(dev, "invalid number of arguments\n");
>> > +		return ERR_PTR(-EINVAL);
>> > +	}
>> > +
>> > +	mode = args->args[0];
>> > +
>> > +	/* MIPI mode is not supported yet */
>> > +	if (mode != PHY_TYPE_PCIE) {
>> > +		dev_err(dev, "invalid phy mode select argument\n");
>> > +		return ERR_PTR(-EINVAL);
>> > +	}
>> > +
>> > +	priv->mode = mode;
>> > +	return priv->phy;
>> > +}
>> > +
>> > +static int phy_axg_mipi_pcie_probe(struct platform_device *pdev)
>> > +{
>> > +	struct phy_provider *pphy;
>> > +	struct device *dev = &pdev->dev;
>> > +	struct phy_axg_mipi_pcie_priv *priv;
>> > +	struct device_node *np = dev->of_node;
>> > +	int ret;
>> > +
>> > +	priv = devm_kmalloc(dev, sizeof(*priv), GFP_KERNEL);
>> > +	if (!priv)
>> > +		return -ENOMEM;
>> > +
>> > +	/* Get the hhi system controller node */
>> > +	priv->regmap = syscon_node_to_regmap(of_get_parent(dev->of_node));
>> > +	if (IS_ERR(priv->regmap)) {
>> > +		dev_err(dev, "failed to get HHI regmap\n");
>> > +		return PTR_ERR(priv->regmap);
>> > +	}
>> 
>> Remi,
>> 
>> Unless we are absolutely sure this will be *AXG ONLY*, I would
>> prefer if you get the registers without the syscon.
>> 
>> Having it introduce some kind of dependency between the 2 which is
>> likely to make this driver SoC specific.
>> 
>> It was clearly wrong for the clock controller to map these regiters, and
>> if there is a possibility that this driver is used on other SoCs, I
>> would prefer if we did not carry that mistake over. I would prefer if we
>> fixed the clock controller so you don't need syscon here.
>
> Jerome thank you for reviewing this,
>
> Sure I will remove access to the registers through syscon system. Just
> to be sure we are on the same page here. What you suggest is keeping the
> two PHYs approach from this patchset (instead of the one PHY in v3),
> even if there is not exactly two PHYs, right ?

Well, according the doc, this "MIPI Phy" seems to be used by the PCIe
PHY so I tempted to say yes but I'm not very familiar with the PHY
subsystem. I'm sure the PHY maintainers can help us with this

>
> Thanks,

