Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E136299647
	for <lists+linux-pci@lfdr.de>; Mon, 26 Oct 2020 19:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1791043AbgJZS6J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Oct 2020 14:58:09 -0400
Received: from mga03.intel.com ([134.134.136.65]:52492 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1783396AbgJZS6I (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Oct 2020 14:58:08 -0400
IronPort-SDR: BvKpMV0FVRPtxdNZZOezWRkbhTmpjocTsIrtIX52fCn2NNaHo+7pzLR2m2IZbGEIq9VzsYwjC6
 rD8ycpKh9/gw==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="168073145"
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="168073145"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 11:58:07 -0700
IronPort-SDR: HEyWfle+/PC5B620muAIBVubve7lz6Gx3xViKUVg3UzF4/z+e6oreInWmPT1sZoCFg5gp+4bpk
 luKxcVy+xK7Q==
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="525607452"
Received: from dhrubajy-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.101.53])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 11:58:06 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        knsathya@kernel.org
Subject: [PATCH v10 2/5] ACPI/PCI: Ignore _OSC negotiation result if pcie_ports_native is set.
Date:   Mon, 26 Oct 2020 11:56:40 -0700
Message-Id: <9a3fcebd55cc6ae2856eee8c4edd52e972adbd0b.1603738449.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1603738449.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1603738449.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <cover.1603738449.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1603738449.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pcie_ports_native is set only if user requests native handling
of PCIe capabilities via pcie_port_setup command line option.
User input takes precedence over _OSC based control negotiation
result. So consider the _OSC negotiated result only if
pcie_ports_native is unset.

Also, since struct pci_host_bridge ->native_* members caches the
ownership status of various PCIe capabilities, use them instead
of distributed checks for pcie_ports_native.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/acpi/pci_root.c           | 33 +++++++++++++++++++++----------
 drivers/pci/hotplug/pciehp_core.c |  2 +-
 drivers/pci/pci-acpi.c            |  3 ---
 drivers/pci/pcie/aer.c            |  2 +-
 drivers/pci/pcie/portdrv_core.c   |  9 +++------
 include/linux/acpi.h              |  2 ++
 6 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index c12b5fb3e8fb..da925bef5bcf 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -41,6 +41,10 @@ static int acpi_pci_root_scan_dependent(struct acpi_device *adev)
 				| OSC_PCI_CLOCK_PM_SUPPORT \
 				| OSC_PCI_MSI_SUPPORT)
 
