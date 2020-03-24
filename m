Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0B331902E5
	for <lists+linux-pci@lfdr.de>; Tue, 24 Mar 2020 01:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgCXA0f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Mar 2020 20:26:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:60461 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727745AbgCXA02 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Mar 2020 20:26:28 -0400
IronPort-SDR: 7EdhRgowJwf6VA4x9ycL7T5U4uNpIiiWYAwv5gIN2TGNwHCFnOXfX2cAOffRXI/QLJFo+ULdnI
 /toLtfBP3Ysw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 17:26:27 -0700
IronPort-SDR: XJaq3o2ani1EpiB0kc6J9V38GRNOcDtRgdUZhVjITlt3Vbdop/SWdwoahbFhI3vtzyKiwmSH1F
 ThOpDawjtUkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,298,1580803200"; 
   d="scan'208";a="419692263"
Received: from bhaveshm-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.134.88.197])
  by orsmga005.jf.intel.com with ESMTP; 23 Mar 2020 17:26:27 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v18 11/11] PCI/AER: Rationalize error status register clearing
Date:   Mon, 23 Mar 2020 17:26:08 -0700
Message-Id: <d1310a75dc3d28f7e8da4e99c45fbd3e60fe238e.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

The AER interfaces to clear error status registers were a confusing mess:

  - pci_cleanup_aer_uncorrect_error_status() cleared non-fatal errors
    from the Uncorrectable Error Status register.

  - pci_aer_clear_fatal_status() cleared fatal errors from the
    Uncorrectable Error Status register.

  - pci_cleanup_aer_error_status_regs() cleared the Root Error Status
    register (for Root Ports), the Uncorrectable Error Status register,
    and the Correctable Error Status register.

Rename them to make them consistent:

  From                                     To
  ---------------------------------------- -------------------------------
  pci_cleanup_aer_uncorrect_error_status() pci_aer_clear_nonfatal_status()
  pci_aer_clear_fatal_status()             pci_aer_clear_fatal_status()
  pci_cleanup_aer_error_status_regs()      pci_aer_clear_status()

Since pci_cleanup_aer_error_status_regs() (renamed to
pci_aer_clear_status()) is only used within drivers/pci/, move the
declaration from <linux/aer.h> to drivers/pci/pci.h.

[bhelgaas: commit log, add renames]
Link: https://lore.kernel.org/r/ca897f459ccb6da6bad81e3893d8daf9e865fac1.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 Documentation/PCI/pcieaer-howto.rst       | 4 ++--
 drivers/net/ethernet/intel/ice/ice_main.c | 4 ++--
 drivers/ntb/hw/idt/ntb_hw_idt.c           | 4 ++--
 drivers/pci/pci.c                         | 2 +-
 drivers/pci/pci.h                         | 2 ++
 drivers/pci/pcie/aer.c                    | 8 ++++----
 drivers/pci/pcie/dpc.c                    | 2 +-
 drivers/pci/pcie/err.c                    | 2 +-
 drivers/scsi/lpfc/lpfc_attr.c             | 4 ++--
 include/linux/aer.h                       | 9 ++-------
 10 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
index afbd8c1c321d..0b36b9ebfa4b 100644
--- a/Documentation/PCI/pcieaer-howto.rst
+++ b/Documentation/PCI/pcieaer-howto.rst
@@ -232,9 +232,9 @@ messages to root port when an error is detected.
 
 ::
 
-  int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev);`
+  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);`
 
-pci_cleanup_aer_uncorrect_error_status cleanups the uncorrectable
+pci_aer_clear_nonfatal_status clears non-fatal errors in the uncorrectable
 error status register.
 
 Frequent Asked Questions
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 5ae671609f98..effca3fa92e0 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3495,10 +3495,10 @@ static pci_ers_result_t ice_pci_err_slot_reset(struct pci_dev *pdev)
 			result = PCI_ERS_RESULT_DISCONNECT;
 	}
 
-	err = pci_cleanup_aer_uncorrect_error_status(pdev);
+	err = pci_aer_clear_nonfatal_status(pdev);
 	if (err)
 		dev_dbg(&pdev->dev,
-			"pci_cleanup_aer_uncorrect_error_status failed, error %d\n",
+			"pci_aer_clear_nonfatal_status() failed, error %d\n",
 			err);
 		/* non-fatal, continue */
 
diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index dcf234680535..edae52384b8a 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -2674,8 +2674,8 @@ static int idt_init_pci(struct idt_ntb_dev *ndev)
 	ret = pci_enable_pcie_error_reporting(pdev);
 	if (ret != 0)
 		dev_warn(&pdev->dev, "PCIe AER capability disabled\n");
-	else /* Cleanup uncorrectable error status before getting to init */
-		pci_cleanup_aer_uncorrect_error_status(pdev);
+	else /* Cleanup nonfatal error status before getting to init */
+		pci_aer_clear_nonfatal_status(pdev);
 
 	/* First enable the PCI device */
 	ret = pcim_enable_device(pdev);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e724341cefff..735d59b27cfd 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1503,7 +1503,7 @@ void pci_restore_state(struct pci_dev *dev)
 	pci_restore_rebar_state(dev);
 	pci_restore_dpc_state(dev);
 
