Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3B363264B
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbiKUOjG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbiKUOiF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:38:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C1B2657;
        Mon, 21 Nov 2022 06:38:03 -0800 (PST)
Message-ID: <20221121091327.217466288@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Bult+QOTyn3yk1J2BaE5BOxLAmykZwJ6i9DuwWbDSqo=;
        b=eE1BHc3stVMCwQrQAUDAd1nHoGWQdcQRs+M83JPkeKRX6ctN69qY9uhrxVx+LGlCZBtVK5
        /UmGPqsaz9IAchDZlM/jqQg1h4m/KVoXckfZQtklH3mqgmsX9Wq747EwulwN7W1qDtRExs
        8yJt+xRDhvzVmuhQq3BQqBHJm+oXRuBS5cnFV7v83jYdHsT5Hl4SaeStepYgzapVosU9Sr
        iGGGeAxY5uvkWllvrDFOn1zEW5rJUpsIfV5DnUund0raH+BDZrfho4ukLZBJ789LsD8LIQ
        rrqvdW/0LOoxVVzh2gOeSfS4oZcgtU1wghZ309ZPJhfRTc2N337csp7GVYoQ/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Bult+QOTyn3yk1J2BaE5BOxLAmykZwJ6i9DuwWbDSqo=;
        b=Os+MLmx8pPA3/dTcyFjd+KvxxvEdJhEiShuNmjwR+j09rn94U86q8zQPV2aq5Tsmz+6Wna
        rx9gcWt6WWF8GkDg==
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
Subject: [patch V2 13/33] x86/apic/vector: Provide MSI parent domain
References: <20221121083657.157152924@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:38:02 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enable MSI parent domain support in the x86 vector domain and fixup the
checks in the iommu implementations to check whether device::msi::domain is
the default MSI parent domain. That keeps the existing logic to protect
e.g. devices behind VMD working.

The interrupt remap PCI/MSI code still works because the underlying vector
domain still provides the same functionality.

None of the other x86 PCI/MSI, e.g. XEN and HyperV, implementations are
affected either. They still work the same way both at the low level and the
PCI/MSI implementations they provide.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Fix kernel doc (robot)
---
 arch/x86/include/asm/msi.h          |    6 +
 arch/x86/include/asm/pci.h          |    1 
 arch/x86/kernel/apic/msi.c          |  176 ++++++++++++++++++++++++++----------
 drivers/iommu/amd/iommu.c           |    2 
 drivers/iommu/intel/irq_remapping.c |    2 
 5 files changed, 138 insertions(+), 49 deletions(-)

