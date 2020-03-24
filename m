Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0B71902E6
	for <lists+linux-pci@lfdr.de>; Tue, 24 Mar 2020 01:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbgCXA0i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Mar 2020 20:26:38 -0400
Received: from mga14.intel.com ([192.55.52.115]:60461 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727729AbgCXA0Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Mar 2020 20:26:25 -0400
IronPort-SDR: tBJs3oVt9C9mcgKpTHM5q4jkyfy00v9q6DYnegjJRUTP/r4ys4r6HY4/ilDMdHUU2hTR8b7n8n
 x1ekYK2fMStA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 17:26:25 -0700
IronPort-SDR: SP/1jlarBGzBmhn75XRTjEb4S/t+l28ROOFK2KwQ6gPuEY6iRHk7M6tnLK3jqkrBRZ5qqDYR+Q
 GAQvlNKxOgdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,298,1580803200"; 
   d="scan'208";a="419692248"
Received: from bhaveshm-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.134.88.197])
  by orsmga005.jf.intel.com with ESMTP; 23 Mar 2020 17:26:24 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v18 07/11] PCI/DPC: Cache DPC capabilities in pci_init_capabilities()
Date:   Mon, 23 Mar 2020 17:26:04 -0700
Message-Id: <5888380657c8b9551675b5dbd48e370e4fd2703d.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Since Error Disconnect Recover needs to use DPC error handling routines
even if the OS doesn't have control of DPC, move the initalization and
caching of DPC capabilities from the DPC driver to pci_init_capabilities().

Link: https://lore.kernel.org/r/6ac4e893e7d1054fe43efed0f89ca02f072c3190.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.h      |  2 ++
 drivers/pci/pcie/dpc.c | 33 +++++++++++++++++++++------------
 drivers/pci/probe.c    |  1 +
 3 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index efbe94096050..e48677a0ba42 100644
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
index 0c45133a9a91..5870a0f154fc 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -257,6 +257,27 @@ static irqreturn_t dpc_irq(int irq, void *context)
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
+	if (!(cap & PCI_EXP_DPC_CAP_RP_EXT))
+		return;
+
+	pdev->dpc_rp_extensions = true;
+	pdev->dpc_rp_log_size = (cap & PCI_EXP_DPC_RP_PIO_LOG_SIZE) >> 8;
+	if (pdev->dpc_rp_log_size < 4 || pdev->dpc_rp_log_size > 9) {
+		pci_err(pdev, "RP PIO log size %u is invalid\n",
+			pdev->dpc_rp_log_size);
+		pdev->dpc_rp_log_size = 0;
+	}
+}
+
 #define FLAG(x, y) (((x) & (y)) ? '+' : '-')
 static int dpc_probe(struct pcie_device *dev)
 {
@@ -268,8 +289,6 @@ static int dpc_probe(struct pcie_device *dev)
 	if (pcie_aer_get_firmware_first(pdev) && !pcie_ports_dpc_native)
 		return -ENOTSUPP;
 
-	pdev->dpc_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DPC);
-
 	status = devm_request_threaded_irq(device, dev->irq, dpc_irq,
 					   dpc_handler, IRQF_SHARED,
 					   "pcie-dpc", pdev);
@@ -282,16 +301,6 @@ static int dpc_probe(struct pcie_device *dev)
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
2.17.1

