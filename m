Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF37CB26A
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2019 01:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732102AbfJCXl7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Oct 2019 19:41:59 -0400
Received: from mga11.intel.com ([192.55.52.93]:39187 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731730AbfJCXlh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Oct 2019 19:41:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 16:41:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,254,1566889200"; 
   d="scan'208";a="343819276"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by orsmga004.jf.intel.com with ESMTP; 03 Oct 2019 16:41:35 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v9 2/8] PCI/DPC: Allow dpc_probe() even if firmware first mode is enabled
Date:   Thu,  3 Oct 2019 16:38:58 -0700
Message-Id: <a2fb1e5296857078ae066177d04a15320e19c922.1570145778.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1570145778.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1570145778.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

As per ACPI specification v6.3, sec 5.6.6, Error Disconnect Recover
(EDR) notification used by firmware to let OS know about the DPC event
and permit OS to perform error recovery when processing the EDR
notification. Also, as per PCI firmware specification r3.2 Downstream
Port Containment Related Enhancements ECN, sec 4.5.1, table 4-6, if DPC
is controlled by firmware (firmware first mode), it's responsible for
initializing Downstream Port Containment Extended Capability Structures
per firmware policy. And, OS is permitted to read or write DPC Control
and Status registers of a port while processing an Error Disconnect
Recover (EDR) notification from firmware on that port.

Currently, if firmware controls DPC (firmware first mode), OS will not
create/enumerate DPC PCIe port services. But, if OS supports EDR
feature, then as mentioned in above spec references, it should permit
enumeration of DPC driver and also support handling ACPI EDR
notification. So as first step, allow dpc_probe() to continue even if
firmware first mode is enabled. Also add appropriate checks to ensure
device registers are not modified outside EDR notification window in
firmware first mode. This is a preparatory patch for adding EDR support.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/dpc.c | 49 +++++++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index a32ec3487a8d..9717fda012f8 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -22,6 +22,8 @@ struct dpc_dev {
 	u16			cap_pos;
 	bool			rp_extensions;
 	u8			rp_log_size;
+	/* Set True if DPC is controlled by firmware */
+	bool			firmware_dpc;
 };
 
 static const char * const rp_pio_error_string[] = {
@@ -69,6 +71,9 @@ void pci_save_dpc_state(struct pci_dev *dev)
 	if (!dpc)
 		return;
 
+	if (dpc->firmware_dpc)
+		return;
+
 	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_DPC);
 	if (!save_state)
 		return;
@@ -90,6 +95,9 @@ void pci_restore_dpc_state(struct pci_dev *dev)
 	if (!dpc)
 		return;
 
+	if (dpc->firmware_dpc)
+		return;
+
 	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_DPC);
 	if (!save_state)
 		return;
@@ -291,9 +299,6 @@ static int dpc_probe(struct pcie_device *dev)
 	int status;
 	u16 ctl, cap;
 
-	if (pcie_aer_get_firmware_first(pdev))
-		return -ENOTSUPP;
-
 	dpc = devm_kzalloc(device, sizeof(*dpc), GFP_KERNEL);
 	if (!dpc)
 		return -ENOMEM;
@@ -302,13 +307,25 @@ static int dpc_probe(struct pcie_device *dev)
 	dpc->dev = dev;
 	set_service_data(dev, dpc);
 
-	status = devm_request_threaded_irq(device, dev->irq, dpc_irq,
-					   dpc_handler, IRQF_SHARED,
-					   "pcie-dpc", dpc);
-	if (status) {
-		pci_warn(pdev, "request IRQ%d failed: %d\n", dev->irq,
-			 status);
-		return status;
+	if (pcie_aer_get_firmware_first(pdev))
+		dpc->firmware_dpc = 1;
+
+	/*
+	 * If DPC is handled in firmware and ACPI support is not enabled
+	 * in OS, skip probe and return error.
+	 */
+	if (dpc->firmware_dpc && !IS_ENABLED(CONFIG_ACPI))
+		return -ENODEV;
+
+	if (!dpc->firmware_dpc) {
+		status = devm_request_threaded_irq(device, dev->irq, dpc_irq,
+						   dpc_handler, IRQF_SHARED,
+						   "pcie-dpc", dpc);
+		if (status) {
+			pci_warn(pdev, "request IRQ%d failed: %d\n", dev->irq,
+				 status);
+			return status;
+		}
 	}
 
 	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CAP, &cap);
@@ -323,9 +340,12 @@ static int dpc_probe(struct pcie_device *dev)
 			dpc->rp_log_size = 0;
 		}
 	}
-
-	ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
-	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, ctl);
+	if (!dpc->firmware_dpc) {
+		ctl = (ctl & 0xfff4) |
+			(PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN);
+		pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL,
+				      ctl);
+	}
 
 	pci_info(pdev, "error containment capabilities: Int Msg #%d, RPExt%c PoisonedTLP%c SwTrigger%c RP PIO Log %d, DL_ActiveErr%c\n",
 		 cap & PCI_EXP_DPC_IRQ, FLAG(cap, PCI_EXP_DPC_CAP_RP_EXT),
@@ -343,6 +363,9 @@ static void dpc_remove(struct pcie_device *dev)
 	struct pci_dev *pdev = dev->port;
 	u16 ctl;
 
+	if (dpc->firmware_dpc)
+		return;
+
 	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, &ctl);
 	ctl &= ~(PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN);
 	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, ctl);
-- 
2.21.0

