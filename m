Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48A401025FC
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2019 15:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbfKSOJ2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Nov 2019 09:09:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:46540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727763AbfKSOJ2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Nov 2019 09:09:28 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 270002084D;
        Tue, 19 Nov 2019 14:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574172566;
        bh=FM/bjst/yFekG0yKfuQFRL1ctO1Q0YUL6KdL5pMpTpI=;
        h=From:To:Cc:Subject:Date:From;
        b=QsH29e/KeSXLDnVP8R5/iy0uhn4gbbcZC7WJaJ1mZrV1HTYkJJY4NWDGAIqT3zqBn
         mHGjDsVXldWNtaEg0hWJiqw9ri/VrO/W0ejbzi+vPOTI7r9hn09PHghBjldivyPEn1
         yYEH7kKeRXw4OodgEqzBW/UQTsoqj+WAe+PCWSro=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PM / QoS: Wrap documentation to fit in 80 columns
Date:   Tue, 19 Nov 2019 08:09:23 -0600
Message-Id: <20191119140923.175286-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Wrap to 80 columns.  No textual change except to correct some "it's" that
should be "its".

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 Documentation/power/drivers-testing.rst       |  7 ++--
 Documentation/power/freezing-of-tasks.rst     | 37 ++++++++++---------
 Documentation/power/opp.rst                   | 32 ++++++++--------
 Documentation/power/pci.rst                   | 28 +++++++-------
 Documentation/power/pm_qos_interface.rst      | 26 ++++++-------
 Documentation/power/runtime_pm.rst            |  4 +-
 .../power/suspend-and-cpuhotplug.rst          |  7 ++--
 Documentation/power/swsusp.rst                | 14 ++++---
 8 files changed, 81 insertions(+), 74 deletions(-)

diff --git a/Documentation/power/drivers-testing.rst b/Documentation/power/drivers-testing.rst
index e53f1999fc39..d77d2894f9fe 100644
--- a/Documentation/power/drivers-testing.rst
+++ b/Documentation/power/drivers-testing.rst
@@ -39,9 +39,10 @@ c) Compile the driver directly into the kernel and try the test modes of
 d) Attempt to hibernate with the driver compiled directly into the kernel
    in the "reboot", "shutdown" and "platform" modes.
 
-e) Try the test modes of suspend (see: Documentation/power/basic-pm-debugging.rst,
-   2).  [As far as the STR tests are concerned, it should not matter whether or
-   not the driver is built as a module.]
+e) Try the test modes of suspend (see:
+   Documentation/power/basic-pm-debugging.rst, 2).  [As far as the STR tests are
+   concerned, it should not matter whether or not the driver is built as a
+   module.]
 
 f) Attempt to suspend to RAM using the s2ram tool with the driver loaded
    (see: Documentation/power/basic-pm-debugging.rst, 2).
diff --git a/Documentation/power/freezing-of-tasks.rst b/Documentation/power/freezing-of-tasks.rst
index ef110fe55e82..8bd693399834 100644
--- a/Documentation/power/freezing-of-tasks.rst
+++ b/Documentation/power/freezing-of-tasks.rst
@@ -215,30 +215,31 @@ VI. Are there any precautions to be taken to prevent freezing failures?
 
 Yes, there are.
 
-First of all, grabbing the 'system_transition_mutex' lock to mutually exclude a piece of code
-from system-wide sleep such as suspend/hibernation is not encouraged.
-If possible, that piece of code must instead hook onto the suspend/hibernation
-notifiers to achieve mutual exclusion. Look at the CPU-Hotplug code
-(kernel/cpu.c) for an example.
-
-However, if that is not feasible, and grabbing 'system_transition_mutex' is deemed necessary,
-it is strongly discouraged to directly call mutex_[un]lock(&system_transition_mutex) since
-that could lead to freezing failures, because if the suspend/hibernate code
-successfully acquired the 'system_transition_mutex' lock, and hence that other entity failed
-to acquire the lock, then that task would get blocked in TASK_UNINTERRUPTIBLE
-state. As a consequence, the freezer would not be able to freeze that task,
-leading to freezing failure.
+First of all, grabbing the 'system_transition_mutex' lock to mutually exclude a
+piece of code from system-wide sleep such as suspend/hibernation is not
+encouraged.  If possible, that piece of code must instead hook onto the
+suspend/hibernation notifiers to achieve mutual exclusion. Look at the
+CPU-Hotplug code (kernel/cpu.c) for an example.
+
+However, if that is not feasible, and grabbing 'system_transition_mutex' is
+deemed necessary, it is strongly discouraged to directly call
+mutex_[un]lock(&system_transition_mutex) since that could lead to freezing
+failures, because if the suspend/hibernate code successfully acquired the
+'system_transition_mutex' lock, and hence that other entity failed to acquire
+the lock, then that task would get blocked in TASK_UNINTERRUPTIBLE state. As a
+consequence, the freezer would not be able to freeze that task, leading to
+freezing failure.
 
 However, the [un]lock_system_sleep() APIs are safe to use in this scenario,
 since they ask the freezer to skip freezing this task, since it is anyway
