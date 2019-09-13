Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52620B1704
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2019 03:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbfIMBPG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Sep 2019 21:15:06 -0400
Received: from mga12.intel.com ([192.55.52.136]:29376 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728507AbfIMBOr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Sep 2019 21:14:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2019 18:14:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="197403708"
Received: from megha-z97x-ud7-th.sc.intel.com ([143.183.85.162])
  by orsmga002.jf.intel.com with ESMTP; 12 Sep 2019 18:14:46 -0700
From:   Megha Dey <megha.dey@linux.intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pci@vger.kernel.org, maz@kernel.org, bhelgaas@google.com,
        rafael@kernel.org, gregkh@linuxfoundation.org, tglx@linutronix.de,
        hpa@zytor.com, alex.williamson@redhat.com, jgg@mellanox.com
Cc:     ashok.raj@intel.com, megha.dey@intel.com, jacob.jun.pan@intel.com,
        Megha Dey <megha.dey@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Sanjay Kumar <sanjay.k.kumar@intel.com>
Subject: [RFC V1 4/7] irq_remapping: New interfaces to support IMS irqdomain
Date:   Thu, 12 Sep 2019 18:32:05 -0700
Message-Id: <1568338328-22458-5-git-send-email-megha.dey@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568338328-22458-1-git-send-email-megha.dey@linux.intel.com>
References: <1568338328-22458-1-git-send-email-megha.dey@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Introduce new interfaces for interrupt remapping drivers to support
IMS irqdomains:

irq_remapping_get_ims_irq_domain(): get the IMS irqdomain for an IRQ
allocation. We must build one IMS irqdomain for each interrupt remapping
unit. The driver calls this interface to get the IMS irqdomain associated
with an IR irqdomain which manages the devices.

Architecture specific hooks:
arch_create_ims_irq_domain(): create an IMS irqdomain associated with the
interrupt remapping unit.

We also add following callback into struct irq_remap_ops:
struct irq_domain *(*get_ims_irq_domain)(struct irq_alloc_info *);

Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Megha Dey <megha.dey@linux.intel.com>
---
 arch/x86/include/asm/irq_remapping.h | 13 +++++++++++++
 drivers/iommu/intel_irq_remapping.c  | 30 ++++++++++++++++++++++++++++++
 drivers/iommu/irq_remapping.c        |  9 +++++++++
 drivers/iommu/irq_remapping.h        |  3 +++
 include/linux/intel-iommu.h          |  1 +
 5 files changed, 56 insertions(+)

diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_remapping.h
index 4bc985f..a735507 100644
--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -48,11 +48,18 @@ extern struct irq_domain *
 irq_remapping_get_ir_irq_domain(struct irq_alloc_info *info);
 extern struct irq_domain *
 irq_remapping_get_irq_domain(struct irq_alloc_info *info);
+extern struct irq_domain *
+irq_remapping_get_ims_irq_domain(struct irq_alloc_info *info);
 
 /* Create PCI MSI/MSIx irqdomain, use @parent as the parent irqdomain. */
 extern struct irq_domain *
 arch_create_remap_msi_irq_domain(struct irq_domain *par, const char *n, int id);
 
+/* Create IMS irqdomain, use @parent as the parent irqdomain. */
+#ifdef CONFIG_MSI_IMS
+extern struct irq_domain *arch_create_ims_irq_domain(struct irq_domain *parent);
+#endif
+
 /* Get parent irqdomain for interrupt remapping irqdomain */
 static inline struct irq_domain *arch_get_ir_parent_domain(void)
 {
@@ -85,5 +92,11 @@ irq_remapping_get_irq_domain(struct irq_alloc_info *info)
 	return NULL;
 }
 
+static inline struct irq_domain *
+irq_remapping_get_ims_irq_domain(struct irq_alloc_info *info)
+{
+	return NULL;
+}
+
 #endif /* CONFIG_IRQ_REMAP */
 #endif /* __X86_IRQ_REMAPPING_H */
diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 4786ca0..3c0c0cb 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -573,6 +573,10 @@ static int intel_setup_irq_remapping(struct intel_iommu *iommu)
 						 "INTEL-IR-MSI",
 						 iommu->seq_id);
 
