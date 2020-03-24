Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB0791902D9
	for <lists+linux-pci@lfdr.de>; Tue, 24 Mar 2020 01:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgCXA0Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Mar 2020 20:26:24 -0400
Received: from mga14.intel.com ([192.55.52.115]:60461 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727665AbgCXA0X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Mar 2020 20:26:23 -0400
IronPort-SDR: x0OdxZkaUAWPFVFsy4f+damPIODMbi9IofkssOjJAu0Co97B6HzrwMRGiyYXzGZ3PIz1fzILAm
 QLlUll1brrgw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 17:26:22 -0700
IronPort-SDR: dqaDozme4VGUcVX95Ak9f/bYtHoJ0HTe2/u+0zEG90GYir5OEA5S0QPD64JCTFYaPfyiCNegCg
 3iiSeymUJfqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,298,1580803200"; 
   d="scan'208";a="419692236"
Received: from bhaveshm-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.134.88.197])
  by orsmga005.jf.intel.com with ESMTP; 23 Mar 2020 17:26:22 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v18 04/11] PCI/DPC: Move DPC data into struct pci_dev
Date:   Mon, 23 Mar 2020 17:26:01 -0700
Message-Id: <98323eaa18080adbe5bb30846862f09f8722d4b3.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

We only need 25 bits of data for DPC, so I don't think it's worth the
complexity of allocating and keeping track of the struct dpc_dev separately
from the pci_dev.  Move that data into the struct pci_dev.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/dpc.c | 103 +++++++++++++----------------------------
 include/linux/pci.h    |   5 ++
 2 files changed, 36 insertions(+), 72 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 0e356ed0d73f..5c2e9d45a269 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -18,13 +18,6 @@
 #include "portdrv.h"
 #include "../pci.h"
 
-struct dpc_dev {
-	struct pcie_device	*dev;
-	u16			cap_pos;
-	bool			rp_extensions;
-	u8			rp_log_size;
-};
-
 static const char * const rp_pio_error_string[] = {
 	"Configuration Request received UR Completion",	 /* Bit Position 0  */
 	"Configuration Request received CA Completion",	 /* Bit Position 1  */
@@ -47,63 +40,42 @@ static const char * const rp_pio_error_string[] = {
 	"Memory Request Completion Timeout",		 /* Bit Position 18 */
 };
 
-static struct dpc_dev *to_dpc_dev(struct pci_dev *dev)
-{
-	struct device *device;
-
-	device = pcie_port_find_device(dev, PCIE_PORT_SERVICE_DPC);
-	if (!device)
-		return NULL;
-	return get_service_data(to_pcie_device(device));
-}
-
 void pci_save_dpc_state(struct pci_dev *dev)
 {
-	struct dpc_dev *dpc;
 	struct pci_cap_saved_state *save_state;
 	u16 *cap;
 
 	if (!pci_is_pcie(dev))
 		return;
 
-	dpc = to_dpc_dev(dev);
-	if (!dpc)
-		return;
-
 	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_DPC);
 	if (!save_state)
 		return;
 
 	cap = (u16 *)&save_state->cap.data[0];
-	pci_read_config_word(dev, dpc->cap_pos + PCI_EXP_DPC_CTL, cap);
+	pci_read_config_word(dev, dev->dpc_cap + PCI_EXP_DPC_CTL, cap);
 }
 
 void pci_restore_dpc_state(struct pci_dev *dev)
 {
-	struct dpc_dev *dpc;
 	struct pci_cap_saved_state *save_state;
 	u16 *cap;
 
 	if (!pci_is_pcie(dev))
 		return;
 
-	dpc = to_dpc_dev(dev);
-	if (!dpc)
-		return;
-
 	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_DPC);
 	if (!save_state)
 		return;
 
 	cap = (u16 *)&save_state->cap.data[0];
-	pci_write_config_word(dev, dpc->cap_pos + PCI_EXP_DPC_CTL, *cap);
+	pci_write_config_word(dev, dev->dpc_cap + PCI_EXP_DPC_CTL, *cap);
 }
 
