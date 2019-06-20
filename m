Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCA624DDBB
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2019 01:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfFTXX6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jun 2019 19:23:58 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38554 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfFTXX5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jun 2019 19:23:57 -0400
Received: by mail-qk1-f196.google.com with SMTP id a27so3152125qkk.5;
        Thu, 20 Jun 2019 16:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h9qTubrFsHxwka7s4Nz2tnPYRZy8y37haq3OlAy2woE=;
        b=XLLAH1Vd65bfOd3AfIZsRrDTHdaL0Dw5iHCncpIJQYZxohsGn0XmDttLlumtyiqRdu
         AEJS+DHwXdDE6qaRxOp59LIbaPP/qUKVTKKp5WfDns9mVJKRnxcBnNE2M/8jXljqHUqY
         tfHOp7r7UyWwJ6njac9rkhOJNm4+6NOWv9JEFjQocWUzo3XJhHL1xfpAgkDt8/pOmqNV
         3F5cmNr+hADF+uLLl2sRjcO1eIbKbBVGIWagbqveOUzU7jzl8nrlOPXMp/4pynjAJniU
         SKvBGYmUd2DK2P28Nj+79i+LUel85MgN293MR7kGf0jci0AEe4AP3vmuMxIJDewJaLUs
         xEkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h9qTubrFsHxwka7s4Nz2tnPYRZy8y37haq3OlAy2woE=;
        b=VcJ7XZeTg8hlPHZ8jf3ZV9z4Hyh+Z3m7ACBWwDIJHVuekESj+uvNF5WayClIGNtSq7
         fsrCl2yusFLD8RreR5E9CJmHsjP32gQUcoDpu2fTt3kE4QfPbI3rFwfVLDTU+TZpezYG
         1ZVQ94hbiaW8TAjm6AfAmmIq7bWntnpH3bFZw+TepBvL22mx14iNgsDOP3xzhDZOIPjN
         ByE+eKc/NFi6Z/Y9K+zwwG/iQqy0Ie5uDUls9f2H00JzaAn6uNhz28sHC67xQwler5uB
         cYMX/I4OhMiKY2XRoT8lPu0yU3JPWEFQ1aBcQ9TEyqrZUhMTSNeRJtOX2W61xFkClwZu
         Figw==
X-Gm-Message-State: APjAAAW9eqttH1IGk0Co8vRLvAZ7PhHjh2f0lgKaO77Gp5DY3JT0GC0j
        1DsP24TOQM32nS7pPihYC+Q=
X-Google-Smtp-Source: APXvYqznxoKCk0MsdIJbUPwVdLJszPgir1NRXAC2N9XlcKzjFfQ4pI3Xzy7Xbfi5KZ/mZscjbK+RqA==
X-Received: by 2002:ae9:ea09:: with SMTP id f9mr3296530qkg.379.1561073036252;
        Thu, 20 Jun 2019 16:23:56 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.googlemail.com with ESMTPSA id d141sm494000qke.3.2019.06.20.16.23.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 16:23:55 -0700 (PDT)
Subject: Re: [PATCH V10 13/15] phy: tegra: Add PCIe PIPE2UPHY support
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vidya Sagar <vidyas@nvidia.com>, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        catalin.marinas@arm.com, will.deacon@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com
Cc:     mperttunen@nvidia.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20190612095339.20118-1-vidyas@nvidia.com>
 <20190612095339.20118-14-vidyas@nvidia.com>
 <9e699085-ef5e-f7be-e27c-23907ba92c82@ti.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <68a6579b-af28-ed7e-35f8-d857638368ba@gmail.com>
Date:   Fri, 21 Jun 2019 02:23:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <9e699085-ef5e-f7be-e27c-23907ba92c82@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

