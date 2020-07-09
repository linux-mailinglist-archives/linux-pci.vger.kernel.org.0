Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68899219C9B
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jul 2020 11:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgGIJxK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jul 2020 05:53:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35574 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgGIJxK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jul 2020 05:53:10 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594288387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wXQWUt/vJLbaOSEl0emlS9+y9HWwosshJi8IFtkfu2g=;
        b=Q+C3poBYxLRrnuc3oxxE56QFKZXK4oyYtUZ7C0/dl9Snn2u9g+X9pv3xCeCLJvUH0fG7ky
        CZyhqcp5W7hXxFNyz/GtZX+VO30RRi40dDhx8RZ0pvlOHRarlUSjkf7PRvIKHgE0ageTQz
        JxE9PJzYozawpgpG8nREYLaaLHtpKzsZ1JBYbqYoYEsexmTHBoA6IICzOHOFhBbJh0Yftp
        YajQDDsX1/OBZq6ohDQdwB1zan7kdgvYgsF+xMyqTWRx7qvMoH3d4J/zj16/OwpqjwIsw9
        EbQEDT2wWGYBjLo8p3LumwhzZa3G/j1+/MzBTZeHfd83R1gRgZ8iMCzIIg7Wzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594288387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wXQWUt/vJLbaOSEl0emlS9+y9HWwosshJi8IFtkfu2g=;
        b=NCJzBcBd1ZHKjOeGbKxxR0NbAHCFvP+GJYtgjNfSolyTog2mh89WFBBaXbg9i/qqahdvkm
        UOXZEzWWL15expCA==
To:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zyngier <maz@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org,
        Sushma Kalakota <sushmax.kalakota@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] irqdomain/treewide: Keep firmware node unconditionally allocated
In-Reply-To: <20200706154410.GA117493@bjorn-Precision-5520>
References: <20200706154410.GA117493@bjorn-Precision-5520>
Date:   Thu, 09 Jul 2020 11:53:06 +0200
Message-ID: <873661qakd.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Quite some non OF/ACPI users of irqdomains allocate firmware nodes of type
IRQCHIP_FWNODE_NAMED or IRQCHIP_FWNODE_NAMED_ID and free them right after
creating the irqdomain. The only purpose of these FW nodes is to convey
name information. When this was introduced the core code did not store the
pointer to the node in the irqdomain. A recent change stored the firmware
node pointer in irqdomain for other reasons and missed to notice that the
usage sites which do the alloc_fwnode/create_domain/free_fwnode sequence
are broken by this. Storing a dangling pointer is dangerous itself, but in
case that the domain is destroyed later on this leads to a double free.

Remove the freeing of the firmware node after creating the irqdomain from
all affected call sites to cure this.

Fixes: 711419e504eb ("irqdomain: Add the missing assignment of domain->fwnode for named fwnode")
Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org

---
 arch/mips/pci/pci-xtalk-bridge.c    |    5 +++--
 arch/x86/kernel/apic/io_apic.c      |   10 +++++-----
 arch/x86/kernel/apic/msi.c          |   18 ++++++++++++------
 arch/x86/kernel/apic/vector.c       |    1 -
 arch/x86/platform/uv/uv_irq.c       |    3 ++-
 drivers/iommu/amd/iommu.c           |    5 +++--
 drivers/iommu/hyperv-iommu.c        |    5 ++++-
 drivers/iommu/intel/irq_remapping.c |    2 +-
 drivers/mfd/ioc3.c                  |    5 +++--
 drivers/pci/controller/vmd.c        |    5 +++--
 10 files changed, 36 insertions(+), 23 deletions(-)

--- a/arch/mips/pci/pci-xtalk-bridge.c
+++ b/arch/mips/pci/pci-xtalk-bridge.c
@@ -627,9 +627,10 @@ static int bridge_probe(struct platform_
 		return -ENOMEM;
 	domain = irq_domain_create_hierarchy(parent, 0, 8, fn,
 					     &bridge_domain_ops, NULL);
-	irq_domain_free_fwnode(fn);
-	if (!domain)
+	if (!domain) {
+		irq_domain_free_fwnode(fn);
 		return -ENOMEM;
+	}
 
 	pci_set_flags(PCI_PROBE_ONLY);
 
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2316,12 +2316,12 @@ static int mp_irqdomain_create(int ioapi
 	ip->irqdomain = irq_domain_create_linear(fn, hwirqs, cfg->ops,
 						 (void *)(long)ioapic);
 
-	/* Release fw handle if it was allocated above */
-	if (!cfg->dev)
-		irq_domain_free_fwnode(fn);
-
-	if (!ip->irqdomain)
+	if (!ip->irqdomain) {
+		/* Release fw handle if it was allocated above */
+		if (!cfg->dev)
+			irq_domain_free_fwnode(fn);
 		return -ENOMEM;
+	}
 
 	ip->irqdomain->parent = parent;
 
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -263,12 +263,13 @@ void __init arch_init_msi_domain(struct
 		msi_default_domain =
 			pci_msi_create_irq_domain(fn, &pci_msi_domain_info,
 						  parent);
-		irq_domain_free_fwnode(fn);
 	}
-	if (!msi_default_domain)
+	if (!msi_default_domain) {
+		irq_domain_free_fwnode(fn);
 		pr_warn("failed to initialize irqdomain for MSI/MSI-x.\n");
-	else
+	} else {
 		msi_default_domain->flags |= IRQ_DOMAIN_MSI_NOMASK_QUIRK;
+	}
 }
 
 #ifdef CONFIG_IRQ_REMAP
@@ -301,7 +302,8 @@ struct irq_domain *arch_create_remap_msi
 	if (!fn)
 		return NULL;
 	d = pci_msi_create_irq_domain(fn, &pci_msi_ir_domain_info, parent);
-	irq_domain_free_fwnode(fn);
+	if (!d)
+		irq_domain_free_fwnode(fn);
 	return d;
 }
 #endif
