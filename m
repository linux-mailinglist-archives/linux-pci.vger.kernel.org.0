Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29DD995B32
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2019 11:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbfHTJko (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Aug 2019 05:40:44 -0400
Received: from mga14.intel.com ([192.55.52.115]:33278 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729461AbfHTJkl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Aug 2019 05:40:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 02:40:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,408,1559545200"; 
   d="scan'208";a="353524493"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga005.jf.intel.com with ESMTP; 20 Aug 2019 02:40:37 -0700
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        linux-pci@vger.kernel.org, hch@infradead.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH v2 3/3] dwc: PCI: intel: Intel PCIe RC controller driver
Date:   Tue, 20 Aug 2019 17:39:37 +0800
Message-Id: <9bd455a628d4699684c0f9d439b64af1535cccc6.1566208109.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1566208109.git.eswara.kota@linux.intel.com>
References: <cover.1566208109.git.eswara.kota@linux.intel.com>
In-Reply-To: <cover.1566208109.git.eswara.kota@linux.intel.com>
References: <cover.1566208109.git.eswara.kota@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to PCIe RC controller on Intel Universal
Gateway SoC. PCIe controller is based of Synopsys
Designware pci core.

Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
---
 drivers/pci/controller/dwc/Kconfig          |  13 +
 drivers/pci/controller/dwc/Makefile         |   1 +
 drivers/pci/controller/dwc/pcie-intel-axi.c | 900 ++++++++++++++++++++++++++++
 3 files changed, 914 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-intel-axi.c

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 6ea778ae4877..e44b9b6a6390 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -82,6 +82,19 @@ config PCIE_DW_PLAT_EP
 	  order to enable device-specific features PCI_DW_PLAT_EP must be
 	  selected.
 
+config PCIE_INTEL_AXI
+        bool "Intel AHB/AXI PCIe host controller support"
+        depends on PCI_MSI
+        depends on PCI
+        depends on OF
+        select PCIE_DW_HOST
+        help
+          Say 'Y' here to enable support for Intel AHB/AXI PCIe Host
+	  controller driver.
+	  The Intel PCIe controller is based on the Synopsys Designware
+	  pcie core and therefore uses the Designware core functions to
+	  implement the driver.
+
 config PCI_EXYNOS
 	bool "Samsung Exynos PCIe controller"
 	depends on SOC_EXYNOS5440 || COMPILE_TEST
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index b085dfd4fab7..46e656ebdf90 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_PCIE_DW) += pcie-designware.o
 obj-$(CONFIG_PCIE_DW_HOST) += pcie-designware-host.o
 obj-$(CONFIG_PCIE_DW_EP) += pcie-designware-ep.o
 obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
+obj-$(CONFIG_PCIE_INTEL_AXI) += pcie-intel-axi.o
 obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
 obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
 obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
