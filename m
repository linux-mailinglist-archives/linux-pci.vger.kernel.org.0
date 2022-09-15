Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6E95B9369
	for <lists+linux-pci@lfdr.de>; Thu, 15 Sep 2022 05:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiIOD5s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Sep 2022 23:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiIOD5p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2022 23:57:45 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673539320E;
        Wed, 14 Sep 2022 20:57:44 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MSjx40KKZz14QZq;
        Thu, 15 Sep 2022 11:53:44 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 15 Sep 2022 11:57:41 +0800
CC:     <yangyicong@hisilicon.com>, <acme@kernel.org>,
        <peterz@infradead.org>, <alexander.shishkin@linux.intel.com>,
        <james.clark@arm.com>, <will@kernel.org>,
        <mathieu.poirier@linaro.org>, <mark.rutland@arm.com>,
        <suzuki.poulose@arm.com>, <jonathan.cameron@huawei.com>,
        <mike.leach@linaro.org>, <gregkh@linuxfoundation.org>,
        <helgaas@kernel.org>, <lorenzo.pieralisi@arm.com>,
        <shameerali.kolothum.thodi@huawei.com>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <prime.zeng@huawei.com>, <zhangshaokun@hisilicon.com>,
        <linuxarm@huawei.com>, <liuqi6124@gmail.com>
Subject: Re: [RESEND PATCH v12 1/3] perf tool: arm: Refactor event list
 iteration in auxtrace_record__init()
To:     John Garry <john.garry@huawei.com>, Leo Yan <leo.yan@linaro.org>
References: <20220914075925.48549-1-yangyicong@huawei.com>
 <20220914075925.48549-2-yangyicong@huawei.com>
 <c5577971-946e-405b-b0ee-23b556ea3f72@huawei.com>
 <YyHkywZUVPL3GNq8@leoy-yangtze.lan>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <57e19865-6552-f8f1-a443-890c24d1dff4@huawei.com>
Date:   Thu, 15 Sep 2022 11:57:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <YyHkywZUVPL3GNq8@leoy-yangtze.lan>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

On 2022/9/14 22:27, Leo Yan wrote:
> On Wed, Sep 14, 2022 at 02:47:43PM +0100, John Garry wrote:
> 
> [...]
> 
>>>   struct auxtrace_record
>>>   *auxtrace_record__init(struct evlist *evlist, int *err)
>>>   {
>>> -	struct perf_pmu	*cs_etm_pmu;
>>> +	struct perf_pmu	*cs_etm_pmu = NULL;
>>> +	struct perf_pmu **arm_spe_pmus = NULL;
>>>   	struct evsel *evsel;
>>> -	bool found_etm = false;
>>> +	struct perf_pmu *found_etm = NULL;
>>>   	struct perf_pmu *found_spe = NULL;
>>> -	struct perf_pmu **arm_spe_pmus = NULL;
>>> +	int auxtrace_event_cnt = 0;
>>>   	int nr_spes = 0;
>>> -	int i = 0;
>>>   	if (!evlist)
>>>   		return NULL;
>>> @@ -68,24 +84,23 @@ struct auxtrace_record
>>>   	arm_spe_pmus = find_all_arm_spe_pmus(&nr_spes, err);
>>>   	evlist__for_each_entry(evlist, evsel) {
>>> -		if (cs_etm_pmu &&
>>> -		    evsel->core.attr.type == cs_etm_pmu->type)
>>> -			found_etm = true;
>>> -
>>> -		if (!nr_spes || found_spe)
>>> -			continue;
>>> -
>>> -		for (i = 0; i < nr_spes; i++) {
>>> -			if (evsel->core.attr.type == arm_spe_pmus[i]->type) {
>>> -				found_spe = arm_spe_pmus[i];
>>> -				break;
>>> -			}
>>> -		}
>>> +		if (cs_etm_pmu && !found_etm) +			found_etm =
>>> find_pmu_for_event(&cs_etm_pmu, 1, evsel);
>>> +
>>> +		if (arm_spe_pmus && !found_spe)
>>> +			found_spe = find_pmu_for_event(arm_spe_pmus, nr_spes, evsel);
>>
>> should you break if found_etm and found_spe are set? Or, indeed, error and
>> return directly as we do below? Indeed, I am not sure why you even require
>> auxtrace_event_cnt
> 
> I think this was my suggestion :)
> 

yes. thanks :). It's dicussed in v7 and for more information:
https://lore.kernel.org/lkml/20220430073411.GA657977@leoy-ThinkPad-X240s/

> We can check if both 'found_etm' and 'found_spe' are set and directly
> break (and bail out) for this case.  But it would introduce more complex
> checking if we connect with patch 2 with new flag 'found_ptt', something
> like:
> 
>   if ((found_etm && found_spe) ||
>       (found_etm && found_ptt) ||
>       (found_spe && found_ptt))
>       break;
> 
> This is hard for later's extension if we need to support a new auxtrace
> event, so using auxtrace_event_cnt would be easier to extend more
> auxtrace event on Arm platforms.
> 
> Thanks,
> Leo
> 
>>>   	}
>>> +
>>>   	free(arm_spe_pmus);
>>> -	if (found_etm && found_spe) {
>>> -		pr_err("Concurrent ARM Coresight ETM and SPE operation not currently supported\n");
>>> +	if (found_etm)
>>> +		auxtrace_event_cnt++;
>>> +
>>> +	if (found_spe)
>>> +		auxtrace_event_cnt++;
>>> +
>>> +	if (auxtrace_event_cnt > 1) {
>>> +		pr_err("Concurrent AUX trace operation not currently supported\n");
>>>   		*err = -EOPNOTSUPP;
>>>   		return NULL;
>>>   	}
>>
> .
> 
