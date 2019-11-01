Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52EBBECC12
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2019 00:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfKAX7Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Nov 2019 19:59:16 -0400
Received: from mga04.intel.com ([192.55.52.120]:63645 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727907AbfKAX7Q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Nov 2019 19:59:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2019 16:59:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,257,1569308400"; 
   d="scan'208";a="199469590"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by fmsmga008.fm.intel.com with ESMTP; 01 Nov 2019 16:59:16 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v10 6/8] PCI/DPC: Update comments related to DPC recovery on NON_FATAL errors
Date:   Fri,  1 Nov 2019 16:56:54 -0700
Message-Id: <e3c16c7f5be6120db187f83a7917754b72b57ac6.1572652041.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1572652041.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1572652041.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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
triggered for both FATAL/NON_FATAL errors. So update comments and add
details about how NON_FATAL dpc recovery is handled.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/dpc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 84581a872f39..b094df7eb5ed 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -283,7 +283,11 @@ static void dpc_process_error(struct dpc_dev *dpc)
 		pci_aer_clear_fatal_status(pdev, 0);
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

