Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07C935C469
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2019 22:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfGAUpR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jul 2019 16:45:17 -0400
Received: from xes-mad.com ([162.248.234.2]:52385 "EHLO mail.xes-mad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbfGAUpR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Jul 2019 16:45:17 -0400
Received: from asierra1.xes-mad.com (asierra1.xes-mad.com [10.52.16.65])
        by mail.xes-mad.com (Postfix) with ESMTP id 17D582035F;
        Mon,  1 Jul 2019 15:45:16 -0500 (CDT)
From:   Aaron Sierra <asierra@xes-inc.com>
To:     linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v4 3/3] PCI/ACPI: Refactor _OSC request bit setting
Date:   Mon,  1 Jul 2019 15:45:15 -0500
Message-Id: <20190701204515.23374-4-asierra@xes-inc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190701204515.23374-1-asierra@xes-inc.com>
References: <20190213213242.21920-1-git-send-email-asierra@xes-inc.com>
 <20190701204515.23374-1-asierra@xes-inc.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Provide an inline function for each feature (ASPM, PCIe hotplug, SHPC
hotplug, and AER) to set its _OSC requests after performing any
sanity checks that it needs. This is intended to improve
readability/maintenance.

Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
---
 drivers/acpi/pci_root.c | 75 ++++++++++++++++++++++++++++++-----------
 1 file changed, 55 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 9b8a44391ea0..4e499bb23352 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -431,6 +431,54 @@ static inline bool osc_have_support(u32 support, u32 required)
 	return ((support & required) == required);
 }
 
+static inline u32 osc_get_aspm_control_bits(struct acpi_pci_root *root,
+					    u32 support)
+{
+	if (osc_have_support(support, ACPI_PCIE_ASPM_SUPPORT))
+		return OSC_CONTROL_BITS_ASPM;
+
+	return 0;
+}
+
+static inline u32 osc_get_pciehp_control_bits(struct acpi_pci_root *root,
+					      u32 support)
+{
+	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE) &&
+	    osc_have_support(support, ACPI_PCIE_REQ_SUPPORT)) {
+		return OSC_PCI_EXPRESS_CAPABILITY_CONTROL |
+		       OSC_PCI_EXPRESS_NATIVE_HP_CONTROL;
+	}
+
+	return 0;
+}
+
+static inline u32 osc_get_shpchp_control_bits(struct acpi_pci_root *root,
+					      u32 support)
+{
+	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_SHPC) &&
+	    osc_have_support(support, ACPI_PCIE_REQ_SUPPORT)) {
+		return OSC_PCI_EXPRESS_CAPABILITY_CONTROL |
+		       OSC_PCI_SHPC_NATIVE_HP_CONTROL;
+	}
+
+	return 0;
+}
+
+static inline u32 osc_get_aer_control_bits(struct acpi_pci_root *root,
+					   u32 support)
+{
+	if (!pci_aer_available() ||
+	    !osc_have_support(support, ACPI_PCIE_REQ_SUPPORT))
+		return 0;
+
+	if (aer_acpi_firmware_first()) {
+		dev_info(&root->device->dev, "PCIe AER handled by firmware\n");
+		return 0;
+	}
+
+	return OSC_PCI_EXPRESS_CAPABILITY_CONTROL | OSC_PCI_EXPRESS_AER_CONTROL;
+}
+
 static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 				 bool is_pcie)
 {
@@ -494,29 +542,16 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 		return;
 	}
 
-	control = 0;
-
-	if (osc_have_support(support, ACPI_PCIE_ASPM_SUPPORT))
-		control |= OSC_CONTROL_BITS_ASPM;
-
+	control = osc_get_aspm_control_bits(root, support);
 	if (!control)
 		*no_aspm = 1;
 
-	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
-		control |= OSC_PCI_EXPRESS_CAPABILITY_CONTROL |
-			   OSC_PCI_EXPRESS_NATIVE_HP_CONTROL;
-
-	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_SHPC))
-		control |= OSC_PCI_EXPRESS_CAPABILITY_CONTROL |
-			   OSC_PCI_SHPC_NATIVE_HP_CONTROL;
-
-	if (pci_aer_available()) {
-		if (aer_acpi_firmware_first())
-			dev_info(&device->dev,
-				 "PCIe AER handled by firmware\n");
-		else
-			control |= OSC_PCI_EXPRESS_CAPABILITY_CONTROL |
-				   OSC_PCI_EXPRESS_AER_CONTROL;
+	control |= osc_get_pciehp_control_bits(root, support);
+	control |= osc_get_shpchp_control_bits(root, support);
+	control |= osc_get_aer_control_bits(root, support);
+	if (!control) {
+		dev_info(&device->dev, "_OSC: not requesting OS control\n");
+		return;
 	}
 
 	requested = control;
-- 
2.17.1

