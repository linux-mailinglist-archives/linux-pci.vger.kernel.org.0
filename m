Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4E51376CE
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2020 20:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgAJTPX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jan 2020 14:15:23 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:9177 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbgAJTPX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jan 2020 14:15:23 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e18cd160001>; Fri, 10 Jan 2020 11:14:30 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 10 Jan 2020 11:15:21 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 10 Jan 2020 11:15:21 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Jan
 2020 19:15:21 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Jan
 2020 19:15:21 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 10 Jan 2020 19:15:20 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.48]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e18cd440002>; Fri, 10 Jan 2020 11:15:20 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>, <andrew.murray@arm.com>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V3 2/2] PCI: Add MCFG quirks for Tegra194 host controllers
Date:   Sat, 11 Jan 2020 00:45:00 +0530
Message-ID: <20200110191500.9538-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110191500.9538-1-vidyas@nvidia.com>
References: <20200106082709.14370-1-vidyas@nvidia.com>
 <20200110191500.9538-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578683671; bh=6wJT/II+S2upRtJe41MS3kcnFzRRB57EIPkoU3txnnc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=KDh6KAfT+xBJE0n0yRibTvav8qocX0wdxtjjCMNH+VNrt1Gvwgt8htMQvTCpi08Hz
         OLS6piubtsXb2Fk+J0rDcwmB2QM0YMKe6eA3DQkuJTPhl6PRxtvXdAYPfl/Z2pvG38
         dq6SIor6Yw4e76ncsvt69w6UXoLZHF7AywICq0jGnmPjWoKDnjID3qKSj5/u7tE+/L
         6hJUZ2QQebXRI17dRdfleyir+rRCS0wMl9tVNiAHplY3Wlxw895LJqvmVRZDVA+kg5
         8DPKJY2JbazS6P4QcywESwuhDfejJGaJUz+1/6oSiHBMCI5OhfhFZ/lyTf0iZycdTQ
         gnZUMkPu2QZOg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCIe controller in Tegra194 SoC is not completely ECAM-compliant.
With the current hardware design limitations in place, ECAM can be enabled
only for one controller (C5 controller to be precise) with bus numbers
starting from 160 instead of 0. A different approach is taken to avoid this
abnormal way of enabling ECAM for just one controller but to enable
configuration space access for all the other controllers. In this approach,
ops are added through MCFG quirk mechanism which access the configuration
spaces by dynamically programming iATU (internal AddressTranslation Unit)
to generate respective configuration accesses just like the way it is
done in DesignWare core sub-system.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Reported-by: kbuild test robot <lkp@intel.com>
---
V3:
* Removed MCFG address hardcoding in pci_mcfg.c file
* Started using 'dbi_base' for accessing root port's own config space
* and using 'config_base' for accessing config space of downstream hierarchy

V2:
* Fixed build issues reported by kbuild test bot

 drivers/acpi/pci_mcfg.c                    |   7 ++
 drivers/pci/controller/dwc/Kconfig         |   3 +-
 drivers/pci/controller/dwc/Makefile        |   2 +-
 drivers/pci/controller/dwc/pcie-tegra194.c | 102 +++++++++++++++++++++
 include/linux/pci-ecam.h                   |   1 +
 5 files changed, 113 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
