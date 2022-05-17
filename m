Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5982D529705
	for <lists+linux-pci@lfdr.de>; Tue, 17 May 2022 03:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238490AbiEQB52 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 May 2022 21:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238216AbiEQB5V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 May 2022 21:57:21 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6238D13F3F;
        Mon, 16 May 2022 18:57:20 -0700 (PDT)
Received: from kwepemi100001.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4L2Jyw5mJqzCsjB;
        Tue, 17 May 2022 09:52:24 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 kwepemi100001.china.huawei.com (7.221.188.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 09:57:18 +0800
Received: from [10.67.101.67] (10.67.101.67) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 17 May
 2022 09:57:17 +0800
Subject: Re: [PATCH v8 5/8] perf tool: Add support for HiSilicon PCIe Tune and
 Trace device driver
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Yicong Yang <yangyicong@hisilicon.com>
CC:     <gregkh@linuxfoundation.org>, <alexander.shishkin@linux.intel.com>,
        <leo.yan@linaro.org>, <james.clark@arm.com>, <will@kernel.org>,
        <robin.murphy@arm.com>, <acme@kernel.org>, <john.garry@huawei.com>,
        <helgaas@kernel.org>, <lorenzo.pieralisi@arm.com>,
        <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mark.rutland@arm.com>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <prime.zeng@huawei.com>,
        <zhangshaokun@hisilicon.com>, <linuxarm@huawei.com>
References: <20220516125223.32012-1-yangyicong@hisilicon.com>
 <20220516125223.32012-6-yangyicong@hisilicon.com>
 <20220516152022.00001ab9@Huawei.com>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <3b952043-53a0-b15e-47bb-e4680c1860c9@huawei.com>
Date:   Tue, 17 May 2022 09:57:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220516152022.00001ab9@Huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.101.67]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2022/5/16 22:20, Jonathan Cameron wrote:
> On Mon, 16 May 2022 20:52:20 +0800
> Yicong Yang <yangyicong@hisilicon.com> wrote:
> 
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
> One query inline.
> 
> 
>> diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
>> index 384c7cfda0fd..297fffedf45e 100644
>> --- a/tools/perf/arch/arm/util/auxtrace.c
>> +++ b/tools/perf/arch/arm/util/auxtrace.c
> 
> ...
> 
>>   static struct perf_pmu *find_pmu_for_event(struct perf_pmu **pmus,
>>   					   int pmu_nr, struct evsel *evsel)
>>   {
>> @@ -71,17 +120,21 @@ struct auxtrace_record
>>   {
>>   	struct perf_pmu	*cs_etm_pmu = NULL;
>>   	struct perf_pmu **arm_spe_pmus = NULL;
>> +	struct perf_pmu **hisi_ptt_pmus = NULL;
>>   	struct evsel *evsel;
>>   	struct perf_pmu *found_etm = NULL;
>>   	struct perf_pmu *found_spe = NULL;
>> +	struct perf_pmu *found_ptt = NULL;
>>   	int auxtrace_event_cnt = 0;
>>   	int nr_spes = 0;
>> +	int nr_ptts = 0;
>>   
>>   	if (!evlist)
>>   		return NULL;
>>   
>>   	cs_etm_pmu = perf_pmu__find(CORESIGHT_ETM_PMU_NAME);
>>   	arm_spe_pmus = find_all_arm_spe_pmus(&nr_spes, err);
>> +	hisi_ptt_pmus = find_all_hisi_ptt_pmus(&nr_ptts, err);
>>   
>>   	evlist__for_each_entry(evlist, evsel) {
>>   		if (cs_etm_pmu && !found_etm)
>> @@ -89,9 +142,13 @@ struct auxtrace_record
>>   
>>   		if (arm_spe_pmus && !found_spe)
>>   			found_spe = find_pmu_for_event(arm_spe_pmus, nr_spes, evsel);
>> +
>> +		if (arm_spe_pmus && !found_spe)
> 
> 		if (hisi_ptt_pmus && !found_ptt) ?
> 
> Otherwise, I'm not sure what the purpose of the checking against spe is.
> 

yes...it's a typo here, thanks for the reminder!

Qi
>> +			found_ptt = find_pmu_for_event(hisi_ptt_pmus, nr_ptts, evsel);
>>   	}
>>   
>>   	free(arm_spe_pmus);
>> +	free(hisi_ptt_pmus);
>>   
>>   	if (found_etm)
>>   		auxtrace_event_cnt++;
>> @@ -99,6 +156,9 @@ struct auxtrace_record
>>   	if (found_spe)
>>   		auxtrace_event_cnt++;
>>   
>> +	if (found_ptt)
>> +		auxtrace_event_cnt++;
>> +
>>   	if (auxtrace_event_cnt > 1) {
>>   		pr_err("Concurrent AUX trace operation not currently supported\n");
>>   		*err = -EOPNOTSUPP;
>> @@ -111,6 +171,9 @@ struct auxtrace_record
>>   #if defined(__aarch64__)
>>   	if (found_spe)
>>   		return arm_spe_recording_init(err, found_spe);
>> +
>> +	if (found_ptt)
>> +		return hisi_ptt_recording_init(err, found_ptt);
>>   #endif
>>   
> .
> 
