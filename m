Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97BD27883B3
	for <lists+linux-pci@lfdr.de>; Fri, 25 Aug 2023 11:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244310AbjHYJcr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Aug 2023 05:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244268AbjHYJcb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Aug 2023 05:32:31 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F69B1FF1;
        Fri, 25 Aug 2023 02:32:28 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,195,1688396400"; 
   d="scan'208";a="177667263"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 25 Aug 2023 18:32:25 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9B78B40071FF;
        Fri, 25 Aug 2023 18:32:25 +0900 (JST)
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
Subject: [PATCH v20 17/19] PCI: rcar-gen4-ep: Add R-Car Gen4 PCIe Endpoint support
Date:   Fri, 25 Aug 2023 18:32:17 +0900
Message-Id: <20230825093219.2685912-18-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230825093219.2685912-1-yoshihiro.shimoda.uh@renesas.com>
References: <20230825093219.2685912-1-yoshihiro.shimoda.uh@renesas.com>
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

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/pci/controller/dwc/Kconfig            |  10 +
 drivers/pci/controller/dwc/Makefile           |   2 +
 .../controller/dwc/pcie-rcar-gen4-ep-drv.c    | 173 ++++++++++++++++++
 3 files changed, 185 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-ep-drv.c

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 3884a67e4d56..65a7c56e64bd 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -425,4 +425,14 @@ config PCIE_RCAR_GEN4
 	  To compile this driver as a module, choose M here: the module will be
 	  called pcie-rcar-gen4-host.ko. This uses the DesignWare core.
 
+config PCIE_RCAR_GEN4_EP
+	tristate "Renesas R-Car Gen4 PCIe Endpoint controller"
+	depends on ARCH_RENESAS || COMPILE_TEST
+	depends on PCI_ENDPOINT
+	select PCIE_DW_EP
+	help
+	  Say Y here if you want PCIe endpoint controller support on R-Car Gen4
+	  SoCs. To compile this driver as a module, choose M here: the module
+	  will be called pcie-rcar-gen4-ep.ko. This uses the DesignWare core.
+
 endmenu
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index ab2c6bc16216..4d53d660e4fe 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -28,6 +28,8 @@ obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
 obj-$(CONFIG_PCIE_VISCONTI_HOST) += pcie-visconti.o
 pcie-rcar-gen4-host-objs := pcie-rcar-gen4.o pcie-rcar-gen4-host-drv.o
 obj-$(CONFIG_PCIE_RCAR_GEN4) += pcie-rcar-gen4-host.o
+pcie-rcar-gen4-ep-objs := pcie-rcar-gen4.o pcie-rcar-gen4-ep-drv.o
+obj-$(CONFIG_PCIE_RCAR_GEN4_EP) += pcie-rcar-gen4-ep.o
 
 # The following drivers are for devices that use the generic ACPI
 # pci_root.c driver but don't support standard ECAM config access.
diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4-ep-drv.c b/drivers/pci/controller/dwc/pcie-rcar-gen4-ep-drv.c
new file mode 100644
index 000000000000..b85c290db3da
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4-ep-drv.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * PCIe Endpoint driver for Renesas R-Car Gen4 Series SoCs
+ * Copyright (C) 2022-2023 Renesas Electronics Corporation
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
+#define RCAR_GEN4_PCIE_EP_FUNC_DBI_OFFSET	0x1000
+#define RCAR_GEN4_PCIE_EP_FUNC_DBI2_OFFSET	0x800
+
+static void rcar_gen4_pcie_ep_pre_init(struct dw_pcie_ep *ep)
+{
+	struct dw_pcie *dw = to_dw_pcie_from_ep(ep);
+	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
+	int ret;
+
+	ret = rcar_gen4_pcie_common_init(rcar);
+	if (ret)
+		return;
+
+	writel(PCIEDMAINTSTSEN_INIT, rcar->base + PCIEDMAINTSTSEN);
+}
+
+static void rcar_gen4_pcie_ep_init(struct dw_pcie_ep *ep)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	enum pci_barno bar;
+
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
+		dw_pcie_ep_reset_bar(pci, bar);
+}
+
+static void rcar_gen4_pcie_ep_deinit(struct dw_pcie_ep *ep)
+{
+	struct dw_pcie *dw = to_dw_pcie_from_ep(ep);
+	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
+
+	writel(0, rcar->base + PCIEDMAINTSTSEN);
+	rcar_gen4_pcie_common_deinit(rcar);
+}
+
+static int rcar_gen4_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
+				       unsigned int type, u16 interrupt_num)
+{
+	struct dw_pcie *dw = to_dw_pcie_from_ep(ep);
+
+	switch (type) {
+	case PCI_IRQ_LEGACY:
+		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
+	case PCI_IRQ_MSI:
+		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
+	default:
+		dev_err(dw->dev, "Unknown IRQ type\n");
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
+	.reserved_bar = 1 << BAR_1 | 1 << BAR_3 | 1 << BAR_5,
+	.align = SZ_1M,
+};
+
+static const struct pci_epc_features*
+rcar_gen4_pcie_ep_get_features(struct dw_pcie_ep *ep)
+{
+	return &rcar_gen4_pcie_epc_features;
+}
+
+static unsigned int rcar_gen4_pcie_ep_func_conf_select(struct dw_pcie_ep *ep,
+						       u8 func_no)
+{
+	return func_no * RCAR_GEN4_PCIE_EP_FUNC_DBI_OFFSET;
+}
+
+static unsigned int rcar_gen4_pcie_ep_get_dbi2_offset(struct dw_pcie_ep *ep,
+						      u8 func_no)
+{
+	return func_no * RCAR_GEN4_PCIE_EP_FUNC_DBI2_OFFSET;
+}
+
+static const struct dw_pcie_ep_ops pcie_ep_ops = {
+	.pre_init = rcar_gen4_pcie_ep_pre_init,
+	.ep_init = rcar_gen4_pcie_ep_init,
+	.deinit = rcar_gen4_pcie_ep_deinit,
+	.raise_irq = rcar_gen4_pcie_ep_raise_irq,
+	.get_features = rcar_gen4_pcie_ep_get_features,
+	.func_conf_select = rcar_gen4_pcie_ep_func_conf_select,
+	.get_dbi2_offset = rcar_gen4_pcie_ep_get_dbi2_offset,
+};
+
+static int rcar_gen4_add_pcie_ep(struct rcar_gen4_pcie *rcar)
+{
+	struct dw_pcie_ep *ep = &rcar->dw.ep;
+
+	rcar->mode = DW_PCIE_EP_TYPE;
+	ep->ops = &pcie_ep_ops;
+
+	return dw_pcie_ep_init(ep);
+}
+
+static void rcar_gen4_remove_pcie_ep(struct rcar_gen4_pcie *rcar)
+{
+	dw_pcie_ep_exit(&rcar->dw.ep);
+}
+
+static int rcar_gen4_pcie_ep_probe(struct platform_device *pdev)
+{
+	struct rcar_gen4_pcie *rcar;
+	int err;
+
+	rcar = rcar_gen4_pcie_devm_alloc(pdev);
+	if (IS_ERR(rcar))
+		return PTR_ERR(rcar);
+
+	err = rcar_gen4_pcie_get_resources(rcar);
+	if (err)
+		return err;
+
+	err = rcar_gen4_pcie_prepare(rcar);
+	if (err)
+		return err;
+
+	err = rcar_gen4_add_pcie_ep(rcar);
+	if (err)
+		goto err_unprepare;
+
+	return 0;
+
+err_unprepare:
+	rcar_gen4_pcie_unprepare(rcar);
+
+	return err;
+}
+
+static void rcar_gen4_pcie_ep_remove(struct platform_device *pdev)
+{
+	struct rcar_gen4_pcie *rcar = platform_get_drvdata(pdev);
+
+	rcar_gen4_remove_pcie_ep(rcar);
+	rcar_gen4_pcie_unprepare(rcar);
+}
+
+static const struct of_device_id rcar_gen4_pcie_of_match[] = {
+	{ .compatible = "renesas,rcar-gen4-pcie-ep", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rcar_gen4_pcie_of_match);
+
+static struct platform_driver rcar_gen4_pcie_ep_driver = {
+	.driver = {
+		.name = "pcie-rcar-gen4-ep",
+		.of_match_table = rcar_gen4_pcie_of_match,
+	},
+	.probe = rcar_gen4_pcie_ep_probe,
+	.remove_new = rcar_gen4_pcie_ep_remove,
+};
+module_platform_driver(rcar_gen4_pcie_ep_driver);
+
+MODULE_DESCRIPTION("Renesas R-Car Gen4 PCIe endpoint controller driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