-"frozen enough" as it is blocked on 'system_transition_mutex', which will be released
-only after the entire suspend/hibernation sequence is complete.
-So, to summarize, use [un]lock_system_sleep() instead of directly using
+"frozen enough" as it is blocked on 'system_transition_mutex', which will be
+released only after the entire suspend/hibernation sequence is complete.  So, to
+summarize, use [un]lock_system_sleep() instead of directly using
 mutex_[un]lock(&system_transition_mutex). That would prevent freezing failures.
 
 V. Miscellaneous
 ================
 
 /sys/power/pm_freeze_timeout controls how long it will cost at most to freeze
-all user space processes or all freezable kernel threads, in unit of millisecond.
-The default value is 20000, with range of unsigned integer.
+all user space processes or all freezable kernel threads, in unit of
+millisecond.  The default value is 20000, with range of unsigned integer.
diff --git a/Documentation/power/opp.rst b/Documentation/power/opp.rst
index 209c7613f5a4..e3cc4f349ea8 100644
--- a/Documentation/power/opp.rst
+++ b/Documentation/power/opp.rst
@@ -73,19 +73,21 @@ factors. Example usage: Thermal management or other exceptional situations where
 SoC framework might choose to disable a higher frequency OPP to safely continue
 operations until that OPP could be re-enabled if possible.
 
-OPP library facilitates this concept in it's implementation. The following
+OPP library facilitates this concept in its implementation. The following
 operational functions operate only on available opps:
-opp_find_freq_{ceil, floor}, dev_pm_opp_get_voltage, dev_pm_opp_get_freq, dev_pm_opp_get_opp_count
+opp_find_freq_{ceil, floor}, dev_pm_opp_get_voltage, dev_pm_opp_get_freq,
+dev_pm_opp_get_opp_count
 
-dev_pm_opp_find_freq_exact is meant to be used to find the opp pointer which can then
-be used for dev_pm_opp_enable/disable functions to make an opp available as required.
+dev_pm_opp_find_freq_exact is meant to be used to find the opp pointer
+which can then be used for dev_pm_opp_enable/disable functions to make an
+opp available as required.
 
 WARNING: Users of OPP library should refresh their availability count using
-get_opp_count if dev_pm_opp_enable/disable functions are invoked for a device, the
-exact mechanism to trigger these or the notification mechanism to other
-dependent subsystems such as cpufreq are left to the discretion of the SoC
-specific framework which uses the OPP library. Similar care needs to be taken
-care to refresh the cpufreq table in cases of these operations.
+get_opp_count if dev_pm_opp_enable/disable functions are invoked for a
+device, the exact mechanism to trigger these or the notification mechanism
+to other dependent subsystems such as cpufreq are left to the discretion of
+the SoC specific framework which uses the OPP library. Similar care needs
+to be taken care to refresh the cpufreq table in cases of these operations.
 
 2. Initial OPP List Registration
 ================================
@@ -99,11 +101,11 @@ OPPs dynamically using the dev_pm_opp_enable / disable functions.
 dev_pm_opp_add
 	Add a new OPP for a specific domain represented by the device pointer.
 	The OPP is defined using the frequency and voltage. Once added, the OPP
-	is assumed to be available and control of it's availability can be done
-	with the dev_pm_opp_enable/disable functions. OPP library internally stores
-	and manages this information in the opp struct. This function may be
-	used by SoC framework to define a optimal list as per the demands of
-	SoC usage environment.
+	is assumed to be available and control of its availability can be done
+	with the dev_pm_opp_enable/disable functions. OPP library
+	internally stores and manages this information in the opp struct.
+	This function may be used by SoC framework to define a optimal list
+	as per the demands of SoC usage environment.
 
 	WARNING:
 		Do not use this function in interrupt context.
@@ -354,7 +356,7 @@ struct dev_pm_opp
 
 struct device
 	This is used to identify a domain to the OPP layer. The
-	nature of the device and it's implementation is left to the user of
+	nature of the device and its implementation is left to the user of
 	OPP library such as the SoC framework.
 
 Overall, in a simplistic view, the data structure operations is represented as
diff --git a/Documentation/power/pci.rst b/Documentation/power/pci.rst
index 0e2ef7429304..51e0a493d284 100644
--- a/Documentation/power/pci.rst
+++ b/Documentation/power/pci.rst
@@ -426,12 +426,12 @@ pm->runtime_idle() callback.
 2.4. System-Wide Power Transitions
 ----------------------------------
 There are a few different types of system-wide power transitions, described in
