Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E7C7592BF
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jul 2023 12:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjGSKVY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jul 2023 06:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjGSKVO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2023 06:21:14 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738611FD2;
        Wed, 19 Jul 2023 03:21:08 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 3607824E2C2;
        Wed, 19 Jul 2023 18:21:07 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 19 Jul
 2023 18:21:07 +0800
Received: from ubuntu.localdomain (113.72.147.86) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 19 Jul
 2023 18:21:06 +0800
From:   Minda Chen <minda.chen@starfivetech.com>
To:     Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>,
        Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v1 8/9] PCI: PLDA: starfive: Add JH7110 PCIe controller
Date:   Wed, 19 Jul 2023 18:20:56 +0800
Message-ID: <20230719102057.22329-9-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230719102057.22329-1-minda.chen@starfivetech.com>
References: <20230719102057.22329-1-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.147.86]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add StarFive JH7110 SoC PCIe controller platform
driver codes.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
---
 MAINTAINERS                                 |   7 +
 drivers/pci/controller/plda/Kconfig         |   8 +
 drivers/pci/controller/plda/Makefile        |   1 +
 drivers/pci/controller/plda/pcie-plda.h     |  58 ++-
 drivers/pci/controller/plda/pcie-starfive.c | 415 ++++++++++++++++++++
 5 files changed, 487 insertions(+), 2 deletions(-)
 create mode 100644 drivers/pci/controller/plda/pcie-starfive.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f02618c2bdf5..b88a54a24ae5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20356,6 +20356,13 @@ S:	Supported
 F:	Documentation/devicetree/bindings/watchdog/starfive*
 F:	drivers/watchdog/starfive-wdt.c
 
+STARFIVE JH71x0 PCIE DRIVER
+M:	Minda Chen <minda.chen@starfivetech.com>
+L:	linux-pci@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/pci/starfive*
+F:	drivers/pci/controller/plda/pcie-starfive.c
+
 STATIC BRANCH/CALL
 M:	Peter Zijlstra <peterz@infradead.org>
 M:	Josh Poimboeuf <jpoimboe@kernel.org>
diff --git a/drivers/pci/controller/plda/Kconfig b/drivers/pci/controller/plda/Kconfig
index a3c790545843..eaf72954da9f 100644
--- a/drivers/pci/controller/plda/Kconfig
+++ b/drivers/pci/controller/plda/Kconfig
@@ -24,4 +24,12 @@ config PCIE_MICROCHIP_HOST
 	  Say Y here if you want kernel to support the Microchip AXI PCIe
 	  Host Bridge driver.
 
+config PCIE_STARFIVE_HOST
+	tristate "StarFive PCIe host controller"
+	select PCIE_PLDA_HOST
+	help
+	  Say Y here if you want to support the StarFive PCIe controller
+	  in host mode. StarFive PCIe controller uses PLDA PCIe
+	  core.
+
 endmenu
diff --git a/drivers/pci/controller/plda/Makefile b/drivers/pci/controller/plda/Makefile
index 2f16d9126535..a6089a873d18 100644
--- a/drivers/pci/controller/plda/Makefile
+++ b/drivers/pci/controller/plda/Makefile
@@ -2,3 +2,4 @@
 obj-$(CONFIG_PCIE_PLDA_HOST) += pcie-plda-host.o
 obj-$(CONFIG_PCIE_PLDA_PLAT_HOST) += pcie-plda-plat.o
 obj-$(CONFIG_PCIE_MICROCHIP_HOST) += pcie-microchip-host.o
+obj-$(CONFIG_PCIE_STARFIVE_HOST) += pcie-starfive.o
diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
index 8785f885ddb1..ef0d2aa7ccea 100644
--- a/drivers/pci/controller/plda/pcie-plda.h
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -15,13 +15,19 @@
 #define PLDA_NUM_MSI_IRQS		32
 #define NUM_MSI_IRQS_CODED		5
 
-/* PCIe Bridge Phy Regs */
+/* PCIe Bridge Regs */
+#define GEN_SETTINGS			0x80
+#define  RP_ENABLE			1
 #define PCIE_PCI_IDS_DW1		0x9c
