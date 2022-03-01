Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A354C822B
	for <lists+linux-pci@lfdr.de>; Tue,  1 Mar 2022 05:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbiCAEU2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Feb 2022 23:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbiCAEU1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Feb 2022 23:20:27 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728232B24F;
        Mon, 28 Feb 2022 20:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646108385; x=1677644385;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4t+PvdGlz2cLuHS96n7ALdgqcJnX7IA3lO1HM5B6eiM=;
  b=Nj2NKC3EaLpQD3OCUtg+B0vv69naBb4uZxFd8F8R4rfxluMY+mdsGLwh
   TFwM8Mz7N/gSyIOL7dz8FjZufpGgDn14zcdgriu7vOLZAUf/LVH2L6RgC
   HMIaegnQa5bINWWW9u6l2BcLhYah9hYRJeQO3eTh7u3Q2CCvyyBZ5X2jN
   EAzaAVw/lKj2Mu0CkUwRVHvE4u3XYtwl9F+/7+avTbhG/cmQixC76wnu4
   YtCjjzEPhQiexBfi/9B4PFbqAIiQ2aO4ESdJ7sTG+SwJuBoAIktshOHtM
   5Hg4neycUdb/KbzfC3if/Ms1knehXTQXVFCa8Hggx9DdhvWY6ssNfwEjs
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="250634178"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="250634178"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 20:19:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="507667403"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 28 Feb 2022 20:19:44 -0800
Received: from debox1-desk4.lan (unknown [10.251.9.202])
        by linux.intel.com (Postfix) with ESMTP id 73195580C20;
        Mon, 28 Feb 2022 20:19:44 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, hch@infradead.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, david.e.box@linux.intel.com,
        michael.a.bottini@linux.intel.com, rafael@kernel.org,
        me@adhityamohan.in
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V6 3/3] PCI: vmd: Configure PCIe ASPM and LTR
Date:   Mon, 28 Feb 2022 20:19:43 -0800
Message-Id: <20220301041943.2935892-4-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220301041943.2935892-1-david.e.box@linux.intel.com>
References: <20220301041943.2935892-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe ports reserved for VMD use are not visible to BIOS and therefore not
configured to enable PCIE ASPM. Additionally, PCIE LTR values may be left
unset since BIOS will set a default maximum LTR value on endpoints to
ensure that they don't block SoC power management. Lack of this programming
results in high power consumption on laptops as reported in bugzilla [1].
For currently affected products, use pci_enable_default_link_state to set
the allowed link states for devices on the root ports. Also set the LTR
value to the maximum value needed for the SoC. Per the VMD hardware team
future products using VMD will enable BIOS configuration of these
capabilities. This solution is a workaround for current products that
mainly targets laptops. Support is not provided if a switch used nor for
hotplug.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=213717

Signed-off-by: Michael Bottini <michael.a.bottini@linux.intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
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

 drivers/pci/controller/vmd.c | 66 +++++++++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index cde6e2cba210..8525bb8312f2 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -67,10 +67,19 @@ enum vmd_features {
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
 
 struct vmd_device_data {
 	enum vmd_features features;
+	u16 ltr;
 };
 
 static DEFINE_IDA(vmd_instance_ida);
@@ -714,6 +723,45 @@ static void vmd_copy_host_bridge_flags(struct pci_host_bridge *root_bridge,
 	vmd_bridge->native_dpc = root_bridge->native_dpc;
 }
 
+/*
+ * Enable ASPM and LTR settings on devices that aren't configured by BIOS.
+ */
+static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
+{
+	struct vmd_device_data *info = userdata;
+	u32 ltr_reg;
+	int pos;
+
+	if (!(info->features & VMD_FEAT_BIOS_PM_QUIRK))
+		return 0;
+
+	pci_enable_default_link_state(pdev, PCIE_LINK_STATE_ALL);
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
+	ltr_reg = (info->ltr << 16) | info->ltr;
+	pci_write_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, ltr_reg);
+	pci_info(pdev, "VMD: Default LTR set\n");
+
+	return 0;
+}
+
 static int vmd_enable_domain(struct vmd_dev *vmd, struct vmd_device_data *info)
 {
 	struct pci_sysdata *sd = &vmd->sysdata;
@@ -867,6 +915,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, struct vmd_device_data *info)
 		pci_reset_bus(child->self);
 	pci_assign_unassigned_bus_resources(vmd->bus);
 
+	pci_walk_bus(vmd->bus, vmd_pm_enable_quirk, info);
+
 	/*
 	 * VMD root buses are virtual and don't return true on pci_is_pcie()
 	 * and will fail pcie_bus_configure_settings() early. It can instead be
@@ -1016,28 +1066,36 @@ static const struct pci_device_id vmd_ids[] = {
 		(kernel_ulong_t)&(struct vmd_device_data) {
 			.features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
 				    VMD_FEAT_HAS_BUS_RESTRICTIONS |
-				    VMD_FEAT_OFFSET_FIRST_VECTOR,
+				    VMD_FEAT_OFFSET_FIRST_VECTOR |
+				    VMD_FEAT_BIOS_PM_QUIRK,
+			.ltr = 0x1003, /* 3145728 ns */
 		},
 	},
 	{ PCI_VDEVICE(INTEL, 0x4c3d),
 		(kernel_ulong_t)&(struct vmd_device_data) {
 			.features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
 				    VMD_FEAT_HAS_BUS_RESTRICTIONS |
-				    VMD_FEAT_OFFSET_FIRST_VECTOR,
+				    VMD_FEAT_OFFSET_FIRST_VECTOR |
+				    VMD_FEAT_BIOS_PM_QUIRK,
+			.ltr = 0x1003, /* 3145728 ns */
 		},
 	},
 	{ PCI_VDEVICE(INTEL, 0xa77f),
 		(kernel_ulong_t)&(struct vmd_device_data) {
 			.features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
 				    VMD_FEAT_HAS_BUS_RESTRICTIONS |
-				    VMD_FEAT_OFFSET_FIRST_VECTOR,
+				    VMD_FEAT_OFFSET_FIRST_VECTOR |
+				    VMD_FEAT_BIOS_PM_QUIRK,
+			.ltr = 0x1003, /* 3145728 ns */
 		},
 	},
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
 		(kernel_ulong_t)&(struct vmd_device_data) {
 			.features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
 				    VMD_FEAT_HAS_BUS_RESTRICTIONS |
-				    VMD_FEAT_OFFSET_FIRST_VECTOR,
+				    VMD_FEAT_OFFSET_FIRST_VECTOR |
+				    VMD_FEAT_BIOS_PM_QUIRK,
+			.ltr = 0x1003, /* 3145728 ns */
 		},
 	},
 	{ }
-- 
2.25.1

