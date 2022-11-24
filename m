Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76DD638152
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 00:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiKXXYN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 18:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiKXXYM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 18:24:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33D986A60;
        Thu, 24 Nov 2022 15:24:10 -0800 (PST)
Message-ID: <20221124225331.464480443@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669332247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=3XlTchWmSYgWxnh2ttknAUfKPOyveIAHvh7jfW9j4Pg=;
        b=qwGocCuzZIp2kiV3bXD80Ch3m8sVA3hK+bkI46Euu+ORcIXD0r36HJb/cUsNMnLDYkJahz
        CGqCw94Bnvpn+K18z5cNKz31Eu1Ebv9/RxIn8rgw0T/5vg2UfgnoWlFWY9VyzEy7I1ZD1m
        n/+w33D8zmiLSZiF8/7YmqOdPaECp24vnJ/sPAedjAQ4OerHfWlCOV6bcaAXe669f1SVVe
        tPgiHxeJMs0GIHjhabGQjBuePCx13eiSUvMFSnWh33ksgNFHR0Z5PeP+Hx01whMKh/mcu1
        GcbDUKMp1vS2fNYi8bHPTQO4JIODATtp3AZQzGMU50P9NyyNdsGiJLSxidavTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669332247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=3XlTchWmSYgWxnh2ttknAUfKPOyveIAHvh7jfW9j4Pg=;
        b=ZyODNB28JFr+B4yU86cU4Ec/3KwX5c522Qudusr86i+XyHu2LktJ56V5F/CUcv0mft6Jzh
        KtFmibTMoarGw4CA==
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
Subject: [patch V3 00/22] genirq, PCI/MSI: Support for per device MSI and
 PCI/IMS - Part 2 API rework
Date:   Fri, 25 Nov 2022 00:24:07 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is V3 of the second part of the effort to provide support for per
device MSI interrupt domains.

Version 2 of this second part can be found here:

  https://lore.kernel.org/all/20221121083210.309161925@linutronix.de

The first part is available here:

  https://lore.kernel.org/all/20221111120501.026511281@linutronix.de

and has been merged into:

 git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core

This part on top of the tip irq/core branch is also available here:

   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git devmsi-v3-part2

This part is the main preparation step for per device MSI domains:

  1) Introduce irqdomain pointer storage space in device::msi::data
     and related helpers.

  2) Convert interfaces to handle multiple per device MSI domains
     based on a domain ID

  3) Provide new interfaces for allocation/free which are domain ID
     based and provide range allocation/free which is a prerequisite
     for post MSI-X enable alloc/free.

  4) Switch all existing call sites of msi allocation/free interfaces
     over to the new interfaces

  5) Remove the old interfaces

Changes vs. V2:

  - Rework the xarray storage into per domain storage (Marc)

@Kevin: I did not pick up your Reviewed-by tag due to these changes.

The delta patch vs. V2 is attached below.

Thanks,

	tglx
---
diff --git a/include/linux/msi.h b/include/linux/msi.h
index af9437ee4d82..43b8866c8431 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -174,24 +174,31 @@ enum msi_desc_filter {
 	MSI_DESC_ASSOCIATED,
 };
 
+
+/**
+ * struct msi_dev_domain - The internals of MSI domain info per device
+ * @store:		Xarray for storing MSI descriptor pointers
+ * @irqdomain:		Pointer to a per device interrupt domain
+ */
+struct msi_dev_domain {
+	struct xarray		store;
+	struct irq_domain	*domain;
+};
+
 /**
  * msi_device_data - MSI per device data
  * @properties:		MSI properties which are interesting to drivers
  * @platform_data:	Platform-MSI specific data
  * @mutex:		Mutex protecting the MSI descriptor store
- * @__store:		Xarray for storing MSI descriptor pointers
+ * @__domains:		Internal data for per device MSI domains
  * @__iter_idx:		Index to search the next entry for iterators
- * @__iter_max:		Index to limit the search
- * @__irqdomains:	Per device interrupt domains
  */
 struct msi_device_data {
 	unsigned long			properties;
 	struct platform_msi_priv_data	*platform_data;
 	struct mutex			mutex;
-	struct xarray			__store;
+	struct msi_dev_domain		__domains[MSI_MAX_DEVICE_IRQDOMAINS];
 	unsigned long			__iter_idx;
-	unsigned long			__iter_max;
-	struct irq_domain		*__irqdomains[MSI_MAX_DEVICE_IRQDOMAINS];
 };
 
 int msi_setup_device_data(struct device *dev);
