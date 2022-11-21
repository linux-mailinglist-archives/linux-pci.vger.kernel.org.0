Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A0F632651
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbiKUOjK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbiKUOiJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:38:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E347F942D5;
        Mon, 21 Nov 2022 06:38:08 -0800 (PST)
Message-ID: <20221121091327.434824195@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=T4PJKhvy3BXQPG8m3pythcilM8fEjCtnrP9dFwguEN8=;
        b=RtPrEADLQ4F09PZEf7MRYrk1DKs2OkxJk+s5MlC4pyGrdJej891wfDCd/fORtsNyjHvFQP
        RF+zvuDHRAxMziDZ34F3pVHKeRVjp3Cvs4LFBD8gG8xekg1V7XgG7EfuZe47+uCgM7lX+7
        3o+9jAaM9ZMm+cSIkIyxQn3tuIl813XQY0dgkrh9CUS3HLkPWyvQS7U2NJdjE7BzVdyt3B
        SZyjsRFiPdcZVT6b/EjzhbI1/vUGwdTQVWNef/ehw/+VJXu7VmXhE5ziy8WO/ttIGMmqiV
        YpX0XjOvpRmltFPubbY0V2LzT8Kan8XqOnFCui/kVnm5wSPfpdjPt3u+HnDSnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=T4PJKhvy3BXQPG8m3pythcilM8fEjCtnrP9dFwguEN8=;
        b=aWd8PCCvc63ClVG88p5VQoROv7Oe2rDRMPbz7IjkMKsR8wjbom7ao8Gw5pclxgYa9dt8x1
        Z4aYP3crdT1MP3BA==
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
Subject: [patch V2 17/33] x86/apic/msi: Remove arch_create_remap_msi_irq_domain()
References: <20221121083657.157152924@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:38:07 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

and related code which is not longer required now that the interrupt remap
code has been converted to MSI parent domains.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/irq_remapping.h |    4 ---
 arch/x86/kernel/apic/msi.c           |   42 -----------------------------------
 2 files changed, 1 insertion(+), 45 deletions(-)

--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -44,10 +44,6 @@ extern int irq_remapping_reenable(int);
 extern int irq_remap_enable_fault_handling(void);
 extern void panic_if_irq_remap(const char *msg);
 
-/* Create PCI MSI/MSIx irqdomain, use @parent as the parent irqdomain. */
-extern struct irq_domain *
-arch_create_remap_msi_irq_domain(struct irq_domain *par, const char *n, int id);
-
 /* Get parent irqdomain for interrupt remapping irqdomain */
 static inline struct irq_domain *arch_get_ir_parent_domain(void)
 {
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -277,7 +277,7 @@ void __init x86_create_pci_msi_domain(vo
 	x86_pci_msi_default_domain = x86_init.irqs.create_pci_msi_domain();
 }
 
-/* Keep around for hyperV and the remap code below */
+/* Keep around for hyperV */
 int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
 		    msi_alloc_info_t *arg)
 {
@@ -291,46 +291,6 @@ int pci_msi_prepare(struct irq_domain *d
 }
 EXPORT_SYMBOL_GPL(pci_msi_prepare);
 
-#ifdef CONFIG_IRQ_REMAP
-static struct msi_domain_ops pci_msi_domain_ops = {
-	.msi_prepare	= pci_msi_prepare,
-};
-
-static struct irq_chip pci_msi_ir_controller = {
-	.name			= "IR-PCI-MSI",
-	.irq_unmask		= pci_msi_unmask_irq,
-	.irq_mask		= pci_msi_mask_irq,
-	.irq_ack		= irq_chip_ack_parent,
-	.irq_retrigger		= irq_chip_retrigger_hierarchy,
-	.flags			= IRQCHIP_SKIP_SET_WAKE |
-				  IRQCHIP_AFFINITY_PRE_STARTUP,
-};
-
-static struct msi_domain_info pci_msi_ir_domain_info = {
-	.flags		= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-			  MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX,
-	.ops		= &pci_msi_domain_ops,
-	.chip		= &pci_msi_ir_controller,
-	.handler	= handle_edge_irq,
-	.handler_name	= "edge",
-};
-
-struct irq_domain *arch_create_remap_msi_irq_domain(struct irq_domain *parent,
-						    const char *name, int id)
-{
-	struct fwnode_handle *fn;
-	struct irq_domain *d;
-
-	fn = irq_domain_alloc_named_id_fwnode(name, id);
-	if (!fn)
-		return NULL;
-	d = pci_msi_create_irq_domain(fn, &pci_msi_ir_domain_info, parent);
-	if (!d)
-		irq_domain_free_fwnode(fn);
-	return d;
-}
-#endif
-
 #ifdef CONFIG_DMAR_TABLE
 /*
  * The Intel IOMMU (ab)uses the high bits of the MSI address to contain the

