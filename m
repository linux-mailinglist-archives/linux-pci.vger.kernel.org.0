Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7432F3F298C
	for <lists+linux-pci@lfdr.de>; Fri, 20 Aug 2021 11:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbhHTJyC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Aug 2021 05:54:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238065AbhHTJyB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Aug 2021 05:54:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5B7A61051;
        Fri, 20 Aug 2021 09:53:20 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V7 2/5] PCI: loongson: Add ACPI init support
Date:   Fri, 20 Aug 2021 17:52:26 +0800
Message-Id: <20210820095229.624515-3-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210820095229.624515-1-chenhuacai@loongson.cn>
References: <20210820095229.624515-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Loongson PCH (LS7A chipset) will be used by both MIPS-based and
LoongArch-based Loongson processors. MIPS-based Loongson uses FDT
while LoongArch-base Loongson uses ACPI, this patch add ACPI init
support for the driver in drivers/pci/controller/pci-loongson.c
because it is currently FDT-only.

LoongArch is a new RISC ISA, mainline support will come soon, and
documentations are here (in translation):

https://github.com/loongson/LoongArch-Documentation

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/acpi/pci_mcfg.c               | 13 +++++++
 drivers/pci/controller/Kconfig        |  2 +-
 drivers/pci/controller/pci-loongson.c | 54 ++++++++++++++++++++++++++-
 include/linux/pci-ecam.h              |  1 +
 4 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
index 53cab975f612..860014b89b8e 100644
--- a/drivers/acpi/pci_mcfg.c
+++ b/drivers/acpi/pci_mcfg.c
@@ -41,6 +41,8 @@ struct mcfg_fixup {
 static struct mcfg_fixup mcfg_quirks[] = {
 /*	{ OEM_ID, OEM_TABLE_ID, REV, SEGMENT, BUS_RANGE, ops, cfgres }, */
 
+#ifdef CONFIG_ARM64
+
 #define AL_ECAM(table_id, rev, seg, ops) \
 	{ "AMAZON", table_id, rev, seg, MCFG_BUS_ANY, ops }
 
@@ -169,6 +171,17 @@ static struct mcfg_fixup mcfg_quirks[] = {
 	ALTRA_ECAM_QUIRK(1, 13),
 	ALTRA_ECAM_QUIRK(1, 14),
 	ALTRA_ECAM_QUIRK(1, 15),
+#endif /* ARM64 */
+
+#ifdef CONFIG_LOONGARCH
+#define LOONGSON_ECAM_MCFG(table_id, seg) \
+	{ "LOONGS", table_id, 1, seg, MCFG_BUS_ANY, &loongson_pci_ecam_ops }
+
+	LOONGSON_ECAM_MCFG("\0", 0),
+	LOONGSON_ECAM_MCFG("LOONGSON", 0),
+	LOONGSON_ECAM_MCFG("\0", 1),
+	LOONGSON_ECAM_MCFG("LOONGSON", 1),
+#endif /* LOONGARCH */
 };
 
 static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 5e1e3796efa4..77aa7272425c 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -287,7 +287,7 @@ config PCI_HYPERV_INTERFACE
 config PCI_LOONGSON
 	bool "LOONGSON PCI Controller"
 	depends on MACH_LOONGSON64 || COMPILE_TEST
-	depends on OF
+	depends on OF || ACPI
 	depends on PCI_QUIRKS
 	default MACH_LOONGSON64
 	help
diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index 7140bdd04d35..db5b51ebff3c 100644
--- a/drivers/pci/controller/pci-loongson.c
+++ b/drivers/pci/controller/pci-loongson.c
@@ -9,6 +9,8 @@
 #include <linux/of_pci.h>
 #include <linux/pci.h>
 #include <linux/pci_ids.h>
+#include <linux/pci-acpi.h>
+#include <linux/pci-ecam.h>
 
 #include "../pci.h"
 
@@ -92,6 +94,18 @@ static void loongson_mrrs_quirk(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_mrrs_quirk);
 
+static struct loongson_pci *pci_bus_to_loongson_pci(struct pci_bus *bus)
+{
+	struct pci_config_window *cfg;
+
+	if (acpi_disabled)
+		return (struct loongson_pci *)(bus->sysdata);
+	else {
+		cfg = bus->sysdata;
+		return (struct loongson_pci *)(cfg->priv);
+	}
+}
+
 static void __iomem *cfg1_map(struct loongson_pci *priv, int bus,
 				unsigned int devfn, int where)
 {
@@ -119,8 +133,10 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus, unsigned int devf
 			       int where)
 {
 	unsigned char busnum = bus->number;
-	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
-	struct loongson_pci *priv =  pci_host_bridge_priv(bridge);
+	struct loongson_pci *priv = pci_bus_to_loongson_pci(bus);
+
+	if (pci_is_root_bus(bus))
+		busnum = 0;
 
 	/*
 	 * Do not read more than one device on the bus other than
@@ -141,6 +157,8 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus, unsigned int devf
 	return NULL;
 }
 
+#ifdef CONFIG_OF
+
 static int loongson_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	int irq;
@@ -242,3 +260,35 @@ static struct platform_driver loongson_pci_driver = {
 	.probe = loongson_pci_probe,
 };
 builtin_platform_driver(loongson_pci_driver);
+
+#endif
+
+#ifdef CONFIG_ACPI
+
+static int loongson_pci_ecam_init(struct pci_config_window *cfg)
+{
+	struct device *dev = cfg->parent;
+	struct loongson_pci *priv;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	cfg->priv = priv;
+	priv->flags = FLAG_CFG1 | FLAG_DEV_FIX,
+	priv->cfg1_base = cfg->win - (cfg->busr.start << 16);
+
+	return 0;
+}
+
+const struct pci_ecam_ops loongson_pci_ecam_ops = {
+	.bus_shift = 16,
+	.init	   = loongson_pci_ecam_init,
+	.pci_ops   = {
+		.map_bus = pci_loongson_map_bus,
+		.read	 = pci_generic_config_read,
+		.write	 = pci_generic_config_write,
+	}
+};
+
+#endif
diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
index adea5a4771cf..6b1301e2498e 100644
--- a/include/linux/pci-ecam.h
+++ b/include/linux/pci-ecam.h
@@ -87,6 +87,7 @@ extern const struct pci_ecam_ops xgene_v1_pcie_ecam_ops; /* APM X-Gene PCIe v1 *
 extern const struct pci_ecam_ops xgene_v2_pcie_ecam_ops; /* APM X-Gene PCIe v2.x */
 extern const struct pci_ecam_ops al_pcie_ops;	/* Amazon Annapurna Labs PCIe */
 extern const struct pci_ecam_ops tegra194_pcie_ops; /* Tegra194 PCIe */
+extern const struct pci_ecam_ops loongson_pci_ecam_ops; /* Loongson PCIe */
 #endif
 
 #if IS_ENABLED(CONFIG_PCI_HOST_COMMON)
-- 
2.27.0

