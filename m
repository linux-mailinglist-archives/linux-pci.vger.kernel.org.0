Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B293D04E8
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jul 2021 00:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhGTWQF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jul 2021 18:16:05 -0400
Received: from mo-csw1116.securemx.jp ([210.130.202.158]:50812 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbhGTWQE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Jul 2021 18:16:04 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 16KMuCkV014291; Wed, 21 Jul 2021 07:56:12 +0900
X-Iguazu-Qid: 2wHHhCFIH53oZqJTkY
X-Iguazu-QSIG: v=2; s=0; t=1626821771; q=2wHHhCFIH53oZqJTkY; m=osn/bC0N2WaDy/AzOTDVXyRnjqCX4pb+KOZFZw4KUVo=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1110) id 16KMu9IV030713
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 21 Jul 2021 07:56:10 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id BFB161000FF;
        Wed, 21 Jul 2021 07:56:09 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 16KMu9gm026090;
        Wed, 21 Jul 2021 07:56:09 +0900
Date:   Wed, 21 Jul 2021 07:56:08 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        yuji2.ishikawa@toshiba.co.jp,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] PCI: visconti: Add Toshiba Visconti PCIe host
 controller driver
X-TSB-HOP: ON
Message-ID: <20210720225608.yt6ymgw3m7ol4erq@toshiba.co.jp>
References: <20210629234952.306578-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210629234952.306578-3-nobuhiro1.iwamatsu@toshiba.co.jp>
 <CAL_Jsq+3RXavdz1-wUtfHhMnVh3QqJY6cvtmLDm8SvkSyR-SHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+3RXavdz1-wUtfHhMnVh3QqJY6cvtmLDm8SvkSyR-SHQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Thanks for your review.

