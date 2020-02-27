Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E66817254F
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2020 18:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbgB0Rn6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Feb 2020 12:43:58 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2473 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729601AbgB0Rn6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Feb 2020 12:43:58 -0500
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id A81A29B4C24BC137BA60;
        Thu, 27 Feb 2020 17:43:55 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 LHREML711-CAH.china.huawei.com (10.201.108.34) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 27 Feb 2020 17:43:55 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 27 Feb
 2020 17:43:54 +0000
Date:   Thu, 27 Feb 2020 17:43:51 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
CC:     <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <linux-mm@kvack.org>,
        <joro@8bytes.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <robin.murphy@arm.com>, <kevin.tian@intel.com>,
        <baolu.lu@linux.intel.com>, <jacob.jun.pan@linux.intel.com>,
        <christian.koenig@amd.com>, <yi.l.liu@intel.com>,
        <zhangfei.gao@linaro.org>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v4 07/26] arm64: mm: Pin down ASIDs for sharing mm with
 devices
Message-ID: <20200227174351.00004d0d@Huawei.com>
In-Reply-To: <20200224182401.353359-8-jean-philippe@linaro.org>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
        <20200224182401.353359-8-jean-philippe@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 24 Feb 2020 19:23:42 +0100
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> 
> To enable address space sharing with the IOMMU, introduce mm_context_get()
> and mm_context_put(), that pin down a context and ensure that it will keep
> its ASID after a rollover. Export the symbols to let the modular SMMUv3
> driver use them.
> 
> Pinning is necessary because a device constantly needs a valid ASID,
> unlike tasks that only require one when running. Without pinning, we would
> need to notify the IOMMU when we're about to use a new ASID for a task,
> and it would get complicated when a new task is assigned a shared ASID.
> Consider the following scenario with no ASID pinned:
> 
> 1. Task t1 is running on CPUx with shared ASID (gen=1, asid=1)
> 2. Task t2 is scheduled on CPUx, gets ASID (1, 2)
> 3. Task tn is scheduled on CPUy, a rollover occurs, tn gets ASID (2, 1)
>    We would now have to immediately generate a new ASID for t1, notify
>    the IOMMU, and finally enable task tn. We are holding the lock during
>    all that time, since we can't afford having another CPU trigger a
>    rollover. The IOMMU issues invalidation commands that can take tens of
>    milliseconds.
> 
> It gets needlessly complicated. All we wanted to do was schedule task tn,
> that has no business with the IOMMU. By letting the IOMMU pin tasks when
> needed, we avoid stalling the slow path, and let the pinning fail when
> we're out of shareable ASIDs.
> 
> After a rollover, the allocator expects at least one ASID to be available
> in addition to the reserved ones (one per CPU). So (NR_ASIDS - NR_CPUS -
> 1) is the maximum number of ASIDs that can be shared with the IOMMU.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
A few more trivial points.

Thanks,

Jonathan

