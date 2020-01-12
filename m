Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAD8C138887
	for <lists+linux-pci@lfdr.de>; Sun, 12 Jan 2020 23:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387495AbgALWqI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 Jan 2020 17:46:08 -0500
Received: from mga18.intel.com ([134.134.136.126]:34749 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387488AbgALWqI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 12 Jan 2020 17:46:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jan 2020 14:46:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,426,1571727600"; 
   d="scan'208";a="396989493"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by orsmga005.jf.intel.com with ESMTP; 12 Jan 2020 14:46:05 -0800
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH v12 5/8] PCI/AER: Allow clearing Error Status Register in FF mode
Date:   Sun, 12 Jan 2020 14:43:59 -0800
Message-Id: <e4fa9c6253fd2bfc49746f98e4024fb4980c8936.1578682741.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1578682741.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1578682741.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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
Error Registers even in FF mode. So create exception for FF mode checks
in pci_cleanup_aer_uncorrect_error_status(), pci_aer_clear_fatal_status()
and pci_cleanup_aer_error_status_regs() functions when its being called
from DPC code path.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Keith Busch <keith.busch@intel.com>
---
 Documentation/PCI/pcieaer-howto.rst       |  2 +-
 drivers/net/ethernet/intel/ice/ice_main.c |  2 +-
 drivers/ntb/hw/idt/ntb_hw_idt.c           |  2 +-
 drivers/pci/pci.c                         |  2 +-
 drivers/pci/pci.h                         |  2 +-
 drivers/pci/pcie/aer.c                    | 16 ++++++++--------
 drivers/pci/pcie/dpc.c                    |  4 ++--
 drivers/pci/pcie/err.c                    |  2 +-
 drivers/scsi/lpfc/lpfc_attr.c             |  2 +-
 include/linux/aer.h                       | 12 ++++++++----
 10 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
index 18bdefaafd1a..184c966b61cb 100644
--- a/Documentation/PCI/pcieaer-howto.rst
+++ b/Documentation/PCI/pcieaer-howto.rst
@@ -243,7 +243,7 @@ messages to root port when an error is detected.
 
 ::
 
