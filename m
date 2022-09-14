Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99205B8A71
	for <lists+linux-pci@lfdr.de>; Wed, 14 Sep 2022 16:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiINO1f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Sep 2022 10:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiINO1e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2022 10:27:34 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D374EA7
        for <linux-pci@vger.kernel.org>; Wed, 14 Sep 2022 07:27:33 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id q3so14752056pjg.3
        for <linux-pci@vger.kernel.org>; Wed, 14 Sep 2022 07:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=CamYkk6hyQ6W/FkGD4SGaKOkaQ0RW1D0VrreKLd+PLg=;
        b=u56wYV3aH2fK+ZrJQ7oF8346nuZfmInRSgBL9Eje8NRerq3bY8k0Jh2pJg816PYes/
         wEAvIXe9IfB4nfpjkFYTFzzS4O7vwVohql7MNPbovpQOTOZqThUOAD64Zm1DBJXLnV2w
         LHCtank+3g29r4y919GrOShxdbBFa33PUjJ/scg3+/s22znmZTchZqmZ2xPchIM2rYPn
         C5NWGITdMShhMfkUPVA1Lmqy2mbB0Jp0vQLHJ8vzsCx8X9QB8Rnj6lBSwHvTArzB8yND
         9MSqnSGzoADtPGHzNdVTynGMpSLm/3rvfzs/QYFIwSBu9PQPV73gA6WEjk5dfxo83y9F
         z21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=CamYkk6hyQ6W/FkGD4SGaKOkaQ0RW1D0VrreKLd+PLg=;
        b=HB+qF3623ibOWjTGorkecpGtUU4Mg0Dn4TjpkMAlzwszk/XzNdRbztzrY6Ab+xlXpZ
         9V+znavko0rvmFtsRg6l1g2I3w1neI5ROkY8f850+Q6CJ6LF9tI/axwt15dfYW2vLQ/Z
         Hi5Mwae+AhVfDmGGi6ZcahcC3ppUKhfxAn+VHJJwLJpsOrUVVqjbttDSWek8xNY2k9hC
         HLHbGhXeHdVmVs6uBjqJGjl7R2cJ7ELKmefh3DE267lu3Qz/ojPtIVUoOJmlUHb7MxEB
         OUr/letRx2s4R0aG2LEGHdz2dmaXL9s3HLWfkisAW1OP97oP+GZ+qFy9eyn5PBPEiFln
         R4DQ==
X-Gm-Message-State: ACgBeo16XZrfFCtwCRIwBq/80ExrYxHShe/mFScfKSwmyyYmONyZpz3j
        jzcrnpx+Etu1te35P8iHYavUMA==
X-Google-Smtp-Source: AA6agR7ddK1vjr6d4fM0btt2VKYOJv+hLk9FU08MkTY7GtSdpIPrZcYUITBky6DhvELRaz/2FyChNw==
X-Received: by 2002:a17:902:ecd2:b0:178:3b53:ebf7 with SMTP id a18-20020a170902ecd200b001783b53ebf7mr11608823plh.28.1663165652471;
        Wed, 14 Sep 2022 07:27:32 -0700 (PDT)
Received: from leoy-yangtze.lan (n058152048222.netvigator.com. [58.152.48.222])
        by smtp.gmail.com with ESMTPSA id c3-20020a654203000000b0042c0ffa0e62sm9857405pgq.47.2022.09.14.07.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 07:27:32 -0700 (PDT)
Date:   Wed, 14 Sep 2022 22:27:23 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Yicong Yang <yangyicong@huawei.com>, acme@kernel.org,
        peterz@infradead.org, alexander.shishkin@linux.intel.com,
        james.clark@arm.com, will@kernel.org, mathieu.poirier@linaro.org,
        mark.rutland@arm.com, suzuki.poulose@arm.com,
        jonathan.cameron@huawei.com, mike.leach@linaro.org,
        gregkh@linuxfoundation.org, helgaas@kernel.org,
        lorenzo.pieralisi@arm.com, shameerali.kolothum.thodi@huawei.com,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-perf-users@vger.kernel.org, prime.zeng@huawei.com,
        zhangshaokun@hisilicon.com, linuxarm@huawei.com,
        yangyicong@hisilicon.com, liuqi6124@gmail.com
