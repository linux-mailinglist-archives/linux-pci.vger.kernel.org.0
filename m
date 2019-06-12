Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D451420BC
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2019 11:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408647AbfFLJ2I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jun 2019 05:28:08 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:14864 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406209AbfFLJ2I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jun 2019 05:28:08 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d00c5a60000>; Wed, 12 Jun 2019 02:28:06 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 12 Jun 2019 02:28:05 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 12 Jun 2019 02:28:05 -0700
Received: from [10.24.47.96] (10.124.1.5) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 12 Jun
 2019 09:27:59 +0000
Subject: Re: [PATCH V9 13/15] phy: tegra: Add PCIe PIPE2UPHY support
To:     Dmitry Osipenko <digetx@gmail.com>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <kishon@ti.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>
CC:     <mperttunen@nvidia.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190607144640.13427-1-vidyas@nvidia.com>
 <20190607144640.13427-14-vidyas@nvidia.com>
 <58349f3f-b9c2-2653-3a69-3bb5e836a9ef@gmail.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <a126dbca-29e3-963b-5a41-f5f29d48de77@nvidia.com>
Date:   Wed, 12 Jun 2019 14:57:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <58349f3f-b9c2-2653-3a69-3bb5e836a9ef@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL108.nvidia.com (172.18.146.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560331686; bh=541DzlQkqOt5dL1lSa3BUJErRlZQ32ioMvRKqpVpig0=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=mQ6YOJnot6aqdlRCEkLoePlM0lyJltEzF8WkZvM16UW/oFBpy7M4MzBJIzgUgFFcc
         X38XRtSV+nWLuTzxP6QKXTvmPBwqP5Jmg2SVGfn0Wd81BhPE1JhzcMYkmQ92kaWidw
         F4PeLGPDF7BPWqqmgofXFAaDLwUoshwxDbJzA/gHMgtA3GZVypPG9/YIWpi0UguL7x
         cNdxq4hp70JjFJmJRpdhD12N2PdIYogQmh037TZdMbWbdY9h9mYy7D7iX9P/UOvT5n
         upq8VmkmqK1lfbaz1casmdUTfcXfqYZxCctcsotBRmytpjm/zRJ/WAk2/nMHY7q+Ld
         j0KvUZWG5iDUw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/10/2019 5:24 PM, Dmitry Osipenko wrote:
> 07.06.2019 17:46, Vidya Sagar =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> Synopsys DesignWare core based PCIe controllers in Tegra 194 SoC interfa=
ce
>> with Universal PHY (UPHY) module through a PIPE2UPHY (P2U) module.
>> For each PCIe lane of a controller, there is a P2U unit instantiated at
>> hardware level. This driver provides support for the programming require=
d
>> for each P2U that is going to be used for a PCIe controller.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>> Changes since [v8]:
>> * Made it dependent on ARCH_TEGRA_194_SOC directly instead of ARCH_TEGRA
>>
>> Changes since [v7]:
>> * Changed P2U driver file name from pcie-p2u-tegra194.c to phy-tegra194-=
p2u.c
>>
>> Changes since [v6]:
>> * None
>>
>> Changes since [v5]:
>> * Addressed review comments from Thierry
>>
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
>>   drivers/phy/tegra/Kconfig            |   7 ++
>>   drivers/phy/tegra/Makefile           |   1 +
>>   drivers/phy/tegra/phy-tegra194-p2u.c | 109 +++++++++++++++++++++++++++
>>   3 files changed, 117 insertions(+)
>>   create mode 100644 drivers/phy/tegra/phy-tegra194-p2u.c
>>
>> diff --git a/drivers/phy/tegra/Kconfig b/drivers/phy/tegra/Kconfig
>> index e516967d695b..f9817c3ae85f 100644
>> --- a/drivers/phy/tegra/Kconfig
>> +++ b/drivers/phy/tegra/Kconfig
>> @@ -7,3 +7,10 @@ config PHY_TEGRA_XUSB
>>  =20
>>   	  To compile this driver as a module, choose M here: the module will
>>   	  be called phy-tegra-xusb.
>> +
>> +config PHY_TEGRA194_P2U
>> +	tristate "NVIDIA Tegra194 PIPE2UPHY PHY driver"
>> +	depends on ARCH_TEGRA_194_SOC || COMPILE_TEST
>> +	select GENERIC_PHY
>> +	help
>> +	  Enable this to support the P2U (PIPE to UPHY) that is part of Tegra =
19x SOCs.
>> diff --git a/drivers/phy/tegra/Makefile b/drivers/phy/tegra/Makefile
>> index 64ccaeacb631..320dd389f34d 100644
>> --- a/drivers/phy/tegra/Makefile
>> +++ b/drivers/phy/tegra/Makefile
>> @@ -6,3 +6,4 @@ phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_124_SOC) +=3D xusb-te=
gra124.o
>>   phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_132_SOC) +=3D xusb-tegra124.o
>>   phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_210_SOC) +=3D xusb-tegra210.o
>>   phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_186_SOC) +=3D xusb-tegra186.o
>> +obj-$(CONFIG_PHY_TEGRA194_P2U) +=3D phy-tegra194-p2u.o
>> diff --git a/drivers/phy/tegra/phy-tegra194-p2u.c b/drivers/phy/tegra/ph=
y-tegra194-p2u.c
>> new file mode 100644
>> index 000000000000..7b84b4c55e43
>> --- /dev/null
>> +++ b/drivers/phy/tegra/phy-tegra194-p2u.c
>> @@ -0,0 +1,109 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * P2U (PIPE to UPHY) driver for Tegra T194 SoC
>> + *
>> + * Copyright (C) 2019 NVIDIA Corporation.
>> + *
>> + * Author: Vidya Sagar <vidyas@nvidia.com>
>> + */
>> +
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/phy/phy.h>
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
>> +	struct tegra_p2u *phy =3D phy_get_drvdata(x);
>> +	u32 val;
>> +
>> +	val =3D readl(phy->base + P2U_PERIODIC_EQ_CTRL_GEN3);
>> +	val &=3D ~P2U_PERIODIC_EQ_CTRL_GEN3_PERIODIC_EQ_EN;
>> +	val |=3D P2U_PERIODIC_EQ_CTRL_GEN3_INIT_PRESET_EQ_TRAIN_EN;
>> +	writel(val, phy->base + P2U_PERIODIC_EQ_CTRL_GEN3);
>> +
>> +	val =3D readl(phy->base + P2U_PERIODIC_EQ_CTRL_GEN4);
>> +	val |=3D P2U_PERIODIC_EQ_CTRL_GEN4_INIT_PRESET_EQ_TRAIN_EN;
>> +	writel(val, phy->base + P2U_PERIODIC_EQ_CTRL_GEN4);
>> +
>> +	val =3D readl(phy->base + P2U_RX_DEBOUNCE_TIME);
>> +	val &=3D ~P2U_RX_DEBOUNCE_TIME_DEBOUNCE_TIMER_MASK;
>> +	val |=3D P2U_RX_DEBOUNCE_TIME_DEBOUNCE_TIMER_VAL;
>> +	writel(val, phy->base + P2U_RX_DEBOUNCE_TIME);
>=20
> I'm wondering whether you're really need to insert memory barriers for
> each readl/writel, can't the relaxed versions be used instead?
Well, there is no real need to use readl/writel with their memory barriers.
I'll push new series replacing them with their _relaxed() counterparts.

>=20
> The same applies to other patches as well.
>=20

