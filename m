Return-Path: <linux-pci+bounces-964-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6051D812935
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 08:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFAF3281C6B
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 07:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3105510A2F;
	Thu, 14 Dec 2023 07:29:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7236E10F;
	Wed, 13 Dec 2023 23:29:22 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id 00E328195;
	Thu, 14 Dec 2023 15:29:21 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 14 Dec
 2023 15:29:20 +0800
Received: from ubuntu.localdomain (113.72.145.168) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 14 Dec
 2023 15:29:17 +0800
From: Minda Chen <minda.chen@starfivetech.com>
To: Conor Dooley <conor@kernel.org>, =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=
	<kw@linux.com>, Rob Herring <robh+dt@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, "Daire
 McNamara" <daire.mcnamara@microchip.com>, Emil Renner Berthing
	<emil.renner.berthing@canonical.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Philipp Zabel <p.zabel@pengutronix.de>, Mason Huo
	<mason.huo@starfivetech.com>, Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Kevin Xie <kevin.xie@starfivetech.com>, Minda Chen
	<minda.chen@starfivetech.com>
Subject: [PATCH v13 09/21] PCI: microchip: Move setup functions to pcie-plda-host.c
Date: Thu, 14 Dec 2023 15:28:27 +0800
Message-ID: <20231214072839.2367-10-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231214072839.2367-1-minda.chen@starfivetech.com>
References: <20231214072839.2367-1-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag

Move setup functions to common pcie-plda-host.c. So these two functions
can be re-used.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/pci/controller/plda/Kconfig           |  4 +
 drivers/pci/controller/plda/Makefile          |  1 +
 .../pci/controller/plda/pcie-microchip-host.c | 59 --------------
 drivers/pci/controller/plda/pcie-plda-host.c  | 80 +++++++++++++++++++
 drivers/pci/controller/plda/pcie-plda.h       |  5 ++
 5 files changed, 90 insertions(+), 59 deletions(-)
 create mode 100644 drivers/pci/controller/plda/pcie-plda-host.c

diff --git a/drivers/pci/controller/plda/Kconfig b/drivers/pci/controller/plda/Kconfig
index 5cb3be4fc98c..e54a82ee94f5 100644
--- a/drivers/pci/controller/plda/Kconfig
+++ b/drivers/pci/controller/plda/Kconfig
@@ -3,10 +3,14 @@
 menu "PLDA-based PCIe controllers"
 	depends on PCI
 
+config PCIE_PLDA_HOST
+	bool
+
 config PCIE_MICROCHIP_HOST
 	tristate "Microchip AXI PCIe controller"
 	depends on PCI_MSI && OF
 	select PCI_HOST_COMMON
+	select PCIE_PLDA_HOST
 	help
 	  Say Y here if you want kernel to support the Microchip AXI PCIe
 	  Host Bridge driver.
diff --git a/drivers/pci/controller/plda/Makefile b/drivers/pci/controller/plda/Makefile
index e1a265cbf91c..4340ab007f44 100644
--- a/drivers/pci/controller/plda/Makefile
+++ b/drivers/pci/controller/plda/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_PCIE_PLDA_HOST) += pcie-plda-host.o
 obj-$(CONFIG_PCIE_MICROCHIP_HOST) += pcie-microchip-host.o
diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index 31ca8d44ee2a..2e79bcc7c0a5 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -838,65 +838,6 @@ static int mc_pcie_init_irq_domains(struct plda_pcie_rp *port)
 	return mc_allocate_msi_domains(port);
 }
 
