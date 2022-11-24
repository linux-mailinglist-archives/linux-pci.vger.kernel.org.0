Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4CE4638165
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 00:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiKXXYz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 18:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiKXXYi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 18:24:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AE38A158;
        Thu, 24 Nov 2022 15:24:26 -0800 (PST)
Message-ID: <20221124230313.985498981@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669332264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=H4LgR27rxWvowkqduv+44wQH1yKk935seCxATvwOx3U=;
        b=Zpb6D8GiMXq+Hbac5EKd7HZxAaZ1f16BYQtjxy+TNJ041MURdG3QxWOhCE1e4HVsyIZKzF
        gmcTxUpcgEQCSzWYVri/vpDfsZDbs2j11eERMVVdRPMig1geQTtUiXmbY8GMYm4Qh8JI76
        xKu28jHNkF8fWTc9xOeMFfoxLZByiOvuBFFsM7VmKtz+b5efE7dS3Feny1do38AQzXY0U1
        HL3KxpHDJZkKlgZXa4l+t33xdNR14muOGdaNkoQ9jWFtZiVe2lxN9Xxj4yu2cmSNfn3ilH
        6uPMzEiqmiR+Ww1tCh7Dv3xknjM0r57XjoIrjxR7RmKtlnVOlwe9XD9S8/bNfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669332264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=H4LgR27rxWvowkqduv+44wQH1yKk935seCxATvwOx3U=;
        b=UHT4mxiDh70tN1igdVL2dT88X6PGfKDYxSHMCHNQIqOwNb9rUpyd5t1ALKspooR41O108O
        1Z8dS9iROL7TgyCQ==
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
Subject: [patch V3 10/22] genirq/msi: Make MSI descriptor iterators device
 domain aware
References: <20221124225331.464480443@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 25 Nov 2022 00:24:24 +0100 (CET)
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
V3: Adopt to the domain/xarray storage change
---
 include/linux/msi.h |   48 ++++++++++++++++++++++++++++++++++++++++++------
 kernel/irq/msi.c    |   35 +++++++++++++++++++++++------------
 2 files changed, 65 insertions(+), 18 deletions(-)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -206,11 +206,48 @@ int msi_setup_device_data(struct device
 void msi_lock_descs(struct device *dev);
 void msi_unlock_descs(struct device *dev);
 
-struct msi_desc *msi_first_desc(struct device *dev, enum msi_desc_filter filter);
-struct msi_desc *msi_next_desc(struct device *dev, enum msi_desc_filter filter);
+struct msi_desc *msi_domain_first_desc(struct device *dev, unsigned int domid,
+				       enum msi_desc_filter filter);
 
 /**
- * msi_for_each_desc - Iterate the MSI descriptors
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
+struct msi_desc *msi_next_desc(struct device *dev, unsigned int domid,
+			       enum msi_desc_filter filter);
+
+/**
+ * msi_domain_for_each_desc - Iterate the MSI descriptors in a specific domain
+ *
+ * @desc:	struct msi_desc pointer used as iterator
+ * @dev:	struct device pointer - device to iterate
+ * @domid:	The id of the interrupt domain which should be walked.
+ * @filter:	Filter for descriptor selection
+ *
+ * Notes:
+ *  - The loop must be protected with a msi_lock_descs()/msi_unlock_descs()
+ *    pair.
+ *  - It is safe to remove a retrieved MSI descriptor in the loop.
+ */
+#define msi_domain_for_each_desc(desc, dev, domid, filter)			\
+	for ((desc) = msi_domain_first_desc((dev), (domid), (filter)); (desc);	\
+	     (desc) = msi_next_desc((dev), (domid), (filter)))
+
+/**
+ * msi_for_each_desc - Iterate the MSI descriptors in the default irqdomain
  *
  * @desc:	struct msi_desc pointer used as iterator
  * @dev:	struct device pointer - device to iterate
@@ -221,9 +258,8 @@ struct msi_desc *msi_next_desc(struct de
  *    pair.
  *  - It is safe to remove a retrieved MSI descriptor in the loop.
  */
-#define msi_for_each_desc(desc, dev, filter)			\
-	for ((desc) = msi_first_desc((dev), (filter)); (desc);	\
-	     (desc) = msi_next_desc((dev), (filter)))
+#define msi_for_each_desc(desc, dev, filter)					\
+	msi_domain_for_each_desc((desc), (dev), MSI_DEFAULT_DOMAIN, (filter))
 
 #define msi_desc_to_dev(desc)		((desc)->dev)
 
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -19,8 +19,14 @@
 
 #include "internals.h"
 
+/* Invalid Xarray index which is outside of any searchable range */
+#define MSI_XA_MAX_INDEX	(ULONG_MAX - 1)
+/* The maximum domain size */
+#define MSI_XA_DOMAIN_SIZE	(MSI_MAX_INDEX + 1)
+
 static inline int msi_sysfs_create_group(struct device *dev);
 
+
 /**
  * msi_alloc_desc - Allocate an initialized msi_desc
  * @dev:	Pointer to the device for which this is allocated
@@ -252,27 +258,29 @@ EXPORT_SYMBOL_GPL(msi_lock_descs);
 void msi_unlock_descs(struct device *dev)
 {
 	/* Invalidate the index which was cached by the iterator */
-	dev->msi.data->__iter_idx = MSI_MAX_INDEX;
+	dev->msi.data->__iter_idx = MSI_XA_MAX_INDEX;
 	mutex_unlock(&dev->msi.data->mutex);
 }
 EXPORT_SYMBOL_GPL(msi_unlock_descs);
 
