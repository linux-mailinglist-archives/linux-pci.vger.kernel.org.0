Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FECF1D314D
	for <lists+linux-pci@lfdr.de>; Thu, 14 May 2020 15:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgENNas (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 May 2020 09:30:48 -0400
Received: from mga03.intel.com ([134.134.136.65]:29703 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbgENNas (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 May 2020 09:30:48 -0400
IronPort-SDR: VqrhY55h7FjlJe+pSzP22yHifxr8fTjP75jvxUZtNh/TyNASSoeFhUf5WLEbgEPDqR4ejNalH4
 6PqmEe707LBQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 06:30:47 -0700
IronPort-SDR: 8ZrAJYygMJfH6yIs7UZ9iQkmp/Xn5V/Vs+MwvyLwSqcIhaQlsOLmCSBC9M9kBbq+jEwcl+5DqE
 H40ZSI4fuhDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,391,1583222400"; 
   d="scan'208";a="437906429"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 14 May 2020 06:30:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id F341D3B6; Thu, 14 May 2020 16:30:43 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v2] PCI: Do not use pcie_get_speed_cap() to determine when to start waiting
Date:   Thu, 14 May 2020 16:30:43 +0300
Message-Id: <20200514133043.27429-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Kai-Heng Feng reported that it takes long time (>1s) to resume
Thunderbolt connected PCIe devices from both runtime suspend and system
sleep (s2idle).

These PCIe downstream ports the second link capability (PCI_EXP_LNKCAP2)
announces support for speeds > 5 GT/s but it is then capped by the
second link control (PCI_EXP_LNKCTL2) register to 2.5 GT/s. This
possiblity was not considered in pci_bridge_wait_for_secondary_bus() so
it ended up waiting for 1100 ms as these ports do not support active
link layer reporting either.

PCIe spec 5.0 section 6.6.1 mandates that we must wait minimum of 100 ms
before sending configuration request to the device below, if the port
does not support speeds > 5 GT/s, and if it does we first need to wait
for the data link layer to become active before waiting for that 100 ms.

PCIe spec 5.0 section 7.5.3.6 further says that all downstream ports
that support speeds > 5 GT/s must support active link layer reporting so
instead of looking for the speed we can check for the active link layer
reporting capability and determine how to wait based on that (as they go
hand in hand).

While there restructure the code a bit so that the delay is always
issued in pci_bridge_wait_for_secondary_bus() by passing value of 0 to
pcie_wait_for_link_delay().

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206837
Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
v2: Restructured the code a bit so that it should be more readable now

Previous version can be found here:

  https://lore.kernel.org/linux-pci/20200514123105.GW2571@lahna.fi.intel.com/

@Kai-heng, since this patch is slightly different than what you tried, I
wonder if you could check that it still solves the and does not break
anything? I tested it myself but it would be nice to get your Tested-by to
make sure it still works.

 drivers/pci/pci.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 595fcf59843f..590c73dc7e0d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4660,7 +4660,8 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
  * pcie_wait_for_link_delay - Wait until link is active or inactive
  * @pdev: Bridge device
  * @active: waiting for active or inactive?
- * @delay: Delay to wait after link has become active (in ms)
+ * @delay: Delay to wait after link has become active (in ms). Specify %0
+ *	   for no delay.
  *
  * Use this to wait till link becomes active or inactive.
  */
@@ -4701,7 +4702,7 @@ static bool pcie_wait_for_link_delay(struct pci_dev *pdev, bool active,
 		msleep(10);
 		timeout -= 10;
 	}
-	if (active && ret)
+	if (active && ret && delay)
 		msleep(delay);
 	else if (ret != active)
 		pci_info(pdev, "Data Link Layer Link Active not %s in 1000 msec\n",
@@ -4822,17 +4823,21 @@ void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev)
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
+	 * Since PCIe spec mandates that all downstream ports that support
+	 * speeds greater than 5 GT/s must support data link layer active
+	 * reporting so if it is supported we poll for the link to become
+	 * active before issuing the mandatory delay.
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
2.26.2