> ---
> v2->v4: handle KPTI
> ---
>  arch/arm64/include/asm/mmu.h         |   1 +
>  arch/arm64/include/asm/mmu_context.h |  11 ++-
>  arch/arm64/mm/context.c              | 103 +++++++++++++++++++++++++--
>  3 files changed, 109 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> index e4d862420bb4..70ac3d4cbd3e 100644
> --- a/arch/arm64/include/asm/mmu.h
> +++ b/arch/arm64/include/asm/mmu.h
> @@ -18,6 +18,7 @@
>  
>  typedef struct {
>  	atomic64_t	id;
> +	unsigned long	pinned;
>  	void		*vdso;
>  	unsigned long	flags;
>  } mm_context_t;
> diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
> index 3827ff4040a3..70715c10c02a 100644
> --- a/arch/arm64/include/asm/mmu_context.h
> +++ b/arch/arm64/include/asm/mmu_context.h
> @@ -175,7 +175,13 @@ static inline void cpu_replace_ttbr1(pgd_t *pgdp)
>  #define destroy_context(mm)		do { } while(0)
>  void check_and_switch_context(struct mm_struct *mm, unsigned int cpu);
>  
> -#define init_new_context(tsk,mm)	({ atomic64_set(&(mm)->context.id, 0); 0; })
> +static inline int
> +init_new_context(struct task_struct *tsk, struct mm_struct *mm)
> +{
> +	atomic64_set(&mm->context.id, 0);
> +	mm->context.pinned = 0;
> +	return 0;
> +}
>  
>  #ifdef CONFIG_ARM64_SW_TTBR0_PAN
>  static inline void update_saved_ttbr0(struct task_struct *tsk,
> @@ -248,6 +254,9 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
>  void verify_cpu_asid_bits(void);
>  void post_ttbr_update_workaround(void);
>  
> +unsigned long mm_context_get(struct mm_struct *mm);
> +void mm_context_put(struct mm_struct *mm);
> +
>  #endif /* !__ASSEMBLY__ */
>  
>  #endif /* !__ASM_MMU_CONTEXT_H */
> diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
> index 121aba5b1941..5558de88b67d 100644
> --- a/arch/arm64/mm/context.c
> +++ b/arch/arm64/mm/context.c
> @@ -26,6 +26,10 @@ static DEFINE_PER_CPU(atomic64_t, active_asids);
>  static DEFINE_PER_CPU(u64, reserved_asids);
>  static cpumask_t tlb_flush_pending;
>  
> +static unsigned long max_pinned_asids;
> +static unsigned long nr_pinned_asids;
> +static unsigned long *pinned_asid_map;
> +
>  #define ASID_MASK		(~GENMASK(asid_bits - 1, 0))
>  #define ASID_FIRST_VERSION	(1UL << asid_bits)
>  
> @@ -73,6 +77,9 @@ void verify_cpu_asid_bits(void)
>  
>  static void set_kpti_asid_bits(void)
>  {
> +	unsigned int k;
> +	u8 *dst = (u8 *)asid_map;
> +	u8 *src = (u8 *)pinned_asid_map;
>  	unsigned int len = BITS_TO_LONGS(NUM_USER_ASIDS) * sizeof(unsigned long);
>  	/*
>  	 * In case of KPTI kernel/user ASIDs are allocated in
> @@ -80,7 +87,8 @@ static void set_kpti_asid_bits(void)
>  	 * is set, then the ASID will map only userspace. Thus
>  	 * mark even as reserved for kernel.
>  	 */
> -	memset(asid_map, 0xaa, len);
> +	for (k = 0; k < len; k++)
> +		dst[k] = src[k] | 0xaa;
>  }
>  
>  static void set_reserved_asid_bits(void)
> @@ -88,9 +96,12 @@ static void set_reserved_asid_bits(void)
>  	if (arm64_kernel_unmapped_at_el0())
>  		set_kpti_asid_bits();
>  	else
> -		bitmap_clear(asid_map, 0, NUM_USER_ASIDS);
> +		bitmap_copy(asid_map, pinned_asid_map, NUM_USER_ASIDS);
>  }
>  
> +#define asid_gen_match(asid) \
> +	(!(((asid) ^ atomic64_read(&asid_generation)) >> asid_bits))
> +

I'd have slightly preferred this bit of refactoring as a precursor patch.

