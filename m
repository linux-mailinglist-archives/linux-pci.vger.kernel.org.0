Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0279E563F2C
	for <lists+linux-pci@lfdr.de>; Sat,  2 Jul 2022 11:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiGBJJh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 2 Jul 2022 05:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbiGBJJg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 2 Jul 2022 05:09:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591F01ADBA
        for <linux-pci@vger.kernel.org>; Sat,  2 Jul 2022 02:09:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7E1160AF0
        for <linux-pci@vger.kernel.org>; Sat,  2 Jul 2022 09:09:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A81C34114;
        Sat,  2 Jul 2022 09:09:30 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     linux-pci@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V15 3/7] PCI: loongson: Add ACPI init support
Date:   Sat,  2 Jul 2022 17:08:04 +0800
Message-Id: <20220702090808.1221300-4-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220702090808.1221300-1-chenhuacai@loongson.cn>
References: <20220702090808.1221300-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 drivers/acpi/pci_mcfg.c               | 10 +++++
 drivers/pci/controller/Kconfig        |  2 +-
 drivers/pci/controller/pci-loongson.c | 62 +++++++++++++++++++++++++--
 include/linux/pci-ecam.h              |  1 +
 4 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
index 63b98eae5e75..860014b89b8e 100644
--- a/drivers/acpi/pci_mcfg.c
+++ b/drivers/acpi/pci_mcfg.c
@@ -172,6 +172,16 @@ static struct mcfg_fixup mcfg_quirks[] = {
 	ALTRA_ECAM_QUIRK(1, 14),
 	ALTRA_ECAM_QUIRK(1, 15),
 #endif /* ARM64 */
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
index b8d96d38064d..9dbd73898b47 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -293,7 +293,7 @@ config PCI_HYPERV_INTERFACE
 config PCI_LOONGSON
 	bool "LOONGSON PCI Controller"
 	depends on MACH_LOONGSON64 || COMPILE_TEST
-	depends on OF
+	depends on OF || ACPI
 	depends on PCI_QUIRKS
 	default MACH_LOONGSON64
 	help
diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index 565453882ffe..a1222fc15454 100644
--- a/drivers/pci/controller/pci-loongson.c
+++ b/drivers/pci/controller/pci-loongson.c
@@ -9,6 +9,8 @@
 #include <linux/of_pci.h>
 #include <linux/pci.h>
 #include <linux/pci_ids.h>
+#include <linux/pci-acpi.h>
+#include <linux/pci-ecam.h>
 
 #include "../pci.h"
 
@@ -97,6 +99,18 @@ static void loongson_mrrs_quirk(struct pci_dev *dev)
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
@@ -124,12 +138,14 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus, unsigned int devf
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
-	 * the host bus. For our hardware the root bus is always bus 0.
+	 * the host bus.
 	 */
 	if (priv->data->flags & FLAG_DEV_FIX &&
 			!pci_is_root_bus(bus) && PCI_SLOT(devfn) > 0)
@@ -146,6 +162,8 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus, unsigned int devf
 	return NULL;
 }
 
+#ifdef CONFIG_OF
+
 static int loongson_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	int irq;
@@ -259,3 +277,41 @@ static struct platform_driver loongson_pci_driver = {
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
+	struct loongson_pci_data *data;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	cfg->priv = priv;
+	data->flags = FLAG_CFG1;
+	priv->data = data;
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

