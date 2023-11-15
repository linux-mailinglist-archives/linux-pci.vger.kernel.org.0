Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A547EC1A7
	for <lists+linux-pci@lfdr.de>; Wed, 15 Nov 2023 12:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343706AbjKOLuS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Nov 2023 06:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343705AbjKOLt6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Nov 2023 06:49:58 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1882D18C;
        Wed, 15 Nov 2023 03:49:33 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id D59B324E2E1;
        Wed, 15 Nov 2023 19:49:31 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 15 Nov
 2023 19:49:31 +0800
Received: from ubuntu.localdomain (183.27.97.246) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 15 Nov
 2023 19:49:30 +0800
From:   Minda Chen <minda.chen@starfivetech.com>
To:     Conor Dooley <conor@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Daire McNamara" <daire.mcnamara@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
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
Subject: [PATCH v11 19/20] PCI: starfive: Add JH7110 PCIe controller
Date:   Wed, 15 Nov 2023 19:49:11 +0800
Message-ID: <20231115114912.71448-20-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231115114912.71448-1-minda.chen@starfivetech.com>
References: <20231115114912.71448-1-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.97.246]
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

Add StarFive JH7110 SoC PCIe controller platform driver codes, JH7110
with PLDA host PCIe core.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Co-developed-by: Kevin Xie <kevin.xie@starfivetech.com>
Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
---
 MAINTAINERS                                 |   7 +
 drivers/pci/controller/plda/Kconfig         |  11 +
 drivers/pci/controller/plda/Makefile        |   1 +
 drivers/pci/controller/plda/pcie-plda.h     |  71 ++-
 drivers/pci/controller/plda/pcie-starfive.c | 460 ++++++++++++++++++++
 drivers/pci/pci.h                           |   7 +
 6 files changed, 556 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/controller/plda/pcie-starfive.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4c08d9354dff..fd4f4f06c069 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16876,6 +16876,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/pci/socionext,uniphier-pcie*
 F:	drivers/pci/controller/dwc/pcie-uniphier*
 
+PCIE DRIVER FOR STARFIVE JH71x0
+M:	Kevin Xie <kevin.xie@starfivetech.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/starfive*
+F:	drivers/pci/controller/plda/pcie-starfive.c
+
 PCIE DRIVER FOR ST SPEAR13XX
 M:	Pratyush Anand <pratyush.anand@gmail.com>
 L:	linux-pci@vger.kernel.org
diff --git a/drivers/pci/controller/plda/Kconfig b/drivers/pci/controller/plda/Kconfig
index e54a82ee94f5..f0791bc6d9f5 100644
--- a/drivers/pci/controller/plda/Kconfig
+++ b/drivers/pci/controller/plda/Kconfig
@@ -15,4 +15,15 @@ config PCIE_MICROCHIP_HOST
 	  Say Y here if you want kernel to support the Microchip AXI PCIe
 	  Host Bridge driver.
 
+config PCIE_STARFIVE_HOST
+	tristate "StarFive PCIe host controller"
+	depends on OF && PCI_MSI
+	select PCIE_PLDA_HOST
+	help
+	  Say Y here if you want to support the StarFive PCIe controller in
+	  host mode. StarFive PCIe controller uses PLDA PCIe core.
+
+	  If you choose to build this driver as module it will be dynamically
+	  linked and module will be called pcie-starfive.ko.
+
 endmenu
diff --git a/drivers/pci/controller/plda/Makefile b/drivers/pci/controller/plda/Makefile
index 4340ab007f44..0ac6851bed48 100644
--- a/drivers/pci/controller/plda/Makefile
+++ b/drivers/pci/controller/plda/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_PCIE_PLDA_HOST) += pcie-plda-host.o
 obj-$(CONFIG_PCIE_MICROCHIP_HOST) += pcie-microchip-host.o
+obj-$(CONFIG_PCIE_STARFIVE_HOST) += pcie-starfive.o
diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
index 6b29bf1f5293..80dbd34d2d51 100644
--- a/drivers/pci/controller/plda/pcie-plda.h
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -10,10 +10,20 @@
 #define PLDA_MAX_NUM_MSI_IRQS			32
 
 /* PCIe Bridge Phy Regs */
