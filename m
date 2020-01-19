Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F594141BDF
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2020 05:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgASECz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Jan 2020 23:02:55 -0500
Received: from mga01.intel.com ([192.55.52.88]:54997 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbgASECy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 18 Jan 2020 23:02:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jan 2020 20:02:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,336,1574150400"; 
   d="scan'208";a="226751889"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by orsmga003.jf.intel.com with ESMTP; 18 Jan 2020 20:02:50 -0800
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH v13 6/8] PCI/DPC: Update comments related to DPC recovery on NON_FATAL errors
Date:   Sat, 18 Jan 2020 20:00:35 -0800
Message-Id: <3ee62d75a2953a6435bebcc806a70fd5a3ecbe57.1579406227.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1579406227.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1579406227.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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
index bb237af8dac1..97eb032f9a29 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -284,7 +284,11 @@ static void dpc_process_error(struct dpc_dev *dpc)
 		pci_aer_clear_err_fatal_status(pdev);
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

