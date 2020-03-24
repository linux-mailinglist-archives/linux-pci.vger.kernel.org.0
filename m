Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD651902E1
	for <lists+linux-pci@lfdr.de>; Tue, 24 Mar 2020 01:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbgCXA02 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Mar 2020 20:26:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:60463 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727705AbgCXA00 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Mar 2020 20:26:26 -0400
IronPort-SDR: qa/kQia4DB6598SqsNiSlEnbXKyQx/t4PxxI3Uf43hQ2+0NQOq2QAe28zUXpBmet+i/SVBWSfg
 sZ8nZEH8WBqA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 17:26:26 -0700
IronPort-SDR: YxV1jv3AKrdrr6aWdzpDqQj1lmCb2Hr7rdxgeUP3x900/N9z6Uj10IFkS9Vi3N5HzYgonA0crt
 ZlO7BobDqmgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,298,1580803200"; 
   d="scan'208";a="419692254"
Received: from bhaveshm-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.134.88.197])
  by orsmga005.jf.intel.com with ESMTP; 23 Mar 2020 17:26:25 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v18 09/11] PCI/DPC: Expose dpc_process_error(), dpc_reset_link() for use by EDR
Date:   Mon, 23 Mar 2020 17:26:06 -0700
Message-Id: <e9000bb15b3a4293e81d98bb29ead7c84a6393c9.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

If firmware controls DPC, it is generally responsible for managing the DPC
capability and events, and the OS should not access the DPC capability.

However, if firmware controls DPC and both the OS and the platform support
Error Disconnect Recover (EDR) notifications, the OS EDR notify handler is
responsible for recovery, and the notify handler may read/write the DPC
capability until it clears the DPC Trigger Status bit.  See [1], sec 4.5.1,
table 4-6.

Expose some DPC error handling functions so they can be used by the EDR
notify handler.

[1] Downstream Port Containment Related Enhancements ECN, Jan 28, 2019,
    affecting PCI Firmware Specification, Rev. 3.2
    https://members.pcisig.com/wg/PCI-SIG/document/12888
Link: https://lore.kernel.org/r/ac8816d4d41d0894720660f9b51dbeac0842869d.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.h      |  2 ++
 drivers/pci/pcie/dpc.c | 12 +++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 6d09bb22b73d..25265bf80a83 100644
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
index 5870a0f154fc..e9087f5f32ec 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -90,7 +90,7 @@ static int dpc_wait_rp_inactive(struct pci_dev *pdev)
 	return 0;
 }
 
-static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
+pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
 {
 	u16 cap;
 
@@ -201,9 +201,8 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
 	return 1;
 }
 
-static irqreturn_t dpc_handler(int irq, void *context)
+void dpc_process_error(struct pci_dev *pdev)
 {
-	struct pci_dev *pdev = context;
 	u16 cap = pdev->dpc_cap, status, source, reason, ext_reason;
 	struct aer_err_info info;
 
@@ -233,6 +232,13 @@ static irqreturn_t dpc_handler(int irq, void *context)
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
2.17.1

