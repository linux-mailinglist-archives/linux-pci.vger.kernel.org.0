Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 473B9285E2F
	for <lists+linux-pci@lfdr.de>; Wed,  7 Oct 2020 13:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbgJGLdq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Oct 2020 07:33:46 -0400
Received: from mga06.intel.com ([134.134.136.31]:24765 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727702AbgJGLdn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Oct 2020 07:33:43 -0400
IronPort-SDR: iwoJxEYC2GoIyS7zSZpwYTWVrlX2M1LRd5Vp8f8JJ6hkE8n6KemI9c2LLQthZ92RHTRPSAtpmg
 GuHdyfl670mw==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="226492572"
X-IronPort-AV: E=Sophos;i="5.77,346,1596524400"; 
   d="scan'208";a="226492572"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 04:33:42 -0700
IronPort-SDR: TDVHQKDcRDR+CN8aIlfPpgFZ1tN4/6zbHOxToBpn0t5VBslZjxbvBVMmMaUGsuCp84OYkPhY20
 TFl81T0ky6lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,346,1596524400"; 
   d="scan'208";a="354862173"
Received: from shskylake.sh.intel.com ([10.239.48.137])
  by orsmga007.jf.intel.com with ESMTP; 07 Oct 2020 04:33:39 -0700
From:   Ethan Zhao <haifeng.zhao@intel.com>
To:     bhelgaas@google.com, oohall@gmail.com, ruscur@russell.cc,
        lukas@wunner.de, andriy.shevchenko@linux.intel.com,
        stuart.w.hayes@gmail.com, mr.nuke.me@gmail.com,
        mika.westerberg@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@linux.intel.com, sathyanarayanan.kuppuswamy@intel.com,
        xerces.zhao@gmail.com, Ethan Zhao <haifeng.zhao@intel.com>
Subject: [PATCH v8 4/6] PCI/ERR: simplify function pci_dev_set_io_state() with if
Date:   Wed,  7 Oct 2020 07:31:56 -0400
Message-Id: <20201007113158.48933-5-haifeng.zhao@intel.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201007113158.48933-1-haifeng.zhao@intel.com>
References: <20201007113158.48933-1-haifeng.zhao@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

No function change.

Signed-off-by: Ethan Zhao <haifeng.zhao@intel.com>
---
Changes:
 v8: based on Bjorn's code and truth table, simplify the logic of
function pci_dev_set_io_state(), no function change.

 drivers/pci/pci.h | 54 ++++++++++++++++++++---------------------------
 1 file changed, 23 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 455b32187abd..bceb3f108744 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -359,39 +359,31 @@ struct pci_sriov {
 static inline bool pci_dev_set_io_state(struct pci_dev *dev,
 					pci_channel_state_t new)
 {
-	bool changed = false;
-
 	device_lock_assert(&dev->dev);
-	switch (new) {
-	case pci_channel_io_perm_failure:
-		switch (dev->error_state) {
-		case pci_channel_io_frozen:
-		case pci_channel_io_normal:
-		case pci_channel_io_perm_failure:
-			changed = true;
-			break;
-		}
-		break;
-	case pci_channel_io_frozen:
-		switch (dev->error_state) {
-		case pci_channel_io_frozen:
-		case pci_channel_io_normal:
-			changed = true;
-			break;
-		}
-		break;
-	case pci_channel_io_normal:
-		switch (dev->error_state) {
-		case pci_channel_io_frozen:
-		case pci_channel_io_normal:
-			changed = true;
-			break;
-		}
-		break;
+/*
+ *                     Truth table:
+ *                     requested new state
+ *     current          ------------------------------------------
+ *     state            normal         frozen         perm_failure
+ *     ------------  +  -------------  -------------  ------------
+ *     normal        |  normal         frozen         perm_failure
+ *     frozen        |  normal         frozen         perm_failure
+ *     perm_failure  |  perm_failure*  perm_failure*  perm_failure
+ */
+
+	/* Can always put a device in perm_failure state */
+	if (new == pci_channel_io_perm_failure) {
+		dev->error_state = pci_channel_io_perm_failure;
+		return true;
 	}
-	if (changed)
-		dev->error_state = new;
-	return changed;
+
+	/* If already in perm_failure, can't set to normal or frozen */
+	if (dev->error_state == pci_channel_io_perm_failure)
+		return false;
+
+	 /* Can always change normal to frozen or vice versa */
+	dev->error_state = new;
+	return true;
 }
 
 static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
-- 
2.18.4