index 6b347d9920cc..707181408173 100644
--- a/drivers/acpi/pci_mcfg.c
+++ b/drivers/acpi/pci_mcfg.c
@@ -116,6 +116,13 @@ static struct mcfg_fixup mcfg_quirks[] = {
 	THUNDER_ECAM_QUIRK(2, 12),
 	THUNDER_ECAM_QUIRK(2, 13),
 
+	{ "NVIDIA", "TEGRA194", 1, 0, MCFG_BUS_ANY, &tegra194_pcie_ops},
+	{ "NVIDIA", "TEGRA194", 1, 1, MCFG_BUS_ANY, &tegra194_pcie_ops},
+	{ "NVIDIA", "TEGRA194", 1, 2, MCFG_BUS_ANY, &tegra194_pcie_ops},
+	{ "NVIDIA", "TEGRA194", 1, 3, MCFG_BUS_ANY, &tegra194_pcie_ops},
+	{ "NVIDIA", "TEGRA194", 1, 4, MCFG_BUS_ANY, &tegra194_pcie_ops},
+	{ "NVIDIA", "TEGRA194", 1, 5, MCFG_BUS_ANY, &tegra194_pcie_ops},
+
 #define XGENE_V1_ECAM_MCFG(rev, seg) \
 	{"APM   ", "XGENE   ", rev, seg, MCFG_BUS_ANY, \
 		&xgene_v1_pcie_ecam_ops }
diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 0830dfcfa43a..f5b9e75aceed 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -255,7 +255,8 @@ config PCIE_TEGRA194
 	select PHY_TEGRA194_P2U
 	help
 	  Say Y here if you want support for DesignWare core based PCIe host
-	  controller found in NVIDIA Tegra194 SoC.
+	  controller found in NVIDIA Tegra194 SoC. ACPI platforms with Tegra194
+	  don't need to enable this.
 
 config PCIE_UNIPHIER
 	bool "Socionext UniPhier PCIe controllers"
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index 8a637cfcf6e9..76a6c52b8500 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -17,7 +17,6 @@ obj-$(CONFIG_PCIE_INTEL_GW) += pcie-intel-gw.o
 obj-$(CONFIG_PCIE_KIRIN) += pcie-kirin.o
 obj-$(CONFIG_PCIE_HISI_STB) += pcie-histb.o
 obj-$(CONFIG_PCI_MESON) += pci-meson.o
-obj-$(CONFIG_PCIE_TEGRA194) += pcie-tegra194.o
 obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
 
 # The following drivers are for devices that use the generic ACPI
@@ -33,4 +32,5 @@ obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
 ifdef CONFIG_PCI
 obj-$(CONFIG_ARM64) += pcie-al.o
 obj-$(CONFIG_ARM64) += pcie-hisi.o
+obj-$(CONFIG_ARM64) += pcie-tegra194.o
 endif
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index cbe95f0ea0ca..660f55caa8be 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -21,6 +21,8 @@
 #include <linux/of_irq.h>
 #include <linux/of_pci.h>
 #include <linux/pci.h>
+#include <linux/pci-acpi.h>
+#include <linux/pci-ecam.h>
 #include <linux/phy/phy.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
@@ -285,6 +287,103 @@ struct tegra_pcie_dw {
 	struct dentry *debugfs;
 };
 
+#if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
+struct tegra194_pcie_acpi  {
+	void __iomem *config_base;
+	void __iomem *iatu_base;
+	void __iomem *dbi_base;
+};
+
+static int tegra194_acpi_init(struct pci_config_window *cfg)
+{
+	struct device *dev = cfg->parent;
+	struct tegra194_pcie_acpi *pcie;
+
+	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+
+	pcie->config_base = cfg->win;
+	pcie->iatu_base = cfg->win + SZ_256K;
+	pcie->dbi_base = cfg->win + SZ_512K;
+	cfg->priv = pcie;
+
+	return 0;
+}
+
+static inline void atu_reg_write(struct tegra194_pcie_acpi *pcie, int index,
+				 u32 val, u32 reg)
+{
+	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
+
+	writel(val, pcie->iatu_base + offset + reg);
+}
+
+static void program_outbound_atu(struct tegra194_pcie_acpi *pcie, int index,
+				 int type, u64 cpu_addr, u64 pci_addr, u64 size)
+{
+	atu_reg_write(pcie, index, lower_32_bits(cpu_addr),
+		      PCIE_ATU_LOWER_BASE);
+	atu_reg_write(pcie, index, upper_32_bits(cpu_addr),
+		      PCIE_ATU_UPPER_BASE);
+	atu_reg_write(pcie, index, lower_32_bits(pci_addr),
+		      PCIE_ATU_LOWER_TARGET);
+	atu_reg_write(pcie, index, lower_32_bits(cpu_addr + size - 1),
+		      PCIE_ATU_LIMIT);
+	atu_reg_write(pcie, index, upper_32_bits(pci_addr),
+		      PCIE_ATU_UPPER_TARGET);
+	atu_reg_write(pcie, index, type, PCIE_ATU_CR1);
+	atu_reg_write(pcie, index, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
+}
+
+static void __iomem *tegra194_map_bus(struct pci_bus *bus,
+				      unsigned int devfn, int where)
+{
+	struct pci_config_window *cfg = bus->sysdata;
+	struct tegra194_pcie_acpi *pcie = cfg->priv;
+	u32 busdev;
+	int type;
+
+	if (bus->number < cfg->busr.start || bus->number > cfg->busr.end)
+		return NULL;
+
+	if (bus->number == cfg->busr.start) {
+		if (PCI_SLOT(devfn) == 0)
+			return pcie->dbi_base + where;
+		else
+			return NULL;
+	}
+
+	busdev = PCIE_ATU_BUS(bus->number) | PCIE_ATU_DEV(PCI_SLOT(devfn)) |
+		 PCIE_ATU_FUNC(PCI_FUNC(devfn));
+
+	if (bus->parent->number == cfg->busr.start) {
+		if (PCI_SLOT(devfn) == 0)
+			type = PCIE_ATU_TYPE_CFG0;
+		else
+			return NULL;
+	} else {
+		type = PCIE_ATU_TYPE_CFG1;
+	}
+
+	program_outbound_atu(pcie, PCIE_ATU_REGION_INDEX0, type,
+			     cfg->res.start, busdev, SZ_256K);
+	return (void __iomem *)(pcie->config_base + where);
+}
+
+struct pci_ecam_ops tegra194_pcie_ops = {
+	.bus_shift	= 20,
+	.init		= tegra194_acpi_init,
+	.pci_ops	= {
+		.map_bus	= tegra194_map_bus,
+		.read		= pci_generic_config_read,
+		.write		= pci_generic_config_write,
+	}
+};
+#endif /* defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS) */
+
+#ifdef CONFIG_PCIE_TEGRA194
+
 static inline struct tegra_pcie_dw *to_tegra_pcie(struct dw_pcie *pci)
 {
 	return container_of(pci, struct tegra_pcie_dw, pci);
@@ -1728,3 +1827,6 @@ MODULE_DEVICE_TABLE(of, tegra_pcie_dw_of_match);
 MODULE_AUTHOR("Vidya Sagar <vidyas@nvidia.com>");
 MODULE_DESCRIPTION("NVIDIA PCIe host controller driver");
 MODULE_LICENSE("GPL v2");
+
+#endif /* CONFIG_PCIE_TEGRA194 */
+
diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
index a73164c85e78..6156140dcbb6 100644
--- a/include/linux/pci-ecam.h
+++ b/include/linux/pci-ecam.h
@@ -57,6 +57,7 @@ extern struct pci_ecam_ops pci_thunder_ecam_ops; /* Cavium ThunderX 1.x */
 extern struct pci_ecam_ops xgene_v1_pcie_ecam_ops; /* APM X-Gene PCIe v1 */
 extern struct pci_ecam_ops xgene_v2_pcie_ecam_ops; /* APM X-Gene PCIe v2.x */
 extern struct pci_ecam_ops al_pcie_ops; /* Amazon Annapurna Labs PCIe */
+extern struct pci_ecam_ops tegra194_pcie_ops; /* Tegra194 PCIe */
 #endif
 
 #ifdef CONFIG_PCI_HOST_COMMON
-- 
2.17.1