-
+#define  IDS_CLASS_CODE_SHIFT		16
+#define PCI_MISC			0xB4
+#define  PHY_FUNCTION_DIS		BIT(15)
 /* PCIe Config space MSI capability structure */
 #define MSI_CAP_CTRL_OFFSET		0xe0
 #define  MSI_MAX_Q_AVAIL		(NUM_MSI_IRQS_CODED << 1)
 #define  MSI_Q_SIZE			(NUM_MSI_IRQS_CODED << 4)
+#define PCIE_WINROM			0xfc
+#define  PREF_MEM_WIN_64_SUPPORT		BIT(3)
 
 #define IMASK_LOCAL				0x180
 #define  DMA_END_ENGINE_0_MASK			0x00000000u
@@ -75,6 +81,8 @@
 #define ISTATUS_HOST				0x18c
 #define IMSI_ADDR				0x190
 #define ISTATUS_MSI				0x194
+#define PMSG_SUPPORT_RX				0x3F0
+#define  PMSG_LTR_SUPPORT			BIT(2)
 
 /* PCIe Master table init defines */
 #define ATR0_PCIE_WIN0_SRCADDR_PARAM		0x600u
@@ -173,4 +181,50 @@ static inline void plda_set_default_msi(struct plda_msi *msi)
 	msi->vector_phy = IMSI_ADDR;
 	msi->num_vectors = PLDA_NUM_MSI_IRQS;
 }
+
+static inline void plda_pcie_enable_root_port(struct plda_pcie *plda)
+{
+	u32 value;
+
+	value = readl_relaxed(plda->bridge_addr + GEN_SETTINGS);
+	value |= RP_ENABLE;
+	writel_relaxed(value, plda->bridge_addr + GEN_SETTINGS);
+}
+
+static inline void plda_pcie_set_standard_class(struct plda_pcie *plda)
+{
+	u32 value;
+
+	value = readl_relaxed(plda->bridge_addr + PCIE_PCI_IDS_DW1);
+	value &= 0xff;
+	value |= (PCI_CLASS_BRIDGE_PCI << IDS_CLASS_CODE_SHIFT);
+	writel_relaxed(value, plda->bridge_addr + PCIE_PCI_IDS_DW1);
+}
+
+static inline void plda_pcie_set_pref_win_64bit(struct plda_pcie *plda)
+{
+	u32 value;
+
+	value = readl_relaxed(plda->bridge_addr + PCIE_WINROM);
+	value |= PREF_MEM_WIN_64_SUPPORT;
+	writel_relaxed(value, plda->bridge_addr + PCIE_WINROM);
+}
+
+static inline void plda_pcie_disable_ltr(struct plda_pcie *plda)
+{
+	u32 value;
+
+	value = readl_relaxed(plda->bridge_addr + PMSG_SUPPORT_RX);
+	value &= ~PMSG_LTR_SUPPORT;
+	writel_relaxed(value, plda->bridge_addr + PMSG_SUPPORT_RX);
+}
+
+static inline void plda_pcie_disable_func(struct plda_pcie *plda)
+{
+	u32 value;
+
+	value = readl_relaxed(plda->bridge_addr + PCI_MISC);
+	value |= PHY_FUNCTION_DIS;
+	writel_relaxed(value, plda->bridge_addr + PCI_MISC);
+}
 #endif /* _PCIE_PLDA_H */
diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
new file mode 100644
index 000000000000..816aa77a311d
--- /dev/null
+++ b/drivers/pci/controller/plda/pcie-starfive.c
@@ -0,0 +1,415 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * PCIe host controller driver for StarFive JH7110 Soc.
+ *
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_pci.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include "../../pci.h"
+
+#include "pcie-plda.h"
+
+#define DATA_LINK_ACTIVE		BIT(5)
+#define PREF_MEM_WIN_64_SUPPORT		BIT(3)
+#define PMSG_LTR_SUPPORT		BIT(2)
+#define LINK_SPEED_GEN2			BIT(12)
+#define PHY_FUNCTION_DIS		BIT(15)
+#define PCIE_FUNC_NUM			4
+#define PHY_FUNC_SHIFT			9
+
+/* system control */
+#define STG_SYSCON_K_RP_NEP			BIT(8)
+#define STG_SYSCON_AXI4_SLVL_ARFUNC_MASK	GENMASK(22, 8)
+#define STG_SYSCON_AXI4_SLVL_ARFUNC_SHIFT	8
+#define STG_SYSCON_AXI4_SLVL_AWFUNC_MASK	GENMASK(14, 0)
+#define STG_SYSCON_CLKREQ			BIT(22)
+#define STG_SYSCON_CKREF_SRC_SHIFT		18
+#define STG_SYSCON_CKREF_SRC_MASK		GENMASK(19, 18)
+
+struct starfive_jh7110_pcie {
+	struct plda_pcie	plda;
+	struct reset_control *resets;
+	struct clk_bulk_data *clks;
+	struct regmap *reg_syscon;
+	struct gpio_desc *power_gpio;
+	struct gpio_desc *reset_gpio;
+
+	u32 stg_arfun;
+	u32 stg_awfun;
+	u32 stg_rp_nep;
+	u32 stg_lnksta;
+
+	int num_clks;
+};
+
+/*
+ * The BAR0/1 of bridge should be hidden during enumeration to
+ * avoid the sizing and resource allocation by PCIe core.
+ */
+static bool starfive_pcie_hide_rc_bar(struct pci_bus *bus, unsigned int  devfn,
+				      int offset)
+{
+	if (pci_is_root_bus(bus) && !devfn &&
+	    (offset == PCI_BASE_ADDRESS_0 || offset == PCI_BASE_ADDRESS_1))
+		return true;
+
+	return false;
+}
+
+int starfive_pcie_config_write(struct pci_bus *bus, unsigned int devfn,
+			       int where, int size, u32 value)
+{
+	if (starfive_pcie_hide_rc_bar(bus, devfn, where))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	return pci_generic_config_write(bus, devfn, where, size, value);
+}
+
+static int starfive_pcie_parse_dt(struct starfive_jh7110_pcie *pcie, struct device *dev)
+{
+	unsigned int args[4];
+
+	pcie->num_clks = devm_clk_bulk_get_all(dev, &pcie->clks);
+	if (pcie->num_clks < 0)
+		return dev_err_probe(dev, -ENODEV,
+			"Failed to get pcie clocks\n");
+
+	pcie->resets = devm_reset_control_array_get_exclusive(dev);
+	if (IS_ERR(pcie->resets))
+		return dev_err_probe(dev, PTR_ERR(pcie->resets),
+			"Failed to get pcie resets");
+
+	pcie->reg_syscon =
+		syscon_regmap_lookup_by_phandle_args(dev->of_node,
+						     "starfive,stg-syscon", 4, args);
+
+	if (IS_ERR(pcie->reg_syscon))
+		return dev_err_probe(dev, PTR_ERR(pcie->reg_syscon),
+			"Failed to parse starfive,stg-syscon\n");
+
+	pcie->stg_arfun = args[0];
+	pcie->stg_awfun = args[1];
+	pcie->stg_rp_nep = args[2];
+	pcie->stg_lnksta = args[3];
+
+	pcie->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR_OR_NULL(pcie->reset_gpio)) {
+		dev_warn(dev, "Failed to get reset-gpio.\n");
+		return -EINVAL;
+	}
+
+	pcie->power_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_LOW);
+	if (IS_ERR(pcie->power_gpio)) {
+		dev_warn(dev, "Failed to get power-gpio.\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static struct pci_ops starfive_pcie_ops = {
+	.map_bus	= plda_pcie_map_bus,
+	.read           = pci_generic_config_read,
+	.write          = starfive_pcie_config_write,
+};
+
+static int starfive_pcie_clk_rst_init(struct starfive_jh7110_pcie *pcie)
+{
+	int ret;
+	struct device *dev = pcie->plda.dev;
+
+	ret = clk_bulk_prepare_enable(pcie->num_clks, pcie->clks);
+	if (ret) {
+		dev_err(dev, "Failed to enable clocks\n");
+		return ret;
+	}
+
+	ret = reset_control_deassert(pcie->resets);
+	if (ret) {
+		clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
+		dev_err(dev, "Failed to resets\n");
+	}
+
+	return ret;
+}
+
+static void starfive_pcie_clk_rst_deinit(struct starfive_jh7110_pcie *pcie)
+{
+	reset_control_assert(pcie->resets);
+	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
+}
+
+static int starfive_pcie_is_link_up(struct starfive_jh7110_pcie *pcie)
+{
+	struct device *dev = pcie->plda.dev;
+	int ret;
+	u32 stg_reg_val;
+
+	/* 100ms timeout value should be enough for Gen1/2 training */
+	ret = regmap_read_poll_timeout(pcie->reg_syscon,
+				       pcie->stg_lnksta,
+				       stg_reg_val,
+				       stg_reg_val & DATA_LINK_ACTIVE,
+				       10 * 1000, 100 * 1000);
+
+	/* If the link is down (no device in slot), then exit. */
+	if (ret == -ETIMEDOUT) {
+		dev_info(dev, "Port link down, exit.\n");
+		return 0;
+	} else if (ret == 0) {
+		dev_info(dev, "Port link up.\n");
+		return 1;
+	}
+
+	return 0;
+}
+
+int starfive_pcie_enable_phy(struct device *dev, struct plda_pcie *pcie)
+{
+	int ret;
+
+	if (!pcie->phy)
+		return 0;
+
+	ret = phy_init(pcie->phy);
+	if (ret)
+		return dev_err_probe(dev, ret,
+			"failed to initialize pcie phy\n");
+
+	ret = phy_set_mode(pcie->phy, PHY_MODE_PCIE);
+	if (ret) {
+		dev_err(dev, "failed to set pcie mode\n");
+		goto err_phy_on;
+	}
+
+	ret = phy_power_on(pcie->phy);
+	if (ret) {
+		dev_err(dev, "failed to power on pcie phy\n");
+		goto err_phy_on;
+	}
+
+	return 0;
+
+err_phy_on:
+	phy_exit(pcie->phy);
+	return ret;
+}
+
+void starfive_pcie_disable_phy(struct plda_pcie *pcie)
+{
+	phy_power_off(pcie->phy);
+	phy_exit(pcie->phy);
+}
+
+static void starfive_pcie_host_deinit(struct plda_pcie *plda)
+{
+	struct starfive_jh7110_pcie *pcie =
+		container_of(plda, struct starfive_jh7110_pcie, plda);
+
+	starfive_pcie_clk_rst_deinit(pcie);
+	if (pcie->power_gpio)
+		gpiod_set_value_cansleep(pcie->power_gpio, 0);
+	starfive_pcie_disable_phy(plda);
+}
+
+static int starfive_pcie_host_init(struct plda_pcie *plda)
+{
+	int i;
+	struct starfive_jh7110_pcie *pcie =
+		container_of(plda, struct starfive_jh7110_pcie, plda);
+	struct device *dev = plda->dev;
+	int ret;
+
+	ret = starfive_pcie_enable_phy(dev, plda);
+	if (ret)
+		return ret;
+
+	regmap_update_bits(pcie->reg_syscon, pcie->stg_rp_nep,
+			   STG_SYSCON_K_RP_NEP, STG_SYSCON_K_RP_NEP);
+
+	regmap_update_bits(pcie->reg_syscon, pcie->stg_awfun,
+			   STG_SYSCON_CKREF_SRC_MASK,
+			   2 << STG_SYSCON_CKREF_SRC_SHIFT);
+
+	regmap_update_bits(pcie->reg_syscon, pcie->stg_awfun,
+			   STG_SYSCON_CLKREQ, STG_SYSCON_CLKREQ);
+
+	ret = starfive_pcie_clk_rst_init(pcie);
+	if (ret)
+		return ret;
+
+	if (pcie->power_gpio)
+		gpiod_set_value_cansleep(pcie->power_gpio, 1);
+
+	gpiod_set_value_cansleep(pcie->reset_gpio, 1);
+
+	/* Disable physical functions except #0 */
+	for (i = 1; i < PCIE_FUNC_NUM; i++) {
+		regmap_update_bits(pcie->reg_syscon,
+				   pcie->stg_arfun,
+				   STG_SYSCON_AXI4_SLVL_ARFUNC_MASK,
+				   (i << PHY_FUNC_SHIFT) <<
+				   STG_SYSCON_AXI4_SLVL_ARFUNC_SHIFT);
+		regmap_update_bits(pcie->reg_syscon,
+				   pcie->stg_awfun,
+				   STG_SYSCON_AXI4_SLVL_AWFUNC_MASK,
+				   i << PHY_FUNC_SHIFT);
+
+		plda_pcie_disable_func(plda);
+	}
+
+	regmap_update_bits(pcie->reg_syscon, pcie->stg_arfun,
+			   STG_SYSCON_AXI4_SLVL_ARFUNC_MASK, 0);
+	regmap_update_bits(pcie->reg_syscon, pcie->stg_awfun,
+			   STG_SYSCON_AXI4_SLVL_AWFUNC_MASK, 0);
+
+	/* Enable root port */
+	plda_pcie_enable_root_port(plda);
+
+	/* PCIe PCI Standard Configuration Identification Settings. */
+	plda_pcie_set_standard_class(plda);
+
+	/*
+	 * The LTR message forwarding of PCIe Message Reception was set by core
+	 * as default, but the forward id & addr are also need to be reset.
+	 * If we do not disable LTR message forwarding here, or set a legal
+	 * forwarding address, the kernel will get stuck after this driver probe.
+	 * To workaround, disable the LTR message forwarding support on
+	 * PCIe Message Reception.
+	 */
+	plda_pcie_disable_ltr(plda);
+
+	/* Prefetchable memory window 64-bit addressing support */
+	plda_pcie_set_pref_win_64bit(plda);
+
+	/* Ensure that PERST has been asserted for at least 100 ms */
+	msleep(300);
+	gpiod_set_value_cansleep(pcie->reset_gpio, 0);
+
+	if (!starfive_pcie_is_link_up(pcie))
+		return -EIO;
+
+	return ret;
+}
+
+static const struct plda_pcie_ops pcie_ops = {
+	.host_init = starfive_pcie_host_init,
+	.host_deinit = starfive_pcie_host_deinit,
+};
+
+static int starfive_pcie_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct starfive_jh7110_pcie *pcie;
+	struct plda_pcie *plda;
+	int ret;
+
+	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+
+	plda = &pcie->plda;
+	plda->dev = dev;
+
+	ret = starfive_pcie_parse_dt(pcie, dev);
+	if (ret)
+		return ret;
+
+	plda->ops = &pcie_ops;
+	plda->num_events = NUM_PLDA_EVENTS;
+	ret = plda_pcie_host_init(&pcie->plda, &starfive_pcie_ops);
+	if (ret)
+		return ret;
+
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
+	platform_set_drvdata(pdev, pcie);
+
+	return 0;
+}
+
+static void starfive_pcie_remove(struct platform_device *pdev)
+{
+	struct starfive_jh7110_pcie *pcie = platform_get_drvdata(pdev);
+
+	plda_pcie_host_deinit(&pcie->plda);
+	platform_set_drvdata(pdev, NULL);
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int __maybe_unused starfive_pcie_suspend_noirq(struct device *dev)
+{
+	struct starfive_jh7110_pcie *pcie = dev_get_drvdata(dev);
+
+	if (!pcie)
+		return 0;
+
+	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
+	starfive_pcie_disable_phy(&pcie->plda);
+
+	return 0;
+}
+
+static int __maybe_unused starfive_pcie_resume_noirq(struct device *dev)
+{
+	struct starfive_jh7110_pcie *pcie = dev_get_drvdata(dev);
+	int ret;
+
+	if (!pcie)
+		return 0;
+
+	ret = starfive_pcie_enable_phy(dev, &pcie->plda);
+	if (ret)
+		return ret;
+
+	ret = clk_bulk_prepare_enable(pcie->num_clks, pcie->clks);
+	if (ret) {
+		dev_err(dev, "Failed to enable clocks\n");
+		starfive_pcie_disable_phy(&pcie->plda);
+		return ret;
+	}
+
+	return ret;
+}
+
+static const struct dev_pm_ops starfive_pcie_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(starfive_pcie_suspend_noirq,
+				      starfive_pcie_resume_noirq)
+};
+#endif
+
+static const struct of_device_id starfive_pcie_of_match[] = {
+	{ .compatible = "starfive,jh7110-pcie"},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, starfive_pcie_of_match);
+
+static struct platform_driver starfive_pcie_driver = {
+	.driver = {
+		.name = "pcie-starfive",
+		.of_match_table = of_match_ptr(starfive_pcie_of_match),
+#ifdef CONFIG_PM_SLEEP
+		.pm = &starfive_pcie_pm_ops,
+#endif
+	},
+	.probe = starfive_pcie_probe,
+	.remove_new = starfive_pcie_remove,
+};
+module_platform_driver(starfive_pcie_driver);
+
+MODULE_DESCRIPTION("StarFive JH7110 PCIe host driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

