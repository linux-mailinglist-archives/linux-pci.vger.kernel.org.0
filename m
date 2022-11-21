Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24C563261F
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbiKUOhU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiKUOgp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:36:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167AD73BA7;
        Mon, 21 Nov 2022 06:36:40 -0800 (PST)
Message-ID: <20221121083326.395696242@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=KIVieCT5YrO5ZtFgVkPWDpR/xD55B+v0G1YHqVi8nCg=;
        b=xfJG1y2I8oEJ4WqfO+qW9vGRmn0Xq9fdfaJMfTzfRQ9bIIDFwaFnFQMJ5TVnq+puLo4hlK
        XxwgUiyofGNLy9c3tUPlpb+efh6Mqz0BoM0p7NFs/FO/YP0YVCRn8v5OWO/tj2WlrDBkH4
        RTAWKf7qz6DKhANvc8FJFnKlbcNv3vkXWaz0sjDGOcJSrurY2hhMlBymXmGz7w8LfMaxVS
        0WMqT06BOgUwgzPd6eLfJN5are53wTiinvRJhsYDzwnyUkDNJfHn/aKSJaurwdqNHNcB5u
        UxR1Oi7cNj290CeBnW3Akv9Z1rqm0mug/Zgjyv/OTG/ysrio0rBUB7yPFQ0nHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=KIVieCT5YrO5ZtFgVkPWDpR/xD55B+v0G1YHqVi8nCg=;
        b=HqeOGsiPjcvholJQ3lRCiEvZpOrwG9jZqWJ0tZD9IHYZ0Wk8xe6WIl32619xdRagN46144
        NbTXzblp9aFY6PBQ==
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
Subject: [patch V2 16/21] genirq/msi: Provide new domain id allocation functions
References: <20221121083210.309161925@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:36:38 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Provide two sorts of interfaces to handle the different use cases:

  - msi_domain_alloc_irqs_range():

	Handles a caller defined precise range

  - msi_domain_alloc_irqs_all():

	Allocates all interrupts associated to a domain by scanning the
    	allocated MSI descriptors

The latter is useful for the existing PCI/MSI support which does not have
range information available.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h |   18 ++---
 kernel/irq/msi.c    |  179 ++++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 149 insertions(+), 48 deletions(-)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -375,8 +375,8 @@ struct msi_domain_info;
  * @get_hwirq, @msi_init and @msi_free are callbacks used by the underlying
  * irqdomain.
  *
- * @msi_check, @msi_prepare and @set_desc are callbacks used by
- * msi_domain_alloc/free_irqs().
+ * @msi_check, @msi_prepare and @set_desc are callbacks used by the
+ * msi_domain_alloc/free_irqs*() variants.
  *
  * @domain_alloc_irqs, @domain_free_irqs can be used to override the
  * default allocation/free functions (__msi_domain_alloc/free_irqs). This
@@ -384,11 +384,6 @@ struct msi_domain_info;
  * be wrapped into the regular irq domains concepts by mere mortals.  This
  * allows to universally use msi_domain_alloc/free_irqs without having to
  * special case XEN all over the place.
- *
- * Contrary to other operations @domain_alloc_irqs and @domain_free_irqs
- * are set to the default implementation if NULL and even when
- * MSI_FLAG_USE_DEF_DOM_OPS is not set to avoid breaking existing users and
- * because these callbacks are obviously mandatory.
  */
 struct msi_domain_ops {
 	irq_hw_number_t	(*get_hwirq)(struct msi_domain_info *info,
@@ -488,14 +483,21 @@ int msi_domain_alloc_irqs_descs_locked(s
 				       int nvec);
 int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 			  int nvec);
+
 void msi_domain_free_irqs_descs_locked(struct irq_domain *domain, struct device *dev);
 void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev);
 
+int msi_domain_alloc_irqs_range_locked(struct device *dev, unsigned int domid,
+				       unsigned int first, unsigned int last);
+int msi_domain_alloc_irqs_range(struct device *dev, unsigned int domid,
+				unsigned int first, unsigned int last);
+int msi_domain_alloc_irqs_all_locked(struct device *dev, unsigned int domid, int nirqs);
+
+
 void msi_domain_free_irqs_range_locked(struct device *dev, unsigned int domid,
 				       unsigned int first, unsigned int last);
 void msi_domain_free_irqs_range(struct device *dev, unsigned int domid,
 				unsigned int first, unsigned int last);
-
 void msi_domain_free_irqs_all_locked(struct device *dev, unsigned int domid);
 void msi_domain_free_irqs_all(struct device *dev, unsigned int domid);
 
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -24,13 +24,17 @@
  * @domid:	ID of the domain on which management operations should be done
  * @first:	First (hardware) slot index to operate on
  * @last:	Last (hardware) slot index to operate on
