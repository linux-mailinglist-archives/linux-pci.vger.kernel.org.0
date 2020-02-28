Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDC64172DDD
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2020 02:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbgB1BCq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Feb 2020 20:02:46 -0500
Received: from mga14.intel.com ([192.55.52.115]:40111 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730538AbgB1BCp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Feb 2020 20:02:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 17:02:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,493,1574150400"; 
   d="scan'208";a="317977008"
Received: from skuppusw-desk.jf.intel.com ([10.7.201.16])
  by orsmga001.jf.intel.com with ESMTP; 27 Feb 2020 17:02:42 -0800
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v16 5/9] PCI/DPC: Cache DPC capabilities in pci_init_capabilities()
Date:   Thu, 27 Feb 2020 16:59:47 -0800
Message-Id: <a3a634b6c6012773e9e668c2110e13a5bd196bb8.1582850766.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1582850766.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1582850766.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Since we need to re-use DPC error handling routines in Error Disconnect
Recover (EDR) driver, move the initalization and caching of DPC
capabilities to pci_init_capabilities().

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pci.h      |  2 ++
 drivers/pci/pcie/dpc.c | 32 ++++++++++++++++++++------------
 2 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index c2c35f152cde..e57e78b619f8 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -448,9 +448,11 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
 #ifdef CONFIG_PCIE_DPC
 void pci_save_dpc_state(struct pci_dev *dev);
 void pci_restore_dpc_state(struct pci_dev *dev);
+void pci_dpc_init(struct pci_dev *pdev);
 #else
 static inline void pci_save_dpc_state(struct pci_dev *dev) {}
 static inline void pci_restore_dpc_state(struct pci_dev *dev) {}
+static inline void pci_dpc_init(struct pci_dev *pdev) {}
 #endif
 
 #ifdef CONFIG_PCI_ATS
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 114358d62ddf..57e7f94b98cf 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -249,6 +249,26 @@ static irqreturn_t dpc_irq(int irq, void *context)
 	return IRQ_HANDLED;
 }
 
+void pci_dpc_init(struct pci_dev *pdev)
+{
+	u16 cap;
+
+	pdev->dpc_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DPC);
+	if (!pdev->dpc_cap)
+		return;
+
+	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CAP, &cap);
+	pdev->dpc_rp_extensions = (cap & PCI_EXP_DPC_CAP_RP_EXT) ? 1 : 0;
+	if (pdev->dpc_rp_extensions) {
+		pdev->dpc_rp_log_size = (cap & PCI_EXP_DPC_RP_PIO_LOG_SIZE) >> 8;
+		if (pdev->dpc_rp_log_size < 4 || pdev->dpc_rp_log_size > 9) {
+			pci_err(pdev, "RP PIO log size %u is invalid\n",
+				pdev->dpc_rp_log_size);
+			pdev->dpc_rp_log_size = 0;
+		}
+	}
+}
+
 #define FLAG(x, y) (((x) & (y)) ? '+' : '-')
 static int dpc_probe(struct pcie_device *dev)
 {
@@ -260,8 +280,6 @@ static int dpc_probe(struct pcie_device *dev)
 	if (pcie_aer_get_firmware_first(pdev) && !pcie_ports_dpc_native)
 		return -ENOTSUPP;
 
-	pdev->dpc_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DPC);
-
 	status = devm_request_threaded_irq(device, dev->irq, dpc_irq,
 					   dpc_handler, IRQF_SHARED,
 					   "pcie-dpc", pdev);
@@ -274,16 +292,6 @@ static int dpc_probe(struct pcie_device *dev)
 	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CAP, &cap);
 	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
 
-	pdev->dpc_rp_extensions = (cap & PCI_EXP_DPC_CAP_RP_EXT) ? 1 : 0;
-	if (pdev->dpc_rp_extensions) {
-		pdev->dpc_rp_log_size = (cap & PCI_EXP_DPC_RP_PIO_LOG_SIZE) >> 8;
-		if (pdev->dpc_rp_log_size < 4 || pdev->dpc_rp_log_size > 9) {
-			pci_err(pdev, "RP PIO log size %u is invalid\n",
-				pdev->dpc_rp_log_size);
-			pdev->dpc_rp_log_size = 0;
-		}
-	}
-
 	ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
 	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);
 
-- 
2.21.0

