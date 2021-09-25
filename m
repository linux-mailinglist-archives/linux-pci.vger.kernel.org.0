Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26F3418281
	for <lists+linux-pci@lfdr.de>; Sat, 25 Sep 2021 16:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237777AbhIYOK5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Sep 2021 10:10:57 -0400
Received: from mx24.baidu.com ([111.206.215.185]:42324 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233738AbhIYOK4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 25 Sep 2021 10:10:56 -0400
Received: from BC-Mail-HQEX01.internal.baidu.com (unknown [172.31.51.57])
        by Forcepoint Email with ESMTPS id B930C88C7835BA9E5ECE;
        Sat, 25 Sep 2021 21:53:01 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-HQEX01.internal.baidu.com (172.31.51.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Sat, 25 Sep 2021 21:53:01 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Sat, 25 Sep 2021 21:53:01 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCI: Remove the unused pci wrappers
Date:   Sat, 25 Sep 2021 21:52:54 +0800
Message-ID: <20210925135255.328-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-MAIL-EX04.internal.baidu.com (10.127.64.14) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The wrappers in include/linux/pci-dma-compat.h should go away,
so remove the unused pci wrappers.
Prefer using dma_xxx() instead of the pci wrappers pci_xxx().

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 include/linux/pci-dma-compat.h | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/include/linux/pci-dma-compat.h b/include/linux/pci-dma-compat.h
index 249d4d7fbf18..33b316f38e1d 100644
--- a/include/linux/pci-dma-compat.h
+++ b/include/linux/pci-dma-compat.h
@@ -20,13 +20,6 @@ pci_alloc_consistent(struct pci_dev *hwdev, size_t size,
 	return dma_alloc_coherent(&hwdev->dev, size, dma_handle, GFP_ATOMIC);
 }
 
-static inline void *
-pci_zalloc_consistent(struct pci_dev *hwdev, size_t size,
-		      dma_addr_t *dma_handle)
-{
-	return dma_alloc_coherent(&hwdev->dev, size, dma_handle, GFP_ATOMIC);
-}
-
 static inline void
 pci_free_consistent(struct pci_dev *hwdev, size_t size,
 		    void *vaddr, dma_addr_t dma_handle)
@@ -89,26 +82,6 @@ pci_dma_sync_single_for_device(struct pci_dev *hwdev, dma_addr_t dma_handle,
 	dma_sync_single_for_device(&hwdev->dev, dma_handle, size, (enum dma_data_direction)direction);
 }
 
-static inline void
-pci_dma_sync_sg_for_cpu(struct pci_dev *hwdev, struct scatterlist *sg,
-		int nelems, int direction)
-{
-	dma_sync_sg_for_cpu(&hwdev->dev, sg, nelems, (enum dma_data_direction)direction);
-}
-
-static inline void
-pci_dma_sync_sg_for_device(struct pci_dev *hwdev, struct scatterlist *sg,
-		int nelems, int direction)
-{
-	dma_sync_sg_for_device(&hwdev->dev, sg, nelems, (enum dma_data_direction)direction);
-}
-
-static inline int
-pci_dma_mapping_error(struct pci_dev *pdev, dma_addr_t dma_addr)
-{
-	return dma_mapping_error(&pdev->dev, dma_addr);
-}
-
 #ifdef CONFIG_PCI
 static inline int pci_set_dma_mask(struct pci_dev *dev, u64 mask)
 {
-- 
2.25.1

