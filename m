Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33ADE6DE674
	for <lists+linux-pci@lfdr.de>; Tue, 11 Apr 2023 23:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjDKVd3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Apr 2023 17:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjDKVd2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2023 17:33:28 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569F64C2E;
        Tue, 11 Apr 2023 14:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681248807; x=1712784807;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Qbs/+BT7zaXH0NFJ1Etj/EqbkrZR4YTOBmmPKWBUP3c=;
  b=C9flPaXtToLgleIzt/nALNSQMxpPFms9FFn3H/OlU78I271HbjrSO+eE
   /E4wOs2ACux9mLwYbRfll6YAL4eD/+r/NnNBSszsQzH1iRJZc62Tg4FK0
   R/qimeQ8f3KkHv0EY6sC02DcL7jZehQLNpsQ8Gux7K3ylJvLL6u6Q3C55
   T3orG6WsElcHXK8MzI43xs26SAynf1et39KDzY//qw6uQTN4Avcrx6KcE
   VgkKz4ZipXNBEJOQEKjVWh8Mn7GF9QucCKn+pVIuR8nzCBiyMMQEJ6vm7
   q9sGUeUPCEXlbqFwAs2D1KaigJPX5GZlcAZ7BPmfPrU/Dc1Vsh8qofEWL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="408880800"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="408880800"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 14:33:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="753285746"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="753285746"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 11 Apr 2023 14:33:26 -0700
Received: from debox1-desk4.lan (unknown [10.209.9.147])
        by linux.intel.com (Postfix) with ESMTP id A8F65580AFF;
        Tue, 11 Apr 2023 14:33:25 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     david.e.box@linux.intel.com, ville.syrjala@linux.intel.com,
        nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, hch@infradead.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, michael.a.bottini@intel.com,
        rafael@kernel.org
Cc:     me@adhityamohan.in, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: [PATCH V2] PCI: Move VMD ASPM/LTR fix to PCI quirk
Date:   Tue, 11 Apr 2023 14:33:23 -0700
Message-Id: <20230411213323.1362300-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In commit f492edb40b54 ("PCI: vmd: Add quirk to configure PCIe ASPM and
LTR") the VMD driver calls pci_enabled_link_state as a callback from
pci_bus_walk. Both will acquire the pci_bus_sem lock leading to a lockdep
warning. Instead of doing the pci_bus_walk, move the fix to quirks.c using
DECLARE_PCI_FIXUP_FINAL.

Fixes: f492edb40b54 ("PCI: vmd: Add quirk to configure PCIe ASPM and LTR")
Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---

V2 - Instead of adding a lock flag argument to pci_enabled_link_state, move
     the fix to quirks.c

 drivers/pci/controller/vmd.c | 55 +--------------------------
 drivers/pci/quirks.c         | 72 ++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 54 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 990630ec57c6..47fa3e5f2dc5 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -66,22 +66,11 @@ enum vmd_features {
 	 * interrupt handling.
 	 */
 	VMD_FEAT_CAN_BYPASS_MSI_REMAP		= (1 << 4),
-
-	/*
-	 * Enable ASPM on the PCIE root ports and set the default LTR of the
-	 * storage devices on platforms where these values are not configured by
-	 * BIOS. This is needed for laptops, which require these settings for
-	 * proper power management of the SoC.
-	 */
-	VMD_FEAT_BIOS_PM_QUIRK		= (1 << 5),
 };
 
-#define VMD_BIOS_PM_QUIRK_LTR	0x1003	/* 3145728 ns */
-
 #define VMD_FEATS_CLIENT	(VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |	\
 				 VMD_FEAT_HAS_BUS_RESTRICTIONS |	\
-				 VMD_FEAT_OFFSET_FIRST_VECTOR |		\
-				 VMD_FEAT_BIOS_PM_QUIRK)
+				 VMD_FEAT_OFFSET_FIRST_VECTOR)
 
 static DEFINE_IDA(vmd_instance_ida);
 
@@ -724,46 +713,6 @@ static void vmd_copy_host_bridge_flags(struct pci_host_bridge *root_bridge,
 	vmd_bridge->native_dpc = root_bridge->native_dpc;
 }
 
