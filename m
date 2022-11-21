Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FF26326EF
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiKUOwQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiKUOvo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:51:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7E7D5A39;
        Mon, 21 Nov 2022 06:43:13 -0800 (PST)
Message-ID: <20221121140050.767805666@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=NGmCCnJedPVthQ5so0NTL3Zqtey0ARjNua+AbqFjFk0=;
        b=KJDqqWBZ5yUQH8ZjaNkIK/Xvu5xm80XntRkpXFUwx3Py+EZcDFsAYzL/8Qf8WFuetLousW
        rxYNBMtkLleXneKuTZPQqtgMfOs0pLXV1py3fmzvfwxwgYWPyBP0hJATD76a9zmJyyDPj+
        GekeG6MxKhdnz5aZBi1IeiT7lxLt2MMWtJXhvGjM5R8xKxAV9uIqkoogsphOhtK0e45NVo
        2CXS2qUwriweSSZuQBnfENpNByfj4S3ssOgMCf8433gm2DJjgPGcFMvXkWNp1niHhm8nNr
        hGvTy5dj43P50AEmbACpujg324R4sDPUmuO7QxkL93Yyzq1mmgxtSHb84wpnNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=NGmCCnJedPVthQ5so0NTL3Zqtey0ARjNua+AbqFjFk0=;
        b=CSdq28VAusZGM1gQ2PugteWc7V5iXxvBCPAyB2JSa4gTMn39Y8mPBgtOnxG3f8FOH5hQtY
        v91u3fcI1ZK2WWCQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Subject: [patch V2 39/40] genirq/msi: Remove platform MSI leftovers
References: <20221121135653.208611233@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:40:17 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

No more users!

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/base/platform-msi.c |  352 --------------------------------------------
 include/linux/msi.h         |   31 ---
 kernel/irq/msi.c            |   48 ------
 3 files changed, 3 insertions(+), 428 deletions(-)

--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -4,357 +4,12 @@
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
-	datap->devid = ida_simple_get(&platform_msi_devid_ida,
-				      0, 1 << DEV_ID_SHIFT, GFP_KERNEL);
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
-	ida_simple_remove(&platform_msi_devid_ida, data->devid);
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
-int platform_msi_domain_alloc_irqs(struct device *dev, unsigned int nvec,
-				   irq_write_msi_msg_t write_msi_msg)
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
-EXPORT_SYMBOL_GPL(platform_msi_domain_alloc_irqs);
-
-/**
- * platform_msi_domain_free_irqs - Free MSI interrupts for @dev
- * @dev:	The device for which to free interrupts
- */
-void platform_msi_domain_free_irqs(struct device *dev)
-{
-	msi_domain_free_irqs_all(dev, MSI_DEFAULT_DOMAIN);
-	platform_msi_free_priv_data(dev);
-}
-EXPORT_SYMBOL_GPL(platform_msi_domain_free_irqs);
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
  * This indirection can go when platform_device_ims_init_and_alloc_irqs()
@@ -415,15 +70,10 @@ int platform_device_ims_init_and_alloc_i
 					    irq_write_msi_msg_t write_msi_msg)
 {
 	struct irq_domain *domain = dev->msi.domain;
-	int ret;
 
 	if (!domain || !write_msi_msg)
 		return -EINVAL;
 
-	/* Migration support. Will go away once everything is converted */
-	if (!irq_domain_is_msi_parent(domain))
-		return platform_msi_domain_alloc_irqs(dev, nvec, write_msi_msg);
-
 	/*
 	 * @write_msi_msg is stored in the resulting msi_domain_info::data.
 	 * The underlying domain creation mechanism will assign that
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -77,7 +77,6 @@ extern int pci_msi_ignore_mask;
 /* Helper functions */
 struct msi_desc;
 struct pci_dev;
-struct platform_msi_priv_data;
 struct device_attribute;
 struct irq_domain;
 struct irq_affinity_desc;
@@ -216,7 +215,6 @@ enum msi_desc_filter {
 /**
  * msi_device_data - MSI per device data
  * @properties:		MSI properties which are interesting to drivers
- * @platform_data:	Platform-MSI specific data
  * @mutex:		Mutex protecting the MSI descriptor store
  * @__store:		Xarray for storing MSI descriptor pointers
  * @__iter_idx:		Index to search the next entry for iterators
@@ -225,7 +223,6 @@ enum msi_desc_filter {
  */
 struct msi_device_data {
 	unsigned long			properties;
-	struct platform_msi_priv_data	*platform_data;
 	struct mutex			mutex;
 	struct xarray			__store;
 	unsigned long			__iter_idx;
@@ -628,34 +625,6 @@ void msi_domain_free_irqs_all(struct dev
 
 struct msi_domain_info *msi_get_domain_info(struct irq_domain *domain);
 
-struct irq_domain *platform_msi_create_irq_domain(struct fwnode_handle *fwnode,
-						  struct msi_domain_info *info,
-						  struct irq_domain *parent);
-int platform_msi_domain_alloc_irqs(struct device *dev, unsigned int nvec,
-				   irq_write_msi_msg_t write_msi_msg);
-void platform_msi_domain_free_irqs(struct device *dev);
-
-/* When an MSI domain is used as an intermediate domain */
-int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,
-			    int nvec, msi_alloc_info_t *args);
-int msi_domain_populate_irqs(struct irq_domain *domain, struct device *dev,
-			     int virq, int nvec, msi_alloc_info_t *args);
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
 int platform_device_ims_init_and_alloc_irqs(struct device *dev, unsigned int nvec,
 					    irq_write_msi_msg_t write_msi_msg);
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1121,8 +1121,8 @@ bool msi_match_device_irq_domain(struct
 	return ret;
 }
 
-int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,
-			    int nvec, msi_alloc_info_t *arg)
+static int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,
+				   int nvec, msi_alloc_info_t *arg)
 {
 	struct msi_domain_info *info = domain->host_data;
 	struct msi_domain_ops *ops = info->ops;
@@ -1130,50 +1130,6 @@ int msi_domain_prepare_irqs(struct irq_d
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
-	int ret, virq;
-
-	if (!msi_ctrl_range_valid(dev, &ctrl))
-		return -EINVAL;
-
-	msi_lock_descs(dev);
-	ret = msi_domain_add_simple_msi_descs(dev, &ctrl);
-	if (ret)
-		goto unlock;
-
-	for (virq = virq_base; virq < virq_base + nvec; virq++) {
-		desc = xa_load(&dev->msi.data->__store, virq);
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
-	for (--virq; virq >= virq_base; virq--)
-		irq_domain_free_irqs_common(domain, virq, 1);
-	msi_domain_free_descs(dev, &ctrl);
-unlock:
-	msi_unlock_descs(dev);
-	return ret;
-}
-
 /*
  * Carefully check whether the device can use reservation mode. If
  * reservation mode is enabled then the early activation will assign a

