Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 566241A4813
	for <lists+linux-pci@lfdr.de>; Fri, 10 Apr 2020 18:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgDJQA5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Apr 2020 12:00:57 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:55398 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgDJQAw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Apr 2020 12:00:52 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 3cc4c344a33009c7; Fri, 10 Apr 2020 18:00:49 +0200
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
Subject: [PATCH 1/7] PM: sleep: core: Simplify the SMART_SUSPEND flag handling
Date:   Fri, 10 Apr 2020 17:48:01 +0200
Message-ID: <2654948.CWnpW94V0n@kreacher>
In-Reply-To: <1888197.j9z7NJ8yPn@kreacher>
References: <1888197.j9z7NJ8yPn@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

The code to handle the SMART_SUSPEND driver PM flag is hard to follow
and somewhat inconsistent with respect to devices without middle-layer
(subsystem) callbacks.

Namely, for those devices the core takes the role of a middle layer
in providing the expected ordering of execution of callbacks (under
the assumption that the drivers setting SMART_SUSPEND can reuse their
PM-runtime callbacks directly for system-wide suspend).  To that end,
it prevents driver ->suspend_late and ->suspend_noirq callbacks from
being executed for devices that are still runtime-suspended in
__device_suspend_late(), because running the same callback funtion
that was previously run by PM-runtime for them may be invalid.

However, it does that only for devices without any middle-layer
callbacks for the late/noirq/early suspend/resume phases even
though it would be simpler and more consistent to skip the
driver-lavel callbacks for all devices with SMART_SUSPEND set
that are runtime-suspended in __device_suspend_late().

Simplify the code in accordance with the above observation.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c | 118 +++++++++++++++-------------------------------
 1 file changed, 39 insertions(+), 79 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index fdd508a78ffd..5d0225573bbe 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -561,24 +561,6 @@ static void dpm_watchdog_clear(struct dpm_watchdog *wd)
 
 /*------------------------- Resume routines -------------------------*/
 
-/**
- * suspend_event - Return a "suspend" message for given "resume" one.
- * @resume_msg: PM message representing a system-wide resume transition.
- */
-static pm_message_t suspend_event(pm_message_t resume_msg)
-{
-	switch (resume_msg.event) {
-	case PM_EVENT_RESUME:
-		return PMSG_SUSPEND;
-	case PM_EVENT_THAW:
-	case PM_EVENT_RESTORE:
-		return PMSG_FREEZE;
-	case PM_EVENT_RECOVER:
-		return PMSG_HIBERNATE;
-	}
-	return PMSG_ON;
-}
-
 /**
  * dev_pm_may_skip_resume - System-wide device resume optimization check.
  * @dev: Target device.
@@ -656,37 +638,36 @@ static int device_resume_noirq(struct device *dev, pm_message_t state, bool asyn
 	if (!dpm_wait_for_superior(dev, async))
 		goto Out;
 
-	skip_resume = dev_pm_may_skip_resume(dev);
-
 	callback = dpm_subsys_resume_noirq_cb(dev, state, &info);
-	if (callback)
+	if (callback) {
+		skip_resume = false;
 		goto Run;
+	}
 
+	skip_resume = dev_pm_may_skip_resume(dev);
 	if (skip_resume)
 		goto Skip;
 
-	if (dev_pm_smart_suspend_and_suspended(dev)) {
-		pm_message_t suspend_msg = suspend_event(state);
-
-		/*
-		 * If "freeze" callbacks have been skipped during a transition
-		 * related to hibernation, the subsequent "thaw" callbacks must
-		 * be skipped too or bad things may happen.  Otherwise, resume
-		 * callbacks are going to be run for the device, so its runtime
-		 * PM status must be changed to reflect the new state after the
-		 * transition under way.
-		 */
-		if (!dpm_subsys_suspend_late_cb(dev, suspend_msg, NULL) &&
-		    !dpm_subsys_suspend_noirq_cb(dev, suspend_msg, NULL)) {
-			if (state.event == PM_EVENT_THAW) {
-				skip_resume = true;
-				goto Skip;
-			} else {
-				pm_runtime_set_active(dev);
-			}
-		}
+	/*
+	 * If "freeze" driver callbacks have been skipped during hibernation,
+	 * because the device was runtime-suspended in __device_suspend_late(),
+	 * the corresponding "thaw" callbacks must be skipped too, because
+	 * running them for a runtime-suspended device may not be valid.
+	 */
+	if (dev_pm_smart_suspend_and_suspended(dev) &&
+	    state.event == PM_EVENT_THAW) {
+		skip_resume = true;
+		goto Skip;
 	}
 
