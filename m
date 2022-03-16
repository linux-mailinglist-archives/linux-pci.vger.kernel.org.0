Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F964DAA85
	for <lists+linux-pci@lfdr.de>; Wed, 16 Mar 2022 07:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352256AbiCPGRM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Mar 2022 02:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237256AbiCPGRL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Mar 2022 02:17:11 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB073701C;
        Tue, 15 Mar 2022 23:15:57 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KJKds0rrTzcb5F;
        Wed, 16 Mar 2022 14:10:57 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 14:15:48 +0800
CC:     <prime.zeng@huawei.com>, <liuqi115@huawei.com>,
        <zhangshaokun@hisilicon.com>, <linuxarm@huawei.com>,
        <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH v5 1/8] iommu/arm-smmu-v3: Make default domain type of
 HiSilicon PTT device to identity
To:     John Garry <john.garry@huawei.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
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
References: <20220308084930.5142-1-yangyicong@hisilicon.com>
 <20220308084930.5142-2-yangyicong@hisilicon.com>
 <162a116a-4b0f-c58b-6760-86d10ecf543f@huawei.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <e6d50ab3-5284-7fea-c20e-d72add9b0c82@huawei.com>
Date:   Wed, 16 Mar 2022 14:15:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <162a116a-4b0f-c58b-6760-86d10ecf543f@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022/3/12 1:27, John Garry wrote:
> On 08/03/2022 08:49, Yicong Yang wrote:
>> The DMA of HiSilicon PTT device can only work with identical mapping.
> 
> nit: I'd have "DMA operations of the HiSilicon PTT device can only work properly with identity mappings".
> 
>> So add a quirk for the device to force the domain passthrough.
> 
> ".. domain as passthrough."
> 

thanks for the comments. will refine the commit as suggested.

>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index 6dc6d8b6b368..6f67a2b1dd27 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -2838,6 +2838,21 @@ static int arm_smmu_dev_disable_feature(struct device *dev,
>>       }
>>   }
>>   +#define IS_HISI_PTT_DEVICE(pdev)    ((pdev)->vendor == PCI_VENDOR_ID_HUAWEI && \
>> +                     (pdev)->device == 0xa12e)
>> +
>> +static int arm_smmu_def_domain_type(struct device *dev)
>> +{
>> +    if (dev_is_pci(dev)) {
>> +        struct pci_dev *pdev = to_pci_dev(dev);
>> +
>> +        if (IS_HISI_PTT_DEVICE(pdev))
>> +            return IOMMU_DOMAIN_IDENTITY;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   static struct iommu_ops arm_smmu_ops = {
>>       .capable        = arm_smmu_capable,
>>       .domain_alloc        = arm_smmu_domain_alloc,
>> @@ -2863,6 +2878,7 @@ static struct iommu_ops arm_smmu_ops = {
>>       .sva_unbind        = arm_smmu_sva_unbind,
>>       .sva_get_pasid        = arm_smmu_sva_get_pasid,
>>       .page_response        = arm_smmu_page_response,
>> +    .def_domain_type    = arm_smmu_def_domain_type,
>>       .pgsize_bitmap        = -1UL, /* Restricted during device attach */
>>       .owner            = THIS_MODULE,
>>   };
> 
> .
