Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45117592B5
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jul 2023 12:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjGSKVP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jul 2023 06:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjGSKVJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2023 06:21:09 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C3E1FC0;
        Wed, 19 Jul 2023 03:21:06 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 823AC24E2C0;
        Wed, 19 Jul 2023 18:21:05 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 19 Jul
 2023 18:21:05 +0800
Received: from ubuntu.localdomain (113.72.147.86) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 19 Jul
 2023 18:21:04 +0800
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
Subject: [PATCH v1 6/9] PCI: PLDA: Add host conroller platform driver
Date:   Wed, 19 Jul 2023 18:20:54 +0800
Message-ID: <20230719102057.22329-7-minda.chen@starfivetech.com>
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

Add PLDA XpressRICH PCIe host controller IP platform
driver. Implement it like DesignWare PCIe platform
driver.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 drivers/pci/controller/plda/Kconfig          |   8 ++
 drivers/pci/controller/plda/Makefile         |   1 +
 drivers/pci/controller/plda/pcie-plda-host.c | 111 +++++++++++++++++++
 drivers/pci/controller/plda/pcie-plda-plat.c |  64 +++++++++++
 drivers/pci/controller/plda/pcie-plda.h      |   3 +
 5 files changed, 187 insertions(+)
 create mode 100644 drivers/pci/controller/plda/pcie-plda-plat.c

diff --git a/drivers/pci/controller/plda/Kconfig b/drivers/pci/controller/plda/Kconfig
index fb274976b84b..a3c790545843 100644
--- a/drivers/pci/controller/plda/Kconfig
+++ b/drivers/pci/controller/plda/Kconfig
@@ -8,6 +8,14 @@ config PCIE_PLDA_HOST
 	depends on OF && PCI_MSI
 	select IRQ_DOMAIN
 
+config PCIE_PLDA_PLAT_HOST
+	bool "PLDA PCIe platform host controller"
+	select PCIE_PLDA_HOST
+	help
+	  Say Y here if you want to support the PLDA PCIe platform controller in
+	  host mode. This PCIe controller may be embedded into many different
+	  vendors SoCs.
+
 config PCIE_MICROCHIP_HOST
 	bool "Microchip AXI PCIe controller"
 	select PCI_HOST_COMMON
diff --git a/drivers/pci/controller/plda/Makefile b/drivers/pci/controller/plda/Makefile
index 4340ab007f44..2f16d9126535 100644
--- a/drivers/pci/controller/plda/Makefile
+++ b/drivers/pci/controller/plda/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_PCIE_PLDA_HOST) += pcie-plda-host.o
+obj-$(CONFIG_PCIE_PLDA_PLAT_HOST) += pcie-plda-plat.o
 obj-$(CONFIG_PCIE_MICROCHIP_HOST) += pcie-microchip-host.o
diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
index ca720430721c..e4baa63f6a5b 100644
--- a/drivers/pci/controller/plda/pcie-plda-host.c
+++ b/drivers/pci/controller/plda/pcie-plda-host.c
@@ -20,6 +20,15 @@
 
 #include "pcie-plda.h"
 
