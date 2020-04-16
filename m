Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7CB1ABC2A
	for <lists+linux-pci@lfdr.de>; Thu, 16 Apr 2020 11:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503321AbgDPJFg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Apr 2020 05:05:36 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2340 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2503247AbgDPJFZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Apr 2020 05:05:25 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EFE111020100B4DE5976;
        Thu, 16 Apr 2020 17:05:02 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Thu, 16 Apr 2020 17:04:53 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
CC:     <kvalo@codeaurora.org>, <andreas.noever@gmail.com>,
        <rjw@rjwysocki.net>, <linux-wireless@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linuxarm@huawei.com>,
        <yangyicong@hisilicon.com>
Subject: [PATCH] PCI: Use pci_pcie_find_root_port() to get root port
Date:   Thu, 16 Apr 2020 17:04:53 +0800
Message-ID: <1587027893-56628-1-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Previously we use pcie_find_root_port() to get root port from a pcie
device, use pci_find_pcie_root_port() to get root port from a pci
device, which increase the complexity.

Unify the two functions and use pci_pcie_find_root_port() to get root
port from both pci device and pcie device. Then there is not need to
distinguish the type of the device.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Acked-by: Kalle Valo <kvalo@codeaurora.org> // for wireless
---
This Patch convert previous RFC patch to formal one. And add
Kalle's Acked-by.

Link:https://lore.kernel.org/linux-pci/1586262717-23566-1-git-send-email-yangyicong@hisilicon.com/

 drivers/net/wireless/intel/iwlwifi/pcie/trans.c |  2 +-
 drivers/pci/pci-acpi.c                          |  4 ++--
 drivers/pci/pci.c                               | 24 ------------------------
 drivers/pci/pcie/aer_inject.c                   |  2 +-
 drivers/pci/probe.c                             |  2 +-
 drivers/pci/quirks.c                            |  2 +-
 drivers/thunderbolt/switch.c                    |  4 ++--
 include/linux/pci.h                             | 14 +++++++-------
 8 files changed, 15 insertions(+), 39 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 38d8fe2..556cb8c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -158,7 +158,7 @@ void iwl_trans_pcie_dump_regs(struct iwl_trans *trans)

 	/* Print root port AER registers */
 	pos = 0;
