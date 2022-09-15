Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093B75B9375
	for <lists+linux-pci@lfdr.de>; Thu, 15 Sep 2022 06:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiIOEGh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Sep 2022 00:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIOEGg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Sep 2022 00:06:36 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA759350E;
        Wed, 14 Sep 2022 21:06:33 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MSk7T1GryzmVMY;
        Thu, 15 Sep 2022 12:02:45 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 15 Sep 2022 12:06:31 +0800
CC:     <yangyicong@hisilicon.com>, <gregkh@linuxfoundation.org>,
        <jonathan.cameron@huawei.com>, <mark.rutland@arm.com>,
        <suzuki.poulose@arm.com>, <james.clark@arm.com>,
        <helgaas@kernel.org>, <lorenzo.pieralisi@arm.com>,
        <shameerali.kolothum.thodi@huawei.com>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <mike.leach@linaro.org>,
        <linux-pci@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <prime.zeng@huawei.com>, <will@kernel.org>, <leo.yan@linaro.org>,
        <alexander.shishkin@linux.intel.com>, <zhangshaokun@hisilicon.com>,
        <linuxarm@huawei.com>, <liuqi6124@gmail.com>, <acme@kernel.org>,
        <peterz@infradead.org>, <mathieu.poirier@linaro.org>
Subject: Re: [RESEND PATCH v12 3/3] perf tool: Add support for parsing
 HiSilicon PCIe Trace packet
To:     John Garry <john.garry@huawei.com>
References: <20220914075925.48549-1-yangyicong@huawei.com>
 <20220914075925.48549-4-yangyicong@huawei.com>
 <80704866-ede6-e3de-2ab0-ee525ac186cd@huawei.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <594b56e0-7a47-bd3c-4a70-0818d03f1382@huawei.com>
