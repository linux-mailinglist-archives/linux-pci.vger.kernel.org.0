Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB16D5766A1
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 20:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiGOSSX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 14:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGOSSW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 14:18:22 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4CE5B781;
        Fri, 15 Jul 2022 11:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657909101; x=1689445101;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nccjUybTT96SnZWYYYafTO6dYVit851GuJJi+EmcEcc=;
  b=N56/p7RRVfw/BGsOJE5Z2DEvqHEMlLPuCynDF//7JRdRZDjPzt7GkFko
   W3AAzm33qmVYyv/h84wP1iK8I8hz/F9SjEOd8UDgCkt/RAtfrbrhahNk9
   CdF5OQTy+ZFKQjqjT22ijo+zFnlJVnW+/ulotOE9zhLx+QOnbKGH036o8
   bscTVgGih2ThoCtQ1QME7VIM9e/iii9T7vqzaAytOf3IpXif3/EMXiWfK
   Bu4rGCWn8NDKyjd7CBdg6QNOQYgrEf8U29y9NUWzzbLGQe9+h79OOqcVY
   AuxlV6npRu/ylCWMspZU62KjC8SJ/Esvjmidf5/JiOHyZvooUtZHtTAvO
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="284628046"
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="284628046"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 11:18:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="842606182"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 15 Jul 2022 11:18:20 -0700
Received: from rjingar-desk5.amr.corp.intel.com (unknown [10.213.176.154])
        by linux.intel.com (Postfix) with ESMTP id 6BEBB580812;
        Fri, 15 Jul 2022 11:18:20 -0700 (PDT)
From:   Rajvi Jingar <rajvi.jingar@linux.intel.com>
To:     rafael.j.wysocki@intel.com, bhelgaas@google.com
Cc:     rajvi.jingar@linux.intel.com, david.e.box@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 1/2] PCI/PM: refactor pci_pm_suspend_noirq()
Date:   Fri, 15 Jul 2022 11:18:08 -0700
Message-Id: <20220715181809.232147-1-rajvi.jingar@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The state of the device is saved during pci_pm_suspend_noirq(), if it
has not already been saved, regardless of the skip_bus_pm flag value. So
skip_bus_pm check is removed before saving the device state.

Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 v1->v2: no change
 v2->v3: no change
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

