Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9C8103563
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 08:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfKTHnn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Nov 2019 02:43:43 -0500
Received: from mga12.intel.com ([192.55.52.136]:31055 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbfKTHnm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Nov 2019 02:43:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2019 23:43:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,221,1571727600"; 
   d="scan'208";a="357354900"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga004.jf.intel.com with ESMTP; 19 Nov 2019 23:43:35 -0800
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     gustavo.pimentel@synopsys.com, lorenzo.pieralisi@arm.com,
        andrew.murray@arm.com, helgaas@kernel.org, jingoohan1@gmail.com,
        robh@kernel.org, martin.blumenstingl@googlemail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com
Cc:     linux-kernel@vger.kernel.org, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH v8 2/3] dwc: PCI: intel: PCIe RC controller driver
Date:   Wed, 20 Nov 2019 15:43:01 +0800
Message-Id: <71262d29ca564060331e7e2c1ceb41158109cb92.1574158309.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1574158309.git.eswara.kota@linux.intel.com>
References: <cover.1574158309.git.eswara.kota@linux.intel.com>
In-Reply-To: <cover.1574158309.git.eswara.kota@linux.intel.com>
References: <cover.1574158309.git.eswara.kota@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to PCIe RC controller on Intel Gateway SoCs.
PCIe controller is based of Synopsys DesignWare PCIe core.

Intel PCIe driver requires Upconfigure support, Fast Training
Sequence and link speed configurations. So adding the respective
helper functions in the PCIe DesignWare framework.
It also programs hardware autonomous speed during speed
configuration so defining it in pci_regs.h.

Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
Changes on v8:
	Add Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
	Place INTEL_GW config in order in Makefile and Kconfig
	Follow offset, mask and value order in function arguments
	update reset-assert-ms dt property read to
		ret = device_property_read_u32(...);
			if (ret)
			...
Changes on v7:
	Add Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
	Remove unused header files.
	  #include <linux/interrupt.h>
	  #include <linux/of_irq.h>
	  #include <linux/of_pci.h>
	  #include <linux/of_platform.h>

Changes on v6:
	Add Reviewed-by: Andrew Murray <andrew.murray@arm.com>
	Address review comments:
	  Remove extra space in Kconfig
	  Fix style indents in switch case
	  Apply mask for the n_fts argument in dw_pcie_link_set_n_fts()
	   to prevent the case of n_fts value having outside the mask bits
	  Update PORT_LOGIC_N_FTS to PORT_LOGIC_N_FTS_MASK
	  Update BUS_IATU_OFFS to BUS_IATU_OFFSET
	  Update RST_INTRVL_DFT_MS to RESET_INTERVAL_MS
	  Reduce local variables in pcie_update_bits()
	  Remove blank lines
	  Remove extra paranthesis during readl_poll_timeout() call
	  Add error handling for dw_pcie_find_capability() call
	  Add blank line before dev_info() in probe()

Changes on v5:
	Use new, old variables in pcie_update_bits()
	Correct naming:
	  s/Designware/DesignWare
	  s/pcie/PCIe
	  s/pci/PCI
	  s/Hw/HW
	  Upconfig to Upconfigure
	Remove extra lines after the intel_pcie_max_speed_setup() def.
	Use pcie_link_speed[] and remove enum for pcie gen.
	Remove dw_pcie_link_speed_change() def.
	Remove "linux,pci-domain" parsing.
	Remove 'id' variable in intel_pcie_port structure.
	Remove extra spaces for lpp->link_gen =
	Correct the offset of PCI_EXP_LNKCTL2_HASD to 0x0020.
	Remove programming of RCB and CCC bits in PCI_EXP_LCTL reg.
	Remove programming Slot clock cfg in PCI_EXP_LSTS reg.
	Update the comments at num_viewport setting.
	Update the description in Kconfig.
	Get PCIe cap offset from the registers using dw_pcie_find_capability()
	Define pcie_cap_ofst var in intel_pcie_port struct to store the same.
	Remove the PCIE_CAP_OFST macro.
	Move intel_pcie_max_speed_setup() function to DesignWare framework,
	 defined as dw_pcie_link_set_max_speed()
	Set EXPORT_SYMBOL_GPL for the newer functions defined in
	  pcie-designware.c

