Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA9CF4587
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2019 12:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfKHLS7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Nov 2019 06:18:59 -0500
Received: from mga04.intel.com ([192.55.52.120]:35937 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfKHLS7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Nov 2019 06:18:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2019 03:18:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,281,1569308400"; 
   d="scan'208";a="377739250"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 08 Nov 2019 03:18:56 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 11B47115; Fri,  8 Nov 2019 13:18:55 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Keith Busch <kbusch@kernel.org>,
        Andrew Murray <andrew.murray@arm.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] PCI: pciehp: Refactor infinite loop in pcie_poll_cmd()
Date:   Fri,  8 Nov 2019 13:18:55 +0200
Message-Id: <20191108111855.85866-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Infinite timeout loops are hard to read. Refactor it
to plausible 'do {} while ()'.

Note, the supplied timeout can't be negative for current use,
though if it's not dividable to 10, we may go below 0,
that's why type of the parameter is int. And thus, we may move
the check to the loop condition.

No functional changes implied.

Reviewed-by: Andrew Murray <andrew.murray@arm.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
- corrected loop conditional to include 0 comparison (Keith)
- added Rb (Andrew)
 drivers/pci/hotplug/pciehp_hpc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 86d97f3112f0..764384153c7d 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -68,7 +68,7 @@ static int pcie_poll_cmd(struct controller *ctrl, int timeout)
 	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 slot_status;
 
-	while (true) {
+	do {
 		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
 		if (slot_status == (u16) ~0) {
 			ctrl_info(ctrl, "%s: no response from device\n",
@@ -81,11 +81,9 @@ static int pcie_poll_cmd(struct controller *ctrl, int timeout)
 						   PCI_EXP_SLTSTA_CC);
 			return 1;
 		}
-		if (timeout < 0)
-			break;
 		msleep(10);
 		timeout -= 10;
-	}
+	} while (timeout >= 0);
 	return 0;	/* timeout */
 }
 
-- 
2.24.0.rc1

