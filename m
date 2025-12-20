Return-Path: <linux-pci+bounces-43458-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3516CD2723
	for <lists+linux-pci@lfdr.de>; Sat, 20 Dec 2025 05:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EADA3010ABA
	for <lists+linux-pci@lfdr.de>; Sat, 20 Dec 2025 04:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4712F7AD8;
	Sat, 20 Dec 2025 04:16:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E88D2F5A09;
	Sat, 20 Dec 2025 04:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766204181; cv=none; b=VYpcOLT137Bf5jKVqcGgYcCxYCd63ipwDw0n3JKm4IZcl7SpVavG/QwREP0AxvDKgpV4K5Y6P+YvqgELMUonSVT+QZl1q4gdv8xQp0HlY25kZ50T/GjSE0kPGrkBo4ZPhW3KIH5YT3ajkfefdM/7Shd2ErEo6dHq6XY/+8Pp9Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766204181; c=relaxed/simple;
	bh=vpg4Y2CuK0BF6n9ne9C/TlupCZKIO9PBgYQ/GswlUyM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=buBGnhsHm4Fnjhoivw3eCdEXO0MQQrGvA/tDBUYua2TSCjC5BUQynXVSwjySkMR37FW1gwrKJI0Ai1IDcS4rklWe+68bK2/xmyAf5FSefUABed0FNCf+HkutdWXTGcMG+3In+e6O5l9vx4KROm2I9CHfJ1FZPJf4fvuOKZ8mN/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dYB081cnVzYQtj5;
	Sat, 20 Dec 2025 12:15:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8ED824056D;
	Sat, 20 Dec 2025 12:16:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP4 (Coremail) with SMTP id gCh0CgD3WPn5IkZpFwpFAw--.56015S13;
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
Subject: [PATCH 09/13] PCI/P2PDMA: support get_unmapped_area to return aligned vaddr
Date: Sat, 20 Dec 2025 12:04:42 +0800
Message-Id: <20251220040446.274991-10-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgD3WPn5IkZpFwpFAw--.56015S13
X-Coremail-Antispam: 1UD129KBjvJXoW7uw1UWFW5JF1UAF15GF15urg_yoW8Kr18pF
	WrtF98JrW8twsrKFWaya1DZry3Wwn5KryjkrWxK34a93W3GFnxWay5Aa4YqF13J34kW3W7
	tanIkr47urWDJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

P2PDMA memory already supports compound page. When mmapping the P2PDMA
memory in the userspace, the mmap procedure needs to use an aligned
virtual address to match the alignment of P2PDMA memory. Therefore,
implement get_unmapped_area for p2pdma memory to return an aligned
virtual address.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 drivers/pci/p2pdma.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 7180dea4855c..e97f5da73458 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -90,6 +90,44 @@ static ssize_t published_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(published);
 
+static unsigned long p2pmem_get_unmapped_area(struct file *filp, struct kobject *kobj,
+					      const struct bin_attribute *attr,
+					      unsigned long uaddr, unsigned long len,
+					      unsigned long pgoff, unsigned long flags)
+{
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+	struct pci_p2pdma *p2pdma;
+	unsigned long aligned_len;
+	unsigned long addr;
+	unsigned long align;
+
+	if (pgoff)
+		return -EINVAL;
+
+	rcu_read_lock();
+	p2pdma = rcu_dereference(pdev->p2pdma);
+	if (!p2pdma) {
+		rcu_read_unlock();
+		return -ENODEV;
+	}
+	align = p2pdma->align;
+	rcu_read_unlock();
+
+	/* Fixed address */
+	if (uaddr)
+		goto out;
+
+	aligned_len = len + align;
+	if (aligned_len < len)
+		goto out;
+
+	addr = mm_get_unmapped_area(filp, uaddr, aligned_len, pgoff, flags);
+	if (!IS_ERR_VALUE(addr))
+		return round_up(addr, align);
+out:
+	return mm_get_unmapped_area(filp, uaddr, len, pgoff, flags);
+}
+
 static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
 		const struct bin_attribute *attr, struct vm_area_struct *vma)
 {
@@ -175,6 +213,7 @@ static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
 static const struct bin_attribute p2pmem_alloc_attr = {
 	.attr = { .name = "allocate", .mode = 0660 },
 	.mmap = p2pmem_alloc_mmap,
+	.get_unmapped_area = p2pmem_get_unmapped_area,
 	/*
 	 * Some places where we want to call mmap (ie. python) will check
 	 * that the file size is greater than the mmap size before allowing
-- 
2.29.2


