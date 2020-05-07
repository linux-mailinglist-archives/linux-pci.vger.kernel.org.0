Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1421C8086
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 05:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgEGDdI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 May 2020 23:33:08 -0400
Received: from mga06.intel.com ([134.134.136.31]:39002 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbgEGDdI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 May 2020 23:33:08 -0400
IronPort-SDR: u+O5SXq0D1d4fJWDlUkBF7LDa2FoDuSaWGjvk7otAcJE7dehVbK9m3DLCKKe2ovvtkQ4ppDVDN
 Z3mQRouwUD1w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 20:33:07 -0700
IronPort-SDR: LLROTNw6PCNmZ27qFr0GAJ7AKDnxWByT4e3Rr6GTwB3Wk51WQBWovidx+E4jbvLYFQvQt1OPOH
 EpiFc/4YKy+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,361,1583222400"; 
   d="scan'208";a="249967520"
Received: from cchia2-mobl1.amr.corp.intel.com (HELO localhost.localdomain) ([10.255.230.47])
  by fmsmga007.fm.intel.com with ESMTP; 06 May 2020 20:33:06 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     jay.vosburgh@canonical.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v1 1/1] PCI/ERR: Handle fatal error recovery for non-hotplug capable devices
Date:   Wed,  6 May 2020 20:32:59 -0700
Message-Id: <f4bbacd3af453285271c8fc733652969e11b84f8.1588821160.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <18609.1588812972@famine>
References: <18609.1588812972@famine>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

If there are non-hotplug capable devices connected to a given
port, then during the fatal error recovery(triggered by DPC or
AER), after calling reset_link() function, we cannot rely on
hotplug handler to detach and re-enumerate the device drivers
in the affected bus. Instead, we will have to let the error
recovery handler call report_slot_reset() for all devices in
the bus to notify about the reset operation. Although this is
only required for non hot-plug capable devices, doing it for
hotplug capable devices should not affect the functionality.

Along with above issue, this fix also applicable to following
issue.

Commit 6d2c89441571 ("PCI/ERR: Update error status after
reset_link()") added support to store status of reset_link()
call. Although this fixed the error recovery issue observed if
the initial value of error status is PCI_ERS_RESULT_DISCONNECT
or PCI_ERS_RESULT_NO_AER_DRIVER, it also discarded the status
result from report_frozen_detected. This can cause a failure to
recover if _NEED_RESET is returned by report_frozen_detected and
report_slot_reset is not invoked.

Such an event can be induced for testing purposes by reducing the
Max_Payload_Size of a PCIe bridge to less than that of a device
downstream from the bridge, and then initiating I/O through the
device, resulting in oversize transactions.  In the presence of DPC,
this results in a containment event and attempted reset and recovery
via pcie_do_recovery.  After 6d2c89441571 report_slot_reset is not
invoked, and the device does not recover.

[original patch is from jay.vosburgh@canonical.com]
[original patch link https://lore.kernel.org/linux-pci/18609.1588812972@famine/]
Fixes: 6d2c89441571 ("PCI/ERR: Update error status after reset_link()")
Signed-off-by: Jay Vosburgh <jay.vosburgh@canonical.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pcie/err.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 14bb8f54723e..db80e1ecb2dc 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -165,13 +165,24 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	pci_dbg(dev, "broadcast error_detected message\n");
 	if (state == pci_channel_io_frozen) {
 		pci_walk_bus(bus, report_frozen_detected, &status);
-		status = reset_link(dev);
-		if (status != PCI_ERS_RESULT_RECOVERED) {
+		status = PCI_ERS_RESULT_NEED_RESET;
+	} else {
+		pci_walk_bus(bus, report_normal_detected, &status);
+	}
+
+	if (status == PCI_ERS_RESULT_NEED_RESET) {
+		if (reset_link) {
+			if (reset_link(dev) != PCI_ERS_RESULT_RECOVERED)
+				status = PCI_ERS_RESULT_DISCONNECT;
+		} else {
+			if (pci_bus_error_reset(dev))
+				status = PCI_ERS_RESULT_DISCONNECT;
+		}
+
+		if (status == PCI_ERS_RESULT_DISCONNECT) {
 			pci_warn(dev, "link reset failed\n");
 			goto failed;
 		}
-	} else {
-		pci_walk_bus(bus, report_normal_detected, &status);
 	}
 
 	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
-- 
2.17.1

