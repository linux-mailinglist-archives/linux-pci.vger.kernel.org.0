Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB5DD161E4
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2019 12:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfEGKZQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 May 2019 06:25:16 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17720 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbfEGKZQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 May 2019 06:25:16 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd15ce70001>; Tue, 07 May 2019 03:24:39 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 07 May 2019 03:25:14 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 07 May 2019 03:25:14 -0700
Received: from [10.25.73.250] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 May
 2019 10:25:08 +0000
Subject: Re: [PATCH V5 14/16] phy: tegra: Add PCIe PIPE2UPHY support
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <kishon@ti.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <mperttunen@nvidia.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190424052004.6270-1-vidyas@nvidia.com>
 <20190424052004.6270-15-vidyas@nvidia.com> <20190503113558.GH32400@ulmo>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <11cf6543-46c0-f95a-d23d-059aeef807ac@nvidia.com>
Date:   Tue, 7 May 2019 15:55:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190503113558.GH32400@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557224679; bh=BOABvpH1oxJXKgemW+XeH/LQSarKXw3t6a6SIta4LAQ=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=q87w5cOdVbN7Lw0+BoqF7OyKYTdp52C4oht1PNzd+X4fyWO79R+hDxiRxgfO8isJo
         jcsUgNyYhu0KgRfBMo6Nosie0qtRK38dpbwdpDE5oEBLgR4SjYzWFKF7iZN/LIriIy
         v/mZhSEaBSpg6OU+hEDp0/4ByYuwqHs9Qd3oiQWbBjwHuPXh3RvPdvzh/75uFcGlzK
         FsEcekp+bw0KUYMe+AvdvZjNp19mpJmqRecVcSwOxwgSw3rNEtIJSI9IukPzOfhJAL
         nYPuMftanyBln7tnv4PMFo2Ny451WIe9IzE2mD2lKloGuxcfczgPR4JinwX5B8RbVR
         gmEAf3nI19asg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/3/2019 5:05 PM, Thierry Reding wrote:
