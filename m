Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 004D51AF2BC
	for <lists+linux-pci@lfdr.de>; Sat, 18 Apr 2020 19:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgDRRM2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Apr 2020 13:12:28 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:50673 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgDRRL5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 18 Apr 2020 13:11:57 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 0494f6aa739a7814; Sat, 18 Apr 2020 19:11:53 +0200
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
Subject: [PATCH v2 6/9] PM: sleep: core: Rename dev_pm_smart_suspend_and_suspended()
Date:   Sat, 18 Apr 2020 18:52:48 +0200
Message-ID: <4560390.sSGzV6Abg1@kreacher>
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

Because all callers of dev_pm_smart_suspend_and_suspended use it only
for checking whether or not to skip driver suspend callbacks for a
device, rename it to dev_pm_skip_suspend() in analogy with
dev_pm_skip_resume().

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

New patch.

---
 drivers/acpi/acpi_lpss.c          |  6 +++---
 drivers/acpi/device_pm.c          |  8 ++++----
 drivers/base/power/main.c         | 13 ++++++-------
 drivers/pci/hotplug/pciehp_core.c |  2 +-
 drivers/pci/pci-driver.c          |  8 ++++----
 include/linux/pm.h                |  2 +-
 6 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 7632df1a5be3..5e2bfbcf526f 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -1041,7 +1041,7 @@ static int acpi_lpss_do_suspend_late(struct device *dev)
 {
 	int ret;
 
-	if (dev_pm_smart_suspend_and_suspended(dev))
+	if (dev_pm_skip_suspend(dev))
 		return 0;
 
 	ret = pm_generic_suspend_late(dev);
@@ -1169,7 +1169,7 @@ static int acpi_lpss_poweroff_late(struct device *dev)
 {
 	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
 
-	if (dev_pm_smart_suspend_and_suspended(dev))
+	if (dev_pm_skip_suspend(dev))
 		return 0;
 
 	if (pdata->dev_desc->resume_from_noirq)
@@ -1182,7 +1182,7 @@ static int acpi_lpss_poweroff_noirq(struct device *dev)
 {
 	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
 
-	if (dev_pm_smart_suspend_and_suspended(dev))
+	if (dev_pm_skip_suspend(dev))
 		return 0;
 
 	if (pdata->dev_desc->resume_from_noirq) {
diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index 8c2a091728a9..ae234d731d42 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1084,7 +1084,7 @@ int acpi_subsys_suspend_late(struct device *dev)
 {
 	int ret;
 
-	if (dev_pm_smart_suspend_and_suspended(dev))
+	if (dev_pm_skip_suspend(dev))
 		return 0;
 
 	ret = pm_generic_suspend_late(dev);
@@ -1100,7 +1100,7 @@ int acpi_subsys_suspend_noirq(struct device *dev)
 {
 	int ret;
 
-	if (dev_pm_smart_suspend_and_suspended(dev))
+	if (dev_pm_skip_suspend(dev))
 		return 0;
 
 	ret = pm_generic_suspend_noirq(dev);
@@ -1213,7 +1213,7 @@ static int acpi_subsys_poweroff_late(struct device *dev)
 {
 	int ret;
 
-	if (dev_pm_smart_suspend_and_suspended(dev))
+	if (dev_pm_skip_suspend(dev))
 		return 0;
 
 	ret = pm_generic_poweroff_late(dev);
@@ -1229,7 +1229,7 @@ static int acpi_subsys_poweroff_late(struct device *dev)
  */
 static int acpi_subsys_poweroff_noirq(struct device *dev)
 {
-	if (dev_pm_smart_suspend_and_suspended(dev))
+	if (dev_pm_skip_suspend(dev))
 		return 0;
 
 	return pm_generic_poweroff_noirq(dev);
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index f98eced0f200..3170d93e29f9 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -567,8 +567,7 @@ static void dpm_watchdog_clear(struct dpm_watchdog *wd)
  *
  * Return:
  * - %false if the transition under way is RESTORE.
- * - The return value of dev_pm_smart_suspend_and_suspended() if the transition
- *   under way is THAW.
+ * - Return value of dev_pm_skip_suspend() if the transition under way is THAW.
  * - The logical negation of %power.must_resume otherwise (that is, when the
  *   transition under way is RESUME).
  */
@@ -578,7 +577,7 @@ bool dev_pm_skip_resume(struct device *dev)
 		return false;
 
 	if (pm_transition.event == PM_EVENT_THAW)
-		return dev_pm_smart_suspend_and_suspended(dev);
+		return dev_pm_skip_suspend(dev);
 
 	return !dev->power.must_resume;
 }
@@ -624,7 +623,7 @@ static int device_resume_noirq(struct device *dev, pm_message_t state, bool asyn
 	 */
 	if (skip_resume)
 		pm_runtime_set_suspended(dev);
-	else if (dev_pm_smart_suspend_and_suspended(dev))
+	else if (dev_pm_skip_suspend(dev))
 		pm_runtime_set_active(dev);
 
 	if (dev->pm_domain) {
@@ -1223,7 +1222,7 @@ static int __device_suspend_noirq(struct device *dev, pm_message_t state, bool a
 	if (callback)
 		goto Run;
 
-	if (dev_pm_smart_suspend_and_suspended(dev))
+	if (dev_pm_skip_suspend(dev))
 		goto Skip;
 
 	if (dev->driver && dev->driver->pm) {
@@ -1415,7 +1414,7 @@ static int __device_suspend_late(struct device *dev, pm_message_t state, bool as
 	if (callback)
 		goto Run;
 
-	if (dev_pm_smart_suspend_and_suspended(dev))
+	if (dev_pm_skip_suspend(dev))
 		goto Skip;
 
 	if (dev->driver && dev->driver->pm) {
@@ -2003,7 +2002,7 @@ void device_pm_check_callbacks(struct device *dev)
 	spin_unlock_irq(&dev->power.lock);
 }
 
-bool dev_pm_smart_suspend_and_suspended(struct device *dev)
+bool dev_pm_skip_suspend(struct device *dev)
 {
 	return dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) &&
 		pm_runtime_status_suspended(dev);
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 312cc45c44c7..bf779f291f15 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -275,7 +275,7 @@ static int pciehp_suspend(struct pcie_device *dev)
 	 * If the port is already runtime suspended we can keep it that
 	 * way.
 	 */
-	if (dev_pm_smart_suspend_and_suspended(&dev->port->dev))
+	if (dev_pm_skip_suspend(&dev->port->dev))
 		return 0;
 
 	pciehp_disable_interrupt(dev);
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index decf82595340..da6510af1221 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -776,7 +776,7 @@ static int pci_pm_suspend(struct device *dev)
 
 static int pci_pm_suspend_late(struct device *dev)
 {
-	if (dev_pm_smart_suspend_and_suspended(dev))
+	if (dev_pm_skip_suspend(dev))
 		return 0;
 
 	pci_fixup_device(pci_fixup_suspend, to_pci_dev(dev));
@@ -789,7 +789,7 @@ static int pci_pm_suspend_noirq(struct device *dev)
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 
-	if (dev_pm_smart_suspend_and_suspended(dev))
+	if (dev_pm_skip_suspend(dev))
 		return 0;
 
 	if (pci_has_legacy_pm_support(pci_dev))
@@ -1126,7 +1126,7 @@ static int pci_pm_poweroff(struct device *dev)
 
 static int pci_pm_poweroff_late(struct device *dev)
 {
-	if (dev_pm_smart_suspend_and_suspended(dev))
+	if (dev_pm_skip_suspend(dev))
 		return 0;
 
 	pci_fixup_device(pci_fixup_suspend, to_pci_dev(dev));
@@ -1139,7 +1139,7 @@ static int pci_pm_poweroff_noirq(struct device *dev)
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 
-	if (dev_pm_smart_suspend_and_suspended(dev))
+	if (dev_pm_skip_suspend(dev))
 		return 0;
 
 	if (pci_has_legacy_pm_support(pci_dev))
diff --git a/include/linux/pm.h b/include/linux/pm.h
index d89b7099f241..8c59a7f0bcf4 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -759,7 +759,7 @@ extern int pm_generic_poweroff(struct device *dev);
 extern void pm_generic_complete(struct device *dev);
 
 extern bool dev_pm_skip_resume(struct device *dev);
-extern bool dev_pm_smart_suspend_and_suspended(struct device *dev);
+extern bool dev_pm_skip_suspend(struct device *dev);
 
 #else /* !CONFIG_PM_SLEEP */
 
-- 
2.16.4




