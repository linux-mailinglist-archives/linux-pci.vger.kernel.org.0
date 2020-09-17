Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3313726E0A8
	for <lists+linux-pci@lfdr.de>; Thu, 17 Sep 2020 18:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgIQQ0M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Sep 2020 12:26:12 -0400
Received: from mga12.intel.com ([192.55.52.136]:44123 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728289AbgIQQ0G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Sep 2020 12:26:06 -0400
IronPort-SDR: /AOfkmkpKzhvQBjjaA0bN0rTqoMj6wPko9jZ2hHa3Upe5ieJnc4kJd8DoQrsUrPRUZPpZI9zEq
 UOkvhCqfh2PA==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="139236833"
X-IronPort-AV: E=Sophos;i="5.77,271,1596524400"; 
   d="scan'208";a="139236833"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 09:25:55 -0700
IronPort-SDR: TilMI6Mp66XxDmfAUrpgFMT4WUskqJ60h7fLIZa+8col0rQbCKWG+/dz9HzWuzjxyfe6UoFc97
 mhE2/6B3ezAg==
X-IronPort-AV: E=Sophos;i="5.77,271,1596524400"; 
   d="scan'208";a="332220094"
Received: from mbair-mobl1.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.254.181.111])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 09:25:55 -0700
From:   Sean V Kelley <sean.v.kelley@intel.com>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rjw@rjwysocki.net, ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v4 07/10] PCI/RCEC: Add RCiEP's linked RCEC to AER/ERR
Date:   Thu, 17 Sep 2020 09:25:45 -0700
Message-Id: <20200917162548.2079894-8-sean.v.kelley@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200917162548.2079894-1-sean.v.kelley@intel.com>
References: <20200917162548.2079894-1-sean.v.kelley@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

When attempting error recovery for an RCiEP associated with an RCEC device,
there needs to be a way to update the Root Error Status, the Uncorrectable
Error Status and the Uncorrectable Error Severity of the parent RCEC.
In some non-native cases in which there is no OS visible device
associated with the RCiEP, there is nothing to act upon as the firmware
is acting before the OS. So add handling for the linked 'rcec' in AER/ERR
while taking into account non-native cases.

Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/pci/pcie/aer.c |  9 +++++----
 drivers/pci/pcie/err.c | 38 ++++++++++++++++++++++++--------------
 2 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 65dff5f3457a..dccdba60b5d9 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1358,17 +1358,18 @@ static int aer_probe(struct pcie_device *dev)
 static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 {
 	int aer = dev->aer_cap;
+	int rc = 0;
 	u32 reg32;
-	int rc;
-
 
 	/* Disable Root's interrupt in response to error messages */
 	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
 	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
 	pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
 
-	rc = pci_bus_error_reset(dev);
-	pci_info(dev, "Root Port link has been reset\n");
+	if (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_EC) {
+		rc = pci_bus_error_reset(dev);
+		pci_info(dev, "Root Port link has been reset\n");
+	}
 
 	/* Clear Root Error Status */
 	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, &reg32);
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 5380ecc41506..a61a2518163a 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -149,7 +149,8 @@ static int report_resume(struct pci_dev *dev, void *data)
 /**
  * pci_bridge_walk - walk bridges potentially AER affected
  * @bridge   bridge which may be an RCEC with associated RCiEPs,
- *           an RCiEP associated with an RCEC, or a Port.
+ *           or a Port.
+ * @dev      an RCiEP lacking an associated RCEC.
  * @cb       callback to be called for each device found
  * @userdata arbitrary pointer to be passed to callback.
  *
@@ -160,13 +161,16 @@ static int report_resume(struct pci_dev *dev, void *data)
  * If the device provided has no subordinate bus, call the provided
  * callback on the device itself.
  */
-static void pci_bridge_walk(struct pci_dev *bridge, int (*cb)(struct pci_dev *, void *),
+static void pci_bridge_walk(struct pci_dev *bridge, struct pci_dev *dev,
+			    int (*cb)(struct pci_dev *, void *),
 			    void *userdata)
 {
-	if (bridge->subordinate)
+	if (bridge && bridge->subordinate)
 		pci_walk_bus(bridge->subordinate, cb, userdata);
-	else
+	else if (bridge)
 		cb(bridge, userdata);
+	else
+		cb(dev, userdata);
 }
 
 static pci_ers_result_t flr_on_rciep(struct pci_dev *dev)
@@ -196,16 +200,24 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	type = pci_pcie_type(dev);
 	if (type == PCI_EXP_TYPE_ROOT_PORT ||
 	    type == PCI_EXP_TYPE_DOWNSTREAM ||
-	    type == PCI_EXP_TYPE_RC_EC ||
-	    type == PCI_EXP_TYPE_RC_END)
+	    type == PCI_EXP_TYPE_RC_EC)
 		bridge = dev;
+	else if (type == PCI_EXP_TYPE_RC_END)
+		bridge = dev->rcec;
 	else
 		bridge = pci_upstream_bridge(dev);
 
 	pci_dbg(dev, "broadcast error_detected message\n");
 	if (state == pci_channel_io_frozen) {
-		pci_bridge_walk(bridge, report_frozen_detected, &status);
+		pci_bridge_walk(bridge, dev, report_frozen_detected, &status);
 		if (type == PCI_EXP_TYPE_RC_END) {
+			/*
+			 * The callback only clears the Root Error Status
+			 * of the RCEC (see aer.c).
+			 */
+			if (bridge)
+				reset_subordinate_devices(bridge);
+
 			status = flr_on_rciep(dev);
 			if (status != PCI_ERS_RESULT_RECOVERED) {
 				pci_warn(dev, "function level reset failed\n");
@@ -219,13 +231,13 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 			}
 		}
 	} else {
-		pci_bridge_walk(bridge, report_normal_detected, &status);
+		pci_bridge_walk(bridge, dev, report_normal_detected, &status);
 	}
 
 	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
 		status = PCI_ERS_RESULT_RECOVERED;
 		pci_dbg(dev, "broadcast mmio_enabled message\n");
-		pci_bridge_walk(bridge, report_mmio_enabled, &status);
+		pci_bridge_walk(bridge, dev, report_mmio_enabled, &status);
 	}
 
 	if (status == PCI_ERS_RESULT_NEED_RESET) {
@@ -236,18 +248,16 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 		 */
 		status = PCI_ERS_RESULT_RECOVERED;
 		pci_dbg(dev, "broadcast slot_reset message\n");
-		pci_bridge_walk(bridge, report_slot_reset, &status);
+		pci_bridge_walk(bridge, dev, report_slot_reset, &status);
 	}
 
 	if (status != PCI_ERS_RESULT_RECOVERED)
 		goto failed;
 
 	pci_dbg(dev, "broadcast resume message\n");
-	pci_bridge_walk(bridge, report_resume, &status);
+	pci_bridge_walk(bridge, dev, report_resume, &status);
 
-	if (type == PCI_EXP_TYPE_ROOT_PORT ||
-	    type == PCI_EXP_TYPE_DOWNSTREAM ||
-	    type == PCI_EXP_TYPE_RC_EC) {
+	if (bridge) {
 		if (pcie_aer_is_native(bridge))
 			pcie_clear_device_status(bridge);
 		pci_aer_clear_nonfatal_status(bridge);
-- 
2.28.0

