Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 940D5B16FC
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2019 03:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbfIMBOr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Sep 2019 21:14:47 -0400
Received: from mga12.intel.com ([192.55.52.136]:29376 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbfIMBOq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Sep 2019 21:14:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2019 18:14:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="197403705"
Received: from megha-z97x-ud7-th.sc.intel.com ([143.183.85.162])
  by orsmga002.jf.intel.com with ESMTP; 12 Sep 2019 18:14:43 -0700
From:   Megha Dey <megha.dey@linux.intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pci@vger.kernel.org, maz@kernel.org, bhelgaas@google.com,
        rafael@kernel.org, gregkh@linuxfoundation.org, tglx@linutronix.de,
        hpa@zytor.com, alex.williamson@redhat.com, jgg@mellanox.com
Cc:     ashok.raj@intel.com, megha.dey@intel.com, jacob.jun.pan@intel.com,
        Megha Dey <megha.dey@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Sanjay Kumar <sanjay.k.kumar@intel.com>
Subject: [RFC V1 3/7] x86/ims: Add support for a new IMS irq domain
Date:   Thu, 12 Sep 2019 18:32:04 -0700
Message-Id: <1568338328-22458-4-git-send-email-megha.dey@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568338328-22458-1-git-send-email-megha.dey@linux.intel.com>
References: <1568338328-22458-1-git-send-email-megha.dey@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch adds support for the creation of a new IMS irq domain. It
creates a new irq_chip associated with the IMS domain and adds the
necessary domain operations to it.

Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Megha Dey <megha.dey@linux.intel.com>
---
 arch/x86/include/asm/msi.h       |  4 ++
 arch/x86/kernel/apic/Makefile    |  1 +
 arch/x86/kernel/apic/ims.c       | 93 ++++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/apic/msi.c       |  4 +-
 drivers/vfio/mdev/mdev_core.c    |  6 +++
 drivers/vfio/mdev/mdev_private.h |  1 -
 include/linux/mdev.h             |  2 +
 7 files changed, 108 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/kernel/apic/ims.c

diff --git a/arch/x86/include/asm/msi.h b/arch/x86/include/asm/msi.h
index 25ddd09..51f9d25 100644
--- a/arch/x86/include/asm/msi.h
+++ b/arch/x86/include/asm/msi.h
@@ -11,4 +11,8 @@ int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
 
 void pci_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc);
 
+struct msi_domain_info;
+
+irq_hw_number_t msi_get_hwirq(struct msi_domain_info *info,
+						msi_alloc_info_t *arg);
 #endif /* _ASM_X86_MSI_H */
diff --git a/arch/x86/kernel/apic/Makefile b/arch/x86/kernel/apic/Makefile
index a6fcaf16..75a2270 100644
--- a/arch/x86/kernel/apic/Makefile
+++ b/arch/x86/kernel/apic/Makefile
@@ -12,6 +12,7 @@ obj-y				+= hw_nmi.o
 
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o
 obj-$(CONFIG_PCI_MSI)		+= msi.o
+obj-$(CONFIG_MSI_IMS)		+= ims.o
 obj-$(CONFIG_SMP)		+= ipi.o
 
 ifeq ($(CONFIG_X86_64),y)
