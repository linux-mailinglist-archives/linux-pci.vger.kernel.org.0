Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8675615CA38
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 19:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgBMSWy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Feb 2020 13:22:54 -0500
Received: from mga03.intel.com ([134.134.136.65]:45466 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728216AbgBMSWx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Feb 2020 13:22:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 10:22:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,437,1574150400"; 
   d="scan'208";a="313809156"
Received: from skuppusw-desk.jf.intel.com ([10.7.201.16])
  by orsmga001.jf.intel.com with ESMTP; 13 Feb 2020 10:22:51 -0800
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v15 3/5] PCI/EDR: Export AER, DPC and error recovery functions
Date:   Thu, 13 Feb 2020 10:20:15 -0800
Message-Id: <b2494cde6711c0157cbd93b4fc4ec85e987af8fe.1581617873.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1581617873.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1581617873.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

This is a preparatory patch for adding EDR support.

As per the Downstream Port Containment Related Enhancements ECN to the
PCI Firmware Specification r3.2, sec 4.5.1, table 4-6, If DPC is
controlled by firmware, firmware is responsible for initializing
Downstream Port Containment Extended Capability Structures per firmware
policy. Further, the OS is permitted to read or write DPC Control and
Status registers of a port while processing an Error Disconnect Recover
notification from firmware on that port. Error Disconnect Recover
notification processing begins with the Error Disconnect Recover notify
from Firmware, and ends when the OS releases DPC by clearing the DPC
Trigger Status bit.Firmware can read DPC Trigger Status bit to determine
the ownership of DPC Control and Status registers. Firmware is not
permitted to write to DPC Control and Status registers if DPC Trigger
Status is set i.e. the link is in DPC state. Outside of the Error
Disconnect Recover notification processing window, the OS is not
permitted to modify DPC Control or Status registers; only firmware
is allowed to.

To add EDR support we need to re-use some of the existing DPC,
AER and pCIE error recovery functions. So add necessary interfaces.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pci.h      |  8 ++++
 drivers/pci/pcie/aer.c | 39 ++++++++++++++------
 drivers/pci/pcie/dpc.c | 84 +++++++++++++++++++++++++-----------------
 drivers/pci/pcie/dpc.h | 20 ++++++++++
 drivers/pci/pcie/err.c | 30 ++++++++++++---
 5 files changed, 131 insertions(+), 50 deletions(-)
 create mode 100644 drivers/pci/pcie/dpc.h

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 6394e7746fb5..136f27cf3871 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -443,6 +443,9 @@ struct aer_err_info {
 
 int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
 void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
+int pci_aer_clear_err_uncor_status(struct pci_dev *dev);
+void pci_aer_clear_err_fatal_status(struct pci_dev *dev);
+int pci_aer_clear_err_status_regs(struct pci_dev *dev);
 #endif	/* CONFIG_PCIEAER */
 
 #ifdef CONFIG_PCIE_DPC
@@ -549,6 +552,11 @@ static inline int pci_dev_specific_disable_acs_redir(struct pci_dev *dev)
 /* PCI error reporting and recovery */
 void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
 		      u32 service);
+pci_ers_result_t pcie_do_recovery_common(struct pci_dev *dev,
+				enum pci_channel_state state,
+				u32 service,
+				pci_ers_result_t (*reset_cb)(void *cb_data),
+				void *cb_data);
 
 bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
 #ifdef CONFIG_PCIEASPM
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 4a818b07a1af..399836aa07f4 100644
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
@@ -397,9 +394,17 @@ int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev)
 
 	return 0;
 }
+
+int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev)
+{
+	if (pcie_aer_get_firmware_first(dev))
+		return -EIO;
+
+	return pci_aer_clear_err_uncor_status(dev);
+}
 EXPORT_SYMBOL_GPL(pci_cleanup_aer_uncorrect_error_status);
 
-void pci_aer_clear_fatal_status(struct pci_dev *dev)
+void pci_aer_clear_err_fatal_status(struct pci_dev *dev)
 {
 	int pos;
 	u32 status, sev;
@@ -408,9 +413,6 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
 	if (!pos)
 		return;
 
-	if (pcie_aer_get_firmware_first(dev))
-		return;
-
 	/* Clear status bits for ERR_FATAL errors only */
 	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
 	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &sev);
@@ -419,7 +421,15 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
 		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, status);
 }
 
