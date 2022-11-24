Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4ABC6381A4
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 00:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiKXXaC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 18:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiKXX3p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 18:29:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4433F2EF65;
        Thu, 24 Nov 2022 15:27:48 -0800 (PST)
Message-ID: <20221124232326.501359457@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669332379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=M7KPMuDnEi8BJsEuyegZhrT26NKyJhQDz95eZFlqKwE=;
        b=H4Yrw/HRS/LSYqDnKSaurm2WD8le2eeKsY1rI7CVowV6D6Q1tYcT1eD9kX1323Nol/a/US
        bEecWmm6zQzGh5e8ODQ+OvP+nGNONUW7vX3LHMnC9FH+xypyEhrTfgIecTIhJn6mpoVDo4
        xqD8xZ81z3qDGHVZStkNN9Y0+dYoAcItJigzTtNsd654C3LJiCCetEmv25+xlpOMpNYVYv
        e4Edh3ZvIwqSRzIK49BwB1NunHt9pkVqa08PNMhTz4XJbaDPiuMt/0CFJCuDUrKUCesYGA
        C4FLRY8XEnH4q9c+3/l9FrIPF3GplI+PmF0NuZdBXG2cwQv69cbpEO3NoNLvBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669332379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=M7KPMuDnEi8BJsEuyegZhrT26NKyJhQDz95eZFlqKwE=;
        b=gs0PydzL74C8H8Ba8sbSLOnxNIiohpwBOFp2zlATmjYvGgpUhFbeOQyATaFqX0YYoyGcCa
        4kdX7AwS7++4pnBA==
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
Subject: [patch V3 21/33] genirq/msi: Provide msi_domain_alloc_irq_at()
References: <20221124230505.073418677@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 25 Nov 2022 00:26:18 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

For supporting post MSI-X enable allocations and for the upcoming PCI/IMS
support a separate interface is required which allows not only the
allocation of a specific index, but also the allocation of any, i.e. the
next free index. The latter is especially required for IMS because IMS
completely does away with index to functionality mappings which are
often found in MSI/MSI-X implementation.

But even with MSI-X there are devices where only the first few indices have
a fixed functionality and the rest is freely assignable by software,
e.g. to queues.

msi_domain_alloc_irq_at() is also different from the range based interfaces
as it always enforces that the MSI descriptor is allocated by the core code
and not preallocated by the caller like the PCI/MSI[-X] enable code path
does.

msi_domain_alloc_irq_at() can be invoked with the index argument set to
MSI_ANY_INDEX which makes the core code pick the next free index. The irq
domain can provide a prepare_desc() operation callback in it's
msi_domain_ops to do domain specific post allocation initialization before
the actual Linux interrupt and the associated interrupt descriptor and
hierarchy alloccations are conducted.

The function also takes an optional @icookie argument which is of type
union msi_instance_cookie. This cookie is not used by the core code and is
stored in the allocated msi_desc::data::icookie. The meaning of the cookie
is completely implementation defined. In case of IMS this might be a PASID
or a pointer to a device queue, but for the MSI core it's opaque and not
used in any way.

The function returns a struct msi_map which on success contains the
allocated index number and the Linux interrupt number so the caller can
spare the index to Linux interrupt number lookup.

On failure map::index contains the error code and map::virq is 0.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Fix the recursive allocation issue and the index calculation (Reinette)
V3: Fixup stale changelog and typos in comments (Kevin)
    Adopt to the reworked domain/xarray storage model
---
 include/linux/msi.h     |    4 +
 include/linux/msi_api.h |    7 +++
 kernel/irq/msi.c        |  107 +++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 108 insertions(+), 10 deletions(-)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -80,6 +80,7 @@ struct pci_dev;
 struct platform_msi_priv_data;
 struct device_attribute;
 struct irq_domain;
+struct irq_affinity_desc;
 
 void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 #ifdef CONFIG_GENERIC_MSI_IRQ
@@ -602,6 +603,9 @@ int msi_domain_alloc_irqs_range(struct d
 				unsigned int first, unsigned int last);
 int msi_domain_alloc_irqs_all_locked(struct device *dev, unsigned int domid, int nirqs);
 
+struct msi_map msi_domain_alloc_irq_at(struct device *dev, unsigned int domid, unsigned int index,
+				       const struct irq_affinity_desc *affdesc,
+				       union msi_instance_cookie *cookie);
 
 void msi_domain_free_irqs_range_locked(struct device *dev, unsigned int domid,
 				       unsigned int first, unsigned int last);
--- a/include/linux/msi_api.h
+++ b/include/linux/msi_api.h
@@ -48,6 +48,13 @@ struct msi_map {
 	int	virq;
 };
 
