Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFBA6322A1
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 13:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiKUMoW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 07:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiKUMoN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 07:44:13 -0500
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C0B0BFF49;
        Mon, 21 Nov 2022 04:44:12 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.96,181,1665414000"; 
   d="scan'208";a="143416649"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Nov 2022 21:44:10 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 078A349236FB;
        Mon, 21 Nov 2022 21:44:10 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, krzk+dt@kernel.org
Cc:     marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v7 8/9] PCI: rcar-gen4-ep: Add R-Car Gen4 PCIe Endpoint support
Date:   Mon, 21 Nov 2022 21:43:59 +0900
Message-Id: <20221121124400.1282768-9-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221121124400.1282768-1-yoshihiro.shimoda.uh@renesas.com>
References: <20221121124400.1282768-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add R-Car Gen4 PCIe Endpoint support. This controller is based on
Synopsys DesignWare PCIe.

This controller requires vender-specific initialization before
.ep_init(). To use dw->dbi and dw->num-lanes in the initialization
code, introduce .ep_pre_init() into struct dw_pcie_ep_ops.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pci/controller/dwc/Kconfig            |   9 +
 drivers/pci/controller/dwc/Makefile           |   2 +
 .../pci/controller/dwc/pcie-designware-ep.c   |   3 +
 drivers/pci/controller/dwc/pcie-designware.h  |   1 +
 .../pci/controller/dwc/pcie-rcar-gen4-ep.c    | 182 ++++++++++++++++++
 5 files changed, 197 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-ep.c

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 99717b0f4e50..4889bde3471b 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -402,4 +402,13 @@ config PCIE_RCAR_GEN4
 	  Say Y here if you want PCIe host controller support on R-Car Gen4 SoCs.
 	  This uses the DesignWare core.
 
+config PCIE_RCAR_GEN4_EP
+	tristate "Renesas R-Car Gen4 PCIe Endpoint controller"
+	depends on ARCH_RENESAS || COMPILE_TEST
+	depends on PCI_ENDPOINT
+	select PCIE_DW_EP
+	help
+	  Say Y here if you want PCIe endpoint controller support on R-Car Gen4
+	  SoCs. This uses the DesignWare core.
+
 endmenu
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index 486cf706b53d..0fb0bde26ac4 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -28,6 +28,8 @@ obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
 obj-$(CONFIG_PCIE_VISCONTI_HOST) += pcie-visconti.o
 pcie-rcar-gen4-host-drv-objs := pcie-rcar-gen4.o pcie-rcar-gen4-host.o
 obj-$(CONFIG_PCIE_RCAR_GEN4) += pcie-rcar-gen4-host-drv.o
+pcie-rcar-gen4-ep-drv-objs := pcie-rcar-gen4.o pcie-rcar-gen4-ep.o
+obj-$(CONFIG_PCIE_RCAR_GEN4_EP) += pcie-rcar-gen4-ep-drv.o
 
 # The following drivers are for devices that use the generic ACPI
 # pci_root.c driver but don't support standard ECAM config access.
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 886483bf378b..be2b31856c69 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -765,6 +765,9 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 
 	dw_pcie_version_detect(pci);
 