On Thu, Jul 01, 2021 at 09:43:49AM -0600, Rob Herring wrote:
> On Tue, Jun 29, 2021 at 5:50 PM Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp> wrote:
> >
> > Add support to PCIe RC controller on Toshiba Visconti ARM SoCs. PCIe
> > controller is based of Synopsys DesignWare PCIe core.
> >
> > This patch does not yet use the clock framework to control the clock.
> > This will be replaced in the future.
> >
> > Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
> > Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> > ---
> >  drivers/pci/controller/dwc/Kconfig         |   9 +
> >  drivers/pci/controller/dwc/Makefile        |   1 +
> >  drivers/pci/controller/dwc/pcie-visconti.c | 360 +++++++++++++++++++++
> >  3 files changed, 370 insertions(+)
> >  create mode 100644 drivers/pci/controller/dwc/pcie-visconti.c
> >
> > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > index 423d35872ce4..7c3dcb86fcad 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -286,6 +286,15 @@ config PCIE_TEGRA194_EP
> >           in order to enable device-specific features PCIE_TEGRA194_EP must be
> >           selected. This uses the DesignWare core.
> >
> > +config PCIE_VISCONTI_HOST
> > +       bool "Toshiba Visconti PCIe controllers"
> > +       depends on ARCH_VISCONTI || COMPILE_TEST
> > +       depends on PCI_MSI_IRQ_DOMAIN
> > +       select PCIE_DW_HOST
> > +       help
> > +         Say Y here if you want PCIe controller support on Toshiba Visconti SoC.
> > +         This driver supports TMPV7708 SoC.
> > +
> >  config PCIE_UNIPHIER
> >         bool "Socionext UniPhier PCIe host controllers"
> >         depends on ARCH_UNIPHIER || COMPILE_TEST
> > diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> > index eca805c1a023..0b569d54deb3 100644
> > --- a/drivers/pci/controller/dwc/Makefile
> > +++ b/drivers/pci/controller/dwc/Makefile
> > @@ -20,6 +20,7 @@ obj-$(CONFIG_PCIE_HISI_STB) += pcie-histb.o
> >  obj-$(CONFIG_PCI_MESON) += pci-meson.o
> >  obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
> >  obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
> > +obj-$(CONFIG_PCIE_VISCONTI_HOST) += pcie-visconti.o
> >
> >  # The following drivers are for devices that use the generic ACPI
> >  # pci_root.c driver but don't support standard ECAM config access.
> > diff --git a/drivers/pci/controller/dwc/pcie-visconti.c b/drivers/pci/controller/dwc/pcie-visconti.c
> > new file mode 100644
> > index 000000000000..1e1caa2ba1b6
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pcie-visconti.c
> > @@ -0,0 +1,360 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * DWC PCIe RC driver for Toshiba Visconti ARM SoC
> > + *
> > + * Copyright (C) 2021 Toshiba Electronic Device & Storage Corporation
> > + * Copyright (C) 2021 TOSHIBA CORPORATION
> > + *
> > + * Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/gpio.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/init.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/kernel.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/pci.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/resource.h>
> > +#include <linux/types.h>
> > +
> > +#include "pcie-designware.h"
> > +#include "../../pci.h"
> > +
> > +struct visconti_pcie {
> > +       struct dw_pcie pci;
> > +       void __iomem *ulreg_base;
> > +       void __iomem *smu_base;
> > +       void __iomem *mpu_base;
> > +       struct clk *refclk;
> > +       struct clk *coreclk;
> > +       struct clk *auxclk;
> > +};
> > +
> > +#define PCIE_UL_REG_S_PCIE_MODE                0x00F4
> > +#define  PCIE_UL_REG_S_PCIE_MODE_EP    0x00
> > +#define  PCIE_UL_REG_S_PCIE_MODE_RC    0x04
> > +
> > +#define PCIE_UL_REG_S_PERSTN_CTRL      0x00F8
> > +#define  PCIE_UL_IOM_PCIE_PERSTN_I_EN  BIT(3)
> > +#define  PCIE_UL_DIRECT_PERSTN_EN      BIT(2)
> > +#define  PCIE_UL_PERSTN_OUT            BIT(1)
> > +#define  PCIE_UL_DIRECT_PERSTN         BIT(0)
> > +#define  PCIE_UL_REG_S_PERSTN_CTRL_INIT        (PCIE_UL_IOM_PCIE_PERSTN_I_EN | \
> > +                                        PCIE_UL_DIRECT_PERSTN_EN | \
> > +                                        PCIE_UL_DIRECT_PERSTN)
> > +
> > +#define PCIE_UL_REG_S_PHY_INIT_02      0x0104
> > +#define  PCIE_UL_PHY0_SRAM_EXT_LD_DONE BIT(0)
> > +
> > +#define PCIE_UL_REG_S_PHY_INIT_03      0x0108
> > +#define  PCIE_UL_PHY0_SRAM_INIT_DONE   BIT(0)
> > +
> > +#define PCIE_UL_REG_S_INT_EVENT_MASK1  0x0138
> > +#define  PCIE_UL_CFG_PME_INT           BIT(0)
> > +#define  PCIE_UL_CFG_LINK_EQ_REQ_INT   BIT(1)
> > +#define  PCIE_UL_EDMA_INT0             BIT(2)
> > +#define  PCIE_UL_EDMA_INT1             BIT(3)
> > +#define  PCIE_UL_EDMA_INT2             BIT(4)
> > +#define  PCIE_UL_EDMA_INT3             BIT(5)
> > +#define  PCIE_UL_S_INT_EVENT_MASK1_ALL  (PCIE_UL_CFG_PME_INT | \
> > +                                        PCIE_UL_CFG_LINK_EQ_REQ_INT | \
> > +                                        PCIE_UL_EDMA_INT0 | \
> > +                                        PCIE_UL_EDMA_INT1 | \
> > +                                        PCIE_UL_EDMA_INT2 | \
> > +                                        PCIE_UL_EDMA_INT3)
> > +
> > +#define PCIE_UL_REG_S_SB_MON           0x0198
> > +#define PCIE_UL_REG_S_SIG_MON          0x019C
> > +#define  PCIE_UL_CORE_RST_N_MON                BIT(0)
> > +
> > +#define PCIE_UL_REG_V_SII_DBG_00       0x0844
> > +#define PCIE_UL_REG_V_SII_GEN_CTRL_01  0x0860
> > +#define  PCIE_UL_APP_LTSSM_ENABLE      BIT(0)
> > +
> > +#define PCIE_UL_REG_V_PHY_ST_00                0x0864
> > +#define  PCIE_UL_SMLH_LINK_UP          BIT(0)
> > +
> > +#define PCIE_UL_REG_V_PHY_ST_02                0x0868
> > +#define  PCIE_UL_S_DETECT_ACT          0x01
> > +#define  PCIE_UL_S_L0                  0x11
> > +
> > +#define PISMU_CKON_PCIE                        0x0038
> > +#define  PISMU_CKON_PCIE_AUX_CLK       BIT(1)
> > +#define  PISMU_CKON_PCIE_MSTR_ACLK     BIT(0)
> > +
> > +#define PISMU_RSOFF_PCIE               0x0538
> > +#define  PISMU_RSOFF_PCIE_ULREG_RST_N  BIT(1)
> > +#define  PISMU_RSOFF_PCIE_PWR_UP_RST_N BIT(0)
> > +
> > +#define PCIE_MPU_REG_MP_EN             0x0
> > +#define  MPU_MP_EN_DISABLE             BIT(0)
> > +
> > +#define PCIE_BUS_OFFSET                        0x40000000
> > +
> > +/* Access registers in PCIe ulreg */
> > +static void visconti_ulreg_writel(struct visconti_pcie *pcie, u32 val, u32 reg)
> > +{
> > +       writel_relaxed(val, pcie->ulreg_base + reg);
> > +}
> > +
> > +static u32 visconti_ulreg_readl(struct visconti_pcie *pcie, u32 reg)
> > +{
> > +       return readl_relaxed(pcie->ulreg_base + reg);
> > +}
> > +
> > +/* Access registers in PCIe smu */
> > +static void visconti_smu_writel(struct visconti_pcie *pcie, u32 val, u32 reg)
> > +{
> > +       writel_relaxed(val, pcie->smu_base + reg);
> > +}
> > +
> > +/* Access registers in PCIe mpu */
> > +static void visconti_mpu_writel(struct visconti_pcie *pcie, u32 val, u32 reg)
> > +{
> > +       writel_relaxed(val, pcie->mpu_base + reg);
> > +}
> > +
> > +static u32 visconti_mpu_readl(struct visconti_pcie *pcie, u32 reg)
> > +{
> > +       return readl_relaxed(pcie->mpu_base + reg);
> > +}
> > +
> > +static int visconti_pcie_link_up(struct dw_pcie *pci)
> > +{
> > +       struct visconti_pcie *pcie = dev_get_drvdata(pci->dev);
> > +       void __iomem *addr = pcie->ulreg_base;
> > +       int ret;
> > +       u32 val;
> > +
> > +       /* wait for linkup of phy link layer */
> > +       ret = readl_relaxed_poll_timeout(addr + PCIE_UL_REG_V_PHY_ST_00,
> > +                                        val, (val & PCIE_UL_SMLH_LINK_UP),
> > +                                        90000, 100000);
> 
> This function is really supposed to be 'is the link up or not', not
> 'wait for link up' as that is what the caller does. Isn't link up just
> all 3 register bits are set? And it is possible for the 3rd bit
> (PCIE_UL_S_L0) to be set without the first 2 bits set? IOW, can't you
> just check PCIE_UL_S_L0?

I mistook in using this function.
As you wrote, there is no problem in checking PCIE_UL_S_L0. I will fix it.

> 
> > +       if (ret)
> > +               return 0;
> > +
> > +       /* wait for linkup of data link layer */
> > +       ret = readl_relaxed_poll_timeout(addr + PCIE_UL_REG_V_PHY_ST_02,
> > +                                        val, (val & PCIE_UL_S_DETECT_ACT),
> > +                                        90000, 100000);
> > +       if (ret)
> > +               return 0;
> > +
> > +       /* wait for LTSSM Status */
> > +       ret = readl_relaxed_poll_timeout(addr + PCIE_UL_REG_V_PHY_ST_02,
> > +                                        val, (val & PCIE_UL_S_L0),
> > +                                        90000, 100000);
> > +       if (ret)
> > +               return 0;
> > +       return 1;
> > +}
> > +
> > +static int visconti_pcie_start_link(struct dw_pcie *pci)
> > +{
> > +       struct visconti_pcie *pcie = dev_get_drvdata(pci->dev);
> > +
> > +       visconti_ulreg_writel(pcie, PCIE_UL_APP_LTSSM_ENABLE,
> > +                             PCIE_UL_REG_V_SII_GEN_CTRL_01);
> > +
> > +       if (dw_pcie_link_up(pci)) {
> > +               u32 val;
> > +
> > +               val = visconti_mpu_readl(pcie, PCIE_MPU_REG_MP_EN);
> > +               visconti_mpu_writel(pcie, val & ~MPU_MP_EN_DISABLE,
> > +                                   PCIE_MPU_REG_MP_EN);
> > +               visconti_ulreg_writel(pcie, PCIE_UL_S_INT_EVENT_MASK1_ALL,
> > +                                     PCIE_UL_REG_S_INT_EVENT_MASK1);
> 
> Do these really have to be set after link up?

Indeed, I can move this before dw_pcie_link_up().
I will fix this.

> 
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static void visconti_pcie_stop_link(struct dw_pcie *pci)
> > +{
> > +       struct visconti_pcie *pcie = dev_get_drvdata(pci->dev);
> > +       u32 val;
> > +
> > +       val = visconti_ulreg_readl(pcie, PCIE_UL_REG_V_SII_GEN_CTRL_01);
> > +       val &= ~PCIE_UL_APP_LTSSM_ENABLE;
> > +       visconti_ulreg_writel(pcie, val, PCIE_UL_REG_V_SII_GEN_CTRL_01);
> > +
> > +       val = visconti_mpu_readl(pcie, PCIE_MPU_REG_MP_EN);
> > +       visconti_mpu_writel(pcie, val | MPU_MP_EN_DISABLE, PCIE_MPU_REG_MP_EN);
> > +}
> > +
> > +/*
> > + * In this SoC specification, the CPU bus outputs the offset value from
> > + * 0x40000000 to the PCIE bus, so 0x40000000 is subtracted from the CPU
> > + * bus address. This 0x40000000 is also based on io_base from DT.
> > + */
> > +static u64 visconti_pcie_cpu_addr_fixup(struct dw_pcie *pci, u64 cpu_addr)
> > +{
> > +       struct pcie_port *pp = &pci->pp;
> > +
> > +       return cpu_addr & ~pp->io_base;
> > +}
> > +
> > +static const struct dw_pcie_ops dw_pcie_ops = {
> > +       .cpu_addr_fixup = visconti_pcie_cpu_addr_fixup,
> > +       .link_up = visconti_pcie_link_up,
> > +       .start_link = visconti_pcie_start_link,
> > +       .stop_link = visconti_pcie_stop_link,
> > +};
> > +
> > +static int visconti_pcie_power_on(struct visconti_pcie *pcie)
> > +{
> > +       void __iomem *addr;
> > +       int err;
> > +       u32 val;
> > +
> > +       visconti_smu_writel(pcie,
> > +                           PISMU_CKON_PCIE_AUX_CLK | PISMU_CKON_PCIE_MSTR_ACLK,
> > +                           PISMU_CKON_PCIE);
> > +       ndelay(250);
> > +
> > +       visconti_smu_writel(pcie, PISMU_RSOFF_PCIE_ULREG_RST_N,
> > +                           PISMU_RSOFF_PCIE);
> > +       visconti_ulreg_writel(pcie, PCIE_UL_REG_S_PCIE_MODE_RC,
> > +                             PCIE_UL_REG_S_PCIE_MODE);
> > +
> > +       val = PCIE_UL_REG_S_PERSTN_CTRL_INIT;
> > +       visconti_ulreg_writel(pcie, val, PCIE_UL_REG_S_PERSTN_CTRL);
> > +       udelay(100);
> > +
> > +       val |= PCIE_UL_PERSTN_OUT;
> > +       visconti_ulreg_writel(pcie, val, PCIE_UL_REG_S_PERSTN_CTRL);
> > +       udelay(100);
> > +
> > +       visconti_smu_writel(pcie, PISMU_RSOFF_PCIE_PWR_UP_RST_N,
> > +                           PISMU_RSOFF_PCIE);
> > +
> > +       addr = pcie->ulreg_base + PCIE_UL_REG_S_PHY_INIT_03;
> > +       err = readl_relaxed_poll_timeout(addr, val,
> > +                                        (val & PCIE_UL_PHY0_SRAM_INIT_DONE),
> > +                                        100, 1000);
> > +       if (err)
> > +               return err;
> > +
> > +       visconti_ulreg_writel(pcie, PCIE_UL_PHY0_SRAM_EXT_LD_DONE,
> > +                             PCIE_UL_REG_S_PHY_INIT_02);
> > +
> > +       addr = pcie->ulreg_base + PCIE_UL_REG_S_SIG_MON;
> > +       return readl_relaxed_poll_timeout(addr, val,
> > +                                         (val & PCIE_UL_CORE_RST_N_MON), 100,
> > +                                         1000);
> > +}
> > +
> > +static int visconti_pcie_host_init(struct pcie_port *pp)
> > +{
> > +       struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +       struct visconti_pcie *pcie = dev_get_drvdata(pci->dev);
> > +
> > +       return visconti_pcie_power_on(pcie);
> 
> This function doesn't do anything but call visconti_pcie_power_on().
> Just collapse to 1 function.
> 

OK, I will move the contents of visconti_pcie_power_on to
visconti_pcie_host_init.

> > +}
> > +
> > +static const struct dw_pcie_host_ops visconti_pcie_host_ops = {
> > +       .host_init = visconti_pcie_host_init,
> > +};
> > +
> > +static int visconti_get_resources(struct platform_device *pdev,
> > +                                 struct visconti_pcie *pcie)
> > +{
> > +       struct device *dev = &pdev->dev;
> > +
> > +       pcie->ulreg_base = devm_platform_ioremap_resource_byname(pdev, "ulreg");
> > +       if (IS_ERR(pcie->ulreg_base))
> > +               return PTR_ERR(pcie->ulreg_base);
> > +
> > +       pcie->smu_base = devm_platform_ioremap_resource_byname(pdev, "smu");
> > +       if (IS_ERR(pcie->smu_base))
> > +               return PTR_ERR(pcie->smu_base);
> > +
> > +       pcie->mpu_base = devm_platform_ioremap_resource_byname(pdev, "mpu");
> > +       if (IS_ERR(pcie->mpu_base))
> > +               return PTR_ERR(pcie->mpu_base);
> > +
> > +       pcie->refclk = devm_clk_get(dev, "ref");
> > +       if (IS_ERR(pcie->refclk))
> > +               return dev_err_probe(dev, PTR_ERR(pcie->refclk),
> > +                                    "Failed to get ref clock\n");
> > +
> > +       pcie->coreclk = devm_clk_get(dev, "core");
> > +       if (IS_ERR(pcie->coreclk))
> > +               return dev_err_probe(dev, PTR_ERR(pcie->coreclk),
> > +                                    "Failed to get core clock\n");
> > +
> > +       pcie->auxclk = devm_clk_get(dev, "aux");
> > +       if (IS_ERR(pcie->auxclk))
> > +               return dev_err_probe(dev, PTR_ERR(pcie->auxclk),
> > +                                    "Failed to get aux clock\n");
> > +
> > +       return 0;
> > +}
> > +
> > +static int
> > +visconti_add_pcie_port(struct visconti_pcie *pcie, struct platform_device *pdev)
> > +{
> > +       struct dw_pcie *pci = &pcie->pci;
> > +       struct pcie_port *pp = &pci->pp;
> > +       struct device *dev = &pdev->dev;
> > +
> > +       pp->irq = platform_get_irq_byname(pdev, "intr");
> > +       if (pp->irq < 0) {
> > +               dev_err(dev, "Interrupt intr is missing");
> > +               return pp->irq;
> > +       }
> > +
> > +       pp->ops = &visconti_pcie_host_ops;
> > +
> > +       pci->link_gen = of_pci_get_max_link_speed(pdev->dev.of_node);
> 
> The common DWC code reads this for you now. You only need to set it to
> default. See other drivers for examples.

I don't need this code by using DT. Remove these codes.

Best regards,
  Nobuhiro