Changes on v4:
	Rename the driver naming and description to
	 "PCIe RC controller on Intel Gateway SoCs".
	Use PCIe core register macros defined in pci_regs.h
	 and remove respective local definitions.
	Remove PCIe core interrupt handling.
	Move PCIe link control speed change, upconfig and FTS.
	configuration functions to DesignWare framework.
	Use of_pci_get_max_link_speed().
	Mark dependency on X86 and COMPILE_TEST in Kconfig.
	Remove lanes and add n_fts variables in intel_pcie_port structure.
	Rename rst_interval variable to rst_intrvl in intel_pcie_port structure.
	Remove intel_pcie_mem_iatu() as it is already perfomed in dw_setup_rc()
	Move sysfs attributes specific code to separate patch.
	Remove redundant error handling.
	Reduce LoCs by doing variable initializations while declaration itself.
	Add extra line after closing parenthesis.
	Move intel_pcie_ep_rst_init() out of get_resources()

changes on v3:
	Rename PCIe app logic registers with PCIE_APP prefix.
	PCIE_IOP_CTRL configuration is not required. Remove respective code.
	Remove wrapper functions for clk enable/disable APIs.
	Use platform_get_resource_byname() instead of
	  devm_platform_ioremap_resource() to be similar with DWC framework.
	Rename phy name to "pciephy".
	Modify debug message in msi_init() callback to be more specific.
	Remove map_irq() callback.
	Enable the INTx interrupts at the time of PCIe initialization.
	Reduce memory fragmentation by using variable "struct dw_pcie pci"
	  instead of allocating memory.
	Reduce the delay to 100us during enpoint initialization
	  intel_pcie_ep_rst_init().
	Call  dw_pcie_host_deinit() during remove() instead of directly
	  calling PCIe core APIs.
	Rename "intel,rst-interval" to "reset-assert-ms".
	Remove unused APP logic Interrupt bit macro definitions.
 	Use dwc framework's dw_pcie_setup_rc() for PCIe host specific
	 configuration instead of redefining the same functionality in
	 the driver.
	Move the whole DT parsing specific code to intel_pcie_get_resources()

 drivers/pci/controller/dwc/Kconfig           |  10 +
 drivers/pci/controller/dwc/Makefile          |   1 +
 drivers/pci/controller/dwc/pcie-designware.c |  57 +++
 drivers/pci/controller/dwc/pcie-designware.h |  12 +
 drivers/pci/controller/dwc/pcie-intel-gw.c   | 545 +++++++++++++++++++++++++++
 include/uapi/linux/pci_regs.h                |   1 +
 6 files changed, 626 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-intel-gw.c

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 0ba988b5b5bc..e580ae036d77 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -209,6 +209,16 @@ config PCIE_ARTPEC6_EP
 	  Enables support for the PCIe controller in the ARTPEC-6 SoC to work in
 	  endpoint mode. This uses the DesignWare core.
 
+config PCIE_INTEL_GW
+	bool "Intel Gateway PCIe host controller support"
+	depends on OF && (X86 || COMPILE_TEST)
+	select PCIE_DW_HOST
+	help
+	  Say 'Y' here to enable PCIe Host controller support on Intel
+	  Gateway SoCs.
+	  The PCIe controller uses the DesignWare core plus Intel-specific
+	  hardware wrappers.
+
 config PCIE_KIRIN
 	depends on OF && (ARM64 || COMPILE_TEST)
 	bool "HiSilicon Kirin series SoCs PCIe controllers"
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index b30336181d46..901e20f2ea96 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o pci-layerscape-ep.o
 obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
 obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
 obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
+obj-$(CONFIG_PCIE_INTEL_GW) += pcie-intel-gw.o
 obj-$(CONFIG_PCIE_KIRIN) += pcie-kirin.o
 obj-$(CONFIG_PCIE_HISI_STB) += pcie-histb.o
 obj-$(CONFIG_PCI_MESON) += pci-meson.o
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 820488dfeaed..479e250695a0 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -14,6 +14,8 @@
 
 #include "pcie-designware.h"
 
