Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC47A1902D7
	for <lists+linux-pci@lfdr.de>; Tue, 24 Mar 2020 01:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbgCXA0X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Mar 2020 20:26:23 -0400
Received: from mga14.intel.com ([192.55.52.115]:60458 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727605AbgCXA0X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Mar 2020 20:26:23 -0400
IronPort-SDR: 5p7/aQPyv8DcNy14PPd8Bok5r0jXeifjyoGuDVui+Jyrnp7wL3w1jLAuy6pyILcdABx6WDf6Al
 KmwYai6gcnNg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 17:26:22 -0700
IronPort-SDR: v5iQVrGEanq7iw09uaOABcG02EegWGFdhAJNllLZcwAQsEnG24EAybuJC5PLB9CM3CYsoaSh31
 xzmvaT+702yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,298,1580803200"; 
   d="scan'208";a="419692232"
Received: from bhaveshm-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.134.88.197])
  by orsmga005.jf.intel.com with ESMTP; 23 Mar 2020 17:26:21 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v18 03/11] PCI/DPC: Fix DPC recovery issue in non hotplug case
Date:   Mon, 23 Mar 2020 17:26:00 -0700
Message-Id: <0e6f89cd6b9e4a72293cc90fafe93487d7c2d295.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

If hotplug is supported, during DPC event, hotplug
driver would remove the affected devices and detach
the drivers on DLLSC link down event and will
re-enumerate it once the DPC recovery is handled
and link comes back online (on DLLSC LINK up event).
Hence we don't depend on .mmio_enabled or .slot_reset
callbacks in error recovery handler to restore the
device.

But if hotplug is not supported/enabled, then we need
to let the error recovery handler attempt
the recovery of the devices using slot reset.

So if hotplug is not supported, then instead of
returning PCI_ERS_RESULT_RECOVERED, return
PCI_ERS_RESULT_NEED_RESET.

Also modify the way error recovery handler processes
the recovery value.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pcie/dpc.c | 8 ++++++++
 drivers/pci/pcie/err.c | 5 +++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index e06f42f58d3d..0e356ed0d73f 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -13,6 +13,7 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/pci.h>
+#include <linux/pci_hotplug.h>
 
 #include "portdrv.h"
 #include "../pci.h"
@@ -144,6 +145,13 @@ static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
 	if (!pcie_wait_for_link(pdev, true))
 		return PCI_ERS_RESULT_DISCONNECT;
 
+	/*
+	 * If hotplug is not supported/enabled then let the device
+	 * recover using slot reset.
+	 */
+	if (!hotplug_is_native(pdev))
+		return PCI_ERS_RESULT_NEED_RESET;
+
 	return PCI_ERS_RESULT_RECOVERED;
 }
 
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 1ac57e9e1e71..6e52591a4722 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -178,7 +178,8 @@ static pci_ers_result_t reset_link(struct pci_dev *dev, u32 service)
 		return PCI_ERS_RESULT_DISCONNECT;
 	}
 
-	if (status != PCI_ERS_RESULT_RECOVERED) {
+	if ((status != PCI_ERS_RESULT_RECOVERED) &&
+	    (status != PCI_ERS_RESULT_NEED_RESET)) {
 		pci_printk(KERN_DEBUG, dev, "link reset at upstream device %s failed\n",
 			pci_name(dev));
 		return PCI_ERS_RESULT_DISCONNECT;
@@ -206,7 +207,7 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
 	if (state == pci_channel_io_frozen) {
 		pci_walk_bus(bus, report_frozen_detected, &status);
 		status = reset_link(dev, service);
-		if (status != PCI_ERS_RESULT_RECOVERED)
+		if (status == PCI_ERS_RESULT_DISCONNECT)
 			goto failed;
 	} else {
 		pci_walk_bus(bus, report_normal_detected, &status);
-- 
2.17.1

