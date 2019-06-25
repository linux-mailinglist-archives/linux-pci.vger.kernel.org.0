Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDD255AF3
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2019 00:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbfFYWU0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jun 2019 18:20:26 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:60207 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFYWU0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jun 2019 18:20:26 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 31d07203676d00d2; Wed, 26 Jun 2019 00:20:23 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] PCI: PM: Avoid skipping bus-level PM on platforms without ACPI
Date:   Wed, 26 Jun 2019 00:20:23 +0200
Message-ID: <14605632.7Eqku7tdey@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There are platforms that do not call pm_set_suspend_via_firmware(),
so pm_suspend_via_firmware() returns 'false' on them, but the power
states of PCI devices (PCIe ports in particular) are changed as a
result of powering down core platform components during system-wide
suspend.  Thus the pm_suspend_via_firmware() checks in
pci_pm_suspend_noirq() and pci_pm_resume_noirq() introduced by
commit 3e26c5feed2a ("PCI: PM: Skip devices in D0 for suspend-to-
idle") are not sufficient to determine that devices left in D0
during suspend will remain in D0 during resume and so the bus-level
power management can be skipped for them.

For this reason, introduce a new global suspend flag,
PM_SUSPEND_FLAG_NO_PLATFORM, set it for suspend-to-idle only
and replace the pm_suspend_via_firmware() checks mentioned above
with checks against this flag.

Fixes: 3e26c5feed2a ("PCI: PM: Skip devices in D0 for suspend-to-idle")
Reported-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci-driver.c |    8 ++++----
 include/linux/suspend.h  |   26 ++++++++++++++++++++++++--
 kernel/power/suspend.c   |    3 +++
 3 files changed, 31 insertions(+), 6 deletions(-)

Index: linux-pm/include/linux/suspend.h
===================================================================
--- linux-pm.orig/include/linux/suspend.h
+++ linux-pm/include/linux/suspend.h
@@ -209,8 +209,9 @@ extern int suspend_valid_only_mem(suspen
 
 extern unsigned int pm_suspend_global_flags;
 
-#define PM_SUSPEND_FLAG_FW_SUSPEND	(1 << 0)
-#define PM_SUSPEND_FLAG_FW_RESUME	(1 << 1)
+#define PM_SUSPEND_FLAG_FW_SUSPEND	BIT(0)
+#define PM_SUSPEND_FLAG_FW_RESUME	BIT(1)
+#define PM_SUSPEND_FLAG_NO_PLATFORM	BIT(2)
 
 static inline void pm_suspend_clear_flags(void)
 {
@@ -227,6 +228,11 @@ static inline void pm_set_resume_via_fir
 	pm_suspend_global_flags |= PM_SUSPEND_FLAG_FW_RESUME;
 }
 
+static inline void pm_set_suspend_no_platform(void)
+{
+	pm_suspend_global_flags |= PM_SUSPEND_FLAG_NO_PLATFORM;
+}
+
 /**
  * pm_suspend_via_firmware - Check if platform firmware will suspend the system.
  *
@@ -268,6 +274,22 @@ static inline bool pm_resume_via_firmwar
 	return !!(pm_suspend_global_flags & PM_SUSPEND_FLAG_FW_RESUME);
 }
 
+/**
+ * pm_suspend_no_platform - Check if platform may change device power states.
+ *
+ * To be called during system-wide power management transitions to sleep states
+ * or during the subsequent system-wide transitions back to the working state.
+ *
+ * Return 'true' if the power states of devices remain under full control of the
+ * kernel throughout the system-wide suspend and resume cycle in progress (that
+ * is, if a device is put into a certain power state during suspend, it can be
+ * expected to remain in that state during resume).
+ */
+static inline bool pm_suspend_no_platform(void)
+{
+	return !!(pm_suspend_global_flags & PM_SUSPEND_FLAG_NO_PLATFORM);
+}
+
 /* Suspend-to-idle state machnine. */
 enum s2idle_states {
 	S2IDLE_STATE_NONE,      /* Not suspended/suspending. */
Index: linux-pm/kernel/power/suspend.c
===================================================================
--- linux-pm.orig/kernel/power/suspend.c
+++ linux-pm/kernel/power/suspend.c
@@ -493,6 +493,9 @@ int suspend_devices_and_enter(suspend_st
 
 	pm_suspend_target_state = state;
 
+	if (state == PM_SUSPEND_TO_IDLE)
+		pm_set_suspend_no_platform();
+
 	error = platform_suspend_begin(state);
 	if (error)
 		goto Close;
Index: linux-pm/drivers/pci/pci-driver.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-driver.c
+++ linux-pm/drivers/pci/pci-driver.c
@@ -877,7 +877,7 @@ static int pci_pm_suspend_noirq(struct d
 			pci_dev->bus->self->skip_bus_pm = true;
 	}
 
-	if (pci_dev->skip_bus_pm && !pm_suspend_via_firmware()) {
+	if (pci_dev->skip_bus_pm && pm_suspend_no_platform()) {
 		dev_dbg(dev, "PCI PM: Skipped\n");
 		goto Fixup;
 	}
@@ -932,10 +932,10 @@ static int pci_pm_resume_noirq(struct de
 	/*
 	 * In the suspend-to-idle case, devices left in D0 during suspend will
 	 * stay in D0, so it is not necessary to restore or update their
-	 * configuration here and attempting to put them into D0 again may
-	 * confuse some firmware, so avoid doing that.
+	 * configuration here and attempting to put them into D0 again is
+	 * pointless, so avoid doing that.
 	 */
-	if (!pci_dev->skip_bus_pm || pm_suspend_via_firmware())
+	if (!(pci_dev->skip_bus_pm && pm_suspend_no_platform()))
 		pci_pm_default_resume_early(pci_dev);
 
 	pci_fixup_device(pci_fixup_resume_early, pci_dev);



