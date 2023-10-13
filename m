Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E967C844A
	for <lists+linux-pci@lfdr.de>; Fri, 13 Oct 2023 13:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjJMLUm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Oct 2023 07:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjJMLUj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Oct 2023 07:20:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34307F4;
        Fri, 13 Oct 2023 04:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697196035; x=1728732035;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dkn+65kr19++pCpCEps7bBc1itglQiK0Qt3T2dobeF0=;
  b=W9IrtXhzDjyiOWt3JwZSggkZFykbj/FS9fkU4uz2b8tpZDm8nw2pXA/9
   Rlso3Kz00YrSeDYid4MsXEAeU5HrQfBqtyj/+RL/Alre0RzNL0ILT2Jxa
   BzcFhEvbT7l0d398r7UvIu2oa2PkzBeu9k2a95+m1Lietnoxal8pn+gzA
   c/j2G/H1SWnLO7/g3TbepSf8zmQHSX1oF7tZWZrwcxK1iwc8i0yW/tuWW
   dtPXRFejyKTf/QxfkI2GwAW5yCmYUAduH1vSzZdzqBxbpS7djg4mxkn4f
   14zQAdcZuqAdGl9nwn59UJbKP/bpJWOVzuYpePeIRmdgPp4PT6uD8iF5N
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="3759008"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="3759008"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 04:20:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="1086104467"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="1086104467"
Received: from rhaeussl-mobl.ger.corp.intel.com (HELO localhost) ([10.252.58.47])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 04:20:31 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/2] PCI/DPC: Use defines with register fields
Date:   Fri, 13 Oct 2023 14:20:04 +0300
Message-Id: <20231013112004.4239-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231013112004.4239-1-ilpo.jarvinen@linux.intel.com>
References: <20231013112004.4239-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use defines instead of literals and replace custom masking and shifts
with FIELD_GET() where it makes sense.

While at it, group PCI_EXP_DPC_CTL RMW and pci_info() lines together
as it makes the code intent slightly easier to follow.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pcie/dpc.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 3ceed8e3de41..81e06639cb8a 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -9,6 +9,7 @@
 #define dev_fmt(fmt) "DPC: " fmt
 
 #include <linux/aer.h>
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
@@ -202,7 +203,7 @@ static void dpc_process_rp_pio_error(struct pci_dev *pdev)
 
 	/* Get First Error Pointer */
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &dpc_status);
-	first_error = (dpc_status & 0x1f00) >> 8;
+	first_error = FIELD_GET(PCI_EXP_DPC_RP_PIO_FEP, dpc_status);
 
 	for (i = 0; i < ARRAY_SIZE(rp_pio_error_string); i++) {
 		if ((status & ~mask) & (1 << i))
@@ -270,20 +271,27 @@ void dpc_process_error(struct pci_dev *pdev)
 	pci_info(pdev, "containment event, status:%#06x source:%#06x\n",
 		 status, source);
 
-	reason = (status & PCI_EXP_DPC_STATUS_TRIGGER_RSN) >> 1;
-	ext_reason = (status & PCI_EXP_DPC_STATUS_TRIGGER_RSN_EXT) >> 5;
+	reason = status & PCI_EXP_DPC_STATUS_TRIGGER_RSN;
+	ext_reason = status & PCI_EXP_DPC_STATUS_TRIGGER_RSN_EXT;
 	pci_warn(pdev, "%s detected\n",
-		 (reason == 0) ? "unmasked uncorrectable error" :
-		 (reason == 1) ? "ERR_NONFATAL" :
-		 (reason == 2) ? "ERR_FATAL" :
-		 (ext_reason == 0) ? "RP PIO error" :
-		 (ext_reason == 1) ? "software trigger" :
-				     "reserved error");
+		 (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_UNCOR) ?
+		 "unmasked uncorrectable error" :
+		 (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_NFE) ?
+		 "ERR_NONFATAL" :
+		 (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_FE) ?
+		 "ERR_FATAL" :
+		 (ext_reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_RP_PIO) ?
+		 "RP PIO error" :
+		 (ext_reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_SW_TRIGGER) ?
+		 "software trigger" :
+		 "reserved error");
 
 	/* show RP PIO error detail information */
-	if (pdev->dpc_rp_extensions && reason == 3 && ext_reason == 0)
+	if (pdev->dpc_rp_extensions &&
+	    reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_IN_EXT &&
+	    ext_reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_RP_PIO)
 		dpc_process_rp_pio_error(pdev);
-	else if (reason == 0 &&
+	else if (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_UNCOR &&
 		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
 		 aer_get_device_error_info(pdev, &info)) {
 		aer_print_error(pdev, &info);
@@ -338,7 +346,7 @@ void pci_dpc_init(struct pci_dev *pdev)
 	/* Quirks may set dpc_rp_log_size if device or firmware is buggy */
 	if (!pdev->dpc_rp_log_size) {
 		pdev->dpc_rp_log_size =
-			(cap & PCI_EXP_DPC_RP_PIO_LOG_SIZE) >> 8;
+			FIELD_GET(PCI_EXP_DPC_RP_PIO_LOG_SIZE, cap);
 		if (pdev->dpc_rp_log_size < 4 || pdev->dpc_rp_log_size > 9) {
 			pci_err(pdev, "RP PIO log size %u is invalid\n",
 				pdev->dpc_rp_log_size);
@@ -368,12 +376,13 @@ static int dpc_probe(struct pcie_device *dev)
 	}
 
 	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CAP, &cap);
-	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
 
-	ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
+	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
+	ctl |= PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
+	ctl &= ~PCI_EXP_DPC_CTL_EN_NONFATAL;
 	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);
-	pci_info(pdev, "enabled with IRQ %d\n", dev->irq);
 
+	pci_info(pdev, "enabled with IRQ %d\n", dev->irq);
 	pci_info(pdev, "error containment capabilities: Int Msg #%d, RPExt%c PoisonedTLP%c SwTrigger%c RP PIO Log %d, DL_ActiveErr%c\n",
 		 cap & PCI_EXP_DPC_IRQ, FLAG(cap, PCI_EXP_DPC_CAP_RP_EXT),
 		 FLAG(cap, PCI_EXP_DPC_CAP_POISONED_TLP),
-- 
2.30.2

