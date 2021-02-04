Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9F130FC4C
	for <lists+linux-pci@lfdr.de>; Thu,  4 Feb 2021 20:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239506AbhBDTM1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Feb 2021 14:12:27 -0500
Received: from mga18.intel.com ([134.134.136.126]:31191 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239591AbhBDTKJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Feb 2021 14:10:09 -0500
IronPort-SDR: y5Q9E6suSheSRlXE01NIglAQ2eTVCT8arv0Ml8P503SfQ2ZwsFPyMQpVP0FYpHFz3oeGtp/quA
 TSD4WzQrpqYw==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="168988759"
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400"; 
   d="scan'208";a="168988759"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 11:09:26 -0800
IronPort-SDR: mgkIpOUnXUJ5f+42lzN4iRZOFIS7LcGeepPGRki8xgk4cSg18tepo8d2LXwMS1wckusk5JlAc0
 jpUFGa0L8UhA==
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400"; 
   d="scan'208";a="434070488"
Received: from sgklier-mobl1.amr.corp.intel.com (HELO jderrick-mobl.amr.corp.intel.com) ([10.212.165.190])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 11:09:25 -0800
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>, <iommu@lists.linux-foundation.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Nirmal Patel <nirmal.patel@intel.com>,
        Kapil Karkra <kapil.karkra@intel.com>,
        Will Deacon <will@kernel.org>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH v2 2/2] PCI: vmd: Disable MSI/X remapping when possible
Date:   Thu,  4 Feb 2021 12:09:06 -0700
Message-Id: <20210204190906.38515-3-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210204190906.38515-1-jonathan.derrick@intel.com>
References: <20210204190906.38515-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

VMD will retransmit child device MSI/X using its own MSI/X table and
requester-id. This limits the number of MSI/X available to the whole
child device domain to the number of VMD MSI/X interrupts.

Some VMD devices have a mode where this remapping can be disabled,
allowing child device interrupts to bypass processing with the VMD MSI/X
domain interrupt handler and going straight the child device interrupt
handler, allowing for better performance and scaling. The requester-id
still gets changed to the VMD endpoint's requester-id, and the interrupt
remapping handlers have been updated to properly set IRTE for child
device interrupts to the VMD endpoint's context.

Some VMD platforms have existing production BIOS which rely on MSI/X
remapping and won't explicitly program the MSI/X remapping bit. This
re-enables MSI/X remapping on unload.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/controller/vmd.c | 60 ++++++++++++++++++++++++++++--------
 1 file changed, 48 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 5e80f28f0119..a319ce49645b 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -59,6 +59,13 @@ enum vmd_features {
 	 * be used for MSI remapping
 	 */
 	VMD_FEAT_OFFSET_FIRST_VECTOR		= (1 << 3),
+
+	/*
+	 * Device can bypass remapping MSI/X transactions into its MSI/X table,
+	 * avoding the requirement of a VMD MSI domain for child device
+	 * interrupt handling
+	 */
+	VMD_FEAT_BYPASS_MSI_REMAP		= (1 << 4),
 };
 
 /*
@@ -306,6 +313,15 @@ static struct msi_domain_info vmd_msi_domain_info = {
 	.chip		= &vmd_msi_controller,
 };
 
+static void vmd_enable_msi_remapping(struct vmd_dev *vmd, bool enable)
+{
+	u16 reg;
+
+	pci_read_config_word(vmd->dev, PCI_REG_VMCONFIG, &reg);
+	reg = enable ? (reg & ~0x2) : (reg | 0x2);
+	pci_write_config_word(vmd->dev, PCI_REG_VMCONFIG, reg);
+}
+
 static int vmd_create_irq_domain(struct vmd_dev *vmd)
 {
 	struct fwnode_handle *fn;
@@ -325,6 +341,13 @@ static int vmd_create_irq_domain(struct vmd_dev *vmd)
 
 static void vmd_remove_irq_domain(struct vmd_dev *vmd)
 {
+	/*
+	 * Some production BIOS won't enable remapping between soft reboots.
+	 * Ensure remapping is restored before unloading the driver.
+	 */
+	if (!vmd->msix_count)
+		vmd_enable_msi_remapping(vmd, true);
+
 	if (vmd->irq_domain) {
 		struct fwnode_handle *fn = vmd->irq_domain->fwnode;
 
@@ -679,15 +702,31 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 
 	sd->node = pcibus_to_node(vmd->dev->bus);
 
-	ret = vmd_create_irq_domain(vmd);
-	if (ret)
-		return ret;
-
 	/*
-	 * Override the irq domain bus token so the domain can be distinguished
-	 * from a regular PCI/MSI domain.
+	 * Currently MSI remapping must be enabled in guest passthrough mode
+	 * due to some missing interrupt remapping plumbing. This is probably
+	 * acceptable because the guest is usually CPU-limited and MSI
+	 * remapping doesn't become a performance bottleneck.
 	 */
-	irq_domain_update_bus_token(vmd->irq_domain, DOMAIN_BUS_VMD_MSI);
+	if (!(features & VMD_FEAT_BYPASS_MSI_REMAP) || offset[0] || offset[1]) {
+		ret = vmd_alloc_irqs(vmd);
+		if (ret)
+			return ret;
+
+		vmd_enable_msi_remapping(vmd, true);
+
+		ret = vmd_create_irq_domain(vmd);
+		if (ret)
+			return ret;
+
+		/*
+		 * Override the irq domain bus token so the domain can be
+		 * distinguished from a regular PCI/MSI domain.
+		 */
+		irq_domain_update_bus_token(vmd->irq_domain, DOMAIN_BUS_VMD_MSI);
+	} else {
+		vmd_enable_msi_remapping(vmd, false);
+	}
 
 	pci_add_resource(&resources, &vmd->resources[0]);
 	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
@@ -753,10 +792,6 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (features & VMD_FEAT_OFFSET_FIRST_VECTOR)
 		vmd->first_vec = 1;
 
-	err = vmd_alloc_irqs(vmd);
-	if (err)
-		return err;
-
 	spin_lock_init(&vmd->cfg_lock);
 	pci_set_drvdata(dev, vmd);
 	err = vmd_enable_domain(vmd, features);
@@ -825,7 +860,8 @@ static const struct pci_device_id vmd_ids[] = {
 		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP,},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_28C0),
 		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
-				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
+				VMD_FEAT_HAS_BUS_RESTRICTIONS |
+				VMD_FEAT_BYPASS_MSI_REMAP,},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x467f),
 		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
 				VMD_FEAT_HAS_BUS_RESTRICTIONS |
-- 
2.27.0

