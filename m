Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6E4616AEA8
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 19:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbgBXSYd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 13:24:33 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55782 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbgBXSYc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2020 13:24:32 -0500
Received: by mail-wm1-f65.google.com with SMTP id q9so296374wmj.5
        for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2020 10:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kbHJ4C4uglc6rYdZYTlW3Ff7m1UL228yD2k/lvDMteQ=;
        b=BxwepHpIFjHRcQQpVZG+EplOFBe3rPSTVBngLVdFteqRT2sLkmijWsDNxP3gXAef7v
         A9Ki3xgUFAgIDFoku0kKMZVVruyvYqZ8P8ImelWV3mtAtcAJTUGNA/kEnXYxrutWTloe
         fmjk12xB0K+ir7axe3XxEzuiqhFr0/u9/5K9kFOyGIdcu5bt5VVq83gQymC8zsmkJCrv
         voT9EkmQHwO+gN+4rzvID2aVflV2VnNv2bi6U866Sm6W2RilOTdNfOLgBgPttVSwqcS3
         OsiGL9oPhNzw8EjsxCP7KMoEV62b+oEAsAdB6DLym25mnnvzgc/nSHXSofYo+yTjBwRE
         C0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kbHJ4C4uglc6rYdZYTlW3Ff7m1UL228yD2k/lvDMteQ=;
        b=Ee6iVbRXIM/HpO1HwCVZvIog78wKg1aYcDxpgdCJWiwLa1ATIn/wteuucVAFxAad3T
         U5Fuo3gnERUd/fCalmDbaVX79eNnYlcabFVel9AGj83BuMAnuJ7ow5T9Od9H4VwSz2V/
         6XCfTjPUB5eq8SAR87I+G9z+tW1h0ddVkOCgKkT9OJWnTGjqfdcfRJ++JgpCW683q3sY
         KLmBplmzwYgETDlOthmIBUzQ97pMwW1rwbVSsB7yXR9Jls8RQ1avwhndquMUxHhG/Q4R
         16cLUjcS8QXxGM64jPPjjOK9mavlaOAskUgAmMaaWnt0NcxXoAY9DoqcuiJoC7fd1FEe
         d4wQ==
X-Gm-Message-State: APjAAAXxgJQKwYFzJT7EkQTOkSth7fMWTptUF//f/Nt1YdH1TCuxyBdj
        rMpZROmS2gDx2qVW0QshTtftkQ==
X-Google-Smtp-Source: APXvYqxeEVL2FgAN9u8VRKK0cl4gGMwWc0V5xlt1mC7IWnfDQ/iqcXGTBT4xHtfN+pJg9F8k5m70JQ==
X-Received: by 2002:a1c:7919:: with SMTP id l25mr284798wme.135.1582568670689;
        Mon, 24 Feb 2020 10:24:30 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id n3sm304255wmc.27.2020.02.24.10.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 10:24:30 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will@kernel.org, robin.murphy@arm.com,
        kevin.tian@intel.com, baolu.lu@linux.intel.com,
        Jonathan.Cameron@huawei.com, jacob.jun.pan@linux.intel.com,
        christian.koenig@amd.com, yi.l.liu@intel.com,
        zhangfei.gao@linaro.org, Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dimitri Sivanich <sivanich@sgi.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v4 01/26] mm/mmu_notifiers: pass private data down to alloc_notifier()
Date:   Mon, 24 Feb 2020 19:23:36 +0100
Message-Id: <20200224182401.353359-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200224182401.353359-1-jean-philippe@linaro.org>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The new allocation scheme introduced by 2c7933f53f6b ("mm/mmu_notifiers:
add a get/put scheme for the registration") provides a convenient way
for users to attach notifier data to an mm. However, it would be even
better to create this notifier data atomically.

Since the alloc_notifier() callback only takes an mm argument at the
moment, some users have to perform the allocation in two times.
alloc_notifier() initially creates an incomplete structure, which is
then finalized using more context once mmu_notifier_get() returns. This
second step requires carrying an initialization lock in the notifier
data and playing dirty tricks to order memory accesses against live
invalidation.

To simplify MMU notifier allocation, pass an allocation context to
mmu_notifier_get().

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Dimitri Sivanich <sivanich@sgi.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/misc/sgi-gru/grutlbpurge.c |  4 ++--
 include/linux/mmu_notifier.h       | 10 ++++++----
 mm/mmu_notifier.c                  |  6 ++++--
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/sgi-gru/grutlbpurge.c b/drivers/misc/sgi-gru/grutlbpurge.c
index 10921cd2608d..77610e1704f6 100644
--- a/drivers/misc/sgi-gru/grutlbpurge.c
+++ b/drivers/misc/sgi-gru/grutlbpurge.c
@@ -235,7 +235,7 @@ static void gru_invalidate_range_end(struct mmu_notifier *mn,
 		gms, range->start, range->end);
 }
 
-static struct mmu_notifier *gru_alloc_notifier(struct mm_struct *mm)
+static struct mmu_notifier *gru_alloc_notifier(struct mm_struct *mm, void *privdata)
 {
 	struct gru_mm_struct *gms;
 
@@ -266,7 +266,7 @@ struct gru_mm_struct *gru_register_mmu_notifier(void)
 {
 	struct mmu_notifier *mn;
 
-	mn = mmu_notifier_get_locked(&gru_mmuops, current->mm);
+	mn = mmu_notifier_get_locked(&gru_mmuops, current->mm, NULL);
 	if (IS_ERR(mn))
 		return ERR_CAST(mn);
 
diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index 736f6918335e..06e68fa2b019 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -207,7 +207,7 @@ struct mmu_notifier_ops {
 	 * callbacks are currently running. It is called from a SRCU callback
 	 * and cannot sleep.
 	 */
-	struct mmu_notifier *(*alloc_notifier)(struct mm_struct *mm);
+	struct mmu_notifier *(*alloc_notifier)(struct mm_struct *mm, void *privdata);
 	void (*free_notifier)(struct mmu_notifier *subscription);
 };
 
@@ -271,14 +271,16 @@ static inline int mm_has_notifiers(struct mm_struct *mm)
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
diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index ef3973a5d34a..8beb9dcbe0fd 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -734,6 +734,7 @@ find_get_mmu_notifier(struct mm_struct *mm, const struct mmu_notifier_ops *ops)
  *                           the mm & ops
  * @ops: The operations struct being subscribe with
  * @mm : The mm to attach notifiers too
+ * @privdata: Initialization data passed down to ops->alloc_notifier()
  *
  * This function either allocates a new mmu_notifier via
  * ops->alloc_notifier(), or returns an already existing notifier on the
@@ -747,7 +748,8 @@ find_get_mmu_notifier(struct mm_struct *mm, const struct mmu_notifier_ops *ops)
  * and can be converted to an active mm pointer via mmget_not_zero().
  */
 struct mmu_notifier *mmu_notifier_get_locked(const struct mmu_notifier_ops *ops,
-					     struct mm_struct *mm)
+					     struct mm_struct *mm,
+					     void *privdata)
 {
 	struct mmu_notifier *subscription;
 	int ret;
@@ -760,7 +762,7 @@ struct mmu_notifier *mmu_notifier_get_locked(const struct mmu_notifier_ops *ops,
 			return subscription;
 	}
 
-	subscription = ops->alloc_notifier(mm);
+	subscription = ops->alloc_notifier(mm, privdata);
 	if (IS_ERR(subscription))
 		return subscription;
 	subscription->ops = ops;
-- 
2.25.0

