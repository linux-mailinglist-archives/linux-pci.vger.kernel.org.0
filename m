Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5BB25BA39
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2019 12:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbfGAK6W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jul 2019 06:58:22 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:62187 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbfGAK6W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jul 2019 06:58:22 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 12f6c2b577100129; Mon, 1 Jul 2019 12:58:18 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans De Goede <hdegoede@redhat.com>,
        "Robert R. Howell" <RHowell@uwyo.edu>
Subject: [PATCH v2 3/5] ACPI: PM: Simplify and fix PM domain hibernation callbacks
Date:   Mon, 01 Jul 2019 12:54:10 +0200
Message-ID: <2802028.YOpNIL8Yh8@kreacher>
In-Reply-To: <4976412.ihyb9sT5jY@kreacher>
References: <4976412.ihyb9sT5jY@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

First, after a previous change causing all runtime-suspended devices
in the ACPI PM domain (and ACPI LPSS devices) to be resumed before
creating a snapshot image of memory during hibernation, it is not
necessary to worry about the case in which them might be left in
runtime-suspend any more, so get rid of the code related to that from
ACPI PM domain and ACPI LPSS hibernation callbacks.

Second, it is not correct to use pm_generic_resume_early() and
acpi_subsys_resume_noirq() in hibernation "restore" callbacks (which
currently happens in the ACPI PM domain and ACPI LPSS), so introduce
proper _restore_late and _restore_noirq callbacks for the ACPI PM
domain and ACPI LPSS.

Fixes: 05087360fd7a (ACPI / PM: Take SMART_SUSPEND driver flag into account)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

-> v2:
 * Add a comment explaining the acpi_lpss_resume_noirq() behavior.
 * Make the new LPSS "restore" callbacks follow that behavior.

