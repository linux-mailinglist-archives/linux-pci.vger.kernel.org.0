Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1843114141E
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2020 23:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgAQWaf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jan 2020 17:30:35 -0500
Received: from mga03.intel.com ([134.134.136.65]:34037 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbgAQWaf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Jan 2020 17:30:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 14:30:30 -0800
X-IronPort-AV: E=Sophos;i="5.70,331,1574150400"; 
   d="scan'208";a="219052210"
Received: from nsgsw-rhel7p6.lm.intel.com ([10.232.116.83])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 14:30:29 -0800
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     <iommu@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH v4 3/7] PCI: Introduce pci_real_dma_dev()
Date:   Fri, 17 Jan 2020 09:27:25 -0700
Message-Id: <1579278449-174098-4-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579278449-174098-1-git-send-email-jonathan.derrick@intel.com>
References: <1579278449-174098-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The current DMA alias implementation requires the aliased device be on
the same PCI bus as the requester ID. This introduces an arch-specific
mechanism to point to another PCI device when doing mapping and
PCI DMA alias search. The default case returns the actual device.

CC: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 arch/x86/pci/common.c | 10 ++++++++++
 drivers/pci/pci.c     | 19 ++++++++++++++++++-
 drivers/pci/search.c  |  6 ++++++
 include/linux/pci.h   |  1 +
 4 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 1e59df0..fe21a5c 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -736,3 +736,13 @@ int pci_ext_cfg_avail(void)
 	else
 		return 0;
 }
+
+#if IS_ENABLED(CONFIG_VMD)
+struct pci_dev *pci_real_dma_dev(struct pci_dev *dev)
+{
+	if (is_vmd(dev->bus))
+		return to_pci_sysdata(dev->bus)->vmd_dev;
+
+	return dev;
+}
+#endif
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 581b177..36d24f2 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6048,7 +6048,9 @@ bool pci_devs_are_dma_aliases(struct pci_dev *dev1, struct pci_dev *dev2)
 	return (dev1->dma_alias_mask &&
 		test_bit(dev2->devfn, dev1->dma_alias_mask)) ||
 	       (dev2->dma_alias_mask &&
-		test_bit(dev1->devfn, dev2->dma_alias_mask));
+		test_bit(dev1->devfn, dev2->dma_alias_mask)) ||
+	       pci_real_dma_dev(dev1) == dev2 ||
+	       pci_real_dma_dev(dev2) == dev1;
 }
 
 bool pci_device_is_present(struct pci_dev *pdev)
@@ -6072,6 +6074,21 @@ void pci_ignore_hotplug(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_ignore_hotplug);
 
+/**
+ * pci_real_dma_dev - Get PCI DMA device for PCI device
+ * @dev: the PCI device that may have a PCI DMA alias
+ *
+ * Permits the platform to provide architecture-specific functionality to
+ * devices needing to alias DMA to another PCI device on another PCI bus. If
+ * the PCI device is on the same bus, it is recommended to use
+ * pci_add_dma_alias(). This is the default implementation. Architecture
+ * implementations can override this.
+ */
+struct pci_dev __weak *pci_real_dma_dev(struct pci_dev *dev)
+{
+	return dev;
+}
+
 resource_size_t __weak pcibios_default_alignment(void)
 {
 	return 0;
diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index e4dbdef..2061672 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -32,6 +32,12 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
 	struct pci_bus *bus;
 	int ret;
 
+	/*
+	 * The device may have an explicit alias requester ID for DMA where the
+	 * requester is on another PCI bus.
+	 */
+	pdev = pci_real_dma_dev(pdev);
+
 	ret = fn(pdev, pci_dev_id(pdev), data);
 	if (ret)
 		return ret;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 930fab2..3840a54 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1202,6 +1202,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 int pci_select_bars(struct pci_dev *dev, unsigned long flags);
 bool pci_device_is_present(struct pci_dev *pdev);
 void pci_ignore_hotplug(struct pci_dev *dev);
+struct pci_dev *pci_real_dma_dev(struct pci_dev *dev);
 
 int __printf(6, 7) pci_request_irq(struct pci_dev *dev, unsigned int nr,
 		irq_handler_t handler, irq_handler_t thread_fn, void *dev_id,
-- 
1.8.3.1

