Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C5F3F5DD9
	for <lists+linux-pci@lfdr.de>; Tue, 24 Aug 2021 14:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237225AbhHXMVs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Aug 2021 08:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237200AbhHXMVr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Aug 2021 08:21:47 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8974DC061764;
        Tue, 24 Aug 2021 05:21:03 -0700 (PDT)
Received: from cap.home.8bytes.org (p4ff2b1ea.dip0.t-ipconnect.de [79.242.177.234])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id 0FDF6373;
        Tue, 24 Aug 2021 14:21:00 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, joro@8bytes.org, jroedel@suse.de
Subject: [PATCH v3 2/4] PCI/ACPI: Move supported and control calculations to separaten functions
Date:   Tue, 24 Aug 2021 14:20:52 +0200
Message-Id: <20210824122054.29481-3-joro@8bytes.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210824122054.29481-1-joro@8bytes.org>
References: <20210824122054.29481-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Move the calculations of supported and controled _OSC features out of
negotiate_os_control into separate functions.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/acpi/pci_root.c | 93 ++++++++++++++++++++++++-----------------
 1 file changed, 55 insertions(+), 38 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 0c3030a58219..ed4e6b55e9bc 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -396,6 +396,59 @@ static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 r
 	return AE_OK;
 }
 
+static u32 calculate_support(void)
+{
+	u32 support;
+
+	/*
+	 * All supported architectures that use ACPI have support for
+	 * PCI domains, so we indicate this in _OSC support capabilities.
+	 */
+	support = OSC_PCI_SEGMENT_GROUPS_SUPPORT;
+	support |= OSC_PCI_HPX_TYPE_3_SUPPORT;
+	if (pci_ext_cfg_avail())
+		support |= OSC_PCI_EXT_CONFIG_SUPPORT;
+	if (pcie_aspm_support_enabled())
+		support |= OSC_PCI_ASPM_SUPPORT | OSC_PCI_CLOCK_PM_SUPPORT;
+	if (pci_msi_enabled())
+		support |= OSC_PCI_MSI_SUPPORT;
+	if (IS_ENABLED(CONFIG_PCIE_EDR))
+		support |= OSC_PCI_EDR_SUPPORT;
+
+	return support;
+}
+
+static u32 calculate_control(void)
+{
+	u32 control;
+
+	control = OSC_PCI_EXPRESS_CAPABILITY_CONTROL
+		| OSC_PCI_EXPRESS_PME_CONTROL;
+
+	if (IS_ENABLED(CONFIG_PCIEASPM))
+		control |= OSC_PCI_EXPRESS_LTR_CONTROL;
+
+	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
+		control |= OSC_PCI_EXPRESS_NATIVE_HP_CONTROL;
+
+	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_SHPC))
+		control |= OSC_PCI_SHPC_NATIVE_HP_CONTROL;
+
+	if (pci_aer_available())
+		control |= OSC_PCI_EXPRESS_AER_CONTROL;
+
+	/*
+	 * Per the Downstream Port Containment Related Enhancements ECN to
+	 * the PCI Firmware Spec, r3.2, sec 4.5.1, table 4-5,
+	 * OSC_PCI_EXPRESS_DPC_CONTROL indicates the OS supports both DPC
+	 * and EDR.
+	 */
+	if (IS_ENABLED(CONFIG_PCIE_DPC) && IS_ENABLED(CONFIG_PCIE_EDR))
+		control |= OSC_PCI_EXPRESS_DPC_CONTROL;
+
+	return control;
+}
+
 static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 				 bool is_pcie)
 {
@@ -416,20 +469,7 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 		return;
 	}
 
-	/*
-	 * All supported architectures that use ACPI have support for
-	 * PCI domains, so we indicate this in _OSC support capabilities.
-	 */
-	support = OSC_PCI_SEGMENT_GROUPS_SUPPORT;
-	support |= OSC_PCI_HPX_TYPE_3_SUPPORT;
-	if (pci_ext_cfg_avail())
-		support |= OSC_PCI_EXT_CONFIG_SUPPORT;
-	if (pcie_aspm_support_enabled())
-		support |= OSC_PCI_ASPM_SUPPORT | OSC_PCI_CLOCK_PM_SUPPORT;
-	if (pci_msi_enabled())
-		support |= OSC_PCI_MSI_SUPPORT;
-	if (IS_ENABLED(CONFIG_PCIE_EDR))
-		support |= OSC_PCI_EDR_SUPPORT;
+	support = calculate_support();
 
 	decode_osc_support(root, "OS supports", support);
 	status = acpi_pci_osc_support(root, support);
@@ -456,31 +496,8 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 		return;
 	}
 
-	control = OSC_PCI_EXPRESS_CAPABILITY_CONTROL
-		| OSC_PCI_EXPRESS_PME_CONTROL;
-
-	if (IS_ENABLED(CONFIG_PCIEASPM))
-		control |= OSC_PCI_EXPRESS_LTR_CONTROL;
-
-	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
-		control |= OSC_PCI_EXPRESS_NATIVE_HP_CONTROL;
-
-	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_SHPC))
-		control |= OSC_PCI_SHPC_NATIVE_HP_CONTROL;
-
-	if (pci_aer_available())
-		control |= OSC_PCI_EXPRESS_AER_CONTROL;
-
-	/*
-	 * Per the Downstream Port Containment Related Enhancements ECN to
-	 * the PCI Firmware Spec, r3.2, sec 4.5.1, table 4-5,
-	 * OSC_PCI_EXPRESS_DPC_CONTROL indicates the OS supports both DPC
-	 * and EDR.
-	 */
-	if (IS_ENABLED(CONFIG_PCIE_DPC) && IS_ENABLED(CONFIG_PCIE_EDR))
-		control |= OSC_PCI_EXPRESS_DPC_CONTROL;
+	requested = control = calculate_control();
 
-	requested = control;
 	status = acpi_pci_osc_control_set(handle, &control,
 					  OSC_PCI_EXPRESS_CAPABILITY_CONTROL);
 	if (ACPI_SUCCESS(status)) {
-- 
2.32.0