-Documentation/driver-api/pm/devices.rst.  Each of them requires devices to be handled
-in a specific way and the PM core executes subsystem-level power management
-callbacks for this purpose.  They are executed in phases such that each phase
-involves executing the same subsystem-level callback for every device belonging
-to the given subsystem before the next phase begins.  These phases always run
-after tasks have been frozen.
+Documentation/driver-api/pm/devices.rst.  Each of them requires devices to be
+handled in a specific way and the PM core executes subsystem-level power
+management callbacks for this purpose.  They are executed in phases such that
+each phase involves executing the same subsystem-level callback for every device
+belonging to the given subsystem before the next phase begins.  These phases
+always run after tasks have been frozen.
 
 2.4.1. System Suspend
 ^^^^^^^^^^^^^^^^^^^^^
@@ -636,12 +636,12 @@ System restore requires a hibernation image to be loaded into memory and the
 pre-hibernation memory contents to be restored before the pre-hibernation system
 activity can be resumed.
 
-As described in Documentation/driver-api/pm/devices.rst, the hibernation image is loaded
-into memory by a fresh instance of the kernel, called the boot kernel, which in
-turn is loaded and run by a boot loader in the usual way.  After the boot kernel
-has loaded the image, it needs to replace its own code and data with the code
-and data of the "hibernated" kernel stored within the image, called the image
-kernel.  For this purpose all devices are frozen just like before creating
+As described in Documentation/driver-api/pm/devices.rst, the hibernation image
+is loaded into memory by a fresh instance of the kernel, called the boot kernel,
+which in turn is loaded and run by a boot loader in the usual way.  After the
+boot kernel has loaded the image, it needs to replace its own code and data with
+the code and data of the "hibernated" kernel stored within the image, called the
+image kernel.  For this purpose all devices are frozen just like before creating
 the image during hibernation, in the
 
 	prepare, freeze, freeze_noirq
@@ -691,8 +691,8 @@ controlling the runtime power management of their devices.
 
 At the time of this writing there are two ways to define power management
 callbacks for a PCI device driver, the recommended one, based on using a
-dev_pm_ops structure described in Documentation/driver-api/pm/devices.rst, and the
-"legacy" one, in which the .suspend(), .suspend_late(), .resume_early(), and
+dev_pm_ops structure described in Documentation/driver-api/pm/devices.rst, and
+the "legacy" one, in which the .suspend(), .suspend_late(), .resume_early(), and
 .resume() callbacks from struct pci_driver are used.  The legacy approach,
 however, doesn't allow one to define runtime power management callbacks and is
 not really suitable for any new drivers.  Therefore it is not covered by this
diff --git a/Documentation/power/pm_qos_interface.rst b/Documentation/power/pm_qos_interface.rst
index 3097694fba69..0d62d506caf0 100644
--- a/Documentation/power/pm_qos_interface.rst
+++ b/Documentation/power/pm_qos_interface.rst
@@ -8,8 +8,8 @@ one of the parameters.
 
 Two different PM QoS frameworks are available:
 1. PM QoS classes for cpu_dma_latency
-2. the per-device PM QoS framework provides the API to manage the per-device latency
-constraints and PM QoS flags.
+2. The per-device PM QoS framework provides the API to manage the
+   per-device latency constraints and PM QoS flags.
 
 Each parameters have defined units:
 
@@ -47,14 +47,14 @@ void pm_qos_add_request(handle, param_class, target_value):
   pm_qos API functions.
 
 void pm_qos_update_request(handle, new_target_value):
-  Will update the list element pointed to by the handle with the new target value
-  and recompute the new aggregated target, calling the notification tree if the
-  target is changed.
+  Will update the list element pointed to by the handle with the new target
+  value and recompute the new aggregated target, calling the notification tree
+  if the target is changed.
 
 void pm_qos_remove_request(handle):
-  Will remove the element.  After removal it will update the aggregate target and
-  call the notification tree if the target was changed as a result of removing
-  the request.
+  Will remove the element.  After removal it will update the aggregate target
+  and call the notification tree if the target was changed as a result of
+  removing the request.
 
 int pm_qos_request(param_class):
   Returns the aggregated value for a given PM QoS class.
@@ -167,9 +167,9 @@ int dev_pm_qos_expose_flags(device, value)
   change the value of the PM_QOS_FLAG_NO_POWER_OFF flag.
 
 void dev_pm_qos_hide_flags(device)
-  Drop the request added by dev_pm_qos_expose_flags() from the device's PM QoS list
-  of flags and remove sysfs attribute pm_qos_no_power_off from the device's power
-  directory.
+  Drop the request added by dev_pm_qos_expose_flags() from the device's PM QoS
+  list of flags and remove sysfs attribute pm_qos_no_power_off from the device's
+  power directory.
 
 Notification mechanisms:
 
