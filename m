Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41CB845FAD3
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 02:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351989AbhK0Be5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 20:34:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40358 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346232AbhK0Bcy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 20:32:54 -0500
Message-ID: <20211126232736.190744801@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=PFuyUtIKHszvU7gtDYULmf7Bd4K09pORQBH8HusBKz0=;
        b=km0dQNrfd/o0N9ZCoe4Dq5mqn2NkF9GyT7EEl4gfQBZ2/Km8fIq547wMj9cqOV8xzApkuS
        Ksyf3qAdZNHCFiBq4rMDm7q1PDtRzByfm+uL7nlbh/RbbagXMHUdUDdlq3fTMEyv1HBy58
        kUj2xZCvoXGyptaUsGze8h7zbKeHqZthvN9JqTFvRPnF8mRWUKqDXBnVX6du4iMnUw2ORK
        lzTJErhLxYUMLEnmclk+DiQ3ypUbpNuKzPFze6WeXZSLOy/ftsqnrFVcaSInfqJosoh5WU
        GemPciyrjbexoyVrduy4cw8W5OHtmc5n4xeYC53ItCrf2aukV2GG15HuoFg7tA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=PFuyUtIKHszvU7gtDYULmf7Bd4K09pORQBH8HusBKz0=;
        b=JkJbBoyWqfnzxRPH0Wq9ayxuLkpf/ve8i8pASU+7toUKJoaviwLXO5Y5kqrZx0DEHN5LFV
        Fj9i8W8OabBRHPCA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
Subject: [patch 32/32] genirq/msi: Convert storage to xarray
References: <20211126230957.239391799@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:23:17 +0100 (CET)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The current linked list storage for MSI descriptors is suboptimal in
several ways:

  1) Looking up a MSI desciptor requires a O(n) list walk in the worst case

  2) The upcoming support of runtime expansion of MSI-X vectors would need
     to do a full list walk to figure out whether a particular index is
     already associated.

  3) Runtime expansion of sparse allocations is even more complex as the
     current implementation assumes an ordered list (increasing MSI index).

Use an xarray which solves all of the above problems nicely.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h |   19 ++---
 kernel/irq/msi.c    |  188 ++++++++++++++++++++++------------------------------
 2 files changed, 90 insertions(+), 117 deletions(-)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -17,6 +17,7 @@
  */
 
 #include <linux/spinlock.h>
+#include <linux/xarray.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
 #include <linux/bits.h>
