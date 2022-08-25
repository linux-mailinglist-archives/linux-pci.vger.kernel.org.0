Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E905A159E
	for <lists+linux-pci@lfdr.de>; Thu, 25 Aug 2022 17:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239089AbiHYPY7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Aug 2022 11:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241945AbiHYPYp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2022 11:24:45 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DDAB95B3;
        Thu, 25 Aug 2022 08:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=jHRxLz2djGGS1TM542jkP+PzdqwM8h/KFYgaj6hQq10=; b=auQ8tkE4WiGZMxITEDr0NehtLa
        pjduVL2MTl1EiBVIWvrNWahaQ5IAFoEUwcLTSHpGK2r6Oe7SxBi+IoVGHvbBpi+CXWY2XBo0a7zhv
        pDZJqZJkhOYRFSM1hA9uDW1z4W3hMxIJBQnMkDchJtZJnzA20Pu7ybmXMSyg3/G8Or3YDlqu6sClq
        3SyNxXu76FGeRui6SKCsyCsBGskr47P/3F2Zsog/zrqzp8FBoym3K0em4jkCFauHESXwUH9TW3iY8
        B91rE1P2LZIVVI99tN4nwLTnWRNVd3Uejp5tslsOCEhyYNKMadbzbS8yFg8DsO9sv68gCv0XkiaT2
        IuGjyLIg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1oREim-0086MC-BQ; Thu, 25 Aug 2022 09:24:41 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1oREie-0001eo-SF; Thu, 25 Aug 2022 09:24:32 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
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
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 25 Aug 2022 09:24:24 -0600
Message-Id: <20220825152425.6296-8-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220825152425.6296-1-logang@deltatee.com>
References: <20220825152425.6296-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, hch@lst.de, gregkh@linuxfoundation.org, jgg@ziepe.ca, christian.koenig@amd.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, jhubbard@nvidia.com, rcampbell@nvidia.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Subject: [PATCH v9 7/8] PCI/P2PDMA: Allow userspace VMA allocations through sysfs
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Create a sysfs bin attribute called "allocate" under the existing
"p2pmem" group. The only allowable operation on this file is the mmap()
call.

When mmap() is called on this attribute, the kernel allocates a chunk of
memory from the genalloc and inserts the pages into the VMA. The
dev_pagemap .page_free callback will indicate when these pages are no
longer used and they will be put back into the genalloc.

On device unbind, remove the sysfs file before the memremap_pages are
cleaned up. This ensures unmap_mapping_range() is called on the files
inode and no new mappings can be created.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/p2pdma.c | 124 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 4496a7c5c478..a6ed6bbca214 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -89,6 +89,90 @@ static ssize_t published_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(published);
 
