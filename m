Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B39485B4B1
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2019 08:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfGAGUs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jul 2019 02:20:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48336 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbfGAGUq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jul 2019 02:20:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=APKBQWkk9iHwyQHEt2C0MEBOgtO6KbM8T5bZXthkZZI=; b=gSbk2W6E84lf5FtDNmA7UbJzV8
        /YpjENtceLBi7lcdSkKI3hddigiEEfPq448QumXbzCmOvF+HQ4eGiOVwzgEgTxo59mprNYGLlbRal
        pFad60P91vtTjcQCJM33sMokpMT0eR115j8oJP1AFdexcCZJzIE+KPqTW59nqSqC58f1njztm+KLt
        nDzWjqQ54DQdSWM+FGXGX7f9sA7DlL6G91SyOHzqRMJtGs2Vw3Ec9RA8nXlpy5RPimyAnOMxTBWv8
        scgz4P+mEmSq7QkjP1YKS3IDhkGZzrRmUCpak5IqWHEFnT7ZLMR6eXSwhpA9HpzzWOMtkhjLVW6wl
        FwufaIVQ==;
Received: from [46.140.178.35] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hhpgA-0002y7-L6; Mon, 01 Jul 2019 06:20:43 +0000
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
Subject: [PATCH 09/22] mm/hmm: Simplify hmm_get_or_create and make it reliable
Date:   Mon,  1 Jul 2019 08:20:07 +0200
Message-Id: <20190701062020.19239-10-hch@lst.de>
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

As coded this function can false-fail in various racy situations. Make it
reliable and simpler by running under the write side of the mmap_sem and
avoiding the false-failing compare/exchange pattern. Due to the mmap_sem
this no longer has to avoid racing with a 2nd parallel
hmm_get_or_create().

Unfortunately this still has to use the page_table_lock as the
non-sleeping lock protecting mm->hmm, since the contexts where we free the
hmm are incompatible with mmap_sem.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Philip Yang <Philip.Yang@amd.com>
---
 mm/hmm.c | 77 ++++++++++++++++++++++----------------------------------
 1 file changed, 30 insertions(+), 47 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 080b17a2e87e..0423f4ca3a7e 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -31,16 +31,6 @@
 #if IS_ENABLED(CONFIG_HMM_MIRROR)
 static const struct mmu_notifier_ops hmm_mmu_notifier_ops;
 
-static inline struct hmm *mm_get_hmm(struct mm_struct *mm)
-{
-	struct hmm *hmm = READ_ONCE(mm->hmm);
-
-	if (hmm && kref_get_unless_zero(&hmm->kref))
-		return hmm;
-
-	return NULL;
-}
-
 /**
  * hmm_get_or_create - register HMM against an mm (HMM internal)
  *
@@ -55,11 +45,16 @@ static inline struct hmm *mm_get_hmm(struct mm_struct *mm)
  */
 static struct hmm *hmm_get_or_create(struct mm_struct *mm)
 {
-	struct hmm *hmm = mm_get_hmm(mm);
-	bool cleanup = false;
+	struct hmm *hmm;
+
+	lockdep_assert_held_exclusive(&mm->mmap_sem);
 
-	if (hmm)
-		return hmm;
+	/* Abuse the page_table_lock to also protect mm->hmm. */
+	spin_lock(&mm->page_table_lock);
+	hmm = mm->hmm;
+	if (mm->hmm && kref_get_unless_zero(&mm->hmm->kref))
+		goto out_unlock;
+	spin_unlock(&mm->page_table_lock);
 
 	hmm = kmalloc(sizeof(*hmm), GFP_KERNEL);
 	if (!hmm)
@@ -74,57 +69,45 @@ static struct hmm *hmm_get_or_create(struct mm_struct *mm)
 	hmm->notifiers = 0;
 	hmm->dead = false;
 	hmm->mm = mm;
-	mmgrab(hmm->mm);
 
-	spin_lock(&mm->page_table_lock);
-	if (!mm->hmm)
-		mm->hmm = hmm;
-	else
-		cleanup = true;
-	spin_unlock(&mm->page_table_lock);
+	hmm->mmu_notifier.ops = &hmm_mmu_notifier_ops;
+	if (__mmu_notifier_register(&hmm->mmu_notifier, mm)) {
+		kfree(hmm);
+		return NULL;
+	}
 
-	if (cleanup)
-		goto error;
+	mmgrab(hmm->mm);
 
 	/*
-	 * We should only get here if hold the mmap_sem in write mode ie on
-	 * registration of first mirror through hmm_mirror_register()
+	 * We hold the exclusive mmap_sem here so we know that mm->hmm is
+	 * still NULL or 0 kref, and is safe to update.
 	 */
-	hmm->mmu_notifier.ops = &hmm_mmu_notifier_ops;
-	if (__mmu_notifier_register(&hmm->mmu_notifier, mm))
-		goto error_mm;
-
-	return hmm;
-
-error_mm:
 	spin_lock(&mm->page_table_lock);
-	if (mm->hmm == hmm)
-		mm->hmm = NULL;
+	mm->hmm = hmm;
+
+out_unlock:
 	spin_unlock(&mm->page_table_lock);
-error:
-	mmdrop(hmm->mm);
-	kfree(hmm);
-	return NULL;
+	return hmm;
 }
 
 static void hmm_free_rcu(struct rcu_head *rcu)
 {
-	kfree(container_of(rcu, struct hmm, rcu));
+	struct hmm *hmm = container_of(rcu, struct hmm, rcu);
+
+	mmdrop(hmm->mm);
+	kfree(hmm);
 }
 
 static void hmm_free(struct kref *kref)
 {
 	struct hmm *hmm = container_of(kref, struct hmm, kref);
-	struct mm_struct *mm = hmm->mm;
 
-	mmu_notifier_unregister_no_release(&hmm->mmu_notifier, mm);
+	spin_lock(&hmm->mm->page_table_lock);
+	if (hmm->mm->hmm == hmm)
+		hmm->mm->hmm = NULL;
+	spin_unlock(&hmm->mm->page_table_lock);
 
-	spin_lock(&mm->page_table_lock);
-	if (mm->hmm == hmm)
-		mm->hmm = NULL;
-	spin_unlock(&mm->page_table_lock);
-
-	mmdrop(hmm->mm);
+	mmu_notifier_unregister_no_release(&hmm->mmu_notifier, hmm->mm);
 	mmu_notifier_call_srcu(&hmm->rcu, hmm_free_rcu);
 }
 
-- 
2.20.1

