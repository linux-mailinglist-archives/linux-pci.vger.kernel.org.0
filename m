Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72AA1C3D3B
	for <lists+linux-pci@lfdr.de>; Mon,  4 May 2020 16:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbgEDOhS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 May 2020 10:37:18 -0400
Received: from foss.arm.com ([217.140.110.172]:46302 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728486AbgEDOhS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 May 2020 10:37:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D6461FB;
        Mon,  4 May 2020 07:37:17 -0700 (PDT)
Received: from [10.37.12.17] (unknown [10.37.12.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 543783F305;
        Mon,  4 May 2020 07:37:04 -0700 (PDT)
Subject: Re: [PATCH v6 11/25] iommu/arm-smmu-v3: Share process page tables
To:     jean-philippe@linaro.org
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, joro@8bytes.org, catalin.marinas@arm.com,
        will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        felix.kuehling@amd.com, zhangfei.gao@linaro.org, jgg@ziepe.ca,
        xuzaibo@huawei.com, fenghua.yu@intel.com, hch@infradead.org
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
 <20200430143424.2787566-12-jean-philippe@linaro.org>
 <580a915f-f8bf-3b3e-c77d-6d0c2ea4bd02@arm.com>
 <20200504141137.GA170104@myrica>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <82f54362-34f1-2378-49c2-2d87e065e385@arm.com>
Date:   Mon, 4 May 2020 15:42:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200504141137.GA170104@myrica>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 05/04/2020 03:11 PM, Jean-Philippe Brucker wrote:
> On Thu, Apr 30, 2020 at 04:39:53PM +0100, Suzuki K Poulose wrote:
>> On 04/30/2020 03:34 PM, Jean-Philippe Brucker wrote:
>>> With Shared Virtual Addressing (SVA), we need to mirror CPU TTBR, TCR,
>>> MAIR and ASIDs in SMMU contexts. Each SMMU has a single ASID space split
>>> into two sets, shared and private. Shared ASIDs correspond to those
>>> obtained from the arch ASID allocator, and private ASIDs are used for
>>> "classic" map/unmap DMA.
>>>
>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>> ---
>>
>>> +
>>> +	tcr = FIELD_PREP(CTXDESC_CD_0_TCR_T0SZ, 64ULL - VA_BITS) |
>>> +	      FIELD_PREP(CTXDESC_CD_0_TCR_IRGN0, ARM_LPAE_TCR_RGN_WBWA) |
>>> +	      FIELD_PREP(CTXDESC_CD_0_TCR_ORGN0, ARM_LPAE_TCR_RGN_WBWA) |
>>> +	      FIELD_PREP(CTXDESC_CD_0_TCR_SH0, ARM_LPAE_TCR_SH_IS) |
>>> +	      CTXDESC_CD_0_TCR_EPD1 | CTXDESC_CD_0_AA64;
>>> +
>>> +	switch (PAGE_SIZE) {
>>> +	case SZ_4K:
>>> +		tcr |= FIELD_PREP(CTXDESC_CD_0_TCR_TG0, ARM_LPAE_TCR_TG0_4K);
>>> +		break;
>>> +	case SZ_16K:
>>> +		tcr |= FIELD_PREP(CTXDESC_CD_0_TCR_TG0, ARM_LPAE_TCR_TG0_16K);
>>> +		break;
>>> +	case SZ_64K:
>>> +		tcr |= FIELD_PREP(CTXDESC_CD_0_TCR_TG0, ARM_LPAE_TCR_TG0_64K);
>>> +		break;
>>> +	default:
>>> +		WARN_ON(1);
>>> +		ret = -EINVAL;
>>> +		goto err_free_asid;
>>> +	}
>>> +
>>> +	reg = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
>>> +	par = cpuid_feature_extract_unsigned_field(reg, ID_AA64MMFR0_PARANGE_SHIFT);
>>> +	tcr |= FIELD_PREP(CTXDESC_CD_0_TCR_IPS, par);
>>> +
>>> +	cd->ttbr = virt_to_phys(mm->pgd);
>>
>> Does the TTBR follow the same layout as TTBR_ELx for 52bit IPA ? i.e,
>> TTBR[5:2] = BADDR[51:48] ? Are you covered for that ?
> 
> Good point, I don't remember checking this. The SMMU TTBR doesn't have the
> same layout as the CPU's, and we don't need to swizzle the bits. For the
> lower bits, the alignment requirements on the pgd are identical to the
> MMU.

Ok, if that is the case:

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
