Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A698457A89
	for <lists+linux-pci@lfdr.de>; Sat, 20 Nov 2021 02:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236274AbhKTCBA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 21:01:00 -0500
Received: from mga05.intel.com ([192.55.52.43]:42362 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236252AbhKTCA7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Nov 2021 21:00:59 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10173"; a="320741100"
X-IronPort-AV: E=Sophos;i="5.87,249,1631602800"; 
   d="scan'208";a="320741100"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 17:57:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,249,1631602800"; 
   d="scan'208";a="551344448"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 19 Nov 2021 17:57:56 -0800
Received: from debox1-server.jf.intel.com (debox1-server.jf.intel.com [10.54.39.121])
        by linux.intel.com (Postfix) with ESMTP id 9E78E580A8B;
        Fri, 19 Nov 2021 17:57:56 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, david.e.box@linux.intel.com,
        michael.a.bottini@linux.intel.com, rafael@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] PCI: vmd: Override ASPM on TGL/ADL VMD devices
Date:   Fri, 19 Nov 2021 17:57:56 -0800
Message-Id: <20211120015756.1396263-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211120015756.1396263-1-david.e.box@linux.intel.com>
References: <20211120015756.1396263-1-david.e.box@linux.intel.com>
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
---
 drivers/pci/controller/vmd.c | 40 +++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index a45e8e59d3d4..0d0b8888cd90 100644
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
@@ -661,6 +669,27 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
 	return 0;
 }
 
+/*
+ * Override the BIOS ASPM policy and set the LTR value for PCI storage
+ * devices on the VMD bride.
+ */
+int vmd_enable_aspm(struct pci_dev *pdev, void *userdata)
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
+			pcie_aspm_policy_override(pdev);
+		}
+	}
+	return 0;
+}
+
 static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 {
 	struct pci_sysdata *sd = &vmd->sysdata;
@@ -807,6 +836,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	pci_scan_child_bus(vmd->bus);
 	pci_assign_unassigned_bus_resources(vmd->bus);
 
+	pci_walk_bus(vmd->bus, vmd_enable_aspm, &features);
+
 	/*
 	 * VMD root buses are virtual and don't return true on pci_is_pcie()
 	 * and will fail pcie_bus_configure_settings() early. It can instead be
@@ -948,15 +979,18 @@ static const struct pci_device_id vmd_ids[] = {
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

