Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEEA137A1C
	for <lists+linux-pci@lfdr.de>; Sat, 11 Jan 2020 00:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgAJXYF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jan 2020 18:24:05 -0500
Received: from mga09.intel.com ([134.134.136.24]:46412 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727442AbgAJXYF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Jan 2020 18:24:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 15:24:05 -0800
X-IronPort-AV: E=Sophos;i="5.69,418,1571727600"; 
   d="scan'208";a="212412164"
Received: from unknown (HELO nsgsw-rhel7p6.lm.intel.com) ([10.232.116.226])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 15:24:03 -0800
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <iommu@lists.linux-foundation.org>, <linux-pci@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <kbusch@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH v3 3/5] PCI: Introduce pci_direct_dma_alias()
Date:   Fri, 10 Jan 2020 10:21:11 -0700
Message-Id: <1578676873-6206-4-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578676873-6206-1-git-send-email-jonathan.derrick@intel.com>
References: <1578676873-6206-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The current DMA alias implementation requires the aliased device be on
the same PCI bus as the requester ID. This introduces an arch-specific
mechanism to point to another PCI device when doing mapping and
PCI DMA alias search.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 arch/x86/pci/common.c |  7 +++++++
 drivers/pci/pci.c     | 19 ++++++++++++++++++-
 drivers/pci/search.c  |  7 +++++++
 include/linux/pci.h   |  1 +
 4 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 1e59df0..83334a5 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -736,3 +736,10 @@ int pci_ext_cfg_avail(void)
 	else
 		return 0;
 }
+
+#if IS_ENABLED(CONFIG_VMD)
+struct pci_dev *pci_direct_dma_alias(struct pci_dev *dev)
+{
+	return to_pci_sysdata(dev->bus)->vmd_dev;
+}
+#endif
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ad746d9..1362694 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6034,7 +6034,9 @@ bool pci_devs_are_dma_aliases(struct pci_dev *dev1, struct pci_dev *dev2)
 	return (dev1->dma_alias_mask &&
 		test_bit(dev2->devfn, dev1->dma_alias_mask)) ||
 	       (dev2->dma_alias_mask &&
-		test_bit(dev1->devfn, dev2->dma_alias_mask));
+		test_bit(dev1->devfn, dev2->dma_alias_mask)) ||
+	       (pci_direct_dma_alias(dev1) == dev2) ||
+	       (pci_direct_dma_alias(dev2) == dev1);
 }
 
 bool pci_device_is_present(struct pci_dev *pdev)
@@ -6058,6 +6060,21 @@ void pci_ignore_hotplug(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_ignore_hotplug);
 
+/**
+ * pci_direct_dma_alias - Get PCI DMA alias for PCI device
+ * @dev: the PCI device that may have a PCI DMA alias
+ *
+ * Permits the platform to provide architecture-specific functionality to
+ * devices needing to alias DMA to another PCI device on another PCI bus. If
+ * the PCI device is on the same bus, it is recommended to use
+ * pci_add_dma_alias(). This is the default implementation. Architecture
+ * implementations can override this.
+ */
+struct pci_dev __weak *pci_direct_dma_alias(struct pci_dev *dev)
+{
+	return NULL;
+}
+
 resource_size_t __weak pcibios_default_alignment(void)
 {
 	return 0;
diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index bade140..12811b3 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -32,6 +32,13 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
 	struct pci_bus *bus;
 	int ret;
 
+	/*
+	 * The device may have an explicit alias requester ID for DMA where the
+	 * requester is on another PCI bus.
+	 */
+	if (unlikely(pci_direct_dma_alias(pdev)))
+		pdev = pci_direct_dma_alias(pdev);
+
 	ret = fn(pdev, pci_dev_id(pdev), data);
 	if (ret)
 		return ret;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c393dff..cb6677b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1202,6 +1202,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 int pci_select_bars(struct pci_dev *dev, unsigned long flags);
 bool pci_device_is_present(struct pci_dev *pdev);
 void pci_ignore_hotplug(struct pci_dev *dev);
+struct pci_dev *pci_direct_dma_alias(struct pci_dev *dev);
 
 int __printf(6, 7) pci_request_irq(struct pci_dev *dev, unsigned int nr,
 		irq_handler_t handler, irq_handler_t thread_fn, void *dev_id,
-- 
1.8.3.1

