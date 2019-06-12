Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89E5B448F4
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 19:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbfFMRME (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 13:12:04 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:60540 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729076AbfFLWOG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jun 2019 18:14:06 -0400
Received: from 79.184.253.190.ipv4.supernova.orange.pl (79.184.253.190) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 991125ee90f9fcfa; Thu, 13 Jun 2019 00:14:02 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PCI <linux-pci@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] PCI: PM: Skip devices in D0 for suspend-to-idle
Date:   Thu, 13 Jun 2019 00:14:02 +0200
Message-ID: <2513600.jR9RdVMSR0@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit d491f2b75237 ("PCI: PM: Avoid possible suspend-to-idle issue")
attempted to avoid a problem with devices whose drivers want them to
stay in D0 over suspend-to-idle and resume, but it did not go as far
as it should with that.

Namely, first of all, it is questionable to change the power state
of a PCI bridge with a device in D0 under it, but that is not
actively prevented from happening during system-wide PM transitions,
so use the skip_bus_pm flag introduced by commit d491f2b75237 for
that.

Second, the configuration of devices left in D0 (whatever the reason)
during suspend-to-idle need not be changed and attempting to put them
into D0 again by force may confuse some firmware, so explicitly avoid
doing that.

Fixes: d491f2b75237 ("PCI: PM: Avoid possible suspend-to-idle issue")
Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Tested on Dell XPS13 9360 with no issues.

---
 drivers/pci/pci-driver.c |   47 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 12 deletions(-)

Index: linux-pm/drivers/pci/pci-driver.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-driver.c
+++ linux-pm/drivers/pci/pci-driver.c
@@ -524,7 +524,6 @@ static void pci_pm_default_resume_early(
 	pci_power_up(pci_dev);
 	pci_restore_state(pci_dev);
 	pci_pme_restore(pci_dev);
-	pci_fixup_device(pci_fixup_resume_early, pci_dev);
 }
 
 /*
@@ -842,18 +841,16 @@ static int pci_pm_suspend_noirq(struct d
 
 	if (pci_dev->skip_bus_pm) {
 		/*
-		 * The function is running for the second time in a row without
+		 * Either the device is a bridge with a child in D0 below it, or
+		 * the function is running for the second time in a row without
 		 * going through full resume, which is possible only during
-		 * suspend-to-idle in a spurious wakeup case.  Moreover, the
-		 * device was originally left in D0, so its power state should
-		 * not be changed here and the device register values saved
-		 * originally should be restored on resume again.
+		 * suspend-to-idle in a spurious wakeup case.  The device should
+		 * be in D0 at this point, but if it is a bridge, it may be
+		 * necessary to save its state.
 		 */
-		pci_dev->state_saved = true;
-	} else if (pci_dev->state_saved) {
-		if (pci_dev->current_state == PCI_D0)
-			pci_dev->skip_bus_pm = true;
-	} else {
+		if (!pci_dev->state_saved)
+			pci_save_state(pci_dev);
+	} else if (!pci_dev->state_saved) {
 		pci_save_state(pci_dev);
 		if (pci_power_manageable(pci_dev))
 			pci_prepare_to_sleep(pci_dev);
@@ -862,6 +859,22 @@ static int pci_pm_suspend_noirq(struct d
 	dev_dbg(dev, "PCI PM: Suspend power state: %s\n",
 		pci_power_name(pci_dev->current_state));
 
+	if (pci_dev->current_state == PCI_D0) {
+		pci_dev->skip_bus_pm = true;
+		/*
+		 * Changing the power state of a PCI bridge with a device in D0
+		 * below it is questionable, so avoid doing that by setting the
+		 * skip_bus_pm flag for the parent bridge.
+		 */
+		if (pci_dev->bus->self)
+			pci_dev->bus->self->skip_bus_pm = true;
+	}
+
+	if (pci_dev->skip_bus_pm && !pm_suspend_via_firmware()) {
+		dev_dbg(dev, "PCI PM: Skipped\n");
+		goto Fixup;
+	}
+
 	pci_pm_set_unknown_state(pci_dev);
 
 	/*
@@ -909,7 +922,16 @@ static int pci_pm_resume_noirq(struct de
 	if (dev_pm_smart_suspend_and_suspended(dev))
 		pm_runtime_set_active(dev);
 
-	pci_pm_default_resume_early(pci_dev);
+	/*
+	 * In the suspend-to-idle case, devices left in D0 during suspend will
+	 * stay in D0, so it is not necessary to restore or update their
+	 * configuration here and attempting to put them into D0 again may
+	 * confuse some firmware, so avoid doing that.
+	 */
+	if (!pci_dev->skip_bus_pm || pm_suspend_via_firmware())
+		pci_pm_default_resume_early(pci_dev);
+
+	pci_fixup_device(pci_fixup_resume_early, pci_dev);
 
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_resume_early(dev);
@@ -1200,6 +1222,7 @@ static int pci_pm_restore_noirq(struct d
 	}
 
 	pci_pm_default_resume_early(pci_dev);
+	pci_fixup_device(pci_fixup_resume_early, pci_dev);
 
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_resume_early(dev);



