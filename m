Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10F321E515
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2019 00:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfENWVI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 May 2019 18:21:08 -0400
Received: from mga03.intel.com ([134.134.136.65]:20401 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbfENWVE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 May 2019 18:21:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 May 2019 15:21:03 -0700
X-ExtLoop1: 1
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by fmsmga007.fm.intel.com with ESMTP; 14 May 2019 15:21:02 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v3 3/5] PCI/DPC: Add dpc_process_error() wrapper function
Date:   Tue, 14 May 2019 15:18:15 -0700
Message-Id: <c998029d9db3bce637dc142f476f963f8ac93f58.1557870869.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1557870869.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1557870869.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Add dpc_process_error() wrapper function for handling the DPC
errors when receiving DPC IRQ or Error Disconnect Recover (EDR)
event. This is a prepratory patch for adding EDR support.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pcie/dpc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 0c9ce876e450..95810b4b0adc 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -232,10 +232,9 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
 	return 1;
 }
 
-static irqreturn_t dpc_handler(int irq, void *context)
+static void dpc_process_error(struct dpc_dev *dpc)
 {
 	struct aer_err_info info;
-	struct dpc_dev *dpc = context;
 	struct pci_dev *pdev = dpc->dev->port;
 	struct device *dev = &dpc->dev->device;
 	u16 cap = dpc->cap_pos, status, source, reason, ext_reason;
@@ -269,6 +268,13 @@ static irqreturn_t dpc_handler(int irq, void *context)
 
 	/* We configure DPC so it only triggers on ERR_FATAL */
 	pcie_do_recovery(pdev, pci_channel_io_frozen, PCIE_PORT_SERVICE_DPC);
+}
+
+static irqreturn_t dpc_handler(int irq, void *context)
+{
+	struct dpc_dev *dpc = context;
+
+	dpc_process_error(dpc);
 
 	return IRQ_HANDLED;
 }
-- 
2.20.1

