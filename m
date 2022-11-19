Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5E1630A65
	for <lists+linux-pci@lfdr.de>; Sat, 19 Nov 2022 03:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbiKSC0X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 21:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235936AbiKSCYo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 21:24:44 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD560C7599;
        Fri, 18 Nov 2022 18:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668824144; x=1700360144;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oeZu/jIyN1c5IQFJ1A7HgOl4IY4Uaxs22ZTpXdLDbgo=;
  b=AUGT0i2yZw3gwHddRNbW4qrRHXd9gduysswN87KvFC+yYbrxAmoqCyMs
   O9e7xJ2tVDYLK+1ZZDmEXw/Y02Xob8v7XPA/qSLgMZkLY5F7++PXhReiK
   YUicgPQ+Qmg0RtrYP7WO4TcYyBGieJ5B29/wnff5qJrZzTE6MVFsK4pHW
   V+WBoH7pOdKfkSFT+w6Ga5fqIFlHVKuqLmuEgqMaqjR92GbbtqHRUl/ig
   4f4K8d8uji0HNFHrvlg/3gQ9DCPXwj4S23zjMY2RMG/t44a1KP9K1+qRj
   BH9oROqx32jRXTP3rObyY38WB2sQIzRkKK99T2aYEmSC89v68v68bRkcF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="315100484"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="315100484"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 18:14:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="618225634"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="618225634"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 18 Nov 2022 18:14:12 -0800
Received: from debox1-desk4.lan (unknown [10.252.138.169])
        by linux.intel.com (Postfix) with ESMTP id AB668580DFA;
        Fri, 18 Nov 2022 18:14:12 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, hch@infradead.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, david.e.box@linux.intel.com,
        michael.a.bottini@intel.com, rafael@kernel.org, me@adhityamohan.in
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V8 RESEND 4/4] PCI: vmd: Add quirk to configure PCIe ASPM and LTR
Date:   Fri, 18 Nov 2022 18:14:11 -0800
Message-Id: <20221119021411.1383248-5-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221119021411.1383248-1-david.e.box@linux.intel.com>
References: <20221119021411.1383248-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe ports reserved for VMD use are not visible to BIOS and therefore not
configured to enable PCIe ASPM or LTR values (which BIOS will configure if
they are not set). Lack of this programming results in high power
consumption on laptops as reported in bugzilla.  For affected products use
pci_enable_link_state to set the allowed link states for devices on the
root ports. Also set the LTR value to the maximum value needed for the SoC.

This is a workaround for products from Rocket Lake through Alder Lake.
Raptor Lake, the latest product at this time, has already implemented LTR
configuring in BIOS. Future products will move ASPM configuration back to
BIOS as well.  As this solution is intended for laptops, support is not
added for hotplug or for devices downstream of a switch on the root port.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=212355
Link: https://bugzilla.kernel.org/show_bug.cgi?id=215063
Link: https://bugzilla.kernel.org/show_bug.cgi?id=213717

Signed-off-by: Michael Bottini <michael.a.bottini@linux.intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Jon Derrick <jonathan.derrick@linux.dev>
Reviewed-by: Nirmal Patel <nirmal.patel@linux.intel.com>
---
 V8
  - Removed struct vmd_device_data patch. Instead use #define for the LTR
    value which is the same across all products needing the quirk.
 V7
  - No change
 V6
  - Set ASPM first before setting LTR. This is needed because some
    devices may only have LTR set by BIOS and not ASPM
  - Skip setting the LTR if the current LTR in non-zero.
 V5
  - Provide the LTR value as driver data.
  - Use DWORD for the config space write to avoid PCI WORD access bug.
  - Set ASPM links firsts, enabling all link states, before setting a
    default LTR if the capability is present
  - Add kernel message that VMD is setting the device LTR.
 V4
  - Refactor vmd_enable_apsm() to exit early, making the lines shorter
    and more readable. Suggested by Christoph.
 V3
  - No changes
 V2
  - Use return status to print pci_info message if ASPM cannot be enabled.
  - Add missing static declaration, caught by lkp@intel.com

 drivers/pci/controller/vmd.c | 64 ++++++++++++++++++++++++++++++++----
 1 file changed, 58 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 86f3085db014..cba57e3091f6 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -66,12 +66,22 @@ enum vmd_features {
 	 * interrupt handling.
 	 */
 	VMD_FEAT_CAN_BYPASS_MSI_REMAP		= (1 << 4),
+
+	/*
+	 * Enable ASPM on the PCIE root ports and set the default LTR of the
+	 * storage devices on platforms where these values are not configured by
+	 * BIOS. This is needed for laptops, which require these settings for
+	 * proper power management of the SoC.
+	 */
+	VMD_FEAT_BIOS_PM_QUIRK		= (1 << 5),
 };
 
 #define VMD_FEATS_CLIENT	(VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |	\
 				 VMD_FEAT_HAS_BUS_RESTRICTIONS |	\
 				 VMD_FEAT_OFFSET_FIRST_VECTOR)
 
