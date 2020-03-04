Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9B2217888C
	for <lists+linux-pci@lfdr.de>; Wed,  4 Mar 2020 03:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387589AbgCDCjm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 21:39:42 -0500
Received: from mga12.intel.com ([192.55.52.136]:44650 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387400AbgCDCjI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Mar 2020 21:39:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 18:39:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400"; 
   d="scan'208";a="233866895"
Received: from skuppusw-desk.jf.intel.com ([10.7.201.16])
  by orsmga008.jf.intel.com with ESMTP; 03 Mar 2020 18:39:06 -0800
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v17 03/12] PCI/ERR: Remove service dependency in pcie_do_recovery()
Date:   Tue,  3 Mar 2020 18:36:26 -0800
Message-Id: <152c530a3ca8780ae85c2325f97f5f35f5d3602f.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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

Currently we pass PCIe service type parameter to pcie_do_recovery()
function which was in-turn used by reset_link() function to identify
the underlying pci_port_service_driver and then initiate the driver
specific reset_link call. Instead of using this roundabout way, we
can just pass the driver specific reset_link callback function when
calling pcie_do_recovery() function.

This change will also enable non PCIe service driver to call
pcie_do_recovery() function. This is required for adding Error
Disconnect Recover (EDR) support.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pci.h      |  2 +-
 drivers/pci/pcie/aer.c | 11 +++++------
 drivers/pci/pcie/dpc.c |  2 +-
 drivers/pci/pcie/err.c | 16 ++++++++--------
 4 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a4c360515a69..2962200bfe35 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -548,7 +548,7 @@ static inline int pci_dev_specific_disable_acs_redir(struct pci_dev *dev)
 
 /* PCI error reporting and recovery */
 void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
-		      u32 service);
+		      pci_ers_result_t (*reset_cb)(struct pci_dev *pdev));
 
 bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
 #ifdef CONFIG_PCIEASPM
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 4a818b07a1af..1235eca0a2e6 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -102,6 +102,7 @@ struct aer_stats {
 #define ERR_UNCOR_ID(d)			(d >> 16)
 
 static int pcie_aer_disable;
+static pci_ers_result_t aer_root_reset(struct pci_dev *dev);
 
 void pci_no_aer(void)
 {
@@ -1053,11 +1054,9 @@ static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
 					info->status);
 		pci_aer_clear_device_status(dev);
 	} else if (info->severity == AER_NONFATAL)
-		pcie_do_recovery(dev, pci_channel_io_normal,
-				 PCIE_PORT_SERVICE_AER);
+		pcie_do_recovery(dev, pci_channel_io_normal, aer_root_reset);
 	else if (info->severity == AER_FATAL)
-		pcie_do_recovery(dev, pci_channel_io_frozen,
-				 PCIE_PORT_SERVICE_AER);
+		pcie_do_recovery(dev, pci_channel_io_frozen, aer_root_reset);
 	pci_dev_put(dev);
 }
 
@@ -1094,10 +1093,10 @@ static void aer_recover_work_func(struct work_struct *work)
 		cper_print_aer(pdev, entry.severity, entry.regs);
 		if (entry.severity == AER_NONFATAL)
 			pcie_do_recovery(pdev, pci_channel_io_normal,
-					 PCIE_PORT_SERVICE_AER);
+					 aer_root_reset);
 		else if (entry.severity == AER_FATAL)
 			pcie_do_recovery(pdev, pci_channel_io_frozen,
-					 PCIE_PORT_SERVICE_AER);
+					 aer_root_reset);
 		pci_dev_put(pdev);
 	}
 }
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 6b116d7fdb89..114358d62ddf 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -227,7 +227,7 @@ static irqreturn_t dpc_handler(int irq, void *context)
 	}
 
 	/* We configure DPC so it only triggers on ERR_FATAL */
-	pcie_do_recovery(pdev, pci_channel_io_frozen, PCIE_PORT_SERVICE_DPC);
+	pcie_do_recovery(pdev, pci_channel_io_frozen, dpc_reset_link);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index eefefe03857a..05f87bc9d011 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -162,14 +162,13 @@ static pci_ers_result_t default_reset_link(struct pci_dev *dev)
 	return rc ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
 }
 
-static pci_ers_result_t reset_link(struct pci_dev *dev, u32 service)
+static pci_ers_result_t reset_link(struct pci_dev *dev,
+			pci_ers_result_t (*reset_cb)(struct pci_dev *pdev))
 {
 	pci_ers_result_t status;
-	struct pcie_port_service_driver *driver = NULL;
 
-	driver = pcie_port_find_service(dev, service);
-	if (driver && driver->reset_link) {
-		status = driver->reset_link(dev);
+	if (reset_cb) {
+		status = reset_cb(dev);
 	} else if (pcie_downstream_port(dev)) {
 		status = default_reset_link(dev);
 	} else {
@@ -187,8 +186,9 @@ static pci_ers_result_t reset_link(struct pci_dev *dev, u32 service)
 	return status;
 }
 
-void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
-		      u32 service)
+void pcie_do_recovery(struct pci_dev *dev,
+		      enum pci_channel_state state,
+		      pci_ers_result_t (*reset_cb)(struct pci_dev *pdev))
 {
 	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
 	struct pci_bus *bus;
@@ -209,7 +209,7 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
 		pci_walk_bus(bus, report_normal_detected, &status);
 
 	if (state == pci_channel_io_frozen) {
-		status = reset_link(dev, service);
+		status = reset_link(dev, reset_cb);
 		if (status != PCI_ERS_RESULT_RECOVERED)
 			goto failed;
 	}
-- 
2.25.1