-  int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev);`
+  int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev, bool ff_check);
 
 pci_cleanup_aer_uncorrect_error_status cleanups the uncorrectable
 error status register.
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 69bff085acf7..8378dbf3500b 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3491,7 +3491,7 @@ static pci_ers_result_t ice_pci_err_slot_reset(struct pci_dev *pdev)
 			result = PCI_ERS_RESULT_DISCONNECT;
 	}
 
-	err = pci_cleanup_aer_uncorrect_error_status(pdev);
+	err = pci_cleanup_aer_uncorrect_error_status(pdev, 1);
 	if (err)
 		dev_dbg(&pdev->dev,
 			"pci_cleanup_aer_uncorrect_error_status failed, error %d\n",
diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index dcf234680535..9023308be2de 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -2675,7 +2675,7 @@ static int idt_init_pci(struct idt_ntb_dev *ndev)
 	if (ret != 0)
 		dev_warn(&pdev->dev, "PCIe AER capability disabled\n");
 	else /* Cleanup uncorrectable error status before getting to init */
-		pci_cleanup_aer_uncorrect_error_status(pdev);
+		pci_cleanup_aer_uncorrect_error_status(pdev, 1);
 
 	/* First enable the PCI device */
 	ret = pcim_enable_device(pdev);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e87196cc1a7f..6264244d92bf 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1499,7 +1499,7 @@ void pci_restore_state(struct pci_dev *dev)
 	pci_restore_rebar_state(dev);
 	pci_restore_dpc_state(dev);
 
-	pci_cleanup_aer_error_status_regs(dev);
+	pci_cleanup_aer_error_status_regs(dev, 1);
 	pci_restore_aer_state(dev);
 
 	pci_restore_config_space(dev);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a0a53bd05a0b..0b4452f72a9a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -646,7 +646,7 @@ void pci_no_aer(void);
 void pci_aer_init(struct pci_dev *dev);
 void pci_aer_exit(struct pci_dev *dev);
 extern const struct attribute_group aer_stats_attr_group;
-void pci_aer_clear_fatal_status(struct pci_dev *dev);
+void pci_aer_clear_fatal_status(struct pci_dev *dev, bool ff_check);
 void pci_aer_clear_device_status(struct pci_dev *dev);
 #else
 static inline void pci_no_aer(void) { }
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 1ca86f2e0166..c64a91b347d2 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -376,7 +376,7 @@ void pci_aer_clear_device_status(struct pci_dev *dev)
 	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
 }
 
-int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev)
+int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev, bool ff_check)
 {
 	int pos;
 	u32 status, sev;
@@ -385,7 +385,7 @@ int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev)
 	if (!pos)
 		return -EIO;
 
-	if (pcie_aer_get_firmware_first(dev))
+	if (ff_check && pcie_aer_get_firmware_first(dev))
 		return -EIO;
 
 	/* Clear status bits for ERR_NONFATAL errors only */
@@ -399,7 +399,7 @@ int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_cleanup_aer_uncorrect_error_status);
 
-void pci_aer_clear_fatal_status(struct pci_dev *dev)
+void pci_aer_clear_fatal_status(struct pci_dev *dev, bool ff_check)
 {
 	int pos;
 	u32 status, sev;
@@ -408,8 +408,8 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
 	if (!pos)
 		return;
 
-	if (pcie_aer_get_firmware_first(dev))
-		return;
+	if (ff_check && pcie_aer_get_firmware_first(dev))
+		return -EIO;
 
 	/* Clear status bits for ERR_FATAL errors only */
 	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
@@ -419,7 +419,7 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
 		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, status);
 }
 
-int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
+int pci_cleanup_aer_error_status_regs(struct pci_dev *dev, bool ff_check)
 {
 	int pos;
 	u32 status;
@@ -432,7 +432,7 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
 	if (!pos)
 		return -EIO;
 
-	if (pcie_aer_get_firmware_first(dev))
+	if (ff_check && pcie_aer_get_firmware_first(dev))
 		return -EIO;
 
 	port_type = pci_pcie_type(dev);
@@ -515,7 +515,7 @@ void pci_aer_init(struct pci_dev *dev)
 	n = pcie_cap_has_rtctl(dev) ? 5 : 4;
 	pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_ERR, sizeof(u32) * n);
 
-	pci_cleanup_aer_error_status_regs(dev);
+	pci_cleanup_aer_error_status_regs(dev, 1);
 }
 
 void pci_aer_exit(struct pci_dev *dev)
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 63366344acff..5bd72d9343f6 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -280,8 +280,8 @@ static void dpc_process_error(struct dpc_dev *dpc)
 		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
 		 aer_get_device_error_info(pdev, &info)) {
 		aer_print_error(pdev, &info);
-		pci_cleanup_aer_uncorrect_error_status(pdev);
-		pci_aer_clear_fatal_status(pdev);
+		pci_cleanup_aer_uncorrect_error_status(pdev, 0);
+		pci_aer_clear_fatal_status(pdev, 0);
 	}
 
 	/* We configure DPC so it only triggers on ERR_FATAL */
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 71639055511e..366be938bd21 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -234,7 +234,7 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
 	pci_walk_bus(bus, report_resume, &status);
 
 	pci_aer_clear_device_status(dev);
-	pci_cleanup_aer_uncorrect_error_status(dev);
+	pci_cleanup_aer_uncorrect_error_status(dev, 1);
 	pci_info(dev, "AER: Device recovery successful\n");
 	return;
 
diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index 4ff82b36a37a..5b37efd29e20 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -4810,7 +4810,7 @@ lpfc_aer_cleanup_state(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 
 	if (phba->hba_flag & HBA_AER_ENABLED)
-		rc = pci_cleanup_aer_uncorrect_error_status(phba->pcidev);
+		rc = pci_cleanup_aer_uncorrect_error_status(phba->pcidev, 1);
 
 	if (rc == 0)
 		return strlen(buf);
diff --git a/include/linux/aer.h b/include/linux/aer.h
index fa19e01f418a..f4f49df500ad 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -44,8 +44,10 @@ struct aer_capability_regs {
 /* PCIe port driver needs this function to enable AER */
 int pci_enable_pcie_error_reporting(struct pci_dev *dev);
 int pci_disable_pcie_error_reporting(struct pci_dev *dev);
-int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev);
-int pci_cleanup_aer_error_status_regs(struct pci_dev *dev);
+int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev,
+					   bool ff_check);
+int pci_cleanup_aer_error_status_regs(struct pci_dev *dev,
+				      bool ff_check);
 void pci_save_aer_state(struct pci_dev *dev);
 void pci_restore_aer_state(struct pci_dev *dev);
 #else
@@ -57,11 +59,13 @@ static inline int pci_disable_pcie_error_reporting(struct pci_dev *dev)
 {
 	return -EINVAL;
 }
-static inline int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev)
+static inline int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev,
+							 bool ff_check)
 {
 	return -EINVAL;
 }
-static inline int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
+static inline int pci_cleanup_aer_error_status_regs(struct pci_dev *dev,
+						    bool ff_check)
 {
 	return -EINVAL;
 }
-- 
2.21.0

