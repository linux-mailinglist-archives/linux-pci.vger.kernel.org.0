Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79FC638171
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 00:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiKXXZr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 18:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKXXZW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 18:25:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC1488F85;
        Thu, 24 Nov 2022 15:24:45 -0800 (PST)
Message-ID: <20221124230314.337844751@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669332274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=67OGZC8axSEDPn2rlV5x6izoKNtu7urmnWWgBzBXHVc=;
        b=DbBZYL0Q0GQ+tQgfRWgE/vjOIeZWl9niVNp3SznXG4/5+n6HOnetAqvyb2R9hIb/bR8gDf
        4GDeCXVxHQUJV0RXqaF8nR4C50dhqumvwMywPmFj4o/Qh3l9a06g+EOs/GYUZcYO5hEWai
        z+L82XKWJe60KuaYviK56pK3FcacSd7HO67YK3YDOTJd23TL3YbJIIGqyL/PL1C+pT77LT
        FTl8xOIPrAEiMCwvBsHuYF/r2xsoH4F9e4F94UC1XsnZy7+GJuh4foek9eLXlKRliuJFdC
        fNkpLuYSWQGsY8rteJVOiwNaJSZ4n9PXkovpopQi0TAPS9n3NWWHqethJXwyaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669332274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=67OGZC8axSEDPn2rlV5x6izoKNtu7urmnWWgBzBXHVc=;
        b=DIOzksTq6+h/1dGe9UyuYXA2mhb7m7wEhz9KXefxrvg8xqLQtcLwNP9lTUZPCen3K2Uop9
        rqQw099kgFGoClBA==
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
Subject: [patch V3 16/22] genirq/msi: Provide new domain id based interfaces
 for freeing interrupts
References: <20221124225331.464480443@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 25 Nov 2022 00:24:33 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Provide two sorts of interfaces to handle the different use cases:

  - msi_domain_free_irqs_range():

	Handles a caller defined precise range

  - msi_domain_free_irqs_all():

	Frees all interrupts associated to a domain

The latter is useful for device teardown and to handle the legacy MSI support
which does not have any range information available.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: Adopt to the domain/xarray storage change
---
 include/linux/msi.h |    9 +++
 kernel/irq/msi.c    |  142 +++++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 129 insertions(+), 22 deletions(-)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -498,6 +498,15 @@ int msi_domain_alloc_irqs(struct irq_dom
 			  int nvec);
 void msi_domain_free_irqs_descs_locked(struct irq_domain *domain, struct device *dev);
 void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev);
+
+void msi_domain_free_irqs_range_locked(struct device *dev, unsigned int domid,
+				       unsigned int first, unsigned int last);
+void msi_domain_free_irqs_range(struct device *dev, unsigned int domid,
+				unsigned int first, unsigned int last);
+
+void msi_domain_free_irqs_all_locked(struct device *dev, unsigned int domid);
+void msi_domain_free_irqs_all(struct device *dev, unsigned int domid);
+
 struct msi_domain_info *msi_get_domain_info(struct irq_domain *domain);
 
 struct irq_domain *platform_msi_create_irq_domain(struct fwnode_handle *fwnode,
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -546,7 +546,25 @@ static inline void msi_sysfs_remove_desc
 #endif /* !CONFIG_SYSFS */
 
 static int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev, int nvec);
-static void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev);
+
+static struct irq_domain *msi_get_device_domain(struct device *dev, unsigned int domid)
+{
+	struct irq_domain *domain;
+
+	lockdep_assert_held(&dev->msi.data->mutex);
+
+	if (WARN_ON_ONCE(domid >= MSI_MAX_DEVICE_IRQDOMAINS))
+		return NULL;
+
+	domain = dev->msi.data->__domains[domid].domain;
+	if (!domain)
+		return NULL;
+
+	if (WARN_ON_ONCE(irq_domain_is_msi_parent(domain)))
+		return NULL;
+
+	return domain;
+}
 
 static inline void irq_chip_write_msi_msg(struct irq_data *data,
 					  struct msi_msg *msg)
@@ -707,7 +725,6 @@ static struct msi_domain_ops msi_domain_
 	.msi_prepare		= msi_domain_ops_prepare,
 	.set_desc		= msi_domain_ops_set_desc,
 	.domain_alloc_irqs	= __msi_domain_alloc_irqs,
-	.domain_free_irqs	= __msi_domain_free_irqs,
 };
 
 static void msi_domain_update_dom_ops(struct msi_domain_info *info)