+/*
+ * Constant to be used for dynamic allocations when the allocation is any
+ * free MSI index, which is either an entry in a hardware table or a
+ * software managed index.
+ */
+#define MSI_ANY_INDEX		UINT_MAX
+
 unsigned int msi_domain_get_virq(struct device *dev, unsigned int domid, unsigned int index);
 
 /**
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -90,17 +90,30 @@ static int msi_insert_desc(struct device
 	int ret;
 
 	hwsize = msi_domain_get_hwsize(dev, domid);
-	if (index >= hwsize) {
-		ret = -ERANGE;
-		goto fail;
-	}
 
-	desc->msi_index = index;
-	ret = xa_insert(xa, index, desc, GFP_KERNEL);
-	if (ret)
-		goto fail;
-	return 0;
+	if (index == MSI_ANY_INDEX) {
+		struct xa_limit limit = { .min = 0, .max = hwsize - 1 };
+		unsigned int index;
+
+		/* Let the xarray allocate a free index within the limit */
+		ret = xa_alloc(xa, &index, desc, limit, GFP_KERNEL);
+		if (ret)
+			goto fail;
 
+		desc->msi_index = index;
+		return 0;
+	} else {
+		if (index >= hwsize) {
+			ret = -ERANGE;
+			goto fail;
+		}
+
+		desc->msi_index = index;
+		ret = xa_insert(xa, index, desc, GFP_KERNEL);
+		if (ret)
+			goto fail;
+		return 0;
+	}
 fail:
 	msi_free_desc(desc);
 	return ret;
@@ -294,7 +307,7 @@ int msi_setup_device_data(struct device
 	}
 
 	for (i = 0; i < MSI_MAX_DEVICE_IRQDOMAINS; i++)
-		xa_init(&md->__domains[i].store);
+		xa_init_flags(&md->__domains[i].store, XA_FLAGS_ALLOC);
 
 	/*
 	 * If @dev::msi::domain is set and is a global MSI domain, copy the
@@ -1407,6 +1420,80 @@ int msi_domain_alloc_irqs_all_locked(str
 	return msi_domain_alloc_locked(dev, &ctrl);
 }
 
+/**
+ * msi_domain_alloc_irq_at - Allocate an interrupt from a MSI interrupt domain at
+ *			     a given index - or at the next free index
+ *
+ * @dev:	Pointer to device struct of the device for which the interrupts
+ *		are allocated
+ * @domid:	Id of the interrupt domain to operate on
+ * @index:	Index for allocation. If @index == %MSI_ANY_INDEX the allocation
+ *		uses the next free index.
+ * @affdesc:	Optional pointer to an interrupt affinity descriptor structure
+ * @icookie:	Optional pointer to a domain specific per instance cookie. If
+ *		non-NULL the content of the cookie is stored in msi_desc::data.
+ *		Must be NULL for MSI-X allocations
+ *
+ * This requires a MSI interrupt domain which lets the core code manage the
+ * MSI descriptors.
+ *
+ * Return: struct msi_map
+ *
+ *	On success msi_map::index contains the allocated index number and
+ *	msi_map::virq the corresponding Linux interrupt number
+ *
+ *	On failure msi_map::index contains the error code and msi_map::virq
+ *	is %0.
+ */
+struct msi_map msi_domain_alloc_irq_at(struct device *dev, unsigned int domid, unsigned int index,
+				       const struct irq_affinity_desc *affdesc,
+				       union msi_instance_cookie *icookie)
+{
+	struct msi_ctrl ctrl = { .domid	= domid, .nirqs = 1, };
+	struct msi_domain_info *info;
+	struct irq_domain *domain;
+	struct msi_map map = { };
+	struct msi_desc *desc;
+	int ret;
+
+	msi_lock_descs(dev);
+	domain = msi_get_device_domain(dev, domid);
+	if (!domain) {
+		map.index = -ENODEV;
+		goto unlock;
+	}
+
+	desc = msi_alloc_desc(dev, 1, affdesc);
+	if (!desc) {
+		map.index = -ENOMEM;
+		goto unlock;
+	}
+
+	if (icookie)
+		desc->data.icookie = *icookie;
+
+	ret = msi_insert_desc(dev, desc, domid, index);
+	if (ret) {
+		map.index = ret;
+		goto unlock;
+	}
+
+	ctrl.first = ctrl.last = desc->msi_index;
+	info = domain->host_data;
+
+	ret = __msi_domain_alloc_irqs(dev, domain, &ctrl);
+	if (ret) {
+		map.index = ret;
+		msi_domain_free_locked(dev, &ctrl);
+	} else {
+		map.index = desc->msi_index;
+		map.virq = desc->irq;
+	}
+unlock:
+	msi_unlock_descs(dev);
+	return map;
+}
+
 static void __msi_domain_free_irqs(struct device *dev, struct irq_domain *domain,
 				   struct msi_ctrl *ctrl)
 {

