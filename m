Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65FF43E4A8
	for <lists+linux-pci@lfdr.de>; Thu, 28 Oct 2021 17:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhJ1PNM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Oct 2021 11:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbhJ1PMw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Oct 2021 11:12:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB494C0613B9
        for <linux-pci@vger.kernel.org>; Thu, 28 Oct 2021 08:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=0d1xRoNq+T8oxWvDQH/sCMyYjPJBW5ePy4wjDgpjUfw=; b=O4S7sR1otMJUaTNrG8rJafO2LU
        ntSKQpdzDeF6Y50VLoiX7FV1AQsjEHeLKTut+w8SelHOwdoOu4/RfBwZJTtbJGYx1TcKvPf5OtMQt
        2UrX33MNYkXKz94meIYMVaPx6a++pKHG2TgHrhDYYIVwZP8YkJJ7sg0uVNehHRUuq3o6xzUbbXmoe
        EUKgZfUDSfR0SjPeHHDWE4+175NIKaKXKsclRMYKfs4pIdye/4nkHDCmFgHH2VDkGQxeIrTe+vmZv
        mocjDE8x1WuhQHDI6DB2C9C894XZdGaCAcPBuFV9sPcAFH/d4WO9Cmzx0Gx4uvqApbRtZQgFQWGXu
        bpNABn7w==;
Received: from [2001:4bb8:199:7b1d:487c:3190:e387:3394] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mg72q-008NA1-1N; Thu, 28 Oct 2021 15:10:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     dan.j.williams@intel.com
Cc:     nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v2] memremap: remove support for external pgmap refcounts
Date:   Thu, 28 Oct 2021 17:10:17 +0200
Message-Id: <20211028151017.50234-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

No driver is left using the external pgmap refcount, so remove the
code to support it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---