-	pci_cleanup_aer_error_status_regs(dev);
+	pci_aer_clear_status(dev);
 	pci_restore_aer_state(dev);
 
 	pci_restore_config_space(dev);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 25265bf80a83..bd46f23e3db1 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -656,6 +656,7 @@ void pci_aer_exit(struct pci_dev *dev);
 extern const struct attribute_group aer_stats_attr_group;
 void pci_aer_clear_fatal_status(struct pci_dev *dev);
 void pci_aer_clear_device_status(struct pci_dev *dev);
+int pci_aer_clear_status(struct pci_dev *dev);
 int pci_aer_raw_clear_status(struct pci_dev *dev);
 #else
 static inline void pci_no_aer(void) { }
@@ -663,6 +664,7 @@ static inline void pci_aer_init(struct pci_dev *d) { }
 static inline void pci_aer_exit(struct pci_dev *d) { }
 static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
 static inline void pci_aer_clear_device_status(struct pci_dev *dev) { }
+static inline int pci_aer_clear_status(struct pci_dev *dev) { return -EINVAL; }
 static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
 #endif
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index bd9f122165e0..f4274d301235 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -377,7 +377,7 @@ void pci_aer_clear_device_status(struct pci_dev *dev)
 	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
 }
 
-int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev)
+int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 {
 	int pos;
 	u32 status, sev;
@@ -398,7 +398,7 @@ int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(pci_cleanup_aer_uncorrect_error_status);
+EXPORT_SYMBOL_GPL(pci_aer_clear_nonfatal_status);
 
 void pci_aer_clear_fatal_status(struct pci_dev *dev)
 {
@@ -457,7 +457,7 @@ int pci_aer_raw_clear_status(struct pci_dev *dev)
 	return 0;
 }
 
-int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
+int pci_aer_clear_status(struct pci_dev *dev)
 {
 	if (pcie_aer_get_firmware_first(dev))
 		return -EIO;
@@ -530,7 +530,7 @@ void pci_aer_init(struct pci_dev *dev)
 	n = pcie_cap_has_rtctl(dev) ? 5 : 4;
 	pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_ERR, sizeof(u32) * n);
 
-	pci_cleanup_aer_error_status_regs(dev);
+	pci_aer_clear_status(dev);
 }
 
 void pci_aer_exit(struct pci_dev *dev)
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index e9087f5f32ec..338f72f27043 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -229,7 +229,7 @@ void dpc_process_error(struct pci_dev *pdev)
 		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
 		 aer_get_device_error_info(pdev, &info)) {
 		aer_print_error(pdev, &info);
-		pci_cleanup_aer_uncorrect_error_status(pdev);
+		pci_aer_clear_nonfatal_status(pdev);
 		pci_aer_clear_fatal_status(pdev);
 	}
 }
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 7881de20af29..bb25006fb721 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -199,7 +199,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	pci_walk_bus(bus, report_resume, &status);
 
 	pci_aer_clear_device_status(dev);
-	pci_cleanup_aer_uncorrect_error_status(dev);
+	pci_aer_clear_nonfatal_status(dev);
 	pci_info(dev, "device recovery successful\n");
 	return status;
 
diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index 46f56f30f77e..847300de7ff1 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -4783,7 +4783,7 @@ static DEVICE_ATTR_RW(lpfc_aer_support);
  * Description:
  * If the @buf contains 1 and the device currently has the AER support
  * enabled, then invokes the kernel AER helper routine
- * pci_cleanup_aer_uncorrect_error_status to clean up the uncorrectable
+ * pci_aer_clear_nonfatal_status() to clean up the uncorrectable
  * error status register.
  *
  * Notes:
@@ -4809,7 +4809,7 @@ lpfc_aer_cleanup_state(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 
 	if (phba->hba_flag & HBA_AER_ENABLED)
-		rc = pci_cleanup_aer_uncorrect_error_status(phba->pcidev);
+		rc = pci_aer_clear_nonfatal_status(phba->pcidev);
 
 	if (rc == 0)
 		return strlen(buf);
diff --git a/include/linux/aer.h b/include/linux/aer.h
index fa19e01f418a..97f64ba1b34a 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -44,8 +44,7 @@ struct aer_capability_regs {
 /* PCIe port driver needs this function to enable AER */
 int pci_enable_pcie_error_reporting(struct pci_dev *dev);
 int pci_disable_pcie_error_reporting(struct pci_dev *dev);
-int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev);
-int pci_cleanup_aer_error_status_regs(struct pci_dev *dev);
+int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
 void pci_save_aer_state(struct pci_dev *dev);
 void pci_restore_aer_state(struct pci_dev *dev);
 #else
@@ -57,11 +56,7 @@ static inline int pci_disable_pcie_error_reporting(struct pci_dev *dev)
 {
 	return -EINVAL;
 }
-static inline int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev)
-{
-	return -EINVAL;
-}
-static inline int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
+static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 {
 	return -EINVAL;
 }
-- 
2.17.1

