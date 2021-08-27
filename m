Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E683F95FD
	for <lists+linux-pci@lfdr.de>; Fri, 27 Aug 2021 10:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244548AbhH0IYd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Aug 2021 04:24:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233066AbhH0IYd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Aug 2021 04:24:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE96260F92;
        Fri, 27 Aug 2021 08:23:42 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V9 5/5] PCI: Add quirk for multifunction devices of LS7A
Date:   Fri, 27 Aug 2021 16:20:31 +0800
Message-Id: <20210827082031.2777623-6-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210827082031.2777623-1-chenhuacai@loongson.cn>
References: <20210827082031.2777623-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jianmin Lv <lvjianmin@loongson.cn>

In LS7A, multifunction device use same PCI PIN (because the PIN register
report the same INTx value to each function) but we need different IRQ
for different functions, so add a quirk to fix it for standard PCI PIN
usage.

This patch only affect ACPI based systems (and only needed by ACPI based
systems, too). For DT based systems, the irq mappings is defined in .dts
files and be handled by of_irq_parse_pci().

Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/pci/controller/pci-loongson.c | 29 +++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index f90d4214e42f..36ad8e259126 100644
--- a/drivers/pci/controller/pci-loongson.c
+++ b/drivers/pci/controller/pci-loongson.c
@@ -22,6 +22,12 @@
 #define DEV_LS2K_APB	0x7a02
 #define DEV_LS7A_CONF	0x7a10
 #define DEV_LS7A_LPC	0x7a0c
+#define DEV_LS7A_GMAC	0x7a03
+#define DEV_LS7A_DC	0x7a06
+#define DEV_LS7A_GPU	0x7a15
+#define DEV_LS7A_AHCI	0x7a08
+#define DEV_LS7A_EHCI	0x7a14
+#define DEV_LS7A_OHCI	0x7a24
 
 #define FLAG_CFG0	BIT(0)
 #define FLAG_CFG1	BIT(1)
@@ -108,6 +114,29 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
 			DEV_PCIE_PORT_2, loongson_bmaster_quirk);
 
+static void loongson_pci_pin_quirk(struct pci_dev *pdev)
+{
+	pdev->pin = 1 + (PCI_FUNC(pdev->devfn) & 3);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
+			DEV_LS7A_DC, loongson_pci_pin_quirk);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
+			DEV_LS7A_GPU, loongson_pci_pin_quirk);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
+			DEV_LS7A_GMAC, loongson_pci_pin_quirk);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
+			DEV_LS7A_AHCI, loongson_pci_pin_quirk);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
+			DEV_LS7A_EHCI, loongson_pci_pin_quirk);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
+			DEV_LS7A_OHCI, loongson_pci_pin_quirk);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
+			DEV_PCIE_PORT_0, loongson_pci_pin_quirk);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
+			DEV_PCIE_PORT_1, loongson_pci_pin_quirk);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
+			DEV_PCIE_PORT_2, loongson_pci_pin_quirk);
+
 static struct loongson_pci *pci_bus_to_loongson_pci(struct pci_bus *bus)
 {
 	struct pci_config_window *cfg;
-- 
2.27.0

