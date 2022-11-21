Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567CB63261E
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiKUOhX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiKUOgl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:36:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356DFC6D21;
        Mon, 21 Nov 2022 06:36:31 -0800 (PST)
Message-ID: <20221121083326.002153609@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=FZrl2FVP1hN+AFQ07RZcCo5g9uO23ic8F3HA5Y+tWWI=;
        b=hPqYNF2DsT62d8jFpqufSgUXB2xq4BHYK46LQXLs8LvhhMRZmJxDY1OoVVTvaVjoqWpZ0Y
        ThYxzYkV8YhufbGeDBZffz4iA2L12l5gXZPwYrmsxoxohz4UUm8geUVp9ioqOxZih0RIbT
        mvmwSmS7Ny4e22DTMKGbYJd2ZrHDYKb00OZgUogfOGyZPJSsoyVnjLtFvS48AjwAGCn4RY
        I8bV2OLSVL0UBv1sbVQKa+F4e9uthLGMV1eWASwZ8p6OV/vb0vGMSHly5fy2J7TF/LRf2o
        6LUKpPaCIRZ/K9eiUV+IE+R+1CrU6lsEFjJQIimVhgJcmq+0m46oyb5i2wAl6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=FZrl2FVP1hN+AFQ07RZcCo5g9uO23ic8F3HA5Y+tWWI=;
        b=o0e/ebYAoMgZUK81TTG6lP8jMxcUsK/2dHJpOIeH/cIYMCTmlye3uklyty7gZi7+LyjxqI
        Be4IPoUPOZGCGKDA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>
Subject: [patch V2 09/21] genirq/msi: Make MSI descriptor iterators device
 domain aware
References: <20221121083210.309161925@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:36:29 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

To support multiple MSI interrupt domains per device it is necessary to
segment the xarray MSI descriptor storage. Each domain gets up to
MSI_MAX_INDEX entries.

Change the iterators so they operate with domain ids and take the domain
offsets into account.

