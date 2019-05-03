Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4F212694
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2019 06:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbfECEAT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 May 2019 00:00:19 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44443 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfECEAS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 May 2019 00:00:18 -0400
Received: by mail-oi1-f196.google.com with SMTP id t184so3394696oie.11
        for <linux-pci@vger.kernel.org>; Thu, 02 May 2019 21:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fredlawl-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ehFlep6RHoGfNzKXt68A98xnVIeOv0Wgz2pAcINSx0w=;
        b=LVK1/bG0FMi2gOxnOUtEdOrc2NC+ARCm+f2q/4zQN/10NQHVwIdYsz3xLeUZseeH0A
         lZ5aeqYGQoqLG9yE5KMkS++MjXsy/j1sQz09TwaaALOD2R7QS/hskG6NbVVzlHEJ6Vcx
         1OPYo+vsjaQXGksUnrvS3kRu/xxWJCItyTo5C015thwhvXemFz0Kay+yBgotRw/od6oX
         uZYOsLPIXx1/yNniP1EVU/1Ci/ORc3bc9hVs7uCrn4EGBJpgN/EwiOHzWx5N4OJETk3r
         d+TeGTlCwuxUvPUmy2EKZVApiz6A82ysFUOv938B9Tzv4FFfPQrwbANFl5eV98nnkK+i
         51bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ehFlep6RHoGfNzKXt68A98xnVIeOv0Wgz2pAcINSx0w=;
        b=W3DKo+oF7f5lB5oSJG6DEevHQP73V9QsW6Qb5BZ2Fet7i0voOFKg7daubkn5+ozlKU
         cprcsqxbniwcQgPJ9SSka+XWoLA2btGWGYHK8VSXGZtbfVUVw9MLLJoFUIKZMbSWZsDZ
         QGI7MQHqCn0wTjqxLP04n63FkRnKSpWdDH4j8SvhW+nT3Q9P0f95RHAZ7gX3jIv+Zih5
         orMd6u9lSj/3a/PtkogM1nttlcDDPOalDykqu65SFMrKW1wgmwL3MSMPNf2aH/z9tEiu
         Mn1gkdJ1FoCw5B61wz9kw2g/NYmJf3BAGEI9oRU12lLEHerdPXt2gi+xY8Cx/JYBLFV9
         3Otg==
X-Gm-Message-State: APjAAAX8JCM+qj+rEc5jpc17DAG/pxZVkyuDhvT2tQ1R3nI0ACqTBiHr
        O5dTfpRpcAvgfBpKfn/5hd3Nsw==
X-Google-Smtp-Source: APXvYqwudvvXv9QrPckqhB9/9QIEdpPo75PqFD8VCoGOI3bQltuttSiRozB9BZDZUI1iOVIfENcgEg==
X-Received: by 2002:aca:6c47:: with SMTP id h68mr5139285oic.57.1556856017635;
        Thu, 02 May 2019 21:00:17 -0700 (PDT)
Received: from linux.fredlawl.com ([2600:1700:18a0:11d0:5518:38b8:ef25:393a])
        by smtp.gmail.com with ESMTPSA id u22sm419161otk.49.2019.05.02.21.00.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 21:00:16 -0700 (PDT)
From:   Frederick Lawler <fred@fredlawl.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mika.westerberg@linux.intel.com, lukas@wunner.de,
        andriy.shevchenko@linux.intel.com, keith.busch@intel.com,
        mr.nuke.me@gmail.com, liudongdong3@huawei.com, thesven73@gmail.com,
        Frederick Lawler <fred@fredlawl.com>
Subject: [PATCH v2 2/9] PCI/DPC: Prefix dmesg logs with PCIe service name
Date:   Thu,  2 May 2019 22:59:39 -0500
Message-Id: <20190503035946.23608-3-fred@fredlawl.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190503035946.23608-1-fred@fredlawl.com>
References: <20190503035946.23608-1-fred@fredlawl.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Prefix dmesg logs with PCIe service name.

Signed-off-by: Frederick Lawler <fred@fredlawl.com>
---
 drivers/pci/pcie/dpc.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 7b77754a82de..934391c91c23 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -6,6 +6,8 @@
  * Copyright (C) 2016 Intel Corp.
  */
 
+#define dev_fmt(fmt) "DPC: " fmt
+
 #include <linux/aer.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
@@ -100,7 +102,6 @@ static int dpc_wait_rp_inactive(struct dpc_dev *dpc)
 {
 	unsigned long timeout = jiffies + HZ;
 	struct pci_dev *pdev = dpc->dev->port;
-	struct device *dev = &dpc->dev->device;
 	u16 cap = dpc->cap_pos, status;
 
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
@@ -110,7 +111,7 @@ static int dpc_wait_rp_inactive(struct dpc_dev *dpc)
 		pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
 	}
 	if (status & PCI_EXP_DPC_RP_BUSY) {
-		dev_warn(dev, "DPC root port still busy\n");
+		pci_warn(pdev, "DPC root port still busy\n");
 		return -EBUSY;
 	}
 	return 0;
@@ -148,7 +149,6 @@ static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
 
 static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
 {
-	struct device *dev = &dpc->dev->device;
 	struct pci_dev *pdev = dpc->dev->port;
 	u16 cap = dpc->cap_pos, dpc_status, first_error;
 	u32 status, mask, sev, syserr, exc, dw0, dw1, dw2, dw3, log, prefix;
@@ -156,13 +156,13 @@ static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
 
 	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_STATUS, &status);
 	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_MASK, &mask);
