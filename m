Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7973C60C0DC
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 03:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiJYBUB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Oct 2022 21:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbiJYBTe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Oct 2022 21:19:34 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B87812AE0;
        Mon, 24 Oct 2022 17:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666658671; x=1698194671;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fN9HAQE3rJNLtGFESkED7VR9H0aD8zu7Jg563TgKGYI=;
  b=dp4hkADL/2VK1H8NY6RSWv0UrC//dbB1X7mOgeLrCY4voEwGxOc86RL/
   InPAXoqujVrubjtiM0OuvzT5pkDaJfpr9UrWxZdacXR+u2NIAaRaAIxdc
   h5tqh00v6jz2lf+r+oc+4s2UBSopslmkFNnvy4K0J4S+mda5TBLVeXisH
   lGHUr7/vDHxXZOlya6W86pJYAsztUgVibGxeFNdYn6I3ScpaOSrdnIeX9
   fE2djQtyR+g3IYmgTptxd5Qga2oBksRx+AgFaf+T1PFwdEz4ngMMuj1V6
   JOQc/6WZo9WD/5GOCDVkfFM3JTY5s0uMd/akYtiAoZQwzpukriTrpxH6z
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="371771375"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="371771375"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 17:44:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="631454276"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="631454276"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 24 Oct 2022 17:44:12 -0700
Received: from debox1-desk4.intel.com (unknown [10.209.125.134])
        by linux.intel.com (Postfix) with ESMTP id A5440580DC8;
        Mon, 24 Oct 2022 17:44:12 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, hch@infradead.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, david.e.box@linux.intel.com,
        michael.a.bottini@intel.com, rafael@kernel.org, me@adhityamohan.in
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V7 4/4] PCI: vmd: Add quirk to configure PCIe ASPM and LTR
Date:   Mon, 24 Oct 2022 17:44:11 -0700
Message-Id: <20221025004411.2910026-5-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025004411.2910026-1-david.e.box@linux.intel.com>
References: <20221025004411.2910026-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On some platforms, PCIe ports reserved for VMD use are not visible to BIOS
and therefore not configured to enable PCIe ASPM or LTR values (which BIOS
will configure if they are not set). Lack of this programming results in
high power consumption on laptops as reported in several open bugzillas.
For the affected platforms use pci_enable_link_state to set the allowed
link states for devices on the root ports. Also set the LTR value to the
maximum value needed for the SoC.

This workaround applies to Rocket Lake, Tiger Lake, Alder Lake, and Raptor
Lake, though the latter has already implemented LTR configuring in BIOS.
Future products will move ASPM configuration back to BIOS.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=212355
Link: https://bugzilla.kernel.org/show_bug.cgi?id=215063
Link: https://bugzilla.kernel.org/show_bug.cgi?id=213717
Signed-off-by: Michael Bottini <michael.a.bottini@linux.intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Jon Derrick <jonathan.derrick@linux.dev>
Reviewed-by: Nirmal Patel <nirmal.patel@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 74 +++++++++++++++++++++++++++++++++---
 1 file changed, 68 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index a53d88fd820c..bb7e9195bc18 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -66,10 +66,19 @@ enum vmd_features {
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
@@ -713,6 +722,45 @@ static void vmd_copy_host_bridge_flags(struct pci_host_bridge *root_bridge,
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
+	ltr_reg = (info->ltr << 16) | info->ltr;
+	pci_write_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, ltr_reg);
+	pci_info(pdev, "VMD: Default LTR value set by driver\n");
+
+	return 0;
+}
+
 static int vmd_enable_domain(struct vmd_dev *vmd, struct vmd_device_data *info)
 {
 	struct pci_sysdata *sd = &vmd->sysdata;
@@ -868,6 +916,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, struct vmd_device_data *info)
 		pci_reset_bus(child->self);
 	pci_assign_unassigned_bus_resources(vmd->bus);
 
+	pci_walk_bus(vmd->bus, vmd_pm_enable_quirk, info);
+
 	/*
 	 * VMD root buses are virtual and don't return true on pci_is_pcie()
 	 * and will fail pcie_bus_configure_settings() early. It can instead be
@@ -1016,42 +1066,54 @@ static const struct pci_device_id vmd_ids[] = {
 		(kernel_ulong_t)&(struct vmd_device_data) {
 			.features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
 				    VMD_FEAT_HAS_BUS_RESTRICTIONS |
-				    VMD_FEAT_OFFSET_FIRST_VECTOR,
+				    VMD_FEAT_OFFSET_FIRST_VECTOR |
+				    VMD_FEAT_BIOS_PM_QUIRK,
+			.ltr = 0x1003, /* 3145728 ns */
 		},
 	},
 	{PCI_VDEVICE(INTEL, 0x4c3d),
 		(kernel_ulong_t)&(struct vmd_device_data) {
 			.features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
 				    VMD_FEAT_HAS_BUS_RESTRICTIONS |
-				    VMD_FEAT_OFFSET_FIRST_VECTOR,
+				    VMD_FEAT_OFFSET_FIRST_VECTOR |
+				    VMD_FEAT_BIOS_PM_QUIRK,
+			.ltr = 0x1003, /* 3145728 ns */
 		},
 	},
 	{PCI_VDEVICE(INTEL, 0xa77f),
 		(kernel_ulong_t)&(struct vmd_device_data) {
 			.features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
 				    VMD_FEAT_HAS_BUS_RESTRICTIONS |
-				    VMD_FEAT_OFFSET_FIRST_VECTOR,
+				    VMD_FEAT_OFFSET_FIRST_VECTOR |
+				    VMD_FEAT_BIOS_PM_QUIRK,
+			.ltr = 0x1003, /* 3145728 ns */
 		},
 	},
 	{PCI_VDEVICE(INTEL, 0x7d0b),
 		(kernel_ulong_t)&(struct vmd_device_data) {
 			.features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
 				    VMD_FEAT_HAS_BUS_RESTRICTIONS |
-				    VMD_FEAT_OFFSET_FIRST_VECTOR,
+				    VMD_FEAT_OFFSET_FIRST_VECTOR |
+				    VMD_FEAT_BIOS_PM_QUIRK,
+			.ltr = 0x1003, /* 3145728 ns */
 		},
 	},
 	{PCI_VDEVICE(INTEL, 0xad0b),
 		(kernel_ulong_t)&(struct vmd_device_data) {
 			.features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
 				    VMD_FEAT_HAS_BUS_RESTRICTIONS |
-				    VMD_FEAT_OFFSET_FIRST_VECTOR,
+				    VMD_FEAT_OFFSET_FIRST_VECTOR |
+				    VMD_FEAT_BIOS_PM_QUIRK,
+			.ltr = 0x1003, /* 3145728 ns */
 		},
 	},
 	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
 		(kernel_ulong_t)&(struct vmd_device_data) {
 			.features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
 				    VMD_FEAT_HAS_BUS_RESTRICTIONS |
-				    VMD_FEAT_OFFSET_FIRST_VECTOR,
+				    VMD_FEAT_OFFSET_FIRST_VECTOR |
+				    VMD_FEAT_BIOS_PM_QUIRK,
+			.ltr = 0x1003, /* 3145728 ns */
 		},
 	},
 	{0,}
-- 
2.25.1

