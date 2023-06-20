Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B0973670B
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jun 2023 11:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjFTJJ6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jun 2023 05:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjFTJJ5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Jun 2023 05:09:57 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF572C9;
        Tue, 20 Jun 2023 02:09:54 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QlgnP0kByz1FDfh;
        Tue, 20 Jun 2023 17:09:45 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 20 Jun 2023 17:09:46 +0800
CC:     <yangyicong@hisilicon.com>, <alexander.shishkin@linux.intel.com>,
        <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <prime.zeng@huawei.com>
Subject: Re: [PATCH v4 4/5] hwtracing: hisi_ptt: Advertise
 PERF_PMU_CAP_NO_EXCLUDE for PTT PMU
To:     hejunhao <hejunhao3@huawei.com>, <mathieu.poirier@linaro.org>,
        <suzuki.poulose@arm.com>, <jonathan.cameron@huawei.com>,
        <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
References: <20230606142244.10939-1-yangyicong@huawei.com>
 <20230606142244.10939-5-yangyicong@huawei.com>
 <01c39cb9-e56a-862b-2d99-024b7ba5a769@huawei.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <e3424908-a6a3-63f7-f3b7-e10b00cdfd13@huawei.com>
Date:   Tue, 20 Jun 2023 17:09:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <01c39cb9-e56a-862b-2d99-024b7ba5a769@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Junhao,

On 2023/6/19 21:00, hejunhao wrote:
> Hi, Yicong
> 
> 
> On 2023/6/6 22:22, Yicong Yang wrote:
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> The PTT trace collects PCIe TLP headers from the PCIe link and don't
>> have the ability to exclude certain context. It doesn't support itrace
>> as well. So only advertise PERF_PMU_CAP_NO_EXCLUDE. This will greatly
>> save the storage of final data. Tested tracing idle link for ~15s,
>> without this patch we'll collect ~28.682MB data for context related
>> information and with this patch it reduced to ~0.226MB.
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>   drivers/hwtracing/ptt/hisi_ptt.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
>> index 5c7e93e7705f..ff2c16efe5b1 100644
>> --- a/drivers/hwtracing/ptt/hisi_ptt.c
>> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
>> @@ -1210,7 +1210,7 @@ static int hisi_ptt_register_pmu(struct hisi_ptt *hisi_ptt)
>>         hisi_ptt->hisi_ptt_pmu = (struct pmu) {
>>           .module        = THIS_MODULE,
>> -        .capabilities    = PERF_PMU_CAP_EXCLUSIVE | PERF_PMU_CAP_ITRACE,
>> +        .capabilities    = PERF_PMU_CAP_NO_EXCLUDE,
> 
> According to the error prompt of function hisi_ptt_trace_start().
> https://elixir.bootlin.com/linux/v6.4-rc7/source/drivers/hwtracing/ptt/hisi_ptt.c#L197
> 
> You may be need to keep advertise PERF_PMU_CAP_EXCLUSIVE?
> Such pmus can only have one event scheduled at a time, if not the perf
> tool will report device busy.
> 

Thanks for point it out. Checking [1] I think we still need this flag here, will add
it back.

[1] https://github.com/torvalds/linux/blob/v6.4-rc6/kernel/events/core.c#L5054

Thanks.
