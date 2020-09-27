Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9426279FA4
	for <lists+linux-pci@lfdr.de>; Sun, 27 Sep 2020 10:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbgI0I3b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Sep 2020 04:29:31 -0400
Received: from mga03.intel.com ([134.134.136.65]:31482 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730548AbgI0I3a (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 27 Sep 2020 04:29:30 -0400
IronPort-SDR: WFSjwK8cYqQHQnJmKUlKlq68ypNWakChcE0YAFE8+VxNKmRzlGKm/oeCbHKk5AbNr0k6FEr/f4
 jZA/JK/jeCEA==
X-IronPort-AV: E=McAfee;i="6000,8403,9756"; a="161912202"
X-IronPort-AV: E=Sophos;i="5.77,309,1596524400"; 
   d="scan'208";a="161912202"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 01:29:30 -0700
IronPort-SDR: 1wAIsIchmeEmypOu/RH+O+8G4P6HKibAmlUzRWwVsjsxSupfoktZx4+jYCcQcJBJ/XV9eivWjR
 UxwdsByz7EPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,309,1596524400"; 
   d="scan'208";a="456437745"
Received: from shskylake.sh.intel.com ([10.239.48.137])
  by orsmga004.jf.intel.com with ESMTP; 27 Sep 2020 01:29:27 -0700
From:   Ethan Zhao <haifeng.zhao@intel.com>
To:     bhelgaas@google.com, oohall@gmail.com, ruscur@russell.cc,
        lukas@wunner.de, andriy.shevchenko@linux.intel.com,
        stuart.w.hayes@gmail.com, mr.nuke.me@gmail.com,
        mika.westerberg@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        pei.p.jia@intel.com, ashok.raj@linux.intel.com,
        sathyanarayanan.kuppuswamy@intel.com, hch@infradead.org,
        joe@perches.com, Ethan Zhao <haifeng.zhao@intel.com>
Subject: [PATCH 4/5 V4] PCI: only return true when dev io state is really changed
Date:   Sun, 27 Sep 2020 04:27:35 -0400
Message-Id: <20200927082736.14633-5-haifeng.zhao@intel.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200927082736.14633-1-haifeng.zhao@intel.com>
References: <20200927082736.14633-1-haifeng.zhao@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When uncorrectable error happens, AER driver and DPC driver interrupt
handlers likely call

   pcie_do_recovery()
   ->pci_walk_bus()
     ->report_frozen_detected()

with pci_channel_io_frozen the same time.
   If pci_dev_set_io_state() return true even if the original state is
pci_channel_io_frozen, that will cause AER or DPC handler re-enter
the error detecting and recovery procedure one after another.
   The result is the recovery flow mixed between AER and DPC.
So simplify the pci_dev_set_io_state() function to only return true
when dev->error_state is changed.

Signed-off-by: Ethan Zhao <haifeng.zhao@intel.com>
Tested-by: Wen Jin <wen.jin@intel.com>
Tested-by: Shanshan Zhang <ShanshanX.Zhang@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Reviewed-by: Joe Perches <joe@perches.com>
---
Changnes:
 V2: revise description and code according to suggestion from Andy.
 V3: change code to simpler.
 V4: no change.
 
 drivers/pci/pci.h | 37 +++++--------------------------------
 1 file changed, 5 insertions(+), 32 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fa12f7cbc1a0..a2c1c7d5f494 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -359,39 +359,12 @@ struct pci_sriov {
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
-	}
-	if (changed)
-		dev->error_state = new;
-	return changed;
+	if (dev->error_state == new)
+		return false;
+
+	dev->error_state = new;
+	return true;
 }
 
 static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
-- 
2.18.4