@@ -179,8 +179,8 @@ int dev_pm_qos_add_notifier(device, notifier, type):
   Adds a notification callback function for the device for a particular request
   type.
 
-  The callback is called when the aggregated value of the device constraints list
-  is changed.
+  The callback is called when the aggregated value of the device constraints
+  list is changed.
 
 int dev_pm_qos_remove_notifier(device, notifier, type):
   Removes the notification callback function for the device.
diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
index 2c2ec99b5088..ab8406c84254 100644
--- a/Documentation/power/runtime_pm.rst
+++ b/Documentation/power/runtime_pm.rst
@@ -268,8 +268,8 @@ defined in include/linux/pm.h:
   `unsigned int runtime_auto;`
     - if set, indicates that the user space has allowed the device driver to
       power manage the device at run time via the /sys/devices/.../power/control
-      `interface;` it may only be modified with the help of the pm_runtime_allow()
-      and pm_runtime_forbid() helper functions
+      `interface;` it may only be modified with the help of the
+      pm_runtime_allow() and pm_runtime_forbid() helper functions
 
   `unsigned int no_callbacks;`
     - indicates that the device does not use the runtime PM callbacks (see
diff --git a/Documentation/power/suspend-and-cpuhotplug.rst b/Documentation/power/suspend-and-cpuhotplug.rst
index 7ac8e1f549f4..572d968c5375 100644
--- a/Documentation/power/suspend-and-cpuhotplug.rst
+++ b/Documentation/power/suspend-and-cpuhotplug.rst
@@ -106,8 +106,8 @@ execution during resume):
 * Release system_transition_mutex lock.
 
 
-It is to be noted here that the system_transition_mutex lock is acquired at the very
-beginning, when we are just starting out to suspend, and then released only
+It is to be noted here that the system_transition_mutex lock is acquired at the
+very beginning, when we are just starting out to suspend, and then released only
 after the entire cycle is complete (i.e., suspend + resume).
 
 ::
@@ -165,7 +165,8 @@ Important files and functions/entry points:
 
 - kernel/power/process.c : freeze_processes(), thaw_processes()
 - kernel/power/suspend.c : suspend_prepare(), suspend_enter(), suspend_finish()
-- kernel/cpu.c: cpu_[up|down](), _cpu_[up|down](), [disable|enable]_nonboot_cpus()
+- kernel/cpu.c: cpu_[up|down](), _cpu_[up|down](),
+  [disable|enable]_nonboot_cpus()
 
 
 
diff --git a/Documentation/power/swsusp.rst b/Documentation/power/swsusp.rst
index d000312f6965..8524f079e05c 100644
--- a/Documentation/power/swsusp.rst
+++ b/Documentation/power/swsusp.rst
@@ -118,7 +118,8 @@ In a really perfect world::
 
   echo 1 > /proc/acpi/sleep       # for standby
   echo 2 > /proc/acpi/sleep       # for suspend to ram
-  echo 3 > /proc/acpi/sleep       # for suspend to ram, but with more power conservative
+  echo 3 > /proc/acpi/sleep       # for suspend to ram, but with more power
+                                  # conservative
   echo 4 > /proc/acpi/sleep       # for suspend to disk
   echo 5 > /proc/acpi/sleep       # for shutdown unfriendly the system
 
@@ -192,8 +193,8 @@ Q:
 
 A:
   The freezing of tasks is a mechanism by which user space processes and some
-  kernel threads are controlled during hibernation or system-wide suspend (on some
-  architectures).  See freezing-of-tasks.txt for details.
+  kernel threads are controlled during hibernation or system-wide suspend (on
+  some architectures).  See freezing-of-tasks.txt for details.
 
 Q:
   What is the difference between "platform" and "shutdown"?
@@ -282,7 +283,8 @@ A:
       suspend(PMSG_FREEZE): devices are frozen so that they don't interfere
       with state snapshot
 
-      state snapshot: copy of whole used memory is taken with interrupts disabled
+      state snapshot: copy of whole used memory is taken with interrupts
+      disabled
 
       resume(): devices are woken up so that we can write image to swap
 
@@ -353,8 +355,8 @@ Q:
 
 A:
   Generally, yes, you can.  However, it requires you to use the "resume=" and
-  "resume_offset=" kernel command line parameters, so the resume from a swap file
-  cannot be initiated from an initrd or initramfs image.  See
+  "resume_offset=" kernel command line parameters, so the resume from a swap
+  file cannot be initiated from an initrd or initramfs image.  See
   swsusp-and-swap-files.txt for details.
 
 Q:
-- 
2.24.0.432.g9d3f5f5b63-goog