+void __iomem *plda_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
+				int where)
+{
+	struct plda_pcie *pcie = bus->sysdata;
+
+	return pcie->config_base + PCIE_ECAM_OFFSET(bus->number, devfn, where);
+}
+EXPORT_SYMBOL_GPL(plda_pcie_map_bus);
+
 void plda_pcie_enable_msi(struct plda_pcie *port)
 {
 	struct plda_msi *msi = &port->msi;
@@ -552,3 +561,105 @@ int plda_pcie_setup_iomems(struct plda_pcie *port, struct pci_host_bridge *bridg
 	return 0;
 }
 EXPORT_SYMBOL_GPL(plda_pcie_setup_iomems);
+
+static void plda_pcie_irq_domain_deinit(struct plda_pcie *pcie)
+{
+	irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
+	irq_set_chained_handler_and_data(pcie->msi_irq, NULL, NULL);
+	irq_set_chained_handler_and_data(pcie->intx_irq, NULL, NULL);
+
+	irq_domain_remove(pcie->msi.msi_domain);
+	irq_domain_remove(pcie->msi.dev_domain);
+
+	irq_domain_remove(pcie->intx_domain);
+	irq_domain_remove(pcie->event_domain);
+}
+
+int plda_pcie_host_init(struct plda_pcie *pcie, struct pci_ops *ops)
+{
+	struct resource *cfg_res;
+	struct device *dev = pcie->dev;
+	int ret;
+	struct pci_host_bridge *bridge;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct plda_evt evt = {NULL, NULL, EVENT_PM_MSI_INT_INTX,
+			       EVENT_PM_MSI_INT_MSI};
+
+	pcie->bridge_addr =
+		devm_platform_ioremap_resource_byname(pdev, "host");
+
+	if (IS_ERR(pcie->bridge_addr))
+		return dev_err_probe(dev, PTR_ERR(pcie->bridge_addr),
+			"Failed to map reg memory\n");
+
+	cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
+	if (!cfg_res)
+		return dev_err_probe(dev, -ENODEV,
+			"Failed to get config memory\n");
+
+	pcie->config_base = devm_ioremap_resource(dev, cfg_res);
+	if (IS_ERR(pcie->config_base))
+		return dev_err_probe(dev, PTR_ERR(pcie->config_base),
+			"Failed to map config memory\n");
+
+	pcie->phy = devm_phy_optional_get(dev, NULL);
+	if (IS_ERR(pcie->phy))
+		return dev_err_probe(dev, PTR_ERR(pcie->phy),
+			"Failed to get pcie phy\n");
+
+	bridge = devm_pci_alloc_host_bridge(dev, 0);
+	if (!bridge)
+		return dev_err_probe(dev, -ENOMEM,
+			"Failed to alloc bridge\n");
+
+	pcie->bridge = bridge;
+
+	if (pcie->ops->host_init) {
+		ret = pcie->ops->host_init(pcie);
+		if (ret)
+			return ret;
+	}
+
+	plda_pcie_setup_window(pcie->bridge_addr, 0, cfg_res->start, 0,
+			       resource_size(cfg_res));
+	plda_pcie_setup_iomems(pcie, bridge);
+	plda_set_default_msi(&pcie->msi);
+	ret = plda_pcie_init_irq(pcie, pdev, &evt);
+	if (ret)
+		goto err_host;
+
+	/* Set default bus ops */
+	bridge->ops = ops;
+	bridge->sysdata = pcie;
+
+	plda_pcie_enable_msi(pcie);
+
+	ret = pci_host_probe(bridge);
+	if (ret < 0) {
+		dev_err(dev, "Failed to pci host probe: %d\n", ret);
+		goto err_probe;
+	}
+
+	return ret;
+
+err_probe:
+	plda_pcie_irq_domain_deinit(pcie);
+err_host:
+	if (pcie->ops->host_deinit)
+		pcie->ops->host_deinit(pcie);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(plda_pcie_host_init);
+
+void plda_pcie_host_deinit(struct plda_pcie *pcie)
+{
+	pci_stop_root_bus(pcie->bridge->bus);
+	pci_remove_root_bus(pcie->bridge->bus);
+
+	plda_pcie_irq_domain_deinit(pcie);
+
+	if (pcie->ops->host_deinit)
+		pcie->ops->host_deinit(pcie);
+}
+EXPORT_SYMBOL_GPL(plda_pcie_host_deinit);
diff --git a/drivers/pci/controller/plda/pcie-plda-plat.c b/drivers/pci/controller/plda/pcie-plda-plat.c
new file mode 100644
index 000000000000..270aceb57c7a
--- /dev/null
+++ b/drivers/pci/controller/plda/pcie-plda-plat.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PLDA XpressRich PCIe platform driver
+ *
+ * Authors: Minda Chen <minda.chen@starfivetech.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/of_device.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/resource.h>
+#include <linux/types.h>
+
+#include "pcie-plda.h"
+
+static struct pci_ops plda_default_ops = {
+	.map_bus	= plda_pcie_map_bus,
+	.read		= pci_generic_config_read,
+	.write		= pci_generic_config_write,
+};
+
+static int plda_plat_pcie_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct plda_pcie *pci;
+	int ret;
+
+	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
+	if (!pci)
+		return -ENOMEM;
+
+	pci->dev = dev;
+
+	ret = plda_pcie_host_init(pci, &plda_default_ops);
+	if (ret) {
+		dev_err(dev, "Failed to initialize host\n");
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, pci);
+
+	return ret;
+}
+
+static const struct of_device_id plda_plat_pcie_of_match[] = {
+	{ .compatible = "plda,xpressrich-pcie-host"},
+	{ /* sentinel */ }
+};
+
+static struct platform_driver plda_plat_pcie_driver = {
+	.driver = {
+		.name	= "plda-xpressrich-pcie",
+		.of_match_table = plda_plat_pcie_of_match,
+		.suppress_bind_attrs = true,
+	},
+	.probe = plda_plat_pcie_probe,
+};
+builtin_platform_driver(plda_plat_pcie_driver);
diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
index feb3a0d9ace5..8785f885ddb1 100644
--- a/drivers/pci/controller/plda/pcie-plda.h
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -157,6 +157,7 @@ struct plda_evt {
 	int msi_evt;
 };
 
+void __iomem *plda_pcie_map_bus(struct pci_bus *bus, unsigned int devfn, int where);
 void plda_pcie_enable_msi(struct plda_pcie *port);
 void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
 			    phys_addr_t axi_addr, phys_addr_t pci_addr,
@@ -164,6 +165,8 @@ void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
 int plda_pcie_setup_iomems(struct plda_pcie *port, struct pci_host_bridge *host_bridge);
 int plda_pcie_init_irq(struct plda_pcie *port, struct platform_device *pdev,
 		       struct plda_evt *evt);
+int plda_pcie_host_init(struct plda_pcie *pcie, struct pci_ops *ops);
+void plda_pcie_host_deinit(struct plda_pcie *pcie);
 
 static inline void plda_set_default_msi(struct plda_msi *msi)
 {
-- 
2.17.1

