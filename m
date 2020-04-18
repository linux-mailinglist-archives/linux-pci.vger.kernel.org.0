Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7681AF2A8
	for <lists+linux-pci@lfdr.de>; Sat, 18 Apr 2020 19:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgDRRMS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Apr 2020 13:12:18 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:43765 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbgDRRMA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 18 Apr 2020 13:12:00 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 7816c468277ea040; Sat, 18 Apr 2020 19:11:55 +0200
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
Subject: [PATCH v2 3/9] PM: sleep: core: Do not skip callbacks in the resume phase
Date:   Sat, 18 Apr 2020 18:52:08 +0200
Message-ID: <7017648.Q9I6Cqpzo5@kreacher>
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

The current code in device_resume_noirq() causes the entire early
resume and resume phases of device suspend to be skipped for
devices for which the noirq resume phase have been skipped (due
to the LEAVE_SUSPENDED flag being set) on the premise that those
devices should stay in runtime-suspend after system-wide resume.

However, that may not be correct in two situations.  First, the
middle layer (subsystem) noirq resume callback may be missing for
a given device, but its early resume callback may be present and it
may need to do something even if it decides to skip the driver
callback.  Second, if the device's wakeup settings were adjusted
in the suspend phase without resuming the device (that was in
runtime suspend at that time), they most likely need to be
adjusted again in the resume phase and so the driver callback
in that phase needs to be run.

For the above reason, modify the core to allow the middle layer
->resume_late callback to run even if its ->resume_noirq callback
is missing (and the core has skipped the driver-level callback
in that phase) and to allow all device callbacks to run in the
resume phase.  Also make the core set the PM-runtime status of
devices with SMART_SUSPEND set whose resume callbacks are not
skipped to "active" in the "noirq" resume phase and update the
affected subsystems (PCI and ACPI) accordingly.

After this change, middle-layer (subsystem) callbacks will always
be invoked in all phases of system suspend and resume and driver
callbacks will always run in the prepare, suspend, resume, and
complete phases for all devices.

For devices with SMART_SUSPEND set, driver callbacks will be
skipped in the late and noirq phases of system suspend if those
devices remain in runtime suspend in __device_suspend_late().
Driver callbacks will also be skipped for them during the
noirq and early phases of the "thaw" transition related to
hibernation in that case.

Setting LEAVE_SUSPENDED means that the driver allows its callbacks
to be skipped in the noirq and early phases of system resume, but
some additional conditions need to be met for that to happen (among
other things, the power.may_skip_resume flag needs to be set for the
device during system suspend for the driver callbacks to be skipped
during the subsequent resume transition).

For all devices with SMART_SUSPEND set whose driver callbacks are
invoked during system resume, the PM-runtime status will be set to
"active" (by the core).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

-> v2:
  * Fixed definition of dev_pm_may_skip_resume().
  * Updated changelog.

---
 Documentation/power/pci.rst |  5 +--
 drivers/acpi/acpi_lpss.c    |  6 ++--
 drivers/acpi/device_pm.c    | 15 ++++----
 drivers/base/power/main.c   | 85 ++++++++++++++++++++++-----------------------
 drivers/pci/pci-driver.c    | 18 +++++-----
 5 files changed, 62 insertions(+), 67 deletions(-)

diff --git a/Documentation/power/pci.rst b/Documentation/power/pci.rst
index 0924d29636ad..a39b2461919a 100644
--- a/Documentation/power/pci.rst
+++ b/Documentation/power/pci.rst
@@ -1035,10 +1035,7 @@ This flag is checked by the PM core, but the PCI bus type informs the PM core
 which devices may be left in suspend from its perspective (that happens during
 the "noirq" phase of system-wide suspend and analogous transitions) and next it
 uses the dev_pm_may_skip_resume() helper to decide whether or not to return from
-pci_pm_resume_noirq() early, as the PM core will skip the remaining resume
-callbacks for the device during the transition under way and will set its
-runtime PM status to "suspended" if dev_pm_may_skip_resume() returns "true" for
-it.
+pci_pm_resume_noirq() and pci_pm_resume_early() upfront.
 
 3.2. Device Runtime Power Management
 ------------------------------------
diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index dee999938213..c4a84df6cc98 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -1093,6 +1093,9 @@ static int acpi_lpss_resume_early(struct device *dev)
 	if (pdata->dev_desc->resume_from_noirq)
 		return 0;
 