Date:   Thu, 15 Sep 2022 12:06:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <80704866-ede6-e3de-2ab0-ee525ac186cd@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022/9/14 18:12, John Garry wrote:
> On 14/09/2022 08:59, Yicong Yang wrote:
>> From: Qi Liu <liuqi115@huawei.com>
>>
>> Add support for using 'perf report --dump-raw-trace' to parse PTT packet.
>>
>> Example usage:
>>
>> Output will contain raw PTT data and its textual representation, such
>> as:
>>
>> 0 0 0x5810 [0x30]: PERF_RECORD_AUXTRACE size: 0x400000  offset: 0
>> ref: 0xa5d50c725  idx: 0  tid: -1  cpu: 0
>> .
>> . ... HISI PTT data: size 4194304 bytes
>> .  00000000: 00 00 00 00                                 Prefix
>> .  00000004: 08 20 00 60                                 Header DW0
>> .  00000008: ff 02 00 01                                 Header DW1
>> .  0000000c: 20 08 00 00                                 Header DW2
>> .  00000010: 10 e7 44 ab                                 Header DW3
>> .  00000014: 2a a8 1e 01                                 Time
>> .  00000020: 00 00 00 00                                 Prefix
>> .  00000024: 01 00 00 60                                 Header DW0
>> .  00000028: 0f 1e 00 01                                 Header DW1
>> .  0000002c: 04 00 00 00                                 Header DW2
>> .  00000030: 40 00 81 02                                 Header DW3
>> .  00000034: ee 02 00 00                                 Time
>> ....
>>
>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>   tools/perf/util/Build                         |   2 +
>>   tools/perf/util/auxtrace.c                    |   3 +
>>   tools/perf/util/hisi-ptt-decoder/Build        |   1 +
>>   .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.c   | 164 +++++++++++++++
>>   .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.h   |  31 +++
>>   tools/perf/util/hisi-ptt.c                    | 192 ++++++++++++++++++
>>   tools/perf/util/hisi-ptt.h                    |   3 +
>>   7 files changed, 396 insertions(+)
>>   create mode 100644 tools/perf/util/hisi-ptt-decoder/Build
>>   create mode 100644 tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
>>   create mode 100644 tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h
>>   create mode 100644 tools/perf/util/hisi-ptt.c
>>
>> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
>> index 9dfae1bda9cc..9bad8568071d 100644
>> --- a/tools/perf/util/Build
>> +++ b/tools/perf/util/Build
>> @@ -118,6 +118,8 @@ perf-$(CONFIG_AUXTRACE) += intel-pt.o
>>   perf-$(CONFIG_AUXTRACE) += intel-bts.o
>>   perf-$(CONFIG_AUXTRACE) += arm-spe.o
>>   perf-$(CONFIG_AUXTRACE) += arm-spe-decoder/
>> +perf-$(CONFIG_AUXTRACE) += hisi-ptt.o
>> +perf-$(CONFIG_AUXTRACE) += hisi-ptt-decoder/
>>   perf-$(CONFIG_AUXTRACE) += s390-cpumsf.o
>>     ifdef CONFIG_LIBOPENCSD
>> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
>> index c30611d9ee99..e799c7314d39 100644
>> --- a/tools/perf/util/auxtrace.c
>> +++ b/tools/perf/util/auxtrace.c
>> @@ -51,6 +51,7 @@
>>   #include "intel-pt.h"
>>   #include "intel-bts.h"
>>   #include "arm-spe.h"
>> +#include "hisi-ptt.h"
>>   #include "s390-cpumsf.h"
>>   #include "util/mmap.h"
>>   @@ -1320,6 +1321,8 @@ int perf_event__process_auxtrace_info(struct perf_session *session,
>>           err = s390_cpumsf_process_auxtrace_info(event, session);
>>           break;
>>       case PERF_AUXTRACE_HISI_PTT:
>> +        err = hisi_ptt_process_auxtrace_info(event, session);
>> +        break;
>>       case PERF_AUXTRACE_UNKNOWN:
>>       default:
>>           return -EINVAL;
>> diff --git a/tools/perf/util/hisi-ptt-decoder/Build b/tools/perf/util/hisi-ptt-decoder/Build
>> new file mode 100644
>> index 000000000000..db3db8b75033
>> --- /dev/null
>> +++ b/tools/perf/util/hisi-ptt-decoder/Build
>> @@ -0,0 +1 @@
>> +perf-$(CONFIG_AUXTRACE) += hisi-ptt-pkt-decoder.o
>> diff --git a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
>> new file mode 100644
>> index 000000000000..dc8f19914628
>> --- /dev/null
>> +++ b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
>> @@ -0,0 +1,164 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * HiSilicon PCIe Trace and Tuning (PTT) support
>> + * Copyright (c) 2022 HiSilicon Technologies Co., Ltd.
>> + */
>> +
>> +#include <stdlib.h>
>> +#include <stdio.h>
>> +#include <string.h>
>> +#include <endian.h>
>> +#include <byteswap.h>
>> +#include <linux/bitops.h>
>> +#include <stdarg.h>
>> +
>> +#include "../color.h"
>> +#include "hisi-ptt-pkt-decoder.h"
>> +
>> +/*
>> + * For 8DW format, the bit[31:11] of DW0 is always 0x1fffff, which can be
>> + * used to distinguish the data format.
>> + * 8DW format is like:
>> + *   bits [                 31:11                 ][       10:0       ]
>> + *        |---------------------------------------|-------------------|
>> + *    DW0 [                0x1fffff               ][ Reserved (0x7ff) ]
>> + *    DW1 [                       Prefix                              ]
>> + *    DW2 [                     Header DW0                            ]
>> + *    DW3 [                     Header DW1                            ]
>> + *    DW4 [                     Header DW2                            ]
>> + *    DW5 [                     Header DW3                            ]
>> + *    DW6 [                   Reserved (0x0)                          ]
>> + *    DW7 [                        Time                               ]
>> + *
>> + * 4DW format is like:
>> + *   bits [31:30] [ 29:25 ][24][23][22][21][    20:11   ][    10:0    ]
>> + *        |-----|---------|---|---|---|---|-------------|-------------|
>> + *    DW0 [ Fmt ][  Type  ][T9][T8][TH][SO][   Length   ][    Time    ]
>> + *    DW1 [                     Header DW1                            ]
>> + *    DW2 [                     Header DW2                            ]
>> + *    DW3 [                     Header DW3                            ]
>> + */
>> +
>> +enum hisi_ptt_8dw_pkt_field_type {
>> +    HISI_PTT_8DW_RSV0,
> 
> if this is defined according to HW value then better be explicit and declare the value
> 

We use these enums to distinguish each DWords of the data, as defined above in the comments.

Do you mean the REV0 here is not accurate according to the above doc?

>> +    HISI_PTT_8DW_PREFIX,
>> +    HISI_PTT_8DW_HEAD0,
>> +    HISI_PTT_8DW_HEAD1,
>> +    HISI_PTT_8DW_HEAD2,
>> +    HISI_PTT_8DW_HEAD3,
>> +    HISI_PTT_8DW_RSV1,
>> +    HISI_PTT_8DW_TIME,
>> +    HISI_PTT_8DW_TYPE_MAX
>> +};
>> +

[...]

>> diff --git a/tools/perf/util/hisi-ptt.c b/tools/perf/util/hisi-ptt.c
>> new file mode 100644
>> index 000000000000..9798e297e7ab
>> --- /dev/null
>> +++ b/tools/perf/util/hisi-ptt.c
>> @@ -0,0 +1,192 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * HiSilicon PCIe Trace and Tuning (PTT) support
>> + * Copyright (c) 2022 HiSilicon Technologies Co., Ltd.
>> + */
>> +
>> +#include <byteswap.h>
>> +#include <endian.h>
>> +#include <errno.h>
>> +#include <inttypes.h>
>> +#include <linux/bitops.h>
>> +#include <linux/kernel.h>
>> +#include <linux/log2.h>
>> +#include <linux/types.h>
>> +#include <linux/zalloc.h>
>> +#include <stdlib.h>
>> +#include <unistd.h>
>> +
>> +#include "auxtrace.h"
>> +#include "color.h"
>> +#include "debug.h"
>> +#include "evlist.h"
>> +#include "evsel.h"
>> +#include "hisi-ptt.h"
>> +#include "hisi-ptt-decoder/hisi-ptt-pkt-decoder.h"
>> +#include "machine.h"
>> +#include "session.h"
>> +#include "symbol.h"
>> +#include "tool.h"
>> +#include "util/synthetic-events.h"
>> +#include <internal/lib.h>
> 
> that's a lot of includes for such a small c file ...
> 

They're necessary I think. Since you point it out I'll do a check and git rid of
the unnecessary including if there is.

>> +
>> +struct hisi_ptt {
>> +    struct auxtrace auxtrace;
>> +    u32 auxtrace_type;
>> +    struct perf_session *session;
>> +    struct machine *machine;
>> +    u32 pmu_type;
>> +};

[...]

>> +
>> +static int hisi_ptt_flush(struct perf_session *session __maybe_unused,
>> +              struct perf_tool *tool __maybe_unused)
> 
> if it's valid to stub this function - s390-cpumsf.c does this also - then can we have it such that auxtrace__flush_events() can handle !flush_events (and avoid stubs)?
> 
>> +{
>> +    return 0;
>> +}
>> +
>> +static void hisi_ptt_free_events(struct perf_session *session __maybe_unused)
>> +{
>> +}
> 
> As above, maybe we can avoid such stubs
> 

ok. But I'd prefer to do it in a separate patch after this series to ease the review, considering
we have only 2 cases here and we already have a refactor in this series, if you don't object.

Will fix the reset comments.

Thanks,
Yicong
