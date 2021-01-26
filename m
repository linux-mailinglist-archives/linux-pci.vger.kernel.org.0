Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8D5304E06
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jan 2021 01:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388910AbhAZXhI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 18:37:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:50294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728020AbhAZWED (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Jan 2021 17:04:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E555C2065D;
        Tue, 26 Jan 2021 22:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611698603;
        bh=ukVXr56Kpyp29Mw5X6LFTAW7cVKyG+Whv7HoIHY331U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sad9mA4v5dJF+h/1PUktAX2JhNckulBr38HgYgdsi62MslBvICLvDrs3KX8bO6iFh
         UoEtHtDsW7vUMXdoUuf1zMSd1IejjsCaNIw2P7uzmtq1v9lKGZZd+RmjkCfUEBxH7x
         02F0DdKwe+9Gj8R4Hhv0SVIfzHyjbuNqfnnVR1D6Lg0g9Bar7QePDFZKWIox7e3Eeg
         hPiJmUnMKilTlzDcUylFJ6+7Bo0OziIRhsOSXcRVIWTCd0iX/AFnW74wbXD0Xw7lh/
         NCnjf3uE26C4zeofQQHw/tdZ5nqe2Z/HDfV9LyPuJwL2ofcVQu413HcqRtwXgBJWlz
         fzSahv/sLem2A==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Sinan Kaya <okaya@kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Sean V Kelley <sean.v.kelley@intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/3] PCI/ACPI: Remove unnecessary osc_lock
Date:   Tue, 26 Jan 2021 16:03:10 -0600
Message-Id: <20210126220311.2925565-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126220311.2925565-1-helgaas@kernel.org>
References: <20210126220311.2925565-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

9778c14b4ca2 ("ACPI/PCI: Fix possible race condition on _OSC evaluation")
added locking around _OSC calls to protect the acpi_osc_data_list that
stored the results.

63f10f0f6df4 ("PCI/ACPI: move _OSC code to pci_root.c") moved the results
from acpi_osc_data_list to the struct acpi_pci_root, where it no longer
needs locking, but did not remove the lock.

Remove the unnecessary locking around _OSC calls.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/pci_root.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 51dec352b8b8..a001f8f56b4b 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -56,8 +56,6 @@ static struct acpi_scan_handler pci_root_handler = {
 	},
 };
 
-static DEFINE_MUTEX(osc_lock);
-
 /**
  * acpi_is_root_bridge - determine whether an ACPI CA node is a PCI root bridge
  * @handle:  the ACPI CA node in question.
@@ -223,12 +221,7 @@ static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root,
 
 static acpi_status acpi_pci_osc_support(struct acpi_pci_root *root, u32 flags)
 {
-	acpi_status status;
-
-	mutex_lock(&osc_lock);
-	status = acpi_pci_query_osc(root, flags, NULL);
-	mutex_unlock(&osc_lock);
-	return status;
+	return acpi_pci_query_osc(root, flags, NULL);
 }
 
 struct acpi_pci_root *acpi_pci_find_root(acpi_handle handle)
@@ -356,7 +349,7 @@ EXPORT_SYMBOL_GPL(acpi_get_pci_dev);
 static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 req)
 {
 	struct acpi_pci_root *root;
-	acpi_status status = AE_OK;
+	acpi_status status;
 	u32 ctrl, capbuf[3];
 
 	if (!mask)
@@ -370,18 +363,16 @@ static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 r
 	if (!root)
 		return AE_NOT_EXIST;
 
-	mutex_lock(&osc_lock);
-
 	*mask = ctrl | root->osc_control_set;
 	/* No need to evaluate _OSC if the control was already granted. */
 	if ((root->osc_control_set & ctrl) == ctrl)
-		goto out;
+		return AE_OK;
 
 	/* Need to check the available controls bits before requesting them. */
 	while (*mask) {
 		status = acpi_pci_query_osc(root, root->osc_support_set, mask);
 		if (ACPI_FAILURE(status))
-			goto out;
+			return status;
 		if (ctrl == *mask)
 			break;
 		decode_osc_control(root, "platform does not support",
@@ -392,19 +383,18 @@ static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 r
 	if ((ctrl & req) != req) {
 		decode_osc_control(root, "not requesting control; platform does not support",
 				   req & ~(ctrl));
-		status = AE_SUPPORT;
-		goto out;
+		return AE_SUPPORT;
 	}
 
 	capbuf[OSC_QUERY_DWORD] = 0;
 	capbuf[OSC_SUPPORT_DWORD] = root->osc_support_set;
 	capbuf[OSC_CONTROL_DWORD] = ctrl;
 	status = acpi_pci_run_osc(handle, capbuf, mask);
-	if (ACPI_SUCCESS(status))
-		root->osc_control_set = *mask;
-out:
-	mutex_unlock(&osc_lock);
-	return status;
+	if (ACPI_FAILURE(status))
+		return status;
+
+	root->osc_control_set = *mask;
+	return AE_OK;
 }
 
 static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
-- 
2.25.1

