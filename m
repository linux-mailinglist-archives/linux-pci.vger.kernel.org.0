Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE74625C6F
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 15:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbiKKOGp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 09:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234421AbiKKOGV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 09:06:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C59698BAB;
        Fri, 11 Nov 2022 05:59:39 -0800 (PST)
Message-ID: <20221111135206.176832734@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668175117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=5F8g3aU97Z6Kyag3K9E0SkLjFZeBlcTh6td6sXBxDio=;
        b=hCvxiEaR/ftuotSJ0rYpX9FRCRgNZLSo95zdWBQdsnkEYM1gPKuvor7QttQXEhc3wEUl2J
        tCgESho46z75o1KylEAfxB0NtqE77Zv3BQYrTzBaRV0oUWQX7kxYjRBUlIIdvnKvt9rGK9
        uNgrjCFEo8DgwHtVpvdBjp6ddRr4NIJsRYgyD9b4912zEy5SGflKmDZfz8sQvhA0mA/mmL
        8+k3GlgGYmjazzPD72KAwhHoeDUSv2lKu6MROuTAzwNjR4WPsyaP/cPYNH9rxfXqk035AD
        YU2wQbsaRczXTO8MmEEGHw+5t3RgxOlMlYCicHQEvBO8X4W36mVtLxSW36KIHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668175117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=5F8g3aU97Z6Kyag3K9E0SkLjFZeBlcTh6td6sXBxDio=;
        b=bQm0H15x7Ua74erk+n6WWSeiGvKswNMLCGweks81shRQ5KQt3rLPVxQv+pjfAIRmc2p7kU
        g+v+hc98ICgkbtAw==
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
Subject: [patch 16/33] iommu/amd: Switch to MSI base domains
References: <20221111133158.196269823@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:58:36 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove the global PCI/MSI irqdomain implementation and provide the required
MSI parent ops so the PCI/MSI code can detect the new parent and setup per
device domains.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/msi.c          |    1 +
 drivers/iommu/amd/amd_iommu_types.h |    1 -
 drivers/iommu/amd/iommu.c           |   19 +++++++++++++------
 include/linux/irqdomain_defs.h      |    1 +
 4 files changed, 15 insertions(+), 7 deletions(-)

--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -218,6 +218,7 @@ static bool x86_init_dev_msi_info(struct
 		info->flags |= MSI_FLAG_NOMASK_QUIRK;
 		break;
 	case DOMAIN_BUS_DMAR:
+	case DOMAIN_BUS_AMDVI:
 		break;
 	default:
 		WARN_ON_ONCE(1);
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -734,7 +734,6 @@ struct amd_iommu {
 	u8 max_counters;
 #ifdef CONFIG_IRQ_REMAP
 	struct irq_domain *ir_domain;
-	struct irq_domain *msi_domain;
 
 	struct amd_irte_ops *irte_ops;
 #endif
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -815,7 +815,7 @@ amd_iommu_set_pci_msi_domain(struct devi
 	    !pci_dev_has_default_msi_parent_domain(to_pci_dev(dev)))
 		return;
 
-	dev_set_msi_domain(dev, iommu->msi_domain);
+	dev_set_msi_domain(dev, iommu->ir_domain);
 }
 
 #else /* CONFIG_IRQ_REMAP */
@@ -3648,6 +3648,12 @@ static struct irq_chip amd_ir_chip = {
 	.irq_compose_msi_msg	= ir_compose_msi_msg,
 };
 
+static const struct msi_parent_ops amdvi_msi_parent_ops = {
+	.supported_flags	= X86_VECTOR_MSI_FLAGS_SUPPORTED | MSI_FLAG_MULTI_PCI_MSI,
+	.prefix			= "IR-",
+	.init_dev_msi_info	= msi_parent_init_dev_msi_info,
+};
+
 int amd_iommu_create_irq_domain(struct amd_iommu *iommu)
 {
 	struct fwnode_handle *fn;
@@ -3655,16 +3661,17 @@ int amd_iommu_create_irq_domain(struct a
 	fn = irq_domain_alloc_named_id_fwnode("AMD-IR", iommu->index);
 	if (!fn)
 		return -ENOMEM;
-	iommu->ir_domain = irq_domain_create_tree(fn, &amd_ir_domain_ops, iommu);
+	iommu->ir_domain = irq_domain_create_hierarchy(arch_get_ir_parent_domain(), 0, 0,
+						       fn, &amd_ir_domain_ops, iommu);
 	if (!iommu->ir_domain) {
 		irq_domain_free_fwnode(fn);
 		return -ENOMEM;
 	}
 
-	iommu->ir_domain->parent = arch_get_ir_parent_domain();
-	iommu->msi_domain = arch_create_remap_msi_irq_domain(iommu->ir_domain,
-							     "AMD-IR-MSI",
-							     iommu->index);
+	irq_domain_update_bus_token(iommu->ir_domain,  DOMAIN_BUS_AMDVI);
+	iommu->ir_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
+	iommu->ir_domain->msi_parent_ops = &amdvi_msi_parent_ops;
+
 	return 0;
 }
 
--- a/include/linux/irqdomain_defs.h
+++ b/include/linux/irqdomain_defs.h
@@ -24,6 +24,7 @@ enum irq_domain_bus_token {
 	DOMAIN_BUS_PCI_DEVICE_MSI,
 	DOMAIN_BUS_PCI_DEVICE_MSIX,
 	DOMAIN_BUS_DMAR,
+	DOMAIN_BUS_AMDVI,
 };
 
 #endif /* _LINUX_IRQDOMAIN_DEFS_H */

