Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9DD43DC8
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 17:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731870AbfFMPpO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 11:45:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33390 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731806AbfFMJn5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jun 2019 05:43:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=J6KgL/HbS2N6LTNHClyEsjbtYbBDeWvEUc8ywUokDbM=; b=Jh8lILEBlkoz7BxZUpZfrk+rPo
        5Vv8zvkEs/Fw9OO79N5N/Y0XT5tjZHyEHTWn8eyvOgqXtUXVd1z/SRTfQtsDOkc03rcc8Oqr+0gGj
        XtkmK2r6kYcloDj/rKBacpiDOED1N5eXx2e3cRHkATAi8m82hHeWGVKkUJ/Fey7N4V9iRL/1FecYK
        PCRNRhSXbu3d/ofC8c+2tCSbKz0UToD06c23kveqrK8w7bUNKe5YMyLwjfgvyitQrNsCgWTU3bjfC
        +/5c3xHAUo+nzc8XFEIMoLhoIwvUGPRqZ8AKtA0fnh3a7Vt8YVEbCbjiXL7LVQ5gOLdxh0voFqRRa
        p1FErRFg==;
Received: from mpp-cp1-natpool-1-198.ethz.ch ([82.130.71.198] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbMGu-0001ni-6t; Thu, 13 Jun 2019 09:43:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     linux-mm@kvack.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/22] memremap: pass a struct dev_pagemap to ->kill
Date:   Thu, 13 Jun 2019 11:43:11 +0200
Message-Id: <20190613094326.24093-9-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613094326.24093-1-hch@lst.de>
References: <20190613094326.24093-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Passing the actual typed structure leads to more understandable code
vs the actual references.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/dax/device.c              | 7 +++----
 drivers/nvdimm/pmem.c             | 6 +++---
 drivers/pci/p2pdma.c              | 6 +++---
 include/linux/memremap.h          | 2 +-
 kernel/memremap.c                 | 4 ++--
 mm/hmm.c                          | 4 ++--
 tools/testing/nvdimm/test/iomap.c | 6 ++----
 7 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 4adab774dade..e23fa1bd8c97 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -37,13 +37,12 @@ static void dev_dax_percpu_exit(void *data)
 	percpu_ref_exit(ref);
 }
 
-static void dev_dax_percpu_kill(struct percpu_ref *data)
+static void dev_dax_percpu_kill(struct dev_pagemap *pgmap)
 {
-	struct percpu_ref *ref = data;
-	struct dev_dax *dev_dax = ref_to_dev_dax(ref);
+	struct dev_dax *dev_dax = container_of(pgmap, struct dev_dax, pgmap);
 
 	dev_dbg(&dev_dax->dev, "%s\n", __func__);
-	percpu_ref_kill(ref);
+	percpu_ref_kill(pgmap->ref);
 }
 
 static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 4efbf184ea68..b9638c6553a1 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -316,11 +316,11 @@ static void pmem_release_queue(void *q)
 	blk_cleanup_queue(q);
 }
 
-static void pmem_kill(struct percpu_ref *ref)
+static void pmem_kill(struct dev_pagemap *pgmap)
 {
-	struct request_queue *q;
+	struct request_queue *q =
+		container_of(pgmap->ref, struct request_queue, q_usage_counter);
 
-	q = container_of(ref, typeof(*q), q_usage_counter);
 	blk_freeze_queue_start(q);
 }
 
diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 6e76380f5b97..3bcacc9222c6 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -82,7 +82,7 @@ static void pci_p2pdma_percpu_release(struct percpu_ref *ref)
 	complete_all(&p2p->devmap_ref_done);
 }
 
-static void pci_p2pdma_percpu_kill(struct percpu_ref *ref)
+static void pci_p2pdma_percpu_kill(struct dev_pagemap *pgmap)
 {
 	/*
 	 * pci_p2pdma_add_resource() may be called multiple times
@@ -90,10 +90,10 @@ static void pci_p2pdma_percpu_kill(struct percpu_ref *ref)
 	 * times. We only want the first action to actually kill the
 	 * percpu_ref.
 	 */
-	if (percpu_ref_is_dying(ref))
+	if (percpu_ref_is_dying(pgmap->ref))
 		return;
 
-	percpu_ref_kill(ref);
+	percpu_ref_kill(pgmap->ref);
 }
 
 static void pci_p2pdma_release(void *data)
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 5f7f40875b35..96a3a6d564ad 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -74,7 +74,7 @@ struct dev_pagemap_ops {
 	/*
 	 * Transition the percpu_ref in struct dev_pagemap to the dead state.
 	 */
-	void (*kill)(struct percpu_ref *ref);
+	void (*kill)(struct dev_pagemap *pgmap);
 };
 
 /**
diff --git a/kernel/memremap.c b/kernel/memremap.c
index e23286ce0ec4..94b830b6eca5 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -92,7 +92,7 @@ static void devm_memremap_pages_release(void *data)
 	unsigned long pfn;
 	int nid;
 
-	pgmap->ops->kill(pgmap->ref);
+	pgmap->ops->kill(pgmap);
 	for_each_device_pfn(pfn, pgmap)
 		put_page(pfn_to_page(pfn));
 
@@ -266,7 +266,7 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
  err_pfn_remap:
 	pgmap_array_delete(res);
  err_array:
-	pgmap->ops->kill(pgmap->ref);
+	pgmap->ops->kill(pgmap);
 	return ERR_PTR(error);
 }
 EXPORT_SYMBOL_GPL(devm_memremap_pages);
diff --git a/mm/hmm.c b/mm/hmm.c
index 2501ac6045d0..c76a1b5defda 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -1325,9 +1325,9 @@ static void hmm_devmem_ref_exit(void *data)
 	percpu_ref_exit(ref);
 }
 
-static void hmm_devmem_ref_kill(struct percpu_ref *ref)
+static void hmm_devmem_ref_kill(struct dev_pagemap *pgmap)
 {
-	percpu_ref_kill(ref);
+	percpu_ref_kill(pgmap->ref);
 }
 
 static vm_fault_t hmm_devmem_fault(struct vm_area_struct *vma,
diff --git a/tools/testing/nvdimm/test/iomap.c b/tools/testing/nvdimm/test/iomap.c
index 7f5ece9b5011..ee07c4de2b35 100644
--- a/tools/testing/nvdimm/test/iomap.c
+++ b/tools/testing/nvdimm/test/iomap.c
@@ -104,11 +104,9 @@ void *__wrap_devm_memremap(struct device *dev, resource_size_t offset,
 }
 EXPORT_SYMBOL(__wrap_devm_memremap);
 
-static void nfit_test_kill(void *_pgmap)
+static void nfit_test_kill(void *pgmap)
 {
-	struct dev_pagemap *pgmap = _pgmap;
-
-	pgmap->ops->kill(pgmap->ref);
+	pgmap->ops->kill(pgmap);
 }
 
 void *__wrap_devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
-- 
2.20.1

