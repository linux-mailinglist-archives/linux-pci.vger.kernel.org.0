Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337E9231386
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jul 2020 22:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgG1UHX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jul 2020 16:07:23 -0400
Received: from mga03.intel.com ([134.134.136.65]:63202 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728559AbgG1UHG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Jul 2020 16:07:06 -0400
IronPort-SDR: RxBq11cZZvcabAlWhpewH031HLbiXj+LfH2BrIAfJ1k0X9VMsfeNuyCZ8jneu2LOagjkBDqtop
 hr3G4LSyA6gg==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="151287334"
X-IronPort-AV: E=Sophos;i="5.75,407,1589266800"; 
   d="scan'208";a="151287334"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 13:07:04 -0700
IronPort-SDR: mnK6quD5Piabw1hA8WNqAwRt8dGmUuKQhUaAjzgXJUuAwwX51XU82pmri4V6kyCjdN+xHlaipv
 cHPlOMBX2srg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,407,1589266800"; 
   d="scan'208";a="312756381"
Received: from unknown (HELO nsgsw-wilsonpoint.lm.intel.com) ([10.232.116.124])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jul 2020 13:07:04 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
        Sushma Kalakota <sushmax.kalakota@intel.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH 3/6] PCI: vmd: Create IRQ Domain configuration helper
Date:   Tue, 28 Jul 2020 13:49:42 -0600
Message-Id: <20200728194945.14126-4-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200728194945.14126-1-jonathan.derrick@intel.com>
References: <20200728194945.14126-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Moves the IRQ and MSI Domain configuration code to new helpers. No
functional changes.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/controller/vmd.c | 52 ++++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index a462719af12a..703c48171993 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -298,6 +298,34 @@ static struct msi_domain_info vmd_msi_domain_info = {
 	.chip		= &vmd_msi_controller,
 };
 
+static int vmd_create_irq_domain(struct vmd_dev *vmd)
+{
+	struct fwnode_handle *fn;
+
+	fn = irq_domain_alloc_named_id_fwnode("VMD-MSI", vmd->sysdata.domain);
+	if (!fn)
+		return -ENODEV;
+
+	vmd->irq_domain = pci_msi_create_irq_domain(fn, &vmd_msi_domain_info,
+						    x86_vector_domain);
+	if (!vmd->irq_domain) {
+		irq_domain_free_fwnode(fn);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static void vmd_remove_irq_domain(struct vmd_dev *vmd)
+{
+	if (vmd->irq_domain) {
+		struct fwnode_handle *fn = vmd->irq_domain->fwnode;
+
+		irq_domain_remove(vmd->irq_domain);
+		irq_domain_free_fwnode(fn);
+	}
+}
+
 static char __iomem *vmd_cfg_addr(struct vmd_dev *vmd, struct pci_bus *bus,
 				  unsigned int devfn, int reg, int len)
 {
@@ -503,7 +531,6 @@ static int vmd_get_bus_number_start(struct vmd_dev *vmd)
 static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 {
 	struct pci_sysdata *sd = &vmd->sysdata;
-	struct fwnode_handle *fn;
 	struct resource *res;
 	u32 upper_bits;
 	unsigned long flags;
@@ -598,16 +625,9 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 
 	sd->node = pcibus_to_node(vmd->dev->bus);
 
-	fn = irq_domain_alloc_named_id_fwnode("VMD-MSI", vmd->sysdata.domain);
-	if (!fn)
-		return -ENODEV;
-
-	vmd->irq_domain = pci_msi_create_irq_domain(fn, &vmd_msi_domain_info,
-						    x86_vector_domain);
-	if (!vmd->irq_domain) {
-		irq_domain_free_fwnode(fn);
-		return -ENODEV;
-	}
+	ret = vmd_create_irq_domain(vmd);
+	if (ret)
+		return ret;
 
 	pci_add_resource(&resources, &vmd->resources[0]);
 	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
@@ -617,13 +637,13 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 				       &vmd_ops, sd, &resources);
 	if (!vmd->bus) {
 		pci_free_resource_list(&resources);
-		irq_domain_remove(vmd->irq_domain);
-		irq_domain_free_fwnode(fn);
+		vmd_remove_irq_domain(vmd);
 		return -ENODEV;
 	}
 
 	vmd_attach_resources(vmd);
-	dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
+	if (vmd->irq_domain)
+		dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
 
 	pci_scan_child_bus(vmd->bus);
 	pci_assign_unassigned_bus_resources(vmd->bus);
@@ -732,15 +752,13 @@ static void vmd_cleanup_srcu(struct vmd_dev *vmd)
 static void vmd_remove(struct pci_dev *dev)
 {
 	struct vmd_dev *vmd = pci_get_drvdata(dev);
-	struct fwnode_handle *fn = vmd->irq_domain->fwnode;
 
 	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
 	pci_stop_root_bus(vmd->bus);
 	pci_remove_root_bus(vmd->bus);
 	vmd_cleanup_srcu(vmd);
 	vmd_detach_resources(vmd);
-	irq_domain_remove(vmd->irq_domain);
-	irq_domain_free_fwnode(fn);
+	vmd_remove_irq_domain(vmd);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.27.0