-static int dpc_wait_rp_inactive(struct dpc_dev *dpc)
+static int dpc_wait_rp_inactive(struct pci_dev *pdev)
 {
 	unsigned long timeout = jiffies + HZ;
-	struct pci_dev *pdev = dpc->dev->port;
-	u16 cap = dpc->cap_pos, status;
+	u16 cap = pdev->dpc_cap, status;
 
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
 	while (status & PCI_EXP_DPC_RP_BUSY &&
@@ -120,15 +92,13 @@ static int dpc_wait_rp_inactive(struct dpc_dev *dpc)
 
 static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
 {
-	struct dpc_dev *dpc;
 	u16 cap;
 
 	/*
 	 * DPC disables the Link automatically in hardware, so it has
 	 * already been reset by the time we get here.
 	 */
-	dpc = to_dpc_dev(pdev);
-	cap = dpc->cap_pos;
+	cap = pdev->dpc_cap;
 
 	/*
 	 * Wait until the Link is inactive, then clear DPC Trigger Status
@@ -136,7 +106,7 @@ static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
 	 */
 	pcie_wait_for_link(pdev, false);
 
-	if (dpc->rp_extensions && dpc_wait_rp_inactive(dpc))
+	if (pdev->dpc_rp_extensions && dpc_wait_rp_inactive(pdev))
 		return PCI_ERS_RESULT_DISCONNECT;
 
 	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
@@ -155,10 +125,9 @@ static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
 	return PCI_ERS_RESULT_RECOVERED;
 }
 
-static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
+static void dpc_process_rp_pio_error(struct pci_dev *pdev)
 {
-	struct pci_dev *pdev = dpc->dev->port;
-	u16 cap = dpc->cap_pos, dpc_status, first_error;
+	u16 cap = pdev->dpc_cap, dpc_status, first_error;
 	u32 status, mask, sev, syserr, exc, dw0, dw1, dw2, dw3, log, prefix;
 	int i;
 
@@ -183,7 +152,7 @@ static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
 				first_error == i ? " (First)" : "");
 	}
 
-	if (dpc->rp_log_size < 4)
+	if (pdev->dpc_rp_log_size < 4)
 		goto clear_status;
 	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_HEADER_LOG,
 			      &dw0);
@@ -196,12 +165,12 @@ static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
 	pci_err(pdev, "TLP Header: %#010x %#010x %#010x %#010x\n",
 		dw0, dw1, dw2, dw3);
 
-	if (dpc->rp_log_size < 5)
+	if (pdev->dpc_rp_log_size < 5)
 		goto clear_status;
 	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_IMPSPEC_LOG, &log);
 	pci_err(pdev, "RP PIO ImpSpec Log %#010x\n", log);
 
-	for (i = 0; i < dpc->rp_log_size - 5; i++) {
+	for (i = 0; i < pdev->dpc_rp_log_size - 5; i++) {
 		pci_read_config_dword(pdev,
 			cap + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG, &prefix);
 		pci_err(pdev, "TLP Prefix Header: dw%d, %#010x\n", i, prefix);
@@ -234,10 +203,9 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
 
 static irqreturn_t dpc_handler(int irq, void *context)
 {
+	struct pci_dev *pdev = context;
+	u16 cap = pdev->dpc_cap, status, source, reason, ext_reason;
 	struct aer_err_info info;
-	struct dpc_dev *dpc = context;
-	struct pci_dev *pdev = dpc->dev->port;
-	u16 cap = dpc->cap_pos, status, source, reason, ext_reason;
 
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID, &source);
@@ -256,8 +224,8 @@ static irqreturn_t dpc_handler(int irq, void *context)
 				     "reserved error");
 
 	/* show RP PIO error detail information */
-	if (dpc->rp_extensions && reason == 3 && ext_reason == 0)
-		dpc_process_rp_pio_error(dpc);
+	if (pdev->dpc_rp_extensions && reason == 3 && ext_reason == 0)
+		dpc_process_rp_pio_error(pdev);
 	else if (reason == 0 &&
 		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
 		 aer_get_device_error_info(pdev, &info)) {
@@ -274,9 +242,8 @@ static irqreturn_t dpc_handler(int irq, void *context)
 
 static irqreturn_t dpc_irq(int irq, void *context)
 {
-	struct dpc_dev *dpc = (struct dpc_dev *)context;
-	struct pci_dev *pdev = dpc->dev->port;
-	u16 cap = dpc->cap_pos, status;
+	struct pci_dev *pdev = context;
+	u16 cap = pdev->dpc_cap, status;
 
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
 
@@ -293,7 +260,6 @@ static irqreturn_t dpc_irq(int irq, void *context)
 #define FLAG(x, y) (((x) & (y)) ? '+' : '-')
 static int dpc_probe(struct pcie_device *dev)
 {
-	struct dpc_dev *dpc;
 	struct pci_dev *pdev = dev->port;
 	struct device *device = &dev->device;
 	int status;
@@ -302,43 +268,37 @@ static int dpc_probe(struct pcie_device *dev)
 	if (pcie_aer_get_firmware_first(pdev) && !pcie_ports_dpc_native)
 		return -ENOTSUPP;
 
-	dpc = devm_kzalloc(device, sizeof(*dpc), GFP_KERNEL);
-	if (!dpc)
-		return -ENOMEM;
-
-	dpc->cap_pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DPC);
-	dpc->dev = dev;
-	set_service_data(dev, dpc);
+	pdev->dpc_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DPC);
 
 	status = devm_request_threaded_irq(device, dev->irq, dpc_irq,
 					   dpc_handler, IRQF_SHARED,
-					   "pcie-dpc", dpc);
+					   "pcie-dpc", pdev);
 	if (status) {
 		pci_warn(pdev, "request IRQ%d failed: %d\n", dev->irq,
 			 status);
 		return status;
 	}
 
-	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CAP, &cap);
-	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, &ctl);
+	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CAP, &cap);
+	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
 
