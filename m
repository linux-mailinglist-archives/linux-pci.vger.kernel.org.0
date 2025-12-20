Return-Path: <linux-pci+bounces-43449-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CE8CD2701
	for <lists+linux-pci@lfdr.de>; Sat, 20 Dec 2025 05:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 810113012DDE
	for <lists+linux-pci@lfdr.de>; Sat, 20 Dec 2025 04:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7242C29D289;
	Sat, 20 Dec 2025 04:16:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0852D2253EE;
	Sat, 20 Dec 2025 04:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766204177; cv=none; b=tZGNUScEuq/x9T6TvgbNbcN5lkJ/WATzLIEM6tE9fbI5X+Z+ldOzlHh5c0gXHwuDZz0SEx5fkwhsitaraXAYiNqdWMO5bgg6C0O8mw+Q/2WegJEvIiVDHZvvQLNQM6ew3Q4wjAEuIE2NpCEd3VLhJvY8pQFX2OdxpwqTZ6Gy8aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766204177; c=relaxed/simple;
	bh=VGvm/RBAbHOoCwU8KD8HI6uHjmNUhOI+disxR/Bn6Gs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p5gE1vMFdqsGVdUcI8WX/rdZhks03Qi4qvZP+P8UcNElYLgEhHwV6YCNlrEsEqGPVtGMFjAEJGjNggRGBTYwSUfnMAECHy9SHg74M+hUGcb9kw4pNWdLxrphWsYGGEIdOw559Vdjixu5mTtqpl0gU4muc2kjyhbat99jRTMSFlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dYB074NMTzYQtf3;
	Sat, 20 Dec 2025 12:15:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E928640577;
	Sat, 20 Dec 2025 12:16:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP4 (Coremail) with SMTP id gCh0CgD3WPn5IkZpFwpFAw--.56015S6;
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
Subject: [PATCH 02/13] PCI/P2PDMA: Fix the warning condition in p2pmem_alloc_mmap()
Date: Sat, 20 Dec 2025 12:04:35 +0800
Message-Id: <20251220040446.274991-3-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgD3WPn5IkZpFwpFAw--.56015S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr18GF15tF13WF1DAr1DWrg_yoW8Ar13pF
	W3GF17GrWktr43JF4DJ3Z8ury5Aan3uFWUKFWUXw1UuF13urWjkw48tF95Jry5try8Ar1S
	qFs8ur1jyF1DAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
	AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wr
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU
	xXTmDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Commit b7e282378773 has already changed the initial page refcount of
p2pdma page from one to zero, however, in p2pmem_alloc_mmap() it uses
"VM_WARN_ON_ONCE_PAGE(!page_ref_count(page))" to assert the initial page
refcount should not be zero and the following will be reported when
CONFIG_DEBUG_VM is enabled:

 page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x380400000
 flags: 0x20000000002000(reserved|node=0|zone=4)
 raw: 0020000000002000 ff1100015e3ab440 0000000000000000 0000000000000000
 raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
 page dumped because: VM_WARN_ON_ONCE_PAGE(!page_ref_count(page))
 ------------[ cut here ]------------
 WARNING: CPU: 5 PID: 449 at drivers/pci/p2pdma.c:240 p2pmem_alloc_mmap+0x83a/0xa60

Fix by using "page_ref_count(page)" as the assertion condition.

Fixes: b7e282378773 ("mm/mm_init: move p2pdma page refcount initialisation to p2pdma")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 drivers/pci/p2pdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 218c1f5252b6..dd64ec830fdd 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -147,7 +147,7 @@ static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
 		 * we have just allocated the page no one else should be
 		 * using it.
 		 */
-		VM_WARN_ON_ONCE_PAGE(!page_ref_count(page), page);
+		VM_WARN_ON_ONCE_PAGE(page_ref_count(page), page);
 		set_page_count(page, 1);
 		ret = vm_insert_page(vma, vaddr, page);
 		if (ret) {
-- 
2.29.2


