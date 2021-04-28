Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40CF836DCDB
	for <lists+linux-pci@lfdr.de>; Wed, 28 Apr 2021 18:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240477AbhD1QVO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Apr 2021 12:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239947AbhD1QVO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Apr 2021 12:21:14 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8E9C061573;
        Wed, 28 Apr 2021 09:20:27 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id p202so30975609ybg.8;
        Wed, 28 Apr 2021 09:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sZLMmEQlltT0b2hnZFwUuOLpdjUHwWYcsq0zsCZ8p6s=;
        b=BRXQc3J6ju+mldxyR03odqbzaI5DEUtbtSxGH7K6xL4VkTauL90AxhwSh+mfq+0SJX
         +FXavJntHJZRj2EjYBuB1GSPSrELjE3Kz31m+wFteJM546KSK5HIxt8jNtAUmFX1dbay
         KxVwURXOqCIZhgvyDilqKe74WWpmbfCRwIKQftNLj0oyGxU36E0R08xeWTMkrfDxZ9tn
         65xEojo+QF6zoCnGrdEfH6cmQSE1vsK9+5VcuUUG5bZBzGuBiAJ7txjzy+XXygFemmrr
         VVDX0L5Ewq25nicbIFvICJgW+EOMSR04VGHY2/LvvYl4ZJthzXNtWGoobujJC6UcZ+k5
         uYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sZLMmEQlltT0b2hnZFwUuOLpdjUHwWYcsq0zsCZ8p6s=;
        b=TIFQFnYUOAfsoQ8u/u6b19FzkIUQzMBSXAamJzvjFMRsMXIzBwpSQlKGEsCh5nxXBz
         23pezo2tNmOQlvXDfuAFa4yOYxAGQtdgf9wsuqDEHpL6ktnn4aX8Bb3iOkszfvEwII/B
         fEeNWH896G/vBRgmq7d5ndwpv9uiaIX9252COvv7HvoOvFmwYqoLB4jiICs6qB4gpMpU
         SqL+r7kruyD+u0HvKHweZwSNrj40UdtZIE5tpNlhLr1lhcYIzfVgIVO3lIH20PvJI4gl
         IhWH11sFkjdpAuIuxg9ZeHWsQaKy51YswPgaV11MWT2oTzLvLtYQSPEPmYDvLP4jEnJn
         EoPA==
X-Gm-Message-State: AOAM532L9tXtwk5Kf4cd3BexFyJ55aPgrsDZw4rjh5zZreDq2JBZv66q
        2ScClPWT4/uOC2/XZ2uUjC8mjGxE/Tch+6f3djU=
X-Google-Smtp-Source: ABdhPJxDV69UmsKnp/NK5E0KYeHkxvAI0wY5a4CTshKqJUhC5aoX74tHEx5LipbbzX8VeTcqO/coeB9MSIh94vtj2so=
X-Received: by 2002:a5b:303:: with SMTP id j3mr38799743ybp.433.1619626827016;
 Wed, 28 Apr 2021 09:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210414070325.924789-1-xxm@rock-chips.com>
In-Reply-To: <20210414070325.924789-1-xxm@rock-chips.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Wed, 28 Apr 2021 12:20:15 -0400
Message-ID: <CAMdYzYqf3FhYrFR1DGrP=_CbNpq5uB+J-m42Mv=c6Pu71Jcxww@mail.gmail.com>
Subject: Re: [PATCH v7] PCI: rockchip: Add Rockchip RK356X host controller driver
To:     Simon Xue <xxm@rock-chips.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Johan Jonker <jbx6244@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 14, 2021 at 3:05 AM Simon Xue <xxm@rock-chips.com> wrote:
>
> Add a driver for the DesignWare-based PCIe controller found on
> RK356X. The existing pcie-rockchip-host driver is only used for
> the Rockchip-designed IP found on RK3399.

Good Afternoon,

I've encountered a bit of an issue with this driver.
Unfortunately it does not support legacy interrupts, meaning any PCIe
device that doesn't support MSIs will fail to enumerate:
[   14.932078] pcieport 0000:00:00.0: of_irq_parse_pci: failed with rc=3D-2=
2
[   14.932708] snd_hda_intel 0000:01:00.1: assign IRQ: got 0
[   14.933687] snd_hda_intel 0000:01:00.1: enabling device (0000 -> 0002)
[   14.934317] snd_hda_intel 0000:01:00.1: Disabling MSI
[   14.934783] snd_hda_intel 0000:01:00.1: Force to snoop mode by module op=
tion
[   14.935534] snd_hda_intel 0000:01:00.1: enabling bus mastering
[   14.939764] snd_hda_intel 0000:01:00.1: unable to grab IRQ 0,
disabling device

Are there plans to support legacy interrupts with the rk3568 controllers?

