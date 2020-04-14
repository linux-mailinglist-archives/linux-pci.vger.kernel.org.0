Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308C71A8694
	for <lists+linux-pci@lfdr.de>; Tue, 14 Apr 2020 19:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbgDNREX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Apr 2020 13:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391162AbgDNREU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Apr 2020 13:04:20 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334C9C061A10
        for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2020 10:04:20 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id z6so14954819wml.2
        for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2020 10:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b6r9zjaLOb/GY5SoRpnEsPfEzGNaayu9MqJdVBCZ20o=;
        b=iWE+Ha3lwIqVGIoKielsz3b3GDoqi8l3C468or7bgi54G/h1gdEn0dD/YvuAMHgCeJ
         EMqOZbJZx5U5awxLOQAd2pINRO8y8sNmo7jLhIBYvGyt19LoEB9d7iUIzre18QneTMXO
         LqFGxoLmiYcy+EhTcPGD3P50QcwUTSk+obkjlzR6wyD7Cu8axRt34C4qoR19Q4fY/qPu
         6cYohrZxSw/fNyRoRu7miy+Fp0/LP/4nC/zrXgblHo9xmLPZQrrkD5FpmmKK22xAGV8L
         lCjeZ0jBo7yLQuG0hyuY2ROHJ2xc1P/6x6Aq3o5kGd0600JT2eI6K17NmBDNHw+mYaTf
         G5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b6r9zjaLOb/GY5SoRpnEsPfEzGNaayu9MqJdVBCZ20o=;
        b=osaEw/k51SiRLV5r6NAIdnoGTvmJ67qeyYpbvd6QLa5OxW9xn31j2Gv9EIU+tAdenn
         li+IxbIJ+qV4611btfSSxv7Jt4czf65kJb5O2YwljlUoqYNzLXCEgNkFXWuix5oTx6gD
         jjZ24s8kCaZelMDNozoxopetVVmYmdqm/CPhdJFGLubZqcn+RvRHvYE0Wu+rGfiaAcUd
         LXqFUhdf6lst0DdTDQB/yCXj1B/VYfkzlxDSnAuhrzWNjKuixE1im56UxsezjqGjpubF
         XrdfmBcDV9hlHuL/7tINkn5y8quFqIKGavn3A8iUt7pYQdP3pPKvKh1uGN8BucKls3Ec
         JRNw==
X-Gm-Message-State: AGi0PuaoNpr6xU3Otdlz2W3WGGBCJHkcfj+ESagjwLcNBPgIKusJlwmW
        oe6+SM1eD4uNur/xGGy/5kO0Nw==
X-Google-Smtp-Source: APiQypLthjr9z+as/UbmGxH1LFQNNhaVrNfKWpaF3zHP/bGjSokMXTPjjI6Xd6SCr4lJr4d8XHGMDw==
X-Received: by 2002:a1c:3281:: with SMTP id y123mr814161wmy.30.1586883858934;
        Tue, 14 Apr 2020 10:04:18 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id x18sm19549147wrs.11.2020.04.14.10.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 10:04:18 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org
Cc:     joro@8bytes.org, catalin.marinas@arm.com, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        zhangfei.gao@linaro.org, jgg@ziepe.ca, xuzaibo@huawei.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Dimitri Sivanich <sivanich@sgi.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v5 01/25] mm/mmu_notifiers: pass private data down to alloc_notifier()
Date:   Tue, 14 Apr 2020 19:02:29 +0200
Message-Id: <20200414170252.714402-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200414170252.714402-1-jean-philippe@linaro.org>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The new allocation scheme introduced by commit 2c7933f53f6b
("mm/mmu_notifiers: add a get/put scheme for the registration") provides
a convenient way for users to attach notifier data to an mm. However, it
would be even better to create this notifier data atomically.

Since the alloc_notifier() callback only takes an mm argument at the
moment, some users have to perform the allocation in two times.
alloc_notifier() initially creates an incomplete structure, which is
then finalized using more context once mmu_notifier_get() returns. This
second step requires extra care to order memory accesses against live
invalidation.

The IOMMU SVA module, which attaches an mm to multiple devices,
exemplifies this situation. In essence it does:

	mmu_notifier_get()
	  alloc_notifier()
	     A = kzalloc()
	  /* MMU notifier is published */
	A->ctx = ctx;				// (1)
	device->A = A;
	list_add_rcu(device, A->devices);	// (2)

The invalidate notifier, which may start running before A is fully
initialized, does the following:

	io_mm_invalidate(A)
	  list_for_each_entry_rcu(device, A->devices)
	    device->invalidate(A->ctx)

