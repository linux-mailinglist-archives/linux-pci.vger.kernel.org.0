Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521B8638160
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 00:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiKXXYj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 18:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiKXXYe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 18:24:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2C688B51;
        Thu, 24 Nov 2022 15:24:23 -0800 (PST)
Message-ID: <20221124230313.864887773@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669332261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=NnY4k5ND5J68IEMTrYz8pNwP6PIWNLBi+fOo/MjnRyo=;
        b=HM1HfQDSQXO7ZFOEwPiY6bEBSZmkbhTocrtAjj9GAmbn7I++7rFXTsmzYUoidOWlolCx2E
        cW6w5UPS5Z2/T0zGQikoWs78c++WPLJtCDxdhlOoB66xITSAs+F85O4zAR67tgCH9po3gw
        nTJFp6B2clr0mhZ5HmNRvYC0pSBST62o2NMWmgcjd6zMJGmJnFGFQni8u4CpAua8R0SIfV
        n8zmdffKGUXDbqJwj63KEoYRWWPiqqTMsASYaLdnymE4JrHTVFNfPo9m7E2BBFt7G3kpY1
        tXTDEfpD2gi0cXJaVLLk5taLQhpf5F9y9loAeXm3Y4bIE5lBOHK9UGBKFcoehQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669332261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=NnY4k5ND5J68IEMTrYz8pNwP6PIWNLBi+fOo/MjnRyo=;
        b=mg3UZqz7MjLrqPbSwSowHzkClGzyjSE6/0d/Z5rbjPfG6lJpB1lI/z0/5bajKe51lUayxj
        QIFAUelszC5jUWDw==
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
Subject: [patch V3 08/22] genirq/msi: Move xarray into a separate struct and
 create an array
References: <20221124225331.464480443@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 25 Nov 2022 00:24:20 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The upcoming support for multiple MSI domains per device requires storage
for the MSI descriptors and in a second step storage for the irqdomain
pointers.

Move the xarray into a separate data structure msi_dev_domain and create an
array with size 1 in msi_device_data, which can be expanded later when the
support for per device domains is implemented.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: New patch to avoid the segmentation of the xarray (Marc)
---
 include/linux/msi.h     |   13 +++++++++++--
 include/linux/msi_api.h |    8 ++++++++
 kernel/irq/msi.c        |   32 ++++++++++++++++++++++----------
 3 files changed, 41 insertions(+), 12 deletions(-)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -173,19 +173,28 @@ enum msi_desc_filter {
 	MSI_DESC_ASSOCIATED,
 };
 
