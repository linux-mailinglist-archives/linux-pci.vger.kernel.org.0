Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C013E4449
	for <lists+linux-pci@lfdr.de>; Mon,  9 Aug 2021 12:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbhHIK63 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Aug 2021 06:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbhHIK6S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Aug 2021 06:58:18 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AC7C0613D3;
        Mon,  9 Aug 2021 03:57:50 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id c137so28270339ybf.5;
        Mon, 09 Aug 2021 03:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=29y/iLxNFNnvLYgOgqntrEvNskLkzb3T+cHZyF7bUPo=;
        b=Abm0cm6I/+CyTKXMwu6hEStFtMK0RXqgvqMbDOU/bH56Ibe53b1hnHrCED8JjLC51E
         FuEsvn9kUgt7XKG2dGVuq0RFAivZ3D8b/WEMs30oyTvoCZN8vkxzcSXzzxZ8d3Qo++Au
         znyFDhAK2894pPpwut/GtMhzTJTCfM08naRZMqmAW+0QXj+s511h06x48j7oFq8GKTT0
         3HlzxlTe8RpL55FsYZyNR0/kpfW4F6qHG9BNc5P6uvui74Cfulrj77qQi2CzO3Mj9vIC
         QGk+kN7D2AmTLvjikUV4Uf+PwYfbYrNESCZWBc/fAX1WYFJMe2r49iEGnj2BEIDJE6Zx
         9SRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=29y/iLxNFNnvLYgOgqntrEvNskLkzb3T+cHZyF7bUPo=;
        b=k0NP7ArG3Iz1RgzZB6dKyEnp2dqXEEt6mXoI6QuDiTQ83hPycxW4npYl6EWy1lu2A0
         6Cv72EvkdJXcYRjPQ4f4S41gmr7ps/pIXpYMyJ6EEd5cyHriBTyeXyTP1AYJoPitnwgP
         D6nfd5f7EMm7Xhco7eL8lHmo3Xxe44mC1RJs7R8wN3Mf1zP+dMtlSmPXcpBWuZ4Df7kR
         MkJBT9u7UL66m6jNATnqcKavsZw0SI6JXG1lJvGtKfioswhUiy3Ix9Wxe28EhXwG5fxC
         wYm2NxgI+LbcNlNb9Y1VLKI80hbW3nOK7WZTtuYvKzorirYyEt+gG0FUqRG90NSfjwZN
         L0MA==
X-Gm-Message-State: AOAM531IwqO06EnADMk7z+kLILhj8wGdmQ7M0sVd7K6Je5sb9nQ38VOD
        7oiMVFhVt64C2uFkq0kJIemXgbaxYxO9vP2Q6rM=
X-Google-Smtp-Source: ABdhPJyIaGIL719GmPBLn0xZ+eSUsLKZMW2KPqAsrxqSHsss+LR1j4yGTNSE/bVQW/GmAV7DPoLWWnaPvdWwoWs45oY=
X-Received: by 2002:a25:3c5:: with SMTP id 188mr28131568ybd.437.1628506669209;
 Mon, 09 Aug 2021 03:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210625065511.1096935-1-xxm@rock-chips.com> <202108091743281185811@rock-chips.com>
In-Reply-To: <202108091743281185811@rock-chips.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Mon, 9 Aug 2021 06:57:38 -0400
Message-ID: <CAMdYzYqX-3BVqiyZycWFixQhUiNT5hg3SZvid8s=+mjGs06KkQ@mail.gmail.com>
Subject: Re: [PATCH v11] PCI: rockchip-dwc: Add Rockchip RK356X host
 controller driver
To:     "xxm@rock-chips.com" <xxm@rock-chips.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-rockchip <linux-rockchip@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        "robh+dt" <robh+dt@kernel.org>, jbx6244 <jbx6244@gmail.com>,
        heiko <heiko@sntech.de>,
        "kever.yang" <kever.yang@rock-chips.com>,
        =?UTF-8?B?5p6X5rabKOW6leWxguW5s+WPsCk=?= <shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 9, 2021 at 5:43 AM xxm@rock-chips.com <xxm@rock-chips.com> wrot=
