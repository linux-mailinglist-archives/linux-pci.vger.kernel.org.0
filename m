Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3912D1D9E6E
	for <lists+linux-pci@lfdr.de>; Tue, 19 May 2020 20:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgESSBv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 May 2020 14:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbgESSBv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 May 2020 14:01:51 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2A8C08C5C0
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2020 11:01:49 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id h17so388210wrc.8
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2020 11:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NSaXkG4DBzNCdQ4OZDMt/0atg6IYfB3L/KPL3V3BCYk=;
        b=nQU00t3D3kWSaVXfKB6ILMM8HhndFO++HUNfNGnl/4ZnY/Rhi7BHTDXR9BpRR0c0qT
         z19ba52YPIwtH4OcM+u0Xdf2tw84kXX05CqOe48/inMpbcHCXlyR9H10fSIDK59pInIA
         15/+tVGMmO+cfZN3/1D4OlqeHoUN05oqhn13vYpWJHIuNsEADi+xswr96WrPDIde7sN+
         wBoY5thPuyrhQlVYF77YHWxFTUSrBCzatmWZFsnpNMn89Pg9cHgJG36M0/aja3AbRcNw
         VHZVVAUGNBCFwjuZNdBhxmesYIBszgrGeKkhSFOIx+ZJbzmAQ0Bv4FSvtSu2/5TpI/jH
         MLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NSaXkG4DBzNCdQ4OZDMt/0atg6IYfB3L/KPL3V3BCYk=;
        b=UNCSd19I3a0wQzVQ311SlegZqp/4XbBfsUU+b/1IioR+9lbOfcVuzrbrAFF58AnkDX
         s2J7F5dNiOLCffYSjAUbMVXt7hE3eSMZSJEZrbYq05f35A+jTjPC/vHBQCCG8iSAxHy+
         4IrWSg9lryNljqXKeo02B9f2bglBiqWgSPtG40RD2wPMxBhEjCIWI2/dXHCTGVFj2AfO
         1b4CS2Dps0WSrhwyW8jt2j5ZgHm0eC7n52QQMtHgD5bmIzifZTg+i+wr6mJ0eS75KBDP
         Xep5oDCm2+jlNhTpuH9kGUs4eWhAznHI5ggwTu0ATZUXN+N3DGWc25R7C2pOffQGf4EO
         UPug==
X-Gm-Message-State: AOAM53241WXnRywIlidZ0/9PozubknMZgqN/ECGtspN9TYM4apnNuYx3
        5eeH+6d9q6p3DXhwNqSodhN4uQ==
X-Google-Smtp-Source: ABdhPJwNMcsg8nvKB0kC8qUGaFg91bhfG5z/uwW4vZV0zE+ZApr2q4kMr3hbdFGf3VvkTxQmHPCTfQ==
X-Received: by 2002:adf:f981:: with SMTP id f1mr114539wrr.244.1589911308565;
        Tue, 19 May 2020 11:01:48 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id 1sm510496wmz.13.2020.05.19.11.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 11:01:48 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org
Cc:     joro@8bytes.org, catalin.marinas@arm.com, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        felix.kuehling@amd.com, zhangfei.gao@linaro.org, jgg@ziepe.ca,
        xuzaibo@huawei.com, fenghua.yu@intel.com, hch@infradead.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v7 06/24] arm64: mm: Pin down ASIDs for sharing mm with devices
Date:   Tue, 19 May 2020 19:54:44 +0200
Message-Id: <20200519175502.2504091-7-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519175502.2504091-1-jean-philippe@linaro.org>
References: <20200519175502.2504091-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

To enable address space sharing with the IOMMU, introduce mm_context_get()
and mm_context_put(), that pin down a context and ensure that it will keep
its ASID after a rollover. Export the symbols to let the modular SMMUv3
driver use them.

Pinning is necessary because a device constantly needs a valid ASID,
unlike tasks that only require one when running. Without pinning, we would
need to notify the IOMMU when we're about to use a new ASID for a task,
and it would get complicated when a new task is assigned a shared ASID.
Consider the following scenario with no ASID pinned:

