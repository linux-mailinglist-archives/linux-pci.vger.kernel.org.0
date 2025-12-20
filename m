Return-Path: <linux-pci+bounces-43451-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61160CD2708
	for <lists+linux-pci@lfdr.de>; Sat, 20 Dec 2025 05:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 882E3301C947
	for <lists+linux-pci@lfdr.de>; Sat, 20 Dec 2025 04:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882172E11C5;
	Sat, 20 Dec 2025 04:16:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B37481DD;
	Sat, 20 Dec 2025 04:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766204177; cv=none; b=QTrpMko/Q2VXPTcxNch3Z1Zl2AOLQdNstYmEAiOedh0OESgShwp3oKSWSO4bpTk8pG2l5ScLobpm67hUHz2xxvw5ebV6WO3TF6t4IJc1+wSa1C/52Y6VP3OVlWNEOA1oyZPF72Wbxq4e78hZRPboSlsgsvazxiyApUhW/kovJ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766204177; c=relaxed/simple;
	bh=ovYIvNvdgqPtcKPLAik+qZBYxy+/Gt+CpMQ2oUPrxJM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jgIhB9Vihg1DkExuBF5BxL10/u4q/upP9pUbjRBxs3IIO+I3tGcjjEY11tuofdZQxkdlsyhO8IL8oJ7Slrtuz53I6vKveFSb8Sk+/sgF1m6nkL+89TXzB1tE2g6ngEoDJDJ5xM1E8TUZuvfs1bZgxfICC6laaWOueK+SzAeLEs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dYB0T4nLFzKHM0f;
	Sat, 20 Dec 2025 12:15:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CA05A40577;
	Sat, 20 Dec 2025 12:16:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP4 (Coremail) with SMTP id gCh0CgD3WPn5IkZpFwpFAw--.56015S4;
	Sat, 20 Dec 2025 12:16:06 +0800 (CST)
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
Subject: [PATCH 00/13] Enable compound page for p2pdma memory
Date: Sat, 20 Dec 2025 12:04:33 +0800
Message-Id: <20251220040446.274991-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3WPn5IkZpFwpFAw--.56015S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWF1rur4fWw13Zw4DGr4kZwb_yoW5Ar1DpF
	Z5KF98JrnrG342y3sxAa1DCr13Zw4rKFWUta4fK3sxCw13JF1Iv3yUtF15Xw1UXrsxG3WY
	qF4xZryxu3Z5XaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x02
	62kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
	026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
	GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
	vEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07j438nUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Hi,

device-dax has already supported compound page. It not only reduces the
cost of struct page significantly, it also improve the performance of
get_user_pages when 2MB or 1GB page size is used. We are experimenting
to use p2p dma to directly transfer the content of NVMe SSD into NPU.
The size of NPU HBM is 32GB or larger and there are at most 8 NPUs in
the host. When using the base page, the memory overhead is about 4GB for
128GB HBM, and the mapping of 32GB HBM into userspace takes about 0.8
second. Considering ZONE_DEVICE memory type has already supported the
compound page, enabling the compound page support for p2pdma memory as
well. After applying the patch set, when using the 1GB page, the memory
overhead is about 2MB and the mmap costs about 0.04 ms.

The main difference between the compound page support of device-dax and
p2pdma is that p2pdma inserts the page into user vma during mmap instead
of page fault. The main reason is simplicity. The patch set is
structured as shown below:

Patch #1~#2: tiny bug fixes for p2pdma
Patch #3~#5: add callbacks support in kernfs and sysfs, include
pagesize, may_split and get_unmapped_area. These callbacks are necessary
for the support of compound page when mmaping sysfs binary file.
Patch #6~#7: create compound page for p2pdma memory in the kernel. 
Patch #8~#10: support the mapping of compound page in userspace. 
Patch #11~#12: support the compound page for NVMe CMB.
Patch #13: enable the support for compound page for p2pdma memory.

Please see individual patches for more details. Comments and
suggestions are always welcome.

Hou Tao (13):
  PCI/P2PDMA: Release the per-cpu ref of pgmap when vm_insert_page()
    fails
  PCI/P2PDMA: Fix the warning condition in p2pmem_alloc_mmap()
  kernfs: add support for get_unmapped_area callback
  kernfs: add support for may_split and pagesize callbacks
  sysfs: support get_unmapped_area callback for binary file
  PCI/P2PDMA: add align parameter for pci_p2pdma_add_resource()
  PCI/P2PDMA: create compound page for aligned p2pdma memory
  mm/huge_memory: add helpers to insert huge page during mmap
  PCI/P2PDMA: support get_unmapped_area to return aligned vaddr
  PCI/P2PDMA: support compound page in p2pmem_alloc_mmap()
  PCI/P2PDMA: add helper pci_p2pdma_max_pagemap_align()
  nvme-pci: introduce cmb_devmap_align module parameter
  PCI/P2PDMA: enable compound page support for p2pdma memory

 drivers/accel/habanalabs/common/hldio.c |   3 +-
 drivers/nvme/host/pci.c                 |  10 +-
 drivers/pci/p2pdma.c                    | 140 ++++++++++++++++++++++--
 fs/kernfs/file.c                        |  79 +++++++++++++
 fs/sysfs/file.c                         |  15 +++
 include/linux/huge_mm.h                 |   4 +
 include/linux/kernfs.h                  |   3 +
 include/linux/pci-p2pdma.h              |  30 ++++-
 include/linux/sysfs.h                   |   4 +
 mm/huge_memory.c                        |  66 +++++++++++
 10 files changed, 339 insertions(+), 15 deletions(-)

-- 
2.29.2


