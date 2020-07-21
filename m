Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB72228A1A
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jul 2020 22:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgGUUkv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jul 2020 16:40:51 -0400
Received: from mga01.intel.com ([192.55.52.88]:13746 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726658AbgGUUkv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Jul 2020 16:40:51 -0400
IronPort-SDR: FrMs/AIO7eygbozn5RpJM4e4rBSiXPlF4F/VadYruA5EkPkAh2IAqsJLk1uVLXpps4dRpaVM6a
 +H8/8HbMiLww==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="168372933"
X-IronPort-AV: E=Sophos;i="5.75,380,1589266800"; 
   d="scan'208";a="168372933"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 13:40:50 -0700
IronPort-SDR: di0B4dk+yo1aHOTRCBEp/aLGMvER7djLdRvLHXklogFG57nPazm/vCe8D12i59J9OPhryp0IPm
 Hqi8wyEf91Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,380,1589266800"; 
   d="scan'208";a="310372739"
Received: from unknown (HELO nsgsw-wilsonpoint.lm.intel.com) ([10.232.116.124])
  by fmsmga004.fm.intel.com with ESMTP; 21 Jul 2020 13:40:50 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Marc Zyngier <maz@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] irqdomain/treewide: Free firmware node after domain removal
Date:   Tue, 21 Jul 2020 14:26:09 -0600
Message-Id: <1595363169-7157-1-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Change 711419e504eb ("irqdomain: Add the missing assignment of
domain->fwnode for named fwnode") unintentionally caused a dangling
pointer page fault issue on firmware nodes that were freed after IRQ
domain allocation. Change e3beca48a45b fixed that dangling pointer issue
by only freeing the firmware node after an IRQ domain allocation
failure. That fix no longer frees the firmware node immediately, but
leaves the firmware node allocated after the domain is removed.

We need to keep the firmware node through irq_domain_remove, but should
free it afterwards. This patch saves the handle and adds the freeing of
firmware node after domain removal where appropriate.

Fixes: e3beca48a45b ("irqdomain/treewide: Keep firmware node unconditionally allocated")
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
Cc: stable@vger.kernel.org
---
 arch/mips/pci/pci-xtalk-bridge.c    | 3 +++
 arch/x86/kernel/apic/io_apic.c      | 5 +++++
 drivers/iommu/intel/irq_remapping.c | 8 ++++++++
 drivers/mfd/ioc3.c                  | 6 ++++++
 drivers/pci/controller/vmd.c        | 3 +++
 5 files changed, 25 insertions(+)

diff --git a/arch/mips/pci/pci-xtalk-bridge.c b/arch/mips/pci/pci-xtalk-bridge.c
index 5958217..9b3cc77 100644
--- a/arch/mips/pci/pci-xtalk-bridge.c
+++ b/arch/mips/pci/pci-xtalk-bridge.c
@@ -728,6 +728,7 @@ static int bridge_probe(struct platform_device *pdev)
 	pci_free_resource_list(&host->windows);
 err_remove_domain:
 	irq_domain_remove(domain);
+	irq_domain_free_fwnode(fn);
 	return err;
 }
 
@@ -735,8 +736,10 @@ static int bridge_remove(struct platform_device *pdev)
 {
 	struct pci_bus *bus = platform_get_drvdata(pdev);
 	struct bridge_controller *bc = BRIDGE_CONTROLLER(bus);
+	struct fwnode_handle *fn = bc->domain->fwnode;
 
 	irq_domain_remove(bc->domain);
+	irq_domain_free_fwnode(fn);
 	pci_lock_rescan_remove();
 	pci_stop_root_bus(bus);
 	pci_remove_root_bus(bus);
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 81ffcfb..21325a4a 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2335,8 +2335,13 @@ static int mp_irqdomain_create(int ioapic)
 
 static void ioapic_destroy_irqdomain(int idx)
 {
+	struct ioapic_domain_cfg *cfg = &ioapics[idx].irqdomain_cfg;
+	struct fwnode_handle *fn = ioapics[idx].irqdomain->fwnode;
+
 	if (ioapics[idx].irqdomain) {
 		irq_domain_remove(ioapics[idx].irqdomain);
+		if (!cfg->dev)
+			irq_domain_free_fwnode(fn);
 		ioapics[idx].irqdomain = NULL;
 	}
 }
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 9564d23..aa096b3 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -628,13 +628,21 @@ static int intel_setup_irq_remapping(struct intel_iommu *iommu)
 
 static void intel_teardown_irq_remapping(struct intel_iommu *iommu)
 {
+	struct fwnode_handle *fn;
+
 	if (iommu && iommu->ir_table) {
 		if (iommu->ir_msi_domain) {
+			fn = iommu->ir_msi_domain->fwnode;
+
 			irq_domain_remove(iommu->ir_msi_domain);
+			irq_domain_free_fwnode(fn);
 			iommu->ir_msi_domain = NULL;
 		}
 		if (iommu->ir_domain) {
+			fn = iommu->ir_domain->fwnode;
+
 			irq_domain_remove(iommu->ir_domain);
+			irq_domain_free_fwnode(fn);
 			iommu->ir_domain = NULL;
 		}
 		free_pages((unsigned long)iommu->ir_table->base,
diff --git a/drivers/mfd/ioc3.c b/drivers/mfd/ioc3.c
index 74cee7c..d939ccc 100644
--- a/drivers/mfd/ioc3.c
+++ b/drivers/mfd/ioc3.c
@@ -616,7 +616,10 @@ static int ioc3_mfd_probe(struct pci_dev *pdev,
 		/* Remove all already added MFD devices */
 		mfd_remove_devices(&ipd->pdev->dev);
 		if (ipd->domain) {
+			struct fwnode_handle *fn = ipd->domain->fwnode;
+
 			irq_domain_remove(ipd->domain);
+			irq_domain_free_fwnode(fn);
 			free_irq(ipd->domain_irq, (void *)ipd);
 		}
 		pci_iounmap(pdev, regs);
@@ -643,7 +646,10 @@ static void ioc3_mfd_remove(struct pci_dev *pdev)
 	/* Release resources */
 	mfd_remove_devices(&ipd->pdev->dev);
 	if (ipd->domain) {
+		struct fwnode_handle *fn = ipd->domain->fwnode;
+
 		irq_domain_remove(ipd->domain);
+		irq_domain_free_fwnode(fn);
 		free_irq(ipd->domain_irq, (void *)ipd);
 	}
 	pci_iounmap(pdev, ipd->regs);
diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index f078114..91eb769 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -560,6 +560,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	if (!vmd->bus) {
 		pci_free_resource_list(&resources);
 		irq_domain_remove(vmd->irq_domain);
+		irq_domain_free_fwnode(fn);
 		return -ENODEV;
 	}
 
@@ -673,6 +674,7 @@ static void vmd_cleanup_srcu(struct vmd_dev *vmd)
 static void vmd_remove(struct pci_dev *dev)
 {
 	struct vmd_dev *vmd = pci_get_drvdata(dev);
+	struct fwnode_handle *fn = vmd->irq_domain->fwnode;
 
 	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
 	pci_stop_root_bus(vmd->bus);
@@ -680,6 +682,7 @@ static void vmd_remove(struct pci_dev *dev)
 	vmd_cleanup_srcu(vmd);
 	vmd_detach_resources(vmd);
 	irq_domain_remove(vmd->irq_domain);
+	irq_domain_free_fwnode(fn);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
1.8.3.1

