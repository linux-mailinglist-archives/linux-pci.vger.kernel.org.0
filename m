Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8177B5296C7
	for <lists+linux-pci@lfdr.de>; Tue, 17 May 2022 03:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiEQBfG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 May 2022 21:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiEQBfG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 May 2022 21:35:06 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B1F45AE7;
        Mon, 16 May 2022 18:35:04 -0700 (PDT)
Received: from kwepemi100019.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L2JYy4SnjzhZBR;
        Tue, 17 May 2022 09:34:14 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 kwepemi100019.china.huawei.com (7.221.188.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 09:35:01 +0800
Received: from [10.67.101.67] (10.67.101.67) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 17 May
 2022 09:35:00 +0800
Subject: Re: [PATCH v8 4/8] perf arm: Refactor event list iteration in
 auxtrace_record__init()
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
 <20220516125223.32012-5-yangyicong@hisilicon.com>
 <20220516151722.0000693a@Huawei.com>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <791a4e66-2e55-c97f-cc05-16032d576121@huawei.com>
Date:   Tue, 17 May 2022 09:35:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220516151722.0000693a@Huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.101.67]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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


Hi Jonathan,
On 2022/5/16 22:17, Jonathan Cameron wrote:
> On Mon, 16 May 2022 20:52:19 +0800
> Yicong Yang <yangyicong@hisilicon.com> wrote:
> 
>> From: Qi Liu <liuqi115@huawei.com>
>>
>> Use find_pmu_for_event() to simplify logic in auxtrace_record__init().
> Possibly reword as
> 
> "Add find_pmu_for_event() and use to simplify logic in
> auxtrace_record_init(). find_pmu_for_event() will be
> reused in subsequent patches."
> 
thanks, I'll modify the commit message next version.

Thanks,
Qi
>>
>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> FWIW as this isn't an area I know much about. It seems
> like a good cleanup and functionally equivalent.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   tools/perf/arch/arm/util/auxtrace.c | 53 ++++++++++++++++++-----------
>>   1 file changed, 34 insertions(+), 19 deletions(-)
>>
>> diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
>> index 5fc6a2a3dbc5..384c7cfda0fd 100644
>> --- a/tools/perf/arch/arm/util/auxtrace.c
>> +++ b/tools/perf/arch/arm/util/auxtrace.c
>> @@ -50,16 +50,32 @@ static struct perf_pmu **find_all_arm_spe_pmus(int *nr_spes, int *err)
>>   	return arm_spe_pmus;
>>   }
>>   
>> +static struct perf_pmu *find_pmu_for_event(struct perf_pmu **pmus,
>> +					   int pmu_nr, struct evsel *evsel)
>> +{
>> +	int i;
>> +
>> +	if (!pmus)
>> +		return NULL;
>> +
>> +	for (i = 0; i < pmu_nr; i++) {
>> +		if (evsel->core.attr.type == pmus[i]->type)
>> +			return pmus[i];
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>>   struct auxtrace_record
>>   *auxtrace_record__init(struct evlist *evlist, int *err)
>>   {
>> -	struct perf_pmu	*cs_etm_pmu;
>> +	struct perf_pmu	*cs_etm_pmu = NULL;
>> +	struct perf_pmu **arm_spe_pmus = NULL;
>>   	struct evsel *evsel;
>> -	bool found_etm = false;
>> +	struct perf_pmu *found_etm = NULL;
>>   	struct perf_pmu *found_spe = NULL;
>> -	struct perf_pmu **arm_spe_pmus = NULL;
>> +	int auxtrace_event_cnt = 0;
>>   	int nr_spes = 0;
>> -	int i = 0;
>>   
>>   	if (!evlist)
>>   		return NULL;
>> @@ -68,24 +84,23 @@ struct auxtrace_record
>>   	arm_spe_pmus = find_all_arm_spe_pmus(&nr_spes, err);
>>   
>>   	evlist__for_each_entry(evlist, evsel) {
>> -		if (cs_etm_pmu &&
>> -		    evsel->core.attr.type == cs_etm_pmu->type)
>> -			found_etm = true;
>> -
>> -		if (!nr_spes || found_spe)
>> -			continue;
>> -
>> -		for (i = 0; i < nr_spes; i++) {
>> -			if (evsel->core.attr.type == arm_spe_pmus[i]->type) {
>> -				found_spe = arm_spe_pmus[i];
>> -				break;
>> -			}
>> -		}
>> +		if (cs_etm_pmu && !found_etm)
>> +			found_etm = find_pmu_for_event(&cs_etm_pmu, 1, evsel);
>> +
>> +		if (arm_spe_pmus && !found_spe)
>> +			found_spe = find_pmu_for_event(arm_spe_pmus, nr_spes, evsel);
>>   	}
>> +
>>   	free(arm_spe_pmus);
>>   
>> -	if (found_etm && found_spe) {
>> -		pr_err("Concurrent ARM Coresight ETM and SPE operation not currently supported\n");
>> +	if (found_etm)
>> +		auxtrace_event_cnt++;
>> +
>> +	if (found_spe)
>> +		auxtrace_event_cnt++;
>> +
>> +	if (auxtrace_event_cnt > 1) {
>> +		pr_err("Concurrent AUX trace operation not currently supported\n");
>>   		*err = -EOPNOTSUPP;
>>   		return NULL;
>>   	}
> 
> .
> 
