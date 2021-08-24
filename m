Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF9D3F5DE0
	for <lists+linux-pci@lfdr.de>; Tue, 24 Aug 2021 14:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237243AbhHXMVv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Aug 2021 08:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237219AbhHXMVs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Aug 2021 08:21:48 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C15C061757;
        Tue, 24 Aug 2021 05:21:04 -0700 (PDT)
Received: from cap.home.8bytes.org (p4ff2b1ea.dip0.t-ipconnect.de [79.242.177.234])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id CDC26922;
        Tue, 24 Aug 2021 14:21:00 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, joro@8bytes.org, jroedel@suse.de
Subject: [PATCH v3 4/4] PCI/ACPI: Check for _OSC support in acpi_pci_osc_control_set()
Date:   Tue, 24 Aug 2021 14:20:54 +0200
Message-Id: <20210824122054.29481-5-joro@8bytes.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210824122054.29481-1-joro@8bytes.org>
References: <20210824122054.29481-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Get rid of acpi_pci_osc_support() and check for _OSC supported features
directly in acpi_pci_osc_control_set(). There is no point in doing an
unconditional _OSC query with control=0 even when the kernel later wants
to take control over more features.

This safes one _OSC query and simplifies the code by getting rid of
the acpi_pci_osc_support() function. As a side effect, the !control
checks in acpi_pci_query_osc() can also be removed.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/acpi/pci_root.c | 81 ++++++++++++++++-------------------------
 1 file changed, 32 insertions(+), 49 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index f12e512bcddc..ab2f7dfb0c44 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -203,26 +203,16 @@ static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root,
 
 	capbuf[OSC_QUERY_DWORD] = OSC_QUERY_ENABLE;
 	capbuf[OSC_SUPPORT_DWORD] = support;
-	if (control)
-		capbuf[OSC_CONTROL_DWORD] = *control | root->osc_control_set;
-	else
-		/* Run _OSC query only with existing controls. */
-		capbuf[OSC_CONTROL_DWORD] = root->osc_control_set;
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
@@ -345,8 +335,9 @@ EXPORT_SYMBOL_GPL(acpi_get_pci_dev);
  * _OSC bits the BIOS has granted control of, but its contents are meaningless
  * on failure.
  **/
-static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 req)
+static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 support)
 {
+	u32 req = OSC_PCI_EXPRESS_CAPABILITY_CONTROL;
 	struct acpi_pci_root *root;
 	acpi_status status;
 	u32 ctrl, capbuf[3];
@@ -354,22 +345,16 @@ static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 r
 	if (!mask)
 		return AE_BAD_PARAMETER;
 
-	ctrl = *mask;
-	if ((ctrl & req) != req)
-		return AE_TYPE;
-
 	root = acpi_pci_find_root(handle);
 	if (!root)
 		return AE_NOT_EXIST;
 
-	*mask = ctrl | root->osc_control_set;
-	/* No need to evaluate _OSC if the control was already granted. */
-	if ((root->osc_control_set & ctrl) == ctrl)
-		return AE_OK;
+	ctrl   = *mask;
+	*mask |= root->osc_control_set;
 
 	/* Need to check the available controls bits before requesting them. */
-	while (*mask) {
-		status = acpi_pci_query_osc(root, root->osc_support_set, mask);
+	do {
+		status = acpi_pci_query_osc(root, support, mask);
 		if (ACPI_FAILURE(status))
 			return status;
 		if (ctrl == *mask)
@@ -377,7 +362,11 @@ static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 r
 		decode_osc_control(root, "platform does not support",
 				   ctrl & ~(*mask));
 		ctrl = *mask;
-	}
+	} while (*mask);
+
+	/* No need to request _OSC if the control was already granted. */
+	if ((root->osc_control_set & ctrl) == ctrl)
+		return AE_OK;
 
 	if ((ctrl & req) != req) {
 		decode_osc_control(root, "not requesting control; platform does not support",
@@ -470,7 +459,7 @@ static bool os_control_query_checks(struct acpi_pci_root *root, u32 support)
 static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 				 bool is_pcie)
 {
-	u32 support, control, requested;
+	u32 support, control = 0, requested = 0;
 	acpi_status status;
 	struct acpi_device *device = root->device;
 	acpi_handle handle = device->handle;
@@ -490,28 +479,15 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 	support = calculate_support();
 
 	decode_osc_support(root, "OS supports", support);
-	status = acpi_pci_osc_support(root, support);
-	if (ACPI_FAILURE(status)) {
-		*no_aspm = 1;
-
-		/* _OSC is optional for PCI host bridges */
-		if ((status == AE_NOT_FOUND) && !is_pcie)
-			return;
-
-		dev_info(&device->dev, "_OSC: platform retains control of PCIe features (%s)\n",
-			 acpi_format_exception(status));
-		return;
-	}
-
-	if (!os_control_query_checks(root, support))
-		return;
 
-	requested = control = calculate_control();
+	if (os_control_query_checks(root, support))
+		requested = control = calculate_control();
 
-	status = acpi_pci_osc_control_set(handle, &control,
-					  OSC_PCI_EXPRESS_CAPABILITY_CONTROL);
+	status = acpi_pci_osc_control_set(handle, &control, support);
 	if (ACPI_SUCCESS(status)) {
-		decode_osc_control(root, "OS now controls", control);
+		if (control)
+			decode_osc_control(root, "OS now controls", control);
+
 		if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_ASPM) {
 			/*
 			 * We have ASPM control, but the FADT indicates that
@@ -522,11 +498,6 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 			*no_aspm = 1;
 		}
 	} else {
-		decode_osc_control(root, "OS requested", requested);
-		decode_osc_control(root, "platform willing to grant", control);
-		dev_info(&device->dev, "_OSC: platform retains control of PCIe features (%s)\n",
-			acpi_format_exception(status));
-
 		/*
 		 * We want to disable ASPM here, but aspm_disabled
 		 * needs to remain in its state from boot so that we
@@ -535,6 +506,18 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 		 * root scan.
 		 */
 		*no_aspm = 1;
+
+		/* _OSC is optional for PCI host bridges */
+		if ((status == AE_NOT_FOUND) && !is_pcie)
+			return;
+
+		if (control) {
+			decode_osc_control(root, "OS requested", requested);
+			decode_osc_control(root, "platform willing to grant", control);
+		}
+
+		dev_info(&device->dev, "_OSC: platform retains control of PCIe features (%s)\n",
+			 acpi_format_exception(status));
 	}
 }
 
-- 
2.32.0

