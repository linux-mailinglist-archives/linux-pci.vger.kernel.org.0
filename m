Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26FCA84A37
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2019 12:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfHGK5X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Aug 2019 06:57:23 -0400
Received: from mga12.intel.com ([192.55.52.136]:37002 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbfHGK5X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Aug 2019 06:57:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2019 03:57:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,357,1559545200"; 
   d="scan'208";a="203144792"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 07 Aug 2019 03:57:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 70125146; Wed,  7 Aug 2019 13:57:18 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Matthias Andree <matthias.andree@gmx.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH] Revert "PCI: Add missing link delays required by the PCIe spec"
Date:   Wed,  7 Aug 2019 13:57:18 +0300
Message-Id: <20190807105718.77600-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit c2bf1fc212f7 ("PCI: Add missing link delays required by the PCIe
spec") turned out causing issues with some systems either by making them
unresponsive or slowing down runtime and system wide resume of PCIe
devices. While root cause for the unresponsiveness is still under
investigation given the amount of issues reported better to revert it
for now.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=204413
Link: https://lore.kernel.org/linux-pci/SL2P216MB01878BBCD75F21D882AEEA2880C60@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM/
Link: https://lore.kernel.org/linux-pci/2857501d-c167-547d-c57d-d5d24ea1f1dc@molgen.mpg.de/
Reported-by: Matthias Andree <matthias.andree@gmx.de>
Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reported-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
I'll try to come up another solution for the missing link delays that
hopefully does not cause regressions.

 drivers/pci/pci.c               | 29 +++++----------
 drivers/pci/pci.h               |  1 -
 drivers/pci/pcie/portdrv_core.c | 66 ---------------------------------
 3 files changed, 10 insertions(+), 86 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 29ed5ec1ac27..1b27b5af3d55 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1025,10 +1025,15 @@ static void __pci_start_power_transition(struct pci_dev *dev, pci_power_t state)
 	if (state == PCI_D0) {
 		pci_platform_power_transition(dev, PCI_D0);
 		/*
-		 * Mandatory power management transition delays are
-		 * handled in the PCIe portdrv resume hooks.
+		 * Mandatory power management transition delays, see
+		 * PCI Express Base Specification Revision 2.0 Section
+		 * 6.6.1: Conventional Reset.  Do not delay for
+		 * devices powered on/off by corresponding bridge,
+		 * because have already delayed for the bridge.
 		 */
 		if (dev->runtime_d3cold) {
+			if (dev->d3cold_delay && !dev->imm_ready)
+				msleep(dev->d3cold_delay);
 			/*
 			 * When powering on a bridge from D3cold, the
 			 * whole hierarchy may be powered on into
@@ -4602,16 +4607,14 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
 
 	return pci_dev_wait(dev, "PM D3->D0", PCIE_RESET_READY_POLL_MS);
 }
-
 /**
- * pcie_wait_for_link_delay - Wait until link is active or inactive
+ * pcie_wait_for_link - Wait until link is active or inactive
  * @pdev: Bridge device
  * @active: waiting for active or inactive?
- * @delay: Delay to wait after link has become active (in ms)
  *
  * Use this to wait till link becomes active or inactive.
  */
-bool pcie_wait_for_link_delay(struct pci_dev *pdev, bool active, int delay)
+bool pcie_wait_for_link(struct pci_dev *pdev, bool active)
 {
 	int timeout = 1000;
 	bool ret;
@@ -4648,25 +4651,13 @@ bool pcie_wait_for_link_delay(struct pci_dev *pdev, bool active, int delay)
 		timeout -= 10;
 	}
 	if (active && ret)
-		msleep(delay);
+		msleep(100);
 	else if (ret != active)
 		pci_info(pdev, "Data Link Layer Link Active not %s in 1000 msec\n",
 			active ? "set" : "cleared");
 	return ret == active;
 }
 
-/**
- * pcie_wait_for_link - Wait until link is active or inactive
- * @pdev: Bridge device
- * @active: waiting for active or inactive?
- *
- * Use this to wait till link becomes active or inactive.
- */
-bool pcie_wait_for_link(struct pci_dev *pdev, bool active)
-{
-	return pcie_wait_for_link_delay(pdev, active, 100);
-}
-
 void pci_reset_secondary_bus(struct pci_dev *dev)
 {
 	u16 ctrl;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 1be03a97cb92..d22d1b807701 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -497,7 +497,6 @@ static inline int pci_dev_specific_disable_acs_redir(struct pci_dev *dev)
 void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
 		      u32 service);
 
-bool pcie_wait_for_link_delay(struct pci_dev *pdev, bool active, int delay);
 bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
 #ifdef CONFIG_PCIEASPM
 void pcie_aspm_init_link_state(struct pci_dev *pdev);
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 308c3e0c4a34..1b330129089f 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -9,7 +9,6 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
-#include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
@@ -379,67 +378,6 @@ static int pm_iter(struct device *dev, void *data)
 	return 0;
 }
 
-static int get_downstream_delay(struct pci_bus *bus)
-{
-	struct pci_dev *pdev;
-	int min_delay = 100;
-	int max_delay = 0;
-
-	list_for_each_entry(pdev, &bus->devices, bus_list) {
-		if (!pdev->imm_ready)
-			min_delay = 0;
-		else if (pdev->d3cold_delay < min_delay)
-			min_delay = pdev->d3cold_delay;
-		if (pdev->d3cold_delay > max_delay)
-			max_delay = pdev->d3cold_delay;
-	}
-
-	return max(min_delay, max_delay);
-}
-
-/*
- * wait_for_downstream_link - Wait for downstream link to establish
- * @pdev: PCIe port whose downstream link is waited
- *
- * Handle delays according to PCIe 4.0 section 6.6.1 before configuration
- * access to the downstream component is permitted.
- *
- * This blocks PCI core resume of the hierarchy below this port until the
- * link is trained. Should be called before resuming port services to
- * prevent pciehp from starting to tear-down the hierarchy too soon.
- */
-static void wait_for_downstream_link(struct pci_dev *pdev)
-{
-	int delay;
-
-	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT &&
-	    pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM)
-		return;
-
-	if (pci_dev_is_disconnected(pdev))
-		return;
-
-	if (!pdev->subordinate || list_empty(&pdev->subordinate->devices) ||
-	    !pdev->bridge_d3)
-		return;
-
-	delay = get_downstream_delay(pdev->subordinate);
-	if (!delay)
-		return;
-
-	dev_dbg(&pdev->dev, "waiting downstream link for %d ms\n", delay);
-
-	/*
-	 * If downstream port does not support speeds greater than 5 GT/s
-	 * need to wait 100ms. For higher speeds (gen3) we need to wait
-	 * first for the data link layer to become active.
-	 */
-	if (pcie_get_speed_cap(pdev) <= PCIE_SPEED_5_0GT)
-		msleep(delay);
-	else
-		pcie_wait_for_link_delay(pdev, true, delay);
-}
-
 /**
  * pcie_port_device_suspend - suspend port services associated with a PCIe port
  * @dev: PCI Express port to handle
@@ -453,8 +391,6 @@ int pcie_port_device_suspend(struct device *dev)
 int pcie_port_device_resume_noirq(struct device *dev)
 {
 	size_t off = offsetof(struct pcie_port_service_driver, resume_noirq);
-
-	wait_for_downstream_link(to_pci_dev(dev));
 	return device_for_each_child(dev, &off, pm_iter);
 }
 
@@ -485,8 +421,6 @@ int pcie_port_device_runtime_suspend(struct device *dev)
 int pcie_port_device_runtime_resume(struct device *dev)
 {
 	size_t off = offsetof(struct pcie_port_service_driver, runtime_resume);
-
-	wait_for_downstream_link(to_pci_dev(dev));
 	return device_for_each_child(dev, &off, pm_iter);
 }
 #endif /* PM */
-- 
2.20.1

