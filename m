Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C5F3C80BA
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jul 2021 10:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238643AbhGNI6O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Jul 2021 04:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238522AbhGNI6O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Jul 2021 04:58:14 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABE5C061760;
        Wed, 14 Jul 2021 01:55:21 -0700 (PDT)
Received: from cap.home.8bytes.org (p4ff2b1ea.dip0.t-ipconnect.de [79.242.177.234])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id AD8D1352;
        Wed, 14 Jul 2021 10:55:19 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH v2 1/2] PCI/APCI: Move acpi_pci_osc_support() check to negotiation phase
Date:   Wed, 14 Jul 2021 10:55:11 +0200
Message-Id: <20210714085512.2176-2-joro@8bytes.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210714085512.2176-1-joro@8bytes.org>
References: <20210714085512.2176-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The acpi_pci_osc_support() does an _OSC query with _OSC supported set
to what the OS supports but a zero _OSC control value, only to later
claim the features Linux wants to control with an extra _OSC query.

Nothing between the two _OSC querys depends on the result of the first
one (if successfull), and if the supported query fails the control
query will fail too. So it is a good code simplification to combine
these two querys into one.

As a result the acpi_pci_osc_support() function can be removed and
acpi_pci_query_osc() be simplified because it no longer called with a
NULL pointer for *control. Also some code duplication in the existing
error paths was consolidated.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/acpi/pci_root.c | 114 ++++++++++++++++++----------------------
 1 file changed, 52 insertions(+), 62 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index d7deedf3548e..c703832b7f7f 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -201,31 +201,20 @@ static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root,
 
 	support &= OSC_PCI_SUPPORT_MASKS;
 	support |= root->osc_support_set;
+	*control &= OSC_PCI_CONTROL_MASKS;
 
 	capbuf[OSC_QUERY_DWORD] = OSC_QUERY_ENABLE;
 	capbuf[OSC_SUPPORT_DWORD] = support;
-	if (control) {
-		*control &= OSC_PCI_CONTROL_MASKS;
-		capbuf[OSC_CONTROL_DWORD] = *control | root->osc_control_set;
-	} else {
-		/* Run _OSC query only with existing controls. */
-		capbuf[OSC_CONTROL_DWORD] = root->osc_control_set;
-	}
+	capbuf[OSC_CONTROL_DWORD] = *control | root->osc_control_set;
 
 	status = acpi_pci_run_osc(root->device->handle, capbuf, &result);
 	if (ACPI_SUCCESS(status)) {
 		root->osc_support_set = support;
-		if (control)
-			*control = result;
+		*control = result;
 	}
 	return status;
 }
 