+static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
+		struct bin_attribute *attr, struct vm_area_struct *vma)
+{
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+	size_t len = vma->vm_end - vma->vm_start;
+	struct pci_p2pdma *p2pdma;
+	struct percpu_ref *ref;
+	unsigned long vaddr;
+	void *kaddr;
+	int ret;
+
+	/* prevent private mappings from being established */
+	if ((vma->vm_flags & VM_MAYSHARE) != VM_MAYSHARE) {
+		pci_info_ratelimited(pdev,
+				     "%s: fail, attempted private mapping\n",
+				     current->comm);
+		return -EINVAL;
+	}
+
+	if (vma->vm_pgoff) {
+		pci_info_ratelimited(pdev,
+				     "%s: fail, attempted mapping with non-zero offset\n",
+				     current->comm);
+		return -EINVAL;
+	}
+
+	rcu_read_lock();
+	p2pdma = rcu_dereference(pdev->p2pdma);
+	if (!p2pdma) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	kaddr = (void *)gen_pool_alloc_owner(p2pdma->pool, len, (void **)&ref);
+	if (!kaddr) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/*
+	 * vm_insert_page() can sleep, so a reference is taken to mapping
+	 * such that rcu_read_unlock() can be done before inserting the
+	 * pages
+	 */
+	if (unlikely(!percpu_ref_tryget_live_rcu(ref))) {
+		ret = -ENODEV;
+		goto out_free_mem;
+	}
+	rcu_read_unlock();
+
+	for (vaddr = vma->vm_start; vaddr < vma->vm_end; vaddr += PAGE_SIZE) {
+		ret = vm_insert_page(vma, vaddr, virt_to_page(kaddr));
+		if (ret) {
+			gen_pool_free(p2pdma->pool, (uintptr_t)kaddr, len);
+			return ret;
+		}
+		percpu_ref_get(ref);
+		put_page(virt_to_page(kaddr));
+		kaddr += PAGE_SIZE;
+		len -= PAGE_SIZE;
+	}
+
+	percpu_ref_put(ref);
+
+	return 0;
+out_free_mem:
+	gen_pool_free(p2pdma->pool, (uintptr_t)kaddr, len);
+out:
+	rcu_read_unlock();
+	return ret;
+}
+
+static struct bin_attribute p2pmem_alloc_attr = {
+	.attr = { .name = "allocate", .mode = 0660 },
+	.mmap = p2pmem_alloc_mmap,
+	/*
+	 * Some places where we want to call mmap (ie. python) will check
+	 * that the file size is greater than the mmap size before allowing
+	 * the mmap to continue. To work around this, just set the size
+	 * to be very large.
+	 */
+	.size = SZ_1T,
+};
+
 static struct attribute *p2pmem_attrs[] = {
 	&dev_attr_size.attr,
 	&dev_attr_available.attr,
@@ -96,11 +180,32 @@ static struct attribute *p2pmem_attrs[] = {
 	NULL,
 };
 
+static struct bin_attribute *p2pmem_bin_attrs[] = {
+	&p2pmem_alloc_attr,
+	NULL,
+};
+
 static const struct attribute_group p2pmem_group = {
 	.attrs = p2pmem_attrs,
+	.bin_attrs = p2pmem_bin_attrs,
 	.name = "p2pmem",
 };
 
+static void p2pdma_page_free(struct page *page)
+{
+	struct pci_p2pdma_pagemap *pgmap = to_p2p_pgmap(page->pgmap);
+	struct percpu_ref *ref;
+
+	gen_pool_free_owner(pgmap->provider->p2pdma->pool,
+			    (uintptr_t)page_to_virt(page), PAGE_SIZE,
+			    (void **)&ref);
+	percpu_ref_put(ref);
+}
+
+static const struct dev_pagemap_ops p2pdma_pgmap_ops = {
+	.page_free = p2pdma_page_free,
+};
+
 static void pci_p2pdma_release(void *data)
 {
 	struct pci_dev *pdev = data;
@@ -152,6 +257,19 @@ static int pci_p2pdma_setup(struct pci_dev *pdev)
 	return error;
 }
 
+static void pci_p2pdma_unmap_mappings(void *data)
+{
+	struct pci_dev *pdev = data;
+
+	/*
+	 * Removing the alloc attribute from sysfs will call
+	 * unmap_mapping_range() on the inode, teardown any existing userspace
+	 * mappings and prevent new ones from being created.
+	 */
+	sysfs_remove_file_from_group(&pdev->dev.kobj, &p2pmem_alloc_attr.attr,
+				     p2pmem_group.name);
+}
+
 /**
  * pci_p2pdma_add_resource - add memory for use as p2p memory
  * @pdev: the device to add the memory to
@@ -198,6 +316,7 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 	pgmap->range.end = pgmap->range.start + size - 1;
 	pgmap->nr_range = 1;
 	pgmap->type = MEMORY_DEVICE_PCI_P2PDMA;
+	pgmap->ops = &p2pdma_pgmap_ops;
 
 	p2p_pgmap->provider = pdev;
 	p2p_pgmap->bus_offset = pci_bus_address(pdev, bar) -
@@ -209,6 +328,11 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 		goto pgmap_free;
 	}
 
+	error = devm_add_action_or_reset(&pdev->dev, pci_p2pdma_unmap_mappings,
+					 pdev);
+	if (error)
+		goto pages_free;
+
 	p2pdma = rcu_dereference_protected(pdev->p2pdma, 1);
 	error = gen_pool_add_owner(p2pdma->pool, (unsigned long)addr,
 			pci_bus_address(pdev, bar) + offset,
-- 
2.30.2

