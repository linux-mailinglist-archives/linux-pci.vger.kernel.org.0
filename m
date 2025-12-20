Return-Path: <linux-pci+bounces-43461-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8C4CD272C
	for <lists+linux-pci@lfdr.de>; Sat, 20 Dec 2025 05:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D0A53073A03
	for <lists+linux-pci@lfdr.de>; Sat, 20 Dec 2025 04:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B722FBE1F;
	Sat, 20 Dec 2025 04:16:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8265C2F6179;
	Sat, 20 Dec 2025 04:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766204182; cv=none; b=usYoqDOk/ihQ0IC6c7n7INZ6IFPNAu+gXTKUbt4MT8x4dJd3qfjCBRpEISoGAlT4sRWIEpZWRd0JzqCucCat9gBg6PuTmWBFVfHbn3LL27krT4EJKaXyiU75yHTPm8or3KRJ9j8U2D1WmPxY98AYwx7kfC40KvZgkzSnRS8J79E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766204182; c=relaxed/simple;
	bh=hqrA2BuPhIDII7vCGnfPJOimI5mCMKKMhO1z38FPsSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hD6hMORoFVi11tVkWtMPy2y13TaVeFHz98JSHywBUmpR81tihA1DIVqi3xCvTCi3V3P5qdY91Y3NWR/FKwgqVZDnZOCLgD+mQXO+KGS4zqSOfv7mZLzGWDSv0tnySH27bx2juuR23lmkJL+ZEVzgpnqFYw8L3mAZlUNtQSkMLa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dYB083ZvgzYQtfS;
	Sat, 20 Dec 2025 12:15:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D046E4056B;
	Sat, 20 Dec 2025 12:16:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP4 (Coremail) with SMTP id gCh0CgD3WPn5IkZpFwpFAw--.56015S16;
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
Subject: [PATCH 12/13] nvme-pci: introduce cmb_devmap_align module parameter
Date: Sat, 20 Dec 2025 12:04:45 +0800
Message-Id: <20251220040446.274991-13-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgD3WPn5IkZpFwpFAw--.56015S16
X-Coremail-Antispam: 1UD129KBjvJXoW7AFykWw48tw1xKr1xWF43trb_yoW8try3pa
	4DZFn8XFWakF1ay3yaywsrZas8Zw4v93yUAFW3Gw17u347tFZayFyUGa4YgFy5WrWDuF13
	AF42kryxWay7AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	v_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZF
	pf9x07j4fO7UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

P2PDMA memory has supported compound page. It is best to enable compound
page for p2pdma memory automatically accordingly to the address, the
size and the offset of the CMB, however, for nvme device, the p2pdma
memory may be used in the kernel space (e.g., for SQ entries) and it
will incur a lot of waste when a PUD or PMD-sized page is enabled for
nvme device.

Therefore, introduce a module parameter cmb_devmap_align to control the
alignment of p2pdma memory mapping. Its default value is PAGE_SIZE. When
its value is zero, it will use pci_p2pdma_max_pagemap_align() to find
the maximal possible mapping alignment.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 drivers/nvme/host/pci.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b070095bae5e..ca0126e36834 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -79,6 +79,10 @@ static bool use_cmb_sqes = true;
 module_param(use_cmb_sqes, bool, 0444);
 MODULE_PARM_DESC(use_cmb_sqes, "use controller's memory buffer for I/O SQes");
 
+static unsigned long cmb_devmap_align = PAGE_SIZE;
+module_param(cmb_devmap_align, ulong, 0444);
+MODULE_PARM_DESC(cmb_devmap_align, "the mapping alignment of CMB");
+
 static unsigned int max_host_mem_size_mb = 128;
 module_param(max_host_mem_size_mb, uint, 0444);
 MODULE_PARM_DESC(max_host_mem_size_mb,
@@ -2266,6 +2270,7 @@ static void nvme_map_cmb(struct nvme_dev *dev)
 	u64 size, offset;
 	resource_size_t bar_size;
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	size_t align;
 	int bar;
 
 	if (dev->cmb_size)
@@ -2309,7 +2314,10 @@ static void nvme_map_cmb(struct nvme_dev *dev)
 			     dev->bar + NVME_REG_CMBMSC);
 	}
 
-	if (pci_p2pdma_add_resource(pdev, bar, size, PAGE_SIZE, offset)) {
+	align = cmb_devmap_align;
+	if (!align)
+		align = pci_p2pdma_max_pagemap_align(pdev, bar, size, offset);
+	if (pci_p2pdma_add_resource(pdev, bar, size, align, offset)) {
 		dev_warn(dev->ctrl.device,
 			 "failed to register the CMB\n");
 		hi_lo_writeq(0, dev->bar + NVME_REG_CMBMSC);
-- 
2.29.2


