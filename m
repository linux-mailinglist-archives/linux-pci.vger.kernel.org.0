Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1307F1E513
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2019 00:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfENWVE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 May 2019 18:21:04 -0400
Received: from mga03.intel.com ([134.134.136.65]:20401 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbfENWVD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 May 2019 18:21:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 May 2019 15:21:02 -0700
X-ExtLoop1: 1
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by fmsmga007.fm.intel.com with ESMTP; 14 May 2019 15:21:02 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v3 2/5] PCI/DPC: Allow dpc_probe() even if DPC is handled in firmware
Date:   Tue, 14 May 2019 15:18:14 -0700
Message-Id: <0713d993b40bed6deac3968c2bba5a5ab3d80a7e.1557870869.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1557870869.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1557870869.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Error Disconnect Recover (EDR) support allows OS to handle the error
recovery even when DPC configuration is handled by firmware. So allow
dpc_probe() to continue even if firmware first mode is enabed. This is
a prepratory patch for adding EDR support.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pcie/dpc.c | 49 +++++++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 7b77754a82de..0c9ce876e450 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -20,6 +20,8 @@ struct dpc_dev {
 	u16			cap_pos;
 	bool			rp_extensions;
 	u8			rp_log_size;
+	/* Set True if DPC is handled in firmware */
+	bool			firmware_dpc;
 };
 
 static const char * const rp_pio_error_string[] = {
@@ -67,6 +69,9 @@ void pci_save_dpc_state(struct pci_dev *dev)
 	if (!dpc)
 		return;
 
+	if (dpc->firmware_dpc)
+		return;
+
 	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_DPC);
 	if (!save_state)
 		return;
@@ -88,6 +93,9 @@ void pci_restore_dpc_state(struct pci_dev *dev)
 	if (!dpc)
 		return;
 
+	if (dpc->firmware_dpc)
+		return;
+
 	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_DPC);
 	if (!save_state)
 		return;
@@ -292,9 +300,6 @@ static int dpc_probe(struct pcie_device *dev)
 	int status;
 	u16 ctl, cap;
 
-	if (pcie_aer_get_firmware_first(pdev))
-		return -ENOTSUPP;
-
 	dpc = devm_kzalloc(device, sizeof(*dpc), GFP_KERNEL);
 	if (!dpc)
 		return -ENOMEM;
@@ -303,13 +308,25 @@ static int dpc_probe(struct pcie_device *dev)
 	dpc->dev = dev;
 	set_service_data(dev, dpc);
 
-	status = devm_request_threaded_irq(device, dev->irq, dpc_irq,
-					   dpc_handler, IRQF_SHARED,
-					   "pcie-dpc", dpc);
-	if (status) {
-		dev_warn(device, "request IRQ%d failed: %d\n", dev->irq,
-			 status);
-		return status;
+	if (pcie_aer_get_firmware_first(pdev))
+		dpc->firmware_dpc = 1;
+
+	/*
+	 * If DPC is handled in firmware and ACPI support is not enabled in OS,
+	 * then its not useful to proceed with probe. So, return error.
+	 */
+	if (dpc->firmware_dpc && !IS_ENABLED(CONFIG_ACPI))
+		return -ENODEV;
+
+	if (!dpc->firmware_dpc) {
+		status = devm_request_threaded_irq(device, dev->irq, dpc_irq,
+						   dpc_handler, IRQF_SHARED,
+						   "pcie-dpc", dpc);
+		if (status) {
+			dev_warn(device, "request IRQ%d failed: %d\n", dev->irq,
+				 status);
+			return status;
+		}
 	}
 
 	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CAP, &cap);
@@ -324,9 +341,12 @@ static int dpc_probe(struct pcie_device *dev)
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
 
 	dev_info(device, "DPC error containment capabilities: Int Msg #%d, RPExt%c PoisonedTLP%c SwTrigger%c RP PIO Log %d, DL_ActiveErr%c\n",
 		cap & PCI_EXP_DPC_IRQ, FLAG(cap, PCI_EXP_DPC_CAP_RP_EXT),
@@ -344,6 +364,9 @@ static void dpc_remove(struct pcie_device *dev)
 	struct pci_dev *pdev = dev->port;
 	u16 ctl;
 
+	if (dpc->firmware_dpc)
+		return;
+
 	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, &ctl);
 	ctl &= ~(PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN);
 	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, ctl);
-- 
2.20.1