1. Task t1 is running on CPUx with shared ASID (gen=1, asid=1)
2. Task t2 is scheduled on CPUx, gets ASID (1, 2)
3. Task tn is scheduled on CPUy, a rollover occurs, tn gets ASID (2, 1)
   We would now have to immediately generate a new ASID for t1, notify
   the IOMMU, and finally enable task tn. We are holding the lock during
   all that time, since we can't afford having another CPU trigger a
   rollover. The IOMMU issues invalidation commands that can take tens of
   milliseconds.

It gets needlessly complicated. All we wanted to do was schedule task tn,
that has no business with the IOMMU. By letting the IOMMU pin tasks when
needed, we avoid stalling the slow path, and let the pinning fail when
we're out of shareable ASIDs.

After a rollover, the allocator expects at least one ASID to be available
in addition to the reserved ones (one per CPU). So (NR_ASIDS - NR_CPUS -
1) is the maximum number of ASIDs that can be shared with the IOMMU.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 arch/arm64/include/asm/mmu.h         |  1 +
 arch/arm64/include/asm/mmu_context.h | 11 +++-
 arch/arm64/mm/context.c              | 95 +++++++++++++++++++++++++++-
 3 files changed, 104 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 68140fdd89d6..bbdd291e31d5 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -19,6 +19,7 @@
 
 typedef struct {
 	atomic64_t	id;
+	unsigned long	pinned;
 	void		*vdso;
 	unsigned long	flags;
 } mm_context_t;
diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index ab46187c6300..69599a64945b 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -177,7 +177,13 @@ static inline void cpu_replace_ttbr1(pgd_t *pgdp)
 #define destroy_context(mm)		do { } while(0)
 void check_and_switch_context(struct mm_struct *mm, unsigned int cpu);
 
-#define init_new_context(tsk,mm)	({ atomic64_set(&(mm)->context.id, 0); 0; })
+static inline int
+init_new_context(struct task_struct *tsk, struct mm_struct *mm)
+{
+	atomic64_set(&mm->context.id, 0);
+	mm->context.pinned = 0;
+	return 0;
+}
 
 #ifdef CONFIG_ARM64_SW_TTBR0_PAN
 static inline void update_saved_ttbr0(struct task_struct *tsk,
@@ -250,6 +256,9 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
 void verify_cpu_asid_bits(void);
 void post_ttbr_update_workaround(void);
 
+unsigned long mm_context_get(struct mm_struct *mm);
+void mm_context_put(struct mm_struct *mm);
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* !__ASM_MMU_CONTEXT_H */
diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index d702d60e64da..d0ddd413f564 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -27,6 +27,10 @@ static DEFINE_PER_CPU(atomic64_t, active_asids);
 static DEFINE_PER_CPU(u64, reserved_asids);
 static cpumask_t tlb_flush_pending;
 
+static unsigned long max_pinned_asids;
+static unsigned long nr_pinned_asids;
+static unsigned long *pinned_asid_map;
+
 #define ASID_MASK		(~GENMASK(asid_bits - 1, 0))
 #define ASID_FIRST_VERSION	(1UL << asid_bits)
 
@@ -74,6 +78,9 @@ void verify_cpu_asid_bits(void)
 
 static void set_kpti_asid_bits(void)
 {
+	unsigned int k;
+	u8 *dst = (u8 *)asid_map;
+	u8 *src = (u8 *)pinned_asid_map;
 	unsigned int len = BITS_TO_LONGS(NUM_USER_ASIDS) * sizeof(unsigned long);
 	/*
 	 * In case of KPTI kernel/user ASIDs are allocated in
@@ -81,7 +88,8 @@ static void set_kpti_asid_bits(void)
 	 * is set, then the ASID will map only userspace. Thus
 	 * mark even as reserved for kernel.
 	 */
-	memset(asid_map, 0xaa, len);
+	for (k = 0; k < len; k++)
+		dst[k] = src[k] | 0xaa;
 }
 
 static void set_reserved_asid_bits(void)
@@ -89,7 +97,7 @@ static void set_reserved_asid_bits(void)
 	if (arm64_kernel_unmapped_at_el0())
 		set_kpti_asid_bits();
 	else
-		bitmap_clear(asid_map, 0, NUM_USER_ASIDS);
+		bitmap_copy(asid_map, pinned_asid_map, NUM_USER_ASIDS);
 }
 
 #define asid_gen_match(asid) \
