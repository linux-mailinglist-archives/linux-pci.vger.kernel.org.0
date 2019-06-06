Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72DA9380D7
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2019 00:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfFFWdQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jun 2019 18:33:16 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:43193 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfFFWdP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jun 2019 18:33:15 -0400
Received: from 79.184.253.190.ipv4.supernova.orange.pl (79.184.253.190) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 315b2b5f6b35bdd6; Fri, 7 Jun 2019 00:33:11 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PCI <linux-pci@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] PCI: PM: Replace pci_dev_keep_suspended() with two functions
Date:   Fri, 07 Jun 2019 00:32:31 +0200
Message-ID: <3991282.doQj0dWKJp@kreacher>
In-Reply-To: <2958812.87Qy2A3tJo@kreacher>
References: <2958812.87Qy2A3tJo@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The code in pci_dev_keep_suspended() is relatively hard to follow due
to the negative checks in it and in its callers and the function has
a possible side-effect (disabling the PME) which doesn't really match
its role.

For this reason, move the PME disablig from pci_dev_keep_suspended()
to a separate function and change the semantics (and name) of the
rest of it, so that 'true' is returned when the device needs to be
resumed (and not the other way around).  Change the callers of
pci_dev_keep_suspended() accordingly.

While at it, make the code flow in pci_pm_poweroff() reflect the
pci_pm_suspend() more closely to avoid arbitrary differences between
them.

This is a cosmetic change with no intention to alter behavior.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci-driver.c |   22 +++++++++++++++---
 drivers/pci/pci.c        |   55 +++++++++++++++++++++++------------------------
 drivers/pci/pci.h        |    3 +-
 3 files changed, 48 insertions(+), 32 deletions(-)

Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -2459,55 +2459,56 @@ bool pci_dev_run_wake(struct pci_dev *de
 EXPORT_SYMBOL_GPL(pci_dev_run_wake);
 
 /**
- * pci_dev_keep_suspended - Check if the device can stay in the suspended state.
+ * pci_dev_need_resume - Check if it is necessary to resume the device.
  * @pci_dev: Device to check.
  *
- * Return 'true' if the device is runtime-suspended, it doesn't have to be
+ * Return 'true' if the device is not runtime-suspended or it has to be
  * reconfigured due to wakeup settings difference between system and runtime
- * suspend and the current power state of it is suitable for the upcoming
- * (system) transition.
- *
- * If the device is not configured for system wakeup, disable PME for it before
- * returning 'true' to prevent it from waking up the system unnecessarily.
+ * suspend, or the current power state of it is not suitable for the upcoming
+ * (system-wide) transition.
  */
-bool pci_dev_keep_suspended(struct pci_dev *pci_dev)
+bool pci_dev_need_resume(struct pci_dev *pci_dev)
 {
 	struct device *dev = &pci_dev->dev;
-	bool wakeup = device_may_wakeup(dev);
 	pci_power_t target_state;
 
 	if (!pm_runtime_suspended(dev) || platform_pci_need_resume(pci_dev))
-		return false;
+		return true;
 
-	target_state = pci_target_state(pci_dev, wakeup);
+	target_state = pci_target_state(pci_dev, device_may_wakeup(dev));
 
 	/*
 	 * If the earlier platform check has not triggered, D3cold is just power
 	 * removal on top of D3hot, so no need to resume the device in that
 	 * case.
 	 */
-	if (target_state != pci_dev->current_state &&
-	    target_state != PCI_D3cold && pci_dev->current_state != PCI_D3hot)
-		return false;
+	return target_state != pci_dev->current_state &&
+		target_state != PCI_D3cold &&
+		pci_dev->current_state != PCI_D3hot;
+}
+
+/**
+ * pci_dev_adjust_pme - Adjust PME setting for a suspended device.
+ * @pci_dev: Device to check.
+ *
+ * If the device is suspended and it is not configured for system wakeup,
+ * disable PME for it to prevent it from waking up the system unnecessarily.
+ *
+ * Note that if the device's power state is D3cold and the platform check in
+ * pci_dev_need_resume() has not triggered, the device's configuration need not
+ * be changed.
+ */
+void pci_dev_adjust_pme(struct pci_dev *pci_dev)
+{
+	struct device *dev = &pci_dev->dev;
 
-	/*
-	 * At this point the device is good to go unless it's been configured
-	 * to generate PME at the runtime suspend time, but it is not supposed
-	 * to wake up the system.  In that case, simply disable PME for it
-	 * (it will have to be re-enabled on exit from system resume).
-	 *
-	 * If the device's power state is D3cold and the platform check above
-	 * hasn't triggered, the device's configuration is suitable and we don't
-	 * need to manipulate it at all.
-	 */
 	spin_lock_irq(&dev->power.lock);
 
-	if (pm_runtime_suspended(dev) && pci_dev->current_state < PCI_D3cold &&
-	    !wakeup)
+	if (pm_runtime_suspended(dev) && !device_may_wakeup(dev) &&
+	    pci_dev->current_state < PCI_D3cold)
 		__pci_pme_active(pci_dev, false);
 
 	spin_unlock_irq(&dev->power.lock);
-	return true;
 }
 
 /**
Index: linux-pm/drivers/pci/pci-driver.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-driver.c
+++ linux-pm/drivers/pci/pci-driver.c
@@ -679,6 +679,7 @@ static bool pci_has_legacy_pm_support(st
 static int pci_pm_prepare(struct device *dev)
 {
 	struct device_driver *drv = dev->driver;
+	struct pci_dev *pci_dev = to_pci_dev(dev);
 
 	if (drv && drv->pm && drv->pm->prepare) {
 		int error = drv->pm->prepare(dev);
@@ -688,7 +689,15 @@ static int pci_pm_prepare(struct device
 		if (!error && dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_PREPARE))
 			return 0;
 	}
-	return pci_dev_keep_suspended(to_pci_dev(dev));
+	if (pci_dev_need_resume(pci_dev))
+		return 0;
+
+	/*
+	 * The PME setting needs to be adjusted here in case the direct-complete
+	 * optimization is used with respect to this device.
+	 */
+	pci_dev_adjust_pme(pci_dev);
+	return 1;
 }
 
 static void pci_pm_complete(struct device *dev)
