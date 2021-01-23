Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A8A3011EF
	for <lists+linux-pci@lfdr.de>; Sat, 23 Jan 2021 02:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbhAWBQn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jan 2021 20:16:43 -0500
Received: from mga04.intel.com ([192.55.52.120]:26962 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbhAWBQf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Jan 2021 20:16:35 -0500
IronPort-SDR: 7oWewMBCkFDsSf44VPrQfTpol4dXOdlHYSnjCNQTvvUgbcCLLfY/wtG4Zeidrww/ldJR1QZc4H
 WMVcxpawiVrQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9872"; a="176962181"
X-IronPort-AV: E=Sophos;i="5.79,368,1602572400"; 
   d="scan'208";a="176962181"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 17:11:22 -0800
IronPort-SDR: p1vPc0PBWrfhAfo6AIBPV7Slf6Q9B8j8hfkI415ZG0Pcan/+CIplUhp2W5eOrqJwnPYYuV4EsV
 t07PchcBzyKw==
X-IronPort-AV: E=Sophos;i="5.79,368,1602572400"; 
   d="scan'208";a="386084698"
Received: from usundar-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.36.142])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 17:11:21 -0800
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v13 4/5] PCI/ACPI: Centralize pcie_ports_native checking
Date:   Fri, 22 Jan 2021 17:11:12 -0800
Message-Id: <a96291aead64474ecb40a07a6d16a55e0f0df140.1611364025.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1611364024.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1611364024.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If the user booted with "pcie_ports=native", we take control of the PCIe
features unconditionally, regardless of what _OSC says.

Centralize the testing of pcie_ports_native in acpi_pci_root_create(),
where we interpret the _OSC results, so other places only have to check
host_bridge->native_X and we don't have to sprinkle tests of
pcie_ports_native everywhere.

[bhelgaas: commit log, rework OSC_PCI_EXPRESS_CONTROL_MASKS, logging]
Link: https://lore.kernel.org/r/bc87c9e675118960949043a832bed86bc22becbd.1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/pci_root.c           | 19 +++++++++++++++++++
 drivers/pci/hotplug/pciehp_core.c |  2 +-
 drivers/pci/pci-acpi.c            |  3 ---
 drivers/pci/pcie/aer.c            |  2 +-
 drivers/pci/pcie/portdrv_core.c   | 11 ++++-------
 5 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 601fbe905993..16ca58d58fef 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -880,6 +880,8 @@ static void acpi_pci_root_release_info(struct pci_host_bridge *bridge)
 			flag = 0;	\
 	} while (0)
 
+#define FLAG(x)		((x) ? '+' : '-')
+
 struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 				     struct acpi_pci_root_ops *ops,
 				     struct acpi_pci_root_info *info,
@@ -928,6 +930,23 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 	OSC_OWNER(ctrl, OSC_PCI_EXPRESS_LTR_CONTROL, host_bridge->native_ltr);
 	OSC_OWNER(ctrl, OSC_PCI_EXPRESS_DPC_CONTROL, host_bridge->native_dpc);
 
+	if (pcie_ports_native) {
+		dev_info(&root->device->dev, "Taking control of PCIe-related features because \"pcie_ports=native\" specified; may conflict with firmware\n");
+		host_bridge->native_pcie_hotplug = 1;
+		host_bridge->native_aer = 1;
+		host_bridge->native_pme = 1;
+		host_bridge->native_ltr = 1;
+		host_bridge->native_dpc = 1;
+	}
+
+	dev_info(&root->device->dev, "OS native features: SHPCHotplug%c PCIeHotplug%c PME%c AER%c DPC%c LTR%c\n",
+		FLAG(host_bridge->native_shpc_hotplug),
+		FLAG(host_bridge->native_pcie_hotplug),
+		FLAG(host_bridge->native_pme),
+		FLAG(host_bridge->native_aer),
+		FLAG(host_bridge->native_dpc),
+		FLAG(host_bridge->native_ltr));
+
 	/*
 	 * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
 	 * exists and returns 0, we must preserve any PCI resource
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
index 53502a751914..f6327cf0601b 100644
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
index 77b0f2c45bc0..7fdeaadc40fe 100644
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
index e1fed6649c41..ea1099908d5d 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -208,8 +208,7 @@ static int get_port_device_capability(struct pci_dev *dev)
 	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
 	int services = 0;
 
-	if (dev->is_hotplug_bridge &&
-	    (pcie_ports_native || host->native_pcie_hotplug)) {
+	if (host->native_pcie_hotplug && dev->is_hotplug_bridge) {
 		services |= PCIE_PORT_SERVICE_HP;
 
 		/*
@@ -221,8 +220,7 @@ static int get_port_device_capability(struct pci_dev *dev)
 	}
 
 #ifdef CONFIG_PCIEAER
-	if (dev->aer_cap && pci_aer_available() &&
-	    (pcie_ports_native || host->native_aer)) {
+	if (host->native_aer && dev->aer_cap && pci_aer_available()) {
 		services |= PCIE_PORT_SERVICE_AER;
 
 		/*
@@ -234,9 +232,8 @@ static int get_port_device_capability(struct pci_dev *dev)
 #endif
 
 	/* Root Ports and Root Complex Event Collectors may generate PMEs */
-	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
-	     pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
-	    (pcie_ports_native || host->native_pme)) {
+	if (host->native_pme && (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
+				 pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)) {
 		services |= PCIE_PORT_SERVICE_PME;
 
 		/*
-- 
2.25.1

