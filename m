Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1952D1A4828
	for <lists+linux-pci@lfdr.de>; Fri, 10 Apr 2020 18:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgDJQBJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Apr 2020 12:01:09 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:61041 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbgDJQAt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Apr 2020 12:00:49 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id a6c6ebd28b772ae9; Fri, 10 Apr 2020 18:00:47 +0200
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
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH 4/7] PM: sleep: core: Rename dev_pm_may_skip_resume()
Date:   Fri, 10 Apr 2020 17:51:35 +0200
Message-ID: <3171765.oZItDzeFuC@kreacher>
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

The name of dev_pm_may_skip_resume() may be easily confused with the
power.may_skip_resume flag which is not checked by that function, so
rename the former as dev_pm_skip_resume().

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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
index 399684085f85..b9a3ade17587 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1129,7 +1129,7 @@ EXPORT_SYMBOL_GPL(acpi_subsys_suspend_noirq);
  */
 static int acpi_subsys_resume_noirq(struct device *dev)
 {
-	if (dev_pm_may_skip_resume(dev))
+	if (dev_pm_skip_resume(dev))
 		return 0;
 
 	return pm_generic_resume_noirq(dev);
@@ -1147,7 +1147,7 @@ static int acpi_subsys_resume_early(struct device *dev)
 {
 	int ret;
 
-	if (dev_pm_may_skip_resume(dev))
+	if (dev_pm_skip_resume(dev))
 		return 0;
 
 	ret = acpi_dev_resume(dev);
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 66f205d7c7a3..21187ee37b22 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -562,7 +562,7 @@ static void dpm_watchdog_clear(struct dpm_watchdog *wd)
 /*------------------------- Resume routines -------------------------*/
 
 /**
- * dev_pm_may_skip_resume - System-wide device resume optimization check.
+ * dev_pm_skip_resume - System-wide device resume optimization check.
  * @dev: Target device.
  *
  * Driver-level resume callbacks can be skipped for @dev if its configuration is
@@ -574,7 +574,7 @@ static void dpm_watchdog_clear(struct dpm_watchdog *wd)
  * device remains in runtime suspend), so running the "thaw" callbacks for it
  * may be invalid.
  */
-bool dev_pm_may_skip_resume(struct device *dev)
+bool dev_pm_skip_resume(struct device *dev)
 {
 	return (!dev->power.must_resume &&
 		pm_transition.event != PM_EVENT_RESTORE) ||
@@ -610,7 +610,7 @@ static int device_resume_noirq(struct device *dev, pm_message_t state, bool asyn
 	if (!dpm_wait_for_superior(dev, async))
 		goto Out;
 
-	skip_resume = dev_pm_may_skip_resume(dev);
+	skip_resume = dev_pm_skip_resume(dev);
 	/*
 	 * If the driver callback is skipped below or by the middle layer
 	 * callback and device_resume_early() also skips the driver callback for
@@ -796,7 +796,7 @@ static int device_resume_early(struct device *dev, pm_message_t state, bool asyn
 	if (callback)
 		goto Run;
 
-	if (dev_pm_may_skip_resume(dev))
+	if (dev_pm_skip_resume(dev))
 		goto Skip;
 
 	if (dev->driver && dev->driver->pm) {
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 685fbf044911..ff2fc93e7a3b 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -893,7 +893,7 @@ static int pci_pm_resume_noirq(struct device *dev)
 	pci_power_t prev_state = pci_dev->current_state;
 	bool skip_bus_pm = pci_dev->skip_bus_pm;
 
-	if (dev_pm_may_skip_resume(dev))
+	if (dev_pm_skip_resume(dev))
 		return 0;
 
 	/*
@@ -922,7 +922,7 @@ static int pci_pm_resume_noirq(struct device *dev)
 
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




