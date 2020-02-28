Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 970EA172DE7
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2020 02:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730688AbgB1BDG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Feb 2020 20:03:06 -0500
Received: from mga07.intel.com ([134.134.136.100]:32657 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730552AbgB1BCo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Feb 2020 20:02:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 17:02:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,493,1574150400"; 
   d="scan'208";a="317977014"
Received: from skuppusw-desk.jf.intel.com ([10.7.201.16])
  by orsmga001.jf.intel.com with ESMTP; 27 Feb 2020 17:02:42 -0800
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v16 7/9] PCI/DPC: Export DPC error recovery functions
Date:   Thu, 27 Feb 2020 16:59:49 -0800
Message-Id: <ef15401783b3d4f33072f8ffe84073cea178486d.1582850766.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1582850766.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1582850766.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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
index 57e7f94b98cf..e0a5b5f9547f 100644
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
2.21.0

