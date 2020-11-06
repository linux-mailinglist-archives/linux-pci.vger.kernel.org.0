Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744FB2A8B43
	for <lists+linux-pci@lfdr.de>; Fri,  6 Nov 2020 01:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732882AbgKFAPR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Nov 2020 19:15:17 -0500
Received: from mga12.intel.com ([192.55.52.136]:23032 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732865AbgKFAPQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Nov 2020 19:15:16 -0500
IronPort-SDR: CgIu9HNvOgHH0LY2fBAXQQKG1Rg3GXJdW1WAH61TEWAFdcpFZW1DVltMjv1pYG4WQ2xkF9J0Om
 qcg5jlA66IqA==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="148759547"
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; 
   d="scan'208";a="148759547"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 16:15:16 -0800
IronPort-SDR: p+k7YTXo80MppTwnlAmcE7sD3eQt/JyWyWrIu2RTXtsdBcY1NNkDGnX8VvQqWlJY0yGRZPn4j6
 blic52C9KS2g==
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; 
   d="scan'208";a="529621736"
Received: from gabriels-mobl1.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.209.37.33])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 16:15:15 -0800
From:   Sean V Kelley <sean.v.kelley@intel.com>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        xerces.zhao@gmail.com, rafael.j.wysocki@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@intel.com, qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v10 11/16] PCI/ERR: Limit AER resets in pcie_do_recovery()
Date:   Thu,  5 Nov 2020 16:14:39 -0800
Message-Id: <20201106001444.667232-12-sean.v.kelley@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201106001444.667232-1-sean.v.kelley@intel.com>
References: <20201106001444.667232-1-sean.v.kelley@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In some cases a bridge may not exist as the hardware controlling may be
handled only by firmware and so is not visible to the OS. This scenario is
also possible in future use cases involving non-native use of RCECs by
firmware.

Explicitly apply conditional logic around these resets by limiting them to
Root Ports and Downstream Ports.

Link: https://lore.kernel.org/r/20201002184735.1229220-8-seanvk.dev@oregontracks.org
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/pcie/err.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 8b53aecdb43d..7883c9791562 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -148,13 +148,17 @@ static int report_resume(struct pci_dev *dev, void *data)
 
 /**
  * pci_walk_bridge - walk bridges potentially AER affected
- * @bridge:	bridge which may be a Port
+ * @bridge:	bridge which may be a Port, an RCEC with associated RCiEPs,
+ *		or an RCiEP associated with an RCEC
  * @cb:		callback to be called for each device found
  * @userdata:	arbitrary pointer to be passed to callback
  *
  * If the device provided is a bridge, walk the subordinate bus, including
  * any bridged devices on buses under this bus.  Call the provided callback
  * on each device found.
+ *
+ * If the device provided has no subordinate bus, call the callback on the
+ * device itself.
  */
 static void pci_walk_bridge(struct pci_dev *bridge,
 			    int (*cb)(struct pci_dev *, void *),
@@ -162,6 +166,8 @@ static void pci_walk_bridge(struct pci_dev *bridge,
 {
 	if (bridge->subordinate)
 		pci_walk_bus(bridge->subordinate, cb, userdata);
+	else
+		cb(bridge, userdata);
 }
 
 pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
@@ -174,10 +180,13 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 
 	/*
 	 * Error recovery runs on all subordinates of the bridge.  If the
-	 * bridge detected the error, it is cleared at the end.
+	 * bridge detected the error, it is cleared at the end.  For RCiEPs
+	 * we should reset just the RCiEP itself.
 	 */
 	if (type == PCI_EXP_TYPE_ROOT_PORT ||
-	    type == PCI_EXP_TYPE_DOWNSTREAM)
+	    type == PCI_EXP_TYPE_DOWNSTREAM ||
+	    type == PCI_EXP_TYPE_RC_EC ||
+	    type == PCI_EXP_TYPE_RC_END)
 		bridge = dev;
 	else
 		bridge = pci_upstream_bridge(dev);
@@ -185,6 +194,12 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	pci_dbg(bridge, "broadcast error_detected message\n");
 	if (state == pci_channel_io_frozen) {
 		pci_walk_bridge(bridge, report_frozen_detected, &status);
+		if (type == PCI_EXP_TYPE_RC_END) {
+			pci_warn(dev, "subordinate device reset not possible for RCiEP\n");
+			status = PCI_ERS_RESULT_NONE;
+			goto failed;
+		}
+
 		status = reset_subordinates(bridge);
 		if (status != PCI_ERS_RESULT_RECOVERED) {
 			pci_warn(bridge, "subordinate device reset failed\n");
@@ -217,9 +232,13 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	pci_dbg(bridge, "broadcast resume message\n");
 	pci_walk_bridge(bridge, report_resume, &status);
 
-	if (pcie_aer_is_native(bridge))
-		pcie_clear_device_status(bridge);
-	pci_aer_clear_nonfatal_status(bridge);
+	if (type == PCI_EXP_TYPE_ROOT_PORT ||
+	    type == PCI_EXP_TYPE_DOWNSTREAM ||
+	    type == PCI_EXP_TYPE_RC_EC) {
+		if (pcie_aer_is_native(bridge))
+			pcie_clear_device_status(bridge);
+		pci_aer_clear_nonfatal_status(bridge);
+	}
 	pci_info(bridge, "device recovery successful\n");
 	return status;
 
-- 
2.29.2

