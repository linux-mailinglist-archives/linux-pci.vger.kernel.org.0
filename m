Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B6B34FCB9
	for <lists+linux-pci@lfdr.de>; Wed, 31 Mar 2021 11:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234717AbhCaJ04 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Mar 2021 05:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234719AbhCaJ0g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Mar 2021 05:26:36 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4B3C06174A
        for <linux-pci@vger.kernel.org>; Wed, 31 Mar 2021 02:26:36 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id w8so9183276pjf.4
        for <linux-pci@vger.kernel.org>; Wed, 31 Mar 2021 02:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mfhDzx20AsGw7xB1elLqDgyXq/O2lE+xOqpu/FQh9ps=;
        b=FMFMy8nZ31Wk7r3GEdNeRfulOUCWb2bPkl5eqRPC1yhGWsQz75rPaStwkxQxxHuqEs
         PlWVX0ZjHseCY2H6pgiTbxdMXr8IqHTnK+Llg5NSOFUhDmx2lz8cwdI7DA1tr2QBGI9d
         3o5oycHIEzFyNS3hZI+EXdzm7T1ty+p7qGfXrcWhsUYcevrh6l1h+atBZUqkEEgUBPMC
         yFDpX/GHoZ/U/GEJXMQS95+r+jfUmKlqc8GJoTVC0rm/386zN+QbWz/7ymGbtpdGFAoM
         MXG3ystSShQQv6h16VMIB9weIRHXt/p7V9LfkEU++9renXN/++D6jlJJFCH4WS5HjCCY
         zrBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mfhDzx20AsGw7xB1elLqDgyXq/O2lE+xOqpu/FQh9ps=;
        b=OlY1Ycnj0T8N1vthEEJ1OrajLRx52LR2mqpn9l0EbZFSOFzk/2YysQcFJwZ/WMiiM9
         FHudOqI+A34zGhdFbzJ+Gb4ea0tcjpuoaO2PUYmI8cB3pk4JmjyGeKlYuqwxp/+0SaBS
         fx1w+ptAAGYoqoz9yfpxNL+TxLDf6TdpYx5ruHul6t1fQlnYymAZfFzUZp19PoCckhbu
         V1BDrKyB6GHc/VnI+AHUOddg42IQR7Smi7dCZ9PGD0rfbiBz+7wB9rW1Kr8/f5118qpJ
         BgjQpLLvPD6ovT6oPVBbaL7sVz1/EIH2i772jk/zjwKry0rb9I43oyrQ6U7ugZbRLCrW
         OZvA==
X-Gm-Message-State: AOAM532BkebWwBzHtYwkgj7OHTUHduZ+TURwyuD1KffsHhDkYFIw6XCM
        VR/60Xt/Ofg9jXp+ZxN3bpjstw==
X-Google-Smtp-Source: ABdhPJzTloArSkfge5SVgST0r8NvMKvcBAnDcR09TelGgsBmsabG/zx/xEFPb0/WkB5Zv4OBHi2tjA==
X-Received: by 2002:a17:902:e5ce:b029:e5:dc8a:7490 with SMTP id u14-20020a170902e5ceb02900e5dc8a7490mr2412869plf.37.1617182796131;
        Wed, 31 Mar 2021 02:26:36 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id 143sm1726505pfx.144.2021.03.31.02.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 02:26:35 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, paul.walmsley@sifive.com, hes@sifive.com,
        erik.danie@sifive.com, zong.li@sifive.com, bhelgaas@google.com,
        robh+dt@kernel.org, aou@eecs.berkeley.edu, mturquette@baylibre.com,
        sboyd@kernel.org, lorenzo.pieralisi@arm.com,
        p.zabel@pengutronix.de, alex.dewar90@gmail.com,
        khilman@baylibre.com, hayashi.kunihiko@socionext.com,
        vidyas@nvidia.com, jh80.chung@samsung.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, helgaas@kernel.org
Subject: [PATCH v3 5/6] PCI: fu740: Add SiFive FU740 PCIe host controller driver
Date:   Wed, 31 Mar 2021 17:26:04 +0800
Message-Id: <20210331092605.105909-6-greentime.hu@sifive.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210331092605.105909-1-greentime.hu@sifive.com>
References: <20210331092605.105909-1-greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Paul Walmsley <paul.walmsley@sifive.com>