+extern const unsigned char pcie_link_speed[];
+
 /*
  * These interfaces resemble the pci_find_*capability() interfaces, but these
  * are for configuring host controllers, which are bridges *to* PCI devices but
@@ -474,6 +476,61 @@ int dw_pcie_link_up(struct dw_pcie *pci)
 		(!(val & PCIE_PORT_DEBUG1_LINK_IN_TRAINING)));
 }
 
+void dw_pcie_upconfig_setup(struct dw_pcie *pci)
+{
+	u32 val;
+
+	val = dw_pcie_readl_dbi(pci, PCIE_PORT_MULTI_LANE_CTRL);
+	val |= PORT_MLTI_UPCFG_SUPPORT;
+	dw_pcie_writel_dbi(pci, PCIE_PORT_MULTI_LANE_CTRL, val);
+}
+EXPORT_SYMBOL_GPL(dw_pcie_upconfig_setup);
+
+void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
+{
+	u32 reg, val;
+	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+
+	reg = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCTL2);
+	reg &= ~PCI_EXP_LNKCTL2_TLS;
+
+	switch (pcie_link_speed[link_gen]) {
+	case PCIE_SPEED_2_5GT:
+		reg |= PCI_EXP_LNKCTL2_TLS_2_5GT;
+		break;
+	case PCIE_SPEED_5_0GT:
+		reg |= PCI_EXP_LNKCTL2_TLS_5_0GT;
+		break;
+	case PCIE_SPEED_8_0GT:
+		reg |= PCI_EXP_LNKCTL2_TLS_8_0GT;
+		break;
+	case PCIE_SPEED_16_0GT:
+		reg |= PCI_EXP_LNKCTL2_TLS_16_0GT;
+		break;
+	default:
+		/* Use hardware capability */
+		val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
+		val = FIELD_GET(PCI_EXP_LNKCAP_SLS, val);
+		reg &= ~PCI_EXP_LNKCTL2_HASD;
+		reg |= FIELD_PREP(PCI_EXP_LNKCTL2_TLS, val);
+		break;
+	}
+
+	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCTL2, reg);
+}
+EXPORT_SYMBOL_GPL(dw_pcie_link_set_max_speed);
+
+void dw_pcie_link_set_n_fts(struct dw_pcie *pci, u32 n_fts)
+{
+	u32 val;
+
+	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
+	val &= ~PORT_LOGIC_N_FTS_MASK;
+	val |= n_fts & PORT_LOGIC_N_FTS_MASK;
+	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
+}
+EXPORT_SYMBOL_GPL(dw_pcie_link_set_n_fts);
+
 static u8 dw_pcie_iatu_unroll_enabled(struct dw_pcie *pci)
 {
 	u32 val;
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 5a18e94e52c8..3b0be5cd9235 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -30,7 +30,12 @@
 #define LINK_WAIT_IATU			9
 
 /* Synopsys-specific PCIe configuration registers */
+#define PCIE_PORT_AFR			0x70C
+#define PORT_AFR_N_FTS_MASK		GENMASK(15, 8)
+#define PORT_AFR_CC_N_FTS_MASK		GENMASK(23, 16)
+
 #define PCIE_PORT_LINK_CONTROL		0x710
+#define PORT_LINK_DLL_LINK_EN		BIT(5)
 #define PORT_LINK_MODE_MASK		GENMASK(21, 16)
 #define PORT_LINK_MODE(n)		FIELD_PREP(PORT_LINK_MODE_MASK, n)
 #define PORT_LINK_MODE_1_LANES		PORT_LINK_MODE(0x1)
@@ -46,6 +51,7 @@
 #define PCIE_PORT_DEBUG1_LINK_IN_TRAINING	BIT(29)
 
 #define PCIE_LINK_WIDTH_SPEED_CONTROL	0x80C
+#define PORT_LOGIC_N_FTS_MASK		GENMASK(7, 0)
 #define PORT_LOGIC_SPEED_CHANGE		BIT(17)
 #define PORT_LOGIC_LINK_WIDTH_MASK	GENMASK(12, 8)
 #define PORT_LOGIC_LINK_WIDTH(n)	FIELD_PREP(PORT_LOGIC_LINK_WIDTH_MASK, n)
@@ -60,6 +66,9 @@
 #define PCIE_MSI_INTR0_MASK		0x82C
 #define PCIE_MSI_INTR0_STATUS		0x830
 
+#define PCIE_PORT_MULTI_LANE_CTRL	0x8C0
+#define PORT_MLTI_UPCFG_SUPPORT		BIT(7)
+
 #define PCIE_ATU_VIEWPORT		0x900
 #define PCIE_ATU_REGION_INBOUND		BIT(31)
 #define PCIE_ATU_REGION_OUTBOUND	0
@@ -273,6 +282,9 @@ void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
 u32 dw_pcie_read_atu(struct dw_pcie *pci, u32 reg, size_t size);
 void dw_pcie_write_atu(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
 int dw_pcie_link_up(struct dw_pcie *pci);
+void dw_pcie_upconfig_setup(struct dw_pcie *pci);
+void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen);
+void dw_pcie_link_set_n_fts(struct dw_pcie *pci, u32 n_fts);
 int dw_pcie_wait_for_link(struct dw_pcie *pci);
 void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
 			       int type, u64 cpu_addr, u64 pci_addr,
diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
new file mode 100644
index 000000000000..165f51e1f736
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
@@ -0,0 +1,545 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCIe host controller driver for Intel Gateway SoCs
+ *
+ * Copyright (c) 2019 Intel Corporation.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/gpio/consumer.h>
+#include <linux/iopoll.h>
+#include <linux/pci_regs.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+
+#include "../../pci.h"
+#include "pcie-designware.h"
+
+#define PORT_AFR_N_FTS_GEN12_DFT	(SZ_128 - 1)
+#define PORT_AFR_N_FTS_GEN3		180
+#define PORT_AFR_N_FTS_GEN4		196
+
+/* PCIe Application logic Registers */
+#define PCIE_APP_CCR			0x10
+#define PCIE_APP_CCR_LTSSM_ENABLE	BIT(0)
+
+#define PCIE_APP_MSG_CR			0x30
+#define PCIE_APP_MSG_XMT_PM_TURNOFF	BIT(0)
+
+#define PCIE_APP_PMC			0x44
+#define PCIE_APP_PMC_IN_L2		BIT(20)
+
+#define PCIE_APP_IRNEN			0xF4
+#define PCIE_APP_IRNCR			0xF8
+#define PCIE_APP_IRN_AER_REPORT		BIT(0)
+#define PCIE_APP_IRN_PME		BIT(2)
+#define PCIE_APP_IRN_RX_VDM_MSG		BIT(4)
+#define PCIE_APP_IRN_PM_TO_ACK		BIT(9)
+#define PCIE_APP_IRN_LINK_AUTO_BW_STAT	BIT(11)
+#define PCIE_APP_IRN_BW_MGT		BIT(12)
+#define PCIE_APP_IRN_MSG_LTR		BIT(18)
+#define PCIE_APP_IRN_SYS_ERR_RC		BIT(29)
+#define PCIE_APP_INTX_OFST		12
+
+#define PCIE_APP_IRN_INT \
+	(PCIE_APP_IRN_AER_REPORT | PCIE_APP_IRN_PME | \
+	PCIE_APP_IRN_RX_VDM_MSG | PCIE_APP_IRN_SYS_ERR_RC | \
+	PCIE_APP_IRN_PM_TO_ACK | PCIE_APP_IRN_MSG_LTR | \
+	PCIE_APP_IRN_BW_MGT | PCIE_APP_IRN_LINK_AUTO_BW_STAT | \
+	(PCIE_APP_INTX_OFST + PCI_INTERRUPT_INTA) | \
+	(PCIE_APP_INTX_OFST + PCI_INTERRUPT_INTB) | \
+	(PCIE_APP_INTX_OFST + PCI_INTERRUPT_INTC) | \
+	(PCIE_APP_INTX_OFST + PCI_INTERRUPT_INTD))
+
+#define BUS_IATU_OFFSET			SZ_256M
+#define RESET_INTERVAL_MS		100
+
+struct intel_pcie_soc {
+	unsigned int pcie_ver;
+	unsigned int pcie_atu_offset;
+	u32 num_viewport;
+};
+
+struct intel_pcie_port {
+	struct dw_pcie		pci;
+	void __iomem		*app_base;
+	struct gpio_desc	*reset_gpio;
+	u32			rst_intrvl;
+	u32			max_speed;
+	u32			link_gen;
+	u32			max_width;
+	u32			n_fts;
+	struct clk		*core_clk;
+	struct reset_control	*core_rst;
+	struct phy		*phy;
+	u8			pcie_cap_ofst;
+};
+
+static void pcie_update_bits(void __iomem *base, u32 ofs, u32 mask, u32 val)
+{
+	u32 old;
+
+	old = readl(base + ofs);
+	val = (old & ~mask) | (val & mask);
+
+	if (val != old)
+		writel(val, base + ofs);
+}
+
+static inline u32 pcie_app_rd(struct intel_pcie_port *lpp, u32 ofs)
+{
+	return readl(lpp->app_base + ofs);
+}
+
+static inline void pcie_app_wr(struct intel_pcie_port *lpp, u32 ofs, u32 val)
+{
+	writel(val, lpp->app_base + ofs);
+}
+
+static void pcie_app_wr_mask(struct intel_pcie_port *lpp,
+			     u32 ofs, u32 mask, u32 val)
+{
+	pcie_update_bits(lpp->app_base, ofs, mask, val);
+}
+
+static inline u32 pcie_rc_cfg_rd(struct intel_pcie_port *lpp, u32 ofs)
+{
+	return dw_pcie_readl_dbi(&lpp->pci, ofs);
+}
+
+static inline void pcie_rc_cfg_wr(struct intel_pcie_port *lpp, u32 ofs, u32 val)
+{
+	dw_pcie_writel_dbi(&lpp->pci, ofs, val);
+}
+
+static void pcie_rc_cfg_wr_mask(struct intel_pcie_port *lpp,
+				u32 ofs, u32 mask, u32 val)
+{
+	pcie_update_bits(lpp->pci.dbi_base, ofs, mask, val);
+}
+
+static void intel_pcie_ltssm_enable(struct intel_pcie_port *lpp)
+{
+	pcie_app_wr_mask(lpp, PCIE_APP_CCR, PCIE_APP_CCR_LTSSM_ENABLE,
+			 PCIE_APP_CCR_LTSSM_ENABLE);
+}
+
+static void intel_pcie_ltssm_disable(struct intel_pcie_port *lpp)
+{
+	pcie_app_wr_mask(lpp, PCIE_APP_CCR, PCIE_APP_CCR_LTSSM_ENABLE, 0);
+}
+
+static void intel_pcie_link_setup(struct intel_pcie_port *lpp)
+{
+	u32 val;
+	u8 offset = lpp->pcie_cap_ofst;
+
+	val = pcie_rc_cfg_rd(lpp, offset + PCI_EXP_LNKCAP);
+	lpp->max_speed = FIELD_GET(PCI_EXP_LNKCAP_SLS, val);
+	lpp->max_width = FIELD_GET(PCI_EXP_LNKCAP_MLW, val);
+
+	val = pcie_rc_cfg_rd(lpp, offset + PCI_EXP_LNKCTL);
+
+	val &= ~(PCI_EXP_LNKCTL_LD | PCI_EXP_LNKCTL_ASPMC);
+	pcie_rc_cfg_wr(lpp, offset + PCI_EXP_LNKCTL, val);
+}
+
+static void intel_pcie_port_logic_setup(struct intel_pcie_port *lpp)
+{
+	u32 val, mask;
+
+	switch (pcie_link_speed[lpp->max_speed]) {
+	case PCIE_SPEED_8_0GT:
+		lpp->n_fts = PORT_AFR_N_FTS_GEN3;
+		break;
+	case PCIE_SPEED_16_0GT:
+		lpp->n_fts = PORT_AFR_N_FTS_GEN4;
+		break;
+	default:
+		lpp->n_fts = PORT_AFR_N_FTS_GEN12_DFT;
+		break;
+	}
+
+	mask = PORT_AFR_N_FTS_MASK | PORT_AFR_CC_N_FTS_MASK;
+	val = FIELD_PREP(PORT_AFR_N_FTS_MASK, lpp->n_fts) |
+	       FIELD_PREP(PORT_AFR_CC_N_FTS_MASK, lpp->n_fts);
+	pcie_rc_cfg_wr_mask(lpp, PCIE_PORT_AFR, mask, val);
+
+	/* Port Link Control Register */
+	pcie_rc_cfg_wr_mask(lpp, PCIE_PORT_LINK_CONTROL, PORT_LINK_DLL_LINK_EN,
+			    PORT_LINK_DLL_LINK_EN);
+}
+
+static void intel_pcie_rc_setup(struct intel_pcie_port *lpp)
+{
+	intel_pcie_ltssm_disable(lpp);
+	intel_pcie_link_setup(lpp);
+	dw_pcie_setup_rc(&lpp->pci.pp);
+	dw_pcie_upconfig_setup(&lpp->pci);
+	intel_pcie_port_logic_setup(lpp);
+	dw_pcie_link_set_max_speed(&lpp->pci, lpp->link_gen);
+	dw_pcie_link_set_n_fts(&lpp->pci, lpp->n_fts);
+}
+
+static int intel_pcie_ep_rst_init(struct intel_pcie_port *lpp)
+{
+	struct device *dev = lpp->pci.dev;
+	int ret;
+
+	lpp->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(lpp->reset_gpio)) {
+		ret = PTR_ERR(lpp->reset_gpio);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to request PCIe GPIO: %d\n", ret);
+		return ret;
+	}
+
+	/* Make initial reset last for 100us */
+	usleep_range(100, 200);
+
+	return 0;
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
+	msleep(lpp->rst_intrvl);
+	gpiod_set_value_cansleep(lpp->reset_gpio, 0);
+}
+
+static int intel_pcie_app_logic_setup(struct intel_pcie_port *lpp)
+{
+	intel_pcie_device_rst_deassert(lpp);
+	intel_pcie_ltssm_enable(lpp);
+
+	return dw_pcie_wait_for_link(&lpp->pci);
+}
+
+static void intel_pcie_core_irq_disable(struct intel_pcie_port *lpp)
+{
+	pcie_app_wr(lpp, PCIE_APP_IRNEN, 0);
+	pcie_app_wr(lpp,  PCIE_APP_IRNCR, PCIE_APP_IRN_INT);
+}
+
+static int intel_pcie_get_resources(struct platform_device *pdev)
+{
+	struct intel_pcie_port *lpp = platform_get_drvdata(pdev);
+	struct dw_pcie *pci = &lpp->pci;
+	struct device *dev = pci->dev;
+	struct resource *res;
+	int ret;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
+	pci->dbi_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(pci->dbi_base))
+		return PTR_ERR(pci->dbi_base);
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
+	ret = device_property_read_u32(dev, "reset-assert-ms",
+				       &lpp->rst_intrvl);
+	if (ret)
+		lpp->rst_intrvl = RESET_INTERVAL_MS;
+
+	ret = of_pci_get_max_link_speed(dev->of_node);
+	lpp->link_gen = ret < 0 ? 0 : ret;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "app");
+	lpp->app_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(lpp->app_base))
+		return PTR_ERR(lpp->app_base);
+
+	lpp->phy = devm_phy_get(dev, "pcie");
+	if (IS_ERR(lpp->phy)) {
+		ret = PTR_ERR(lpp->phy);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "couldn't get pcie-phy: %d\n", ret);
+		return ret;
+	}
+
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
+	if (pcie_link_speed[lpp->max_speed] < PCIE_SPEED_8_0GT)
+		return 0;
+
+	/* Send PME_TURN_OFF message */
+	pcie_app_wr_mask(lpp, PCIE_APP_MSG_CR, PCIE_APP_MSG_XMT_PM_TURNOFF,
+			 PCIE_APP_MSG_XMT_PM_TURNOFF);
+
+	/* Read PMC status and wait for falling into L2 link state */
+	ret = readl_poll_timeout(lpp->app_base + PCIE_APP_PMC, value,
+				 value & PCIE_APP_PMC_IN_L2, 20,
+				 jiffies_to_usecs(5 * HZ));
+	if (ret)
+		dev_err(lpp->pci.dev, "PCIe link enter L2 timeout!\n");
+
+	return ret;
+}
+
+static void intel_pcie_turn_off(struct intel_pcie_port *lpp)
+{
+	if (dw_pcie_link_up(&lpp->pci))
+		intel_pcie_wait_l2(lpp);
+
+	/* Put endpoint device in reset state */
+	intel_pcie_device_rst_assert(lpp);
+	pcie_rc_cfg_wr_mask(lpp, PCI_COMMAND, PCI_COMMAND_MEMORY, 0);
+}
+
+static int intel_pcie_host_setup(struct intel_pcie_port *lpp)
+{
+	struct device *dev = lpp->pci.dev;
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
+
+	ret = clk_prepare_enable(lpp->core_clk);
+	if (ret) {
+		dev_err(lpp->pci.dev, "Core clock enable failed: %d\n", ret);
+		goto clk_err;
+	}
+
+	if (!lpp->pcie_cap_ofst) {
+		ret = dw_pcie_find_capability(&lpp->pci, PCI_CAP_ID_EXP);
+		if (!ret) {
+			ret = -ENXIO;
+			dev_err(dev, "Invalid PCIe capability offset\n");
+			goto app_init_err;
+		}
+
+		lpp->pcie_cap_ofst = ret;
+	}
+
+	intel_pcie_rc_setup(lpp);
+	ret = intel_pcie_app_logic_setup(lpp);
+	if (ret)
+		goto app_init_err;
+
+	/* Enable integrated interrupts */
+	pcie_app_wr_mask(lpp, PCIE_APP_IRNEN, PCIE_APP_IRN_INT,
+			PCIE_APP_IRN_INT);
+
+	return 0;
+
+app_init_err:
+	clk_disable_unprepare(lpp->core_clk);
+clk_err:
+	intel_pcie_core_rst_assert(lpp);
+	intel_pcie_deinit_phy(lpp);
+
+	return ret;
+}
+
+static void __intel_pcie_remove(struct intel_pcie_port *lpp)
+{
+	intel_pcie_core_irq_disable(lpp);
+	intel_pcie_turn_off(lpp);
+	clk_disable_unprepare(lpp->core_clk);
+	intel_pcie_core_rst_assert(lpp);
+	intel_pcie_deinit_phy(lpp);
+}
+
+static int intel_pcie_remove(struct platform_device *pdev)
+{
+	struct intel_pcie_port *lpp = platform_get_drvdata(pdev);
+	struct pcie_port *pp = &lpp->pci.pp;
+
+	dw_pcie_host_deinit(pp);
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
+	clk_disable_unprepare(lpp->core_clk);
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
+
+	return intel_pcie_host_setup(lpp);
+}
+
+int intel_pcie_msi_init(struct pcie_port *pp)
+{
+	/* PCIe MSI/MSIx is handled by MSI in x86 processor */
+	return 0;
+}
+
+u64 intel_pcie_cpu_addr(struct dw_pcie *pcie, u64 cpu_addr)
+{
+	return cpu_addr + BUS_IATU_OFFSET;
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
+	const struct intel_pcie_soc *data;
+	struct device *dev = &pdev->dev;
+	struct intel_pcie_port *lpp;
+	struct pcie_port *pp;
+	struct dw_pcie *pci;
+	int ret;
+
+	lpp = devm_kzalloc(dev, sizeof(*lpp), GFP_KERNEL);
+	if (!lpp)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, lpp);
+	pci = &lpp->pci;
+	pci->dev = dev;
+	pp = &pci->pp;
+
+	ret = intel_pcie_get_resources(pdev);
+	if (ret)
+		return ret;
+
+	ret = intel_pcie_ep_rst_init(lpp);
+	if (ret)
+		return ret;
+
+	data = device_get_match_data(dev);
+	if (!data)
+		return -ENODEV;
+
+	pci->ops = &intel_pcie_ops;
+	pci->version = data->pcie_ver;
+	pci->atu_base = pci->dbi_base + data->pcie_atu_offset;
+	pp->ops = &intel_pcie_dw_ops;
+
+	ret = dw_pcie_host_init(pp);
+	if (ret) {
+		dev_err(dev, "cannot initialize host\n");
+		return ret;
+	}
+
+	/*
+	 * Intel PCIe doesn't configure IO region, so set viewport
+	 * to not to perform IO region access.
+	 */
+	pci->num_viewport = data->num_viewport;
+
+	dev_info(dev, "Intel PCIe Root Complex Port init done\n");
+
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
+		.name = "intel-gw-pcie",
+		.of_match_table = of_intel_pcie_match,
+		.pm = &intel_pcie_pm_ops,
+	},
+};
+builtin_platform_driver(intel_pcie_driver);
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 29d6e93fd15e..548e22e07a52 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -673,6 +673,7 @@
 #define  PCI_EXP_LNKCTL2_TLS_8_0GT	0x0003 /* Supported Speed 8GT/s */
 #define  PCI_EXP_LNKCTL2_TLS_16_0GT	0x0004 /* Supported Speed 16GT/s */
 #define  PCI_EXP_LNKCTL2_TLS_32_0GT	0x0005 /* Supported Speed 32GT/s */
+#define  PCI_EXP_LNKCTL2_HASD		0x0020 /* HW Autonomous Speed Disable */
 #define PCI_EXP_LNKSTA2		50	/* Link Status 2 */
 #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	52	/* v2 endpoints with link end here */
 #define PCI_EXP_SLTCAP2		52	/* Slot Capabilities 2 */
-- 
2.11.0