diff --git a/arch/x86/kernel/apic/ims.c b/arch/x86/kernel/apic/ims.c
new file mode 100644
index 0000000..d9808a5
--- /dev/null
+++ b/arch/x86/kernel/apic/ims.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright © 2019 Intel Corporation.
+ *
+ * Author: Megha Dey <megha.dey@intel.com>
+ */
+
+#include <linux/dmar.h>
+#include <linux/irq.h>
+#include <linux/mdev.h>
+#include <linux/pci.h>
+
+/*
+ * Determine if a dev is mdev or not. Return NULL if not mdev device.
+ * Return mdev's parent dev if success.
+ */
+static inline struct device *mdev_to_parent(struct device *dev)
+{
+	struct device *ret = NULL;
+	struct device *(*fn)(struct device *dev);
+	struct bus_type *bus = symbol_get(mdev_bus_type);
+
+	if (bus && dev->bus == bus) {
+		fn = symbol_get(mdev_dev_to_parent_dev);
+		ret = fn(dev);
+		symbol_put(mdev_dev_to_parent_dev);
+		symbol_put(mdev_bus_type);
+	}
+
+	return ret;
+}
+
+static struct pci_dev *ims_get_pci_dev(struct device *dev)
+{
+	struct pci_dev *pdev;
+
+	if (dev_is_mdev(dev)) {
+		struct device *parent = mdev_to_parent(dev);
+
+		pdev = to_pci_dev(parent);
+	} else {
+		pdev = to_pci_dev(dev);
+	}
+
+	return pdev;
+}
+
+int dev_ims_prepare(struct irq_domain *domain, struct device *dev, int nvec,
+		    msi_alloc_info_t *arg)
+{
+	struct pci_dev *pdev = ims_get_pci_dev(dev);
+
+	init_irq_alloc_info(arg, NULL);
+	arg->msi_dev = pdev;
+	arg->type = X86_IRQ_ALLOC_TYPE_MSIX;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dev_ims_prepare);
+
+#ifdef CONFIG_IRQ_REMAP
+
+static struct msi_domain_ops dev_ims_domain_ops = {
+	.get_hwirq	= msi_get_hwirq,
+	.msi_prepare	= dev_ims_prepare,
+};
+
+static struct irq_chip dev_ims_ir_controller = {
+	.name			= "IR-DEV-IMS",
+	.irq_unmask		= dev_ims_unmask_irq,
+	.irq_mask		= dev_ims_mask_irq,
+	.irq_ack		= irq_chip_ack_parent,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_set_vcpu_affinity	= irq_chip_set_vcpu_affinity_parent,
+	.flags			= IRQCHIP_SKIP_SET_WAKE,
+	.irq_write_msi_msg	= dev_ims_write_msg,
+};
+
+static struct msi_domain_info ims_ir_domain_info = {
+	.flags		= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+			  MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX,
+	.ops		= &dev_ims_domain_ops,
+	.chip		= &dev_ims_ir_controller,
+	.handler	= handle_edge_irq,
+	.handler_name	= "edge",
+};
+
+struct irq_domain *arch_create_ims_irq_domain(struct irq_domain *parent)
+{
+	return pci_msi_create_irq_domain(NULL, &ims_ir_domain_info, parent);
+}
+
+#endif
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 435bcda..65da813 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -84,7 +84,7 @@ void native_teardown_msi_irq(unsigned int irq)
 	irq_domain_free_irqs(irq, 1);
 }
 
-static irq_hw_number_t pci_msi_get_hwirq(struct msi_domain_info *info,
+irq_hw_number_t msi_get_hwirq(struct msi_domain_info *info,
 					 msi_alloc_info_t *arg)
 {
 	return arg->msi_hwirq;
@@ -116,7 +116,7 @@ void pci_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
 EXPORT_SYMBOL_GPL(pci_msi_set_desc);
 
 static struct msi_domain_ops pci_msi_domain_ops = {
-	.get_hwirq	= pci_msi_get_hwirq,
+	.get_hwirq	= msi_get_hwirq,
 	.msi_prepare	= pci_msi_prepare,
 	.set_desc	= pci_msi_set_desc,
 };
diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
index b558d4c..cecc6a6 100644
--- a/drivers/vfio/mdev/mdev_core.c
+++ b/drivers/vfio/mdev/mdev_core.c
@@ -33,6 +33,12 @@ struct device *mdev_parent_dev(struct mdev_device *mdev)
 }
 EXPORT_SYMBOL(mdev_parent_dev);
 
+struct device *mdev_dev_to_parent_dev(struct device *dev)
+{
+	return to_mdev_device(dev)->parent->dev;
+}
+EXPORT_SYMBOL(mdev_dev_to_parent_dev);
+
 void *mdev_get_drvdata(struct mdev_device *mdev)
 {
 	return mdev->driver_data;
diff --git a/drivers/vfio/mdev/mdev_private.h b/drivers/vfio/mdev/mdev_private.h
index 7d92295..c21f130 100644
--- a/drivers/vfio/mdev/mdev_private.h
+++ b/drivers/vfio/mdev/mdev_private.h
@@ -36,7 +36,6 @@ struct mdev_device {
 };
 
 #define to_mdev_device(dev)	container_of(dev, struct mdev_device, dev)
-#define dev_is_mdev(d)		((d)->bus == &mdev_bus_type)
 
 struct mdev_type {
 	struct kobject kobj;
diff --git a/include/linux/mdev.h b/include/linux/mdev.h
index 0ce30ca..9dcbffe 100644
--- a/include/linux/mdev.h
+++ b/include/linux/mdev.h
@@ -144,5 +144,7 @@ void mdev_unregister_driver(struct mdev_driver *drv);
 struct device *mdev_parent_dev(struct mdev_device *mdev);
 struct device *mdev_dev(struct mdev_device *mdev);
 struct mdev_device *mdev_from_dev(struct device *dev);
+struct device *mdev_dev_to_parent_dev(struct device *dev);
 
+#define dev_is_mdev(d)          ((d)->bus == symbol_get(mdev_bus_type))
 #endif /* MDEV_H */
-- 
2.7.4

