Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72ABC625C36
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 15:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbiKKOBx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 09:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbiKKOBM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 09:01:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4463845EE;
        Fri, 11 Nov 2022 05:56:56 -0800 (PST)
Message-ID: <20221111132706.670241974@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668175015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=8VY0WlPNbaPO/N862hvT4P/0JGamuqTySDiEq2psBhM=;
        b=vQ3lgcgffVuzDcIPPmJPQzk3wBklFqvXva0o7ABF8VTKJH3XYL+oJzDyVFO4MIaPqme0ma
        tULBhHr4vHtCDZ2axZMydQUEC8XpXDnGSrZu6uEo9ro/IyiUC6A60K6YQd2QuNMXxsXalD
        Xf5Psro7OoQY/RkfQ/ePBoogH1qL9wUSQGHUhIabIcKmO15NlyXuNRAnPE91I5IFh0Efpi
        I2d9TQgQ5VOXou35y7xfcYR4MLo1OV7GRAyXEyx1TWnWkt8fYOlF5zR73G+Kd9Cug9F11y
        jJ5CJcEOUGkNvn/yYX+XZFbv4kthHrVncKJjYYErAkEdfEBr1I6F52ILfnYs5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668175015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=8VY0WlPNbaPO/N862hvT4P/0JGamuqTySDiEq2psBhM=;
        b=UgjpGjR3YALnEENedrFuTqyZjT9U+KlIu4668jQ4UNC9G62TNloZbk8cxOrd/XzsGE0tjy
        bujACfmPoZ0070Ag==
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
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [patch 11/20] genirq/msi: Make descriptor allocation device domain aware
References: <20221111131813.914374272@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:56:54 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Change the descriptor allocation and insertion functions to take a domain
id to prepare for the upcoming multi MSI domain per device support.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h |   15 ++++++++++++++-
 kernel/irq/msi.c    |   44 +++++++++++++++++++++++++++++++++++---------
 2 files changed, 49 insertions(+), 10 deletions(-)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -274,7 +274,20 @@ static inline void msi_desc_set_iommu_co
 }
 #endif
 
-int msi_insert_msi_desc(struct device *dev, struct msi_desc *init_desc);
+int msi_domain_insert_msi_desc(struct device *dev, unsigned int domid,
+			       struct msi_desc *init_desc);
+/**
+ * msi_insert_msi_desc - Allocate and initialize a MSI descriptor in the default domain
+ * @dev:	Pointer to the device for which the descriptor is allocated
+ * @init_desc:	Pointer to an MSI descriptor to initialize the new descriptor
+ *
+ * Return: 0 on success or an appropriate failure code.
+ */
+static inline int msi_insert_msi_desc(struct device *dev, struct msi_desc *init_desc)
+{
+	return msi_domain_insert_msi_desc(dev, MSI_DEFAULT_DOMAIN, init_desc);
+}
+
 void msi_free_msi_descs_range(struct device *dev, unsigned int first_index, unsigned int last_index);
 
 /**
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -63,7 +63,7 @@ static int msi_get_domain_base_index(str
  * Return: pointer to allocated &msi_desc on success or %NULL on failure
  */
 static struct msi_desc *msi_alloc_desc(struct device *dev, int nvec,
-					const struct irq_affinity_desc *affinity)
+				       const struct irq_affinity_desc *affinity)
 {
 	struct msi_desc *desc = kzalloc(sizeof(*desc), GFP_KERNEL);
 
@@ -88,39 +88,58 @@ static void msi_free_desc(struct msi_des
 	kfree(desc);
 }
 
-static int msi_insert_desc(struct msi_device_data *md, struct msi_desc *desc, unsigned int index)
+static int msi_insert_desc(struct device *dev, struct msi_desc *desc,
+			   unsigned int domid, unsigned int index)
 {
-	int ret;
+	struct msi_device_data *md = dev->msi.data;
+	int baseidx, ret;
+
+	baseidx = msi_get_domain_base_index(dev, domid);
+	if (baseidx < 0) {
+		ret = baseidx;
+		goto fail;
+	}
 
 	desc->msi_index = index;
+	index += baseidx;
 	ret = xa_insert(&md->__store, index, desc, GFP_KERNEL);
 	if (ret)
-		msi_free_desc(desc);
+		goto fail;
+	return 0;
+
+fail:
+	msi_free_desc(desc);
 	return ret;
 }
 
 /**
- * msi_insert_msi_desc - Allocate and initialize a MSI descriptor and
- *			 insert it at @init_desc->msi_index
+ * msi_domain_insert_msi_desc - Allocate and initialize a MSI descriptor and
+ *				insert it at @init_desc->msi_index
  *
  * @dev:	Pointer to the device for which the descriptor is allocated
+ * @domid:	The id of the interrupt domain to which the desriptor is added
  * @init_desc:	Pointer to an MSI descriptor to initialize the new descriptor
  *
  * Return: 0 on success or an appropriate failure code.
  */
-int msi_insert_msi_desc(struct device *dev, struct msi_desc *init_desc)
+int msi_domain_insert_msi_desc(struct device *dev, unsigned int domid,
+			       struct msi_desc *init_desc)
 {
 	struct msi_desc *desc;
 
 	lockdep_assert_held(&dev->msi.data->mutex);
 
+	if (WARN_ON_ONCE(init_desc->msi_index >= MSI_MAX_INDEX))
+		return -EINVAL;
+
 	desc = msi_alloc_desc(dev, init_desc->nvec_used, init_desc->affinity);
 	if (!desc)
 		return -ENOMEM;
 
 	/* Copy type specific data to the new descriptor. */
 	desc->pci = init_desc->pci;
-	return msi_insert_desc(dev->msi.data, desc, init_desc->msi_index);
+
+	return msi_insert_desc(dev, desc, domid, init_desc->msi_index);
 }
 
 /**
@@ -143,7 +162,7 @@ static int msi_add_simple_msi_descs(stru
 		desc = msi_alloc_desc(dev, 1, NULL);
 		if (!desc)
 			goto fail_mem;
-		ret = msi_insert_desc(dev->msi.data, desc, idx);
+		ret = msi_insert_desc(dev, desc, MSI_DEFAULT_DOMAIN, idx);
 		if (ret)
 			goto fail;
 	}
@@ -183,6 +202,9 @@ void msi_free_msi_descs_range(struct dev
 	struct msi_desc *desc;
 	unsigned long idx;
 
+	if (WARN_ON_ONCE(first_index >= MSI_MAX_INDEX || last_index >= MSI_MAX_INDEX))
+		return;
+
 	lockdep_assert_held(&dev->msi.data->mutex);
 
 	xa_for_each_range(xa, idx, desc, first_index, last_index) {
@@ -779,6 +801,10 @@ int msi_domain_populate_irqs(struct irq_
 	struct msi_desc *desc;
 	int ret, virq;
 
+	if (WARN_ON_ONCE(virq_base >= MSI_MAX_INDEX ||
+			 (virq_base + nvec) >= MSI_MAX_INDEX))
+		return 0;
+
 	msi_lock_descs(dev);
 	ret = msi_add_simple_msi_descs(dev, virq_base, nvec);
 	if (ret)