+	if (dev_pm_may_skip_resume(dev))
+		return 0;
+
 	return acpi_lpss_do_resume_early(dev);
 }
 
@@ -1105,9 +1108,6 @@ static int acpi_lpss_resume_noirq(struct device *dev)
 	if (dev_pm_may_skip_resume(dev))
 		return 0;
 
-	if (dev_pm_smart_suspend_and_suspended(dev))
-		pm_runtime_set_active(dev);
-
 	ret = pm_generic_resume_noirq(dev);
 	if (ret)
 		return ret;
diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index b2263ec67b43..399684085f85 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1132,14 +1132,6 @@ static int acpi_subsys_resume_noirq(struct device *dev)
 	if (dev_pm_may_skip_resume(dev))
 		return 0;
 
-	/*
-	 * Devices with DPM_FLAG_SMART_SUSPEND may be left in runtime suspend
-	 * during system suspend, so update their runtime PM status to "active"
-	 * as they will be put into D0 going forward.
-	 */
-	if (dev_pm_smart_suspend_and_suspended(dev))
-		pm_runtime_set_active(dev);
-
 	return pm_generic_resume_noirq(dev);
 }
 
@@ -1153,7 +1145,12 @@ static int acpi_subsys_resume_noirq(struct device *dev)
  */
 static int acpi_subsys_resume_early(struct device *dev)
 {
-	int ret = acpi_dev_resume(dev);
+	int ret;
+
+	if (dev_pm_may_skip_resume(dev))
+		return 0;
+
+	ret = acpi_dev_resume(dev);
 	return ret ? ret : pm_generic_resume_early(dev);
 }
 
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 75d7cdb4de9c..25b0302188d8 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -565,12 +565,22 @@ static void dpm_watchdog_clear(struct dpm_watchdog *wd)
  * dev_pm_may_skip_resume - System-wide device resume optimization check.
  * @dev: Target device.
  *
