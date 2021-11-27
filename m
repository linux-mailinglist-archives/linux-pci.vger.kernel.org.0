Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7A945FA1E
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 02:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348530AbhK0BaN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 20:30:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37388 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348686AbhK0B2M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 20:28:12 -0500
Message-ID: <20211126230524.416227100@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=gPGwhzABUUuyh4AiGm3N1S2AvFjbvgj2SBJATF8Ta9k=;
        b=tSSAck+iAsZ9+1LdM8d3aysmZvy1m5vkl5bocA/WJxlyTDE4q+mZbsdEjgaXX5iqhc88W+
        Puv97zLINILbFNTz+f1Dmlr8t9QyS8Jv+Svs+IN1qWM+SzCZGiT+NbgXEJvF5+D57dZJL+
        Ce0RUIJetsQnTGAD79MV6+rqz2/pQFc/pV/oAR21jBHOtHvXUXEkk/YvMs7Xy4OfpE3sWX
        pLpi36UJgHbV52etY0rXvw/vEncHi9Dcf/2O+ta7vhEHSwUxSS7L+t63zF0+novG5sm8M2
        ew0u06hdp3kDWMGC9bJr3Zu+aCbi3hk+zXdwXfc8OJD9YJ5s3+IcBNiOkzGHUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=gPGwhzABUUuyh4AiGm3N1S2AvFjbvgj2SBJATF8Ta9k=;
        b=LHolcTKJPPUBYCRATNIMFQS5Abm5k31EBkjw5CWmjmMxgh8Ezqq4hQe/XkG2JIuJpuBfMJ
        xf1CkaZW2XsKDKCw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        iommu@lists.linux-foundation.org, dmaengine@vger.kernel.org,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, Sinan Kaya <okaya@kernel.org>
Subject: [patch 08/37] genirq/msi: Provide msi_device_populate/destroy_sysfs()
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:21:30 +0100 (CET)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add new allocation functions which can be activated by domain info
flags. They store the groups pointer in struct msi_device_data.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h |   12 +++++++++++-
 kernel/irq/msi.c    |   42 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 51 insertions(+), 3 deletions(-)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -174,9 +174,11 @@ struct msi_desc {
 /**
  * msi_device_data - MSI per device data
  * @lock:		Spinlock to protect register access
+ * @attrs:		Pointer to the sysfs attribute group
  */
 struct msi_device_data {
-	raw_spinlock_t		lock;
+	raw_spinlock_t			lock;
+	const struct attribute_group    **attrs;
 };
 
 int msi_setup_device_data(struct device *dev);
@@ -242,10 +244,16 @@ void pci_msi_mask_irq(struct irq_data *d
 void pci_msi_unmask_irq(struct irq_data *data);
 
 #ifdef CONFIG_SYSFS
+int msi_device_populate_sysfs(struct device *dev);
+void msi_device_destroy_sysfs(struct device *dev);
+
 const struct attribute_group **msi_populate_sysfs(struct device *dev);
 void msi_destroy_sysfs(struct device *dev,
 		       const struct attribute_group **msi_irq_groups);
 #else
+static inline int msi_device_populate_sysfs(struct device *dev) { return 0; }
+static inline void msi_device_destroy_sysfs(struct device *dev) { }
+
 static inline const struct attribute_group **msi_populate_sysfs(struct device *dev)
 {
 	return NULL;
@@ -393,6 +401,8 @@ enum {
 	MSI_FLAG_MUST_REACTIVATE	= (1 << 5),
 	/* Is level-triggered capable, using two messages */
 	MSI_FLAG_LEVEL_CAPABLE		= (1 << 6),
+	/* Populate sysfs on alloc() and destroy it on free() */
+	MSI_FLAG_DEV_SYSFS		= (1 << 7),
 };
 
 int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -214,6 +214,20 @@ const struct attribute_group **msi_popul
 }
 
 /**
+ * msi_device_populate_sysfs - Populate msi_irqs sysfs entries for a device
+ * @dev:	The device(PCI, platform etc) which will get sysfs entries
+ */
+int msi_device_populate_sysfs(struct device *dev)
+{
+	const struct attribute_group **group = msi_populate_sysfs(dev);
+
+	if (IS_ERR(group))
+		return PTR_ERR(group);
+	dev->msi.data->attrs = group;
+	return 0;
+}
+
+/**
  * msi_destroy_sysfs - Destroy msi_irqs sysfs entries for devices
  * @dev:		The device(PCI, platform etc) who will remove sysfs entries
  * @msi_irq_groups:	attribute_group for device msi_irqs entries
@@ -239,6 +253,17 @@ void msi_destroy_sysfs(struct device *de
 		kfree(msi_irq_groups);
 	}
 }
+
+/**
+ * msi_device_destroy_sysfs - Destroy msi_irqs sysfs entries for a device
+ * @dev:		The device(PCI, platform etc) for which to remove
+ *			sysfs entries
+ */
+void msi_device_destroy_sysfs(struct device *dev)
+{
+	msi_destroy_sysfs(dev, dev->msi.data->attrs);
+	dev->msi.data->attrs = NULL;
+}
 #endif
 
 #ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
@@ -686,8 +711,19 @@ int msi_domain_alloc_irqs(struct irq_dom
 {
 	struct msi_domain_info *info = domain->host_data;
 	struct msi_domain_ops *ops = info->ops;
+	int ret;
 
-	return ops->domain_alloc_irqs(domain, dev, nvec);
+	ret = ops->domain_alloc_irqs(domain, dev, nvec);
+	if (ret)
+		return ret;
+
+	if (!(info->flags & MSI_FLAG_DEV_SYSFS))
+		return 0;
+
+	ret = msi_device_populate_sysfs(dev);
+	if (ret)
+		msi_domain_free_irqs(domain, dev);
+	return ret;
 }
 
 void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
@@ -726,7 +762,9 @@ void msi_domain_free_irqs(struct irq_dom
 	struct msi_domain_info *info = domain->host_data;
 	struct msi_domain_ops *ops = info->ops;
 
-	return ops->domain_free_irqs(domain, dev);
+	if (info->flags & MSI_FLAG_DEV_SYSFS)
+		msi_device_destroy_sysfs(dev);
+	ops->domain_free_irqs(domain, dev);
 }
 
 /**

