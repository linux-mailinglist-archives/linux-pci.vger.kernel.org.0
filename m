Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECCE95B4E8
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2019 08:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbfGAGUz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jul 2019 02:20:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48426 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbfGAGUx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jul 2019 02:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kPt7QqoQAeZJ9C9mepK91f+1X9hMOg2RzNm4lgmOCmg=; b=fAnfAaMz3Bi39bBAZqCZSGeuQM
        Xsba2waTpHlBW5IwPPLVvjXXLeCwtvh5KfJzq7GeBah6VXSNUvFwesh2TsCGgr9GJ++YhdjQyDGYn
        qR+hlXN/DEa6X4qKaWvnCUCWIdC8L5OLPLmZJvX0+tVWLdwKnUVCUHVXAnv2/hxfZj8mqEskLXeAY
        LRYWG+DnZJIKCqdLfbjS6vrZRwUwsFBEwYabVFw8EzHSik9cafdWu9IuVzT7o2kHPFn+aI4zJwnb+
        B0oPDvbD5Fj2Rg+GDLbMFwXG7/EkSLMjm/VCaQt5ozhMjljL8ESsrrq/wDdpcShqnf5EfoKN5TqJB
        uem06+qw==;
Received: from [46.140.178.35] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hhpgH-00031D-N6; Mon, 01 Jul 2019 06:20:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH 12/22] mm/hmm: Hold on to the mmget for the lifetime of the range
Date:   Mon,  1 Jul 2019 08:20:10 +0200
Message-Id: <20190701062020.19239-13-hch@lst.de>
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

From: Jason Gunthorpe <jgg@mellanox.com>

Range functions like hmm_range_snapshot() and hmm_range_fault() call
find_vma, which requires hodling the mmget() and the mmap_sem for the mm.

Make this simpler for the callers by holding the mmget() inside the range
for the lifetime of the range. Other functions that accept a range should
only be called if the range is registered.

This has the side effect of directly preventing hmm_release() from
happening while a range is registered. That means range->dead cannot be
false during the lifetime of the range, so remove dead and
hmm_mirror_mm_is_alive() entirely.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Philip Yang <Philip.Yang@amd.com>
---
 include/linux/hmm.h | 26 --------------------------
 mm/hmm.c            | 32 +++++++++++---------------------
 2 files changed, 11 insertions(+), 47 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 26e7c477490c..bf013e965257 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -82,7 +82,6 @@
  * @mirrors_sem: read/write semaphore protecting the mirrors list
  * @wq: wait queue for user waiting on a range invalidation
  * @notifiers: count of active mmu notifiers
- * @dead: is the mm dead ?
  */
 struct hmm {
 	struct mm_struct	*mm;
@@ -95,7 +94,6 @@ struct hmm {
 	wait_queue_head_t	wq;
 	struct rcu_head		rcu;
 	long			notifiers;
-	bool			dead;
 };
 
 /*
@@ -459,30 +457,6 @@ struct hmm_mirror {
 int hmm_mirror_register(struct hmm_mirror *mirror, struct mm_struct *mm);
 void hmm_mirror_unregister(struct hmm_mirror *mirror);
 
-/*
- * hmm_mirror_mm_is_alive() - test if mm is still alive
- * @mirror: the HMM mm mirror for which we want to lock the mmap_sem
- * Return: false if the mm is dead, true otherwise
- *
- * This is an optimization, it will not always accurately return false if the
- * mm is dead; i.e., there can be false negatives (process is being killed but
- * HMM is not yet informed of that). It is only intended to be used to optimize
- * out cases where the driver is about to do something time consuming and it
- * would be better to skip it if the mm is dead.
- */
-static inline bool hmm_mirror_mm_is_alive(struct hmm_mirror *mirror)
-{
-	struct mm_struct *mm;
-
-	if (!mirror || !mirror->hmm)
-		return false;
-	mm = READ_ONCE(mirror->hmm->mm);
-	if (mirror->hmm->dead || !mm)
-		return false;
-
-	return true;
-}
-
 /*
  * Please see Documentation/vm/hmm.rst for how to use the range API.
  */
diff --git a/mm/hmm.c b/mm/hmm.c
index 73c8af4827fe..1eddda45cefa 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -67,7 +67,6 @@ static struct hmm *hmm_get_or_create(struct mm_struct *mm)
 	mutex_init(&hmm->lock);
 	kref_init(&hmm->kref);
 	hmm->notifiers = 0;
-	hmm->dead = false;
 	hmm->mm = mm;
 
 	hmm->mmu_notifier.ops = &hmm_mmu_notifier_ops;
@@ -120,21 +119,16 @@ static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 {
 	struct hmm *hmm = container_of(mn, struct hmm, mmu_notifier);
 	struct hmm_mirror *mirror;
-	struct hmm_range *range;
 
 	/* Bail out if hmm is in the process of being freed */
 	if (!kref_get_unless_zero(&hmm->kref))
 		return;
 
-	/* Report this HMM as dying. */
-	hmm->dead = true;
-
-	/* Wake-up everyone waiting on any range. */
-	mutex_lock(&hmm->lock);
-	list_for_each_entry(range, &hmm->ranges, list)
-		range->valid = false;
-	wake_up_all(&hmm->wq);
-	mutex_unlock(&hmm->lock);
+	/*
+	 * Since hmm_range_register() holds the mmget() lock hmm_release() is
+	 * prevented as long as a range exists.
+	 */
+	WARN_ON(!list_empty_careful(&hmm->ranges));
 
 	down_write(&hmm->mirrors_sem);
 	mirror = list_first_entry_or_null(&hmm->mirrors, struct hmm_mirror,
@@ -903,8 +897,8 @@ int hmm_range_register(struct hmm_range *range,
 	range->start = start;
 	range->end = end;
 
-	/* Check if hmm_mm_destroy() was call. */
-	if (hmm->mm == NULL || hmm->dead)
+	/* Prevent hmm_release() from running while the range is valid */
+	if (!mmget_not_zero(hmm->mm))
 		return -EFAULT;
 
 	/* Initialize range to track CPU page table updates. */
@@ -942,11 +936,12 @@ void hmm_range_unregister(struct hmm_range *range)
 		return;
 
 	mutex_lock(&hmm->lock);
-	list_del(&range->list);
+	list_del_init(&range->list);
 	mutex_unlock(&hmm->lock);
 
 	/* Drop reference taken by hmm_range_register() */
 	range->valid = false;
+	mmput(hmm->mm);
 	hmm_put(hmm);
 	range->hmm = NULL;
 }
@@ -974,10 +969,7 @@ long hmm_range_snapshot(struct hmm_range *range)
 	struct vm_area_struct *vma;
 	struct mm_walk mm_walk;
 
-	/* Check if hmm_mm_destroy() was call. */
-	if (hmm->mm == NULL || hmm->dead)
-		return -EFAULT;
-
+	lockdep_assert_held(&hmm->mm->mmap_sem);
 	do {
 		/* If range is no longer valid force retry. */
 		if (!range->valid)
@@ -1072,9 +1064,7 @@ long hmm_range_fault(struct hmm_range *range, bool block)
 	struct mm_walk mm_walk;
 	int ret;
 
-	/* Check if hmm_mm_destroy() was call. */
-	if (hmm->mm == NULL || hmm->dead)
-		return -EFAULT;
+	lockdep_assert_held(&hmm->mm->mmap_sem);
 
 	do {
 		/* If range is no longer valid force retry. */
-- 
2.20.1