--- a/arch/x86/include/asm/msi.h
+++ b/arch/x86/include/asm/msi.h
@@ -62,4 +62,10 @@ typedef struct x86_msi_addr_hi {
 struct msi_msg;
 u32 x86_msi_msg_get_destid(struct msi_msg *msg, bool extid);
 
+#define X86_VECTOR_MSI_FLAGS_SUPPORTED					\
+	(MSI_GENERIC_FLAGS_MASK | MSI_FLAG_PCI_MSIX)
+
+#define X86_VECTOR_MSI_FLAGS_REQUIRED					\
+	(MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS)
+
 #endif /* _ASM_X86_MSI_H */
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -92,6 +92,7 @@ void pcibios_scan_root(int bus);
 struct irq_routing_table *pcibios_get_irq_routing_table(void);
 int pcibios_set_irq_routing(struct pci_dev *dev, int pin, int irq);
 
+bool pci_dev_has_default_msi_parent_domain(struct pci_dev *dev);
 
 #define HAVE_PCI_MMAP
 #define arch_can_pci_mmap_wc()	pat_enabled()
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -142,67 +142,131 @@ msi_set_affinity(struct irq_data *irqd,
 	return ret;
 }
 
-/*
- * IRQ Chip for MSI PCI/PCI-X/PCI-Express Devices,
- * which implement the MSI or MSI-X Capability Structure.
+/**
+ * pci_dev_has_default_msi_parent_domain - Check whether the device has the default
+ *					   MSI parent domain associated
+ * @dev:	Pointer to the PCI device
  */
-static struct irq_chip pci_msi_controller = {
-	.name			= "PCI-MSI",
-	.irq_unmask		= pci_msi_unmask_irq,
-	.irq_mask		= pci_msi_mask_irq,
-	.irq_ack		= irq_chip_ack_parent,
-	.irq_retrigger		= irq_chip_retrigger_hierarchy,
-	.irq_set_affinity	= msi_set_affinity,
-	.flags			= IRQCHIP_SKIP_SET_WAKE |
-				  IRQCHIP_AFFINITY_PRE_STARTUP,
-};
+bool pci_dev_has_default_msi_parent_domain(struct pci_dev *dev)
+{
+	struct irq_domain *domain = dev_get_msi_domain(&dev->dev);
 
-int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
-		    msi_alloc_info_t *arg)
+	if (!domain)
+		domain = dev_get_msi_domain(&dev->bus->dev);
+	if (!domain)
+		return false;
+
+	return domain == x86_vector_domain;
+}
+
+/**
+ * x86_msi_prepare - Setup of msi_alloc_info_t for allocations
+ * @domain:	The domain for which this setup happens
+ * @dev:	The device for which interrupts are allocated
+ * @nvec:	The number of vectors to allocate
+ * @alloc:	The allocation info structure to initialize
+ *
+ * This function is to be used for all types of MSI domains above the x86
+ * vector domain and any intermediates. It is always invoked from the
+ * top level interrupt domain. The domain specific allocation
+ * functionality is determined via the @domain's bus token which allows to
+ * map the X86 specific allocation type.
+ */
+static int x86_msi_prepare(struct irq_domain *domain, struct device *dev,
+			   int nvec, msi_alloc_info_t *alloc)
 {
-	init_irq_alloc_info(arg, NULL);
-	if (to_pci_dev(dev)->msix_enabled)
-		arg->type = X86_IRQ_ALLOC_TYPE_PCI_MSIX;
-	else
-		arg->type = X86_IRQ_ALLOC_TYPE_PCI_MSI;
+	struct msi_domain_info *info = domain->host_data;
 
-	return 0;
+	init_irq_alloc_info(alloc, NULL);
+
+	switch (info->bus_token) {
+	case DOMAIN_BUS_PCI_DEVICE_MSI:
+		alloc->type = X86_IRQ_ALLOC_TYPE_PCI_MSI;
+		return 0;
+	case DOMAIN_BUS_PCI_DEVICE_MSIX:
+		alloc->type = X86_IRQ_ALLOC_TYPE_PCI_MSIX;
+		return 0;
+	default:
+		return -EINVAL;
+	}
 }
-EXPORT_SYMBOL_GPL(pci_msi_prepare);
 
