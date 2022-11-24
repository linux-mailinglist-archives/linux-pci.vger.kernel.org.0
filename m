Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A6C638183
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 00:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiKXX1q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 18:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiKXX1Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 18:27:16 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DF3CD97B;
        Thu, 24 Nov 2022 15:26:10 -0800 (PST)
Message-ID: <20221124230505.073418677@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669332345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=als3+uiohdwha1q3nxHOpuFLNA/KnCPUD+1sxNlaCHo=;
        b=Eh1cXbjEOz1GZmtHmsBivQLBNxJ75J1w1PAY5/ToY6GcvGSHwj5lzXd7Grqwq/fIrNnAnC
        g4gYkd1MqwDxxpUAzwYRzs+67xMDYipOQQomfVdQXAqQgm0BX4jL9lGvkNdrKmvznDZrYg
        bgAM2AxoO5kBrQbc0FqKsv1c/iUzZfD5rWmUKAJUZkj6ZSRUzB4ON9jPECnEQ8EHhyz1BU
        mBHK4oWmt6SMoKaYvgc5PNmVAIkqmgLgspkHAESvruqZdMKOaNgGvFduIvK2iYk0kFkOoo
        Xur0ryckHHiIUcx7uo+c3m216ntP7Gb+/zP6WKNTCr09IY/U8ogN/iZ1AUv+6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669332345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=als3+uiohdwha1q3nxHOpuFLNA/KnCPUD+1sxNlaCHo=;
        b=sleDmDqCOorRX3Opzw5PDBIp2m7APBhDf9yhUFXd2bllfxJUQvvyt67pfFn0Jb5WV4i8a+
        3P75avG8NzBlk7BQ==
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
Subject: [patch V3 00/33] genirq, PCI/MSI: Support for per device MSI and
 PCI/IMS - Part 3 implementation
Date:   Fri, 25 Nov 2022 00:25:45 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is V3 of the third part of the effort to provide support for per device
MSI interrupt domains.

Version 2 of this part can be found here:

  https://lore.kernel.org/all/20221121083657.157152924@linutronix.de

This is based on the second part which is available here:

  https://lore.kernel.org/all/20221124225331.464480443@linutronix.de

and from git:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git devmsi-v3-part2

This third part is available from git too:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git devmsi-v3-part3

This part provides the actual per device domain implementation and related
functionality:

  1) Provide infrastructure to create and remove per device MSI domains

  2) Implement per device MSI domains in the PCI/MSI code and make
     them conditional on the availability of a suitable parent MSI
     domain. This allows to convert the existing domains one by one
     and keeps both the legacy and the current "global" PCI/MSI domain
     model working.

  3) Convert the related x86 MSI domains over (vector and remapping).

  4) Provide core infrastructure for dynamic allocations

  5) Provide PCI/MSI-X interfaces for device drivers to do post
     MSI-X enable allocation/free

  6) Enable dynamic allocation support on the x86 MSI parent domains

  7) Provide infrastructure to create PCI/IMS domains

  8) Enable IMS support on the x86 MSI parent domains

  9) Provide a driver for IDXD which demonstrates how IMS domains
     look like.

Changes vs. v2:

  - Rework the domain size initialization and handling (Kevin)

  - Enable IMS only when on real hardware (Kevin)

  - Rename the PCI/MSI irqchip functions (Kevin)
  
  - Update change logs and comments (Kevin)
   
The delta patch vs. V3 is attached below. It's not completely accurate as
it has some changes from part 2 intermingled, but you get the idea.

Thanks,

	tglx
---
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 1eb9f9eb4852..4d28967f910d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3656,6 +3656,13 @@ static const struct msi_parent_ops amdvi_msi_parent_ops = {
 	.init_dev_msi_info	= msi_parent_init_dev_msi_info,
 };
 
