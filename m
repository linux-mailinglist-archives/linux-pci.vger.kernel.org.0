Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA812B6E61
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 20:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbgKQTUo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Nov 2020 14:20:44 -0500
Received: from mga04.intel.com ([192.55.52.120]:31785 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729126AbgKQTUo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Nov 2020 14:20:44 -0500
IronPort-SDR: 9fIbpC3yPWIoSFIoDj2cdsSIXuFWGr1fMBTVcgtRVRhIPO/F8KLS30/0Te4r5LjY+mKV27tZLk
 I1IHiIw9lXBg==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="168417225"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="168417225"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 11:20:43 -0800
IronPort-SDR: ltYwOni9YEYq//KTPbYVW7fAuy3sNtT1577ZHG/raw39ul2ZmQqzTmrjLu7bNxuRC2x3NIHh1m
 ZBuMGvFn/bNw==
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="533931727"
Received: from rojasmor-mobl1.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.255.231.24])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 11:20:43 -0800
From:   Sean V Kelley <sean.v.kelley@intel.com>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        xerces.zhao@gmail.com, rafael.j.wysocki@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@intel.com, qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v11 08/16] PCI/ERR: Use "bridge" for clarity in pcie_do_recovery()
Date:   Tue, 17 Nov 2020 11:19:46 -0800
Message-Id: <20201117191954.1322844-9-sean.v.kelley@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201117191954.1322844-1-sean.v.kelley@intel.com>
References: <20201117191954.1322844-1-sean.v.kelley@intel.com>
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

