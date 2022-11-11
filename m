Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1783625C46
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 15:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbiKKODG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 09:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbiKKOB1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 09:01:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E483456EFD;
        Fri, 11 Nov 2022 05:57:02 -0800 (PST)
Message-ID: <20221111132706.782035109@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668175018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=OEm4xrpV1/zN+pLVIqTY/U3g2kts6NtvCQ7+3pqs27w=;
        b=SScVgFEb6wG2lTtqGM0ZFdaTJrHV7Ww/Su+jFjx+DFChy8814YcApoHs2dEJyvkVCaamaI
        vcn1GruBS5Q2kFXS1c3HxKXa/AAeSqdsEZYqniJvRjvk/xzn+YzuJj+mNjR1UrOo3cY5vJ
        llDRCq5HFYytDyxBjS8PFqvPg0dJkYhqquiAHauJjz9o9HNDs78IUG/PXbTxg04e/25jED
        5BRS0J5t92lNoBB08yXVa7OWAem5tl3i773wfDnELWYLKXw/XSwEqDwYDzOQbUqe1fnKnL
        hXkxEo4ZesJrPDl+pOTE5yKwC0yVcAuZ8dGAX9KpmsUPUhme309DNtYLdRCOAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668175018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=OEm4xrpV1/zN+pLVIqTY/U3g2kts6NtvCQ7+3pqs27w=;
        b=+rqfyeRDjpbi1FcT4xPx1AMLcUAMy0x2ZTyXUj7Ncx2mhlOXKOT/CciiL89olxLaMIZfbR
        6PQ1Jw4nETR3MkBw==
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
Subject: [patch 13/20] genirq/msi: Make msi_add_simple_msi_descs() device domain aware
References: <20221111131813.914374272@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:56:58 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Allocating simple interrupt descriptors in the core code has to be multi
device aware for the upcoming PCI/IMS support.

Change the interfaces to take a domain id into account. Use the internal
control struct for transport of arguments.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/msi.c |   99 +++++++++++++++++++++++++++++++------------------------
 1 file changed, 57 insertions(+), 42 deletions(-)

--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -154,39 +154,6 @@ int msi_domain_insert_msi_desc(struct de
 	return msi_insert_desc(dev, desc, domid, init_desc->msi_index);
 }
 
-/**
- * msi_add_simple_msi_descs - Allocate and initialize MSI descriptors
- * @dev:	Pointer to the device for which the descriptors are allocated
- * @index:	Index for the first MSI descriptor
- * @ndesc:	Number of descriptors to allocate
- *
- * Return: 0 on success or an appropriate failure code.
- */
-static int msi_add_simple_msi_descs(struct device *dev, unsigned int index, unsigned int ndesc)
-{
-	unsigned int idx, last = index + ndesc - 1;
-	struct msi_desc *desc;
-	int ret;
-
-	lockdep_assert_held(&dev->msi.data->mutex);
-
-	for (idx = index; idx <= last; idx++) {
-		desc = msi_alloc_desc(dev, 1, NULL);
-		if (!desc)
-			goto fail_mem;
-		ret = msi_insert_desc(dev, desc, MSI_DEFAULT_DOMAIN, idx);
-		if (ret)
-			goto fail;
-	}
-	return 0;
-
-fail_mem:
-	ret = -ENOMEM;
-fail:
-	msi_free_msi_descs_range(dev, index, last);
-	return ret;
-}
-
 static bool msi_desc_match(struct msi_desc *desc, enum msi_desc_filter filter)
 {
 	switch (filter) {
@@ -255,6 +222,45 @@ void msi_domain_free_msi_descs_range(str
 	msi_domain_free_descs(dev, &ctrl);
 }
 
+/**
+ * msi_domain_add_simple_msi_descs - Allocate and initialize MSI descriptors
+ * @dev:	Pointer to the device for which the descriptors are allocated
+ * @ctrl:	Allocation control struct
+ *
+ * Return: 0 on success or an appropriate failure code.
+ */
+static int msi_domain_add_simple_msi_descs(struct device *dev, struct msi_ctrl *ctrl)
+{
+	struct msi_desc *desc;
+	unsigned int idx;
+	int ret, baseidx;
+
+	lockdep_assert_held(&dev->msi.data->mutex);
+
+	if (!msi_ctrl_valid(dev, ctrl))
+		return -EINVAL;
+
+	baseidx = msi_get_domain_base_index(dev, ctrl->domid);
+	if (baseidx < 0)
+		return baseidx;
+
+	for (idx = ctrl->first; idx <= ctrl->last; idx++) {
+		desc = msi_alloc_desc(dev, 1, NULL);
+		if (!desc)
+			goto fail_mem;
+		ret = msi_insert_desc(dev, desc, ctrl->domid, idx);
+		if (ret)
+			goto fail;
+	}
+	return 0;
+
+fail_mem:
+	ret = -ENOMEM;
+fail:
+	msi_domain_free_descs(dev, ctrl);
+	return ret;
+}
+
 void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 {
 	*msg = entry->msg;
@@ -821,15 +827,19 @@ int msi_domain_populate_irqs(struct irq_
 {
 	struct msi_domain_info *info = domain->host_data;
 	struct msi_domain_ops *ops = info->ops;
+	struct msi_ctrl ctrl = {
+		.domid	= MSI_DEFAULT_DOMAIN,
+		.first  = virq_base,
+		.last	= virq_base + nvec - 1,
+	};
 	struct msi_desc *desc;
 	int ret, virq;
 
-	if (WARN_ON_ONCE(virq_base >= MSI_MAX_INDEX ||
-			 (virq_base + nvec) >= MSI_MAX_INDEX))
+	if (!msi_ctrl_valid(dev, &ctrl))
 		return 0;
 
 	msi_lock_descs(dev);
-	ret = msi_add_simple_msi_descs(dev, virq_base, nvec);
+	ret = msi_domain_add_simple_msi_descs(dev, &ctrl);
 	if (ret)
 		goto unlock;
 
@@ -850,7 +860,7 @@ int msi_domain_populate_irqs(struct irq_
 fail:
 	for (--virq; virq >= virq_base; virq--)
 		irq_domain_free_irqs_common(domain, virq, 1);
-	msi_free_msi_descs_range(dev, virq_base, virq_base + nvec - 1);
+	msi_domain_free_descs(dev, &ctrl);
 unlock:
 	msi_unlock_descs(dev);
 	return ret;
@@ -1024,14 +1034,19 @@ static int __msi_domain_alloc_irqs(struc
 	return 0;
 }
 
-static int msi_domain_add_simple_msi_descs(struct msi_domain_info *info,
-					   struct device *dev,
-					   unsigned int num_descs)
+static int msi_domain_alloc_simple_msi_descs(struct device *dev,
+					     struct msi_domain_info *info,
+					     unsigned int num_descs)
 {
+	struct msi_ctrl ctrl = {
+		.domid	= MSI_DEFAULT_DOMAIN,
+		.last	= num_descs - 1,
+	};
+
 	if (!(info->flags & MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS))
 		return 0;
 
-	return msi_add_simple_msi_descs(dev, 0, num_descs);
+	return msi_domain_add_simple_msi_descs(dev, &ctrl);
 }
 
 /**
@@ -1062,7 +1077,7 @@ int msi_domain_alloc_irqs_descs_locked(s
 	}
 
 	/* Frees allocated descriptors in case of failure. */
-	ret = msi_domain_add_simple_msi_descs(info, dev, nvec);
+	ret = msi_domain_alloc_simple_msi_descs(dev, info, nvec);
 	if (ret)
 		return ret;
 

