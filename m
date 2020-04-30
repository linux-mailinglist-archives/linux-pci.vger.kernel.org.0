Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 184F31BFEA5
	for <lists+linux-pci@lfdr.de>; Thu, 30 Apr 2020 16:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgD3Ok2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Apr 2020 10:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728018AbgD3Ok2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Apr 2020 10:40:28 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272AFC035495
        for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2020 07:40:28 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id r26so2210329wmh.0
        for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2020 07:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vSIvSRBzv8F87N2eh+SogoEdQ3Y+F4975ZvmBVJjXyM=;
        b=tzcdYYDnJJWmpXjOpgnid6d4dTYm6kQVVWfzPSygXZa6oqY8GOtk+I9pkl/978JDwv
         mQbNf5wE2dcfmDeRArm4tX4AHl4LX8xykzcpixdlo0n8cygHehdL5OENIN71IdjhG1Bt
         P5sDDS9Bw23exlEa7juXJTL1DFRSKh2611//wdwKe4KEbDPbn0XEg9EmysIRL2+UZx/E
         XSbQltT/V2GGEtrIWyxkZf7TL9HwlvqktWSG53FRVUwVm+7PdTebAaTHy/vZM7wn8KM3
         HDyWenOwxKTUKEIx0B2LW0us/eY7srXkB/4wZtI4oF5HJm951GdLYXXafMEiEfhHBZVo
         iclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vSIvSRBzv8F87N2eh+SogoEdQ3Y+F4975ZvmBVJjXyM=;
        b=DQlqOV+pxJOa0ag4CXfFDnRnote5tz01t7qwc0q0oTAkd3ruhyAYjHE/B02KIMv/Ve
         lVMSnDE7DguRUdDK0ztsej+BTNAs6Xv+rhLipA+QiN3IERwPf7tPGaphPZSCMN5TTiuz
         hgKTPi6pZw7ezsdEdCFsL3CdecVZhrPAX5IeAHlCeWA1Ty9oLD9otrFXY6DfHDBIQ+i9
         8hf4kCeqVM/SmuhTn47DPc/ViXDvws/4G1YUeMl2T7EbYgwVpym3umm6wkiERzjO1XSP
         KiPLl8TZujodui9or8MbIbz61K4FivJbcQ0tx/ZDUStUBBXvLukWtCG92qiSxfKFg97f
         fMIA==
X-Gm-Message-State: AGi0Puby9BNZIEQWA005FvtBng8SQHbND8nALqdTERXtos9/fnwPxj3t
        N12CyDbT6cVkRu6bnl2Po1jIMA==
X-Google-Smtp-Source: APiQypILBmgDpVJ3kGkqLumDZa/s/TYeNjreRgbRNmhtdf3KCt9R3YPaJk7ZdU8tHg9mzB6E1vZF2g==
X-Received: by 2002:a1c:4e16:: with SMTP id g22mr3202925wmh.157.1588257626712;
        Thu, 30 Apr 2020 07:40:26 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id n2sm4153286wrt.33.2020.04.30.07.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 07:40:26 -0700 (PDT)
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
Subject: [PATCH v6 07/25] arm64: mm: Pin down ASIDs for sharing mm with devices
Date:   Thu, 30 Apr 2020 16:34:06 +0200
Message-Id: <20200430143424.2787566-8-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200430143424.2787566-1-jean-philippe@linaro.org>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
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
index 68140fdd89d6b..bbdd291e31d59 100644
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
index ab46187c63001..69599a64945b0 100644
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
index d702d60e64dab..d0ddd413f5645 100644
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

