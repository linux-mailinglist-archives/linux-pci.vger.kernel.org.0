Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12BAA12D7BD
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2019 11:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfLaKBz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Dec 2019 05:01:55 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52548 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbfLaKBx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Dec 2019 05:01:53 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBVA1eJQ069033;
        Tue, 31 Dec 2019 04:01:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577786500;
        bh=b/64JglBpKY6W4ba0VJS0cOO7Ch2+G3ZysdJiabZQfo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=xHkgg8eAVctAYV1Zhn+azqu4KozF0iGsaicpEBgDz4t+y+tWiIbUI0ctc1tCTHwqW
         +lQdlMqAjLtMBV2G09gh7hI3fzVbZYPbXaYw+NYp04+BTcVmjb5Ayk9XqzlCPHYFhw
         hSOyi+sNSO98z26jocV3MmZ/lWbepQI2TgdMMVuA=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBVA1eFh079660
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 31 Dec 2019 04:01:40 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 31
 Dec 2019 04:01:39 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 31 Dec 2019 04:01:39 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBVA1TZi020876;
        Tue, 31 Dec 2019 04:01:37 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <andrew.murray@arm.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/5] PCI: endpoint: Protect concurrent access to memory allocation with mutex
Date:   Tue, 31 Dec 2019 15:33:29 +0530
Message-ID: <20191231100331.6316-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191231100331.6316-1-kishon@ti.com>
References: <20191231100331.6316-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci-epc-mem uses bitmap to manage the PCI address region. This address
region will be shared by multiple endpoint functions (in the case of
multi function endpoint) and it has to be protected from concurrent
access to avoid updating inconsistent state. Use mutex to protect while
updating bitmap.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/pci-epc-mem.c | 10 ++++++++--
 include/linux/pci-epc.h            |  3 +++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
index d2b174ce15de..abfac1109a13 100644
--- a/drivers/pci/endpoint/pci-epc-mem.c
+++ b/drivers/pci/endpoint/pci-epc-mem.c
@@ -79,6 +79,7 @@ int __pci_epc_mem_init(struct pci_epc *epc, phys_addr_t phys_base, size_t size,
 	mem->page_size = page_size;
 	mem->pages = pages;
 	mem->size = size;
+	mutex_init(&mem->lock);
 
 	epc->mem = mem;
 
@@ -122,7 +123,7 @@ void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
 				     phys_addr_t *phys_addr, size_t size)
 {
 	int pageno;
-	void __iomem *virt_addr;
+	void __iomem *virt_addr = NULL;
 	struct pci_epc_mem *mem = epc->mem;
 	unsigned int page_shift = ilog2(mem->page_size);
 	int order;
@@ -130,15 +131,18 @@ void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
 	size = ALIGN(size, mem->page_size);
 	order = pci_epc_mem_get_order(mem, size);
 
+	mutex_lock(&mem->lock);
 	pageno = bitmap_find_free_region(mem->bitmap, mem->pages, order);
 	if (pageno < 0)
-		return NULL;
+		goto ret;
 
 	*phys_addr = mem->phys_base + ((phys_addr_t)pageno << page_shift);
 	virt_addr = ioremap(*phys_addr, size);
 	if (!virt_addr)
 		bitmap_release_region(mem->bitmap, pageno, order);
 
+ret:
+	mutex_unlock(&mem->lock);
 	return virt_addr;
 }
 EXPORT_SYMBOL_GPL(pci_epc_mem_alloc_addr);
@@ -164,7 +168,9 @@ void pci_epc_mem_free_addr(struct pci_epc *epc, phys_addr_t phys_addr,
 	pageno = (phys_addr - mem->phys_base) >> page_shift;
 	size = ALIGN(size, mem->page_size);
 	order = pci_epc_mem_get_order(mem, size);
+	mutex_lock(&mem->lock);
 	bitmap_release_region(mem->bitmap, pageno, order);
+	mutex_unlock(&mem->lock);
 }
 EXPORT_SYMBOL_GPL(pci_epc_mem_free_addr);
 
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 97c78464013c..42c2b14ea2b4 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -72,6 +72,7 @@ struct pci_epc_ops {
  * @bitmap: bitmap to manage the PCI address space
  * @pages: number of bits representing the address region
  * @page_size: size of each page
+ * @lock: mutex to protect bitmap
  */
 struct pci_epc_mem {
 	phys_addr_t	phys_base;
@@ -79,6 +80,8 @@ struct pci_epc_mem {
 	unsigned long	*bitmap;
 	size_t		page_size;
 	int		pages;
+	/* mutex to protect against concurrent access for memory allocation*/
+	struct mutex	lock;
 };
 
 /**
-- 
2.17.1

