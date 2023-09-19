Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D846F7A6446
	for <lists+linux-pci@lfdr.de>; Tue, 19 Sep 2023 15:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjISNDZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Sep 2023 09:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjISNDZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Sep 2023 09:03:25 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5464AF3;
        Tue, 19 Sep 2023 06:03:18 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RqhZh6WJvzMl6D;
        Tue, 19 Sep 2023 20:59:40 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 19 Sep 2023 21:03:14 +0800
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
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <75b93d15-f099-5d17-caa9-94b0390773cf@huawei.com>
Date:   Tue, 19 Sep 2023 21:03:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <73655f9b-9ea4-cb46-d712-20f1c4ac7c95@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.177]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023/9/15 20:53, Suzuki K Poulose wrote:
> On 14/09/2023 12:22, Yicong Yang wrote:
>> From: Junhao He <hejunhao3@huawei.com>
>>
>> When start trace with perf option "-C $cpu" and immediately stop it
>> with SIGTERM or others, the perf core will invoke pmu::read() while
>> the driver doesn't implement it. Add a dummy pmu::read() to avoid
>> any issues.
> 
> What issues are we talking about here ? Shouldn't the core perf
> skip the call, if pmu::read() is not available ?
> 

Actually no, the core doesn't check it. So I think that's why some PMUs
like SPE implements a dummy pmu::read() callback. Otherwise we'll
dereference a NULL pointer.

Currently we only met this on emulated platforms with very slow CPUs,
follow the instructions in the commit above.

> Suzuki
> 
>>
>> Signed-off-by: Junhao He <hejunhao3@huawei.com>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   drivers/hwtracing/ptt/hisi_ptt.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
>> index 62a444f5228e..c1b5fd2b8974 100644
>> --- a/drivers/hwtracing/ptt/hisi_ptt.c
>> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
>> @@ -1184,6 +1184,10 @@ static void hisi_ptt_pmu_del(struct perf_event *event, int flags)
>>       hisi_ptt_pmu_stop(event, PERF_EF_UPDATE);
>>   }
>>   +static void hisi_ptt_pmu_read(struct perf_event *event)
>> +{
>> +}
>> +
>>   static void hisi_ptt_remove_cpuhp_instance(void *hotplug_node)
>>   {
>>       cpuhp_state_remove_instance_nocalls(hisi_ptt_pmu_online, hotplug_node);
>> @@ -1227,6 +1231,7 @@ static int hisi_ptt_register_pmu(struct hisi_ptt *hisi_ptt)
>>           .stop        = hisi_ptt_pmu_stop,
>>           .add        = hisi_ptt_pmu_add,
>>           .del        = hisi_ptt_pmu_del,
>> +        .read        = hisi_ptt_pmu_read,
>>       };
>>         reg = readl(hisi_ptt->iobase + HISI_PTT_LOCATION);
> 
> 
> .