-	dpc->rp_extensions = (cap & PCI_EXP_DPC_CAP_RP_EXT);
-	if (dpc->rp_extensions) {
-		dpc->rp_log_size = (cap & PCI_EXP_DPC_RP_PIO_LOG_SIZE) >> 8;
-		if (dpc->rp_log_size < 4 || dpc->rp_log_size > 9) {
+	pdev->dpc_rp_extensions = (cap & PCI_EXP_DPC_CAP_RP_EXT) ? 1 : 0;
+	if (pdev->dpc_rp_extensions) {
+		pdev->dpc_rp_log_size = (cap & PCI_EXP_DPC_RP_PIO_LOG_SIZE) >> 8;
+		if (pdev->dpc_rp_log_size < 4 || pdev->dpc_rp_log_size > 9) {
 			pci_err(pdev, "RP PIO log size %u is invalid\n",
-				dpc->rp_log_size);
-			dpc->rp_log_size = 0;
+				pdev->dpc_rp_log_size);
+			pdev->dpc_rp_log_size = 0;
 		}
 	}
 
 	ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
-	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, ctl);
+	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);
 
 	pci_info(pdev, "error containment capabilities: Int Msg #%d, RPExt%c PoisonedTLP%c SwTrigger%c RP PIO Log %d, DL_ActiveErr%c\n",
 		 cap & PCI_EXP_DPC_IRQ, FLAG(cap, PCI_EXP_DPC_CAP_RP_EXT),
 		 FLAG(cap, PCI_EXP_DPC_CAP_POISONED_TLP),
-		 FLAG(cap, PCI_EXP_DPC_CAP_SW_TRIGGER), dpc->rp_log_size,
+		 FLAG(cap, PCI_EXP_DPC_CAP_SW_TRIGGER), pdev->dpc_rp_log_size,
 		 FLAG(cap, PCI_EXP_DPC_CAP_DL_ACTIVE));
 
 	pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_DPC, sizeof(u16));
@@ -347,13 +307,12 @@ static int dpc_probe(struct pcie_device *dev)
 
 static void dpc_remove(struct pcie_device *dev)
 {
-	struct dpc_dev *dpc = get_service_data(dev);
 	struct pci_dev *pdev = dev->port;
 	u16 ctl;
 
-	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, &ctl);
+	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
 	ctl &= ~(PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN);
-	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, ctl);
+	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);
 }
 
 static struct pcie_port_service_driver dpcdriver = {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 3840a541a9de..a0b7e7a53741 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -444,6 +444,11 @@ struct pci_dev {
 	const struct attribute_group **msi_irq_groups;
 #endif
 	struct pci_vpd *vpd;
+#ifdef CONFIG_PCIE_DPC
+	u16		dpc_cap;
+	unsigned int	dpc_rp_extensions:1;
+	u8		dpc_rp_log_size;
+#endif
 #ifdef CONFIG_PCI_ATS
 	union {
 		struct pci_sriov	*sriov;		/* PF: SR-IOV info */
-- 
2.17.1

