Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 531CE178878
	for <lists+linux-pci@lfdr.de>; Wed,  4 Mar 2020 03:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387637AbgCDCjK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 21:39:10 -0500
Received: from mga07.intel.com ([134.134.136.100]:56583 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387631AbgCDCjI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Mar 2020 21:39:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 18:39:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400"; 
   d="scan'208";a="233866922"
Received: from skuppusw-desk.jf.intel.com ([10.7.201.16])
  by orsmga008.jf.intel.com with ESMTP; 03 Mar 2020 18:39:06 -0800
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Huong Nguyen <huong.nguyen@dell.com>,
        Austin Bolen <Austin.Bolen@dell.com>
Subject: [PATCH v17 12/12] PCI/ACPI: Enable EDR support
Date:   Tue,  3 Mar 2020 18:36:35 -0800
Message-Id: <246aa05acca8f0a7e6d20a65ab05af0027f60118.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

As per PCI firmware specification r3.2 Downstream Port Containment
Related Enhancements ECN, sec 4.5.1, OS must implement following steps
to enable/use EDR feature.

1. OS can use bit 7 of _OSC Control Field to negotiate control over
Downstream Port Containment (DPC) configuration of PCIe port. After _OSC
negotiation, firmware will Set this bit to grant OS control over PCIe
DPC configuration and Clear it if this feature was requested and denied,
or was not requested.

2. Also, if OS supports EDR, it should expose its support to BIOS by
setting bit 7 of _OSC Support Field. And if OS sets bit 7 of _OSC
Control Field it must also expose support for EDR by setting bit 7 of
_OSC Support Field.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Keith Busch <keith.busch@intel.com>
Tested-by: Huong Nguyen <huong.nguyen@dell.com>
Tested-by: Austin Bolen <Austin.Bolen@dell.com>
---
 drivers/acpi/pci_root.c | 16 ++++++++++++++++
 drivers/pci/pcie/edr.c  |  4 +++-
 drivers/pci/probe.c     |  1 +
 include/linux/acpi.h    |  6 ++++--
 include/linux/pci.h     |  1 +
 5 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index d1e666ef3fcc..ad1be5941a00 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -131,6 +131,7 @@ static struct pci_osc_bit_struct pci_osc_support_bit[] = {
 	{ OSC_PCI_CLOCK_PM_SUPPORT, "ClockPM" },
 	{ OSC_PCI_SEGMENT_GROUPS_SUPPORT, "Segments" },
 	{ OSC_PCI_MSI_SUPPORT, "MSI" },
+	{ OSC_PCI_EDR_SUPPORT, "EDR" },
 	{ OSC_PCI_HPX_TYPE_3_SUPPORT, "HPX-Type3" },
 };
 
@@ -141,6 +142,7 @@ static struct pci_osc_bit_struct pci_osc_control_bit[] = {
 	{ OSC_PCI_EXPRESS_AER_CONTROL, "AER" },
 	{ OSC_PCI_EXPRESS_CAPABILITY_CONTROL, "PCIeCapability" },
 	{ OSC_PCI_EXPRESS_LTR_CONTROL, "LTR" },
+	{ OSC_PCI_EXPRESS_DPC_CONTROL, "DPC" },
 };
 
 static void decode_osc_bits(struct acpi_pci_root *root, char *msg, u32 word,
@@ -440,6 +442,8 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 		support |= OSC_PCI_ASPM_SUPPORT | OSC_PCI_CLOCK_PM_SUPPORT;
 	if (pci_msi_enabled())
 		support |= OSC_PCI_MSI_SUPPORT;
+	if (IS_ENABLED(CONFIG_PCIE_EDR))
+		support |= OSC_PCI_EDR_SUPPORT;
 
 	decode_osc_support(root, "OS supports", support);
 	status = acpi_pci_osc_support(root, support);
@@ -487,6 +491,16 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 			control |= OSC_PCI_EXPRESS_AER_CONTROL;
 	}
 
+	/*
+	 * Per the Downstream Port Containment Related Enhancements ECN to
+	 * the PCI Firmware Spec, r3.2, sec 4.5.1, table 4-5,
+	 * OSC_PCI_EXPRESS_DPC_CONTROL indicates the OS supports both DPC
+	 * and EDR. So use CONFIG_PCIE_EDR for requesting DPC control which
+	 * will only be turned on if both EDR and DPC is enabled.
+	 */
+	if (IS_ENABLED(CONFIG_PCIE_EDR))
+		control |= OSC_PCI_EXPRESS_DPC_CONTROL;
+
 	requested = control;
 	status = acpi_pci_osc_control_set(handle, &control,
 					  OSC_PCI_EXPRESS_CAPABILITY_CONTROL);
@@ -916,6 +930,8 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 		host_bridge->native_pme = 0;
 	if (!(root->osc_control_set & OSC_PCI_EXPRESS_LTR_CONTROL))
 		host_bridge->native_ltr = 0;
+	if (!(root->osc_control_set & OSC_PCI_EXPRESS_DPC_CONTROL))
+		host_bridge->native_dpc = 0;
 
 	/*
 	 * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
index 2d8680be0302..45d165e838bb 100644
--- a/drivers/pci/pcie/edr.c
+++ b/drivers/pci/pcie/edr.c
@@ -195,6 +195,7 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
 void pci_acpi_add_edr_notifier(struct pci_dev *pdev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
+	struct pci_host_bridge *host = pci_find_host_bridge(pdev->bus);
 	acpi_status astatus;
 
 	if (!adev) {
@@ -214,7 +215,8 @@ void pci_acpi_add_edr_notifier(struct pci_dev *pdev)
 	 * OS can use bit 7 of _OSC control field to negotiate control
 	 * over DPC Capability.
 	 */
-	if (!pcie_aer_get_firmware_first(pdev) || pcie_ports_dpc_native) {
+	if (!pcie_aer_get_firmware_first(pdev) || pcie_ports_dpc_native ||
+	    (host->native_dpc)) {
 		pci_dbg(pdev, "OS handles AER/DPC, so skip EDR init\n");
 		return;
 	}
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c6f91f886818..f67c007edcae 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -598,6 +598,7 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
 	bridge->native_shpc_hotplug = 1;
 	bridge->native_pme = 1;
 	bridge->native_ltr = 1;
+	bridge->native_dpc = 1;
 }
 
 struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 0f24d701fbdc..b7d3caf6f205 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -530,8 +530,9 @@ extern bool osc_pc_lpi_support_confirmed;
 #define OSC_PCI_CLOCK_PM_SUPPORT		0x00000004
 #define OSC_PCI_SEGMENT_GROUPS_SUPPORT		0x00000008
 #define OSC_PCI_MSI_SUPPORT			0x00000010
+#define OSC_PCI_EDR_SUPPORT			0x00000080
 #define OSC_PCI_HPX_TYPE_3_SUPPORT		0x00000100
-#define OSC_PCI_SUPPORT_MASKS			0x0000011f
+#define OSC_PCI_SUPPORT_MASKS			0x0000019f
 
 /* PCI Host Bridge _OSC: Capabilities DWORD 3: Control Field */
 #define OSC_PCI_EXPRESS_NATIVE_HP_CONTROL	0x00000001
@@ -540,7 +541,8 @@ extern bool osc_pc_lpi_support_confirmed;
 #define OSC_PCI_EXPRESS_AER_CONTROL		0x00000008
 #define OSC_PCI_EXPRESS_CAPABILITY_CONTROL	0x00000010
 #define OSC_PCI_EXPRESS_LTR_CONTROL		0x00000020
-#define OSC_PCI_CONTROL_MASKS			0x0000003f
+#define OSC_PCI_EXPRESS_DPC_CONTROL		0x00000080
+#define OSC_PCI_CONTROL_MASKS			0x000000bf
 
 #define ACPI_GSB_ACCESS_ATTRIB_QUICK		0x00000002
 #define ACPI_GSB_ACCESS_ATTRIB_SEND_RCV         0x00000004
diff --git a/include/linux/pci.h b/include/linux/pci.h
index a0b7e7a53741..7ed7c088c952 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -515,6 +515,7 @@ struct pci_host_bridge {
 	unsigned int	native_shpc_hotplug:1;	/* OS may use SHPC hotplug */
 	unsigned int	native_pme:1;		/* OS may use PCIe PME */
 	unsigned int	native_ltr:1;		/* OS may use PCIe LTR */
+	unsigned int	native_dpc:1;		/* OS may use PCIe DPC */
 	unsigned int	preserve_config:1;	/* Preserve FW resource setup */
 
 	/* Resource alignment requirements */
-- 
2.25.1

