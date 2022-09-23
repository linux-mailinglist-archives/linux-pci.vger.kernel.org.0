Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2675A5E78A9
	for <lists+linux-pci@lfdr.de>; Fri, 23 Sep 2022 12:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiIWKti (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Sep 2022 06:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiIWKth (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Sep 2022 06:49:37 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D531214D35;
        Fri, 23 Sep 2022 03:49:32 -0700 (PDT)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MYpkz34x7z67QJq;
        Fri, 23 Sep 2022 18:47:39 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 12:49:29 +0200
Received: from [10.48.153.47] (10.48.153.47) by lhrpeml500003.china.huawei.com
 (7.191.162.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 23 Sep
 2022 11:49:28 +0100
Message-ID: <db2a81dc-18be-6e15-c241-a1a91747d063@huawei.com>
Date:   Fri, 23 Sep 2022 11:49:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v13 2/3] perf tool: Add support for HiSilicon PCIe Tune
 and Trace device driver
To:     Yicong Yang <yangyicong@huawei.com>, <acme@kernel.org>,
        <peterz@infradead.org>, <alexander.shishkin@linux.intel.com>,
        <leo.yan@linaro.org>, <james.clark@arm.com>, <will@kernel.org>,
        <mathieu.poirier@linaro.org>, <mark.rutland@arm.com>,
        <suzuki.poulose@arm.com>, <jonathan.cameron@huawei.com>,
        <mike.leach@linaro.org>
CC:     <gregkh@linuxfoundation.org>, <helgaas@kernel.org>,
        <lorenzo.pieralisi@arm.com>,
        <shameerali.kolothum.thodi@huawei.com>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <prime.zeng@huawei.com>, <zhangshaokun@hisilicon.com>,
        <linuxarm@huawei.com>, <yangyicong@hisilicon.com>,
        <liuqi6124@gmail.com>
References: <20220919090045.6778-1-yangyicong@huawei.com>
 <20220919090045.6778-3-yangyicong@huawei.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220919090045.6778-3-yangyicong@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.153.47]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 19/09/2022 10:00, Yicong Yang wrote:
> From: Qi Liu <liuqi115@huawei.com>
> 
> HiSilicon PCIe tune and trace device (PTT) could dynamically tune
> the PCIe link's events, and trace the TLP headers).
> 
> This patch add support for PTT device in perf tool, so users could
> use 'perf record' to get TLP headers trace data.
> 
> Reviewed-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

I'm not overly fimilar with the auxtrace code, but this patch looks ok 
apart from comments, so acked-by seems more appropiate than reviewed-by:

Acked-by: John Garry <john.garry@huawei.com>

> ---
>   tools/perf/arch/arm/util/auxtrace.c   |  63 +++++++++
>   tools/perf/arch/arm/util/pmu.c        |   3 +
>   tools/perf/arch/arm64/util/Build      |   2 +-
>   tools/perf/arch/arm64/util/hisi-ptt.c | 188 ++++++++++++++++++++++++++
>   tools/perf/util/auxtrace.c            |   1 +
>   tools/perf/util/auxtrace.h            |   1 +
>   tools/perf/util/hisi-ptt.h            |  16 +++
>   7 files changed, 273 insertions(+), 1 deletion(-)
>   create mode 100644 tools/perf/arch/arm64/util/hisi-ptt.c
>   create mode 100644 tools/perf/util/hisi-ptt.h
> 
> diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
> index 384c7cfda0fd..129ed72391a4 100644
> --- a/tools/perf/arch/arm/util/auxtrace.c
> +++ b/tools/perf/arch/arm/util/auxtrace.c
> @@ -4,9 +4,11 @@
>    * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
>    */
>   
> +#include <dirent.h>
>   #include <stdbool.h>
>   #include <linux/coresight-pmu.h>
>   #include <linux/zalloc.h>
> +#include <api/fs/fs.h>
>   
>   #include "../../../util/auxtrace.h"
>   #include "../../../util/debug.h"
> @@ -14,6 +16,7 @@
>   #include "../../../util/pmu.h"
>   #include "cs-etm.h"
>   #include "arm-spe.h"
> +#include "hisi-ptt.h"
>   
>   static struct perf_pmu **find_all_arm_spe_pmus(int *nr_spes, int *err)
>   {
> @@ -50,6 +53,52 @@ static struct perf_pmu **find_all_arm_spe_pmus(int *nr_spes, int *err)
>   	return arm_spe_pmus;
>   }
>   
> +static struct perf_pmu **find_all_hisi_ptt_pmus(int *nr_ptts, int *err)
> +{
> +	const char *sysfs = sysfs__mountpoint();
> +	struct perf_pmu **hisi_ptt_pmus = NULL;
> +	struct dirent *dent;
> +	char path[PATH_MAX];
> +	DIR *dir = NULL;
> +	int idx = 0;
> +
> +	snprintf(path, PATH_MAX, "%s" EVENT_SOURCE_DEVICE_PATH, sysfs);
> +	dir = opendir(path);
> +	if (!dir) {
> +		pr_err("can't read directory '%s'\n", EVENT_SOURCE_DEVICE_PATH);
> +		*err = -EINVAL;
> +		goto out;

Do you really need to call closedir() in this scenario?

> +	}
> +
> +	while ((dent = readdir(dir))) {
> +		if (strstr(dent->d_name, HISI_PTT_PMU_NAME))
> +			(*nr_ptts)++;
> +	}
> +
> +	if (!(*nr_ptts))
> +		goto out;
> +
> +	hisi_ptt_pmus = zalloc(sizeof(struct perf_pmu *) * (*nr_ptts));
> +	if (!hisi_ptt_pmus) {
> +		pr_err("hisi_ptt alloc failed\n");
> +		*err = -ENOMEM;
> +		goto out;
> +	}
> +
> +	rewinddir(dir);
> +	while ((dent = readdir(dir))) {
> +		if (strstr(dent->d_name, HISI_PTT_PMU_NAME) && idx < (*nr_ptts)) {

idx < *nr_ptts

is ok

> +			hisi_ptt_pmus[idx] = perf_pmu__find(dent->d_name);
> +			if (hisi_ptt_pmus[idx])
> +				idx++;
> +		}
> +	}
> +
> +out:
> +	closedir(dir);
> +	return hisi_ptt_pmus;
> +}
> +
>   static struct perf_pmu *find_pmu_for_event(struct perf_pmu **pmus,
>   					   int pmu_nr, struct evsel *evsel)
>   {
> @@ -71,17 +120,21 @@ struct auxtrace_record
>   {
>   	struct perf_pmu	*cs_etm_pmu = NULL;
>   	struct perf_pmu **arm_spe_pmus = NULL;
> +	struct perf_pmu **hisi_ptt_pmus = NULL;
>   	struct evsel *evsel;
>   	struct perf_pmu *found_etm = NULL;
>   	struct perf_pmu *found_spe = NULL;
> +	struct perf_pmu *found_ptt = NULL;
>   	int auxtrace_event_cnt = 0;
>   	int nr_spes = 0;
> +	int nr_ptts = 0;
>   
>   	if (!evlist)
>   		return NULL;
>   
>   	cs_etm_pmu = perf_pmu__find(CORESIGHT_ETM_PMU_NAME);
>   	arm_spe_pmus = find_all_arm_spe_pmus(&nr_spes, err);
> +	hisi_ptt_pmus = find_all_hisi_ptt_pmus(&nr_ptts, err);
>   
>   	evlist__for_each_entry(evlist, evsel) {
>   		if (cs_etm_pmu && !found_etm)
> @@ -89,9 +142,13 @@ struct auxtrace_record
>   
>   		if (arm_spe_pmus && !found_spe)
>   			found_spe = find_pmu_for_event(arm_spe_pmus, nr_spes, evsel);
> +
> +		if (hisi_ptt_pmus && !found_ptt)
> +			found_ptt = find_pmu_for_event(hisi_ptt_pmus, nr_ptts, evsel);
>   	}
>   
>   	free(arm_spe_pmus);
> +	free(hisi_ptt_pmus);
>   
>   	if (found_etm)
>   		auxtrace_event_cnt++;
> @@ -99,6 +156,9 @@ struct auxtrace_record
>   	if (found_spe)
>   		auxtrace_event_cnt++;
>   
> +	if (found_ptt)
> +		auxtrace_event_cnt++;
> +
>   	if (auxtrace_event_cnt > 1) {
>   		pr_err("Concurrent AUX trace operation not currently supported\n");
>   		*err = -EOPNOTSUPP;
> @@ -111,6 +171,9 @@ struct auxtrace_record
>   #if defined(__aarch64__)
>   	if (found_spe)
>   		return arm_spe_recording_init(err, found_spe);
> +
> +	if (found_ptt)
> +		return hisi_ptt_recording_init(err, found_ptt);
>   #endif
>   
>   	/*
> diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
> index b8b23b9dc598..887c8addc491 100644
> --- a/tools/perf/arch/arm/util/pmu.c
> +++ b/tools/perf/arch/arm/util/pmu.c
> @@ -10,6 +10,7 @@
>   #include <linux/string.h>
>   
>   #include "arm-spe.h"
> +#include "hisi-ptt.h"
>   #include "../../../util/pmu.h"
>   
>   struct perf_event_attr
> @@ -22,6 +23,8 @@ struct perf_event_attr
>   #if defined(__aarch64__)
>   	} else if (strstarts(pmu->name, ARM_SPE_PMU_NAME)) {
>   		return arm_spe_pmu_default_config(pmu);
> +	} else if (strstarts(pmu->name, HISI_PTT_PMU_NAME)) {
> +		pmu->selectable = true;
>   #endif
>   	}
>   
> diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
> index 9fcb4e68add9..337aa9bdf905 100644
> --- a/tools/perf/arch/arm64/util/Build
> +++ b/tools/perf/arch/arm64/util/Build
> @@ -11,4 +11,4 @@ perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
>   perf-$(CONFIG_AUXTRACE) += ../../arm/util/pmu.o \
>   			      ../../arm/util/auxtrace.o \
>   			      ../../arm/util/cs-etm.o \
> -			      arm-spe.o mem-events.o
> +			      arm-spe.o mem-events.o hisi-ptt.o
> diff --git a/tools/perf/arch/arm64/util/hisi-ptt.c b/tools/perf/arch/arm64/util/hisi-ptt.c
> new file mode 100644
> index 000000000000..ba97c8a562a0
> --- /dev/null
> +++ b/tools/perf/arch/arm64/util/hisi-ptt.c
> @@ -0,0 +1,188 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * HiSilicon PCIe Trace and Tuning (PTT) support
> + * Copyright (c) 2022 HiSilicon Technologies Co., Ltd.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/bitops.h>
> +#include <linux/log2.h>
> +#include <linux/zalloc.h>
> +#include <time.h>
> +
> +#include <internal/lib.h> // page_size
> +#include "../../../util/auxtrace.h"
> +#include "../../../util/cpumap.h"
> +#include "../../../util/debug.h"
> +#include "../../../util/event.h"
> +#include "../../../util/evlist.h"
> +#include "../../../util/evsel.h"
> +#include "../../../util/hisi-ptt.h"
> +#include "../../../util/pmu.h"
> +#include "../../../util/record.h"
> +#include "../../../util/session.h"
> +#include "../../../util/tsc.h"
> +
> +#define KiB(x) ((x) * 1024)
> +#define MiB(x) ((x) * 1024 * 1024)

surely we have defines for these available elsewhere

> +
> +struct hisi_ptt_recording {
> +	struct auxtrace_record	itr;
> +	struct perf_pmu *hisi_ptt_pmu;
> +	struct evlist *evlist;
> +};
> +
> +static size_t
> +hisi_ptt_info_priv_size(struct auxtrace_record *itr __maybe_unused,
> +			struct evlist *evlist __maybe_unused)
> +{
> +	return HISI_PTT_AUXTRACE_PRIV_SIZE;
> +}
> +
> +static int hisi_ptt_info_fill(struct auxtrace_record *itr,
> +			      struct perf_session *session,
> +			      struct perf_record_auxtrace_info *auxtrace_info,
> +			      size_t priv_size)
> +{
> +	struct hisi_ptt_recording *pttr =
> +			container_of(itr, struct hisi_ptt_recording, itr);
> +	struct perf_pmu *hisi_ptt_pmu = pttr->hisi_ptt_pmu;
> +
> +	if (priv_size != HISI_PTT_AUXTRACE_PRIV_SIZE)
> +		return -EINVAL;
> +
> +	if (!session->evlist->core.nr_mmaps)
> +		return -EINVAL;
> +
> +	auxtrace_info->type = PERF_AUXTRACE_HISI_PTT;
> +	auxtrace_info->priv[0] = hisi_ptt_pmu->type;
> +
> +	return 0;
> +}
> +
> +static int hisi_ptt_set_auxtrace_mmap_page(struct record_opts *opts)
> +{
> +	bool privileged = perf_event_paranoid_check(-1);
> +
> +	if (!opts->full_auxtrace)
> +		return 0;
> +
> +	if (opts->full_auxtrace && !opts->auxtrace_mmap_pages) {
> +		if (privileged) {
> +			opts->auxtrace_mmap_pages = MiB(16) / page_size;
> +		} else {
> +			opts->auxtrace_mmap_pages = KiB(128) / page_size;
> +			if (opts->mmap_pages == UINT_MAX)
> +				opts->mmap_pages = KiB(256) / page_size;
> +		}
> +	}
> +
> +	/* Validate auxtrace_mmap_pages */
> +	if (opts->auxtrace_mmap_pages) {
> +		size_t sz = opts->auxtrace_mmap_pages * (size_t)page_size;
> +		size_t min_sz = KiB(8);
> +
> +		if (sz < min_sz || !is_power_of_2(sz)) {
> +			pr_err("Invalid mmap size for HISI PTT: must be at least %zuKiB and a power of 2\n",
> +			       min_sz / 1024);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int hisi_ptt_recording_options(struct auxtrace_record *itr,
> +				      struct evlist *evlist,
> +				      struct record_opts *opts)
> +{
> +	struct hisi_ptt_recording *pttr =
> +			container_of(itr, struct hisi_ptt_recording, itr);
> +	struct perf_pmu *hisi_ptt_pmu = pttr->hisi_ptt_pmu;
> +	struct evsel *evsel, *hisi_ptt_evsel = NULL;
> +	struct evsel *tracking_evsel;
> +	int err;
> +
> +	pttr->evlist = evlist;
> +	evlist__for_each_entry(evlist, evsel) {
> +		if (evsel->core.attr.type == hisi_ptt_pmu->type) {
> +			if (hisi_ptt_evsel) {
> +				pr_err("There may be only one " HISI_PTT_PMU_NAME "x event\n");
> +				return -EINVAL;
> +			}
> +			evsel->core.attr.freq = 0;
> +			evsel->core.attr.sample_period = 1;
> +			evsel->needs_auxtrace_mmap = true;
> +			hisi_ptt_evsel = evsel;
> +			opts->full_auxtrace = true;
> +		}
> +	}
> +
> +	err = hisi_ptt_set_auxtrace_mmap_page(opts);
> +	if (err)
> +		return err;
> +	/*
> +	 * To obtain the auxtrace buffer file descriptor, the auxtrace event
> +	 * must come first.
> +	 */
> +	evlist__to_front(evlist, hisi_ptt_evsel);
> +	evsel__set_sample_bit(hisi_ptt_evsel, TIME);
> +
> +	/* Add dummy event to keep tracking */
> +	err = parse_event(evlist, "dummy:u");
> +	if (err)
> +		return err;
> +
> +	tracking_evsel = evlist__last(evlist);
> +	evlist__set_tracking_event(evlist, tracking_evsel);
> +
> +	tracking_evsel->core.attr.freq = 0;
> +	tracking_evsel->core.attr.sample_period = 1;
> +	evsel__set_sample_bit(tracking_evsel, TIME);
> +
> +	return 0;
> +}
> +
> +static u64 hisi_ptt_reference(struct auxtrace_record *itr __maybe_unused)
> +{
> +	return rdtsc();
> +}
> +
> +static void hisi_ptt_recording_free(struct auxtrace_record *itr)
> +{
> +	struct hisi_ptt_recording *pttr =
> +			container_of(itr, struct hisi_ptt_recording, itr);
> +
> +	free(pttr);
> +}
> +
> +struct auxtrace_record *hisi_ptt_recording_init(int *err,
> +						struct perf_pmu *hisi_ptt_pmu)
> +{
> +	struct hisi_ptt_recording *pttr;
> +
> +	if (!hisi_ptt_pmu) {
> +		*err = -ENODEV;
> +		return NULL;
> +	}
> +
> +	pttr = zalloc(sizeof(*pttr));
> +	if (!pttr) {
> +		*err = -ENOMEM;
> +		return NULL;
> +	}
> +
> +	pttr->hisi_ptt_pmu = hisi_ptt_pmu;
> +	pttr->itr.pmu = hisi_ptt_pmu;
> +	pttr->itr.recording_options = hisi_ptt_recording_options;
> +	pttr->itr.info_priv_size = hisi_ptt_info_priv_size;
> +	pttr->itr.info_fill = hisi_ptt_info_fill;
> +	pttr->itr.free = hisi_ptt_recording_free;
> +	pttr->itr.reference = hisi_ptt_reference;
> +	pttr->itr.read_finish = auxtrace_record__read_finish;
> +	pttr->itr.alignment = 0;
> +
> +	*err = 0;
> +	return &pttr->itr;
> +}
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index 6edab8a16de6..c30611d9ee99 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -1319,6 +1319,7 @@ int perf_event__process_auxtrace_info(struct perf_session *session,
>   	case PERF_AUXTRACE_S390_CPUMSF:
>   		err = s390_cpumsf_process_auxtrace_info(event, session);
>   		break;
> +	case PERF_AUXTRACE_HISI_PTT:
>   	case PERF_AUXTRACE_UNKNOWN:
>   	default:
>   		return -EINVAL;
> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> index 6a4fbfd34c6b..3a122fc01ccd 100644
> --- a/tools/perf/util/auxtrace.h
> +++ b/tools/perf/util/auxtrace.h
> @@ -48,6 +48,7 @@ enum auxtrace_type {
>   	PERF_AUXTRACE_CS_ETM,
>   	PERF_AUXTRACE_ARM_SPE,
>   	PERF_AUXTRACE_S390_CPUMSF,
> +	PERF_AUXTRACE_HISI_PTT,
>   };
>   
>   enum itrace_period_type {
> diff --git a/tools/perf/util/hisi-ptt.h b/tools/perf/util/hisi-ptt.h

I'm still not a fan of having a header file which is only included by 1x 
.c file, which this seems to be

> new file mode 100644
> index 000000000000..82283c81b4c1
> --- /dev/null
> +++ b/tools/perf/util/hisi-ptt.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * HiSilicon PCIe Trace and Tuning (PTT) support
> + * Copyright (c) 2022 HiSilicon Technologies Co., Ltd.
> + */
> +
> +#ifndef INCLUDE__PERF_HISI_PTT_H__
> +#define INCLUDE__PERF_HISI_PTT_H__
> +
> +#define HISI_PTT_PMU_NAME		"hisi_ptt"
> +#define HISI_PTT_AUXTRACE_PRIV_SIZE	sizeof(u64)
> +
> +struct auxtrace_record *hisi_ptt_recording_init(int *err,
> +						struct perf_pmu *hisi_ptt_pmu);
> +
> +#endif