diff --git a/drivers/pci/controller/dwc/pcie-intel-axi.c b/drivers/pci/controller/dwc/pcie-intel-axi.c
new file mode 100644
index 000000000000..2085b580add3
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-intel-axi.c
@@ -0,0 +1,900 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCIe host controller driver for Intel AXI PCIe Bridge
+ *
+ * Copyright (c) 2019 Intel Corporation.
+ *
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/of_irq.h>
+#include <linux/of_pci.h>
+#include <linux/of_platform.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+
+#include "../../pci.h"
+#include "pcie-designware.h"
+
+#define PCIE_CCRID				0x8
+
+#define PCIE_LCAP				0x7C
+#define PCIE_LCAP_MAX_LINK_SPEED		GENMASK(3, 0)
+#define PCIE_LCAP_MAX_LENGTH_WIDTH		GENMASK(9, 4)
+
+/* Link Control and Status Register */
+#define PCIE_LCTLSTS				0x80
+#define PCIE_LCTLSTS_ASPM_ENABLE		GENMASK(1, 0)
+#define PCIE_LCTLSTS_RCB128			BIT(3)
+#define PCIE_LCTLSTS_LINK_DISABLE		BIT(4)
+#define PCIE_LCTLSTS_COM_CLK_CFG		BIT(6)
+#define PCIE_LCTLSTS_HW_AW_DIS			BIT(9)
+#define PCIE_LCTLSTS_LINK_SPEED			GENMASK(19, 16)
+#define PCIE_LCTLSTS_NEGOTIATED_LINK_WIDTH	GENMASK(25, 20)
+#define PCIE_LCTLSTS_SLOT_CLK_CFG		BIT(28)
+
+#define PCIE_LCTLSTS2				0xA0
+#define PCIE_LCTLSTS2_TGT_LINK_SPEED		GENMASK(3, 0)
+#define PCIE_LCTLSTS2_TGT_LINK_SPEED_25GT	0x1
+#define PCIE_LCTLSTS2_TGT_LINK_SPEED_5GT	0x2
+#define PCIE_LCTLSTS2_TGT_LINK_SPEED_8GT	0x3
+#define PCIE_LCTLSTS2_TGT_LINK_SPEED_16GT	0x4
+#define PCIE_LCTLSTS2_HW_AUTO_DIS		BIT(5)
+
+/* Ack Frequency Register */
+#define PCIE_AFR				0x70C
+#define PCIE_AFR_FTS_NUM			GENMASK(15, 8)
+#define PCIE_AFR_COM_FTS_NUM			GENMASK(23, 16)
+#define PCIE_AFR_GEN12_FTS_NUM_DFT		(SZ_128 - 1)
+#define PCIE_AFR_GEN3_FTS_NUM_DFT		180
+#define PCIE_AFR_GEN4_FTS_NUM_DFT		196
+
+#define PCIE_PLCR_DLL_LINK_EN			BIT(5)
+#define PCIE_PORT_LOGIC_FTS			GENMASK(7, 0)
+#define PCIE_PORT_LOGIC_DFT_FTS_NUM		(SZ_128 - 1)
+
+#define PCIE_MISC_CTRL				0x8BC
+#define PCIE_MISC_CTRL_DBI_RO_WR_EN		BIT(0)
+
+#define PCIE_MULTI_LANE_CTRL			0x8C0
+#define PCIE_UPCONFIG_SUPPORT			BIT(7)
+#define PCIE_DIRECT_LINK_WIDTH_CHANGE		BIT(6)
+#define PCIE_TARGET_LINK_WIDTH			GENMASK(5, 0)
+
+#define PCIE_IOP_CTRL				0x8C4
+#define PCIE_IOP_RX_STANDBY_CTRL		GENMASK(6, 0)
+
+/* APP RC Core Control Register */
+#define PCIE_RC_CCR				0x10
+#define PCIE_RC_CCR_LTSSM_ENABLE		BIT(0)
+#define PCIE_DEVICE_TYPE			GENMASK(7, 4)
+#define PCIE_RC_CCR_RC_MODE			BIT(2)
+
+/* PCIe Message Control */
+#define PCIE_MSG_CR				0x30
+#define PCIE_XMT_PM_TURNOFF			BIT(0)
+
+/* PCIe Power Management Control */
+#define PCIE_PMC				0x44
+#define PCIE_PM_IN_L2				BIT(20)
+
+/* Interrupt Enable Register */
+#define PCIE_IRNEN				0xF4
+#define PCIE_IRNCR				0xF8
+#define PCIE_IRN_AER_REPORT			BIT(0)
+#define PCIE_IRN_PME				BIT(2)
+#define PCIE_IRN_HOTPLUG			BIT(3)
+#define PCIE_IRN_RX_VDM_MSG			BIT(4)
+#define PCIE_IRN_PM_TO_ACK			BIT(9)
+#define PCIE_IRN_PM_TURNOFF_ACK			BIT(10)
+#define PCIE_IRN_LINK_AUTO_BW_STATUS		BIT(11)
+#define PCIE_IRN_BW_MGT				BIT(12)
+#define PCIE_IRN_WAKEUP				BIT(17)
+#define PCIE_IRN_MSG_LTR			BIT(18)
+#define PCIE_IRN_SYS_INT			BIT(28)
+#define PCIE_IRN_SYS_ERR_RC			BIT(29)
+
+#define PCIE_IRN_IR_INT	(PCIE_IRN_AER_REPORT | PCIE_IRN_PME | \
+			PCIE_IRN_RX_VDM_MSG | PCIE_IRN_SYS_ERR_RC | \
+			PCIE_IRN_PM_TO_ACK | PCIE_IRN_LINK_AUTO_BW_STATUS | \
+			PCIE_IRN_BW_MGT | PCIE_IRN_MSG_LTR)
+
+#define PCIE_INTX_OFFSET	12
+#define BUS_IATU_OFFS		SZ_256M
+#define RST_INTRVL_DFT_MS	100
+enum {
+	PCIE_LINK_SPEED_AUTO = 0,
+	PCIE_LINK_SPEED_GEN1,
+	PCIE_LINK_SPEED_GEN2,
+	PCIE_LINK_SPEED_GEN3,
+	PCIE_LINK_SPEED_GEN4,
+};
+
+struct intel_pcie_soc {
+	unsigned int pcie_ver;
+	unsigned int pcie_atu_offset;
+	u32 num_viewport;
+};
+
+struct intel_pcie_port {
+	struct dw_pcie		*pci;
+	unsigned int		id; /* Physical RC Index */
+	void __iomem		*app_base;
+	struct gpio_desc	*reset_gpio;
+	u32			rst_interval;
+	u32			max_speed;
+	u32			link_gen;
+	u32			max_width;
+	u32			lanes;
+	struct clk		*core_clk;
+	struct reset_control	*core_rst;
+	struct phy		*phy;
+};
+
+static void pcie_update_bits(void __iomem *base, u32 mask, u32 val, u32 ofs)
+{
+	u32 orig, tmp;
+
+	orig = readl(base + ofs);
+
+	tmp = (orig & ~mask) | (val & mask);
+
+	if (tmp != orig)
+		writel(tmp, base + ofs);
+}
+
+static inline u32 pcie_app_rd(struct intel_pcie_port *lpp, u32 ofs)
+{
+	return readl(lpp->app_base + ofs);
+}
+
+static inline void pcie_app_wr(struct intel_pcie_port *lpp, u32 val, u32 ofs)
+{
+	writel(val, lpp->app_base + ofs);
+}
+
+static void pcie_app_wr_mask(struct intel_pcie_port *lpp,
+			     u32 mask, u32 val, u32 ofs)
+{
+	pcie_update_bits(lpp->app_base, mask, val, ofs);
+}
+
+static inline u32 pcie_rc_cfg_rd(struct intel_pcie_port *lpp, u32 ofs)
+{
+	return dw_pcie_readl_dbi(lpp->pci, ofs);
+}
+
+static inline void pcie_rc_cfg_wr(struct intel_pcie_port *lpp, u32 val, u32 ofs)
+{
+	dw_pcie_writel_dbi(lpp->pci, ofs, val);
+}
+
+static void pcie_rc_cfg_wr_mask(struct intel_pcie_port *lpp,
+				u32 mask, u32 val, u32 ofs)
+{
+	pcie_update_bits(lpp->pci->dbi_base, mask, val, ofs);
+}
+
+static void intel_pcie_mem_iatu(struct intel_pcie_port *lpp)
+{
+	struct pcie_port *pp = &lpp->pci->pp;
+	phys_addr_t cpu_addr = pp->mem_base;
+
+	dw_pcie_prog_outbound_atu(lpp->pci, PCIE_ATU_REGION_INDEX0,
+				  PCIE_ATU_TYPE_MEM, cpu_addr,
+				  pp->mem_base, pp->mem_size);
+}
+
+static int intel_pcie_bios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+
+	struct pcie_port *pp = dev->bus->sysdata;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct intel_pcie_port *lpp = dev_get_drvdata(pci->dev);
+	struct device *pdev = lpp->pci->dev;
+	u32 irq_bit;
+	int irq;
+
+	if (pin == PCI_INTERRUPT_UNKNOWN || pin > PCI_NUM_INTX) {
+		dev_warn(pdev, "WARNING: dev %s: invalid interrupt pin %d\n",
+			 pci_name(dev), pin);
+		return -1;
+	}
+	irq = of_irq_parse_and_map_pci(dev, slot, pin);
+	if (!irq) {
+		dev_err(pdev, "trying to map irq for unknown slot:%d pin:%d\n",
+			slot, pin);
+		return -1;
+	}
+	/* Pin to irq offset bit position */
+	irq_bit = BIT(pin + PCIE_INTX_OFFSET);
+
+	/* Clear possible pending interrupts first */
+	pcie_app_wr(lpp, irq_bit, PCIE_IRNCR);
+
+	pcie_app_wr_mask(lpp, irq_bit, irq_bit, PCIE_IRNEN);
+	return irq;
+}
+
+static void intel_pcie_bridge_class_code_setup(struct intel_pcie_port *lpp)
+{
+	pcie_rc_cfg_wr_mask(lpp, PCIE_MISC_CTRL_DBI_RO_WR_EN,
+			    PCIE_MISC_CTRL_DBI_RO_WR_EN, PCIE_MISC_CTRL);
+	pcie_rc_cfg_wr_mask(lpp, 0xffffff00, PCI_CLASS_BRIDGE_PCI << 16,
+			    PCIE_CCRID);
+	pcie_rc_cfg_wr_mask(lpp, PCIE_MISC_CTRL_DBI_RO_WR_EN, 0,
+			    PCIE_MISC_CTRL);
+}
+
+static void intel_pcie_ltssm_enable(struct intel_pcie_port *lpp)
+{
+	pcie_app_wr_mask(lpp, PCIE_RC_CCR_LTSSM_ENABLE,
+			 PCIE_RC_CCR_LTSSM_ENABLE, PCIE_RC_CCR);
+}
+
+static void intel_pcie_ltssm_disable(struct intel_pcie_port *lpp)
+{
+	pcie_app_wr_mask(lpp, PCIE_RC_CCR_LTSSM_ENABLE, 0, PCIE_RC_CCR);
+}
+
+static const char *pcie_link_gen_to_str(int gen)
+{
+	switch (gen) {
+	case PCIE_LINK_SPEED_GEN1:
+		return "2.5";
+	case PCIE_LINK_SPEED_GEN2:
+		return "5.0";
+	case PCIE_LINK_SPEED_GEN3:
+		return "8.0";
+	case PCIE_LINK_SPEED_GEN4:
+		return "16.0";
+	default:
+		return "???";
+	}
+}
+
+static void intel_pcie_link_setup(struct intel_pcie_port *lpp)
+{
+	u32 val;
+
+	val = pcie_rc_cfg_rd(lpp, PCIE_LCAP);
+	lpp->max_speed = FIELD_GET(PCIE_LCAP_MAX_LINK_SPEED, val);
+	lpp->max_width = FIELD_GET(PCIE_LCAP_MAX_LENGTH_WIDTH, val);
+
+	val = pcie_rc_cfg_rd(lpp, PCIE_LCTLSTS);
+
+	val &= ~(PCIE_LCTLSTS_LINK_DISABLE | PCIE_LCTLSTS_ASPM_ENABLE);
+	val |= (PCIE_LCTLSTS_SLOT_CLK_CFG | PCIE_LCTLSTS_COM_CLK_CFG |
+		PCIE_LCTLSTS_RCB128);
+	pcie_rc_cfg_wr(lpp, val, PCIE_LCTLSTS);
+}
+
+static void intel_pcie_max_speed_setup(struct intel_pcie_port *lpp)
+{
+	u32 reg, val;
+
+	reg = pcie_rc_cfg_rd(lpp, PCIE_LCTLSTS2);
+	switch (lpp->link_gen) {
+	case PCIE_LINK_SPEED_GEN1:
+		reg &= ~PCIE_LCTLSTS2_TGT_LINK_SPEED;
+		reg |= PCIE_LCTLSTS2_HW_AUTO_DIS |
+			PCIE_LCTLSTS2_TGT_LINK_SPEED_25GT;
+		break;
+	case PCIE_LINK_SPEED_GEN2:
+		reg &= ~PCIE_LCTLSTS2_TGT_LINK_SPEED;
+		reg |= PCIE_LCTLSTS2_HW_AUTO_DIS |
+			PCIE_LCTLSTS2_TGT_LINK_SPEED_5GT;
+		break;
+	case PCIE_LINK_SPEED_GEN3:
+		reg &= ~PCIE_LCTLSTS2_TGT_LINK_SPEED;
+		reg |= PCIE_LCTLSTS2_HW_AUTO_DIS |
+			PCIE_LCTLSTS2_TGT_LINK_SPEED_8GT;
+		break;
+	case PCIE_LINK_SPEED_GEN4:
+		reg &= ~PCIE_LCTLSTS2_TGT_LINK_SPEED;
+		reg |= PCIE_LCTLSTS2_HW_AUTO_DIS |
+			PCIE_LCTLSTS2_TGT_LINK_SPEED_16GT;
+		break;
+	default:
+		/* Use hardware capability */
+		val = pcie_rc_cfg_rd(lpp, PCIE_LCAP);
+		val = FIELD_GET(PCIE_LCAP_MAX_LINK_SPEED, val);
+		reg &= ~PCIE_LCTLSTS2_HW_AUTO_DIS;
+		reg |= val;
+		break;
+	}
+	pcie_rc_cfg_wr(lpp, reg, PCIE_LCTLSTS2);
+}
+
+static void intel_pcie_speed_change_enable(struct intel_pcie_port *lpp)
+{
+	u32 mask, val;
+
+	mask = PORT_LOGIC_SPEED_CHANGE | PCIE_PORT_LOGIC_FTS;
+	val = PORT_LOGIC_SPEED_CHANGE | PCIE_PORT_LOGIC_DFT_FTS_NUM;
+
+	pcie_rc_cfg_wr_mask(lpp, mask, val, PCIE_LINK_WIDTH_SPEED_CONTROL);
+}
+
+static void intel_pcie_speed_change_disable(struct intel_pcie_port *lpp)
+{
+	pcie_rc_cfg_wr_mask(lpp, PORT_LOGIC_SPEED_CHANGE, 0,
+			    PCIE_LINK_WIDTH_SPEED_CONTROL);
+}
+
+static void intel_pcie_max_link_width_setup(struct intel_pcie_port *lpp)
+{
+	u32 mask, val;
+
+	/* HW auto bandwidth negotiation must be enabled */
+	pcie_rc_cfg_wr_mask(lpp, PCIE_LCTLSTS_HW_AW_DIS, 0, PCIE_LCTLSTS);
+
+	mask = PCIE_DIRECT_LINK_WIDTH_CHANGE | PCIE_TARGET_LINK_WIDTH;
+	val = PCIE_DIRECT_LINK_WIDTH_CHANGE | lpp->lanes;
+	pcie_rc_cfg_wr_mask(lpp, mask, val, PCIE_MULTI_LANE_CTRL);
+}
+
+static void intel_pcie_port_logic_setup(struct intel_pcie_port *lpp)
+{
+	u32 val, mask, fts;
+
+	switch (lpp->max_speed) {
+	case PCIE_LINK_SPEED_GEN1:
+	case PCIE_LINK_SPEED_GEN2:
+		fts = PCIE_AFR_GEN12_FTS_NUM_DFT;
+		break;
+	case PCIE_LINK_SPEED_GEN3:
+		fts = PCIE_AFR_GEN3_FTS_NUM_DFT;
+		break;
+	case PCIE_LINK_SPEED_GEN4:
+		fts = PCIE_AFR_GEN4_FTS_NUM_DFT;
+		break;
+	default:
+		fts = PCIE_AFR_GEN12_FTS_NUM_DFT;
+		break;
+	}
+	mask = PCIE_AFR_FTS_NUM | PCIE_AFR_COM_FTS_NUM;
+	val = FIELD_PREP(PCIE_AFR_FTS_NUM, fts) |
+	       FIELD_PREP(PCIE_AFR_COM_FTS_NUM, fts);
+	pcie_rc_cfg_wr_mask(lpp, mask, val, PCIE_AFR);
+
+	/* Port Link Control Register */
+	pcie_rc_cfg_wr_mask(lpp, PCIE_PLCR_DLL_LINK_EN,
+			    PCIE_PLCR_DLL_LINK_EN, PCIE_PORT_LINK_CONTROL);
+}
+
+static void intel_pcie_upconfig_setup(struct intel_pcie_port *lpp)
+{
+	pcie_rc_cfg_wr_mask(lpp, PCIE_UPCONFIG_SUPPORT,
+			    PCIE_UPCONFIG_SUPPORT, PCIE_MULTI_LANE_CTRL);
+
+	pcie_rc_cfg_wr_mask(lpp, PCIE_IOP_RX_STANDBY_CTRL, 0, PCIE_IOP_CTRL);
+}
+
+static void intel_pcie_rc_setup(struct intel_pcie_port *lpp)
+{
+	u32 val;
+
+	val = PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER;
+	pcie_rc_cfg_wr_mask(lpp, val, val, PCI_COMMAND);
+
+	intel_pcie_ltssm_disable(lpp);
+	intel_pcie_link_setup(lpp);
+	dw_pcie_setup(lpp->pci);
+	intel_pcie_upconfig_setup(lpp);
+	intel_pcie_bridge_class_code_setup(lpp);
+	intel_pcie_max_speed_setup(lpp);
+	intel_pcie_speed_change_enable(lpp);
+	intel_pcie_port_logic_setup(lpp);
+	intel_pcie_mem_iatu(lpp);
+}
+
+static int intel_pcie_ep_rst_init(struct intel_pcie_port *lpp)
+{
+	struct device *dev = lpp->pci->dev;
+	int ret = 0;
+
+	lpp->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(lpp->reset_gpio)) {
+		ret = PTR_ERR(lpp->reset_gpio);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to request PCIe GPIO: %d\n", ret);
+		return ret;
+	}
+	/* Make initial reset last for 100ms */
+	msleep(100);
+
+	return ret;
+}
+
+static void intel_pcie_core_rst_assert(struct intel_pcie_port *lpp)
+{
+	reset_control_assert(lpp->core_rst);
+}
+
+static void intel_pcie_core_rst_deassert(struct intel_pcie_port *lpp)
+{
+	/*
+	 * One micro-second delay to make sure the reset pulse
+	 * wide enough so that core reset is clean.
+	 */
+	udelay(1);
+	reset_control_deassert(lpp->core_rst);
+
+	/*
+	 * Some SoC core reset also reset PHY, more delay needed
+	 * to make sure the reset process is done.
+	 */
+	usleep_range(1000, 2000);
+}
+
+static void intel_pcie_device_rst_assert(struct intel_pcie_port *lpp)
+{
+	gpiod_set_value_cansleep(lpp->reset_gpio, 1);
+}
+
+static void intel_pcie_device_rst_deassert(struct intel_pcie_port *lpp)
+{
+	msleep(lpp->rst_interval);
+	gpiod_set_value_cansleep(lpp->reset_gpio, 0);
+}
+
+static int intel_pcie_app_logic_setup(struct intel_pcie_port *lpp)
+{
+	intel_pcie_device_rst_deassert(lpp);
+	intel_pcie_ltssm_enable(lpp);
+
+	return dw_pcie_wait_for_link(lpp->pci);
+}
+
+static irqreturn_t intel_pcie_core_isr(int irq, void *arg)
+{
+	struct intel_pcie_port *lpp = arg;
+	u32 val, reg;
+
+	reg = pcie_app_rd(lpp, PCIE_IRNCR);
+	val = reg & PCIE_IRN_IR_INT;
+
+	pcie_app_wr(lpp, val, PCIE_IRNCR);
+
+	trace_printk("PCIe misc interrupt status 0x%x\n", reg);
+	return IRQ_HANDLED;
+}
+
+static int intel_pcie_setup_irq(struct intel_pcie_port *lpp)
+{
+	struct device *dev = lpp->pci->dev;
+	struct platform_device *pdev;
+	char *irq_name;
+	int irq, ret;
+
+	pdev = to_platform_device(dev);
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(dev, "missing sys integrated irq resource\n");
+		return irq;
+	}
+
+	irq_name = devm_kasprintf(dev, GFP_KERNEL, "pcie_misc%d", lpp->id);
+	if (!irq_name) {
+		dev_err(dev, "failed to alloc irq name\n");
+		return -ENOMEM;
+	}
+
+	ret = devm_request_irq(dev, irq, intel_pcie_core_isr,
+			       IRQF_SHARED, irq_name, lpp);
+	if (ret) {
+		dev_err(dev, "request irq %d failed\n", irq);
+		return ret;
+	}
+	/* Enable integrated interrupts */
+	pcie_app_wr_mask(lpp, PCIE_IRN_IR_INT, PCIE_IRN_IR_INT, PCIE_IRNEN);
+
+	return ret;
+}
+
+static void intel_pcie_core_irq_disable(struct intel_pcie_port *lpp)
+{
+	pcie_app_wr(lpp, 0, PCIE_IRNEN);
+	pcie_app_wr(lpp, PCIE_IRN_IR_INT,  PCIE_IRNCR);
+}
+
+static void intel_pcie_disable_clks(struct intel_pcie_port *lpp)
+{
+	clk_disable_unprepare(lpp->core_clk);
+}
+
+static int intel_pcie_enable_clks(struct intel_pcie_port *lpp)
+{
+	int ret = clk_prepare_enable(lpp->core_clk);
+
+	if (ret)
+		dev_err(lpp->pci->dev, "Core clock enable failed: %d\n", ret);
+
+	return ret;
+}
+
+static int intel_pcie_get_resources(struct platform_device *pdev)
+{
+	struct intel_pcie_port *lpp;
+	struct device *dev;
+	int ret;
+
+	lpp = platform_get_drvdata(pdev);
+	dev = lpp->pci->dev;
+
+	lpp->core_clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(lpp->core_clk)) {
+		ret = PTR_ERR(lpp->core_clk);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to get clks: %d\n", ret);
+		return ret;
+	}
+
+	lpp->core_rst = devm_reset_control_get(dev, NULL);
+	if (IS_ERR(lpp->core_rst)) {
+		ret = PTR_ERR(lpp->core_rst);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to get resets: %d\n", ret);
+		return ret;
+	}
+
+	ret = device_property_match_string(dev, "device_type", "pci");
+	if (ret) {
+		dev_err(dev, "failed to find pci device type: %d\n", ret);
+		return ret;
+	}
+
+	if (device_property_read_u32(dev, "intel,rst-interval",
+				     &lpp->rst_interval))
+		lpp->rst_interval = RST_INTRVL_DFT_MS;
+
+	if (device_property_read_u32(dev, "max-link-speed", &lpp->link_gen))
+		lpp->link_gen = 0; /* Fallback to auto */
+
+	lpp->app_base = devm_platform_ioremap_resource(pdev, 2);
+	if (IS_ERR(lpp->app_base))
+		return PTR_ERR(lpp->app_base);
+
+	ret = intel_pcie_ep_rst_init(lpp);
+	if (ret)
+		return ret;
+
+	lpp->phy = devm_phy_get(dev, "phy");
+	if (IS_ERR(lpp->phy)) {
+		ret = PTR_ERR(lpp->phy);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "couldn't get pcie-phy: %d\n", ret);
+		return ret;
+	}
+	return 0;
+}
+
+static void intel_pcie_deinit_phy(struct intel_pcie_port *lpp)
+{
+	phy_exit(lpp->phy);
+}
+
+static int intel_pcie_wait_l2(struct intel_pcie_port *lpp)
+{
+	u32 value;
+	int ret;
+
+	if (lpp->max_speed < PCIE_LINK_SPEED_GEN3)
+		return 0;
+
+	/* Send PME_TURN_OFF message */
+	pcie_app_wr_mask(lpp, PCIE_XMT_PM_TURNOFF,
+			 PCIE_XMT_PM_TURNOFF, PCIE_MSG_CR);
+
+	/* Read PMC status and wait for falling into L2 link state */
+	ret = readl_poll_timeout(lpp->app_base + PCIE_PMC, value,
+				 (value & PCIE_PM_IN_L2), 20,
+				 jiffies_to_usecs(5 * HZ));
+	if (ret)
+		dev_err(lpp->pci->dev, "PCIe link enter L2 timeout!\n");
+
+	return ret;
+}
+
+static void intel_pcie_turn_off(struct intel_pcie_port *lpp)
+{
+	if (dw_pcie_link_up(lpp->pci))
+		intel_pcie_wait_l2(lpp);
+
+	/* Put EP in reset state */
+	intel_pcie_device_rst_assert(lpp);
+	pcie_rc_cfg_wr_mask(lpp, PCI_COMMAND_MEMORY, 0, PCI_COMMAND);
+}
+
+static int intel_pcie_host_setup(struct intel_pcie_port *lpp)
+{
+	int ret;
+
+	intel_pcie_core_rst_assert(lpp);
+	intel_pcie_device_rst_assert(lpp);
+
+	ret = phy_init(lpp->phy);
+	if (ret)
+		return ret;
+
+	intel_pcie_core_rst_deassert(lpp);
+	ret = intel_pcie_enable_clks(lpp);
+	if (ret)
+		goto clk_err;
+
+	intel_pcie_rc_setup(lpp);
+	ret = intel_pcie_app_logic_setup(lpp);
+	if (ret)
+		goto app_init_err;
+
+	ret = intel_pcie_setup_irq(lpp);
+	if (!ret)
+		return ret;
+
+	intel_pcie_turn_off(lpp);
+app_init_err:
+	intel_pcie_disable_clks(lpp);
+clk_err:
+	intel_pcie_core_rst_assert(lpp);
+	intel_pcie_deinit_phy(lpp);
+	return ret;
+}
+
+static ssize_t
+pcie_link_status_show(struct device *dev, struct device_attribute *attr,
+		      char *buf)
+{
+	u32 reg, width, gen;
+	struct intel_pcie_port *lpp;
+
+	lpp = dev_get_drvdata(dev);
+
+	reg = pcie_rc_cfg_rd(lpp, PCIE_LCTLSTS);
+	width = FIELD_GET(PCIE_LCTLSTS_NEGOTIATED_LINK_WIDTH, reg);
+	gen = FIELD_GET(PCIE_LCTLSTS_LINK_SPEED, reg);
+	if (gen > lpp->max_speed)
+		return -EINVAL;
+
+	return sprintf(buf, "Port %2u Width x%u Speed %s GT/s\n", lpp->id,
+		       width, pcie_link_gen_to_str(gen));
+}
+static DEVICE_ATTR_RO(pcie_link_status);
+
+static ssize_t pcie_speed_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t len)
+{
+	struct intel_pcie_port *lpp;
+	unsigned long val;
+	int ret;
+
+	lpp = dev_get_drvdata(dev);
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	if (val > lpp->max_speed)
+		return -EINVAL;
+
+	lpp->link_gen = val;
+	intel_pcie_max_speed_setup(lpp);
+	intel_pcie_speed_change_disable(lpp);
+	intel_pcie_speed_change_enable(lpp);
+
+	return len;
+}
+static DEVICE_ATTR_WO(pcie_speed);
+
+/*
+ * Link width change on the fly is not always successful.
+ * It also depends on the partner.
+ */
+static ssize_t pcie_width_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t len)
+{
+	struct intel_pcie_port *lpp;
+	unsigned long val;
+
+	lpp = dev_get_drvdata(dev);
+
+	if (kstrtoul(buf, 10, &val))
+		return -EINVAL;
+
+	if (val > lpp->max_width)
+		return -EINVAL;
+
+	lpp->lanes = val;
+	intel_pcie_max_link_width_setup(lpp);
+
+	return len;
+}
+static DEVICE_ATTR_WO(pcie_width);
+
+static struct attribute *pcie_cfg_attrs[] = {
+	&dev_attr_pcie_link_status.attr,
+	&dev_attr_pcie_speed.attr,
+	&dev_attr_pcie_width.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(pcie_cfg);
+
+static int intel_pcie_sysfs_init(struct intel_pcie_port *lpp)
+{
+	return devm_device_add_groups(lpp->pci->dev, pcie_cfg_groups);
+}
+
+static void __intel_pcie_remove(struct intel_pcie_port *lpp)
+{
+	pcie_rc_cfg_wr_mask(lpp, PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER,
+			    0, PCI_COMMAND);
+	intel_pcie_core_irq_disable(lpp);
+	intel_pcie_turn_off(lpp);
+	intel_pcie_disable_clks(lpp);
+	intel_pcie_core_rst_assert(lpp);
+	intel_pcie_deinit_phy(lpp);
+}
+
+static int intel_pcie_remove(struct platform_device *pdev)
+{
+	struct intel_pcie_port *lpp = platform_get_drvdata(pdev);
+	struct pcie_port *pp = &lpp->pci->pp;
+
+	pci_stop_root_bus(pp->root_bus);
+	pci_remove_root_bus(pp->root_bus);
+	__intel_pcie_remove(lpp);
+
+	return 0;
+}
+
+static int __maybe_unused intel_pcie_suspend_noirq(struct device *dev)
+{
+	struct intel_pcie_port *lpp = dev_get_drvdata(dev);
+	int ret;
+
+	intel_pcie_core_irq_disable(lpp);
+	ret = intel_pcie_wait_l2(lpp);
+	if (ret)
+		return ret;
+
+	intel_pcie_deinit_phy(lpp);
+	intel_pcie_disable_clks(lpp);
+	return ret;
+}
+
+static int __maybe_unused intel_pcie_resume_noirq(struct device *dev)
+{
+	struct intel_pcie_port *lpp = dev_get_drvdata(dev);
+
+	return intel_pcie_host_setup(lpp);
+}
+
+static int intel_pcie_rc_init(struct pcie_port *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct intel_pcie_port *lpp = dev_get_drvdata(pci->dev);
+	int ret;
+
+	/* RC/host initialization */
+	ret = intel_pcie_host_setup(lpp);
+	if (ret)
+		return ret;
+	ret = intel_pcie_sysfs_init(lpp);
+	if (ret)
+		__intel_pcie_remove(lpp);
+	return ret;
+}
+
+int intel_pcie_msi_init(struct pcie_port *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+
+	dev_dbg(pci->dev, "MSI is handled in x86 arch\n");
+	return 0;
+}
+
+u64 intel_pcie_cpu_addr(struct dw_pcie *pcie, u64 cpu_addr)
+{
+	return cpu_addr + BUS_IATU_OFFS;
+}
+
+static const struct dw_pcie_ops intel_pcie_ops = {
+	.cpu_addr_fixup = intel_pcie_cpu_addr,
+};
+
+static const struct dw_pcie_host_ops intel_pcie_dw_ops = {
+	.host_init =		intel_pcie_rc_init,
+	.msi_host_init =	intel_pcie_msi_init,
+};
+
+static const struct intel_pcie_soc pcie_data = {
+	.pcie_ver =		0x520A,
+	.pcie_atu_offset =	0xC0000,
+	.num_viewport =		3,
+};
+
+static int intel_pcie_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct intel_pcie_soc *data;
+	struct intel_pcie_port *lpp;
+	struct pcie_port *pp;
+	struct dw_pcie *pci;
+	int ret;
+
+	lpp = devm_kzalloc(dev, sizeof(*lpp), GFP_KERNEL);
+	if (!lpp)
+		return -ENOMEM;
+
+	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
+	if (!pci)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, lpp);
+	lpp->pci = pci;
+	pci->dev = dev;
+	pp = &pci->pp;
+
+	ret = device_property_read_u32(dev, "linux,pci-domain", &lpp->id);
+	if (ret) {
+		dev_err(dev, "failed to get domain id, errno %d\n", ret);
+		return ret;
+	}
+
+	pci->dbi_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(pci->dbi_base))
+		return PTR_ERR(pci->dbi_base);
+
+	ret = intel_pcie_get_resources(pdev);
+	if (ret)
+		return ret;
+
+	data = device_get_match_data(dev);
+	pci->ops = &intel_pcie_ops;
+	pci->version = data->pcie_ver;
+	pci->atu_base = pci->dbi_base + data->pcie_atu_offset;
+	pp->ops = &intel_pcie_dw_ops;
+	pp->map_irq = intel_pcie_bios_map_irq;
+
+	ret = dw_pcie_host_init(pp);
+	if (ret) {
+		dev_err(dev, "cannot initialize host\n");
+		return ret;
+	}
+	/* Intel PCIe doesn't configure IO region, so configure
+	 * viewport to not to access IO region during register
+	 * read write operations.
+	 */
+	pci->num_viewport = data->num_viewport;
+	dev_info(dev,
+		 "Intel AXI PCIe Root Complex Port %d Init Done\n", lpp->id);
+	return ret;
+}
+
+static const struct dev_pm_ops intel_pcie_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(intel_pcie_suspend_noirq,
+				      intel_pcie_resume_noirq)
+};
+
+static const struct of_device_id of_intel_pcie_match[] = {
+	{ .compatible = "intel,lgm-pcie", .data = &pcie_data },
+	{}
+};
+
+static struct platform_driver intel_pcie_driver = {
+	.probe = intel_pcie_probe,
+	.remove = intel_pcie_remove,
+	.driver = {
+		.name = "intel-lgm-pcie",
+		.of_match_table = of_intel_pcie_match,
+		.pm = &intel_pcie_pm_ops,
+	},
+};
+builtin_platform_driver(intel_pcie_driver);
-- 
2.11.0