-/*
- * Enable ASPM and LTR settings on devices that aren't configured by BIOS.
- */
-static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
-{
-	unsigned long features = *(unsigned long *)userdata;
-	u16 ltr = VMD_BIOS_PM_QUIRK_LTR;
-	u32 ltr_reg;
-	int pos;
-
-	if (!(features & VMD_FEAT_BIOS_PM_QUIRK))
-		return 0;
-
-	pci_enable_link_state(pdev, PCIE_LINK_STATE_ALL);
-
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_LTR);
-	if (!pos)
-		return 0;
-
-	/*
-	 * Skip if the max snoop LTR is non-zero, indicating BIOS has set it
-	 * so the LTR quirk is not needed.
-	 */
-	pci_read_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, &ltr_reg);
-	if (!!(ltr_reg & (PCI_LTR_VALUE_MASK | PCI_LTR_SCALE_MASK)))
-		return 0;
-
-	/*
-	 * Set the default values to the maximum required by the platform to
-	 * allow the deepest power management savings. Write as a DWORD where
-	 * the lower word is the max snoop latency and the upper word is the
-	 * max non-snoop latency.
-	 */
-	ltr_reg = (ltr << 16) | ltr;
-	pci_write_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, ltr_reg);
-	pci_info(pdev, "VMD: Default LTR value set by driver\n");
-
-	return 0;
-}
-
 static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 {
 	struct pci_sysdata *sd = &vmd->sysdata;
@@ -936,8 +885,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 
 	pci_assign_unassigned_bus_resources(vmd->bus);
 
-	pci_walk_bus(vmd->bus, vmd_pm_enable_quirk, &features);
-
 	/*
 	 * VMD root buses are virtual and don't return true on pci_is_pcie()
 	 * and will fail pcie_bus_configure_settings() early. It can instead be
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 44cab813bf95..2d86623f96e3 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6023,3 +6023,75 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2d, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2f, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
 #endif
+
+#ifdef CONFIG_VMD
+/*
+ * Enable ASPM on the PCIE root ports under VMD and set the default LTR of the
+ * storage devices on platforms where these values are not configured by BIOS.
+ * This is needed for laptops, which require these settings for proper power
+ * management of the SoC.
+ */
+#define VMD_DEVICE_LTR	0x1003	/* 3145728 ns */
+static void quirk_intel_vmd(struct pci_dev *pdev)
+{
+	struct pci_dev *parent;
+	u16 ltr = VMD_DEVICE_LTR;
+	u32 ltr_reg;
+	int pos;
+
+	/* Check in VMD domain */
+	if (pci_domain_nr(pdev->bus) < 0x10000)
+		return;
+
+	/* Get Root Port */
+	parent = pci_upstream_bridge(pdev);
+	if (!parent || parent->vendor != PCI_VENDOR_ID_INTEL)
+		return;
+
+	/* Get VMD Host Bridge */
+	parent = to_pci_dev(parent->dev.parent);
+	if (!parent)
+		return;
+
+	/* Get RAID controller */
+	parent = to_pci_dev(parent->dev.parent);
+	if (!parent)
+		return;
+
+	switch (parent->device) {
+	case 0x467f:
+	case 0x4c3d:
+	case 0xa77f:
+	case 0x7d0b:
+	case 0xad0b:
+	case 0x9a0b:
+		break;
+	default:
+		return;
+	}
+
+	pci_enable_link_state(pdev, PCIE_LINK_STATE_ALL);
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_LTR);
+	if (!pos)
+		return;
+
+	/* Skip if the max snoop LTR is non-zero, indicating BIOS has set it */
+	pci_read_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, &ltr_reg);
+	if (!!(ltr_reg & (PCI_LTR_VALUE_MASK | PCI_LTR_SCALE_MASK)))
+		return;
+
+	/*
+	 * Set the LTR values to the maximum required by the platform to
+	 * allow the deepest power management savings. Write as a DWORD where
+	 * the lower word is the max snoop latency and the upper word is the
+	 * max non-snoop latency.
+	 */
+	ltr_reg = (ltr << 16) | ltr;
+	pci_write_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, ltr_reg);
+	pci_info(pdev, "LTR set by VMD PCI quick\n");
+
+}
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_ANY_ID, PCI_ANY_ID,
+			      PCI_CLASS_STORAGE_EXPRESS, 0, quirk_intel_vmd);
+#endif
-- 
2.34.1