Subject: Re: [RESEND PATCH v12 1/3] perf tool: arm: Refactor event list
 iteration in auxtrace_record__init()
Message-ID: <YyHkywZUVPL3GNq8@leoy-yangtze.lan>
References: <20220914075925.48549-1-yangyicong@huawei.com>
 <20220914075925.48549-2-yangyicong@huawei.com>
 <c5577971-946e-405b-b0ee-23b556ea3f72@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5577971-946e-405b-b0ee-23b556ea3f72@huawei.com>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_BL_SPAMCOP_NET,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 14, 2022 at 02:47:43PM +0100, John Garry wrote:

[...]

> >   struct auxtrace_record
> >   *auxtrace_record__init(struct evlist *evlist, int *err)
> >   {
> > -	struct perf_pmu	*cs_etm_pmu;
> > +	struct perf_pmu	*cs_etm_pmu = NULL;
> > +	struct perf_pmu **arm_spe_pmus = NULL;
> >   	struct evsel *evsel;
> > -	bool found_etm = false;
> > +	struct perf_pmu *found_etm = NULL;
> >   	struct perf_pmu *found_spe = NULL;
> > -	struct perf_pmu **arm_spe_pmus = NULL;
> > +	int auxtrace_event_cnt = 0;
> >   	int nr_spes = 0;
> > -	int i = 0;
> >   	if (!evlist)
> >   		return NULL;
> > @@ -68,24 +84,23 @@ struct auxtrace_record
> >   	arm_spe_pmus = find_all_arm_spe_pmus(&nr_spes, err);
> >   	evlist__for_each_entry(evlist, evsel) {
> > -		if (cs_etm_pmu &&
> > -		    evsel->core.attr.type == cs_etm_pmu->type)
> > -			found_etm = true;
> > -
> > -		if (!nr_spes || found_spe)
> > -			continue;
> > -
> > -		for (i = 0; i < nr_spes; i++) {
> > -			if (evsel->core.attr.type == arm_spe_pmus[i]->type) {
> > -				found_spe = arm_spe_pmus[i];
> > -				break;
> > -			}
> > -		}
> > +		if (cs_etm_pmu && !found_etm) +			found_etm =
> > find_pmu_for_event(&cs_etm_pmu, 1, evsel);
> > +
> > +		if (arm_spe_pmus && !found_spe)
> > +			found_spe = find_pmu_for_event(arm_spe_pmus, nr_spes, evsel);
> 
> should you break if found_etm and found_spe are set? Or, indeed, error and
> return directly as we do below? Indeed, I am not sure why you even require
> auxtrace_event_cnt

I think this was my suggestion :)

We can check if both 'found_etm' and 'found_spe' are set and directly
break (and bail out) for this case.  But it would introduce more complex
checking if we connect with patch 2 with new flag 'found_ptt', something
like:

  if ((found_etm && found_spe) ||
      (found_etm && found_ptt) ||
      (found_spe && found_ptt))
      break;

This is hard for later's extension if we need to support a new auxtrace
event, so using auxtrace_event_cnt would be easier to extend more
auxtrace event on Arm platforms.

Thanks,
Leo

> >   	}
> > +
> >   	free(arm_spe_pmus);
> > -	if (found_etm && found_spe) {
> > -		pr_err("Concurrent ARM Coresight ETM and SPE operation not currently supported\n");
> > +	if (found_etm)
> > +		auxtrace_event_cnt++;
> > +
> > +	if (found_spe)
> > +		auxtrace_event_cnt++;
> > +
> > +	if (auxtrace_event_cnt > 1) {
> > +		pr_err("Concurrent AUX trace operation not currently supported\n");
> >   		*err = -EOPNOTSUPP;
> >   		return NULL;
> >   	}
> 
