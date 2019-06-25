Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 355B854E66
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2019 14:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbfFYMJQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jun 2019 08:09:16 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:43097 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbfFYMJQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jun 2019 08:09:16 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 6e2dd8267a530f68; Tue, 25 Jun 2019 14:09:12 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PCI <linux-pci@vger.kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: [PATCH] PCI: PM/ACPI: Refresh all stale power state data in pci_pm_complete()
Date:   Tue, 25 Jun 2019 14:09:12 +0200
Message-ID: <6435024.1ODgWP2se3@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In pci_pm_complete() there are checks to decide whether or not to
resume devices that were left in runtime-suspend during the preceding
system-wide transition into a sleep state.  They involve checking the
current power state of the device and comparing it with the power
state of it set before the preceding system-wide transition, but the
platform component of the device's power state is not handled
correctly in there.

Namely, on platforms with ACPI, the device power state information
needs to be updated with care, so that the reference counters of
power resources used by the device (if any) are set to ensure that
the refreshed power state of it will be maintained going forward.

To that end, introduce a new ->refresh_state() platform PM callback
for PCI devices, for asking the platform to refresh the device power
state data and ensure that the corresponding power state will be
maintained going forward, make it invoke acpi_device_update_power()
(for devices with ACPI PM) on platforms with ACPI and make
pci_pm_complete() use it, through a new pci_refresh_power_state()
wrapper function.

Fixes: a0d2a959d3da (PCI: Avoid unnecessary resume after direct-complete)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci-acpi.c   |    9 +++++++++
 drivers/pci/pci-driver.c |    9 ++++++++-
 drivers/pci/pci.c        |   21 +++++++++++++++++++++
 drivers/pci/pci.h        |    4 ++++
 4 files changed, 42 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/pci/pci-acpi.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-acpi.c
+++ linux-pm/drivers/pci/pci-acpi.c
@@ -691,6 +691,14 @@ static pci_power_t acpi_pci_get_power_st
 	return state_conv[state];
 }
 
+static void acpi_pci_refresh_power_state(struct pci_dev *dev)
+{
+	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
+
+	if (adev && acpi_device_power_manageable(adev))
+		acpi_device_update_power(adev, NULL);
+}
+
 static int acpi_pci_propagate_wakeup(struct pci_bus *bus, bool enable)
 {
 	while (bus->parent) {
@@ -748,6 +756,7 @@ static const struct pci_platform_pm_ops
 	.is_manageable = acpi_pci_power_manageable,
 	.set_state = acpi_pci_set_power_state,
 	.get_state = acpi_pci_get_power_state,
+	.refresh_state = acpi_pci_refresh_power_state,
 	.choose_state = acpi_pci_choose_state,
 	.set_wakeup = acpi_pci_wakeup,
 	.need_resume = acpi_pci_need_resume,
Index: linux-pm/drivers/pci/pci.h
===================================================================
--- linux-pm.orig/drivers/pci/pci.h
+++ linux-pm/drivers/pci/pci.h
@@ -51,6 +51,8 @@ int pci_bus_error_reset(struct pci_dev *
  *
  * @get_state: queries the platform firmware for a device's current power state
  *
+ * @refresh_state: asks the platform to refresh the device's power state data
+ *
  * @choose_state: returns PCI power state of given device preferred by the
  *		  platform; to be used during system-wide transitions from a
  *		  sleeping state to the working state and vice versa
@@ -69,6 +71,7 @@ struct pci_platform_pm_ops {
 	bool (*is_manageable)(struct pci_dev *dev);
 	int (*set_state)(struct pci_dev *dev, pci_power_t state);
 	pci_power_t (*get_state)(struct pci_dev *dev);
+	void (*refresh_state)(struct pci_dev *dev);
 	pci_power_t (*choose_state)(struct pci_dev *dev);
 	int (*set_wakeup)(struct pci_dev *dev, bool enable);
 	bool (*need_resume)(struct pci_dev *dev);
@@ -76,6 +79,7 @@ struct pci_platform_pm_ops {
 
 int pci_set_platform_pm(const struct pci_platform_pm_ops *ops);
 void pci_update_current_state(struct pci_dev *dev, pci_power_t state);
+void pci_refresh_power_state(struct pci_dev *dev);
 void pci_power_up(struct pci_dev *dev);
 void pci_disable_enabled_device(struct pci_dev *dev);
 int pci_finish_runtime_suspend(struct pci_dev *dev);
Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -777,6 +777,12 @@ static inline pci_power_t platform_pci_g
 	return pci_platform_pm ? pci_platform_pm->get_state(dev) : PCI_UNKNOWN;
 }
 
+static inline void platform_pci_refresh_power_state(struct pci_dev *dev)
+{
+	if (pci_platform_pm && pci_platform_pm->refresh_state)
+		pci_platform_pm->refresh_state(dev);
+}
+
 static inline pci_power_t platform_pci_choose_state(struct pci_dev *dev)
 {
 	return pci_platform_pm ?
@@ -938,6 +944,21 @@ void pci_update_current_state(struct pci
 }
 
 /**
+ * pci_refresh_power_state - Refresh the given device's power state data
+ * @dev: Target PCI device.
+ *
+ * Ask the platform to refresh the devices power state information and invoke
+ * pci_update_current_state() to update its current PCI power state.
+ */
+void pci_refresh_power_state(struct pci_dev *dev)
+{
+	if (platform_pci_power_manageable(dev))
+		platform_pci_refresh_power_state(dev);
+
+	pci_update_current_state(dev, dev->current_state);
+}
+
+/**
  * pci_power_up - Put the given device into D0 forcibly
  * @dev: PCI device to power up
  */
Index: linux-pm/drivers/pci/pci-driver.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-driver.c
+++ linux-pm/drivers/pci/pci-driver.c
@@ -710,7 +710,14 @@ static void pci_pm_complete(struct devic
 	if (pm_runtime_suspended(dev) && pm_resume_via_firmware()) {
 		pci_power_t pre_sleep_state = pci_dev->current_state;
 
-		pci_update_current_state(pci_dev, pci_dev->current_state);
+		pci_refresh_power_state(pci_dev);
+		/*
+		 * On platforms with ACPI this check may also trigger for
+		 * devices sharing power resources if one of those power
+		 * resources has been activated as a result of a change of the
+		 * power state of another device sharing it.  However, in that
+		 * case it is also better to resume the device, in general.
+		 */
 		if (pci_dev->current_state < pre_sleep_state)
 			pm_request_resume(dev);
 	}