+	if (ep->ops->ep_pre_init)
+		ep->ops->ep_pre_init(ep);
+
 	dw_pcie_iatu_detect(pci);
 
 	ep->ib_window_map = devm_bitmap_zalloc(dev, pci->num_ib_windows,
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index ca0f9678517f..25c11a591ae2 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -324,6 +324,7 @@ struct dw_pcie_rp {
 };
 
 struct dw_pcie_ep_ops {
+	void	(*ep_pre_init)(struct dw_pcie_ep *ep);
 	void	(*ep_init)(struct dw_pcie_ep *ep);
 	int	(*raise_irq)(struct dw_pcie_ep *ep, u8 func_no,
 			     enum pci_epc_irq_type type, u16 interrupt_num);
diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4-ep.c b/drivers/pci/controller/dwc/pcie-rcar-gen4-ep.c
new file mode 100644
index 000000000000..c043844a2acd
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4-ep.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * PCIe Endpoint driver for Renesas R-Car Gen4 Series SoCs
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
+/* Configuration */
+#define PCICONF3		0x000c
+#define  MULTI_FUNC		BIT(23)
+
+static void rcar_gen4_pcie_ep_pre_init(struct dw_pcie_ep *ep)
+{
+	struct dw_pcie *dw = to_dw_pcie_from_ep(ep);
+	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
+	int val;
+
+	rcar_gen4_pcie_set_device_type(rcar, false, dw->num_lanes);
+
+	dw_pcie_dbi_ro_wr_en(dw);
+
+	/* Single function */
+	val = dw_pcie_readl_dbi(dw, PCICONF3);
+	val &= ~MULTI_FUNC;
+	dw_pcie_writel_dbi(dw, PCICONF3, val);
+
+	rcar_gen4_pcie_disable_bar(dw, BAR5MASKF);
+
+	rcar_gen4_pcie_set_max_link_width(dw, dw->num_lanes);
+
+	dw_pcie_dbi_ro_wr_dis(dw);
+}
+
+static int rcar_gen4_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
+				       enum pci_epc_irq_type type,
+				       u16 interrupt_num)
+{
+	struct dw_pcie *dw = to_dw_pcie_from_ep(ep);
+
+	switch (type) {
+	case PCI_EPC_IRQ_LEGACY:
+		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
+	case PCI_EPC_IRQ_MSI:
+		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
+	default:
+		dev_err(dw->dev, "UNKNOWN IRQ type\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct pci_epc_features rcar_gen4_pcie_epc_features = {
+	.linkup_notifier = false,
+	.msi_capable = true,
+	.msix_capable = false,
+	.reserved_bar = 1 << BAR_5,
+	.align = SZ_1M,
+};
+
+static const struct pci_epc_features*
+rcar_gen4_pcie_ep_get_features(struct dw_pcie_ep *ep)
+{
+	return &rcar_gen4_pcie_epc_features;
+}
+
+static const struct dw_pcie_ep_ops pcie_ep_ops = {
+	.ep_pre_init = rcar_gen4_pcie_ep_pre_init,
+	.raise_irq = rcar_gen4_pcie_ep_raise_irq,
+	.get_features = rcar_gen4_pcie_ep_get_features,
+};
+
+static int rcar_gen4_add_pcie_ep(struct rcar_gen4_pcie *rcar,
+				 struct platform_device *pdev)
+{
+	struct dw_pcie *dw = &rcar->dw;
+	struct dw_pcie_ep *ep;
+	int ret;
+
+	ep = &dw->ep;
+	ep->ops = &pcie_ep_ops;
+	ep->intx_by_atu = true;
+
+	ret = dw_pcie_ep_init(ep);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to initialize endpoint\n");
+		return ret;
+	}
+
+	dw->ops->start_link(dw);
+
+	return 0;
+}
+
+static void rcar_gen4_remove_pcie_ep(struct rcar_gen4_pcie *rcar)
+{
+	dw_pcie_ep_exit(&rcar->dw.ep);
+}
+
+static int rcar_gen4_pcie_ep_get_resources(struct rcar_gen4_pcie *rcar,
+					   struct platform_device *pdev)
+{
+	struct dw_pcie *dw = &rcar->dw;
+	struct device *dev = dw->dev;
+
+	/* Renesas-specific registers */
+	rcar->base = devm_platform_ioremap_resource_byname(pdev, "appl");
+	if (IS_ERR(rcar->base))
+		return PTR_ERR(rcar->base);
+
+	return rcar_gen4_pcie_devm_reset_get(rcar, dev);
+}
+
+static int rcar_gen4_pcie_ep_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct rcar_gen4_pcie *rcar;
+	int err;
+
+	rcar = rcar_gen4_pcie_devm_alloc(dev);
+	if (!rcar)
+		return -ENOMEM;
+
+	err = rcar_gen4_pcie_ep_get_resources(rcar, pdev);
+	if (err < 0) {
+		dev_err(dev, "failed to request resource: %d\n", err);
+		return err;
+	}
+
+	platform_set_drvdata(pdev, rcar);
+
+	err = rcar_gen4_pcie_prepare(rcar);
+	if (err < 0)
+		return err;
+
+	err = rcar_gen4_add_pcie_ep(rcar, pdev);
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
+static int rcar_gen4_pcie_ep_remove(struct platform_device *pdev)
+{
+	struct rcar_gen4_pcie *rcar = platform_get_drvdata(pdev);
+
+	rcar_gen4_remove_pcie_ep(rcar);
+	rcar_gen4_pcie_unprepare(rcar);
+
+	return 0;
+}
+
+static const struct of_device_id rcar_gen4_pcie_of_match[] = {
+	{ .compatible = "renesas,rcar-gen4-pcie-ep", },
+	{},
+};
+
+static struct platform_driver rcar_gen4_pcie_ep_driver = {
+	.driver = {
+		.name = "pcie-rcar-gen4-ep",
+		.of_match_table = rcar_gen4_pcie_of_match,
+	},
+	.probe = rcar_gen4_pcie_ep_probe,
+	.remove = rcar_gen4_pcie_ep_remove,
+};
+module_platform_driver(rcar_gen4_pcie_ep_driver);
+
+MODULE_DESCRIPTION("Renesas R-Car Gen4 PCIe endpoint controller driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

