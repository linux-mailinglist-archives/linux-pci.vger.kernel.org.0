Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4293B440
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2019 13:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389459AbfFJLym (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Jun 2019 07:54:42 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43029 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389404AbfFJLyl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Jun 2019 07:54:41 -0400
Received: by mail-lj1-f195.google.com with SMTP id 16so7623439ljv.10;
        Mon, 10 Jun 2019 04:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gs+dXo03iGSXIbvZumT3whB+zUNhpW1uB1X7IkDvdb0=;
        b=DXoQ672WRtOEEQeugKYzCuci1EVDXorH0W4sPdjohMTf/tDn7+XN0DiJLtuGXHLVrF
         2L4ocu9rBFntHMFL1rUq9tI83lUegzr6JrQ+Q2i5oOt3oYyCVD84kT7bt7Zvlb3HzvrV
         xplZLmOrgyZNoaWFzAgeT0Vn2qk1PlNMEBq0lOJxQ5EFVGYFoKQQBUZyvNM4hdEHefLB
         bFgldbZolk/QqxD6XCscfgON8hbsp+vJKrjO7YCe2sRCisOBUn1IswmaAIj/RBiUOB42
         GS/BYTyis0KOWtQllpD0YSXi7ui9sUd1n6ZZWdeWRezzBj9+5Rslm7nS4/P/nXdhPN3Y
         bTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gs+dXo03iGSXIbvZumT3whB+zUNhpW1uB1X7IkDvdb0=;
        b=FYo78TZqS3qojOUhI//RaqVOisHq0Hzifu5gnyAPDP8xydsisBvRxDW2NubsnljBx5
         ToJqRkSfsjPaM13Zjr0Zb1KpKDFlM4UekOKB2rdmUaZF4k5WDh2lB+3U/ljj9kkwZgj6
         LJPhFOTQwc7+2uzcUz9MdJ7Gkew5lnfOvjipNK4VfW7kWbc3hPqmHOEqmd0UjFQKRkad
         A5LRarCe7C6mxKt+Q8T1ZuAbLzd4qNR6svwLssHqYBUo6nVALzOX0btZzC/i5RL10jY7
         u1kp8PmBogwOajJzR+dhw3LmvfhrJI7w8t/noy81sOudwAXr3xdMoosDJ3jazSlV9vrj
         P+0g==
X-Gm-Message-State: APjAAAUWNd4r55cj6l0JO4ox6Z6Yh6LFLzdhYDjrLcoQWjbjVIQ/8pQ9
        SiS2fhu6Is7wgpCMeeM1Xu0=
X-Google-Smtp-Source: APXvYqw+E63/QIjGRyPS5+iyhJUBCA93yR14aDpe6TUA4ON6HuwlLloOZxpGwwk0hQXDoWxjiy7r0Q==
X-Received: by 2002:a2e:5c88:: with SMTP id q130mr7199616ljb.176.1560167678633;
        Mon, 10 Jun 2019 04:54:38 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.googlemail.com with ESMTPSA id i5sm1966626lfo.55.2019.06.10.04.54.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 04:54:37 -0700 (PDT)
Subject: Re: [PATCH V9 13/15] phy: tegra: Add PCIe PIPE2UPHY support
To:     Vidya Sagar <vidyas@nvidia.com>, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@ti.com,
        catalin.marinas@arm.com, will.deacon@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com
Cc:     mperttunen@nvidia.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20190607144640.13427-1-vidyas@nvidia.com>
 <20190607144640.13427-14-vidyas@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <58349f3f-b9c2-2653-3a69-3bb5e836a9ef@gmail.com>
Date:   Mon, 10 Jun 2019 14:54:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190607144640.13427-14-vidyas@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

07.06.2019 17:46, Vidya Sagar пишет:
> Synopsys DesignWare core based PCIe controllers in Tegra 194 SoC interface
> with Universal PHY (UPHY) module through a PIPE2UPHY (P2U) module.
> For each PCIe lane of a controller, there is a P2U unit instantiated at
> hardware level. This driver provides support for the programming required
> for each P2U that is going to be used for a PCIe controller.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> Changes since [v8]:
> * Made it dependent on ARCH_TEGRA_194_SOC directly instead of ARCH_TEGRA
> 
> Changes since [v7]:
> * Changed P2U driver file name from pcie-p2u-tegra194.c to phy-tegra194-p2u.c
> 
> Changes since [v6]:
> * None
> 
> Changes since [v5]:
> * Addressed review comments from Thierry
> 
> Changes since [v4]:
> * None
> 
> Changes since [v3]:
> * Rebased on top of linux-next top of the tree
> 
> Changes since [v2]:
> * Replaced spaces with tabs in Kconfig file
> * Sorted header file inclusion alphabetically
> 
> Changes since [v1]:
> * Added COMPILE_TEST in Kconfig
> * Removed empty phy_ops implementations
> * Modified code according to DT documentation file modifications
> 
>  drivers/phy/tegra/Kconfig            |   7 ++
>  drivers/phy/tegra/Makefile           |   1 +
>  drivers/phy/tegra/phy-tegra194-p2u.c | 109 +++++++++++++++++++++++++++
>  3 files changed, 117 insertions(+)
>  create mode 100644 drivers/phy/tegra/phy-tegra194-p2u.c
> 
> diff --git a/drivers/phy/tegra/Kconfig b/drivers/phy/tegra/Kconfig
> index e516967d695b..f9817c3ae85f 100644
> --- a/drivers/phy/tegra/Kconfig
> +++ b/drivers/phy/tegra/Kconfig
> @@ -7,3 +7,10 @@ config PHY_TEGRA_XUSB
>  
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called phy-tegra-xusb.
> +
> +config PHY_TEGRA194_P2U
> +	tristate "NVIDIA Tegra194 PIPE2UPHY PHY driver"
> +	depends on ARCH_TEGRA_194_SOC || COMPILE_TEST
> +	select GENERIC_PHY
> +	help
> +	  Enable this to support the P2U (PIPE to UPHY) that is part of Tegra 19x SOCs.
> diff --git a/drivers/phy/tegra/Makefile b/drivers/phy/tegra/Makefile
> index 64ccaeacb631..320dd389f34d 100644
> --- a/drivers/phy/tegra/Makefile
> +++ b/drivers/phy/tegra/Makefile
> @@ -6,3 +6,4 @@ phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_124_SOC) += xusb-tegra124.o
>  phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_132_SOC) += xusb-tegra124.o
>  phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_210_SOC) += xusb-tegra210.o
>  phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_186_SOC) += xusb-tegra186.o
> +obj-$(CONFIG_PHY_TEGRA194_P2U) += phy-tegra194-p2u.o
> diff --git a/drivers/phy/tegra/phy-tegra194-p2u.c b/drivers/phy/tegra/phy-tegra194-p2u.c
> new file mode 100644
> index 000000000000..7b84b4c55e43
> --- /dev/null
> +++ b/drivers/phy/tegra/phy-tegra194-p2u.c
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * P2U (PIPE to UPHY) driver for Tegra T194 SoC
> + *
> + * Copyright (C) 2019 NVIDIA Corporation.
> + *
> + * Author: Vidya Sagar <vidyas@nvidia.com>
> + */
> +
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/phy/phy.h>
> +
> +#define P2U_PERIODIC_EQ_CTRL_GEN3	0xc0
> +#define P2U_PERIODIC_EQ_CTRL_GEN3_PERIODIC_EQ_EN		BIT(0)
> +#define P2U_PERIODIC_EQ_CTRL_GEN3_INIT_PRESET_EQ_TRAIN_EN	BIT(1)
> +#define P2U_PERIODIC_EQ_CTRL_GEN4	0xc4
> +#define P2U_PERIODIC_EQ_CTRL_GEN4_INIT_PRESET_EQ_TRAIN_EN	BIT(1)
> +
> +#define P2U_RX_DEBOUNCE_TIME				0xa4
> +#define P2U_RX_DEBOUNCE_TIME_DEBOUNCE_TIMER_MASK	0xffff
> +#define P2U_RX_DEBOUNCE_TIME_DEBOUNCE_TIMER_VAL		160
> +
> +struct tegra_p2u {
> +	void __iomem *base;
> +};
> +
> +static int tegra_p2u_power_on(struct phy *x)
> +{
> +	struct tegra_p2u *phy = phy_get_drvdata(x);
> +	u32 val;
> +
> +	val = readl(phy->base + P2U_PERIODIC_EQ_CTRL_GEN3);
> +	val &= ~P2U_PERIODIC_EQ_CTRL_GEN3_PERIODIC_EQ_EN;
> +	val |= P2U_PERIODIC_EQ_CTRL_GEN3_INIT_PRESET_EQ_TRAIN_EN;
> +	writel(val, phy->base + P2U_PERIODIC_EQ_CTRL_GEN3);
> +
> +	val = readl(phy->base + P2U_PERIODIC_EQ_CTRL_GEN4);
> +	val |= P2U_PERIODIC_EQ_CTRL_GEN4_INIT_PRESET_EQ_TRAIN_EN;
> +	writel(val, phy->base + P2U_PERIODIC_EQ_CTRL_GEN4);
> +
> +	val = readl(phy->base + P2U_RX_DEBOUNCE_TIME);
> +	val &= ~P2U_RX_DEBOUNCE_TIME_DEBOUNCE_TIMER_MASK;
> +	val |= P2U_RX_DEBOUNCE_TIME_DEBOUNCE_TIMER_VAL;
> +	writel(val, phy->base + P2U_RX_DEBOUNCE_TIME);

I'm wondering whether you're really need to insert memory barriers for
each readl/writel, can't the relaxed versions be used instead?

The same applies to other patches as well.
