Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8C246AD9D
	for <lists+linux-pci@lfdr.de>; Mon,  6 Dec 2021 23:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376716AbhLFW4E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Dec 2021 17:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376698AbhLFWzl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Dec 2021 17:55:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79186C061359;
        Mon,  6 Dec 2021 14:51:52 -0800 (PST)
Message-ID: <20211206210749.224917330@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638831111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=21WP0HmWXZNG6C0xaMrdmPLK4zT+1q4zI1Oc6dWMW6M=;
        b=e4ohXDN8N3EbP+sROJ9Vc7PD/uaHcghbISezOJ56XaxTiurZIxJTlRHJJkP3swh6sSnDXs
        e7IXRkELCmBqfKF+BOHcCFMQ5IrZuzjToW3xE1Bm4OnYb6N2jSvLQK578eTHhV9LgsOWMm
        eAge6jql/Gi910inDARZYlIaaLy6gdLldduqaU8SnE0JJQb6JDpnW4qZgPvqb4oQOZl1eR
        WYcSU3BL87ixyGnOP+EIsPpctR8dDI1ILzXhZU/OcI3YfCieFqazL6RKk+kHylxS5kSo0s
        GpDqDp3yQezbN2pTs/fbVZXZd39KPh9SIwsUaGtr9PxRNlD//hhSRWnc+WvwgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638831111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=21WP0HmWXZNG6C0xaMrdmPLK4zT+1q4zI1Oc6dWMW6M=;
        b=DR0QJ0cMvP6X9yWSUQVTSHjnTfMPJHHtdGpnte6lBofbmRbMre4ig5B947piM8An5fcNhc
        m+ozvwWqr04jKfCQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Cedric Le Goater <clg@kaod.org>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
Subject: [patch V2 30/31] genirq/msi: Simplify sysfs handling
References: <20211206210600.123171746@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  6 Dec 2021 23:51:50 +0100 (CET)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The sysfs handling for MSI is a convoluted maze and it is in the way of
supporting dynamic expansion of the MSI-X vectors because it only supports
a one off bulk population/free of the sysfs entries.

Change it to do:

   1) Creating an empty sysfs attribute group when msi_device_data is
      allocated

   2) Populate the entries when the MSI descriptor is initialized

   3) Free the entries when a MSI descriptor is detached from a Linux
      interrupt.

   4) Provide functions for the legacy non-irqdomain fallback code to
      do a bulk population/free. This code won't support dynamic
      expansion.

This makes the code simpler and reduces the number of allocations as the
empty attribute group can be shared.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/msi.h |    8 +-
 kernel/irq/msi.c    |  196 +++++++++++++++++++++++-----------------------------
 2 files changed, 95 insertions(+), 109 deletions(-)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -72,7 +72,7 @@ struct irq_data;
 struct msi_desc;
 struct pci_dev;
 struct platform_msi_priv_data;
-struct attribute_group;
+struct device_attribute;
 
 void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 #ifdef CONFIG_GENERIC_MSI_IRQ
