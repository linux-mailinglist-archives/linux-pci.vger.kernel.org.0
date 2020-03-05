Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0164F179EB8
	for <lists+linux-pci@lfdr.de>; Thu,  5 Mar 2020 05:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbgCEEvs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Mar 2020 23:51:48 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:43476 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgCEEvr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Mar 2020 23:51:47 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0254pTD8119086;
        Wed, 4 Mar 2020 22:51:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583383889;
        bh=YWxU9N3oS/F+fWkAAyJPMZXRGvDp4HaQTUtmye33uIo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=YWICIf1hIItt+93A00J/GummAW0EjoL0G/z3OCIy6sXsCnt7BD+5+191YT//aunS5
         xqgfaZphkzq+lqnSFb3bQwoYfWcafReIJSU8X2U1pUXmX/l24pIbxa2TSObG31qZnW
         uo28j2AnhlMx3a9IPTdoEPMJld35Flu6y647pAjE=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0254pT5f088116
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Mar 2020 22:51:29 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 4 Mar
 2020 22:51:28 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 4 Mar 2020 22:51:28 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0254pO4u032047;
        Wed, 4 Mar 2020 22:51:25 -0600
Subject: Re: [PATCH v6 6/7] phy: amlogic: Add Amlogic AXG PCIE PHY Driver
To:     Remi Pommarel <repk@triplefau.lt>
CC:     Yue Wang <yue.wang@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
References: <20200123232943.10229-1-repk@triplefau.lt>
 <20200123232943.10229-7-repk@triplefau.lt>
 <14627e42-4894-6674-4911-3205ea8f5e55@ti.com> <20200304130811.GP2248@voidbox>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <a6f8ac2f-f49a-f53e-1b44-fc446c3d7964@ti.com>
Date:   Thu, 5 Mar 2020 10:26:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200304130811.GP2248@voidbox>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 04/03/20 6:38 pm, Remi Pommarel wrote:
> On Wed, Mar 04, 2020 at 04:31:24PM +0530, Kishon Vijay Abraham I wrote:
>>
>>
>> On 24/01/20 4:59 am, Remi Pommarel wrote:
>>> This adds support for the PCI PHY found in the Amlogic AXG SoC Family.
>>> This will allow to mutualize code in pci-meson.c between AXG and G12A
>>> SoC.
>>>
>>> This PHY also uses and chains an analog PHY, which on AXG platform
>>> is needed to have reliable PCIe communication.
>>
>> Is the analog PHY an independent block and can be used with other PHYs?
> 
> It is documented as a separate block yes, but I think it is unlikely
> that it will be used with other PHYs than the PCIe or the MIPI one of
> the AXG SoC.

Shouldn't we then have a single PHY driver instead of chaining PHYs?

Thanks
Kishon

