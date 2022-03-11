Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CFE4D6798
	for <lists+linux-pci@lfdr.de>; Fri, 11 Mar 2022 18:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350760AbiCKR2w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Mar 2022 12:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344114AbiCKR2v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Mar 2022 12:28:51 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174BA31DD3;
        Fri, 11 Mar 2022 09:27:46 -0800 (PST)
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KFXsB6JVmz684TK;
        Sat, 12 Mar 2022 01:26:06 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Mar 2022 18:27:43 +0100
Received: from [10.47.87.13] (10.47.87.13) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.21; Fri, 11 Mar
 2022 17:27:42 +0000
Message-ID: <162a116a-4b0f-c58b-6760-86d10ecf543f@huawei.com>
Date:   Fri, 11 Mar 2022 17:27:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v5 1/8] iommu/arm-smmu-v3: Make default domain type of
 HiSilicon PTT device to identity
To:     Yicong Yang <yangyicong@hisilicon.com>,
        <gregkh@linuxfoundation.org>, <helgaas@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <lorenzo.pieralisi@arm.com>,
        <will@kernel.org>, <mark.rutland@arm.com>,
        <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>,
        <jonathan.cameron@huawei.com>, <daniel.thompson@linaro.org>,
        <joro@8bytes.org>, <shameerali.kolothum.thodi@huawei.com>,
        <robin.murphy@arm.com>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <coresight@lists.linaro.org>, <linux-pci@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>
CC:     <prime.zeng@huawei.com>, <liuqi115@huawei.com>,
        <zhangshaokun@hisilicon.com>, <linuxarm@huawei.com>,
        <song.bao.hua@hisilicon.com>
References: <20220308084930.5142-1-yangyicong@hisilicon.com>
 <20220308084930.5142-2-yangyicong@hisilicon.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220308084930.5142-2-yangyicong@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.87.13]
X-ClientProxiedBy: lhreml707-chm.china.huawei.com (10.201.108.56) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 08/03/2022 08:49, Yicong Yang wrote:
> The DMA of HiSilicon PTT device can only work with identical mapping.

nit: I'd have "DMA operations of the HiSilicon PTT device can only work 
properly with identity mappings".

> So add a quirk for the device to force the domain passthrough.

".. domain as passthrough."

> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 6dc6d8b6b368..6f67a2b1dd27 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2838,6 +2838,21 @@ static int arm_smmu_dev_disable_feature(struct device *dev,
>   	}
>   }
>   
> +#define IS_HISI_PTT_DEVICE(pdev)	((pdev)->vendor == PCI_VENDOR_ID_HUAWEI && \
> +					 (pdev)->device == 0xa12e)
> +
> +static int arm_smmu_def_domain_type(struct device *dev)
> +{
> +	if (dev_is_pci(dev)) {
> +		struct pci_dev *pdev = to_pci_dev(dev);
> +
> +		if (IS_HISI_PTT_DEVICE(pdev))
> +			return IOMMU_DOMAIN_IDENTITY;
> +	}
> +
> +	return 0;
> +}
> +
>   static struct iommu_ops arm_smmu_ops = {
>   	.capable		= arm_smmu_capable,
>   	.domain_alloc		= arm_smmu_domain_alloc,
> @@ -2863,6 +2878,7 @@ static struct iommu_ops arm_smmu_ops = {
>   	.sva_unbind		= arm_smmu_sva_unbind,
>   	.sva_get_pasid		= arm_smmu_sva_get_pasid,
>   	.page_response		= arm_smmu_page_response,
> +	.def_domain_type	= arm_smmu_def_domain_type,
>   	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
>   	.owner			= THIS_MODULE,
>   };

