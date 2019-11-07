Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA168F2E0C
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2019 13:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfKGMTA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Nov 2019 07:19:00 -0500
Received: from mga18.intel.com ([134.134.136.126]:18274 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388319AbfKGMSy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Nov 2019 07:18:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2019 04:18:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,278,1569308400"; 
   d="scan'208";a="201023124"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 07 Nov 2019 04:18:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 273A7FC; Thu,  7 Nov 2019 14:18:48 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] PCI: Introduce pcie_wait_for_link_delay()
Date:   Thu,  7 Nov 2019 15:18:46 +0300
Message-Id: <20191107121847.24781-2-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191107121847.24781-1-mika.westerberg@linux.intel.com>
References: <20191107121847.24781-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is otherwise similar to pcie_wait_for_link() but allows passing
custom activation delay in milliseconds.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/pci.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ecc775793c3c..7083adc07f5c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4588,14 +4588,17 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
 
 	return pci_dev_wait(dev, "PM D3hot->D0", PCIE_RESET_READY_POLL_MS);
 }
+
 /**
- * pcie_wait_for_link - Wait until link is active or inactive
+ * pcie_wait_for_link_delay - Wait until link is active or inactive
  * @pdev: Bridge device
  * @active: waiting for active or inactive?
+ * @delay: Delay to wait after link has become active (in ms)
  *
  * Use this to wait till link becomes active or inactive.
  */
-bool pcie_wait_for_link(struct pci_dev *pdev, bool active)
+static bool pcie_wait_for_link_delay(struct pci_dev *pdev, bool active,
+				     int delay)
 {
 	int timeout = 1000;
 	bool ret;
@@ -4632,13 +4635,25 @@ bool pcie_wait_for_link(struct pci_dev *pdev, bool active)
 		timeout -= 10;
 	}
 	if (active && ret)
-		msleep(100);
+		msleep(delay);
 	else if (ret != active)
 		pci_info(pdev, "Data Link Layer Link Active not %s in 1000 msec\n",
 			active ? "set" : "cleared");
 	return ret == active;
 }
 
+/**
+ * pcie_wait_for_link - Wait until link is active or inactive
+ * @pdev: Bridge device
+ * @active: waiting for active or inactive?
+ *
+ * Use this to wait till link becomes active or inactive.
+ */
+bool pcie_wait_for_link(struct pci_dev *pdev, bool active)
+{
+	return pcie_wait_for_link_delay(pdev, active, 100);
+}
+
 void pci_reset_secondary_bus(struct pci_dev *dev)
 {
 	u16 ctrl;
-- 
2.24.0.rc1