> 
> Thanks,
> Remi
> 
>>
>> For the patch itself
>> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
>>
>> Thanks
>> Kishon
>>>
>>> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
>>> ---
>>>  drivers/phy/amlogic/Kconfig              |  11 ++
>>>  drivers/phy/amlogic/Makefile             |   1 +
>>>  drivers/phy/amlogic/phy-meson-axg-pcie.c | 192 +++++++++++++++++++++++
>>>  3 files changed, 204 insertions(+)
>>>  create mode 100644 drivers/phy/amlogic/phy-meson-axg-pcie.c
>>>
>>> diff --git a/drivers/phy/amlogic/Kconfig b/drivers/phy/amlogic/Kconfig
>>> index 8c9cf2403591..71801e30d601 100644
>>> --- a/drivers/phy/amlogic/Kconfig
>>> +++ b/drivers/phy/amlogic/Kconfig
>>> @@ -60,6 +60,17 @@ config PHY_MESON_G12A_USB3_PCIE
>>>  	  in Meson G12A SoCs.
>>>  	  If unsure, say N.
>>>  
>>> +config PHY_MESON_AXG_PCIE
>>> +	tristate "Meson AXG PCIE PHY driver"
>>> +	default ARCH_MESON
>>> +	depends on OF && (ARCH_MESON || COMPILE_TEST)
>>> +	select GENERIC_PHY
>>> +	select REGMAP_MMIO
>>> +	help
>>> +	  Enable this to support the Meson MIPI + PCIE PHY found
>>> +	  in Meson AXG SoCs.
>>> +	  If unsure, say N.
>>> +
>>>  config PHY_MESON_AXG_MIPI_PCIE_ANALOG
>>>  	tristate "Meson AXG MIPI + PCIE analog PHY driver"
>>>  	default ARCH_MESON
>>> diff --git a/drivers/phy/amlogic/Makefile b/drivers/phy/amlogic/Makefile
>>> index 0aecf92d796a..e2baa133f7af 100644
>>> --- a/drivers/phy/amlogic/Makefile
>>> +++ b/drivers/phy/amlogic/Makefile
>>> @@ -4,4 +4,5 @@ obj-$(CONFIG_PHY_MESON_GXL_USB2)		+= phy-meson-gxl-usb2.o
>>>  obj-$(CONFIG_PHY_MESON_G12A_USB2)		+= phy-meson-g12a-usb2.o
>>>  obj-$(CONFIG_PHY_MESON_GXL_USB3)		+= phy-meson-gxl-usb3.o
>>>  obj-$(CONFIG_PHY_MESON_G12A_USB3_PCIE)		+= phy-meson-g12a-usb3-pcie.o
>>> +obj-$(CONFIG_PHY_MESON_AXG_PCIE)		+= phy-meson-axg-pcie.o
>>>  obj-$(CONFIG_PHY_MESON_AXG_MIPI_PCIE_ANALOG)	+= phy-meson-axg-mipi-pcie-analog.o
>>> diff --git a/drivers/phy/amlogic/phy-meson-axg-pcie.c b/drivers/phy/amlogic/phy-meson-axg-pcie.c
>>> new file mode 100644
>>> index 000000000000..377ed0dcd0d9
>>> --- /dev/null
>>> +++ b/drivers/phy/amlogic/phy-meson-axg-pcie.c
>>> @@ -0,0 +1,192 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Amlogic AXG PCIE PHY driver
>>> + *
>>> + * Copyright (C) 2020 Remi Pommarel <repk@triplefau.lt>
>>> + */
>>> +#include <linux/module.h>
>>> +#include <linux/phy/phy.h>
>>> +#include <linux/regmap.h>
>>> +#include <linux/reset.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/bitfield.h>
>>> +#include <dt-bindings/phy/phy.h>
>>> +
>>> +#define MESON_PCIE_REG0 0x00
>>> +#define		MESON_PCIE_COMMON_CLK	BIT(4)
>>> +#define		MESON_PCIE_PORT_SEL	GENMASK(3, 2)
>>> +#define		MESON_PCIE_CLK		BIT(1)
>>> +#define		MESON_PCIE_POWERDOWN	BIT(0)
>>> +
>>> +#define MESON_PCIE_TWO_X1		FIELD_PREP(MESON_PCIE_PORT_SEL, 0x3)
>>> +#define MESON_PCIE_COMMON_REF_CLK	FIELD_PREP(MESON_PCIE_COMMON_CLK, 0x1)
>>> +#define MESON_PCIE_PHY_INIT		(MESON_PCIE_TWO_X1 |		\
>>> +					 MESON_PCIE_COMMON_REF_CLK)
>>> +#define MESON_PCIE_RESET_DELAY		500
>>> +
>>> +struct phy_axg_pcie_priv {
>>> +	struct phy *phy;
>>> +	struct phy *analog;
>>> +	struct regmap *regmap;
>>> +	struct reset_control *reset;
>>> +};
>>> +
>>> +static const struct regmap_config phy_axg_pcie_regmap_conf = {
>>> +	.reg_bits = 8,
>>> +	.val_bits = 32,
>>> +	.reg_stride = 4,
>>> +	.max_register = MESON_PCIE_REG0,
>>> +};
>>> +
>>> +static int phy_axg_pcie_power_on(struct phy *phy)
>>> +{
>>> +	struct phy_axg_pcie_priv *priv = phy_get_drvdata(phy);
>>> +	int ret;
>>> +
>>> +	ret = phy_power_on(priv->analog);
>>> +	if (ret != 0)
>>> +		return ret;
>>> +
>>> +	regmap_update_bits(priv->regmap, MESON_PCIE_REG0,
>>> +			   MESON_PCIE_POWERDOWN, 0);
>>> +	return 0;
>>> +}
>>> +
>>> +static int phy_axg_pcie_power_off(struct phy *phy)
>>> +{
>>> +	struct phy_axg_pcie_priv *priv = phy_get_drvdata(phy);
>>> +	int ret;
>>> +
>>> +	ret = phy_power_off(priv->analog);
>>> +	if (ret != 0)
>>> +		return ret;
>>> +
>>> +	regmap_update_bits(priv->regmap, MESON_PCIE_REG0,
>>> +			   MESON_PCIE_POWERDOWN, 1);
>>> +	return 0;
>>> +}
>>> +
>>> +static int phy_axg_pcie_init(struct phy *phy)
>>> +{
>>> +	struct phy_axg_pcie_priv *priv = phy_get_drvdata(phy);
>>> +	int ret;
>>> +
>>> +	ret = phy_init(priv->analog);
>>> +	if (ret != 0)
>>> +		return ret;
>>> +
>>> +	regmap_write(priv->regmap, MESON_PCIE_REG0, MESON_PCIE_PHY_INIT);
>>> +	return reset_control_reset(priv->reset);
>>> +}
>>> +
>>> +static int phy_axg_pcie_exit(struct phy *phy)
>>> +{
>>> +	struct phy_axg_pcie_priv *priv = phy_get_drvdata(phy);
>>> +	int ret;
>>> +
>>> +	ret = phy_exit(priv->analog);
>>> +	if (ret != 0)
>>> +		return ret;
>>> +
>>> +	return reset_control_reset(priv->reset);
>>> +}
>>> +
>>> +static int phy_axg_pcie_reset(struct phy *phy)
>>> +{
>>> +	struct phy_axg_pcie_priv *priv = phy_get_drvdata(phy);
>>> +	int ret = 0;
>>> +
>>> +	ret = phy_reset(priv->analog);
>>> +	if (ret != 0)
>>> +		goto out;
>>> +
>>> +	ret = reset_control_assert(priv->reset);
>>> +	if (ret != 0)
>>> +		goto out;
>>> +	udelay(MESON_PCIE_RESET_DELAY);
>>> +
>>> +	ret = reset_control_deassert(priv->reset);
>>> +	if (ret != 0)
>>> +		goto out;
>>> +	udelay(MESON_PCIE_RESET_DELAY);
>>> +
>>> +out:
>>> +	return ret;
>>> +}
>>> +
>>> +static const struct phy_ops phy_axg_pcie_ops = {
>>> +	.init = phy_axg_pcie_init,
>>> +	.exit = phy_axg_pcie_exit,
>>> +	.power_on = phy_axg_pcie_power_on,
>>> +	.power_off = phy_axg_pcie_power_off,
>>> +	.reset = phy_axg_pcie_reset,
>>> +	.owner = THIS_MODULE,
>>> +};
>>> +
>>> +static int phy_axg_pcie_probe(struct platform_device *pdev)
>>> +{
>>> +	struct phy_provider *pphy;
>>> +	struct device *dev = &pdev->dev;
>>> +	struct phy_axg_pcie_priv *priv;
>>> +	struct device_node *np = dev->of_node;
>>> +	struct resource *res;
>>> +	void __iomem *base;
>>> +	int ret;
>>> +
>>> +	priv = devm_kmalloc(dev, sizeof(*priv), GFP_KERNEL);
>>> +	if (!priv)
>>> +		return -ENOMEM;
>>> +
>>> +	priv->phy = devm_phy_create(dev, np, &phy_axg_pcie_ops);
>>> +	if (IS_ERR(priv->phy)) {
>>> +		ret = PTR_ERR(priv->phy);
>>> +		if (ret != -EPROBE_DEFER)
>>> +			dev_err(dev, "failed to create PHY\n");
>>> +		return ret;
>>> +	}
>>> +
>>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +	base = devm_ioremap_resource(dev, res);
>>> +	if (IS_ERR(base))
>>> +		return PTR_ERR(base);
>>> +
>>> +	priv->regmap = devm_regmap_init_mmio(dev, base,
>>> +					     &phy_axg_pcie_regmap_conf);
>>> +	if (IS_ERR(priv->regmap))
>>> +		return PTR_ERR(priv->regmap);
>>> +
>>> +	priv->reset = devm_reset_control_array_get(dev, false, false);
>>> +	if (IS_ERR(priv->reset))
>>> +		return PTR_ERR(priv->reset);
>>> +
>>> +	priv->analog = devm_phy_get(dev, "analog");
>>> +	if (IS_ERR(priv->analog))
>>> +		return PTR_ERR(priv->analog);
>>> +
>>> +	phy_set_drvdata(priv->phy, priv);
>>> +	dev_set_drvdata(dev, priv);
>>> +	pphy = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
>>> +
>>> +	return PTR_ERR_OR_ZERO(pphy);
>>> +}
>>> +
>>> +static const struct of_device_id phy_axg_pcie_of_match[] = {
>>> +	{
>>> +		.compatible = "amlogic,axg-pcie-phy",
>>> +	},
>>> +	{ },
>>> +};
>>> +MODULE_DEVICE_TABLE(of, phy_axg_pcie_of_match);
>>> +
>>> +static struct platform_driver phy_axg_pcie_driver = {
>>> +	.probe = phy_axg_pcie_probe,
>>> +	.driver = {
>>> +		.name = "phy-axg-pcie",
>>> +		.of_match_table = phy_axg_pcie_of_match,
>>> +	},
>>> +};
>>> +module_platform_driver(phy_axg_pcie_driver);
>>> +
>>> +MODULE_AUTHOR("Remi Pommarel <repk@triplefau.lt>");
>>> +MODULE_DESCRIPTION("Amlogic AXG PCIE PHY driver");
>>> +MODULE_LICENSE("GPL v2");
>>>
