Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A851D45FA84
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 02:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348874AbhK0BcT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 20:32:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40022 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348666AbhK0BaO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 20:30:14 -0500
Message-ID: <20211126232734.531194050@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=z6dcduacKPcvuHhstAFE2CgJ262pdWvtfjUlsYpcJo0=;
        b=wNd/UdhtOuyG6hR1CojOJ7dT8ywotGs+6jouAqrg50+AFAJx7lgCtNiBA9f0HqtTKVOjFy
        WI95kwRI1lxcCnjXJML87sAAS+v6n0s7ce18ry7VdgQTZloVC1hsL3Y2dohlfXqbCDgJZ1
        +xQAM40AcUysjhGnaqxxFliFCnEkyeQKth7cCq3Azy4b6/ALltYIpgnImMHJTBo4LSZ1Fc
        iqz2mCxfl+fJmASHHWGi3eFiZkQLwoau0QhgqkudeqJ+BmjMTAZ3qOsxb6asU5A1wB3w6f
        OL1LgZsmvI5SENS7nRVsxseG9JGsxg1eIF3v+bJRLk2vP56aiBtfjwCU9D4mWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=z6dcduacKPcvuHhstAFE2CgJ262pdWvtfjUlsYpcJo0=;
        b=pOAnc66w/kUZ+aKOetZAEbuapqnbNeEjyQ9zVWgpbCsEVKeLfi2jCnYY+dSKWIBqUL0rYQ
        zMXdNZxJAkdn93Dw==
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
Subject: [patch 04/32] genirq/msi: Provide a set of advanced MSI accessors and
 iterators
References: <20211126230957.239391799@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:22:33 +0100 (CET)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In preparation for dynamic handling of MSI-X interrupts provide a new set
of MSI descriptor accessor functions and iterators. They are benefitial per
se as they allow to cleanup quite some code in various MSI domain
implementations.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h |   58 ++++++++++++++++++++++++++++
 kernel/irq/msi.c    |  107 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 165 insertions(+)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -140,6 +140,18 @@ struct msi_desc {
 	struct pci_msi_desc		pci;
 };
 
