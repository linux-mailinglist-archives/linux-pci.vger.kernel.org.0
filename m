Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B217F3B5C48
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jun 2021 12:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbhF1KPG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Jun 2021 06:15:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232802AbhF1KOi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Jun 2021 06:14:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1EA2E61982;
        Mon, 28 Jun 2021 10:12:10 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V4 3/4] PCI: Improve the MRRS quirk for LS7A
Date:   Mon, 28 Jun 2021 18:10:26 +0800
Message-Id: <20210628101027.1372370-4-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210628101027.1372370-1-chenhuacai@loongson.cn>
References: <20210628101027.1372370-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In new revision of LS7A, some PCIe ports support larger value than 256,
but their maximum supported MRRS values are not detectable. Moreover,
the current loongson_mrrs_quirk() cannot avoid devices increasing its
MRRS after pci_enable_device(), and some devices (e.g. Realtek 8169)
will actually set a big value in its driver. So the only possible way
is configure MRRS of all devices in BIOS, and add a PCI bus flag (i.e.,
PCI_BUS_FLAGS_NO_INC_MRRS) to stop the increasing MRRS operations.

However, according to PCIe Spec, it is legal for an OS to program any
value for MRRS, and it is also legal for an endpoint to generate a Read
Request with any size up to its MRRS. As the hardware engineers say, the
root cause here is LS7A doesn't break up large read requests. In detail,
LS7A PCIe port reports CA (Completer Abort) if it receives a Memory Read
request with a size that's "too big" (Yes, that is a problem in the LS7A
hardware design).

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/pci/pci.c    |  5 +++++
 drivers/pci/quirks.c | 41 +++++++++++------------------------------
 include/linux/pci.h  |  1 +
 3 files changed, 17 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8d4ebe095d0c..0f1ff4a6fe44 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5812,6 +5812,11 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
 
 	v = (ffs(rq) - 8) << 12;
 
+	if (dev->bus->bus_flags & PCI_BUS_FLAGS_NO_INC_MRRS) {
+		if (rq > pcie_get_readrq(dev))
+			return -EINVAL;
+	}
+
 	ret = pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
 						  PCI_EXP_DEVCTL_READRQ, v);
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index dee4798a49fc..4bbdf5a5425f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -242,37 +242,18 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
 			DEV_LS7A_LPC, loongson_system_bus_quirk);
 
-static void loongson_mrrs_quirk(struct pci_dev *dev)
-{
-	struct pci_bus *bus = dev->bus;
-	struct pci_dev *bridge;
-	static const struct pci_device_id bridge_devids[] = {
-		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_0) },
-		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_1) },
-		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_2) },
-		{ 0, },
-	};
-
-	/* look for the matching bridge */
-	while (!pci_is_root_bus(bus)) {
-		bridge = bus->self;
-		bus = bus->parent;
-		/*
-		 * Some Loongson PCIe ports have a h/w limitation of
-		 * 256 bytes maximum read request size. They can't handle
-		 * anything larger than this. So force this limit on
-		 * any devices attached under these ports.
-		 */
-		if (pci_match_id(bridge_devids, bridge)) {
-			if (pcie_get_readrq(dev) > 256) {
-				pci_info(dev, "limiting MRRS to 256\n");
-				pcie_set_readrq(dev, 256);
-			}
-			break;
-		}
-	}
+static void loongson_mrrs_quirk(struct pci_dev *pdev)
+{
+	/*
+	 * Some Loongson PCIe ports have h/w limitations of maximum read
+	 * request size. They can't handle anything larger than this. So
+	 * force this limit on any devices attached under these ports.
+	 */
+	pdev->subordinate->bus_flags |= PCI_BUS_FLAGS_NO_INC_MRRS;
 }
-DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_mrrs_quirk);
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_LOONGSON, DEV_PCIE_PORT_0, loongson_mrrs_quirk);
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_LOONGSON, DEV_PCIE_PORT_1, loongson_mrrs_quirk);
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_LOONGSON, DEV_PCIE_PORT_2, loongson_mrrs_quirk);
 
 /*
  * The Mellanox Tavor device gives false positive parity errors.  Disable
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 24306504226a..b336239b5282 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -240,6 +240,7 @@ enum pci_bus_flags {
 	PCI_BUS_FLAGS_NO_MMRBC	= (__force pci_bus_flags_t) 2,
 	PCI_BUS_FLAGS_NO_AERSID	= (__force pci_bus_flags_t) 4,
 	PCI_BUS_FLAGS_NO_EXTCFG	= (__force pci_bus_flags_t) 8,
+	PCI_BUS_FLAGS_NO_INC_MRRS = (__force pci_bus_flags_t) 16,
 };
 
 /* Values from Link Status register, PCIe r3.1, sec 7.8.8 */
-- 
2.27.0

