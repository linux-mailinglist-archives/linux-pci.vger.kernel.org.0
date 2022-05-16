Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6945286D1
	for <lists+linux-pci@lfdr.de>; Mon, 16 May 2022 16:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244437AbiEPOUc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 May 2022 10:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242798AbiEPOU2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 May 2022 10:20:28 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351B63B00C;
        Mon, 16 May 2022 07:20:27 -0700 (PDT)
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L21Y13WBjz67KdQ;
        Mon, 16 May 2022 22:17:25 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 16 May 2022 16:20:25 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 16 May
 2022 15:20:24 +0100
Date:   Mon, 16 May 2022 15:20:22 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Yicong Yang <yangyicong@hisilicon.com>
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
        <liuqi115@huawei.com>, <zhangshaokun@hisilicon.com>,
        <linuxarm@huawei.com>
Subject: Re: [PATCH v8 5/8] perf tool: Add support for HiSilicon PCIe Tune
 and Trace device driver
Message-ID: <20220516152022.00001ab9@Huawei.com>
In-Reply-To: <20220516125223.32012-6-yangyicong@hisilicon.com>
References: <20220516125223.32012-1-yangyicong@hisilicon.com>
        <20220516125223.32012-6-yangyicong@hisilicon.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml736-chm.china.huawei.com (10.201.108.87) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 16 May 2022 20:52:20 +0800
Yicong Yang <yangyicong@hisilicon.com> wrote:

> From: Qi Liu <liuqi115@huawei.com>
> 
> HiSilicon PCIe tune and trace device (PTT) could dynamically tune
> the PCIe link's events, and trace the TLP headers).
> 
> This patch add support for PTT device in perf tool, so users could
> use 'perf record' to get TLP headers trace data.
> 
> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

One query inline.


> diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
> index 384c7cfda0fd..297fffedf45e 100644
> --- a/tools/perf/arch/arm/util/auxtrace.c
> +++ b/tools/perf/arch/arm/util/auxtrace.c

...

>  static struct perf_pmu *find_pmu_for_event(struct perf_pmu **pmus,
>  					   int pmu_nr, struct evsel *evsel)
>  {
> @@ -71,17 +120,21 @@ struct auxtrace_record
>  {
>  	struct perf_pmu	*cs_etm_pmu = NULL;
>  	struct perf_pmu **arm_spe_pmus = NULL;
> +	struct perf_pmu **hisi_ptt_pmus = NULL;
>  	struct evsel *evsel;
>  	struct perf_pmu *found_etm = NULL;
>  	struct perf_pmu *found_spe = NULL;
> +	struct perf_pmu *found_ptt = NULL;
>  	int auxtrace_event_cnt = 0;
>  	int nr_spes = 0;
> +	int nr_ptts = 0;
>  
>  	if (!evlist)
>  		return NULL;
>  
>  	cs_etm_pmu = perf_pmu__find(CORESIGHT_ETM_PMU_NAME);
>  	arm_spe_pmus = find_all_arm_spe_pmus(&nr_spes, err);
> +	hisi_ptt_pmus = find_all_hisi_ptt_pmus(&nr_ptts, err);
>  
>  	evlist__for_each_entry(evlist, evsel) {
>  		if (cs_etm_pmu && !found_etm)
> @@ -89,9 +142,13 @@ struct auxtrace_record
>  
>  		if (arm_spe_pmus && !found_spe)
>  			found_spe = find_pmu_for_event(arm_spe_pmus, nr_spes, evsel);
> +
> +		if (arm_spe_pmus && !found_spe)

		if (hisi_ptt_pmus && !found_ptt) ?

Otherwise, I'm not sure what the purpose of the checking against spe is.

> +			found_ptt = find_pmu_for_event(hisi_ptt_pmus, nr_ptts, evsel);
>  	}
>  
>  	free(arm_spe_pmus);
> +	free(hisi_ptt_pmus);
>  
>  	if (found_etm)
>  		auxtrace_event_cnt++;
> @@ -99,6 +156,9 @@ struct auxtrace_record
>  	if (found_spe)
>  		auxtrace_event_cnt++;
>  
> +	if (found_ptt)
> +		auxtrace_event_cnt++;
> +
>  	if (auxtrace_event_cnt > 1) {
>  		pr_err("Concurrent AUX trace operation not currently supported\n");
>  		*err = -EOPNOTSUPP;
> @@ -111,6 +171,9 @@ struct auxtrace_record
>  #if defined(__aarch64__)
>  	if (found_spe)
>  		return arm_spe_recording_init(err, found_spe);
> +
> +	if (found_ptt)
> +		return hisi_ptt_recording_init(err, found_ptt);
>  #endif
>  
