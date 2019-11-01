Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC87BECC16
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2019 00:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbfKAX7d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Nov 2019 19:59:33 -0400
Received: from mga04.intel.com ([192.55.52.120]:63645 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfKAX7P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Nov 2019 19:59:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2019 16:59:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,257,1569308400"; 
   d="scan'208";a="199469576"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by fmsmga008.fm.intel.com with ESMTP; 01 Nov 2019 16:59:15 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v10 3/8] PCI/DPC: Add dpc_process_error() wrapper function
Date:   Fri,  1 Nov 2019 16:56:51 -0700
Message-Id: <073b373cfe88ac88fbac9770357f315c41321b05.1572652041.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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

With Error Disconnect Recover (EDR) support, we need to support
processing DPC event either from DPC IRQ or ACPI EDR event. So create
a wrapper function dpc_process_error() and move common error handling
code in to it. It will be used to process the DPC event in both DPC IRQ
and EDR ACPI event contexts.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/dpc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index c3e0b05efa4b..66ce371911cc 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -240,10 +240,9 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
 	return 1;
 }
 
-static irqreturn_t dpc_handler(int irq, void *context)
+static void dpc_process_error(struct dpc_dev *dpc)
 {
 	struct aer_err_info info;
-	struct dpc_dev *dpc = context;
 	struct pci_dev *pdev = dpc->dev->port;
 	u16 cap = dpc->cap_pos, status, source, reason, ext_reason;
 
@@ -276,6 +275,13 @@ static irqreturn_t dpc_handler(int irq, void *context)
 
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

