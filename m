Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672F15757F1
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 01:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240931AbiGNXQU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 19:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240920AbiGNXQU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 19:16:20 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B1B70E52;
        Thu, 14 Jul 2022 16:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657840578; x=1689376578;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FrYh3K9iwXAx6UuvS+41bwa0q58BzXMelivLnufGNBc=;
  b=dDipWpuB/5/6qMV0Xh9JhBItKlGvkQhthmEs4MtCASYGk0ulTBA/Vdnw
   +tD7sqR0Uy1315OQkuCH1768HWJZdsH+kD1lsoUjEf5YgcDI8J/8pJYuU
   s2wBH/tS6AZljAkzCOjL205cFYJiBLYhWx5u6JQhewBm+cS38He9vnc02
   FA0jitX5RZVjrzHaUflyv4Coxu8uCD7ZD+Sfow/rzNVKWDdz+OkeiLDIq
   HkKo/V1yvET2vV3Hpqw5Bo4k9O2br639YO3dg9lsQ/BP3XxL1dV9KsdGX
   bn3hJaKlRUjCS4luVVKbqVL2UyKHxZVHWbS4R++hD7POw3EMlGl+7JQgW
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="268676975"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="268676975"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 16:16:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="663970223"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 14 Jul 2022 16:16:10 -0700
Received: from rjingar-desk5.amr.corp.intel.com (vicentes-mobl.amr.corp.intel.com [10.209.132.117])
        by linux.intel.com (Postfix) with ESMTP id 0E86E580812;
        Thu, 14 Jul 2022 16:16:10 -0700 (PDT)
From:   Rajvi Jingar <rajvi.jingar@linux.intel.com>
To:     rafael.j.wysocki@intel.com, bhelgaas@google.com
Cc:     rajvi.jingar@linux.intel.com, david.e.box@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 1/2] PCI/PM: refactor pci_pm_suspend_noirq()
Date:   Thu, 14 Jul 2022 16:16:08 -0700
Message-Id: <20220714231609.3962051-1-rajvi.jingar@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