> On Wed, Apr 24, 2019 at 10:50:02AM +0530, Vidya Sagar wrote:
>> Synopsys DesignWare core based PCIe controllers in Tegra 194 SoC interface
>> with Universal PHY (UPHY) module through a PIPE2UPHY (P2U) module.
>> For each PCIe lane of a controller, there is a P2U unit instantiated at
>> hardware level. This driver provides support for the programming required
>> for each P2U that is going to be used for a PCIe controller.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>> Changes since [v4]:
>> * None
>>
>> Changes since [v3]:
>> * Rebased on top of linux-next top of the tree
>>
>> Changes since [v2]:
>> * Replaced spaces with tabs in Kconfig file
>> * Sorted header file inclusion alphabetically
>>
>> Changes since [v1]:
>> * Added COMPILE_TEST in Kconfig
>> * Removed empty phy_ops implementations
>> * Modified code according to DT documentation file modifications
>>
>>   drivers/phy/tegra/Kconfig             |   7 ++
>>   drivers/phy/tegra/Makefile            |   1 +
>>   drivers/phy/tegra/pcie-p2u-tegra194.c | 120 ++++++++++++++++++++++++++
>>   3 files changed, 128 insertions(+)
>>   create mode 100644 drivers/phy/tegra/pcie-p2u-tegra194.c
>>
>> diff --git a/drivers/phy/tegra/Kconfig b/drivers/phy/tegra/Kconfig
>> index a3b1de953fb7..06d423fa85b4 100644
>> --- a/drivers/phy/tegra/Kconfig
>> +++ b/drivers/phy/tegra/Kconfig
>> @@ -6,3 +6,10 @@ config PHY_TEGRA_XUSB
>>   
>>   	  To compile this driver as a module, choose M here: the module will
>>   	  be called phy-tegra-xusb.
>> +
>> +config PHY_TEGRA194_PCIE_P2U
>> +	tristate "NVIDIA Tegra P2U PHY Driver"
>> +	depends on ARCH_TEGRA || COMPILE_TEST
>> +	select GENERIC_PHY
>> +	help
>> +	  Enable this to support the P2U (PIPE to UPHY) that is part of Tegra 19x SOCs.
>> diff --git a/drivers/phy/tegra/Makefile b/drivers/phy/tegra/Makefile
>> index a93cd9a499b2..1aaca794f40c 100644
>> --- a/drivers/phy/tegra/Makefile
>> +++ b/drivers/phy/tegra/Makefile
>> @@ -5,3 +5,4 @@ phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_124_SOC) += xusb-tegra124.o
>>   phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_132_SOC) += xusb-tegra124.o
>>   phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_210_SOC) += xusb-tegra210.o
>>   phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_186_SOC) += xusb-tegra186.o
>> +obj-$(CONFIG_PHY_TEGRA194_PCIE_P2U) += pcie-p2u-tegra194.o
>> diff --git a/drivers/phy/tegra/pcie-p2u-tegra194.c b/drivers/phy/tegra/pcie-p2u-tegra194.c
>> new file mode 100644
>> index 000000000000..a5d85e411088
>> --- /dev/null
>> +++ b/drivers/phy/tegra/pcie-p2u-tegra194.c
>> @@ -0,0 +1,120 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * P2U (PIPE to UPHY) driver for Tegra T194 SoC
>> + *
>> + * Copyright (C) 2019 NVIDIA Corporation.
>> + *
>> + * Author: Vidya Sagar <vidyas@nvidia.com>
>> + */
>> +
>> +#include <linux/delay.h>
>> +#include <linux/err.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/phy/phy.h>
>> +#include <linux/platform_device.h>
>> +#include <soc/tegra/bpmp-abi.h>
> 
> Looks to me like not all of the above are actually needed. I don't see
> anything from delay.h used, and you certainly aren't using anything from
> soc/tegra/bpmp-abi.h either.
Done.

