Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9567B39D647
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jun 2021 09:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhFGHsz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Jun 2021 03:48:55 -0400
Received: from mga06.intel.com ([134.134.136.31]:36928 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230177AbhFGHsy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Jun 2021 03:48:54 -0400
IronPort-SDR: /HCj8lVy4j6Li75zGmkd+VqU9eE2e2re/sS0CXo2TNn52LY7DLSRE2z62revgJjBrLJ4LcVRiX
 st+SbT4hOffA==
X-IronPort-AV: E=McAfee;i="6200,9189,10007"; a="265733148"
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; 
   d="scan'208";a="265733148"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 00:47:03 -0700
IronPort-SDR: zX82IV/ulHHK3q53RAF3MXhVFjDUXqFlYzWpVgqJDGBgXWlnejX8JLP6oEwKRBH5fNDkRxM7Nx
 GYXCnIeoiQMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; 
   d="scan'208";a="401606150"
Received: from intel-z390-ud.iind.intel.com ([10.106.46.146])
  by orsmga003.jf.intel.com with ESMTP; 07 Jun 2021 00:46:59 -0700
From:   srikanth.thokala@intel.com
To:     robh+dt@kernel.org, lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        mallikarjunappa.sangannavar@intel.com, kw@linux.com,
        srikanth.thokala@intel.com
Subject: [PATCH v10 2/2] PCI: keembay: Add support for Intel Keem Bay
Date:   Mon,  7 Jun 2021 21:10:44 +0530
Message-Id: <20210607154044.26074-3-srikanth.thokala@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210607154044.26074-1-srikanth.thokala@intel.com>
References: <20210607154044.26074-1-srikanth.thokala@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Srikanth Thokala <srikanth.thokala@intel.com>

Add driver for Intel Keem Bay SoC PCIe controller. This controller
is based on DesignWare PCIe core.

In Root Complex mode, only internal reference clock is possible for
Keem Bay A0. For Keem Bay B0, external reference clock can be used
and will be the default configuration. Currently, keembay_pcie_of_data
structure has one member. It will be expanded later to handle this
difference.

Endpoint mode link initialization is handled by the boot firmware.

Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Srikanth Thokala <srikanth.thokala@intel.com>
Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
---
 MAINTAINERS                               |   7 +
 drivers/pci/controller/dwc/Kconfig        |  28 ++
 drivers/pci/controller/dwc/Makefile       |   1 +
 drivers/pci/controller/dwc/pcie-keembay.c | 451 ++++++++++++++++++++++
 4 files changed, 487 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-keembay.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b706dd20ff2b..40d1fa0b0a0d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14244,6 +14244,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt
 F:	drivers/pci/controller/dwc/pcie-histb.c
 
+PCIE DRIVER FOR INTEL KEEM BAY
+M:	Srikanth Thokala <srikanth.thokala@intel.com>
+L:	linux-pci@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/pci/intel,keembay-pcie*
+F:	drivers/pci/controller/dwc/pcie-keembay.c
+
 PCIE DRIVER FOR MEDIATEK
 M:	Ryder Lee <ryder.lee@mediatek.com>
 M:	Jianjun Wang <jianjun.wang@mediatek.com>
diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 423d35872ce4..04430ddde8c4 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -225,6 +225,34 @@ config PCIE_INTEL_GW
 	  The PCIe controller uses the DesignWare core plus Intel-specific
 	  hardware wrappers.
 
+config PCIE_KEEMBAY
+	bool
+
+config PCIE_KEEMBAY_HOST
+	bool "Intel Keem Bay PCIe controller - Host mode"
+	depends on ARCH_KEEMBAY || COMPILE_TEST
+	depends on PCI && PCI_MSI_IRQ_DOMAIN
+	select PCIE_DW_HOST
+	select PCIE_KEEMBAY
+	help
+	  Say 'Y' here to enable support for the PCIe controller in Keem Bay
+	  to work in host mode.
+	  The PCIe controller is based on DesignWare Hardware and uses
+	  DesignWare core functions.
+
+config PCIE_KEEMBAY_EP
+	bool "Intel Keem Bay PCIe controller - Endpoint mode"
+	depends on ARCH_KEEMBAY || COMPILE_TEST
+	depends on PCI && PCI_MSI_IRQ_DOMAIN
+	depends on PCI_ENDPOINT
+	select PCIE_DW_EP
+	select PCIE_KEEMBAY
+	help
+	  Say 'Y' here to enable support for the PCIe controller in Keem Bay
+	  to work in endpoint mode.
+	  The PCIe controller is based on DesignWare Hardware and uses
+	  DesignWare core functions.
+
 config PCIE_KIRIN
 	depends on OF && (ARM64 || COMPILE_TEST)
 	bool "HiSilicon Kirin series SoCs PCIe controllers"
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index eca805c1a023..6932292b3f22 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
 obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
 obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
 obj-$(CONFIG_PCIE_INTEL_GW) += pcie-intel-gw.o
+obj-$(CONFIG_PCIE_KEEMBAY) += pcie-keembay.o
 obj-$(CONFIG_PCIE_KIRIN) += pcie-kirin.o
 obj-$(CONFIG_PCIE_HISI_STB) += pcie-histb.o
 obj-$(CONFIG_PCI_MESON) += pci-meson.o
diff --git a/drivers/pci/controller/dwc/pcie-keembay.c b/drivers/pci/controller/dwc/pcie-keembay.c
new file mode 100644
index 000000000000..91ebb461c8a3
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-keembay.c
@@ -0,0 +1,451 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * PCIe controller driver for Intel Keem Bay
+ * Copyright (C) 2020 Intel Corporation
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/init.h>
+#include <linux/iopoll.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+
+#include "pcie-designware.h"
+
+/* PCIE_REGS_APB_SLV Registers */
+#define PCIE_REGS_PCIE_CFG		0x0004
+#define  PCIE_DEVICE_TYPE		BIT(8)
+#define  PCIE_RSTN			BIT(0)
+#define PCIE_REGS_PCIE_APP_CNTRL	0x0008
+#define  APP_LTSSM_ENABLE		BIT(0)
+#define PCIE_REGS_INTERRUPT_ENABLE	0x0028
+#define  MSI_CTRL_INT_EN		BIT(8)
+#define  EDMA_INT_EN			GENMASK(7, 0)
+#define PCIE_REGS_INTERRUPT_STATUS	0x002c
+#define  MSI_CTRL_INT			BIT(8)
+#define PCIE_REGS_PCIE_SII_PM_STATE	0x00b0
+#define  SMLH_LINK_UP			BIT(19)
+#define  RDLH_LINK_UP			BIT(8)
+#define  PCIE_REGS_PCIE_SII_LINK_UP	(SMLH_LINK_UP | RDLH_LINK_UP)
+#define PCIE_REGS_PCIE_PHY_CNTL		0x0164
+#define  PHY0_SRAM_BYPASS		BIT(8)
+#define PCIE_REGS_PCIE_PHY_STAT		0x0168
+#define  PHY0_MPLLA_STATE		BIT(1)
+#define PCIE_REGS_LJPLL_STA		0x016c
+#define  LJPLL_LOCK			BIT(0)
+#define PCIE_REGS_LJPLL_CNTRL_0		0x0170
+#define  LJPLL_EN			BIT(29)
+#define  LJPLL_FOUT_EN			GENMASK(24, 21)
+#define PCIE_REGS_LJPLL_CNTRL_2		0x0178
+#define  LJPLL_REF_DIV			GENMASK(17, 12)
+#define  LJPLL_FB_DIV			GENMASK(11, 0)
+#define PCIE_REGS_LJPLL_CNTRL_3		0x017c
+#define  LJPLL_POST_DIV3A		GENMASK(24, 22)
+#define  LJPLL_POST_DIV2A		GENMASK(18, 16)
+
+#define PERST_DELAY_US		1000
+#define AUX_CLK_RATE_HZ		24000000
+
+struct keembay_pcie {
+	struct dw_pcie		pci;
+	void __iomem		*apb_base;
+	enum dw_pcie_device_mode mode;
+
+	struct clk		*clk_master;
+	struct clk		*clk_aux;
+	struct gpio_desc	*reset;
+};
+
+struct keembay_pcie_of_data {
+	enum dw_pcie_device_mode mode;
+};
+
+static void keembay_ep_reset_assert(struct keembay_pcie *pcie)
+{
+	gpiod_set_value_cansleep(pcie->reset, 1);
+	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
+}
+
+static void keembay_ep_reset_deassert(struct keembay_pcie *pcie)
+{
+	/*
+	 * Ensure that PERST# is asserted for a minimum of 100ms.
+	 *
+	 * For more details, refer to PCI Express Card Electromechanical
+	 * Specification Revision 1.1, Table-2.4.
+	 */
+	msleep(100);
+
+	gpiod_set_value_cansleep(pcie->reset, 0);
+	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
+}
+
+static void keembay_pcie_ltssm_set(struct keembay_pcie *pcie, bool enable)
+{
+	u32 val;
+
+	val = readl(pcie->apb_base + PCIE_REGS_PCIE_APP_CNTRL);
+	if (enable)
+		val |= APP_LTSSM_ENABLE;
+	else
+		val &= ~APP_LTSSM_ENABLE;
+	writel(val, pcie->apb_base + PCIE_REGS_PCIE_APP_CNTRL);
+}
+
+static int keembay_pcie_link_up(struct dw_pcie *pci)
+{
+	struct keembay_pcie *pcie = dev_get_drvdata(pci->dev);
+	u32 val;
+
+	val = readl(pcie->apb_base + PCIE_REGS_PCIE_SII_PM_STATE);
+
+	return (val & PCIE_REGS_PCIE_SII_LINK_UP) == PCIE_REGS_PCIE_SII_LINK_UP;
+}
+
+static int keembay_pcie_start_link(struct dw_pcie *pci)
+{
+	struct keembay_pcie *pcie = dev_get_drvdata(pci->dev);
+	u32 val;
+	int ret;
+
+	if (pcie->mode == DW_PCIE_EP_TYPE)
+		return 0;
+
+	keembay_pcie_ltssm_set(pcie, false);
+
+	ret = readl_poll_timeout(pcie->apb_base + PCIE_REGS_PCIE_PHY_STAT,
+				 val, val & PHY0_MPLLA_STATE, 20,
+				 500 * USEC_PER_MSEC);
+	if (ret) {
+		dev_err(pci->dev, "MPLLA is not locked\n");
+		return ret;
+	}
+
+	keembay_pcie_ltssm_set(pcie, true);
+
+	return 0;
+}
+
+static void keembay_pcie_stop_link(struct dw_pcie *pci)
+{
+	struct keembay_pcie *pcie = dev_get_drvdata(pci->dev);
+
+	keembay_pcie_ltssm_set(pcie, false);
+}
+
+static const struct dw_pcie_ops keembay_pcie_ops = {
+	.link_up	= keembay_pcie_link_up,
+	.start_link	= keembay_pcie_start_link,
+	.stop_link	= keembay_pcie_stop_link,
+};
+
+static inline struct clk *keembay_pcie_probe_clock(struct device *dev,
+						   const char *id, u64 rate)
+{
+	struct clk *clk;
+	int ret;
+
+	clk = devm_clk_get(dev, id);
+	if (IS_ERR(clk))
+		return clk;
+
+	if (rate) {
+		ret = clk_set_rate(clk, rate);
+		if (ret)
+			return ERR_PTR(ret);
+	}
+
+	ret = clk_prepare_enable(clk);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = devm_add_action_or_reset(dev,
+				       (void(*)(void *))clk_disable_unprepare,
+				       clk);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return clk;
+}
+
+static int keembay_pcie_probe_clocks(struct keembay_pcie *pcie)
+{
+	struct dw_pcie *pci = &pcie->pci;
+	struct device *dev = pci->dev;
+
+	pcie->clk_master = keembay_pcie_probe_clock(dev, "master", 0);
+	if (IS_ERR(pcie->clk_master))
+		return dev_err_probe(dev, PTR_ERR(pcie->clk_master),
+				     "Failed to enable master clock");
+
+	pcie->clk_aux = keembay_pcie_probe_clock(dev, "aux", AUX_CLK_RATE_HZ);
+	if (IS_ERR(pcie->clk_aux))
+		return dev_err_probe(dev, PTR_ERR(pcie->clk_aux),
+				     "Failed to enable auxiliary clock");
+
+	return 0;
+}
+
+/*
+ * Initialize the internal PCIe PLL in Host mode.
+ * See the following sections in Keem Bay data book,
+ * (1) 6.4.6.1 PCIe Subsystem Example Initialization,
+ * (2) 6.8 PCIe Low Jitter PLL for Ref Clk Generation.
+ */
+static int keembay_pcie_pll_init(struct keembay_pcie *pcie)
+{
+	struct dw_pcie *pci = &pcie->pci;
+	u32 val;
+	int ret;
+
+	val = FIELD_PREP(LJPLL_REF_DIV, 0) | FIELD_PREP(LJPLL_FB_DIV, 0x32);
+	writel(val, pcie->apb_base + PCIE_REGS_LJPLL_CNTRL_2);
+
+	val = FIELD_PREP(LJPLL_POST_DIV3A, 0x2) |
+		FIELD_PREP(LJPLL_POST_DIV2A, 0x2);
+	writel(val, pcie->apb_base + PCIE_REGS_LJPLL_CNTRL_3);
+
+	val = FIELD_PREP(LJPLL_EN, 0x1) | FIELD_PREP(LJPLL_FOUT_EN, 0xc);
+	writel(val, pcie->apb_base + PCIE_REGS_LJPLL_CNTRL_0);
+
+	ret = readl_poll_timeout(pcie->apb_base + PCIE_REGS_LJPLL_STA,
+				 val, val & LJPLL_LOCK, 20,
+				 500 * USEC_PER_MSEC);
+	if (ret)
+		dev_err(pci->dev, "Low jitter PLL is not locked\n");
+
+	return ret;
+}
+
+static void keembay_pcie_msi_irq_handler(struct irq_desc *desc)
+{
+	struct keembay_pcie *pcie = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	u32 val, mask, status;
+	struct pcie_port *pp;
+
+	chained_irq_enter(chip, desc);
+
+	pp = &pcie->pci.pp;
+	val = readl(pcie->apb_base + PCIE_REGS_INTERRUPT_STATUS);
+	mask = readl(pcie->apb_base + PCIE_REGS_INTERRUPT_ENABLE);
+
+	status = val & mask;
+
+	if (status & MSI_CTRL_INT) {
+		dw_handle_msi_irq(pp);
+		writel(status, pcie->apb_base + PCIE_REGS_INTERRUPT_STATUS);
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static int keembay_pcie_setup_msi_irq(struct keembay_pcie *pcie)
+{
+	struct dw_pcie *pci = &pcie->pci;
+	struct device *dev = pci->dev;
+	struct platform_device *pdev = to_platform_device(dev);
+	int irq;
+
+	irq = platform_get_irq_byname(pdev, "pcie");
+	if (irq < 0)
+		return irq;
+
+	irq_set_chained_handler_and_data(irq, keembay_pcie_msi_irq_handler,
+					 pcie);
+
+	return 0;
+}
+
+static void keembay_pcie_ep_init(struct dw_pcie_ep *ep)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct keembay_pcie *pcie = dev_get_drvdata(pci->dev);
+
+	writel(EDMA_INT_EN, pcie->apb_base + PCIE_REGS_INTERRUPT_ENABLE);
+}
+
+static int keembay_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
+				     enum pci_epc_irq_type type,
+				     u16 interrupt_num)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+
+	switch (type) {
+	case PCI_EPC_IRQ_LEGACY:
+		/* Legacy interrupts are not supported in Keem Bay */
+		dev_err(pci->dev, "Legacy IRQ is not supported\n");
+		return -EINVAL;
+	case PCI_EPC_IRQ_MSI:
+		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
+	case PCI_EPC_IRQ_MSIX:
+		return dw_pcie_ep_raise_msix_irq(ep, func_no, interrupt_num);
+	default:
+		dev_err(pci->dev, "Unknown IRQ type %d\n", type);
+		return -EINVAL;
+	}
+}
+
+static const struct pci_epc_features keembay_pcie_epc_features = {
+	.linkup_notifier	= false,
+	.msi_capable		= true,
+	.msix_capable		= true,
+	.reserved_bar		= BIT(BAR_1) | BIT(BAR_3) | BIT(BAR_5),
+	.bar_fixed_64bit	= BIT(BAR_0) | BIT(BAR_2) | BIT(BAR_4),
+	.align			= SZ_16K,
+};
+
+static const struct pci_epc_features *
+keembay_pcie_get_features(struct dw_pcie_ep *ep)
+{
+	return &keembay_pcie_epc_features;
+}
+
+static const struct dw_pcie_ep_ops keembay_pcie_ep_ops = {
+	.ep_init	= keembay_pcie_ep_init,
+	.raise_irq	= keembay_pcie_ep_raise_irq,
+	.get_features	= keembay_pcie_get_features,
+};
+
+static const struct dw_pcie_host_ops keembay_pcie_host_ops = {
+};
+
+static int keembay_pcie_add_pcie_port(struct keembay_pcie *pcie,
+				      struct platform_device *pdev)
+{
+	struct dw_pcie *pci = &pcie->pci;
+	struct pcie_port *pp = &pci->pp;
+	struct device *dev = &pdev->dev;
+	u32 val;
+	int ret;
+
+	pp->ops = &keembay_pcie_host_ops;
+	pp->msi_irq = -ENODEV;
+
+	ret = keembay_pcie_setup_msi_irq(pcie);
+	if (ret)
+		return ret;
+
+	pcie->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(pcie->reset))
+		return PTR_ERR(pcie->reset);
+
+	ret = keembay_pcie_probe_clocks(pcie);
+	if (ret)
+		return ret;
+
+	val = readl(pcie->apb_base + PCIE_REGS_PCIE_PHY_CNTL);
+	val |= PHY0_SRAM_BYPASS;
+	writel(val, pcie->apb_base + PCIE_REGS_PCIE_PHY_CNTL);
+
+	writel(PCIE_DEVICE_TYPE, pcie->apb_base + PCIE_REGS_PCIE_CFG);
+
+	ret = keembay_pcie_pll_init(pcie);
+	if (ret)
+		return ret;
+
+	val = readl(pcie->apb_base + PCIE_REGS_PCIE_CFG);
+	writel(val | PCIE_RSTN, pcie->apb_base + PCIE_REGS_PCIE_CFG);
+	keembay_ep_reset_deassert(pcie);
+
+	ret = dw_pcie_host_init(pp);
+	if (ret) {
+		keembay_ep_reset_assert(pcie);
+		dev_err(dev, "Failed to initialize host: %d\n", ret);
+		return ret;
+	}
+
+	val = readl(pcie->apb_base + PCIE_REGS_INTERRUPT_ENABLE);
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		val |= MSI_CTRL_INT_EN;
+	writel(val, pcie->apb_base + PCIE_REGS_INTERRUPT_ENABLE);
+
+	return 0;
+}
+
+static int keembay_pcie_probe(struct platform_device *pdev)
+{
+	const struct keembay_pcie_of_data *data;
+	struct device *dev = &pdev->dev;
+	struct keembay_pcie *pcie;
+	struct dw_pcie *pci;
+	enum dw_pcie_device_mode mode;
+
+	data = device_get_match_data(dev);
+	if (!data)
+		return -ENODEV;
+
+	mode = (enum dw_pcie_device_mode)data->mode;
+
+	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+
+	pci = &pcie->pci;
+	pci->dev = dev;
+	pci->ops = &keembay_pcie_ops;
+
+	pcie->mode = mode;
+
+	pcie->apb_base = devm_platform_ioremap_resource_byname(pdev, "apb");
+	if (IS_ERR(pcie->apb_base))
+		return PTR_ERR(pcie->apb_base);
+
+	platform_set_drvdata(pdev, pcie);
+
+	switch (pcie->mode) {
+	case DW_PCIE_RC_TYPE:
+		if (!IS_ENABLED(CONFIG_PCIE_KEEMBAY_HOST))
+			return -ENODEV;
+
+		return keembay_pcie_add_pcie_port(pcie, pdev);
+	case DW_PCIE_EP_TYPE:
+		if (!IS_ENABLED(CONFIG_PCIE_KEEMBAY_EP))
+			return -ENODEV;
+
+		pci->ep.ops = &keembay_pcie_ep_ops;
+		return dw_pcie_ep_init(&pci->ep);
+	default:
+		dev_err(dev, "Invalid device type %d\n", pcie->mode);
+		return -ENODEV;
+	}
+}
+
+static const struct keembay_pcie_of_data keembay_pcie_rc_of_data = {
+	.mode = DW_PCIE_RC_TYPE,
+};
+
+static const struct keembay_pcie_of_data keembay_pcie_ep_of_data = {
+	.mode = DW_PCIE_EP_TYPE,
+};
+
+static const struct of_device_id keembay_pcie_of_match[] = {
+	{
+		.compatible = "intel,keembay-pcie",
+		.data = &keembay_pcie_rc_of_data,
+	},
+	{
+		.compatible = "intel,keembay-pcie-ep",
+		.data = &keembay_pcie_ep_of_data,
+	},
+	{}
+};
+
+static struct platform_driver keembay_pcie_driver = {
+	.driver = {
+		.name = "keembay-pcie",
+		.of_match_table = keembay_pcie_of_match,
+		.suppress_bind_attrs = true,
+	},
+	.probe  = keembay_pcie_probe,
+};
+builtin_platform_driver(keembay_pcie_driver);
-- 
2.17.1