- * Checks whether or not the device may be left in suspend after a system-wide
- * transition to the working state.
+ * Return:
+ * - %false if the transition under way is RESTORE.
+ * - The return value of dev_pm_smart_suspend_and_suspended() if the transition
+ *   under way is THAW.
+ * - The logical negation of %power.must_resume otherwise (that is, when the
+ *   transition under way is RESUME).
  */
 bool dev_pm_may_skip_resume(struct device *dev)
 {
-	return !dev->power.must_resume && pm_transition.event != PM_EVENT_RESTORE;
+	if (pm_transition.event == PM_EVENT_RESTORE)
+		return false;
+
+	if (pm_transition.event == PM_EVENT_THAW)
+		return dev_pm_smart_suspend_and_suspended(dev);
+
+	return !dev->power.must_resume;
 }
 
 /**
@@ -601,6 +611,22 @@ static int device_resume_noirq(struct device *dev, pm_message_t state, bool asyn
 	if (!dpm_wait_for_superior(dev, async))
 		goto Out;
 
+	skip_resume = dev_pm_may_skip_resume(dev);
+	/*
+	 * If the driver callback is skipped below or by the middle layer
+	 * callback and device_resume_early() also skips the driver callback for
+	 * this device later, it needs to appear as "suspended" to PM-runtime,
+	 * so change its status accordingly.
+	 *
+	 * Otherwise, the device is going to be resumed, so set its PM-runtime
+	 * status to "active", but do that only if DPM_FLAG_SMART_SUSPEND is set
+	 * to avoid confusing drivers that don't use it.
+	 */
+	if (skip_resume)
+		pm_runtime_set_suspended(dev);
+	else if (dev_pm_smart_suspend_and_suspended(dev))
+		pm_runtime_set_active(dev);
+
 	if (dev->pm_domain) {
 		info = "noirq power domain ";
 		callback = pm_noirq_op(&dev->pm_domain->ops, state);
@@ -614,35 +640,12 @@ static int device_resume_noirq(struct device *dev, pm_message_t state, bool asyn
 		info = "noirq bus ";
 		callback = pm_noirq_op(dev->bus->pm, state);
 	}
-	if (callback) {
-		skip_resume = false;
+	if (callback)
 		goto Run;
-	}
 
-	skip_resume = dev_pm_may_skip_resume(dev);
 	if (skip_resume)
 		goto Skip;
 
-	/*
-	 * If "freeze" driver callbacks have been skipped during hibernation,
-	 * because the device was runtime-suspended in __device_suspend_late(),
-	 * the corresponding "thaw" callbacks must be skipped too, because
-	 * running them for a runtime-suspended device may not be valid.
-	 */
-	if (dev_pm_smart_suspend_and_suspended(dev) &&
-	    state.event == PM_EVENT_THAW) {
-		skip_resume = true;
-		goto Skip;
-	}
-
-	/*
-	 * The device is going to be resumed, so set its PM-runtime status to
-	 * "active", but do that only if DPM_FLAG_SMART_SUSPEND is set to avoid
-	 * confusing drivers that don't use it.
-	 */
-	if (dev_pm_smart_suspend_and_suspended(dev))
-		pm_runtime_set_active(dev);
-
 	if (dev->driver && dev->driver->pm) {
 		info = "noirq driver ";
 		callback = pm_noirq_op(dev->driver->pm, state);
@@ -654,20 +657,6 @@ static int device_resume_noirq(struct device *dev, pm_message_t state, bool asyn
 Skip:
 	dev->power.is_noirq_suspended = false;
 
-	if (skip_resume) {
-		/* Make the next phases of resume skip the device. */
-		dev->power.is_late_suspended = false;
-		dev->power.is_suspended = false;
-		/*
-		 * The device is going to be left in suspend, but it might not
-		 * have been in runtime suspend before the system suspended, so
-		 * its runtime PM status needs to be updated to avoid confusing
-		 * the runtime PM framework when runtime PM is enabled for the
-		 * device again.
-		 */
-		pm_runtime_set_suspended(dev);
-	}
-
 Out:
 	complete_all(&dev->power.completion);
 	TRACE_RESUME(error);
@@ -804,15 +793,25 @@ static int device_resume_early(struct device *dev, pm_message_t state, bool asyn
 	} else if (dev->bus && dev->bus->pm) {
 		info = "early bus ";
 		callback = pm_late_early_op(dev->bus->pm, state);
-	} else if (dev->driver && dev->driver->pm) {
+	}
+	if (callback)
+		goto Run;
+
+	if (dev_pm_may_skip_resume(dev))
+		goto Skip;
+
+	if (dev->driver && dev->driver->pm) {
 		info = "early driver ";
 		callback = pm_late_early_op(dev->driver->pm, state);
 	}
 
+Run:
 	error = dpm_run_callback(callback, dev, state, info);
+
+Skip:
 	dev->power.is_late_suspended = false;
 
- Out:
+Out:
 	TRACE_RESUME(error);
 
 	pm_runtime_enable(dev);
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 0454ca0e4e3f..685fbf044911 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -896,14 +896,6 @@ static int pci_pm_resume_noirq(struct device *dev)
 	if (dev_pm_may_skip_resume(dev))
 		return 0;
 
-	/*
-	 * Devices with DPM_FLAG_SMART_SUSPEND may be left in runtime suspend
-	 * during system suspend, so update their runtime PM status to "active"
-	 * as they are going to be put into D0 shortly.
-	 */
-	if (dev_pm_smart_suspend_and_suspended(dev))
-		pm_runtime_set_active(dev);
-
 	/*
 	 * In the suspend-to-idle case, devices left in D0 during suspend will
 	 * stay in D0, so it is not necessary to restore or update their
@@ -928,6 +920,14 @@ static int pci_pm_resume_noirq(struct device *dev)
 	return 0;
 }
 
+static int pci_pm_resume_early(struct device *dev)
+{
+	if (dev_pm_may_skip_resume(dev))
+		return 0;
+
+	return pm_generic_resume_early(dev);
+}
+
 static int pci_pm_resume(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
@@ -961,6 +961,7 @@ static int pci_pm_resume(struct device *dev)
 #define pci_pm_suspend_late	NULL
 #define pci_pm_suspend_noirq	NULL
 #define pci_pm_resume		NULL
+#define pci_pm_resume_early	NULL
 #define pci_pm_resume_noirq	NULL
 
 #endif /* !CONFIG_SUSPEND */
@@ -1358,6 +1359,7 @@ static const struct dev_pm_ops pci_dev_pm_ops = {
 	.suspend = pci_pm_suspend,
 	.suspend_late = pci_pm_suspend_late,
 	.resume = pci_pm_resume,
+	.resume_early = pci_pm_resume_early,
 	.freeze = pci_pm_freeze,
 	.thaw = pci_pm_thaw,
 	.poweroff = pci_pm_poweroff,
-- 
2.16.4




