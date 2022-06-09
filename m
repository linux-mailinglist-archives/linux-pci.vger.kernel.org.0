Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B8654405C
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jun 2022 02:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235215AbiFIAKY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 20:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235529AbiFIAKV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 20:10:21 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137EC3467E;
        Wed,  8 Jun 2022 17:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654733418; x=1686269418;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a4P2Gcxk73HDhExF9ALEg8W8RNzRGhGylrPCFfw/tP0=;
  b=UIl32lTyCoFNcJe0tLk+4DKWd/ztfwZQ+R/BjywYk0TNiVR0W8TPC91P
   uMhcywBHm91c5ssR2GcD7FTy5FOiLeyNq5aXgJP5DwRJf0u1Az3oTWKHA
   DZn/bj03az8Nb0FvmJfUHesRgD2HYBGeb+R6SZN3nUdAc7pYoYwxaKKeX
   BmapWkfS1JMUgEo5AP0f4KqKolgUFWZZ6KrpTZ4leVlBJ+dNSJMCaaFTm
   DuEAQDlE9+mtk3iihqY20os0QD7GD4aH9iH7BkhICuI08DYUZT5UsxjT4
   JEBsSJjpyG3vT7ejS8jmOdrPNNhhE0bAqJFue8PeJX1BxNV7/MUca4y8Y
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="260229122"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="260229122"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 17:10:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="580316768"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 08 Jun 2022 17:10:08 -0700
Received: from rjingar-desk5.amr.corp.intel.com (unknown [10.251.26.11])
        by linux.intel.com (Postfix) with ESMTP id 62BB3580BE1;
        Wed,  8 Jun 2022 17:10:08 -0700 (PDT)
From:   Rajvi Jingar <rajvi.jingar@linux.intel.com>
To:     rafael.j.wysocki@intel.com, bhelgaas@google.com
Cc:     rajvi.jingar@linux.intel.com, david.e.box@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v7 1/2] PCI/PM: refactor pci_pm_suspend_noirq()
Date:   Wed,  8 Jun 2022 17:10:06 -0700
Message-Id: <20220609001007.533242-1-rajvi.jingar@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The state of the device is saved during pci_pm_suspend_noirq(), if it
has not already been saved, regardless of the skip_bus_pm flag value. So
skip_bus_pm check is removed before saving the device state.

Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
Suggested-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 v1 -> v2: add comments to the changes
 v2 -> v3: move changelog after "---" marker
 v3 -> v4: add "---" marker after changelog
 v4 -> v5: no change
 v5 -> v6: no change
 v6 -> v7: no change
---
 drivers/pci/pci-driver.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 49238ddd39ee..1f64de3e5280 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -867,20 +867,14 @@ static int pci_pm_suspend_noirq(struct device *dev)
 		}
 	}
 
-	if (pci_dev->skip_bus_pm) {
+	if (!pci_dev->state_saved) {
+		pci_save_state(pci_dev);
 		/*
-		 * Either the device is a bridge with a child in D0 below it, or
-		 * the function is running for the second time in a row without
-		 * going through full resume, which is possible only during
-		 * suspend-to-idle in a spurious wakeup case.  The device should
-		 * be in D0 at this point, but if it is a bridge, it may be
-		 * necessary to save its state.
+		 * If the device is a bridge with a child in D0 below it, it needs to
+		 * stay in D0, so check skip_bus_pm to avoid putting it into a
+		 * low-power state in that case.
 		 */
-		if (!pci_dev->state_saved)
-			pci_save_state(pci_dev);
-	} else if (!pci_dev->state_saved) {
-		pci_save_state(pci_dev);
-		if (pci_power_manageable(pci_dev))
+		if (!pci_dev->skip_bus_pm && pci_power_manageable(pci_dev))
 			pci_prepare_to_sleep(pci_dev);
 	}
 
-- 
2.25.1

