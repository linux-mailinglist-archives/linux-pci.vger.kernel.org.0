Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0D9615CA3D
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 19:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgBMSXE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Feb 2020 13:23:04 -0500
Received: from mga03.intel.com ([134.134.136.65]:45465 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728235AbgBMSWy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Feb 2020 13:22:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 10:22:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,437,1574150400"; 
   d="scan'208";a="313809153"
Received: from skuppusw-desk.jf.intel.com ([10.7.201.16])
  by orsmga001.jf.intel.com with ESMTP; 13 Feb 2020 10:22:51 -0800
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v15 2/5] PCI/DPC: Remove pcie_device reference from dpc_dev structure
Date:   Thu, 13 Feb 2020 10:20:14 -0800
Message-Id: <48cc718aef4c4612b0896bd4a270c6c1f0c0f1a7.1581617873.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1581617873.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1581617873.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Currently the only use of pcie_device member in dpc_dev structure is to
get the associated pci_dev reference. Since none of the users of
dpc_dev need reference to pcie_device, just remove it and replace it
with associated pci_dev pointer reference.

Removing pcie_device reference will help if we have need to call DPC
driver functions outside PCIe port drivers.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pcie/dpc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index e06f42f58d3d..99fca8400956 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -18,7 +18,7 @@
 #include "../pci.h"
 
 struct dpc_dev {
-	struct pcie_device	*dev;
+	struct pci_dev		*pdev;
 	u16			cap_pos;
 	bool			rp_extensions;
 	u8			rp_log_size;
@@ -101,7 +101,7 @@ void pci_restore_dpc_state(struct pci_dev *dev)
 static int dpc_wait_rp_inactive(struct dpc_dev *dpc)
 {
 	unsigned long timeout = jiffies + HZ;
-	struct pci_dev *pdev = dpc->dev->port;
+	struct pci_dev *pdev = dpc->pdev;
 	u16 cap = dpc->cap_pos, status;
 
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
@@ -149,7 +149,7 @@ static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
 
 static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
 {
-	struct pci_dev *pdev = dpc->dev->port;
+	struct pci_dev *pdev = dpc->pdev;
 	u16 cap = dpc->cap_pos, dpc_status, first_error;
 	u32 status, mask, sev, syserr, exc, dw0, dw1, dw2, dw3, log, prefix;
 	int i;
@@ -228,7 +228,7 @@ static irqreturn_t dpc_handler(int irq, void *context)
 {
 	struct aer_err_info info;
 	struct dpc_dev *dpc = context;
-	struct pci_dev *pdev = dpc->dev->port;
+	struct pci_dev *pdev = dpc->pdev;
 	u16 cap = dpc->cap_pos, status, source, reason, ext_reason;
 
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
@@ -267,7 +267,7 @@ static irqreturn_t dpc_handler(int irq, void *context)
 static irqreturn_t dpc_irq(int irq, void *context)
 {
 	struct dpc_dev *dpc = (struct dpc_dev *)context;
-	struct pci_dev *pdev = dpc->dev->port;
+	struct pci_dev *pdev = dpc->pdev;
 	u16 cap = dpc->cap_pos, status;
 
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
@@ -299,7 +299,7 @@ static int dpc_probe(struct pcie_device *dev)
 		return -ENOMEM;
 
 	dpc->cap_pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DPC);
-	dpc->dev = dev;
+	dpc->pdev = pdev;
 	set_service_data(dev, dpc);
 
 	status = devm_request_threaded_irq(device, dev->irq, dpc_irq,
-- 
2.21.0

