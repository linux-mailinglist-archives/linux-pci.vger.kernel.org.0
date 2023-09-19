Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAAD77A64AD
	for <lists+linux-pci@lfdr.de>; Tue, 19 Sep 2023 15:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbjISNTv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Sep 2023 09:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbjISNTu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Sep 2023 09:19:50 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494FEF1;
        Tue, 19 Sep 2023 06:19:44 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RqhzN3vg4zrT2T;
        Tue, 19 Sep 2023 21:17:36 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 19 Sep 2023 21:19:41 +0800
CC:     <yangyicong@hisilicon.com>, <alexander.shishkin@linux.intel.com>,
        <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>,
        <hejunhao3@huawei.com>
Subject: Re: [PATCH v2 3/5] hwtracing: hisi_ptt: Optimize the trace data
 committing
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        <mathieu.poirier@linaro.org>, <jonathan.cameron@huawei.com>,
        <linux-kernel@vger.kernel.org>
References: <20230914112223.27165-1-yangyicong@huawei.com>
 <20230914112223.27165-4-yangyicong@huawei.com>
 <03da788f-584b-1be5-2cc3-70a9e57c11ba@arm.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <fd62aa39-78d7-a6c5-7782-8214256ee51b@huawei.com>
Date:   Tue, 19 Sep 2023 21:19:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <03da788f-584b-1be5-2cc3-70a9e57c11ba@arm.com>
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

On 2023/9/15 22:44, Suzuki K Poulose wrote:
> On 14/09/2023 12:22, Yicong Yang wrote:
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> Currently during the PTT trace, we'll only commit the data
>> to the perf core when its full, which means after 4 interrupts
>> and totally 16MiB data while the AUX buffer is 16MiB length.
>> Then the userspace gets notified and handle the data. The driver
>> cannot apply a new AUX buffer immediately until the committed data
>> are handled and there's enough room in the buffer again.
>>
>> This patch tries to optimize this by commit the data in every
>> interrupts in a 4MiB granularity. Then the userspace can have
>> enough time to consume the data and there's always enough room
>> in the AUX buffer.
> 
> Instead of always committing at 4M, could we not use the existing
> markers used by the handle->wakeup to decide if we should commit it ?
> 

Is it intended to avoid too much wakeups? I think the core will handle
the wakeup even if we commit the data in perf_aux_output_end().
For example, if the userspace buffer is 16MiB and the watermark is 8MiB,
we'll not wake up userspace after the first 4MiB committing.

4MiB mentioned in the commit is our current configuration: hardware
maintains 4 buffers and driver configure each one as 4MiB. Driver will
get interrupt if one buffer filled and then copy the data to the AUX
buffer. We restrict the AUX buffer to be at least 16MiB. Previous we'll
only commit the data if the resident space in the AUX buffer cannot
contain next 4MiB data, typically after copy 4 buffers to AUX buffer.
This is suboptimal because after committing there's no space in the
AUX buffer and driver needs to wait until userspace consumes the data.
So we optimize it in this patch to always commit the data to AUX
buffer in time to avoid waiting.

> 
> Suzuki
> 
>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   drivers/hwtracing/ptt/hisi_ptt.c | 15 +++++++--------
>>   1 file changed, 7 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
>> index 3041238a6e54..4f355df8da23 100644
>> --- a/drivers/hwtracing/ptt/hisi_ptt.c
>> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
>> @@ -274,15 +274,14 @@ static int hisi_ptt_update_aux(struct hisi_ptt *hisi_ptt, int index, bool stop)
>>       buf->pos += size;
>>         /*
>> -     * Just commit the traced data if we're going to stop. Otherwise if the
>> -     * resident AUX buffer cannot contain the data of next trace buffer,
>> -     * apply a new one.
>> +     * Always commit the data to the AUX buffer in time to make sure
>> +     * userspace got enough time to consume the data.
>> +     *
>> +     * If we're not going to stop, apply a new one and check whether
>> +     * there's enough room for the next trace.
>>        */
>> -    if (stop) {
>> -        perf_aux_output_end(handle, buf->pos);
>> -    } else if (buf->length - buf->pos < HISI_PTT_TRACE_BUF_SIZE) {
>> -        perf_aux_output_end(handle, buf->pos);
>> -
>> +    perf_aux_output_end(handle, size);
>> +    if (!stop) {
>>           buf = perf_aux_output_begin(handle, event);
>>           if (!buf)
>>               return -EINVAL;
> 
> 
> .
