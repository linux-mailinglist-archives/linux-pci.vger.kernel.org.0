Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641BA1ABC4E
	for <lists+linux-pci@lfdr.de>; Thu, 16 Apr 2020 11:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501892AbgDPIix (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Apr 2020 04:38:53 -0400
Received: from mga05.intel.com ([192.55.52.43]:19219 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441259AbgDPIdB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Apr 2020 04:33:01 -0400
IronPort-SDR: T6Mq+Cg1WQ++Mc8nKgZej+aFTm+mi4Fvflmwmn99W/JqcSd8nD5zFaeAXM35dSZVD0vrDaY8/V
 cYOqDEJxK/ww==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 01:32:48 -0700
IronPort-SDR: 8SzTQP3YALXk+8p8y9o1VafGNYp63FeG/sGSnV0eRCx1/eZAkfF9QO89GjTW8ceruoNZuZ/n0z
 Ste/t7TShjVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,390,1580803200"; 
   d="scan'208";a="427754672"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 16 Apr 2020 01:32:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 9608E17F; Thu, 16 Apr 2020 11:32:45 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH] PCI: Do not use pcie_get_speed_cap() to determine when to start waiting
Date:   Thu, 16 Apr 2020 11:32:45 +0300
Message-Id: <20200416083245.73957-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.25.1
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

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206837
Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/pci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 595fcf59843f..d9d9ff5b968e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4822,7 +4822,13 @@ void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev)
 	if (!pcie_downstream_port(dev))
 		return;
 
-	if (pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT) {
+	/*
+	 * Since PCIe spec mandates that all downstream ports that support
+	 * speeds greater than 5 GT/s must support data link layer active
+	 * reporting so we use that here to determine when the delay should
+	 * be issued.
+	 */
+	if (!dev->link_active_reporting) {
 		pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
 		msleep(delay);
 	} else {
-- 
2.25.1

