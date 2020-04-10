Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA2A1A481E
	for <lists+linux-pci@lfdr.de>; Fri, 10 Apr 2020 18:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgDJQAt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Apr 2020 12:00:49 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41565 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgDJQAs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Apr 2020 12:00:48 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id fa9d766f623ddf0c; Fri, 10 Apr 2020 18:00:45 +0200
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
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>
Subject: [PATCH 7/7] Documentation: PM: sleep: Update driver flags documentation
Date:   Fri, 10 Apr 2020 17:58:50 +0200
Message-ID: <1997182.shB3oO26W5@kreacher>
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

Update the documentation of the driver flags for system-wide power
management to reflect the current code flows and be more consistent.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/driver-api/pm/devices.rst | 118 +++++++++++++++++++-------------
 Documentation/power/pci.rst             |  43 ++++++------
 include/linux/pm.h                      |  24 ++-----
 3 files changed, 98 insertions(+), 87 deletions(-)

diff --git a/Documentation/driver-api/pm/devices.rst b/Documentation/driver-api/pm/devices.rst
index f342c7549b4c..39360c2cc54d 100644
--- a/Documentation/driver-api/pm/devices.rst
+++ b/Documentation/driver-api/pm/devices.rst
@@ -776,58 +776,82 @@ Some bus types and PM domains have a policy to resume all devices from runtime
 suspend upfront in their ``->suspend`` callbacks, but that may not be really
 necessary if the driver of the device can cope with runtime-suspended devices.
 The driver can indicate that by setting ``DPM_FLAG_SMART_SUSPEND`` in
-:c:member:`power.driver_flags` at the probe time, by passing it to the
-:c:func:`dev_pm_set_driver_flags` helper.  That also may cause middle-layer code
+:c:member:`power.driver_flags` at the probe time with the help of the
+:c:func:`dev_pm_set_driver_flags` helper routine.
+
+However, setting that flag also causes the PM core and middle-layer code
 (bus types, PM domains etc.) to skip the ``->suspend_late`` and
 ``->suspend_noirq`` callbacks provided by the driver if the device remains in
-runtime suspend at the beginning of the ``suspend_late`` phase of system-wide
-suspend (or in the ``poweroff_late`` phase of hibernation), when runtime PM
-has been disabled for it, under the assumption that its state should not change
-after that point until the system-wide transition is over (the PM core itself
-does that for devices whose "noirq", "late" and "early" system-wide PM callbacks
-are executed directly by it).  If that happens, the driver's system-wide resume
-callbacks, if present, may still be invoked during the subsequent system-wide
-resume transition and the device's runtime power management status may be set
-to "active" before enabling runtime PM for it, so the driver must be prepared to
-cope with the invocation of its system-wide resume callbacks back-to-back with
-its ``->runtime_suspend`` one (without the intervening ``->runtime_resume`` and
-so on) and the final state of the device must reflect the "active" runtime PM
-status in that case.
+runtime suspend during the ``suspend_late`` phase of system-wide suspend (or
+during the ``poweroff_late`` or ``freeze_late`` phase of hibernation),
+after runtime PM was disabled for it.  [Without doing that, the same driver
+callback might be executed twice in a row for the same device, which would not
+be valid in general.]  If the middle-layer system-wide PM callbacks are present
+for the device, they are responsible for doing the above, and if they are not
+present, the PM core takes care of it.
+
+In addition, with ``DPM_FLAG_SMART_SUSPEND`` set, the driver's ``->thaw_late``
+and ``->thaw_noirq`` callbacks are skipped if the device remained in runtime
+suspend during the preceding "freeze" transition related to hibernation.
+[Again, if the middle-layer callbacks are present for the device, they are
+responsible for doing that, or the PM core takes care of it otherwise.]
 
 During system-wide resume from a sleep state it's easiest to put devices into
 the full-power state, as explained in :file:`Documentation/power/runtime_pm.rst`.
 [Refer to that document for more information regarding this particular issue as
 well as for information on the device runtime power management framework in
-general.]
-
-However, it often is desirable to leave devices in suspend after system
-transitions to the working state, especially if those devices had been in
+general.]  However, it often is desirable to leave devices in suspend after
+system transitions to the working state, especially if those devices had been in
 runtime suspend before the preceding system-wide suspend (or analogous)
