Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 161455A9FA
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2019 11:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfF2JxQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Jun 2019 05:53:16 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:62978 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfF2JxK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Jun 2019 05:53:10 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 4dbad7c8839ee43e; Sat, 29 Jun 2019 11:53:08 +0200
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
Subject: [PATCH 1/6] PM: ACPI/PCI: Resume all devices during hibernation
Date:   Sat, 29 Jun 2019 11:48:42 +0200
Message-ID: <5569909.YxqlWfZ7VZ@kreacher>
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

Both the PCI bus type and the ACPI PM domain avoid resuming
runtime-suspended devices with DPM_FLAG_SMART_SUSPEND set during
hibernation (before creating the snapshot image of system memory),
but that turns out to be a mistake.  It leads to functional issues
and adds complexity that's hard to justify.

For this reason, resume all runtime-suspended PCI devices and all
devices in the ACPI PM domains before creating a snapshot image of
system memory during hibernation.

Fixes: 05087360fd7a (ACPI / PM: Take SMART_SUSPEND driver flag into account)
Fixes: c4b65157aeef (PCI / PM: Take SMART_SUSPEND driver flag into account)
Link: https://lore.kernel.org/linux-acpi/917d4399-2e22-67b1-9d54-808561f9083f@uwyo.edu/T/#maf065fe6e4974f2a9d79f332ab99dfaba635f64c
Reported-by: Robert R. Howell <RHowell@uwyo.edu>
Tested-by: Robert R. Howell <RHowell@uwyo.edu>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/device_pm.c |   13 +++++++------
 drivers/pci/pci-driver.c |   16 ++++++++--------
 2 files changed, 15 insertions(+), 14 deletions(-)

Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -1155,13 +1155,14 @@ EXPORT_SYMBOL_GPL(acpi_subsys_resume_ear
 int acpi_subsys_freeze(struct device *dev)
 {
 	/*
-	 * This used to be done in acpi_subsys_prepare() for all devices and
-	 * some drivers may depend on it, so do it here.  Ideally, however,
-	 * runtime-suspended devices should not be touched during freeze/thaw
-	 * transitions.
+	 * Resume all runtime-suspended devices before creating a snapshot
+	 * image of system memory, because the restore kernel generally cannot
+	 * be expected to always handle them consistently and they need to be
+	 * put into the runtime-active metastate during system resume anyway,
+	 * so it is better to ensure that the state saved in the image will be
+	 * alwyas consistent with that.
 	 */
-	if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND))
-		pm_runtime_resume(dev);
+	pm_runtime_resume(dev);
 
 	return pm_generic_freeze(dev);
 }
Index: linux-pm/drivers/pci/pci-driver.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-driver.c
+++ linux-pm/drivers/pci/pci-driver.c
@@ -1012,15 +1012,15 @@ static int pci_pm_freeze(struct device *
 	}
 
 	/*
-	 * This used to be done in pci_pm_prepare() for all devices and some
-	 * drivers may depend on it, so do it here.  Ideally, runtime-suspended
-	 * devices should not be touched during freeze/thaw transitions,
-	 * however.
+	 * Resume all runtime-suspended devices before creating a snapshot
+	 * image of system memory, because the restore kernel generally cannot
+	 * be expected to always handle them consistently and they need to be
+	 * put into the runtime-active metastate during system resume anyway,
+	 * so it is better to ensure that the state saved in the image will be
+	 * alwyas consistent with that.
 	 */
-	if (!dev_pm_smart_suspend_and_suspended(dev)) {
-		pm_runtime_resume(dev);
-		pci_dev->state_saved = false;
-	}
+	pm_runtime_resume(dev);
+	pci_dev->state_saved = false;
 
 	if (pm->freeze) {
 		int error;




