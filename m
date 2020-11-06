Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 926BB2A9A4C
	for <lists+linux-pci@lfdr.de>; Fri,  6 Nov 2020 18:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgKFRBx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Nov 2020 12:01:53 -0500
Received: from ale.deltatee.com ([204.191.154.188]:57674 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727765AbgKFRA6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Nov 2020 12:00:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5dvKfzRnO0iiiLL/CYBa9gf//32ohjJCm8GSYQzKYAs=; b=Bjj9w5enjWXzYve9zF10M+2O9P
        qjVGNonCDmqcDolyhjugoGithINjBxlB/lx8aYU7j9Fd9F4mEgsxs2J7X5pgLFNdwuriDlCJep9hR
        EDoGZ4dVz7LW07ISC74HuoBMP0AFPEZ8d3iZ2gUCXE5nTe9eQGQyrniQmkZYDp1YJmgOS8+N5LC5U
        jW4dO74EYiAbhsAzx0C5Jyt8MQx8C6uv/BLPAvRjgQ8By2vdhAjcX28IMS053QSvZPJnrtkyXUutw
        iL1GnELk8QMpL5Kia/vaMQgw/h3WCQ6HXpcipTLtRdpt91b/0NfNWFnXLQhcTWyzVyMVJsMXGHOdf
        +Z9NM3tQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kb56d-0002PY-EO; Fri, 06 Nov 2020 10:00:57 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kb56V-0004tT-Sy; Fri, 06 Nov 2020 10:00:47 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Ira Weiny <iweiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Fri,  6 Nov 2020 10:00:35 -0700
Message-Id: <20201106170036.18713-15-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201106170036.18713-1-logang@deltatee.com>
References: <20201106170036.18713-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de, jgg@ziepe.ca, christian.koenig@amd.com, dan.j.williams@intel.com, iweiny@intel.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_FREE,MYRULES_NO_TEXT autolearn=ham
        autolearn_force=no version=3.4.2
Subject: [RFC PATCH 14/15] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Introduce pci_mmap_p2pmem() which is a helper to allocate and mmap
a hunk of p2pmem into userspace.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/p2pdma.c       | 104 +++++++++++++++++++++++++++++++++++++
 include/linux/pci-p2pdma.h |   6 +++
 2 files changed, 110 insertions(+)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 9961e779f430..8eab53ac59ae 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -16,6 +16,7 @@
 #include <linux/genalloc.h>
 #include <linux/memremap.h>
 #include <linux/percpu-refcount.h>
+#include <linux/pfn_t.h>
 #include <linux/random.h>
 #include <linux/seq_buf.h>
 #include <linux/xarray.h>
@@ -1055,3 +1056,106 @@ ssize_t pci_p2pdma_enable_show(char *page, struct pci_dev *p2p_dev,
 	return sprintf(page, "%s\n", pci_name(p2p_dev));
 }
 EXPORT_SYMBOL_GPL(pci_p2pdma_enable_show);
+
+struct pci_p2pdma_map {
+	struct kref ref;
+	struct pci_dev *pdev;
+	void *kaddr;
+	size_t len;
+};
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
+	pmap->pdev = pdev;
+	pmap->len = len;
+
+	pmap->kaddr = pci_alloc_p2pmem(pdev, len);
+	if (!pmap->kaddr) {
+		kfree(pmap);
+		return NULL;
+	}
+
+	return pmap;
+}
+
+static void pci_p2pdma_map_free(struct kref *ref)
+{
+	struct pci_p2pdma_map *pmap =
+		container_of(ref, struct pci_p2pdma_map, ref);
+
+	pci_free_p2pmem(pmap->pdev, pmap->kaddr, pmap->len);
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
+const struct vm_operations_struct pci_p2pdma_vmops = {
+	.open = pci_p2pdma_vma_open,
+	.close = pci_p2pdma_vma_close,
+};
+
+/**
+ * pci_mmap_p2pmem - allocate peer-to-peer DMA memory
+ * @pdev: the device to allocate memory from
+ * @vma: the userspace vma to map the memory to
+ *
+ * Returns 0 on success, or a negative error code on failure
+ */
+int pci_mmap_p2pmem(struct pci_dev *pdev, struct vm_area_struct *vma)
+{
+	struct pci_p2pdma_map *pmap;
+	unsigned long addr, pfn;
+	vm_fault_t ret;
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
+	vma->vm_flags |= VM_MIXEDMAP;
+	vma->vm_private_data = pmap;
+	vma->vm_ops = &pci_p2pdma_vmops;
+
+	pfn = virt_to_phys(pmap->kaddr) >> PAGE_SHIFT;
+	for (addr = vma->vm_start; addr < vma->vm_end; addr += PAGE_SIZE) {
+		ret = vmf_insert_mixed(vma, addr,
+				       __pfn_to_pfn_t(pfn, PFN_DEV | PFN_MAP));
+		if (ret & VM_FAULT_ERROR)
+			goto out_error;
+		pfn++;
+	}
+
+	return 0;
+
+out_error:
+	kref_put(&pmap->ref, pci_p2pdma_map_free);
+	return -EFAULT;
+}
+EXPORT_SYMBOL_GPL(pci_mmap_p2pmem);
diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
index fc5de47eeac4..26fe40363d1c 100644
--- a/include/linux/pci-p2pdma.h
+++ b/include/linux/pci-p2pdma.h
@@ -40,6 +40,7 @@ int pci_p2pdma_enable_store(const char *page, struct pci_dev **p2p_dev,
 			    bool *use_p2pdma);
 ssize_t pci_p2pdma_enable_show(char *page, struct pci_dev *p2p_dev,
 			       bool use_p2pdma);
+int pci_mmap_p2pmem(struct pci_dev *pdev, struct vm_area_struct *vma);
 #else /* CONFIG_PCI_P2PDMA */
 static inline int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar,
 		size_t size, u64 offset)
@@ -116,6 +117,11 @@ static inline ssize_t pci_p2pdma_enable_show(char *page,
 {
 	return sprintf(page, "none\n");
 }
+static inline int pci_mmap_p2pmem(struct pci_dev *pdev,
+				  struct vm_area_struct *vma)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_PCI_P2PDMA */
 
 
-- 
2.20.1

