Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBD75E99E9
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 08:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiIZGxn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 02:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbiIZGxi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 02:53:38 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19FA2035E;
        Sun, 25 Sep 2022 23:53:36 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MbYJ11tp0zHtp4;
        Mon, 26 Sep 2022 14:48:49 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 14:53:34 +0800
CC:     <yangyicong@hisilicon.com>, <gregkh@linuxfoundation.org>,
        <mathieu.poirier@linaro.org>, <will@kernel.org>,
        <james.clark@arm.com>, <leo.yan@linaro.org>,
        <alexander.shishkin@linux.intel.com>, <peterz@infradead.org>,
        <helgaas@kernel.org>, <lorenzo.pieralisi@arm.com>,
        <shameerali.kolothum.thodi@huawei.com>, <mark.rutland@arm.com>,
        <suzuki.poulose@arm.com>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <prime.zeng@huawei.com>, <zhangshaokun@hisilicon.com>,
        <linuxarm@huawei.com>, <liuqi6124@gmail.com>, <acme@kernel.org>,
        <jonathan.cameron@huawei.com>, <mike.leach@linaro.org>
Subject: Re: [PATCH v13 2/3] perf tool: Add support for HiSilicon PCIe Tune
 and Trace device driver
To:     John Garry <john.garry@huawei.com>
References: <20220919090045.6778-1-yangyicong@huawei.com>
 <20220919090045.6778-3-yangyicong@huawei.com>
 <db2a81dc-18be-6e15-c241-a1a91747d063@huawei.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <77226dcb-d158-a4f7-8afb-ac89c07bed97@huawei.com>
Date:   Mon, 26 Sep 2022 14:53:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <db2a81dc-18be-6e15-c241-a1a91747d063@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022/9/23 18:49, John Garry wrote:
> On 19/09/2022 10:00, Yicong Yang wrote:
>> From: Qi Liu <liuqi115@huawei.com>
>>
>> HiSilicon PCIe tune and trace device (PTT) could dynamically tune
>> the PCIe link's events, and trace the TLP headers).
>>
>> This patch add support for PTT device in perf tool, so users could
>> use 'perf record' to get TLP headers trace data.
>>
>> Reviewed-by: Leo Yan <leo.yan@linaro.org>
>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> 
> I'm not overly fimilar with the auxtrace code, but this patch looks ok apart from comments, so acked-by seems more appropiate than reviewed-by:
> 
> Acked-by: John Garry <john.garry@huawei.com>

Thanks! May I have the ack for the other 2 patches as well?

Some replies below.

> 
>> ---
>>   tools/perf/arch/arm/util/auxtrace.c   |  63 +++++++++
>>   tools/perf/arch/arm/util/pmu.c        |   3 +
>>   tools/perf/arch/arm64/util/Build      |   2 +-
>>   tools/perf/arch/arm64/util/hisi-ptt.c | 188 ++++++++++++++++++++++++++
>>   tools/perf/util/auxtrace.c            |   1 +
>>   tools/perf/util/auxtrace.h            |   1 +
>>   tools/perf/util/hisi-ptt.h            |  16 +++
>>   7 files changed, 273 insertions(+), 1 deletion(-)
>>   create mode 100644 tools/perf/arch/arm64/util/hisi-ptt.c
>>   create mode 100644 tools/perf/util/hisi-ptt.h
>>
>> diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
>> index 384c7cfda0fd..129ed72391a4 100644
>> --- a/tools/perf/arch/arm/util/auxtrace.c
>> +++ b/tools/perf/arch/arm/util/auxtrace.c
>> @@ -4,9 +4,11 @@
>>    * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
>>    */
>>   +#include <dirent.h>
>>   #include <stdbool.h>
>>   #include <linux/coresight-pmu.h>
>>   #include <linux/zalloc.h>
>> +#include <api/fs/fs.h>
>>     #include "../../../util/auxtrace.h"
>>   #include "../../../util/debug.h"
>> @@ -14,6 +16,7 @@
>>   #include "../../../util/pmu.h"
>>   #include "cs-etm.h"
>>   #include "arm-spe.h"
>> +#include "hisi-ptt.h"
>>     static struct perf_pmu **find_all_arm_spe_pmus(int *nr_spes, int *err)
>>   {
>> @@ -50,6 +53,52 @@ static struct perf_pmu **find_all_arm_spe_pmus(int *nr_spes, int *err)
>>       return arm_spe_pmus;
>>   }
>>   +static struct perf_pmu **find_all_hisi_ptt_pmus(int *nr_ptts, int *err)
>> +{
>> +    const char *sysfs = sysfs__mountpoint();
>> +    struct perf_pmu **hisi_ptt_pmus = NULL;
>> +    struct dirent *dent;
>> +    char path[PATH_MAX];
>> +    DIR *dir = NULL;
>> +    int idx = 0;
>> +
>> +    snprintf(path, PATH_MAX, "%s" EVENT_SOURCE_DEVICE_PATH, sysfs);
>> +    dir = opendir(path);
>> +    if (!dir) {
>> +        pr_err("can't read directory '%s'\n", EVENT_SOURCE_DEVICE_PATH);
>> +        *err = -EINVAL;
>> +        goto out;
> 
> Do you really need to call closedir() in this scenario?
> 

It's unnecessary here. will return NULL directly.

>> +    }
>> +
>> +    while ((dent = readdir(dir))) {
>> +        if (strstr(dent->d_name, HISI_PTT_PMU_NAME))
>> +            (*nr_ptts)++;
>> +    }
>> +
>> +    if (!(*nr_ptts))
>> +        goto out;
>> +
>> +    hisi_ptt_pmus = zalloc(sizeof(struct perf_pmu *) * (*nr_ptts));
>> +    if (!hisi_ptt_pmus) {
>> +        pr_err("hisi_ptt alloc failed\n");
>> +        *err = -ENOMEM;
>> +        goto out;
>> +    }
>> +
>> +    rewinddir(dir);
>> +    while ((dent = readdir(dir))) {
>> +        if (strstr(dent->d_name, HISI_PTT_PMU_NAME) && idx < (*nr_ptts)) {
> 
> idx < *nr_ptts
> 
> is ok
> 

ok.

>> +            hisi_ptt_pmus[idx] = perf_pmu__find(dent->d_name);
>> +            if (hisi_ptt_pmus[idx])
>> +                idx++;
>> +        }
>> +    }
>> +
>> +out:
>> +    closedir(dir);
>> +    return hisi_ptt_pmus;
>> +}
>> +

