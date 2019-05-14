Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B26F41E51C
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2019 00:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfENWV1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 May 2019 18:21:27 -0400
Received: from mga03.intel.com ([134.134.136.65]:20401 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbfENWVD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 May 2019 18:21:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 May 2019 15:21:02 -0700
X-ExtLoop1: 1
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by fmsmga007.fm.intel.com with ESMTP; 14 May 2019 15:21:02 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v3 1/5] PCI/ACPI: Add _OSC based negotiation support for DPC
Date:   Tue, 14 May 2019 15:18:13 -0700
Message-Id: <1d7b8966972edcad8ac9f219e9d83b47beb85f6f.1557870869.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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
(https://members.pcisig.com/wg/PCI-SIG/document/12614), OS can use
bit 7 of _OSC Control Field to negotiate control over Downstream Port
Containment (DPC) configuration of PCIe port.

After _OSC negotiation, firmware will Set this bit to grant OS control
over PCIe DPC configuration and Clear it if this feature was requested
and denied, or was not requested.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/acpi/pci_root.c         | 6 ++++++
 drivers/pci/pcie/portdrv_core.c | 3 ++-
 drivers/pci/probe.c             | 1 +
 include/linux/acpi.h            | 3 ++-
 include/linux/pci.h             | 1 +
 5 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 707aafc7c2aa..a60261e50b08 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -154,6 +154,7 @@ static struct pci_osc_bit_struct pci_osc_control_bit[] = {
 	{ OSC_PCI_EXPRESS_AER_CONTROL, "AER" },
 	{ OSC_PCI_EXPRESS_CAPABILITY_CONTROL, "PCIeCapability" },
 	{ OSC_PCI_EXPRESS_LTR_CONTROL, "LTR" },
+	{ OSC_PCI_EXPRESS_DPC_CONTROL, "DPC" },
 };
 
 static void decode_osc_bits(struct acpi_pci_root *root, char *msg, u32 word,
@@ -499,6 +500,9 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 			control |= OSC_PCI_EXPRESS_AER_CONTROL;
 	}
 
+	if (IS_ENABLED(CONFIG_PCIE_DPC))
+		control |= OSC_PCI_EXPRESS_DPC_CONTROL;
+
 	requested = control;
 	status = acpi_pci_osc_control_set(handle, &control,
 					  OSC_PCI_EXPRESS_CAPABILITY_CONTROL);
@@ -927,6 +931,8 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 		host_bridge->native_pme = 0;
 	if (!(root->osc_control_set & OSC_PCI_EXPRESS_LTR_CONTROL))
 		host_bridge->native_ltr = 0;
+	if (!(root->osc_control_set & OSC_PCI_EXPRESS_DPC_CONTROL))
+		host_bridge->native_dpc = 0;
 
 	pci_scan_child_bus(bus);
 	pci_set_host_bridge_release(host_bridge, acpi_pci_root_release_info,
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 1b330129089f..0a59ac574be1 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -251,7 +251,8 @@ static int get_port_device_capability(struct pci_dev *dev)
 	}
 
 	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
-	    pci_aer_available() && services & PCIE_PORT_SERVICE_AER)
+	    pci_aer_available() && services & PCIE_PORT_SERVICE_AER &&
+	    (pcie_ports_native || host->native_dpc))
 		services |= PCIE_PORT_SERVICE_DPC;
 
 	if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 7e12d0163863..31639ef8a95b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -608,6 +608,7 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
 	bridge->native_shpc_hotplug = 1;
 	bridge->native_pme = 1;
 	bridge->native_ltr = 1;
+	bridge->native_dpc = 1;
 
 	return bridge;
 }
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index d5dcebd7aad3..f68e9513996b 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -522,7 +522,8 @@ extern bool osc_pc_lpi_support_confirmed;
 #define OSC_PCI_EXPRESS_AER_CONTROL		0x00000008
 #define OSC_PCI_EXPRESS_CAPABILITY_CONTROL	0x00000010
 #define OSC_PCI_EXPRESS_LTR_CONTROL		0x00000020
-#define OSC_PCI_CONTROL_MASKS			0x0000003f
+#define OSC_PCI_EXPRESS_DPC_CONTROL		0x00000080
+#define OSC_PCI_CONTROL_MASKS			0x000000ff
 
 #define ACPI_GSB_ACCESS_ATTRIB_QUICK		0x00000002
 #define ACPI_GSB_ACCESS_ATTRIB_SEND_RCV         0x00000004
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 77448215ef5b..1c38bcd200d1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -502,6 +502,7 @@ struct pci_host_bridge {
 	unsigned int	native_shpc_hotplug:1;	/* OS may use SHPC hotplug */
 	unsigned int	native_pme:1;		/* OS may use PCIe PME */
 	unsigned int	native_ltr:1;		/* OS may use PCIe LTR */
+	unsigned int	native_dpc:1;		/* OS may use PCIe DPC */
 	/* Resource alignment requirements */
 	resource_size_t (*align_resource)(struct pci_dev *dev,
 			const struct resource *res,
-- 
2.20.1