+#define OSC_OWNER(ctrl, bit, flag) \
+	if (!(ctrl & bit)) \
+		flag = 0;
+
 static const struct acpi_device_id root_device_ids[] = {
 	{"PNP0A03", 0},
 	{"", 0},
@@ -887,6 +891,7 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 	struct pci_bus *bus;
 	struct pci_host_bridge *host_bridge;
 	union acpi_object *obj;
+	u32 ctrl;
 
 	info->root = root;
 	info->bridge = device;
@@ -912,18 +917,26 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 		goto out_release_info;
 
 	host_bridge = to_pci_host_bridge(bus->bridge);
-	if (!(root->osc_control_set & OSC_PCI_EXPRESS_NATIVE_HP_CONTROL))
-		host_bridge->native_pcie_hotplug = 0;
+
+	  if (pcie_ports_native) {
+		  decode_osc_control(root, "OS forcibly taking over",
+				     OSC_PCI_EXPRESS_CONTROL_MASKS);
+	  } else {
+		  ctrl = root->osc_control_set;
+		  OSC_OWNER(ctrl, OSC_PCI_EXPRESS_NATIVE_HP_CONTROL,
+			    host_bridge->native_pcie_hotplug);
+		  OSC_OWNER(ctrl, OSC_PCI_EXPRESS_AER_CONTROL,
+			    host_bridge->native_aer);
+		  OSC_OWNER(ctrl, OSC_PCI_EXPRESS_PME_CONTROL,
+			    host_bridge->native_pme);
+		  OSC_OWNER(ctrl, OSC_PCI_EXPRESS_LTR_CONTROL,
+			    host_bridge->native_ltr);
+		  OSC_OWNER(ctrl, OSC_PCI_EXPRESS_DPC_CONTROL,
+			    host_bridge->native_dpc);
+	  }
+
 	if (!(root->osc_control_set & OSC_PCI_SHPC_NATIVE_HP_CONTROL))
 		host_bridge->native_shpc_hotplug = 0;
-	if (!(root->osc_control_set & OSC_PCI_EXPRESS_AER_CONTROL))
-		host_bridge->native_aer = 0;
-	if (!(root->osc_control_set & OSC_PCI_EXPRESS_PME_CONTROL))
-		host_bridge->native_pme = 0;
-	if (!(root->osc_control_set & OSC_PCI_EXPRESS_LTR_CONTROL))
-		host_bridge->native_ltr = 0;
-	if (!(root->osc_control_set & OSC_PCI_EXPRESS_DPC_CONTROL))
-		host_bridge->native_dpc = 0;
 
 	/*
 	 * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index ad3393930ecb..d1831e6bf60a 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -256,7 +256,7 @@ static bool pme_is_native(struct pcie_device *dev)
 	const struct pci_host_bridge *host;
 
 	host = pci_find_host_bridge(dev->port->bus);
-	return pcie_ports_native || host->native_pme;
+	return host->native_pme;
 }
 
 static void pciehp_disable_interrupt(struct pcie_device *dev)
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index bf03648c2072..a84f75ec6df8 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -800,9 +800,6 @@ bool pciehp_is_native(struct pci_dev *bridge)
 	if (!(slot_cap & PCI_EXP_SLTCAP_HPC))
 		return false;
 
-	if (pcie_ports_native)
-		return true;
-
 	host = pci_find_host_bridge(bridge->bus);
 	return host->native_pcie_hotplug;
 }
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 65dff5f3457a..79bb441139c2 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -219,7 +219,7 @@ int pcie_aer_is_native(struct pci_dev *dev)
 	if (!dev->aer_cap)
 		return 0;
 
-	return pcie_ports_native || host->native_aer;
+	return host->native_aer;
 }
 
 int pci_enable_pcie_error_reporting(struct pci_dev *dev)
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 50a9522ab07d..ccd5e0ce5605 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -208,8 +208,7 @@ static int get_port_device_capability(struct pci_dev *dev)
 	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
 	int services = 0;
 
-	if (dev->is_hotplug_bridge &&
-	    (pcie_ports_native || host->native_pcie_hotplug)) {
+	if (dev->is_hotplug_bridge && host->native_pcie_hotplug) {
 		services |= PCIE_PORT_SERVICE_HP;
 
 		/*
@@ -221,8 +220,7 @@ static int get_port_device_capability(struct pci_dev *dev)
 	}
 
 #ifdef CONFIG_PCIEAER
-	if (dev->aer_cap && pci_aer_available() &&
-	    (pcie_ports_native || host->native_aer)) {
+	if (dev->aer_cap && pci_aer_available() && host->native_aer) {
 		services |= PCIE_PORT_SERVICE_AER;
 
 		/*
@@ -238,8 +236,7 @@ static int get_port_device_capability(struct pci_dev *dev)
 	 * Event Collectors can also generate PMEs, but we don't handle
 	 * those yet.
 	 */
-	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
-	    (pcie_ports_native || host->native_pme)) {
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT && host->native_pme) {
 		services |= PCIE_PORT_SERVICE_PME;
 
 		/*
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 39263c6b52e1..35689f4e8e1f 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -569,6 +569,8 @@ extern bool osc_pc_lpi_support_confirmed;
 #define OSC_PCI_EXPRESS_LTR_CONTROL		0x00000020
 #define OSC_PCI_EXPRESS_DPC_CONTROL		0x00000080
 #define OSC_PCI_CONTROL_MASKS			0x000000bf
+/* Masks specific to PCIe Capabilities */
+#define OSC_PCI_EXPRESS_CONTROL_MASKS		0x000000bd
 
 #define ACPI_GSB_ACCESS_ATTRIB_QUICK		0x00000002
 #define ACPI_GSB_ACCESS_ATTRIB_SEND_RCV         0x00000004
-- 
2.17.1