-	pdev = pcie_find_root_port(pdev);
+	pdev = pci_pcie_find_root_port(pdev);
 	if (pdev)
 		pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
 	if (pos) {
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 0c02d50..9316533 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -246,7 +246,7 @@ static acpi_status decode_type1_hpx_record(union acpi_object *record,

 static bool pcie_root_rcb_set(struct pci_dev *dev)
 {
-	struct pci_dev *rp = pcie_find_root_port(dev);
+	struct pci_dev *rp = pci_pcie_find_root_port(dev);
 	u16 lnkctl;

 	if (!rp)
@@ -948,7 +948,7 @@ static bool acpi_pci_bridge_d3(struct pci_dev *dev)
 	 * Look for a special _DSD property for the root port and if it
 	 * is set we know the hierarchy behind it supports D3 just fine.
 	 */
-	root = pci_find_pcie_root_port(dev);
+	root = pci_pcie_find_root_port(dev);
 	if (!root)
 		return false;

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d828ca8..fc5e7b6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -695,30 +695,6 @@ struct resource *pci_find_resource(struct pci_dev *dev, struct resource *res)
 EXPORT_SYMBOL(pci_find_resource);

 /**
- * pci_find_pcie_root_port - return PCIe Root Port
- * @dev: PCI device to query
- *
- * Traverse up the parent chain and return the PCIe Root Port PCI Device
- * for a given PCI Device.
- */
-struct pci_dev *pci_find_pcie_root_port(struct pci_dev *dev)
-{
-	struct pci_dev *bridge, *highest_pcie_bridge = dev;
-
-	bridge = pci_upstream_bridge(dev);
-	while (bridge && pci_is_pcie(bridge)) {
-		highest_pcie_bridge = bridge;
-		bridge = pci_upstream_bridge(bridge);
-	}
-
-	if (pci_pcie_type(highest_pcie_bridge) != PCI_EXP_TYPE_ROOT_PORT)
-		return NULL;
-
-	return highest_pcie_bridge;
-}
-EXPORT_SYMBOL(pci_find_pcie_root_port);
-
-/**
  * pci_wait_for_pending - wait for @mask bit(s) to clear in status word @pos
  * @dev: the PCI device to operate on
  * @pos: config space offset of status word
diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
index 6988fe7..c3bfc1b5 100644
--- a/drivers/pci/pcie/aer_inject.c
+++ b/drivers/pci/pcie/aer_inject.c
@@ -332,7 +332,7 @@ static int aer_inject(struct aer_error_inj *einj)
 	dev = pci_get_domain_bus_and_slot(einj->domain, einj->bus, devfn);
 	if (!dev)
 		return -ENODEV;
-	rpdev = pcie_find_root_port(dev);
+	rpdev = pci_pcie_find_root_port(dev);
 	if (!rpdev) {
 		pci_err(dev, "Root port not found\n");
 		ret = -ENODEV;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 512cb43..50f7733 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2015,7 +2015,7 @@ static void pci_configure_relaxed_ordering(struct pci_dev *dev)
 	 * For now, we only deal with Relaxed Ordering issues with Root
 	 * Ports. Peer-to-Peer DMA is another can of worms.
 	 */
-	root = pci_find_pcie_root_port(dev);
+	root = pci_pcie_find_root_port(dev);
 	if (!root)
 		return;

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 29f473e..ac62675 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4253,7 +4253,7 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_AMD, 0x1a02, PCI_CLASS_NOT_DEFINED,
  */
 static void quirk_disable_root_port_attributes(struct pci_dev *pdev)
 {
-	struct pci_dev *root_port = pci_find_pcie_root_port(pdev);
+	struct pci_dev *root_port = pci_pcie_find_root_port(pdev);

 	if (!root_port) {
 		pci_warn(pdev, "PCIe Completion erratum may cause device errors\n");
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index a2ce990..90844c1 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -263,7 +263,7 @@ static void nvm_authenticate_start_dma_port(struct tb_switch *sw)
 	 * itself. To be on the safe side keep the root port in D0 during
 	 * the whole upgrade process.
 	 */
-	root_port = pci_find_pcie_root_port(sw->tb->nhi->pdev);
+	root_port = pci_pcie_find_root_port(sw->tb->nhi->pdev);
 	if (root_port)
 		pm_runtime_get_noresume(&root_port->dev);
 }
@@ -272,7 +272,7 @@ static void nvm_authenticate_complete_dma_port(struct tb_switch *sw)
 {
 	struct pci_dev *root_port;

-	root_port = pci_find_pcie_root_port(sw->tb->nhi->pdev);
+	root_port = pci_pcie_find_root_port(sw->tb->nhi->pdev);
 	if (root_port)
 		pm_runtime_put(&root_port->dev);
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 3840a54..b341ca30 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1011,7 +1011,6 @@ void pci_bus_add_device(struct pci_dev *dev);
 void pci_read_bridge_bases(struct pci_bus *child);
 struct resource *pci_find_parent_resource(const struct pci_dev *dev,
 					  struct resource *res);
-struct pci_dev *pci_find_pcie_root_port(struct pci_dev *dev);
 u8 pci_swizzle_interrupt_pin(const struct pci_dev *dev, u8 pin);
 int pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge);
 u8 pci_common_swizzle(struct pci_dev *dev, u8 *pinp);
@@ -2124,15 +2123,16 @@ static inline int pci_pcie_type(const struct pci_dev *dev)
 	return (pcie_caps_reg(dev) & PCI_EXP_FLAGS_TYPE) >> 4;
 }

-static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
+/**
+ * pci_pcie_find_root_port - Get the PCIe root port device
+ * @dev: PCI device
+ */
+static inline struct pci_dev *pci_pcie_find_root_port(struct pci_dev *dev)
 {
-	while (1) {
-		if (!pci_is_pcie(dev))
-			break;
+	dev = pci_physfn(dev);
+	while (dev) {
 		if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
 			return dev;
-		if (!dev->bus->self)
-			break;
 		dev = dev->bus->self;
 	}
 	return NULL;
--
2.8.1

