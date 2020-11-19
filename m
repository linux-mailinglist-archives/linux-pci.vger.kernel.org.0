Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91752B88F9
	for <lists+linux-pci@lfdr.de>; Thu, 19 Nov 2020 01:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgKSARg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Nov 2020 19:17:36 -0500
Received: from mga04.intel.com ([192.55.52.120]:42527 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbgKSARg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Nov 2020 19:17:36 -0500
IronPort-SDR: xVmg+ZTE45vTjaA1Z12DM1lrGJwEsccig8ip4gjq9uQgNzJJH261aXSHtjh9EVVOX7YiEhNIOk
 xEW1xo+QxdmA==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="168636023"
X-IronPort-AV: E=Sophos;i="5.77,488,1596524400"; 
   d="scan'208";a="168636023"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 16:17:36 -0800
IronPort-SDR: K0yjAZy610D6k9RTK94qF0OPB+3/hO7QSMCyxoZ+6lbEMfm5eu7RIxWukRyc/CU0x/sZOJJ5BT
 vasYfCf1i1Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,488,1596524400"; 
   d="scan'208";a="368559667"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Nov 2020 16:17:36 -0800
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id CDAC458088D;
        Wed, 18 Nov 2020 16:17:35 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     bhelgaas@google.com, rafael@kernel.org, len.brown@intel.com
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] PCI: Disable Precision Time Measurement during suspend
Date:   Wed, 18 Nov 2020 16:18:22 -0800
Message-Id: <20201119001822.31617-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201119001822.31617-1-david.e.box@linux.intel.com>
References: <20201119001822.31617-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Intel client platforms that support suspend-to-idle, like Ice Lake,
root ports that have Precision Time Management (PTM) enabled can prevent
the port from being fully power gated, causing higher power consumption
while suspended.  To prevent this, after saving the PTM control register,
disable the feature.  The feature will be returned to its previous state
during restore.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=209361
Reported-by: Len Brown <len.brown@intel.com>
Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/pci/pci.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 6fd4ae910a88..a2b40497d443 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -21,6 +21,7 @@
 #include <linux/module.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
+#include <linux/suspend.h>
 #include <linux/log2.h>
 #include <linux/logic_pio.h>
 #include <linux/pm_wakeup.h>
@@ -1543,7 +1544,7 @@ static void pci_save_ptm_state(struct pci_dev *dev)
 {
 	int ptm;
 	struct pci_cap_saved_state *save_state;
-	u16 *cap;
+	u16 *cap, ctrl;
 
 	if (!pci_is_pcie(dev))
 		return;
@@ -1560,6 +1561,17 @@ static void pci_save_ptm_state(struct pci_dev *dev)
 
 	cap = (u16 *)&save_state->cap.data[0];
 	pci_read_config_word(dev, ptm + PCI_PTM_CTRL, cap);
+
+	/*
+	 * On Intel systems that support suspend-to-idle, additional
+	 * power savings can be gained by disabling PTM on root ports,
+	 * as this allows the port to enter a deeper pm state.
+	 */
+	if (pm_suspend_target_state == PM_SUSPEND_TO_IDLE &&
+	    pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) {
+		ctrl = *cap & ~(PCI_PTM_CTRL_ENABLE | PCI_PTM_CTRL_ROOT);
+		pci_write_config_word(dev, ptm + PCI_PTM_CTRL, ctrl);
+	}
 }
 
 static void pci_restore_ptm_state(struct pci_dev *dev)
-- 
2.20.1