@@ -758,9 +767,11 @@ static int pci_pm_suspend(struct device
 	 * better to resume the device from runtime suspend here.
 	 */
 	if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) ||
-	    !pci_dev_keep_suspended(pci_dev)) {
+	    pci_dev_need_resume(pci_dev)) {
 		pm_runtime_resume(dev);
 		pci_dev->state_saved = false;
+	} else {
+		pci_dev_adjust_pme(pci_dev);
 	}
 
 	if (pm->suspend) {
@@ -1108,10 +1119,13 @@ static int pci_pm_poweroff(struct device
 
 	/* The reason to do that is the same as in pci_pm_suspend(). */
 	if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) ||
-	    !pci_dev_keep_suspended(pci_dev))
+	    pci_dev_need_resume(pci_dev)) {
 		pm_runtime_resume(dev);
+		pci_dev->state_saved = false;
+	} else {
+		pci_dev_adjust_pme(pci_dev);
+	}
 
-	pci_dev->state_saved = false;
 	if (pm->poweroff) {
 		int error;
 
Index: linux-pm/drivers/pci/pci.h
===================================================================
--- linux-pm.orig/drivers/pci/pci.h
+++ linux-pm/drivers/pci/pci.h
@@ -82,7 +82,8 @@ int pci_finish_runtime_suspend(struct pc
 void pcie_clear_root_pme_status(struct pci_dev *dev);
 int __pci_pme_wakeup(struct pci_dev *dev, void *ign);
 void pci_pme_restore(struct pci_dev *dev);
-bool pci_dev_keep_suspended(struct pci_dev *dev);
+bool pci_dev_need_resume(struct pci_dev *dev);
+void pci_dev_adjust_pme(struct pci_dev *dev);
 void pci_dev_complete_resume(struct pci_dev *pci_dev);
 void pci_config_pm_runtime_get(struct pci_dev *dev);
 void pci_config_pm_runtime_put(struct pci_dev *dev);



