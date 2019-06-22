Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E40744F191
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2019 01:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfFUX5j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jun 2019 19:57:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:48779 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbfFUX5Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Jun 2019 19:57:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2019 16:57:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,402,1557212400"; 
   d="scan'208";a="359022894"
Received: from megha-z97x-ud7-th.sc.intel.com ([143.183.85.162])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jun 2019 16:57:21 -0700
From:   Megha Dey <megha.dey@linux.intel.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, marc.zyngier@arm.com, ashok.raj@intel.com,
        jacob.jun.pan@linux.intel.com, megha.dey@intel.com,
        Megha Dey <megha.dey@linux.intel.com>
Subject: [RFC V1 RESEND 5/6] PCI/MSI: Free MSI-X resources by group
Date:   Fri, 21 Jun 2019 17:19:37 -0700
Message-Id: <1561162778-12669-6-git-send-email-megha.dey@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561162778-12669-1-git-send-email-megha.dey@linux.intel.com>
References: <1561162778-12669-1-git-send-email-megha.dey@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently, the pci_free_irq_vectors() frees all the allocated resources
associated with a PCIe device when the device is being shut down. With
the introduction of dynamic allocation of MSI-X vectors by group ID,
there should exist an API which can free the resources allocated only
to a particular group, which can be called even if the device is not
being shut down. The pci_free_irq_vectors_grp() function provides this
type of interface.

The existing pci_free_irq_vectors() can be called along side this API.

Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Megha Dey <megha.dey@linux.intel.com>
---
 drivers/pci/msi.c   | 130 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/msi.h |   2 +
 include/linux/pci.h |   9 ++++
 kernel/irq/msi.c    |  26 +++++++++++
 4 files changed, 167 insertions(+)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index e947243..342e267 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -53,9 +53,23 @@ static void pci_msi_teardown_msi_irqs(struct pci_dev *dev)
 	else
 		arch_teardown_msi_irqs(dev);
 }
+
+static void pci_msi_teardown_msi_irqs_grp(struct pci_dev *dev, int group_id)
+{
+	struct irq_domain *domain;
+
+	domain = dev_get_msi_domain(&dev->dev);
+
+	if (domain && irq_domain_is_hierarchy(domain))
+		msi_domain_free_irqs_grp(domain, &dev->dev, group_id);
+	else
+		arch_teardown_msi_irqs_grp(dev, group_id);
+}
+
 #else
 #define pci_msi_setup_msi_irqs		arch_setup_msi_irqs
 #define pci_msi_teardown_msi_irqs	arch_teardown_msi_irqs
+#define pci_msi_teardown_msi_irqs_grp	default_teardown_msi_irqs_grp
 #endif
 
 /* Arch hooks */
@@ -373,6 +387,7 @@ static void free_msi_irqs(struct pci_dev *dev)
 
 	list_for_each_entry_safe(entry, tmp, msi_list, list) {
 		if (entry->msi_attrib.is_msix) {
+			clear_bit(entry->msi_attrib.entry_nr, dev->entry);
 			if (list_is_last(&entry->list, msi_list))
 				iounmap(entry->mask_base);
 		}
@@ -381,6 +396,8 @@ static void free_msi_irqs(struct pci_dev *dev)
 		free_msi_entry(entry);
 	}
 
+	idr_destroy(dev->grp_idr);
+
 	if (dev->msi_irq_groups) {
 		sysfs_remove_groups(&dev->dev.kobj, dev->msi_irq_groups);
 		msi_attrs = dev->msi_irq_groups[0]->attrs;
@@ -398,6 +415,60 @@ static void free_msi_irqs(struct pci_dev *dev)
 	}
 }
 
