Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2527854245B
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 08:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245096AbiFHBC7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jun 2022 21:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1453996AbiFGXQP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Jun 2022 19:16:15 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918D83BF6F0;
        Tue,  7 Jun 2022 14:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654636138; x=1686172138;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uaj2zVTRdbat138k5S+d3ScjGk5l9kGngqRsS56dZKs=;
  b=OUa9P3Mkx4wSzDO2h7nDmqBqfwn/+H9lCeLrErRcLvt1+ZKs+qrFOeEo
   jXfOAHgt9n2Dj2ywZDydyUfGm/ozWlVt+NI5LLXYn8cPCExVSjhQzOHpu
   CsEdSDm2tYaL2i/4XP51EIWN8/VWG4A6FQA5AryBLI2kj1JEcQy/smeD2
   LyFk+rUwUiJqAl49BedX7/MKAc4MdXBAk8QV0pJOg/PHzGFl1WvntZPZW
   BerwY3/bcGeiGw2ohz55NsFTusVp17/OBd3cwchNphb7ocEqBzGQSvgB+
   lAp4l3P+I2/Zp7BnCChdmeBADPdo0NZHQrXNip5jstXYasWcDNQ8BxApa
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="257191733"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="257191733"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 14:08:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="723522760"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 07 Jun 2022 14:08:54 -0700
Received: from rjingar-desk5.amr.corp.intel.com (unknown [10.209.92.238])
        by linux.intel.com (Postfix) with ESMTP id A6FA8580A8B;
        Tue,  7 Jun 2022 14:08:53 -0700 (PDT)
From:   Rajvi Jingar <rajvi.jingar@linux.intel.com>
To:     rafael.j.wysocki@intel.com, bhelgaas@google.com
Cc:     rajvi.jingar@linux.intel.com, david.e.box@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v6 1/2] PCI/PM: refactor pci_pm_suspend_noirq()
Date:   Tue,  7 Jun 2022 14:08:51 -0700
Message-Id: <20220607210852.475863-1-rajvi.jingar@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
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