@@ -122,7 +123,6 @@ struct pci_msi_desc {
 
 /**
  * struct msi_desc - Descriptor structure for MSI based interrupts
- * @list:	List head for management
  * @irq:	The base interrupt number
  * @nvec_used:	The number of vectors used
  * @dev:	Pointer to the device which uses this descriptor
@@ -139,7 +139,6 @@ struct pci_msi_desc {
  */
 struct msi_desc {
 	/* Shared device/bus type independent data */
-	struct list_head		list;
 	unsigned int			irq;
 	unsigned int			nvec_used;
 	struct device			*dev;
@@ -177,20 +176,20 @@ enum msi_desc_filter {
  * @properties:		MSI properties which are interesting to drivers
  * @num_descs:		The number of allocated MSI descriptors for the device
  * @platform_data:	Platform-MSI specific data
- * @list:		List of MSI descriptors associated to the device
- * @mutex:		Mutex protecting the MSI list
- * @__next:		Cached pointer to the next entry for iterators
- * @__filter:		Cached descriptor filter
+ * @mutex:		Mutex protecting the MSI descriptor store
+ * @store:		Xarray for storing MSI descriptor pointers
+ * @__iter_idx:		Index to search the next entry for iterators
+ * @__iter_filter:	Cached descriptor filter
  */
 struct msi_device_data {
 	raw_spinlock_t			lock;
 	unsigned long			properties;
 	unsigned int			num_descs;
 	struct platform_msi_priv_data	*platform_data;
-	struct list_head		list;
 	struct mutex			mutex;
-	struct msi_desc			*__next;
-	enum msi_desc_filter		__filter;
+	struct xarray			store;
+	unsigned long			__iter_idx;
+	enum msi_desc_filter		__iter_filter;
 };
 
 int msi_setup_device_data(struct device *dev);
@@ -266,7 +265,7 @@ static inline struct msi_desc *msi_first
  * @dev:	struct device pointer - device to iterate
  * @filter:	Filter for descriptor selection
  *
- * See msi_for_each_desc_from()for further information.
+ * See msi_for_each_desc_from() for further information.
  */
 #define msi_for_each_desc(desc, dev, filter)				\
 	msi_for_each_desc_from(desc, dev, filter, 0)
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -20,7 +20,6 @@
 #include "internals.h"
 
 static inline int msi_sysfs_create_group(struct device *dev);
-#define dev_to_msi_list(dev)	(&(dev)->msi.data->list)
 
 /**
  * msi_alloc_desc - Allocate an initialized msi_desc
@@ -41,7 +40,6 @@ static struct msi_desc *msi_alloc_desc(s
 	if (!desc)
 		return NULL;
 
-	INIT_LIST_HEAD(&desc->list);
 	desc->dev = dev;
 	desc->nvec_used = nvec;
 	if (affinity) {
@@ -60,6 +58,19 @@ static void msi_free_desc(struct msi_des
 	kfree(desc);
 }
 
+static int msi_insert_desc(struct msi_device_data *md, struct msi_desc *desc, unsigned int index)
+{
+	int ret;
+
+	desc->msi_index = index;
+	ret = xa_insert(&md->store, index, desc, GFP_KERNEL);
+	if (!ret)
+		md->num_descs++;
+	else
+		msi_free_desc(desc);
+	return ret;
+}
+
 /**
  * msi_add_msi_desc - Allocate and initialize a MSI descriptor
  * @dev:	Pointer to the device for which the descriptor is allocated
@@ -77,13 +88,9 @@ int msi_add_msi_desc(struct device *dev,
 	if (!desc)
 		return -ENOMEM;
 
-	/* Copy the MSI index and type specific data to the new descriptor. */
-	desc->msi_index = init_desc->msi_index;
+	/* Copy type specific data to the new descriptor. */
 	desc->pci = init_desc->pci;
-
-	list_add_tail(&desc->list, &dev->msi.data->list);
-	dev->msi.data->num_descs++;
-	return 0;
+	return msi_insert_desc(dev->msi.data, desc, init_desc->msi_index);
 }
 
 /**
@@ -96,29 +103,41 @@ int msi_add_msi_desc(struct device *dev,
  */
 static int msi_add_simple_msi_descs(struct device *dev, unsigned int index, unsigned int ndesc)
 {
-	struct msi_desc *desc, *tmp;
-	LIST_HEAD(list);
-	unsigned int i;
+	struct msi_desc *desc;
+	unsigned long i;
+	int ret;
 
 	lockdep_assert_held(&dev->msi.data->mutex);
 
 	for (i = 0; i < ndesc; i++) {
 		desc = msi_alloc_desc(dev, 1, NULL);
 		if (!desc)
+			goto fail_mem;
+		ret = msi_insert_desc(dev->msi.data, desc, index + i);
+		if (ret)
 			goto fail;
-		desc->msi_index = index + i;
-		list_add_tail(&desc->list, &list);
 	}
-	list_splice_tail(&list, &dev->msi.data->list);
-	dev->msi.data->num_descs += ndesc;
 	return 0;
 
+fail_mem:
+	ret = -ENOMEM;
 fail:
-	list_for_each_entry_safe(desc, tmp, &list, list) {
-		list_del(&desc->list);
-		msi_free_desc(desc);
+	msi_free_msi_descs_range(dev, MSI_DESC_NOTASSOCIATED, index, ndesc);
+	return ret;
+}
+
+static bool msi_desc_match(struct msi_desc *desc, enum msi_desc_filter filter)
+{
+	switch (filter) {
+	case MSI_DESC_ALL:
+		return true;
+	case MSI_DESC_NOTASSOCIATED:
+		return !desc->irq;
+	case MSI_DESC_ASSOCIATED:
+		return !!desc->irq;
 	}
-	return -ENOMEM;
+	WARN_ON_ONCE(1);
+	return false;
 }
 
 /**
@@ -132,19 +151,16 @@ void msi_free_msi_descs_range(struct dev
 			      unsigned int base_index, unsigned int ndesc)
 {
 	struct msi_desc *desc;
+	unsigned long idx;
 
 	lockdep_assert_held(&dev->msi.data->mutex);
 
-	msi_for_each_desc(desc, dev, filter) {
-		/*
-		 * Stupid for now to handle MSI device domain until the
-		 * storage is switched over to an xarray.
-		 */
-		if (desc->msi_index < base_index || desc->msi_index >= base_index + ndesc)
-			continue;
-		list_del(&desc->list);
-		msi_free_desc(desc);
-		dev->msi.data->num_descs--;
+	xa_for_each_range(&dev->msi.data->store, idx, desc, base_index, base_index + ndesc - 1) {
+		if (msi_desc_match(desc, filter)) {
+			xa_erase(&dev->msi.data->store, idx);
+			msi_free_desc(desc);
+			dev->msi.data->num_descs--;
+		}
 	}
 }
 
@@ -192,7 +208,8 @@ static void msi_device_data_release(stru
 {
 	struct msi_device_data *md = res;
 
-	WARN_ON_ONCE(!list_empty(&md->list));
+	WARN_ON_ONCE(!xa_empty(&md->store));
+	xa_destroy(&md->store);
 	dev->msi.data = NULL;
 }
 
@@ -225,7 +242,7 @@ int msi_setup_device_data(struct device
 	}
 
 	raw_spin_lock_init(&md->lock);
-	INIT_LIST_HEAD(&md->list);
+	xa_init(&md->store);
 	mutex_init(&md->mutex);
 	dev->msi.data = md;
 	devres_add(dev, md);
@@ -252,38 +269,21 @@ void msi_unlock_descs(struct device *dev
 {
 	if (WARN_ON_ONCE(!dev->msi.data))
 		return;
-	/* Clear the next pointer which was cached by the iterator */
-	dev->msi.data->__next = NULL;
+	/* Invalidate the index wich was cached by the iterator */
+	dev->msi.data->__iter_idx = ULONG_MAX;
 	mutex_unlock(&dev->msi.data->mutex);
 }
 EXPORT_SYMBOL_GPL(msi_unlock_descs);
 
-static bool msi_desc_match(struct msi_desc *desc, enum msi_desc_filter filter)
-{
-	switch (filter) {
-	case MSI_DESC_ALL:
-		return true;
-	case MSI_DESC_NOTASSOCIATED:
-		return !desc->irq;
-	case MSI_DESC_ASSOCIATED:
-		return !!desc->irq;
-	}
-	WARN_ON_ONCE(1);
-	return false;
-}
-
-static struct msi_desc *msi_find_first_desc(struct device *dev, enum msi_desc_filter filter,
-					    unsigned int base_index)
+static struct msi_desc *msi_find_desc(struct msi_device_data *md)
 {
 	struct msi_desc *desc;
 
-	list_for_each_entry(desc, dev_to_msi_list(dev), list) {
-		if (desc->msi_index < base_index)
-			continue;
-		if (msi_desc_match(desc, filter))
-			return desc;
+	xa_for_each_start(&md->store, md->__iter_idx, desc, md->__iter_idx) {
+		if (msi_desc_match(desc, md->__iter_filter))
+			break;
 	}
-	return NULL;
+	return desc;
 }
 
 /**
@@ -301,43 +301,25 @@ static struct msi_desc *msi_find_first_d
 struct msi_desc *__msi_first_desc(struct device *dev, enum msi_desc_filter filter,
 				  unsigned int base_index)
 {
-	struct msi_desc *desc;
+	struct msi_device_data *md = dev->msi.data;
 
-	if (WARN_ON_ONCE(!dev->msi.data))
+	if (WARN_ON_ONCE(!md))
 		return NULL;
 
-	lockdep_assert_held(&dev->msi.data->mutex);
+	lockdep_assert_held(&md->mutex);
 
-	/* Invalidate a previous invocation within the same lock section */
-	dev->msi.data->__next = NULL;
-
-	desc = msi_find_first_desc(dev, filter, base_index);
-	if (desc) {
-		dev->msi.data->__next = list_next_entry(desc, list);
-		dev->msi.data->__filter = filter;
-	}
-	return desc;
+	md->__iter_filter = filter;
+	md->__iter_idx = base_index;
+	return msi_find_desc(md);
 }
 EXPORT_SYMBOL_GPL(__msi_first_desc);
 
-static struct msi_desc *__msi_next_desc(struct device *dev, enum msi_desc_filter filter,
-					struct msi_desc *from)
-{
-	struct msi_desc *desc = from;
-
-	list_for_each_entry_from(desc, dev_to_msi_list(dev), list) {
-		if (msi_desc_match(desc, filter))
-			return desc;
-	}
-	return NULL;
-}
-
 /**
  * msi_next_desc - Get the next MSI descriptor of a device
  * @dev:	Device to operate on
  *
  * The first invocation of msi_next_desc() has to be preceeded by a
- * successful incovation of __msi_first_desc(). Consecutive invocations are
+ * successful invocation of __msi_first_desc(). Consecutive invocations are
  * only valid if the previous one was successful. All these operations have
  * to be done within the same MSI mutex held region.
  *
@@ -346,20 +328,18 @@ static struct msi_desc *__msi_next_desc(
  */
 struct msi_desc *msi_next_desc(struct device *dev)
 {
-	struct msi_device_data *data = dev->msi.data;
-	struct msi_desc *desc;
+	struct msi_device_data *md = dev->msi.data;
 
-	if (WARN_ON_ONCE(!data))
+	if (WARN_ON_ONCE(!md))
 		return NULL;
 
-	lockdep_assert_held(&data->mutex);
+	lockdep_assert_held(&md->mutex);
 
-	if (!data->__next)
+	if (md->__iter_idx == ULONG_MAX)
 		return NULL;
 
-	desc = __msi_next_desc(dev, data->__filter, data->__next);
-	dev->msi.data->__next = desc ? list_next_entry(desc, list) : NULL;
-	return desc;
+	md->__iter_idx++;
+	return msi_find_desc(md);
 }
 EXPORT_SYMBOL_GPL(msi_next_desc);
 
@@ -384,21 +364,18 @@ int __msi_get_virq(struct device *dev, u
 	pcimsi = msi_device_has_property(dev, MSI_PROP_PCI_MSI);
 
 	msi_lock_descs(dev);
-	msi_for_each_desc_from(desc, dev, MSI_DESC_ASSOCIATED, index) {
-		/* PCI-MSI has only one descriptor for multiple interrupts. */
-		if (pcimsi) {
-			if (index < desc->nvec_used)
-				ret = desc->irq + index;
-			break;
-		}
-
+	desc = xa_load(&dev->msi.data->store, pcimsi ? 0 : index);
+	if (desc && desc->irq) {
 		/*
+		 * PCI-MSI has only one descriptor for multiple interrupts.
 		 * PCI-MSIX and platform MSI use a descriptor per
 		 * interrupt.
 		 */
-		if (desc->msi_index == index) {
+		if (pcimsi) {
+			if (index < desc->nvec_used)
+				ret = desc->irq + index;
+		} else {
 			ret = desc->irq;
-			break;
 		}
 	}
 	msi_unlock_descs(dev);
@@ -779,17 +756,13 @@ int msi_domain_populate_irqs(struct irq_
 	int ret, virq;
 
 	msi_lock_descs(dev);
-	for (virq = virq_base; virq < virq_base + nvec; virq++) {
-		desc = msi_alloc_desc(dev, 1, NULL);
-		if (!desc) {
-			ret = -ENOMEM;
-			goto fail;
-		}
+	ret = msi_add_simple_msi_descs(dev, virq_base, nvec);
+	if (ret)
+		goto unlock;
 
-		desc->msi_index = virq;
+	for (virq = virq_base; virq < virq_base + nvec; virq++) {
+		desc = xa_load(&dev->msi.data->store, virq);
 		desc->irq = virq;
-		list_add_tail(&desc->list, &dev->msi.data->list);
-		dev->msi.data->num_descs++;
 
 		ops->set_desc(arg, desc);
 		ret = irq_domain_alloc_irqs_hierarchy(domain, virq, 1, arg);
@@ -805,6 +778,7 @@ int msi_domain_populate_irqs(struct irq_
 	for (--virq; virq >= virq_base; virq--)
 		irq_domain_free_irqs_common(domain, virq, 1);
 	msi_free_msi_descs_range(dev, MSI_DESC_ALL, virq_base, nvec);
+unlock:
 	msi_unlock_descs(dev);
 	return ret;
 }

