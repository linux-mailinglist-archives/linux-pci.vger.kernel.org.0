Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B655211EA
	for <lists+linux-pci@lfdr.de>; Tue, 10 May 2022 12:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236464AbiEJKSW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 May 2022 06:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235377AbiEJKSV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 May 2022 06:18:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A2D3A2AC0C6;
        Tue, 10 May 2022 03:14:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F34D11FB;
        Tue, 10 May 2022 03:14:22 -0700 (PDT)
Received: from [10.57.2.65] (unknown [10.57.2.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0C7F3F66F;
        Tue, 10 May 2022 03:14:17 -0700 (PDT)
Message-ID: <ace5aa71-a7f9-cb3a-ee80-b56c71df343b@arm.com>
Date:   Tue, 10 May 2022 11:14:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v7 5/7] perf tool: Add support for HiSilicon PCIe Tune and
 Trace device driver
Content-Language: en-US
To:     Yicong Yang <yangyicong@hisilicon.com>,
        Leo Yan <leo.yan@linaro.org>
Cc:     prime.zeng@huawei.com, liuqi115@huawei.com,
        zhangshaokun@hisilicon.com, linuxarm@huawei.com,
        gregkh@linuxfoundation.org, helgaas@kernel.org,
        alexander.shishkin@linux.intel.com, lorenzo.pieralisi@arm.com,
        will@kernel.org, mark.rutland@arm.com, mathieu.poirier@linaro.org,
        suzuki.poulose@arm.com, mike.leach@linaro.org, leo.yan@linaro.org,
        jonathan.cameron@huawei.com, daniel.thompson@linaro.org,
        joro@8bytes.org, john.garry@huawei.com,
        shameerali.kolothum.thodi@huawei.com, robin.murphy@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org, linux-pci@vger.kernel.org,
        linux-perf-users@vger.kernel.org, iommu@lists.linux-foundation.org
References: <20220407125841.3678-1-yangyicong@hisilicon.com>
 <20220407125841.3678-6-yangyicong@hisilicon.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20220407125841.3678-6-yangyicong@hisilicon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 07/04/2022 13:58, Yicong Yang wrote:
> From: Qi Liu <liuqi115@huawei.com>
> 
> 'perf record' and 'perf report --dump-raw-trace' supported in this
> patch.
> 
> Example usage:
> 
> Output will contain raw PTT data and its textual representation, such
> as:
> 
> 0 0 0x5810 [0x30]: PERF_RECORD_AUXTRACE size: 0x400000  offset: 0
> ref: 0xa5d50c725  idx: 0  tid: -1  cpu: 0
> .
> . ... HISI PTT data: size 4194304 bytes
> .  00000000: 00 00 00 00                                 Prefix
> .  00000004: 08 20 00 60                                 Header DW0
> .  00000008: ff 02 00 01                                 Header DW1
> .  0000000c: 20 08 00 00                                 Header DW2
> .  00000010: 10 e7 44 ab                                 Header DW3
> .  00000014: 2a a8 1e 01                                 Time
> .  00000020: 00 00 00 00                                 Prefix
> .  00000024: 01 00 00 60                                 Header DW0
> .  00000028: 0f 1e 00 01                                 Header DW1
> .  0000002c: 04 00 00 00                                 Header DW2
> .  00000030: 40 00 81 02                                 Header DW3
> .  00000034: ee 02 00 00                                 Time
> ....
> 
> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  tools/perf/arch/arm/util/auxtrace.c           |  76 +++++-
>  tools/perf/arch/arm/util/pmu.c                |   3 +
>  tools/perf/arch/arm64/util/Build              |   2 +-
>  tools/perf/arch/arm64/util/hisi_ptt.c         | 195 ++++++++++++++++
>  tools/perf/util/Build                         |   2 +
>  tools/perf/util/auxtrace.c                    |   4 +
>  tools/perf/util/auxtrace.h                    |   1 +
>  tools/perf/util/hisi-ptt-decoder/Build        |   1 +
>  .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.c   | 170 ++++++++++++++
>  .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.h   |  28 +++
>  tools/perf/util/hisi_ptt.c                    | 218 ++++++++++++++++++
>  tools/perf/util/hisi_ptt.h                    |  28 +++
>  12 files changed, 724 insertions(+), 4 deletions(-)
>  create mode 100644 tools/perf/arch/arm64/util/hisi_ptt.c
>  create mode 100644 tools/perf/util/hisi-ptt-decoder/Build
>  create mode 100644 tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
>  create mode 100644 tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h
>  create mode 100644 tools/perf/util/hisi_ptt.c
>  create mode 100644 tools/perf/util/hisi_ptt.h
> 
> diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
> index 5fc6a2a3dbc5..393f5757c039 100644
> --- a/tools/perf/arch/arm/util/auxtrace.c
> +++ b/tools/perf/arch/arm/util/auxtrace.c
> @@ -4,9 +4,11 @@
>   * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
>   */
>  
> +#include <dirent.h>
>  #include <stdbool.h>
>  #include <linux/coresight-pmu.h>
>  #include <linux/zalloc.h>
> +#include <api/fs/fs.h>
>  
>  #include "../../../util/auxtrace.h"
>  #include "../../../util/debug.h"
> @@ -14,6 +16,7 @@
>  #include "../../../util/pmu.h"
>  #include "cs-etm.h"
>  #include "arm-spe.h"
> +#include "hisi_ptt.h"
>  
>  static struct perf_pmu **find_all_arm_spe_pmus(int *nr_spes, int *err)
>  {
> @@ -50,6 +53,58 @@ static struct perf_pmu **find_all_arm_spe_pmus(int *nr_spes, int *err)
>  	return arm_spe_pmus;
>  }
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
> +			hisi_ptt_pmus[idx] = perf_pmu__find(dent->d_name);
> +			if (hisi_ptt_pmus[idx]) {
> +				pr_debug2("%s %d: hisi_ptt_pmu %d type %d name %s\n",
> +					__func__, __LINE__, idx,
> +					hisi_ptt_pmus[idx]->type,
> +					hisi_ptt_pmus[idx]->name);
> +					idx++;
> +			}
> +
> +		}
> +	}
> +
> +out:
> +	closedir(dir);
> +	return hisi_ptt_pmus;
> +}
> +
>  struct auxtrace_record
>  *auxtrace_record__init(struct evlist *evlist, int *err)
>  {
> @@ -57,8 +112,12 @@ struct auxtrace_record
>  	struct evsel *evsel;
>  	bool found_etm = false;
>  	struct perf_pmu *found_spe = NULL;
> +	struct perf_pmu *found_ptt = NULL;
>  	struct perf_pmu **arm_spe_pmus = NULL;
> +	struct perf_pmu **hisi_ptt_pmus = NULL;
> +
>  	int nr_spes = 0;
> +	int nr_ptts = 0;
>  	int i = 0;
>  
>  	if (!evlist)
> @@ -66,13 +125,14 @@ struct auxtrace_record
>  
>  	cs_etm_pmu = perf_pmu__find(CORESIGHT_ETM_PMU_NAME);
>  	arm_spe_pmus = find_all_arm_spe_pmus(&nr_spes, err);
> +	hisi_ptt_pmus = find_all_hisi_ptt_pmus(&nr_ptts, err);
>  
>  	evlist__for_each_entry(evlist, evsel) {
>  		if (cs_etm_pmu &&
>  		    evsel->core.attr.type == cs_etm_pmu->type)
>  			found_etm = true;
>  
> -		if (!nr_spes || found_spe)
> +		if ((!nr_spes || found_spe) && (!nr_ptts || found_ptt))
>  			continue;
>  
>  		for (i = 0; i < nr_spes; i++) {
> @@ -81,11 +141,18 @@ struct auxtrace_record
>  				break;
>  			}
>  		}
> +
> +		for (i = 0; i < nr_ptts; i++) {
> +			if (evsel->core.attr.type == hisi_ptt_pmus[i]->type) {
> +				found_ptt = hisi_ptt_pmus[i];
> +				break;
> +			}
> +		}
>  	}
>  	free(arm_spe_pmus);
>  
> -	if (found_etm && found_spe) {
> -		pr_err("Concurrent ARM Coresight ETM and SPE operation not currently supported\n");
> +	if (found_etm && found_spe && found_ptt) {
> +		pr_err("Concurrent ARM Coresight ETM ,SPE and HiSilicon PCIe Trace operation not currently supported\n");

Hi Yicong,

Is that actually a limitation? I don't see why they couldn't work concurrently.


>  		*err = -EOPNOTSUPP;
>  		return NULL;
>  	}
> @@ -96,6 +163,9 @@ struct auxtrace_record
>  #if defined(__aarch64__)
>  	if (found_spe)
>  		return arm_spe_recording_init(err, found_spe);
> +
> +	if (found_ptt)
> +		return hisi_ptt_recording_init(err, found_ptt);
>  #endif
>  
>  	/*
> diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
> index b8b23b9dc598..89a3cedb4557 100644
> --- a/tools/perf/arch/arm/util/pmu.c
> +++ b/tools/perf/arch/arm/util/pmu.c
> @@ -10,6 +10,7 @@
>  #include <linux/string.h>
>  
>  #include "arm-spe.h"
> +#include "hisi_ptt.h"
>  #include "../../../util/pmu.h"
>  
>  struct perf_event_attr
> @@ -22,6 +23,8 @@ struct perf_event_attr
>  #if defined(__aarch64__)
>  	} else if (strstarts(pmu->name, ARM_SPE_PMU_NAME)) {
>  		return arm_spe_pmu_default_config(pmu);
> +	} else if (strstarts(pmu->name, HISI_PTT_PMU_NAME)) {
> +		pmu->selectable = true;
>  #endif
>  	}
>  
> diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
> index 9fcb4e68add9..8b7fd1dc9f37 100644
> --- a/tools/perf/arch/arm64/util/Build
> +++ b/tools/perf/arch/arm64/util/Build
> @@ -11,4 +11,4 @@ perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
>  perf-$(CONFIG_AUXTRACE) += ../../arm/util/pmu.o \
>  			      ../../arm/util/auxtrace.o \
>  			      ../../arm/util/cs-etm.o \
> -			      arm-spe.o mem-events.o
> +			      arm-spe.o mem-events.o hisi_ptt.o
> diff --git a/tools/perf/arch/arm64/util/hisi_ptt.c b/tools/perf/arch/arm64/util/hisi_ptt.c
> new file mode 100644
> index 000000000000..de3a3523ffd5
> --- /dev/null
> +++ b/tools/perf/arch/arm64/util/hisi_ptt.c
> @@ -0,0 +1,195 @@
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
> +#include "../../../util/hisi_ptt.h"
> +#include "../../../util/pmu.h"
> +#include "../../../util/record.h"
> +#include "../../../util/session.h"
> +#include "../../../util/tsc.h"
> +
> +#define DEFAULT_PAGE_SIZE 1024
> +#define KiB(x) ((x) * DEFAULT_PAGE_SIZE)
> +#define MiB(x) ((x) * DEFAULT_PAGE_SIZE * DEFAULT_PAGE_SIZE)
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
> +	auxtrace_info->priv[HISI_PTT_PMU_TYPE] = hisi_ptt_pmu->type;
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
> +			       min_sz / DEFAULT_PAGE_SIZE);
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
> +	struct perf_cpu_map *cpus = evlist->core.cpus;
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
> +
> +	if (!perf_cpu_map__empty(cpus)) {
> +		evsel__set_sample_bit(hisi_ptt_evsel, TIME);
> +		evsel__set_sample_bit(hisi_ptt_evsel, CPU);
> +	}

Similar to Leo's comment: CPU isn't required if it's uncore,
and if TIME is useful then add it regardless of whether the
event is opened per-cpu or on a task.

> +
> +	/* Add dummy event to keep tracking */
> +	err = parse_events(evlist, "dummy:u", NULL);
> +	if (err)
> +		return err;
> +
> +	tracking_evsel = evlist__last(evlist);
> +	evlist__set_tracking_event(evlist, tracking_evsel);
> +
> +	tracking_evsel->core.attr.freq = 0;
> +	tracking_evsel->core.attr.sample_period = 1;
> +
> +	if (!perf_cpu_map__empty(cpus))
> +		evsel__set_sample_bit(tracking_evsel, TIME);

Same comment as above.

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
> +	pttr = zalloc(sizeof(struct hisi_ptt_recording));
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
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 9a7209a99e16..95d2d76c52da 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -116,6 +116,8 @@ perf-$(CONFIG_AUXTRACE) += intel-pt.o
>  perf-$(CONFIG_AUXTRACE) += intel-bts.o
>  perf-$(CONFIG_AUXTRACE) += arm-spe.o
>  perf-$(CONFIG_AUXTRACE) += arm-spe-decoder/
> +perf-$(CONFIG_AUXTRACE) += hisi_ptt.o
> +perf-$(CONFIG_AUXTRACE) += hisi-ptt-decoder/
>  perf-$(CONFIG_AUXTRACE) += s390-cpumsf.o
>  
>  ifdef CONFIG_LIBOPENCSD
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index df1c5bbbaa0d..f4841ebaf314 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -51,6 +51,7 @@
>  #include "intel-pt.h"
>  #include "intel-bts.h"
>  #include "arm-spe.h"
> +#include "hisi_ptt.h"
>  #include "s390-cpumsf.h"
>  #include "util/mmap.h"
>  
> @@ -1281,6 +1282,9 @@ int perf_event__process_auxtrace_info(struct perf_session *session,
>  	case PERF_AUXTRACE_S390_CPUMSF:
>  		err = s390_cpumsf_process_auxtrace_info(event, session);
>  		break;
> +	case PERF_AUXTRACE_HISI_PTT:
> +		err = hisi_ptt_process_auxtrace_info(event, session);
> +		break;
>  	case PERF_AUXTRACE_UNKNOWN:
>  	default:
>  		return -EINVAL;
> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> index dc38b6f57232..3858c5752ead 100644
> --- a/tools/perf/util/auxtrace.h
> +++ b/tools/perf/util/auxtrace.h
> @@ -48,6 +48,7 @@ enum auxtrace_type {
>  	PERF_AUXTRACE_CS_ETM,
>  	PERF_AUXTRACE_ARM_SPE,
>  	PERF_AUXTRACE_S390_CPUMSF,
> +	PERF_AUXTRACE_HISI_PTT,
>  };
>  
>  enum itrace_period_type {
> diff --git a/tools/perf/util/hisi-ptt-decoder/Build b/tools/perf/util/hisi-ptt-decoder/Build
> new file mode 100644
> index 000000000000..db3db8b75033
> --- /dev/null
> +++ b/tools/perf/util/hisi-ptt-decoder/Build
> @@ -0,0 +1 @@
> +perf-$(CONFIG_AUXTRACE) += hisi-ptt-pkt-decoder.o
> diff --git a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
> new file mode 100644
> index 000000000000..3fb7a6949209
> --- /dev/null
> +++ b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
> @@ -0,0 +1,170 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * HiSilicon PCIe Trace and Tuning (PTT) support
> + * Copyright (c) 2022 HiSilicon Technologies Co., Ltd.
> + */
> +
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <endian.h>
> +#include <byteswap.h>
> +#include <linux/bitops.h>
> +#include <stdarg.h>
> +
> +#include "../color.h"
> +#include "hisi-ptt-pkt-decoder.h"
> +
> +/*
> + * For 8DW format, the bit[31:11] of DW0 is always 0x1fffff, which can be
> + * used to distinguish the data format.
> + * 8DW format is like:
> + *   bits [                 31:11                 ][       10:0       ]
> + *        |---------------------------------------|-------------------|
> + *    DW0 [                0x1fffff               ][ Reserved (0x7ff) ]
> + *    DW1 [                       Prefix                              ]
> + *    DW2 [                     Header DW0                            ]
> + *    DW3 [                     Header DW1                            ]
> + *    DW4 [                     Header DW2                            ]
> + *    DW5 [                     Header DW3                            ]
> + *    DW6 [                   Reserved (0x0)                          ]
> + *    DW7 [                        Time                               ]
> + *
> + * 4DW format is like:
> + *   bits [31:30] [ 29:25 ][24][23][22][21][    20:11   ][    10:0    ]
> + *        |-----|---------|---|---|---|---|-------------|-------------|
> + *    DW0 [ Fmt ][  Type  ][T9][T8][TH][SO][   Length   ][    Time    ]
> + *    DW1 [                     Header DW1                            ]
> + *    DW2 [                     Header DW2                            ]
> + *    DW3 [                     Header DW3                            ]
> + */
> +
> +enum hisi_ptt_8dw_pkt_field_type {
> +	HISI_PTT_8DW_PREFIX,
> +	HISI_PTT_8DW_HEAD0,
> +	HISI_PTT_8DW_HEAD1,
> +	HISI_PTT_8DW_HEAD2,
> +	HISI_PTT_8DW_HEAD3,
> +	HISI_PTT_8DW_TIME,
> +	HISI_PTT_8DW_TYPE_MAX
> +};
> +
> +enum hisi_ptt_4dw_pkt_field_type {
> +	HISI_PTT_4DW_HEAD1,
> +	HISI_PTT_4DW_HEAD2,
> +	HISI_PTT_4DW_HEAD3,
> +	HISI_PTT_4DW_TYPE_MAX
> +};
> +
> +static const char * const hisi_ptt_8dw_pkt_field_name[] = {
> +	[HISI_PTT_8DW_PREFIX]	= "Prefix",
> +	[HISI_PTT_8DW_HEAD0]	= "Header DW0",
> +	[HISI_PTT_8DW_HEAD1]	= "Header DW1",
> +	[HISI_PTT_8DW_HEAD2]	= "Header DW2",
> +	[HISI_PTT_8DW_HEAD3]	= "Header DW3",
> +	[HISI_PTT_8DW_TIME]	= "Time",
> +};
> +
> +static const char * const hisi_ptt_4dw_pkt_field_name[] = {
> +	[HISI_PTT_4DW_HEAD1]	= "Header DW1",
> +	[HISI_PTT_4DW_HEAD2]	= "Header DW2",
> +	[HISI_PTT_4DW_HEAD3]	= "Header DW3",
> +};
> +
> +/* offset of each member is determined by format of 8dw packet. */
> +static uint32_t hisi_ptt_8dw_pkt_field_offset[] = {
> +	[HISI_PTT_8DW_PREFIX]	= 4,
> +	[HISI_PTT_8DW_HEAD0]	= 4,
> +	[HISI_PTT_8DW_HEAD1]	= 4,
> +	[HISI_PTT_8DW_HEAD2]	= 4,
> +	[HISI_PTT_8DW_HEAD3]	= 4,
> +	[HISI_PTT_8DW_TIME]	= 8,
> +};
> +
> +union hisi_ptt_4dw {
> +	struct {
> +		uint32_t format : 2;
> +		uint32_t type : 5;
> +		uint32_t t9 : 1;
> +		uint32_t t8 : 1;
> +		uint32_t th : 1;
> +		uint32_t so : 1;
> +		uint32_t len : 10;
> +		uint32_t time : 11;
> +	};
> +	uint32_t value;
> +};
> +
> +static void hisi_ptt_print_pkt(const unsigned char *buf, int *pos, const char *desc)
> +{
> +	const char *color = PERF_COLOR_BLUE;
> +	int field_len = sizeof(uint32_t);
> +	int i;
> +
> +	printf(".");
> +	color_fprintf(stdout, color, "  %08x: ", *pos);
> +	for (i = 0; i < field_len; i++)
> +		color_fprintf(stdout, color, "%02x ", buf[i]);
> +	for (i = 0; i < HISI_PTT_MAX_SPACE_LEN; i++)
> +		color_fprintf(stdout, color, "   ");
> +	color_fprintf(stdout, color, "  %s\n", desc);
> +	*pos += field_len;
> +}
> +
> +static int hisi_ptt_8dw_kpt_desc(const unsigned char *buf, int pos)
> +{
> +	int i;
> +
> +	for (i = HISI_PTT_8DW_PREFIX; i < HISI_PTT_8DW_TYPE_MAX; i++) {
> +		buf += hisi_ptt_8dw_pkt_field_offset[i];
> +		hisi_ptt_print_pkt(buf, &pos, hisi_ptt_8dw_pkt_field_name[i]);
> +	}
> +
> +	return HISI_PTT_8DW_PKT_SIZE;
> +}
> +
> +static void hisi_ptt_4dw_print_dw0(const unsigned char *buf, int *pos)
> +{
> +	const char *color = PERF_COLOR_BLUE;
> +	int field_len = sizeof(uint32_t);
> +	union hisi_ptt_4dw dw0;
> +	int i;
> +
> +	dw0.value = *(uint32_t *)buf;
> +	printf(".");
> +	color_fprintf(stdout, color, "  %08x: ", *pos);
> +	for (i = 0; i < field_len; i++)
> +		color_fprintf(stdout, color, "%02x ", buf[i]);
> +	for (i = 0; i < HISI_PTT_MAX_SPACE_LEN; i++)
> +		color_fprintf(stdout, color, "   ");
> +
> +	color_fprintf(stdout, color,
> +		      "  %s %x %s %x %s %x %s %x %s %x %s %x %s %x %s %x\n",
> +		      "Format", dw0.format, "Type", dw0.type, "T9", dw0.t9,
> +		      "T8", dw0.t8, "TH", dw0.th, "SO", dw0.so, "Length",
> +		      dw0.len, "Time", dw0.time);
> +
> +	*pos += field_len;
> +}
> +
> +static int hisi_ptt_4dw_kpt_desc(const unsigned char *buf, int pos)
> +{
> +	int i;
> +
> +	hisi_ptt_4dw_print_dw0(buf, &pos);
> +
> +	for (i = HISI_PTT_4DW_HEAD1; i < HISI_PTT_4DW_TYPE_MAX; i++) {
> +		buf += sizeof(uint32_t);
> +		hisi_ptt_print_pkt(buf, &pos, hisi_ptt_4dw_pkt_field_name[i]);
> +	}
> +
> +	return HISI_PTT_4DW_PKT_SIZE;
> +}
> +
> +int hisi_ptt_pkt_desc(const unsigned char *buf, int pos, enum hisi_ptt_pkt_type type)
> +{
> +	if (type == HISI_PTT_8DW_PKT)
> +		return hisi_ptt_8dw_kpt_desc(buf, pos);
> +
> +	return hisi_ptt_4dw_kpt_desc(buf, pos);
> +}
> diff --git a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h
> new file mode 100644
> index 000000000000..20c51f230cac
> --- /dev/null
> +++ b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * HiSilicon PCIe Trace and Tuning (PTT) support
> + * Copyright (c) 2022 HiSilicon Technologies Co., Ltd.
> + */
> +
> +#ifndef INCLUDE__HISI_PTT_PKT_DECODER_H__
> +#define INCLUDE__HISI_PTT_PKT_DECODER_H__
> +
> +#include <stddef.h>
> +#include <stdint.h>
> +
> +#define HISI_PTT_PKT_DESC_MAX		256
> +#define HISI_PTT_NEED_MORE_BYTES	-1
> +#define HISI_PTT_8DW_CHECK_MASK		GENMASK(31, 11)
> +#define HISI_PTT_IS_8DW_PKT		GENMASK(31, 11)
> +#define HISI_PTT_8DW_PKT_SIZE		32
> +#define HISI_PTT_4DW_PKT_SIZE		16
> +#define HISI_PTT_MAX_SPACE_LEN		10
> +
> +enum hisi_ptt_pkt_type {
> +	HISI_PTT_4DW_PKT,
> +	HISI_PTT_8DW_PKT,
> +};
> +
> +int hisi_ptt_pkt_desc(const unsigned char *buf, int pos, enum hisi_ptt_pkt_type type);
> +
> +#endif
> diff --git a/tools/perf/util/hisi_ptt.c b/tools/perf/util/hisi_ptt.c
> new file mode 100644
> index 000000000000..e2934214763c
> --- /dev/null
> +++ b/tools/perf/util/hisi_ptt.c
> @@ -0,0 +1,218 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * HiSilicon PCIe Trace and Tuning (PTT) support
> + * Copyright (c) 2022 HiSilicon Technologies Co., Ltd.
> + */
> +
> +#include <byteswap.h>
> +#include <endian.h>
> +#include <errno.h>
> +#include <inttypes.h>
> +#include <linux/bitops.h>
> +#include <linux/kernel.h>
> +#include <linux/log2.h>
> +#include <linux/types.h>
> +#include <linux/zalloc.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +
> +#include "auxtrace.h"
> +#include "color.h"
> +#include "debug.h"
> +#include "evlist.h"
> +#include "evsel.h"
> +#include "hisi_ptt.h"
> +#include "hisi-ptt-decoder/hisi-ptt-pkt-decoder.h"
> +#include "machine.h"
> +#include "session.h"
> +#include "symbol.h"
> +#include "tool.h"
> +#include "util/synthetic-events.h"
> +
> +struct hisi_ptt {
> +	struct auxtrace auxtrace;
> +	struct auxtrace_queues queues;
> +	u32 auxtrace_type;
> +	struct perf_session *session;
> +	struct machine *machine;
> +	u32 pmu_type;
> +};
> +
> +struct hisi_ptt_queue {
> +	struct hisi_ptt *ptt;
> +	struct auxtrace_buffer *buffer;
> +};
> +
> +static enum hisi_ptt_pkt_type hisi_ptt_check_packet_type(unsigned char *buf)
> +{
> +	uint32_t head = *(uint32_t *)buf;
> +
> +	if ((HISI_PTT_8DW_CHECK_MASK & head) == HISI_PTT_IS_8DW_PKT)
> +		return HISI_PTT_8DW_PKT;
> +
> +	return HISI_PTT_4DW_PKT;
> +}
> +
> +static void hisi_ptt_dump(struct hisi_ptt *ptt __maybe_unused,
> +			  unsigned char *buf, size_t len)
> +{
> +	const char *color = PERF_COLOR_BLUE;
> +	enum hisi_ptt_pkt_type type;
> +	size_t pos = 0;
> +	int pkt_len;
> +
> +	color_fprintf(stdout, color, ". ... HISI PTT data: size %zu bytes\n",
> +		      len);
> +
> +	type = hisi_ptt_check_packet_type(buf);
> +	while (len) {
> +		pkt_len = hisi_ptt_pkt_desc(buf, pos, type);
> +		if (!pkt_len)
> +			color_fprintf(stdout, color, " Bad packet!\n");
> +
> +		pos += pkt_len;
> +		buf += pkt_len;
> +		len -= pkt_len;
> +	}
> +}
> +
> +static void hisi_ptt_dump_event(struct hisi_ptt *ptt, unsigned char *buf,
> +				size_t len)
> +{
> +	printf(".\n");
> +
> +	hisi_ptt_dump(ptt, buf, len);
> +}
> +
> +static int hisi_ptt_process_event(struct perf_session *session __maybe_unused,
> +				  union perf_event *event __maybe_unused,
> +				  struct perf_sample *sample __maybe_unused,
> +				  struct perf_tool *tool __maybe_unused)
> +{
> +	return 0;
> +}
> +
> +static int hisi_ptt_process_auxtrace_event(struct perf_session *session,
> +					   union perf_event *event,
> +					   struct perf_tool *tool __maybe_unused)
> +{
> +	struct hisi_ptt *ptt = container_of(session->auxtrace, struct hisi_ptt,
> +					    auxtrace);
> +	struct auxtrace_buffer *buffer;
> +	off_t data_offset;
> +	int fd = perf_data__fd(session->data);
> +	int err;
> +
> +	if (perf_data__is_pipe(session->data)) {
> +		data_offset = 0;
> +	} else {
> +		data_offset = lseek(fd, 0, SEEK_CUR);
> +		if (data_offset == -1)
> +			return -errno;
> +	}
> +
> +	err = auxtrace_queues__add_event(&ptt->queues, session, event,
> +					 data_offset, &buffer);
> +	if (err)
> +		return err;
> +
> +	if (dump_trace) {
> +		if (auxtrace_buffer__get_data(buffer, fd)) {
> +			hisi_ptt_dump_event(ptt, buffer->data, buffer->size);
> +			auxtrace_buffer__put_data(buffer);
> +		}

Technically auxtrace_queues aren't required here because they are more for
supporting trace from multiple CPUs and sorting and re-ordering between them.

If this is new device is uncore and always from a single source you could
just go straight to  hisi_ptt_dump_event() with data_offset and size of the
auxtrace event.

But I suppose it also doesn't hurt to use some of the existing framework
like you have done.

> +	}
> +
> +	return 0;
> +}
> +
> +static int hisi_ptt_flush(struct perf_session *session __maybe_unused,
> +			  struct perf_tool *tool __maybe_unused)
> +{
> +	return 0;
> +}
> +
> +static void hisi_ptt_free_events(struct perf_session *session)
> +{
> +	struct hisi_ptt *ptt = container_of(session->auxtrace, struct hisi_ptt,
> +					    auxtrace);
> +	struct auxtrace_queues *queues = &ptt->queues;
> +	unsigned int i;
> +
> +	for (i = 0; i < queues->nr_queues; i++) {
> +		free(queues->queue_array[i].priv);
> +		queues->queue_array[i].priv = NULL;
> +	}
> +	auxtrace_queues__free(queues);
> +}
> +
> +static void hisi_ptt_free(struct perf_session *session)
> +{
> +	struct hisi_ptt *ptt = container_of(session->auxtrace, struct hisi_ptt,
> +					    auxtrace);
> +
> +	hisi_ptt_free_events(session);
> +	session->auxtrace = NULL;
> +	free(ptt);
> +}
> +
> +static bool hisi_ptt_evsel_is_auxtrace(struct perf_session *session,
> +				       struct evsel *evsel)
> +{
> +	struct hisi_ptt *ptt = container_of(session->auxtrace, struct hisi_ptt, auxtrace);
> +
> +	return evsel->core.attr.type == ptt->pmu_type;
> +}
> +
> +static const char * const hisi_ptt_info_fmts[] = {
> +	[HISI_PTT_PMU_TYPE]		= "  PMU Type           %" PRId64 "\n",
> +};
> +
> +static void hisi_ptt_print_info(__u64 *arr)
> +{
> +	if (!dump_trace)
> +		return;
> +
> +	fprintf(stdout, hisi_ptt_info_fmts[HISI_PTT_PMU_TYPE], arr[HISI_PTT_PMU_TYPE]);
> +}
> +
> +int hisi_ptt_process_auxtrace_info(union perf_event *event,
> +				   struct perf_session *session)
> +{
> +	struct perf_record_auxtrace_info *auxtrace_info = &event->auxtrace_info;
> +	struct hisi_ptt *ptt;
> +	int err;
> +
> +	if (auxtrace_info->header.size < HISI_PTT_AUXTRACE_PRIV_SIZE +
> +				sizeof(struct perf_record_auxtrace_info))
> +		return -EINVAL;
> +
> +	ptt = zalloc(sizeof(struct hisi_ptt));
> +	if (!ptt)
> +		return -ENOMEM;
> +
> +	err = auxtrace_queues__init(&ptt->queues);
> +	if (err)
> +		goto err_free;
> +
> +	ptt->session = session;
> +	ptt->machine = &session->machines.host; /* No kvm support */
> +	ptt->auxtrace_type = auxtrace_info->type;
> +	ptt->pmu_type = auxtrace_info->priv[HISI_PTT_PMU_TYPE];
> +
> +	ptt->auxtrace.process_event = hisi_ptt_process_event;
> +	ptt->auxtrace.process_auxtrace_event = hisi_ptt_process_auxtrace_event;
> +	ptt->auxtrace.flush_events = hisi_ptt_flush;
> +	ptt->auxtrace.free_events = hisi_ptt_free_events;
> +	ptt->auxtrace.free = hisi_ptt_free;
> +	ptt->auxtrace.evsel_is_auxtrace = hisi_ptt_evsel_is_auxtrace;
> +	session->auxtrace = &ptt->auxtrace;
> +
> +	hisi_ptt_print_info(&auxtrace_info->priv[0]);
> +
> +	return 0;
> +
> +err_free:
> +	free(ptt);
> +	return err;
> +}
> diff --git a/tools/perf/util/hisi_ptt.h b/tools/perf/util/hisi_ptt.h
> new file mode 100644
> index 000000000000..c0b6cbde1221
> --- /dev/null
> +++ b/tools/perf/util/hisi_ptt.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * HiSilicon PCIe Trace and Tuning (PTT) support
> + * Copyright (c) 2022 HiSilicon Technologies Co., Ltd.
> + */
> +
> +#ifndef INCLUDE__PERF_HISI_PTT_H__
> +#define INCLUDE__PERF_HISI_PTT_H__
> +
> +#define HISI_PTT_PMU_NAME "hisi_ptt"
> +enum {
> +	HISI_PTT_PMU_TYPE,
> +	HISI_PTT_PER_CPU_MMAPS,
> +	HISI_PTT_AUXTRACE_PRIV_MAX,
> +};
> +
> +#define HISI_PTT_AUXTRACE_PRIV_SIZE (HISI_PTT_AUXTRACE_PRIV_MAX * sizeof(u64))
> +union perf_event;
> +struct perf_session;
> +struct perf_pmu;
> +
> +struct auxtrace_record *hisi_ptt_recording_init(int *err,
> +						struct perf_pmu *hisi_ptt_pmu);
> +
> +int hisi_ptt_process_auxtrace_info(union perf_event *event,
> +				   struct perf_session *session);
> +
> +#endif
