Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F165E56A95E
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 19:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236331AbiGGRWO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 13:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236406AbiGGRWM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 13:22:12 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4526133A23;
        Thu,  7 Jul 2022 10:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657214531; x=1688750531;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dgCPOoH+hXfK+iqKwqQrHEg8bHUcSkmFz7OpBodBAww=;
  b=OfL8ZsgQvJj29IKfgYwxa/OW6O1cud71Kk2wWy6/B7liV6jo9tUJMEy8
   o4rIIGWBpZs4xCYN8sENbskPNenuXCaPIqQE1Axi7itMVDywmUM6kD3wq
   F6PRQ0/aOIgQU1khgObfQ0kCCFrtGDBBx0FZYWnG6zV1xYQy0KNYcz4AF
   f1aUCyWt+hgrRbcVZBzmy+Sq7XLcdMUmk5EQvLXV0Kyyg4dYgFJ5TFZbJ
   CvK3QtCep2CUzlOxw4Zjk+EHqPEm7MAn5z2wSnVBcdRDHDznQ0iCKX8SB
   5eKzb0YHhs7zSxElZd5CgeoH4ZVvHWz0nRy0F2eFOMsBnY+QHsep9faO5
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="282832819"
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="282832819"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 10:22:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="651219178"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 07 Jul 2022 10:22:09 -0700
Received: from rjingar-desk5.amr.corp.intel.com (bodunhu-mobl2.amr.corp.intel.com [10.212.24.246])
        by linux.intel.com (Postfix) with ESMTP id 4D6EA5805BD;
        Thu,  7 Jul 2022 10:22:09 -0700 (PDT)
From:   Rajvi Jingar <rajvi.jingar@linux.intel.com>
To:     rafael.j.wysocki@intel.com, bhelgaas@google.com
Cc:     rajvi.jingar@linux.intel.com, david.e.box@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 1/2] PCI/PM: refactor pci_pm_suspend_noirq()
Date:   Thu,  7 Jul 2022 10:22:04 -0700
Message-Id: <20220707172205.3205110-1-rajvi.jingar@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 This patch is a resend of https://lkml.org/lkml/2022/6/8/1462
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