+#define GEN_SETTINGS				0x80
+#define  RP_ENABLE				1
+#define PCIE_PCI_IDS_DW1			0x9c
+#define  IDS_CLASS_CODE_SHIFT			16
+#define  REVISION_ID_MASK			GENMASK(7, 0)
+#define  CLASS_CODE_ID_MASK			GENMASK(31, 8)
 #define PCIE_PCI_IRQ_DW0			0xa8
 #define  MSIX_CAP_MASK				BIT(31)
 #define  NUM_MSI_MSGS_MASK			GENMASK(6, 4)
 #define  NUM_MSI_MSGS_SHIFT			4
+#define PCI_MISC				0xb4
+#define  PHY_FUNCTION_DIS			BIT(15)
+#define PCIE_WINROM				0xfc
+#define  PREF_MEM_WIN_64_SUPPORT		BIT(3)
 
 #define IMASK_LOCAL				0x180
 #define  DMA_END_ENGINE_0_MASK			0x00000000u
@@ -66,6 +76,8 @@
 #define ISTATUS_HOST				0x18c
 #define IMSI_ADDR				0x190
 #define ISTATUS_MSI				0x194
+#define PMSG_SUPPORT_RX				0x3f0
+#define  PMSG_LTR_SUPPORT			BIT(2)
 
 /* PCIe Master table init defines */
 #define ATR0_PCIE_WIN0_SRCADDR_PARAM		0x600u
@@ -87,6 +99,8 @@
 #define  PCIE_TX_RX_INTERFACE			0x00000000u
 #define  PCIE_CONFIG_INTERFACE			0x00000001u
 
+#define CONFIG_SPACE_ADDR_OFFSET		0x1000u
+
 #define ATR_ENTRY_SIZE				32
 
 #define EVENT_A_ATR_EVT_POST_ERR		0
@@ -194,4 +208,59 @@ static inline void plda_set_default_msi(struct plda_msi *msi)
 	msi->vector_phy = IMSI_ADDR;
 	msi->num_vectors = PLDA_MAX_NUM_MSI_IRQS;
 }
