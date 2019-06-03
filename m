Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E97C32D93
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2019 12:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfFCKKc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Jun 2019 06:10:32 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:46614 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfFCKKc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jun 2019 06:10:32 -0400
Received: from 79.184.253.190.ipv4.supernova.orange.pl (79.184.253.190) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 1b9cea5bb1cf6da1; Mon, 3 Jun 2019 12:10:28 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: PM: Avoid resuming devices in D3hot during system suspend
Date:   Mon, 03 Jun 2019 12:10:28 +0200
Message-ID: <1855172.0PEGphScmv@kreacher>
In-Reply-To: <20190531211648.GB58810@google.com>
References: <4561083.VtDMOnK5Me@kreacher> <20190531211648.GB58810@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday, May 31, 2019 11:16:48 PM CEST Bjorn Helgaas wrote:
> On Fri, May 31, 2019 at 11:49:30AM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > The current code resumes devices in D3hot during system suspend if
> > the target power state for them is D3cold, but that is not necessary
> > in general.  It only is necessary to do that if the platform firmware
> > requires the device to be resumed, but that should be covered by
> > the platform_pci_need_resume() check anyway, so rework
> > pci_dev_keep_suspended() to avoid returning 'false' for devices
> > in D3hot which need not be resumed due to platform firmware
> > requirements.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/pci/pci.c |   15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> > 
> > Index: linux-pm/drivers/pci/pci.c
> > ===================================================================
> > --- linux-pm.orig/drivers/pci/pci.c
> > +++ linux-pm/drivers/pci/pci.c
> > @@ -2474,10 +2474,19 @@ bool pci_dev_keep_suspended(struct pci_d
> >  {
> >  	struct device *dev = &pci_dev->dev;
> >  	bool wakeup = device_may_wakeup(dev);
> > +	pci_power_t target_state;
> >  
> > -	if (!pm_runtime_suspended(dev)
> > -	    || pci_target_state(pci_dev, wakeup) != pci_dev->current_state
> > -	    || platform_pci_need_resume(pci_dev))
> > +	if (!pm_runtime_suspended(dev) || platform_pci_need_resume(pci_dev))
> > +		return false;
> > +
> > +	target_state = pci_target_state(pci_dev, wakeup);
> 
> Nit, add a blank line here.

OK

> > +	/*
> > +	 * If the earlier platform check has not triggered, D3cold is just power
> > +	 * removal on top of D3hot, so no need to resume the device in that
> > +	 * case.
> > +	 */
> > +	if (target_state != pci_dev->current_state &&
> > +	    target_state != PCI_D3cold && pci_dev->current_state != PCI_D3hot)
> >  		return false;
> 
> This is more a comment on the existing code than on this particular
> patch, but I find this whole function hard to understand, and I think
> one reason is that there are a lot of negative conditions, both in
> this function and in its callers.  This "target_state != ... &&
> target_state != ...  && current_state != ..." is one example.  Another
> is the function name itself.  It might be easier to read as something
> like this:
> 
>   bool pci_dev_need_resume(...)
>   {
>     if (!pm_runtime_suspended(...))
>       return true;
> 
>     if (platform_pci_need_resume(...))
>       return true;
> 
>     if (target_state != current_state)
>       return true;

Please see the appended (untested) patch on top of the $subject one.

>     ...
> 
> Another reason I think it's hard to read is that
> "pci_dev_keep_suspended" suggests that this is a pure boolean function
> without side-effects, but in fact it also fiddles with the PME state
> in some cases.  I don't have any ideas for that part.

Well, I can only propose to put the PME adjustment part into a separate function like
in the patch below.

---
 drivers/pci/pci-driver.c |   21 ++++++++++++++++---
 drivers/pci/pci.c        |   50 ++++++++++++++++++++++++-----------------------
 drivers/pci/pci.h        |    3 +-
 3 files changed, 46 insertions(+), 28 deletions(-)

Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -2459,54 +2459,56 @@ bool pci_dev_run_wake(struct pci_dev *de
 EXPORT_SYMBOL_GPL(pci_dev_run_wake);
 
 /**
- * pci_dev_keep_suspended - Check if the device can stay in the suspended state.
+ * pci_dev_need_resume - Check if the device can stay in the suspended state.
  * @pci_dev: Device to check.
  *
- * Return 'true' if the device is runtime-suspended, it doesn't have to be
+ * Return 'false' if the device is runtime-suspended, it doesn't have to be
  * reconfigured due to wakeup settings difference between system and runtime
  * suspend and the current power state of it is suitable for the upcoming
  * (system) transition.
- *
- * If the device is not configured for system wakeup, disable PME for it before
- * returning 'true' to prevent it from waking up the system unnecessarily.
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
+ * If the device is not configured for system wakeup, disable PME for it to
+ * prevent it from waking up the system unnecessarily.
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
 
+	/*
+	 * If the device's power state is D3cold and the platform check in
+	 * pci_dev_need_resume() hasn't triggered, the device's configuration is
+	 * suitable and it need not be touched.
+	 */
 	if (pm_runtime_suspended(dev) && pci_dev->current_state < PCI_D3cold &&
-	    !wakeup)
+	    !device_may_wakeup(dev))
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
@@ -1108,8 +1119,12 @@ static int pci_pm_poweroff(struct device
 
 	/* The reason to do that is the same as in pci_pm_suspend(). */
 	if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) ||
-	    !pci_dev_keep_suspended(pci_dev))
+	    pci_dev_need_resume(pci_dev)) {
 		pm_runtime_resume(dev);
+		pci_dev->state_saved = false;
+	} else {
+		pci_dev_adjust_pme(pci_dev);
+	}
 
 	pci_dev->state_saved = false;
 	if (pm->poweroff) {
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



