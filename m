Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F755498C3
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jun 2022 18:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356375AbiFMO4T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 10:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386390AbiFMOzz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 10:55:55 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49C35D2473;
        Mon, 13 Jun 2022 04:57:54 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.91,297,1647270000"; 
   d="scan'208";a="122758907"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 13 Jun 2022 20:57:22 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 31EDB422104E;
        Mon, 13 Jun 2022 20:57:22 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, krzk+dt@kernel.org, geert+renesas@glider.be,
        magnus.damm@gmail.com
Cc:     marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 3/7] PCI: renesas: Add R-Car Gen4 PCIe Host support
Date:   Mon, 13 Jun 2022 20:57:08 +0900
Message-Id: <20220613115712.2831386-4-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220613115712.2831386-1-yoshihiro.shimoda.uh@renesas.com>
References: <20220613115712.2831386-1-yoshihiro.shimoda.uh@renesas.com>
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
Synopsys Designware PCIe.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pci/controller/dwc/Kconfig            |   9 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 .../pci/controller/dwc/pcie-rcar-gen4-host.c  | 235 ++++++++++++++++++
 drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 198 +++++++++++++++
 drivers/pci/controller/dwc/pcie-rcar-gen4.h   |  59 +++++
 5 files changed, 502 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.c
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.h

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 62ce3abf0f19..3ddccc9c38c5 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -384,4 +384,13 @@ config PCIE_FU740
 	  Say Y here if you want PCIe controller support for the SiFive
 	  FU740.
 
+config PCIE_RCAR_GEN4
+	bool "Renesas R-Car Gen4 PCIe Host controller"
+	depends on ARCH_RENESAS || COMPILE_TEST
+	depends on PCI_MSI_IRQ_DOMAIN
+	select PCIE_DW_HOST
+	help
+	  Say Y here if you want PCIe host controller support on R-Car Gen4 SoCs.
+	  This uses the DesignWare core.
+
 endmenu
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index 8ba7b67f5e50..b3f285e685f9 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_PCIE_TEGRA194) += pcie-tegra194.o
 obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
 obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
 obj-$(CONFIG_PCIE_VISCONTI_HOST) += pcie-visconti.o
+obj-$(CONFIG_PCIE_RCAR_GEN4) += pcie-rcar-gen4.o pcie-rcar-gen4-host.o
 
 # The following drivers are for devices that use the generic ACPI
 # pci_root.c driver but don't support standard ECAM config access.
diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4-host.c b/drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
new file mode 100644
index 000000000000..788cd0206528
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
@@ -0,0 +1,235 @@
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
+/* ASPM L1 PM Substates */
+#define L1PSCAP(x)		(0x01bc + (x))
+
+static int rcar_gen4_pcie_host_init(struct pcie_port *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	int ret;
+
+	dw_pcie_setup_rc(pp);
+
+	dw_pcie_dbi_ro_wr_en(pci);
+
+	/* Set Max Link Width */
+	rcar_gen4_pcie_set_max_link_width(pci, pci->num_lanes);
+
+	dw_pcie_dbi_ro_wr_dis(pci);
+
+	if (!dw_pcie_link_up(pci)) {
+		ret = pci->ops->start_link(pci);
+		if (ret)
+			return ret;
+	}
+
+	/* Ignore errors, the link may come up later */
+	if (dw_pcie_wait_for_link(pci))
+		dev_info(pci->dev, "PCIe link down\n");
+
+	return 0;
+}
+
+static const struct dw_pcie_host_ops rcar_gen4_pcie_host_ops = {
+	.host_init = rcar_gen4_pcie_host_init,
+};
+
+static int rcar_gen4_add_pcie_port(struct rcar_gen4_pcie *pcie,
+				   struct platform_device *pdev)
+{
+	struct dw_pcie *pci = pcie->pci;
+	struct pcie_port *pp = &pci->pp;
+	u32 val;
+	int ret;
+
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		pp->msi_irq = platform_get_irq_byname(pdev, "msi");
+		if (pp->msi_irq < 0)
+			return pp->msi_irq;
+
+		/* Enable MSI interrupt signal */
+		val = rcar_gen4_pcie_readl(pcie, PCIEINTSTS0EN);
+		val |= MSI_CTRL_INT;
+		rcar_gen4_pcie_writel(pcie, PCIEINTSTS0EN, val);
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
+static void rcar_gen4_remove_pcie_port(struct rcar_gen4_pcie *pcie)
+{
+	dw_pcie_host_deinit(&pcie->pci->pp);
+}
+
+static void rcar_gen4_pcie_init_rc(struct rcar_gen4_pcie *pcie, u32 num_lanes)
+{
+	struct dw_pcie *pci = pcie->pci;
+	int val;
+
+	/* Device type selection - Root Complex */
+	val = rcar_gen4_pcie_readl(pcie, PCIEMSR0);
+	val |= DEVICE_TYPE_RC;
+	if (num_lanes < 4)
+		val |= BIFUR_MOD_SET_ON;
+	rcar_gen4_pcie_writel(pcie, PCIEMSR0, val);
+
+	dw_pcie_dbi_ro_wr_en(pci);
+
+	/* Enable L1 Substates */
+	val = dw_pcie_readl_dbi(pci, L1PSCAP(PCI_L1SS_CTL1));
+	val &= ~PCI_L1SS_CTL1_L1SS_MASK;
+	val |= PCI_L1SS_CTL1_PCIPM_L1_2 | PCI_L1SS_CTL1_PCIPM_L1_1 |
+	       PCI_L1SS_CTL1_ASPM_L1_2 | PCI_L1SS_CTL1_ASPM_L1_1;
+	dw_pcie_writel_dbi(pci, L1PSCAP(PCI_L1SS_CTL1), val);
+
+	/* Disable BARs */
+	dw_pcie_writel_dbi(pci, SHADOW_REG(BAR0MASKF), 0x0);
+	dw_pcie_writel_dbi(pci, SHADOW_REG(BAR1MASKF), 0x0);
+
+	/* Set Root Control */
+	val = dw_pcie_readl_dbi(pci, EXPCAP(PCI_EXP_RTCTL));
+	val |= PCI_EXP_RTCTL_SECEE | PCI_EXP_RTCTL_SENFEE |
+	       PCI_EXP_RTCTL_SEFEE | PCI_EXP_RTCTL_PMEIE |
+	       PCI_EXP_RTCTL_CRSSVE;
+	dw_pcie_writel_dbi(pci, EXPCAP(PCI_EXP_RTCTL), val);
+
+	/* Set Interrupt Disable, SERR# Enable, Parity Error Response */
+	val = dw_pcie_readl_dbi(pci, PCI_COMMAND);
+	val |= PCI_COMMAND_PARITY | PCI_COMMAND_SERR |
+	       PCI_COMMAND_INTX_DISABLE;
+	dw_pcie_writel_dbi(pci, PCI_COMMAND, val);
+
+	/* Enable SERR */
+	val = dw_pcie_readb_dbi(pci, PCI_BRIDGE_CONTROL);
+	val |= PCI_BRIDGE_CTL_SERR;
+	dw_pcie_writeb_dbi(pci, PCI_BRIDGE_CONTROL, val);
+
+	/* Device control */
+	val = dw_pcie_readl_dbi(pci, EXPCAP(PCI_EXP_DEVCTL));
+	val |= PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE |
+	       PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE;
+	dw_pcie_writel_dbi(pci, EXPCAP(PCI_EXP_DEVCTL), val);
+
+	dw_pcie_dbi_ro_wr_dis(pci);
+}
+
+static int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *pcie,
+					struct platform_device *pdev)
+{
+	struct dw_pcie *pci = pcie->pci;
+	struct resource *res;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
+	pci->dbi_base = devm_pci_remap_cfg_resource(pci->dev, res);
+	if (IS_ERR(pci->dbi_base))
+		return PTR_ERR(pci->dbi_base);
+
+	/* Renesas-specific registers */
+	pcie->base = devm_platform_ioremap_resource_byname(pdev, "app");
+	if (IS_ERR(pcie->base))
+		return PTR_ERR(pcie->base);
+
+	return rcar_gen4_pcie_devm_clk_and_reset_get(pcie, pci->dev);
+}
+
+static int rcar_gen4_pcie_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct rcar_gen4_pcie *pcie;
+	struct device_node *np = dev->of_node;
+	int err;
+	u32 num_lanes;
+
+	pcie = rcar_gen4_pcie_devm_alloc(dev);
+	if (!pcie)
+		return -ENOMEM;
+
+	err = rcar_gen4_pcie_pm_runtime_enable(dev);
+	if (err < 0) {
+		dev_err(dev, "pm_runtime_get_sync failed\n");
+		return err;
+	}
+
+	err = rcar_gen4_pcie_get_resources(pcie, pdev);
+	if (err < 0) {
+		dev_err(dev, "failed to request resource: %d\n", err);
+		goto err_pm_put;
+	}
+
+	err = of_property_read_u32(np, "num-lanes", &num_lanes);
+	if (err < 0) {
+		dev_err(dev, "num-lanes not found %d\n", err);
+		goto err_pm_put;
+	}
+
+	platform_set_drvdata(pdev, pcie);
+
+	err = rcar_gen4_pcie_prepare(pcie);
+	if (err < 0)
+		goto err_pm_put;
+	rcar_gen4_pcie_init_rc(pcie, num_lanes);
+
+	err = rcar_gen4_add_pcie_port(pcie, pdev);
+	if (err < 0)
+		goto err_host_disable;
+
+	return 0;
+
+err_host_disable:
+	rcar_gen4_pcie_unprepare(pcie);
+
+err_pm_put:
+	rcar_gen4_pcie_pm_runtime_disable(dev);
+
+	return err;
+}
+
+static int rcar_gen4_pcie_remove(struct platform_device *pdev)
+{
+	struct rcar_gen4_pcie *pcie = platform_get_drvdata(pdev);
+
+	rcar_gen4_remove_pcie_port(pcie);
+	rcar_gen4_pcie_unprepare(pcie);
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
+builtin_platform_driver(rcar_gen4_pcie_driver);
+
+MODULE_DESCRIPTION("Renesas R-Car Gen4 PCIe host controller driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
new file mode 100644
index 000000000000..48c3fc0b5e67
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCIe host/endpoint controller driver for Renesas R-Car Gen4 Series SoCs
+ * Copyright (C) 2022 Renesas Electronics Corporation
+ */
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/of_device.h>
+#include <linux/pci.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+
+#include "pcie-rcar-gen4.h"
+#include "pcie-designware.h"
+
+/* Link Capabilities - Maximum Link Width */
+#define  PCI_EXP_LNKCAP_MLW_X1	BIT(4)
+#define  PCI_EXP_LNKCAP_MLW_X2	BIT(5)
+#define  PCI_EXP_LNKCAP_MLW_X4	BIT(6)
+
+/* ASPM L1 PM Substates */
+#define L1PSCAP(x)		(0x01bc + (x))
+
+/* Renesas-specific */
+#define PCIEMSR0		0x0000
+#define	 BIFUR_MOD_SET_ON	(0x1 << 0)
+#define  DEVICE_TYPE_RC		(0x4 << 2)
+
+#define PCIERSTCTRL1		0x0014
+#define  APP_HOLD_PHY_RST	BIT(16)
+#define  APP_LTSSM_ENABLE	BIT(0)
+
+#define DWC_VERSION		0x520a
+
+#define to_rcar_gen4_pcie(x)	dev_get_drvdata((x)->dev)
+
+u32 rcar_gen4_pcie_readl(struct rcar_gen4_pcie *pcie, u32 reg)
+{
+	return readl(pcie->base + reg);
+}
+
+void rcar_gen4_pcie_writel(struct rcar_gen4_pcie *pcie, u32 reg, u32 val)
+{
+	writel(val, pcie->base + reg);
+}
+
+static void rcar_gen4_pcie_ltssm_enable(struct rcar_gen4_pcie *pcie,
+					bool enable)
+{
+	u32 val;
+
+	val = rcar_gen4_pcie_readl(pcie, PCIERSTCTRL1);
+	if (enable) {
+		val |= APP_LTSSM_ENABLE;
+		val &= ~APP_HOLD_PHY_RST;
+	} else {
+		val &= ~APP_LTSSM_ENABLE;
+		val |= APP_HOLD_PHY_RST;
+	}
+	rcar_gen4_pcie_writel(pcie, PCIERSTCTRL1, val);
+}
+
+static int rcar_gen4_pcie_link_up(struct dw_pcie *pci)
+{
+	struct rcar_gen4_pcie *pcie = to_rcar_gen4_pcie(pci);
+	u32 val, mask;
+
+	val = rcar_gen4_pcie_readl(pcie, PCIEINTSTS0);
+	mask = RDLH_LINK_UP | SMLH_LINK_UP;
+
+	return (val & mask) == mask;
+}
+
+static int rcar_gen4_pcie_start_link(struct dw_pcie *pci)
+{
+	struct rcar_gen4_pcie *pcie = to_rcar_gen4_pcie(pci);
+
+	rcar_gen4_pcie_ltssm_enable(pcie, true);
+
+	return 0;
+}
+
+static void rcar_gen4_pcie_stop_link(struct dw_pcie *pci)
+{
+	struct rcar_gen4_pcie *pcie = to_rcar_gen4_pcie(pci);
+
+	rcar_gen4_pcie_ltssm_enable(pcie, false);
+}
+
+void rcar_gen4_pcie_set_max_link_width(struct dw_pcie *pci, int num_lanes)
+{
+	u32 val = dw_pcie_readl_dbi(pci, EXPCAP(PCI_EXP_LNKCAP));
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
+		dev_info(pci->dev, "invalid num-lanes %d\n", num_lanes);
+		val |= PCI_EXP_LNKCAP_MLW_X1;
+		break;
+	}
+	dw_pcie_writel_dbi(pci, EXPCAP(PCI_EXP_LNKCAP), val);
+}
+
+int rcar_gen4_pcie_prepare(struct rcar_gen4_pcie *pcie)
+{
+	struct dw_pcie *pci = pcie->pci;
+	int ret;
+
+	ret = clk_prepare_enable(pcie->bus_clk);
+	if (ret) {
+		dev_err(pci->dev, "failed to enable bus clock: %d\n", ret);
+		return ret;
+	}
+
+	ret = reset_control_deassert(pcie->rst);
+	if (ret)
+		goto err_clk_disable;
+
+	return 0;
+
+err_clk_disable:
+	clk_disable_unprepare(pcie->bus_clk);
+
+	return ret;
+}
+
+void rcar_gen4_pcie_unprepare(struct rcar_gen4_pcie *pcie)
+{
+	reset_control_assert(pcie->rst);
+	clk_disable_unprepare(pcie->bus_clk);
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
+int rcar_gen4_pcie_devm_clk_and_reset_get(struct rcar_gen4_pcie *pcie,
+					  struct device *dev)
+{
+	pcie->bus_clk = devm_clk_get(dev, "pcie_bus");
+	if (IS_ERR(pcie->bus_clk)) {
+		dev_err(dev, "cannot get pcie bus clock\n");
+		return PTR_ERR(pcie->bus_clk);
+	}
+
+	pcie->rst = devm_reset_control_get(dev, NULL);
+	if (IS_ERR(pcie->rst)) {
+		dev_err(dev, "failed to get Cold-reset\n");
+		return PTR_ERR(pcie->rst);
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
+	struct rcar_gen4_pcie *pcie;
+	struct dw_pcie *pci;
+
+	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return NULL;
+
+	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
+	if (!pci)
+		return NULL;
+
+	pci->dev = dev;
+	pci->ops = &dw_pcie_ops;
+	pci->version = DWC_VERSION;
+	pcie->pci = pci;
+
+	return pcie;
+}
diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.h b/drivers/pci/controller/dwc/pcie-rcar-gen4.h
new file mode 100644
index 000000000000..bd01d0ffcac9
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * PCIe host/endpoint controller driver for Renesas R-Car Gen4 Series SoCs
+ * Copyright (C) 2022 Renesas Electronics Corporation
+ */
+
+#ifndef _PCIE_RCAR_GEN4_H_
+#define _PCIE_RCAR_GEN4_H_
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/pci.h>
+#include <linux/reset.h>
+
+#include "pcie-designware.h"
+
+/* PCI Express capability */
+#define EXPCAP(x)		(0x0070 + (x))
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
+#define  BIFUR_MOD_SET_ON	(0x1 << 0)
+#define  DEVICE_TYPE_EP		(0x0 << 2)
+#define  DEVICE_TYPE_RC		(0x4 << 2)
+
+#define PCIEINTSTS0		0x0084
+#define PCIEINTSTS0EN		0x0310
+#define  MSI_CTRL_INT		BIT(26)
+#define  SMLH_LINK_UP		BIT(7)
+#define  RDLH_LINK_UP		BIT(6)
+
+struct rcar_gen4_pcie {
+	struct dw_pcie		*pci;
+	void __iomem		*base;
+	struct clk		*bus_clk;
+	struct reset_control	*rst;
+};
+
+extern u32 rcar_gen4_pcie_readl(struct rcar_gen4_pcie *pcie, u32 reg);
+extern void rcar_gen4_pcie_writel(struct rcar_gen4_pcie *pcie, u32 reg, u32 val);
+extern void rcar_gen4_pcie_set_max_link_width(struct dw_pcie *pci, int num_lanes);
+extern int rcar_gen4_pcie_prepare(struct rcar_gen4_pcie *pcie);
+extern void rcar_gen4_pcie_unprepare(struct rcar_gen4_pcie *pcie);
+extern int rcar_gen4_pcie_pm_runtime_enable(struct device *dev);
+extern void rcar_gen4_pcie_pm_runtime_disable(struct device *dev);
+extern int rcar_gen4_pcie_devm_clk_and_reset_get(struct rcar_gen4_pcie *pcie,
+						 struct device *dev);
+extern struct rcar_gen4_pcie *rcar_gen4_pcie_devm_alloc(struct device *dev);
+
+#endif /* _PCIE_RCAR_GEN4_H_ */
-- 
2.25.1