Add driver for the SiFive FU740 PCIe host controller.
This controller is based on the DesignWare PCIe core.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Co-developed-by: Henry Styles <hes@sifive.com>
Signed-off-by: Henry Styles <hes@sifive.com>
Co-developed-by: Erik Danie <erik.danie@sifive.com>
Signed-off-by: Erik Danie <erik.danie@sifive.com>
Co-developed-by: Greentime Hu <greentime.hu@sifive.com>
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 drivers/pci/controller/dwc/Kconfig      |   9 +
 drivers/pci/controller/dwc/Makefile     |   1 +
 drivers/pci/controller/dwc/pcie-fu740.c | 324 ++++++++++++++++++++++++
 3 files changed, 334 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-fu740.c

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 22c5529e9a65..0a37d21ed64e 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -318,4 +318,13 @@ config PCIE_AL
 	  required only for DT-based platforms. ACPI platforms with the
 	  Annapurna Labs PCIe controller don't need to enable this.
 
+config PCIE_FU740
+	bool "SiFive FU740 PCIe host controller"
+	depends on PCI_MSI_IRQ_DOMAIN
+	depends on SOC_SIFIVE || COMPILE_TEST
+	select PCIE_DW_HOST
+	help
+	  Say Y here if you want PCIe controller support for the SiFive
+	  FU740.
+
 endmenu
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index a751553fa0db..625f6aaeb5b8 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_PCIE_DW_EP) += pcie-designware-ep.o
 obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
 obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
 obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
+obj-$(CONFIG_PCIE_FU740) += pcie-fu740.o
 obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
 obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
 obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone.o
