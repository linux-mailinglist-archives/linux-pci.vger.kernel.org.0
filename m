Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF2C55B4E8
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jun 2022 03:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiF0BUE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Jun 2022 21:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbiF0BUD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 26 Jun 2022 21:20:03 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF522AE6
        for <linux-pci@vger.kernel.org>; Sun, 26 Jun 2022 18:20:01 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id k14so6831015plh.4
        for <linux-pci@vger.kernel.org>; Sun, 26 Jun 2022 18:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JiM3N5evqJOowVHWeRy1BwX3FfyhynbxcUWkOm6L1ik=;
        b=MsSky8rDDNs+PaeJiRVQB1ywR02u//iGONyyvf7FEtTfEv4lDjV4I0s9czbxLDUlC7
         hsbylmLh4lkwFDR2wcTssR4JKfGmiC0X2jbsyTQqZ8piT/seBMuw9fJg5afyGhwP6hWJ
         h4KVr+A/lgCTGixqzRRf/QAH3Ih2kD9CrSUYJyArsX3bkBBSeQWDmcUaIaTgp/poVGou
         wCELTMGy/eNdRn8wkTfLBYMviw3HKzeBKLaP4DuXF7jOANwxuL7mwKoQdphN9VwfycyL
         EYnKRM7gBzMgq54yzBZbT0+8WpoxkEAGhh9PIHUMCo7yarxf3rbI8yqoZGFOpq3EQwXU
         GTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JiM3N5evqJOowVHWeRy1BwX3FfyhynbxcUWkOm6L1ik=;
        b=aGJJqQpuXqrWNlwiP/iBVl5CgyrfsuyyxptiIRQ3nsB2EqxVIbFHMcAt8YfP4WE8dQ
         1XMr8adoqrDlgWCa7hu72ixq2By0dcJXMW+LTFz8XFNAT7E0UYz/bJnbyWmzcXwqskBi
         Ec+rOxU4O2dXRg1hptl63MJ5AeyiW9Lv16HedfOADPDZcXoabWvcU5GT7TzVRfJkK1NH
         EdHW51O6tvAHPQwUFtgrf4O+Sq8NGaM1LyrITp7NQQsqBcrEwa4ZjL9aFWy7rho45Brj
         ErQ4CWzk/2FI2cscTeg8PmrQ8PEem+QHuZDT4PMr3gpj3AzxUVOXmC6l/2YYWzsogisM
         TkWA==
X-Gm-Message-State: AJIora/K/IY3JCt0YYepmsnuxbKpbemUiAQO2kHCzfRqs3oHtzf0/okq
        VFcM6WEck8qikIvWSUlG1DC8/w==
X-Google-Smtp-Source: AGRyM1t2oztCFYrN6uMQKxDHkXdOqDSQ8UIJhLBDVPzheHA8LqCKnazYXDAdI5hfVtGXQ8ObBUyVpQ==
X-Received: by 2002:a17:903:1cf:b0:16a:605a:d58a with SMTP id e15-20020a17090301cf00b0016a605ad58amr11786381plh.37.1656292800336;
        Sun, 26 Jun 2022 18:20:00 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([103.135.249.206])
        by smtp.gmail.com with ESMTPSA id n22-20020a17090a161600b001ecd48b80a2sm8064260pja.5.2022.06.26.18.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 18:19:59 -0700 (PDT)
Date:   Mon, 27 Jun 2022 09:19:52 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     gregkh@linuxfoundation.org, alexander.shishkin@linux.intel.com,
        james.clark@arm.com, will@kernel.org, robin.murphy@arm.com,
        acme@kernel.org, jonathan.cameron@huawei.com,
        john.garry@huawei.com, helgaas@kernel.org,
        lorenzo.pieralisi@arm.com, mathieu.poirier@linaro.org,
        suzuki.poulose@arm.com, mark.rutland@arm.com, joro@8bytes.org,
        shameerali.kolothum.thodi@huawei.com, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-perf-users@vger.kernel.org, iommu@lists.linux-foundation.org,
        prime.zeng@huawei.com, liuqi115@huawei.com,
        zhangshaokun@hisilicon.com, linuxarm@huawei.com
Subject: Re: [PATCH v9 4/8] perf tool: arm: Refactor event list iteration in
 auxtrace_record__init()
Message-ID: <20220627011952.GA143063@leoy-ThinkPad-X240s>
References: <20220606115555.41103-1-yangyicong@hisilicon.com>
 <20220606115555.41103-5-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606115555.41103-5-yangyicong@hisilicon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 06, 2022 at 07:55:51PM +0800, Yicong Yang wrote:
> From: Qi Liu <liuqi115@huawei.com>
> 
> Add find_pmu_for_event() and use to simplify logic in
> auxtrace_record_init(). find_pmu_for_event() will be
> reused in subsequent patches.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> ---
>  tools/perf/arch/arm/util/auxtrace.c | 53 ++++++++++++++++++-----------
>  1 file changed, 34 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
> index 5fc6a2a3dbc5..384c7cfda0fd 100644
> --- a/tools/perf/arch/arm/util/auxtrace.c
> +++ b/tools/perf/arch/arm/util/auxtrace.c
> @@ -50,16 +50,32 @@ static struct perf_pmu **find_all_arm_spe_pmus(int *nr_spes, int *err)
>  	return arm_spe_pmus;
>  }
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
>  struct auxtrace_record
>  *auxtrace_record__init(struct evlist *evlist, int *err)
>  {
> -	struct perf_pmu	*cs_etm_pmu;
> +	struct perf_pmu	*cs_etm_pmu = NULL;
> +	struct perf_pmu **arm_spe_pmus = NULL;
>  	struct evsel *evsel;
> -	bool found_etm = false;
> +	struct perf_pmu *found_etm = NULL;
>  	struct perf_pmu *found_spe = NULL;
> -	struct perf_pmu **arm_spe_pmus = NULL;
> +	int auxtrace_event_cnt = 0;
>  	int nr_spes = 0;
> -	int i = 0;
>  
>  	if (!evlist)
>  		return NULL;
> @@ -68,24 +84,23 @@ struct auxtrace_record
>  	arm_spe_pmus = find_all_arm_spe_pmus(&nr_spes, err);
>  
>  	evlist__for_each_entry(evlist, evsel) {
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
>  	}
> +
>  	free(arm_spe_pmus);
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
>  		*err = -EOPNOTSUPP;
>  		return NULL;
>  	}
> -- 
> 2.24.0