+	/*
+	 * The device is going to be resumed, so set its PM-runtime status to
+	 * "active", but do that only if DPM_FLAG_SMART_SUSPEND is set to avoid
+	 * confusing drivers that don't use it.
+	 */
+	if (dev_pm_smart_suspend_and_suspended(dev))
+		pm_runtime_set_active(dev);
+
 	if (dev->driver && dev->driver->pm) {
 		info = "noirq driver ";
 		callback = pm_noirq_op(dev->driver->pm, state);
@@ -1274,32 +1255,6 @@ static pm_callback_t dpm_subsys_suspend_noirq_cb(struct device *dev,
 	return callback;
 }
 
-static bool device_must_resume(struct device *dev, pm_message_t state,
-			       bool no_subsys_suspend_noirq)
-{
-	pm_message_t resume_msg = resume_event(state);
-
-	/*
-	 * If all of the device driver's "noirq", "late" and "early" callbacks
-	 * are invoked directly by the core, the decision to allow the device to
-	 * stay in suspend can be based on its current runtime PM status and its
-	 * wakeup settings.
-	 */
-	if (no_subsys_suspend_noirq &&
-	    !dpm_subsys_suspend_late_cb(dev, state, NULL) &&
-	    !dpm_subsys_resume_early_cb(dev, resume_msg, NULL) &&
-	    !dpm_subsys_resume_noirq_cb(dev, resume_msg, NULL))
-		return !pm_runtime_status_suspended(dev) &&
-			(resume_msg.event != PM_EVENT_RESUME ||
-			 (device_can_wakeup(dev) && !device_may_wakeup(dev)));
-
-	/*
-	 * The only safe strategy here is to require that if the device may not
-	 * be left in suspend, resume callbacks must be invoked for it.
-	 */
-	return !dev->power.may_skip_resume;
-}
-
 /**
  * __device_suspend_noirq - Execute a "noirq suspend" callback for given device.
  * @dev: Device to handle.
@@ -1313,7 +1268,6 @@ static int __device_suspend_noirq(struct device *dev, pm_message_t state, bool a
 {
 	pm_callback_t callback;
 	const char *info;
-	bool no_subsys_cb = false;
 	int error = 0;
 
 	TRACE_DEVICE(dev);
@@ -1331,9 +1285,7 @@ static int __device_suspend_noirq(struct device *dev, pm_message_t state, bool a
 	if (callback)
 		goto Run;
 
-	no_subsys_cb = !dpm_subsys_suspend_late_cb(dev, state, NULL);
-
-	if (dev_pm_smart_suspend_and_suspended(dev) && no_subsys_cb)
+	if (dev_pm_smart_suspend_and_suspended(dev))
 		goto Skip;
 
 	if (dev->driver && dev->driver->pm) {
@@ -1351,13 +1303,16 @@ static int __device_suspend_noirq(struct device *dev, pm_message_t state, bool a
 Skip:
 	dev->power.is_noirq_suspended = true;
 
-	if (dev_pm_test_driver_flags(dev, DPM_FLAG_LEAVE_SUSPENDED)) {
-		dev->power.must_resume = dev->power.must_resume ||
-				atomic_read(&dev->power.usage_count) > 1 ||
-				device_must_resume(dev, state, no_subsys_cb);
-	} else {
+	/*
+	 * Skipping the resume of devices that were in use right before the
+	 * system suspend (as indicated by their PM-runtime usage counters)
+	 * would be suboptimal.  Also resume them if doing that is not allowed
+	 * to be skipped.
+	 */
+	if (atomic_read(&dev->power.usage_count) > 1 ||
+	    !(dev_pm_test_driver_flags(dev, DPM_FLAG_LEAVE_SUSPENDED) &&
+	      dev->power.may_skip_resume))
 		dev->power.must_resume = true;
-	}
 
 	if (dev->power.must_resume)
 		dpm_superior_set_must_resume(dev);
@@ -1539,9 +1494,14 @@ static int __device_suspend_late(struct device *dev, pm_message_t state, bool as
 	if (callback)
 		goto Run;
 
-	if (dev_pm_smart_suspend_and_suspended(dev) &&
-	    !dpm_subsys_suspend_noirq_cb(dev, state, NULL))
+	if (dev_pm_smart_suspend_and_suspended(dev)) {
+		/*
+		 * In principle, the resume of the device may be skippend if it
+		 * remains in runtime suspend at this point.
+		 */
+		dev->power.may_skip_resume = true;
 		goto Skip;
+	}
 
 	if (dev->driver && dev->driver->pm) {
 		info = "late driver ";
-- 
2.16.4