+#define VMD_BIOS_PM_QUIRK_LTR	0x1003	/* 3145728 ns */
+
 static DEFINE_IDA(vmd_instance_ida);
 
 /*
@@ -713,6 +723,46 @@ static void vmd_copy_host_bridge_flags(struct pci_host_bridge *root_bridge,
 	vmd_bridge->native_dpc = root_bridge->native_dpc;
 }
 
+/*
+ * Enable ASPM and LTR settings on devices that aren't configured by BIOS.
+ */
+static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
+{
+	unsigned long features = *(unsigned long *)userdata;
+	u16 ltr = VMD_BIOS_PM_QUIRK_LTR;
+	u32 ltr_reg;
+	int pos;
+
+	if (!(features & VMD_FEAT_BIOS_PM_QUIRK))
+		return 0;
+
+	pci_enable_link_state(pdev, PCIE_LINK_STATE_ALL);
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_LTR);
+	if (!pos)
+		return 0;
+
+	/*
+	 * Skip if the max snoop LTR is non-zero, indicating BIOS has set it
+	 * so the LTR quirk is not needed.
+	 */
+	pci_read_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, &ltr_reg);
+	if (!!(ltr_reg & (PCI_LTR_VALUE_MASK | PCI_LTR_SCALE_MASK)))
+		return 0;
+
+	/*
+	 * Set the default values to the maximum required by the platform to
+	 * allow the deepest power management savings. Write as a DWORD where
+	 * the lower word is the max snoop latency and the upper word is the
+	 * max non-snoop latency.
+	 */
+	ltr_reg = (ltr << 16) | ltr;
+	pci_write_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, ltr_reg);
+	pci_info(pdev, "VMD: Default LTR value set by driver\n");
+
+	return 0;
+}
+
 static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 {
 	struct pci_sysdata *sd = &vmd->sysdata;
@@ -867,6 +917,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		pci_reset_bus(child->self);
 	pci_assign_unassigned_bus_resources(vmd->bus);
 
+	pci_walk_bus(vmd->bus, vmd_pm_enable_quirk, &features);
+
 	/*
 	 * VMD root buses are virtual and don't return true on pci_is_pcie()
 	 * and will fail pcie_bus_configure_settings() early. It can instead be
@@ -1005,17 +1057,17 @@ static const struct pci_device_id vmd_ids[] = {
 				VMD_FEAT_HAS_BUS_RESTRICTIONS |
 				VMD_FEAT_CAN_BYPASS_MSI_REMAP,},
 	{PCI_VDEVICE(INTEL, 0x467f),
-		.driver_data = VMD_FEATS_CLIENT,},
+		.driver_data = VMD_FEATS_CLIENT | VMD_FEAT_BIOS_PM_QUIRK,},
 	{PCI_VDEVICE(INTEL, 0x4c3d),
-		.driver_data = VMD_FEATS_CLIENT,},
+		.driver_data = VMD_FEATS_CLIENT | VMD_FEAT_BIOS_PM_QUIRK,},
 	{PCI_VDEVICE(INTEL, 0xa77f),
-		.driver_data = VMD_FEATS_CLIENT,},
+		.driver_data = VMD_FEATS_CLIENT | VMD_FEAT_BIOS_PM_QUIRK,},
 	{PCI_VDEVICE(INTEL, 0x7d0b),
-		.driver_data = VMD_FEATS_CLIENT,},
+		.driver_data = VMD_FEATS_CLIENT | VMD_FEAT_BIOS_PM_QUIRK,},
 	{PCI_VDEVICE(INTEL, 0xad0b),
-		.driver_data = VMD_FEATS_CLIENT,},
+		.driver_data = VMD_FEATS_CLIENT | VMD_FEAT_BIOS_PM_QUIRK,},
 	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
-		.driver_data = VMD_FEATS_CLIENT,},
+		.driver_data = VMD_FEATS_CLIENT | VMD_FEAT_BIOS_PM_QUIRK,},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, vmd_ids);
-- 
2.34.1

