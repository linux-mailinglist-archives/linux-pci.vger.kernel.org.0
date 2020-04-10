Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 318301A4817
	for <lists+linux-pci@lfdr.de>; Fri, 10 Apr 2020 18:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgDJQAw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Apr 2020 12:00:52 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58474 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgDJQAv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Apr 2020 12:00:51 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id ebbf3e2dfb3ed491; Fri, 10 Apr 2020 18:00:48 +0200
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
Subject: [PATCH 2/7] PM: sleep: core: Fold functions into their callers
Date:   Fri, 10 Apr 2020 17:48:45 +0200
Message-ID: <3637853.KA6EFo2J0E@kreacher>
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

Fold four functions in the PM core that each have only one caller
now into their callers.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c | 198 ++++++++++++++--------------------------------
 1 file changed, 60 insertions(+), 138 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 5d0225573bbe..75d7cdb4de9c 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -573,43 +573,6 @@ bool dev_pm_may_skip_resume(struct device *dev)
 	return !dev->power.must_resume && pm_transition.event != PM_EVENT_RESTORE;
 }
 
-static pm_callback_t dpm_subsys_resume_noirq_cb(struct device *dev,
-						pm_message_t state,
-						const char **info_p)
-{
-	pm_callback_t callback;
-	const char *info;
-
-	if (dev->pm_domain) {
-		info = "noirq power domain ";
-		callback = pm_noirq_op(&dev->pm_domain->ops, state);
-	} else if (dev->type && dev->type->pm) {
-		info = "noirq type ";
-		callback = pm_noirq_op(dev->type->pm, state);
-	} else if (dev->class && dev->class->pm) {
-		info = "noirq class ";
-		callback = pm_noirq_op(dev->class->pm, state);
-	} else if (dev->bus && dev->bus->pm) {
-		info = "noirq bus ";
-		callback = pm_noirq_op(dev->bus->pm, state);
-	} else {
-		return NULL;
-	}
-
-	if (info_p)
-		*info_p = info;
-
-	return callback;
-}
-
-static pm_callback_t dpm_subsys_suspend_noirq_cb(struct device *dev,
-						 pm_message_t state,
-						 const char **info_p);
-
-static pm_callback_t dpm_subsys_suspend_late_cb(struct device *dev,
-						pm_message_t state,
-						const char **info_p);
-
 /**
  * device_resume_noirq - Execute a "noirq resume" callback for given device.
  * @dev: Device to handle.
@@ -621,8 +584,8 @@ static pm_callback_t dpm_subsys_suspend_late_cb(struct device *dev,
  */
 static int device_resume_noirq(struct device *dev, pm_message_t state, bool async)
 {
-	pm_callback_t callback;
-	const char *info;
+	pm_callback_t callback = NULL;
+	const char *info = NULL;
 	bool skip_resume;
 	int error = 0;
 
@@ -638,7 +601,19 @@ static int device_resume_noirq(struct device *dev, pm_message_t state, bool asyn
 	if (!dpm_wait_for_superior(dev, async))
 		goto Out;
 
-	callback = dpm_subsys_resume_noirq_cb(dev, state, &info);
+	if (dev->pm_domain) {
+		info = "noirq power domain ";
+		callback = pm_noirq_op(&dev->pm_domain->ops, state);
+	} else if (dev->type && dev->type->pm) {
+		info = "noirq type ";
+		callback = pm_noirq_op(dev->type->pm, state);
+	} else if (dev->class && dev->class->pm) {
+		info = "noirq class ";
+		callback = pm_noirq_op(dev->class->pm, state);
+	} else if (dev->bus && dev->bus->pm) {
+		info = "noirq bus ";
+		callback = pm_noirq_op(dev->bus->pm, state);
+	}
 	if (callback) {
 		skip_resume = false;
 		goto Run;
@@ -791,35 +766,6 @@ void dpm_resume_noirq(pm_message_t state)
 	cpuidle_resume();
 }
 
-static pm_callback_t dpm_subsys_resume_early_cb(struct device *dev,
-						pm_message_t state,
-						const char **info_p)
-{
-	pm_callback_t callback;
-	const char *info;
-
-	if (dev->pm_domain) {
-		info = "early power domain ";
-		callback = pm_late_early_op(&dev->pm_domain->ops, state);
-	} else if (dev->type && dev->type->pm) {
-		info = "early type ";
-		callback = pm_late_early_op(dev->type->pm, state);
-	} else if (dev->class && dev->class->pm) {
-		info = "early class ";
-		callback = pm_late_early_op(dev->class->pm, state);
-	} else if (dev->bus && dev->bus->pm) {
-		info = "early bus ";
-		callback = pm_late_early_op(dev->bus->pm, state);
-	} else {
-		return NULL;
-	}
-
-	if (info_p)
-		*info_p = info;
-
-	return callback;
-}
-
 /**
  * device_resume_early - Execute an "early resume" callback for given device.
  * @dev: Device to handle.
@@ -830,8 +776,8 @@ static pm_callback_t dpm_subsys_resume_early_cb(struct device *dev,
  */
 static int device_resume_early(struct device *dev, pm_message_t state, bool async)
 {
-	pm_callback_t callback;
-	const char *info;
+	pm_callback_t callback = NULL;
+	const char *info = NULL;
 	int error = 0;
 
 	TRACE_DEVICE(dev);
@@ -846,9 +792,19 @@ static int device_resume_early(struct device *dev, pm_message_t state, bool asyn
 	if (!dpm_wait_for_superior(dev, async))
 		goto Out;
 
-	callback = dpm_subsys_resume_early_cb(dev, state, &info);
-
-	if (!callback && dev->driver && dev->driver->pm) {
+	if (dev->pm_domain) {
+		info = "early power domain ";
+		callback = pm_late_early_op(&dev->pm_domain->ops, state);
+	} else if (dev->type && dev->type->pm) {
+		info = "early type ";
+		callback = pm_late_early_op(dev->type->pm, state);
+	} else if (dev->class && dev->class->pm) {
+		info = "early class ";
+		callback = pm_late_early_op(dev->class->pm, state);
+	} else if (dev->bus && dev->bus->pm) {
+		info = "early bus ";
+		callback = pm_late_early_op(dev->bus->pm, state);
+	} else if (dev->driver && dev->driver->pm) {
 		info = "early driver ";
 		callback = pm_late_early_op(dev->driver->pm, state);
 	}
@@ -1226,35 +1182,6 @@ static void dpm_superior_set_must_resume(struct device *dev)
 	device_links_read_unlock(idx);
 }
 
-static pm_callback_t dpm_subsys_suspend_noirq_cb(struct device *dev,
-						 pm_message_t state,
-						 const char **info_p)
-{
-	pm_callback_t callback;
-	const char *info;
-
-	if (dev->pm_domain) {
-		info = "noirq power domain ";
-		callback = pm_noirq_op(&dev->pm_domain->ops, state);
-	} else if (dev->type && dev->type->pm) {
-		info = "noirq type ";
-		callback = pm_noirq_op(dev->type->pm, state);
-	} else if (dev->class && dev->class->pm) {
-		info = "noirq class ";
-		callback = pm_noirq_op(dev->class->pm, state);
-	} else if (dev->bus && dev->bus->pm) {
-		info = "noirq bus ";
-		callback = pm_noirq_op(dev->bus->pm, state);
-	} else {
-		return NULL;
-	}
-
-	if (info_p)
-		*info_p = info;
-
-	return callback;
-}
-
 /**
  * __device_suspend_noirq - Execute a "noirq suspend" callback for given device.
  * @dev: Device to handle.
@@ -1266,8 +1193,8 @@ static pm_callback_t dpm_subsys_suspend_noirq_cb(struct device *dev,
  */
 static int __device_suspend_noirq(struct device *dev, pm_message_t state, bool async)
 {
-	pm_callback_t callback;
-	const char *info;
+	pm_callback_t callback = NULL;
+	const char *info = NULL;
 	int error = 0;
 
 	TRACE_DEVICE(dev);
@@ -1281,7 +1208,19 @@ static int __device_suspend_noirq(struct device *dev, pm_message_t state, bool a
 	if (dev->power.syscore || dev->power.direct_complete)
 		goto Complete;
 
-	callback = dpm_subsys_suspend_noirq_cb(dev, state, &info);
+	if (dev->pm_domain) {
+		info = "noirq power domain ";
+		callback = pm_noirq_op(&dev->pm_domain->ops, state);
+	} else if (dev->type && dev->type->pm) {
+		info = "noirq type ";
+		callback = pm_noirq_op(dev->type->pm, state);
+	} else if (dev->class && dev->class->pm) {
+		info = "noirq class ";
+		callback = pm_noirq_op(dev->class->pm, state);
+	} else if (dev->bus && dev->bus->pm) {
+		info = "noirq bus ";
+		callback = pm_noirq_op(dev->bus->pm, state);
+	}
 	if (callback)
 		goto Run;
 
@@ -1429,35 +1368,6 @@ static void dpm_propagate_wakeup_to_parent(struct device *dev)
 	spin_unlock_irq(&parent->power.lock);
 }
 
-static pm_callback_t dpm_subsys_suspend_late_cb(struct device *dev,
-						pm_message_t state,
-						const char **info_p)
-{
-	pm_callback_t callback;
-	const char *info;
-
-	if (dev->pm_domain) {
-		info = "late power domain ";
-		callback = pm_late_early_op(&dev->pm_domain->ops, state);
-	} else if (dev->type && dev->type->pm) {
-		info = "late type ";
-		callback = pm_late_early_op(dev->type->pm, state);
-	} else if (dev->class && dev->class->pm) {
-		info = "late class ";
-		callback = pm_late_early_op(dev->class->pm, state);
-	} else if (dev->bus && dev->bus->pm) {
-		info = "late bus ";
-		callback = pm_late_early_op(dev->bus->pm, state);
-	} else {
-		return NULL;
-	}
-
-	if (info_p)
-		*info_p = info;
-
-	return callback;
-}
-
 /**
  * __device_suspend_late - Execute a "late suspend" callback for given device.
  * @dev: Device to handle.
@@ -1468,8 +1378,8 @@ static pm_callback_t dpm_subsys_suspend_late_cb(struct device *dev,
  */
 static int __device_suspend_late(struct device *dev, pm_message_t state, bool async)
 {
-	pm_callback_t callback;
-	const char *info;
+	pm_callback_t callback = NULL;
+	const char *info = NULL;
 	int error = 0;
 
 	TRACE_DEVICE(dev);
@@ -1490,7 +1400,19 @@ static int __device_suspend_late(struct device *dev, pm_message_t state, bool as
 	if (dev->power.syscore || dev->power.direct_complete)
 		goto Complete;
 
-	callback = dpm_subsys_suspend_late_cb(dev, state, &info);
+	if (dev->pm_domain) {
+		info = "late power domain ";
+		callback = pm_late_early_op(&dev->pm_domain->ops, state);
+	} else if (dev->type && dev->type->pm) {
+		info = "late type ";
+		callback = pm_late_early_op(dev->type->pm, state);
+	} else if (dev->class && dev->class->pm) {
+		info = "late class ";
+		callback = pm_late_early_op(dev->class->pm, state);
+	} else if (dev->bus && dev->bus->pm) {
+		info = "late bus ";
+		callback = pm_late_early_op(dev->bus->pm, state);
+	}
 	if (callback)
 		goto Run;
 
-- 
2.16.4




