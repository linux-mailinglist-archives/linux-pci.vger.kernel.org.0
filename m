Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15AF86C2E36
	for <lists+linux-pci@lfdr.de>; Tue, 21 Mar 2023 10:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjCUJt4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Mar 2023 05:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjCUJty (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Mar 2023 05:49:54 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E3626862
        for <linux-pci@vger.kernel.org>; Tue, 21 Mar 2023 02:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679392190; x=1710928190;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZoOLQ7JDDepWYxAolcmkQtWT6zQyhyhy9r0AlJdLNAE=;
  b=jPqlPw+TyTv/Jq4vzTfSIWWBWaT28dvAVXEmfR7tck5nUmycOU7kGQJ8
   eQkkY9usmjMMeptpqcqL14w/wu16XWzo7sFVbFB88Jv5aMCt90VAQvd9S
   yALDQAUWbhA/Rm8ihytZ6mk2XQ0Tr5y/ju0/5NdLta4xmLzBaKDWtlWm1
   ja7+vGbNvqpR1Lxa/o0/UoOtX/42N4wWKxmHRBGzm76Z0liCHR76EMUeE
   2U8k4qL0kLfmMlPtbmhXC/dU8SwSEulmRCm08J1VvR/duA9R/0AyG7ejb
   UpPBRRxk7pfSVXpaMZfmrKsHzN7kP1w+HuB82dfqp1gW030KI/mi1D95r
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="319286073"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="319286073"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 02:49:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="681430123"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="681430123"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 21 Mar 2023 02:49:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 56BD43DD; Tue, 21 Mar 2023 11:50:31 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Mahesh J Salgaonkar <mahesh@linux.ibm.com>, oohall@gmail.com,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH] PCI/PM: Wait longer after reset when active link reporting is supported
Date:   Tue, 21 Mar 2023 11:50:31 +0200
Message-Id: <20230321095031.65709-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCIe spec prescribes that a device may take up to 1 second to
recover from reset and this same delay is prescribed when coming out of
D3cold (as that involves reset too). The device may extend this 1 second
delay through Request Retry Status completions and we accommondate for
that in Linux with 60 second cap, only in reset code path, not in resume
code path.

However, a device has surfaced, namely Intel Titan Ridge xHCI, which
requires longer delay also in the resume code path. For this reason make
the resume code path to use this same extended delay than with the reset
path but only after the link has come up (active link reporting is
supported) so that we do not wait longer time for devices that have
become permanently innaccessible during system sleep, e.g because they
have been removed.

While there move the two constants from the pci.h header into pci.c as
these are not used outside of that file anymore.

Reported-by: Chris Chiu <chris.chiu@canonical.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216728
Cc: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/pci-driver.c |  2 +-
 drivers/pci/pci.c        | 51 +++++++++++++++++++++++-----------------
 drivers/pci/pci.h        | 16 +------------
 drivers/pci/pcie/dpc.c   |  3 +--
 4 files changed, 33 insertions(+), 39 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 57ddcc59af30..1a5ee65edb10 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -572,7 +572,7 @@ static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
 
 static void pci_pm_bridge_power_up_actions(struct pci_dev *pci_dev)
 {
-	pci_bridge_wait_for_secondary_bus(pci_dev, "resume", PCI_RESET_WAIT);
+	pci_bridge_wait_for_secondary_bus(pci_dev, "resume");
 	/*
 	 * When powering on a bridge from D3cold, the whole hierarchy may be
 	 * powered on into D0uninitialized state, resume them to give them a
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7a67611dc5f4..f4875e5b8b29 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -64,6 +64,19 @@ struct pci_pme_device {
 
 #define PME_TIMEOUT 1000 /* How long between PME checks */
 
+/*
+ * Following exit from Conventional Reset, devices must be ready within 1 sec
+ * (PCIe r6.0 sec 6.6.1).  A D3cold to D0 transition implies a Conventional
+ * Reset (PCIe r6.0 sec 5.8).
+ */
+#define PCI_RESET_WAIT			1000	/* msec */
+/*
+ * Devices may extend the 1 sec period through Request Retry Status completions
+ * (PCIe r6.0 sec 2.3.1).  The spec does not provide an upper limit, but 60 sec
+ * ought to be enough for any device to become responsive.
+ */
+#define PCIE_RESET_READY_POLL_MS	60000	/* msec */
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
@@ -5004,13 +5015,11 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type,
 	 * speeds (gen3) we need to wait first for the data link layer to
 	 * become active.
 	 *
-	 * However, 100 ms is the minimum and the PCIe spec says the
-	 * software must allow at least 1s before it can determine that the
-	 * device that did not respond is a broken device. There is
-	 * evidence that 100 ms is not always enough, for example certain
-	 * Titan Ridge xHCI controller does not always respond to
-	 * configuration requests if we only wait for 100 ms (see
-	 * https://bugzilla.kernel.org/show_bug.cgi?id=203885).
+	 * However, 100 ms is the minimum and the PCIe spec says the software
+	 * must allow at least 1s before it can determine that the device that
+	 * did not respond is a broken device. Also device can take longer than
+	 * that to respond if it indicates so through Request Retry Status
+	 * completions.
 	 *
 	 * Therefore we wait for 100 ms and check for the device presence
 	 * until the timeout expires.
@@ -5021,17 +5030,18 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type,
 	if (pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT) {
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
@@ -5068,8 +5078,7 @@ int pci_bridge_secondary_bus_reset(struct pci_dev *dev)
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

