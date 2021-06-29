Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7D83B6FC6
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jun 2021 10:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbhF2I6O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Jun 2021 04:58:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232491AbhF2I6N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jun 2021 04:58:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2DCAF613FE;
        Tue, 29 Jun 2021 08:55:44 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V5 3/4] PCI: Move loongson pci quirks to quirks.c
Date:   Tue, 29 Jun 2021 16:55:20 +0800
Message-Id: <20210629085521.2976352-4-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210629085521.2976352-1-chenhuacai@loongson.cn>
References: <20210629085521.2976352-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Loongson PCH (LS7A chipset) will be used by both MIPS-based and
LoongArch-based Loongson processors. MIPS-based Loongson uses FDT
but LoongArch-base Loongson uses ACPI, but the driver in drivers/
pci/controller/pci-loongson.c is FDT-only. So move the quirks to
quirks.c where can be shared by all architectures.

LoongArch is a new RISC ISA, mainline support will come soon, and
documentations are here (in translation):

https://github.com/loongson/LoongArch-Documentation

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/pci/controller/pci-loongson.c | 58 ---------------------------
 drivers/pci/quirks.c                  | 58 +++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 58 deletions(-)

diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index b02c98723f3b..88066e9db69e 100644
--- a/drivers/pci/controller/pci-loongson.c
+++ b/drivers/pci/controller/pci-loongson.c
@@ -12,15 +12,6 @@
 
 #include "../pci.h"
 
-/* Device IDs */
-#define DEV_PCIE_PORT_0	0x7a09
-#define DEV_PCIE_PORT_1	0x7a19
-#define DEV_PCIE_PORT_2	0x7a29
-
-#define DEV_LS2K_APB	0x7a02
-#define DEV_LS7A_CONF	0x7a10
-#define DEV_LS7A_LPC	0x7a0c
-
 #define FLAG_CFG0	BIT(0)
 #define FLAG_CFG1	BIT(1)
 #define FLAG_DEV_FIX	BIT(2)
@@ -32,55 +23,6 @@ struct loongson_pci {
 	u32 flags;
 };
 
-/* Fixup wrong class code in PCIe bridges */
-static void bridge_class_quirk(struct pci_dev *dev)
-{
-	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
-}
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
-			DEV_PCIE_PORT_0, bridge_class_quirk);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
-			DEV_PCIE_PORT_1, bridge_class_quirk);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
-			DEV_PCIE_PORT_2, bridge_class_quirk);
-
-static void system_bus_quirk(struct pci_dev *pdev)
-{
-	/*
-	 * The address space consumed by these devices is outside the
-	 * resources of the host bridge.
-	 */
-	pdev->mmio_always_on = 1;
-	pdev->non_compliant_bars = 1;
-}
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
-			DEV_LS2K_APB, system_bus_quirk);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
-			DEV_LS7A_CONF, system_bus_quirk);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
-			DEV_LS7A_LPC, system_bus_quirk);
-
-static void loongson_mrrs_quirk(struct pci_dev *pdev)
-{
-	/*
-	 * Some Loongson PCIe ports have h/w limitations of maximum read
-	 * request size. They can't handle anything larger than this. So
-	 * force this limit on any devices attached under these ports.
-	 */
-	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
-
-	if (!bridge)
-		return;
-
-	bridge->no_inc_mrrs = 1;
-}
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
-			DEV_PCIE_PORT_0, loongson_mrrs_quirk);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
-			DEV_PCIE_PORT_1, loongson_mrrs_quirk);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
-			DEV_PCIE_PORT_2, loongson_mrrs_quirk);
-
 static void __iomem *cfg1_map(struct loongson_pci *priv, int bus,
 				unsigned int devfn, int where)
 {
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 22b2bb1109c9..febc53943051 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -205,6 +205,64 @@ static void quirk_mmio_always_on(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_ANY_ID, PCI_ANY_ID,
 				PCI_CLASS_BRIDGE_HOST, 8, quirk_mmio_always_on);
 
+/* Device IDs */
+#define DEV_PCIE_PORT_0	0x7a09
+#define DEV_PCIE_PORT_1	0x7a19
+#define DEV_PCIE_PORT_2	0x7a29
+
+#define DEV_LS2K_APB	0x7a02
+#define DEV_LS7A_CONF	0x7a10
+#define DEV_LS7A_LPC	0x7a0c
+
+/* Fixup wrong class code in PCIe bridges */
+static void bridge_class_quirk(struct pci_dev *dev)
+{
+	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
+			DEV_PCIE_PORT_0, bridge_class_quirk);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
+			DEV_PCIE_PORT_1, bridge_class_quirk);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
+			DEV_PCIE_PORT_2, bridge_class_quirk);
+
+static void system_bus_quirk(struct pci_dev *pdev)
+{
+	/*
+	 * The address space consumed by these devices is outside the
+	 * resources of the host bridge.
+	 */
+	pdev->mmio_always_on = 1;
+	pdev->non_compliant_bars = 1;
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
+			DEV_LS2K_APB, system_bus_quirk);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
+			DEV_LS7A_CONF, system_bus_quirk);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
+			DEV_LS7A_LPC, system_bus_quirk);
+
+static void loongson_mrrs_quirk(struct pci_dev *pdev)
+{
+	/*
+	 * Some Loongson PCIe ports have h/w limitations of maximum read
+	 * request size. They can't handle anything larger than this. So
+	 * force this limit on any devices attached under these ports.
+	 */
+	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
+
+	if (!bridge)
+		return;
+
+	bridge->no_inc_mrrs = 1;
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
+			DEV_PCIE_PORT_0, loongson_mrrs_quirk);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
+			DEV_PCIE_PORT_1, loongson_mrrs_quirk);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
+			DEV_PCIE_PORT_2, loongson_mrrs_quirk);
+
 /*
  * The Mellanox Tavor device gives false positive parity errors.  Disable
  * parity error reporting.
-- 
2.27.0