-	dev_err(dev, "rp_pio_status: %#010x, rp_pio_mask: %#010x\n",
+	pci_err(pdev, "rp_pio_status: %#010x, rp_pio_mask: %#010x\n",
 		status, mask);
 
 	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_SEVERITY, &sev);
 	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_SYSERROR, &syserr);
 	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_EXCEPTION, &exc);
-	dev_err(dev, "RP PIO severity=%#010x, syserror=%#010x, exception=%#010x\n",
+	pci_err(pdev, "RP PIO severity=%#010x, syserror=%#010x, exception=%#010x\n",
 		sev, syserr, exc);
 
 	/* Get First Error Pointer */
@@ -171,7 +171,7 @@ static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
 
 	for (i = 0; i < ARRAY_SIZE(rp_pio_error_string); i++) {
 		if ((status & ~mask) & (1 << i))
-			dev_err(dev, "[%2d] %s%s\n", i, rp_pio_error_string[i],
+			pci_err(pdev, "[%2d] %s%s\n", i, rp_pio_error_string[i],
 				first_error == i ? " (First)" : "");
 	}
 
@@ -185,18 +185,18 @@ static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
 			      &dw2);
 	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_HEADER_LOG + 12,
 			      &dw3);
-	dev_err(dev, "TLP Header: %#010x %#010x %#010x %#010x\n",
+	pci_err(pdev, "TLP Header: %#010x %#010x %#010x %#010x\n",
 		dw0, dw1, dw2, dw3);
 
 	if (dpc->rp_log_size < 5)
 		goto clear_status;
 	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_IMPSPEC_LOG, &log);
-	dev_err(dev, "RP PIO ImpSpec Log %#010x\n", log);
+	pci_err(pdev, "RP PIO ImpSpec Log %#010x\n", log);
 
 	for (i = 0; i < dpc->rp_log_size - 5; i++) {
 		pci_read_config_dword(pdev,
 			cap + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG, &prefix);
-		dev_err(dev, "TLP Prefix Header: dw%d, %#010x\n", i, prefix);
+		pci_err(pdev, "TLP Prefix Header: dw%d, %#010x\n", i, prefix);
 	}
  clear_status:
 	pci_write_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_STATUS, status);
@@ -229,18 +229,17 @@ static irqreturn_t dpc_handler(int irq, void *context)
 	struct aer_err_info info;
 	struct dpc_dev *dpc = context;
 	struct pci_dev *pdev = dpc->dev->port;
-	struct device *dev = &dpc->dev->device;
 	u16 cap = dpc->cap_pos, status, source, reason, ext_reason;
 
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID, &source);
 
-	dev_info(dev, "DPC containment event, status:%#06x source:%#06x\n",
+	pci_info(pdev, "DPC containment event, status:%#06x source:%#06x\n",
 		 status, source);
 
 	reason = (status & PCI_EXP_DPC_STATUS_TRIGGER_RSN) >> 1;
 	ext_reason = (status & PCI_EXP_DPC_STATUS_TRIGGER_RSN_EXT) >> 5;
-	dev_warn(dev, "DPC %s detected\n",
+	pci_warn(pdev, "DPC %s detected\n",
 		 (reason == 0) ? "unmasked uncorrectable error" :
 		 (reason == 1) ? "ERR_NONFATAL" :
 		 (reason == 2) ? "ERR_FATAL" :
@@ -307,7 +306,7 @@ static int dpc_probe(struct pcie_device *dev)
 					   dpc_handler, IRQF_SHARED,
 					   "pcie-dpc", dpc);
 	if (status) {
-		dev_warn(device, "request IRQ%d failed: %d\n", dev->irq,
+		pci_warn(pdev, "request IRQ%d failed: %d\n", dev->irq,
 			 status);
 		return status;
 	}
@@ -319,7 +318,7 @@ static int dpc_probe(struct pcie_device *dev)
 	if (dpc->rp_extensions) {
 		dpc->rp_log_size = (cap & PCI_EXP_DPC_RP_PIO_LOG_SIZE) >> 8;
 		if (dpc->rp_log_size < 4 || dpc->rp_log_size > 9) {
-			dev_err(device, "RP PIO log size %u is invalid\n",
+			pci_err(pdev, "RP PIO log size %u is invalid\n",
 				dpc->rp_log_size);
 			dpc->rp_log_size = 0;
 		}
@@ -328,11 +327,11 @@ static int dpc_probe(struct pcie_device *dev)
 	ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
 	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, ctl);
 
-	dev_info(device, "DPC error containment capabilities: Int Msg #%d, RPExt%c PoisonedTLP%c SwTrigger%c RP PIO Log %d, DL_ActiveErr%c\n",
-		cap & PCI_EXP_DPC_IRQ, FLAG(cap, PCI_EXP_DPC_CAP_RP_EXT),
-		FLAG(cap, PCI_EXP_DPC_CAP_POISONED_TLP),
-		FLAG(cap, PCI_EXP_DPC_CAP_SW_TRIGGER), dpc->rp_log_size,
-		FLAG(cap, PCI_EXP_DPC_CAP_DL_ACTIVE));
+	pci_info(pdev, "DPC error containment capabilities: Int Msg #%d, RPExt%c PoisonedTLP%c SwTrigger%c RP PIO Log %d, DL_ActiveErr%c\n",
+		 cap & PCI_EXP_DPC_IRQ, FLAG(cap, PCI_EXP_DPC_CAP_RP_EXT),
+		 FLAG(cap, PCI_EXP_DPC_CAP_POISONED_TLP),
+		 FLAG(cap, PCI_EXP_DPC_CAP_SW_TRIGGER), dpc->rp_log_size,
+		 FLAG(cap, PCI_EXP_DPC_CAP_DL_ACTIVE));
 
 	pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_DPC, sizeof(u16));
 	return status;
-- 
2.17.1

