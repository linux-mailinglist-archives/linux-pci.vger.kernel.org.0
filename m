Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAC11E3607
	for <lists+linux-pci@lfdr.de>; Wed, 27 May 2020 05:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbgE0DAp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 May 2020 23:00:45 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35682 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725893AbgE0DAo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 May 2020 23:00:44 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3C20BF272BC3D1B5F2DA;
        Wed, 27 May 2020 11:00:42 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.213) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Wed, 27 May 2020
 11:00:31 +0800
Subject: Re: [PATCH v7 18/24] iommu/arm-smmu-v3: Add support for Hardware
 Translation Table Update
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <fenghua.yu@intel.com>, <kevin.tian@intel.com>,
        <jacob.jun.pan@linux.intel.com>, <jgg@ziepe.ca>,
        <catalin.marinas@arm.com>, <joro@8bytes.org>,
        <robin.murphy@arm.com>, <hch@infradead.org>,
        <zhangfei.gao@linaro.org>, <Jonathan.Cameron@huawei.com>,
        <felix.kuehling@amd.com>, <xuzaibo@huawei.com>, <will@kernel.org>,
        <christian.koenig@amd.com>, <baolu.lu@linux.intel.com>,
        Wang Haibin <wanghaibin.wang@huawei.com>
References: <20200519175502.2504091-1-jean-philippe@linaro.org>
 <20200519175502.2504091-19-jean-philippe@linaro.org>
From:   Xiang Zheng <zhengxiang9@huawei.com>
Message-ID: <4eea10e0-1343-8d7d-ba8d-214d05558c76@huawei.com>
Date:   Wed, 27 May 2020 11:00:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20200519175502.2504091-19-jean-philippe@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.221.213]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jean,

This patch only enables HTTU bits in CDs. Is it also neccessary to enable
HTTU bits in STEs in this patch?

On 2020/5/20 1:54, Jean-Philippe Brucker wrote:
> If the SMMU supports it and the kernel was built with HTTU support,
> enable hardware update of access and dirty flags. This is essential for
> shared page tables, to reduce the number of access faults on the fault
> queue. Normal DMA with io-pgtables doesn't currently use the access or
> dirty flags.
> 
> We can enable HTTU even if CPUs don't support it, because the kernel
> always checks for HW dirty bit and updates the PTE flags atomically.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 1386d4d2bc60..6a368218f54c 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -58,6 +58,8 @@
>  #define IDR0_ASID16			(1 << 12)
>  #define IDR0_ATS			(1 << 10)
>  #define IDR0_HYP			(1 << 9)
> +#define IDR0_HD				(1 << 7)
> +#define IDR0_HA				(1 << 6)
>  #define IDR0_BTM			(1 << 5)
>  #define IDR0_COHACC			(1 << 4)
>  #define IDR0_TTF			GENMASK(3, 2)
> @@ -311,6 +313,9 @@
>  #define CTXDESC_CD_0_TCR_IPS		GENMASK_ULL(34, 32)
>  #define CTXDESC_CD_0_TCR_TBI0		(1ULL << 38)
>  
> +#define CTXDESC_CD_0_TCR_HA		(1UL << 43)
> +#define CTXDESC_CD_0_TCR_HD		(1UL << 42)
> +

>  #define CTXDESC_CD_0_AA64		(1UL << 41)
>  #define CTXDESC_CD_0_S			(1UL << 44)
>  #define CTXDESC_CD_0_R			(1UL << 45)
> @@ -663,6 +668,8 @@ struct arm_smmu_device {
>  #define ARM_SMMU_FEAT_E2H		(1 << 16)
>  #define ARM_SMMU_FEAT_BTM		(1 << 17)
>  #define ARM_SMMU_FEAT_SVA		(1 << 18)
> +#define ARM_SMMU_FEAT_HA		(1 << 19)
> +#define ARM_SMMU_FEAT_HD		(1 << 20)
>  	u32				features;
>  
>  #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
> @@ -1718,10 +1725,17 @@ static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
>  		 * this substream's traffic
>  		 */
>  	} else { /* (1) and (2) */
> +		u64 tcr = cd->tcr;
> +
>  		cdptr[1] = cpu_to_le64(cd->ttbr & CTXDESC_CD_1_TTB0_MASK);
>  		cdptr[2] = 0;
>  		cdptr[3] = cpu_to_le64(cd->mair);
>  
> +		if (!(smmu->features & ARM_SMMU_FEAT_HD))
> +			tcr &= ~CTXDESC_CD_0_TCR_HD;
> +		if (!(smmu->features & ARM_SMMU_FEAT_HA))
> +			tcr &= ~CTXDESC_CD_0_TCR_HA;
> +
>  		/*
>  		 * STE is live, and the SMMU might read dwords of this CD in any
>  		 * order. Ensure that it observes valid values before reading
> @@ -1729,7 +1743,7 @@ static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
>  		 */
>  		arm_smmu_sync_cd(smmu_domain, ssid, true);
>  
> -		val = cd->tcr |
> +		val = tcr |
>  #ifdef __BIG_ENDIAN
>  			CTXDESC_CD_0_ENDI |
>  #endif
> @@ -1958,10 +1972,12 @@ static struct arm_smmu_ctx_desc *arm_smmu_alloc_shared_cd(struct mm_struct *mm)
>  		return old_cd;
>  	}
>  
> +	/* HA and HD will be filtered out later if not supported by the SMMU */
>  	tcr = FIELD_PREP(CTXDESC_CD_0_TCR_T0SZ, 64ULL - VA_BITS) |
>  	      FIELD_PREP(CTXDESC_CD_0_TCR_IRGN0, ARM_LPAE_TCR_RGN_WBWA) |
>  	      FIELD_PREP(CTXDESC_CD_0_TCR_ORGN0, ARM_LPAE_TCR_RGN_WBWA) |
>  	      FIELD_PREP(CTXDESC_CD_0_TCR_SH0, ARM_LPAE_TCR_SH_IS) |
> +	      CTXDESC_CD_0_TCR_HA | CTXDESC_CD_0_TCR_HD |
>  	      CTXDESC_CD_0_TCR_EPD1 | CTXDESC_CD_0_AA64;
>  
>  	switch (PAGE_SIZE) {
> @@ -4454,6 +4470,12 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>  			smmu->features |= ARM_SMMU_FEAT_E2H;
>  	}
>  
> +	if (reg & (IDR0_HA | IDR0_HD)) {

> +		smmu->features |= ARM_SMMU_FEAT_HA;
> +		if (reg & IDR0_HD)
> +			smmu->features |= ARM_SMMU_FEAT_HD;
> +	}
> +

>  	/*
>  	 * If the CPU is using VHE, but the SMMU doesn't support it, the SMMU
>  	 * will create TLB entries for NH-EL1 world and will miss the
> 

-- 
Thanks,
Xiang