+ * @nirqs:	The number of Linux interrupts to allocate. Can be larger
+ *		than the range due to PCI/multi-MSI.
  */
 struct msi_ctrl {
 	unsigned int			domid;
 	unsigned int			first;
 	unsigned int			last;
+	unsigned int			nirqs;
 };
 
+static void msi_domain_free_locked(struct device *dev, struct msi_ctrl *ctrl);
 static inline int msi_sysfs_create_group(struct device *dev);
 
 /* Invalid XA index which is outside of any searchable range */
@@ -582,8 +586,6 @@ static inline int msi_sysfs_populate_des
 static inline void msi_sysfs_remove_desc(struct device *dev, struct msi_desc *desc) { }
 #endif /* !CONFIG_SYSFS */
 
-static int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev, int nvec);
-
 static struct irq_domain *msi_get_device_domain(struct device *dev, unsigned int domid)
 {
 	struct irq_domain *domain;
@@ -761,7 +763,6 @@ static struct msi_domain_ops msi_domain_
 	.msi_init		= msi_domain_ops_init,
 	.msi_prepare		= msi_domain_ops_prepare,
 	.set_desc		= msi_domain_ops_set_desc,
-	.domain_alloc_irqs	= __msi_domain_alloc_irqs,
 };
 
 static void msi_domain_update_dom_ops(struct msi_domain_info *info)
@@ -773,9 +774,6 @@ static void msi_domain_update_dom_ops(st
 		return;
 	}
 
-	if (ops->domain_alloc_irqs == NULL)
-		ops->domain_alloc_irqs = msi_domain_ops_default.domain_alloc_irqs;
-
 	if (!(info->flags & MSI_FLAG_USE_DEF_DOM_OPS))
 		return;
 
@@ -986,18 +984,19 @@ static int msi_init_virq(struct irq_doma
 	return 0;
 }
 