@@ -130,6 +130,7 @@ struct pci_msi_desc {
  * @dev:	Pointer to the device which uses this descriptor
  * @msg:	The last set MSI message cached for reuse
  * @affinity:	Optional pointer to a cpu affinity mask for this descriptor
+ * @sysfs_attr:	Pointer to sysfs device attribute
  *
  * @write_msi_msg:	Callback that may be called when the MSI message
  *			address or data changes
@@ -149,6 +150,9 @@ struct msi_desc {
 #ifdef CONFIG_IRQ_MSI_IOMMU
 	const void			*iommu_cookie;
 #endif
+#ifdef CONFIG_SYSFS
+	struct device_attribute		*sysfs_attrs;
+#endif
 
 	void (*write_msi_msg)(struct msi_desc *entry, void *data);
 	void *write_msi_msg_data;
@@ -172,7 +176,6 @@ enum msi_desc_filter {
 /**
  * msi_device_data - MSI per device data
  * @properties:		MSI properties which are interesting to drivers
- * @attrs:		Pointer to the sysfs attribute group
  * @platform_data:	Platform-MSI specific data
  * @list:		List of MSI descriptors associated to the device
  * @mutex:		Mutex protecting the MSI list
@@ -180,7 +183,6 @@ enum msi_desc_filter {
  */
 struct msi_device_data {
 	unsigned long			properties;
-	const struct attribute_group    **attrs;
 	struct platform_msi_priv_data	*platform_data;
 	struct list_head		list;
 	struct mutex			mutex;
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -19,6 +19,7 @@
 
 #include "internals.h"
 
+static inline int msi_sysfs_create_group(struct device *dev);
 #define dev_to_msi_list(dev)	(&(dev)->msi.data->list)
 
 /**
@@ -202,6 +203,7 @@ static void msi_device_data_release(stru
 int msi_setup_device_data(struct device *dev)
 {
 	struct msi_device_data *md;
+	int ret;
 
 	if (dev->msi.data)
 		return 0;
@@ -210,6 +212,12 @@ int msi_setup_device_data(struct device
 	if (!md)
 		return -ENOMEM;
 
+	ret = msi_sysfs_create_group(dev);
+	if (ret) {
+		devres_free(md);
+		return ret;
+	}
+
 	INIT_LIST_HEAD(&md->list);
 	mutex_init(&md->mutex);
 	dev->msi.data = md;
@@ -379,6 +387,20 @@ unsigned int msi_get_virq(struct device
 EXPORT_SYMBOL_GPL(msi_get_virq);
 
 #ifdef CONFIG_SYSFS
+static struct attribute *msi_dev_attrs[] = {
+	NULL
+};
+
+static const struct attribute_group msi_irqs_group = {
+	.name	= "msi_irqs",
+	.attrs	= msi_dev_attrs,
+};
+
+static inline int msi_sysfs_create_group(struct device *dev)
+{
+	return devm_device_add_group(dev, &msi_irqs_group);
+}
+
 static ssize_t msi_mode_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
@@ -388,97 +410,74 @@ static ssize_t msi_mode_show(struct devi
 	return sysfs_emit(buf, "%s\n", is_msix ? "msix" : "msi");
 }
 
-/**
- * msi_populate_sysfs - Populate msi_irqs sysfs entries for devices
- * @dev:	The device(PCI, platform etc) who will get sysfs entries
- */
-static const struct attribute_group **msi_populate_sysfs(struct device *dev)
+static void msi_sysfs_remove_desc(struct device *dev, struct msi_desc *desc)
 {
-	const struct attribute_group **msi_irq_groups;
-	struct attribute **msi_attrs, *msi_attr;
-	struct device_attribute *msi_dev_attr;
-	struct attribute_group *msi_irq_group;
-	struct msi_desc *entry;
-	int ret = -ENOMEM;
-	int num_msi = 0;
-	int count = 0;
+	struct device_attribute *attrs = desc->sysfs_attrs;
 	int i;
 
-	/* Determine how many msi entries we have */
-	msi_for_each_desc(entry, dev, MSI_DESC_ALL)
-		num_msi += entry->nvec_used;
-	if (!num_msi)
-		return NULL;
+	if (!attrs)
+		return;
 
-	/* Dynamically create the MSI attributes for the device */
-	msi_attrs = kcalloc(num_msi + 1, sizeof(void *), GFP_KERNEL);
-	if (!msi_attrs)
-		return ERR_PTR(-ENOMEM);
-
-	msi_for_each_desc(entry, dev, MSI_DESC_ALL) {
-		for (i = 0; i < entry->nvec_used; i++) {
-			msi_dev_attr = kzalloc(sizeof(*msi_dev_attr), GFP_KERNEL);
-			if (!msi_dev_attr)
-				goto error_attrs;
-			msi_attrs[count] = &msi_dev_attr->attr;
-
-			sysfs_attr_init(&msi_dev_attr->attr);
-			msi_dev_attr->attr.name = kasprintf(GFP_KERNEL, "%d",
-							    entry->irq + i);
-			if (!msi_dev_attr->attr.name)
-				goto error_attrs;
-			msi_dev_attr->attr.mode = 0444;
-			msi_dev_attr->show = msi_mode_show;
-			++count;
-		}
+	desc->sysfs_attrs = NULL;
+	for (i = 0; i < desc->nvec_used; i++) {
+		if (attrs[i].show)
+			sysfs_remove_file_from_group(&dev->kobj, &attrs[i].attr, msi_irqs_group.name);
+		kfree(attrs[i].attr.name);
 	}
+	kfree(attrs);
+}
 
-	msi_irq_group = kzalloc(sizeof(*msi_irq_group), GFP_KERNEL);
-	if (!msi_irq_group)
-		goto error_attrs;
-	msi_irq_group->name = "msi_irqs";
-	msi_irq_group->attrs = msi_attrs;
-
-	msi_irq_groups = kcalloc(2, sizeof(void *), GFP_KERNEL);
-	if (!msi_irq_groups)
-		goto error_irq_group;
-	msi_irq_groups[0] = msi_irq_group;
+static int msi_sysfs_populate_desc(struct device *dev, struct msi_desc *desc)
+{
+	struct device_attribute *attrs;
+	int ret, i;
 
-	ret = sysfs_create_groups(&dev->kobj, msi_irq_groups);
-	if (ret)
-		goto error_irq_groups;
+	attrs = kcalloc(desc->nvec_used, sizeof(*attrs), GFP_KERNEL);
+	if (!attrs)
+		return -ENOMEM;
+
+	desc->sysfs_attrs = attrs;
+	for (i = 0; i < desc->nvec_used; i++) {
+		sysfs_attr_init(&attrs[i].attr);
+		attrs[i].attr.name = kasprintf(GFP_KERNEL, "%d", desc->irq + i);
+		if (!attrs[i].attr.name) {
+			ret = -ENOMEM;
+			goto fail;
+		}
 
-	return msi_irq_groups;
+		attrs[i].attr.mode = 0444;
+		attrs[i].show = msi_mode_show;
 
-error_irq_groups:
-	kfree(msi_irq_groups);
-error_irq_group:
-	kfree(msi_irq_group);
-error_attrs:
-	count = 0;
-	msi_attr = msi_attrs[count];
-	while (msi_attr) {
-		msi_dev_attr = container_of(msi_attr, struct device_attribute, attr);
-		kfree(msi_attr->name);
-		kfree(msi_dev_attr);
-		++count;
-		msi_attr = msi_attrs[count];
+		ret = sysfs_add_file_to_group(&dev->kobj, &attrs[i].attr, msi_irqs_group.name);
+		if (ret) {
+			attrs[i].show = NULL;
+			goto fail;
+		}
 	}
-	kfree(msi_attrs);
-	return ERR_PTR(ret);
+	return 0;
+
+fail:
+	msi_sysfs_remove_desc(dev, desc);
+	return ret;
 }
 
+#ifdef CONFIG_PCI_MSI_ARCH_FALLBACKS
 /**
  * msi_device_populate_sysfs - Populate msi_irqs sysfs entries for a device
  * @dev:	The device (PCI, platform etc) which will get sysfs entries
  */
 int msi_device_populate_sysfs(struct device *dev)
 {
-	const struct attribute_group **group = msi_populate_sysfs(dev);
+	struct msi_desc *desc;
+	int ret;
 
-	if (IS_ERR(group))
-		return PTR_ERR(group);
-	dev->msi.data->attrs = group;
+	msi_for_each_desc(desc, dev, MSI_DESC_ASSOCIATED) {
+		if (desc->sysfs_attrs)
+			continue;
+		ret = msi_sysfs_populate_desc(dev, desc);
+		if (ret)
+			return ret;
+	}
 	return 0;
 }
 
@@ -489,28 +488,17 @@ int msi_device_populate_sysfs(struct dev
  */
 void msi_device_destroy_sysfs(struct device *dev)
 {
-	const struct attribute_group **msi_irq_groups = dev->msi.data->attrs;
-	struct device_attribute *dev_attr;
-	struct attribute **msi_attrs;
-	int count = 0;
-
-	dev->msi.data->attrs = NULL;
-	if (!msi_irq_groups)
-		return;
+	struct msi_desc *desc;
 
-	sysfs_remove_groups(&dev->kobj, msi_irq_groups);
-	msi_attrs = msi_irq_groups[0]->attrs;
-	while (msi_attrs[count]) {
-		dev_attr = container_of(msi_attrs[count], struct device_attribute, attr);
-		kfree(dev_attr->attr.name);
-		kfree(dev_attr);
-		++count;
-	}
-	kfree(msi_attrs);
-	kfree(msi_irq_groups[0]);
-	kfree(msi_irq_groups);
+	msi_for_each_desc(desc, dev, MSI_DESC_ALL)
+		msi_sysfs_remove_desc(dev, desc);
 }
-#endif
+#endif /* CONFIG_PCI_MSI_ARCH_FALLBACK */
+#else /* CONFIG_SYSFS */
+static inline int msi_sysfs_create_group(struct device *dev) { return 0; }
+static inline int msi_sysfs_populate_desc(struct device *dev, struct msi_desc *desc) { return 0; }
+static inline void msi_sysfs_remove_desc(struct device *dev, struct msi_desc *desc) { }
+#endif /* !CONFIG_SYSFS */
 
 #ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
 static inline void irq_chip_write_msi_msg(struct irq_data *data,
@@ -942,6 +930,12 @@ int __msi_domain_alloc_irqs(struct irq_d
 			ret = msi_init_virq(domain, virq + i, vflags);
 			if (ret)
 				return ret;
+
+			if (info->flags & MSI_FLAG_DEV_SYSFS) {
+				ret = msi_sysfs_populate_desc(dev, desc);
+				if (ret)
+					return ret;
+			}
 		}
 		allocated++;
 	}
@@ -986,18 +980,7 @@ int msi_domain_alloc_irqs_descs_locked(s
 
 	ret = ops->domain_alloc_irqs(domain, dev, nvec);
 	if (ret)
-		goto cleanup;
-
-	if (!(info->flags & MSI_FLAG_DEV_SYSFS))
-		return 0;
-
-	ret = msi_device_populate_sysfs(dev);
-	if (ret)
-		goto cleanup;
-	return 0;
-
-cleanup:
-	msi_domain_free_irqs_descs_locked(domain, dev);
+		msi_domain_free_irqs_descs_locked(domain, dev);
 	return ret;
 }
 
@@ -1022,6 +1005,7 @@ int msi_domain_alloc_irqs(struct irq_dom
 
 void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
 {
+	struct msi_domain_info *info = domain->host_data;
 	struct irq_data *irqd;
 	struct msi_desc *desc;
 	int i;
@@ -1036,6 +1020,8 @@ void __msi_domain_free_irqs(struct irq_d
 		}
 
 		irq_domain_free_irqs(desc->irq, desc->nvec_used);
+		if (info->flags & MSI_FLAG_DEV_SYSFS)
+			msi_sysfs_remove_desc(dev, desc);
 		desc->irq = 0;
 	}
 }
@@ -1064,8 +1050,6 @@ void msi_domain_free_irqs_descs_locked(s
 
 	lockdep_assert_held(&dev->msi.data->mutex);
 
-	if (info->flags & MSI_FLAG_DEV_SYSFS)
-		msi_device_destroy_sysfs(dev);
 	ops->domain_free_irqs(domain, dev);
 	msi_domain_free_msi_descs(info, dev);
 }

