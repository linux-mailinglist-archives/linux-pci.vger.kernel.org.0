Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533D940EDEE
	for <lists+linux-pci@lfdr.de>; Fri, 17 Sep 2021 01:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241629AbhIPXmg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Sep 2021 19:42:36 -0400
Received: from ale.deltatee.com ([204.191.154.188]:40600 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240718AbhIPXmc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Sep 2021 19:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=Byl50tSN7YlTKxj2Cnj7aNCxVxnUGzLxCzAMeQXCg2g=; b=FvpT0F1TSth/j9oIVgyR0o/ECk
        FwdDLPllU0QCkpSzeM9WJpora6IVS3n6b6aebs1shi/3gXspQjL+UEkXyJtIm8ZaihJOIouZ+/0j5
        2P3F/KhpP/rZwbiWet8U6obfYqAVMqgAKFs1MRe0btNV79U7r4e/wUVsHtiAukS7VOH95I1iL3HtN
        CtBxlTtBWGplKsg0bViPFYU1Nsf+cvLJBglliMfmSJhncyOuM4uSa5YvihQJCssb0iVKbB3Sses1j
        NbYxYaGGqCnuHzl1WAabJbDoR7+SRgbjrWZfpvbMcP6DBqfLQP8o6IuujPZ2BsybbZLToNjQzVlU+
        mVk+4oyg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1mR108-0008I0-IW; Thu, 16 Sep 2021 17:41:11 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1mR106-000Vru-Ip; Thu, 16 Sep 2021 17:41:06 -0600
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
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 16 Sep 2021 17:40:59 -0600
Message-Id: <20210916234100.122368-20-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210916234100.122368-1-logang@deltatee.com>
References: <20210916234100.122368-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de, jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com, andrzej.jakowski@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_FREE,MYRULES_NO_TEXT autolearn=no autolearn_force=no
        version=3.4.2
Subject: [PATCH v3 19/20] PCI/P2PDMA: introduce pci_mmap_p2pmem()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Introduce pci_mmap_p2pmem() which is a helper to allocate and mmap
a hunk of p2pmem into userspace.

Pages are allocated from the genalloc in bulk and their reference count
incremented. They are returned to the genalloc when the page is put.

The VMA does not take a reference to the pages when they are inserted
with vmf_insert_mixed() (which is necessary for zone device pages) so
the backing P2P memory is stored in a structures in vm_private_data.

A pseudo mount is used to allocate an inode for each PCI device. The
inode's address_space is used in the file doing the mmap so that all
VMAs are collected and can be unmapped if the PCI device is unbound.
After unmapping, the VMAs are iterated through and their pages are
put so the device can continue to be unbound. An active flag is used
to signal to VMAs not to allocate any further P2P memory once the
removal process starts. The flag is synchronized with concurrent
access with an RCU lock.

The VMAs and inode will survive after the unbind of the device, but no
pages will be present in the VMA and a subsequent access will result
in a SIGBUS error.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/p2pdma.c       | 263 ++++++++++++++++++++++++++++++++++++-
 include/linux/pci-p2pdma.h |  11 ++
 include/uapi/linux/magic.h |   1 +
 3 files changed, 273 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 2422af5a529c..a5adf57af53a 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -16,14 +16,19 @@
 #include <linux/genalloc.h>
 #include <linux/memremap.h>
 #include <linux/percpu-refcount.h>
+#include <linux/pfn_t.h>
+#include <linux/pseudo_fs.h>
 #include <linux/random.h>
 #include <linux/seq_buf.h>
 #include <linux/xarray.h>
+#include <uapi/linux/magic.h>
 
 struct pci_p2pdma {
 	struct gen_pool *pool;
 	bool p2pmem_published;
 	struct xarray map_types;
+	struct inode *inode;
+	bool active;
 };
 
 struct pci_p2pdma_pagemap {
@@ -32,6 +37,14 @@ struct pci_p2pdma_pagemap {
 	u64 bus_offset;
 };
 
+struct pci_p2pdma_map {
+	struct kref ref;
+	struct pci_dev *pdev;
+	struct inode *inode;
+	void *kaddr;
+	size_t len;
+};
+
 static struct pci_p2pdma_pagemap *to_p2p_pgmap(struct dev_pagemap *pgmap)
 {
 	return container_of(pgmap, struct pci_p2pdma_pagemap, pgmap);
@@ -100,6 +113,26 @@ static const struct attribute_group p2pmem_group = {
 	.name = "p2pmem",
 };
 
+/*
+ * P2PDMA internal mount
+ * Fake an internal VFS mount-point in order to allocate struct address_space
+ * mappings to remove VMAs on unbind events.
+ */
+static int pci_p2pdma_fs_cnt;
+static struct vfsmount *pci_p2pdma_fs_mnt;
+
+static int pci_p2pdma_fs_init_fs_context(struct fs_context *fc)
+{
+	return init_pseudo(fc, P2PDMA_MAGIC) ? 0 : -ENOMEM;
+}
+
+static struct file_system_type pci_p2pdma_fs_type = {
+	.name = "p2dma",
+	.owner = THIS_MODULE,
+	.init_fs_context = pci_p2pdma_fs_init_fs_context,
+	.kill_sb = kill_anon_super,
+};
+
 static void p2pdma_page_free(struct page *page)
 {
 	struct pci_p2pdma_pagemap *pgmap = to_p2p_pgmap(page->pgmap);
@@ -128,6 +161,9 @@ static void pci_p2pdma_release(void *data)
 	gen_pool_destroy(p2pdma->pool);
 	sysfs_remove_group(&pdev->dev.kobj, &p2pmem_group);
 	xa_destroy(&p2pdma->map_types);
+
+	iput(p2pdma->inode);
+	simple_release_fs(&pci_p2pdma_fs_mnt, &pci_p2pdma_fs_cnt);
 }
 
 static int pci_p2pdma_setup(struct pci_dev *pdev)
@@ -145,17 +181,32 @@ static int pci_p2pdma_setup(struct pci_dev *pdev)
 	if (!p2p->pool)
 		goto out;
 
-	error = devm_add_action_or_reset(&pdev->dev, pci_p2pdma_release, pdev);
+	error = simple_pin_fs(&pci_p2pdma_fs_type, &pci_p2pdma_fs_mnt,
+			      &pci_p2pdma_fs_cnt);
 	if (error)
 		goto out_pool_destroy;
 
+	p2p->inode = alloc_anon_inode(pci_p2pdma_fs_mnt->mnt_sb);
+	if (IS_ERR(p2p->inode)) {
+		error = -ENOMEM;
+		goto out_unpin_fs;
+	}
+
+	error = devm_add_action_or_reset(&pdev->dev, pci_p2pdma_release, pdev);
+	if (error)
+		goto out_put_inode;
+
 	error = sysfs_create_group(&pdev->dev.kobj, &p2pmem_group);
 	if (error)
-		goto out_pool_destroy;
+		goto out_put_inode;
 
 	rcu_assign_pointer(pdev->p2pdma, p2p);
 	return 0;
 
+out_put_inode:
+	iput(p2p->inode);
+out_unpin_fs:
+	simple_release_fs(&pci_p2pdma_fs_mnt, &pci_p2pdma_fs_cnt);
 out_pool_destroy:
 	gen_pool_destroy(p2p->pool);
 out:
@@ -163,6 +214,45 @@ static int pci_p2pdma_setup(struct pci_dev *pdev)
 	return error;
 }
 
+static void pci_p2pdma_map_free_pages(struct pci_p2pdma_map *pmap)
+{
+	int i;
+
+	if (!pmap->kaddr)
+		return;
+
+	for (i = 0; i < pmap->len; i += PAGE_SIZE)
+		put_page(virt_to_page(pmap->kaddr + i));
+
+	pmap->kaddr = NULL;
+}
+
+static void pci_p2pdma_free_mappings(struct address_space *mapping)
+{
+	struct vm_area_struct *vma;
+
+	i_mmap_lock_write(mapping);
+	if (RB_EMPTY_ROOT(&mapping->i_mmap.rb_root))
+		goto out;
+
+	vma_interval_tree_foreach(vma, &mapping->i_mmap, 0, -1)
+		pci_p2pdma_map_free_pages(vma->vm_private_data);
+
+out:
+	i_mmap_unlock_write(mapping);
+}
+
+static void pci_p2pdma_unmap_mappings(void *data)
+{
+	struct pci_dev *pdev = data;
+	struct pci_p2pdma *p2pdma = rcu_dereference_protected(pdev->p2pdma, 1);
+
+	p2pdma->active = false;
+	synchronize_rcu();
+	unmap_mapping_range(p2pdma->inode->i_mapping, 0, 0, 1);
+	pci_p2pdma_free_mappings(p2pdma->inode->i_mapping);
+}
+
 /**
  * pci_p2pdma_add_resource - add memory for use as p2p memory
  * @pdev: the device to add the memory to
@@ -221,6 +311,11 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
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
@@ -229,6 +324,7 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 	if (error)
 		goto pages_free;
 
+	p2pdma->active = true;
 	pci_info(pdev, "added peer-to-peer DMA memory %#llx-%#llx\n",
 		 pgmap->range.start, pgmap->range.end);
 
@@ -1029,3 +1125,166 @@ ssize_t pci_p2pdma_enable_show(char *page, struct pci_dev *p2p_dev,
 	return sprintf(page, "%s\n", pci_name(p2p_dev));
 }
 EXPORT_SYMBOL_GPL(pci_p2pdma_enable_show);
+
+static struct pci_p2pdma_map *pci_p2pdma_map_alloc(struct pci_dev *pdev,
+						   size_t len)
+{
+	struct pci_p2pdma_map *pmap;
+
+	pmap = kzalloc(sizeof(*pmap), GFP_KERNEL);
+	if (!pmap)
+		return NULL;
+
+	kref_init(&pmap->ref);
+	pmap->pdev = pci_dev_get(pdev);
+	pmap->len = len;
+
+	return pmap;
+}
+
+static void pci_p2pdma_map_free(struct kref *ref)
+{
+	struct pci_p2pdma_map *pmap =
+		container_of(ref, struct pci_p2pdma_map, ref);
+
+	pci_p2pdma_map_free_pages(pmap);
+	pci_dev_put(pmap->pdev);
+	iput(pmap->inode);
+	simple_release_fs(&pci_p2pdma_fs_mnt, &pci_p2pdma_fs_cnt);
+	kfree(pmap);
+}
+
+static void pci_p2pdma_vma_open(struct vm_area_struct *vma)
+{
+	struct pci_p2pdma_map *pmap = vma->vm_private_data;
+
+	kref_get(&pmap->ref);
+}
+
+static void pci_p2pdma_vma_close(struct vm_area_struct *vma)
+{
+	struct pci_p2pdma_map *pmap = vma->vm_private_data;
+
+	kref_put(&pmap->ref, pci_p2pdma_map_free);
+}
+
+static vm_fault_t pci_p2pdma_vma_fault(struct vm_fault *vmf)
+{
+	struct pci_p2pdma_map *pmap = vmf->vma->vm_private_data;
+	struct pci_p2pdma *p2pdma;
+	void *vaddr;
+	pfn_t pfn;
+	int i;
+
+	if (!pmap->kaddr) {
+		rcu_read_lock();
+		p2pdma = rcu_dereference(pmap->pdev->p2pdma);
+		if (!p2pdma)
+			goto err_out;
+
+		if (!p2pdma->active)
+			goto err_out;
+
+		pmap->kaddr = (void *)gen_pool_alloc(p2pdma->pool, pmap->len);
+		if (!pmap->kaddr)
+			goto err_out;
+
+		for (i = 0; i < pmap->len; i += PAGE_SIZE)
+			get_page(virt_to_page(pmap->kaddr + i));
+
+		rcu_read_unlock();
+	}
+
+	vaddr = pmap->kaddr + (vmf->pgoff << PAGE_SHIFT);
+	pfn = phys_to_pfn_t(virt_to_phys(vaddr), PFN_DEV | PFN_MAP);
+
+	return vmf_insert_mixed(vmf->vma, vmf->address, pfn);
+
+err_out:
+	rcu_read_unlock();
+	return VM_FAULT_SIGBUS;
+}
+static const struct vm_operations_struct pci_p2pdma_vmops = {
+	.open = pci_p2pdma_vma_open,
+	.close = pci_p2pdma_vma_close,
+	.fault = pci_p2pdma_vma_fault,
+};
+
+/**
+ * pci_p2pdma_mmap_file_open - setup file mapping to store P2PMEM VMAs
+ * @pdev: the device to allocate memory from
+ * @vma: the userspace vma to map the memory to
+ *
+ * Set f_mapping of the file to the p2pdma inode so that mappings
+ * are can be torn down on device unbind.
+ *
+ * Returns 0 on success, or a negative error code on failure
+ */
+void pci_p2pdma_mmap_file_open(struct pci_dev *pdev, struct file *file)
+{
+	struct pci_p2pdma *p2pdma;
+
+	rcu_read_lock();
+	p2pdma = rcu_dereference(pdev->p2pdma);
+	if (p2pdma)
+		file->f_mapping = p2pdma->inode->i_mapping;
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL_GPL(pci_p2pdma_mmap_file_open);
+
+/**
+ * pci_mmap_p2pmem - setup an mmap region to be backed with P2PDMA memory
+ *	that was registered with pci_p2pdma_add_resource()
+ * @pdev: the device to allocate memory from
+ * @vma: the userspace vma to map the memory to
+ *
+ * The file must call pci_p2pdma_mmap_file_open() in its open() operation.
+ *
+ * Returns 0 on success, or a negative error code on failure
+ */
+int pci_mmap_p2pmem(struct pci_dev *pdev, struct vm_area_struct *vma)
+{
+	struct pci_p2pdma_map *pmap;
+	struct pci_p2pdma *p2pdma;
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
+	pmap = pci_p2pdma_map_alloc(pdev, vma->vm_end - vma->vm_start);
+	if (!pmap)
+		return -ENOMEM;
+
+	rcu_read_lock();
+	p2pdma = rcu_dereference(pdev->p2pdma);
+	if (!p2pdma) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	ret = simple_pin_fs(&pci_p2pdma_fs_type, &pci_p2pdma_fs_mnt,
+			    &pci_p2pdma_fs_cnt);
+	if (ret)
+		goto out;
+
+	ihold(p2pdma->inode);
+	pmap->inode = p2pdma->inode;
+	rcu_read_unlock();
+
+	vma->vm_flags |= VM_MIXEDMAP;
+	vma->vm_private_data = pmap;
+	vma->vm_ops = &pci_p2pdma_vmops;
+
+	return 0;
+
+out:
+	rcu_read_unlock();
+	kfree(pmap);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_mmap_p2pmem);
diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
index 0c33a40a86e7..f9f19f3db676 100644
--- a/include/linux/pci-p2pdma.h
+++ b/include/linux/pci-p2pdma.h
@@ -81,6 +81,8 @@ int pci_p2pdma_enable_store(const char *page, struct pci_dev **p2p_dev,
 			    bool *use_p2pdma);
 ssize_t pci_p2pdma_enable_show(char *page, struct pci_dev *p2p_dev,
 			       bool use_p2pdma);
+void pci_p2pdma_mmap_file_open(struct pci_dev *pdev, struct file *file);
+int pci_mmap_p2pmem(struct pci_dev *pdev, struct vm_area_struct *vma);
 #else /* CONFIG_PCI_P2PDMA */
 static inline int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar,
 		size_t size, u64 offset)
@@ -152,6 +154,15 @@ static inline ssize_t pci_p2pdma_enable_show(char *page,
 {
 	return sprintf(page, "none\n");
 }
+static inline void pci_p2pdma_mmap_file_open(struct pci_dev *pdev,
+					     struct file *file)
+{
+}
+static inline int pci_mmap_p2pmem(struct pci_dev *pdev,
+				  struct vm_area_struct *vma)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_PCI_P2PDMA */
 
 
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index 35687dcb1a42..af737842c56f 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -88,6 +88,7 @@
 #define BPF_FS_MAGIC		0xcafe4a11
 #define AAFS_MAGIC		0x5a3c69f0
 #define ZONEFS_MAGIC		0x5a4f4653
+#define P2PDMA_MAGIC		0x70327064
 
 /* Since UDF 2.01 is ISO 13346 based... */
 #define UDF_SUPER_MAGIC		0x15013346
-- 
2.30.2

