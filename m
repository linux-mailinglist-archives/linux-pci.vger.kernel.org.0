Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 007915B4DC
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2019 08:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbfGAGVM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jul 2019 02:21:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48644 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbfGAGVL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jul 2019 02:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tWgCV0T5gyBBloZRaADn3Gi+6+ID0uvOOaOC/BREjAY=; b=o95YPE7Ed8kykY6bfvr4aZ6u4a
        iqVj/FoZrabOP8GDjgVj/9kqBGTTn4CmRLeIxb1rNW3VxoSW4AVNy/eAyP4qrIvkxkbxj+rI/Pvok
        RmFYJ5q7h6/x66KlLFTEjo/16kYV8FBai9C7tW5NgGcfwfE+rgvK/NKditEuH0Fv6LFdrnBsnb9Cz
        3jCoRpM3l4EDwQLfGOFXE5x/awO4QWFV3Iwjwsar5N34jJAtY9I4Ge806rGwjeZ32tkVsqr4SKF5i
        +B8R6m57E3Hu5awfYglSUsyp/80U+lJGXdAGb9+ckm2WeqWt4HoRPT4Z475oxzhHiwLHg1y7KmucZ
        WnLoHtpA==;
Received: from [46.140.178.35] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hhpgZ-0003OJ-Fg; Mon, 01 Jul 2019 06:21:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 20/22] mm: move hmm_vma_fault to nouveau
Date:   Mon,  1 Jul 2019 08:20:18 +0200
Message-Id: <20190701062020.19239-21-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701062020.19239-1-hch@lst.de>
References: <20190701062020.19239-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

hmm_vma_fault is marked as a legacy API to get rid of, but quite suites
the current nouvea flow.  Move it to the only user in preparation for
fixing a locking bug involving caller and callee.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/nouveau/nouveau_svm.c | 54 ++++++++++++++++++++++++++-
 include/linux/hmm.h                   | 54 ---------------------------
 2 files changed, 53 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index 9d40114d7949..e831f4184a17 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -36,6 +36,13 @@
 #include <linux/sort.h>
 #include <linux/hmm.h>
 
+/*
+ * When waiting for mmu notifiers we need some kind of time out otherwise we
+ * could potentialy wait for ever, 1000ms ie 1s sounds like a long time to
+ * wait already.
+ */
+#define NOUVEAU_RANGE_FAULT_TIMEOUT 1000
+
 struct nouveau_svm {
 	struct nouveau_drm *drm;
 	struct mutex mutex;
@@ -475,6 +482,51 @@ nouveau_svm_fault_cache(struct nouveau_svm *svm,
 		fault->inst, fault->addr, fault->access);
 }
 
+static int
+nouveau_range_fault(struct hmm_mirror *mirror, struct hmm_range *range,
+		    bool block)
+{
+	long ret;
+
+	/*
+	 * With the old API the driver must set each individual entries with
+	 * the requested flags (valid, write, ...). So here we set the mask to
+	 * keep intact the entries provided by the driver and zero out the
+	 * default_flags.
+	 */
+	range->default_flags = 0;
+	range->pfn_flags_mask = -1UL;
+
+	ret = hmm_range_register(range, mirror,
+				 range->start, range->end,
+				 PAGE_SHIFT);
+	if (ret)
+		return (int)ret;
+
+	if (!hmm_range_wait_until_valid(range, NOUVEAU_RANGE_FAULT_TIMEOUT)) {
+		/*
+		 * The mmap_sem was taken by driver we release it here and
+		 * returns -EAGAIN which correspond to mmap_sem have been
+		 * drop in the old API.
+		 */
+		up_read(&range->vma->vm_mm->mmap_sem);
+		return -EAGAIN;
+	}
+
+	ret = hmm_range_fault(range, block);
+	if (ret <= 0) {
+		if (ret == -EBUSY || !ret) {
+			/* Same as above, drop mmap_sem to match old API. */
+			up_read(&range->vma->vm_mm->mmap_sem);
+			ret = -EBUSY;
+		} else if (ret == -EAGAIN)
+			ret = -EBUSY;
+		hmm_range_unregister(range);
+		return ret;
+	}
+	return 0;
+}
+
 static int
 nouveau_svm_fault(struct nvif_notify *notify)
 {
@@ -649,7 +701,7 @@ nouveau_svm_fault(struct nvif_notify *notify)
 		range.values = nouveau_svm_pfn_values;
 		range.pfn_shift = NVIF_VMM_PFNMAP_V0_ADDR_SHIFT;
 again:
-		ret = hmm_vma_fault(&svmm->mirror, &range, true);
+		ret = nouveau_range_fault(&svmm->mirror, &range, true);
 		if (ret == 0) {
 			mutex_lock(&svmm->mutex);
 			if (!hmm_range_unregister(&range)) {
diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 4b185d286c3b..3457cf9182e5 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -478,60 +478,6 @@ long hmm_range_dma_unmap(struct hmm_range *range,
 			 dma_addr_t *daddrs,
 			 bool dirty);
 
-/*
- * HMM_RANGE_DEFAULT_TIMEOUT - default timeout (ms) when waiting for a range
- *
- * When waiting for mmu notifiers we need some kind of time out otherwise we
- * could potentialy wait for ever, 1000ms ie 1s sounds like a long time to
- * wait already.
- */
-#define HMM_RANGE_DEFAULT_TIMEOUT 1000
-
-/* This is a temporary helper to avoid merge conflict between trees. */
-static inline int hmm_vma_fault(struct hmm_mirror *mirror,
-				struct hmm_range *range, bool block)
-{
-	long ret;
-
-	/*
-	 * With the old API the driver must set each individual entries with
-	 * the requested flags (valid, write, ...). So here we set the mask to
-	 * keep intact the entries provided by the driver and zero out the
-	 * default_flags.
-	 */
-	range->default_flags = 0;
-	range->pfn_flags_mask = -1UL;
-
-	ret = hmm_range_register(range, mirror,
-				 range->start, range->end,
-				 PAGE_SHIFT);
-	if (ret)
-		return (int)ret;
-
-	if (!hmm_range_wait_until_valid(range, HMM_RANGE_DEFAULT_TIMEOUT)) {
-		/*
-		 * The mmap_sem was taken by driver we release it here and
-		 * returns -EAGAIN which correspond to mmap_sem have been
-		 * drop in the old API.
-		 */
-		up_read(&range->vma->vm_mm->mmap_sem);
-		return -EAGAIN;
-	}
-
-	ret = hmm_range_fault(range, block);
-	if (ret <= 0) {
-		if (ret == -EBUSY || !ret) {
-			/* Same as above, drop mmap_sem to match old API. */
-			up_read(&range->vma->vm_mm->mmap_sem);
-			ret = -EBUSY;
-		} else if (ret == -EAGAIN)
-			ret = -EBUSY;
-		hmm_range_unregister(range);
-		return ret;
-	}
-	return 0;
-}
-
 /* Below are for HMM internal use only! Not to be used by device driver! */
 static inline void hmm_mm_init(struct mm_struct *mm)
 {
-- 
2.20.1

