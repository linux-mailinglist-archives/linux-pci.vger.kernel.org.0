Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E1D625C93
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 15:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbiKKOIu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 09:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234717AbiKKOH2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 09:07:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689EB8D7DF;
        Fri, 11 Nov 2022 06:00:09 -0800 (PST)
Message-ID: <20221111135206.463650635@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668175125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=fxLPSxIR9ZSTFaDUWsnR87RJL6z40jyNrKWhIshWH24=;
        b=gr6TbLeAglJQA4CkKIu8La2LR+j4NvxNLSxGDetxfKPxYNQav72vYnviCrYCDLCAa9Atq5
        1jV4Z+lPfKTkbz/YKiyiLdoovniJ8XpJrfOGpOJXWb68ygvUN3hYt/8IDwpLQBVfmFkfzp
        iCpcWLaMsa1W5cbBivMyZD4Z77BxlB4F5+EqAc8eacAku1E38KI/LjpBCc5DIyEO9vWkAW
        BD+L0znlUIDFS4DD2QNC2aIBPxziZnKVPlidD9PdefTVwuywXjk+a+igZCRDnTEkHbuTTS
        W00hpg+Y9axfBokUSrSmTvGXSofS3/FYJ47CC+LZrIMwJ2A0Mci5BkuVS+So6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668175125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=fxLPSxIR9ZSTFaDUWsnR87RJL6z40jyNrKWhIshWH24=;
        b=ATFUOEfBPF+bLWCFt9RheygXADG6b2cWwhn4hwR4Ev/sGKw76fIcEoGvjTj7FZE+F0Sv9u
        PI37+4wDpNkeCiBQ==
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
Subject: [patch 21/33] genirq/msi: Provide msi_domain_alloc_irq_at()
References: <20221111133158.196269823@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:58:44 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

For supporting post MSI-X enable allocations and for the upcoming PCI/IMS
support a seperate interface is required which allows not only the
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
domain can provide a prepare_desc() operation callback in its
msi_domain_ops to do domain specific post allocation initialization before
the actual Linux interrupt and the associated interrupt descriptor and
hierarchy alloccations are conducted.

The function also takes an optional @cookie argument which is of type union
msi_dev_cookie. This cookie is not used by the core code and is stored in
the allocated msi_desc::data::cookie. The meaning of the cookie is
completely implementation defined. In case of IMS this might be a PASID or
a pointer to a device queue, but for the MSI core it's opaque and not used
in any way.

The function returns a struct msi_map which on success contains the
allocated index number and the Linux interrupt number so the caller can
spare the index to Linux interrupt number lookup.

On failure map::index contains the error code and map::virq is 0.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h     |    4 +
 include/linux/msi_api.h |    7 +++
 kernel/irq/msi.c        |  105 ++++++++++++++++++++++++++++++++++++++++++------
 3 files changed, 105 insertions(+), 11 deletions(-)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -80,6 +80,7 @@ struct pci_dev;
 struct platform_msi_priv_data;
 struct device_attribute;
 struct irq_domain;
+struct irq_affinity_desc;
 
 void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg);
@@ -567,6 +568,9 @@ int msi_domain_alloc_irqs_range(struct d
 				unsigned int first, unsigned int last);
 int msi_domain_alloc_irqs_all_locked(struct device *dev, unsigned int domid, int nirqs);
 
+struct msi_map msi_domain_alloc_irq_at(struct device *dev, unsigned int domid, unsigned int index,
+				       const struct irq_affinity_desc *affdesc,
+				       union msi_dev_cookie *cookie);
 
 void msi_domain_free_irqs_range_locked(struct device *dev, unsigned int domid,
 				       unsigned int first, unsigned int last);
--- a/include/linux/msi_api.h
+++ b/include/linux/msi_api.h
@@ -48,6 +48,13 @@ struct msi_map {
 	int	virq;
 };
 
+/*
+ * Constant to be used for dynamic allocations when the allocation
+ * is any free MSI index (entry in the MSI-X table or a software
+ * managed index.
+ */
+#define MSI_ANY_INDEX		UINT_MAX
+
 unsigned int msi_domain_get_virq(struct device *dev, unsigned int domid, unsigned int index);
 
 /**
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -39,6 +39,7 @@ static inline int msi_sysfs_create_group
 /* Invalid XA index which is outside of any searchable range */
 #define MSI_XA_MAX_INDEX	(ULONG_MAX - 1)
 #define MSI_XA_DOMAIN_SIZE	(MSI_MAX_INDEX + 1)
+#define MSI_ANY_INDEX		UINT_MAX
 
 static inline void msi_setup_default_irqdomain(struct device *dev, struct msi_device_data *md)
 {
@@ -126,18 +127,34 @@ static int msi_insert_desc(struct device
 	}
 
 	hwsize = msi_domain_get_hwsize(dev, domid);
-	if (index >= hwsize) {
-		ret = -ERANGE;
-		goto fail;
-	}
 
-	desc->msi_index = index;
-	index += baseidx;
-	ret = xa_insert(&md->__store, index, desc, GFP_KERNEL);
-	if (ret)
-		goto fail;
-	return 0;
+	if (index == MSI_ANY_INDEX) {
+		struct xa_limit limit;
+		unsigned int index;
+
+		limit.min = baseidx;
+		limit.max = baseidx + hwsize - 1;
 
+		/* Let the xarray allocate a free index within the limits */
+		ret = xa_alloc(&md->__store, &index, desc, limit, GFP_KERNEL);
+		if (ret)
+			goto fail;
+
+		desc->msi_index = index;
+		return 0;
+	} else {
+		if (index >= hwsize) {
+			ret = -ERANGE;
+			goto fail;
+		}
+
+		desc->msi_index = index;
+		index += baseidx;
+		ret = xa_insert(&md->__store, index, desc, GFP_KERNEL);
+		if (ret)
+			goto fail;
+		return 0;
+	}
 fail:
 	msi_free_desc(desc);
 	return ret;
@@ -335,7 +352,7 @@ int msi_setup_device_data(struct device
 
 	msi_setup_default_irqdomain(dev, md);
 
-	xa_init(&md->__store);
+	xa_init_flags(&md->__store, XA_FLAGS_ALLOC);
 	mutex_init(&md->mutex);
 	md->__iter_idx = MSI_XA_MAX_INDEX;
 	dev->msi.data = md;
@@ -1423,6 +1440,72 @@ int msi_domain_alloc_irqs_all_locked(str
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
+ * @cookie:	Optional pointer to a descriptor specific cookie to be stored
+ *		in msi_desc::data. Must be NULL for MSI-X allocations
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
+				       union msi_dev_cookie *cookie)
+{
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
+	if (cookie)
+		desc->data.cookie = *cookie;
+
+	ret = msi_insert_desc(dev, desc, domid, index);
+	if (ret) {
+		map.index = ret;
+		goto unlock;
+	}
+
+	map.index = desc->msi_index;
+	ret = msi_domain_alloc_irqs_range_locked(dev, domid, map.index, map.index);
+	if (ret)
+		map.index = ret;
+	else
+		map.virq = desc->irq;
+unlock:
+	msi_unlock_descs(dev);
+	return map;
+}
+
 static void __msi_domain_free_irqs(struct device *dev, struct irq_domain *domain,
 				   struct msi_ctrl *ctrl)
 {

