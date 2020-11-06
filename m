Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22BE2A8B46
	for <lists+linux-pci@lfdr.de>; Fri,  6 Nov 2020 01:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732866AbgKFAPQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Nov 2020 19:15:16 -0500
Received: from mga12.intel.com ([192.55.52.136]:23004 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732825AbgKFAPN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Nov 2020 19:15:13 -0500
IronPort-SDR: aHakXGviMzjfxril8FAIIGiRFFY3xlpeJJhQt6lfJGrWFrza5R7nVqoHBboOwNUMOcbT0n71JQ
 KvXuqBPV28Cw==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="148759540"
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; 
   d="scan'208";a="148759540"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 16:15:13 -0800
IronPort-SDR: laLeN+jZV+Rnsy6sGPNfrRbnKtNKHTrvYJXLzeE00RL7Hmikxx5wM7GZWoWA7r/YKg8ZfWoj5x
 Ull9cFiOshbw==
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; 
   d="scan'208";a="529621721"
Received: from gabriels-mobl1.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.209.37.33])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 16:15:12 -0800
From:   Sean V Kelley <sean.v.kelley@intel.com>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        xerces.zhao@gmail.com, rafael.j.wysocki@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@intel.com, qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v10 08/16] PCI/ERR: Use "bridge" for clarity in pcie_do_recovery()
Date:   Thu,  5 Nov 2020 16:14:36 -0800
Message-Id: <20201106001444.667232-9-sean.v.kelley@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201106001444.667232-1-sean.v.kelley@intel.com>
References: <20201106001444.667232-1-sean.v.kelley@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pcie_do_recovery() may be called with "dev" being either a bridge (Root
Port or Switch Downstream Port) or an Endpoint.  The bulk of the function
deals with the bridge, so if we start with an Endpoint, we reset "dev" to
be the bridge leading to it.

For clarity, replace "dev" in the body of the function with "bridge".  No
functional change intended.

[bhelgaas: commit log, split pieces out so this is pure rename, also
replace "dev" with "bridge" in messages and pci_uevent_ers()]
Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20201002184735.1229220-6-seanvk.dev@oregontracks.org
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/pcie/err.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 7a5af873d8bc..46a5b84f8842 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -151,24 +151,27 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 		pci_ers_result_t (*reset_subordinates)(struct pci_dev *pdev))
 {
 	int type = pci_pcie_type(dev);
-	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
+	struct pci_dev *bridge;
 	struct pci_bus *bus;
+	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
 
 	/*
-	 * Error recovery runs on all subordinates of the first downstream port.
-	 * If the downstream port detected the error, it is cleared at the end.
+	 * Error recovery runs on all subordinates of the bridge.  If the
+	 * bridge detected the error, it is cleared at the end.
 	 */
 	if (!(type == PCI_EXP_TYPE_ROOT_PORT ||
 	      type == PCI_EXP_TYPE_DOWNSTREAM))
-		dev = pci_upstream_bridge(dev);
-	bus = dev->subordinate;
+		bridge = pci_upstream_bridge(dev);
+	else
+		bridge = dev;
 
-	pci_dbg(dev, "broadcast error_detected message\n");
+	bus = bridge->subordinate;
+	pci_dbg(bridge, "broadcast error_detected message\n");
 	if (state == pci_channel_io_frozen) {
 		pci_walk_bus(bus, report_frozen_detected, &status);
-		status = reset_subordinates(dev);
+		status = reset_subordinates(bridge);
 		if (status != PCI_ERS_RESULT_RECOVERED) {
-			pci_warn(dev, "subordinate device reset failed\n");
+			pci_warn(bridge, "subordinate device reset failed\n");
 			goto failed;
 		}
 	} else {
@@ -177,7 +180,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 
 	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
 		status = PCI_ERS_RESULT_RECOVERED;
-		pci_dbg(dev, "broadcast mmio_enabled message\n");
+		pci_dbg(bridge, "broadcast mmio_enabled message\n");
 		pci_walk_bus(bus, report_mmio_enabled, &status);
 	}
 
@@ -188,27 +191,27 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 		 * drivers' slot_reset callbacks?
 		 */
 		status = PCI_ERS_RESULT_RECOVERED;
-		pci_dbg(dev, "broadcast slot_reset message\n");
+		pci_dbg(bridge, "broadcast slot_reset message\n");
 		pci_walk_bus(bus, report_slot_reset, &status);
 	}
 
 	if (status != PCI_ERS_RESULT_RECOVERED)
 		goto failed;
 
-	pci_dbg(dev, "broadcast resume message\n");
+	pci_dbg(bridge, "broadcast resume message\n");
 	pci_walk_bus(bus, report_resume, &status);
 
-	if (pcie_aer_is_native(dev))
-		pcie_clear_device_status(dev);
-	pci_aer_clear_nonfatal_status(dev);
-	pci_info(dev, "device recovery successful\n");
+	if (pcie_aer_is_native(bridge))
+		pcie_clear_device_status(bridge);
+	pci_aer_clear_nonfatal_status(bridge);
+	pci_info(bridge, "device recovery successful\n");
 	return status;
 
 failed:
-	pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
+	pci_uevent_ers(bridge, PCI_ERS_RESULT_DISCONNECT);
 
 	/* TODO: Should kernel panic here? */
-	pci_info(dev, "device recovery failed\n");
+	pci_info(bridge, "device recovery failed\n");
 
 	return status;
 }
-- 
2.29.2

