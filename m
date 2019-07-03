Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8C7A5ED9B
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2019 22:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfGCUcT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jul 2019 16:32:19 -0400
Received: from mga04.intel.com ([192.55.52.120]:60930 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbfGCUcT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jul 2019 16:32:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2019 13:32:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,448,1557212400"; 
   d="scan'208";a="158089410"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by orsmga008.jf.intel.com with ESMTP; 03 Jul 2019 13:32:18 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v4 2/8] PCI/ACPI: Expose EDR support via _OSC to BIOS
Date:   Wed,  3 Jul 2019 13:29:49 -0700
Message-Id: <345e16361762a8d047a32a1380877dc0f2909559.1562185606.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1562185606.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1562185606.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

As per PCI firmware specification r3.2 Downstream Port Containment
Related Enhancements ECN, sec 4.5.1, table 4-4, if OS supports EDR,
it should expose its support to BIOS by setting bit 7 of _OSC Support
Field.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/acpi/pci_root.c | 3 +++
 include/linux/acpi.h    | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index fa35c2b5b998..361f8b177c6c 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -132,6 +132,7 @@ static struct pci_osc_bit_struct pci_osc_support_bit[] = {
 	{ OSC_PCI_CLOCK_PM_SUPPORT, "ClockPM" },
 	{ OSC_PCI_SEGMENT_GROUPS_SUPPORT, "Segments" },
 	{ OSC_PCI_MSI_SUPPORT, "MSI" },
+	{ OSC_PCI_EDR_SUPPORT, "EDR" },
 	{ OSC_PCI_HPX_TYPE_3_SUPPORT, "HPX-Type3" },
 };
 
@@ -442,6 +443,8 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 		support |= OSC_PCI_ASPM_SUPPORT | OSC_PCI_CLOCK_PM_SUPPORT;
 	if (pci_msi_enabled())
 		support |= OSC_PCI_MSI_SUPPORT;
+	if (IS_ENABLED(CONFIG_PCIE_EDR))
+		support |= OSC_PCI_EDR_SUPPORT;
 
 	decode_osc_support(root, "OS supports", support);
 	status = acpi_pci_osc_support(root, support);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 61ab40bff45c..24ac0435ef3b 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -504,6 +504,7 @@ extern bool osc_pc_lpi_support_confirmed;
 #define OSC_PCI_CLOCK_PM_SUPPORT		0x00000004
 #define OSC_PCI_SEGMENT_GROUPS_SUPPORT		0x00000008
 #define OSC_PCI_MSI_SUPPORT			0x00000010
+#define OSC_PCI_EDR_SUPPORT			0x00000080
 #define OSC_PCI_HPX_TYPE_3_SUPPORT		0x00000100
 #define OSC_PCI_SUPPORT_MASKS			0x0000011f
 
-- 
2.21.0

