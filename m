Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A03F4F79B
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2019 19:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfFVR4X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Jun 2019 13:56:23 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:15026 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfFVR4X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Jun 2019 13:56:23 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0e6bc30000>; Sat, 22 Jun 2019 10:56:20 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 22 Jun 2019 10:56:20 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 22 Jun 2019 10:56:20 -0700
Received: from [10.25.72.60] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 22 Jun
 2019 17:56:13 +0000
Subject: Re: [PATCH V10 13/15] phy: tegra: Add PCIe PIPE2UPHY support
To:     Dmitry Osipenko <digetx@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <mperttunen@nvidia.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190612095339.20118-1-vidyas@nvidia.com>
 <20190612095339.20118-14-vidyas@nvidia.com>
 <9e699085-ef5e-f7be-e27c-23907ba92c82@ti.com>
 <68a6579b-af28-ed7e-35f8-d857638368ba@gmail.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <9fe060a1-947b-9fd4-d965-5393474116e1@nvidia.com>
Date:   Sat, 22 Jun 2019 23:26:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <68a6579b-af28-ed7e-35f8-d857638368ba@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561226180; bh=FPEqeVoOjkLE9CXebBQ5ns9O3vg2DvsSK/z3knmmwi4=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=cBMF6btYslhW+xqHD9ruSdhZ25KIXdXSaIwynub9LrME0LayuDOrnXFjWpeGS2oLq
         Oo79fRdomyCU7PsnhR8OGKko+FmSJlRpJz/Q/pNHD1Ky7yQ67Nf1mQMt28yOpg3aEH
         ijk4ES0kOHjA3kjXvUBs7KmcaW+ncOi5T0nEbWnqLIOB4B80ZhS2lNDl5pl+YFi/C6
         dDH92+p0tiYQVzB8XoTNz25WvIlMfCanNwVDjmRHhGC4ZYXGcYSEXKUQflxqPBmye5
         Z8XIcgRyT9u3GqIkShgdhXBgL+eciOFJj/gB0GtMH0jaPH0IX1KKa8ywZpEkuuDWuE
         P0Z5wQHBlq0oA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/21/2019 4:53 AM, Dmitry Osipenko wrote:
> 20.06.2019 10:24, Kishon Vijay Abraham I =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>
>>
>> On 12/06/19 3:23 PM, Vidya Sagar wrote:
>>> Synopsys DesignWare core based PCIe controllers in Tegra 194 SoC interf=
ace
>>> with Universal PHY (UPHY) module through a PIPE2UPHY (P2U) module.
>>> For each PCIe lane of a controller, there is a P2U unit instantiated at
>>> hardware level. This driver provides support for the programming requir=
ed
>>> for each P2U that is going to be used for a PCIe controller.
>>
>> One minor comment below. With that fixed
>>
>> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>
>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>> ---
>>> Changes since [v9]:
>>> * Used _relaxed() versions of readl() & writel()
>>>
>>> Changes since [v8]:
>>> * Made it dependent on ARCH_TEGRA_194_SOC directly instead of ARCH_TEGR=
A
>>>
>>> Changes since [v7]:
>>> * Changed P2U driver file name from pcie-p2u-tegra194.c to phy-tegra194=
-p2u.c
>>>
>>> Changes since [v6]:
>>> * None
>>>
>>> Changes since [v5]:
>>> * Addressed review comments from Thierry
>>>
>>> Changes since [v4]:
>>> * None
>>>
>>> Changes since [v3]:
>>> * Rebased on top of linux-next top of the tree
>>>
>>> Changes since [v2]:
>>> * Replaced spaces with tabs in Kconfig file
>>> * Sorted header file inclusion alphabetically
>>>
>>> Changes since [v1]:
>>> * Added COMPILE_TEST in Kconfig
>>> * Removed empty phy_ops implementations
>>> * Modified code according to DT documentation file modifications
>>>
>>>   drivers/phy/tegra/Kconfig            |   7 ++
>>>   drivers/phy/tegra/Makefile           |   1 +
>>>   drivers/phy/tegra/phy-tegra194-p2u.c | 120 ++++++++++++++++++++++++++=
+
>>>   3 files changed, 128 insertions(+)
>>>   create mode 100644 drivers/phy/tegra/phy-tegra194-p2u.c
>>>
>>> diff --git a/drivers/phy/tegra/Kconfig b/drivers/phy/tegra/Kconfig
>>> index e516967d695b..f9817c3ae85f 100644
>>> --- a/drivers/phy/tegra/Kconfig
>>> +++ b/drivers/phy/tegra/Kconfig
>>> @@ -7,3 +7,10 @@ config PHY_TEGRA_XUSB
>>>  =20
>>>   	  To compile this driver as a module, choose M here: the module will
>>>   	  be called phy-tegra-xusb.
>>> +
>>> +config PHY_TEGRA194_P2U
>>> +	tristate "NVIDIA Tegra194 PIPE2UPHY PHY driver"
>>> +	depends on ARCH_TEGRA_194_SOC || COMPILE_TEST
>>> +	select GENERIC_PHY
>>> +	help
>>> +	  Enable this to support the P2U (PIPE to UPHY) that is part of Tegra=
 19x SOCs.
