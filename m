Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6D8529DB0
	for <lists+linux-pci@lfdr.de>; Tue, 17 May 2022 11:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244383AbiEQJPq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 May 2022 05:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244479AbiEQJPK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 May 2022 05:15:10 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9687837A35;
        Tue, 17 May 2022 02:15:09 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L2VmC3KYRzbbmM;
        Tue, 17 May 2022 17:13:47 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 17:15:07 +0800
CC:     <helgaas@kernel.org>, <lorenzo.pieralisi@arm.com>,
        <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mark.rutland@arm.com>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <prime.zeng@huawei.com>,
        <liuqi115@huawei.com>, <zhangshaokun@hisilicon.com>,
        <linuxarm@huawei.com>
Subject: Re: [PATCH v8 2/8] hwtracing: hisi_ptt: Add trace function support
 for HiSilicon PCIe Tune and Trace device
To:     John Garry <john.garry@huawei.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        <gregkh@linuxfoundation.org>, <alexander.shishkin@linux.intel.com>,
        <leo.yan@linaro.org>, <james.clark@arm.com>, <will@kernel.org>,
        <robin.murphy@arm.com>, <acme@kernel.org>,
        <jonathan.cameron@huawei.com>
References: <20220516125223.32012-1-yangyicong@hisilicon.com>
 <20220516125223.32012-3-yangyicong@hisilicon.com>
 <90aafbc1-b7f6-1cc9-8f94-c72f05150f70@huawei.com>
 <31113797-29c5-1400-f7ac-bff79853b3fe@huawei.com>
 <f1e5309d-d330-faf1-32c5-78962b125f66@huawei.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <53d7db9f-dbd6-c21a-01dd-7316dd541957@huawei.com>
Date:   Tue, 17 May 2022 17:15:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <f1e5309d-d330-faf1-32c5-78962b125f66@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022/5/17 16:21, John Garry wrote:
> On 17/05/2022 09:09, Yicong Yang wrote:
>>>> +    target = cpumask_any(cpumask_of_node(dev_to_node(&hisi_ptt->pdev->dev)));
>>>> +    if (target < nr_cpumask_bits) {
>>> the comment for cpumask_any() hints to check against nr_cpu_ids - any specific reason to check against nr_cpumask_bits?
>>>
>> here should be:
>>     if (target >= nr_cpumask_bits) {
>>
>> will fix this up.
>>
> 
> I am still not sure that using nr_cpumask_bits is correct.

Let's use nr_cpu_ids to match the comment of cpumask_any(). Actually we should have
nr_cpu_ids(possible cpus, init to NR_CPUS) <= nr_cpumask_bits (NR_CPUS) so it's ok here.
