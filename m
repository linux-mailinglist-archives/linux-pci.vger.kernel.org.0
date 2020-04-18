Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF031AF2B2
	for <lists+linux-pci@lfdr.de>; Sat, 18 Apr 2020 19:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgDRRL5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Apr 2020 13:11:57 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:64478 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgDRRL4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 18 Apr 2020 13:11:56 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 5b0698f0b97e3fd0; Sat, 18 Apr 2020 19:11:54 +0200
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
Subject: [PATCH v2 5/9] PM: sleep: core: Rename dev_pm_may_skip_resume()
Date:   Sat, 18 Apr 2020 18:52:30 +0200
Message-ID: <9307490.qYtgvy6jVK@kreacher>
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

The name of dev_pm_may_skip_resume() may be easily confused with the
power.may_skip_resume flag which is not checked by that function, so
rename the former as dev_pm_skip_resume().

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

-> v2:
   * Rebased.

---
 Documentation/power/pci.rst | 2 +-
 drivers/acpi/acpi_lpss.c    | 4 ++--
 drivers/acpi/device_pm.c    | 4 ++--
 drivers/base/power/main.c   | 8 ++++----
 drivers/pci/pci-driver.c    | 4 ++--
 include/linux/pm.h          | 2 +-
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/power/pci.rst b/Documentation/power/pci.rst
index a39b2461919a..aa1c7fce6cd0 100644
--- a/Documentation/power/pci.rst
+++ b/Documentation/power/pci.rst
@@ -1034,7 +1034,7 @@ device to be left in suspend after system-wide transitions to the working state.
 This flag is checked by the PM core, but the PCI bus type informs the PM core
 which devices may be left in suspend from its perspective (that happens during
 the "noirq" phase of system-wide suspend and analogous transitions) and next it
-uses the dev_pm_may_skip_resume() helper to decide whether or not to return from
+uses the dev_pm_skip_resume() helper to decide whether or not to return from
 pci_pm_resume_noirq() and pci_pm_resume_early() upfront.
 
 3.2. Device Runtime Power Management
diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index c4a84df6cc98..7632df1a5be3 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -1093,7 +1093,7 @@ static int acpi_lpss_resume_early(struct device *dev)
 	if (pdata->dev_desc->resume_from_noirq)
 		return 0;
 
-	if (dev_pm_may_skip_resume(dev))
+	if (dev_pm_skip_resume(dev))
 		return 0;
 
 	return acpi_lpss_do_resume_early(dev);
@@ -1105,7 +1105,7 @@ static int acpi_lpss_resume_noirq(struct device *dev)
 	int ret;
 
 	/* Follow acpi_subsys_resume_noirq(). */
-	if (dev_pm_may_skip_resume(dev))
+	if (dev_pm_skip_resume(dev))
 		return 0;
 
 	ret = pm_generic_resume_noirq(dev);
diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index 1b02d7dc7d34..8c2a091728a9 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1127,7 +1127,7 @@ EXPORT_SYMBOL_GPL(acpi_subsys_suspend_noirq);
  */
 static int acpi_subsys_resume_noirq(struct device *dev)
 {
-	if (dev_pm_may_skip_resume(dev))
+	if (dev_pm_skip_resume(dev))
 		return 0;
 
 	return pm_generic_resume_noirq(dev);
@@ -1145,7 +1145,7 @@ static int acpi_subsys_resume_early(struct device *dev)
 {
 	int ret;
 
-	if (dev_pm_may_skip_resume(dev))
+	if (dev_pm_skip_resume(dev))
 		return 0;
 
 	ret = acpi_dev_resume(dev);
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 5adf0be6aa47..f98eced0f200 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -562,7 +562,7 @@ static void dpm_watchdog_clear(struct dpm_watchdog *wd)
 /*------------------------- Resume routines -------------------------*/
 
 /**
- * dev_pm_may_skip_resume - System-wide device resume optimization check.
+ * dev_pm_skip_resume - System-wide device resume optimization check.
  * @dev: Target device.
  *
  * Return:
@@ -572,7 +572,7 @@ static void dpm_watchdog_clear(struct dpm_watchdog *wd)
  * - The logical negation of %power.must_resume otherwise (that is, when the
  *   transition under way is RESUME).
  */
-bool dev_pm_may_skip_resume(struct device *dev)
+bool dev_pm_skip_resume(struct device *dev)
 {
 	if (pm_transition.event == PM_EVENT_RESTORE)
 		return false;
@@ -611,7 +611,7 @@ static int device_resume_noirq(struct device *dev, pm_message_t state, bool asyn
 	if (!dpm_wait_for_superior(dev, async))
 		goto Out;
 
-	skip_resume = dev_pm_may_skip_resume(dev);
+	skip_resume = dev_pm_skip_resume(dev);
 	/*
 	 * If the driver callback is skipped below or by the middle layer
 	 * callback and device_resume_early() also skips the driver callback for
@@ -797,7 +797,7 @@ static int device_resume_early(struct device *dev, pm_message_t state, bool asyn
 	if (callback)
 		goto Run;
 
-	if (dev_pm_may_skip_resume(dev))
+	if (dev_pm_skip_resume(dev))
 		goto Skip;
 
 	if (dev->driver && dev->driver->pm) {
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index ce220b1987df..decf82595340 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -891,7 +891,7 @@ static int pci_pm_resume_noirq(struct device *dev)
 	pci_power_t prev_state = pci_dev->current_state;
 	bool skip_bus_pm = pci_dev->skip_bus_pm;
 
-	if (dev_pm_may_skip_resume(dev))
+	if (dev_pm_skip_resume(dev))
 		return 0;
 
 	/*
@@ -920,7 +920,7 @@ static int pci_pm_resume_noirq(struct device *dev)
 
 static int pci_pm_resume_early(struct device *dev)
 {
-	if (dev_pm_may_skip_resume(dev))
+	if (dev_pm_skip_resume(dev))
 		return 0;
 
 	return pm_generic_resume_early(dev);
diff --git a/include/linux/pm.h b/include/linux/pm.h
index e057d1fa2469..d89b7099f241 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -758,7 +758,7 @@ extern int pm_generic_poweroff_late(struct device *dev);
 extern int pm_generic_poweroff(struct device *dev);
 extern void pm_generic_complete(struct device *dev);
 
-extern bool dev_pm_may_skip_resume(struct device *dev);
+extern bool dev_pm_skip_resume(struct device *dev);
 extern bool dev_pm_smart_suspend_and_suspended(struct device *dev);
 
 #else /* !CONFIG_PM_SLEEP */
-- 
2.16.4




