Return-Path: <linux-pci+bounces-8822-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3939089F3
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 12:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BD32287D2F
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 10:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B42A19EEAC;
	Fri, 14 Jun 2024 10:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HCCPGAKA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x453r40/"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5385819E7EA;
	Fri, 14 Jun 2024 10:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718360769; cv=none; b=YGDv0/jORtqeDQ+wVMQLko8baGBMM6RBlWH9Qm21AE8Q28I0fLnpDlFF4A8nk4zIq7oNfSMAlhCQE70LIlARSiDui6sSHBBzC4HisgM5YEIjKp/gpJUj28gg+j69q6JtsgdHtq28PpEy+u/DGb8fsLbB7V/H4B8OYPuUxOTftew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718360769; c=relaxed/simple;
	bh=XJdt7C56F67FJDI6RIEnpTNlex3QZJWIDJfh5nG2n/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lm55YrncTvu7PnSQfWSPZJp8YnDZU9v5byvhiV8O1ijhMWqmEt9akgBDmYr9AKFdY8KaFTubHEdWjsYR2dFPzOsfEFcJlpibr9jnBu+lZA+rjhskEOCh4ESgnOkhzYlW2MKGIs3BSDJOgDQolZKm5SpCQ+GgMX2/0OQqYS9Yj0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HCCPGAKA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x453r40/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718360765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EzuOHftkykYOC4iYQt0jV2CCrrjq+nNdHHFDfeHMQWo=;
	b=HCCPGAKARJdXplxRx8zKmDU2oeZyE+GNlHlDTDOJGhmqlq4EEJzKjzyC3KR7pd68z7i3jH
	va7Edg3qzsz6gi14sZfmyGdVy1uE0xsgXW52ZjpM3Hd30/T50qDJTxkSgLRQTS9Y8ExYDp
	jNe2hquZ6om/eJBakafAkspLHhGEalKQ1sBPF3jao0Pixr0uio5UDvjn+RLvurEqz3rF6h
	8FnBP6Pfj0vR3f6a7bbo74VFfd3ZhcGb1k+htKIx27jcsZg6nu43AJUg/ExSqqBLQOrkOH
	x9UhbSCCNmonJhmL+wKutmqpLlxjzDEyC3tsmjo3RVrJ8/0wcdotwA9YDJ9n7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718360765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EzuOHftkykYOC4iYQt0jV2CCrrjq+nNdHHFDfeHMQWo=;
	b=x453r40/BPcy9qf1H82Zagn8zwUwTFTdvGxvkRJNy/HyoiAbLJOfwpch27x14sgKS3mQfi
	97dUJG/rdrC5uoCA==
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	maz@kernel.org,
	tglx@linutronix.de,
	anna-maria@linutronix.de,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	bhelgaas@google.com,
	rdunlap@infradead.org,
	vidyas@nvidia.com,
	ilpo.jarvinen@linux.intel.com,
	apatel@ventanamicro.com,
	kevin.tian@intel.com,
	nipun.gupta@amd.com,
	den@valinux.co.jp,
	andrew@lunn.ch,
	gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	alex.williamson@redhat.com,
	will@kernel.org,
	lorenzo.pieralisi@arm.com,
	jgg@mellanox.com,
	ammarfaizi2@gnuweeb.org,
	robin.murphy@arm.com,
	lpieralisi@kernel.org,
	nm@ti.com,
	kristo@kernel.org,
	vkoul@kernel.org,
	okaya@kernel.org,
	agross@kernel.org,
	andersson@kernel.org,
	mark.rutland@arm.com,
	shameerali.kolothum.thodi@huawei.com,
	yuzenghui@huawei.com,
	shivamurthy.shastri@linutronix.de
Subject: [PATCH v3 23/24] genirq/msi: Remove platform MSI leftovers
Date: Fri, 14 Jun 2024 12:24:02 +0200
Message-Id: <20240614102403.13610-24-shivamurthy.shastri@linutronix.de>
In-Reply-To: <20240614102403.13610-1-shivamurthy.shastri@linutronix.de>
References: <20240614102403.13610-1-shivamurthy.shastri@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