@@ -721,8 +738,6 @@ static void msi_domain_update_dom_ops(st
 
 	if (ops->domain_alloc_irqs == NULL)
 		ops->domain_alloc_irqs = msi_domain_ops_default.domain_alloc_irqs;
-	if (ops->domain_free_irqs == NULL)
-		ops->domain_free_irqs = msi_domain_ops_default.domain_free_irqs;
 
 	if (!(info->flags & MSI_FLAG_USE_DEF_DOM_OPS))
 		return;
@@ -1074,15 +1089,21 @@ int msi_domain_alloc_irqs(struct irq_dom
 	return ret;
 }
 
-static void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
+static void __msi_domain_free_irqs(struct device *dev, struct irq_domain *domain,
+				   struct msi_ctrl *ctrl)
 {
+	struct xarray *xa = &dev->msi.data->__domains[ctrl->domid].store;
 	struct msi_domain_info *info = domain->host_data;
 	struct irq_data *irqd;
 	struct msi_desc *desc;
+	unsigned long idx;
 	int i;
 
-	/* Only handle MSI entries which have an interrupt associated */
-	msi_for_each_desc(desc, dev, MSI_DESC_ASSOCIATED) {
+	xa_for_each_range(xa, idx, desc, ctrl->first, ctrl->last) {
+		/* Only handle MSI entries which have an interrupt associated */
+		if (!msi_desc_match(desc, MSI_DESC_ASSOCIATED))
+			continue;
+
 		/* Make sure all interrupts are deactivated */
 		for (i = 0; i < desc->nvec_used; i++) {
 			irqd = irq_domain_get_irq_data(domain, desc->irq + i);
@@ -1097,11 +1118,99 @@ static void __msi_domain_free_irqs(struc
 	}
 }
 
-static void msi_domain_free_msi_descs(struct msi_domain_info *info,
-				      struct device *dev)
+static void msi_domain_free_locked(struct device *dev, struct msi_ctrl *ctrl)
 {
+	struct msi_domain_info *info;
+	struct msi_domain_ops *ops;
+	struct irq_domain *domain;
+
+	if (!msi_ctrl_valid(dev, ctrl))
+		return;
+
+	domain = msi_get_device_domain(dev, ctrl->domid);
+	if (!domain)
+		return;
+
+	info = domain->host_data;
+	ops = info->ops;
+
+	if (ops->domain_free_irqs)
+		ops->domain_free_irqs(domain, dev);
+	else
+		__msi_domain_free_irqs(dev, domain, ctrl);
+
+	if (ops->msi_post_free)
+		ops->msi_post_free(domain, dev);
+
 	if (info->flags & MSI_FLAG_FREE_MSI_DESCS)
-		msi_free_msi_descs(dev);
+		msi_domain_free_descs(dev, ctrl);
+}
+
+/**
+ * msi_domain_free_irqs_range_locked - Free a range of interrupts from a MSI interrupt domain
+ *				       associated to @dev with msi_lock held
+ * @dev:	Pointer to device struct of the device for which the interrupts
+ *		are freed
+ * @domid:	Id of the interrupt domain to operate on
+ * @first:	First index to free (inclusive)
+ * @last:	Last index to free (inclusive)
+ */
+void msi_domain_free_irqs_range_locked(struct device *dev, unsigned int domid,
+				       unsigned int first, unsigned int last)
+{
+	struct msi_ctrl ctrl = {
+		.domid	= domid,
+		.first	= first,
+		.last	= last,
+	};
+	msi_domain_free_locked(dev, &ctrl);
+}
+
+/**
+ * msi_domain_free_irqs_range - Free a range of interrupts from a MSI interrupt domain
+ *				associated to @dev
+ * @dev:	Pointer to device struct of the device for which the interrupts
+ *		are freed
+ * @domid:	Id of the interrupt domain to operate on
+ * @first:	First index to free (inclusive)
+ * @last:	Last index to free (inclusive)
+ */
+void msi_domain_free_irqs_range(struct device *dev, unsigned int domid,
+				unsigned int first, unsigned int last)
+{
+	msi_lock_descs(dev);
+	msi_domain_free_irqs_range_locked(dev, domid, first, last);
+	msi_unlock_descs(dev);
+}
+
+/**
+ * msi_domain_free_irqs_all_locked - Free all interrupts from a MSI interrupt domain
+ *				     associated to a device
+ * @dev:	Pointer to device struct of the device for which the interrupts
+ *		are freed
+ * @domid:	The id of the domain to operate on
+ *
+ * Must be invoked from within a msi_lock_descs() / msi_unlock_descs()
+ * pair. Use this for MSI irqdomains which implement their own vector
+ * allocation.
+ */
+void msi_domain_free_irqs_all_locked(struct device *dev, unsigned int domid)
+{
+	msi_domain_free_irqs_range_locked(dev, domid, 0, MSI_MAX_INDEX);
+}
+
+/**
+ * msi_domain_free_irqs_all - Free all interrupts from a MSI interrupt domain
+ *			      associated to a device
+ * @dev:	Pointer to device struct of the device for which the interrupts
+ *		are freed
+ * @domid:	The id of the domain to operate on
+ */
+void msi_domain_free_irqs_all(struct device *dev, unsigned int domid)
+{
+	msi_lock_descs(dev);
+	msi_domain_free_irqs_all_locked(dev, domid);
+	msi_unlock_descs(dev);
 }
 
 /**
@@ -1116,18 +1225,7 @@ static void msi_domain_free_msi_descs(st
  */
 void msi_domain_free_irqs_descs_locked(struct irq_domain *domain, struct device *dev)
 {
-	struct msi_domain_info *info = domain->host_data;
-	struct msi_domain_ops *ops = info->ops;
-
-	lockdep_assert_held(&dev->msi.data->mutex);
-
-	if (WARN_ON_ONCE(irq_domain_is_msi_parent(domain)))
-		return;
-
-	ops->domain_free_irqs(domain, dev);
-	if (ops->msi_post_free)
-		ops->msi_post_free(domain, dev);
-	msi_domain_free_msi_descs(info, dev);
+	msi_domain_free_irqs_range_locked(dev, MSI_DEFAULT_DOMAIN, 0, MSI_MAX_INDEX);
 }
 
 /**