[...]

>> +
>> +#define KiB(x) ((x) * 1024)
>> +#define MiB(x) ((x) * 1024 * 1024)
> 
> surely we have defines for these available elsewhere
> 

Yes but we looks like have no public definition for these:

yangyicong@ubuntu:~/mainline_linux/linux$ egrep -rwn "#define KiB|#define MiB" tools/perf/
tools/perf/arch/arm64/util/hisi-ptt.c:27:#define KiB(x) ((x) * 1024)
tools/perf/arch/arm64/util/hisi-ptt.c:28:#define MiB(x) ((x) * 1024 * 1024)
tools/perf/arch/arm64/util/arm-spe.c:28:#define KiB(x) ((x) * 1024)
tools/perf/arch/arm64/util/arm-spe.c:29:#define MiB(x) ((x) * 1024 * 1024)
tools/perf/arch/x86/util/intel-bts.c:28:#define KiB(x) ((x) * 1024)
tools/perf/arch/x86/util/intel-bts.c:29:#define MiB(x) ((x) * 1024 * 1024)
tools/perf/arch/x86/util/intel-pt.c:35:#define KiB(x) ((x) * 1024)
tools/perf/arch/x86/util/intel-pt.c:36:#define MiB(x) ((x) * 1024 * 1024)
tools/perf/util/cs-etm.h:188:#define KiB(x) ((x) * 1024)
tools/perf/util/cs-etm.h:189:#define MiB(x) ((x) * 1024 * 1024)

We can centralize this definition after this series.

>> +
>> +struct hisi_ptt_recording {
>> +    struct auxtrace_record    itr;
>> +    struct perf_pmu *hisi_ptt_pmu;
>> +    struct evlist *evlist;
>> +};
>> +

[...]

>> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
>> index 6edab8a16de6..c30611d9ee99 100644
>> --- a/tools/perf/util/auxtrace.c
>> +++ b/tools/perf/util/auxtrace.c
>> @@ -1319,6 +1319,7 @@ int perf_event__process_auxtrace_info(struct perf_session *session,
>>       case PERF_AUXTRACE_S390_CPUMSF:
>>           err = s390_cpumsf_process_auxtrace_info(event, session);
>>           break;
>> +    case PERF_AUXTRACE_HISI_PTT:
>>       case PERF_AUXTRACE_UNKNOWN:
>>       default:
>>           return -EINVAL;
>> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
>> index 6a4fbfd34c6b..3a122fc01ccd 100644
>> --- a/tools/perf/util/auxtrace.h
>> +++ b/tools/perf/util/auxtrace.h
>> @@ -48,6 +48,7 @@ enum auxtrace_type {
>>       PERF_AUXTRACE_CS_ETM,
>>       PERF_AUXTRACE_ARM_SPE,
>>       PERF_AUXTRACE_S390_CPUMSF,
>> +    PERF_AUXTRACE_HISI_PTT,
>>   };
>>     enum itrace_period_type {
>> diff --git a/tools/perf/util/hisi-ptt.h b/tools/perf/util/hisi-ptt.h
> 
> I'm still not a fan of having a header file which is only included by 1x .c file, which this seems to be
> 

The stuff in hisi-ptt.h is shared across several source files:

yangyicong@ubuntu:~/mainline_linux/linux$ egrep -rn "hisi-ptt.h" tools/perf/
tools/perf/arch/arm64/util/hisi-ptt.c:21:#include "../../../util/hisi-ptt.h"
tools/perf/arch/arm/util/auxtrace.c:19:#include "hisi-ptt.h"
tools/perf/arch/arm/util/pmu.c:13:#include "hisi-ptt.h"

Thanks,
Yicong

>> new file mode 100644
>> index 000000000000..82283c81b4c1
>> --- /dev/null
>> +++ b/tools/perf/util/hisi-ptt.h
>> @@ -0,0 +1,16 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * HiSilicon PCIe Trace and Tuning (PTT) support
>> + * Copyright (c) 2022 HiSilicon Technologies Co., Ltd.
>> + */
>> +
>> +#ifndef INCLUDE__PERF_HISI_PTT_H__
>> +#define INCLUDE__PERF_HISI_PTT_H__
>> +
>> +#define HISI_PTT_PMU_NAME        "hisi_ptt"
>> +#define HISI_PTT_AUXTRACE_PRIV_SIZE    sizeof(u64)
>> +
>> +struct auxtrace_record *hisi_ptt_recording_init(int *err,
>> +                        struct perf_pmu *hisi_ptt_pmu);
>> +
>> +#endif
> 
> .
