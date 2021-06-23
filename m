Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F753B2247
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jun 2021 23:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhFWVRg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Jun 2021 17:17:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229929AbhFWVRe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Jun 2021 17:17:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BCD4611AD;
        Wed, 23 Jun 2021 21:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624482916;
        bh=5DDATN6MRuiNNQvmly7UIStt1wPMfoANB8FdNIH4u/8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FS1wi1JXQU4BUwRc7Iwf2ME3a8GtBq9y4YbAD+mvUee97qYDYHM+ecc7hicROLd1O
         SoQualSWy0ffvrfM5tc3BkYHEs0oR3P20nr0tZsnRIDNBoQkzwHzcaoNStVbe5je6u
         J3v2M8AuaslHLjaxHqHi5fq6awfqIUrMUpMRD3f7RNgEZQynA+EnFsk6V+nJmnRicW
         EaSyLim4qpaPi9UtxA+nTMoo1STwwKwZZryWLOY4sl4g79AeMzSYgBrHcIzZE2yRId
         phk7uV1XJ8btzUkAqc70x0DK1WpZ4XD/dR2Sw5WGKcbQCQ91m9gNlECar3ru9yvpmv
         u+bpqJmrVeTOQ==
Received: by mail-qk1-f179.google.com with SMTP id q190so8914761qkd.2;
        Wed, 23 Jun 2021 14:15:16 -0700 (PDT)
X-Gm-Message-State: AOAM532I4Ev9UV4dvZykbALuho3psmG6Pm3Nele8GdewAXc6A/snJTBK
        Ow334wmOWQ1Alz4cNkEt1aNyXbmvNKSHT1l65g==
X-Google-Smtp-Source: ABdhPJwiiW2XL8Tm79E73aQSh6PrhRd3uTAp3Xj3Bd6L+0j3Yr/wrFb9eQJMkQ2p4HP0cAncSZSePKdIGjCu5WngymA=
X-Received: by 2002:a37:947:: with SMTP id 68mr2120580qkj.364.1624482915365;
 Wed, 23 Jun 2021 14:15:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210506023448.169146-1-xxm@rock-chips.com> <20210506023544.169196-1-xxm@rock-chips.com>
In-Reply-To: <20210506023544.169196-1-xxm@rock-chips.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 23 Jun 2021 15:15:03 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+4SiNHFLTWU7005x46r=9cF83sL0S=bPwqxFSgPLgJ4A@mail.gmail.com>
Message-ID: <CAL_Jsq+4SiNHFLTWU7005x46r=9cF83sL0S=bPwqxFSgPLgJ4A@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] PCI: rockchip: Add Rockchip RK356X host controller driver
To:     Simon Xue <xxm@rock-chips.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, Johan Jonker <jbx6244@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        kernel test robot <lkp@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

 =3D=3D On Wed, May 5, 2021 at 8:35 PM Simon Xue <xxm@rock-chips.com> wrote=
:
>
> Add a driver for the DesignWare-based PCIe controller found on
> RK356X. The existing pcie-rockchip-host driver is only used for
> the Rockchip-designed IP found on RK3399.
>
> Tested-by: Peter Geis <pgwipeout@gmail.com>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Simon Xue <xxm@rock-chips.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>  drivers/pci/controller/dwc/Kconfig            |  11 +
>  drivers/pci/controller/dwc/Makefile           |   1 +
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 277 ++++++++++++++++++
>  3 files changed, 289 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-dw-rockchip.c
>
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/=
dwc/Kconfig
> index 423d35872ce4..60d3dde9ca39 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -214,6 +214,17 @@ config PCIE_ARTPEC6_EP
>           Enables support for the PCIe controller in the ARTPEC-6 SoC to =
work in
>           endpoint mode. This uses the DesignWare core.
>
> +config PCIE_ROCKCHIP_DW_HOST
> +       bool "Rockchip DesignWare PCIe controller"
> +       select PCIE_DW
> +       select PCIE_DW_HOST
> +       depends on PCI_MSI_IRQ_DOMAIN
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
> index eca805c1a023..689b06a7d334 100644
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

Use _relaxed variant.

> +}
> +
> +static void rockchip_pcie_writel_apb(struct rockchip_pcie *rockchip,
> +                                               u32 val, u32 reg)
> +{
> +       writel(val, rockchip->apb_base + reg);

Use _relaxed variant.

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

((val & PCIE_LINKUP) =3D=3D PCIE_LINKUP)

> +           (val & GENMASK(5, 0)) =3D=3D PCIE_L0S_ENTRY)

Perhaps a define for GENMASK(5, 0)

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

With gpiod, 0 means inactive which is reset deasserted. Your DT should
have an ACTIVE_LOW flag.

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

Since you have a write mask, why do you need to do a read-mod-write?
And why not use HIWORD_UPDATE_BIT?

> +       rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTR=
L);
> +
> +       rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_RC_MODE,
> +                                PCIE_CLIENT_GENERAL_CONTROL);
> +
> +       return 0;
> +}