+/*
+ * Filter values for the MSI descriptor iterators and accessor functions.
+ */
+enum msi_desc_filter {
+	/* All descriptors */
+	MSI_DESC_ALL,
+	/* Descriptors which have no interrupt associated */
+	MSI_DESC_NOTASSOCIATED,
+	/* Descriptors which have an interrupt associated */
+	MSI_DESC_ASSOCIATED,
+};
+
 /**
  * msi_device_data - MSI per device data
  * @lock:		Spinlock to protect register access
@@ -148,6 +160,8 @@ struct msi_desc {
  * @platform_data:	Platform-MSI specific data
  * @list:		List of MSI descriptors associated to the device
  * @mutex:		Mutex protecting the MSI list
+ * @__next:		Cached pointer to the next entry for iterators
+ * @__filter:		Cached descriptor filter
  */
 struct msi_device_data {
 	raw_spinlock_t			lock;
@@ -156,6 +170,8 @@ struct msi_device_data {
 	struct platform_msi_priv_data	*platform_data;
 	struct list_head		list;
 	struct mutex			mutex;
+	struct msi_desc			*__next;
+	enum msi_desc_filter		__filter;
 };
 
 int msi_setup_device_data(struct device *dev);
@@ -193,6 +209,48 @@ static inline unsigned int msi_get_virq(
 void msi_lock_descs(struct device *dev);
 void msi_unlock_descs(struct device *dev);
 
+struct msi_desc *__msi_first_desc(struct device *dev, enum msi_desc_filter filter, unsigned int base_index);
+struct msi_desc *msi_next_desc(struct device *dev);
+
+/**
+ * msi_first_desc - Get the first MSI descriptor associated to the device
+ * @dev:	Device to search
+ */
+static inline struct msi_desc *msi_first_desc(struct device *dev)
+{
+	return __msi_first_desc(dev, MSI_DESC_ALL, 0);
+}
+
+
+/**
+ * msi_for_each_desc_from - Iterate the MSI descriptors from a given index
+ *
+ * @desc:	struct msi_desc pointer used as iterator
+ * @dev:	struct device pointer - device to iterate
+ * @filter:	Filter for descriptor selection
+ * @base_index:	MSI index to iterate from
+ *
+ * Notes:
+ *  - The loop must be protected with a msi_lock_descs()/msi_unlock_descs()
+ *    pair.
+ *  - It is safe to remove a retrieved MSI descriptor in the loop.
+ */
+#define msi_for_each_desc_from(desc, dev, filter, base_index)			\
+	for ((desc) = __msi_first_desc((dev), (filter), (base_index)); (desc);	\
+	     (desc) = msi_next_desc((dev)))
+
+/**
+ * msi_for_each_desc - Iterate the MSI descriptors
+ *
+ * @desc:	struct msi_desc pointer used as iterator
+ * @dev:	struct device pointer - device to iterate
+ * @filter:	Filter for descriptor selection
+ *
+ * See msi_for_each_desc_from()for further information.
+ */
+#define msi_for_each_desc(desc, dev, filter)				\
+	msi_for_each_desc_from(desc, dev, filter, 0)
+
 /* Helpers to hide struct msi_desc implementation details */
 #define msi_desc_to_dev(desc)		((desc)->dev)
 #define dev_to_msi_list(dev)		(&(dev)->msi.data->list)
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -142,10 +142,117 @@ void msi_unlock_descs(struct device *dev
 {
 	if (WARN_ON_ONCE(!dev->msi.data))
 		return;
+	/* Clear the next pointer which was cached by the iterator */
+	dev->msi.data->__next = NULL;
 	mutex_unlock(&dev->msi.data->mutex);
 }
 EXPORT_SYMBOL_GPL(msi_unlock_descs);
 
+static bool msi_desc_match(struct msi_desc *desc, enum msi_desc_filter filter)
+{
+	switch (filter) {
+	case MSI_DESC_ALL:
+		return true;
+	case MSI_DESC_NOTASSOCIATED:
+		return !desc->irq;
+	case MSI_DESC_ASSOCIATED:
+		return !!desc->irq;
+	}
+	WARN_ON_ONCE(1);
+	return false;
+}
+
+static struct msi_desc *msi_find_first_desc(struct device *dev, enum msi_desc_filter filter,
+					    unsigned int base_index)
+{
+	struct msi_desc *desc;
+
+	list_for_each_entry(desc, dev_to_msi_list(dev), list) {
+		if (desc->msi_index < base_index)
+			continue;
+		if (msi_desc_match(desc, filter))
+			return desc;
+	}
+	return NULL;
+}
+
+/**
+ * __msi_first_desc - Get the first MSI descriptor of a device
+ * @dev:	Device to operate on
+ * @filter:	Descriptor state filter
+ * @base_index:	MSI index to start from for range based operations
+ *
+ * Must be called with the MSI descriptor mutex held, i.e. msi_lock_descs()
+ * must be invoked before the call.
+ *
+ * Return: Pointer to the first MSI descriptor matching the search
+ *	   criteria, NULL if none found.
+ */
+struct msi_desc *__msi_first_desc(struct device *dev, enum msi_desc_filter filter,
+				  unsigned int base_index)
+{
+	struct msi_desc *desc;
+
+	if (WARN_ON_ONCE(!dev->msi.data))
+		return NULL;
+
+	lockdep_assert_held(&dev->msi.data->mutex);
+
+	/* Invalidate a previous invocation within the same lock section */
+	dev->msi.data->__next = NULL;
+
+	desc = msi_find_first_desc(dev, filter, base_index);
+	if (desc) {
+		dev->msi.data->__next = list_next_entry(desc, list);
+		dev->msi.data->__filter = filter;
+	}
+	return desc;
+}
+EXPORT_SYMBOL_GPL(__msi_first_desc);
+
+static struct msi_desc *__msi_next_desc(struct device *dev, enum msi_desc_filter filter,
+					struct msi_desc *from)
+{
+	struct msi_desc *desc = from;
+
+	list_for_each_entry_from(desc, dev_to_msi_list(dev), list) {
+		if (msi_desc_match(desc, filter))
+			return desc;
+	}
+	return NULL;
+}
+
+/**
+ * msi_next_desc - Get the next MSI descriptor of a device
+ * @dev:	Device to operate on
+ *
+ * The first invocation of msi_next_desc() has to be preceeded by a
+ * successful incovation of __msi_first_desc(). Consecutive invocations are
+ * only valid if the previous one was successful. All these operations have
+ * to be done within the same MSI mutex held region.
+ *
+ * Return: Pointer to the next MSI descriptor matching the search
+ *	   criteria, NULL if none found.
+ */
+struct msi_desc *msi_next_desc(struct device *dev)
+{
+	struct msi_device_data *data = dev->msi.data;
+	struct msi_desc *desc;
+
+	if (WARN_ON_ONCE(!data))
+		return NULL;
+
+	lockdep_assert_held(&data->mutex);
+
+	if (!data->__next)
+		return NULL;
+
+	desc = __msi_next_desc(dev, data->__filter, data->__next);
+	dev->msi.data->__next = desc ? list_next_entry(desc, list) : NULL;
+	return desc;
+}
+EXPORT_SYMBOL_GPL(msi_next_desc);
+
 /**
  * __msi_get_virq - Return Linux interrupt number of a MSI interrupt
  * @dev:	Device to operate on

