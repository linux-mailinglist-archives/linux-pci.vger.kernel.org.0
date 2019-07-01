Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 611475C46A
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2019 22:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfGAUpS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jul 2019 16:45:18 -0400
Received: from xes-mad.com ([162.248.234.2]:9098 "EHLO mail.xes-mad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbfGAUpR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Jul 2019 16:45:17 -0400
Received: from asierra1.xes-mad.com (asierra1.xes-mad.com [10.52.16.65])
        by mail.xes-mad.com (Postfix) with ESMTP id 076D420357;
        Mon,  1 Jul 2019 15:45:16 -0500 (CDT)
From:   Aaron Sierra <asierra@xes-inc.com>
To:     linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v4 2/3] PCI/ACPI: Allow _OSC request without ASPM support
Date:   Mon,  1 Jul 2019 15:45:14 -0500
Message-Id: <20190701204515.23374-3-asierra@xes-inc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190701204515.23374-1-asierra@xes-inc.com>
References: <20190213213242.21920-1-git-send-email-asierra@xes-inc.com>
 <20190701204515.23374-1-asierra@xes-inc.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some use cases favor resiliency over efficiency. In my company's case,
the power savings offered by Active State Power Management (ASPM) are
entirely secondary to ensuring robust operation. For that same reason we
want to stay aware of events reportable via Advanced Error Reporting
(AER). We found, on x86 platforms, that AER has an erroneous implicit
dependency on ASPM within negotiate_os_control().

This patch updates negotiate_os_control() to be less ASPM-centric in
order to allow other features (notably AER) to work without enabling
ASPM (either at compile time or at run time).

Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
---
 drivers/acpi/pci_root.c | 49 +++++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 21aa56f9ca54..9b8a44391ea0 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -53,9 +53,13 @@ static int acpi_pci_root_scan_dependent(struct acpi_device *adev)
 }
 
 #define ACPI_PCIE_REQ_SUPPORT (OSC_PCI_EXT_CONFIG_SUPPORT \
-				| OSC_PCI_ASPM_SUPPORT \
-				| OSC_PCI_CLOCK_PM_SUPPORT \
 				| OSC_PCI_MSI_SUPPORT)
+#define ACPI_PCIE_ASPM_SUPPORT (ACPI_PCIE_REQ_SUPPORT \
+				| OSC_PCI_ASPM_SUPPORT \
+				| OSC_PCI_CLOCK_PM_SUPPORT)
+#define OSC_CONTROL_BITS_ASPM (OSC_PCI_EXPRESS_CAPABILITY_CONTROL \
+				| OSC_PCI_EXPRESS_LTR_CONTROL \
+				| OSC_PCI_EXPRESS_PME_CONTROL)
 
 static const struct acpi_device_id root_device_ids[] = {
 	{"PNP0A03", 0},
@@ -422,6 +426,11 @@ acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 req)
 }
 EXPORT_SYMBOL(acpi_pci_osc_control_set);
 
+static inline bool osc_have_support(u32 support, u32 required)
+{
+	return ((support & required) == required);
+}
+
 static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 				 bool is_pcie)
 {
@@ -475,38 +484,47 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 		return;
 	}
 
-	if ((support & ACPI_PCIE_REQ_SUPPORT) != ACPI_PCIE_REQ_SUPPORT) {
+	/*
+	 * Require the least restrictive set needed to satisfy at least one
+	 * kernel feature.
+	 */
+	if (!osc_have_support(support, ACPI_PCIE_REQ_SUPPORT)) {
 		decode_osc_support(root, "not requesting OS control; OS requires",
 				   ACPI_PCIE_REQ_SUPPORT);
 		return;
 	}
 
-	control = OSC_PCI_EXPRESS_CAPABILITY_CONTROL
-		| OSC_PCI_EXPRESS_PME_CONTROL;
+	control = 0;
+
+	if (osc_have_support(support, ACPI_PCIE_ASPM_SUPPORT))
+		control |= OSC_CONTROL_BITS_ASPM;
 
-	if (IS_ENABLED(CONFIG_PCIEASPM))
-		control |= OSC_PCI_EXPRESS_LTR_CONTROL;
+	if (!control)
+		*no_aspm = 1;
 
 	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
-		control |= OSC_PCI_EXPRESS_NATIVE_HP_CONTROL;
+		control |= OSC_PCI_EXPRESS_CAPABILITY_CONTROL |
+			   OSC_PCI_EXPRESS_NATIVE_HP_CONTROL;
 
 	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_SHPC))
-		control |= OSC_PCI_SHPC_NATIVE_HP_CONTROL;
+		control |= OSC_PCI_EXPRESS_CAPABILITY_CONTROL |
+			   OSC_PCI_SHPC_NATIVE_HP_CONTROL;
 
 	if (pci_aer_available()) {
 		if (aer_acpi_firmware_first())
 			dev_info(&device->dev,
 				 "PCIe AER handled by firmware\n");
 		else
-			control |= OSC_PCI_EXPRESS_AER_CONTROL;
+			control |= OSC_PCI_EXPRESS_CAPABILITY_CONTROL |
+				   OSC_PCI_EXPRESS_AER_CONTROL;
 	}
 
 	requested = control;
-	status = acpi_pci_osc_control_set(handle, &control,
-					  OSC_PCI_EXPRESS_CAPABILITY_CONTROL);
+	acpi_pci_osc_control_set(handle, &control, 0);
 	decode_osc_control(root, "OS requested", requested);
 	decode_osc_control(root, "platform granted", control);
-	if (ACPI_SUCCESS(status)) {
+
+	if (osc_have_support(control, OSC_CONTROL_BITS_ASPM)) {
 		if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_ASPM) {
 			/*
 			 * We have ASPM control, but the FADT indicates that
@@ -516,9 +534,8 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 			dev_info(&device->dev, "FADT indicates ASPM is unsupported, using BIOS configuration\n");
 			*no_aspm = 1;
 		}
-	} else {
-		dev_info(&device->dev, "_OSC failed (%s); disabling ASPM\n",
-			acpi_format_exception(status));
+	} else if (!*no_aspm) {
+		dev_info(&device->dev, "_OSC failed; disabling ASPM\n");
 
 		/*
 		 * We want to disable ASPM here, but aspm_disabled
-- 
2.17.1

