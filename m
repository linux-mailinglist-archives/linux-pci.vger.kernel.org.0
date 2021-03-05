Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACE432DF0A
	for <lists+linux-pci@lfdr.de>; Fri,  5 Mar 2021 02:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbhCEBYA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 4 Mar 2021 20:24:00 -0500
Received: from mail-io1-f47.google.com ([209.85.166.47]:33503 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhCEBYA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Mar 2021 20:24:00 -0500
Received: by mail-io1-f47.google.com with SMTP id n132so295430iod.0;
        Thu, 04 Mar 2021 17:23:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qCiGPmBAQHO9tt1ONRWiayoBlGqk/7+AoDpstfxzT1g=;
        b=B2PyZqEbsxlz4dydY+YMUYYrCAEJQ8u0W71oJ9pbFZ/Sz0UuRWudn1T7kOC8M8DtDS
         69p7qoOW7RC4q2r4nkNF5FnyUcnjPHIaHRu6bIMI6ETUWhevCf9h0TwcaKc1ex6W8EmI
         Ki05meem/+1KreEhOKkEF45s08zJi8RQVCnLQ+2LQo9TQP8Z9RDC12UevKP1pzstksIi
         N83rXCHPprcrVjHo/RuRNH5s9CIcpLLzBtgJbne5cJu2K+PvEA7CFXLo7qWng7WjY3yi
         Z9E8SpMVDrohBQ1gdTx/g8935hmRNcMqitfuVqEDGcKC+5xbxIFm732hyPVRaSzn3Yrg
         lJ7g==
X-Gm-Message-State: AOAM531uMmAClIdr4EkAQkA5AjmrTvFVtvGtjB3h5JQzYqOevnYYgyT/
        AkDtr4WX6keT7Bav6Zn0kIo154bNau20FuURKvQ=
X-Google-Smtp-Source: ABdhPJyuyh7aQfW+Hz4Ys3yKZmc5TNKD0E4dK9tIrXtFfmH2cFvPx7EPwhMbsk8eVyOlsorMoGiw+J1PRlbVSHaLtK0=
X-Received: by 2002:a5e:aa04:: with SMTP id s4mr5925745ioe.30.1614907439556;
 Thu, 04 Mar 2021 17:23:59 -0800 (PST)
MIME-Version: 1.0
References: <20210222071721.30062-1-xxm@rock-chips.com> <20210222071828.30120-1-xxm@rock-chips.com>
In-Reply-To: <20210222071828.30120-1-xxm@rock-chips.com>
From:   Kever Yang <kever.yang@rock-chips.com>
Date:   Fri, 5 Mar 2021 09:23:48 +0800
Message-ID: <CAKUh=RwuttWTUCGEMkabY=Yh_OUyhXQXiQEoE9VgtcKkbh9eUQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] PCI: rockchip: Add DesignWare based PCIe controller
To:     Simon Xue <xxm@rock-chips.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Johan Jonker <jbx6244@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Simon Xue <xxm@rock-chips.com> 于2021年2月22日周一 下午3:18写道：
>
> Add driver for DesignWare based PCIe controller found on RK356X.
> The already existed driver pcie-rockchip-host is only used for
> Rockchip designed IP found on RK3399.
>
> Signed-off-by: Simon Xue <xxm@rock-chips.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Patch looks good to me.

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>  drivers/pci/controller/dwc/Kconfig            |  10 +
>  drivers/pci/controller/dwc/Makefile           |   1 +
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 288 ++++++++++++++++++
>  3 files changed, 299 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-dw-rockchip.c
>
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 22c5529e9a65..159791775cc6 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -214,6 +214,16 @@ config PCIE_ARTPEC6_EP
>           Enables support for the PCIe controller in the ARTPEC-6 SoC to work in
>           endpoint mode. This uses the DesignWare core.
>
> +config PCIE_ROCKCHIP_DW_HOST
> +       bool "Rockchip DesignWare PCIe controller"
> +       select PCIE_DW
> +       select PCIE_DW_HOST
> +       depends on ARCH_ROCKCHIP || COMPILE_TEST
> +       depends on OF
> +       help
> +         Enables support for the DesignWare PCIe controller in the
> +         Rockchip SoC except RK3399.
> +
>  config PCIE_INTEL_GW
>         bool "Intel Gateway PCIe host controller support"
>         depends on OF && (X86 || COMPILE_TEST)
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> index a751553fa0db..30eef8e9ee8a 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_PCI_LAYERSCAPE_EP) += pci-layerscape-ep.o
>  obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
>  obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
>  obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
> +obj-$(CONFIG_PCIE_ROCKCHIP_DW_HOST) += pcie-dw-rockchip.o
>  obj-$(CONFIG_PCIE_INTEL_GW) += pcie-intel-gw.o
>  obj-$(CONFIG_PCIE_KIRIN) += pcie-kirin.o
>  obj-$(CONFIG_PCIE_HISI_STB) += pcie-histb.o
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> new file mode 100644
> index 000000000000..f0c40f0a7480
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -0,0 +1,288 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCIe host controller driver for Rockchip SoCs.
> + *
> + * Copyright (C) 2021 Rockchip Electronics Co., Ltd.
> + *             http://www.rock-chips.com
> + *
> + * Author: Simon Xue <xxm@rock-chips.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +
> +#include "pcie-designware.h"
> +
> +/*
> + * The upper 16 bits of PCIE_CLIENT_CONFIG are a write
> + * mask for the lower 16 bits.
> + */
> +#define HIWORD_UPDATE(mask, val) (((mask) << 16) | (val))
> +#define HIWORD_UPDATE_BIT(val) HIWORD_UPDATE(val, val)
> +
> +#define to_rockchip_pcie(x) dev_get_drvdata((x)->dev)
> +
> +#define PCIE_CLIENT_RC_MODE            HIWORD_UPDATE_BIT(0x40)
> +#define PCIE_CLIENT_ENABLE_LTSSM       HIWORD_UPDATE_BIT(0xc)
> +#define PCIE_SMLH_LINKUP               BIT(16)
> +#define PCIE_RDLH_LINKUP               BIT(17)
> +#define PCIE_LINKUP                    (PCIE_SMLH_LINKUP | PCIE_RDLH_LINKUP)
> +#define PCIE_L0S_ENTRY                 0x11
> +#define PCIE_CLIENT_GENERAL_CONTROL    0x0
> +#define PCIE_CLIENT_GENERAL_DEBUG      0x104
> +#define PCIE_CLIENT_HOT_RESET_CTRL      0x180
> +#define PCIE_CLIENT_LTSSM_STATUS       0x300
> +#define PCIE_LTSSM_ENABLE_ENHANCE       BIT(4)
> +
> +struct rockchip_pcie {
> +       struct dw_pcie                  pci;
> +       void __iomem                    *apb_base;
> +       struct phy                      *phy;
> +       struct clk_bulk_data            *clks;
> +       unsigned int                    clk_cnt;
> +       struct reset_control            *rst;
> +       struct gpio_desc                *rst_gpio;
> +       struct regulator                *vpcie3v3;
> +};
> +
> +static int rockchip_pcie_readl_apb(struct rockchip_pcie *rockchip,
> +                                            u32 reg)
> +{
> +       return readl(rockchip->apb_base + reg);
> +}
> +
> +static void rockchip_pcie_writel_apb(struct rockchip_pcie *rockchip,
> +                                               u32 val, u32 reg)
> +{
> +       writel(val, rockchip->apb_base + reg);
> +}
> +
> +static void rockchip_pcie_enable_ltssm(struct rockchip_pcie *rockchip)
> +{
> +       rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_ENABLE_LTSSM,
> +                                PCIE_CLIENT_GENERAL_CONTROL);
> +}
> +
> +static int rockchip_pcie_link_up(struct dw_pcie *pci)
> +{
> +       struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
> +       u32 val = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_LTSSM_STATUS);
> +
> +       if ((val & (PCIE_RDLH_LINKUP | PCIE_SMLH_LINKUP)) == PCIE_LINKUP &&
> +           (val & GENMASK(5, 0)) == PCIE_L0S_ENTRY)
> +               return 1;
> +
> +       return 0;
> +}
> +
> +static int rockchip_pcie_start_link(struct dw_pcie *pci)
> +{
> +       struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
> +
> +       /* Reset device */
> +       gpiod_set_value_cansleep(rockchip->rst_gpio, 0);
> +       msleep(100);
> +       gpiod_set_value_cansleep(rockchip->rst_gpio, 1);
> +
> +       rockchip_pcie_enable_ltssm(rockchip);
> +
> +       return 0;
> +}
> +
> +static void rockchip_pcie_fast_link_setup(struct rockchip_pcie *rockchip)
> +{
> +       u32 val;
> +
> +       /* LTSSM enable control mode */
> +       val = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_HOT_RESET_CTRL);
> +       val |= PCIE_LTSSM_ENABLE_ENHANCE | (PCIE_LTSSM_ENABLE_ENHANCE << 16);
> +       rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
> +}
> +
> +static int rockchip_pcie_host_init(struct pcie_port *pp)
> +{
> +       struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +       struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
> +
> +       rockchip_pcie_fast_link_setup(rockchip);
> +
> +       rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_RC_MODE,
> +                                PCIE_CLIENT_GENERAL_CONTROL);
> +
> +       return 0;
> +}
> +
> +static const struct dw_pcie_host_ops rockchip_pcie_host_ops = {
> +       .host_init = rockchip_pcie_host_init,
> +};
> +
> +static int rockchip_pcie_clk_init(struct rockchip_pcie *rockchip)
> +{
> +       struct device *dev = rockchip->pci.dev;
> +       int ret;
> +
> +       ret = devm_clk_bulk_get_all(dev, &rockchip->clks);
> +       if (ret < 0)
> +               return ret;
> +
> +       rockchip->clk_cnt = ret;
> +
> +       ret = clk_bulk_prepare_enable(rockchip->clk_cnt, rockchip->clks);
> +       if (ret)
> +               return ret;
> +
> +       return 0;
> +}
> +
> +static int rockchip_pcie_resource_get(struct platform_device *pdev,
> +                                     struct rockchip_pcie *rockchip)
> +{
> +       rockchip->apb_base = devm_platform_ioremap_resource_byname(pdev, "apb");
> +       if (IS_ERR(rockchip->apb_base))
> +               return PTR_ERR(rockchip->apb_base);
> +
> +       rockchip->rst_gpio = devm_gpiod_get_optional(&pdev->dev, "reset",
> +                                                    GPIOD_OUT_HIGH);
> +       if (IS_ERR(rockchip->rst_gpio))
> +               return PTR_ERR(rockchip->rst_gpio);
> +
> +       return 0;
> +}
> +
> +static int rockchip_pcie_phy_init(struct rockchip_pcie *rockchip)
> +{
> +       struct device *dev = rockchip->pci.dev;
> +       int ret;
> +
> +       rockchip->phy = devm_phy_get(dev, "pcie-phy");
> +       if (IS_ERR(rockchip->phy))
> +               return dev_err_probe(dev, PTR_ERR(rockchip->phy),
> +                                    "missing PHY\n");
> +
> +       ret = phy_init(rockchip->phy);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = phy_power_on(rockchip->phy);
> +       if (ret)
> +               phy_exit(rockchip->phy);
> +
> +       return ret;
> +}
> +
> +static void rockchip_pcie_phy_deinit(struct rockchip_pcie *rockchip)
> +{
> +       phy_exit(rockchip->phy);
> +       phy_power_off(rockchip->phy);
> +}
> +
> +static int rockchip_pcie_reset_control_release(struct rockchip_pcie *rockchip)
> +{
> +       struct device *dev = rockchip->pci.dev;
> +       int ret;
> +
> +       rockchip->rst = devm_reset_control_array_get_exclusive(dev);
> +       if (IS_ERR(rockchip->rst))
> +               return dev_err_probe(dev, PTR_ERR(rockchip->rst),
> +                                    "failed to get reset lines\n");
> +
> +       ret = reset_control_deassert(rockchip->rst);
> +
> +       return ret;
> +}
> +
> +static const struct dw_pcie_ops dw_pcie_ops = {
> +       .link_up = rockchip_pcie_link_up,
> +       .start_link = rockchip_pcie_start_link,
> +};
> +
> +static int rockchip_pcie_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct rockchip_pcie *rockchip;
> +       struct pcie_port *pp;
> +       int ret;
> +
> +       rockchip = devm_kzalloc(dev, sizeof(*rockchip), GFP_KERNEL);
> +       if (!rockchip)
> +               return -ENOMEM;
> +
> +       platform_set_drvdata(pdev, rockchip);
> +
> +       rockchip->pci.dev = dev;
> +       rockchip->pci.ops = &dw_pcie_ops;
> +
> +       pp = &rockchip->pci.pp;
> +       pp->ops = &rockchip_pcie_host_ops;
> +
> +       ret = rockchip_pcie_resource_get(pdev, rockchip);
> +       if (ret)
> +               return ret;
> +
> +       /* DON'T MOVE ME: must be enable before PHY init */
> +       rockchip->vpcie3v3 = devm_regulator_get_optional(dev, "vpcie3v3");
> +       if (IS_ERR(rockchip->vpcie3v3))
> +               return dev_err_probe(dev, PTR_ERR(rockchip->rst),
> +                                    "failed to get vpcie3v3 regulator\n");
> +
> +       if (rockchip->vpcie3v3) {
> +               ret = regulator_enable(rockchip->vpcie3v3);
> +               if (ret) {
> +                       dev_err(dev, "failed to enable vpcie3v3 regulator\n");
> +                       return ret;
> +               }
> +       }
> +
> +       ret = rockchip_pcie_phy_init(rockchip);
> +       if (ret)
> +               goto disable_regulator;
> +
> +       ret = rockchip_pcie_reset_control_release(rockchip);
> +       if (ret)
> +               goto deinit_phy;
> +
> +       ret = rockchip_pcie_clk_init(rockchip);
> +       if (ret)
> +               goto deinit_phy;
> +
> +       ret = dw_pcie_host_init(pp);
> +       if (ret)
> +               goto deinit_clk;
> +
> +       return 0;
> +
> +deinit_clk:
> +       clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
> +deinit_phy:
> +       rockchip_pcie_phy_deinit(rockchip);
> +disable_regulator:
> +       if (rockchip->vpcie3v3)
> +               regulator_disable(rockchip->vpcie3v3);
> +
> +       return ret;
> +}
> +
> +MODULE_DEVICE_TABLE(of, rockchip_pcie_of_match);
> +
> +static const struct of_device_id rockchip_pcie_of_match[] = {
> +       { .compatible = "rockchip,rk3568-pcie", },
> +       {},
> +};
> +
> +static struct platform_driver rockchip_pcie_driver = {
> +       .driver = {
> +               .name   = "rockchip-dw-pcie",
> +               .of_match_table = rockchip_pcie_of_match,
> +               .suppress_bind_attrs = true,
> +       },
> +       .probe = rockchip_pcie_probe,
> +};
> +
> +builtin_platform_driver(rockchip_pcie_driver);
> --
> 2.25.1
>
>
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>
>
>
