Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB4FA1361D2
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2020 21:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbgAIUdo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jan 2020 15:33:44 -0500
Received: from mga01.intel.com ([192.55.52.88]:37112 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727738AbgAIUdn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jan 2020 15:33:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 12:33:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,414,1571727600"; 
   d="scan'208";a="396206715"
Received: from unknown (HELO nsgsw-rhel7p6.lm.intel.com) ([10.232.116.226])
  by orsmga005.jf.intel.com with ESMTP; 09 Jan 2020 12:33:42 -0800
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <iommu@lists.linux-foundation.org>, <linux-pci@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <kbusch@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH v2 3/5] PCI: Introduce direct dma alias
Date:   Thu,  9 Jan 2020 07:30:54 -0700
Message-Id: <1578580256-3483-4-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578580256-3483-1-git-send-email-jonathan.derrick@intel.com>
References: <1578580256-3483-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The current dma alias implementation requires the aliased device be on
the same bus as the dma parent. This introduces an arch-specific
mechanism to point to an arbitrary struct device when doing mapping and
pci alias search.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 arch/x86/pci/common.c |  7 +++++++
 drivers/pci/pci.c     | 17 ++++++++++++++++-
 drivers/pci/search.c  |  9 +++++++++
 include/linux/pci.h   |  1 +
 4 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 1e59df0..565cc17 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -736,3 +736,10 @@ int pci_ext_cfg_avail(void)
 	else
 		return 0;
 }
+
+#if IS_ENABLED(CONFIG_VMD)
+struct device *pci_direct_dma_alias(struct pci_dev *dev)
+{
+	return to_pci_sysdata(dev->bus)->vmd_dev;
+}
+#endif
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ad746d9..e4269e9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6034,7 +6034,9 @@ bool pci_devs_are_dma_aliases(struct pci_dev *dev1, struct pci_dev *dev2)
 	return (dev1->dma_alias_mask &&
 		test_bit(dev2->devfn, dev1->dma_alias_mask)) ||
 	       (dev2->dma_alias_mask &&
-		test_bit(dev1->devfn, dev2->dma_alias_mask));
+		test_bit(dev1->devfn, dev2->dma_alias_mask)) ||
+	       (pci_direct_dma_alias(dev1) == &dev2->dev) ||
+	       (pci_direct_dma_alias(dev2) == &dev1->dev);
 }
 
 bool pci_device_is_present(struct pci_dev *pdev)
@@ -6058,6 +6060,19 @@ void pci_ignore_hotplug(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_ignore_hotplug);
 
+/**
+ * pci_direct_dma_alias - Get dma alias for pci device
+ * @dev: the PCI device that may have a dma alias
+ *
+ * Permits the platform to provide architecture-specific functionality to
+ * devices needing to alias dma to another device. This is the default
+ * implementation. Architecture implementations can override this.
+ */
+struct device __weak *pci_direct_dma_alias(struct pci_dev *dev)
+{
+	return NULL;
+}
+
 resource_size_t __weak pcibios_default_alignment(void)
 {
 	return 0;
diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index bade140..6d61209 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -32,6 +32,15 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
 	struct pci_bus *bus;
 	int ret;
 
+	if (unlikely(pci_direct_dma_alias(pdev))) {
+		struct device *dev = pci_direct_dma_alias(pdev);
+
+		if (dev_is_pci(dev))
+			pdev = to_pci_dev(dev);
+		return fn(pdev, PCI_DEVID(pdev->bus->number, pdev->devfn),
+			  data);
+	}
+
 	ret = fn(pdev, pci_dev_id(pdev), data);
 	if (ret)
 		return ret;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c393dff..82494d3 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1202,6 +1202,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 int pci_select_bars(struct pci_dev *dev, unsigned long flags);
 bool pci_device_is_present(struct pci_dev *pdev);
 void pci_ignore_hotplug(struct pci_dev *dev);
+struct device *pci_direct_dma_alias(struct pci_dev *dev);
 
 int __printf(6, 7) pci_request_irq(struct pci_dev *dev, unsigned int nr,
 		irq_handler_t handler, irq_handler_t thread_fn, void *dev_id,
-- 
1.8.3.1

