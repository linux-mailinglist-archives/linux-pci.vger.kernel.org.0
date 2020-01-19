Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92566141BE0
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2020 05:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgASECz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Jan 2020 23:02:55 -0500
Received: from mga01.intel.com ([192.55.52.88]:54998 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726936AbgASECy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 18 Jan 2020 23:02:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jan 2020 20:02:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,336,1574150400"; 
   d="scan'208";a="226751891"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by orsmga003.jf.intel.com with ESMTP; 18 Jan 2020 20:02:50 -0800
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH v13 7/8] PCI/DPC: Clear AER registers in EDR mode
Date:   Sat, 18 Jan 2020 20:00:36 -0800
Message-Id: <9766b86c8d88c8dbce6c3d72541b76011a50e15a.1579406227.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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
"DPC Event Handling Implementation Note", page 10, OS is responsible
for clearing the AER registers in EDR mode. So clear AER registers in
dpc_process_error() function.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pci.h      |  1 +
 drivers/pci/pcie/aer.c | 13 +++++++++----
 drivers/pci/pcie/dpc.c |  4 ++++
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index d71b7c07c6d2..d55eb1f0cd7c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -442,6 +442,7 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
 void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
 int pci_aer_clear_err_uncor_status(struct pci_dev *dev);
 void pci_aer_clear_err_fatal_status(struct pci_dev *dev);
+int pci_aer_clear_err_status_regs(struct pci_dev *dev);
 #endif	/* CONFIG_PCIEAER */
 
 #ifdef CONFIG_PCIE_DPC
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 4527c30db4f5..f267f7adbc30 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -431,7 +431,7 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
 	return pci_aer_clear_err_fatal_status(dev);
 }
 
-int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
+int pci_aer_clear_err_status_regs(struct pci_dev *dev)
 {
 	int pos;
 	u32 status;
@@ -444,9 +444,6 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
 	if (!pos)
 		return -EIO;
 
-	if (pcie_aer_get_firmware_first(dev))
-		return -EIO;
-
 	port_type = pci_pcie_type(dev);
 	if (port_type == PCI_EXP_TYPE_ROOT_PORT) {
 		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &status);
@@ -462,6 +459,14 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
 	return 0;
 }
 
+int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
+{
+	if (pcie_aer_get_firmware_first(dev))
+		return -EIO;
+
+	return pci_aer_clear_err_status_regs(dev);
+}
+
 void pci_save_aer_state(struct pci_dev *dev)
 {
 	struct pci_cap_saved_state *save_state;
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 97eb032f9a29..00ed77ea9380 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -284,6 +284,10 @@ static void dpc_process_error(struct dpc_dev *dpc)
 		pci_aer_clear_err_fatal_status(pdev);
 	}
 
+	/* In EDR mode, OS is responsible for clearing AER registers */
+	if (dpc->edr_enabled)
+		pci_aer_clear_err_status_regs(pdev);
+
 	/*
 	 * Irrespective of whether the DPC event is triggered by
 	 * ERR_FATAL or ERR_NONFATAL, since the link is already down,
-- 
2.21.0