+static const struct msi_parent_ops virt_amdvi_msi_parent_ops = {
+	.supported_flags	= X86_VECTOR_MSI_FLAGS_SUPPORTED |
+				  MSI_FLAG_MULTI_PCI_MSI,
+	.prefix			= "vIR-",
+	.init_dev_msi_info	= msi_parent_init_dev_msi_info,
+};
+
 int amd_iommu_create_irq_domain(struct amd_iommu *iommu)
 {
 	struct fwnode_handle *fn;
@@ -3672,7 +3679,11 @@ int amd_iommu_create_irq_domain(struct amd_iommu *iommu)
 
 	irq_domain_update_bus_token(iommu->ir_domain,  DOMAIN_BUS_AMDVI);
 	iommu->ir_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
-	iommu->ir_domain->msi_parent_ops = &amdvi_msi_parent_ops;
+
+	if (amd_iommu_np_cache)
+		iommu->ir_domain->msi_parent_ops = &virt_amdvi_msi_parent_ops;
+	else
+		iommu->ir_domain->msi_parent_ops = &amdvi_msi_parent_ops;
 
 	return 0;
 }
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index f3ee93be9032..a723f53ba472 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -82,7 +82,7 @@ static const struct irq_domain_ops intel_ir_domain_ops;
 
 static void iommu_disable_irq_remapping(struct intel_iommu *iommu);
 static int __init parse_ioapics_under_ir(void);