-static struct msi_domain_ops pci_msi_domain_ops = {
-	.msi_prepare	= pci_msi_prepare,
-};
+/**
+ * x86_init_dev_msi_info - Domain info setup for MSI domains
+ * @dev:		The device for which the domain should be created
+ * @domain:		The (root) domain providing this callback
+ * @real_parent:	The real parent domain of the to initialize domain
+ * @info:		The domain info for the to initialize domain
+ *
+ * This function is to be used for all types of MSI domains above the x86
+ * vector domain and any intermediates. The domain specific functionality
+ * is determined via the @real_parent.
+ */
+static bool x86_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
+				  struct irq_domain *real_parent, struct msi_domain_info *info)
+{
+	const struct msi_parent_ops *pops = real_parent->msi_parent_ops;
+
+	/* MSI parent domain specific settings */
+	switch (real_parent->bus_token) {
+	case DOMAIN_BUS_ANY:
+		/* Only the vector domain can have the ANY token */
+		if (WARN_ON_ONCE(domain != real_parent))
+			return false;
+		info->chip->irq_set_affinity = msi_set_affinity;
+		/* See msi_set_affinity() for the gory details */
+		info->flags |= MSI_FLAG_NOMASK_QUIRK;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return false;
+	}
+
+	/* Is the target supported? */
+	switch(info->bus_token) {
+	case DOMAIN_BUS_PCI_DEVICE_MSI:
+	case DOMAIN_BUS_PCI_DEVICE_MSIX:
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return false;
+	}
+
+	/*
+	 * Mask out the domain specific MSI feature flags which are not
+	 * supported by the real parent.
+	 */
+	info->flags			&= pops->supported_flags;
+	/* Enforce the required flags */
+	info->flags			|= X86_VECTOR_MSI_FLAGS_REQUIRED;
+
+	/* This is always invoked from the top level MSI domain! */
+	info->ops->msi_prepare		= x86_msi_prepare;
+
+	info->chip->irq_ack		= irq_chip_ack_parent;
+	info->chip->irq_retrigger	= irq_chip_retrigger_hierarchy;
+	info->chip->flags		|= IRQCHIP_SKIP_SET_WAKE |
+					   IRQCHIP_AFFINITY_PRE_STARTUP;
 
-static struct msi_domain_info pci_msi_domain_info = {
-	.flags		= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-			  MSI_FLAG_PCI_MSIX | MSI_FLAG_NOMASK_QUIRK,
-
-	.ops		= &pci_msi_domain_ops,
-	.chip		= &pci_msi_controller,
-	.handler	= handle_edge_irq,
-	.handler_name	= "edge",
+	info->handler			= handle_edge_irq;
+	info->handler_name		= "edge";
+
+	return true;
+}
+
+static const struct msi_parent_ops x86_vector_msi_parent_ops = {
+	.supported_flags	= X86_VECTOR_MSI_FLAGS_SUPPORTED,
+	.init_dev_msi_info	= x86_init_dev_msi_info,
 };
 
 struct irq_domain * __init native_create_pci_msi_domain(void)
 {
-	struct fwnode_handle *fn;
-	struct irq_domain *d;
-
 	if (disable_apic)
 		return NULL;
 
-	fn = irq_domain_alloc_named_fwnode("PCI-MSI");
-	if (!fn)
-		return NULL;
-
-	d = pci_msi_create_irq_domain(fn, &pci_msi_domain_info,
-				      x86_vector_domain);
-	if (!d) {
-		irq_domain_free_fwnode(fn);
-		pr_warn("Failed to initialize PCI-MSI irqdomain.\n");
-	}
-	return d;
+	x86_vector_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
+	x86_vector_domain->msi_parent_ops = &x86_vector_msi_parent_ops;
+	return x86_vector_domain;
 }
 
 void __init x86_create_pci_msi_domain(void)
@@ -210,7 +274,25 @@ void __init x86_create_pci_msi_domain(vo
 	x86_pci_msi_default_domain = x86_init.irqs.create_pci_msi_domain();
 }
 
+/* Keep around for hyperV and the remap code below */
+int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
+		    msi_alloc_info_t *arg)
+{
+	init_irq_alloc_info(arg, NULL);
+
+	if (to_pci_dev(dev)->msix_enabled)
+		arg->type = X86_IRQ_ALLOC_TYPE_PCI_MSIX;
+	else
+		arg->type = X86_IRQ_ALLOC_TYPE_PCI_MSI;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_msi_prepare);
+
 #ifdef CONFIG_IRQ_REMAP
+static struct msi_domain_ops pci_msi_domain_ops = {
+	.msi_prepare	= pci_msi_prepare,
+};
+
 static struct irq_chip pci_msi_ir_controller = {
 	.name			= "IR-PCI-MSI",
 	.irq_unmask		= pci_msi_unmask_irq,
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -812,7 +812,7 @@ static void
 amd_iommu_set_pci_msi_domain(struct device *dev, struct amd_iommu *iommu)
 {
 	if (!irq_remapping_enabled || !dev_is_pci(dev) ||
-	    pci_dev_has_special_msi_domain(to_pci_dev(dev)))
+	    !pci_dev_has_default_msi_parent_domain(to_pci_dev(dev)))
 		return;
 
 	dev_set_msi_domain(dev, iommu->msi_domain);
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1107,7 +1107,7 @@ static int reenable_irq_remapping(int ei
  */
 void intel_irq_remap_add_device(struct dmar_pci_notify_info *info)
 {
-	if (!irq_remapping_enabled || pci_dev_has_special_msi_domain(info->dev))
+	if (!irq_remapping_enabled || !pci_dev_has_default_msi_parent_domain(info->dev))
 		return;
 
 	dev_set_msi_domain(&info->dev->dev, map_dev_to_ir(info->dev));

