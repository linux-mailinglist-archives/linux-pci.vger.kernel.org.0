Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF5A2D7FD6
	for <lists+linux-pci@lfdr.de>; Fri, 11 Dec 2020 21:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388123AbgLKUSX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Dec 2020 15:18:23 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:48294 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388074AbgLKUST (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Dec 2020 15:18:19 -0500
Received: from 89-77-60-66.dynamic.chello.pl (89.77.60.66) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.530)
 id 2f2b1a0f38d96bcd; Fri, 11 Dec 2020 21:17:36 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PCI <linux-pci@vger.kernel.org>
Cc:     Daniel Scally <djrscally@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH] PCI: ACPI: Fix up ACPI companion lookup for device 0 on the root bus
Date:   Fri, 11 Dec 2020 21:17:35 +0100
Message-ID: <4673285.9aE2nYKHPr@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In some cases acpi_pci_find_companion() returns an incorrect device
object as the ACPI companion for device 0 on the root bus (bus 0).

On the affected systems that device is the PCI interface to the
host bridge and the "ACPI companion" returned for it corresponds
to a non-PCI device located in the SoC (e.g. a sensor on an I2C
bus).  As a result of this, the ACPI device object "attached"
to PCI device 00:00.0 cannot be used for enumerating the device
that is really represented by it which (of course) is problematic.

Address that issue by preventing acpi_pci_find_companion() from
returning a device object with a valid _HID (which by the spec
should not be present uder ACPI device objects corresponding to
PCI devices) for PCI device 00:00.0.

Link: https://lore.kernel.org/linux-acpi/1409ba0c-1580-dc09-e6fe-a0c9bcda6462@gmail.com/
Reported-by: Daniel Scally <djrscally@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci-acpi.c |   20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/pci/pci-acpi.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-acpi.c
+++ linux-pm/drivers/pci/pci-acpi.c
@@ -1162,14 +1162,32 @@ void acpi_pci_remove_bus(struct pci_bus
 static struct acpi_device *acpi_pci_find_companion(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
+	struct acpi_device *adev;
 	bool check_children;
 	u64 addr;
 
 	check_children = pci_is_bridge(pci_dev);
 	/* Please ref to ACPI spec for the syntax of _ADR */
 	addr = (PCI_SLOT(pci_dev->devfn) << 16) | PCI_FUNC(pci_dev->devfn);
-	return acpi_find_child_device(ACPI_COMPANION(dev->parent), addr,
+	adev = acpi_find_child_device(ACPI_COMPANION(dev->parent), addr,
 				      check_children);
+	/*
+	 * There may be ACPI device objects in the ACPI namespace that are
+	 * children of the device object representing the host bridge, but don't
+	 * represent PCI devices.  Both _HID and _ADR may be present for them,
+	 * even though that is against the specification (for example, see
+	 * Section 6.1 of ACPI 6.3), but in many cases the _ADR returns 0 which
+	 * appears to indicate that they should not be taken into consideration
+	 * as potential companions of PCI devices on the root bus.
+	 *
+	 * To catch this special case, disregard the returned device object if
+	 * it has a valid _HID, addr is 0 and the PCI device at hand is on the
+	 * root bus.
+	 */
+	if (adev && adev->pnp.type.platform_id && !addr && !pci_dev->bus->parent)
+		return NULL;
+
+	return adev;
 }
 
 /**