No more users!

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
---
 drivers/base/platform-msi.c | 350 +-----------------------------------
 include/linux/msi.h         |  30 ----
 kernel/irq/msi.c            |  75 +-------
 3 files changed, 5 insertions(+), 450 deletions(-)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 11f5fdf65b9e..0e60dd650b5e 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -4,346 +4,12 @@
  *
  * Copyright (C) 2015 ARM Limited, All Rights Reserved.
  * Author: Marc Zyngier <marc.zyngier@arm.com>
+ * Copyright (C) 2022 Linutronix GmbH
  */
 
 #include <linux/device.h>
-#include <linux/idr.h>
-#include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
-#include <linux/slab.h>
-
-/* Begin of removal area. Once everything is converted over. Cleanup the includes too! */
-
-#define DEV_ID_SHIFT	21
-#define MAX_DEV_MSIS	(1 << (32 - DEV_ID_SHIFT))
-
-/*
- * Internal data structure containing a (made up, but unique) devid
- * and the callback to write the MSI message.
- */
-struct platform_msi_priv_data {
-	struct device			*dev;
-	void				*host_data;
-	msi_alloc_info_t		arg;
-	irq_write_msi_msg_t		write_msg;
-	int				devid;
-};
-
-/* The devid allocator */
-static DEFINE_IDA(platform_msi_devid_ida);
-
-#ifdef GENERIC_MSI_DOMAIN_OPS
-/*
- * Convert an msi_desc to a globaly unique identifier (per-device
- * devid + msi_desc position in the msi_list).
- */
-static irq_hw_number_t platform_msi_calc_hwirq(struct msi_desc *desc)
-{
-	u32 devid = desc->dev->msi.data->platform_data->devid;
-
-	return (devid << (32 - DEV_ID_SHIFT)) | desc->msi_index;
-}
-
-static void platform_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
-{
-	arg->desc = desc;
-	arg->hwirq = platform_msi_calc_hwirq(desc);
-}
-
-static int platform_msi_init(struct irq_domain *domain,
-			     struct msi_domain_info *info,
-			     unsigned int virq, irq_hw_number_t hwirq,
-			     msi_alloc_info_t *arg)
-{
-	return irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
-					     info->chip, info->chip_data);
-}
-
-static void platform_msi_set_proxy_dev(msi_alloc_info_t *arg)
-{
-	arg->flags |= MSI_ALLOC_FLAGS_PROXY_DEVICE;
-}
-#else
-#define platform_msi_set_desc		NULL
-#define platform_msi_init		NULL
-#define platform_msi_set_proxy_dev(x)	do {} while(0)
-#endif
-
-static void platform_msi_update_dom_ops(struct msi_domain_info *info)
-{
-	struct msi_domain_ops *ops = info->ops;
-
-	BUG_ON(!ops);
-
-	if (ops->msi_init == NULL)
-		ops->msi_init = platform_msi_init;
-	if (ops->set_desc == NULL)
-		ops->set_desc = platform_msi_set_desc;
-}
-
-static void platform_msi_write_msg(struct irq_data *data, struct msi_msg *msg)
-{
-	struct msi_desc *desc = irq_data_get_msi_desc(data);
-
-	desc->dev->msi.data->platform_data->write_msg(desc, msg);
-}
-
-static void platform_msi_update_chip_ops(struct msi_domain_info *info)
-{
-	struct irq_chip *chip = info->chip;
-
-	BUG_ON(!chip);
-	if (!chip->irq_mask)
-		chip->irq_mask = irq_chip_mask_parent;
-	if (!chip->irq_unmask)
-		chip->irq_unmask = irq_chip_unmask_parent;
-	if (!chip->irq_eoi)
-		chip->irq_eoi = irq_chip_eoi_parent;
-	if (!chip->irq_set_affinity)
-		chip->irq_set_affinity = msi_domain_set_affinity;
-	if (!chip->irq_write_msi_msg)
-		chip->irq_write_msi_msg = platform_msi_write_msg;
-	if (WARN_ON((info->flags & MSI_FLAG_LEVEL_CAPABLE) &&
-		    !(chip->flags & IRQCHIP_SUPPORTS_LEVEL_MSI)))
-		info->flags &= ~MSI_FLAG_LEVEL_CAPABLE;
-}
-
-/**
- * platform_msi_create_irq_domain - Create a platform MSI interrupt domain
- * @fwnode:		Optional fwnode of the interrupt controller
- * @info:	MSI domain info
- * @parent:	Parent irq domain
- *
- * Updates the domain and chip ops and creates a platform MSI
- * interrupt domain.
- *
- * Returns:
- * A domain pointer or NULL in case of failure.
- */
-struct irq_domain *platform_msi_create_irq_domain(struct fwnode_handle *fwnode,
-						  struct msi_domain_info *info,
-						  struct irq_domain *parent)
-{
-	struct irq_domain *domain;
-
-	if (info->flags & MSI_FLAG_USE_DEF_DOM_OPS)
-		platform_msi_update_dom_ops(info);
-	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
-		platform_msi_update_chip_ops(info);
-	info->flags |= MSI_FLAG_DEV_SYSFS | MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS |
-		       MSI_FLAG_FREE_MSI_DESCS;
-
-	domain = msi_create_irq_domain(fwnode, info, parent);
-	if (domain)
-		irq_domain_update_bus_token(domain, DOMAIN_BUS_PLATFORM_MSI);
-
-	return domain;
-}
-EXPORT_SYMBOL_GPL(platform_msi_create_irq_domain);
-
-static int platform_msi_alloc_priv_data(struct device *dev, unsigned int nvec,
-					irq_write_msi_msg_t write_msi_msg)
-{
-	struct platform_msi_priv_data *datap;
-	int err;
-
-	/*
-	 * Limit the number of interrupts to 2048 per device. Should we
-	 * need to bump this up, DEV_ID_SHIFT should be adjusted
-	 * accordingly (which would impact the max number of MSI
-	 * capable devices).
-	 */
-	if (!dev->msi.domain || !write_msi_msg || !nvec || nvec > MAX_DEV_MSIS)
-		return -EINVAL;
-
-	if (dev->msi.domain->bus_token != DOMAIN_BUS_PLATFORM_MSI) {
-		dev_err(dev, "Incompatible msi_domain, giving up\n");
-		return -EINVAL;
-	}
-
-	err = msi_setup_device_data(dev);
-	if (err)
-		return err;
-
-	/* Already initialized? */
-	if (dev->msi.data->platform_data)
-		return -EBUSY;
-
-	datap = kzalloc(sizeof(*datap), GFP_KERNEL);
-	if (!datap)
-		return -ENOMEM;
-
-	datap->devid = ida_alloc_max(&platform_msi_devid_ida,
-				     (1 << DEV_ID_SHIFT) - 1, GFP_KERNEL);
-	if (datap->devid < 0) {
-		err = datap->devid;
-		kfree(datap);
-		return err;
-	}
-
-	datap->write_msg = write_msi_msg;
-	datap->dev = dev;
-	dev->msi.data->platform_data = datap;
-	return 0;
-}
-
-static void platform_msi_free_priv_data(struct device *dev)
-{
-	struct platform_msi_priv_data *data = dev->msi.data->platform_data;
-
-	dev->msi.data->platform_data = NULL;
-	ida_free(&platform_msi_devid_ida, data->devid);
-	kfree(data);
-}
-
-/**
- * platform_msi_domain_alloc_irqs - Allocate MSI interrupts for @dev
- * @dev:		The device for which to allocate interrupts
- * @nvec:		The number of interrupts to allocate
- * @write_msi_msg:	Callback to write an interrupt message for @dev
- *
- * Returns:
- * Zero for success, or an error code in case of failure
- */
-static int platform_msi_domain_alloc_irqs(struct device *dev, unsigned int nvec,
-					  irq_write_msi_msg_t write_msi_msg)
-{
-	int err;
-
-	err = platform_msi_alloc_priv_data(dev, nvec, write_msi_msg);
-	if (err)
-		return err;
-
-	err = msi_domain_alloc_irqs_range(dev, MSI_DEFAULT_DOMAIN, 0, nvec - 1);
-	if (err)
-		platform_msi_free_priv_data(dev);
-
-	return err;
-}
-
-/**
- * platform_msi_get_host_data - Query the private data associated with
- *                              a platform-msi domain
- * @domain:	The platform-msi domain
- *
- * Return: The private data provided when calling
- * platform_msi_create_device_domain().
- */
-void *platform_msi_get_host_data(struct irq_domain *domain)
-{
-	struct platform_msi_priv_data *data = domain->host_data;
-
-	return data->host_data;
-}
-
-static struct lock_class_key platform_device_msi_lock_class;
-
-/**
- * __platform_msi_create_device_domain - Create a platform-msi device domain
- *
- * @dev:		The device generating the MSIs
- * @nvec:		The number of MSIs that need to be allocated
- * @is_tree:		flag to indicate tree hierarchy
- * @write_msi_msg:	Callback to write an interrupt message for @dev
- * @ops:		The hierarchy domain operations to use
- * @host_data:		Private data associated to this domain
- *
- * Return: An irqdomain for @nvec interrupts on success, NULL in case of error.
- *
- * This is for interrupt domains which stack on a platform-msi domain
- * created by platform_msi_create_irq_domain(). @dev->msi.domain points to
- * that platform-msi domain which is the parent for the new domain.
- */
-struct irq_domain *
-__platform_msi_create_device_domain(struct device *dev,
-				    unsigned int nvec,
-				    bool is_tree,
-				    irq_write_msi_msg_t write_msi_msg,
-				    const struct irq_domain_ops *ops,
-				    void *host_data)
-{
-	struct platform_msi_priv_data *data;
-	struct irq_domain *domain;
-	int err;
-
-	err = platform_msi_alloc_priv_data(dev, nvec, write_msi_msg);
-	if (err)
-		return NULL;
-
-	/*
-	 * Use a separate lock class for the MSI descriptor mutex on
-	 * platform MSI device domains because the descriptor mutex nests
-	 * into the domain mutex. See alloc/free below.
-	 */
-	lockdep_set_class(&dev->msi.data->mutex, &platform_device_msi_lock_class);
-
-	data = dev->msi.data->platform_data;
-	data->host_data = host_data;
-	domain = irq_domain_create_hierarchy(dev->msi.domain, 0,
-					     is_tree ? 0 : nvec,
-					     dev->fwnode, ops, data);
-	if (!domain)
-		goto free_priv;
-
-	platform_msi_set_proxy_dev(&data->arg);
-	err = msi_domain_prepare_irqs(domain->parent, dev, nvec, &data->arg);
-	if (err)
-		goto free_domain;
-
-	return domain;
-
-free_domain:
-	irq_domain_remove(domain);
-free_priv:
-	platform_msi_free_priv_data(dev);
-	return NULL;
-}
-
-/**
- * platform_msi_device_domain_free - Free interrupts associated with a platform-msi
- *				     device domain
- *
- * @domain:	The platform-msi device domain
- * @virq:	The base irq from which to perform the free operation
- * @nr_irqs:	How many interrupts to free from @virq
- */
-void platform_msi_device_domain_free(struct irq_domain *domain, unsigned int virq,
-				     unsigned int nr_irqs)
-{
-	struct platform_msi_priv_data *data = domain->host_data;
-
-	msi_lock_descs(data->dev);
-	msi_domain_depopulate_descs(data->dev, virq, nr_irqs);
-	irq_domain_free_irqs_common(domain, virq, nr_irqs);
-	msi_free_msi_descs_range(data->dev, virq, virq + nr_irqs - 1);
-	msi_unlock_descs(data->dev);
-}
-
-/**
- * platform_msi_device_domain_alloc - Allocate interrupts associated with
- *				      a platform-msi device domain
- *
- * @domain:	The platform-msi device domain
- * @virq:	The base irq from which to perform the allocate operation
- * @nr_irqs:	How many interrupts to allocate from @virq
- *
- * Return 0 on success, or an error code on failure. Must be called
- * with irq_domain_mutex held (which can only be done as part of a
- * top-level interrupt allocation).
- */
-int platform_msi_device_domain_alloc(struct irq_domain *domain, unsigned int virq,
-				     unsigned int nr_irqs)
-{
-	struct platform_msi_priv_data *data = domain->host_data;
-	struct device *dev = data->dev;
-
-	return msi_domain_populate_irqs(domain->parent, dev, virq, nr_irqs, &data->arg);
-}
-
-/* End of removal area */
-
-/* Real per device domain interfaces */
 
 /*
  * This indirection can go when platform_device_msi_init_and_alloc_irqs()
@@ -357,7 +23,7 @@ static void platform_msi_write_msi_msg(struct irq_data *d, struct msi_msg *msg)
 	cb(irq_data_get_msi_desc(d), msg);
 }
 
-static void platform_msi_set_desc_byindex(msi_alloc_info_t *arg, struct msi_desc *desc)
+static void platform_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
 {
 	arg->desc = desc;
 	arg->hwirq = desc->msi_index;
@@ -373,7 +39,7 @@ static const struct msi_domain_template platform_msi_template = {
 	},
 
 	.ops = {
-		.set_desc		= platform_msi_set_desc_byindex,
+		.set_desc		= platform_msi_set_desc,
 	},
 
 	.info = {
@@ -408,10 +74,6 @@ int platform_device_msi_init_and_alloc_irqs(struct device *dev, unsigned int nve
 	if (!domain || !write_msi_msg)
 		return -EINVAL;
 
-	/* Migration support. Will go away once everything is converted */
-	if (!irq_domain_is_msi_parent(domain))
-		return platform_msi_domain_alloc_irqs(dev, nvec, write_msi_msg);
-
 	/*
 	 * @write_msi_msg is stored in the resulting msi_domain_info::data.
 	 * The underlying domain creation mechanism will assign that
@@ -432,12 +94,6 @@ EXPORT_SYMBOL_GPL(platform_device_msi_init_and_alloc_irqs);
  */
 void platform_device_msi_free_irqs_all(struct device *dev)
 {
-	struct irq_domain *domain = dev->msi.domain;
-
 	msi_domain_free_irqs_all(dev, MSI_DEFAULT_DOMAIN);
-
-	/* Migration support. Will go away once everything is converted */
-	if (!irq_domain_is_msi_parent(domain))
-		platform_msi_free_priv_data(dev);
 }
 EXPORT_SYMBOL_GPL(platform_device_msi_free_irqs_all);
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 4ae036d0c7db..4c3462a6a97b 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -81,7 +81,6 @@ extern int pci_msi_ignore_mask;
 /* Helper functions */
 struct msi_desc;
 struct pci_dev;
