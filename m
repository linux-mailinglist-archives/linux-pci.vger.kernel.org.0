Return-Path: <linux-pci+bounces-43453-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 926DBCD26DA
	for <lists+linux-pci@lfdr.de>; Sat, 20 Dec 2025 05:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 03BA63002171
	for <lists+linux-pci@lfdr.de>; Sat, 20 Dec 2025 04:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55FD2F12C3;
	Sat, 20 Dec 2025 04:16:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DF9275AEB;
	Sat, 20 Dec 2025 04:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766204177; cv=none; b=ARJuuwLgvwvodhV/VyuSypCuAvxJKK90knO7S50hepXq/IjZc28tbr75A8CqDf/bvXnTOFf15L9qXF+IEKWTp4KVhepDpLxjc46uz5JEyfZcja9Rh8b6L29Gh0EIfrgrfPgoUM2jy0xDns9qi4d3OjDmlm6JlUrh/KBIyyEr/1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766204177; c=relaxed/simple;
	bh=9vCTTJw9IQZQdFTnf+iBa15xvCU0d4qAo3nVeWr1T/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fGFJ+GO5Gk/mie+zheRHSl2HyBqNXa9h0iv7IK8JvH9ozGkRnvNsEc5wmPyOuNethYV+NH0674P3fuQi8jw/gzaxDQ0KybGPJd2+O8UeUZMsd1AoCj7Ky6ZcuvHCf/0fiOUAV261keRoRDWQFUbsZJb7ebfvpU4eS+orkBpSZD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dYB076fLpzYQtgv;
	Sat, 20 Dec 2025 12:15:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 424F240575;
	Sat, 20 Dec 2025 12:16:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP4 (Coremail) with SMTP id gCh0CgD3WPn5IkZpFwpFAw--.56015S9;
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
Subject: [PATCH 05/13] sysfs: support get_unmapped_area callback for binary file
Date: Sat, 20 Dec 2025 12:04:38 +0800
Message-Id: <20251220040446.274991-6-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgD3WPn5IkZpFwpFAw--.56015S9
X-Coremail-Antispam: 1UD129KBjvJXoW7uF48Xw1DWw45tr1rXFy8AFb_yoW8uF4rpF
	sYk343XrZ7G3srKr9xAFW5W343KwnrGr1q9rZ2g343AwnrtF9Ig3yjya15JryrJrW8Cr1x
	KF429ryYkrW5G37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Add support for ->get_unmapped_area callback for binary sysfs file. The
following patch will use it to support compound page for p2pdma device
memory when the device memory is mapped into userspace.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 fs/sysfs/file.c       | 15 +++++++++++++++
 include/linux/sysfs.h |  4 ++++
 2 files changed, 19 insertions(+)

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index 3825e780cc58..e843795ebdc2 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -164,6 +164,20 @@ static ssize_t sysfs_kf_bin_write(struct kernfs_open_file *of, char *buf,
 	return battr->write(of->file, kobj, battr, buf, pos, count);
 }
 
+static unsigned long sysfs_kf_bin_get_unmapped_area(struct kernfs_open_file *of,
+						    unsigned long uaddr, unsigned long len,
+						    unsigned long pgoff, unsigned long flags)
+{
+	const struct bin_attribute *battr = of->kn->priv;
+	struct kobject *kobj;
+
+	if (!battr->get_unmapped_area)
+		return -EOPNOTSUPP;
+
+	kobj = sysfs_file_kobj(of->kn);
+	return battr->get_unmapped_area(of->file, kobj, battr, uaddr, len, pgoff, flags);
+}
+
 static int sysfs_kf_bin_mmap(struct kernfs_open_file *of,
 			     struct vm_area_struct *vma)
 {
@@ -268,6 +282,7 @@ static const struct kernfs_ops sysfs_bin_kfops_mmap = {
 	.mmap		= sysfs_kf_bin_mmap,
 	.open		= sysfs_kf_bin_open,
 	.llseek		= sysfs_kf_bin_llseek,
+	.get_unmapped_area = sysfs_kf_bin_get_unmapped_area,
 };
 
 int sysfs_add_file_mode_ns(struct kernfs_node *parent,
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index c33a96b7391a..f4a50f244f4d 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -321,6 +321,10 @@ struct bin_attribute {
 			 loff_t, int);
 	int (*mmap)(struct file *, struct kobject *, const struct bin_attribute *attr,
 		    struct vm_area_struct *vma);
+	unsigned long (*get_unmapped_area)(struct file *, struct kobject *,
+					   const struct bin_attribute *attr,
+					   unsigned long uaddr, unsigned long len,
+					   unsigned long pgoff, unsigned long flags);
 };
 
 /**
-- 
2.29.2


