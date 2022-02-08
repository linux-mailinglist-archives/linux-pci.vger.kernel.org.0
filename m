Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C363E4AD808
	for <lists+linux-pci@lfdr.de>; Tue,  8 Feb 2022 12:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356265AbiBHL5L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Feb 2022 06:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233434AbiBHL5L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Feb 2022 06:57:11 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EFEC03FEC0;
        Tue,  8 Feb 2022 03:57:10 -0800 (PST)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JtLw80t75z688jd;
        Tue,  8 Feb 2022 19:52:08 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Tue, 8 Feb 2022 12:57:07 +0100
Received: from [10.47.82.28] (10.47.82.28) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 8 Feb
 2022 11:56:53 +0000
Message-ID: <144329a3-8125-1975-7f23-a247343a679e@huawei.com>
Date:   Tue, 8 Feb 2022 11:56:48 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v3 8/8] iommu/arm-smmu-v3: Make default domain type of
 HiSilicon PTT device to identity
To:     Yicong Yang <yangyicong@huawei.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
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
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
References: <20220124131118.17887-1-yangyicong@hisilicon.com>
 <20220124131118.17887-9-yangyicong@hisilicon.com>
 <4f6f6e0f-4398-3018-cc35-6aa7ea1305fe@huawei.com>
 <ae45a637-2c67-4126-3007-6829320d5659@huawei.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <ae45a637-2c67-4126-3007-6829320d5659@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.82.28]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

On 08/02/2022 11:21, Yicong Yang wrote:
>> This patch should be earlier in the series, before the PTT driver, and the comment on hisi_ptt_check_iommu_mapping() should mention what is going on here.
>>
> ok I'll reorder the serives and modify the comments of hisi_ptt_check_iommu_mapping() like:
> 
> /*
>   * The DMA of PTT trace can only use direct mapping, due to some
>   * hardware restriction. Check whether there is an iommu or the
>   * policy of the iommu domain is passthrough, otherwise the trace
>   * cannot work.

IOMMU, capitalize acronyms

>   *
>   * The PTT device is supposed to behind the arm smmu v3, which
>   * should have passthrough the device by a quirk. Otherwise user
>   * should manually set the iommu domain type to identity through
>   * sysfs.

Sorry, but I don't really understand your meaning here.

I did not think that if we have a default domain then we can change via 
sysfs to anything else.

>   */
> 
>>> Signed-off-by: Yicong Yang<yangyicong@hisilicon.com>
>>> ---
>>>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 16 ++++++++++++++++
>>>    1 file changed, 16 insertions(+)
>>>
>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> index 6dc6d8b6b368..6f67a2b1dd27 100644
>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> @@ -2838,6 +2838,21 @@ static int arm_smmu_dev_disable_feature(struct device *dev,
>>>        }
>>>    }
>>>    +#define IS_HISI_PTT_DEVICE(pdev)    ((pdev)->vendor == PCI_VENDOR_ID_HUAWEI && \
>>> +                     (pdev)->device == 0xa12e)
>> I assume that not all revisions will require this check, right?

So if you are very confident that the next revision will be fixed then I 
would add a check for this current broken revision.

>>
> For current revisions it's necessary.
> 