>>> diff --git a/drivers/phy/tegra/Makefile b/drivers/phy/tegra/Makefile
>>> index 64ccaeacb631..320dd389f34d 100644
>>> --- a/drivers/phy/tegra/Makefile
>>> +++ b/drivers/phy/tegra/Makefile
>>> @@ -6,3 +6,4 @@ phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_124_SOC) +=3D xusb-t=
egra124.o
>>>   phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_132_SOC) +=3D xusb-tegra124.o
>>>   phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_210_SOC) +=3D xusb-tegra210.o
>>>   phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_186_SOC) +=3D xusb-tegra186.o
>>> +obj-$(CONFIG_PHY_TEGRA194_P2U) +=3D phy-tegra194-p2u.o
>>> diff --git a/drivers/phy/tegra/phy-tegra194-p2u.c b/drivers/phy/tegra/p=
hy-tegra194-p2u.c
>>> new file mode 100644
>>> index 000000000000..df009abd2482
>>> --- /dev/null
>>> +++ b/drivers/phy/tegra/phy-tegra194-p2u.c
>>> @@ -0,0 +1,120 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/*
>>> + * P2U (PIPE to UPHY) driver for Tegra T194 SoC
>>> + *
>>> + * Copyright (C) 2019 NVIDIA Corporation.
>>> + *
>>> + * Author: Vidya Sagar <vidyas@nvidia.com>
>>> + */
>>> +
>>> +#include <linux/err.h>
>>> +#include <linux/io.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of.h>
>>> +#include <linux/of_platform.h>
>>> +#include <linux/phy/phy.h>
>>> +
>>> +#define P2U_PERIODIC_EQ_CTRL_GEN3	0xc0
>>> +#define P2U_PERIODIC_EQ_CTRL_GEN3_PERIODIC_EQ_EN		BIT(0)
>>> +#define P2U_PERIODIC_EQ_CTRL_GEN3_INIT_PRESET_EQ_TRAIN_EN	BIT(1)
>>> +#define P2U_PERIODIC_EQ_CTRL_GEN4	0xc4
>>> +#define P2U_PERIODIC_EQ_CTRL_GEN4_INIT_PRESET_EQ_TRAIN_EN	BIT(1)
>>> +
>>> +#define P2U_RX_DEBOUNCE_TIME				0xa4
>>> +#define P2U_RX_DEBOUNCE_TIME_DEBOUNCE_TIMER_MASK	0xffff
>>> +#define P2U_RX_DEBOUNCE_TIME_DEBOUNCE_TIMER_VAL		160
>>> +
>>> +struct tegra_p2u {
>>> +	void __iomem *base;
>>> +};
>>> +
>>> +static inline void p2u_writel(struct tegra_p2u *phy, const u32 value,
>>> +			      const u32 reg)
>>> +{
>>> +	writel_relaxed(value, phy->base + reg);
>>> +}
>>> +
>>> +static inline u32 p2u_readl(struct tegra_p2u *phy, const u32 reg)
>>> +{
>>> +	return readl_relaxed(phy->base + reg);
>>> +}
>>> +
>>> +static int tegra_p2u_power_on(struct phy *x)
>>> +{
>>> +	struct tegra_p2u *phy =3D phy_get_drvdata(x);
>>> +	u32 val;
>>> +
>>> +	val =3D p2u_readl(phy, P2U_PERIODIC_EQ_CTRL_GEN3);
>>> +	val &=3D ~P2U_PERIODIC_EQ_CTRL_GEN3_PERIODIC_EQ_EN;
>>> +	val |=3D P2U_PERIODIC_EQ_CTRL_GEN3_INIT_PRESET_EQ_TRAIN_EN;
>>> +	p2u_writel(phy, val, P2U_PERIODIC_EQ_CTRL_GEN3);
>>> +
>>> +	val =3D p2u_readl(phy, P2U_PERIODIC_EQ_CTRL_GEN4);
>>> +	val |=3D P2U_PERIODIC_EQ_CTRL_GEN4_INIT_PRESET_EQ_TRAIN_EN;
>>> +	p2u_writel(phy, val, P2U_PERIODIC_EQ_CTRL_GEN4);
>>> +
>>> +	val =3D p2u_readl(phy, P2U_RX_DEBOUNCE_TIME);
>>> +	val &=3D ~P2U_RX_DEBOUNCE_TIME_DEBOUNCE_TIMER_MASK;
>>> +	val |=3D P2U_RX_DEBOUNCE_TIME_DEBOUNCE_TIMER_VAL;
>>> +	p2u_writel(phy, val, P2U_RX_DEBOUNCE_TIME);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static const struct phy_ops ops =3D {
>>> +	.power_on =3D tegra_p2u_power_on,
>>> +	.owner =3D THIS_MODULE,
>>> +};
>>> +
>>> +static int tegra_p2u_probe(struct platform_device *pdev)
>>> +{
>>> +	struct phy_provider *phy_provider;
>>> +	struct device *dev =3D &pdev->dev;
>>> +	struct phy *generic_phy;
>>> +	struct tegra_p2u *phy;
>>> +	struct resource *res;
>>> +
>>> +	phy =3D devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
>>> +	if (!phy)
>>> +		return -ENOMEM;
>>> +
>>> +	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "ctl");
>>> +	phy->base =3D devm_ioremap_resource(dev, res);
>>> +	if (IS_ERR(phy->base))
>>> +		return PTR_ERR_OR_ZERO(phy->base);
>>> +
>>> +	platform_set_drvdata(pdev, phy);
>>> +
>>> +	generic_phy =3D devm_phy_create(dev, NULL, &ops);
>>> +	if (IS_ERR(generic_phy))
>>> +		return PTR_ERR_OR_ZERO(generic_phy);
>>> +
>>> +	phy_set_drvdata(generic_phy, phy);
>>> +
>>> +	phy_provider =3D devm_of_phy_provider_register(dev, of_phy_simple_xla=
te);
>>> +	if (IS_ERR(phy_provider))
>>> +		return PTR_ERR_OR_ZERO(phy_provider);
>>> +
>>> +	return 0;
>>
>> Just make this..
>> phy_provider =3D devm_of_phy_provider_register(dev, of_phy_simple_xlate)=
;
>> return PTR_ERR_OR_ZERO(phy_provider);
>=20
> There is a need to s/PTR_ERR_OR_ZERO/PTR_ERR/ for all of the occurrences
> in this patch because it is impossible to get ZERO if we already know
> that pointer is a error.
Agree with this point.

>=20
> Secondly, it is always cleaner to return 0 explicitly on success and
> PTR_ERR_OR_ZERO(phy_provider) is a much less readable form than a simple
> return 0. So I'm suggesting to keep that part as-is.
>=20
yes, true that. I'll address these in the next series
