Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921CF51BE05
	for <lists+linux-pci@lfdr.de>; Thu,  5 May 2022 13:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357257AbiEELed (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 May 2022 07:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355252AbiEELec (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 May 2022 07:34:32 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C921FCC3;
        Thu,  5 May 2022 04:30:52 -0700 (PDT)
Received: from kwepemi100016.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KvBLd0lrpzfbGq;
        Thu,  5 May 2022 19:29:45 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 kwepemi100016.china.huawei.com (7.221.188.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 19:30:49 +0800
Received: from [10.67.101.67] (10.67.101.67) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 19:30:48 +0800
Subject: Re: [PATCH v7 5/7] perf tool: Add support for HiSilicon PCIe Tune and
 Trace device driver
To:     Leo Yan <leo.yan@linaro.org>,
        Yicong Yang <yangyicong@hisilicon.com>
CC:     <gregkh@linuxfoundation.org>, <helgaas@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <lorenzo.pieralisi@arm.com>,
        <will@kernel.org>, <mark.rutland@arm.com>,
        <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>, <jonathan.cameron@huawei.com>,
        <daniel.thompson@linaro.org>, <joro@8bytes.org>,
        <john.garry@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
        <robin.murphy@arm.com>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <coresight@lists.linaro.org>, <linux-pci@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <zhangshaokun@hisilicon.com>,
        <linuxarm@huawei.com>, <prime.zeng@huawei.com>
References: <20220407125841.3678-1-yangyicong@hisilicon.com>
 <20220407125841.3678-6-yangyicong@hisilicon.com>
 <20220430073411.GA657977@leoy-ThinkPad-X240s>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <602845da-ba50-fe28-7341-76f1066ab725@huawei.com>
Date:   Thu, 5 May 2022 19:30:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220430073411.GA657977@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.101.67]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Hi Leo,

Thanks for your review, some replies below.

On 2022/4/30 15:35, Leo Yan wrote:
> On Thu, Apr 07, 2022 at 08:58:39PM +0800, Yicong Yang via iommu wrote:
>> From: Qi Liu <liuqi115@huawei.com>
>>
>> 'perf record' and 'perf report --dump-raw-trace' supported in this
>> patch.
>>
>> Example usage:
>>
>> Output will contain raw PTT data and its textual representation, such
>> as:
>>
>> 0 0 0x5810 [0x30]: PERF_RECORD_AUXTRACE size: 0x400000  offset: 0
>> ref: 0xa5d50c725  idx: 0  tid: -1  cpu: 0
>> .
>> . ... HISI PTT data: size 4194304 bytes
>> .  00000000: 00 00 00 00                                 Prefix
>> .  00000004: 08 20 00 60                                 Header DW0
>> .  00000008: ff 02 00 01                                 Header DW1
>> .  0000000c: 20 08 00 00                                 Header DW2
>> .  00000010: 10 e7 44 ab                                 Header DW3
>> .  00000014: 2a a8 1e 01                                 Time
>> .  00000020: 00 00 00 00                                 Prefix
>> .  00000024: 01 00 00 60                                 Header DW0
>> .  00000028: 0f 1e 00 01                                 Header DW1
>> .  0000002c: 04 00 00 00                                 Header DW2
>> .  00000030: 40 00 81 02                                 Header DW3
>> .  00000034: ee 02 00 00                                 Time
>> ....
>>
>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>   tools/perf/arch/arm/util/auxtrace.c           |  76 +++++-
>>   tools/perf/arch/arm/util/pmu.c                |   3 +
>>   tools/perf/arch/arm64/util/Build              |   2 +-
>>   tools/perf/arch/arm64/util/hisi_ptt.c         | 195 ++++++++++++++++
>>   tools/perf/util/Build                         |   2 +
>>   tools/perf/util/auxtrace.c                    |   4 +
>>   tools/perf/util/auxtrace.h                    |   1 +
>>   tools/perf/util/hisi-ptt-decoder/Build        |   1 +
>>   .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.c   | 170 ++++++++++++++
>>   .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.h   |  28 +++
>>   tools/perf/util/hisi_ptt.c                    | 218 ++++++++++++++++++
>>   tools/perf/util/hisi_ptt.h                    |  28 +++
> 
> It's good to divide the big patch into smaller patches, e.g. one patch
> is to add PTT auxtrace (so mainly for perf record), and the second
> patch is to add PTT decoder for perf decoding.
> 
got it, I'll do this, thanks.

>>   12 files changed, 724 insertions(+), 4 deletions(-)
>>   create mode 100644 tools/perf/arch/arm64/util/hisi_ptt.c
>>   create mode 100644 tools/perf/util/hisi-ptt-decoder/Build
>>   create mode 100644 tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
>>   create mode 100644 tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h
>>   create mode 100644 tools/perf/util/hisi_ptt.c
>>   create mode 100644 tools/perf/util/hisi_ptt.h
>>
>> diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
>> index 5fc6a2a3dbc5..393f5757c039 100644
>> --- a/tools/perf/arch/arm/util/auxtrace.c
>> +++ b/tools/perf/arch/arm/util/auxtrace.c
>> @@ -4,9 +4,11 @@
>>    * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
>>    */
[...]
>> +
>> +	rewinddir(dir);
>> +	while ((dent = readdir(dir))) {
>> +		if (strstr(dent->d_name, HISI_PTT_PMU_NAME) && idx < (*nr_ptts)) {
>> +			hisi_ptt_pmus[idx] = perf_pmu__find(dent->d_name);
>> +			if (hisi_ptt_pmus[idx]) {
>> +				pr_debug2("%s %d: hisi_ptt_pmu %d type %d name %s\n",
>> +					__func__, __LINE__, idx,
>> +					hisi_ptt_pmus[idx]->type,
>> +					hisi_ptt_pmus[idx]->name);
>> +					idx++;
> 
> Indentation for "idx++" is not right.
will fix this, thanks.

> 
>> +			}
>> +
> 
> Redundant new line.
will fix this, thanks.
> 
>> +		}
>> +	}
>> +
>> +out:
>> +	closedir(dir);
>> +	return hisi_ptt_pmus;
>> +}
>> +
>>   struct auxtrace_record
>>   *auxtrace_record__init(struct evlist *evlist, int *err)
>>   {
>> @@ -57,8 +112,12 @@ struct auxtrace_record
>>   	struct evsel *evsel;
>>   	bool found_etm = false;
>>   	struct perf_pmu *found_spe = NULL;
>> +	struct perf_pmu *found_ptt = NULL;
>>   	struct perf_pmu **arm_spe_pmus = NULL;
>> +	struct perf_pmu **hisi_ptt_pmus = NULL;
>> +
>>   	int nr_spes = 0;
>> +	int nr_ptts = 0;
>>   	int i = 0;
>>   
>>   	if (!evlist)
>> @@ -66,13 +125,14 @@ struct auxtrace_record
>>   
>>   	cs_etm_pmu = perf_pmu__find(CORESIGHT_ETM_PMU_NAME);
>>   	arm_spe_pmus = find_all_arm_spe_pmus(&nr_spes, err);
>> +	hisi_ptt_pmus = find_all_hisi_ptt_pmus(&nr_ptts, err);
>>   
>>   	evlist__for_each_entry(evlist, evsel) {
>>   		if (cs_etm_pmu &&
>>   		    evsel->core.attr.type == cs_etm_pmu->type)
>>   			found_etm = true;
>>   
>> -		if (!nr_spes || found_spe)
>> +		if ((!nr_spes || found_spe) && (!nr_ptts || found_ptt))
>>   			continue;
>>   
>>   		for (i = 0; i < nr_spes; i++) {
>> @@ -81,11 +141,18 @@ struct auxtrace_record
>>   				break;
>>   			}
>>   		}
>> +
>> +		for (i = 0; i < nr_ptts; i++) {
>> +			if (evsel->core.attr.type == hisi_ptt_pmus[i]->type) {
>> +				found_ptt = hisi_ptt_pmus[i];
>> +				break;
>> +			}
>> +		}
>>   	}
> 
> For the loop of evlist__for_each_entry, it's good to refactor the
> event list iteration, we can refine code like below:
> 
> static struct perf_pmu *find_pmu_for_event(struct perf_pmu **pmus,
>                                             int pmu_nr, struct evsel *evsel)
> {
>          int i;
>          struct perf_pmu *found = NULL;
> 
>          if (!pmus)
>                  return NULL;
> 
>          for (i = 0; i < pmu_nr; i++) {
>                  if (evsel->core.attr.type == pmus[i]->type) {
>                          found = pmus[i];
>                          break;
>                  }
>          }
> 
>          return found;
> }
> 
> struct auxtrace_record
> *auxtrace_record__init(struct evlist *evlist, int *err)
> {
>      ...
> 
>      evlist__for_each_entry(evlist, evsel) {
>              if (cs_etm_pmu && !found_etm)
> 		    found_etm = find_pmu_for_event(&cs_etm_pmu, 1, evsel);
> 
>              if (arm_spe_pmus && !found_spe)
> 		    found_etm = find_pmu_for_event(arm_spe_pmus, nr_spe, evsel);
> 
>              if (hisi_ptt_pmus && !found_ptt)
> 		    found_ptt = find_pmu_for_event(hisi_ptt_pmus, nr_ptt, evsel);
>      }
> 
>      ...
> 
> Please use a separate patch for the refactoring, and then based on it
> you could add PTT PMU related finding code.
> 
> }
> 

got it, will do this refactoring in next version, thanks.
> 
>>   	free(arm_spe_pmus);
> 
> Add:
> 
>       free(hisi_ptt_pmus);
> 
> to avoid memory leaking.
> 

will fix it, thanks.

>>   
>> -	if (found_etm && found_spe) {
>> -		pr_err("Concurrent ARM Coresight ETM and SPE operation not currently supported\n");
>> +	if (found_etm && found_spe && found_ptt) {
> 
> This logic is not right; actually we want the logic is:
> 
>          int auxtrace_event_cnt = 0;
>          if (found_etm)
>                  auxtrace_event_cnt++;
>          if (found_spe)
>                  auxtrace_event_cnt++;
>          if (found_ptt)
>                  auxtrace_event_cnt++;
> 
>          if (auxtrace_event_cnt > 1) {
>                  pr_err("Concurrent AUX trace operation isn't supported: found etm %d spe %d ptt %d\n",
>                         found_etm, found_spe, found_ptt);
>                  *err = -EOPNOTSUPP;
>                  return NULL;
>          }
> 
got it, will fix it, thanks.
>> +		pr_err("Concurrent ARM Coresight ETM ,SPE and HiSilicon PCIe Trace operation not currently supported\n");
>>   		*err = -EOPNOTSUPP;
>>   		return NULL;
>>   	}
>> @@ -96,6 +163,9 @@ struct auxtrace_record
>>   #if defined(__aarch64__)
>>   	if (found_spe)
>>   		return arm_spe_recording_init(err, found_spe);
>> +
>> +	if (found_ptt)
>> +		return hisi_ptt_recording_init(err, found_ptt);
>>   #endif
>>   
>>   	/*
>> diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
>> index b8b23b9dc598..89a3cedb4557 100644
>> --- a/tools/perf/arch/arm/util/pmu.c
>> +++ b/tools/perf/arch/arm/util/pmu.c
>> @@ -10,6 +10,7 @@
>>   #include <linux/string.h>
>>   
>>   #include "arm-spe.h"
>> +#include "hisi_ptt.h"
>>   #include "../../../util/pmu.h"
>>   
>>   struct perf_event_attr
>> @@ -22,6 +23,8 @@ struct perf_event_attr
>>   #if defined(__aarch64__)
>>   	} else if (strstarts(pmu->name, ARM_SPE_PMU_NAME)) {
>>   		return arm_spe_pmu_default_config(pmu);
>> +	} else if (strstarts(pmu->name, HISI_PTT_PMU_NAME)) {
>> +		pmu->selectable = true;
>>   #endif
>>   	}
>>   
>> diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
>> index 9fcb4e68add9..8b7fd1dc9f37 100644
>> --- a/tools/perf/arch/arm64/util/Build
>> +++ b/tools/perf/arch/arm64/util/Build
>> @@ -11,4 +11,4 @@ perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
[...]
>> +
>> +#define DEFAULT_PAGE_SIZE 1024
> 
> It's a bit confusion to define PAGE_SIZE as 1024.  Here can simply
> define:
> 
> #define KiB(x) ((x) * 1024)
> 
>> +#define KiB(x) ((x) * DEFAULT_PAGE_SIZE)
>> +#define MiB(x) ((x) * DEFAULT_PAGE_SIZE * DEFAULT_PAGE_SIZE)
> 
> 
ok, I'll change it, thanks.
>> +
>> +struct hisi_ptt_recording {
>> +	struct auxtrace_record	itr;
>> +	struct perf_pmu *hisi_ptt_pmu;
>> +	struct evlist *evlist;
>> +};
>> +
[...]
>> +}
>> +
>> +static int hisi_ptt_recording_options(struct auxtrace_record *itr,
>> +				      struct evlist *evlist,
>> +				      struct record_opts *opts)
>> +{
>> +	struct hisi_ptt_recording *pttr =
>> +			container_of(itr, struct hisi_ptt_recording, itr);
>> +	struct perf_pmu *hisi_ptt_pmu = pttr->hisi_ptt_pmu;
>> +	struct perf_cpu_map *cpus = evlist->core.cpus;
>> +	struct evsel *evsel, *hisi_ptt_evsel = NULL;
>> +	struct evsel *tracking_evsel;
>> +	int err;
>> +
>> +	pttr->evlist = evlist;
>> +	evlist__for_each_entry(evlist, evsel) {
>> +		if (evsel->core.attr.type == hisi_ptt_pmu->type) {
>> +			if (hisi_ptt_evsel) {
>> +				pr_err("There may be only one " HISI_PTT_PMU_NAME "x event\n");
>> +				return -EINVAL;
>> +			}
>> +			evsel->core.attr.freq = 0;
>> +			evsel->core.attr.sample_period = 1;
>> +			hisi_ptt_evsel = evsel;
>> +			opts->full_auxtrace = true;
>> +		}
>> +	}
>> +
>> +	err = hisi_ptt_set_auxtrace_mmap_page(opts);
>> +	if (err)
>> +		return err;
>> +	/*
>> +	 * To obtain the auxtrace buffer file descriptor, the auxtrace event
>> +	 * must come first.
>> +	 */
>> +	evlist__to_front(evlist, hisi_ptt_evsel);
>> +
>> +	if (!perf_cpu_map__empty(cpus)) {
>> +		evsel__set_sample_bit(hisi_ptt_evsel, TIME);
>> +		evsel__set_sample_bit(hisi_ptt_evsel, CPU);
> 
> It needs to set CPU bit in sample type for per-cpu mmaps.  IIUC, PTT
> is only used for system wide tracing?  If so, you don't need set CPU
> bit.
>
ok, I'll delete set CPU bit.

> To be honest, I am also confused set the sample bits.  Actually, there
> have two different sample types for AUX trace, one is here set the
> sample type for AUX event, and in PTT decoding code it needs to set
> sample type for synthesized samples.

does "synthesized samples" mean something like spe pmu in perf report? 
such as consolidate multiple pieces of information into one event named 
"llc-miss" "remote-access"?

PTT doesn't need to do this, we just parse message in perf.data and show it.

> 
>> +	}
>> +
>> +	/* Add dummy event to keep tracking */
>> +	err = parse_events(evlist, "dummy:u", NULL);
>> +	if (err)
>> +		return err;
>> +
>> +	tracking_evsel = evlist__last(evlist);
>> +	evlist__set_tracking_event(evlist, tracking_evsel);
>> +
>> +	tracking_evsel->core.attr.freq = 0;
>> +	tracking_evsel->core.attr.sample_period = 1;
>> +
>> +	if (!perf_cpu_map__empty(cpus))
>> +		evsel__set_sample_bit(tracking_evsel, TIME);
>> +
>> +	return 0;

[...]
>> +
>> +enum hisi_ptt_8dw_pkt_field_type {
>> +	HISI_PTT_8DW_PREFIX,
>> +	HISI_PTT_8DW_HEAD0,
>> +	HISI_PTT_8DW_HEAD1,
>> +	HISI_PTT_8DW_HEAD2,
>> +	HISI_PTT_8DW_HEAD3,
>> +	HISI_PTT_8DW_TIME,
>> +	HISI_PTT_8DW_TYPE_MAX
>> +};
>> +
>> +enum hisi_ptt_4dw_pkt_field_type {
>> +	HISI_PTT_4DW_HEAD1,
>> +	HISI_PTT_4DW_HEAD2,
>> +	HISI_PTT_4DW_HEAD3,
>> +	HISI_PTT_4DW_TYPE_MAX
>> +};
>> +
>> +static const char * const hisi_ptt_8dw_pkt_field_name[] = {
>> +	[HISI_PTT_8DW_PREFIX]	= "Prefix",
>> +	[HISI_PTT_8DW_HEAD0]	= "Header DW0",
>> +	[HISI_PTT_8DW_HEAD1]	= "Header DW1",
>> +	[HISI_PTT_8DW_HEAD2]	= "Header DW2",
>> +	[HISI_PTT_8DW_HEAD3]	= "Header DW3",
>> +	[HISI_PTT_8DW_TIME]	= "Time",
>> +};
>> +
>> +static const char * const hisi_ptt_4dw_pkt_field_name[] = {
>> +	[HISI_PTT_4DW_HEAD1]	= "Header DW1",
>> +	[HISI_PTT_4DW_HEAD2]	= "Header DW2",
>> +	[HISI_PTT_4DW_HEAD3]	= "Header DW3",
>> +};
>> +
>> +/* offset of each member is determined by format of 8dw packet. */
>> +static uint32_t hisi_ptt_8dw_pkt_field_offset[] = {
>> +	[HISI_PTT_8DW_PREFIX]	= 4,
>> +	[HISI_PTT_8DW_HEAD0]	= 4,
>> +	[HISI_PTT_8DW_HEAD1]	= 4,
>> +	[HISI_PTT_8DW_HEAD2]	= 4,
>> +	[HISI_PTT_8DW_HEAD3]	= 4,
>> +	[HISI_PTT_8DW_TIME]	= 8,
>> +};
> 
> You could define a structure hisi_ptt_8dw (just like hisi_ptt_4dw) so
> that can avoid to define this field offset structure.
> 
> It's unusal to define data structure for offset, another way is to
> define macros for offset values.
> 
got it, I'll do this.
>> +
>> +union hisi_ptt_4dw {
>> +	struct {
>> +		uint32_t format : 2;
>> +		uint32_t type : 5;
>> +		uint32_t t9 : 1;
>> +		uint32_t t8 : 1;
>> +		uint32_t th : 1;
>> +		uint32_t so : 1;
>> +		uint32_t len : 10;
>> +		uint32_t time : 11;
>> +	};
>> +	uint32_t value;
>> +};
>> +
[...]

>> +
>> +static void hisi_ptt_dump(struct hisi_ptt *ptt __maybe_unused,
>> +			  unsigned char *buf, size_t len)
>> +{
>> +	const char *color = PERF_COLOR_BLUE;
>> +	enum hisi_ptt_pkt_type type;
>> +	size_t pos = 0;
>> +	int pkt_len;
>> +
>> +	color_fprintf(stdout, color, ". ... HISI PTT data: size %zu bytes\n",
>> +		      len);
>> +
>> +	type = hisi_ptt_check_packet_type(buf);
>> +	while (len) {
> 
> It's good to use condition "while (len > 0)".
ok, will change this.

> 
>> +		pkt_len = hisi_ptt_pkt_desc(buf, pos, type);
>> +		if (!pkt_len)
>> +			color_fprintf(stdout, color, " Bad packet!\n");
>> +
>> +		pos += pkt_len;
>> +		buf += pkt_len;
>> +		len -= pkt_len;
>> +	}
>> +}
>> +
[...]

>> diff --git a/tools/perf/util/hisi_ptt.h b/tools/perf/util/hisi_ptt.h
>> new file mode 100644
>> index 000000000000..c0b6cbde1221
>> --- /dev/null
>> +++ b/tools/perf/util/hisi_ptt.h
>> @@ -0,0 +1,28 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * HiSilicon PCIe Trace and Tuning (PTT) support
>> + * Copyright (c) 2022 HiSilicon Technologies Co., Ltd.
>> + */
>> +
>> +#ifndef INCLUDE__PERF_HISI_PTT_H__
>> +#define INCLUDE__PERF_HISI_PTT_H__
>> +
>> +#define HISI_PTT_PMU_NAME "hisi_ptt"
>> +enum {
>> +	HISI_PTT_PMU_TYPE,
>> +	HISI_PTT_PER_CPU_MMAPS,
> 
> HISI_PTT_PER_CPU_MMAPS is not used, so can remove it.
> 
will move this.

Thanks,
Qi
> Thanks,
> Leo
> 
>> +	HISI_PTT_AUXTRACE_PRIV_MAX,
>> +};
>> +
>> +#define HISI_PTT_AUXTRACE_PRIV_SIZE (HISI_PTT_AUXTRACE_PRIV_MAX * sizeof(u64))
>> +union perf_event;
>> +struct perf_session;
>> +struct perf_pmu;
>> +
>> +struct auxtrace_record *hisi_ptt_recording_init(int *err,
>> +						struct perf_pmu *hisi_ptt_pmu);
>> +
>> +int hisi_ptt_process_auxtrace_info(union perf_event *event,
>> +				   struct perf_session *session);
>> +
>> +#endif
>> -- 
>> 2.24.0
>>
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> .
> 
