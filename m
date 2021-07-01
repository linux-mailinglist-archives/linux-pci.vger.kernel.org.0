Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27B93B8E5A
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jul 2021 09:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbhGAHtN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jul 2021 03:49:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229906AbhGAHtM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Jul 2021 03:49:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C15561490;
        Thu,  1 Jul 2021 07:46:40 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V6 4/4] PCI: Add quirk for multifunction devices of LS7A
Date:   Thu,  1 Jul 2021 15:44:58 +0800
Message-Id: <20210701074458.1809532-5-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210701074458.1809532-1-chenhuacai@loongson.cn>
References: <20210701074458.1809532-1-chenhuacai@loongson.cn>
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
 drivers/pci/quirks.c    | 23 +++++++++++++++++++++++
 include/linux/pci_ids.h | 11 +++++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b1a13d8fe3b6..f52f203c4209 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -284,6 +284,29 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
 			DEV_PCIE_PORT_2, loongson_bmaster_quirk);
 
+static void loongson_pci_pin_quirk(struct pci_dev *pdev)
+{
+	pdev->pin = 1 + (PCI_FUNC(pdev->devfn) & 3);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
+			DEV_PCIE_PORT_0, loongson_pci_pin_quirk);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
+			DEV_PCIE_PORT_1, loongson_pci_pin_quirk);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
+			DEV_PCIE_PORT_2, loongson_pci_pin_quirk);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
+			PCI_DEVICE_ID_LOONGSON_AHCI, loongson_pci_pin_quirk);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
+			PCI_DEVICE_ID_LOONGSON_EHCI, loongson_pci_pin_quirk);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
+			PCI_DEVICE_ID_LOONGSON_OHCI, loongson_pci_pin_quirk);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
+			PCI_DEVICE_ID_LOONGSON_DC, loongson_pci_pin_quirk);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
+			PCI_DEVICE_ID_LOONGSON_GPU, loongson_pci_pin_quirk);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
+			PCI_DEVICE_ID_LOONGSON_GMAC, loongson_pci_pin_quirk);
+
 /*
  * The Mellanox Tavor device gives false positive parity errors.  Disable
  * parity error reporting.
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 4bac1831de80..17b2ab059176 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -151,6 +151,17 @@
 /* Vendors and devices.  Sort key: vendor first, device next. */
 
 #define PCI_VENDOR_ID_LOONGSON		0x0014
+#define PCI_DEVICE_ID_LOONGSON_HOST     0x7a00
+#define PCI_DEVICE_ID_LOONGSON_APB      0x7a02
+#define PCI_DEVICE_ID_LOONGSON_GMAC     0x7a03
+#define PCI_DEVICE_ID_LOONGSON_DC       0x7a06
+#define PCI_DEVICE_ID_LOONGSON_HDA      0x7a07
+#define PCI_DEVICE_ID_LOONGSON_GPU      0x7a15
+#define PCI_DEVICE_ID_LOONGSON_AHCI     0x7a08
+#define PCI_DEVICE_ID_LOONGSON_EHCI     0x7a14
+#define PCI_DEVICE_ID_LOONGSON_OHCI     0x7a24
+#define PCI_DEVICE_ID_LOONGSON_LPC      0x7a0c
+#define PCI_DEVICE_ID_LOONGSON_DMA      0x7a0f
 
 #define PCI_VENDOR_ID_TTTECH		0x0357
 #define PCI_DEVICE_ID_TTTECH_MC322	0x000a
-- 
2.27.0