+#ifdef CONFIG_MSI_IMS
+	iommu->ir_ims_domain = arch_create_ims_irq_domain(iommu->ir_domain);
+#endif
+
 	ir_table->base = page_address(pages);
 	ir_table->bitmap = bitmap;
 	iommu->ir_table = ir_table;
@@ -633,6 +637,10 @@ static void intel_teardown_irq_remapping(struct intel_iommu *iommu)
 			irq_domain_remove(iommu->ir_msi_domain);
 			iommu->ir_msi_domain = NULL;
 		}
+		if (iommu->ir_ims_domain) {
+			irq_domain_remove(iommu->ir_ims_domain);
+			iommu->ir_ims_domain = NULL;
+		}
 		if (iommu->ir_domain) {
 			irq_domain_remove(iommu->ir_domain);
 			iommu->ir_domain = NULL;
@@ -1139,6 +1147,27 @@ static struct irq_domain *intel_get_irq_domain(struct irq_alloc_info *info)
 	return NULL;
 }
 
+static struct irq_domain *intel_get_ims_irq_domain(struct irq_alloc_info *info)
+{
+	struct intel_iommu *iommu;
+
+	if (!info)
+		return NULL;
+
+	switch (info->type) {
+	case X86_IRQ_ALLOC_TYPE_MSI:
+	case X86_IRQ_ALLOC_TYPE_MSIX:
+		iommu = map_dev_to_ir(info->msi_dev);
+		if (iommu)
+			return iommu->ir_ims_domain;
+		break;
+	default:
+		break;
+	}
+
+	return NULL;
+}
+
 struct irq_remap_ops intel_irq_remap_ops = {
 	.prepare		= intel_prepare_irq_remapping,
 	.enable			= intel_enable_irq_remapping,
@@ -1147,6 +1176,7 @@ struct irq_remap_ops intel_irq_remap_ops = {
 	.enable_faulting	= enable_drhd_fault_handling,
 	.get_ir_irq_domain	= intel_get_ir_irq_domain,
 	.get_irq_domain		= intel_get_irq_domain,
+	.get_ims_irq_domain     = intel_get_ims_irq_domain,
 };
 
 static void intel_ir_reconfigure_irte(struct irq_data *irqd, bool force)
diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index 83f36f6..c4352fc 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -193,3 +193,12 @@ irq_remapping_get_irq_domain(struct irq_alloc_info *info)
 
 	return remap_ops->get_irq_domain(info);
 }
+
+struct irq_domain *
+irq_remapping_get_ims_irq_domain(struct irq_alloc_info *info)
+{
+	if (!remap_ops || !remap_ops->get_ims_irq_domain)
+		return NULL;
+
+	return remap_ops->get_ims_irq_domain(info);
+}
diff --git a/drivers/iommu/irq_remapping.h b/drivers/iommu/irq_remapping.h
index 6a190d5..8e198ad 100644
--- a/drivers/iommu/irq_remapping.h
+++ b/drivers/iommu/irq_remapping.h
@@ -48,6 +48,9 @@ struct irq_remap_ops {
 
 	/* Get the MSI irqdomain associated with the IOMMU device */
 	struct irq_domain *(*get_irq_domain)(struct irq_alloc_info *);
+
+	/* Get the IMS irqdomain associated with the IOMMU device */
+	struct irq_domain *(*get_ims_irq_domain)(struct irq_alloc_info *);
 };
 
 extern struct irq_remap_ops intel_irq_remap_ops;
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 4fc6454f..26be769 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -546,6 +546,7 @@ struct intel_iommu {
 	struct ir_table *ir_table;	/* Interrupt remapping info */
 	struct irq_domain *ir_domain;
 	struct irq_domain *ir_msi_domain;
+	struct irq_domain *ir_ims_domain;
 #endif
 	struct iommu_device iommu;  /* IOMMU core code handle */
 	int		node;
-- 
2.7.4