-struct platform_msi_priv_data;
 struct device_attribute;
 struct irq_domain;
 struct irq_affinity_desc;
@@ -231,14 +230,12 @@ struct msi_dev_domain {
 /**
  * msi_device_data - MSI per device data
  * @properties:		MSI properties which are interesting to drivers
- * @platform_data:	Platform-MSI specific data
  * @mutex:		Mutex protecting the MSI descriptor store
  * @__domains:		Internal data for per device MSI domains
  * @__iter_idx:		Index to search the next entry for iterators
  */
 struct msi_device_data {
 	unsigned long			properties;
-	struct platform_msi_priv_data	*platform_data;
 	struct mutex			mutex;
 	struct msi_dev_domain		__domains[MSI_MAX_DEVICE_IRQDOMAINS];
 	unsigned long			__iter_idx;
@@ -641,33 +638,6 @@ void msi_domain_free_irqs_all(struct device *dev, unsigned int domid);
 
 struct msi_domain_info *msi_get_domain_info(struct irq_domain *domain);
 
-struct irq_domain *platform_msi_create_irq_domain(struct fwnode_handle *fwnode,
-						  struct msi_domain_info *info,
-						  struct irq_domain *parent);
-
-/* When an MSI domain is used as an intermediate domain */
-int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,
-			    int nvec, msi_alloc_info_t *args);
-int msi_domain_populate_irqs(struct irq_domain *domain, struct device *dev,
-			     int virq, int nvec, msi_alloc_info_t *args);
-void msi_domain_depopulate_descs(struct device *dev, int virq, int nvec);
-
-struct irq_domain *
-__platform_msi_create_device_domain(struct device *dev,
-				    unsigned int nvec,
-				    bool is_tree,
-				    irq_write_msi_msg_t write_msi_msg,
-				    const struct irq_domain_ops *ops,
-				    void *host_data);
-
-#define platform_msi_create_device_tree_domain(dev, nvec, write, ops, data) \
-	__platform_msi_create_device_domain(dev, nvec, true, write, ops, data)
-
-int platform_msi_device_domain_alloc(struct irq_domain *domain, unsigned int virq,
-				     unsigned int nr_irqs);
-void platform_msi_device_domain_free(struct irq_domain *domain, unsigned int virq,
-				     unsigned int nvec);
-void *platform_msi_get_host_data(struct irq_domain *domain);
 /* Per device platform MSI */
 int platform_device_msi_init_and_alloc_irqs(struct device *dev, unsigned int nvec,
 					    irq_write_msi_msg_t write_msi_msg);
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 2024f89baea4..8314b1d4a903 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1088,8 +1088,8 @@ bool msi_match_device_irq_domain(struct device *dev, unsigned int domid,
 	return ret;
 }
 
-int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,
-			    int nvec, msi_alloc_info_t *arg)
+static int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,
+				   int nvec, msi_alloc_info_t *arg)
 {
 	struct msi_domain_info *info = domain->host_data;
 	struct msi_domain_ops *ops = info->ops;
@@ -1097,77 +1097,6 @@ int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,
 	return ops->msi_prepare(domain, dev, nvec, arg);
 }
 
