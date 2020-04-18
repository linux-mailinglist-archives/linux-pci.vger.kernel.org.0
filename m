Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 137281AF295
	for <lists+linux-pci@lfdr.de>; Sat, 18 Apr 2020 19:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgDRRMA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Apr 2020 13:12:00 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41913 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgDRRL6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 18 Apr 2020 13:11:58 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 30cb542102df344c; Sat, 18 Apr 2020 19:11:54 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans De Goede <hdegoede@redhat.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 4/9] PM: sleep: core: Rework the power.may_skip_resume handling
Date:   Sat, 18 Apr 2020 18:52:19 +0200
Message-ID: <4410060.DOjU9hYLuO@kreacher>
In-Reply-To: <5673945.BT02kTCndr@kreacher>
References: <1888197.j9z7NJ8yPn@kreacher> <5673945.BT02kTCndr@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Because the power.may_skip_resume device status bit is taken
into account in combination with the DPM_FLAG_LEAVE_SUSPENDED
driver flag, it can be set to 'true' for all devices in the
"suspend" phase of a suspend-resume cycle, so do that.

Then, neither the PM core nor the middle-layer (sybsystem) code
handling it needs to set it to 'true' any more and it just has
to be cleared if there is a reason to avoid skipping the "noirq"
and "early" resume callbacks provided by the driver, so update
the code in question accordingly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

New patch.

---
 drivers/acpi/device_pm.c  |  8 +++-----
 drivers/base/power/main.c | 10 ++--------
 drivers/pci/pci-driver.c  |  8 +++-----
 3 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index 399684085f85..1b02d7dc7d34 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1100,10 +1100,8 @@ int acpi_subsys_suspend_noirq(struct device *dev)
 {
 	int ret;
 
-	if (dev_pm_smart_suspend_and_suspended(dev)) {
-		dev->power.may_skip_resume = true;
+	if (dev_pm_smart_suspend_and_suspended(dev))
 		return 0;
-	}
 
 	ret = pm_generic_suspend_noirq(dev);
 	if (ret)
@@ -1116,8 +1114,8 @@ int acpi_subsys_suspend_noirq(struct device *dev)
 	 * acpi_subsys_complete() to take care of fixing up the device's state
 	 * anyway, if need be.
 	 */
-	dev->power.may_skip_resume = device_may_wakeup(dev) ||
-					!device_can_wakeup(dev);
+	if (device_can_wakeup(dev) && !device_may_wakeup(dev))
+		dev->power.may_skip_resume = false;
 
 	return 0;
 }
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 25b0302188d8..5adf0be6aa47 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1415,14 +1415,8 @@ static int __device_suspend_late(struct device *dev, pm_message_t state, bool as
 	if (callback)
 		goto Run;
 
-	if (dev_pm_smart_suspend_and_suspended(dev)) {
-		/*
-		 * In principle, the resume of the device may be skippend if it
-		 * remains in runtime suspend at this point.
-		 */
-		dev->power.may_skip_resume = true;
+	if (dev_pm_smart_suspend_and_suspended(dev))
 		goto Skip;
-	}
 
 	if (dev->driver && dev->driver->pm) {
 		info = "late driver ";
@@ -1647,7 +1641,7 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
 		dev->power.direct_complete = false;
 	}
 
-	dev->power.may_skip_resume = false;
+	dev->power.may_skip_resume = true;
 	dev->power.must_resume = false;
 
 	dpm_watchdog_set(&wd, dev);
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 685fbf044911..ce220b1987df 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -789,10 +789,8 @@ static int pci_pm_suspend_noirq(struct device *dev)
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 
-	if (dev_pm_smart_suspend_and_suspended(dev)) {
-		dev->power.may_skip_resume = true;
+	if (dev_pm_smart_suspend_and_suspended(dev))
 		return 0;
-	}
 
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_suspend_late(dev, PMSG_SUSPEND);
@@ -880,8 +878,8 @@ static int pci_pm_suspend_noirq(struct device *dev)
 	 * pci_pm_complete() to take care of fixing up the device's state
 	 * anyway, if need be.
 	 */
-	dev->power.may_skip_resume = device_may_wakeup(dev) ||
-					!device_can_wakeup(dev);
+	if (device_can_wakeup(dev) && !device_may_wakeup(dev))
+		dev->power.may_skip_resume = false;
 
 	return 0;
 }
-- 
2.16.4




