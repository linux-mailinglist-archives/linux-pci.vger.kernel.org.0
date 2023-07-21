Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F3C75C049
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jul 2023 09:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjGUHpS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jul 2023 03:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjGUHpQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jul 2023 03:45:16 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4DD342D6D;
        Fri, 21 Jul 2023 00:45:11 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,220,1684767600"; 
   d="scan'208";a="170346737"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 21 Jul 2023 16:45:04 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 754EC418F610;
        Fri, 21 Jul 2023 16:45:04 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
        kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     marek.vasut+renesas@gmail.com, fancer.lancer@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v18 17/20] PCI: rcar-gen4: Add R-Car Gen4 PCIe Host support
Date:   Fri, 21 Jul 2023 16:44:49 +0900
Message-Id: <20230721074452.65545-18-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add R-Car Gen4 PCIe Host support. This controller is based on
Synopsys DesignWare PCIe, but this controller has vendor-specific
registers so that requires initialization code like mode setting
and retraining and so on.

To reduce code delta, adds some helper functions which are used by
both the host driver and the endpoint driver (which is added
immediately afterwards) into a separate file.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pci/controller/dwc/Kconfig            |   9 +
 drivers/pci/controller/dwc/Makefile           |   2 +
 .../pci/controller/dwc/pcie-rcar-gen4-host.c  | 149 +++++++++++++
 drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 200 ++++++++++++++++++
 drivers/pci/controller/dwc/pcie-rcar-gen4.h   |  44 ++++
 5 files changed, 404 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.c
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.h

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index ab96da43e0c2..64d4d37bc891 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -415,4 +415,13 @@ config PCIE_VISCONTI_HOST
 	  Say Y here if you want PCIe controller support on Toshiba Visconti SoC.
 	  This driver supports TMPV7708 SoC.
 
+config PCIE_RCAR_GEN4
+	tristate "Renesas R-Car Gen4 PCIe Host controller"
+	depends on ARCH_RENESAS || COMPILE_TEST
+	depends on PCI_MSI
+	select PCIE_DW_HOST
+	help
+	  Say Y here if you want PCIe host controller support on R-Car Gen4 SoCs.
+	  This uses the DesignWare core.
+
 endmenu
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index bf5c311875a1..486cf706b53d 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -26,6 +26,8 @@ obj-$(CONFIG_PCIE_TEGRA194) += pcie-tegra194.o
 obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
 obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
 obj-$(CONFIG_PCIE_VISCONTI_HOST) += pcie-visconti.o
+pcie-rcar-gen4-host-drv-objs := pcie-rcar-gen4.o pcie-rcar-gen4-host.o
+obj-$(CONFIG_PCIE_RCAR_GEN4) += pcie-rcar-gen4-host-drv.o
 
 # The following drivers are for devices that use the generic ACPI
 # pci_root.c driver but don't support standard ECAM config access.
diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4-host.c b/drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
new file mode 100644
index 000000000000..3168f5d98a79
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * PCIe host controller driver for Renesas R-Car Gen4 Series SoCs
+ * Copyright (C) 2022-2023 Renesas Electronics Corporation
+ */
+
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+
+#include "pcie-rcar-gen4.h"
+#include "pcie-designware.h"
+
+static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
+	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
+	int ret;
+	u32 val;
+
+	gpiod_set_value_cansleep(dw->pe_rst, 1);
+
+	ret = clk_bulk_prepare_enable(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
+	if (ret) {
+		dev_err(dw->dev, "Failed to enable ref clocks\n");
+		return ret;
+	}
+
+	ret = rcar_gen4_pcie_basic_init(rcar);
+	if (ret < 0) {
+		clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
+		return ret;
+	}
+
+	/*
+	 * According to the section 3.5.7.2 "RC Mode" in DWC PCIe Dual Mode
+	 * Rev.5.20a, we should disable two BARs to avoid unnecessary memory
+	 * assignment during device enumeration.
+	 */
+	dw_pcie_writel_dbi2(dw, PCI_BASE_ADDRESS_0, 0x0);
+	dw_pcie_writel_dbi2(dw, PCI_BASE_ADDRESS_1, 0x0);
+
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		/* Enable MSI interrupt signal */
+		val = readl(rcar->base + PCIEINTSTS0EN);
+		val |= MSI_CTRL_INT;
+		writel(val, rcar->base + PCIEINTSTS0EN);
+	}
+
+	msleep(100);	/* pe_rst requires 100msec delay */
+
+	gpiod_set_value_cansleep(dw->pe_rst, 0);
+
+	return 0;
+}
+
+static void rcar_gen4_pcie_host_deinit(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
+	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
+
+	gpiod_set_value_cansleep(dw->pe_rst, 1);
+	rcar_gen4_pcie_basic_deinit(rcar);
+	clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
+}
+
+static const struct dw_pcie_host_ops rcar_gen4_pcie_host_ops = {
+	.host_init = rcar_gen4_pcie_host_init,
+	.host_deinit = rcar_gen4_pcie_host_deinit,
+};
+
+static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
+{
+	struct dw_pcie_rp *pp = &rcar->dw.pp;
+
+	pp->num_vectors = MAX_MSI_IRQS;
+	pp->ops = &rcar_gen4_pcie_host_ops;
+	rcar->mode = DW_PCIE_RC_TYPE;
+
+	return dw_pcie_host_init(pp);
+}
+
+static void rcar_gen4_remove_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
+{
+	dw_pcie_host_deinit(&rcar->dw.pp);
+	gpiod_set_value_cansleep(rcar->dw.pe_rst, 1);
+}
+
+static int rcar_gen4_pcie_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct rcar_gen4_pcie *rcar;
+	int err;
+
+	rcar = rcar_gen4_pcie_devm_alloc(pdev);
+	if (!rcar)
+		return -ENOMEM;
+
+	err = rcar_gen4_pcie_get_resources(rcar);
+	if (err < 0) {
+		dev_err(dev, "Failed to request resource: %d\n", err);
+		return err;
+	}
+
+	err = rcar_gen4_pcie_prepare(rcar);
+	if (err < 0)
+		return err;
+
+	err = rcar_gen4_add_dw_pcie_rp(rcar);
+	if (err < 0)
+		goto err_add;
+
+	return 0;
+
+err_add:
+	rcar_gen4_pcie_unprepare(rcar);
+
+	return err;
+}
+
+static void rcar_gen4_pcie_remove(struct platform_device *pdev)
+{
+	struct rcar_gen4_pcie *rcar = platform_get_drvdata(pdev);
+
+	rcar_gen4_remove_dw_pcie_rp(rcar);
+	rcar_gen4_pcie_unprepare(rcar);
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
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+	.probe = rcar_gen4_pcie_probe,
+	.remove_new = rcar_gen4_pcie_remove,
+};
+module_platform_driver(rcar_gen4_pcie_driver);
+
+MODULE_DESCRIPTION("Renesas R-Car Gen4 PCIe host controller driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
new file mode 100644
index 000000000000..a5fb9aae0a6f
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * PCIe host/endpoint controller driver for Renesas R-Car Gen4 Series SoCs
+ * Copyright (C) 2022-2023 Renesas Electronics Corporation
+ */
+
+#include <linux/delay.h>
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
+#define RCAR_NUM_SPEED_CHANGE_RETRIES	10
+#define RCAR_MAX_LINK_SPEED		4
+
+static void rcar_gen4_pcie_ltssm_enable(struct rcar_gen4_pcie *rcar,
+					bool enable)
+{
+	u32 val;
+
+	val = readl(rcar->base + PCIERSTCTRL1);
+	if (enable) {
+		val |= APP_LTSSM_ENABLE;
+		val &= ~APP_HOLD_PHY_RST;
+	} else {
+		/*
+		 * Since the datasheet of R-Car doesn't mention how to assert
+		 * the APP_HOLD_PHY_RST, don't assert it again. Otherwise,
+		 * hang-up issue happened in the dw_edma_core_off() when
+		 * the controller didn't detect a PCI device.
+		 */
+		val &= ~APP_LTSSM_ENABLE;
+	}
+	writel(val, rcar->base + PCIERSTCTRL1);
+}
+
+static int rcar_gen4_pcie_link_up(struct dw_pcie *dw)
+{
+	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
+	u32 val, mask;
+
+	val = readl(rcar->base + PCIEINTSTS0);
+	mask = RDLH_LINK_UP | SMLH_LINK_UP;
+
+	return (val & mask) == mask;
+}
+
+static bool rcar_gen4_pcie_speed_change(struct dw_pcie *dw)
+{
+	u32 val;
+	int i;
+
+	val = dw_pcie_readl_dbi(dw, PCIE_LINK_WIDTH_SPEED_CONTROL);
+	val &= ~PORT_LOGIC_SPEED_CHANGE;
+	dw_pcie_writel_dbi(dw, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
+
+	val = dw_pcie_readl_dbi(dw, PCIE_LINK_WIDTH_SPEED_CONTROL);
+	val |= PORT_LOGIC_SPEED_CHANGE;
+	dw_pcie_writel_dbi(dw, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
+
+	for (i = 0; i < RCAR_NUM_SPEED_CHANGE_RETRIES; i++) {
+		val = dw_pcie_readl_dbi(dw, PCIE_LINK_WIDTH_SPEED_CONTROL);
+		if (!(val & PORT_LOGIC_SPEED_CHANGE))
+			return true;
+		usleep_range(10000, 11000);
+	}
+
+	return false;
+}
+
+static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
+{
+	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
+	int i, changes;
+
+	rcar_gen4_pcie_ltssm_enable(rcar, true);
+
+	/*
+	 * Require direct speed change with retrying here if the link_gen is
+	 * PCIe Gen2 or higher.
+	 */
+	changes = min_not_zero(dw->link_gen, RCAR_MAX_LINK_SPEED) - 1;
+
+	/*
+	 * Since dw_pcie_setup_rc() sets it once, PCIe Gen2 will be trained.
+	 * So, this needs remaining times for up to PCIe Gen4 if RC mode.
+	 */
+	if (changes && rcar->mode == DW_PCIE_RC_TYPE)
+		changes--;
+
+	for (i = 0; i < changes; i++) {
+		if (!rcar_gen4_pcie_speed_change(dw))
+			break;	/* No error because possible disconnected here if EP mode */
+	}
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
+int rcar_gen4_pcie_basic_init(struct rcar_gen4_pcie *rcar)
+{
+	struct dw_pcie *dw = &rcar->dw;
+	u32 val;
+
+	if (!reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc))
+		reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
+
+	val = readl(rcar->base + PCIEMSR0);
+	if (rcar->mode == DW_PCIE_RC_TYPE)
+		val |= DEVICE_TYPE_RC;
+	else if (rcar->mode == DW_PCIE_EP_TYPE)
+		val |= DEVICE_TYPE_EP;
+	else
+		return -EINVAL;
+
+	if (dw->num_lanes < 4)
+		val |= BIFUR_MOD_SET_ON;
+
+	writel(val, rcar->base + PCIEMSR0);
+
+	return reset_control_deassert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
+}
+
+void rcar_gen4_pcie_basic_deinit(struct rcar_gen4_pcie *rcar)
+{
+	struct dw_pcie *dw = &rcar->dw;
+
+	reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
+}
+
+int rcar_gen4_pcie_prepare(struct rcar_gen4_pcie *rcar)
+{
+	struct device *dev = rcar->dw.dev;
+	int err;
+
+	pm_runtime_enable(dev);
+	err = pm_runtime_resume_and_get(dev);
+	if (err < 0) {
+		dev_err(dev, "Failed to resume/get Runtime PM\n");
+		pm_runtime_disable(dev);
+	}
+
+	return err;
+}
+
+void rcar_gen4_pcie_unprepare(struct rcar_gen4_pcie *rcar)
+{
+	struct device *dev = rcar->dw.dev;
+
+	pm_runtime_put(dev);
+	pm_runtime_disable(dev);
+}
+
+int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar)
+{
+	/* Renesas-specific registers */
+	rcar->base = devm_platform_ioremap_resource_byname(rcar->pdev, "app");
+
+	return IS_ERR(rcar->base) ? PTR_ERR(rcar->base) : 0;
+}
+
+static const struct dw_pcie_ops dw_pcie_ops = {
+	.start_link = rcar_gen4_pcie_start_link,
+	.stop_link = rcar_gen4_pcie_stop_link,
+	.link_up = rcar_gen4_pcie_link_up,
+};
+
+struct rcar_gen4_pcie *rcar_gen4_pcie_devm_alloc(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct rcar_gen4_pcie *rcar;
+
+	rcar = devm_kzalloc(dev, sizeof(*rcar), GFP_KERNEL);
+	if (!rcar)
+		return NULL;
+
+	rcar->dw.dev = dev;
+	rcar->dw.ops = &dw_pcie_ops;
+	dw_pcie_cap_set(&rcar->dw, EDMA_UNROLL);
+	dw_pcie_cap_set(&rcar->dw, REQ_RES);
+	rcar->pdev = pdev;
+	platform_set_drvdata(pdev, rcar);
+
+	return rcar;
+}
diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.h b/drivers/pci/controller/dwc/pcie-rcar-gen4.h
new file mode 100644
index 000000000000..781165422739
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * PCIe host/endpoint controller driver for Renesas R-Car Gen4 Series SoCs
+ * Copyright (C) 2022-2023 Renesas Electronics Corporation
+ */
+
+#ifndef _PCIE_RCAR_GEN4_H_
+#define _PCIE_RCAR_GEN4_H_
+
+#include <linux/io.h>
+#include <linux/pci.h>
+
+#include "pcie-designware.h"
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
+#define PCIEDMAINTSTSEN		0x0314
+#define  PCIEDMAINTSTSEN_INIT	GENMASK(15, 0)
+
+struct rcar_gen4_pcie {
+	struct dw_pcie dw;
+	void __iomem *base;
+	struct platform_device *pdev;
+	enum dw_pcie_device_mode mode;
+};
+#define to_rcar_gen4_pcie(_dw)	container_of(_dw, struct rcar_gen4_pcie, dw)
+
+int rcar_gen4_pcie_basic_init(struct rcar_gen4_pcie *rcar);
+void rcar_gen4_pcie_basic_deinit(struct rcar_gen4_pcie *rcar);
+int rcar_gen4_pcie_prepare(struct rcar_gen4_pcie *rcar);
+void rcar_gen4_pcie_unprepare(struct rcar_gen4_pcie *rcar);
+int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar);
+struct rcar_gen4_pcie *rcar_gen4_pcie_devm_alloc(struct platform_device *pdev);
+
+#endif /* _PCIE_RCAR_GEN4_H_ */
-- 
2.25.1

