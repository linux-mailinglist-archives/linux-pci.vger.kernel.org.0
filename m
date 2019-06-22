Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B84C4F18D
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2019 01:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfFUX5X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jun 2019 19:57:23 -0400
Received: from mga09.intel.com ([134.134.136.24]:48779 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbfFUX5X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Jun 2019 19:57:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2019 16:57:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,402,1557212400"; 
   d="scan'208";a="359022886"
Received: from megha-z97x-ud7-th.sc.intel.com ([143.183.85.162])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jun 2019 16:57:21 -0700
From:   Megha Dey <megha.dey@linux.intel.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, marc.zyngier@arm.com, ashok.raj@intel.com,
        jacob.jun.pan@linux.intel.com, megha.dey@intel.com,
        Megha Dey <megha.dey@linux.intel.com>
Subject: [RFC V1 RESEND 2/6] PCI/MSI: Dynamic allocation of MSI-X vectors by group
Date:   Fri, 21 Jun 2019 17:19:34 -0700
Message-Id: <1561162778-12669-3-git-send-email-megha.dey@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561162778-12669-1-git-send-email-megha.dey@linux.intel.com>
References: <1561162778-12669-1-git-send-email-megha.dey@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently, MSI-X vector enabling and allocation for a PCIe device is
static i.e. a device driver gets only one chance to enable a specific
number of MSI-X vectors, usually during device probe. Also, in many
cases, drivers usually reserve more than required number of vectors
anticipating their use, which unnecessarily blocks resources that
could have been made available to other devices. Lastly, there is no
way for drivers to reserve more vectors, if the MSI-X has already been
enabled for that device.

Hence, a dynamic MSI-X kernel infrastructure can benefit drivers by
deferring MSI-X allocation to post probe phase, where actual demand
information is available.

This patch enables the dynamic allocation of MSI-X vectors even after
MSI-X is enabled for a PCIe device by introducing a new API:
pci_alloc_irq_vectors_dyn().

This API can be called multiple times by the driver. The MSI-X vectors
allocated each time are associated with a group ID. If the existing
static allocation is used, a default group ID of -1 is assigned. The
existing pci_alloc_irq_vectors() and the new pci_alloc_irq_vectors_dyn()
API cannot be used alongside each other.

Lastly, in order to obtain the Linux IRQ number associated with any
vector in a group, a new API pci_irq_vector_group() has been introduced.

Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Megha Dey <megha.dey@linux.intel.com>
---
 drivers/pci/msi.c   | 203 +++++++++++++++++++++++++++++++++++++++++++++-------
 drivers/pci/probe.c |   8 +++
 include/linux/pci.h |  37 ++++++++++
 kernel/irq/msi.c    |   8 +--
 4 files changed, 226 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index e039b74..73ad9bf 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -102,7 +102,7 @@ int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 	if (type == PCI_CAP_ID_MSI && nvec > 1)
 		return 1;
 
-	for_each_pci_msi_entry(entry, dev) {
+	for_each_pci_msi_entry_from(entry, dev) {
 		ret = arch_setup_msi_irq(dev, entry);
 		if (ret < 0)
 			return ret;
@@ -468,7 +468,7 @@ static int populate_msi_sysfs(struct pci_dev *pdev)
 	int i;
 
 	/* Determine how many msi entries we have */
-	for_each_pci_msi_entry(entry, pdev)
+	for_each_pci_msi_entry_from(entry, pdev)
 		num_msi += entry->nvec_used;
 	if (!num_msi)
 		return 0;
@@ -477,7 +477,7 @@ static int populate_msi_sysfs(struct pci_dev *pdev)
 	msi_attrs = kcalloc(num_msi + 1, sizeof(void *), GFP_KERNEL);
 	if (!msi_attrs)
 		return -ENOMEM;
-	for_each_pci_msi_entry(entry, pdev) {
+	for_each_pci_msi_entry_from(entry, pdev) {
 		for (i = 0; i < entry->nvec_used; i++) {
 			msi_dev_attr = kzalloc(sizeof(*msi_dev_attr), GFP_KERNEL);
 			if (!msi_dev_attr)
@@ -506,7 +506,11 @@ static int populate_msi_sysfs(struct pci_dev *pdev)
 		goto error_irq_group;
 	msi_irq_groups[0] = msi_irq_group;
 
-	ret = sysfs_create_groups(&pdev->dev.kobj, msi_irq_groups);
+	if (!pdev->msix_enabled)
+		ret = sysfs_create_group(&pdev->dev.kobj, msi_irq_group);
+	else
+		ret = sysfs_merge_group(&pdev->dev.kobj, msi_irq_group);
+
 	if (ret)
 		goto error_irq_groups;
 	pdev->msi_irq_groups = msi_irq_groups;
@@ -574,7 +578,7 @@ static int msi_verify_entries(struct pci_dev *dev)
 {
 	struct msi_desc *entry;
 
-	for_each_pci_msi_entry(entry, dev) {
+	for_each_pci_msi_entry_from(entry, dev) {
 		if (!dev->no_64bit_msi || !entry->msg.address_hi)
 			continue;
 		pci_err(dev, "Device has broken 64-bit MSI but arch"
@@ -615,6 +619,9 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
 
 	list_add_tail(&entry->list, dev_to_msi_list(&dev->dev));
 
+	 dev->dev.grp_first_desc = list_last_entry
+			(dev_to_msi_list(&dev->dev), struct msi_desc, list);
+
 	/* Configure MSI capability structure */
 	ret = pci_msi_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSI);
 	if (ret) {
@@ -669,7 +676,7 @@ static void __iomem *msix_map_region(struct pci_dev *dev, unsigned nr_entries)
 
 static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
 			      struct msix_entry *entries, int nvec,
-			      struct irq_affinity *affd)
+			      struct irq_affinity *affd, int group)
 {
 	struct irq_affinity_desc *curmsk, *masks = NULL;
 	struct msi_desc *entry;
@@ -698,8 +705,20 @@ static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
 			entry->msi_attrib.entry_nr = i;
 		entry->msi_attrib.default_irq	= dev->irq;
 		entry->mask_base		= base;
+		entry->group_id			= group;
 
 		list_add_tail(&entry->list, dev_to_msi_list(&dev->dev));
+
+		/*
+		 * Save the pointer to the first msi_desc entry of every
+		 * MSI-X group. This pointer is used by other functions
+		 * as the starting point to iterate through each of the
+		 * entries in that particular group.
+		 */
+		if (!i)
+			dev->dev.grp_first_desc = list_last_entry
+			(dev_to_msi_list(&dev->dev), struct msi_desc, list);
+
 		if (masks)
 			curmsk++;
 	}
@@ -715,7 +734,7 @@ static void msix_program_entries(struct pci_dev *dev,
 	struct msi_desc *entry;
 	int i = 0;
 
-	for_each_pci_msi_entry(entry, dev) {
+	for_each_pci_msi_entry_from(entry, dev) {
 		if (entries)
 			entries[i++].vector = entry->irq;
 		entry->masked = readl(pci_msix_desc_addr(entry) +
@@ -730,28 +749,31 @@ static void msix_program_entries(struct pci_dev *dev,
  * @entries: pointer to an array of struct msix_entry entries
  * @nvec: number of @entries
  * @affd: Optional pointer to enable automatic affinity assignement
+ * @group: The Group ID to be allocated to the msi-x vectors
  *
  * Setup the MSI-X capability structure of device function with a
  * single MSI-X irq. A return of zero indicates the successful setup of
  * requested MSI-X entries with allocated irqs or non-zero for otherwise.
  **/
 static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
-				int nvec, struct irq_affinity *affd)
+				int nvec, struct irq_affinity *affd, int group)
 {
 	int ret;
 	u16 control;
-	void __iomem *base;
 
 	/* Ensure MSI-X is disabled while it is set up */
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
 
 	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &control);
+
 	/* Request & Map MSI-X table region */
-	base = msix_map_region(dev, msix_table_size(control));
-	if (!base)
-		return -ENOMEM;
+	if (!dev->msix_enabled) {
+		dev->base = msix_map_region(dev, msix_table_size(control));
+		if (!dev->base)
+			return -ENOMEM;
+	}
 
-	ret = msix_setup_entries(dev, base, entries, nvec, affd);
+	ret = msix_setup_entries(dev, dev->base, entries, nvec, affd, group);
 	if (ret)
 		return ret;
 
@@ -784,6 +806,7 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
 
 	pcibios_free_irq(dev);
+
 	return 0;
 
 out_avail:
@@ -795,7 +818,7 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 		struct msi_desc *entry;
 		int avail = 0;
 
-		for_each_pci_msi_entry(entry, dev) {
+		for_each_pci_msi_entry_from(entry, dev) {
 			if (entry->irq != 0)
 				avail++;
 		}
@@ -932,7 +955,8 @@ int pci_msix_vec_count(struct pci_dev *dev)
 EXPORT_SYMBOL(pci_msix_vec_count);
 
 static int __pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries,
-			     int nvec, struct irq_affinity *affd)
+			     int nvec, struct irq_affinity *affd,
+			     bool one_shot, int group)
 {
 	int nr_entries;
 	int i, j;
@@ -963,7 +987,7 @@ static int __pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries,
 		pci_info(dev, "can't enable MSI-X (MSI IRQ already assigned)\n");
 		return -EINVAL;
 	}
-	return msix_capability_init(dev, entries, nvec, affd);
+	return msix_capability_init(dev, entries, nvec, affd, group);
 }
 
 static void pci_msix_shutdown(struct pci_dev *dev)
@@ -1079,16 +1103,14 @@ EXPORT_SYMBOL(pci_enable_msi);
 
 static int __pci_enable_msix_range(struct pci_dev *dev,
 				   struct msix_entry *entries, int minvec,
-				   int maxvec, struct irq_affinity *affd)
+				   int maxvec, struct irq_affinity *affd,
+				   bool one_shot, int group)
 {
 	int rc, nvec = maxvec;
 
 	if (maxvec < minvec)
 		return -ERANGE;
 
-	if (WARN_ON_ONCE(dev->msix_enabled))
-		return -EINVAL;
-
 	for (;;) {
 		if (affd) {
 			nvec = irq_calc_affinity_vectors(minvec, nvec, affd);
@@ -1096,7 +1118,8 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
 				return -ENOSPC;
 		}
 
-		rc = __pci_enable_msix(dev, entries, nvec, affd);
+		rc = __pci_enable_msix(dev, entries, nvec, affd, one_shot,
+									group);
 		if (rc == 0)
 			return nvec;
 
@@ -1127,7 +1150,8 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
 int pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
 		int minvec, int maxvec)
 {
-	return __pci_enable_msix_range(dev, entries, minvec, maxvec, NULL);
+	return __pci_enable_msix_range(dev, entries, minvec, maxvec, NULL,
+								false, -1);
 }
 EXPORT_SYMBOL(pci_enable_msix_range);
 
@@ -1153,9 +1177,49 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 				   unsigned int max_vecs, unsigned int flags,
 				   struct irq_affinity *affd)
 {
+	int group = -1;
+
+	dev->one_shot = true;
+
+	return pci_alloc_irq_vectors_affinity_dyn(dev, min_vecs, max_vecs,
+					flags, NULL, &group, dev->one_shot);
+}
+EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
+
+/**
+ * pci_alloc_irq_vectors_affinity_dyn - allocate multiple IRQs for a device
+ * dynamically. Can be called multiple times.
+ * @dev:		PCI device to operate on
+ * @min_vecs:		minimum number of vectors required (must be >= 1)
+ * @max_vecs:		maximum (desired) number of vectors
+ * @flags:		flags or quirks for the allocation
+ * @affd:		optional description of the affinity requirements
+ * @group_id:		group ID assigned to vectors allocated
+ * @one_shot:		true if dynamic MSI-X allocation is disabled, else false
+ *
+ * Allocate up to @max_vecs interrupt vectors for @dev, using MSI-X. Return
+ * the number of vectors allocated (which might be smaller than @max_vecs)
+ * if successful, or a negative error code on error. If less than @min_vecs
+ * interrupt vectors are available for @dev the function will fail with -ENOSPC.
+ * Assign a unique group ID to the set of vectors being allocated.
+ *
+ * To get the Linux IRQ number used for a vector that can be passed to
+ * request_irq() use the pci_irq_vector_group() helper.
+ */
+int pci_alloc_irq_vectors_affinity_dyn(struct pci_dev *dev,
+				       unsigned int min_vecs,
+				       unsigned int max_vecs,
+				       unsigned int flags,
+				       struct irq_affinity *affd,
+				       int *group_id, bool one_shot)
+{
+
 	struct irq_affinity msi_default_affd = {0};
-	int msix_vecs = -ENOSPC;
+	int msix_vecs = -ENOSPC, i;
 	int msi_vecs = -ENOSPC;
+	struct msix_entry *entries = NULL;
+	struct msi_desc *entry;
+	int p = 0;
 
 	if (flags & PCI_IRQ_AFFINITY) {
 		if (!affd)
@@ -1166,8 +1230,54 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 	}
 
 	if (flags & PCI_IRQ_MSIX) {
-		msix_vecs = __pci_enable_msix_range(dev, NULL, min_vecs,
-						    max_vecs, affd);
+		if (dev->msix_enabled) {
+			if (one_shot) {
+				goto err_alloc;
+			} else {
+				for_each_pci_msi_entry(entry, dev) {
+					if (entry->group_id != -1)
+						p = 1;
+				}
+				if (!p)
+					goto err_alloc;
+			}
+		} else {
+			dev->num_msix = pci_msix_vec_count(dev);
+			dev->entry = kcalloc(BITS_TO_LONGS(dev->num_msix),
+					sizeof(unsigned long), GFP_KERNEL);
+			if (!dev->entry)
+				return -ENOMEM;
+		}
+
+		entries = kcalloc(max_vecs, sizeof(struct msix_entry),
+								GFP_KERNEL);
+		if (entries == NULL)
+			return -ENOMEM;
+
+		for (i = 0; i < max_vecs; i++) {
+			entries[i].entry = find_first_zero_bit(
+						dev->entry, dev->num_msix);
+			if (entries[i].entry == dev->num_msix)
+				return -ENOSPC;
+			set_bit(entries[i].entry, dev->entry);
+		}
+
+		if (!one_shot) {
+			/* Assign a unique group ID */
+			*group_id = idr_alloc(dev->grp_idr, NULL,
+						0, dev->num_msix, GFP_KERNEL);
+			if (*group_id < 0) {
+				if (*group_id == -ENOSPC)
+					pci_err(dev, "No free group IDs\n");
+				return *group_id;
+			}
+		}
+
+		msix_vecs = __pci_enable_msix_range(dev, entries, min_vecs,
+					max_vecs, affd, one_shot, *group_id);
+
+		kfree(entries);
+
 		if (msix_vecs > 0)
 			return msix_vecs;
 	}
@@ -1197,8 +1307,12 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 	if (msix_vecs == -ENOSPC)
 		return -ENOSPC;
 	return msi_vecs;
+
+err_alloc:
+	WARN_ON_ONCE(dev->msix_enabled);
+	return -EINVAL;
 }
-EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
+EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity_dyn);
 
 /**
  * pci_free_irq_vectors - free previously allocated IRQs for a device
@@ -1248,6 +1362,43 @@ int pci_irq_vector(struct pci_dev *dev, unsigned int nr)
 EXPORT_SYMBOL(pci_irq_vector);
 
 /**
+ * pci_irq_vector_group - return the IRQ number of a device vector associated
+ * with a group
+ * @dev: PCI device to operate on
+ * @nr: device-relative interrupt vector index (0-based)
+ * @group_id: group from which IRQ number should be returned
+ */
+int pci_irq_vector_group(struct pci_dev *dev, unsigned int nr,
+						unsigned int group_id)
+{
+	if (dev->msix_enabled) {
+		struct msi_desc *entry;
+		int i = 0, grp_present = 0;
+
+		for_each_pci_msi_entry(entry, dev) {
+			if (entry->group_id == group_id) {
+				grp_present = 1;
+				if (i == nr)
+					return entry->irq;
+				i++;
+			}
+		}
+
+		if (!grp_present) {
+			pci_err(dev, "Group %d not present\n", group_id);
+			return -EINVAL;
+		}
+
+		pci_err(dev, "Interrupt vector index %d does not exist in "
+						"group %d\n", nr, group_id);
+	}
+
+	pci_err(dev, "MSI-X not enabled\n");
+	return -EINVAL;
+}
+EXPORT_SYMBOL(pci_irq_vector_group);
+
+/**
  * pci_irq_get_affinity - return the affinity of a particular msi vector
  * @dev:	PCI device to operate on
  * @nr:		device-relative interrupt vector index (0-based).
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 0e8e2c1..491c1cf 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2426,6 +2426,14 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
 	if (!dev)
 		return NULL;
 
+	/* For dynamic MSI-x */
+	dev->grp_idr = kzalloc(sizeof(struct idr), GFP_KERNEL);
+	if (!dev->grp_idr)
+		return NULL;
+
+	/* Initialise the IDR structures */
+	idr_init(dev->grp_idr);
+
 	INIT_LIST_HEAD(&dev->bus_list);
 	dev->dev.type = &pci_dev_type;
 	dev->bus = pci_bus_get(bus);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b9a1d41..c56462c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1411,9 +1411,17 @@ static inline int pci_enable_msix_exact(struct pci_dev *dev,
 int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 				   unsigned int max_vecs, unsigned int flags,
 				   struct irq_affinity *affd);
+int pci_alloc_irq_vectors_affinity_dyn(struct pci_dev *dev,
+				       unsigned int min_vecs,
+				       unsigned int max_vecs,
+				       unsigned int flags,
+				       struct irq_affinity *affd,
+				       int *group_id, bool one_shot);
 
 void pci_free_irq_vectors(struct pci_dev *dev);
 int pci_irq_vector(struct pci_dev *dev, unsigned int nr);
+int pci_irq_vector_group(struct pci_dev *dev, unsigned int nr,
+						unsigned int group_id);
 const struct cpumask *pci_irq_get_affinity(struct pci_dev *pdev, int vec);
 int pci_irq_get_node(struct pci_dev *pdev, int vec);
 
@@ -1443,6 +1451,17 @@ pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 	return -ENOSPC;
 }
 
+static inline int
+pci_alloc_irq_vectors_affinity_dyn(struct pci_dev *dev, unsigned int min_vecs,
+				   unsigned int max_vecs, unsigned int flags,
+				   struct irq_affinity *aff_desc,
+				   int *group_id, bool one_shot)
+{
+	if ((flags & PCI_IRQ_LEGACY) && min_vecs == 1 && dev->irq)
+		return 1;
+	return -ENOSPC;
+}
+
 static inline void pci_free_irq_vectors(struct pci_dev *dev)
 {
 }
@@ -1453,6 +1472,15 @@ static inline int pci_irq_vector(struct pci_dev *dev, unsigned int nr)
 		return -EINVAL;
 	return dev->irq;
 }
+
+static inline int pci_irq_vector_group(struct pci_dev *dev, unsigned int nr,
+							unsigned int group_id)
+{
+	if (WARN_ON_ONCE(nr > 0))
+		return -EINVAL;
+	return dev->irq;
+}
+
 static inline const struct cpumask *pci_irq_get_affinity(struct pci_dev *pdev,
 		int vec)
 {
@@ -1473,6 +1501,15 @@ pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
 					      NULL);
 }
 
+static inline int
+pci_alloc_irq_vectors_dyn(struct pci_dev *dev, unsigned int min_vecs,
+			  unsigned int max_vecs, unsigned int flags,
+			  int *group_id)
+{
+	return pci_alloc_irq_vectors_affinity_dyn(dev, min_vecs, max_vecs,
+					  flags, NULL, group_id, false);
+}
+
 /**
  * pci_irqd_intx_xlate() - Translate PCI INTx value to an IRQ domain hwirq
  * @d: the INTx IRQ domain
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index ad26fbc..5cfa931 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -411,7 +411,7 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 	if (ret)
 		return ret;
 
-	for_each_msi_entry(desc, dev) {
+	for_each_msi_entry_from(desc, dev) {
 		ops->set_desc(&arg, desc);
 
 		virq = __irq_domain_alloc_irqs(domain, -1, desc->nvec_used,
@@ -437,7 +437,7 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 
 	can_reserve = msi_check_reservation_mode(domain, info, dev);
 
-	for_each_msi_entry(desc, dev) {
+	for_each_msi_entry_from(desc, dev) {
 		virq = desc->irq;
 		if (desc->nvec_used == 1)
 			dev_dbg(dev, "irq %d for MSI\n", virq);
@@ -465,7 +465,7 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 	 * so request_irq() will assign the final vector.
 	 */
 	if (can_reserve) {
-		for_each_msi_entry(desc, dev) {
+		for_each_msi_entry_from(desc, dev) {
 			irq_data = irq_domain_get_irq_data(domain, desc->irq);
 			irqd_clr_activated(irq_data);
 		}
@@ -473,7 +473,7 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 	return 0;
 
 cleanup:
-	for_each_msi_entry(desc, dev) {
+	for_each_msi_entry_from(desc, dev) {
 		struct irq_data *irqd;
 
 		if (desc->irq == virq)
-- 
2.7.4