@@ -219,7 +226,8 @@ static inline struct msi_desc *msi_first_desc(struct device *dev,
 	return msi_domain_first_desc(dev, MSI_DEFAULT_DOMAIN, filter);
 }
 
-struct msi_desc *msi_next_desc(struct device *dev, enum msi_desc_filter filter);
+struct msi_desc *msi_next_desc(struct device *dev, unsigned int domid,
+			       enum msi_desc_filter filter);
 
 /**
  * msi_domain_for_each_desc - Iterate the MSI descriptors in a specific domain
@@ -236,7 +244,7 @@ struct msi_desc *msi_next_desc(struct device *dev, enum msi_desc_filter filter);
  */
 #define msi_domain_for_each_desc(desc, dev, domid, filter)			\
 	for ((desc) = msi_domain_first_desc((dev), (domid), (filter)); (desc);	\
-	     (desc) = msi_next_desc((dev), (filter)))
+	     (desc) = msi_next_desc((dev), (domid), (filter)))
 
 /**
  * msi_for_each_desc - Iterate the MSI descriptors in the default irqdomain
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index c98c07ae46c9..695801b3cb68 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -34,37 +34,13 @@ struct msi_ctrl {
 	unsigned int			nirqs;
 };
 
-static void msi_domain_free_locked(struct device *dev, struct msi_ctrl *ctrl);
-static inline int msi_sysfs_create_group(struct device *dev);
-
-/* Invalid XA index which is outside of any searchable range */
+/* Invalid Xarray index which is outside of any searchable range */
 #define MSI_XA_MAX_INDEX	(ULONG_MAX - 1)
+/* The maximum domain size */
 #define MSI_XA_DOMAIN_SIZE	(MSI_MAX_INDEX + 1)
 
-static inline void msi_setup_default_irqdomain(struct device *dev, struct msi_device_data *md)
-{
-	if (!dev->msi.domain)
-		return;
-	/*
-	 * If @dev::msi::domain is a global MSI domain, copy the pointer
-	 * into the domain array to avoid conditionals all over the place.
-	 */
-	if (!irq_domain_is_msi_parent(dev->msi.domain))
-		md->__irqdomains[MSI_DEFAULT_DOMAIN] = dev->msi.domain;
-}
-
-static int msi_get_domain_base_index(struct device *dev, unsigned int domid)
-{
-	lockdep_assert_held(&dev->msi.data->mutex);
-
-	if (WARN_ON_ONCE(domid >= MSI_MAX_DEVICE_IRQDOMAINS))
-		return -ENODEV;
-
-	if (WARN_ON_ONCE(!dev->msi.data->__irqdomains[domid]))
-		return -ENODEV;
-
-	return domid * MSI_XA_DOMAIN_SIZE;
-}
+static void msi_domain_free_locked(struct device *dev, struct msi_ctrl *ctrl);
+static inline int msi_sysfs_create_group(struct device *dev);
 
 
 /**
@@ -104,27 +80,16 @@ static void msi_free_desc(struct msi_desc *desc)
 	kfree(desc);
 }
 
-static int msi_insert_desc(struct device *dev, struct msi_desc *desc,
+static int msi_insert_desc(struct msi_device_data *md, struct msi_desc *desc,
 			   unsigned int domid, unsigned int index)
 {
-	struct msi_device_data *md = dev->msi.data;
-	int baseidx, ret;
-
-	baseidx = msi_get_domain_base_index(dev, domid);
-	if (baseidx < 0) {
-		ret = baseidx;
-		goto fail;
-	}
+	struct xarray *xa = &md->__domains[domid].store;
+	int ret;
 
 	desc->msi_index = index;
-	index += baseidx;
-	ret = xa_insert(&md->__store, index, desc, GFP_KERNEL);
+	ret = xa_insert(xa, index, desc, GFP_KERNEL);
 	if (ret)
-		goto fail;
-	return 0;
-
-fail:
-	msi_free_desc(desc);
+		msi_free_desc(desc);
 	return ret;
 }
 
@@ -152,7 +117,7 @@ int msi_domain_insert_msi_desc(struct device *dev, unsigned int domid,
 	/* Copy type specific data to the new descriptor. */
 	desc->pci = init_desc->pci;
 
-	return msi_insert_desc(dev, desc, domid, init_desc->msi_index);
+	return msi_insert_desc(dev->msi.data, desc, domid, init_desc->msi_index);
 }
 
 static bool msi_desc_match(struct msi_desc *desc, enum msi_desc_filter filter)
@@ -169,9 +134,11 @@ static bool msi_desc_match(struct msi_desc *desc, enum msi_desc_filter filter)
 	return false;
 }
 
