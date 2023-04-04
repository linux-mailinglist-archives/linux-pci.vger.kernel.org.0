Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939A76D57F3
	for <lists+linux-pci@lfdr.de>; Tue,  4 Apr 2023 07:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbjDDF1T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Apr 2023 01:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbjDDF1S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Apr 2023 01:27:18 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7839D1BF3
        for <linux-pci@vger.kernel.org>; Mon,  3 Apr 2023 22:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680586037; x=1712122037;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OVSutMyYq4OFKFRZWaRt8vfOaIwgdrPq10909aUsIe8=;
  b=R/7e9czKC8C/AAvPleZLhVF7kal2CHfPTWs5FkmyKF8vwfaengCp988E
   xmhUB/LB4ogsqt4d3213YhmdlJQ5ehMlMpxA6FPNZjbfB+z1rF0nvxvS1
   Bv93Q2CgLQEvsxNJg5SMfYnrgK5VcE5y66ErwRH/3whVACxeiY7lIptY/
   r+YKeAhotcTJtjXQ6ZDdxv1E3KvlP79CYcCb4nFuAppKm3rVoAJ6hE4jc
   RVlS++FOUfCUK+XoB1DL8lmNn+ywOU/FNtJ6v5ZmHcG4gGXpSom2umAK4
   dOHGvTcEMRsaP34TQ6o7H1e1UjoPZbgUtUQCpY5hYkrG5uDrDCJASJRmI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="342116188"
X-IronPort-AV: E=Sophos;i="5.98,316,1673942400"; 
   d="scan'208";a="342116188"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 22:27:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="775501970"
X-IronPort-AV: E=Sophos;i="5.98,316,1673942400"; 
   d="scan'208";a="775501970"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Apr 2023 22:27:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 8795814B; Tue,  4 Apr 2023 08:27:14 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Mahesh J Salgaonkar <mahesh@linux.ibm.com>, oohall@gmail.com,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Sheng Bi <windy.bi.enflame@gmail.com>,
        Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>,
        Stanislav Spassov <stanspas@amazon.de>,
        Yang Su <yang.su@linux.alibaba.com>,
        shuo.tan@linux.alibaba.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 2/2] PCI/PM: Decrease wait time for devices behind slow links
Date:   Tue,  4 Apr 2023 08:27:14 +0300
Message-Id: <20230404052714.51315-3-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230404052714.51315-1-mika.westerberg@linux.intel.com>
References: <20230404052714.51315-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In order speed up reset and resume time of devices behind slow links,
decrease the wait time to 1s. This should give enough time for them to
respond. While doing this, instead of looking at the speed we check if
the port supports active link reporting. If it does we can wait longer
but if it does not we wait for the 1s prescribed in the PCIe spec.

Since pci_bridge_wait_for_secondary_bus() handles all the delays
internally now move the wait constants from drivers/pci/pci.h into
drivers/pci/pci.c.