@@ -165,6 +173,14 @@ static u64 new_context(struct mm_struct *mm)
 		if (check_update_reserved_asid(asid, newasid))
 			return newasid;
 
+		/*
+		 * If it is pinned, we can keep using it. Note that reserved
+		 * takes priority, because even if it is also pinned, we need to
+		 * update the generation into the reserved_asids.
+		 */
+		if (mm->context.pinned)
+			return newasid;
+
 		/*
 		 * We had a valid ASID in a previous life, so try to re-use
 		 * it if possible.
@@ -254,6 +270,68 @@ void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
 		cpu_switch_mm(mm->pgd, mm);
 }
 
+unsigned long mm_context_get(struct mm_struct *mm)
+{
+	unsigned long flags;
+	u64 asid;
+
+	raw_spin_lock_irqsave(&cpu_asid_lock, flags);
+
+	asid = atomic64_read(&mm->context.id);
+
+	if (mm->context.pinned) {
+		mm->context.pinned++;
+		asid &= ~ASID_MASK;
+		goto out_unlock;
+	}
+
+	if (nr_pinned_asids >= max_pinned_asids) {
+		asid = 0;
+		goto out_unlock;
+	}
+
+	if (!asid_gen_match(asid)) {
+		/*
+		 * We went through one or more rollover since that ASID was
+		 * used. Ensure that it is still valid, or generate a new one.
+		 */
+		asid = new_context(mm);
+		atomic64_set(&mm->context.id, asid);
+	}
+
+	asid &= ~ASID_MASK;
+
+	nr_pinned_asids++;
+	__set_bit(asid2idx(asid), pinned_asid_map);
+	mm->context.pinned++;
+
+out_unlock:
+	raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);
+
+	/* Set the equivalent of USER_ASID_BIT */
+	if (asid && IS_ENABLED(CONFIG_UNMAP_KERNEL_AT_EL0))
+		asid |= 1;
+
+	return asid;
+}
+EXPORT_SYMBOL_GPL(mm_context_get);
+
+void mm_context_put(struct mm_struct *mm)
+{
+	unsigned long flags;
+	u64 asid = atomic64_read(&mm->context.id) & ~ASID_MASK;
+
+	raw_spin_lock_irqsave(&cpu_asid_lock, flags);
+
+	if (--mm->context.pinned == 0) {
+		__clear_bit(asid2idx(asid), pinned_asid_map);
+		nr_pinned_asids--;
+	}
+
+	raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);
+}
+EXPORT_SYMBOL_GPL(mm_context_put);
+
 /* Errata workaround post TTBRx_EL1 update. */
 asmlinkage void post_ttbr_update_workaround(void)
 {
@@ -303,6 +381,13 @@ static int asids_update_limit(void)
 	WARN_ON(num_available_asids - 1 <= num_possible_cpus());
 	pr_info("ASID allocator initialised with %lu entries\n",
 		num_available_asids);
+
+	/*
+	 * We assume that an ASID is always available after a rollover. This
+	 * means that even if all CPUs have a reserved ASID, there still is at
+	 * least one slot available in the asid map.
+	 */
+	max_pinned_asids = num_available_asids - num_possible_cpus() - 2;
 	return 0;
 }
 arch_initcall(asids_update_limit);
@@ -317,6 +402,12 @@ static int asids_init(void)
 		panic("Failed to allocate bitmap for %lu ASIDs\n",
 		      NUM_USER_ASIDS);
 
+	pinned_asid_map = kcalloc(BITS_TO_LONGS(NUM_USER_ASIDS),
+				  sizeof(*pinned_asid_map), GFP_KERNEL);
+	if (!pinned_asid_map)
+		panic("Failed to allocate pinned ASID bitmap\n");
+	nr_pinned_asids = 0;
+
 	/*
 	 * We cannot call set_reserved_asid_bits() here because CPU
 	 * caps are not finalized yet, so it is safer to assume KPTI
-- 
2.26.2

