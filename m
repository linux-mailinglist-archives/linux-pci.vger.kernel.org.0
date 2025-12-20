Return-Path: <linux-pci+bounces-43454-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F947CD26E6
	for <lists+linux-pci@lfdr.de>; Sat, 20 Dec 2025 05:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA2293016EC3
	for <lists+linux-pci@lfdr.de>; Sat, 20 Dec 2025 04:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BDB2F12DF;
	Sat, 20 Dec 2025 04:16:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DE0288537;
	Sat, 20 Dec 2025 04:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766204177; cv=none; b=PEMzv3epLF7m7CPPSHfIaKMT6wrxVHSTQ+dDzYtpTG3B9zqtCHD/DL5HXLV6jvMvbC4Yk+woMMNn017KzTMLunW4uaNFXT9oaoADwEb08d6tEzninJOkgxbLTKd8TUxvMHNwKCDtr5Iul2LFvTtxA4awcs2HIV1kvgvgQO8vNnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766204177; c=relaxed/simple;
	bh=MWPqLIbDIy2eCFmEoAxxLAkBRkEpL23GYIkxYSqXz/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X3pxP5J27LedQ+Ocj9P34v++JRvvnengaeNfVulWpYJ+Qg34/+Vl/SmFMYgY5wlA5kBmaSC1lNQZtlonRw2Hqwq4rwne7oAiFoiYJWfxf3uQgTzxAeHit2dZRYYNdeP/b949GUqBcL1mPYY66S9Ak3tAxTzoVrCZ0g7Mqfg84hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dYB0V1HXlzKHMKg;
	Sat, 20 Dec 2025 12:15:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 537AF40574;
	Sat, 20 Dec 2025 12:16:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP4 (Coremail) with SMTP id gCh0CgD3WPn5IkZpFwpFAw--.56015S10;
	Sat, 20 Dec 2025 12:16:07 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org,
	linux-mm@kvack.org,
	linux-nvme@lists.infradead.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Alistair Popple <apopple@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	houtao1@huawei.com
Subject: [PATCH 06/13] PCI/P2PDMA: add align parameter for pci_p2pdma_add_resource()
Date: Sat, 20 Dec 2025 12:04:39 +0800
Message-Id: <20251220040446.274991-7-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20251220040446.274991-1-houtao@huaweicloud.com>
References: <20251220040446.274991-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3WPn5IkZpFwpFAw--.56015S10
X-Coremail-Antispam: 1UD129KBjvJXoWxtryrCF4xXw1kZrW3GFy5CFg_yoW7uF45pF
	yrA3WDGrW8Ka17J34UJa1DAF1Fvwnag34IkrW7Cws3Za43trs5tF1UCFyjkF1fGrWkC3W5
	tFWjyr1ruw1UJF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262
	kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GF
	v_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZF
	pf9x07j4fO7UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

The align parameter is used to align both the mapping of p2p dma memory
and to enable the compound page for p2p dma memory in the kernel and in
the userspace.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 drivers/accel/habanalabs/common/hldio.c |  3 +-
 drivers/nvme/host/pci.c                 |  2 +-
 drivers/pci/p2pdma.c                    | 38 +++++++++++++++++++++----
 include/linux/pci-p2pdma.h              |  4 +--
 4 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/accel/habanalabs/common/hldio.c b/drivers/accel/habanalabs/common/hldio.c
index 083ae5610875..4d1528dbde9f 100644
--- a/drivers/accel/habanalabs/common/hldio.c
+++ b/drivers/accel/habanalabs/common/hldio.c
@@ -372,7 +372,8 @@ int hl_p2p_region_init(struct hl_device *hdev, struct hl_p2p_region *p2pr)
 	int rc, i;
 
 	/* Start by publishing our p2p memory */
-	rc = pci_p2pdma_add_resource(hdev->pdev, p2pr->bar, p2pr->size, p2pr->bar_offset);
+	rc = pci_p2pdma_add_resource(hdev->pdev, p2pr->bar, p2pr->size, PAGE_SIZE,
+				     p2pr->bar_offset);
 	if (rc) {
 		dev_err(hdev->dev, "error adding p2p resource: %d\n", rc);
 		goto err;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0e4caeab739c..b070095bae5e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2309,7 +2309,7 @@ static void nvme_map_cmb(struct nvme_dev *dev)
 			     dev->bar + NVME_REG_CMBMSC);
 	}
 
