Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E71C1902E9
	for <lists+linux-pci@lfdr.de>; Tue, 24 Mar 2020 01:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgCXA0q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Mar 2020 20:26:46 -0400
Received: from mga14.intel.com ([192.55.52.115]:60459 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727421AbgCXA0W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Mar 2020 20:26:22 -0400
IronPort-SDR: pBDYIPRvU/uKKvRrN3cwsOEWZyxeL1UTqU7kCCoipF1BZv4NR7WOltwdFBKeJWBqWuS7pIoj/T
 IZHNN3WqMi7g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 17:26:21 -0700
IronPort-SDR: Ou3m9MgYCxOn4I3E/7b673eCIgjVWmvtddS6pF7MMwj585KJif6sdbbbTF3EeKBZ+rdOGxYhKV
 9fFFOy7I1/mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,298,1580803200"; 
   d="scan'208";a="419692229"
Received: from bhaveshm-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.134.88.197])
  by orsmga005.jf.intel.com with ESMTP; 23 Mar 2020 17:26:21 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v18 02/11] PCI: move {pciehp,shpchp}_is_native() definitions to pci.c
Date:   Mon, 23 Mar 2020 17:25:59 -0700
Message-Id: <201bd9ecd241cce0242af90a6c0f29356b472c6f.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Currently pciehp_is_native() and shpchp_is_native() API's
always returns true if CONFIG_ACPI is not defined. But
these APIs does not have any dependency on ACPI. In non
ACPI case, we should return true only if slot supports it.

So move the definitions out of pci-acpi.c and always evaluate
the function before returning the status.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pci-acpi.c      | 38 -------------------------------------
 drivers/pci/pci.c           | 38 +++++++++++++++++++++++++++++++++++++
 include/linux/pci_hotplug.h |  7 +++----
 3 files changed, 41 insertions(+), 42 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 0c02d500158f..1bf8765c41bd 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -781,44 +781,6 @@ int pci_acpi_program_hp_params(struct pci_dev *dev)
 	return -ENODEV;
 }
 
-/**
- * pciehp_is_native - Check whether a hotplug port is handled by the OS
- * @bridge: Hotplug port to check
- *
- * Returns true if the given @bridge is handled by the native PCIe hotplug
- * driver.
- */
-bool pciehp_is_native(struct pci_dev *bridge)
-{
-	const struct pci_host_bridge *host;
-	u32 slot_cap;
-
-	if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
-		return false;
-
-	pcie_capability_read_dword(bridge, PCI_EXP_SLTCAP, &slot_cap);
-	if (!(slot_cap & PCI_EXP_SLTCAP_HPC))
-		return false;
-
-	if (pcie_ports_native)
-		return true;
-
-	host = pci_find_host_bridge(bridge->bus);
-	return host->native_pcie_hotplug;
-}
-
-/**
- * shpchp_is_native - Check whether a hotplug port is handled by the OS
- * @bridge: Hotplug port to check
- *
- * Returns true if the given @bridge is handled by the native SHPC hotplug
- * driver.
- */
-bool shpchp_is_native(struct pci_dev *bridge)
-{
-	return bridge->shpc_managed;
-}
-
 /**
  * pci_acpi_wake_bus - Root bus wakeup notification fork function.
  * @context: Device wakeup context.
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d828ca835a98..e724341cefff 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4783,6 +4783,44 @@ void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev)
 	}
 }
 
+/**
+ * pciehp_is_native - Check whether a hotplug port is handled by the OS
+ * @bridge: Hotplug port to check
+ *
+ * Returns true if the given @bridge is handled by the native PCIe hotplug
+ * driver.
+ */
+bool pciehp_is_native(struct pci_dev *bridge)
+{
+	const struct pci_host_bridge *host;
+	u32 slot_cap;
+
+	if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
+		return false;
+
+	pcie_capability_read_dword(bridge, PCI_EXP_SLTCAP, &slot_cap);
+	if (!(slot_cap & PCI_EXP_SLTCAP_HPC))
+		return false;
+
+	if (pcie_ports_native)
+		return true;
+
+	host = pci_find_host_bridge(bridge->bus);
+	return host->native_pcie_hotplug;
+}
+
+/**
+ * shpchp_is_native - Check whether a hotplug port is handled by the OS
+ * @bridge: Hotplug port to check
+ *
+ * Returns true if the given @bridge is handled by the native SHPC hotplug
+ * driver.
+ */
+bool shpchp_is_native(struct pci_dev *bridge)
+{
+	return bridge->shpc_managed;
+}
+
 void pci_reset_secondary_bus(struct pci_dev *dev)
 {
 	u16 ctrl;
diff --git a/include/linux/pci_hotplug.h b/include/linux/pci_hotplug.h
index b482e42d7153..11660e19a133 100644
--- a/include/linux/pci_hotplug.h
+++ b/include/linux/pci_hotplug.h
@@ -88,9 +88,7 @@ void pci_hp_deregister(struct hotplug_slot *slot);
 
 #ifdef CONFIG_ACPI
 #include <linux/acpi.h>
-bool pciehp_is_native(struct pci_dev *bridge);
 int acpi_get_hp_hw_control_from_firmware(struct pci_dev *bridge);
-bool shpchp_is_native(struct pci_dev *bridge);
 int acpi_pci_check_ejectable(struct pci_bus *pbus, acpi_handle handle);
 int acpi_pci_detect_ejectable(acpi_handle handle);
 #else
@@ -98,10 +96,11 @@ static inline int acpi_get_hp_hw_control_from_firmware(struct pci_dev *bridge)
 {
 	return 0;
 }
-static inline bool pciehp_is_native(struct pci_dev *bridge) { return true; }
-static inline bool shpchp_is_native(struct pci_dev *bridge) { return true; }
 #endif
 
+bool pciehp_is_native(struct pci_dev *bridge);
+bool shpchp_is_native(struct pci_dev *bridge);
+
 static inline bool hotplug_is_native(struct pci_dev *bridge)
 {
 	return pciehp_is_native(bridge) || shpchp_is_native(bridge);
-- 
2.17.1