-static const struct msi_parent_ops dmar_msi_parent_ops;
+static const struct msi_parent_ops dmar_msi_parent_ops, virt_dmar_msi_parent_ops;
 
 static bool ir_pre_enabled(struct intel_iommu *iommu)
 {
@@ -577,7 +577,11 @@ static int intel_setup_irq_remapping(struct intel_iommu *iommu)
 
 	irq_domain_update_bus_token(iommu->ir_domain,  DOMAIN_BUS_DMAR);
 	iommu->ir_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
-	iommu->ir_domain->msi_parent_ops = &dmar_msi_parent_ops;
+
+	if (cap_caching_mode(iommu->cap))
+		iommu->ir_domain->msi_parent_ops = &virt_dmar_msi_parent_ops;
+	else
+		iommu->ir_domain->msi_parent_ops = &dmar_msi_parent_ops;
 
 	ir_table->base = page_address(pages);
 	ir_table->bitmap = bitmap;
@@ -1436,6 +1440,13 @@ static const struct msi_parent_ops dmar_msi_parent_ops = {
 	.init_dev_msi_info	= msi_parent_init_dev_msi_info,
 };
 
+static const struct msi_parent_ops virt_dmar_msi_parent_ops = {
+	.supported_flags	= X86_VECTOR_MSI_FLAGS_SUPPORTED |
+				  MSI_FLAG_MULTI_PCI_MSI,
+	.prefix			= "vIR-",
+	.init_dev_msi_info	= msi_parent_init_dev_msi_info,
+};
+
 /*
  * Support of Interrupt Remapping Unit Hotplug
  */
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 622f0fd5f829..9eec1ec19917 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -699,7 +699,7 @@ config PCI_INTEL_IDXD_IMS
 	tristate "Intel IDXD Interrupt Message Store controller"
 	depends on PCI_MSI
 	help
-	  Support for Intel IDXD IMS Interrupt Message Store controller
+	  Support for Intel IDXD Interrupt Message Store (IMS) controller
 	  with IMS slot storage in a slot array in device memory
 
 endmenu
diff --git a/drivers/irqchip/irq-pci-intel-idxd.c b/drivers/irqchip/irq-pci-intel-idxd.c
index 509450b08f47..d33c32787ad5 100644
--- a/drivers/irqchip/irq-pci-intel-idxd.c
+++ b/drivers/irqchip/irq-pci-intel-idxd.c
@@ -128,7 +128,7 @@ static const struct msi_domain_template idxd_ims_template = {
 /**
  * pci_intel_idxd_create_ims_domain - Create a IDXD IMS domain
  * @pdev:	IDXD PCI device to operate on
- * @slots:	Pointer to the mapped slot memory arrray
+ * @slots:	Pointer to the mapped slot memory array
  * @nr_slots:	The number of slots in the array
  *
  * Returns: True on success, false otherwise
diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index dfcaa77108de..d60585875009 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -141,7 +141,7 @@ EXPORT_SYMBOL_GPL(pci_msix_can_alloc_dyn);
  * Return: A struct msi_map
  *
  *	On success msi_map::index contains the allocated index (>= 0) and
- *	msi_map::virq the allocated Linux interrupt number (> 0).
+ *	msi_map::virq contains the allocated Linux interrupt number (> 0).
  *
  *	On fail msi_map::index contains the error code and msi_map::virq
  *	is set to 0.
@@ -376,7 +376,7 @@ EXPORT_SYMBOL(pci_irq_get_affinity);
  * the index - if there is a hardware table - or in case of purely software
  * managed IMS implementation the association happens via the
  * irq_write_msi_msg() callback of the implementation specific interrupt
- * chip, which utilizes the provided @cookie to store the MSI message in
+ * chip, which utilizes the provided @icookie to store the MSI message in
  * the appropriate place.
  *
  * Return: A struct msi_map
diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index ad235d1b0f35..687a986365f9 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -148,14 +148,14 @@ static void pci_device_domain_set_desc(msi_alloc_info_t *arg, struct msi_desc *d
 	arg->hwirq = desc->msi_index;
 }
 
-static void pci_mask_msi(struct irq_data *data)
+static void pci_irq_mask_msi(struct irq_data *data)
 {
 	struct msi_desc *desc = irq_data_get_msi_desc(data);
 
 	pci_msi_mask(desc, BIT(data->irq - desc->irq));
 }
 
-static void pci_unmask_msi(struct irq_data *data)
+static void pci_irq_unmask_msi(struct irq_data *data)
 {
 	struct msi_desc *desc = irq_data_get_msi_desc(data);
 
@@ -176,8 +176,8 @@ static void pci_unmask_msi(struct irq_data *data)
 static struct msi_domain_template pci_msi_template = {
 	.chip = {
 		.name			= "PCI-MSI",
-		.irq_mask		= pci_mask_msi,
-		.irq_unmask		= pci_unmask_msi,
+		.irq_mask		= pci_irq_mask_msi,
+		.irq_unmask		= pci_irq_unmask_msi,
 		.irq_write_msi_msg	= pci_msi_domain_write_msg,
 		.flags			= IRQCHIP_ONESHOT_SAFE,
 	},
@@ -192,12 +192,12 @@ static struct msi_domain_template pci_msi_template = {
 	},
 };
 
-static void pci_mask_msix(struct irq_data *data)
+static void pci_irq_mask_msix(struct irq_data *data)
 {
 	pci_msix_mask(irq_data_get_msi_desc(data));
 }
 
-static void pci_unmask_msix(struct irq_data *data)
+static void pci_irq_unmask_msix(struct irq_data *data)
 {
 	pci_msix_unmask(irq_data_get_msi_desc(data));
 }
@@ -213,8 +213,8 @@ static void pci_msix_prepare_desc(struct irq_domain *domain, msi_alloc_info_t *a
 static struct msi_domain_template pci_msix_template = {
 	.chip = {
 		.name			= "PCI-MSIX",
-		.irq_mask		= pci_mask_msix,
-		.irq_unmask		= pci_unmask_msix,
+		.irq_mask		= pci_irq_mask_msix,
+		.irq_unmask		= pci_irq_unmask_msix,
 		.irq_write_msi_msg	= pci_msi_domain_write_msg,
 		.flags			= IRQCHIP_ONESHOT_SAFE,
 	},
@@ -302,7 +302,7 @@ bool pci_setup_msi_device_domain(struct pci_dev *pdev)
  */
 bool pci_setup_msix_device_domain(struct pci_dev *pdev, unsigned int hwsize)
 {
-	if (WARN_ON_ONCE(pdev->msix_enabled))
+	if (WARN_ON_ONCE(pdev->msi_enabled))
 		return false;
 
 	if (pci_match_device_domain(pdev, DOMAIN_BUS_PCI_DEVICE_MSIX))
diff --git a/include/linux/msi.h b/include/linux/msi.h
index f73d20ccd552..a112b913fff9 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -455,7 +463,10 @@ struct msi_domain_ops {
  * struct msi_domain_info - MSI interrupt domain data
  * @flags:		Flags to decribe features and capabilities
  * @bus_token:		The domain bus token
- * @hwsize:		The hardware table size (0 if unknown/unlimited)
+ * @hwsize:		The hardware table size or the software index limit.
+ *			If 0 then the size is considered unlimited and
+ *			gets initialized to the maximum software index limit
+ *			by the domain creation code.
  * @ops:		The callback data structure
  * @chip:		Optional: associated interrupt chip
  * @chip_data:		Optional: associated interrupt chip data
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 43bc0c6d66ec..c39f75e473ea 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -118,30 +85,22 @@ static int msi_insert_desc(struct device *dev, struct msi_desc *desc,
 			   unsigned int domid, unsigned int index)
 {
 	struct msi_device_data *md = dev->msi.data;
+	struct xarray *xa = &md->__domains[domid].store;
 	unsigned int hwsize;
-	int baseidx, ret;
-
-	baseidx = msi_get_domain_base_index(dev, domid);
-	if (baseidx < 0) {
-		ret = baseidx;
-		goto fail;
-	}
+	int ret;
 
 	hwsize = msi_domain_get_hwsize(dev, domid);
 
 	if (index == MSI_ANY_INDEX) {
-		struct xa_limit limit;
+		struct xa_limit limit = { .min = 0, .max = hwsize - 1 };
 		unsigned int index;
 
-		limit.min = baseidx;
-		limit.max = baseidx + hwsize - 1;
-
-		/* Let the xarray allocate a free index within the limits */
-		ret = xa_alloc(&md->__store, &index, desc, limit, GFP_KERNEL);
+		/* Let the xarray allocate a free index within the limit */
+		ret = xa_alloc(xa, &index, desc, limit, GFP_KERNEL);
 		if (ret)
 			goto fail;
 
-		desc->msi_index = index - baseidx;
+		desc->msi_index = index;
 		return 0;
 	} else {
 		if (index >= hwsize) {
@@ -150,8 +109,7 @@ static int msi_insert_desc(struct device *dev, struct msi_desc *desc,
 		}
 
 		desc->msi_index = index;
-		index += baseidx;
-		ret = xa_insert(&md->__store, index, desc, GFP_KERNEL);
+		ret = xa_insert(xa, index, desc, GFP_KERNEL);
 		if (ret)
 			goto fail;
 		return 0;
@@ -313,10 +268,13 @@ EXPORT_SYMBOL_GPL(get_cached_msi_msg);
 static void msi_device_data_release(struct device *dev, void *res)
 {
 	struct msi_device_data *md = res;
+	int i;
 
-	msi_remove_device_irqdomains(dev, md);
-	WARN_ON_ONCE(!xa_empty(&md->__store));
-	xa_destroy(&md->__store);
+	for (i = 0; i < MSI_MAX_DEVICE_IRQDOMAINS; i++) {
+		msi_remove_device_irq_domain(dev, i);
+		WARN_ON_ONCE(!xa_empty(&md->__domains[i].store));
+		xa_destroy(&md->__domains[i].store);
+	}
 	dev->msi.data = NULL;
 }
 
@@ -348,11 +306,19 @@ int msi_setup_device_data(struct device *dev)
 		return ret;
 	}
 
-	msi_setup_default_irqdomain(dev, md);
+	for (i = 0; i < MSI_MAX_DEVICE_IRQDOMAINS; i++)
+		xa_init_flags(&md->__domains[i].store, XA_FLAGS_ALLOC);
+
+	/*
+	 * If @dev::msi::domain is set and is a global MSI domain, copy the
+	 * pointer into the domain array so all code can operate on domain
+	 * ids. The NULL pointer check is required to keep the legacy
+	 * architecture specific PCI/MSI support working.
+	 */
+	if (dev->msi.domain && !irq_domain_is_msi_parent(dev->msi.domain))
+		md->__domains[MSI_DEFAULT_DOMAIN].domain = dev->msi.domain;
 
-	xa_init_flags(&md->__store, XA_FLAGS_ALLOC);
 	mutex_init(&md->mutex);
-	md->__iter_idx = MSI_XA_MAX_INDEX;
 	dev->msi.data = md;
 	devres_add(dev, md);
 	return 0;
@@ -631,7 +592,7 @@ static struct irq_domain *msi_get_device_domain(struct device *dev, unsigned int
 	if (WARN_ON_ONCE(domid >= MSI_MAX_DEVICE_IRQDOMAINS))
 		return NULL;
 
-	domain = dev->msi.data->__irqdomains[domid];
+	domain = dev->msi.data->__domains[domid].domain;
 	if (!domain)
 		return NULL;
 
@@ -646,18 +607,13 @@ static unsigned int msi_domain_get_hwsize(struct device *dev, unsigned int domid
 	struct msi_domain_info *info;
 	struct irq_domain *domain;
 
-	/*
-	 * Retrieve the MSI domain for range checking. If there is no
-	 * domain or the domain is not a per device domain, then assume
-	 * full MSI range and pray that the calling subsystem knows what it
-	 * is doing.
-	 */
 	domain = msi_get_device_domain(dev, domid);
-	if (domain && irq_domain_is_msi_device(domain)) {
+	if (domain) {
 		info = domain->host_data;
 		return info->hwsize;
 	}
-	return MSI_MAX_INDEX + 1;
+	/* No domain, no size... */
+	return 0;
 }
 
 static inline void irq_chip_write_msi_msg(struct irq_data *data,
@@ -858,6 +814,17 @@ static struct irq_domain *__msi_create_irq_domain(struct fwnode_handle *fwnode,
 {
 	struct irq_domain *domain;
 
+	if (info->hwsize > MSI_XA_DOMAIN_SIZE)
+		return NULL;
+
+	/*
+	 * Hardware size 0 is valid for backwards compatibility and for
+	 * domains which are not backed by a hardware table. Grant the
+	 * maximum index space.
+	 */
+	if (!info->hwsize)
+		info->hwsize = MSI_XA_DOMAIN_SIZE;
+
 	msi_domain_update_dom_ops(info);
 	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
 		msi_domain_update_chip_ops(info);
@@ -997,7 +964,7 @@ bool msi_create_device_irq_domain(struct device *dev, unsigned int domid,
 	if (!bundle)
 		return false;
 
-	bundle->info.hwsize = hwsize ? hwsize : MSI_MAX_INDEX;
+	bundle->info.hwsize = hwsize;
 	bundle->info.chip = &bundle->chip;
 	bundle->info.ops = &bundle->ops;
 	bundle->info.data = domain_data;
@@ -1028,7 +995,7 @@ bool msi_create_device_irq_domain(struct device *dev, unsigned int domid,
 		goto fail;
 
 	domain->dev = dev;
-	dev->msi.data->__irqdomains[domid] = domain;
+	dev->msi.data->__domains[domid].domain = domain;
 	msi_unlock_descs(dev);
 	return true;
 
@@ -1058,7 +1025,7 @@ void msi_remove_device_irq_domain(struct device *dev, unsigned int domid)
 	if (!domain || !irq_domain_is_msi_device(domain))
 		goto unlock;
 
-	dev->msi.data->__irqdomains[domid] = NULL;
+	dev->msi.data->__domains[domid].domain = NULL;
 	info = domain->host_data;
 	irq_domain_remove(domain);
 	kfree(container_of(info, struct msi_domain_template, info));
@@ -1112,9 +1079,10 @@ int msi_domain_populate_irqs(struct irq_domain *domain, struct device *dev,
 		.last	= virq_base + nvec - 1,
 	};
 	struct msi_desc *desc;
+	struct xarray *xa;
 	int ret, virq;
 
-	if (!msi_ctrl_range_valid(dev, &ctrl))
+	if (!msi_ctrl_valid(dev, &ctrl))
 		return -EINVAL;
 
 	msi_lock_descs(dev);
@@ -1122,8 +1090,10 @@ int msi_domain_populate_irqs(struct irq_domain *domain, struct device *dev,
 	if (ret)
 		goto unlock;
 
+	xa = &dev->msi.data->__domains[ctrl.domid].store;
+
 	for (virq = virq_base; virq < virq_base + nvec; virq++) {
-		desc = xa_load(&dev->msi.data->__store, virq);
+		desc = xa_load(xa, virq);
 		desc->irq = virq;
 
 		ops->set_desc(arg, desc);
@@ -1257,8 +1227,8 @@ static int msi_init_virq(struct irq_domain *domain, int virq, unsigned int vflag
 static int __msi_domain_alloc_irqs(struct device *dev, struct irq_domain *domain,
 				   struct msi_ctrl *ctrl)
 {
+	struct xarray *xa = &dev->msi.data->__domains[ctrl->domid].store;
 	struct msi_domain_info *info = domain->host_data;
-	struct xarray *xa = &dev->msi.data->__store;
 	struct msi_domain_ops *ops = info->ops;
 	unsigned int vflags = 0, allocated = 0;
 	msi_alloc_info_t arg = { };
@@ -1347,7 +1317,7 @@ static int __msi_domain_alloc_locked(struct device *dev, struct msi_ctrl *ctrl)
 	struct irq_domain *domain;
 	int ret;
 
-	if (!msi_ctrl_range_valid(dev, ctrl))
+	if (!msi_ctrl_valid(dev, ctrl))
 		return -EINVAL;
 
 	domain = msi_get_device_domain(dev, ctrl->domid);
@@ -1527,16 +1497,14 @@ struct msi_map msi_domain_alloc_irq_at(struct device *dev, unsigned int domid, u
 static void __msi_domain_free_irqs(struct device *dev, struct irq_domain *domain,
 				   struct msi_ctrl *ctrl)
 {
+	struct xarray *xa = &dev->msi.data->__domains[ctrl->domid].store;
 	struct msi_domain_info *info = domain->host_data;
-	struct xarray *xa = &dev->msi.data->__store;
 	struct irq_data *irqd;
 	struct msi_desc *desc;
 	unsigned long idx;
-	int i, base;
-
-	base = ctrl->domid * MSI_XA_DOMAIN_SIZE;
+	int i;
 
-	xa_for_each_range(xa, idx, desc, ctrl->first + base, ctrl->last + base) {
+	xa_for_each_range(xa, idx, desc, ctrl->first, ctrl->last) {
 		/* Only handle MSI entries which have an interrupt associated */
 		if (!msi_desc_match(desc, MSI_DESC_ASSOCIATED))
 			continue;
@@ -1561,7 +1529,7 @@ static void msi_domain_free_locked(struct device *dev, struct msi_ctrl *ctrl)
 	struct msi_domain_ops *ops;
 	struct irq_domain *domain;
 
-	if (!msi_ctrl_range_valid(dev, ctrl))
+	if (!msi_ctrl_valid(dev, ctrl))
 		return;
 
 	domain = msi_get_device_domain(dev, ctrl->domid);