e:
>
> Hi all,
>
> If any new comments about this patch?

Good Morning,

Not a direct comment, but certainly adjacent.
Is there any status on the ITS errata?

My reasoning is the mbi-alias method isn't perfect, for example the
following error is constantlyseen using it:
[39910.458531] ixgbe 0000:01:00.1 enp1s0f1: NIC Link is Up 10 Gbps,
Flow Control: RX/TX
[40049.195579] ixgbe 0000:01:00.1 enp1s0f1: NIC Link is Down
[40049.783010] ixgbe 0000:01:00.1 enp1s0f1: NIC Link is Up 10 Gbps,
Flow Control: RX/TX
[40110.597421] ixgbe 0000:01:00.1 enp1s0f1: NIC Link is Down

This issue doesn't occur when using legacy interrupts nor proper ITS servic=
es.

The only other issue I have encountered is dGPUs do not function.
I suspect the PCIe controller is affected by the same cache coherency
issue as the ITS translator is, is that correct?

Otherwise, I've had great success with this driver.

Very Respectfully,
Peter Geis

> >Add a driver for the DesignWare-based PCIe controller found on
> >RK356X. The existing pcie-rockchip-host driver is only used for
> >the Rockchip-designed IP found on RK3399.
> >
> >Tested-by: Peter Geis <pgwipeout@gmail.com>
> >Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> >Signed-off-by: Simon Xue <xxm@rock-chips.com>
> >Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> >---
> > drivers/pci/controller/dwc/Kconfig            |  11 +
> > drivers/pci/controller/dwc/Makefile           |   1 +
> > drivers/pci/controller/dwc/pcie-dw-rockchip.c | 276 ++++++++++++++++++
> > 3 files changed, 288 insertions(+)
> > create mode 100644 drivers/pci/controller/dwc/pcie-dw-rockchip.c
> >
> >diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller=
/dwc/Kconfig
> >index 423d35872ce4..60d3dde9ca39 100644
> >--- a/drivers/pci/controller/dwc/Kconfig
> >+++ b/drivers/pci/controller/dwc/Kconfig
> >@@ -214,6 +214,17 @@ config PCIE_ARTPEC6_EP
> >   Enables support for the PCIe controller in the ARTPEC-6 SoC to work i=
n
> >   endpoint mode. This uses the DesignWare core.
> >
> >+config PCIE_ROCKCHIP_DW_HOST
> >+      bool "Rockchip DesignWare PCIe controller"
> >+      select PCIE_DW
> >+      select PCIE_DW_HOST
> >+      depends on PCI_MSI_IRQ_DOMAIN
> >+      depends on ARCH_ROCKCHIP || COMPILE_TEST
> >+      depends on OF
> >+      help
> >+        Enables support for the DesignWare PCIe controller in the
> >+        Rockchip SoC except RK3399.
> >+
> > config PCIE_INTEL_GW
> > bool "Intel Gateway PCIe host controller support"
> > depends on OF && (X86 || COMPILE_TEST)
> >diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controlle=
r/dwc/Makefile
> >index 9e6ce0dc2f53..3710e91471f7 100644
> >--- a/drivers/pci/controller/dwc/Makefile
> >+++ b/drivers/pci/controller/dwc/Makefile
> >@@ -14,6 +14,7 @@ obj-$(CONFIG_PCI_LAYERSCAPE_EP) +=3D pci-layerscape-ep=
.o
> > obj-$(CONFIG_PCIE_QCOM) +=3D pcie-qcom.o
> > obj-$(CONFIG_PCIE_ARMADA_8K) +=3D pcie-armada8k.o
> > obj-$(CONFIG_PCIE_ARTPEC6) +=3D pcie-artpec6.o
> >+obj-$(CONFIG_PCIE_ROCKCHIP_DW_HOST) +=3D pcie-dw-rockchip.o
> > obj-$(CONFIG_PCIE_INTEL_GW) +=3D pcie-intel-gw.o
> > obj-$(CONFIG_PCIE_KIRIN) +=3D pcie-kirin.o
> > obj-$(CONFIG_PCIE_HISI_STB) +=3D pcie-histb.o
> >diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci=
/controller/dwc/pcie-dw-rockchip.c
> >new file mode 100644
> >index 000000000000..20cef2e06f66
> >--- /dev/null
> >+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> >@@ -0,0 +1,276 @@
> >+// SPDX-License-Identifier: GPL-2.0
> >+/*
> >+ * PCIe host controller driver for Rockchip SoCs.
> >+ *
> >+ * Copyright (C) 2021 Rockchip Electronics Co., Ltd.
> >+ *    http://www.rock-chips.com
> >+ *
> >+ * Author: Simon Xue <xxm@rock-chips.com>
> >+ */
> >+
> >+#include <linux/clk.h>
> >+#include <linux/gpio/consumer.h>
> >+#include <linux/mfd/syscon.h>
> >+#include <linux/module.h>
> >+#include <linux/of_device.h>
> >+#include <linux/phy/phy.h>
> >+#include <linux/platform_device.h>
> >+#include <linux/regmap.h>
> >+#include <linux/reset.h>
> >+
> >+#include "pcie-designware.h"
> >+
> >+/*
> >+ * The upper 16 bits of PCIE_CLIENT_CONFIG are a write
> >+ * mask for the lower 16 bits.
> >+ */
> >+#define HIWORD_UPDATE(mask, val) (((mask) << 16) | (val))
> >+#define HIWORD_UPDATE_BIT(val)        HIWORD_UPDATE(val, val)
> >+
> >+#define to_rockchip_pcie(x) dev_get_drvdata((x)->dev)
> >+
> >+#define PCIE_CLIENT_RC_MODE   HIWORD_UPDATE_BIT(0x40)
> >+#define PCIE_CLIENT_ENABLE_LTSSM      HIWORD_UPDATE_BIT(0xc)
> >+#define PCIE_SMLH_LINKUP      BIT(16)
> >+#define PCIE_RDLH_LINKUP      BIT(17)
> >+#define PCIE_LINKUP   (PCIE_SMLH_LINKUP | PCIE_RDLH_LINKUP)
> >+#define PCIE_L0S_ENTRY        0x11
> >+#define PCIE_CLIENT_GENERAL_CONTROL   0x0
> >+#define PCIE_CLIENT_GENERAL_DEBUG     0x104
> >+#define PCIE_CLIENT_HOT_RESET_CTRL      0x180
> >+#define PCIE_CLIENT_LTSSM_STATUS      0x300
> >+#define PCIE_LTSSM_ENABLE_ENHANCE       BIT(4)
> >+#define PCIE_LTSSM_STATUS_MASK        GENMASK(5, 0)
> >+
> >+struct rockchip_pcie {
> >+      struct dw_pcie  pci;
> >+      void __iomem    *apb_base;
> >+      struct phy      *phy;
> >+      struct clk_bulk_data    *clks;
> >+      unsigned int    clk_cnt;
> >+      struct reset_control    *rst;
> >+      struct gpio_desc        *rst_gpio;
> >+      struct regulator                *vpcie3v3;
> >+};
> >+
> >+static int rockchip_pcie_readl_apb(struct rockchip_pcie *rockchip,
> >+           u32 reg)
> >+{
> >+      return readl_relaxed(rockchip->apb_base + reg);
> >+}
> >+
> >+static void rockchip_pcie_writel_apb(struct rockchip_pcie *rockchip,
> >+      u32 val, u32 reg)
> >+{
> >+      writel_relaxed(val, rockchip->apb_base + reg);
> >+}
> >+
> >+static void rockchip_pcie_enable_ltssm(struct rockchip_pcie *rockchip)
> >+{
> >+      rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_ENABLE_LTSSM,
> >+      PCIE_CLIENT_GENERAL_CONTROL);
> >+}
> >+
> >+static int rockchip_pcie_link_up(struct dw_pcie *pci)
> >+{
> >+      struct rockchip_pcie *rockchip =3D to_rockchip_pcie(pci);
> >+      u32 val =3D rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_LTSSM_S=
TATUS);
> >+
> >+      if ((val & PCIE_LINKUP) =3D=3D PCIE_LINKUP &&
> >+          (val & PCIE_LTSSM_STATUS_MASK) =3D=3D PCIE_L0S_ENTRY)
> >+      return 1;
> >+
> >+      return 0;
> >+}
> >+
> >+static int rockchip_pcie_start_link(struct dw_pcie *pci)
> >+{
> >+      struct rockchip_pcie *rockchip =3D to_rockchip_pcie(pci);
> >+
> >+      /* Reset device */
> >+      gpiod_set_value_cansleep(rockchip->rst_gpio, 0);
> >+
> >+      rockchip_pcie_enable_ltssm(rockchip);
> >+
> >+      /*
> >+      * PCIe requires the refclk to be stable for 100=C2=B5s prior to r=
eleasing
> >+      * PERST. See table 2-4 in section 2.6.2 AC Specifications of the =
PCI
> >+      * Express Card Electromechanical Specification, 1.1. However, we =
don't
> >+      * know if the refclk is coming from RC's PHY or external OSC. If =
it's
> >+      * from RC, so enabling LTSSM is the just right place to release #=
PERST.
> >+      * We need more extra time as before, rather than setting just
> >+      * 100us as we don't know how long should the device need to reset=
.
> >+      */
> >+      msleep(100);
> >+      gpiod_set_value_cansleep(rockchip->rst_gpio, 1);
> >+
> >+      return 0;
> >+}
> >+
> >+static int rockchip_pcie_host_init(struct pcie_port *pp)
> >+{
> >+      struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> >+      struct rockchip_pcie *rockchip =3D to_rockchip_pcie(pci);
> >+      u32 val =3D HIWORD_UPDATE_BIT(PCIE_LTSSM_ENABLE_ENHANCE);
> >+
> >+      /* LTSSM enable control mode */
> >+      rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTR=
L);
> >+
> >+      rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_RC_MODE,
> >+      PCIE_CLIENT_GENERAL_CONTROL);
> >+
> >+      return 0;
> >+}
> >+
> >+static const struct dw_pcie_host_ops rockchip_pcie_host_ops =3D {
> >+      .host_init =3D rockchip_pcie_host_init,
> >+};
> >+
> >+static int rockchip_pcie_clk_init(struct rockchip_pcie *rockchip)
> >+{
> >+      struct device *dev =3D rockchip->pci.dev;
> >+      int ret;
> >+
> >+      ret =3D devm_clk_bulk_get_all(dev, &rockchip->clks);
> >+      if (ret < 0)
> >+      return ret;
> >+
> >+      rockchip->clk_cnt =3D ret;
> >+
> >+      return clk_bulk_prepare_enable(rockchip->clk_cnt, rockchip->clks)=
;
> >+}
> >+
> >+static int rockchip_pcie_resource_get(struct platform_device *pdev,
> >+            struct rockchip_pcie *rockchip)
> >+{
> >+      rockchip->apb_base =3D devm_platform_ioremap_resource_byname(pdev=
, "apb");
> >+      if (IS_ERR(rockchip->apb_base))
> >+      return PTR_ERR(rockchip->apb_base);
> >+
> >+      rockchip->rst_gpio =3D devm_gpiod_get_optional(&pdev->dev, "reset=
",
> >+           GPIOD_OUT_HIGH);
> >+      if (IS_ERR(rockchip->rst_gpio))
> >+      return PTR_ERR(rockchip->rst_gpio);
> >+
> >+      return 0;
> >+}
> >+
> >+static int rockchip_pcie_phy_init(struct rockchip_pcie *rockchip)
> >+{
> >+      struct device *dev =3D rockchip->pci.dev;
> >+      int ret;
> >+
> >+      rockchip->phy =3D devm_phy_get(dev, "pcie-phy");
> >+      if (IS_ERR(rockchip->phy))
> >+      return dev_err_probe(dev, PTR_ERR(rockchip->phy),
> >+           "missing PHY\n");
> >+
> >+      ret =3D phy_init(rockchip->phy);
> >+      if (ret < 0)
> >+      return ret;
> >+
> >+      ret =3D phy_power_on(rockchip->phy);
> >+      if (ret)
> >+      phy_exit(rockchip->phy);
> >+
> >+      return ret;
> >+}
> >+
> >+static void rockchip_pcie_phy_deinit(struct rockchip_pcie *rockchip)
> >+{
> >+      phy_exit(rockchip->phy);
> >+      phy_power_off(rockchip->phy);
> >+}
> >+
> >+static int rockchip_pcie_reset_control_release(struct rockchip_pcie *ro=
ckchip)
> >+{
> >+      struct device *dev =3D rockchip->pci.dev;
> >+
> >+      rockchip->rst =3D devm_reset_control_array_get_exclusive(dev);
> >+      if (IS_ERR(rockchip->rst))
> >+      return dev_err_probe(dev, PTR_ERR(rockchip->rst),
> >+           "failed to get reset lines\n");
> >+
> >+      return reset_control_deassert(rockchip->rst);
> >+}
> >+
> >+static const struct dw_pcie_ops dw_pcie_ops =3D {
> >+      .link_up =3D rockchip_pcie_link_up,
> >+      .start_link =3D rockchip_pcie_start_link,
> >+};
> >+
> >+static int rockchip_pcie_probe(struct platform_device *pdev)
> >+{
> >+      struct device *dev =3D &pdev->dev;
> >+      struct rockchip_pcie *rockchip;
> >+      struct pcie_port *pp;
> >+      int ret;
> >+
> >+      rockchip =3D devm_kzalloc(dev, sizeof(*rockchip), GFP_KERNEL);
> >+      if (!rockchip)
> >+      return -ENOMEM;
> >+
> >+      platform_set_drvdata(pdev, rockchip);
> >+
> >+      rockchip->pci.dev =3D dev;
> >+      rockchip->pci.ops =3D &dw_pcie_ops;
> >+
> >+      pp =3D &rockchip->pci.pp;
> >+      pp->ops =3D &rockchip_pcie_host_ops;
> >+
> >+      ret =3D rockchip_pcie_resource_get(pdev, rockchip);
> >+      if (ret)
> >+      return ret;
> >+
> >+      /* DON'T MOVE ME: must be enable before PHY init */
> >+      rockchip->vpcie3v3 =3D devm_regulator_get_optional(dev, "vpcie3v3=
");
> >+      if (IS_ERR(rockchip->vpcie3v3))
> >+      if (PTR_ERR(rockchip->vpcie3v3) !=3D -ENODEV)
> >+      return dev_err_probe(dev, PTR_ERR(rockchip->vpcie3v3),
> >+      "failed to get vpcie3v3 regulator\n");
> >+
> >+      ret =3D regulator_enable(rockchip->vpcie3v3);
> >+      if (ret) {
> >+      dev_err(dev, "failed to enable vpcie3v3 regulator\n");
> >+      return ret;
> >+      }
> >+
> >+      ret =3D rockchip_pcie_phy_init(rockchip);
> >+      if (ret)
> >+      goto disable_regulator;
> >+
> >+      ret =3D rockchip_pcie_reset_control_release(rockchip);
> >+      if (ret)
> >+      goto deinit_phy;
> >+
> >+      ret =3D rockchip_pcie_clk_init(rockchip);
> >+      if (ret)
> >+      goto deinit_phy;
> >+
> >+      ret =3D dw_pcie_host_init(pp);
> >+      if (!ret)
> >+      return 0;
> >+
> >+      clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
> >+deinit_phy:
> >+      rockchip_pcie_phy_deinit(rockchip);
> >+disable_regulator:
> >+      regulator_disable(rockchip->vpcie3v3);
> >+
> >+      return ret;
> >+}
> >+
> >+static const struct of_device_id rockchip_pcie_of_match[] =3D {
> >+      { .compatible =3D "rockchip,rk3568-pcie", },
> >+      {},
> >+};
> >+
> >+static struct platform_driver rockchip_pcie_driver =3D {
> >+      .driver =3D {
> >+      .name   =3D "rockchip-dw-pcie",
> >+      .of_match_table =3D rockchip_pcie_of_match,
> >+      .suppress_bind_attrs =3D true,
> >+      },
> >+      .probe =3D rockchip_pcie_probe,
> >+};
> >+builtin_platform_driver(rockchip_pcie_driver);
> >--
> >2.25.1
> >
> >
> >
> >
