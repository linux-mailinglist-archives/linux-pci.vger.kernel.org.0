Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0E1431201
	for <lists+linux-pci@lfdr.de>; Mon, 18 Oct 2021 10:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbhJRIS4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Oct 2021 04:18:56 -0400
Received: from mx24.baidu.com ([111.206.215.185]:43294 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230469AbhJRISy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Oct 2021 04:18:54 -0400
Received: from BC-Mail-Ex11.internal.baidu.com (unknown [172.31.51.51])
        by Forcepoint Email with ESMTPS id 70BFE1012CB84C20ABCE;
        Mon, 18 Oct 2021 16:16:36 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex11.internal.baidu.com (172.31.51.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Mon, 18 Oct 2021 16:16:35 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Mon, 18 Oct 2021 16:16:35 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCI: Remove the unused pci wrappers pci_pool_xxx()
Date:   Mon, 18 Oct 2021 16:16:28 +0800
Message-ID: <20211018081629.151-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex01.internal.baidu.com (10.127.64.11) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
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
 include/linux/pci.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 7e0ce3a4d5a1..98fc67ceb582 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1498,19 +1498,6 @@ int pci_set_vga_state(struct pci_dev *pdev, bool decode,
 #define PCI_IRQ_ALL_TYPES \
 	(PCI_IRQ_LEGACY | PCI_IRQ_MSI | PCI_IRQ_MSIX)
 
-/* kmem_cache style wrapper around pci_alloc_consistent() */
-
-#include <linux/dmapool.h>
-
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