> 
>> +
>> +#define P2U_PERIODIC_EQ_CTRL_GEN3	0xc0
>> +#define P2U_PERIODIC_EQ_CTRL_GEN3_PERIODIC_EQ_EN		BIT(0)
>> +#define P2U_PERIODIC_EQ_CTRL_GEN3_INIT_PRESET_EQ_TRAIN_EN	BIT(1)
>> +#define P2U_PERIODIC_EQ_CTRL_GEN4	0xc4
>> +#define P2U_PERIODIC_EQ_CTRL_GEN4_INIT_PRESET_EQ_TRAIN_EN	BIT(1)
>> +
>> +#define P2U_RX_DEBOUNCE_TIME				0xa4
>> +#define P2U_RX_DEBOUNCE_TIME_DEBOUNCE_TIMER_MASK	0xffff
>> +#define P2U_RX_DEBOUNCE_TIME_DEBOUNCE_TIMER_VAL		160
>> +
>> +struct tegra_p2u {
>> +	void __iomem *base;
>> +};
>> +
>> +static int tegra_p2u_power_on(struct phy *x)
>> +{
>> +	struct tegra_p2u *phy = phy_get_drvdata(x);
>> +	u32 val;
>> +
>> +	val = readl(phy->base + P2U_PERIODIC_EQ_CTRL_GEN3);
>> +	val &= ~P2U_PERIODIC_EQ_CTRL_GEN3_PERIODIC_EQ_EN;
>> +	val |= P2U_PERIODIC_EQ_CTRL_GEN3_INIT_PRESET_EQ_TRAIN_EN;
>> +	writel(val, phy->base + P2U_PERIODIC_EQ_CTRL_GEN3);
>> +
>> +	val = readl(phy->base + P2U_PERIODIC_EQ_CTRL_GEN4);
>> +	val |= P2U_PERIODIC_EQ_CTRL_GEN4_INIT_PRESET_EQ_TRAIN_EN;
>> +	writel(val, phy->base + P2U_PERIODIC_EQ_CTRL_GEN4);
>> +
>> +	val = readl(phy->base + P2U_RX_DEBOUNCE_TIME);
>> +	val &= ~P2U_RX_DEBOUNCE_TIME_DEBOUNCE_TIMER_MASK;
>> +	val |= P2U_RX_DEBOUNCE_TIME_DEBOUNCE_TIMER_VAL;
>> +	writel(val, phy->base + P2U_RX_DEBOUNCE_TIME);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct phy_ops ops = {
>> +	.power_on	= tegra_p2u_power_on,
>> +	.owner		= THIS_MODULE,
> 
> I think it's perhaps best to just stick with single spaces around the =
> instead of trying to arbitrarily align these. See below for why I think
> so.
Done.

> 
>> +};
>> +
>> +static int tegra_p2u_probe(struct platform_device *pdev)
>> +{
>> +	struct phy_provider *phy_provider;
>> +	struct device *dev = &pdev->dev;
>> +	struct phy *generic_phy;
>> +	struct tegra_p2u *phy;
>> +	struct resource *res;
>> +
>> +	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
>> +	if (!phy)
>> +		return -ENOMEM;
>> +
>> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ctl");
>> +	phy->base = devm_ioremap_resource(dev, res);
>> +	if (IS_ERR(phy->base))
>> +		return PTR_ERR_OR_ZERO(phy->base);
>> +
>> +	platform_set_drvdata(pdev, phy);
> 
> You could use dev_set_drvdata() here since you already use dev (instead
> of pdev) everywhere else.
Since this is a platform driver, wouldn't it make more sense to use platform_set_drvdata()
instead of dev_set_drvdata()?

> 
>> +
>> +	generic_phy = devm_phy_create(dev, NULL, &ops);
>> +	if (IS_ERR(generic_phy))
>> +		return PTR_ERR_OR_ZERO(generic_phy);
>> +
>> +	phy_set_drvdata(generic_phy, phy);
>> +
>> +	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
>> +	if (IS_ERR(phy_provider))
>> +		return PTR_ERR_OR_ZERO(phy_provider);
>> +
>> +	return 0;
>> +}
>> +
>> +static int tegra_p2u_remove(struct platform_device *pdev)
>> +{
>> +	return 0;
>> +}
> 
> I thought it had already been mentioned that you don't need to implement
> this if it's empty?
Done.

> 
>> +
>> +static const struct of_device_id tegra_p2u_id_table[] = {
>> +	{
>> +		.compatible = "nvidia,tegra194-p2u",
>> +	},
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(of, tegra_p2u_id_table);
>> +
>> +static struct platform_driver tegra_p2u_driver = {
>> +	.probe		= tegra_p2u_probe,
>> +	.remove		= tegra_p2u_remove,
>> +	.driver		= {
>> +		.name	= "tegra194-p2u",
>> +		.of_match_table = tegra_p2u_id_table,
> 
> Again, I don't think the artificial padding does this any good. For
> example, the .driver.name's assignment operator is padded to the same
> column as members of the parent structure, so that's confusing to read.
> Also, .of_match_table is not padded at all, so it's inconsistent. Just
> use single spaces around =. That's easy to keep consistent and really
> doesn't read that bad.
Done.

> 
>> +	},
>> +};
>> +
>> +module_platform_driver(tegra_p2u_driver);
> 
> It's customary to have no blank line between the closing "};" and the
> module_platform_driver() macro.
Done.

> 
> Thierry
> 
>> +
>> +MODULE_AUTHOR("Vidya Sagar <vidyas@nvidia.com>");
>> +MODULE_DESCRIPTION("NVIDIA Tegra PIPE2UPHY PHY driver");
>> +MODULE_LICENSE("GPL v2");
>> -- 
>> 2.17.1
>>

