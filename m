Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649BA625BE6
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 14:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbiKKN6R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 08:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbiKKN5C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 08:57:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F92D701AD;
        Fri, 11 Nov 2022 05:55:19 -0800 (PST)
Message-ID: <20221111122015.865042356@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668174918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=KlmWSrD822PE2zOCQUPKNeyY1BUX75wWYBCy1LY/Ddo=;
        b=uOX0P7JY4JDZrhpHSa4G1IGNcgMKKOEotn3WaD7e11QG/6dfy0hAWm6VlqdtkgWxscy2j2
        vg8RZD2L7my03vFnseCP0zLzRVNFtmog03/OZWe8j+dCe3360GRdm7D7Ro+eFucXWe1cGt
        B1TbYs1Kn3thlD7fo2rbFIumODHXMAxjO1WybkfUU98oPmOGMfEeOcgke6duFUhpjCZKei
        OKjgabNkcGtNWaX2DdmfmLk843sFhP8s/1IrxWyfYUmW6Aek0x8nC5F0XV+DOF6doD4AUQ
        pelYpWuMy5qNR57TeK4q2muF+jZFU5A0mAMkigQCBXCSX0sc7psCpSz6yuOhBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668174918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=KlmWSrD822PE2zOCQUPKNeyY1BUX75wWYBCy1LY/Ddo=;
        b=IbSEAj1FCCNGEuhGibqJgPyd7PCqcVB4JEhzyivG+QUYDdfm3d+uCQ5/9YQCI9bNGUKlUx
        zljP/0HV6LO8O0BA==
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
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [patch 39/39] x86/apic: Remove X86_IRQ_ALLOC_CONTIGUOUS_VECTORS
References: <20221111120501.026511281@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:55:17 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that the PCI/MSI core code does early checking for multi-MSI support
X86_IRQ_ALLOC_CONTIGUOUS_VECTORS is not required anymore.

Remove the flag and rely on MSI_FLAG_MULTI_PCI_MSI.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/irqdomain.h    |    4 +---
 arch/x86/kernel/apic/msi.c          |    6 ++----
 arch/x86/kernel/apic/vector.c       |    4 ----
 drivers/iommu/amd/iommu.c           |    7 -------
 drivers/iommu/intel/irq_remapping.c |    7 -------
 drivers/pci/controller/pci-hyperv.c |   15 +--------------
 6 files changed, 4 insertions(+), 39 deletions(-)

--- a/arch/x86/include/asm/irqdomain.h
+++ b/arch/x86/include/asm/irqdomain.h
@@ -7,9 +7,7 @@
 
 #ifdef CONFIG_X86_LOCAL_APIC
 enum {
-	/* Allocate contiguous CPU vectors */
-	X86_IRQ_ALLOC_CONTIGUOUS_VECTORS		= 0x1,
-	X86_IRQ_ALLOC_LEGACY				= 0x2,
+	X86_IRQ_ALLOC_LEGACY				= 0x1,
 };
 
 extern int x86_fwspec_is_ioapic(struct irq_fwspec *fwspec);
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -161,12 +161,10 @@ int pci_msi_prepare(struct irq_domain *d
 		    msi_alloc_info_t *arg)
 {
 	init_irq_alloc_info(arg, NULL);
-	if (to_pci_dev(dev)->msix_enabled) {
+	if (to_pci_dev(dev)->msix_enabled)
 		arg->type = X86_IRQ_ALLOC_TYPE_PCI_MSIX;
-	} else {
+	else
 		arg->type = X86_IRQ_ALLOC_TYPE_PCI_MSI;
-		arg->flags |= X86_IRQ_ALLOC_CONTIGUOUS_VECTORS;
-	}
 
 	return 0;
 }
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -539,10 +539,6 @@ static int x86_vector_alloc_irqs(struct
 	if (disable_apic)
 		return -ENXIO;
 
-	/* Currently vector allocator can't guarantee contiguous allocations */
-	if ((info->flags & X86_IRQ_ALLOC_CONTIGUOUS_VECTORS) && nr_irqs > 1)
-		return -ENOSYS;
-
 	/*
 	 * Catch any attempt to touch the cascade interrupt on a PIC
 	 * equipped system.
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3297,13 +3297,6 @@ static int irq_remapping_alloc(struct ir
 	if (nr_irqs > 1 && info->type != X86_IRQ_ALLOC_TYPE_PCI_MSI)
 		return -EINVAL;
 
-	/*
-	 * With IRQ remapping enabled, don't need contiguous CPU vectors
-	 * to support multiple MSI interrupts.
-	 */
-	if (info->type == X86_IRQ_ALLOC_TYPE_PCI_MSI)
-		info->flags &= ~X86_IRQ_ALLOC_CONTIGUOUS_VECTORS;
-
 	sbdf = get_devid(info);
 	if (sbdf < 0)
 		return -EINVAL;
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1337,13 +1337,6 @@ static int intel_irq_remapping_alloc(str
 	if (nr_irqs > 1 && info->type != X86_IRQ_ALLOC_TYPE_PCI_MSI)
 		return -EINVAL;
 
-	/*
-	 * With IRQ remapping enabled, don't need contiguous CPU vectors
-	 * to support multiple MSI interrupts.
-	 */
-	if (info->type == X86_IRQ_ALLOC_TYPE_PCI_MSI)
-		info->flags &= ~X86_IRQ_ALLOC_CONTIGUOUS_VECTORS;
-
 	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
 	if (ret < 0)
 		return ret;
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -611,20 +611,7 @@ static unsigned int hv_msi_get_int_vecto
 	return cfg->vector;
 }
 
-static int hv_msi_prepare(struct irq_domain *domain, struct device *dev,
-			  int nvec, msi_alloc_info_t *info)
-{
-	int ret = pci_msi_prepare(domain, dev, nvec, info);
-
-	/*
-	 * By using the interrupt remapper in the hypervisor IOMMU, contiguous
-	 * CPU vectors is not needed for multi-MSI
-	 */
-	if (info->type == X86_IRQ_ALLOC_TYPE_PCI_MSI)
-		info->flags &= ~X86_IRQ_ALLOC_CONTIGUOUS_VECTORS;
-
-	return ret;
-}
+#define hv_msi_prepare		pci_msi_prepare
 
 /**
  * hv_arch_irq_unmask() - "Unmask" the IRQ by setting its current

