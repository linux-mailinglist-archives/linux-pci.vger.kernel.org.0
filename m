Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D7649EF34
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jan 2022 01:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344491AbiA1A00 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jan 2022 19:26:26 -0500
Received: from ale.deltatee.com ([204.191.154.188]:46980 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235714AbiA1A00 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Jan 2022 19:26:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=bRKwNbLS7GTorTVqHwjsOSnom3kuz6wsSSmUEePGzuc=; b=bbCGCv2EfpiJjjFaP9abLvC1cM
        Sm++joV+vIhFDE3ycOTZUG498KzRrSdEDKEN9SQIIZUdbhc/YoQ0DfjQMkERarIVbrRXVK6w2CSPZ
        AwcM72rvP+JqOvBa+3q4iZDXBxHGKa5KJVDotidYB/zfXPJtcPv9FjbpNJc4lVVYY36VJ1bW1BEBo
        CRlyTYkBXN6VJFG77/h9nzmY6aSthXmwEKGNBwhM4NSTdBkAVdpPgcp8zZPZDr4HFIa4YC4KZX4Yf
        6V9SzQVNljq015M1B9bdjnNhtFDKymD2AgeAianLjdGqdqYecjHiGk8E1Tz1MtYAaWItofLbzhgHj
        e6SlzPQA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nDF5r-005OcX-Pi; Thu, 27 Jan 2022 17:26:24 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nDF5p-0001dT-Uz; Thu, 27 Jan 2022 17:26:22 -0700
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
        Ralph Campbell <rcampbell@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 27 Jan 2022 17:26:12 -0700
Message-Id: <20220128002614.6136-23-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220128002614.6136-1-logang@deltatee.com>
References: <20220128002614.6136-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de, jgg@ziepe.ca, christian.koenig@amd.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com, andrzej.jakowski@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, jhubbard@nvidia.com, rcampbell@nvidia.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_FREE,MYRULES_NO_TEXT autolearn=no autolearn_force=no
        version=3.4.6
Subject: [PATCH v5 22/24] mm: use custom page_free for P2PDMA pages
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
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
 drivers/pci/p2pdma.c | 13 +++++++++++++
 mm/memremap.c        |  5 +++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index e66694cc9e14..3a24bf5099cf 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -101,6 +101,18 @@ static const struct attribute_group p2pmem_group = {
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
@@ -198,6 +210,7 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 	pgmap->range.end = pgmap->range.start + size - 1;
 	pgmap->nr_range = 1;
 	pgmap->type = MEMORY_DEVICE_PCI_P2PDMA;
+	pgmap->ops = &p2pdma_pgmap_ops;
 
 	p2p_pgmap->provider = pdev;
 	p2p_pgmap->bus_offset = pci_bus_address(pdev, bar) -
diff --git a/mm/memremap.c b/mm/memremap.c
index 0fc8b85d792e..ced9448ddcb4 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -299,6 +299,10 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
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
@@ -460,6 +464,7 @@ void free_zone_device_page(struct page *page)
 {
 	switch (page->pgmap->type) {
 	case MEMORY_DEVICE_PRIVATE:
+	case MEMORY_DEVICE_PCI_P2PDMA:
 		free_device_page(page);
 		return;
 	case MEMORY_DEVICE_FS_DAX:
-- 
2.30.2