-static bool msi_ctrl_range_valid(struct device *dev, struct msi_ctrl *ctrl)
+static bool msi_ctrl_valid(struct device *dev, struct msi_ctrl *ctrl)
 {
-	if (WARN_ON_ONCE(ctrl->first > ctrl->last ||
+	if (WARN_ON_ONCE(ctrl->domid >= MSI_MAX_DEVICE_IRQDOMAINS ||
+			 !dev->msi.data->__domains[ctrl->domid].domain ||
+			 ctrl->first > ctrl->last ||
 			 ctrl->first > MSI_MAX_INDEX ||
 			 ctrl->last > MSI_MAX_INDEX))
 		return false;
@@ -180,21 +147,17 @@ static bool msi_ctrl_range_valid(struct device *dev, struct msi_ctrl *ctrl)
 
 static void msi_domain_free_descs(struct device *dev, struct msi_ctrl *ctrl)
 {
-	struct xarray *xa = &dev->msi.data->__store;
 	struct msi_desc *desc;
+	struct xarray *xa;
 	unsigned long idx;
-	int base;
 
 	lockdep_assert_held(&dev->msi.data->mutex);
 
-	if (!msi_ctrl_range_valid(dev, ctrl))
-		return;
-
-	base = msi_get_domain_base_index(dev, ctrl->domid);
-	if (base < 0)
+	if (!msi_ctrl_valid(dev, ctrl))
 		return;
 
-	xa_for_each_range(xa, idx, desc, ctrl->first + base, ctrl->last + base) {
+	xa = &dev->msi.data->__domains[ctrl->domid].store;
+	xa_for_each_range(xa, idx, desc, ctrl->first, ctrl->last) {
 		xa_erase(xa, idx);
 
 		/* Leak the descriptor when it is still referenced */
@@ -234,22 +197,18 @@ static int msi_domain_add_simple_msi_descs(struct device *dev, struct msi_ctrl *
 {
 	struct msi_desc *desc;
 	unsigned int idx;
-	int ret, baseidx;
+	int ret;
 
 	lockdep_assert_held(&dev->msi.data->mutex);
 
-	if (!msi_ctrl_range_valid(dev, ctrl))
+	if (!msi_ctrl_valid(dev, ctrl))
 		return -EINVAL;
 
-	baseidx = msi_get_domain_base_index(dev, ctrl->domid);
-	if (baseidx < 0)
-		return baseidx;
-
 	for (idx = ctrl->first; idx <= ctrl->last; idx++) {
 		desc = msi_alloc_desc(dev, 1, NULL);
 		if (!desc)
 			goto fail_mem;
-		ret = msi_insert_desc(dev, desc, ctrl->domid, idx);
+		ret = msi_insert_desc(dev->msi.data, desc, ctrl->domid, idx);
 		if (ret)
 			goto fail;
 	}
@@ -278,9 +237,12 @@ EXPORT_SYMBOL_GPL(get_cached_msi_msg);
 static void msi_device_data_release(struct device *dev, void *res)
 {
 	struct msi_device_data *md = res;
+	int i;
 
-	WARN_ON_ONCE(!xa_empty(&md->__store));
-	xa_destroy(&md->__store);
+	for (i = 0; i < MSI_MAX_DEVICE_IRQDOMAINS; i++) {
+		WARN_ON_ONCE(!xa_empty(&md->__domains[i].store));
+		xa_destroy(&md->__domains[i].store);
+	}
 	dev->msi.data = NULL;
 }
 
@@ -297,7 +259,7 @@ static void msi_device_data_release(struct device *dev, void *res)
 int msi_setup_device_data(struct device *dev)
 {
 	struct msi_device_data *md;
-	int ret;
+	int ret, i;
 
 	if (dev->msi.data)
 		return 0;
@@ -312,11 +274,19 @@ int msi_setup_device_data(struct device *dev)
 		return ret;
 	}
 
-	msi_setup_default_irqdomain(dev, md);
+	for (i = 0; i < MSI_MAX_DEVICE_IRQDOMAINS; i++)
+		xa_init(&md->__domains[i].store);
+
+	/*
+	 * If @dev::msi::domain is set and is a global MSI domain, copy the
+	 * pointer into the domain array so all code can operate on domain
+	 * ids. The NULL pointer check is required to keep the legacy
+	 * architecture specific PCI/MSI support working.
+	 */
+	if (dev->msi.domain && !irq_domain_is_msi_parent(dev->msi.domain))
+		md->__domains[MSI_DEFAULT_DOMAIN].domain = dev->msi.domain;
 
-	xa_init(&md->__store);
 	mutex_init(&md->mutex);
-	md->__iter_idx = MSI_XA_MAX_INDEX;
 	dev->msi.data = md;
 	devres_add(dev, md);
 	return 0;
@@ -338,17 +308,19 @@ EXPORT_SYMBOL_GPL(msi_lock_descs);
  */
 void msi_unlock_descs(struct device *dev)
 {
-	/* Invalidate the index wich was cached by the iterator */
+	/* Invalidate the index which was cached by the iterator */
 	dev->msi.data->__iter_idx = MSI_XA_MAX_INDEX;
 	mutex_unlock(&dev->msi.data->mutex);
 }
 EXPORT_SYMBOL_GPL(msi_unlock_descs);
 
-static struct msi_desc *msi_find_desc(struct msi_device_data *md, enum msi_desc_filter filter)
+static struct msi_desc *msi_find_desc(struct msi_device_data *md, unsigned int domid,
+				      enum msi_desc_filter filter)
 {
+	struct xarray *xa = &md->__domains[domid].store;
 	struct msi_desc *desc;
 
-	xa_for_each_range(&md->__store, md->__iter_idx, desc, md->__iter_idx, md->__iter_max) {
+	xa_for_each_start(xa, md->__iter_idx, desc, md->__iter_idx) {
 		if (msi_desc_match(desc, filter))
 			return desc;
 	}
@@ -372,26 +344,21 @@ struct msi_desc *msi_domain_first_desc(struct device *dev, unsigned int domid,
 				       enum msi_desc_filter filter)
 {
 	struct msi_device_data *md = dev->msi.data;
-	int baseidx;
 
-	if (WARN_ON_ONCE(!md))
+	if (WARN_ON_ONCE(!md || domid >= MSI_MAX_DEVICE_IRQDOMAINS))
 		return NULL;
 
 	lockdep_assert_held(&md->mutex);
 
-	baseidx = msi_get_domain_base_index(dev, domid);
-	if (baseidx < 0)
-		return NULL;
-
-	md->__iter_idx = baseidx;
-	md->__iter_max = baseidx + MSI_MAX_INDEX;
-	return msi_find_desc(md, filter);
+	md->__iter_idx = 0;
+	return msi_find_desc(md, domid, filter);
 }
 EXPORT_SYMBOL_GPL(msi_domain_first_desc);
 
 /**
  * msi_next_desc - Get the next MSI descriptor of a device
  * @dev:	Device to operate on
+ * @domid:	The id of the interrupt domain which should be walked.
  * @filter:	Descriptor state filter
  *
  * The first invocation of msi_next_desc() has to be preceeded by a
@@ -402,20 +369,21 @@ EXPORT_SYMBOL_GPL(msi_domain_first_desc);
  * Return: Pointer to the next MSI descriptor matching the search
  *	   criteria, NULL if none found.
  */
-struct msi_desc *msi_next_desc(struct device *dev, enum msi_desc_filter filter)
+struct msi_desc *msi_next_desc(struct device *dev, unsigned int domid,
+			       enum msi_desc_filter filter)
 {
 	struct msi_device_data *md = dev->msi.data;
 
-	if (WARN_ON_ONCE(!md))
+	if (WARN_ON_ONCE(!md || domid >= MSI_MAX_DEVICE_IRQDOMAINS))
 		return NULL;
 
 	lockdep_assert_held(&md->mutex);
 
-	if (md->__iter_idx >= md->__iter_max)
+	if (md->__iter_idx >= (unsigned long)MSI_MAX_INDEX)
 		return NULL;
 
 	md->__iter_idx++;
-	return msi_find_desc(md, filter);
+	return msi_find_desc(md, domid, filter);
 }
 EXPORT_SYMBOL_GPL(msi_next_desc);
 
@@ -432,12 +400,12 @@ unsigned int msi_domain_get_virq(struct device *dev, unsigned int domid, unsigne
 	struct msi_desc *desc;
 	unsigned int ret = 0;
 	bool pcimsi = false;
-	int base;
+	struct xarray *xa;
 
 	if (!dev->msi.data)
 		return 0;
 
-	if (WARN_ON_ONCE(index > MSI_MAX_INDEX))
+	if (WARN_ON_ONCE(index > MSI_MAX_INDEX || domid >= MSI_MAX_DEVICE_IRQDOMAINS))
 		return 0;
 
 	/* This check is only valid for the PCI default MSI domain */
@@ -445,13 +413,8 @@ unsigned int msi_domain_get_virq(struct device *dev, unsigned int domid, unsigne
 		pcimsi = to_pci_dev(dev)->msi_enabled;
 
 	msi_lock_descs(dev);
-
-	base = msi_get_domain_base_index(dev, domid);
-	if (base < 0)
-		goto unlock;
-
-	base += pcimsi ? 0 : index;
-	desc = xa_load(&dev->msi.data->__store, base);
+	xa = &dev->msi.data->__domains[domid].store;
+	desc = xa_load(xa, pcimsi ? 0 : index);
 	if (desc && desc->irq) {
 		/*
 		 * PCI-MSI has only one descriptor for multiple interrupts.
@@ -466,7 +429,6 @@ unsigned int msi_domain_get_virq(struct device *dev, unsigned int domid, unsigne
 		}
 	}
 
-unlock:
 	msi_unlock_descs(dev);
 	return ret;
 }
@@ -595,7 +557,7 @@ static struct irq_domain *msi_get_device_domain(struct device *dev, unsigned int
 	if (WARN_ON_ONCE(domid >= MSI_MAX_DEVICE_IRQDOMAINS))
 		return NULL;
 
-	domain = dev->msi.data->__irqdomains[domid];
+	domain = dev->msi.data->__domains[domid].domain;
 	if (!domain)
 		return NULL;
 
@@ -846,9 +808,10 @@ int msi_domain_populate_irqs(struct irq_domain *domain, struct device *dev,
 		.last	= virq_base + nvec - 1,
 	};
 	struct msi_desc *desc;
+	struct xarray *xa;
 	int ret, virq;
 
-	if (!msi_ctrl_range_valid(dev, &ctrl))
+	if (!msi_ctrl_valid(dev, &ctrl))
 		return -EINVAL;
 
 	msi_lock_descs(dev);
@@ -856,8 +819,10 @@ int msi_domain_populate_irqs(struct irq_domain *domain, struct device *dev,
 	if (ret)
 		goto unlock;
 
+	xa = &dev->msi.data->__domains[ctrl.domid].store;
+
 	for (virq = virq_base; virq < virq_base + nvec; virq++) {
-		desc = xa_load(&dev->msi.data->__store, virq);
+		desc = xa_load(xa, virq);
 		desc->irq = virq;
 
 		ops->set_desc(arg, desc);
@@ -987,8 +952,8 @@ static int msi_init_virq(struct irq_domain *domain, int virq, unsigned int vflag
 static int __msi_domain_alloc_irqs(struct device *dev, struct irq_domain *domain,
 				   struct msi_ctrl *ctrl)
 {
+	struct xarray *xa = &dev->msi.data->__domains[ctrl->domid].store;
 	struct msi_domain_info *info = domain->host_data;
-	struct xarray *xa = &dev->msi.data->__store;
 	struct msi_domain_ops *ops = info->ops;
 	unsigned int vflags = 0, allocated = 0;
 	msi_alloc_info_t arg = { };
@@ -1074,7 +1039,7 @@ static int __msi_domain_alloc_locked(struct device *dev, struct msi_ctrl *ctrl)
 	struct irq_domain *domain;
 	int ret;
 
-	if (!msi_ctrl_range_valid(dev, ctrl))
+	if (!msi_ctrl_valid(dev, ctrl))
 		return -EINVAL;
 
 	domain = msi_get_device_domain(dev, ctrl->domid);
@@ -1180,16 +1145,14 @@ int msi_domain_alloc_irqs_all_locked(struct device *dev, unsigned int domid, int
 static void __msi_domain_free_irqs(struct device *dev, struct irq_domain *domain,
 				   struct msi_ctrl *ctrl)
 {
+	struct xarray *xa = &dev->msi.data->__domains[ctrl->domid].store;
 	struct msi_domain_info *info = domain->host_data;
-	struct xarray *xa = &dev->msi.data->__store;
 	struct irq_data *irqd;
 	struct msi_desc *desc;
 	unsigned long idx;
-	int i, base;
-
-	base = ctrl->domid * MSI_XA_DOMAIN_SIZE;
+	int i;
 
-	xa_for_each_range(xa, idx, desc, ctrl->first + base, ctrl->last + base) {
+	xa_for_each_range(xa, idx, desc, ctrl->first, ctrl->last) {
 		/* Only handle MSI entries which have an interrupt associated */
 		if (!msi_desc_match(desc, MSI_DESC_ASSOCIATED))
 			continue;
@@ -1214,7 +1177,7 @@ static void msi_domain_free_locked(struct device *dev, struct msi_ctrl *ctrl)
 	struct msi_domain_ops *ops;
 	struct irq_domain *domain;
 
-	if (!msi_ctrl_range_valid(dev, ctrl))
+	if (!msi_ctrl_valid(dev, ctrl))
 		return;
 
 	domain = msi_get_device_domain(dev, ctrl->domid);