-static void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
-				   phys_addr_t axi_addr, phys_addr_t pci_addr,
-				   size_t size)
-{
-	u32 atr_sz = ilog2(size) - 1;
-	u32 val;
-
-	if (index == 0)
-		val = PCIE_CONFIG_INTERFACE;
-	else
-		val = PCIE_TX_RX_INTERFACE;
-
-	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
-	       ATR0_AXI4_SLV0_TRSL_PARAM);
-
-	val = lower_32_bits(axi_addr) | (atr_sz << ATR_SIZE_SHIFT) |
-			    ATR_IMPL_ENABLE;
-	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
-	       ATR0_AXI4_SLV0_SRCADDR_PARAM);
-
-	val = upper_32_bits(axi_addr);
-	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
-	       ATR0_AXI4_SLV0_SRC_ADDR);
-
-	val = lower_32_bits(pci_addr);
-	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
-	       ATR0_AXI4_SLV0_TRSL_ADDR_LSB);
-
-	val = upper_32_bits(pci_addr);
-	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
-	       ATR0_AXI4_SLV0_TRSL_ADDR_UDW);
-
-	val = readl(bridge_base_addr + ATR0_PCIE_WIN0_SRCADDR_PARAM);
-	val |= (ATR0_PCIE_ATR_SIZE << ATR0_PCIE_ATR_SIZE_SHIFT);
-	writel(val, bridge_base_addr + ATR0_PCIE_WIN0_SRCADDR_PARAM);
-	writel(0, bridge_base_addr + ATR0_PCIE_WIN0_SRC_ADDR);
-}
-
-static int plda_pcie_setup_iomems(struct pci_host_bridge *bridge,
-				  struct plda_pcie_rp *port)
-{
-	void __iomem *bridge_base_addr = port->bridge_addr;
-	struct resource_entry *entry;
-	u64 pci_addr;
-	u32 index = 1;
-
-	resource_list_for_each_entry(entry, &bridge->windows) {
-		if (resource_type(entry->res) == IORESOURCE_MEM) {
-			pci_addr = entry->res->start - entry->offset;
-			plda_pcie_setup_window(bridge_base_addr, index,
-					       entry->res->start, pci_addr,
-					       resource_size(entry->res));
-			index++;
-		}
-	}
-
-	return 0;
-}
-
 static inline void mc_clear_secs(struct mc_pcie *port)
 {
 	void __iomem *ctrl_base_addr = port->axi_base_addr + MC_PCIE_CTRL_ADDR;
diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
new file mode 100644
index 000000000000..19131181897f
--- /dev/null
+++ b/drivers/pci/controller/plda/pcie-plda-host.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PLDA PCIe XpressRich host controller driver
+ *
+ * Copyright (C) 2023 Microchip Co. Ltd
+ *
+ * Author: Daire McNamara <daire.mcnamara@microchip.com>
+ */
+
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/msi.h>
+#include <linux/of_address.h>
+#include <linux/of_pci.h>
+#include <linux/pci_regs.h>
+#include <linux/pci-ecam.h>
+#include <linux/platform_device.h>
+
+#include "pcie-plda.h"
+
+void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
+			    phys_addr_t axi_addr, phys_addr_t pci_addr,
+			    size_t size)
+{
+	u32 atr_sz = ilog2(size) - 1;
+	u32 val;
+
+	if (index == 0)
+		val = PCIE_CONFIG_INTERFACE;
+	else
+		val = PCIE_TX_RX_INTERFACE;
+
+	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
+	       ATR0_AXI4_SLV0_TRSL_PARAM);
+
+	val = lower_32_bits(axi_addr) | (atr_sz << ATR_SIZE_SHIFT) |
+			    ATR_IMPL_ENABLE;
+	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
+	       ATR0_AXI4_SLV0_SRCADDR_PARAM);
+
+	val = upper_32_bits(axi_addr);
+	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
+	       ATR0_AXI4_SLV0_SRC_ADDR);
+
+	val = lower_32_bits(pci_addr);
+	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
+	       ATR0_AXI4_SLV0_TRSL_ADDR_LSB);
+
+	val = upper_32_bits(pci_addr);
+	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
+	       ATR0_AXI4_SLV0_TRSL_ADDR_UDW);
+
+	val = readl(bridge_base_addr + ATR0_PCIE_WIN0_SRCADDR_PARAM);
+	val |= (ATR0_PCIE_ATR_SIZE << ATR0_PCIE_ATR_SIZE_SHIFT);
+	writel(val, bridge_base_addr + ATR0_PCIE_WIN0_SRCADDR_PARAM);
+	writel(0, bridge_base_addr + ATR0_PCIE_WIN0_SRC_ADDR);
+}
+EXPORT_SYMBOL_GPL(plda_pcie_setup_window);
+
+int plda_pcie_setup_iomems(struct pci_host_bridge *bridge,
+			   struct plda_pcie_rp *port)
+{
+	void __iomem *bridge_base_addr = port->bridge_addr;
+	struct resource_entry *entry;
+	u64 pci_addr;
+	u32 index = 1;
+
+	resource_list_for_each_entry(entry, &bridge->windows) {
+		if (resource_type(entry->res) == IORESOURCE_MEM) {
+			pci_addr = entry->res->start - entry->offset;
+			plda_pcie_setup_window(bridge_base_addr, index,
+					       entry->res->start, pci_addr,
+					       resource_size(entry->res));
+			index++;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(plda_pcie_setup_iomems);
diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
index 363fcbbaf6ec..3deefd35fa5a 100644
--- a/drivers/pci/controller/plda/pcie-plda.h
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -120,4 +120,9 @@ struct plda_pcie_rp {
 	void __iomem *bridge_addr;
 };
 
+void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
+			    phys_addr_t axi_addr, phys_addr_t pci_addr,
+			    size_t size);
+int plda_pcie_setup_iomems(struct pci_host_bridge *bridge,
+			   struct plda_pcie_rp *port);
 #endif
-- 
2.17.1


