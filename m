Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7B64AD2B3
	for <lists+linux-pci@lfdr.de>; Tue,  8 Feb 2022 09:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348734AbiBHIFx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Feb 2022 03:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236001AbiBHIFw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Feb 2022 03:05:52 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6509C0401EF;
        Tue,  8 Feb 2022 00:05:51 -0800 (PST)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JtFnG68VGz6F92x;
        Tue,  8 Feb 2022 16:00:50 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Tue, 8 Feb 2022 09:05:49 +0100
Received: from [10.47.24.125] (10.47.24.125) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 8 Feb
 2022 08:05:35 +0000
Message-ID: <4f6f6e0f-4398-3018-cc35-6aa7ea1305fe@huawei.com>
Date:   Tue, 8 Feb 2022 08:05:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v3 8/8] iommu/arm-smmu-v3: Make default domain type of
 HiSilicon PTT device to identity
To:     Yicong Yang <yangyicong@hisilicon.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        "Jonathan Cameron" <jonathan.cameron@huawei.com>,
        "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC:     "Zengtao (B)" <prime.zeng@hisilicon.com>,
        "liuqi (BA)" <liuqi115@huawei.com>,
        Zhangshaokun <zhangshaokun@hisilicon.com>,
        Linuxarm <linuxarm@huawei.com>,
        yangyicong <yangyicong@huawei.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
References: <20220124131118.17887-1-yangyicong@hisilicon.com>
 <20220124131118.17887-9-yangyicong@hisilicon.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220124131118.17887-9-yangyicong@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.24.125]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

On 24/01/2022 13:11, Yicong Yang wrote:
> The DMA of HiSilicon PTT device can only work with identical
> mapping. So add a quirk for the device to force the domain
> passthrough.

This patch should be earlier in the series, before the PTT driver, and 
the comment on hisi_ptt_check_iommu_mapping() should mention what is 
going on here.

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

I assume that not all revisions will require this check, right?

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

