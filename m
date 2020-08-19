Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5CCF249F1D
	for <lists+linux-pci@lfdr.de>; Wed, 19 Aug 2020 15:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgHSNHJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Aug 2020 09:07:09 -0400
Received: from mga18.intel.com ([134.134.136.126]:31923 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728681AbgHSNGk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Aug 2020 09:06:40 -0400
IronPort-SDR: QvVdf37NAn0whfsu35IaKCKARCrZAY+EH22IYe7LthvvIK0sC6e9evKMCJmQm6q96wLUY7YDWC
 EhUWU7mtHlpg==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="142732570"
X-IronPort-AV: E=Sophos;i="5.76,331,1592895600"; 
   d="scan'208";a="142732570"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 06:06:29 -0700
IronPort-SDR: LHu8zE4mkBo2+KtYNOyXMXM8CHviRlmlmFpKy+jdmP8mcqp0hVJSG2d1Zzj1QWyrQyBH+Klwb1
 O8t/VwywvU4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,331,1592895600"; 
   d="scan'208";a="310763578"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 19 Aug 2020 06:06:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 1AC7426A; Wed, 19 Aug 2020 16:06:25 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Patrick Volkerding <volkerdi@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Ben Skeggs <bskeggs@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH] PCI/PM: Assume ports without DLL Link Active train links in 100 ms
Date:   Wed, 19 Aug 2020 16:06:25 +0300
Message-Id: <20200819130625.12778-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Kai-Heng Feng reported that it takes a long time (> 1 s) to resume
Thunderbolt-connected devices from both runtime suspend and system sleep
(s2idle).

This was because some Downstream Ports that support > 5 GT/s do not also
support Data Link Layer Link Active reporting.  Per PCIe r5.0 sec 6.6.1:

  With a Downstream Port that supports Link speeds greater than 5.0 GT/s,
  software must wait a minimum of 100 ms after Link training completes
  before sending a Configuration Request to the device immediately below
  that Port. Software can determine when Link training completes by polling
  the Data Link Layer Link Active bit or by setting up an associated
  interrupt (see Section 6.7.3.3).

Sec 7.5.3.6 requires such Ports to support DLL Link Active reporting, but
at least the Intel JHL6240 Thunderbolt 3 Bridge [8086:15c0] and the Intel
JHL7540 Thunderbolt 3 Bridge [8086:15ea] do not.

Previously we tried to wait for Link training to complete, but since there
was no DLL Link Active reporting, all we could do was wait the worst-case
1000 ms, then another 100 ms.

Instead of using the supported speeds to determine whether to wait for Link
training, check whether the port supports DLL Link Active reporting.  The
Ports in question do not, so we'll wait only the 100 ms required for Ports
that support Link speeds <= 5 GT/s.

This of course assumes these Ports always train the Link within 100 ms even
if they are operating at > 5 GT/s, which is not required by the spec.

This version adds a special check for devices whose power management is
disabled by their driver (->pm_cap is set to zero). This is needed to
avoid regression with some NVIDIA GPUs.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=208597
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206837
Link: https://lore.kernel.org/r/20200514133043.27429-1-mika.westerberg@linux.intel.com
Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/pci.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a458c46d7e39..33eb502a60c8 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4658,7 +4658,8 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
  * pcie_wait_for_link_delay - Wait until link is active or inactive
  * @pdev: Bridge device
  * @active: waiting for active or inactive?
- * @delay: Delay to wait after link has become active (in ms)
+ * @delay: Delay to wait after link has become active (in ms). Specify %0
+ *	   for no delay.
  *
  * Use this to wait till link becomes active or inactive.
  */
@@ -4699,7 +4700,7 @@ static bool pcie_wait_for_link_delay(struct pci_dev *pdev, bool active,
 		msleep(10);
 		timeout -= 10;
 	}
-	if (active && ret)
+	if (active && ret && delay)
 		msleep(delay);
 	else if (ret != active)
 		pci_info(pdev, "Data Link Layer Link Active not %s in 1000 msec\n",
@@ -4793,8 +4794,13 @@ void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev)
 	 * accessing the device after reset (that is 1000 ms + 100 ms). In
 	 * practice this should not be needed because we don't do power
 	 * management for them (see pci_bridge_d3_possible()).
+	 *
+	 * Also do the same for devices that have power management disabled
+	 * by their driver and are completely power managed through the
+	 * root port power resource instead. This is a special case for
+	 * nouveau.
 	 */
-	if (!pci_is_pcie(dev)) {
+	if (!pci_is_pcie(dev) || !child->pm_cap) {
 		pci_dbg(dev, "waiting %d ms for secondary bus\n", 1000 + delay);
 		msleep(1000 + delay);
 		return;
@@ -4820,17 +4826,28 @@ void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev)
 	if (!pcie_downstream_port(dev))
 		return;
 
-	if (pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT) {
-		pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
-		msleep(delay);
-	} else {
-		pci_dbg(dev, "waiting %d ms for downstream link, after activation\n",
-			delay);
-		if (!pcie_wait_for_link_delay(dev, true, delay)) {
+	/*
+	 * Per PCIe r5.0, sec 6.6.1, for downstream ports that support
+	 * speeds > 5 GT/s, we must wait for link training to complete
+	 * before the mandatory delay.
+	 *
+	 * We can only tell when link training completes via DLL Link
+	 * Active, which is required for downstream ports that support
+	 * speeds > 5 GT/s (sec 7.5.3.6).  Unfortunately some common
+	 * devices do not implement Link Active reporting even when it's
+	 * required, so we'll check for that directly instead of checking
+	 * the supported link speed.  We assume devices without Link Active
+	 * reporting can train in 100 ms regardless of speed.
+	 */
+	if (dev->link_active_reporting) {
+		pci_dbg(dev, "waiting for link to train\n");
+		if (!pcie_wait_for_link_delay(dev, true, 0)) {
 			/* Did not train, no need to wait any further */
 			return;
 		}
 	}
+	pci_dbg(child, "waiting %d ms to become accessible\n", delay);
+	msleep(delay);
 
 	if (!pci_device_is_present(child)) {
 		pci_dbg(child, "waiting additional %d ms to become accessible\n", delay);
-- 
2.28.0

