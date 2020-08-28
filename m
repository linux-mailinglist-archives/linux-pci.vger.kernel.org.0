Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C87425579B
	for <lists+linux-pci@lfdr.de>; Fri, 28 Aug 2020 11:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgH1J2j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Aug 2020 05:28:39 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52700 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728016AbgH1J2h (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Aug 2020 05:28:37 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 33BACF005785721D2BAA;
        Fri, 28 Aug 2020 17:28:34 +0800 (CST)
Received: from [10.174.185.226] (10.174.185.226) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Fri, 28 Aug 2020 17:28:23 +0800
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
        <christian.koenig@amd.com>, <baolu.lu@linux.intel.com>
References: <20200519175502.2504091-1-jean-philippe@linaro.org>
 <20200519175502.2504091-19-jean-philippe@linaro.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <472fdcf6-f306-60bc-5813-4ad421ee03f2@huawei.com>
Date:   Fri, 28 Aug 2020 17:28:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200519175502.2504091-19-jean-philippe@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.185.226]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020/5/20 1:54, Jean-Philippe Brucker wrote:
> @@ -4454,6 +4470,12 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>   			smmu->features |= ARM_SMMU_FEAT_E2H;
>   	}
>   
> +	if (reg & (IDR0_HA | IDR0_HD)) {
> +		smmu->features |= ARM_SMMU_FEAT_HA;
> +		if (reg & IDR0_HD)
> +			smmu->features |= ARM_SMMU_FEAT_HD;
> +	}
> +

nitpick:

As per the IORT spec (DEN0049D, 3.1.1.2 SMMUv3 node, Table 10), the
"HTTU Override" flag of the SMMUv3 node can override the value in
SMMU_IDR0.HTTU. You may want to check this bit before selecting the
{HA,HD} features and shout if there is a mismatch between firmware and
the SMMU implementation. Just like how ARM_SMMU_FEAT_COHERENCY is
selected.


Thanks,
Zenghui