-int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
+void pci_aer_clear_fatal_status(struct pci_dev *dev)
+{
+	if (pcie_aer_get_firmware_first(dev))
+		return;
+
+	return pci_aer_clear_err_fatal_status(dev);
+}
+
+int pci_aer_clear_err_status_regs(struct pci_dev *dev)
 {
 	int pos;
 	u32 status;
@@ -432,9 +442,6 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
 	if (!pos)
 		return -EIO;
 
-	if (pcie_aer_get_firmware_first(dev))
-		return -EIO;
-
 	port_type = pci_pcie_type(dev);
 	if (port_type == PCI_EXP_TYPE_ROOT_PORT) {
 		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &status);
@@ -450,6 +457,14 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
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
index 99fca8400956..acae12dbf9ff 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -15,15 +15,9 @@
 #include <linux/pci.h>
 
 #include "portdrv.h"
+#include "dpc.h"
 #include "../pci.h"
 
-struct dpc_dev {
-	struct pci_dev		*pdev;
-	u16			cap_pos;
-	bool			rp_extensions;
-	u8			rp_log_size;
-};
-
 static const char * const rp_pio_error_string[] = {
 	"Configuration Request received UR Completion",	 /* Bit Position 0  */
 	"Configuration Request received CA Completion",	 /* Bit Position 1  */
@@ -117,36 +111,44 @@ static int dpc_wait_rp_inactive(struct dpc_dev *dpc)
 	return 0;
 }
 
-static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
+pci_ers_result_t dpc_reset_link_common(struct dpc_dev *dpc)
 {
-	struct dpc_dev *dpc;
 	u16 cap;
 
-	/*
-	 * DPC disables the Link automatically in hardware, so it has
-	 * already been reset by the time we get here.
-	 */
-	dpc = to_dpc_dev(pdev);
 	cap = dpc->cap_pos;
 
 	/*
 	 * Wait until the Link is inactive, then clear DPC Trigger Status
 	 * to allow the Port to leave DPC.
 	 */
-	pcie_wait_for_link(pdev, false);
+	pcie_wait_for_link(dpc->pdev, false);
 
 	if (dpc->rp_extensions && dpc_wait_rp_inactive(dpc))
 		return PCI_ERS_RESULT_DISCONNECT;
 
-	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
+	pci_write_config_word(dpc->pdev, cap + PCI_EXP_DPC_STATUS,
 			      PCI_EXP_DPC_STATUS_TRIGGER);
 
-	if (!pcie_wait_for_link(pdev, true))
+	if (!pcie_wait_for_link(dpc->pdev, true))
 		return PCI_ERS_RESULT_DISCONNECT;
 
 	return PCI_ERS_RESULT_RECOVERED;
 }
 
+static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
+{
+	struct dpc_dev *dpc;
+
+	/*
+	 * DPC disables the Link automatically in hardware, so it has
+	 * already been reset by the time we get here.
+	 */
+	dpc = to_dpc_dev(pdev);
+
+	return dpc_reset_link_common(dpc);
+
+}
+
 static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
 {
 	struct pci_dev *pdev = dpc->pdev;
@@ -224,10 +226,9 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
 	return 1;
 }
 
-static irqreturn_t dpc_handler(int irq, void *context)
+void dpc_process_error(struct dpc_dev *dpc)
 {
 	struct aer_err_info info;
-	struct dpc_dev *dpc = context;
 	struct pci_dev *pdev = dpc->pdev;
 	u16 cap = dpc->cap_pos, status, source, reason, ext_reason;
 
@@ -257,6 +258,14 @@ static irqreturn_t dpc_handler(int irq, void *context)
 		pci_cleanup_aer_uncorrect_error_status(pdev);
 		pci_aer_clear_fatal_status(pdev);
 	}
+}
+
+static irqreturn_t dpc_handler(int irq, void *context)
+{
+	struct dpc_dev *dpc = context;
+	struct pci_dev *pdev = dpc->pdev;
+
+	dpc_process_error(dpc);
 
 	/* We configure DPC so it only triggers on ERR_FATAL */
 	pcie_do_recovery(pdev, pci_channel_io_frozen, PCIE_PORT_SERVICE_DPC);
@@ -282,6 +291,25 @@ static irqreturn_t dpc_irq(int irq, void *context)
 	return IRQ_HANDLED;
 }
 
+void dpc_dev_init(struct pci_dev *pdev, struct dpc_dev *dpc)
+{
+	dpc->cap_pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DPC);
+	dpc->pdev = pdev;
+	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CAP, &dpc->cap);
+	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, &dpc->ctl);
+
+	dpc->rp_extensions = (dpc->cap & PCI_EXP_DPC_CAP_RP_EXT);
+	if (dpc->rp_extensions) {
+		dpc->rp_log_size =
+			(dpc->cap & PCI_EXP_DPC_RP_PIO_LOG_SIZE) >> 8;
+		if (dpc->rp_log_size < 4 || dpc->rp_log_size > 9) {
+			pci_err(pdev, "RP PIO log size %u is invalid\n",
+				dpc->rp_log_size);
+			dpc->rp_log_size = 0;
+		}
+	}
+}
+
 #define FLAG(x, y) (((x) & (y)) ? '+' : '-')
 static int dpc_probe(struct pcie_device *dev)
 {
@@ -298,8 +326,8 @@ static int dpc_probe(struct pcie_device *dev)
 	if (!dpc)
 		return -ENOMEM;
 
-	dpc->cap_pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DPC);
-	dpc->pdev = pdev;
+	dpc_dev_init(pdev, dpc);
+
 	set_service_data(dev, dpc);
 
 	status = devm_request_threaded_irq(device, dev->irq, dpc_irq,
@@ -311,18 +339,8 @@ static int dpc_probe(struct pcie_device *dev)
 		return status;
 	}
 
