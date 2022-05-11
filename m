Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7711F522F25
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 11:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbiEKJSN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 05:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238072AbiEKJSK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 05:18:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A5AF201300;
        Wed, 11 May 2022 02:18:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D244A1FB;
        Wed, 11 May 2022 02:18:07 -0700 (PDT)
Received: from [10.57.2.55] (unknown [10.57.2.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B9613F73D;
        Wed, 11 May 2022 02:18:03 -0700 (PDT)
Message-ID: <1b6d1ed3-fdec-3fef-cbf6-735ba5104a94@arm.com>
Date:   Wed, 11 May 2022 10:18:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v7 5/7] perf tool: Add support for HiSilicon PCIe Tune and
 Trace device driver
Content-Language: en-US
To:     "liuqi (BA)" <liuqi115@huawei.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Leo Yan <leo.yan@linaro.org>
Cc:     prime.zeng@huawei.com, zhangshaokun@hisilicon.com,
        linuxarm@huawei.com, gregkh@linuxfoundation.org,
        helgaas@kernel.org, alexander.shishkin@linux.intel.com,
        lorenzo.pieralisi@arm.com, will@kernel.org, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        mike.leach@linaro.org, jonathan.cameron@huawei.com,
        daniel.thompson@linaro.org, joro@8bytes.org, john.garry@huawei.com,
        shameerali.kolothum.thodi@huawei.com, robin.murphy@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org, linux-pci@vger.kernel.org,
        linux-perf-users@vger.kernel.org, iommu@lists.linux-foundation.org
References: <20220407125841.3678-1-yangyicong@hisilicon.com>
 <20220407125841.3678-6-yangyicong@hisilicon.com>
 <ace5aa71-a7f9-cb3a-ee80-b56c71df343b@arm.com>
 <7fe57ed2-c583-1ada-ea5d-324d8de078bc@huawei.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <7fe57ed2-c583-1ada-ea5d-324d8de078bc@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/05/2022 03:02, liuqi (BA) wrote:
> 
> Hi James,
> 
> On 2022/5/10 18:14, James Clark wrote:
>>
>>
>> On 07/04/2022 13:58, Yicong Yang wrote:
>>> From: Qi Liu <liuqi115@huawei.com>
>>>
> [...]
>>>   struct auxtrace_record
>>>   *auxtrace_record__init(struct evlist *evlist, int *err)
>>>   {
>>> @@ -57,8 +112,12 @@ struct auxtrace_record
>>>       struct evsel *evsel;
>>>       bool found_etm = false;
>>>       struct perf_pmu *found_spe = NULL;
>>> +    struct perf_pmu *found_ptt = NULL;
>>>       struct perf_pmu **arm_spe_pmus = NULL;
>>> +    struct perf_pmu **hisi_ptt_pmus = NULL;
>>> +
>>>       int nr_spes = 0;
>>> +    int nr_ptts = 0;
>>>       int i = 0;
>>>         if (!evlist)
>>> @@ -66,13 +125,14 @@ struct auxtrace_record
>>>         cs_etm_pmu = perf_pmu__find(CORESIGHT_ETM_PMU_NAME);
>>>       arm_spe_pmus = find_all_arm_spe_pmus(&nr_spes, err);
>>> +    hisi_ptt_pmus = find_all_hisi_ptt_pmus(&nr_ptts, err);
>>>         evlist__for_each_entry(evlist, evsel) {
>>>           if (cs_etm_pmu &&
>>>               evsel->core.attr.type == cs_etm_pmu->type)
>>>               found_etm = true;
>>>   -        if (!nr_spes || found_spe)
>>> +        if ((!nr_spes || found_spe) && (!nr_ptts || found_ptt))
>>>               continue;
>>>             for (i = 0; i < nr_spes; i++) {
>>> @@ -81,11 +141,18 @@ struct auxtrace_record
>>>                   break;
>>>               }
>>>           }
>>> +
>>> +        for (i = 0; i < nr_ptts; i++) {
>>> +            if (evsel->core.attr.type == hisi_ptt_pmus[i]->type) {
>>> +                found_ptt = hisi_ptt_pmus[i];
>>> +                break;
>>> +            }
>>> +        }
>>>       }
>>>       free(arm_spe_pmus);
>>>   -    if (found_etm && found_spe) {
>>> -        pr_err("Concurrent ARM Coresight ETM and SPE operation not currently supported\n");
>>> +    if (found_etm && found_spe && found_ptt) {
>>> +        pr_err("Concurrent ARM Coresight ETM ,SPE and HiSilicon PCIe Trace operation not currently supported\n");
>>
>> Hi Yicong,
>>
>> Is that actually a limitation? I don't see why they couldn't work concurrently.
> 
> As Leo said, the logic here should be like this:
> 
>         int auxtrace_event_cnt = 0;
>         if (found_etm)
>                 auxtrace_event_cnt++;
>         if (found_spe)
>                 auxtrace_event_cnt++;
>         if (found_ptt)
>                 auxtrace_event_cnt++;
> 
>         if (auxtrace_event_cnt > 1) {
>                 pr_err("Concurrent AUX trace operation isn't supported: found etm %d spe %d ptt %d\n",
>                        found_etm, found_spe, found_ptt);
>                 *err = -EOPNOTSUPP;
>                 return NULL;
>         }
> 
> which means perf doesn't allow more than one auxtrace event recording at the same time.

Oh I see that the limitation is actually in perf when decoding the data. I thought it meant
that it wasn't possible to open multiple aux events at the same time, which I think should
work in theory. Makes sense.

> 
>>
>>
>>>           *err = -EOPNOTSUPP;
>>>           return NULL;
>>>       }
>>> @@ -96,6 +163,9 @@ struct auxtrace_record
>>>   #if defined(__aarch64__)
>>>       if (found_spe)
>>>           return arm_spe_recording_init(err, found_spe);
>>> +
>>> +    if (found_ptt)
>>> +        return hisi_ptt_recording_init(err, found_ptt);
>>>   #endif
>>>         /*
> 
> [...]
>>> +
>>> +static int hisi_ptt_recording_options(struct auxtrace_record *itr,
>>> +                      struct evlist *evlist,
>>> +                      struct record_opts *opts)
>>> +{
>>> +    struct hisi_ptt_recording *pttr =
>>> +            container_of(itr, struct hisi_ptt_recording, itr);
>>> +    struct perf_pmu *hisi_ptt_pmu = pttr->hisi_ptt_pmu;
>>> +    struct perf_cpu_map *cpus = evlist->core.cpus;
>>> +    struct evsel *evsel, *hisi_ptt_evsel = NULL;
>>> +    struct evsel *tracking_evsel;
>>> +    int err;
>>> +
>>> +    pttr->evlist = evlist;
>>> +    evlist__for_each_entry(evlist, evsel) {
>>> +        if (evsel->core.attr.type == hisi_ptt_pmu->type) {
>>> +            if (hisi_ptt_evsel) {
>>> +                pr_err("There may be only one " HISI_PTT_PMU_NAME "x event\n");
>>> +                return -EINVAL;
>>> +            }
>>> +            evsel->core.attr.freq = 0;
>>> +            evsel->core.attr.sample_period = 1;
>>> +            hisi_ptt_evsel = evsel;
>>> +            opts->full_auxtrace = true;
>>> +        }
>>> +    }
>>> +
>>> +    err = hisi_ptt_set_auxtrace_mmap_page(opts);
>>> +    if (err)
>>> +        return err;
>>> +    /*
>>> +     * To obtain the auxtrace buffer file descriptor, the auxtrace event
>>> +     * must come first.
>>> +     */
>>> +    evlist__to_front(evlist, hisi_ptt_evsel);
>>> +
>>> +    if (!perf_cpu_map__empty(cpus)) {
>>> +        evsel__set_sample_bit(hisi_ptt_evsel, TIME);
>>> +        evsel__set_sample_bit(hisi_ptt_evsel, CPU);
>>> +    }
>>
>> Similar to Leo's comment: CPU isn't required if it's uncore,
>> and if TIME is useful then add it regardless of whether the
>> event is opened per-cpu or on a task.
>>
> got it, will fix this next time.
> 
>>> +
>>> +    /* Add dummy event to keep tracking */
>>> +    err = parse_events(evlist, "dummy:u", NULL);
>>> +    if (err)
>>> +        return err;
>>> +
>>> +    tracking_evsel = evlist__last(evlist);
>>> +    evlist__set_tracking_event(evlist, tracking_evsel);
>>> +
>>> +    tracking_evsel->core.attr.freq = 0;
>>> +    tracking_evsel->core.attr.sample_period = 1;
>>> +
>>> +    if (!perf_cpu_map__empty(cpus))
>>> +        evsel__set_sample_bit(tracking_evsel, TIME);
>>
>> Same comment as above.
>>
> got it, thanks.
>>> +
>>> +    return 0;
>>> +}
>>> +
> 
> 
>>> +
>>> +static int hisi_ptt_process_auxtrace_event(struct perf_session *session,
>>> +                       union perf_event *event,
>>> +                       struct perf_tool *tool __maybe_unused)
>>> +{
>>> +    struct hisi_ptt *ptt = container_of(session->auxtrace, struct hisi_ptt,
>>> +                        auxtrace);
>>> +    struct auxtrace_buffer *buffer;
>>> +    off_t data_offset;
>>> +    int fd = perf_data__fd(session->data);
>>> +    int err;
>>> +
>>> +    if (perf_data__is_pipe(session->data)) {
>>> +        data_offset = 0;
>>> +    } else {
>>> +        data_offset = lseek(fd, 0, SEEK_CUR);
>>> +        if (data_offset == -1)
>>> +            return -errno;
>>> +    }
>>> +
>>> +    err = auxtrace_queues__add_event(&ptt->queues, session, event,
>>> +                     data_offset, &buffer);
>>> +    if (err)
>>> +        return err;
>>> +
>>> +    if (dump_trace) {
>>> +        if (auxtrace_buffer__get_data(buffer, fd)) {
>>> +            hisi_ptt_dump_event(ptt, buffer->data, buffer->size);
>>> +            auxtrace_buffer__put_data(buffer);
>>> +        }
>>
>> Technically auxtrace_queues aren't required here because they are more for
>> supporting trace from multiple CPUs and sorting and re-ordering between them.
>>
>> If this is new device is uncore and always from a single source you could
>> just go straight to  hisi_ptt_dump_event() with data_offset and size of the
>> auxtrace event.
>>
>> But I suppose it also doesn't hurt to use some of the existing framework
>> like you have done.
>>
> ok, I'll delete the auxtrace_queues next time, thanks.

It's up to you, it might be more work and it's best to leave it as it is now
that you have it working already.

James

> 
> Qi
> 
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int hisi_ptt_flush(struct perf_session *session __maybe_unused,
>>> +              struct perf_tool *tool __maybe_unused)
>>> +{
>>> +    return 0;
>>> +}
>>> +
>>> +static void hisi_ptt_free_events(struct perf_session *session)
>>> +{
>>> +    struct hisi_ptt *ptt = container_of(session->auxtrace, struct hisi_ptt,
>>> +                        auxtrace);
>>> +    struct auxtrace_queues *queues = &ptt->queues;
>>> +    unsigned int i;
>>> +
>>> +    for (i = 0; i < queues->nr_queues; i++) {
>>> +        free(queues->queue_array[i].priv);
>>> +        queues->queue_array[i].priv = NULL;
>>> +    }
>>> +    auxtrace_queues__free(queues);
>>> +}
>>> +
>>> +static void hisi_ptt_free(struct perf_session *session)
>>> +{
>>> +    struct hisi_ptt *ptt = container_of(session->auxtrace, struct hisi_ptt,
>>> +                        auxtrace);
>>> +
>>> +    hisi_ptt_free_events(session);
>>> +    session->auxtrace = NULL;
>>> +    free(ptt);
>>> +}
>>> +
>>> +static bool hisi_ptt_evsel_is_auxtrace(struct perf_session *session,
>>> +                       struct evsel *evsel)
>>> +{
>>> +    struct hisi_ptt *ptt = container_of(session->auxtrace, struct hisi_ptt, auxtrace);
>>> +
>>> +    return evsel->core.attr.type == ptt->pmu_type;
>>> +}
>>> +
>>> +static const char * const hisi_ptt_info_fmts[] = {
>>> +    [HISI_PTT_PMU_TYPE]        = "  PMU Type           %" PRId64 "\n",
>>> +};
>>> +
>>> +static void hisi_ptt_print_info(__u64 *arr)
>>> +{
>>> +    if (!dump_trace)
>>> +        return;
>>> +
>>> +    fprintf(stdout, hisi_ptt_info_fmts[HISI_PTT_PMU_TYPE], arr[HISI_PTT_PMU_TYPE]);
>>> +}
>>> +
>>> +int hisi_ptt_process_auxtrace_info(union perf_event *event,
>>> +                   struct perf_session *session)
>>> +{
>>> +    struct perf_record_auxtrace_info *auxtrace_info = &event->auxtrace_info;
>>> +    struct hisi_ptt *ptt;
>>> +    int err;
>>> +
>>> +    if (auxtrace_info->header.size < HISI_PTT_AUXTRACE_PRIV_SIZE +
>>> +                sizeof(struct perf_record_auxtrace_info))
>>> +        return -EINVAL;
>>> +
>>> +    ptt = zalloc(sizeof(struct hisi_ptt));
>>> +    if (!ptt)
>>> +        return -ENOMEM;
>>> +
>>> +    err = auxtrace_queues__init(&ptt->queues);
>>> +    if (err)
>>> +        goto err_free;
>>> +
>>> +    ptt->session = session;
>>> +    ptt->machine = &session->machines.host; /* No kvm support */
>>> +    ptt->auxtrace_type = auxtrace_info->type;
>>> +    ptt->pmu_type = auxtrace_info->priv[HISI_PTT_PMU_TYPE];
>>> +
>>> +    ptt->auxtrace.process_event = hisi_ptt_process_event;
>>> +    ptt->auxtrace.process_auxtrace_event = hisi_ptt_process_auxtrace_event;
>>> +    ptt->auxtrace.flush_events = hisi_ptt_flush;
>>> +    ptt->auxtrace.free_events = hisi_ptt_free_events;
>>> +    ptt->auxtrace.free = hisi_ptt_free;
>>> +    ptt->auxtrace.evsel_is_auxtrace = hisi_ptt_evsel_is_auxtrace;
>>> +    session->auxtrace = &ptt->auxtrace;
>>> +
>>> +    hisi_ptt_print_info(&auxtrace_info->priv[0]);
>>> +
>>> +    return 0;
>>> +
>>> +err_free:
>>> +    free(ptt);
>>> +    return err;
>>> +}
>>> diff --git a/tools/perf/util/hisi_ptt.h b/tools/perf/util/hisi_ptt.h
>>> new file mode 100644
>>> index 000000000000..c0b6cbde1221
>>> --- /dev/null
>>> +++ b/tools/perf/util/hisi_ptt.h
>>> @@ -0,0 +1,28 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +/*
>>> + * HiSilicon PCIe Trace and Tuning (PTT) support
>>> + * Copyright (c) 2022 HiSilicon Technologies Co., Ltd.
>>> + */
>>> +
>>> +#ifndef INCLUDE__PERF_HISI_PTT_H__
>>> +#define INCLUDE__PERF_HISI_PTT_H__
>>> +
>>> +#define HISI_PTT_PMU_NAME "hisi_ptt"
>>> +enum {
>>> +    HISI_PTT_PMU_TYPE,
>>> +    HISI_PTT_PER_CPU_MMAPS,
>>> +    HISI_PTT_AUXTRACE_PRIV_MAX,
>>> +};
>>> +
>>> +#define HISI_PTT_AUXTRACE_PRIV_SIZE (HISI_PTT_AUXTRACE_PRIV_MAX * sizeof(u64))
>>> +union perf_event;
>>> +struct perf_session;
>>> +struct perf_pmu;
>>> +
>>> +struct auxtrace_record *hisi_ptt_recording_init(int *err,
>>> +                        struct perf_pmu *hisi_ptt_pmu);
>>> +
>>> +int hisi_ptt_process_auxtrace_info(union perf_event *event,
>>> +                   struct perf_session *session);
>>> +
>>> +#endif
>> .
>>
