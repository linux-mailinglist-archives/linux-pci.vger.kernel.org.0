Return-Path: <linux-pci+bounces-43459-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D683FCD2714
	for <lists+linux-pci@lfdr.de>; Sat, 20 Dec 2025 05:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 400ED3022D18
	for <lists+linux-pci@lfdr.de>; Sat, 20 Dec 2025 04:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141132F999A;
	Sat, 20 Dec 2025 04:16:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824412F6173;
	Sat, 20 Dec 2025 04:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766204181; cv=none; b=TX6J56JnIGAk9yD4zhFUImudM1921rLP+71Mbdql0D1a2swBM2M6Et+N9SV+IVq4Kqs0NBC38oRBNmF/LD7LwTqw2lI2ghqKXC5qvOMpVOPIjLDAUh3r1tc/+TK2dIeBVzIJLgbumlvnncvu7Kc7tSQLDTq2g8ndXbZCEydjCS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766204181; c=relaxed/simple;
	bh=UfTzxFmeBxMi2StwimfIMpRVlZpdNpNwvrM7o3WjFLA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jkcjmxnRZFRZoYDO3oKJgD4WzQTrpuMsBBz5C2vfo+laVM7KMjN+M6H5sPDMF2tstVGfg+HVzy7Z/k6t89OBPnbKetnxv991U5xi03y61aETG0yJQDEsz25EQCRWkXk2Y+WQEQ388Cz9c8pV3OhHpEOfmRqa5SWKRBG38p3ILFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dYB082vZWzYQtjX;
	Sat, 20 Dec 2025 12:15:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B52A740573;
	Sat, 20 Dec 2025 12:16:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP4 (Coremail) with SMTP id gCh0CgD3WPn5IkZpFwpFAw--.56015S15;
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
Subject: [PATCH 11/13] PCI/P2PDMA: add helper pci_p2pdma_max_pagemap_align()
Date: Sat, 20 Dec 2025 12:04:44 +0800
Message-Id: <20251220040446.274991-12-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgD3WPn5IkZpFwpFAw--.56015S15
X-Coremail-Antispam: 1UD129KBjvJXoWxJF15Gw1rWr1fKr48Xr48Crg_yoW8Ww43pF
	1kAFZ5Xr18KF47Ar9xA3Z0k3ZYvrs3Ca42krW3Kan7ZFy7Jws5Kr4UGF1Ygr1rWrWvkrWf
	JrsayF4Fk3sxt3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Add helper pci_p2pdma_max_pagemap_align() to find the max possible
alignment for p2p dma memory mapping in both userspace and kernel space.

When huge transparent page is supported, and the physical address, the
size of the BAR and the offset is {PUD|PMM}_SIZE aligned, it returns
{PUD|PMD_SIZE} accordingly. Otherwise, it returns PAGE_SIZE.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/pci-p2pdma.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
index 2fa671274c45..5d940b9e5338 100644
--- a/include/linux/pci-p2pdma.h
+++ b/include/linux/pci-p2pdma.h
@@ -210,4 +210,30 @@ pci_p2pdma_bus_addr_map(struct p2pdma_provider *provider, phys_addr_t paddr)
 	return paddr + provider->bus_offset;
 }
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static inline size_t pci_p2pdma_max_pagemap_align(struct pci_dev *pdev, int bar,
+						  u64 size, u64 offset)
+{
+	resource_size_t start = pci_resource_start(pdev, bar);
+
+	if (has_transparent_pud_hugepage() &&
+	    IS_ALIGNED(start, PUD_SIZE) && IS_ALIGNED(size, PUD_SIZE) &&
+	    IS_ALIGNED(offset, PUD_SIZE))
+		return PUD_SIZE;
+
+	if (has_transparent_hugepage() &&
+	    IS_ALIGNED(start, PMD_SIZE) && IS_ALIGNED(size, PMD_SIZE) &&
+	    IS_ALIGNED(offset, PMD_SIZE))
+		return PMD_SIZE;
+
+	return PAGE_SIZE;
+}
+#else
+static inline size_t pci_p2pdma_max_pagemap_align(resource_size_t start,
+						  u64 size, u64 offset)
+{
+	return PAGE_SIZE;
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
 #endif /* _LINUX_PCI_P2P_H */
-- 
2.29.2


