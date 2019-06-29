Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77CA35A9F4
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2019 11:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfF2JxJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Jun 2019 05:53:09 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:46717 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbfF2JxJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Jun 2019 05:53:09 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id db6c82754ccb710d; Sat, 29 Jun 2019 11:53:07 +0200
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
Subject: [PATCH 2/6] PCI: PM: Simplify bus-level hibernation callbacks
Date:   Sat, 29 Jun 2019 11:49:29 +0200
Message-ID: <2374682.f9L2DV4Cc2@kreacher>
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

After a previous change causing all runtime-suspended PCI devices
to be resumed before creating a snapshot image of memory during
hibernation, it is not necessary to worry about the case in which
them might be left in runtime-suspend any more, so get rid of the
code related to that from bus-level PCI hibernation callbacks.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci-driver.c |   27 ---------------------------
 1 file changed, 27 deletions(-)

Index: linux-pm/drivers/pci/pci-driver.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-driver.c
+++ linux-pm/drivers/pci/pci-driver.c
@@ -1034,22 +1034,11 @@ static int pci_pm_freeze(struct device *
 	return 0;
 }
 
-static int pci_pm_freeze_late(struct device *dev)
-{
-	if (dev_pm_smart_suspend_and_suspended(dev))
-		return 0;
-
-	return pm_generic_freeze_late(dev);
-}
-
 static int pci_pm_freeze_noirq(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct device_driver *drv = dev->driver;
 
-	if (dev_pm_smart_suspend_and_suspended(dev))
-		return 0;
-
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_suspend_late(dev, PMSG_FREEZE);
 
@@ -1079,16 +1068,6 @@ static int pci_pm_thaw_noirq(struct devi
 	struct device_driver *drv = dev->driver;
 	int error = 0;
 
-	/*
-	 * If the device is in runtime suspend, the code below may not work
-	 * correctly with it, so skip that code and make the PM core skip all of
-	 * the subsequent "thaw" callbacks for the device.
-	 */
-	if (dev_pm_smart_suspend_and_suspended(dev)) {
-		dev_pm_skip_next_resume_phases(dev);
-		return 0;
-	}
-
 	if (pcibios_pm_ops.thaw_noirq) {
 		error = pcibios_pm_ops.thaw_noirq(dev);
 		if (error)
@@ -1226,10 +1205,6 @@ static int pci_pm_restore_noirq(struct d
 	struct device_driver *drv = dev->driver;
 	int error = 0;
 
-	/* This is analogous to the pci_pm_resume_noirq() case. */
-	if (dev_pm_smart_suspend_and_suspended(dev))
-		pm_runtime_set_active(dev);
-
 	if (pcibios_pm_ops.restore_noirq) {
 		error = pcibios_pm_ops.restore_noirq(dev);
 		if (error)
@@ -1279,7 +1254,6 @@ static int pci_pm_restore(struct device
 #else /* !CONFIG_HIBERNATE_CALLBACKS */
 
 #define pci_pm_freeze		NULL
-#define pci_pm_freeze_late	NULL
 #define pci_pm_freeze_noirq	NULL
 #define pci_pm_thaw		NULL
 #define pci_pm_thaw_noirq	NULL
@@ -1405,7 +1379,6 @@ static const struct dev_pm_ops pci_dev_p
 	.suspend_late = pci_pm_suspend_late,
 	.resume = pci_pm_resume,
 	.freeze = pci_pm_freeze,
-	.freeze_late = pci_pm_freeze_late,
 	.thaw = pci_pm_thaw,
 	.poweroff = pci_pm_poweroff,
 	.poweroff_late = pci_pm_poweroff_late,




