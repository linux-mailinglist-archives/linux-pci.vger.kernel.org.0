Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8F71AF2AA
	for <lists+linux-pci@lfdr.de>; Sat, 18 Apr 2020 19:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgDRRMT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Apr 2020 13:12:19 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41196 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgDRRL7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 18 Apr 2020 13:11:59 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id ffe55581f52f5e08; Sat, 18 Apr 2020 19:11:51 +0200
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
Subject: [PATCH v2 9/9] Documentation: PM: sleep: Update driver flags documentation
Date:   Sat, 18 Apr 2020 18:55:32 +0200
Message-ID: <1694461.b9jsgxSh8l@kreacher>
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

Update the documentation of the driver flags for system-wide power
management to reflect the current code flows and be more consistent.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

-> v2:
   * Updated to reflect changes new in v2.

---
 Documentation/driver-api/pm/devices.rst | 139 +++++++++++++++++++++-----------
 Documentation/power/pci.rst             |  43 +++++-----
 include/linux/pm.h                      |  24 ++----
 3 files changed, 119 insertions(+), 87 deletions(-)

diff --git a/Documentation/driver-api/pm/devices.rst b/Documentation/driver-api/pm/devices.rst
index f342c7549b4c..782cb37073a3 100644
--- a/Documentation/driver-api/pm/devices.rst
+++ b/Documentation/driver-api/pm/devices.rst
@@ -772,62 +772,107 @@ the state of devices (possibly except for resuming them from runtime suspend)
 from their ``->prepare`` and ``->suspend`` callbacks (or equivalent) *before*
 invoking device drivers' ``->suspend`` callbacks (or equivalent).
 
+.. _smart_suspend_flag:
+
+The ``DPM_FLAG_SMART_SUSPEND`` Driver Flag
+------------------------------------------
+
 Some bus types and PM domains have a policy to resume all devices from runtime
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
+for the device, they are responsible for doing the above, and the PM core takes
+care of it otherwise.
+
+In addition, with ``DPM_FLAG_SMART_SUSPEND`` set, the driver's ``->thaw_late``
+and ``->thaw_noirq`` callbacks are skipped if the device remained in runtime
+suspend during the preceding "freeze" transition related to hibernation.
+Again, if the middle-layer callbacks are present for the device, they are
+responsible for doing that, or the PM core takes care of it otherwise.
+
+
+The ``DPM_FLAG_MAY_SKIP_RESUME`` Driver Flag
+--------------------------------------------
 
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
+the case generally depends on the state of the device before the given system
+suspend-resume cycle and on the type of the system transition under way.
+In particular, the "restore" and "thaw" transitions related to hibernation are
+not affected by ``DPM_FLAG_MAY_SKIP_RESUME`` at all.  [All devices are always
+resumed during the "restore" transition and whether or not any driver callbacks
+are skipped during the "freeze" transition depends whether or not the
+``DPM_FLAG_SMART_SUSPEND`` flag is set (see `above <smart_suspend_flag_>`_).]
+
+The ``DPM_FLAG_MAY_SKIP_RESUME`` flag is taken into account in combination with
+the :c:member:`power.may_skip_resume` status bit set by the PM core during the
+"suspend" phase of suspend-type transitions.  If the driver or the middle layer
+has a reason to prevent the driver's "noirq" and "early" resume callbacks from
+being skipped during the subsequent resume transition of the system, it should
+clear :c:member:`power.may_skip_resume` in its ``->suspend``, ``->suspend_late``
+or ``->suspend_noirq`` callback.  [Note that the drivers setting
+``DPM_FLAG_SMART_SUSPEND`` need to clear :c:member:`power.may_skip_resume` in
+their ``->suspend`` callback in case the other two are skipped.]
+
+Setting the :c:member:`power.may_skip_resume` status bit along with the
+``DPM_FLAG_MAY_SKIP_RESUME`` flag is necessary, but generally not sufficient,
+for the driver's "noirq" and "early" resume callbacks to be skipped.  Whether or
+not they should be skipped can be determined by evaluating the
+:c:func:`dev_pm_skip_resume` helper function.
+
+If that function returns ``true``, the driver's "noirq" and "early" resume
+callbacks should be skipped and the device's runtime PM status will be set to
+"suspended" by the PM core.  Otherwise, if the device was runtime-suspended
+during the preceding system-wide suspend transition and
+``DPM_FLAG_SMART_SUSPEND`` is set for it, its runtime PM status will be set to
+"active" by the PM core.  [Hence, the drivers that do not set
+``DPM_FLAG_SMART_SUSPEND`` should not expect the runtime PM status of their
+devices to be changed from "suspended" to "active" by the PM core during
+system-wide resume-type transitions.]
+
+If the ``DPM_FLAG_MAY_SKIP_RESUME`` flag is not set for a device, but
+``DPM_FLAG_SMART_SUSPEND`` is set and the driver's "late" and "noirq" suspend
+callbacks are skipped, its system-wide "noirq" and "early" resume callbacks, if
+present, are invoked as usual and the device's runtime PM status is set to
+"active" by the PM core before enabling runtime PM for it.  In that case, the
+driver must be prepared to cope with the invocation of its system-wide resume
+callbacks back-to-back with its ``->runtime_suspend`` one (without the
+intervening ``->runtime_resume`` and system-wide suspend callbacks) and the
+final state of the device must reflect the "active" runtime PM status in that
+case.  [Note that this is not a problem at all if the driver's
+``->suspend_late`` callback pointer points to the same function as its
+``->runtime_suspend`` one and its ``->resume_early`` callback pointer points to
+the same function as the ``->runtime_resume`` one, while none of the other
+system-wide suspend-resume callbacks of the driver are present, for example.]
+
+Likewise, if ``DPM_FLAG_MAY_SKIP_RESUME`` is set for a device, its driver's
+system-wide "noirq" and "early" resume callbacks may be skipped while its "late"
+and "noirq" suspend callbacks may have been executed (in principle, regardless
+of whether or not ``DPM_FLAG_SMART_SUSPEND`` is set).  In that case, the driver
+needs to be able to cope with the invocation of its ``->runtime_resume``
+callback back-to-back with its "late" and "noirq" suspend ones.  [For instance,
+that is not a concern if the driver sets both ``DPM_FLAG_SMART_SUSPEND`` and
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
index 35796fc49e7a..121c104a4090 100644
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




