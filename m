Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70B8E178886
	for <lists+linux-pci@lfdr.de>; Wed,  4 Mar 2020 03:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387505AbgCDCj2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 21:39:28 -0500
Received: from mga07.intel.com ([134.134.136.100]:56584 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387657AbgCDCjL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Mar 2020 21:39:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 18:39:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400"; 
   d="scan'208";a="233866911"
Received: from skuppusw-desk.jf.intel.com ([10.7.201.16])
  by orsmga008.jf.intel.com with ESMTP; 03 Mar 2020 18:39:06 -0800
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v17 08/12] PCI/DPC: Cache DPC capabilities in pci_init_capabilities()
Date:   Tue,  3 Mar 2020 18:36:31 -0800
Message-Id: <6ac4e893e7d1054fe43efed0f89ca02f072c3190.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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
 drivers/pci/probe.c    |  1 +
 3 files changed, 23 insertions(+), 12 deletions(-)

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
index 1ae5d94944eb..ad011d6b22c5 100644
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
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 512cb4312ddd..c6f91f886818 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2329,6 +2329,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_enable_acs(dev);		/* Enable ACS P2P upstream forwarding */
 	pci_ptm_init(dev);		/* Precision Time Measurement */
 	pci_aer_init(dev);		/* Advanced Error Reporting */
+	pci_dpc_init(dev);		/* Downstream Port Containment */
 
 	pcie_report_downtraining(dev);
 
-- 
2.25.1