@@ -364,7 +366,8 @@ static struct irq_domain *dmar_get_irq_d
 	if (fn) {
 		dmar_domain = msi_create_irq_domain(fn, &dmar_msi_domain_info,
 						    x86_vector_domain);
-		irq_domain_free_fwnode(fn);
+		if (!dmar_domain)
+			irq_domain_free_fwnode(fn);
 	}
 out:
 	mutex_unlock(&dmar_lock);
@@ -489,7 +492,10 @@ struct irq_domain *hpet_create_irq_domai
 	}
 
 	d = msi_create_irq_domain(fn, domain_info, parent);
-	irq_domain_free_fwnode(fn);
+	if (!d) {
+		irq_domain_free_fwnode(fn);
+		kfree(domain_info);
+	}
 	return d;
 }
 
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -709,7 +709,6 @@ int __init arch_early_irq_init(void)
 	x86_vector_domain = irq_domain_create_tree(fn, &x86_vector_domain_ops,
 						   NULL);
 	BUG_ON(x86_vector_domain == NULL);
-	irq_domain_free_fwnode(fn);
 	irq_set_default_host(x86_vector_domain);
 
 	arch_init_msi_domain(x86_vector_domain);
--- a/arch/x86/platform/uv/uv_irq.c
+++ b/arch/x86/platform/uv/uv_irq.c
@@ -167,9 +167,10 @@ static struct irq_domain *uv_get_irq_dom
 		goto out;
 
 	uv_domain = irq_domain_create_tree(fn, &uv_domain_ops, NULL);
-	irq_domain_free_fwnode(fn);
 	if (uv_domain)
 		uv_domain->parent = x86_vector_domain;
+	else
+		irq_domain_free_fwnode(fn);
 out:
 	mutex_unlock(&uv_lock);
 
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3985,9 +3985,10 @@ int amd_iommu_create_irq_domain(struct a
 	if (!fn)
 		return -ENOMEM;
 	iommu->ir_domain = irq_domain_create_tree(fn, &amd_ir_domain_ops, iommu);
-	irq_domain_free_fwnode(fn);
-	if (!iommu->ir_domain)
+	if (!iommu->ir_domain) {
+		irq_domain_free_fwnode(fn);
 		return -ENOMEM;
+	}
 
 	iommu->ir_domain->parent = arch_get_ir_parent_domain();
 	iommu->msi_domain = arch_create_remap_msi_irq_domain(iommu->ir_domain,
--- a/drivers/iommu/hyperv-iommu.c
+++ b/drivers/iommu/hyperv-iommu.c
@@ -155,7 +155,10 @@ static int __init hyperv_prepare_irq_rem
 				0, IOAPIC_REMAPPING_ENTRY, fn,
 				&hyperv_ir_domain_ops, NULL);
 
-	irq_domain_free_fwnode(fn);
+	if (!ioapic_ir_domain) {
+		irq_domain_free_fwnode(fn);
+		return -ENOMEM;
+	}
 
 	/*
 	 * Hyper-V doesn't provide irq remapping function for
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -563,8 +563,8 @@ static int intel_setup_irq_remapping(str
 					    0, INTR_REMAP_TABLE_ENTRIES,
 					    fn, &intel_ir_domain_ops,
 					    iommu);
-	irq_domain_free_fwnode(fn);
 	if (!iommu->ir_domain) {
+		irq_domain_free_fwnode(fn);
 		pr_err("IR%d: failed to allocate irqdomain\n", iommu->seq_id);
 		goto out_free_bitmap;
 	}
--- a/drivers/mfd/ioc3.c
+++ b/drivers/mfd/ioc3.c
@@ -142,10 +142,11 @@ static int ioc3_irq_domain_setup(struct
 		goto err;
 
 	domain = irq_domain_create_linear(fn, 24, &ioc3_irq_domain_ops, ipd);
-	if (!domain)
+	if (!domain) {
+		irq_domain_free_fwnode(fn);
 		goto err;
+	}
 
-	irq_domain_free_fwnode(fn);
 	ipd->domain = domain;
 
 	irq_set_chained_handler_and_data(irq, ioc3_irq_handler, domain);
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -546,9 +546,10 @@ static int vmd_enable_domain(struct vmd_
 
 	vmd->irq_domain = pci_msi_create_irq_domain(fn, &vmd_msi_domain_info,
 						    x86_vector_domain);
-	irq_domain_free_fwnode(fn);
-	if (!vmd->irq_domain)
+	if (!vmd->irq_domain) {
+		irq_domain_free_fwnode(fn);
 		return -ENODEV;
+	}
 
 	pci_add_resource(&resources, &vmd->resources[0]);
 	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