Cc: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/pci-driver.c |  3 +--
 drivers/pci/pci.c        | 42 ++++++++++++++++++++++++++--------------
 drivers/pci/pci.h        | 16 +--------------
 drivers/pci/pcie/dpc.c   |  3 +--
 4 files changed, 30 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 6b5b2a818e65..1a5ee65edb10 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -572,8 +572,7 @@ static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
 
 static void pci_pm_bridge_power_up_actions(struct pci_dev *pci_dev)
 {
-	pci_bridge_wait_for_secondary_bus(pci_dev, "resume",
-					  PCIE_RESET_READY_POLL_MS);
+	pci_bridge_wait_for_secondary_bus(pci_dev, "resume");
 	/*
 	 * When powering on a bridge from D3cold, the whole hierarchy may be
 	 * powered on into D0uninitialized state, resume them to give them a
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7a67611dc5f4..5302d900dbe7 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -64,6 +64,19 @@ struct pci_pme_device {
 
 #define PME_TIMEOUT 1000 /* How long between PME checks */
 
+/*
+ * Following exit from Conventional Reset, devices must be ready within 1 sec
+ * (PCIe r6.0 sec 6.6.1).  A D3cold to D0 transition implies a Conventional
+ * Reset (PCIe r6.0 sec 5.8).
+ */
+#define PCI_RESET_WAIT		1000	/* msec */
+/*
+ * Devices may extend the 1 sec period through Request Retry Status completions
+ * (PCIe r6.0 sec 2.3.1).  The spec does not provide an upper limit, but 60 sec
+ * ought to be enough for any device to become responsive.
+ */
+#define PCIE_RESET_READY_POLL_MS 60000	/* msec */
+
 static void pci_dev_d3_sleep(struct pci_dev *dev)
 {
 	unsigned int delay_ms = max(dev->d3hot_delay, pci_pm_d3hot_delay);
@@ -4939,7 +4952,6 @@ static int pci_bus_max_d3cold_delay(const struct pci_bus *bus)
  * pci_bridge_wait_for_secondary_bus - Wait for secondary bus to be accessible
  * @dev: PCI bridge
  * @reset_type: reset type in human-readable form
- * @timeout: maximum time to wait for devices on secondary bus (milliseconds)
  *
  * Handle necessary delays before access to the devices on the secondary
  * side of the bridge are permitted after D3cold to D0 transition
@@ -4952,8 +4964,7 @@ static int pci_bus_max_d3cold_delay(const struct pci_bus *bus)
  * Return 0 on success or -ENOTTY if the first device on the secondary bus
  * failed to become accessible.
  */
-int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type,
-				      int timeout)
+int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
 {
 	struct pci_dev *child;
 	int delay;
@@ -5018,20 +5029,22 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type,
 	if (!pcie_downstream_port(dev))
 		return 0;
 
-	if (pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT) {
+	if (!dev->link_active_reporting) {
 		pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
 		msleep(delay);
-	} else {
-		pci_dbg(dev, "waiting %d ms for downstream link, after activation\n",
-			delay);
-		if (!pcie_wait_for_link_delay(dev, true, delay)) {
-			/* Did not train, no need to wait any further */
-			pci_info(dev, "Data Link Layer Link Active not set in 1000 msec\n");
-			return -ENOTTY;
-		}
+
+		return pci_dev_wait(child, reset_type, PCI_RESET_WAIT - delay);
+	}
+
+	pci_dbg(dev, "waiting %d ms for downstream link, after activation\n",
+		delay);
+	if (!pcie_wait_for_link_delay(dev, true, delay)) {
+		/* Did not train, no need to wait any further */
+		pci_info(dev, "Data Link Layer Link Active not set in 1000 msec\n");
+		return -ENOTTY;
 	}
 
-	return pci_dev_wait(child, reset_type, timeout - delay);
+	return pci_dev_wait(child, reset_type, PCIE_RESET_READY_POLL_MS - delay);
 }
 
 void pci_reset_secondary_bus(struct pci_dev *dev)
@@ -5068,8 +5081,7 @@ int pci_bridge_secondary_bus_reset(struct pci_dev *dev)
 {
 	pcibios_reset_secondary_bus(dev);
 
-	return pci_bridge_wait_for_secondary_bus(dev, "bus reset",
-						 PCIE_RESET_READY_POLL_MS);
+	return pci_bridge_wait_for_secondary_bus(dev, "bus reset");
 }
 EXPORT_SYMBOL_GPL(pci_bridge_secondary_bus_reset);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index d2c08670a20e..f2d3aeab91f4 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -64,19 +64,6 @@ struct pci_cap_saved_state *pci_find_saved_ext_cap(struct pci_dev *dev,
 #define PCI_PM_D3HOT_WAIT       10	/* msec */
 #define PCI_PM_D3COLD_WAIT      100	/* msec */
 
-/*
- * Following exit from Conventional Reset, devices must be ready within 1 sec
- * (PCIe r6.0 sec 6.6.1).  A D3cold to D0 transition implies a Conventional
- * Reset (PCIe r6.0 sec 5.8).
- */
-#define PCI_RESET_WAIT		1000	/* msec */
-/*
- * Devices may extend the 1 sec period through Request Retry Status completions
- * (PCIe r6.0 sec 2.3.1).  The spec does not provide an upper limit, but 60 sec
- * ought to be enough for any device to become responsive.
- */
-#define PCIE_RESET_READY_POLL_MS 60000	/* msec */
-
 void pci_update_current_state(struct pci_dev *dev, pci_power_t state);
 void pci_refresh_power_state(struct pci_dev *dev);
 int pci_power_up(struct pci_dev *dev);
@@ -100,8 +87,7 @@ void pci_msix_init(struct pci_dev *dev);
 bool pci_bridge_d3_possible(struct pci_dev *dev);
 void pci_bridge_d3_update(struct pci_dev *dev);
 void pci_bridge_reconfigure_ltr(struct pci_dev *dev);
-int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type,
-				      int timeout);
+int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type);
 
 static inline void pci_wakeup_event(struct pci_dev *dev)
 {
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index a5d7c69b764e..3ceed8e3de41 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -170,8 +170,7 @@ pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
 	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
 			      PCI_EXP_DPC_STATUS_TRIGGER);
 
-	if (pci_bridge_wait_for_secondary_bus(pdev, "DPC",
-					      PCIE_RESET_READY_POLL_MS)) {
+	if (pci_bridge_wait_for_secondary_bus(pdev, "DPC")) {
 		clear_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);
 		ret = PCI_ERS_RESULT_DISCONNECT;
 	} else {
-- 
2.39.2

