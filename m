Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 151742CDE0D
	for <lists+linux-pci@lfdr.de>; Thu,  3 Dec 2020 19:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731700AbgLCSwD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Dec 2020 13:52:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:33304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731649AbgLCSwC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Dec 2020 13:52:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Kishore <kthota@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Vidya Sagar <sagar.tv@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 1/3] PCI/MSI: Move MSI/MSI-X init to msi.c
Date:   Thu,  3 Dec 2020 12:51:08 -0600
Message-Id: <20201203185110.1583077-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201203185110.1583077-1-helgaas@kernel.org>
References: <20201203185110.1583077-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Move pci_msi_setup_pci_dev(), which disables MSI and MSI-X interrupts, from
probe.c to msi.c so it's with all the other MSI code and more consistent
with other capability initialization.  This means we must compile msi.c
always, even without CONFIG_PCI_MSI, so wrap the rest of msi.c in an #ifdef
and adjust the Makefile accordingly.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/Makefile |  3 +--
 drivers/pci/msi.c    | 36 ++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h    |  2 ++
 drivers/pci/probe.c  | 21 ++-------------------
 4 files changed, 41 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 522d2b974e91..11cc79411e2d 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -5,7 +5,7 @@
 obj-$(CONFIG_PCI)		+= access.o bus.o probe.o host-bridge.o \
 				   remove.o pci.o pci-driver.o search.o \
 				   pci-sysfs.o rom.o setup-res.o irq.o vpd.o \
-				   setup-bus.o vc.o mmap.o setup-irq.o
+				   setup-bus.o vc.o mmap.o setup-irq.o msi.o
 
 obj-$(CONFIG_PCI)		+= pcie/
 
@@ -18,7 +18,6 @@ endif
 obj-$(CONFIG_OF)		+= of.o
 obj-$(CONFIG_PCI_QUIRKS)	+= quirks.o
 obj-$(CONFIG_HOTPLUG_PCI)	+= hotplug/
-obj-$(CONFIG_PCI_MSI)		+= msi.o
 obj-$(CONFIG_PCI_ATS)		+= ats.o
 obj-$(CONFIG_PCI_IOV)		+= iov.o
 obj-$(CONFIG_PCI_BRIDGE_EMUL)	+= pci-bridge-emul.o
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index d52d118979a6..555791c0ee1a 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -26,6 +26,8 @@
 
 #include "pci.h"
 
+#ifdef CONFIG_MSI
+
 static int pci_msi_enable = 1;
 int pci_msi_ignore_mask;
 
@@ -1577,3 +1579,37 @@ bool pci_dev_has_special_msi_domain(struct pci_dev *pdev)
 }
 
 #endif /* CONFIG_PCI_MSI_IRQ_DOMAIN */
+#endif /* CONFIG_PCI_MSI */
+
+void pci_msi_init(struct pci_dev *dev)
+{
+	u16 ctrl;
+
+	/*
+	 * Disable the MSI hardware to avoid screaming interrupts
+	 * during boot.  This is the power on reset default so
+	 * usually this should be a noop.
+	 */
+	dev->msi_cap = pci_find_capability(dev, PCI_CAP_ID_MSI);
+	if (!dev->msi_cap)
+		return;
+
+	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &ctrl);
+	if (ctrl & PCI_MSI_FLAGS_ENABLE)
+		pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS,
+				      ctrl & ~PCI_MSI_FLAGS_ENABLE);
+}
+
+void pci_msix_init(struct pci_dev *dev)
+{
+	u16 ctrl;
+
+	dev->msix_cap = pci_find_capability(dev, PCI_CAP_ID_MSIX);
+	if (!dev->msix_cap)
+		return;
+
+	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &ctrl);
+	if (ctrl & PCI_MSIX_FLAGS_ENABLE)
+		pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS,
+				      ctrl & ~PCI_MSIX_FLAGS_ENABLE);
+}
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index f86cae9aa1f4..3f5f303775c4 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -104,6 +104,8 @@ void pci_config_pm_runtime_get(struct pci_dev *dev);
 void pci_config_pm_runtime_put(struct pci_dev *dev);
 void pci_pm_init(struct pci_dev *dev);
 void pci_ea_init(struct pci_dev *dev);
+void pci_msi_init(struct pci_dev *dev);
+void pci_msix_init(struct pci_dev *dev);
 void pci_allocate_cap_save_buffers(struct pci_dev *dev);
 void pci_free_cap_save_buffers(struct pci_dev *dev);
 bool pci_bridge_d3_possible(struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4289030b0fff..50b480c016bf 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1716,22 +1716,6 @@ static u8 pci_hdr_type(struct pci_dev *dev)
 
 #define LEGACY_IO_RESOURCE	(IORESOURCE_IO | IORESOURCE_PCI_FIXED)
 
-static void pci_msi_setup_pci_dev(struct pci_dev *dev)
-{
-	/*
-	 * Disable the MSI hardware to avoid screaming interrupts
-	 * during boot.  This is the power on reset default so
-	 * usually this should be a noop.
-	 */
-	dev->msi_cap = pci_find_capability(dev, PCI_CAP_ID_MSI);
-	if (dev->msi_cap)
-		pci_msi_set_enable(dev, 0);
-
-	dev->msix_cap = pci_find_capability(dev, PCI_CAP_ID_MSIX);
-	if (dev->msix_cap)
-		pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
-}
-
 /**
  * pci_intx_mask_broken - Test PCI_COMMAND_INTX_DISABLE writability
  * @dev: PCI device
@@ -2397,9 +2381,8 @@ void pcie_report_downtraining(struct pci_dev *dev)
 static void pci_init_capabilities(struct pci_dev *dev)
 {
 	pci_ea_init(dev);		/* Enhanced Allocation */
-
-	/* Setup MSI caps & disable MSI/MSI-X interrupts */
-	pci_msi_setup_pci_dev(dev);
+	pci_msi_init(dev);		/* Disable MSI */
+	pci_msix_init(dev);		/* Disable MSI-X */
 
 	/* Buffers for saving PCIe and PCI-X capabilities */
 	pci_allocate_cap_save_buffers(dev);
-- 
2.25.1