-static int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
-				   int nvec)
+static int __msi_domain_alloc_irqs(struct device *dev, struct irq_domain *domain,
+				   struct msi_ctrl *ctrl)
 {
 	struct msi_domain_info *info = domain->host_data;
+	struct xarray *xa = &dev->msi.data->__store;
 	struct msi_domain_ops *ops = info->ops;
+	unsigned int vflags = 0, allocated = 0;
 	msi_alloc_info_t arg = { };
-	unsigned int vflags = 0;
+	int i, ret, virq, base;
 	struct msi_desc *desc;
-	int allocated = 0;
-	int i, ret, virq;
+	unsigned long idx;
 
-	ret = msi_domain_prepare_irqs(domain, dev, nvec, &arg);
+	ret = msi_domain_prepare_irqs(domain, dev, ctrl->nirqs, &arg);
 	if (ret)
 		return ret;
 
@@ -1023,7 +1022,16 @@ static int __msi_domain_alloc_irqs(struc
 			vflags |= VIRQ_NOMASK_QUIRK;
 	}
 
-	msi_for_each_desc(desc, dev, MSI_DESC_NOTASSOCIATED) {
+	base = ctrl->domid * MSI_XA_DOMAIN_SIZE;
+
+	xa_for_each_range(xa, idx, desc, ctrl->first + base, ctrl->last + base) {
+		if (!msi_desc_match(desc, MSI_DESC_NOTASSOCIATED))
+			continue;
+
+		/* This should return -ECONFUSED... */
+		if (WARN_ON_ONCE(allocated >= ctrl->nirqs))
+			return -EINVAL;
+
 		ops->set_desc(&arg, desc);
 
 		virq = __irq_domain_alloc_irqs(domain, -1, desc->nvec_used,
@@ -1051,17 +1059,122 @@ static int __msi_domain_alloc_irqs(struc
 
 static int msi_domain_alloc_simple_msi_descs(struct device *dev,
 					     struct msi_domain_info *info,
-					     unsigned int num_descs)
+					     struct msi_ctrl *ctrl)
+{
+	if (!(info->flags & MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS))
+		return 0;
+
+	return msi_domain_add_simple_msi_descs(dev, ctrl);
+}
+
+static int __msi_domain_alloc_locked(struct device *dev, struct msi_ctrl *ctrl)
+{
+	struct msi_domain_info *info;
+	struct msi_domain_ops *ops;
+	struct irq_domain *domain;
+	int ret;
+
+	if (!msi_ctrl_range_valid(dev, ctrl))
+		return -EINVAL;
+
+	domain = msi_get_device_domain(dev, ctrl->domid);
+	if (!domain)
+		return -ENODEV;
+
+	info = domain->host_data;
+
+	ret = msi_domain_alloc_simple_msi_descs(dev, info, ctrl);
+	if (ret)
+		return ret;
+
+	ops = info->ops;
+	if (ops->domain_alloc_irqs)
+		return ops->domain_alloc_irqs(domain, dev, ctrl->nirqs);
+
+	return __msi_domain_alloc_irqs(dev, domain, ctrl);
+}
+
+static int msi_domain_alloc_locked(struct device *dev, struct msi_ctrl *ctrl)
+{
+	int ret = __msi_domain_alloc_locked(dev, ctrl);
+
+	if (ret)
+		msi_domain_free_locked(dev, ctrl);
+	return ret;
+}
+
+/**
+ * msi_domain_alloc_irqs_range_locked - Allocate interrupts from a MSI interrupt domain
+ * @dev:	Pointer to device struct of the device for which the interrupts
+ *		are allocated
+ * @domid:	Id of the interrupt domain to operate on
+ * @first:	First index to allocate (inclusive)
+ * @last:	Last index to allocate (inclusive)
+ *
+ * Must be invoked from within a msi_lock_descs() / msi_unlock_descs()
+ * pair. Use this for MSI irqdomains which implement their own descriptor
+ * allocation/free.
+ *
+ * Return: %0 on success or an error code.
+ */
+int msi_domain_alloc_irqs_range_locked(struct device *dev, unsigned int domid,
+				       unsigned int first, unsigned int last)
 {
 	struct msi_ctrl ctrl = {
-		.domid	= MSI_DEFAULT_DOMAIN,
-		.last	= num_descs - 1,
+		.domid	= domid,
+		.first	= first,
+		.last	= last,
+		.nirqs	= last + 1 - first,
 	};
 
-	if (!(info->flags & MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS))
-		return 0;
+	return msi_domain_alloc_locked(dev, &ctrl);
+}
+
+/**
+ * msi_domain_alloc_irqs_range - Allocate interrupts from a MSI interrupt domain
+ * @dev:	Pointer to device struct of the device for which the interrupts
+ *		are allocated
+ * @domid:	Id of the interrupt domain to operate on
+ * @first:	First index to allocate (inclusive)
+ * @last:	Last index to allocate (inclusive)
+ *
+ * Return: %0 on success or an error code.
+ */
+int msi_domain_alloc_irqs_range(struct device *dev, unsigned int domid,
+				unsigned int first, unsigned int last)
+{
+	int ret;
 
-	return msi_domain_add_simple_msi_descs(dev, &ctrl);
+	msi_lock_descs(dev);
+	ret = msi_domain_alloc_irqs_range_locked(dev, domid, first, last);
+	msi_unlock_descs(dev);
+	return ret;
+}
+
+/**
+ * msi_domain_alloc_irqs_all_locked - Allocate all interrupts from a MSI interrupt domain
+ *
+ * @dev:	Pointer to device struct of the device for which the interrupts
+ *		are allocated
+ * @domid:	Id of the interrupt domain to operate on
+ * @nirqs:	The number of interrupts to allocate
+ *
+ * This function scans all MSI descriptors of the MSI domain and allocates interrupts
+ * for all unassigned ones. That function is to be used for MSI domain usage where
+ * the descriptor allocation is handled at the call site, e.g. PCI/MSI[X].
+ *
+ * Return: %0 on success or an error code.
+ */
+int msi_domain_alloc_irqs_all_locked(struct device *dev, unsigned int domid, int nirqs)
+{
+	struct msi_ctrl ctrl = {
+		.domid	= domid,
+		.first	= 0,
+		.last	= MSI_MAX_INDEX,
+		.nirqs	= nirqs,
+	};
+
+	return msi_domain_alloc_locked(dev, &ctrl);
 }
 
 /**
@@ -1080,28 +1193,14 @@ static int msi_domain_alloc_simple_msi_d
 int msi_domain_alloc_irqs_descs_locked(struct irq_domain *domain, struct device *dev,
 				       int nvec)
 {
-	struct msi_domain_info *info = domain->host_data;
-	struct msi_domain_ops *ops = info->ops;
-	int ret;
-
-	lockdep_assert_held(&dev->msi.data->mutex);
-
-	if (WARN_ON_ONCE(irq_domain_is_msi_parent(domain))) {
-		ret = -EINVAL;
-		goto free;
-	}
-
-	/* Frees allocated descriptors in case of failure. */
-	ret = msi_domain_alloc_simple_msi_descs(dev, info, nvec);
-	if (ret)
-		goto free;
+	struct msi_ctrl ctrl = {
+		.domid	= MSI_DEFAULT_DOMAIN,
+		.first	= 0,
+		.last	= MSI_MAX_INDEX,
+		.nirqs	= nvec,
+	};
 
-	ret = ops->domain_alloc_irqs(domain, dev, nvec);
-	if (!ret)
-		return 0;
-free:
-	msi_domain_free_irqs_descs_locked(domain, dev);
-	return ret;
+	return msi_domain_alloc_locked(dev, &ctrl);
 }
 
 /**

