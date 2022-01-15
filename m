Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9734248F76C
	for <lists+linux-pci@lfdr.de>; Sat, 15 Jan 2022 16:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbiAOPUp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 Jan 2022 10:20:45 -0500
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:57467 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbiAOPUp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 15 Jan 2022 10:20:45 -0500
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id 8krBn6lOIrdkG8krCnQwSd; Sat, 15 Jan 2022 16:20:43 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 15 Jan 2022 16:20:43 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-pci@vger.kernel.org
Subject: [PATCH] PCI: vmd: Remove useless DMA-32 fallback configuration
Date:   Sat, 15 Jan 2022 16:20:29 +0100
Message-Id: <f10bb9f76b275a74b4efd7661bf9499a8b72eaa2.1642259917.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As stated in [1], dma_set_mask() with a 64-bit mask never fails if
dev->dma_mask is non-NULL.
So, if it fails, the 32 bits case will also fail for the same reason.

Simplify code and remove some dead code accordingly.

[1]: https://lore.kernel.org/linux-kernel/YL3vSPK5DXTNvgdx@infradead.org/#t

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/pci/controller/vmd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index cc166c683638..dead82b23a98 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -914,8 +914,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	}
 
 	pci_set_master(dev);
-	if (dma_set_mask_and_coherent(&dev->dev, DMA_BIT_MASK(64)) &&
-	    dma_set_mask_and_coherent(&dev->dev, DMA_BIT_MASK(32))) {
+	if (dma_set_mask_and_coherent(&dev->dev, DMA_BIT_MASK(64))) {
 		err = -ENODEV;
 		goto out_release_instance;
 	}
-- 
2.32.0