20.06.2019 10:24, Kishon Vijay Abraham I пишет:
> 
> 
> On 12/06/19 3:23 PM, Vidya Sagar wrote:
>> Synopsys DesignWare core based PCIe controllers in Tegra 194 SoC interface
>> with Universal PHY (UPHY) module through a PIPE2UPHY (P2U) module.
>> For each PCIe lane of a controller, there is a P2U unit instantiated at
>> hardware level. This driver provides support for the programming required
>> for each P2U that is going to be used for a PCIe controller.
> 
> One minor comment below. With that fixed
> 
> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>> Changes since [v9]:
>> * Used _relaxed() versions of readl() & writel()
>>
>> Changes since [v8]:
>> * Made it dependent on ARCH_TEGRA_194_SOC directly instead of ARCH_TEGRA
>>
>> Changes since [v7]:
>> * Changed P2U driver file name from pcie-p2u-tegra194.c to phy-tegra194-p2u.c
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
>>  drivers/phy/tegra/Kconfig            |   7 ++
>>  drivers/phy/tegra/Makefile           |   1 +
>>  drivers/phy/tegra/phy-tegra194-p2u.c | 120 +++++++++++++++++++++++++++
>>  3 files changed, 128 insertions(+)
>>  create mode 100644 drivers/phy/tegra/phy-tegra194-p2u.c
>>
>> diff --git a/drivers/phy/tegra/Kconfig b/drivers/phy/tegra/Kconfig
>> index e516967d695b..f9817c3ae85f 100644
>> --- a/drivers/phy/tegra/Kconfig
>> +++ b/drivers/phy/tegra/Kconfig
>> @@ -7,3 +7,10 @@ config PHY_TEGRA_XUSB
>>  
>>  	  To compile this driver as a module, choose M here: the module will
>>  	  be called phy-tegra-xusb.
>> +
>> +config PHY_TEGRA194_P2U
>> +	tristate "NVIDIA Tegra194 PIPE2UPHY PHY driver"
>> +	depends on ARCH_TEGRA_194_SOC || COMPILE_TEST
>> +	select GENERIC_PHY
>> +	help
>> +	  Enable this to support the P2U (PIPE to UPHY) that is part of Tegra 19x SOCs.
>> diff --git a/drivers/phy/tegra/Makefile b/drivers/phy/tegra/Makefile
>> index 64ccaeacb631..320dd389f34d 100644
>> --- a/drivers/phy/tegra/Makefile
>> +++ b/drivers/phy/tegra/Makefile
>> @@ -6,3 +6,4 @@ phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_124_SOC) += xusb-tegra124.o
>>  phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_132_SOC) += xusb-tegra124.o
>>  phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_210_SOC) += xusb-tegra210.o
>>  phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_186_SOC) += xusb-tegra186.o
>> +obj-$(CONFIG_PHY_TEGRA194_P2U) += phy-tegra194-p2u.o
>> diff --git a/drivers/phy/tegra/phy-tegra194-p2u.c b/drivers/phy/tegra/phy-tegra194-p2u.c
>> new file mode 100644
>> index 000000000000..df009abd2482
>> --- /dev/null
>> +++ b/drivers/phy/tegra/phy-tegra194-p2u.c
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
>> +static inline void p2u_writel(struct tegra_p2u *phy, const u32 value,
>> +			      const u32 reg)
>> +{
>> +	writel_relaxed(value, phy->base + reg);
>> +}
>> +
>> +static inline u32 p2u_readl(struct tegra_p2u *phy, const u32 reg)
>> +{
>> +	return readl_relaxed(phy->base + reg);
>> +}
>> +
>> +static int tegra_p2u_power_on(struct phy *x)
>> +{
>> +	struct tegra_p2u *phy = phy_get_drvdata(x);
>> +	u32 val;
>> +
>> +	val = p2u_readl(phy, P2U_PERIODIC_EQ_CTRL_GEN3);
>> +	val &= ~P2U_PERIODIC_EQ_CTRL_GEN3_PERIODIC_EQ_EN;
>> +	val |= P2U_PERIODIC_EQ_CTRL_GEN3_INIT_PRESET_EQ_TRAIN_EN;
>> +	p2u_writel(phy, val, P2U_PERIODIC_EQ_CTRL_GEN3);
>> +
>> +	val = p2u_readl(phy, P2U_PERIODIC_EQ_CTRL_GEN4);
>> +	val |= P2U_PERIODIC_EQ_CTRL_GEN4_INIT_PRESET_EQ_TRAIN_EN;
>> +	p2u_writel(phy, val, P2U_PERIODIC_EQ_CTRL_GEN4);
>> +
>> +	val = p2u_readl(phy, P2U_RX_DEBOUNCE_TIME);
>> +	val &= ~P2U_RX_DEBOUNCE_TIME_DEBOUNCE_TIMER_MASK;
>> +	val |= P2U_RX_DEBOUNCE_TIME_DEBOUNCE_TIMER_VAL;
>> +	p2u_writel(phy, val, P2U_RX_DEBOUNCE_TIME);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct phy_ops ops = {
>> +	.power_on = tegra_p2u_power_on,
>> +	.owner = THIS_MODULE,
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
> 
> Just make this..
> phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> return PTR_ERR_OR_ZERO(phy_provider);

There is a need to s/PTR_ERR_OR_ZERO/PTR_ERR/ for all of the occurrences
in this patch because it is impossible to get ZERO if we already know
that pointer is a error.

Secondly, it is always cleaner to return 0 explicitly on success and
PTR_ERR_OR_ZERO(phy_provider) is a much less readable form than a simple
return 0. So I'm suggesting to keep that part as-is.
