Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8118A141BDE
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2020 05:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgASECz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Jan 2020 23:02:55 -0500
Received: from mga04.intel.com ([192.55.52.120]:47571 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726935AbgASECy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 18 Jan 2020 23:02:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jan 2020 20:02:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,336,1574150400"; 
   d="scan'208";a="226751886"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by orsmga003.jf.intel.com with ESMTP; 18 Jan 2020 20:02:50 -0800
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH v13 5/8] PCI/AER: Allow clearing Error Status Register in FF mode
Date:   Sat, 18 Jan 2020 20:00:34 -0800
Message-Id: <5009c7566b454118d4ced51fb74132dd25d31206.1579406227.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1579406227.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1579406227.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

As per PCI firmware specification r3.2 System Firmware Intermediary
(SFI) _OSC and DPC Updates ECR
(https://members.pcisig.com/wg/PCI-SIG/document/13563), sec titled
"DPC Event Handling Implementation Note", page 10, Error Disconnect
Recover (EDR) support allows OS to handle error recovery and clearing
Error Registers even in FF mode. So create new APIs to replace
pci_cleanup_aer_uncorrect_error_status() and
pci_aer_clear_fatal_status() function implementations without FF mode
checks.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pci.h      |  2 ++
 drivers/pci/pcie/aer.c | 28 ++++++++++++++++++++--------
 drivers/pci/pcie/dpc.c |  4 ++--
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a0a53bd05a0b..d71b7c07c6d2 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -440,6 +440,8 @@ struct aer_err_info {
 
 int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
 void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
+int pci_aer_clear_err_uncor_status(struct pci_dev *dev);
+void pci_aer_clear_err_fatal_status(struct pci_dev *dev);
 #endif	/* CONFIG_PCIEAER */
 
 #ifdef CONFIG_PCIE_DPC
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 1ca86f2e0166..4527c30db4f5 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -376,7 +376,7 @@ void pci_aer_clear_device_status(struct pci_dev *dev)
 	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
 }
 
-int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev)
+int pci_aer_clear_err_uncor_status(struct pci_dev *dev)
 {
 	int pos;
 	u32 status, sev;
@@ -385,9 +385,6 @@ int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev)
 	if (!pos)
 		return -EIO;
 
-	if (pcie_aer_get_firmware_first(dev))
-		return -EIO;
-
 	/* Clear status bits for ERR_NONFATAL errors only */
 	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
 	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &sev);
@@ -396,10 +393,19 @@ int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev)
 		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, status);
 
 	return 0;
+
+}
+
+int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev)
+{
+	if (pcie_aer_get_firmware_first(dev))
+		return -EIO;
+
+	return pci_aer_clear_err_uncor_status(dev);
 }
 EXPORT_SYMBOL_GPL(pci_cleanup_aer_uncorrect_error_status);
 
-void pci_aer_clear_fatal_status(struct pci_dev *dev)
+void pci_aer_clear_err_fatal_status(struct pci_dev *dev)
 {
 	int pos;
 	u32 status, sev;
@@ -408,15 +414,21 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
 	if (!pos)
 		return;
 
-	if (pcie_aer_get_firmware_first(dev))
-		return;
-
 	/* Clear status bits for ERR_FATAL errors only */
 	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
 	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &sev);
 	status &= sev;
 	if (status)
 		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, status);
+
+}
+
+void pci_aer_clear_fatal_status(struct pci_dev *dev)
+{
+	if (pcie_aer_get_firmware_first(dev))
+		return;
+
+	return pci_aer_clear_err_fatal_status(dev);
 }
 
 int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 8a8ee374d9b1..bb237af8dac1 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -280,8 +280,8 @@ static void dpc_process_error(struct dpc_dev *dpc)
 		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
 		 aer_get_device_error_info(pdev, &info)) {
 		aer_print_error(pdev, &info);
-		pci_cleanup_aer_uncorrect_error_status(pdev);
-		pci_aer_clear_fatal_status(pdev);
+		pci_aer_clear_err_uncor_status(pdev);
+		pci_aer_clear_err_fatal_status(pdev);
 	}
 
 	/* We configure DPC so it only triggers on ERR_FATAL */
-- 
2.21.0