---
 drivers/acpi/acpi_lpss.c |   61 ++++++++++++++++++++++++++++++++++++++++-------
 drivers/acpi/device_pm.c |   61 ++++++-----------------------------------------
 include/linux/acpi.h     |   10 -------
 3 files changed, 61 insertions(+), 71 deletions(-)

Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -1116,7 +1116,7 @@ EXPORT_SYMBOL_GPL(acpi_subsys_suspend_no
  * acpi_subsys_resume_noirq - Run the device driver's "noirq" resume callback.
  * @dev: Device to handle.
  */
-int acpi_subsys_resume_noirq(struct device *dev)
+static int acpi_subsys_resume_noirq(struct device *dev)
 {
 	if (dev_pm_may_skip_resume(dev))
 		return 0;
@@ -1131,7 +1131,6 @@ int acpi_subsys_resume_noirq(struct devi
 
 	return pm_generic_resume_noirq(dev);
 }
-EXPORT_SYMBOL_GPL(acpi_subsys_resume_noirq);
 
 /**
  * acpi_subsys_resume_early - Resume device using ACPI.
@@ -1141,12 +1140,11 @@ EXPORT_SYMBOL_GPL(acpi_subsys_resume_noi
  * generic early resume procedure for it during system transition into the
  * working state.
  */
-int acpi_subsys_resume_early(struct device *dev)
+static int acpi_subsys_resume_early(struct device *dev)
 {
 	int ret = acpi_dev_resume(dev);
 	return ret ? ret : pm_generic_resume_early(dev);
 }
-EXPORT_SYMBOL_GPL(acpi_subsys_resume_early);
 
 /**
  * acpi_subsys_freeze - Run the device driver's freeze callback.
@@ -1169,52 +1167,15 @@ int acpi_subsys_freeze(struct device *de
 EXPORT_SYMBOL_GPL(acpi_subsys_freeze);
 
 /**
- * acpi_subsys_freeze_late - Run the device driver's "late" freeze callback.
- * @dev: Device to handle.
- */
-int acpi_subsys_freeze_late(struct device *dev)
-{
-
-	if (dev_pm_smart_suspend_and_suspended(dev))
-		return 0;
-
-	return pm_generic_freeze_late(dev);
-}
-EXPORT_SYMBOL_GPL(acpi_subsys_freeze_late);
-
-/**
- * acpi_subsys_freeze_noirq - Run the device driver's "noirq" freeze callback.
- * @dev: Device to handle.
- */
-int acpi_subsys_freeze_noirq(struct device *dev)
-{
-
-	if (dev_pm_smart_suspend_and_suspended(dev))
-		return 0;
-
-	return pm_generic_freeze_noirq(dev);
-}
-EXPORT_SYMBOL_GPL(acpi_subsys_freeze_noirq);
-
-/**
- * acpi_subsys_thaw_noirq - Run the device driver's "noirq" thaw callback.
- * @dev: Device to handle.
+ * acpi_subsys_restore_early - Restore device using ACPI.
+ * @dev: Device to restore.
  */
-int acpi_subsys_thaw_noirq(struct device *dev)
+int acpi_subsys_restore_early(struct device *dev)
 {
-	/*
-	 * If the device is in runtime suspend, the "thaw" code may not work
-	 * correctly with it, so skip the driver callback and make the PM core
-	 * skip all of the subsequent "thaw" callbacks for the device.
-	 */
-	if (dev_pm_smart_suspend_and_suspended(dev)) {
-		dev_pm_skip_next_resume_phases(dev);
-		return 0;
-	}
-
-	return pm_generic_thaw_noirq(dev);
+	int ret = acpi_dev_resume(dev);
+	return ret ? ret : pm_generic_restore_early(dev);
 }
-EXPORT_SYMBOL_GPL(acpi_subsys_thaw_noirq);
+EXPORT_SYMBOL_GPL(acpi_subsys_restore_early);
 #endif /* CONFIG_PM_SLEEP */
 
 static struct dev_pm_domain acpi_general_pm_domain = {
@@ -1230,14 +1191,10 @@ static struct dev_pm_domain acpi_general
 		.resume_noirq = acpi_subsys_resume_noirq,
 		.resume_early = acpi_subsys_resume_early,
 		.freeze = acpi_subsys_freeze,
-		.freeze_late = acpi_subsys_freeze_late,
-		.freeze_noirq = acpi_subsys_freeze_noirq,
-		.thaw_noirq = acpi_subsys_thaw_noirq,
 		.poweroff = acpi_subsys_suspend,
 		.poweroff_late = acpi_subsys_suspend_late,
 		.poweroff_noirq = acpi_subsys_suspend_noirq,
-		.restore_noirq = acpi_subsys_resume_noirq,
-		.restore_early = acpi_subsys_resume_early,
+		.restore_early = acpi_subsys_restore_early,
 #endif
 	},
 };
Index: linux-pm/include/linux/acpi.h
===================================================================
--- linux-pm.orig/include/linux/acpi.h
+++ linux-pm/include/linux/acpi.h
@@ -918,26 +918,16 @@ int acpi_subsys_prepare(struct device *d
 void acpi_subsys_complete(struct device *dev);
 int acpi_subsys_suspend_late(struct device *dev);
 int acpi_subsys_suspend_noirq(struct device *dev);
-int acpi_subsys_resume_noirq(struct device *dev);
-int acpi_subsys_resume_early(struct device *dev);
 int acpi_subsys_suspend(struct device *dev);
 int acpi_subsys_freeze(struct device *dev);
-int acpi_subsys_freeze_late(struct device *dev);
-int acpi_subsys_freeze_noirq(struct device *dev);
-int acpi_subsys_thaw_noirq(struct device *dev);
 #else
 static inline int acpi_dev_resume_early(struct device *dev) { return 0; }
 static inline int acpi_subsys_prepare(struct device *dev) { return 0; }
 static inline void acpi_subsys_complete(struct device *dev) {}
 static inline int acpi_subsys_suspend_late(struct device *dev) { return 0; }
 static inline int acpi_subsys_suspend_noirq(struct device *dev) { return 0; }
-static inline int acpi_subsys_resume_noirq(struct device *dev) { return 0; }
-static inline int acpi_subsys_resume_early(struct device *dev) { return 0; }
 static inline int acpi_subsys_suspend(struct device *dev) { return 0; }
 static inline int acpi_subsys_freeze(struct device *dev) { return 0; }
-static inline int acpi_subsys_freeze_late(struct device *dev) { return 0; }
-static inline int acpi_subsys_freeze_noirq(struct device *dev) { return 0; }
-static inline int acpi_subsys_thaw_noirq(struct device *dev) { return 0; }
 #endif
 
 #ifdef CONFIG_ACPI
Index: linux-pm/drivers/acpi/acpi_lpss.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpi_lpss.c
+++ linux-pm/drivers/acpi/acpi_lpss.c
@@ -1091,16 +1091,62 @@ static int acpi_lpss_resume_noirq(struct
 	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
 	int ret;
 
-	ret = acpi_subsys_resume_noirq(dev);
+	/* Follow acpi_subsys_resume_noirq(). */
+	if (dev_pm_may_skip_resume(dev))
+		return 0;
+
+	if (dev_pm_smart_suspend_and_suspended(dev))
+		pm_runtime_set_active(dev);
+
+	ret = pm_generic_resume_noirq(dev);
 	if (ret)
 		return ret;
 
-	if (!dev_pm_may_skip_resume(dev) && pdata->dev_desc->resume_from_noirq)
-		ret = acpi_lpss_do_resume_early(dev);
+	if (!pdata->dev_desc->resume_from_noirq)
+		return 0;
+
+	/*
+	 * The driver's ->resume_early callback will be invoked by
+	 * acpi_lpss_do_resume_early(), with the assumption that the driver
+	 * really wanted to run that code in ->resume_noirq, but it could not
+	 * run before acpi_dev_resume() and the driver expected the latter to be
+	 * called in the "early" phase.
+	 */
+	return acpi_lpss_do_resume_early(dev);
+}
+
+static int acpi_lpss_do_restore_early(struct device *dev)
+{
+	int ret = acpi_lpss_resume(dev);
+
+	return ret ? ret : pm_generic_restore_early(dev);
+}
+
+static int acpi_lpss_restore_early(struct device *dev)
+{
+	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
+
+	if (pdata->dev_desc->resume_from_noirq)
+		return 0;
 
-	return ret;
+	return acpi_lpss_do_restore_early(dev);
 }
 
+static int acpi_lpss_restore_noirq(struct device *dev)
+{
+	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
+	int ret;
+
+	ret = pm_generic_restore_noirq(dev);
+	if (ret)
+		return ret;
+
+	if (!pdata->dev_desc->resume_from_noirq)
+		return 0;
+
+	/* This is analogous to what happens in acpi_lpss_resume_noirq(). */
+	return acpi_lpss_do_restore_early(dev);
+}
 #endif /* CONFIG_PM_SLEEP */
 
 static int acpi_lpss_runtime_suspend(struct device *dev)
@@ -1134,14 +1180,11 @@ static struct dev_pm_domain acpi_lpss_pm
 		.resume_noirq = acpi_lpss_resume_noirq,
 		.resume_early = acpi_lpss_resume_early,
 		.freeze = acpi_subsys_freeze,
-		.freeze_late = acpi_subsys_freeze_late,
-		.freeze_noirq = acpi_subsys_freeze_noirq,
-		.thaw_noirq = acpi_subsys_thaw_noirq,
 		.poweroff = acpi_subsys_suspend,
 		.poweroff_late = acpi_lpss_suspend_late,
 		.poweroff_noirq = acpi_lpss_suspend_noirq,
-		.restore_noirq = acpi_lpss_resume_noirq,
-		.restore_early = acpi_lpss_resume_early,
+		.restore_noirq = acpi_lpss_restore_noirq,
+		.restore_early = acpi_lpss_restore_early,
 #endif
 		.runtime_suspend = acpi_lpss_runtime_suspend,
 		.runtime_resume = acpi_lpss_runtime_resume,