-int msi_domain_populate_irqs(struct irq_domain *domain, struct device *dev,
-			     int virq_base, int nvec, msi_alloc_info_t *arg)
-{
-	struct msi_domain_info *info = domain->host_data;
-	struct msi_domain_ops *ops = info->ops;
-	struct msi_ctrl ctrl = {
-		.domid	= MSI_DEFAULT_DOMAIN,
-		.first  = virq_base,
-		.last	= virq_base + nvec - 1,
-	};
-	struct msi_desc *desc;
-	struct xarray *xa;
-	int ret, virq;
-
-	msi_lock_descs(dev);
-
-	if (!msi_ctrl_valid(dev, &ctrl)) {
-		ret = -EINVAL;
-		goto unlock;
-	}
-
-	ret = msi_domain_add_simple_msi_descs(dev, &ctrl);
-	if (ret)
-		goto unlock;
-
-	xa = &dev->msi.data->__domains[ctrl.domid].store;
-
-	for (virq = virq_base; virq < virq_base + nvec; virq++) {
-		desc = xa_load(xa, virq);
-		desc->irq = virq;
-
-		ops->set_desc(arg, desc);
-		ret = irq_domain_alloc_irqs_hierarchy(domain, virq, 1, arg);
-		if (ret)
-			goto fail;
-
-		irq_set_msi_desc(virq, desc);
-	}
-	msi_unlock_descs(dev);
-	return 0;
-
-fail:
-	for (--virq; virq >= virq_base; virq--) {
-		msi_domain_depopulate_descs(dev, virq, 1);
-		irq_domain_free_irqs_common(domain, virq, 1);
-	}
-	msi_domain_free_descs(dev, &ctrl);
-unlock:
-	msi_unlock_descs(dev);
-	return ret;
-}
-
-void msi_domain_depopulate_descs(struct device *dev, int virq_base, int nvec)
-{
-	struct msi_ctrl ctrl = {
-		.domid	= MSI_DEFAULT_DOMAIN,
-		.first  = virq_base,
-		.last	= virq_base + nvec - 1,
-	};
-	struct msi_desc *desc;
-	struct xarray *xa;
-	unsigned long idx;
-
-	if (!msi_ctrl_valid(dev, &ctrl))
-		return;
-
-	xa = &dev->msi.data->__domains[ctrl.domid].store;
-	xa_for_each_range(xa, idx, desc, ctrl.first, ctrl.last)
-		desc->irq = 0;
-}
-
 /*
  * Carefully check whether the device can use reservation mode. If
  * reservation mode is enabled then the early activation will assign a
-- 
2.34.1


