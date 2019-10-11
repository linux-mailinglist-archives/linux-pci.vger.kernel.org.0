Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2354D3BD9
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2019 11:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfJKJCe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Oct 2019 05:02:34 -0400
Received: from mga09.intel.com ([134.134.136.24]:2223 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbfJKJCe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Oct 2019 05:02:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2019 02:02:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,283,1566889200"; 
   d="scan'208";a="369364202"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 11 Oct 2019 02:02:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 559FA312; Fri, 11 Oct 2019 12:02:31 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] PCI: pciehp: Refactor infinite loop in pcie_poll_cmd()
Date:   Fri, 11 Oct 2019 12:02:30 +0300
Message-Id: <20191011090230.81080-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0
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

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 1a522c1c4177..e397c78ca232 100644
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
+	} while (timeout > 0);
 	return 0;	/* timeout */
 }
 
-- 
2.23.0

