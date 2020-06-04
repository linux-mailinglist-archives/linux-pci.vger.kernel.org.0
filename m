Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69171EED7E
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jun 2020 23:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgFDVuP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Jun 2020 17:50:15 -0400
Received: from mga06.intel.com ([134.134.136.31]:51375 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgFDVuP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Jun 2020 17:50:15 -0400
IronPort-SDR: DBlK8pj1cxo0RrOOHWpvq2Qfnl1D/9GhYDKOylZkmRqMAmWq0hR+pJu8n6NfgsIvi77PA9varR
 3hXAtaCfIkBw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2020 14:50:14 -0700
IronPort-SDR: MCi6w5JSEw8vyDAnktvgF7vkZYs5LPaIr3fCB4wKno7h+/t2kAxiq2hIBFJx59pi05zul1/ePh
 684VJvgJzpuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,472,1583222400"; 
   d="scan'208";a="313018614"
Received: from unknown (HELO localhost.localdomain) ([10.254.105.50])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Jun 2020 14:50:13 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        Jay Vosburgh <jay.vosburgh@canonical.com>
Subject: [PATCH v2 1/2] PCI/ERR: Fix fatal error recovery for non-hotplug capable devices
Date:   Thu,  4 Jun 2020 14:50:01 -0700
Message-Id: <ce417fbf81a8a46a89535f44b9224ee9fbb55a29.1591307288.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Fatal (DPC) error recovery is currently broken for non-hotplug
capable devices. With current implementation, after successful
fatal error recovery, non-hotplug capable device state won't be
restored properly. You can find related issues in following links.

https://lkml.org/lkml/2020/5/27/290
https://lore.kernel.org/linux-pci/12115.1588207324@famine/
https://lkml.org/lkml/2020/3/28/328

Current fatal error recovery implementation relies on hotplug handler
for detaching/re-enumerating the affected devices/drivers on DLLSC
state changes. So when dealing with non-hotplug capable devices,
recovery code does not restore the state of the affected devices
correctly. Correct implementation should call report_slot_reset()
function after resetting the link to restore the state of the
device/driver.

So use PCI_ERS_RESULT_NEED_RESET as error status for successful
reset_link() operation and use PCI_ERS_RESULT_DISCONNECT for failure
case. PCI_ERS_RESULT_NEED_RESET error state will ensure slot_reset()
is called after reset link operation which will also fix the above
mentioned issue.

[original patch is from jay.vosburgh@canonical.com]
[original patch link https://lore.kernel.org/linux-pci/12115.1588207324@famine/]
Fixes: 6d2c89441571 ("PCI/ERR: Update error status after reset_link()")
Signed-off-by: Jay Vosburgh <jay.vosburgh@canonical.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pcie/err.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 14bb8f54723e..5fe8561c7185 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -165,8 +165,28 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	pci_dbg(dev, "broadcast error_detected message\n");
 	if (state == pci_channel_io_frozen) {
 		pci_walk_bus(bus, report_frozen_detected, &status);
-		status = reset_link(dev);
-		if (status != PCI_ERS_RESULT_RECOVERED) {
+		/*
+		 * After resetting the link using reset_link() call, the
+		 * possible value of error status is either
+		 * PCI_ERS_RESULT_DISCONNECT (failure case) or
+		 * PCI_ERS_RESULT_NEED_RESET (success case).
+		 * So ignore the return value of report_error_detected()
+		 * call for fatal errors. Instead use
+		 * PCI_ERS_RESULT_NEED_RESET as initial status value.
+		 *
+		 * Ignoring the status return value of report_error_detected()
+		 * call will also help in case of EDR mode based error
+		 * recovery. In EDR mode AER and DPC Capabilities are owned by
+		 * firmware and hence report_error_detected() call will possibly
+		 * return PCI_ERS_RESULT_NO_AER_DRIVER. So if we don't ignore
+		 * the return value of report_error_detected() then
+		 * pcie_do_recovery() would report incorrect status after
+		 * successful recovery. Ignoring PCI_ERS_RESULT_NO_AER_DRIVER
+		 * in non EDR case should not have any functional impact.
+		 */
+		status = PCI_ERS_RESULT_NEED_RESET;
+		if (reset_link(dev) != PCI_ERS_RESULT_RECOVERED) {
+			status = PCI_ERS_RESULT_DISCONNECT;
 			pci_warn(dev, "link reset failed\n");
 			goto failed;
 		}
-- 
2.17.1

