Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A91091E51A
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2019 00:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfENWVV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 May 2019 18:21:21 -0400
Received: from mga01.intel.com ([192.55.52.88]:21188 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbfENWVD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 May 2019 18:21:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 May 2019 15:21:03 -0700
X-ExtLoop1: 1
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by fmsmga007.fm.intel.com with ESMTP; 14 May 2019 15:21:02 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v3 5/5] PCI/ACPI: Expose EDR support via _OSC to BIOS
Date:   Tue, 14 May 2019 15:18:17 -0700
Message-Id: <33fee01b1248ef53bdbad4fb5c16c81915c9e6ee.1557870869.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1557870869.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1557870869.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

As per PCI Firmware Specification, r3.2 ECN
(https://members.pcisig.com/wg/PCI-SIG/document/12614), if OS supports
EDR, it should expose its support to BIOS by setting bit 7 of _OSC
Support Field.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/acpi/pci_root.c | 3 +++
 include/linux/acpi.h    | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index a60261e50b08..aeb3fcc40e2f 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -145,6 +145,7 @@ static struct pci_osc_bit_struct pci_osc_support_bit[] = {
 	{ OSC_PCI_CLOCK_PM_SUPPORT, "ClockPM" },
 	{ OSC_PCI_SEGMENT_GROUPS_SUPPORT, "Segments" },
 	{ OSC_PCI_MSI_SUPPORT, "MSI" },
+	{ OSC_PCI_EDR_SUPPORT, "EDR" },
 };
 
 static struct pci_osc_bit_struct pci_osc_control_bit[] = {
@@ -453,6 +454,8 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 		support |= OSC_PCI_ASPM_SUPPORT | OSC_PCI_CLOCK_PM_SUPPORT;
 	if (pci_msi_enabled())
 		support |= OSC_PCI_MSI_SUPPORT;
+	if (IS_ENABLED(CONFIG_PCIE_EDR))
+		support |= OSC_PCI_EDR_SUPPORT;
 
 	decode_osc_support(root, "OS supports", support);
 	status = acpi_pci_osc_support(root, support);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index f68e9513996b..c60b7d72e526 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -513,7 +513,8 @@ extern bool osc_pc_lpi_support_confirmed;
 #define OSC_PCI_CLOCK_PM_SUPPORT		0x00000004
 #define OSC_PCI_SEGMENT_GROUPS_SUPPORT		0x00000008
 #define OSC_PCI_MSI_SUPPORT			0x00000010
-#define OSC_PCI_SUPPORT_MASKS			0x0000001f
+#define OSC_PCI_EDR_SUPPORT			0x00000080
+#define OSC_PCI_SUPPORT_MASKS			0x000000ff
 
 /* PCI Host Bridge _OSC: Capabilities DWORD 3: Control Field */
 #define OSC_PCI_EXPRESS_NATIVE_HP_CONTROL	0x00000001
-- 
2.20.1

