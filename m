Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9072C22CE5E
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jul 2020 21:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgGXTIC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jul 2020 15:08:02 -0400
Received: from mga12.intel.com ([192.55.52.136]:45715 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbgGXTIC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Jul 2020 15:08:02 -0400
IronPort-SDR: GBR8bqbgV9z/+bVnCf3ee0KKf3btc5wPpUf0bCsAOQukn3YOlQVmOfuSIQDLj28blvY4ZJZ8FV
 pMH3jsWiZPyA==
X-IronPort-AV: E=McAfee;i="6000,8403,9692"; a="130328294"
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; 
   d="scan'208";a="130328294"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 12:08:01 -0700
IronPort-SDR: Owy6CufN3MA4RtuWmHr1DJ/EIMsQB/j95gTNub98sZpRdKxfWYj17mSesXnaoj8biylRxpgJ+o
 xE8l2Qu/S5yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; 
   d="scan'208";a="272659690"
Received: from pittner-mobl1.amr.corp.intel.com (HELO localhost.localdomain) ([10.254.77.166])
  by fmsmga008.fm.intel.com with ESMTP; 24 Jul 2020 12:08:00 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        Jay Vosburgh <jay.vosburgh@canonical.com>
Subject: [PATCH v3 1/1] PCI/ERR: Fix reset logic in pcie_do_recovery() call
Date:   Fri, 24 Jul 2020 12:07:55 -0700
Message-Id: <cbba08a5e9ca62778c8937f44eda2192a2045da7.1595617529.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Reply-To: 20200714230803.GA92891@bjorn-Precision-5520
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Current pcie_do_recovery() implementation has following two issues:

1. Fatal (DPC) error recovery is currently broken for non-hotplug
capable devices. Current fatal error recovery implementation relies
on PCIe hotplug (pciehp) handler for detaching and re-enumerating
the affected devices/drivers. pciehp handler listens for DLLSC state
changes and handles device/driver detachment on DLLSC_LINK_DOWN event
and re-enumeration on DLLSC_LINK_UP event. So when dealing with
non-hotplug capable devices, recovery code does not restore the state
of the affected devices correctly. Correct implementation should
restore the device state and call report_slot_reset() function after
resetting the link to restore the state of the device/driver.

You can find fatal non-hotplug related issues reported in following links:

https://lore.kernel.org/linux-pci/20200527083130.4137-1-Zhiqiang.Hou@nxp.com/
https://lore.kernel.org/linux-pci/12115.1588207324@famine/
https://lore.kernel.org/linux-pci/0e6f89cd6b9e4a72293cc90fafe93487d7c2d295.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com/

2. For non-fatal errors if report_error_detected() or
report_mmio_enabled() functions requests PCI_ERS_RESULT_NEED_RESET then
current pcie_do_recovery() implementation does not do the requested
explicit device reset, instead just calls the report_slot_reset() on all
affected devices. Notifying about the reset via report_slot_reset()
without doing the actual device reset is incorrect.

To fix above issues, use PCI_ERS_RESULT_NEED_RESET as error state after
successful reset_link() operation. This will ensure ->slot_reset() be
called after reset_link() operation for fatal errors. Also call
pci_bus_reset() to do slot/bus reset() before triggering device specific
->slot_reset() callback. Also, using pci_bus_reset() will restore the state
of the devices after performing the reset operation.

Even though using pci_bus_reset() will do redundant reset operation after
->reset_link() for fatal errors, it should should affect the functional
behavior.

[original patch is from jay.vosburgh@canonical.com]
[original patch link https://lore.kernel.org/linux-pci/12115.1588207324@famine/]
Fixes: 6d2c89441571 ("PCI/ERR: Update error status after reset_link()")
Signed-off-by: Jay Vosburgh <jay.vosburgh@canonical.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v2:
 * Changed the subject of patch to "PCI/ERR: Fix reset logic in
   pcie_do_recovery() call". v2 patch link is,
   https://lore.kernel.org/linux-pci/ce417fbf81a8a46a89535f44b9224ee9fbb55a29.1591307288.git.sathyanarayanan.kuppuswamy@linux.intel.com/
 * Squashed "PCI/ERR: Add reset support for non fatal errors" patch.

 drivers/pci/pcie/err.c | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 14bb8f54723e..b5eb6ba65be1 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -165,8 +165,29 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	pci_dbg(dev, "broadcast error_detected message\n");
 	if (state == pci_channel_io_frozen) {
 		pci_walk_bus(bus, report_frozen_detected, &status);
+		/*
+		 * After resetting the link using reset_link() call, the
+		 * possible value of error status is either
+		 * PCI_ERS_RESULT_DISCONNECT (failure case) or
+		 * PCI_ERS_RESULT_NEED_RESET (success case).
+		 * So ignore the return value of report_error_detected()
+		 * call for fatal errors.
+		 *
+		 * In EDR mode, since AER and DPC Capabilities are owned by
+		 * firmware, reported_error_detected() will return error
+		 * status PCI_ERS_RESULT_NO_AER_DRIVER. Continuing
+		 * pcie_do_recovery() with error status as
+		 * PCI_ERS_RESULT_NO_AER_DRIVER will report recovery failure
+		 * irrespective of recovery status. But successful reset_link()
+		 * call usually recovers all fatal errors. So ignoring the
+		 * status result of report_error_detected() also helps EDR based
+		 * error recovery.
+		 */
 		status = reset_link(dev);
-		if (status != PCI_ERS_RESULT_RECOVERED) {
+		if (status == PCI_ERS_RESULT_RECOVERED) {
+			status = PCI_ERS_RESULT_NEED_RESET;
+		} else {
+			status = PCI_ERS_RESULT_DISCONNECT;
 			pci_warn(dev, "link reset failed\n");
 			goto failed;
 		}
@@ -182,10 +203,22 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 
 	if (status == PCI_ERS_RESULT_NEED_RESET) {
 		/*
-		 * TODO: Should call platform-specific
-		 * functions to reset slot before calling
-		 * drivers' slot_reset callbacks?
+		 * TODO: Optimize the call to pci_reset_bus()
+		 *
+		 * There are two components to pci_reset_bus().
+		 *
+		 * 1. Do platform specific slot/bus reset.
+		 * 2. Save/Restore all devices in the bus.
+		 *
+		 * For hotplug capable devices and fatal errors,
+		 * device is already in reset state due to link
+		 * reset. So repeating platform specific slot/bus
+		 * reset via pci_reset_bus() call is redundant. So
+		 * can optimize this logic and conditionally call
+		 * pci_reset_bus().
 		 */
+		pci_reset_bus(dev);
+
 		status = PCI_ERS_RESULT_RECOVERED;
 		pci_dbg(dev, "broadcast slot_reset message\n");
 		pci_walk_bus(bus, report_slot_reset, &status);
-- 
2.17.1

