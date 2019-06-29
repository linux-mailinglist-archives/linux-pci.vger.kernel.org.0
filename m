Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83B2E5A9F2
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2019 11:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfF2JxI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Jun 2019 05:53:08 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:53402 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfF2JxI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Jun 2019 05:53:08 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 9df156552b97bad2; Sat, 29 Jun 2019 11:53:05 +0200
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
Subject: [PATCH 4/6] ACPI: LPSS: Fix ->suspend_late callbacks handling
Date:   Sat, 29 Jun 2019 11:50:54 +0200
Message-ID: <2981101.tKVHzisTAg@kreacher>
In-Reply-To: <2318839.0szTqvJMZa@kreacher>
References: <2318839.0szTqvJMZa@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If the resume_from_noirq flag is set in dev_desc, the ->suspend_late
callback provided by the device driver will be invoked at the "noirq"
stage of system suspend, via acpi_lpss_do_suspend_late(), which is
incorrect.

To fix that, drop acpi_lpss_do_suspend_late() and rearrange
acpi_lpss_suspend_late() to call pm_generic_suspend_late()
directly, before calling acpi_lpss_suspend(), in analogy with
acpi_subsys_suspend_late().

Also notice that acpi_subsys_suspend_late() is not used outside
of the file where it is defined, so make it static and drop its
header for the header file containing it.

Fixes: 48402cee6889 (ACPI / LPSS: Resume BYT/CHT I2C controllers from resume_noirq)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_lpss.c |   23 ++++++++++-------------
 drivers/acpi/device_pm.c |    3 +--
 include/linux/acpi.h     |    2 --
 3 files changed, 11 insertions(+), 17 deletions(-)

Index: linux-pm/drivers/acpi/acpi_lpss.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpi_lpss.c
+++ linux-pm/drivers/acpi/acpi_lpss.c
@@ -1034,34 +1034,31 @@ static int acpi_lpss_resume(struct devic
 }
 
 #ifdef CONFIG_PM_SLEEP
-static int acpi_lpss_do_suspend_late(struct device *dev)
+static int acpi_lpss_suspend_late(struct device *dev)
 {
+	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
 	int ret;
 
 	if (dev_pm_smart_suspend_and_suspended(dev))
 		return 0;
 
 	ret = pm_generic_suspend_late(dev);
-	return ret ? ret : acpi_lpss_suspend(dev, device_may_wakeup(dev));
-}
+	if (ret)
+		return ret;
 
-static int acpi_lpss_suspend_late(struct device *dev)
-{
-	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
-
-	if (pdata->dev_desc->resume_from_noirq)
-		return 0;
+	if (!pdata->dev_desc->resume_from_noirq)
+		return acpi_lpss_suspend(dev, device_may_wakeup(dev));
 
-	return acpi_lpss_do_suspend_late(dev);
+	return 0;
 }
 
 static int acpi_lpss_suspend_noirq(struct device *dev)
 {
 	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
-	int ret;
 
-	if (pdata->dev_desc->resume_from_noirq) {
-		ret = acpi_lpss_do_suspend_late(dev);
+	if (!dev_pm_smart_suspend_and_suspended(dev) &&
+	    pdata->dev_desc->resume_from_noirq) {
+		int ret = acpi_lpss_suspend(dev, device_may_wakeup(dev));
 		if (ret)
 			return ret;
 	}
Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -1069,7 +1069,7 @@ EXPORT_SYMBOL_GPL(acpi_subsys_suspend);
  * Carry out the generic late suspend procedure for @dev and use ACPI to put
  * it into a low-power state during system transition into a sleep state.
  */
-int acpi_subsys_suspend_late(struct device *dev)
+static int acpi_subsys_suspend_late(struct device *dev)
 {
 	int ret;
 
@@ -1079,7 +1079,6 @@ int acpi_subsys_suspend_late(struct devi
 	ret = pm_generic_suspend_late(dev);
 	return ret ? ret : acpi_dev_suspend(dev, device_may_wakeup(dev));
 }
-EXPORT_SYMBOL_GPL(acpi_subsys_suspend_late);
 
 /**
  * acpi_subsys_suspend_noirq - Run the device driver's "noirq" suspend callback.
Index: linux-pm/include/linux/acpi.h
===================================================================
--- linux-pm.orig/include/linux/acpi.h
+++ linux-pm/include/linux/acpi.h
@@ -916,7 +916,6 @@ static inline int acpi_dev_pm_attach(str
 int acpi_dev_suspend_late(struct device *dev);
 int acpi_subsys_prepare(struct device *dev);
 void acpi_subsys_complete(struct device *dev);
-int acpi_subsys_suspend_late(struct device *dev);
 int acpi_subsys_suspend_noirq(struct device *dev);
 int acpi_subsys_suspend(struct device *dev);
 int acpi_subsys_freeze(struct device *dev);
@@ -924,7 +923,6 @@ int acpi_subsys_freeze(struct device *de
 static inline int acpi_dev_resume_early(struct device *dev) { return 0; }
 static inline int acpi_subsys_prepare(struct device *dev) { return 0; }
 static inline void acpi_subsys_complete(struct device *dev) {}
-static inline int acpi_subsys_suspend_late(struct device *dev) { return 0; }
 static inline int acpi_subsys_suspend_noirq(struct device *dev) { return 0; }
 static inline int acpi_subsys_suspend(struct device *dev) { return 0; }
 static inline int acpi_subsys_freeze(struct device *dev) { return 0; }