-	if (pci_p2pdma_add_resource(pdev, bar, size, offset)) {
+	if (pci_p2pdma_add_resource(pdev, bar, size, PAGE_SIZE, offset)) {
 		dev_warn(dev->ctrl.device,
 			 "failed to register the CMB\n");
 		hi_lo_writeq(0, dev->bar + NVME_REG_CMBMSC);
diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index dd64ec830fdd..70482e240304 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -23,6 +23,7 @@
 
 struct pci_p2pdma {
 	struct gen_pool *pool;
+	size_t align;
 	bool p2pmem_published;
 	struct xarray map_types;
 	struct p2pdma_provider mem[PCI_STD_NUM_BARS];
@@ -211,7 +212,7 @@ static void p2pdma_folio_free(struct folio *folio)
 	struct percpu_ref *ref;
 
 	gen_pool_free_owner(p2pdma->pool, (uintptr_t)page_to_virt(page),
-			    PAGE_SIZE, (void **)&ref);
+			    p2pdma->align, (void **)&ref);
 	percpu_ref_put(ref);
 }
 
@@ -323,17 +324,22 @@ struct p2pdma_provider *pcim_p2pdma_provider(struct pci_dev *pdev, int bar)
 }
 EXPORT_SYMBOL_GPL(pcim_p2pdma_provider);
 
-static int pci_p2pdma_setup_pool(struct pci_dev *pdev)
+static int pci_p2pdma_setup_pool(struct pci_dev *pdev, size_t align)
 {
 	struct pci_p2pdma *p2pdma;
 	int ret;
 
 	p2pdma = rcu_dereference_protected(pdev->p2pdma, 1);
-	if (p2pdma->pool)
+	if (p2pdma->pool) {
+		/* Two p2pdma BARs with different alignment ? */
+		if (p2pdma->align != align)
+			return -EINVAL;
 		/* We already setup pools, do nothing, */
 		return 0;
+	}
 
-	p2pdma->pool = gen_pool_create(PAGE_SHIFT, dev_to_node(&pdev->dev));
+	p2pdma->align = align;
+	p2pdma->pool = gen_pool_create(ilog2(p2pdma->align), dev_to_node(&pdev->dev));
 	if (!p2pdma->pool)
 		return -ENOMEM;
 
@@ -363,18 +369,31 @@ static void pci_p2pdma_unmap_mappings(void *data)
 				     p2pmem_group.name);
 }
 
+static inline int pci_p2pdma_check_pagemap_align(struct pci_dev *pdev, int bar,
+						 u64 size, size_t align,
+						 u64 offset)
+{
+	if (align == PAGE_SIZE)
+		return 0;
+	return -EINVAL;
+}
+
 /**
  * pci_p2pdma_add_resource - add memory for use as p2p memory
  * @pdev: the device to add the memory to
  * @bar: PCI BAR to add
  * @size: size of the memory to add, may be zero to use the whole BAR
+ * @align: dev memory mapping alignment of the memory to add. It is used
+ * to optimize the mappings both in userspace and kernel space when
+ * transparent huge page is supported. The possible values are
+ * PAGE_SIZE, PMD_SIZE, and PUD_SIZE.
  * @offset: offset into the PCI BAR
  *
  * The memory will be given ZONE_DEVICE struct pages so that it may
  * be used with any DMA request.
  */
 int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
-			    u64 offset)
+			    size_t align, u64 offset)
 {
 	struct pci_p2pdma_pagemap *p2p_pgmap;
 	struct p2pdma_provider *mem;
@@ -395,11 +414,18 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 	if (size + offset > pci_resource_len(pdev, bar))
 		return -EINVAL;
 
+	error = pci_p2pdma_check_pagemap_align(pdev, bar, size, align, offset);
+	if (error) {
+		pci_info_ratelimited(pdev, "invalid align 0x%zx for bar %d\n",
+				     align, bar);
+		return error;
+	}
+
 	error = pcim_p2pdma_init(pdev);
 	if (error)
 		return error;
 
-	error = pci_p2pdma_setup_pool(pdev);
+	error = pci_p2pdma_setup_pool(pdev, align);
 	if (error)
 		return error;
 
diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
index 517e121d2598..2fa671274c45 100644
--- a/include/linux/pci-p2pdma.h
+++ b/include/linux/pci-p2pdma.h
@@ -69,7 +69,7 @@ enum pci_p2pdma_map_type {
 int pcim_p2pdma_init(struct pci_dev *pdev);
 struct p2pdma_provider *pcim_p2pdma_provider(struct pci_dev *pdev, int bar);
 int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
-		u64 offset);
+			    size_t align, u64 offset);
 int pci_p2pdma_distance_many(struct pci_dev *provider, struct device **clients,
 			     int num_clients, bool verbose);
 struct pci_dev *pci_p2pmem_find_many(struct device **clients, int num_clients);
@@ -97,7 +97,7 @@ static inline struct p2pdma_provider *pcim_p2pdma_provider(struct pci_dev *pdev,
 	return NULL;
 }
 static inline int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar,
-		size_t size, u64 offset)
+		size_t size, size_t align, u64 offset)
 {
 	return -EOPNOTSUPP;
 }
-- 
2.29.2


