Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B2327E200
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 09:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgI3HHt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 03:07:49 -0400
Received: from mga07.intel.com ([134.134.136.100]:34494 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728346AbgI3HHm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Sep 2020 03:07:42 -0400
IronPort-SDR: PcrT3ah9QRus4BIHLUO/cwUXGOKSGg32PRRybMd6QdjXybno0e3EKq/ZrSVwQc9RscxAJHIn19
 +xY1HqufnVhw==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="226533042"
X-IronPort-AV: E=Sophos;i="5.77,321,1596524400"; 
   d="scan'208";a="226533042"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 00:07:41 -0700
IronPort-SDR: lEQvHh6FsuO66EQyJ1k2VenG1B/fdTdfGnJwRf5734aSMId/TSjkY2ThpuPKWL+5EKb22NKPM6
 SrM6KhnfM+1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,321,1596524400"; 
   d="scan'208";a="496014017"
Received: from shskylake.sh.intel.com ([10.239.48.137])
  by orsmga005.jf.intel.com with ESMTP; 30 Sep 2020 00:07:38 -0700
From:   Ethan Zhao <haifeng.zhao@intel.com>
To:     bhelgaas@google.com, oohall@gmail.com, ruscur@russell.cc,
        lukas@wunner.de, andriy.shevchenko@linux.intel.com,
        stuart.w.hayes@gmail.com, mr.nuke.me@gmail.com,
        mika.westerberg@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@linux.intel.com, sathyanarayanan.kuppuswamy@intel.com,
        xerces.zhao@gmail.com, Ethan Zhao <haifeng.zhao@intel.com>
Subject: [PATCH v6 4/5] PCI: only return true when dev io state is really changed
Date:   Wed, 30 Sep 2020 03:05:36 -0400
Message-Id: <20200930070537.30982-5-haifeng.zhao@intel.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200930070537.30982-1-haifeng.zhao@intel.com>
References: <20200930070537.30982-1-haifeng.zhao@intel.com>
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
Reviewed-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
Changnes:
 v2: revise description and code according to suggestion from Andy.
 v3: change code to simpler.
 v4: no change.
 v5: no change.
 v6: no change.

 drivers/pci/pci.h | 37 +++++--------------------------------
 1 file changed, 5 insertions(+), 32 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 455b32187abd..f2beeaeda321 100644
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