-	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CAP, &cap);
-	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, &ctl);
-
-	dpc->rp_extensions = (cap & PCI_EXP_DPC_CAP_RP_EXT);
-	if (dpc->rp_extensions) {
-		dpc->rp_log_size = (cap & PCI_EXP_DPC_RP_PIO_LOG_SIZE) >> 8;
-		if (dpc->rp_log_size < 4 || dpc->rp_log_size > 9) {
-			pci_err(pdev, "RP PIO log size %u is invalid\n",
-				dpc->rp_log_size);
-			dpc->rp_log_size = 0;
-		}
-	}
+	ctl = dpc->ctl;
+	cap = dpc->cap;
 
 	ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
 	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, ctl);
diff --git a/drivers/pci/pcie/dpc.h b/drivers/pci/pcie/dpc.h
new file mode 100644
index 000000000000..2d82bc917fcb
--- /dev/null
+++ b/drivers/pci/pcie/dpc.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef DRIVERS_PCIE_DPC_H
+#define DRIVERS_PCIE_DPC_H
+
+#include <linux/pci.h>
+
+struct dpc_dev {
+	struct pci_dev		*pdev;
+	u16			cap_pos;
+	bool			rp_extensions;
+	u8			rp_log_size;
+	u16			ctl;
+	u16			cap;
+};
+
+pci_ers_result_t dpc_reset_link_common(struct dpc_dev *dpc);
+void dpc_process_error(struct dpc_dev *dpc);
+void dpc_dev_init(struct pci_dev *pdev, struct dpc_dev *dpc);
+
+#endif /* DRIVERS_PCIE_DPC_H */
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index eefefe03857a..e7b9dfae9035 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -162,11 +162,18 @@ static pci_ers_result_t default_reset_link(struct pci_dev *dev)
 	return rc ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
 }
 
-static pci_ers_result_t reset_link(struct pci_dev *dev, u32 service)
+static pci_ers_result_t reset_link(struct pci_dev *dev, u32 service,
+				   pci_ers_result_t (*reset_cb)(void *cb_data),
+				   void *cb_data)
 {
 	pci_ers_result_t status;
 	struct pcie_port_service_driver *driver = NULL;
 
+	if (reset_cb) {
+		status = reset_cb(cb_data);
+		goto done;
+	}
+
 	driver = pcie_port_find_service(dev, service);
 	if (driver && driver->reset_link) {
 		status = driver->reset_link(dev);
@@ -178,6 +185,7 @@ static pci_ers_result_t reset_link(struct pci_dev *dev, u32 service)
 		return PCI_ERS_RESULT_DISCONNECT;
 	}
 
+done:
 	if (status != PCI_ERS_RESULT_RECOVERED) {
 		pci_printk(KERN_DEBUG, dev, "link reset at upstream device %s failed\n",
 			pci_name(dev));
@@ -187,8 +195,11 @@ static pci_ers_result_t reset_link(struct pci_dev *dev, u32 service)
 	return status;
 }
 
-void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
-		      u32 service)
+pci_ers_result_t pcie_do_recovery_common(struct pci_dev *dev,
+				enum pci_channel_state state,
+				u32 service,
+				pci_ers_result_t (*reset_cb)(void *cb_data),
+				void *cb_data)
 {
 	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
 	struct pci_bus *bus;
@@ -209,7 +220,7 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
 		pci_walk_bus(bus, report_normal_detected, &status);
 
 	if (state == pci_channel_io_frozen) {
-		status = reset_link(dev, service);
+		status = reset_link(dev, service, reset_cb, cb_data);
 		if (status != PCI_ERS_RESULT_RECOVERED)
 			goto failed;
 	}
@@ -240,11 +251,20 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
 	pci_aer_clear_device_status(dev);
 	pci_cleanup_aer_uncorrect_error_status(dev);
 	pci_info(dev, "device recovery successful\n");
-	return;
+
+	return status;
 
 failed:
 	pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
 
 	/* TODO: Should kernel panic here? */
 	pci_info(dev, "device recovery failed\n");
+
+	return status;
+}
+
+void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
+		      u32 service)
+{
+	pcie_do_recovery_common(dev, state, service, NULL, NULL);
 }
-- 
2.21.0

