Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57FFE40EE21
	for <lists+linux-pci@lfdr.de>; Fri, 17 Sep 2021 01:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241961AbhIPXmv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Sep 2021 19:42:51 -0400
Received: from ale.deltatee.com ([204.191.154.188]:40948 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241854AbhIPXmp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Sep 2021 19:42:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=ldkK6FksW6AxBSIsN/n+YIWPajMSW0GYq8IzRYvtFoM=; b=OMj+IXhA0JlmDcMTNtuw+2naNo
        h+aSEBqNXGALEhnyVoJJQ02Zj7o7Zc9QOB+HlQGmZ1MdLz/kYLSgLKXn3vNz4ZouyEjt5er7gupt5
        z33xIhm/pO6gFpEIcnqKlAvm9oUXO347Qddi9w6t//UZb/L7JZH7xFHh33H6AhrWylBygyn17hAvR
        /H1rKFjBtB7mFHaD4INKJGVdTq9Lo+eQ+MB6SpwSuitUO/WBujObJ655/GoumkDOgj9twvXY2vM0F
        47f1/CRT1Dc+KenE0m9BVndGCJMkc2kcmbKYHLNSMJpiFZ895GlsBV2IabtQxZ81oTtdlhF9V5ps0
        h1jpMxjA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1mR10A-0008Hz-91; Thu, 16 Sep 2021 17:41:23 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1mR106-000Vrq-CV; Thu, 16 Sep 2021 17:41:06 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 16 Sep 2021 17:40:58 -0600
Message-Id: <20210916234100.122368-19-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210916234100.122368-1-logang@deltatee.com>
References: <20210916234100.122368-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de, jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com, andrzej.jakowski@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_FREE autolearn=no autolearn_force=no version=3.4.2
Subject: [PATCH v3 18/20] mm: use custom page_free for P2PDMA pages
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When P2PDMA pages are passed to userspace, they will need to be
reference counted properly and returned to their genalloc after their
reference count returns to 1. This is accomplished with the existing
DEV_PAGEMAP_OPS and the .page_free() operation.

Change CONFIG_P2PDMA to select CONFIG_DEV_PAGEMAP_OPS and add
MEMORY_DEVICE_PCI_P2PDMA to page_is_devmap_managed(),
devmap_managed_enable_[put|get]() and free_devmap_managed_page().

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/Kconfig  |  1 +
 drivers/pci/p2pdma.c | 13 +++++++++++++
 include/linux/mm.h   |  1 +
 mm/memremap.c        | 12 +++++++++---
 4 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 90b4bddb3300..b31d35259d3a 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -165,6 +165,7 @@ config PCI_P2PDMA
 	bool "PCI peer-to-peer transfer support"
 	depends on ZONE_DEVICE && 64BIT
 	select GENERIC_ALLOCATOR
+	select DEV_PAGEMAP_OPS
 	help
 	  Enableѕ drivers to do PCI peer-to-peer transactions to and from
 	  BARs that are exposed in other devices that are the part of
diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 4478633346bd..2422af5a529c 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -100,6 +100,18 @@ static const struct attribute_group p2pmem_group = {
 	.name = "p2pmem",
 };
 
+static void p2pdma_page_free(struct page *page)
+{
+	struct pci_p2pdma_pagemap *pgmap = to_p2p_pgmap(page->pgmap);
+
+	gen_pool_free(pgmap->provider->p2pdma->pool,
+		      (uintptr_t)page_to_virt(page), PAGE_SIZE);
+}
+
+static const struct dev_pagemap_ops p2pdma_pgmap_ops = {
+	.page_free = p2pdma_page_free,
+};
+
 static void pci_p2pdma_release(void *data)
 {
 	struct pci_dev *pdev = data;
@@ -197,6 +209,7 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 	pgmap->range.end = pgmap->range.start + size - 1;
 	pgmap->nr_range = 1;
 	pgmap->type = MEMORY_DEVICE_PCI_P2PDMA;
+	pgmap->ops = &p2pdma_pgmap_ops;
 
 	p2p_pgmap->provider = pdev;
 	p2p_pgmap->bus_offset = pci_bus_address(pdev, bar) -
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6afdc09d0712..9a6ea00e5292 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1163,6 +1163,7 @@ static inline bool page_is_devmap_managed(struct page *page)
 	switch (page->pgmap->type) {
 	case MEMORY_DEVICE_PRIVATE:
 	case MEMORY_DEVICE_FS_DAX:
+	case MEMORY_DEVICE_PCI_P2PDMA:
 		return true;
 	default:
 		break;
diff --git a/mm/memremap.c b/mm/memremap.c
index ceebdb8a72bb..fbdc9991af0e 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -44,14 +44,16 @@ EXPORT_SYMBOL(devmap_managed_key);
 static void devmap_managed_enable_put(struct dev_pagemap *pgmap)
 {
 	if (pgmap->type == MEMORY_DEVICE_PRIVATE ||
-	    pgmap->type == MEMORY_DEVICE_FS_DAX)
+	    pgmap->type == MEMORY_DEVICE_FS_DAX ||
+	    pgmap->type == MEMORY_DEVICE_PCI_P2PDMA)
 		static_branch_dec(&devmap_managed_key);
 }
 
 static void devmap_managed_enable_get(struct dev_pagemap *pgmap)
 {
 	if (pgmap->type == MEMORY_DEVICE_PRIVATE ||
-	    pgmap->type == MEMORY_DEVICE_FS_DAX)
+	    pgmap->type == MEMORY_DEVICE_FS_DAX ||
+	    pgmap->type == MEMORY_DEVICE_PCI_P2PDMA)
 		static_branch_inc(&devmap_managed_key);
 }
 #else
@@ -355,6 +357,10 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
 	case MEMORY_DEVICE_GENERIC:
 		break;
 	case MEMORY_DEVICE_PCI_P2PDMA:
+		if (!pgmap->ops->page_free) {
+			WARN(1, "Missing page_free method\n");
+			return ERR_PTR(-EINVAL);
+		}
 		params.pgprot = pgprot_noncached(params.pgprot);
 		break;
 	default:
@@ -504,7 +510,7 @@ EXPORT_SYMBOL_GPL(get_dev_pagemap);
 void free_devmap_managed_page(struct page *page)
 {
 	/* notify page idle for dax */
-	if (!is_device_private_page(page)) {
+	if (!is_device_private_page(page) && !is_pci_p2pdma_page(page)) {
 		wake_up_var(&page->_refcount);
 		return;
 	}
-- 
2.30.2

