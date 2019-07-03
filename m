Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72B015ED8F
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2019 22:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfGCUcV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jul 2019 16:32:21 -0400
Received: from mga14.intel.com ([192.55.52.115]:3964 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727290AbfGCUcU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jul 2019 16:32:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2019 13:32:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,448,1557212400"; 
   d="scan'208";a="158089425"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by orsmga008.jf.intel.com with ESMTP; 03 Jul 2019 13:32:18 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v4 7/8] PCI/DPC: Add support for DPC recovery on NON_FATAL errors
Date:   Wed,  3 Jul 2019 13:29:54 -0700
Message-Id: <10eab0aeb3edad3cbe385ec1e96ea5e5497bde80.1562185606.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1562185606.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1562185606.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Currently, in native mode, DPC driver is configured to trigger DPC only
for FATAL errors and hence it only supports port recovery for FATAL
errors. But with Error Disconnect Recover (EDR) support, DPC
configuration is done by firmware, and hence we should expect DPC
triggered for both FATAL/NON-FATAL errors. So add support for DPC
recovery with NON-FATAL errors.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pcie/dpc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 214fa623228e..34f4e6ca24df 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -267,15 +267,20 @@ static void dpc_process_error(struct dpc_dev *dpc)
 	/* show RP PIO error detail information */
 	if (dpc->rp_extensions && reason == 3 && ext_reason == 0)
 		dpc_process_rp_pio_error(dpc);
-	else if (reason == 0 &&
+	else if (reason <= 2 &&
 		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
 		 aer_get_device_error_info(pdev, &info)) {
 		aer_print_error(pdev, &info);
 		pci_cleanup_aer_uncorrect_error_status(pdev);
-		pci_aer_clear_fatal_status(pdev);
+		if (reason != 1)
+			pci_aer_clear_fatal_status(pdev);
 	}
 
-	/* We configure DPC so it only triggers on ERR_FATAL */
+	/*
+	 * Irrespective of whether the DPC event is triggered by
+	 * ERR_FATAL or ERR_NONFATAL, since the link is already down,
+	 * use the FATAL error recovery path for both cases.
+	 */
 	pcie_do_recovery(pdev, pci_channel_io_frozen, PCIE_PORT_SERVICE_DPC);
 }
 
-- 
2.21.0

