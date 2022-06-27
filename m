Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB33555C5F7
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 14:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240710AbiF0MYh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jun 2022 08:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240698AbiF0MYe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jun 2022 08:24:34 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F0658BF5D;
        Mon, 27 Jun 2022 05:24:31 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.92,226,1650898800"; 
   d="scan'208";a="125807844"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 27 Jun 2022 21:24:29 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9F0C34290415;
        Mon, 27 Jun 2022 21:24:29 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, krzk+dt@kernel.org, geert+renesas@glider.be,
        magnus.damm@gmail.com
Cc:     marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2 09/13] PCI: renesas: Add R-Car Gen4 PCIe Host support
Date:   Mon, 27 Jun 2022 21:24:13 +0900
Message-Id: <20220627122417.809615-10-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220627122417.809615-1-yoshihiro.shimoda.uh@renesas.com>
References: <20220627122417.809615-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add R-Car Gen4 PCIe Host support. This controller is based on
Synopsys DesignWare PCIe.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pci/controller/dwc/Kconfig            |   9 +
 drivers/pci/controller/dwc/Makefile           |   2 +
 .../pci/controller/dwc/pcie-rcar-gen4-host.c  | 205 ++++++++++++++++++
 drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 172 +++++++++++++++
 drivers/pci/controller/dwc/pcie-rcar-gen4.h   |  63 ++++++
 5 files changed, 451 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.c
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.h

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 62ce3abf0f19..bee273968720 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -384,4 +384,13 @@ config PCIE_FU740
 	  Say Y here if you want PCIe controller support for the SiFive
 	  FU740.
 
+config PCIE_RCAR_GEN4
+	tristate "Renesas R-Car Gen4 PCIe Host controller"
+	depends on ARCH_RENESAS || COMPILE_TEST
+	depends on PCI_MSI_IRQ_DOMAIN
+	select PCIE_DW_HOST
+	help
+	  Say Y here if you want PCIe host controller support on R-Car Gen4 SoCs.
+	  This uses the DesignWare core.
+
 endmenu
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index 8ba7b67f5e50..108fcbc61d9b 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -25,6 +25,8 @@ obj-$(CONFIG_PCIE_TEGRA194) += pcie-tegra194.o
 obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
 obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
 obj-$(CONFIG_PCIE_VISCONTI_HOST) += pcie-visconti.o
+pcie-rcar-gen4-host-drv-objs := pcie-rcar-gen4.o pcie-rcar-gen4-host.o
+obj-$(CONFIG_PCIE_RCAR_GEN4) += pcie-rcar-gen4-host-drv.o
 
 # The following drivers are for devices that use the generic ACPI
 # pci_root.c driver but don't support standard ECAM config access.
diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4-host.c b/drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
new file mode 100644
index 000000000000..7c81973956d0
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCIe host controller driver for Renesas R-Car Gen4 Series SoCs
+ * Copyright (C) 2022 Renesas Electronics Corporation
+ */
+
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+
+#include "pcie-rcar-gen4.h"
+#include "pcie-designware.h"
+
+static int rcar_gen4_pcie_host_init(struct pcie_port *pp)
+{
+	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
+	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
+	int ret;
+	u32 val;
+
+	rcar_gen4_pcie_set_device_type(rcar, true, dw->num_lanes);
+
+	dw_pcie_dbi_ro_wr_en(dw);
+
+	/* Enable L1 Substates */
+	val = dw_pcie_readl_dbi(dw, L1PSCAP(PCI_L1SS_CTL1));
+	val &= ~PCI_L1SS_CTL1_L1SS_MASK;
+	val |= PCI_L1SS_CTL1_PCIPM_L1_2 | PCI_L1SS_CTL1_PCIPM_L1_1 |
+	       PCI_L1SS_CTL1_ASPM_L1_2 | PCI_L1SS_CTL1_ASPM_L1_1;
+	dw_pcie_writel_dbi(dw, L1PSCAP(PCI_L1SS_CTL1), val);
+
+	rcar_gen4_pcie_disable_bar(dw, BAR0MASKF);
+	rcar_gen4_pcie_disable_bar(dw, BAR1MASKF);
+
+	/* Set Root Control */
+	val = dw_pcie_readl_dbi(dw, EXPCAP(PCI_EXP_RTCTL));
+	val |= PCI_EXP_RTCTL_SECEE | PCI_EXP_RTCTL_SENFEE |
+	       PCI_EXP_RTCTL_SEFEE | PCI_EXP_RTCTL_PMEIE |
+	       PCI_EXP_RTCTL_CRSSVE;
+	dw_pcie_writel_dbi(dw, EXPCAP(PCI_EXP_RTCTL), val);
+
+	/* Set Interrupt Disable, SERR# Enable, Parity Error Response */
+	val = dw_pcie_readl_dbi(dw, PCI_COMMAND);
+	val |= PCI_COMMAND_PARITY | PCI_COMMAND_SERR |
+	       PCI_COMMAND_INTX_DISABLE;
+	dw_pcie_writel_dbi(dw, PCI_COMMAND, val);
+
+	/* Enable SERR */
+	val = dw_pcie_readb_dbi(dw, PCI_BRIDGE_CONTROL);
+	val |= PCI_BRIDGE_CTL_SERR;
+	dw_pcie_writeb_dbi(dw, PCI_BRIDGE_CONTROL, val);
+
+	/* Device control */
+	val = dw_pcie_readl_dbi(dw, EXPCAP(PCI_EXP_DEVCTL));
+	val |= PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE |
+	       PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE;
+	dw_pcie_writel_dbi(dw, EXPCAP(PCI_EXP_DEVCTL), val);
+
+	dw_pcie_dbi_ro_wr_dis(dw);
+
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		/* Enable MSI interrupt signal */
+		val = rcar_gen4_pcie_readl(rcar, PCIEINTSTS0EN);
+		val |= MSI_CTRL_INT;
+		rcar_gen4_pcie_writel(rcar, PCIEINTSTS0EN, val);
+	}
+
+	dw_pcie_setup_rc(pp);
+
+	dw_pcie_dbi_ro_wr_en(dw);
+	rcar_gen4_pcie_set_max_link_width(dw, dw->num_lanes);
+	dw_pcie_dbi_ro_wr_dis(dw);
+
+	if (!dw_pcie_link_up(dw)) {
+		ret = dw->ops->start_link(dw);
+		if (ret)
+			return ret;
+	}
+
+	/* Ignore errors, the link may come up later */
+	if (dw_pcie_wait_for_link(dw))
+		dev_info(dw->dev, "PCIe link down\n");
+
+	return 0;
+}
+
+static const struct dw_pcie_host_ops rcar_gen4_pcie_host_ops = {
+	.host_init = rcar_gen4_pcie_host_init,
+};
+
+static int rcar_gen4_add_pcie_port(struct rcar_gen4_pcie *rcar,
+				   struct platform_device *pdev)
+{
+	struct dw_pcie *dw = &rcar->dw;
+	struct pcie_port *pp = &dw->pp;
+	int ret;
+
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		pp->msi_irq = platform_get_irq_byname(pdev, "others");
+		if (pp->msi_irq < 0)
+			return pp->msi_irq;
+	}
+
+	pp->ops = &rcar_gen4_pcie_host_ops;
+
+	ret = dw_pcie_host_init(pp);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to initialize host\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void rcar_gen4_remove_pcie_port(struct rcar_gen4_pcie *rcar)
+{
+	dw_pcie_host_deinit(&rcar->dw.pp);
+}
+
+static int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar,
+					struct platform_device *pdev)
+{
+	struct dw_pcie *dw = &rcar->dw;
+
+	/* Renesas-specific registers */
+	rcar->base = devm_platform_ioremap_resource_byname(pdev, "app");
+	if (IS_ERR(rcar->base))
+		return PTR_ERR(rcar->base);
+
+	return rcar_gen4_pcie_devm_reset_get(rcar, dw->dev);
+}
+
+static int rcar_gen4_pcie_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct rcar_gen4_pcie *rcar;
+	int err;
+
+	rcar = rcar_gen4_pcie_devm_alloc(dev);
+	if (!rcar)
+		return -ENOMEM;
+
+	err = rcar_gen4_pcie_pm_runtime_enable(dev);
+	if (err < 0) {
+		dev_err(dev, "pm_runtime_get_sync failed\n");
+		return err;
+	}
+
+	err = rcar_gen4_pcie_get_resources(rcar, pdev);
+	if (err < 0) {
+		dev_err(dev, "failed to request resource: %d\n", err);
+		goto err_pm_put;
+	}
+
+	platform_set_drvdata(pdev, rcar);
+
+	err = rcar_gen4_pcie_prepare(rcar);
+	if (err < 0)
+		goto err_pm_put;
+
+	err = rcar_gen4_add_pcie_port(rcar, pdev);
+	if (err < 0)
+		goto err_host_disable;
+
+	return 0;
+
+err_host_disable:
+	rcar_gen4_pcie_unprepare(rcar);
+
+err_pm_put:
+	rcar_gen4_pcie_pm_runtime_disable(dev);
+
+	return err;
+}
+
+static int rcar_gen4_pcie_remove(struct platform_device *pdev)
+{
+	struct rcar_gen4_pcie *rcar = platform_get_drvdata(pdev);
+
+	rcar_gen4_remove_pcie_port(rcar);
+	rcar_gen4_pcie_unprepare(rcar);
+	rcar_gen4_pcie_pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
+static const struct of_device_id rcar_gen4_pcie_of_match[] = {
+	{ .compatible = "renesas,rcar-gen4-pcie", },
+	{},
+};
+
+static struct platform_driver rcar_gen4_pcie_driver = {
+	.driver = {
+		.name = "pcie-rcar-gen4",
+		.of_match_table = rcar_gen4_pcie_of_match,
+	},
+	.probe = rcar_gen4_pcie_probe,
+	.remove = rcar_gen4_pcie_remove,
+};
+module_platform_driver(rcar_gen4_pcie_driver);
+
+MODULE_DESCRIPTION("Renesas R-Car Gen4 PCIe host controller driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
new file mode 100644
index 000000000000..fa9588ed75e0
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCIe host/endpoint controller driver for Renesas R-Car Gen4 Series SoCs
+ * Copyright (C) 2022 Renesas Electronics Corporation
+ */
+
+#include <linux/io.h>
+#include <linux/of_device.h>
+#include <linux/pci.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+
+#include "pcie-rcar-gen4.h"
+#include "pcie-designware.h"
+
+/* Renesas-specific */
+#define PCIERSTCTRL1		0x0014
+#define  APP_HOLD_PHY_RST	BIT(16)
+#define  APP_LTSSM_ENABLE	BIT(0)
+
+#define DWC_VERSION		0x520a
+
+u32 rcar_gen4_pcie_readl(struct rcar_gen4_pcie *rcar, u32 reg)
+{
+	return readl(rcar->base + reg);
+}
+
+void rcar_gen4_pcie_writel(struct rcar_gen4_pcie *rcar, u32 reg, u32 val)
+{
+	writel(val, rcar->base + reg);
+}
+
+static void rcar_gen4_pcie_ltssm_enable(struct rcar_gen4_pcie *rcar,
+					bool enable)
+{
+	u32 val;
+
+	val = rcar_gen4_pcie_readl(rcar, PCIERSTCTRL1);
+	if (enable) {
+		val |= APP_LTSSM_ENABLE;
+		val &= ~APP_HOLD_PHY_RST;
+	} else {
+		val &= ~APP_LTSSM_ENABLE;
+		val |= APP_HOLD_PHY_RST;
+	}
+	rcar_gen4_pcie_writel(rcar, PCIERSTCTRL1, val);
+}
+
+static int rcar_gen4_pcie_link_up(struct dw_pcie *dw)
+{
+	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
+	u32 val, mask;
+
+	val = rcar_gen4_pcie_readl(rcar, PCIEINTSTS0);
+	mask = RDLH_LINK_UP | SMLH_LINK_UP;
+
+	return (val & mask) == mask;
+}
+
+static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
+{
+	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
+
+	rcar_gen4_pcie_ltssm_enable(rcar, true);
+
+	return 0;
+}
+
+static void rcar_gen4_pcie_stop_link(struct dw_pcie *dw)
+{
+	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
+
+	rcar_gen4_pcie_ltssm_enable(rcar, false);
+}
+
+void rcar_gen4_pcie_set_device_type(struct rcar_gen4_pcie *rcar, bool rc,
+				    int num_lanes)
+{
+	u32 val;
+
+	val = rcar_gen4_pcie_readl(rcar, PCIEMSR0);
+	if (rc)
+		val |= DEVICE_TYPE_RC;
+	else
+		val |= DEVICE_TYPE_EP;
+	if (num_lanes < 4)
+		val |= BIFUR_MOD_SET_ON;
+	rcar_gen4_pcie_writel(rcar, PCIEMSR0, val);
+}
+
+void rcar_gen4_pcie_disable_bar(struct dw_pcie *dw, u32 bar_mask_reg)
+{
+	dw_pcie_writel_dbi(dw, SHADOW_REG(bar_mask_reg), 0x0);
+}
+
+void rcar_gen4_pcie_set_max_link_width(struct dw_pcie *dw, int num_lanes)
+{
+	u32 val = dw_pcie_readl_dbi(dw, EXPCAP(PCI_EXP_LNKCAP));
+
+	val &= ~PCI_EXP_LNKCAP_MLW;
+	switch (num_lanes) {
+	case 1:
+		val |= PCI_EXP_LNKCAP_MLW_X1;
+		break;
+	case 2:
+		val |= PCI_EXP_LNKCAP_MLW_X2;
+		break;
+	case 4:
+		val |= PCI_EXP_LNKCAP_MLW_X4;
+		break;
+	default:
+		dev_info(dw->dev, "invalid num-lanes %d\n", num_lanes);
+		val |= PCI_EXP_LNKCAP_MLW_X1;
+		break;
+	}
+	dw_pcie_writel_dbi(dw, EXPCAP(PCI_EXP_LNKCAP), val);
+}
+
+int rcar_gen4_pcie_prepare(struct rcar_gen4_pcie *rcar)
+{
+	return reset_control_deassert(rcar->rst);
+}
+
+void rcar_gen4_pcie_unprepare(struct rcar_gen4_pcie *rcar)
+{
+	reset_control_assert(rcar->rst);
+}
+
+int rcar_gen4_pcie_pm_runtime_enable(struct device *dev)
+{
+	pm_runtime_enable(dev);
+	return pm_runtime_get_sync(dev);
+}
+
+void rcar_gen4_pcie_pm_runtime_disable(struct device *dev)
+{
+	pm_runtime_put(dev);
+	pm_runtime_disable(dev);
+}
+
+int rcar_gen4_pcie_devm_reset_get(struct rcar_gen4_pcie *rcar,
+				  struct device *dev)
+{
+	rcar->rst = devm_reset_control_get(dev, NULL);
+	if (IS_ERR(rcar->rst)) {
+		dev_err(dev, "failed to get Cold-reset\n");
+		return PTR_ERR(rcar->rst);
+	}
+
+	return 0;
+}
+
+static const struct dw_pcie_ops dw_pcie_ops = {
+	.start_link = rcar_gen4_pcie_start_link,
+	.stop_link = rcar_gen4_pcie_stop_link,
+	.link_up = rcar_gen4_pcie_link_up,
+};
+
+struct rcar_gen4_pcie *rcar_gen4_pcie_devm_alloc(struct device *dev)
+{
+	struct rcar_gen4_pcie *rcar;
+
+	rcar = devm_kzalloc(dev, sizeof(*rcar), GFP_KERNEL);
+	if (!rcar)
+		return NULL;
+
+	rcar->dw.dev = dev;
+	rcar->dw.ops = &dw_pcie_ops;
+	rcar->dw.version = DWC_VERSION;
+
+	return rcar;
+}
diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.h b/drivers/pci/controller/dwc/pcie-rcar-gen4.h
new file mode 100644
index 000000000000..638f536d364f
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * PCIe host/endpoint controller driver for Renesas R-Car Gen4 Series SoCs
+ * Copyright (C) 2022 Renesas Electronics Corporation
+ */
+
+#ifndef _PCIE_RCAR_GEN4_H_
+#define _PCIE_RCAR_GEN4_H_
+
+#include <linux/io.h>
+#include <linux/pci.h>
+#include <linux/reset.h>
+
+#include "pcie-designware.h"
+
+/* PCI Express capability */
+#define EXPCAP(x)		(0x0070 + (x))
+/* ASPM L1 PM Substates */
+#define L1PSCAP(x)		(0x01bc + (x))
+/* PCI Shadow offset */
+#define SHADOW_REG(x)		(0x2000 + (x))
+/* BAR Mask registers */
+#define BAR0MASKF		0x0010
+#define BAR1MASKF		0x0014
+#define BAR2MASKF		0x0018
+#define BAR3MASKF		0x001c
+#define BAR4MASKF		0x0020
+#define BAR5MASKF		0x0024
+
+/* Renesas-specific */
+#define PCIEMSR0		0x0000
+#define  BIFUR_MOD_SET_ON	BIT(0)
+#define  DEVICE_TYPE_EP		0
+#define  DEVICE_TYPE_RC		BIT(4)
+
+#define PCIEINTSTS0		0x0084
+#define PCIEINTSTS0EN		0x0310
+#define  MSI_CTRL_INT		BIT(26)
+#define  SMLH_LINK_UP		BIT(7)
+#define  RDLH_LINK_UP		BIT(6)
+
+struct rcar_gen4_pcie {
+	struct dw_pcie		dw;
+	void __iomem		*base;
+	struct reset_control	*rst;
+};
+#define to_rcar_gen4_pcie(x)	dev_get_drvdata((x)->dev)
+
+u32 rcar_gen4_pcie_readl(struct rcar_gen4_pcie *pcie, u32 reg);
+void rcar_gen4_pcie_writel(struct rcar_gen4_pcie *pcie, u32 reg, u32 val);
+void rcar_gen4_pcie_set_device_type(struct rcar_gen4_pcie *rcar, bool rc,
+				    int num_lanes);
+void rcar_gen4_pcie_disable_bar(struct dw_pcie *dw, u32 bar_mask_reg);
+void rcar_gen4_pcie_set_max_link_width(struct dw_pcie *pci, int num_lanes);
+int rcar_gen4_pcie_prepare(struct rcar_gen4_pcie *pcie);
+void rcar_gen4_pcie_unprepare(struct rcar_gen4_pcie *pcie);
+int rcar_gen4_pcie_pm_runtime_enable(struct device *dev);
+void rcar_gen4_pcie_pm_runtime_disable(struct device *dev);
+int rcar_gen4_pcie_devm_reset_get(struct rcar_gen4_pcie *pcie,
+				  struct device *dev);
+struct rcar_gen4_pcie *rcar_gen4_pcie_devm_alloc(struct device *dev);
+
+#endif /* _PCIE_RCAR_GEN4_H_ */
-- 
2.25.1