The publicly available iterators which are mostly used in legacy
implementations and the PCI/MSI core default to MSI_DEFAULT_DOMAIN (0)
which is the id for the existing "global" domains.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Fix the off by one so the index space is including MSI_MAX_INDEX (Kevin)
---
 include/linux/msi.h |   45 +++++++++++++++++++++++++++++++++++++++++----
 kernel/irq/msi.c    |   43 +++++++++++++++++++++++++++++++++++--------
 2 files changed, 76 insertions(+), 12 deletions(-)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -181,6 +181,7 @@ enum msi_desc_filter {
  * @mutex:		Mutex protecting the MSI descriptor store
  * @__store:		Xarray for storing MSI descriptor pointers
  * @__iter_idx:		Index to search the next entry for iterators
+ * @__iter_max:		Index to limit the search
  * @__irqdomains:	Per device interrupt domains
  */
 struct msi_device_data {
@@ -189,6 +190,7 @@ struct msi_device_data {
 	struct mutex			mutex;
 	struct xarray			__store;
 	unsigned long			__iter_idx;
+	unsigned long			__iter_max;
 	struct irq_domain		*__irqdomains[MSI_MAX_DEVICE_IRQDOMAINS];
 };
 
@@ -197,14 +199,34 @@ int msi_setup_device_data(struct device
 void msi_lock_descs(struct device *dev);
 void msi_unlock_descs(struct device *dev);
 
-struct msi_desc *msi_first_desc(struct device *dev, enum msi_desc_filter filter);
+struct msi_desc *msi_domain_first_desc(struct device *dev, unsigned int domid,
+				       enum msi_desc_filter filter);
+
+/**
+ * msi_first_desc - Get the first MSI descriptor of the default irqdomain
+ * @dev:	Device to operate on
+ * @filter:	Descriptor state filter
+ *
+ * Must be called with the MSI descriptor mutex held, i.e. msi_lock_descs()
+ * must be invoked before the call.
+ *
+ * Return: Pointer to the first MSI descriptor matching the search
+ *	   criteria, NULL if none found.
+ */
+static inline struct msi_desc *msi_first_desc(struct device *dev,
+					      enum msi_desc_filter filter)
+{
+	return msi_domain_first_desc(dev, MSI_DEFAULT_DOMAIN, filter);
+}
+
 struct msi_desc *msi_next_desc(struct device *dev, enum msi_desc_filter filter);
 
 /**
- * msi_for_each_desc - Iterate the MSI descriptors
+ * msi_domain_for_each_desc - Iterate the MSI descriptors in a specific domain
  *
  * @desc:	struct msi_desc pointer used as iterator
  * @dev:	struct device pointer - device to iterate
+ * @domid:	The id of the interrupt domain which should be walked.
  * @filter:	Filter for descriptor selection
  *
  * Notes:
@@ -212,10 +234,25 @@ struct msi_desc *msi_next_desc(struct de
  *    pair.
  *  - It is safe to remove a retrieved MSI descriptor in the loop.
  */
-#define msi_for_each_desc(desc, dev, filter)			\
-	for ((desc) = msi_first_desc((dev), (filter)); (desc);	\
+#define msi_domain_for_each_desc(desc, dev, domid, filter)			\
+	for ((desc) = msi_domain_first_desc((dev), (domid), (filter)); (desc);	\
 	     (desc) = msi_next_desc((dev), (filter)))
 
+/**
+ * msi_for_each_desc - Iterate the MSI descriptors in the default irqdomain
+ *
+ * @desc:	struct msi_desc pointer used as iterator
+ * @dev:	struct device pointer - device to iterate
+ * @filter:	Filter for descriptor selection
+ *
+ * Notes:
+ *  - The loop must be protected with a msi_lock_descs()/msi_unlock_descs()
+ *    pair.
+ *  - It is safe to remove a retrieved MSI descriptor in the loop.
+ */
+#define msi_for_each_desc(desc, dev, filter)					\
+	msi_domain_for_each_desc((desc), (dev), MSI_DEFAULT_DOMAIN, (filter))
+
 #define msi_desc_to_dev(desc)		((desc)->dev)
 
 #ifdef CONFIG_IRQ_MSI_IOMMU
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -21,6 +21,10 @@
 
 static inline int msi_sysfs_create_group(struct device *dev);
 
+/* Invalid XA index which is outside of any searchable range */
+#define MSI_XA_MAX_INDEX	(ULONG_MAX - 1)
+#define MSI_XA_DOMAIN_SIZE	(MSI_MAX_INDEX + 1)
+
 static inline void msi_setup_default_irqdomain(struct device *dev, struct msi_device_data *md)
 {
 	if (!dev->msi.domain)
@@ -33,6 +37,20 @@ static inline void msi_setup_default_irq
 		md->__irqdomains[MSI_DEFAULT_DOMAIN] = dev->msi.domain;
 }
 
+static int msi_get_domain_base_index(struct device *dev, unsigned int domid)
+{
+	lockdep_assert_held(&dev->msi.data->mutex);
+
+	if (WARN_ON_ONCE(domid >= MSI_MAX_DEVICE_IRQDOMAINS))
+		return -ENODEV;
+
+	if (WARN_ON_ONCE(!dev->msi.data->__irqdomains[domid]))
+		return -ENODEV;
+
+	return domid * MSI_XA_DOMAIN_SIZE;
+}
+
+
 /**
  * msi_alloc_desc - Allocate an initialized msi_desc
  * @dev:	Pointer to the device for which this is allocated
@@ -229,6 +247,7 @@ int msi_setup_device_data(struct device
 
 	xa_init(&md->__store);
 	mutex_init(&md->mutex);
+	md->__iter_idx = MSI_XA_MAX_INDEX;
 	dev->msi.data = md;
 	devres_add(dev, md);
 	return 0;
@@ -251,7 +270,7 @@ EXPORT_SYMBOL_GPL(msi_lock_descs);
 void msi_unlock_descs(struct device *dev)
 {
 	/* Invalidate the index wich was cached by the iterator */
-	dev->msi.data->__iter_idx = MSI_MAX_INDEX;
+	dev->msi.data->__iter_idx = MSI_XA_MAX_INDEX;
 	mutex_unlock(&dev->msi.data->mutex);
 }
 EXPORT_SYMBOL_GPL(msi_unlock_descs);
@@ -260,17 +279,18 @@ static struct msi_desc *msi_find_desc(st
 {
 	struct msi_desc *desc;
 
-	xa_for_each_start(&md->__store, md->__iter_idx, desc, md->__iter_idx) {
+	xa_for_each_range(&md->__store, md->__iter_idx, desc, md->__iter_idx, md->__iter_max) {
 		if (msi_desc_match(desc, filter))
 			return desc;
 	}
-	md->__iter_idx = MSI_MAX_INDEX;
+	md->__iter_idx = MSI_XA_MAX_INDEX;
 	return NULL;
 }
 
 /**
- * msi_first_desc - Get the first MSI descriptor of a device
+ * msi_domain_first_desc - Get the first MSI descriptor of an irqdomain associated to a device
  * @dev:	Device to operate on
+ * @domid:	The id of the interrupt domain which should be walked.
  * @filter:	Descriptor state filter
  *
  * Must be called with the MSI descriptor mutex held, i.e. msi_lock_descs()
@@ -279,19 +299,26 @@ static struct msi_desc *msi_find_desc(st
  * Return: Pointer to the first MSI descriptor matching the search
  *	   criteria, NULL if none found.
  */
-struct msi_desc *msi_first_desc(struct device *dev, enum msi_desc_filter filter)
+struct msi_desc *msi_domain_first_desc(struct device *dev, unsigned int domid,
+				       enum msi_desc_filter filter)
 {
 	struct msi_device_data *md = dev->msi.data;
+	int baseidx;
 
 	if (WARN_ON_ONCE(!md))
 		return NULL;
 
 	lockdep_assert_held(&md->mutex);
 
-	md->__iter_idx = 0;
+	baseidx = msi_get_domain_base_index(dev, domid);
+	if (baseidx < 0)
+		return NULL;
+
+	md->__iter_idx = baseidx;
+	md->__iter_max = baseidx + MSI_MAX_INDEX;
 	return msi_find_desc(md, filter);
 }
-EXPORT_SYMBOL_GPL(msi_first_desc);
+EXPORT_SYMBOL_GPL(msi_domain_first_desc);
 
 /**
  * msi_next_desc - Get the next MSI descriptor of a device
@@ -315,7 +342,7 @@ struct msi_desc *msi_next_desc(struct de
 
 	lockdep_assert_held(&md->mutex);
 
-	if (md->__iter_idx >= (unsigned long)MSI_MAX_INDEX)
+	if (md->__iter_idx >= md->__iter_max)
 		return NULL;
 
 	md->__iter_idx++;