Changes since v1:
 - fix compile in p2pdma.c
 - drop the alredy merged first patch

 drivers/pci/p2pdma.c              |  2 +-
 include/linux/memremap.h          | 18 ++--------
 mm/memremap.c                     | 59 +++++++------------------------
 tools/testing/nvdimm/test/iomap.c | 43 +++++++---------------
 4 files changed, 28 insertions(+), 94 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 50cdde3e9a8b2..316fd2f44df45 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -219,7 +219,7 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 	error = gen_pool_add_owner(p2pdma->pool, (unsigned long)addr,
 			pci_bus_address(pdev, bar) + offset,
 			range_len(&pgmap->range), dev_to_node(&pdev->dev),
-			pgmap->ref);
+			&pgmap->ref);
 	if (error)
 		goto pages_free;
 
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index c0e9d35889e8d..a8bc588fe7aa8 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -72,16 +72,6 @@ struct dev_pagemap_ops {
 	 */
 	void (*page_free)(struct page *page);
 
-	/*
-	 * Transition the refcount in struct dev_pagemap to the dead state.
-	 */
-	void (*kill)(struct dev_pagemap *pgmap);
-
-	/*
-	 * Wait for refcount in struct dev_pagemap to be idle and reap it.
-	 */
-	void (*cleanup)(struct dev_pagemap *pgmap);
-
 	/*
 	 * Used for private (un-addressable) device memory only.  Must migrate
 	 * the page back to a CPU accessible page.
@@ -95,8 +85,7 @@ struct dev_pagemap_ops {
  * struct dev_pagemap - metadata for ZONE_DEVICE mappings
  * @altmap: pre-allocated/reserved memory for vmemmap allocations
  * @ref: reference count that pins the devm_memremap_pages() mapping
- * @internal_ref: internal reference if @ref is not provided by the caller
- * @done: completion for @internal_ref
+ * @done: completion for @ref
  * @type: memory type: see MEMORY_* in memory_hotplug.h
  * @flags: PGMAP_* flags to specify defailed behavior
  * @ops: method table
@@ -109,8 +98,7 @@ struct dev_pagemap_ops {
  */
 struct dev_pagemap {
 	struct vmem_altmap altmap;
-	struct percpu_ref *ref;
-	struct percpu_ref internal_ref;
+	struct percpu_ref ref;
 	struct completion done;
 	enum memory_type type;
 	unsigned int flags;
@@ -191,7 +179,7 @@ static inline unsigned long memremap_compat_align(void)
 static inline void put_dev_pagemap(struct dev_pagemap *pgmap)
 {
 	if (pgmap)
-		percpu_ref_put(pgmap->ref);
+		percpu_ref_put(&pgmap->ref);
 }
 
 #endif /* _LINUX_MEMREMAP_H_ */
diff --git a/mm/memremap.c b/mm/memremap.c
index ed593bf87109a..d7034c55d0a24 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -112,30 +112,6 @@ static unsigned long pfn_next(unsigned long pfn)
 #define for_each_device_pfn(pfn, map, i) \
 	for (pfn = pfn_first(map, i); pfn < pfn_end(map, i); pfn = pfn_next(pfn))
 
-static void dev_pagemap_kill(struct dev_pagemap *pgmap)
-{
-	if (pgmap->ops && pgmap->ops->kill)
-		pgmap->ops->kill(pgmap);
-	else
-		percpu_ref_kill(pgmap->ref);
-}
-
-static void dev_pagemap_cleanup(struct dev_pagemap *pgmap)
-{
-	if (pgmap->ops && pgmap->ops->cleanup) {
-		pgmap->ops->cleanup(pgmap);
-	} else {
-		wait_for_completion(&pgmap->done);
-		percpu_ref_exit(pgmap->ref);
-	}
-	/*
-	 * Undo the pgmap ref assignment for the internal case as the
-	 * caller may re-enable the same pgmap.
-	 */
-	if (pgmap->ref == &pgmap->internal_ref)
-		pgmap->ref = NULL;
-}
-
 static void pageunmap_range(struct dev_pagemap *pgmap, int range_id)
 {
 	struct range *range = &pgmap->ranges[range_id];
@@ -167,11 +143,12 @@ void memunmap_pages(struct dev_pagemap *pgmap)
 	unsigned long pfn;
 	int i;
 
-	dev_pagemap_kill(pgmap);
+	percpu_ref_kill(&pgmap->ref);
 	for (i = 0; i < pgmap->nr_range; i++)
 		for_each_device_pfn(pfn, pgmap, i)
 			put_page(pfn_to_page(pfn));
-	dev_pagemap_cleanup(pgmap);
+	wait_for_completion(&pgmap->done);
+	percpu_ref_exit(&pgmap->ref);
 
 	for (i = 0; i < pgmap->nr_range; i++)
 		pageunmap_range(pgmap, i);
@@ -188,8 +165,7 @@ static void devm_memremap_pages_release(void *data)
 
 static void dev_pagemap_percpu_release(struct percpu_ref *ref)
 {
-	struct dev_pagemap *pgmap =
-		container_of(ref, struct dev_pagemap, internal_ref);
+	struct dev_pagemap *pgmap = container_of(ref, struct dev_pagemap, ref);
 
 	complete(&pgmap->done);
 }
@@ -295,8 +271,8 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
 	memmap_init_zone_device(&NODE_DATA(nid)->node_zones[ZONE_DEVICE],
 				PHYS_PFN(range->start),
 				PHYS_PFN(range_len(range)), pgmap);
-	percpu_ref_get_many(pgmap->ref, pfn_end(pgmap, range_id)
-			- pfn_first(pgmap, range_id));
+	percpu_ref_get_many(&pgmap->ref,
+		pfn_end(pgmap, range_id) - pfn_first(pgmap, range_id));
 	return 0;
 
 err_add_memory:
@@ -362,22 +338,11 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
 		break;
 	}
 
-	if (!pgmap->ref) {
-		if (pgmap->ops && (pgmap->ops->kill || pgmap->ops->cleanup))
-			return ERR_PTR(-EINVAL);
-
-		init_completion(&pgmap->done);
-		error = percpu_ref_init(&pgmap->internal_ref,
-				dev_pagemap_percpu_release, 0, GFP_KERNEL);
-		if (error)
-			return ERR_PTR(error);
-		pgmap->ref = &pgmap->internal_ref;
-	} else {
-		if (!pgmap->ops || !pgmap->ops->kill || !pgmap->ops->cleanup) {
-			WARN(1, "Missing reference count teardown definition\n");
-			return ERR_PTR(-EINVAL);
-		}
-	}
+	init_completion(&pgmap->done);
+	error = percpu_ref_init(&pgmap->ref, dev_pagemap_percpu_release, 0,
+				GFP_KERNEL);
+	if (error)
+		return ERR_PTR(error);
 
 	devmap_managed_enable_get(pgmap);
 
@@ -486,7 +451,7 @@ struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
 	/* fall back to slow path lookup */
 	rcu_read_lock();
 	pgmap = xa_load(&pgmap_array, PHYS_PFN(phys));
-	if (pgmap && !percpu_ref_tryget_live(pgmap->ref))
+	if (pgmap && !percpu_ref_tryget_live(&pgmap->ref))
 		pgmap = NULL;
 	rcu_read_unlock();
 
diff --git a/tools/testing/nvdimm/test/iomap.c b/tools/testing/nvdimm/test/iomap.c
index ed563bdd88f39..b752ce47ead3c 100644
--- a/tools/testing/nvdimm/test/iomap.c
+++ b/tools/testing/nvdimm/test/iomap.c
@@ -100,25 +100,17 @@ static void nfit_test_kill(void *_pgmap)
 {
 	struct dev_pagemap *pgmap = _pgmap;
 
-	WARN_ON(!pgmap || !pgmap->ref);
-
-	if (pgmap->ops && pgmap->ops->kill)
-		pgmap->ops->kill(pgmap);
-	else
-		percpu_ref_kill(pgmap->ref);
-
-	if (pgmap->ops && pgmap->ops->cleanup) {
-		pgmap->ops->cleanup(pgmap);
-	} else {
-		wait_for_completion(&pgmap->done);
-		percpu_ref_exit(pgmap->ref);
-	}
+	WARN_ON(!pgmap);
+
+	percpu_ref_kill(&pgmap->ref);
+
+	wait_for_completion(&pgmap->done);
+	percpu_ref_exit(&pgmap->ref);
 }
 
 static void dev_pagemap_percpu_release(struct percpu_ref *ref)
 {
-	struct dev_pagemap *pgmap =
-		container_of(ref, struct dev_pagemap, internal_ref);
+	struct dev_pagemap *pgmap = container_of(ref, struct dev_pagemap, ref);
 
 	complete(&pgmap->done);
 }
@@ -132,22 +124,11 @@ void *__wrap_devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 	if (!nfit_res)
 		return devm_memremap_pages(dev, pgmap);
 
-	if (!pgmap->ref) {
-		if (pgmap->ops && (pgmap->ops->kill || pgmap->ops->cleanup))
-			return ERR_PTR(-EINVAL);
-
-		init_completion(&pgmap->done);
-		error = percpu_ref_init(&pgmap->internal_ref,
-				dev_pagemap_percpu_release, 0, GFP_KERNEL);
-		if (error)
-			return ERR_PTR(error);
-		pgmap->ref = &pgmap->internal_ref;
-	} else {
-		if (!pgmap->ops || !pgmap->ops->kill || !pgmap->ops->cleanup) {
-			WARN(1, "Missing reference count teardown definition\n");
-			return ERR_PTR(-EINVAL);
-		}
-	}
+	init_completion(&pgmap->done);
+	error = percpu_ref_init(&pgmap->ref, dev_pagemap_percpu_release, 0,
+				GFP_KERNEL);
+	if (error)
+		return ERR_PTR(error);
 
 	error = devm_add_action_or_reset(dev, nfit_test_kill, pgmap);
 	if (error)
-- 
2.30.2

