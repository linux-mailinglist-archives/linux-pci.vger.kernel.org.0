Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9583F95F8
	for <lists+linux-pci@lfdr.de>; Fri, 27 Aug 2021 10:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbhH0IX3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Aug 2021 04:23:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231922AbhH0IX3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Aug 2021 04:23:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12D3F60F58;
        Fri, 27 Aug 2021 08:22:38 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V9 3/5] PCI: Improve the MRRS quirk for LS7A
Date:   Fri, 27 Aug 2021 16:20:29 +0800
Message-Id: <20210827082031.2777623-4-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210827082031.2777623-1-chenhuacai@loongson.cn>
References: <20210827082031.2777623-1-chenhuacai@loongson.cn>
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
is configure MRRS of all devices in BIOS, and add a pci host bridge bit
flag (i.e., no_inc_mrrs) to stop the increasing MRRS operations.

However, according to PCIe Spec, it is legal for an OS to program any
value for MRRS, and it is also legal for an endpoint to generate a Read
Request with any size up to its MRRS. As the hardware engineers say, the
root cause here is LS7A doesn't break up large read requests. In detail,
LS7A PCIe port reports CA (Completer Abort) if it receives a Memory Read
request with a size that's "too big" ("too big" means larger than the
PCIe ports can handle, which means 256 for some ports and 4096 for the
others, and of course this is a problem in the LS7A's hardware design).

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/pci/controller/pci-loongson.c | 47 ++++++++++-----------------
 drivers/pci/pci.c                     |  6 ++++
 include/linux/pci.h                   |  1 +
 3 files changed, 25 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index 164c0f6e419f..3aa98f9e94a8 100644
--- a/drivers/pci/controller/pci-loongson.c
+++ b/drivers/pci/controller/pci-loongson.c
@@ -67,37 +67,26 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
 			DEV_LS7A_LPC, system_bus_quirk);
 
-static void loongson_mrrs_quirk(struct pci_dev *dev)
+static void loongson_mrrs_quirk(struct pci_dev *pdev)
 {
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
 }
-DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_mrrs_quirk);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
+			DEV_PCIE_PORT_0, loongson_mrrs_quirk);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
+			DEV_PCIE_PORT_1, loongson_mrrs_quirk);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
+			DEV_PCIE_PORT_2, loongson_mrrs_quirk);
 
 static struct loongson_pci *pci_bus_to_loongson_pci(struct pci_bus *bus)
 {
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index aacf575c15cf..3279da8ce2dd 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5800,6 +5800,7 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
 {
 	u16 v;
 	int ret;
+	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
 
 	if (rq < 128 || rq > 4096 || !is_power_of_2(rq))
 		return -EINVAL;
@@ -5818,6 +5819,11 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
 
 	v = (ffs(rq) - 8) << 12;
 
+	if (bridge->no_inc_mrrs) {
+		if (rq > pcie_get_readrq(dev))
+			return -EINVAL;
+	}
+
 	ret = pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
 						  PCI_EXP_DEVCTL_READRQ, v);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 540b377ca8f6..e2583c2785e2 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -541,6 +541,7 @@ struct pci_host_bridge {
 	void		*release_data;
 	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
 	unsigned int	no_ext_tags:1;		/* No Extended Tags */
+	unsigned int	no_inc_mrrs:1;		/* No Increase MRRS */
 	unsigned int	native_aer:1;		/* OS may use PCIe AER */
 	unsigned int	native_pcie_hotplug:1;	/* OS may use PCIe hotplug */
 	unsigned int	native_shpc_hotplug:1;	/* OS may use SHPC hotplug */
-- 
2.27.0