-transition.  Device drivers can use the ``DPM_FLAG_MAY_SKIP_RESUME`` flag to
-indicate to the PM core (and middle-layer code) that they prefer the specific
-devices handled by them to be left suspended and they have no problems with
-skipping their system-wide resume callbacks for this reason.  Whether or not the
-devices will actually be left in suspend may depend on their state before the
-given system suspend-resume cycle and on the type of the system transition under
-way.  In particular, devices are not left suspended if that transition is a
-restore from hibernation, as device states are not guaranteed to be reflected
-by the information stored in the hibernation image in that case.
-
-The middle-layer code involved in the handling of the device is expected to
-indicate to the PM core if the device may be left in suspend by setting its
-:c:member:`power.may_skip_resume` status bit which is checked by the PM core
-during the "noirq" phase of the preceding system-wide suspend (or analogous)
-transition.  The middle layer is then responsible for handling the device as
-appropriate in its "noirq" resume callback, which is executed regardless of
-whether or not the device is left suspended, but the other resume callbacks
-(except for ``->complete``) will be skipped automatically by the PM core if the
-device really can be left in suspend.
-
-For devices whose "noirq", "late" and "early" driver callbacks are invoked
-directly by the PM core, all of the system-wide resume callbacks are skipped if
-``DPM_FLAG_MAY_SKIP_RESUME`` is set and the device is in runtime suspend during
-the ``suspend_noirq`` (or analogous) phase or the transition under way is a
-proper system suspend (rather than anything related to hibernation) and the
-device's wakeup settings are suitable for runtime PM (that is, it cannot
-generate wakeup signals at all or it is allowed to wake up the system from
-sleep).
+transition.
+
+To that end, device drivers can use the ``DPM_FLAG_MAY_SKIP_RESUME`` flag to
+indicate to the PM core and middle-layer code that they allow their "noirq" and
+"early" resume callbacks to be skipped if the device can be left in suspend
+after system-wide PM transitions to the working state.  Whether or not that is
+the case generally depend on the state of the device before the given system
+suspend-resume cycle and on the type of the system transition under way.
+In particular, driver callbacks are never skipped during the "restore"
+transition related to hibernation (because the actual states of devices at that
+time are not known in general, all of them are put into the full-power state
+then and configured to reflect their "active" working-state settings).
+
+The middle-layer code is expected to indicate to the PM core whether or not
+skipping the driver's "noirq" and "early" resume callbacks for a given device
+makes sense from its perspective by either setting or clearing the device's
+:c:member:`power.may_skip_resume` status bit (checked by the PM core during the
+"noirq" phase of the suspend, or analogous, transition).  Setting that status
+bit along with the ``DPM_FLAG_MAY_SKIP_RESUME`` flag is necessary, but
+generally not sufficient, for the driver's "noirq" and "early" callbacks to be
+skipped.  Whether or not they should be skipped can be determined by evaluating
+the :c:func:`dev_pm_skip_resume` helper function.
+
+If that function returns ``true``, the driver's "noirq" and "early" resume
+callbacks should be skipped.  Otherwise, if the device was runtime-suspended
+during the preceding system-wide suspend transition, its runtime PM status needs
+to be set to "active" which is taken care of by the PM core.
+
+If the ``DPM_FLAG_MAY_SKIP_RESUME`` flag is not set for a device, but
+``DPM_FLAG_SMART_SUSPEND`` is set and the driver's "late" and "noirq" suspend
+callbacks are skipped, its system-wide "noirq" and "early" resume callbacks, if
+present, are invoked as usual and the device's runtime PM status is set to
+"active" by the PM core before enabling runtime PM for it, so the driver must be
+prepared to cope with the invocation of its system-wide resume callbacks
+back-to-back with its ``->runtime_suspend`` one (without the intervening
+``->runtime_resume`` and system-wide suspend callbacks) and the final state of
+the device must reflect the "active" runtime PM status in that case.  [Note that
+this is not a problem at all if the driver's ``->suspend_late`` callback pointer
+points to the same function as its ``->runtime_suspend`` one and its
+``->resume_early`` callback pointer points to the same function as the
+``->runtime_resume`` one, while none of the other system-wide suspend-resume
+callbacks of the driver are present, for example.]
+
+Likewise, if ``DPM_FLAG_MAY_SKIP_RESUME`` is set for a device, its driver's
+system-wide "noirq" and "early" resume callbacks may be skipped while its "late"
+and "noirq" suspend callbacks may have been executed (in principle, regardless
+of whether or not ``DPM_FLAG_SMART_SUSPEND`` is set).  In that case, the driver
+needs to be able to cope with the invocation of its ``->runtime_resume``
+callback back-to-back with its "late" and "noirq" suspend ones.  [Again, that
+is not a concern if the driver sets both ``DPM_FLAG_SMART_SUSPEND`` and
+``DPM_FLAG_MAY_SKIP_RESUME`` and uses the same pair of suspend/resume callback
+functions for runtime PM and system-wide suspend/resume.]
diff --git a/Documentation/power/pci.rst b/Documentation/power/pci.rst
index f09b382b4621..1831e431f725 100644
--- a/Documentation/power/pci.rst
+++ b/Documentation/power/pci.rst
@@ -1010,32 +1010,33 @@ if the device is in runtime suspend when the system suspend starts.  That also
 affects all of the ancestors of the device, so this flag should only be used if
 absolutely necessary.
 
-The DPM_FLAG_SMART_PREPARE flag instructs the PCI bus type to only return a
-positive value from pci_pm_prepare() if the ->prepare callback provided by the
+The DPM_FLAG_SMART_PREPARE flag causes the PCI bus type to return a positive
+value from pci_pm_prepare() only if the ->prepare callback provided by the
 driver of the device returns a positive value.  That allows the driver to opt
