Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF38BECC18
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2019 00:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfKAX7P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Nov 2019 19:59:15 -0400
Received: from mga04.intel.com ([192.55.52.120]:63645 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727269AbfKAX7P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Nov 2019 19:59:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2019 16:59:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,257,1569308400"; 
   d="scan'208";a="199469573"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by fmsmga008.fm.intel.com with ESMTP; 01 Nov 2019 16:59:15 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v10 2/8] PCI/DPC: Allow dpc_probe() even if firmware first mode is enabled
Date:   Fri,  1 Nov 2019 16:56:50 -0700
Message-Id: <c2bb2291887fe321a0b8747992539516ef5b68d9.1572652041.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1572652041.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1572652041.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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
 drivers/pci/pcie/dpc.c | 65 +++++++++++++++++++++++++++++++++---------
 1 file changed, 52 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index a32ec3487a8d..c3e0b05efa4b 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -69,6 +69,14 @@ void pci_save_dpc_state(struct pci_dev *dev)
 	if (!dpc)
 		return;
 
+	/*
+	 * If DPC is controlled by firmware then save/restore tasks are also
+	 * controller by firmware. So skip rest of the function if DPC is
+	 * controlled by firmware.
+	 */
+	if (pcie_aer_get_firmware_first(dev))
+		return;
+
 	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_DPC);
 	if (!save_state)
 		return;
@@ -90,6 +98,14 @@ void pci_restore_dpc_state(struct pci_dev *dev)
 	if (!dpc)
 		return;
 
+	/*
+	 * If DPC is controlled by firmware then save/restore tasks are also
+	 * controller by firmware. So skip rest of the function if DPC is
+	 * controlled by firmware.
+	 */
+	if (pcie_aer_get_firmware_first(dev))
+		return;
+
 	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_DPC);
 	if (!save_state)
 		return;
@@ -291,9 +307,6 @@ static int dpc_probe(struct pcie_device *dev)
 	int status;
 	u16 ctl, cap;
 
-	if (pcie_aer_get_firmware_first(pdev))
-		return -ENOTSUPP;
-
 	dpc = devm_kzalloc(device, sizeof(*dpc), GFP_KERNEL);
 	if (!dpc)
 		return -ENOMEM;
@@ -302,13 +315,32 @@ static int dpc_probe(struct pcie_device *dev)
 	dpc->dev = dev;
 	set_service_data(dev, dpc);
 
-	status = devm_request_threaded_irq(device, dev->irq, dpc_irq,
-					   dpc_handler, IRQF_SHARED,
-					   "pcie-dpc", dpc);
-	if (status) {
-		pci_warn(pdev, "request IRQ%d failed: %d\n", dev->irq,
-			 status);
-		return status;
+	/*
+	 * As per PCIe spec r5.0, implementation note titled "Determination
+	 * of DPC Control", to avoid conflicts over whether platform
+	 * firmware or the operating system have control of DPC, it is
+	 * recommended that platform firmware and operating systems always link
+	 * the control of DPC to the control of Advanced Error Reporting.
+	 *
+	 * So use AER FF mode check API pcie_aer_get_firmware_first() to decide
+	 * whether DPC is controlled by software or firmware.
+	 *
+	 * If DPC is handled in firmware and ACPI support is not enabled
+	 * in OS, skip probe and return error.
+	 */
+	if (pcie_aer_get_firmware_first(pdev) && !IS_ENABLED(CONFIG_ACPI))
+		return -ENODEV;
+
+	/* Register interrupt handler only if OS controls DPC */
+	if (!pcie_aer_get_firmware_first(pdev)) {
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
@@ -323,9 +355,12 @@ static int dpc_probe(struct pcie_device *dev)
 			dpc->rp_log_size = 0;
 		}
 	}
-
-	ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
-	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, ctl);
+	if (!pcie_aer_get_firmware_first(pdev)) {
+		ctl = (ctl & 0xfff4) |
+			(PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN);
+		pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL,
+				      ctl);
+	}
 
 	pci_info(pdev, "error containment capabilities: Int Msg #%d, RPExt%c PoisonedTLP%c SwTrigger%c RP PIO Log %d, DL_ActiveErr%c\n",
 		 cap & PCI_EXP_DPC_IRQ, FLAG(cap, PCI_EXP_DPC_CAP_RP_EXT),
@@ -343,6 +378,10 @@ static void dpc_remove(struct pcie_device *dev)
 	struct pci_dev *pdev = dev->port;
 	u16 ctl;
 
+	/* Skip updating DPC registers if DPC is controlled by firmware */
+	if (pcie_aer_get_firmware_first(pdev))
+		return;
+
 	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, &ctl);
 	ctl &= ~(PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN);
 	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, ctl);
-- 
2.21.0

