Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0129625C7B
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 15:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbiKKOHy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 09:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbiKKOHM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 09:07:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2272787B6;
        Fri, 11 Nov 2022 06:00:01 -0800 (PST)
Message-ID: <20221111135206.120140010@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668175115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=OWDR1HVKygNBsw9mLHuKFZNGcf87XagJ2m0BnhitI40=;
        b=udW9IcJSFabEoepM5gdIGS+ELCFJpYwYDNCssvx+nI0nvdJGy25WrJiUwYASxLAFFrUuOJ
        A/Vgdq5/GV5MVBrg37/Sw3sBoauwnORcUKhPcGJYUMPCWI0KC6XDZNDKPXSK0jIqp0Dvw0
        GZsJkaz2mN01lq+L/lIhzibBtcvFd4+zfsLJ/JTey0/omCuzCzpA9ZESi1FAEcRDgr4Weg
        k/4ES9F97lR2YXh+9Frq2PEyqX4LF9joqz0DZkFjno8dOWbyH/d4HPOdHAh9fuDeUP/xtr
        1/aK2jG1FoECQEaT+8s8NS66qVmYEkjI19EWEBZjt0e8gBgOoTmzbJKXbghwvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668175115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=OWDR1HVKygNBsw9mLHuKFZNGcf87XagJ2m0BnhitI40=;
        b=fB9FMLcPFvfiDKAyWIhZXWOc2YDbRC01dngkYeJLXv0aEX5h/JYTJD6MhnK1828s5zqzfe
        bGoNnK3zCiq+MRDw==
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
Subject: [patch 15/33] iommu/vt-d: Switch to MSI parent domains
References: <20221111133158.196269823@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:58:35 +0100 (CET)
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
 arch/x86/kernel/apic/msi.c          |    2 ++
 drivers/iommu/intel/iommu.h         |    1 -
 drivers/iommu/intel/irq_remapping.c |   27 ++++++++++++---------------
 include/linux/irqdomain_defs.h      |    1 +
 4 files changed, 15 insertions(+), 16 deletions(-)

--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -217,6 +217,8 @@ static bool x86_init_dev_msi_info(struct
 		/* See msi_set_affinity() for the gory details */
 		info->flags |= MSI_FLAG_NOMASK_QUIRK;
 		break;
+	case DOMAIN_BUS_DMAR:
+		break;
 	default:
 		WARN_ON_ONCE(1);
 		return false;
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -600,7 +600,6 @@ struct intel_iommu {
 #ifdef CONFIG_IRQ_REMAP
 	struct ir_table *ir_table;	/* Interrupt remapping info */
 	struct irq_domain *ir_domain;
-	struct irq_domain *ir_msi_domain;
 #endif
 	struct iommu_device iommu;  /* IOMMU core code handle */
 	int		node;
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -82,6 +82,7 @@ static const struct irq_domain_ops intel
 
 static void iommu_disable_irq_remapping(struct intel_iommu *iommu);
 static int __init parse_ioapics_under_ir(void);
+static const struct msi_parent_ops dmar_msi_parent_ops;
 
 static bool ir_pre_enabled(struct intel_iommu *iommu)
 {
@@ -230,7 +231,7 @@ static struct irq_domain *map_dev_to_ir(
 {
 	struct dmar_drhd_unit *drhd = dmar_find_matched_drhd_unit(dev);
 
-	return drhd ? drhd->iommu->ir_msi_domain : NULL;
+	return drhd ? drhd->iommu->ir_domain : NULL;
 }
 
 static int clear_entries(struct irq_2_iommu *irq_iommu)
@@ -573,10 +574,10 @@ static int intel_setup_irq_remapping(str
 		pr_err("IR%d: failed to allocate irqdomain\n", iommu->seq_id);
 		goto out_free_fwnode;
 	}
-	iommu->ir_msi_domain =
-		arch_create_remap_msi_irq_domain(iommu->ir_domain,
-						 "INTEL-IR-MSI",
-						 iommu->seq_id);
+
+	irq_domain_update_bus_token(iommu->ir_domain,  DOMAIN_BUS_DMAR);
+	iommu->ir_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
+	iommu->ir_domain->msi_parent_ops = &dmar_msi_parent_ops;
 
 	ir_table->base = page_address(pages);
 	ir_table->bitmap = bitmap;
@@ -620,9 +621,6 @@ static int intel_setup_irq_remapping(str
 	return 0;
 
 out_free_ir_domain:
-	if (iommu->ir_msi_domain)
-		irq_domain_remove(iommu->ir_msi_domain);
-	iommu->ir_msi_domain = NULL;
 	irq_domain_remove(iommu->ir_domain);
 	iommu->ir_domain = NULL;
 out_free_fwnode:
@@ -644,13 +642,6 @@ static void intel_teardown_irq_remapping
 	struct fwnode_handle *fn;
 
 	if (iommu && iommu->ir_table) {
-		if (iommu->ir_msi_domain) {
-			fn = iommu->ir_msi_domain->fwnode;
-
-			irq_domain_remove(iommu->ir_msi_domain);
-			irq_domain_free_fwnode(fn);
-			iommu->ir_msi_domain = NULL;
-		}
 		if (iommu->ir_domain) {
 			fn = iommu->ir_domain->fwnode;
 
@@ -1437,6 +1428,12 @@ static const struct irq_domain_ops intel
 	.deactivate = intel_irq_remapping_deactivate,
 };
 
+static const struct msi_parent_ops dmar_msi_parent_ops = {
+	.supported_flags	= X86_VECTOR_MSI_FLAGS_SUPPORTED | MSI_FLAG_MULTI_PCI_MSI,
+	.prefix			= "IR-",
+	.init_dev_msi_info	= msi_parent_init_dev_msi_info,
+};
+
 /*
  * Support of Interrupt Remapping Unit Hotplug
  */
--- a/include/linux/irqdomain_defs.h
+++ b/include/linux/irqdomain_defs.h
@@ -23,6 +23,7 @@ enum irq_domain_bus_token {
 	DOMAIN_BUS_VMD_MSI,
 	DOMAIN_BUS_PCI_DEVICE_MSI,
 	DOMAIN_BUS_PCI_DEVICE_MSIX,
+	DOMAIN_BUS_DMAR,
 };
 
 #endif /* _LINUX_IRQDOMAIN_DEFS_H */