-out from using the direct-complete mechanism dynamically.
+out from using the direct-complete mechanism dynamically (whereas setting
+DPM_FLAG_NO_DIRECT_COMPLETE means permanent opt-out).
 
 The DPM_FLAG_SMART_SUSPEND flag tells the PCI bus type that from the driver's
 perspective the device can be safely left in runtime suspend during system
 suspend.  That causes pci_pm_suspend(), pci_pm_freeze() and pci_pm_poweroff()
-to skip resuming the device from runtime suspend unless there are PCI-specific
-reasons for doing that.  Also, it causes pci_pm_suspend_late/noirq(),
-pci_pm_freeze_late/noirq() and pci_pm_poweroff_late/noirq() to return early
-if the device remains in runtime suspend in the beginning of the "late" phase
-of the system-wide transition under way.  Moreover, if the device is in
-runtime suspend in pci_pm_resume_noirq() or pci_pm_restore_noirq(), its runtime
-power management status will be changed to "active" (as it is going to be put
-into D0 going forward), but if it is in runtime suspend in pci_pm_thaw_noirq(),
-the function will set the power.direct_complete flag for it (to make the PM core
-skip the subsequent "thaw" callbacks for it) and return.
-
-Setting the DPM_FLAG_MAY_SKIP_RESUME flag means that the driver prefers the
-device to be left in suspend after system-wide transitions to the working state.
-This flag is checked by the PM core, but the PCI bus type informs the PM core
-which devices may be left in suspend from its perspective (that happens during
-the "noirq" phase of system-wide suspend and analogous transitions) and next it
-uses the dev_pm_skip_resume() helper to decide whether or not to return from
-pci_pm_resume_noirq() and pci_pm_resume_early() upfront.
+to avoid resuming the device from runtime suspend unless there are PCI-specific
+reasons for doing that.  Also, it causes pci_pm_suspend_late/noirq() and
+pci_pm_poweroff_late/noirq() to return early if the device remains in runtime
+suspend during the "late" phase of the system-wide transition under way.
+Moreover, if the device is in runtime suspend in pci_pm_resume_noirq() or
+pci_pm_restore_noirq(), its runtime PM status will be changed to "active" (as it
+is going to be put into D0 going forward).
+
+Setting the DPM_FLAG_MAY_SKIP_RESUME flag means that the driver allows its
+"noirq" and "early" resume callbacks to be skipped if the device can be left
+in suspend after a system-wide transition into the working state.  This flag is
+taken into consideration by the PM core along with the power.may_skip_resume
+status bit of the device which is set by pci_pm_suspend_noirq() in certain
+situations.  If the PM core determines that the driver's "noirq" and "early"
+resume callbacks should be skipped, the dev_pm_skip_resume() helper function
+will return "true" and that will cause pci_pm_resume_noirq() and
+pci_pm_resume_early() to return upfront without touching the device and
+executing the driver callbacks.
 
 3.2. Device Runtime Power Management
 ------------------------------------
diff --git a/include/linux/pm.h b/include/linux/pm.h
index f545666120d0..9542bbc5f938 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -545,25 +545,11 @@ struct pm_subsys_data {
  * cleared by the drivers as the driver core will take care of that.
  *
  * NO_DIRECT_COMPLETE: Do not apply direct-complete optimization to the device.
- * SMART_PREPARE: Check the return value of the driver's ->prepare callback.
- * SMART_SUSPEND: No need to resume the device from runtime suspend.
- * MAY_SKIP_RESUME: Avoid resuming the device during system resume if possible.
- *
- * Setting SMART_PREPARE instructs bus types and PM domains which may want
- * system suspend/resume callbacks to be skipped for the device to return 0 from
- * their ->prepare callbacks if the driver's ->prepare callback returns 0 (in
- * other words, the system suspend/resume callbacks can only be skipped for the
- * device if its driver doesn't object against that).  This flag has no effect
- * if NO_DIRECT_COMPLETE is set.
- *
- * Setting SMART_SUSPEND instructs bus types and PM domains which may want to
- * runtime resume the device upfront during system suspend that doing so is not
- * necessary from the driver's perspective.  It also may cause them to skip
- * invocations of the ->suspend_late and ->suspend_noirq callbacks provided by
- * the driver if they decide to leave the device in runtime suspend.
- *
- * Setting MAY_SKIP_RESUME informs the PM core and middle-layer code that the
- * driver prefers the device to be left in suspend after system resume.
+ * SMART_PREPARE: Take the driver ->prepare callback return value into account.
+ * SMART_SUSPEND: Avoid resuming the device from runtime suspend.
+ * MAY_SKIP_RESUME: Allow driver "noirq" and "early" callbacks to be skipped.
+ *
+ * See Documentation/driver-api/pm/devices.rst for details.
  */
 #define DPM_FLAG_NO_DIRECT_COMPLETE	BIT(0)
 #define DPM_FLAG_SMART_PREPARE		BIT(1)
-- 
2.16.4