-#endif
+
+static inline void plda_pcie_enable_root_port(struct plda_pcie_rp *plda)
+{
+	u32 value;
+
+	value = readl_relaxed(plda->bridge_addr + GEN_SETTINGS);
+	value |= RP_ENABLE;
+	writel_relaxed(value, plda->bridge_addr + GEN_SETTINGS);
+}
+
+static inline void plda_pcie_set_standard_class(struct plda_pcie_rp *plda)
+{
+	u32 value;
+
+	/* set class code and reserve revision id */
+	value = readl_relaxed(plda->bridge_addr + PCIE_PCI_IDS_DW1);
+	value &= REVISION_ID_MASK;
+	value |= (PCI_CLASS_BRIDGE_PCI << IDS_CLASS_CODE_SHIFT);
+	writel_relaxed(value, plda->bridge_addr + PCIE_PCI_IDS_DW1);
+}
+
+static inline void plda_pcie_set_pref_win_64bit(struct plda_pcie_rp *plda)
+{
+	u32 value;
+
+	value = readl_relaxed(plda->bridge_addr + PCIE_WINROM);
+	value |= PREF_MEM_WIN_64_SUPPORT;
+	writel_relaxed(value, plda->bridge_addr + PCIE_WINROM);
+}
+
+static inline void plda_pcie_disable_ltr(struct plda_pcie_rp *plda)
+{
+	u32 value;
+
+	value = readl_relaxed(plda->bridge_addr + PMSG_SUPPORT_RX);
+	value &= ~PMSG_LTR_SUPPORT;
+	writel_relaxed(value, plda->bridge_addr + PMSG_SUPPORT_RX);
+}
+
+static inline void plda_pcie_disable_func(struct plda_pcie_rp *plda)
+{
+	u32 value;
+
+	value = readl_relaxed(plda->bridge_addr + PCI_MISC);
+	value |= PHY_FUNCTION_DIS;
+	writel_relaxed(value, plda->bridge_addr + PCI_MISC);
+}
+
+static inline void plda_pcie_write_rc_bar(struct plda_pcie_rp *plda, u64 val)
+{
+	void __iomem *addr = plda->bridge_addr + CONFIG_SPACE_ADDR_OFFSET;
+
+	writel_relaxed(lower_32_bits(val), addr + PCI_BASE_ADDRESS_0);
+	writel_relaxed(upper_32_bits(val), addr + PCI_BASE_ADDRESS_1);
+}
+#endif /* _PCIE_PLDA_H */
diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
new file mode 100644
index 000000000000..c0673faac312
--- /dev/null
+++ b/drivers/pci/controller/plda/pcie-starfive.c
@@ -0,0 +1,460 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * PCIe host controller driver for StarFive JH7110 Soc.
+ *
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_pci.h>
+#include <linux/pci.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include "../../pci.h"
+
+#include "pcie-plda.h"
+
+#define PCIE_FUNC_NUM			4
+
+/* system control */
+#define STG_SYSCON_PCIE0_BASE			0x48
+#define STG_SYSCON_PCIE1_BASE			0x1f8
+
+#define STG_SYSCON_AR_OFFSET			0x78
+#define STG_SYSCON_AXI4_SLVL_AR_MASK		GENMASK(22, 8)
+#define STG_SYSCON_AXI4_SLVL_PHY_AR(x)		FIELD_PREP(GENMASK(20, 17), x)
+#define STG_SYSCON_AW_OFFSET			0x7c
+#define STG_SYSCON_AXI4_SLVL_AW_MASK		GENMASK(14, 0)
+#define STG_SYSCON_AXI4_SLVL_PHY_AW(x)		FIELD_PREP(GENMASK(12, 9), x)
+#define STG_SYSCON_CLKREQ			BIT(22)
+#define STG_SYSCON_CKREF_SRC_MASK		GENMASK(19, 18)
+#define STG_SYSCON_RP_NEP_OFFSET		0xe8
+#define STG_SYSCON_K_RP_NEP			BIT(8)
+#define STG_SYSCON_LNKSTA_OFFSET		0x170
+#define DATA_LINK_ACTIVE			BIT(5)
+
+/* Parameters for the waiting for link up routine */
+#define LINK_WAIT_MAX_RETRIES	10
+#define LINK_WAIT_USLEEP_MIN	90000
+#define LINK_WAIT_USLEEP_MAX	100000
+
+struct starfive_jh7110_pcie {
+	struct plda_pcie_rp plda;
+	struct reset_control *resets;
+	struct clk_bulk_data *clks;
+	struct regmap *reg_syscon;
+	struct gpio_desc *power_gpio;
+	struct gpio_desc *reset_gpio;
+	struct phy *phy;
+
+	unsigned int stg_pcie_base;
+	int num_clks;
+};
+
+/*
+ * The BAR0/1 of bridge should be hidden during enumeration to
+ * avoid the sizing and resource allocation by PCIe core.
+ */
+static bool starfive_pcie_hide_rc_bar(struct pci_bus *bus, unsigned int devfn,
+				      int offset)
+{
+	if (pci_is_root_bus(bus) && !devfn &&
+	    (offset == PCI_BASE_ADDRESS_0 || offset == PCI_BASE_ADDRESS_1))
+		return true;
+
+	return false;
+}
+
+static int starfive_pcie_config_write(struct pci_bus *bus, unsigned int devfn,
+				      int where, int size, u32 value)
+{
+	if (starfive_pcie_hide_rc_bar(bus, devfn, where))
+		return PCIBIOS_SUCCESSFUL;
+
+	return pci_generic_config_write(bus, devfn, where, size, value);
+}
+
+static int starfive_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
+				     int where, int size, u32 *value)
+{
+	if (starfive_pcie_hide_rc_bar(bus, devfn, where)) {
+		*value = 0;
+		return PCIBIOS_SUCCESSFUL;
+	}
+
+	return pci_generic_config_read(bus, devfn, where, size, value);
+}
+
+static int starfive_pcie_parse_dt(struct starfive_jh7110_pcie *pcie,
+				  struct device *dev)
+{
+	int domain_nr;
+
+	pcie->num_clks = devm_clk_bulk_get_all(dev, &pcie->clks);
+	if (pcie->num_clks < 0)
+		return dev_err_probe(dev, -ENODEV,
+				     "failed to get pcie clocks\n");
+
+	pcie->resets = devm_reset_control_array_get_exclusive(dev);
+	if (IS_ERR(pcie->resets))
+		return dev_err_probe(dev, PTR_ERR(pcie->resets),
+				     "failed to get pcie resets");
+
+	pcie->reg_syscon =
+		syscon_regmap_lookup_by_phandle(dev->of_node,
+						"starfive,stg-syscon");
+
+	if (IS_ERR(pcie->reg_syscon))
+		return dev_err_probe(dev, PTR_ERR(pcie->reg_syscon),
+				     "failed to parse starfive,stg-syscon\n");
+
+	pcie->phy = devm_phy_optional_get(dev, NULL);
+	if (IS_ERR(pcie->phy))
+		return dev_err_probe(dev, PTR_ERR(pcie->phy),
+				     "failed to get pcie phy\n");
+
+	domain_nr = of_get_pci_domain_nr(dev->of_node);
+
+	if (domain_nr < 0 || domain_nr > 1)
+		return dev_err_probe(dev, -ENODEV,
+				     "failed to get valid pcie domain\n");
+
+	if (domain_nr == 0)
+		pcie->stg_pcie_base = STG_SYSCON_PCIE0_BASE;
+	else
+		pcie->stg_pcie_base = STG_SYSCON_PCIE1_BASE;
+
+	pcie->reset_gpio = devm_gpiod_get_optional(dev, "perst",
+						   GPIOD_OUT_HIGH);
+	if (IS_ERR(pcie->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(pcie->reset_gpio),
+				     "failed to get perst-gpio\n");
+
+	pcie->power_gpio = devm_gpiod_get_optional(dev, "enable",
+						   GPIOD_OUT_LOW);
+	if (IS_ERR(pcie->power_gpio))
+		return dev_err_probe(dev, PTR_ERR(pcie->power_gpio),
+				     "failed to get power-gpio\n");
+
+	return 0;
+}
+
+static struct pci_ops starfive_pcie_ops = {
+	.map_bus	= plda_pcie_map_bus,
+	.read           = starfive_pcie_config_read,
+	.write          = starfive_pcie_config_write,
+};
+
+static int starfive_pcie_clk_rst_init(struct starfive_jh7110_pcie *pcie)
+{
+	struct device *dev = pcie->plda.dev;
+	int ret;
+
+	ret = clk_bulk_prepare_enable(pcie->num_clks, pcie->clks);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable clocks\n");
+
+	ret = reset_control_deassert(pcie->resets);
+	if (ret) {
+		clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
+		dev_err_probe(dev, ret, "failed to deassert resets\n");
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
+static bool starfive_pcie_link_up(struct plda_pcie_rp *plda)
+{
+	struct starfive_jh7110_pcie *pcie =
+		container_of(plda, struct starfive_jh7110_pcie, plda);
+	int ret;
+	u32 stg_reg_val;
+
+	ret = regmap_read(pcie->reg_syscon,
+			  pcie->stg_pcie_base + STG_SYSCON_LNKSTA_OFFSET,
+			  &stg_reg_val);
+	if (ret) {
+		dev_err(pcie->plda.dev, "failed to read link status\n");
+		return false;
+	}
+
+	return !!(stg_reg_val & DATA_LINK_ACTIVE);
+}
+
+static int starfive_pcie_host_wait_for_link(struct starfive_jh7110_pcie *pcie)
+{
+	int retries;
+
+	/* Check if the link is up or not */
+	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
+		if (starfive_pcie_link_up(&pcie->plda)) {
+			dev_info(pcie->plda.dev, "port link up\n");
+			return 0;
+		}
+		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
+	}
+
+	return -ETIMEDOUT;
+}
+
+static int starfive_pcie_enable_phy(struct device *dev,
+				    struct starfive_jh7110_pcie *pcie)
+{
+	int ret;
+
+	if (!pcie->phy)
+		return 0;
+
+	ret = phy_init(pcie->phy);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to initialize pcie phy\n");
+
+	ret = phy_set_mode(pcie->phy, PHY_MODE_PCIE);
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to set pcie mode\n");
+		goto err_phy_on;
+	}
+
+	ret = phy_power_on(pcie->phy);
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to power on pcie phy\n");
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
+static void starfive_pcie_disable_phy(struct starfive_jh7110_pcie *pcie)
+{
+	phy_power_off(pcie->phy);
+	phy_exit(pcie->phy);
+}
+
+static void starfive_pcie_host_deinit(struct plda_pcie_rp *plda)
+{
+	struct starfive_jh7110_pcie *pcie =
+		container_of(plda, struct starfive_jh7110_pcie, plda);
+
+	starfive_pcie_clk_rst_deinit(pcie);
+	if (pcie->power_gpio)
+		gpiod_set_value_cansleep(pcie->power_gpio, 0);
+	starfive_pcie_disable_phy(pcie);
+}
+
+static int starfive_pcie_host_init(struct plda_pcie_rp *plda)
+{
+	struct starfive_jh7110_pcie *pcie =
+		container_of(plda, struct starfive_jh7110_pcie, plda);
+	struct device *dev = plda->dev;
+	int ret;
+	int i;
+
+	ret = starfive_pcie_enable_phy(dev, pcie);
+	if (ret)
+		return ret;
+
+	regmap_update_bits(pcie->reg_syscon,
+			   pcie->stg_pcie_base + STG_SYSCON_RP_NEP_OFFSET,
+			   STG_SYSCON_K_RP_NEP, STG_SYSCON_K_RP_NEP);
+
+	regmap_update_bits(pcie->reg_syscon,
+			   pcie->stg_pcie_base + STG_SYSCON_AW_OFFSET,
+			   STG_SYSCON_CKREF_SRC_MASK,
+			   FIELD_PREP(STG_SYSCON_CKREF_SRC_MASK, 2));
+
+	regmap_update_bits(pcie->reg_syscon,
+			   pcie->stg_pcie_base + STG_SYSCON_AW_OFFSET,
+			   STG_SYSCON_CLKREQ, STG_SYSCON_CLKREQ);
+
+	ret = starfive_pcie_clk_rst_init(pcie);
+	if (ret)
+		return ret;
+
+	if (pcie->power_gpio)
+		gpiod_set_value_cansleep(pcie->power_gpio, 1);
+
+	if (pcie->reset_gpio)
+		gpiod_set_value_cansleep(pcie->reset_gpio, 1);
+
+	/* Disable physical functions except #0 */
+	for (i = 1; i < PCIE_FUNC_NUM; i++) {
+		regmap_update_bits(pcie->reg_syscon,
+				   pcie->stg_pcie_base + STG_SYSCON_AR_OFFSET,
+				   STG_SYSCON_AXI4_SLVL_AR_MASK,
+				   STG_SYSCON_AXI4_SLVL_PHY_AR(i));
+
+		regmap_update_bits(pcie->reg_syscon,
+				   pcie->stg_pcie_base + STG_SYSCON_AW_OFFSET,
+				   STG_SYSCON_AXI4_SLVL_AW_MASK,
+				   STG_SYSCON_AXI4_SLVL_PHY_AW(i));
+
+		plda_pcie_disable_func(plda);
+	}
+
+	regmap_update_bits(pcie->reg_syscon,
+			   pcie->stg_pcie_base + STG_SYSCON_AR_OFFSET,
+			   STG_SYSCON_AXI4_SLVL_AR_MASK, 0);
+	regmap_update_bits(pcie->reg_syscon,
+			   pcie->stg_pcie_base + STG_SYSCON_AW_OFFSET,
+			   STG_SYSCON_AXI4_SLVL_AW_MASK, 0);
+
+	plda_pcie_enable_root_port(plda);
+	plda_pcie_write_rc_bar(plda, 0);
+
+	/* PCIe PCI Standard Configuration Identification Settings. */
+	plda_pcie_set_standard_class(plda);
+
+	/*
+	 * The LTR message forwarding of PCIe Message Reception was set by core
+	 * as default, but the forward id & addr are also need to be reset.
+	 * If we do not disable LTR message forwarding here, or set a legal
+	 * forwarding address, the kernel will get stuck after the driver probe.
+	 * To workaround, disable the LTR message forwarding support on
+	 * PCIe Message Reception.
+	 */
+	plda_pcie_disable_ltr(plda);
+
+	/* Prefetchable memory window 64-bit addressing support */
+	plda_pcie_set_pref_win_64bit(plda);
+
+	/*
+	 * Ensure that PERST has been asserted for at least 100 ms,
+	 * the sleep value is T_PVPERL from PCIe CEM spec r2.0 (Table 2-4)
+	 */
+	msleep(100);
+	if (pcie->reset_gpio)
+		gpiod_set_value_cansleep(pcie->reset_gpio, 0);
+
+	/*
+	 * With a Downstream Port (<=5GT/s), software must wait a minimum
+	 * of 100ms following exit from a conventional reset before
+	 * sending a configuration request to the device.
+	 */
+	msleep(PCIE_BEFORE_CONFIG_REQUEST_WAIT_MS);
+
+	if (starfive_pcie_host_wait_for_link(pcie))
+		dev_info(dev, "port link down\n");
+
+	return 0;
+}
+
+static const struct plda_pcie_host_ops sf_host_ops = {
+	.host_init = starfive_pcie_host_init,
+	.host_deinit = starfive_pcie_host_deinit,
+};
+
+static int starfive_pcie_probe(struct platform_device *pdev)
+{
+	struct starfive_jh7110_pcie *pcie;
+	struct device *dev = &pdev->dev;
+	struct plda_pcie_rp *plda;
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
+	plda->host_ops = &sf_host_ops;
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
+static int starfive_pcie_suspend_noirq(struct device *dev)
+{
+	struct starfive_jh7110_pcie *pcie = dev_get_drvdata(dev);
+
+	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
+	starfive_pcie_disable_phy(pcie);
+
+	return 0;
+}
+
+static int starfive_pcie_resume_noirq(struct device *dev)
+{
+	struct starfive_jh7110_pcie *pcie = dev_get_drvdata(dev);
+	int ret;
+
+	ret = starfive_pcie_enable_phy(dev, pcie);
+	if (ret)
+		return ret;
+
+	ret = clk_bulk_prepare_enable(pcie->num_clks, pcie->clks);
+	if (ret) {
+		dev_err(dev, "failed to enable clocks\n");
+		starfive_pcie_disable_phy(pcie);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops starfive_pcie_pm_ops = {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(starfive_pcie_suspend_noirq,
+				  starfive_pcie_resume_noirq)
+};
+
+static const struct of_device_id starfive_pcie_of_match[] = {
+	{ .compatible = "starfive,jh7110-pcie", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, starfive_pcie_of_match);
+
+static struct platform_driver starfive_pcie_driver = {
+	.driver = {
+		.name = "pcie-starfive",
+		.of_match_table = of_match_ptr(starfive_pcie_of_match),
+		.pm = pm_sleep_ptr(&starfive_pcie_pm_ops),
+	},
+	.probe = starfive_pcie_probe,
+	.remove_new = starfive_pcie_remove,
+};
+module_platform_driver(starfive_pcie_driver);
+
+MODULE_DESCRIPTION("StarFive JH7110 PCIe host driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 5ecbcf041179..7b35c06d05b5 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -22,6 +22,13 @@
  */
 #define PCIE_PME_TO_L2_TIMEOUT_US	10000
 
+/*
+ * PCIe r6.0, sec 6.6.1, <Conventional Reset>
+ * Requires a minimum waiting of 100ms before sending a configuration
+ * request to the device.
+ */
+#define PCIE_BEFORE_CONFIG_REQUEST_WAIT_MS	100
+
 extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
 
-- 
2.17.1

