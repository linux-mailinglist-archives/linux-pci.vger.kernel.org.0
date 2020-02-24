Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5113F16A30B
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 10:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbgBXJuK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 04:50:10 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:36516 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbgBXJuJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2020 04:50:09 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01O9o542077967;
        Mon, 24 Feb 2020 03:50:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582537805;
        bh=4R+owEG12mdV/TBScFUfx88107L2rS3RYt6zKecizGw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=MmHp2q+qqi//+bT2lfaSF6XPWeT69plR3FWRrewy1DnR0T9Y47b9DpRN/PMSw9ChU
         zeakMj8SHLLwUJVbFKHFF9N/xPz1VvGWZAtbLgNJ2nhS0TiAMiNa3BCwvVUibAgEeK
         jnnNlIvUvJJyAuj+ZK7V0ejp6YwBZuUBpIexoUvE=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01O9o55M089767
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Feb 2020 03:50:05 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 24
 Feb 2020 03:50:04 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 24 Feb 2020 03:50:05 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01O9nsnE103443;
        Mon, 24 Feb 2020 03:50:02 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/5] PCI: endpoint: Fix for concurrent memory allocation in OB address region
Date:   Mon, 24 Feb 2020 15:23:36 +0530
Message-ID: <20200224095338.3758-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200224095338.3758-1-kishon@ti.com>
References: <20200224095338.3758-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci-epc-mem uses bitmap to manage the Endpoint outbound (OB) address
region. This address region will be shared by multiple endpoint
functions (in the case of multi function endpoint) and it has to be
protected from concurrent access to avoid updating inconsistent state.

Use mutex to protect while updating bitmap without which the memory
allocation API will return incorrect address.

Cc: stable@vger.kernel.org # v4.14+
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
index 9dd60f2e9705..4e3e527c49d1 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -71,6 +71,7 @@ struct pci_epc_ops {
  * @bitmap: bitmap to manage the PCI address space
  * @pages: number of bits representing the address region
  * @page_size: size of each page
+ * @lock: mutex to protect bitmap
  */
 struct pci_epc_mem {
 	phys_addr_t	phys_base;
@@ -78,6 +79,8 @@ struct pci_epc_mem {
 	unsigned long	*bitmap;
 	size_t		page_size;
 	int		pages;
+	/* mutex to protect against concurrent access for memory allocation*/
+	struct mutex	lock;
 };
 
 /**
-- 
2.17.1

