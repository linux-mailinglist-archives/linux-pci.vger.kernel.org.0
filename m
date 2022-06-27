Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D653055CEB6
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 15:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbiF0ISm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jun 2022 04:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbiF0ISl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jun 2022 04:18:41 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE065C76;
        Mon, 27 Jun 2022 01:18:39 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LWgY31qVdzhYn4;
        Mon, 27 Jun 2022 16:16:23 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 27 Jun 2022 16:18:36 +0800
CC:     <gregkh@linuxfoundation.org>, <alexander.shishkin@linux.intel.com>,
        <james.clark@arm.com>, <will@kernel.org>, <robin.murphy@arm.com>,
        <acme@kernel.org>, <jonathan.cameron@huawei.com>,
        <john.garry@huawei.com>, <helgaas@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <mathieu.poirier@linaro.org>,
        <suzuki.poulose@arm.com>, <mark.rutland@arm.com>,
        <joro@8bytes.org>, <shameerali.kolothum.thodi@huawei.com>,
        <peterz@infradead.org>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <prime.zeng@huawei.com>,
        <liuqi115@huawei.com>, <zhangshaokun@hisilicon.com>,
        <linuxarm@huawei.com>
Subject: Re: [PATCH v9 5/8] perf tool: Add support for HiSilicon PCIe Tune and
 Trace device driver
To:     Leo Yan <leo.yan@linaro.org>,
        Yicong Yang <yangyicong@hisilicon.com>
References: <20220606115555.41103-1-yangyicong@hisilicon.com>
 <20220606115555.41103-6-yangyicong@hisilicon.com>
 <20220627020256.GB143063@leoy-ThinkPad-X240s>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <fb55fdab-3ad6-a21a-315a-9dc404b35f11@huawei.com>
Date:   Mon, 27 Jun 2022 16:18:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20220627020256.GB143063@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022/6/27 10:02, Leo Yan wrote:
> On Mon, Jun 06, 2022 at 07:55:52PM +0800, Yicong Yang wrote:
>> From: Qi Liu <liuqi115@huawei.com>
>>
>> HiSilicon PCIe tune and trace device (PTT) could dynamically tune
>> the PCIe link's events, and trace the TLP headers).
>>
>> This patch add support for PTT device in perf tool, so users could
>> use 'perf record' to get TLP headers trace data.
>>
>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> 
> Just one minor comment.
> 
> [...]
> 
>> diff --git a/tools/perf/util/hisi-ptt.h b/tools/perf/util/hisi-ptt.h
>> new file mode 100644
>> index 000000000000..2db9b4056214
>> --- /dev/null
>> +++ b/tools/perf/util/hisi-ptt.h
>> @@ -0,0 +1,19 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * HiSilicon PCIe Trace and Tuning (PTT) support
>> + * Copyright (c) 2022 HiSilicon Technologies Co., Ltd.
>> + */
>> +
>> +#ifndef INCLUDE__PERF_HISI_PTT_H__
>> +#define INCLUDE__PERF_HISI_PTT_H__
>> +
>> +#define HISI_PTT_PMU_NAME		"hisi_ptt"
>> +#define HISI_PTT_AUXTRACE_PRIV_SIZE	sizeof(u64)
>> +
>> +struct auxtrace_record *hisi_ptt_recording_init(int *err,
>> +						struct perf_pmu *hisi_ptt_pmu);
>> +
>> +int hisi_ptt_process_auxtrace_info(union perf_event *event,
>> +				   struct perf_session *session);
> 
> The function hisi_ptt_process_auxtrace_info() is introduced by next
> patch for support PTT decoding, for good practice (e.g. keep
> bisection), it's good to introduce function declaration and definition
> in one patch.
> 

Thanks for catching this. There's something wrong when doing the patch splitting.
Will fix this!

> With this fixing, this patch looks good to me:
> 
> Reviewed-by: Leo Yan <leo.yan@linaro.org>
> 

Thanks.