The invalidate() thread must observe the initialization (1) before (2),
which is easily solved by fully initializing object A in
alloc_notifier(), before publishing the MMU notifier.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Dimitri Sivanich <sivanich@sgi.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v4->v5: provide example in commit message, fix style.
---
 include/linux/mmu_notifier.h       | 11 +++++++----
 drivers/misc/sgi-gru/grutlbpurge.c |  5 +++--
 mm/mmu_notifier.c                  |  6 ++++--
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index 736f6918335ed..0536fe85e7457 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -207,7 +207,8 @@ struct mmu_notifier_ops {
 	 * callbacks are currently running. It is called from a SRCU callback
 	 * and cannot sleep.
 	 */
-	struct mmu_notifier *(*alloc_notifier)(struct mm_struct *mm);
+	struct mmu_notifier *(*alloc_notifier)(struct mm_struct *mm,
+					       void *privdata);
 	void (*free_notifier)(struct mmu_notifier *subscription);
 };
 
@@ -271,14 +272,16 @@ static inline int mm_has_notifiers(struct mm_struct *mm)
 }
 
 struct mmu_notifier *mmu_notifier_get_locked(const struct mmu_notifier_ops *ops,
-					     struct mm_struct *mm);
+					     struct mm_struct *mm,
+					     void *privdata);
 static inline struct mmu_notifier *
-mmu_notifier_get(const struct mmu_notifier_ops *ops, struct mm_struct *mm)
+mmu_notifier_get(const struct mmu_notifier_ops *ops, struct mm_struct *mm,
+		 void *privdata)
 {
 	struct mmu_notifier *ret;
 
 	down_write(&mm->mmap_sem);
-	ret = mmu_notifier_get_locked(ops, mm);
+	ret = mmu_notifier_get_locked(ops, mm, privdata);
 	up_write(&mm->mmap_sem);
 	return ret;
 }
diff --git a/drivers/misc/sgi-gru/grutlbpurge.c b/drivers/misc/sgi-gru/grutlbpurge.c
index 10921cd2608df..336e1b1df072f 100644
--- a/drivers/misc/sgi-gru/grutlbpurge.c
+++ b/drivers/misc/sgi-gru/grutlbpurge.c
@@ -235,7 +235,8 @@ static void gru_invalidate_range_end(struct mmu_notifier *mn,
 		gms, range->start, range->end);
 }
 
-static struct mmu_notifier *gru_alloc_notifier(struct mm_struct *mm)
+static struct mmu_notifier *gru_alloc_notifier(struct mm_struct *mm,
+					       void *privdata)
 {
 	struct gru_mm_struct *gms;
 
@@ -266,7 +267,7 @@ struct gru_mm_struct *gru_register_mmu_notifier(void)
 {
 	struct mmu_notifier *mn;
 
-	mn = mmu_notifier_get_locked(&gru_mmuops, current->mm);
+	mn = mmu_notifier_get_locked(&gru_mmuops, current->mm, NULL);
 	if (IS_ERR(mn))
 		return ERR_CAST(mn);
 
diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 06852b896fa63..6b9bfb8ca94d2 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -743,6 +743,7 @@ find_get_mmu_notifier(struct mm_struct *mm, const struct mmu_notifier_ops *ops)
  *                           the mm & ops
  * @ops: The operations struct being subscribe with
  * @mm : The mm to attach notifiers too
+ * @privdata: Initialization data passed down to ops->alloc_notifier()
  *
  * This function either allocates a new mmu_notifier via
  * ops->alloc_notifier(), or returns an already existing notifier on the
@@ -756,7 +757,8 @@ find_get_mmu_notifier(struct mm_struct *mm, const struct mmu_notifier_ops *ops)
  * and can be converted to an active mm pointer via mmget_not_zero().
  */
 struct mmu_notifier *mmu_notifier_get_locked(const struct mmu_notifier_ops *ops,
-					     struct mm_struct *mm)
+					     struct mm_struct *mm,
+					     void *privdata)
 {
 	struct mmu_notifier *subscription;
 	int ret;
@@ -769,7 +771,7 @@ struct mmu_notifier *mmu_notifier_get_locked(const struct mmu_notifier_ops *ops,
 			return subscription;
 	}
 
-	subscription = ops->alloc_notifier(mm);
+	subscription = ops->alloc_notifier(mm, privdata);
 	if (IS_ERR(subscription))
 		return subscription;
 	subscription->ops = ops;
-- 
2.26.0