diff --git a/drivers/pci/controller/dwc/pcie-fu740.c b/drivers/pci/controller/dwc/pcie-fu740.c
new file mode 100644
index 000000000000..ebbcbda97490
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-fu740.c
@@ -0,0 +1,324 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * FU740 DesignWare PCIe Controller integration
+ * Copyright (C) 2019-2021 SiFive, Inc.
+ * Paul Walmsley
+ * Greentime Hu
+ *
+ * Based in part on the i.MX6 PCIe host controller shim which is:
+ *
+ * Copyright (C) 2013 Kosagi
+ *		https://www.kosagi.com
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of_gpio.h>
+#include <linux/of_device.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/resource.h>
+#include <linux/signal.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/reset.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
+
+#include "pcie-designware.h"
+
+#define to_fu740_pcie(x)	dev_get_drvdata((x)->dev)
+
+struct fu740_pcie {
+	struct dw_pcie pci;
+	void __iomem *mgmt_base;
+	struct gpio_desc *reset;
+	struct gpio_desc *pwren;
+	struct clk *pcie_aux;
+	struct reset_control *rst;
+};
+
+#define SIFIVE_DEVICESRESETREG		0x28
+
+#define PCIEX8MGMT_PERST_N		0x0
+#define PCIEX8MGMT_APP_LTSSM_ENABLE	0x10
+#define PCIEX8MGMT_APP_HOLD_PHY_RST	0x18
+#define PCIEX8MGMT_DEVICE_TYPE		0x708
+#define PCIEX8MGMT_PHY0_CR_PARA_ADDR	0x860
+#define PCIEX8MGMT_PHY0_CR_PARA_RD_EN	0x870
+#define PCIEX8MGMT_PHY0_CR_PARA_RD_DATA	0x878
+#define PCIEX8MGMT_PHY0_CR_PARA_SEL	0x880
+#define PCIEX8MGMT_PHY0_CR_PARA_WR_DATA	0x888
+#define PCIEX8MGMT_PHY0_CR_PARA_WR_EN	0x890
+#define PCIEX8MGMT_PHY0_CR_PARA_ACK	0x898
+#define PCIEX8MGMT_PHY1_CR_PARA_ADDR	0x8a0
+#define PCIEX8MGMT_PHY1_CR_PARA_RD_EN	0x8b0
+#define PCIEX8MGMT_PHY1_CR_PARA_RD_DATA	0x8b8
+#define PCIEX8MGMT_PHY1_CR_PARA_SEL	0x8c0
+#define PCIEX8MGMT_PHY1_CR_PARA_WR_DATA	0x8c8
+#define PCIEX8MGMT_PHY1_CR_PARA_WR_EN	0x8d0
+#define PCIEX8MGMT_PHY1_CR_PARA_ACK	0x8d8
+
+#define PCIEX8MGMT_PHY_CDR_TRACK_EN	BIT(0)
+#define PCIEX8MGMT_PHY_LOS_THRSHLD	BIT(5)
+#define PCIEX8MGMT_PHY_TERM_EN		BIT(9)
+#define PCIEX8MGMT_PHY_TERM_ACDC	BIT(10)
+#define PCIEX8MGMT_PHY_EN		BIT(11)
+#define PCIEX8MGMT_PHY_INIT_VAL		(PCIEX8MGMT_PHY_CDR_TRACK_EN|\
+					 PCIEX8MGMT_PHY_LOS_THRSHLD|\
+					 PCIEX8MGMT_PHY_TERM_EN|\
+					 PCIEX8MGMT_PHY_TERM_ACDC|\
+					 PCIEX8MGMT_PHY_EN)
+
+#define PCIEX8MGMT_PHY_LANEN_DIG_ASIC_RX_OVRD_IN_3	0x1008
+#define PCIEX8MGMT_PHY_LANE_OFF		0x100
+#define PCIEX8MGMT_PHY_LANE0_BASE	(PCIEX8MGMT_PHY_LANEN_DIG_ASIC_RX_OVRD_IN_3 + 0x100 * 0)
+#define PCIEX8MGMT_PHY_LANE1_BASE	(PCIEX8MGMT_PHY_LANEN_DIG_ASIC_RX_OVRD_IN_3 + 0x100 * 1)
+#define PCIEX8MGMT_PHY_LANE2_BASE	(PCIEX8MGMT_PHY_LANEN_DIG_ASIC_RX_OVRD_IN_3 + 0x100 * 2)
+#define PCIEX8MGMT_PHY_LANE3_BASE	(PCIEX8MGMT_PHY_LANEN_DIG_ASIC_RX_OVRD_IN_3 + 0x100 * 3)
+
+static void fu740_pcie_assert_reset(struct fu740_pcie *afp)
+{
+	/* Assert PERST_N GPIO */
+	gpiod_set_value_cansleep(afp->reset, 0);
+	/* Assert controller PERST_N */
+	writel_relaxed(0x0, afp->mgmt_base + PCIEX8MGMT_PERST_N);
+}
+
+static void fu740_pcie_deassert_reset(struct fu740_pcie *afp)
+{
+	/* Deassert controller PERST_N */
+	writel_relaxed(0x1, afp->mgmt_base + PCIEX8MGMT_PERST_N);
+	/* Deassert PERST_N GPIO */
+	gpiod_set_value_cansleep(afp->reset, 1);
+}
+
+static void fu740_pcie_power_on(struct fu740_pcie *afp)
+{
+	gpiod_set_value_cansleep(afp->pwren, 1);
+	/*
+	 * Ensure that PERST has been asserted for at least 100 ms.
+	 * Section 2.2 of PCI Express Card Electromechanical Specification
+	 * Revision 3.0
+	 */
+	msleep(100);
+}
+
+static void fu740_pcie_drive_reset(struct fu740_pcie *afp)
+{
+	fu740_pcie_assert_reset(afp);
+	fu740_pcie_power_on(afp);
+	fu740_pcie_deassert_reset(afp);
+}
+
+static void fu740_phyregwrite(const uint8_t phy, const uint16_t addr,
+			      const uint16_t wrdata, struct fu740_pcie *afp)
+{
+	struct device *dev = afp->pci.dev;
+	void __iomem *phy_cr_para_addr;
+	void __iomem *phy_cr_para_wr_data;
+	void __iomem *phy_cr_para_wr_en;
+	void __iomem *phy_cr_para_ack;
+	int ret, val;
+
+	/* Setup */
+	if (phy) {
+		phy_cr_para_addr = afp->mgmt_base + PCIEX8MGMT_PHY1_CR_PARA_ADDR;
+		phy_cr_para_wr_data = afp->mgmt_base + PCIEX8MGMT_PHY1_CR_PARA_WR_DATA;
+		phy_cr_para_wr_en = afp->mgmt_base + PCIEX8MGMT_PHY1_CR_PARA_WR_EN;
+		phy_cr_para_ack = afp->mgmt_base + PCIEX8MGMT_PHY1_CR_PARA_ACK;
+	} else {
+		phy_cr_para_addr = afp->mgmt_base + PCIEX8MGMT_PHY0_CR_PARA_ADDR;
+		phy_cr_para_wr_data = afp->mgmt_base + PCIEX8MGMT_PHY0_CR_PARA_WR_DATA;
+		phy_cr_para_wr_en = afp->mgmt_base + PCIEX8MGMT_PHY0_CR_PARA_WR_EN;
+		phy_cr_para_ack = afp->mgmt_base + PCIEX8MGMT_PHY0_CR_PARA_ACK;
+	}
+
+	writel_relaxed(addr, phy_cr_para_addr);
+	writel_relaxed(wrdata, phy_cr_para_wr_data);
+	writel_relaxed(1, phy_cr_para_wr_en);
+
+	/* Wait for wait_idle */
+	ret = readl_poll_timeout(phy_cr_para_ack, val, val, 10, 5000);
+	if (ret)
+		dev_err(dev, "Wait for wait_ilde state failed!\n");
+
+	/* Clear */
+	writel_relaxed(0, phy_cr_para_wr_en);
+
+	/* Wait for ~wait_idle */
+	ret = readl_poll_timeout(phy_cr_para_ack, val, !val, 10, 5000);
+	if (ret)
+		dev_err(dev, "Wait for !wait_ilde state failed!\n");
+}
+
+static void fu740_pcie_init_phy(struct fu740_pcie *afp)
+{
+	/* Enable phy cr_para_sel interfaces */
+	writel_relaxed(0x1, afp->mgmt_base + PCIEX8MGMT_PHY0_CR_PARA_SEL);
+	writel_relaxed(0x1, afp->mgmt_base + PCIEX8MGMT_PHY1_CR_PARA_SEL);
+
+	/*
+	 * Wait 10 cr_para cycles to guarantee that the registers are ready
+	 * to be edited.
+	 */
+	ndelay(10);
+
+	/* Set PHY AC termination mode */
+	fu740_phyregwrite(0, PCIEX8MGMT_PHY_LANE0_BASE, PCIEX8MGMT_PHY_INIT_VAL, afp);
+	fu740_phyregwrite(0, PCIEX8MGMT_PHY_LANE1_BASE, PCIEX8MGMT_PHY_INIT_VAL, afp);
+	fu740_phyregwrite(0, PCIEX8MGMT_PHY_LANE2_BASE, PCIEX8MGMT_PHY_INIT_VAL, afp);
+	fu740_phyregwrite(0, PCIEX8MGMT_PHY_LANE3_BASE, PCIEX8MGMT_PHY_INIT_VAL, afp);
+	fu740_phyregwrite(1, PCIEX8MGMT_PHY_LANE0_BASE, PCIEX8MGMT_PHY_INIT_VAL, afp);
+	fu740_phyregwrite(1, PCIEX8MGMT_PHY_LANE1_BASE, PCIEX8MGMT_PHY_INIT_VAL, afp);
+	fu740_phyregwrite(1, PCIEX8MGMT_PHY_LANE2_BASE, PCIEX8MGMT_PHY_INIT_VAL, afp);
+	fu740_phyregwrite(1, PCIEX8MGMT_PHY_LANE3_BASE, PCIEX8MGMT_PHY_INIT_VAL, afp);
+}
+
+static void fu740_pcie_ltssm_enable(struct device *dev)
+{
+	struct fu740_pcie *afp = dev_get_drvdata(dev);
+
+	/* Enable LTSSM */
+	writel_relaxed(0x1, afp->mgmt_base + PCIEX8MGMT_APP_LTSSM_ENABLE);
+}
+
+static int fu740_pcie_start_link(struct dw_pcie *pci)
+{
+	struct device *dev = pci->dev;
+
+	/* Start LTSSM. */
+	fu740_pcie_ltssm_enable(dev);
+	return 0;
+}
+
+static int fu740_pcie_host_init(struct pcie_port *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct fu740_pcie *afp = to_fu740_pcie(pci);
+	struct device *dev = pci->dev;
+	int ret;
+
+	/* Power on reset */
+	fu740_pcie_drive_reset(afp);
+
+	/* Enable pcieauxclk */
+	ret = clk_prepare_enable(afp->pcie_aux);
+	if (ret)
+		dev_err(dev, "unable to enable pcie_aux clock\n");
+
+	/*
+	 * Assert hold_phy_rst (hold the controller LTSSM in reset after
+	 * power_up_rst_n for register programming with cr_para)
+	 */
+	writel_relaxed(0x1, afp->mgmt_base + PCIEX8MGMT_APP_HOLD_PHY_RST);
+
+	/* Deassert power_up_rst_n */
+	ret = reset_control_deassert(afp->rst);
+	if (ret)
+		dev_err(dev, "unable to deassert pcie_power_up_rst_n\n");
+
+	fu740_pcie_init_phy(afp);
+
+	/* Disable pcieauxclk */
+	clk_disable_unprepare(afp->pcie_aux);
+	/* Clear hold_phy_rst */
+	writel_relaxed(0x0, afp->mgmt_base + PCIEX8MGMT_APP_HOLD_PHY_RST);
+	/* Enable pcieauxclk */
+	ret = clk_prepare_enable(afp->pcie_aux);
+	/* Set RC mode */
+	writel_relaxed(0x4, afp->mgmt_base + PCIEX8MGMT_DEVICE_TYPE);
+
+	return 0;
+}
+
+static const struct dw_pcie_host_ops fu740_pcie_host_ops = {
+	.host_init = fu740_pcie_host_init,
+};
+
+static const struct dw_pcie_ops dw_pcie_ops = {
+	.start_link = fu740_pcie_start_link,
+};
+
+static int fu740_pcie_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct dw_pcie *pci;
+	struct fu740_pcie *afp;
+	int ret;
+
+	afp = devm_kzalloc(dev, sizeof(*afp), GFP_KERNEL);
+	if (!afp)
+		return -ENOMEM;
+	pci = &afp->pci;
+	pci->dev = dev;
+	pci->ops = &dw_pcie_ops;
+	pci->pp.ops = &fu740_pcie_host_ops;
+
+	/* SiFive specific region: mgmt */
+	afp->mgmt_base = devm_platform_ioremap_resource_byname(pdev, "mgmt");
+	if (IS_ERR(afp->mgmt_base))
+		return PTR_ERR(afp->mgmt_base);
+
+	/* Fetch GPIOs */
+	afp->reset = devm_gpiod_get_optional(dev, "reset-gpios", GPIOD_OUT_LOW);
+	if (IS_ERR(afp->reset)) {
+		dev_err(dev, "unable to get reset-gpios\n");
+		return ret;
+	}
+	afp->pwren = devm_gpiod_get_optional(dev, "pwren-gpios", GPIOD_OUT_LOW);
+	if (IS_ERR(afp->pwren)) {
+		dev_err(dev, "unable to get pwren-gpios\n");
+		return ret;
+	}
+
+	/* Fetch clocks */
+	afp->pcie_aux = devm_clk_get(dev, "pcie_aux");
+	if (IS_ERR(afp->pcie_aux))
+		return dev_err_probe(dev, PTR_ERR(afp->pcie_aux),
+					     "pcie_aux clock source missing or invalid\n");
+
+	/* Fetch reset */
+	afp->rst = devm_reset_control_get_exclusive(dev, NULL);
+	if (IS_ERR(afp->rst))
+		return dev_err_probe(dev, PTR_ERR(afp->rst), "unable to get reset\n");
+
+	platform_set_drvdata(pdev, afp);
+
+	ret = dw_pcie_host_init(&pci->pp);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static void fu740_pcie_shutdown(struct platform_device *pdev)
+{
+	struct fu740_pcie *afp = platform_get_drvdata(pdev);
+
+	/* Bring down link, so bootloader gets clean state in case of reboot */
+	fu740_pcie_assert_reset(afp);
+}
+
+static const struct of_device_id fu740_pcie_of_match[] = {
+	{ .compatible = "sifive,fu740-pcie", },
+	{},
+};
+
+static struct platform_driver fu740_pcie_driver = {
+	.driver = {
+		   .name = "fu740-pcie",
+		   .of_match_table = fu740_pcie_of_match,
+		   .suppress_bind_attrs = true,
+	},
+	.probe = fu740_pcie_probe,
+	.shutdown = fu740_pcie_shutdown,
+};
+
+builtin_platform_driver(fu740_pcie_driver);
-- 
2.30.2

