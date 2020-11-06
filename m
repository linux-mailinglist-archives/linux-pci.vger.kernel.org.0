Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3220C2A8B36
	for <lists+linux-pci@lfdr.de>; Fri,  6 Nov 2020 01:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732878AbgKFAPQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Nov 2020 19:15:16 -0500
Received: from mga12.intel.com ([192.55.52.136]:23004 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732838AbgKFAPP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Nov 2020 19:15:15 -0500
IronPort-SDR: +GZipDq5EWJrus5l72VlAt/W/ZVFDUWH/JPoqdj71QRCgL8YWgLEIZ0AfthztQY7C0ts4r1XQF
 xEyarwv11PGQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="148759544"
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; 
   d="scan'208";a="148759544"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 16:15:15 -0800
IronPort-SDR: p2KjJtDgCbxjbb3V+BB5+oE2L37GT376D59bT1hQBg24bwlXxr4WTi2cutgaysZNpeUMjvkW/q
 nes2UjCZvQGA==
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; 
   d="scan'208";a="529621729"
Received: from gabriels-mobl1.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.209.37.33])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 16:15:14 -0800
From:   Sean V Kelley <sean.v.kelley@intel.com>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        xerces.zhao@gmail.com, rafael.j.wysocki@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@intel.com, qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v10 10/16] PCI/ERR: Add pci_walk_bridge() to pcie_do_recovery()
Date:   Thu,  5 Nov 2020 16:14:38 -0800
Message-Id: <20201106001444.667232-11-sean.v.kelley@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201106001444.667232-1-sean.v.kelley@intel.com>
References: <20201106001444.667232-1-sean.v.kelley@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Consolidate subordinate bus checks with pci_walk_bus() into
pci_walk_bridge() for walking below potentially AER affected bridges.

[bhelgaas: fix kerneldoc]
Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20201002184735.1229220-7-seanvk.dev@oregontracks.org
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/err.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 931e75f2549d..8b53aecdb43d 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -146,13 +146,30 @@ static int report_resume(struct pci_dev *dev, void *data)
 	return 0;
 }
 
+/**
+ * pci_walk_bridge - walk bridges potentially AER affected
+ * @bridge:	bridge which may be a Port
+ * @cb:		callback to be called for each device found
+ * @userdata:	arbitrary pointer to be passed to callback
+ *
+ * If the device provided is a bridge, walk the subordinate bus, including
+ * any bridged devices on buses under this bus.  Call the provided callback
+ * on each device found.
+ */
+static void pci_walk_bridge(struct pci_dev *bridge,
+			    int (*cb)(struct pci_dev *, void *),
+			    void *userdata)
+{
+	if (bridge->subordinate)
+		pci_walk_bus(bridge->subordinate, cb, userdata);
+}
+
 pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 		pci_channel_state_t state,
 		pci_ers_result_t (*reset_subordinates)(struct pci_dev *pdev))
 {
 	int type = pci_pcie_type(dev);
 	struct pci_dev *bridge;
-	struct pci_bus *bus;
 	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
 
 	/*
@@ -165,23 +182,22 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	else
 		bridge = pci_upstream_bridge(dev);
 
-	bus = bridge->subordinate;
 	pci_dbg(bridge, "broadcast error_detected message\n");
 	if (state == pci_channel_io_frozen) {
-		pci_walk_bus(bus, report_frozen_detected, &status);
+		pci_walk_bridge(bridge, report_frozen_detected, &status);
 		status = reset_subordinates(bridge);
 		if (status != PCI_ERS_RESULT_RECOVERED) {
 			pci_warn(bridge, "subordinate device reset failed\n");
 			goto failed;
 		}
 	} else {
-		pci_walk_bus(bus, report_normal_detected, &status);
+		pci_walk_bridge(bridge, report_normal_detected, &status);
 	}
 
 	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
 		status = PCI_ERS_RESULT_RECOVERED;
 		pci_dbg(bridge, "broadcast mmio_enabled message\n");
-		pci_walk_bus(bus, report_mmio_enabled, &status);
+		pci_walk_bridge(bridge, report_mmio_enabled, &status);
 	}
 
 	if (status == PCI_ERS_RESULT_NEED_RESET) {
@@ -192,14 +208,14 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 		 */
 		status = PCI_ERS_RESULT_RECOVERED;
 		pci_dbg(bridge, "broadcast slot_reset message\n");
-		pci_walk_bus(bus, report_slot_reset, &status);
+		pci_walk_bridge(bridge, report_slot_reset, &status);
 	}
 
 	if (status != PCI_ERS_RESULT_RECOVERED)
 		goto failed;
 
 	pci_dbg(bridge, "broadcast resume message\n");
-	pci_walk_bus(bus, report_resume, &status);
+	pci_walk_bridge(bridge, report_resume, &status);
 
 	if (pcie_aer_is_native(bridge))
 		pcie_clear_device_status(bridge);
-- 
2.29.2

