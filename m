Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32F5528A5D
	for <lists+linux-pci@lfdr.de>; Mon, 16 May 2022 18:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343614AbiEPQ3K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 May 2022 12:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343628AbiEPQ3J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 May 2022 12:29:09 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951403B012;
        Mon, 16 May 2022 09:29:08 -0700 (PDT)
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L24PV63Xzz67h1V;
        Tue, 17 May 2022 00:26:06 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 16 May 2022 18:29:06 +0200
Received: from [10.47.25.151] (10.47.25.151) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 16 May
 2022 17:29:05 +0100
Message-ID: <d874dd82-30fd-f8e0-b7ab-0c9d14e47324@huawei.com>
Date:   Mon, 16 May 2022 17:29:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v8 4/8] perf arm: Refactor event list iteration in
 auxtrace_record__init()
To:     Yicong Yang <yangyicong@hisilicon.com>,
        <gregkh@linuxfoundation.org>, <alexander.shishkin@linux.intel.com>,
        <leo.yan@linaro.org>, <james.clark@arm.com>, <will@kernel.org>,
        <robin.murphy@arm.com>, <acme@kernel.org>,
        <jonathan.cameron@huawei.com>
CC:     <helgaas@kernel.org>, <lorenzo.pieralisi@arm.com>,
        <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mark.rutland@arm.com>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <prime.zeng@huawei.com>,
        <liuqi115@huawei.com>, <zhangshaokun@hisilicon.com>,
        <linuxarm@huawei.com>
References: <20220516125223.32012-1-yangyicong@hisilicon.com>
 <20220516125223.32012-5-yangyicong@hisilicon.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220516125223.32012-5-yangyicong@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.25.151]
X-ClientProxiedBy: lhreml714-chm.china.huawei.com (10.201.108.65) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 16/05/2022 13:52, Yicong Yang wrote:

As requested before, please mention "perf tool" in the commit subject

> From: Qi Liu <liuqi115@huawei.com>
> 
> Use find_pmu_for_event() to simplify logic in auxtrace_record__init().
> 
> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>   tools/perf/arch/arm/util/auxtrace.c | 53 ++++++++++++++++++-----------
>   1 file changed, 34 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
> index 5fc6a2a3dbc5..384c7cfda0fd 100644
> --- a/tools/perf/arch/arm/util/auxtrace.c
> +++ b/tools/perf/arch/arm/util/auxtrace.c
> @@ -50,16 +50,32 @@ static struct perf_pmu **find_all_arm_spe_pmus(int *nr_spes, int *err)
>   	return arm_spe_pmus;
>   }
>   
> +static struct perf_pmu *find_pmu_for_event(struct perf_pmu **pmus,
> +					   int pmu_nr, struct evsel *evsel)
> +{
> +	int i;
> +
> +	if (!pmus)
> +		return NULL;
> +
> +	for (i = 0; i < pmu_nr; i++) {
> +		if (evsel->core.attr.type == pmus[i]->type)
> +			return pmus[i];
> +	}
> +
> +	return NULL;
> +}
> +
>   struct auxtrace_record
>   *auxtrace_record__init(struct evlist *evlist, int *err)
>   {
> -	struct perf_pmu	*cs_etm_pmu;
> +	struct perf_pmu	*cs_etm_pmu = NULL;
> +	struct perf_pmu **arm_spe_pmus = NULL;
>   	struct evsel *evsel;
> -	bool found_etm = false;
> +	struct perf_pmu *found_etm = NULL;
>   	struct perf_pmu *found_spe = NULL;
> -	struct perf_pmu **arm_spe_pmus = NULL;
> +	int auxtrace_event_cnt = 0;
>   	int nr_spes = 0;
> -	int i = 0;
>   
>   	if (!evlist)
>   		return NULL;
> @@ -68,24 +84,23 @@ struct auxtrace_record
>   	arm_spe_pmus = find_all_arm_spe_pmus(&nr_spes, err);
>   
>   	evlist__for_each_entry(evlist, evsel) {
> -		if (cs_etm_pmu &&
> -		    evsel->core.attr.type == cs_etm_pmu->type)
> -			found_etm = true;
> -
> -		if (!nr_spes || found_spe)
> -			continue;
> -
> -		for (i = 0; i < nr_spes; i++) {
> -			if (evsel->core.attr.type == arm_spe_pmus[i]->type) {
> -				found_spe = arm_spe_pmus[i];
> -				break;
> -			}
> -		}
> +		if (cs_etm_pmu && !found_etm)
> +			found_etm = find_pmu_for_event(&cs_etm_pmu, 1, evsel);
> +
> +		if (arm_spe_pmus && !found_spe)
> +			found_spe = find_pmu_for_event(arm_spe_pmus, nr_spes, evsel);
>   	}
> +
>   	free(arm_spe_pmus);
>   
> -	if (found_etm && found_spe) {
> -		pr_err("Concurrent ARM Coresight ETM and SPE operation not currently supported\n");
> +	if (found_etm)
> +		auxtrace_event_cnt++;
> +
> +	if (found_spe)
> +		auxtrace_event_cnt++;
> +
> +	if (auxtrace_event_cnt > 1) {
> +		pr_err("Concurrent AUX trace operation not currently supported\n");
>   		*err = -EOPNOTSUPP;
>   		return NULL;
>   	}

