Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91B51B5230
	for <lists+linux-pci@lfdr.de>; Thu, 23 Apr 2020 03:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgDWB6d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Apr 2020 21:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgDWB6d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Apr 2020 21:58:33 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5115C03C1AA
        for <linux-pci@vger.kernel.org>; Wed, 22 Apr 2020 18:58:32 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id e6so1796510pjt.4
        for <linux-pci@vger.kernel.org>; Wed, 22 Apr 2020 18:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=x5efM2ueg20lQ5Hrj0oF5TwSG9LnE5AUjxtjD5ZG32I=;
        b=hU3LyJMKSmmn63z1aHIZgrx254yPmKYjpIvHf4WJgjn8JkXXnXca1Xfl+CZqBMzQIG
         H/yRTQeTMWY6H7zPxIh6JIATFNMRpQvueOfcWL4+8eQcWOTt1hYO4m53l31qUbQjtw9b
         zDLmEK4Pv7AfZPRGiLCipfcIr++IL7CNNszKTDMWUfoxT+j2cZ5XX/WYhWbuxWC+twxH
         ujnXV3kdkca3Lnym5FOhj7no5VxVNboVTGABq64511yZkhk7ULPj8CJK66crmaA8e05W
         6YKDG1gfWkOILOxdOD+Y9RLY4T8W4hWRwN/2X2f/xgG/NSQ+LQHeRWXxeqGcjicQXr/N
         55hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x5efM2ueg20lQ5Hrj0oF5TwSG9LnE5AUjxtjD5ZG32I=;
        b=dHoDrCllJAV8uFLkUyrxxqbEDmzo6VV+ngjlmysSRvNrEUYrQwJhHWBQjr/NrLctSs
         +e0rglt9izYQrVwRAOP6sD8G3aeFGmpE5XlEnwnWnUVvb2owg1S7vvB0+eYGTsRXO6eg
         ieo5ImyEli9dORXPJgtlzhWx2XEz+FVeC5WkQ4PNDmCcb+uOWmAF3VHsJG3F9a/+2V/i
         BOzTNNG5DkkheNVPhTqq4icEPssHoPewHVYIqjJv6hEQM/POoAvhxXLrfWoq1ipyZD9f
         99wWJVkvC6qPieMzVzOwOfHjWKMcplewCm/UhlRKEsm1+Z6kyU2h6788cnv84EcPq5r6
         5kzQ==
X-Gm-Message-State: AGi0PuYsjO0lYPXQDyHzsEuMEk/sOqtq6hsci7kcZkK5eqTGbXoBS/uY
        D6NQb3VB2Q5FNMB0I11DFb4R1A==
X-Google-Smtp-Source: APiQypIJz5F0oEVa34+/biHGG3V0VySH518Ee2vPNYVdEdRYI/SIiDdkdo857++PWW8Mye318vjMfA==
X-Received: by 2002:a17:90a:2401:: with SMTP id h1mr1757802pje.1.1587607112389;
        Wed, 22 Apr 2020 18:58:32 -0700 (PDT)
Received: from nuc7.sifive.com (c-24-5-48-146.hsd1.ca.comcast.net. [24.5.48.146])
        by smtp.gmail.com with ESMTPSA id 1sm532356pjc.32.2020.04.22.18.58.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Apr 2020 18:58:31 -0700 (PDT)
From:   Alan Mikhak <alan.mikhak@sifive.com>
X-Google-Original-From: Alan Mikhak < alan.mikhak@sifive.com >
To:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, gustavo.pimentel@synopsys.com,
        dan.j.williams@intel.com, vkoul@kernel.org, kishon@ti.com,
        maz@kernel.org, paul.walmsley@sifive.com
Cc:     Alan Mikhak <alan.mikhak@sifive.com>
Subject: [PATCH v2][next] dmaengine: dw-edma: Check MSI descriptor before copying
Date:   Wed, 22 Apr 2020 18:58:21 -0700
Message-Id: <1587607101-31914-1-git-send-email-alan.mikhak@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Alan Mikhak <alan.mikhak@sifive.com>

Modify dw_edma_irq_request() to check if a struct msi_desc entry exists
before copying the contents of its struct msi_msg pointer.

Without this sanity check, __get_cached_msi_msg() crashes when invoked by
dw_edma_irq_request() running on a Linux-based PCIe endpoint device. MSI
interrupt are not received by PCIe endpoint devices. If irq_get_msi_desc()
returns null, then there is no cached struct msi_msg to be copied.

This patch depends on the following patch:
[PATCH v2] dmaengine: dw-edma: Decouple dw-edma-core.c from struct pci_dev
https://patchwork.kernel.org/patch/11491757/

Rebased on linux-next which has above patch applied.

Fixes: Build error with config x86_64-randconfig-f003-20200422
Fixes: Build error with config s390-allmodconfig
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
---
 drivers/dma/dw-edma/dw-edma-core.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index db401eb11322..306ab50462be 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -13,6 +13,7 @@
 #include <linux/dmaengine.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/dma/edma.h>
 #include <linux/dma-mapping.h>
 
@@ -773,6 +774,7 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
 	u32 rd_mask = 1;
 	int i, err = 0;
 	u32 ch_cnt;
+	int irq;
 
 	ch_cnt = dw->wr_ch_cnt + dw->rd_ch_cnt;
 
@@ -781,16 +783,16 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
 
 	if (dw->nr_irqs == 1) {
 		/* Common IRQ shared among all channels */
-		err = request_irq(dw->ops->irq_vector(dev, 0),
-				  dw_edma_interrupt_common,
+		irq = dw->ops->irq_vector(dev, 0);
+		err = request_irq(irq, dw_edma_interrupt_common,
 				  IRQF_SHARED, dw->name, &dw->irq[0]);
 		if (err) {
 			dw->nr_irqs = 0;
 			return err;
 		}
 
-		get_cached_msi_msg(dw->ops->irq_vector(dev, 0),
-				   &dw->irq[0].msi);
+		if (irq_get_msi_desc(irq))
+			get_cached_msi_msg(irq, &dw->irq[0].msi);
 	} else {
 		/* Distribute IRQs equally among all channels */
 		int tmp = dw->nr_irqs;
@@ -804,7 +806,8 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
 		dw_edma_add_irq_mask(&rd_mask, *rd_alloc, dw->rd_ch_cnt);
 
 		for (i = 0; i < (*wr_alloc + *rd_alloc); i++) {
-			err = request_irq(dw->ops->irq_vector(dev, i),
+			irq = dw->ops->irq_vector(dev, i);
+			err = request_irq(irq,
 					  i < *wr_alloc ?
 						dw_edma_interrupt_write :
 						dw_edma_interrupt_read,
@@ -815,8 +818,8 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
 				return err;
 			}
 
-			get_cached_msi_msg(dw->ops->irq_vector(dev, i),
-					   &dw->irq[i].msi);
+			if (irq_get_msi_desc(irq))
+				get_cached_msi_msg(irq, &dw->irq[i].msi);
 		}
 
 		dw->nr_irqs = i;
-- 
2.7.4

