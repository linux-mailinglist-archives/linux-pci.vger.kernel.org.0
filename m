Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4CC2B6E66
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 20:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbgKQTUx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Nov 2020 14:20:53 -0500
Received: from mga04.intel.com ([192.55.52.120]:31805 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729588AbgKQTUu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Nov 2020 14:20:50 -0500
IronPort-SDR: V0XVd9Tv9V1uetcvClpF4bgos67NfIr/QgYPDl2kWb/sAnZS2wLNEPWUmlk8MZKXgvOehPAIrr
 JzmWd+XNcpLw==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="168417255"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="168417255"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 11:20:50 -0800
IronPort-SDR: S32Vh+4TK7sXkh0gEZLMpqgrfzEMntnTcJo1ERdflotDeN+av7kKjqkMwQFnhpzJCNm0Bu1dpz
 ihC6axf9PNnQ==
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="533931759"
Received: from rojasmor-mobl1.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.255.231.24])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 11:20:49 -0800
From:   Sean V Kelley <sean.v.kelley@intel.com>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        xerces.zhao@gmail.com, rafael.j.wysocki@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@intel.com, qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v11 13/16] PCI/RCEC: Add RCiEP's linked RCEC to AER/ERR
Date:   Tue, 17 Nov 2020 11:19:51 -0800
Message-Id: <20201117191954.1322844-14-sean.v.kelley@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201117191954.1322844-1-sean.v.kelley@intel.com>
References: <20201117191954.1322844-1-sean.v.kelley@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

When attempting error recovery for an RCiEP associated with an RCEC device,
there needs to be a way to update the Root Error Status, the Uncorrectable
Error Status and the Uncorrectable Error Severity of the parent RCEC.  In
some non-native cases in which there is no OS-visible device associated
with the RCiEP, there is nothing to act upon as the firmware is acting
before the OS.

Add handling for the linked RCEC in AER/ERR while taking into account
non-native cases.

Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
Link: https://lore.kernel.org/r/20201002184735.1229220-12-seanvk.dev@oregontracks.org
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/pcie/aer.c | 46 +++++++++++++++++++++++++++++++-----------
 drivers/pci/pcie/err.c | 20 +++++++++---------
 2 files changed, 44 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 6fe2d4ef0635..2869212af8b4 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1357,29 +1357,51 @@ static int aer_probe(struct pcie_device *dev)
  */
 static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 {
-	int aer = dev->aer_cap;
+	int type = pci_pcie_type(dev);
+	struct pci_dev *root;
+	int aer = 0;
+	int rc = 0;
 	u32 reg32;
-	int rc;

-	if (pcie_aer_is_native(dev)) {
+	if (type == PCI_EXP_TYPE_RC_END)
+		/*
+		 * The reset should only clear the Root Error Status
+		 * of the RCEC. Only perform this for the
+		 * native case, i.e., an RCEC is present.
+		 */
+		root = dev->rcec;
+	else
+		root = dev;
+
+	if (root)
+		aer = dev->aer_cap;
+
+	if ((aer) && pcie_aer_is_native(dev)) {
 		/* Disable Root's interrupt in response to error messages */
-		pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
+		pci_read_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, &reg32);
 		reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
-		pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
+		pci_write_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, reg32);
 	}

-	rc = pci_bus_error_reset(dev);
-	pci_info(dev, "Root Port link has been reset (%d)\n", rc);
+	if (type == PCI_EXP_TYPE_RC_EC || type == PCI_EXP_TYPE_RC_END) {
+		if (pcie_has_flr(dev)) {
+			rc = pcie_flr(dev);
+			pci_info(dev, "has been reset (%d)\n", rc);
+		}
+	} else {
+		rc = pci_bus_error_reset(dev);
+		pci_info(dev, "Root Port link has been reset (%d)\n", rc);
+	}

-	if (pcie_aer_is_native(dev)) {
+	if ((aer) && pcie_aer_is_native(dev)) {
 		/* Clear Root Error Status */
-		pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, &reg32);
-		pci_write_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, reg32);
+		pci_read_config_dword(root, aer + PCI_ERR_ROOT_STATUS, &reg32);
+		pci_write_config_dword(root, aer + PCI_ERR_ROOT_STATUS, reg32);

 		/* Enable Root Port's interrupt in response to error messages */
-		pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
+		pci_read_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, &reg32);
 		reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
-		pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
+		pci_write_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, reg32);
 	}

 	return rc ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 7883c9791562..cbc5abfe767b 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -148,10 +148,10 @@ static int report_resume(struct pci_dev *dev, void *data)

 /**
  * pci_walk_bridge - walk bridges potentially AER affected
- * @bridge:	bridge which may be a Port, an RCEC with associated RCiEPs,
- *		or an RCiEP associated with an RCEC
- * @cb:		callback to be called for each device found
- * @userdata:	arbitrary pointer to be passed to callback
+ * @bridge   bridge which may be an RCEC with associated RCiEPs,
+ *           or a Port.
+ * @cb       callback to be called for each device found
+ * @userdata arbitrary pointer to be passed to callback.
  *
  * If the device provided is a bridge, walk the subordinate bus, including
  * any bridged devices on buses under this bus.  Call the provided callback
@@ -164,8 +164,14 @@ static void pci_walk_bridge(struct pci_dev *bridge,
 			    int (*cb)(struct pci_dev *, void *),
 			    void *userdata)
 {
+	/*
+	 * In a non-native case where there is no OS-visible reporting
+	 * device the bridge will be NULL, i.e., no RCEC, no Downstream Port.
+	 */
 	if (bridge->subordinate)
 		pci_walk_bus(bridge->subordinate, cb, userdata);
+	else if (bridge->rcec)
+		cb(bridge->rcec, userdata);
 	else
 		cb(bridge, userdata);
 }
@@ -194,12 +200,6 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	pci_dbg(bridge, "broadcast error_detected message\n");
 	if (state == pci_channel_io_frozen) {
 		pci_walk_bridge(bridge, report_frozen_detected, &status);
-		if (type == PCI_EXP_TYPE_RC_END) {
-			pci_warn(dev, "subordinate device reset not possible for RCiEP\n");
-			status = PCI_ERS_RESULT_NONE;
-			goto failed;
-		}
-
 		status = reset_subordinates(bridge);
 		if (status != PCI_ERS_RESULT_RECOVERED) {
 			pci_warn(bridge, "subordinate device reset failed\n");
--
2.29.2

