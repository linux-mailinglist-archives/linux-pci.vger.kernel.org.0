Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E7043197E
	for <lists+linux-pci@lfdr.de>; Mon, 18 Oct 2021 14:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbhJRMnb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Oct 2021 08:43:31 -0400
Received: from mx24.baidu.com ([111.206.215.185]:54154 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231601AbhJRMna (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Oct 2021 08:43:30 -0400
Received: from BJHW-Mail-Ex07.internal.baidu.com (unknown [10.127.64.17])
        by Forcepoint Email with ESMTPS id 10DF484695B7C702BF99;
        Mon, 18 Oct 2021 20:41:12 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex07.internal.baidu.com (10.127.64.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Mon, 18 Oct 2021 20:41:11 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Mon, 18 Oct 2021 20:41:11 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <hch@infradead.org>
CC:     Cai Huoqing <caihuoqing@baidu.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] PCI: Remove the unused pci wrappers pci_pool_xxx()
Date:   Mon, 18 Oct 2021 20:41:09 +0800
Message-ID: <20211018124110.214-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex15.internal.baidu.com (10.127.64.38) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex07_2021-10-18 20:41:11:925
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The wrappers around dma_pool_xxx should go away, so
remove the unused pci wrappers.
Prefer using dma_pool_xxx() instead of the pci wrappers
pci_pool_xxx(), and the use of pci_pool_xxx was already
removed.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
v1->v2: *Revert the implicit inclusion of dma_pool.h

 include/linux/pci.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 94c75f3a4a19..74529d0388de 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1500,19 +1500,8 @@ int pci_set_vga_state(struct pci_dev *pdev, bool decode,
 #define PCI_IRQ_ALL_TYPES \
 	(PCI_IRQ_LEGACY | PCI_IRQ_MSI | PCI_IRQ_MSIX)
 
-/* kmem_cache style wrapper around pci_alloc_consistent() */
-
 #include <linux/dmapool.h>
 
-#define	pci_pool dma_pool
-#define pci_pool_create(name, pdev, size, align, allocation) \
-		dma_pool_create(name, &pdev->dev, size, align, allocation)
-#define	pci_pool_destroy(pool) dma_pool_destroy(pool)
-#define	pci_pool_alloc(pool, flags, handle) dma_pool_alloc(pool, flags, handle)
-#define	pci_pool_zalloc(pool, flags, handle) \
-		dma_pool_zalloc(pool, flags, handle)
-#define	pci_pool_free(pool, vaddr, addr) dma_pool_free(pool, vaddr, addr)
-
 struct msix_entry {
 	u32	vector;	/* Kernel uses to write allocated vector */
 	u16	entry;	/* Driver uses to specify entry, OS writes */
-- 
2.25.1

