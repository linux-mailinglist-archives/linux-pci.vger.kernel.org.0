Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D26A625C70
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 15:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbiKKOGq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 09:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbiKKOGV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 09:06:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6D898BAC;
        Fri, 11 Nov 2022 05:59:40 -0800 (PST)
Message-ID: <20221111135206.234039487@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668175118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=T4PJKhvy3BXQPG8m3pythcilM8fEjCtnrP9dFwguEN8=;
        b=ByEzPpj3u5GaTiyl8vMIt8mWZRu1Hka2oeuFxL2Q1lchVX8Mx4dQ2SzKafkzmH+zsM+Qlk
        nAtYQrYOox+JvJMdZB1QR8O56FDBIWvc/cojPiLLAHn1cBnu9D9UFK0Lp7ql89aDxFAjze
        4tSMLVG8AuH4e7JHrw0zALZv7AG+jeuIcb8JldLuwDM++zqbMWElF1PID/02Be4ER2PKWc
        Sev+10xQG6KouDmvo8ag+lePGOX3tlj6P7oGxkXzGOEZT7tulUkanqdQDDCif7Eksl7MhY
        bbyj+VmI1bDfJOfPhaErlKDt4bRKpawwZPiDdP0VRCDD8knEAxH8e2euozfs2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668175118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=T4PJKhvy3BXQPG8m3pythcilM8fEjCtnrP9dFwguEN8=;
        b=EUvCzVBrW/Qy+f75degia4Cea00w4kFssriQYGeh5YjujfOl/ntMycvHFMjlJi1Snqznbs
        zud4H5DChs+cP6Aw==
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
Subject: [patch 17/33] x86/apic/msi: Remove arch_create_remap_msi_irq_domain()
References: <20221111133158.196269823@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:58:38 +0100 (CET)
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

