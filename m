Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B431DCF59
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 16:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbgEUORM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 10:17:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727909AbgEUORM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 May 2020 10:17:12 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34BA420748;
        Thu, 21 May 2020 14:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590070631;
        bh=GjzwaRRDCT9qDw4gwlt5yphxvwdwXZXZJrf50Lvn5nM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zhp5hS0c2hiMcsTRAY10N5jHSgZcntp4kpwpJONYplXF38WzHAEZoGyGf7WtcOmeZ
         SKj5nEInq3SKL2VlD8LFdVsuhHY/aZUa7Jj8fkbSrkOJJPXvL3N6U8V1CkL+2owG/s
         gfSxtKHi1uniXMpcr8PtGe4iCXKURd11/Z63TNoU=
Date:   Thu, 21 May 2020 15:17:05 +0100
From:   Will Deacon <will@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, joro@8bytes.org, catalin.marinas@arm.com,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        felix.kuehling@amd.com, zhangfei.gao@linaro.org, jgg@ziepe.ca,
        xuzaibo@huawei.com, fenghua.yu@intel.com, hch@infradead.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH v7 14/24] iommu/arm-smmu-v3: Add SVA feature checking
Message-ID: <20200521141704.GH6608@willie-the-truck>
References: <20200519175502.2504091-1-jean-philippe@linaro.org>
 <20200519175502.2504091-15-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519175502.2504091-15-jean-philippe@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 19, 2020 at 07:54:52PM +0200, Jean-Philippe Brucker wrote:
> Aggregate all sanity-checks for sharing CPU page tables with the SMMU
> under a single ARM_SMMU_FEAT_SVA bit. For PCIe SVA, users also need to
> check FEAT_ATS and FEAT_PRI. For platform SVA, they will most likely have
> to check FEAT_STALLS.
> 
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 72 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 9332253e3608..a9f6f1d7014e 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -660,6 +660,7 @@ struct arm_smmu_device {
>  #define ARM_SMMU_FEAT_RANGE_INV		(1 << 15)
>  #define ARM_SMMU_FEAT_E2H		(1 << 16)
>  #define ARM_SMMU_FEAT_BTM		(1 << 17)
> +#define ARM_SMMU_FEAT_SVA		(1 << 18)
>  	u32				features;
>  
>  #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
> @@ -3935,6 +3936,74 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
>  	return 0;
>  }
>  
> +static bool arm_smmu_supports_sva(struct arm_smmu_device *smmu)
> +{
> +	unsigned long reg, fld;
> +	unsigned long oas;
> +	unsigned long asid_bits;
> +
> +	u32 feat_mask = ARM_SMMU_FEAT_BTM | ARM_SMMU_FEAT_COHERENCY;

Aha -- here's the coherency check I missed!

> +
> +	if ((smmu->features & feat_mask) != feat_mask)
> +		return false;
> +
> +	if (!(smmu->pgsize_bitmap & PAGE_SIZE))
> +		return false;
> +
> +	/*
> +	 * Get the smallest PA size of all CPUs (sanitized by cpufeature). We're
> +	 * not even pretending to support AArch32 here.
> +	 */
> +	reg = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
> +	fld = cpuid_feature_extract_unsigned_field(reg, ID_AA64MMFR0_PARANGE_SHIFT);
> +	switch (fld) {
> +	case 0x0:
> +		oas = 32;
> +		break;
> +	case 0x1:
> +		oas = 36;
> +		break;
> +	case 0x2:
> +		oas = 40;
> +		break;
> +	case 0x3:
> +		oas = 42;
> +		break;
> +	case 0x4:
> +		oas = 44;
> +		break;
> +	case 0x5:
> +		oas = 48;
> +		break;
> +	case 0x6:

We can use ID_AA64MMFR0_PARANGE_xx constants instead of the hardcoded hex
numbers here.

With that:

Acked-by: Will Deacon <will@kernel.org>

Will
