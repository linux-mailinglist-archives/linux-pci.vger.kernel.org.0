Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C1246C894
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 01:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbhLHAZr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Dec 2021 19:25:47 -0500
Received: from mga06.intel.com ([134.134.136.31]:24068 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229662AbhLHAZr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Dec 2021 19:25:47 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="298518384"
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="298518384"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 16:20:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="563883182"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 07 Dec 2021 16:20:45 -0800
Received: from debox1-desk4.hsd1.or.comcast.net (unknown [10.251.18.198])
        by linux.intel.com (Postfix) with ESMTP id 242975804B4;
        Tue,  7 Dec 2021 16:20:45 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, kw@linux.com, bhelgaas@google.com,
        david.e.box@linux.intel.com, michael.a.bottini@linux.intel.com,
        rafael@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adhitya Mohan <me@adhityamohan.in>
Subject: [PATCH V2 2/2] PCI: vmd: Override ASPM on TGL/ADL VMD devices
Date:   Tue,  7 Dec 2021 16:20:43 -0800
Message-Id: <20211208002043.882200-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208002043.882200-1-david.e.box@linux.intel.com>
References: <20211208002043.882200-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Michael Bottini <michael.a.bottini@linux.intel.com>

On Tiger Lake and Alder Lake platforms, VMD controllers do not have ASPM
enabled nor LTR values set by BIOS. This leads high power consumption on
these platforms when VMD is enabled as reported in bugzilla [1].  Enable
these features in the VMD driver using pcie_aspm_policy_override() to set
the ASPM policy for the root ports.

To do this, add an additional flag in VMD features to specify devices that
must have their respective policies overridden.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=213717

Signed-off-by: Michael Bottini <michael.a.bottini@linux.intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Tested-by: Adhitya Mohan <me@adhityamohan.in>
---
V2
 - Use return status to print pci_info message if ASPM cannot be enabled.
 - Add missing static declaration, caught by lkp@intel.com

 drivers/pci/controller/vmd.c | 42 +++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index a45e8e59d3d4..e555dcae73cc 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -20,6 +20,8 @@
 
 #include <asm/irqdomain.h>
 
+#include "../pci.h"
+
 #define VMD_CFGBAR	0
 #define VMD_MEMBAR1	2
 #define VMD_MEMBAR2	4
@@ -67,6 +69,12 @@ enum vmd_features {
 	 * interrupt handling.
 	 */
 	VMD_FEAT_CAN_BYPASS_MSI_REMAP		= (1 << 4),
+
+	/*
+	 * Device must have ASPM policy overridden, as its default policy is
+	 * incorrect.
+	 */
+	VMD_FEAT_QUIRK_OVERRIDE_ASPM		= (1 << 5),
 };
 
 static DEFINE_IDA(vmd_instance_ida);
@@ -661,6 +669,29 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
 	return 0;
 }
 
+/*
+ * Override the BIOS ASPM policy and set the LTR value for PCI storage
+ * devices on the VMD bride.
+ */
+static int vmd_enable_aspm(struct pci_dev *pdev, void *userdata)
+{
+	int features = *(int *)userdata;
+
+	if (features & VMD_FEAT_QUIRK_OVERRIDE_ASPM &&
+	    pdev->class == PCI_CLASS_STORAGE_EXPRESS) {
+		int pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_LTR);
+
+		if (pos) {
+			pci_write_config_word(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, 0x1003);
+			pci_write_config_word(pdev, pos + PCI_LTR_MAX_NOSNOOP_LAT, 0x1003);
+			if (pcie_aspm_policy_override(pdev))
+				pci_info(pdev, "Unable of override ASPM policy\n");
+		}
+	}
+
+	return 0;
+}
+
 static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 {
 	struct pci_sysdata *sd = &vmd->sysdata;
@@ -807,6 +838,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	pci_scan_child_bus(vmd->bus);
 	pci_assign_unassigned_bus_resources(vmd->bus);
 
+	pci_walk_bus(vmd->bus, vmd_enable_aspm, &features);
+
 	/*
 	 * VMD root buses are virtual and don't return true on pci_is_pcie()
 	 * and will fail pcie_bus_configure_settings() early. It can instead be
@@ -948,15 +981,18 @@ static const struct pci_device_id vmd_ids[] = {
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x467f),
 		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
 				VMD_FEAT_HAS_BUS_RESTRICTIONS |
-				VMD_FEAT_OFFSET_FIRST_VECTOR,},
+				VMD_FEAT_OFFSET_FIRST_VECTOR |
+				VMD_FEAT_QUIRK_OVERRIDE_ASPM,},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x4c3d),
 		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
 				VMD_FEAT_HAS_BUS_RESTRICTIONS |
-				VMD_FEAT_OFFSET_FIRST_VECTOR,},
+				VMD_FEAT_OFFSET_FIRST_VECTOR |
+				VMD_FEAT_QUIRK_OVERRIDE_ASPM,},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
 		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
 				VMD_FEAT_HAS_BUS_RESTRICTIONS |
-				VMD_FEAT_OFFSET_FIRST_VECTOR,},
+				VMD_FEAT_OFFSET_FIRST_VECTOR |
+				VMD_FEAT_QUIRK_OVERRIDE_ASPM,},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, vmd_ids);
-- 
2.25.1

