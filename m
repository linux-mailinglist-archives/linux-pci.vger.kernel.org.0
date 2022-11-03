Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAE761741D
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 03:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbiKCCSd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Nov 2022 22:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKCCS2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Nov 2022 22:18:28 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119BE13D48;
        Wed,  2 Nov 2022 19:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667441907; x=1698977907;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aEiHMG/t7yyno42B1YTG/JN48w91eX/H9maLsZ24Sp0=;
  b=mMsfE7DPPMYcfi/Ii0kcUlolsfkUNNfdpDmA7EcRKiHEqsMbCdeVtIRk
   Qs5CyXpnBkA+g4c0G+x9fNEu1vWUsI+KTzOrr8z1OZz/DMq0WfHO+gKcz
   mdEZ75Y2AE4aUxEYeyqsGTU6FpnZ+WdR3jBbPoVBp1AcyA58dVZwMkSjs
   UB3PQfdysXnrfSdgMTzZMlsBsSmohnLAtn1BeKgdZtH2AHPxO6wsv9TPY
   NhcRZKWd2tVPfq77Qol0XDRGQZUdWXPFZfJHQ2b2GXkeCJ75rrHeEHVvU
   Rfh+HEb7GDuHamdtXYPnlkaA183sJycUDR+Vv8rYICq0j7o7a6krxEExc
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="292886417"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="292886417"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 19:18:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="585619408"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="585619408"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 02 Nov 2022 19:18:24 -0700
Received: from debox1-desk4.intel.com (unknown [10.212.195.54])
        by linux.intel.com (Postfix) with ESMTP id B46F4580DBD;
        Wed,  2 Nov 2022 19:18:23 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, hch@infradead.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, david.e.box@linux.intel.com,
        michael.a.bottini@intel.com, rafael@kernel.org, me@adhityamohan.in
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V8 4/4] PCI: vmd: Add quirk to configure PCIe ASPM and LTR
Date:   Wed,  2 Nov 2022 19:18:22 -0700
Message-Id: <20221103021822.308586-5-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221103021822.308586-1-david.e.box@linux.intel.com>
References: <20221103021822.308586-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
2.25.1

