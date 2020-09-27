Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D74279DBB
	for <lists+linux-pci@lfdr.de>; Sun, 27 Sep 2020 05:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730251AbgI0DaN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 26 Sep 2020 23:30:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:65386 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730250AbgI0DaN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 26 Sep 2020 23:30:13 -0400
IronPort-SDR: NxTuNn9+vb+x2PaDySmV0JOT6jJbvwlVXQwCIZ+WjPmm4qi24g3gT6PxcNqwH3mdMK8qgqLIf7
 l9UM12bnhMXA==
X-IronPort-AV: E=McAfee;i="6000,8403,9756"; a="141242670"
X-IronPort-AV: E=Sophos;i="5.77,308,1596524400"; 
   d="scan'208";a="141242670"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2020 20:30:12 -0700
IronPort-SDR: k7kuHZOWuM6IQrSnGRUR3zYbRDGCMufzqKZhok+pDtbmKePH/qNPUOJY5HucATi1ycN9zgk3KE
 870H3MnH+aJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,308,1596524400"; 
   d="scan'208";a="337697538"
Received: from shskylake.sh.intel.com ([10.239.48.137])
  by fmsmga004.fm.intel.com with ESMTP; 26 Sep 2020 20:30:09 -0700
From:   Ethan Zhao <haifeng.zhao@intel.com>
To:     bhelgaas@google.com, oohall@gmail.com, ruscur@russell.cc,
        lukas@wunner.de, andriy.shevchenko@linux.intel.com,
        stuart.w.hayes@gmail.com, mr.nuke.me@gmail.com,
        mika.westerberg@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        pei.p.jia@intel.com, ashok.raj@linux.intel.com,
        sathyanarayanan.kuppuswamy@intel.com,
        Ethan Zhao <haifeng.zhao@intel.com>
Subject: [PATCH 4/5 V2] PCI: only return true when dev io state is really changed
Date:   Sat, 26 Sep 2020 23:28:28 -0400
Message-Id: <20200927032829.11321-5-haifeng.zhao@intel.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200927032829.11321-1-haifeng.zhao@intel.com>
References: <20200927032829.11321-1-haifeng.zhao@intel.com>
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
---
Changes:
 V2: revise doc and code flow according to Andy's suggestion.
 drivers/pci/pci.h | 34 +++++-----------------------------
 1 file changed, 5 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fa12f7cbc1a0..387f891ce6a1 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -362,35 +362,11 @@ static inline bool pci_dev_set_io_state(struct pci_dev *dev,
 	bool changed = false;
 
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
+	if (dev->error_state == new)
+		return changed;
+
+	dev->error_state = new;
+	changed = true;
 	return changed;
 }
 
-- 
2.18.4

