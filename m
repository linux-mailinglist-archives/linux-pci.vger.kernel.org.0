Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7306F17887E
	for <lists+linux-pci@lfdr.de>; Wed,  4 Mar 2020 03:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387662AbgCDCjM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 21:39:12 -0500
Received: from mga07.intel.com ([134.134.136.100]:56583 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387656AbgCDCjL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Mar 2020 21:39:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 18:39:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400"; 
   d="scan'208";a="233866917"
Received: from skuppusw-desk.jf.intel.com ([10.7.201.16])
  by orsmga008.jf.intel.com with ESMTP; 03 Mar 2020 18:39:06 -0800
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v17 10/12] PCI/DPC: Export DPC error recovery functions
Date:   Tue,  3 Mar 2020 18:36:33 -0800
Message-Id: <ac8816d4d41d0894720660f9b51dbeac0842869d.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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

This is a preparatory patch for adding EDR support.

As per the Downstream Port Containment Related Enhancements ECN to the
PCI Firmware Specification r3.2, sec 4.5.1, table 4-6, If DPC is
controlled by firmware, firmware is responsible for initializing
Downstream Port Containment Extended Capability Structures per firmware
policy. Further, the OS is permitted to read or write DPC Control and
Status registers of a port while processing an Error Disconnect Recover
notification from firmware on that port.

To add EDR support we need to re-use DPC error handling functions. So
add necessary interfaces.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pci.h      |  2 ++
 drivers/pci/pcie/dpc.c | 12 +++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index c239e6dd2542..a475192c553a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -449,6 +449,8 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
 void pci_save_dpc_state(struct pci_dev *dev);
 void pci_restore_dpc_state(struct pci_dev *dev);
 void pci_dpc_init(struct pci_dev *pdev);
+void dpc_process_error(struct pci_dev *pdev);
+pci_ers_result_t dpc_reset_link(struct pci_dev *pdev);
 #else
 static inline void pci_save_dpc_state(struct pci_dev *dev) {}
 static inline void pci_restore_dpc_state(struct pci_dev *dev) {}
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index ad011d6b22c5..72bfb58918e1 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -89,7 +89,7 @@ static int dpc_wait_rp_inactive(struct pci_dev *pdev)
 	return 0;
 }
 
-static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
+pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
 {
 	u16 cap;
 
@@ -193,9 +193,8 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
 	return 1;
 }
 
-static irqreturn_t dpc_handler(int irq, void *context)
+void dpc_process_error(struct pci_dev *pdev)
 {
-	struct pci_dev *pdev = context;
 	u16 cap = pdev->dpc_cap, status, source, reason, ext_reason;
 	struct aer_err_info info;
 
@@ -225,6 +224,13 @@ static irqreturn_t dpc_handler(int irq, void *context)
 		pci_cleanup_aer_uncorrect_error_status(pdev);
 		pci_aer_clear_fatal_status(pdev);
 	}
+}
+
+static irqreturn_t dpc_handler(int irq, void *context)
+{
+	struct pci_dev *pdev = context;
+
+	dpc_process_error(pdev);
 
 	/* We configure DPC so it only triggers on ERR_FATAL */
 	pcie_do_recovery(pdev, pci_channel_io_frozen, dpc_reset_link);
-- 
2.25.1