+static const char msix_sysfs_grp[] = "msi_irqs";
+
+static int free_msi_irqs_grp(struct pci_dev *dev, int group_id)
+{
+	struct list_head *msi_list = dev_to_msi_list(&dev->dev);
+	struct msi_desc *entry, *tmp;
+	struct attribute **msi_attrs;
+	struct device_attribute *dev_attr;
+	int i;
+	long vec;
+	struct msix_sysfs *msix_sysfs_entry, *tmp_msix;
+	struct list_head *pci_msix = &dev->msix_sysfs;
+	int num_vec = 0;
+
+	for_each_pci_msi_entry(entry, dev) {
+		if (entry->group_id == group_id && entry->irq)
+			for (i = 0; i < entry->nvec_used; i++)
+				BUG_ON(irq_has_action(entry->irq + i));
+	}
+
+	pci_msi_teardown_msi_irqs_grp(dev, group_id);
+
+	list_for_each_entry_safe(entry, tmp, msi_list, list) {
+		if (entry->group_id == group_id) {
+			clear_bit(entry->msi_attrib.entry_nr, dev->entry);
+			list_del(&entry->list);
+			free_msi_entry(entry);
+		}
+	}
+
+	list_for_each_entry_safe(msix_sysfs_entry, tmp_msix, pci_msix, list) {
+		if (msix_sysfs_entry->group_id == group_id) {
+			msi_attrs = msix_sysfs_entry->msi_irq_group->attrs;
+			for (i = 0; i < msix_sysfs_entry->vecs_in_grp; i++) {
+				if (!i)
+					num_vec = msix_sysfs_entry->vecs_in_grp;
+				dev_attr = container_of(msi_attrs[i],
+						struct device_attribute, attr);
+				sysfs_remove_file_from_group(&dev->dev.kobj,
+					&dev_attr->attr, msix_sysfs_grp);
+				if (kstrtol(dev_attr->attr.name, 10, &vec))
+					return -EINVAL;
+				kfree(dev_attr->attr.name);
+				kfree(dev_attr);
+			}
+			msix_sysfs_entry->msi_irq_group = NULL;
+			list_del(&msix_sysfs_entry->list);
+			idr_remove(dev->grp_idr, group_id);
+			kfree(msix_sysfs_entry);
+		}
+	}
+	return num_vec;
+}
+
 static void pci_intx_for_msi(struct pci_dev *dev, int enable)
 {
 	if (!(dev->dev_flags & PCI_DEV_FLAGS_MSI_INTX_DISABLE_BUG))
@@ -1052,6 +1123,45 @@ void pci_disable_msix(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pci_disable_msix);
 
+static void pci_msix_shutdown_grp(struct pci_dev *dev, int group_id)
+{
+	struct msi_desc *entry;
+	int grp_present = 0;
+
+	if (pci_dev_is_disconnected(dev)) {
+		dev->msix_enabled = 0;
+		return;
+	}
+
+	/* Return the device with MSI-X masked as initial states */
+	for_each_pci_msi_entry(entry, dev) {
+		if (entry->group_id == group_id) {
+			/* Keep cached states to be restored */
+			__pci_msix_desc_mask_irq(entry, 1);
+			grp_present = 1;
+		}
+	}
+
+	if (!grp_present) {
+		pci_err(dev, "Group to be disabled not present\n");
+		return;
+	}
+}
+
+int pci_disable_msix_grp(struct pci_dev *dev, int group_id)
+{
+	int num_vecs;
+
+	if (!pci_msi_enable || !dev)
+		return -EINVAL;
+
+	pci_msix_shutdown_grp(dev, group_id);
+	num_vecs = free_msi_irqs_grp(dev, group_id);
+
+	return num_vecs;
+}
+EXPORT_SYMBOL(pci_disable_msix_grp);
+
 void pci_no_msi(void)
 {
 	pci_msi_enable = 0;
@@ -1356,6 +1466,26 @@ void pci_free_irq_vectors(struct pci_dev *dev)
 EXPORT_SYMBOL(pci_free_irq_vectors);
 
 /**
+ * pci_free_irq_vectors_grp - free previously allocated IRQs for a
+ * device associated with a group
+ * @dev:		PCI device to operate on
+ * @group_id:		group to be freed
+ *
+ * Undoes the allocations and enabling in pci_alloc_irq_vectors_dyn().
+ * Can be only called for MSIx vectors.
+ */
+int pci_free_irq_vectors_grp(struct pci_dev *dev, int group_id)
+{
+	if (group_id < 0) {
+		pci_err(dev, "Group should be > 0\n");
+		return -EINVAL;
+	}
+
+	return pci_disable_msix_grp(dev, group_id);
+}
+EXPORT_SYMBOL(pci_free_irq_vectors_grp);
+
+/**
  * pci_irq_vector - return Linux IRQ number of a device vector
  * @dev: PCI device to operate on
  * @nr: device-relative interrupt vector index (0-based).
diff --git a/include/linux/msi.h b/include/linux/msi.h
index e61ba24..78929ad 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -333,6 +333,8 @@ struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
 int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 			  int nvec);
 void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev);
+void msi_domain_free_irqs_grp(struct irq_domain *domain, struct device *dev,
+								int group_id);
 struct msi_domain_info *msi_get_domain_info(struct irq_domain *domain);
 
 struct irq_domain *platform_msi_create_irq_domain(struct fwnode_handle *fwnode,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 73385c0..944e539 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1404,6 +1404,7 @@ int pci_msi_vec_count(struct pci_dev *dev);
 void pci_disable_msi(struct pci_dev *dev);
 int pci_msix_vec_count(struct pci_dev *dev);
 void pci_disable_msix(struct pci_dev *dev);
+int pci_disable_msix_grp(struct pci_dev *dev, int group_id);
 void pci_restore_msi_state(struct pci_dev *dev);
 int pci_msi_enabled(void);
 int pci_enable_msi(struct pci_dev *dev);
@@ -1428,6 +1429,7 @@ int pci_alloc_irq_vectors_affinity_dyn(struct pci_dev *dev,
 				       int *group_id, bool one_shot);
 
 void pci_free_irq_vectors(struct pci_dev *dev);
+int pci_free_irq_vectors_grp(struct pci_dev *dev, int group_id);
 int pci_irq_vector(struct pci_dev *dev, unsigned int nr);
 int pci_irq_vector_group(struct pci_dev *dev, unsigned int nr,
 						unsigned int group_id);
@@ -1439,6 +1441,8 @@ static inline int pci_msi_vec_count(struct pci_dev *dev) { return -ENOSYS; }
 static inline void pci_disable_msi(struct pci_dev *dev) { }
 static inline int pci_msix_vec_count(struct pci_dev *dev) { return -ENOSYS; }
 static inline void pci_disable_msix(struct pci_dev *dev) { }
+static inline int pci_disable_msix_grp(struct pci_dev *dev, int group_id)
+							{ return -ENOSYS; }
 static inline void pci_restore_msi_state(struct pci_dev *dev) { }
 static inline int pci_msi_enabled(void) { return 0; }
 static inline int pci_enable_msi(struct pci_dev *dev)
@@ -1475,6 +1479,11 @@ static inline void pci_free_irq_vectors(struct pci_dev *dev)
 {
 }
 
+static inline void pci_free_irq_vectors_grp(struct pci_dev *dev, int group_id)
+{
+	return 0;
+}
+
 static inline int pci_irq_vector(struct pci_dev *dev, unsigned int nr)
 {
 	if (WARN_ON_ONCE(nr > 0))
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 5cfa931..d73a5dc 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -511,6 +511,32 @@ void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
 }
 
 /**
+ * msi_domain_free_irqs_grp - Free interrupts belonging to a group from
+ * a MSI interrupt @domain associated to @dev
+ * @domain:	The domain to managing the interrupts
+ * @dev:	Pointer to device struct of the device for which the interrupt
+ *		should be freed
+ * @group_id:	The group ID to be freed
+ */
+void msi_domain_free_irqs_grp(struct irq_domain *domain, struct device *dev,
+								int group_id)
+{
+	struct msi_desc *desc;
+
+	for_each_msi_entry(desc, dev) {
+		/*
+		 * We might have failed to allocate an MSI early
+		 * enough that there is no IRQ associated to this
+		 * entry. If that's the case, don't do anything.
+		 */
+		if (desc->group_id == group_id && desc->irq) {
+			irq_domain_free_irqs(desc->irq, desc->nvec_used);
+			desc->irq = 0;
+		}
+	}
+}
+
+/**
  * msi_get_domain_info - Get the MSI interrupt domain info for @domain
  * @domain:	The interrupt domain to retrieve data from
  *
-- 
2.7.4