Thanks,
Peter Geis

>
> Signed-off-by: Simon Xue <xxm@rock-chips.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>  drivers/pci/controller/dwc/Kconfig            |  10 +
>  drivers/pci/controller/dwc/Makefile           |   1 +
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 277 ++++++++++++++++++
>  3 files changed, 288 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-dw-rockchip.c
>
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/=
dwc/Kconfig
> index 423d35872ce4..8ab027ba8c04 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -214,6 +214,16 @@ config PCIE_ARTPEC6_EP
>           Enables support for the PCIe controller in the ARTPEC-6 SoC to =
work in
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
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller=
/dwc/Makefile
> index 952d01941f23..0104659dfe88 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_PCI_LAYERSCAPE_EP) +=3D pci-layerscape-ep.=
o
>  obj-$(CONFIG_PCIE_QCOM) +=3D pcie-qcom.o
>  obj-$(CONFIG_PCIE_ARMADA_8K) +=3D pcie-armada8k.o
>  obj-$(CONFIG_PCIE_ARTPEC6) +=3D pcie-artpec6.o
> +obj-$(CONFIG_PCIE_ROCKCHIP_DW_HOST) +=3D pcie-dw-rockchip.o
>  obj-$(CONFIG_PCIE_INTEL_GW) +=3D pcie-intel-gw.o
>  obj-$(CONFIG_PCIE_KIRIN) +=3D pcie-kirin.o
>  obj-$(CONFIG_PCIE_HISI_STB) +=3D pcie-histb.o
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/=
controller/dwc/pcie-dw-rockchip.c
> new file mode 100644
> index 000000000000..3f060144eeab
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -0,0 +1,277 @@
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
> +#define PCIE_LINKUP                    (PCIE_SMLH_LINKUP | PCIE_RDLH_LIN=
KUP)
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
> +       struct rockchip_pcie *rockchip =3D to_rockchip_pcie(pci);
> +       u32 val =3D rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_LTSSM_S=
TATUS);
> +
> +       if ((val & (PCIE_RDLH_LINKUP | PCIE_SMLH_LINKUP)) =3D=3D PCIE_LIN=
KUP &&
> +           (val & GENMASK(5, 0)) =3D=3D PCIE_L0S_ENTRY)
> +               return 1;
> +
> +       return 0;
> +}
> +
> +static int rockchip_pcie_start_link(struct dw_pcie *pci)
> +{
> +       struct rockchip_pcie *rockchip =3D to_rockchip_pcie(pci);
> +
> +       /* Reset device */
> +       gpiod_set_value_cansleep(rockchip->rst_gpio, 0);
> +
> +       rockchip_pcie_enable_ltssm(rockchip);
> +
> +       /*
> +        * PCIe requires the refclk to be stable for 100=C2=B5s prior to =
releasing
> +        * PERST. See table 2-4 in section 2.6.2 AC Specifications of the=
 PCI
> +        * Express Card Electromechanical Specification, 1.1. However, we=
 don't
> +        * know if the refclk is coming from RC's PHY or external OSC. If=
 it's
> +        * from RC, so enabling LTSSM is the just right place to release =
#PERST.
> +        * We need more extra time as before, rather than setting just
> +        * 100us as we don't know how long should the device need to rese=
t.
> +        */
> +       msleep(100);
> +       gpiod_set_value_cansleep(rockchip->rst_gpio, 1);
> +
> +       return 0;
> +}
> +
> +static int rockchip_pcie_host_init(struct pcie_port *pp)
> +{
> +       struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> +       struct rockchip_pcie *rockchip =3D to_rockchip_pcie(pci);
> +       u32 val;
> +
> +       /* LTSSM enable control mode */
> +       val =3D rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_HOT_RESET_C=
TRL);
> +       val |=3D PCIE_LTSSM_ENABLE_ENHANCE | (PCIE_LTSSM_ENABLE_ENHANCE <=
< 16);
> +       rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTR=
L);
> +
> +       rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_RC_MODE,
> +                                PCIE_CLIENT_GENERAL_CONTROL);
> +
> +       return 0;
> +}
> +
> +static const struct dw_pcie_host_ops rockchip_pcie_host_ops =3D {
> +       .host_init =3D rockchip_pcie_host_init,
> +};
> +
> +static int rockchip_pcie_clk_init(struct rockchip_pcie *rockchip)
> +{
> +       struct device *dev =3D rockchip->pci.dev;
> +       int ret;
> +
> +       ret =3D devm_clk_bulk_get_all(dev, &rockchip->clks);
> +       if (ret < 0)
> +               return ret;
> +
> +       rockchip->clk_cnt =3D ret;
> +
> +       return clk_bulk_prepare_enable(rockchip->clk_cnt, rockchip->clks)=
;
> +}
> +
> +static int rockchip_pcie_resource_get(struct platform_device *pdev,
> +                                     struct rockchip_pcie *rockchip)
> +{
> +       rockchip->apb_base =3D devm_platform_ioremap_resource_byname(pdev=
, "apb");
> +       if (IS_ERR(rockchip->apb_base))
> +               return PTR_ERR(rockchip->apb_base);
> +
> +       rockchip->rst_gpio =3D devm_gpiod_get_optional(&pdev->dev, "reset=
",
> +                                                    GPIOD_OUT_HIGH);
> +       if (IS_ERR(rockchip->rst_gpio))
> +               return PTR_ERR(rockchip->rst_gpio);
> +
> +       return 0;
> +}
> +
> +static int rockchip_pcie_phy_init(struct rockchip_pcie *rockchip)
> +{
> +       struct device *dev =3D rockchip->pci.dev;
> +       int ret;
> +
> +       rockchip->phy =3D devm_phy_get(dev, "pcie-phy");
> +       if (IS_ERR(rockchip->phy))
> +               return dev_err_probe(dev, PTR_ERR(rockchip->phy),
> +                                    "missing PHY\n");
> +
> +       ret =3D phy_init(rockchip->phy);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret =3D phy_power_on(rockchip->phy);
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
> +static int rockchip_pcie_reset_control_release(struct rockchip_pcie *roc=
kchip)
> +{
> +       struct device *dev =3D rockchip->pci.dev;
> +
> +       rockchip->rst =3D devm_reset_control_array_get_exclusive(dev);
> +       if (IS_ERR(rockchip->rst))
> +               return dev_err_probe(dev, PTR_ERR(rockchip->rst),
> +                                    "failed to get reset lines\n");
> +
> +       return reset_control_deassert(rockchip->rst);
> +}
> +
> +static const struct dw_pcie_ops dw_pcie_ops =3D {
> +       .link_up =3D rockchip_pcie_link_up,
> +       .start_link =3D rockchip_pcie_start_link,
> +};
> +
> +static int rockchip_pcie_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct rockchip_pcie *rockchip;
> +       struct pcie_port *pp;
> +       int ret;
> +
> +       rockchip =3D devm_kzalloc(dev, sizeof(*rockchip), GFP_KERNEL);
> +       if (!rockchip)
> +               return -ENOMEM;
> +
> +       platform_set_drvdata(pdev, rockchip);
> +
> +       rockchip->pci.dev =3D dev;
> +       rockchip->pci.ops =3D &dw_pcie_ops;
> +
> +       pp =3D &rockchip->pci.pp;
> +       pp->ops =3D &rockchip_pcie_host_ops;
> +
> +       ret =3D rockchip_pcie_resource_get(pdev, rockchip);
> +       if (ret)
> +               return ret;
> +
> +       /* DON'T MOVE ME: must be enable before PHY init */
> +       rockchip->vpcie3v3 =3D devm_regulator_get_optional(dev, "vpcie3v3=
");
> +       if (IS_ERR(rockchip->vpcie3v3))
> +               if (PTR_ERR(rockchip->vpcie3v3) !=3D -ENODEV)
> +                       return dev_err_probe(dev, PTR_ERR(rockchip->vpcie=
3v3),
> +                                       "failed to get vpcie3v3 regulator=
\n");
> +
> +       ret =3D regulator_enable(rockchip->vpcie3v3);
> +       if (ret) {
> +               dev_err(dev, "failed to enable vpcie3v3 regulator\n");
> +               return ret;
> +       }
> +
> +       ret =3D rockchip_pcie_phy_init(rockchip);
> +       if (ret)
> +               goto disable_regulator;
> +
> +       ret =3D rockchip_pcie_reset_control_release(rockchip);
> +       if (ret)
> +               goto deinit_phy;
> +
> +       ret =3D rockchip_pcie_clk_init(rockchip);
> +       if (ret)
> +               goto deinit_phy;
> +
> +       ret =3D dw_pcie_host_init(pp);
> +       if (!ret)
> +               return 0;
> +
> +       clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
> +deinit_phy:
> +       rockchip_pcie_phy_deinit(rockchip);
> +disable_regulator:
> +       regulator_disable(rockchip->vpcie3v3);
> +
> +       return ret;
> +}
> +
> +static const struct of_device_id rockchip_pcie_of_match[] =3D {
> +       { .compatible =3D "rockchip,rk3568-pcie", },
> +       {},
> +};
> +
> +static struct platform_driver rockchip_pcie_driver =3D {
> +       .driver =3D {
> +               .name   =3D "rockchip-dw-pcie",
> +               .of_match_table =3D rockchip_pcie_of_match,
> +               .suppress_bind_attrs =3D true,
> +       },
> +       .probe =3D rockchip_pcie_probe,
> +};
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