>  static void flush_context(void)
>  {
>  	int i;
> @@ -161,6 +172,14 @@ static u64 new_context(struct mm_struct *mm)
>  		if (check_update_reserved_asid(asid, newasid))
>  			return newasid;
>  
> +		/*
> +		 * If it is pinned, we can keep using it. Note that reserved
> +		 * takes priority, because even if it is also pinned, we need to
> +		 * update the generation into the reserved_asids.
> +		 */
> +		if (mm->context.pinned)
> +			return newasid;
> +
>  		/*
>  		 * We had a valid ASID in a previous life, so try to re-use
>  		 * it if possible.
> @@ -219,8 +238,7 @@ void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
>  	 *   because atomic RmWs are totally ordered for a given location.
>  	 */
>  	old_active_asid = atomic64_read(&per_cpu(active_asids, cpu));
> -	if (old_active_asid &&
> -	    !((asid ^ atomic64_read(&asid_generation)) >> asid_bits) &&
> +	if (old_active_asid && asid_gen_match(asid) &&
>  	    atomic64_cmpxchg_relaxed(&per_cpu(active_asids, cpu),
>  				     old_active_asid, asid))
>  		goto switch_mm_fastpath;
> @@ -228,7 +246,7 @@ void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
>  	raw_spin_lock_irqsave(&cpu_asid_lock, flags);
>  	/* Check that our ASID belongs to the current generation. */
>  	asid = atomic64_read(&mm->context.id);
> -	if ((asid ^ atomic64_read(&asid_generation)) >> asid_bits) {
> +	if (!asid_gen_match(asid)) {
>  		asid = new_context(mm);
>  		atomic64_set(&mm->context.id, asid);
>  	}
> @@ -251,6 +269,68 @@ void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
>  		cpu_switch_mm(mm->pgd, mm);
>  }
>  
> +unsigned long mm_context_get(struct mm_struct *mm)
> +{
> +	unsigned long flags;
> +	u64 asid;
> +
> +	raw_spin_lock_irqsave(&cpu_asid_lock, flags);
> +
> +	asid = atomic64_read(&mm->context.id);
> +
> +	if (mm->context.pinned) {
> +		mm->context.pinned++;
> +		asid &= ~ASID_MASK;
> +		goto out_unlock;
> +	}
> +
> +	if (nr_pinned_asids >= max_pinned_asids) {
> +		asid = 0;
> +		goto out_unlock;
> +	}
> +
> +	if (!asid_gen_match(asid)) {
> +		/*
> +		 * We went through one or more rollover since that ASID was
> +		 * used. Ensure that it is still valid, or generate a new one.
> +		 */
> +		asid = new_context(mm);
> +		atomic64_set(&mm->context.id, asid);
> +	}
> +
> +	asid &= ~ASID_MASK;
> +
> +	nr_pinned_asids++;
> +	__set_bit(asid2idx(asid), pinned_asid_map);
> +	mm->context.pinned++;
> +
> +out_unlock:
> +	raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);
> +
> +	/* Set the equivalent of USER_ASID_BIT */
> +	if (asid && IS_ENABLED(CONFIG_UNMAP_KERNEL_AT_EL0))
> +		asid |= 1;
> +
> +	return asid;
> +}
> +EXPORT_SYMBOL_GPL(mm_context_get);
> +
> +void mm_context_put(struct mm_struct *mm)
> +{
> +	unsigned long flags;
> +	u64 asid = atomic64_read(&mm->context.id) & ~ASID_MASK;
> +
> +	raw_spin_lock_irqsave(&cpu_asid_lock, flags);
> +
> +	if (--mm->context.pinned == 0) {
> +		__clear_bit(asid2idx(asid), pinned_asid_map);
> +		nr_pinned_asids--;
> +	}
> +
> +	raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);
> +}
> +EXPORT_SYMBOL_GPL(mm_context_put);
> +
>  /* Errata workaround post TTBRx_EL1 update. */
>  asmlinkage void post_ttbr_update_workaround(void)
>  {
> @@ -279,6 +359,19 @@ static int asids_init(void)
>  		panic("Failed to allocate bitmap for %lu ASIDs\n",
>  		      NUM_USER_ASIDS);
>  
> +	pinned_asid_map = kcalloc(BITS_TO_LONGS(NUM_USER_ASIDS),
> +				  sizeof(*pinned_asid_map), GFP_KERNEL);
> +	if (!pinned_asid_map)
> +		panic("Failed to allocate pinned bitmap\n");
Perhaps "Failed to allocate pinnned asid bitmap\n"
> +
> +	/*
> +	 * We assume that an ASID is always available after a rollover. This
> +	 * means that even if all CPUs have a reserved ASID, there still is at
> +	 * least one slot available in the asid map.
> +	 */
> +	max_pinned_asids = num_available_asids - num_possible_cpus() - 1;
> +	nr_pinned_asids = 0;
> +
>  	/*
>  	 * We cannot call set_reserved_asid_bits() here because CPU
>  	 * caps are not finalized yet, so it is safer to assume KPTI


