Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9F25ED99
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2019 22:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfGCUco (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jul 2019 16:32:44 -0400
Received: from mga04.intel.com ([192.55.52.120]:60933 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727281AbfGCUcU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jul 2019 16:32:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2019 13:32:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,448,1557212400"; 
   d="scan'208";a="158089415"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by orsmga008.jf.intel.com with ESMTP; 03 Jul 2019 13:32:18 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v4 4/8] PCI/DPC: Add dpc_process_error() wrapper function
Date:   Wed,  3 Jul 2019 13:29:51 -0700
Message-Id: <0202c06d4500762994f4f3e723b6f3e4801f53b4.1562185606.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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

With Error Disconnect Recover (EDR) support, we need to support
processing DPC event either from DPC IRQ or ACPI EDR event. So create
a wrapper function dpc_process_error() and move common error handling
code in to it. It will be used to process the DPC event in both DPC IRQ
and EDR ACPI event contexts.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pcie/dpc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 9717fda012f8..4137ec7b48cc 100644
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
 	u16 cap = dpc->cap_pos, status, source, reason, ext_reason;
 
@@ -268,6 +267,13 @@ static irqreturn_t dpc_handler(int irq, void *context)
 
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
2.21.0

