Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCAE2316AE1
	for <lists+linux-pci@lfdr.de>; Wed, 10 Feb 2021 17:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbhBJQOe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Feb 2021 11:14:34 -0500
Received: from mga04.intel.com ([192.55.52.120]:47934 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232128AbhBJQOY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Feb 2021 11:14:24 -0500
IronPort-SDR: 1ZJHZDJgm5/ivuOQ+ruJ93W4cCQ6HE2kxv9l5XXajOAJdW7nQAOvNnzU+qZEbNtVd8Yq9lnP0D
 4lYq3Ef3YKUA==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="179543658"
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="179543658"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 08:13:27 -0800
IronPort-SDR: u2kavugDTlOmEgCnUxJwb7V8DNnKAOrrs2HkCgM6AdyHVWi2q2Sk4gKvMkkCk7RtjwgP9Q13Jl
 mO2U3nmB75Iw==
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="380191385"
Received: from mjyalung-mobl.amr.corp.intel.com (HELO jderrick-mobl.amr.corp.intel.com) ([10.209.178.245])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 08:13:27 -0800
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>, <iommu@lists.linux-foundation.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Nirmal Patel <nirmal.patel@intel.com>,
        Kapil Karkra <kapil.karkra@intel.com>,
        Krzysztof Wilczynski <kw@linux.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH v4 2/2] PCI: vmd: Disable MSI-X remapping when possible
Date:   Wed, 10 Feb 2021 09:13:15 -0700
Message-Id: <20210210161315.316097-3-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210210161315.316097-1-jonathan.derrick@intel.com>
References: <20210210161315.316097-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

VMD will retransmit child device MSI-X using its own MSI-X table and
requester-id. This limits the number of MSI-X available to the whole
child device domain to the number of VMD MSI-X interrupts.

Some VMD devices have a mode where this remapping can be disabled,
allowing child device interrupts to bypass processing with the VMD MSI-X
domain interrupt handler and going straight the child device interrupt
handler, allowing for better performance and scaling. The requester-id
still gets changed to the VMD endpoint's requester-id, and the interrupt
remapping handlers have been updated to properly set IRTE for child
device interrupts to the VMD endpoint's context.

Some VMD platforms have existing production BIOS which rely on MSI-X
remapping and won't explicitly program the MSI-X remapping bit. This
re-enables MSI-X remapping on unload.

Acked-by: Joerg Roedel <jroedel@suse.de>
Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/controller/vmd.c | 63 +++++++++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 5e80f28f0119..e3fcdfec58b3 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -28,6 +28,7 @@
 #define BUS_RESTRICT_CAP(vmcap)	(vmcap & 0x1)
 #define PCI_REG_VMCONFIG	0x44
 #define BUS_RESTRICT_CFG(vmcfg)	((vmcfg >> 8) & 0x3)
+#define VMCONFIG_MSI_REMAP	0x2
 #define PCI_REG_VMLOCK		0x70
 #define MB2_SHADOW_EN(vmlock)	(vmlock & 0x2)
 
@@ -59,6 +60,13 @@ enum vmd_features {
 	 * be used for MSI remapping
 	 */
 	VMD_FEAT_OFFSET_FIRST_VECTOR		= (1 << 3),
+
+	/*
+	 * Device can bypass remapping MSI-X transactions into its MSI-X table,
+	 * avoiding the requirement of a VMD MSI domain for child device
+	 * interrupt handling.
+	 */
+	VMD_FEAT_CAN_BYPASS_MSI_REMAP		= (1 << 4),
 };
 
 /*
@@ -306,6 +314,16 @@ static struct msi_domain_info vmd_msi_domain_info = {
 	.chip		= &vmd_msi_controller,
 };
 
+static void vmd_set_msi_remapping(struct vmd_dev *vmd, bool enable)
+{
+	u16 reg;
+
+	pci_read_config_word(vmd->dev, PCI_REG_VMCONFIG, &reg);
+	reg = enable ? (reg & ~VMCONFIG_MSI_REMAP) :
+		       (reg | VMCONFIG_MSI_REMAP);
+	pci_write_config_word(vmd->dev, PCI_REG_VMCONFIG, reg);
+}
+
 static int vmd_create_irq_domain(struct vmd_dev *vmd)
 {
 	struct fwnode_handle *fn;
@@ -325,6 +343,13 @@ static int vmd_create_irq_domain(struct vmd_dev *vmd)
 
 static void vmd_remove_irq_domain(struct vmd_dev *vmd)
 {
+	/*
+	 * Some production BIOS won't enable remapping between soft reboots.
+	 * Ensure remapping is restored before unloading the driver.
+	 */
+	if (!vmd->msix_count)
+		vmd_set_msi_remapping(vmd, true);
+
 	if (vmd->irq_domain) {
 		struct fwnode_handle *fn = vmd->irq_domain->fwnode;
 
@@ -679,15 +704,32 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 
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
+	if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
+	    offset[0] || offset[1]) {
+		ret = vmd_alloc_irqs(vmd);
+		if (ret)
+			return ret;
+
+		vmd_set_msi_remapping(vmd, true);
+
+		ret = vmd_create_irq_domain(vmd);
+		if (ret)
+			return ret;
+
+		/*
+		 * Override the IRQ domain bus token so the domain can be
+		 * distinguished from a regular PCI/MSI domain.
+		 */
+		irq_domain_update_bus_token(vmd->irq_domain, DOMAIN_BUS_VMD_MSI);
+	} else {
+		vmd_set_msi_remapping(vmd, false);
+	}
 
 	pci_add_resource(&resources, &vmd->resources[0]);
 	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
@@ -753,10 +795,6 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (features & VMD_FEAT_OFFSET_FIRST_VECTOR)
 		vmd->first_vec = 1;
 
-	err = vmd_alloc_irqs(vmd);
-	if (err)
-		return err;
-
 	spin_lock_init(&vmd->cfg_lock);
 	pci_set_drvdata(dev, vmd);
 	err = vmd_enable_domain(vmd, features);
@@ -825,7 +863,8 @@ static const struct pci_device_id vmd_ids[] = {
 		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP,},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_28C0),
 		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
-				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
+				VMD_FEAT_HAS_BUS_RESTRICTIONS |
+				VMD_FEAT_CAN_BYPASS_MSI_REMAP,},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x467f),
 		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
 				VMD_FEAT_HAS_BUS_RESTRICTIONS |
-- 
2.27.0

