Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C6B2241B6
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jul 2020 19:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgGQRX7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jul 2020 13:23:59 -0400
Received: from mga07.intel.com ([134.134.136.100]:31672 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726633AbgGQRX7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Jul 2020 13:23:59 -0400
IronPort-SDR: XTWJkS6XdW9Y0lkt3+HBC/EQDzBWbB7O4NGZ6QSMezPyfn5ftlanCU6PIjVKX9aLncPEY3HN4S
 u47zIxVRNlow==
X-IronPort-AV: E=McAfee;i="6000,8403,9685"; a="214353104"
X-IronPort-AV: E=Sophos;i="5.75,364,1589266800"; 
   d="scan'208";a="214353104"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 10:23:58 -0700
IronPort-SDR: twhhc1q08mh+16A8V2grDesgfIV3GusRO7mnRVS/0dshX1xj+O/pdR1CI8MF52Z2CpCurnYp3e
 472fQwDHx3pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,364,1589266800"; 
   d="scan'208";a="282846755"
Received: from jmharral-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.254.77.39])
  by orsmga003.jf.intel.com with ESMTP; 17 Jul 2020 10:23:58 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v7 2/5] ACPI/PCI: Ignore _OSC negotiation result if pcie_ports_native is set.
Date:   Fri, 17 Jul 2020 10:23:47 -0700
Message-Id: <a5da506cb5cd5d590d88da8537ad01c0167840da.1595006564.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1595006564.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1595006564.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

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
 drivers/acpi/pci_root.c           | 62 ++++++++++++++++++++++++++-----
 drivers/pci/hotplug/pciehp_core.c |  2 +-
 drivers/pci/pci-acpi.c            |  3 --
 drivers/pci/pcie/aer.c            |  2 +-
 drivers/pci/pcie/portdrv_core.c   |  9 ++---
 5 files changed, 57 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index f90e841c59f5..a82069d064fe 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -145,6 +145,18 @@ static struct pci_osc_bit_struct pci_osc_control_bit[] = {
 	{ OSC_PCI_EXPRESS_DPC_CONTROL, "DPC" },
 };
 
+static char *get_osc_desc(u32 bit)
+{
+	int len = sizeof(pci_osc_control_bit) / sizeof(pci_osc_control_bit[0]);
+	int i = 0;
+
+	for (i = 0; i <len; i++)
+		if (bit == pci_osc_control_bit[i].bit)
+			return pci_osc_control_bit[i].desc;
+
+	return NULL;
+}
+
 static void decode_osc_bits(struct acpi_pci_root *root, char *msg, u32 word,
 			    struct pci_osc_bit_struct *table, int size)
 {
@@ -914,18 +926,48 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 		goto out_release_info;
 
 	host_bridge = to_pci_host_bridge(bus->bridge);
-	if (!(root->osc_control_set & OSC_PCI_EXPRESS_NATIVE_HP_CONTROL))
-		host_bridge->native_pcie_hotplug = 0;
+	if (!(root->osc_control_set & OSC_PCI_EXPRESS_NATIVE_HP_CONTROL)) {
+		if (!pcie_ports_native)
+			host_bridge->native_pcie_hotplug = 0;
+		else
+			dev_warn(&bus->dev, "OS overrides %s firmware control",
+			get_osc_desc(OSC_PCI_EXPRESS_NATIVE_HP_CONTROL));
+	}
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
+
+	if (!(root->osc_control_set & OSC_PCI_EXPRESS_AER_CONTROL)) {
+		if (!pcie_ports_native)
+			host_bridge->native_aer = 0;
+		else
+			dev_warn(&bus->dev, "OS overrides %s firmware control",
+			get_osc_desc(OSC_PCI_EXPRESS_AER_CONTROL));
+	}
+
+	if (!(root->osc_control_set & OSC_PCI_EXPRESS_PME_CONTROL)) {
+		if (!pcie_ports_native)
+			host_bridge->native_pme = 0;
+		else
+			dev_warn(&bus->dev, "OS overrides %s firmware control",
+			get_osc_desc(OSC_PCI_EXPRESS_PME_CONTROL));
+	}
+
+	if (!(root->osc_control_set & OSC_PCI_EXPRESS_LTR_CONTROL)) {
+		if (!pcie_ports_native)
+			host_bridge->native_ltr = 0;
+		else
+			dev_warn(&bus->dev, "OS overrides %s firmware control",
+			get_osc_desc(OSC_PCI_EXPRESS_LTR_CONTROL));
+	}
+
+	if (!(root->osc_control_set & OSC_PCI_EXPRESS_DPC_CONTROL)) {
+		if (!pcie_ports_native)
+			host_bridge->native_dpc = 0;
+		else
+			dev_warn(&bus->dev, "OS overrides %s firmware control",
+			get_osc_desc(OSC_PCI_EXPRESS_DPC_CONTROL));
+	}
 
 	/*
 	 * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index bf779f291f15..5fc999bf6f1b 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -255,7 +255,7 @@ static bool pme_is_native(struct pcie_device *dev)
 	const struct pci_host_bridge *host;
 
 	host = pci_find_host_bridge(dev->port->bus);
-	return pcie_ports_native || host->native_pme;
+	return host->native_pme;
 }
 
 static void pciehp_disable_interrupt(struct pcie_device *dev)
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 7224b1e5f2a8..e09589571a9d 100644
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
index 3acf56683915..d663bd9c7257 100644
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
-- 
2.17.1