+
+/**
+ * struct msi_dev_domain - The internals of MSI domain info per device
+ * @store:		Xarray for storing MSI descriptor pointers
+ */
+struct msi_dev_domain {
+	struct xarray		store;
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
  */
 struct msi_device_data {
 	unsigned long			properties;
 	struct platform_msi_priv_data	*platform_data;
 	struct mutex			mutex;
-	struct xarray			__store;
+	struct msi_dev_domain		__domains[MSI_MAX_DEVICE_IRQDOMAINS];
 	unsigned long			__iter_idx;
 };
 
--- a/include/linux/msi_api.h
+++ b/include/linux/msi_api.h
@@ -10,6 +10,14 @@
 
 struct device;
 
+/*
+ * Per device interrupt domain related constants.
+ */
+enum msi_domain_ids {
+	MSI_DEFAULT_DOMAIN,
+	MSI_MAX_DEVICE_IRQDOMAINS,
+};
+
 unsigned int msi_get_virq(struct device *dev, unsigned int index);
 
 #endif
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -60,10 +60,11 @@ static void msi_free_desc(struct msi_des
 
 static int msi_insert_desc(struct msi_device_data *md, struct msi_desc *desc, unsigned int index)
 {
+	struct xarray *xa = &md->__domains[MSI_DEFAULT_DOMAIN].store;
 	int ret;
 
 	desc->msi_index = index;
-	ret = xa_insert(&md->__store, index, desc, GFP_KERNEL);
+	ret = xa_insert(xa, index, desc, GFP_KERNEL);
 	if (ret)
 		msi_free_desc(desc);
 	return ret;
@@ -147,7 +148,7 @@ static bool msi_desc_match(struct msi_de
 void msi_free_msi_descs_range(struct device *dev, unsigned int first_index,
 			      unsigned int last_index)
 {
-	struct xarray *xa = &dev->msi.data->__store;
+	struct xarray *xa = &dev->msi.data->__domains[MSI_DEFAULT_DOMAIN].store;
 	struct msi_desc *desc;
 	unsigned long idx;
 
@@ -179,9 +180,12 @@ EXPORT_SYMBOL_GPL(get_cached_msi_msg);
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
 
@@ -198,7 +202,7 @@ static void msi_device_data_release(stru
 int msi_setup_device_data(struct device *dev)
 {
 	struct msi_device_data *md;
-	int ret;
+	int ret, i;
 
 	if (dev->msi.data)
 		return 0;
@@ -213,7 +217,9 @@ int msi_setup_device_data(struct device
 		return ret;
 	}
 
-	xa_init(&md->__store);
+	for (i = 0; i < MSI_MAX_DEVICE_IRQDOMAINS; i++)
+		xa_init(&md->__domains[i].store);
+
 	mutex_init(&md->mutex);
 	dev->msi.data = md;
 	devres_add(dev, md);
@@ -236,7 +242,7 @@ EXPORT_SYMBOL_GPL(msi_lock_descs);
  */
 void msi_unlock_descs(struct device *dev)
 {
-	/* Invalidate the index wich was cached by the iterator */
+	/* Invalidate the index which was cached by the iterator */
 	dev->msi.data->__iter_idx = MSI_MAX_INDEX;
 	mutex_unlock(&dev->msi.data->mutex);
 }
@@ -244,9 +250,10 @@ EXPORT_SYMBOL_GPL(msi_unlock_descs);
 
 static struct msi_desc *msi_find_desc(struct msi_device_data *md, enum msi_desc_filter filter)
 {
+	struct xarray *xa = &md->__domains[MSI_DEFAULT_DOMAIN].store;
 	struct msi_desc *desc;
 
-	xa_for_each_start(&md->__store, md->__iter_idx, desc, md->__iter_idx) {
+	xa_for_each_start(xa, md->__iter_idx, desc, md->__iter_idx) {
 		if (msi_desc_match(desc, filter))
 			return desc;
 	}
@@ -320,6 +327,7 @@ unsigned int msi_get_virq(struct device
 {
 	struct msi_desc *desc;
 	unsigned int ret = 0;
+	struct xarray *xa;
 	bool pcimsi;
 
 	if (!dev->msi.data)
@@ -328,7 +336,8 @@ unsigned int msi_get_virq(struct device
 	pcimsi = dev_is_pci(dev) ? to_pci_dev(dev)->msi_enabled : false;
 
 	msi_lock_descs(dev);
-	desc = xa_load(&dev->msi.data->__store, pcimsi ? 0 : index);
+	xa = &dev->msi.data->__domains[MSI_DEFAULT_DOMAIN].store;
+	desc = xa_load(xa, pcimsi ? 0 : index);
 	if (desc && desc->irq) {
 		/*
 		 * PCI-MSI has only one descriptor for multiple interrupts.
@@ -707,6 +716,7 @@ int msi_domain_populate_irqs(struct irq_
 	struct msi_domain_info *info = domain->host_data;
 	struct msi_domain_ops *ops = info->ops;
 	struct msi_desc *desc;
+	struct xarray *xa;
 	int ret, virq;
 
 	msi_lock_descs(dev);
@@ -714,8 +724,10 @@ int msi_domain_populate_irqs(struct irq_
 	if (ret)
 		goto unlock;
 
+	xa = &dev->msi.data->__domains[MSI_DEFAULT_DOMAIN].store;
+
 	for (virq = virq_base; virq < virq_base + nvec; virq++) {
-		desc = xa_load(&dev->msi.data->__store, virq);
+		desc = xa_load(xa, virq);
 		desc->irq = virq;
 
 		ops->set_desc(arg, desc);

