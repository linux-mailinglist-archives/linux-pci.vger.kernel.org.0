Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1126A1B1425
	for <lists+linux-pci@lfdr.de>; Mon, 20 Apr 2020 20:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgDTSQR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Apr 2020 14:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbgDTSQQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Apr 2020 14:16:16 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBFDC061A0C
        for <linux-pci@vger.kernel.org>; Mon, 20 Apr 2020 11:16:16 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id w65so5317416pfc.12
        for <linux-pci@vger.kernel.org>; Mon, 20 Apr 2020 11:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=QUQCSO3sl8PGNrXa4jdtXmAY28M49Ft4G5H9JTodPcw=;
        b=CYie8fSQkf91EabFDU6MKKRA6RXg/CIZ6raAEDtACsf+pAkhaGG3bA/B7ftMPTNAzv
         PcogpFXonbLQ+YmmSUkglNSbsfn7wqDj82SDGr5L8FhFSAg0MYrfkfx9CStopUgtgm5q
         3L/ERws+4oT7z6ZdWKWaWCMBSf8jT3UD1zJOpHfQzDqy4j9DQ2QkluudG3Vl6MAi1Cnc
         GMciq0L9RcR+K3OlOGAp5F4E4W3lubJ0/CJtYOScGbaomeCpHasbIajOwgHvgt13m71K
         l5K/vBMgIGr9lwThmMxps+a+zMnWb1rKMDbiFJPqMMvoUkgVfLGC/xMdRcGmyPWoYJTD
         fsIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QUQCSO3sl8PGNrXa4jdtXmAY28M49Ft4G5H9JTodPcw=;
        b=DPiJW3E/i287esvvROINuHP3TKZyxxUqA4aoAiaB8ApxSaVGtt8eOPdw0ds3EI/9Gu
         DU/MmBdOhBQAgFFyluYV+TLKBJ8l9pBPxmUiiJnaKRrOr04Bpfj79a6qbuOQqm68bko0
         Jivw1Q4uR1Upzlw+VIB6m2Um7MEAErFLs3fioFGSZO2Be471jv38l1SjE9Y1zbIg/eme
         0FVDm+doYzKjqq0n6dVpJO31+1GOva2dgaFiup8o0jtOlS8R/SoFBpJEikEmUNMPB4uW
         T9c9vuuM8rk+wKw9h77AiLt35NQUfxQlQJQDINOMng6y3cjdk21i4Y8D6t1tWcyX7WAT
         PAuQ==
X-Gm-Message-State: AGi0Puaa0Iec2SzfYZ9/JwiRrFCWOvJCToCHkG3vA9IWOJlQosoKEkw5
        8AorcSmYt7IS3ec+p1PKSVAA2Q==
X-Google-Smtp-Source: APiQypKSr8NJ930Ww3r7NLKtsxj6P8B/4DFGcMVHASsZ+V6AMZEEIBGEr2AQ/j4RGvOMFYpgpdxfNg==
X-Received: by 2002:a62:874e:: with SMTP id i75mr9560713pfe.248.1587406575986;
        Mon, 20 Apr 2020 11:16:15 -0700 (PDT)
Received: from nuc7.sifive.com (c-24-5-48-146.hsd1.ca.comcast.net. [24.5.48.146])
        by smtp.gmail.com with ESMTPSA id t6sm150753pfh.98.2020.04.20.11.16.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2020 11:16:14 -0700 (PDT)
From:   Alan Mikhak <alan.mikhak@sifive.com>
X-Google-Original-From: Alan Mikhak < alan.mikhak@sifive.com >
To:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, gustavo.pimentel@synopsys.com,
        dan.j.williams@intel.com, vkoul@kernel.org, kishon@ti.com,
        maz@kernel.org, paul.walmsley@sifive.com
Cc:     Alan Mikhak <alan.mikhak@sifive.com>
Subject: [PATCH] dmaengine: dw-edma: Check MSI descriptor before copying
Date:   Mon, 20 Apr 2020 11:16:08 -0700
Message-Id: <1587406568-26592-1-git-send-email-alan.mikhak@sifive.com>
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

Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
---
 drivers/dma/dw-edma/dw-edma-core.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index db401eb11322..a5d15f6ed5eb 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -773,6 +773,7 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
 	u32 rd_mask = 1;
 	int i, err = 0;
 	u32 ch_cnt;
+	int irq;
 
 	ch_cnt = dw->wr_ch_cnt + dw->rd_ch_cnt;
 
@@ -781,16 +782,16 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
 
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
@@ -804,7 +805,8 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
 		dw_edma_add_irq_mask(&rd_mask, *rd_alloc, dw->rd_ch_cnt);
 
 		for (i = 0; i < (*wr_alloc + *rd_alloc); i++) {
-			err = request_irq(dw->ops->irq_vector(dev, i),
+			irq = dw->ops->irq_vector(dev, i);
+			err = request_irq(irq,
 					  i < *wr_alloc ?
 						dw_edma_interrupt_write :
 						dw_edma_interrupt_read,
@@ -815,8 +817,8 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
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

