Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F213D5215B2
	for <lists+linux-pci@lfdr.de>; Tue, 10 May 2022 14:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237389AbiEJMrO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 May 2022 08:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234623AbiEJMrM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 May 2022 08:47:12 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C251209B;
        Tue, 10 May 2022 05:43:15 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KyHkM6qnxzhZ3l;
        Tue, 10 May 2022 20:42:35 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 10 May 2022 20:43:13 +0800
CC:     <gregkh@linuxfoundation.org>, <helgaas@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <lorenzo.pieralisi@arm.com>,
        <mark.rutland@arm.com>, <mathieu.poirier@linaro.org>,
        <suzuki.poulose@arm.com>, <mike.leach@linaro.org>,
        <leo.yan@linaro.org>, <jonathan.cameron@huawei.com>,
        <daniel.thompson@linaro.org>, <joro@8bytes.org>,
        <john.garry@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
        <robin.murphy@arm.com>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <coresight@lists.linaro.org>, <linux-pci@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <prime.zeng@huawei.com>,
        <liuqi115@huawei.com>, <zhangshaokun@hisilicon.com>,
        <linuxarm@huawei.com>
Subject: Re: [PATCH v7 1/7] iommu/arm-smmu-v3: Make default domain type of
 HiSilicon PTT device to identity
To:     Will Deacon <will@kernel.org>
References: <20220407125841.3678-1-yangyicong@hisilicon.com>
 <20220407125841.3678-2-yangyicong@hisilicon.com>
 <20220510112326.GA27790@willie-the-truck>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <cfde7d29-bf1b-35c4-92d8-6cd1faabc4c7@huawei.com>
Date:   Tue, 10 May 2022 20:43:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20220510112326.GA27790@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022/5/10 19:23, Will Deacon wrote:
> On Thu, Apr 07, 2022 at 08:58:35PM +0800, Yicong Yang wrote:
>> The DMA operations of HiSilicon PTT device can only work properly with
>> identical mappings. So add a quirk for the device to force the domain
>> as passthrough.
>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
> 
> I still don't like this being part of the SMMU driver, but given that
> (a) Robin doesn't seem to agree with the objection and (b) you've been
> refreshing the patch series:
> 
> Acked-by: Will Deacon <will@kernel.org>
> 
> If you do respin, then:
> 
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index 627a3ed5ee8f..5ec15ae2a9b1 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -2839,6 +2839,21 @@ static int arm_smmu_dev_disable_feature(struct device *dev,
>>  	}
>>  }
> 
> It might be worth adding a brief comment here to explain what this device is
> and why it needs an identity mapping.
> 
>> +#define IS_HISI_PTT_DEVICE(pdev)	((pdev)->vendor == PCI_VENDOR_ID_HUAWEI && \
>> +					 (pdev)->device == 0xa12e)
> 

Will add a brief comment here in next version.

Thanks,
Yicong