-static struct msi_desc *msi_find_desc(struct msi_device_data *md, enum msi_desc_filter filter)
+static struct msi_desc *msi_find_desc(struct msi_device_data *md, unsigned int domid,
+				      enum msi_desc_filter filter)
 {
-	struct xarray *xa = &md->__domains[MSI_DEFAULT_DOMAIN].store;
+	struct xarray *xa = &md->__domains[domid].store;
 	struct msi_desc *desc;
 
 	xa_for_each_start(xa, md->__iter_idx, desc, md->__iter_idx) {
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
@@ -281,23 +289,25 @@ static struct msi_desc *msi_find_desc(st
  * Return: Pointer to the first MSI descriptor matching the search
  *	   criteria, NULL if none found.
  */
-struct msi_desc *msi_first_desc(struct device *dev, enum msi_desc_filter filter)
+struct msi_desc *msi_domain_first_desc(struct device *dev, unsigned int domid,
+				       enum msi_desc_filter filter)
 {
 	struct msi_device_data *md = dev->msi.data;
 
-	if (WARN_ON_ONCE(!md))
+	if (WARN_ON_ONCE(!md || domid >= MSI_MAX_DEVICE_IRQDOMAINS))
 		return NULL;
 
 	lockdep_assert_held(&md->mutex);
 
 	md->__iter_idx = 0;
-	return msi_find_desc(md, filter);
+	return msi_find_desc(md, domid, filter);
 }
-EXPORT_SYMBOL_GPL(msi_first_desc);
+EXPORT_SYMBOL_GPL(msi_domain_first_desc);
 
 /**
  * msi_next_desc - Get the next MSI descriptor of a device
  * @dev:	Device to operate on
+ * @domid:	The id of the interrupt domain which should be walked.
  * @filter:	Descriptor state filter
  *
  * The first invocation of msi_next_desc() has to be preceeded by a
@@ -308,11 +318,12 @@ EXPORT_SYMBOL_GPL(msi_first_desc);
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
@@ -321,7 +332,7 @@ struct msi_desc *msi_next_desc(struct de
 		return NULL;
 
 	md->__iter_idx++;
-	return msi_find_desc(md, filter);
+	return msi_find_desc(md, domid, filter);
 }
 EXPORT_SYMBOL_GPL(msi_next_desc);
 

