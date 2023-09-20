Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C023E7A73BB
	for <lists+linux-pci@lfdr.de>; Wed, 20 Sep 2023 09:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbjITHKh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Sep 2023 03:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbjITHKg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Sep 2023 03:10:36 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A1FB9;
        Wed, 20 Sep 2023 00:10:28 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Rr8hM4gslztSvJ;
        Wed, 20 Sep 2023 15:06:11 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 20 Sep 2023 15:10:25 +0800
CC:     <yangyicong@hisilicon.com>, <alexander.shishkin@linux.intel.com>,
        <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>,
        <hejunhao3@huawei.com>
Subject: Re: [PATCH v2 5/5] hwtracing: hisi_ptt: Add dummy callback
 pmu::read()
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        <mathieu.poirier@linaro.org>, <jonathan.cameron@huawei.com>,
        <linux-kernel@vger.kernel.org>
References: <20230914112223.27165-1-yangyicong@huawei.com>
 <20230914112223.27165-6-yangyicong@huawei.com>
 <73655f9b-9ea4-cb46-d712-20f1c4ac7c95@arm.com>
 <75b93d15-f099-5d17-caa9-94b0390773cf@huawei.com>
 <3cc013bd-c85e-b28a-f921-d5593b3935a4@arm.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <adf0211e-3e7d-8d33-bff4-cf064bfb20af@huawei.com>
Date:   Wed, 20 Sep 2023 15:10:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <3cc013bd-c85e-b28a-f921-d5593b3935a4@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.177]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023/9/20 1:01, Suzuki K Poulose wrote:
> On 19/09/2023 14:03, Yicong Yang wrote:
>> On 2023/9/15 20:53, Suzuki K Poulose wrote:
>>> On 14/09/2023 12:22, Yicong Yang wrote:
>>>> From: Junhao He <hejunhao3@huawei.com>
>>>>
>>>> When start trace with perf option "-C $cpu" and immediately stop it
>>>> with SIGTERM or others, the perf core will invoke pmu::read() while
>>>> the driver doesn't implement it. Add a dummy pmu::read() to avoid
>>>> any issues.
>>>
>>> What issues are we talking about here ? Shouldn't the core perf
>>> skip the call, if pmu::read() is not available ?
>>>
>>
>> Actually no, the core doesn't check it. So I think that's why some PMUs
>> like SPE implements a dummy pmu::read() callback. Otherwise we'll
>> dereference a NULL pointer.
>>
>> Currently we only met this on emulated platforms with very slow CPUs,
>> follow the instructions in the commit above.
> 
> Ok, then it calls for a Fixes tag. Please tag it to the commit that
> introduced the PMU.
> 

Sure. I'll add the tag in v3.

Thanks.