-static acpi_status acpi_pci_osc_support(struct acpi_pci_root *root, u32 flags)
-{
-	return acpi_pci_query_osc(root, flags, NULL);
-}
-
 struct acpi_pci_root *acpi_pci_find_root(acpi_handle handle)
 {
 	struct acpi_pci_root *root;
@@ -348,7 +337,8 @@ EXPORT_SYMBOL_GPL(acpi_get_pci_dev);
  * _OSC bits the BIOS has granted control of, but its contents are meaningless
  * on failure.
  **/
-static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 req)
+static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32
+					    *mask, u32 req, u32 support)
 {
 	struct acpi_pci_root *root;
 	acpi_status status;
@@ -372,7 +362,7 @@ static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 r
 
 	/* Need to check the available controls bits before requesting them. */
 	while (*mask) {
-		status = acpi_pci_query_osc(root, root->osc_support_set, mask);
+		status = acpi_pci_query_osc(root, support, mask);
 		if (ACPI_FAILURE(status))
 			return status;
 		if (ctrl == *mask)
@@ -402,7 +392,7 @@ static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 r
 static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 				 bool is_pcie)
 {
-	u32 support, control, requested;
+	u32 support, control = 0, requested;
 	acpi_status status;
 	struct acpi_device *device = root->device;
 	acpi_handle handle = device->handle;
@@ -435,59 +425,49 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 		support |= OSC_PCI_EDR_SUPPORT;
 
 	decode_osc_support(root, "OS supports", support);
-	status = acpi_pci_osc_support(root, support);
-	if (ACPI_FAILURE(status)) {
-		*no_aspm = 1;
 
-		/* _OSC is optional for PCI host bridges */
-		if ((status == AE_NOT_FOUND) && !is_pcie)
+	if (!pcie_ports_disabled) {
+		if ((support & ACPI_PCIE_REQ_SUPPORT) != ACPI_PCIE_REQ_SUPPORT) {
+			decode_osc_support(root, "not requesting OS control; OS requires",
+					ACPI_PCIE_REQ_SUPPORT);
 			return;
+		}
 
-		dev_info(&device->dev, "_OSC: platform retains control of PCIe features (%s)\n",
-			 acpi_format_exception(status));
-		return;
-	}
-
-	if (pcie_ports_disabled) {
-		dev_info(&device->dev, "PCIe port services disabled; not requesting _OSC control\n");
-		return;
-	}
-
-	if ((support & ACPI_PCIE_REQ_SUPPORT) != ACPI_PCIE_REQ_SUPPORT) {
-		decode_osc_support(root, "not requesting OS control; OS requires",
-				   ACPI_PCIE_REQ_SUPPORT);
-		return;
-	}
-
-	control = OSC_PCI_EXPRESS_CAPABILITY_CONTROL
-		| OSC_PCI_EXPRESS_PME_CONTROL;
+		control = OSC_PCI_EXPRESS_CAPABILITY_CONTROL
+			| OSC_PCI_EXPRESS_PME_CONTROL;
 
-	if (IS_ENABLED(CONFIG_PCIEASPM))
-		control |= OSC_PCI_EXPRESS_LTR_CONTROL;
+		if (IS_ENABLED(CONFIG_PCIEASPM))
+			control |= OSC_PCI_EXPRESS_LTR_CONTROL;
 
-	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
-		control |= OSC_PCI_EXPRESS_NATIVE_HP_CONTROL;
+		if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
+			control |= OSC_PCI_EXPRESS_NATIVE_HP_CONTROL;
 
-	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_SHPC))
-		control |= OSC_PCI_SHPC_NATIVE_HP_CONTROL;
+		if (IS_ENABLED(CONFIG_HOTPLUG_PCI_SHPC))
+			control |= OSC_PCI_SHPC_NATIVE_HP_CONTROL;
 
-	if (pci_aer_available())
-		control |= OSC_PCI_EXPRESS_AER_CONTROL;
+		if (pci_aer_available())
+			control |= OSC_PCI_EXPRESS_AER_CONTROL;
 
-	/*
-	 * Per the Downstream Port Containment Related Enhancements ECN to
-	 * the PCI Firmware Spec, r3.2, sec 4.5.1, table 4-5,
-	 * OSC_PCI_EXPRESS_DPC_CONTROL indicates the OS supports both DPC
-	 * and EDR.
-	 */
-	if (IS_ENABLED(CONFIG_PCIE_DPC) && IS_ENABLED(CONFIG_PCIE_EDR))
-		control |= OSC_PCI_EXPRESS_DPC_CONTROL;
+		/*
+		 * Per the Downstream Port Containment Related Enhancements ECN to
+		 * the PCI Firmware Spec, r3.2, sec 4.5.1, table 4-5,
+		 * OSC_PCI_EXPRESS_DPC_CONTROL indicates the OS supports both DPC
+		 * and EDR.
+		 */
+		if (IS_ENABLED(CONFIG_PCIE_DPC) && IS_ENABLED(CONFIG_PCIE_EDR))
+			control |= OSC_PCI_EXPRESS_DPC_CONTROL;
+	}
 
+	/* Need an _OSC call even with pcie_ports_disabled set */
 	requested = control;
 	status = acpi_pci_osc_control_set(handle, &control,
-					  OSC_PCI_EXPRESS_CAPABILITY_CONTROL);
+					  OSC_PCI_EXPRESS_CAPABILITY_CONTROL,
+					  support);
+
 	if (ACPI_SUCCESS(status)) {
-		decode_osc_control(root, "OS now controls", control);
+		if (control)
+			decode_osc_control(root, "OS now controls", control);
+
 		if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_ASPM) {
 			/*
 			 * We have ASPM control, but the FADT indicates that
@@ -498,10 +478,8 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 			*no_aspm = 1;
 		}
 	} else {
-		decode_osc_control(root, "OS requested", requested);
-		decode_osc_control(root, "platform willing to grant", control);
-		dev_info(&device->dev, "_OSC: platform retains control of PCIe features (%s)\n",
-			acpi_format_exception(status));
+		/* Platform wants to control PCIe features */
+		root->osc_support_set = 0;
 
 		/*
 		 * We want to disable ASPM here, but aspm_disabled
@@ -511,6 +489,18 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 		 * root scan.
 		 */
 		*no_aspm = 1;
+
+		/* _OSC is optional for PCI host bridges */
+		if ((status == AE_NOT_FOUND) && !is_pcie)
+			return;
+
+		if (requested) {
+			decode_osc_control(root, "OS requested", requested);
+			decode_osc_control(root, "platform willing to grant", control);
+		}
+
+		dev_info(&device->dev, "_OSC: platform retains control of PCIe features (%s)\n",
+			acpi_format_exception(status));
 	}
 }
 
-- 
2.31.1

