Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57F855B510
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jun 2022 04:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiF0CDG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Jun 2022 22:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiF0CDG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 26 Jun 2022 22:03:06 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B18DEB5
        for <linux-pci@vger.kernel.org>; Sun, 26 Jun 2022 19:03:05 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id g7so2802959pjj.2
        for <linux-pci@vger.kernel.org>; Sun, 26 Jun 2022 19:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cFzsYDSniCnlBZ03HwKNu3S5QmFfxy2xvMgtRDJMZis=;
        b=W9NMxYS6VjeyTC2cMMP/U2hMAgucbyOeYIMRtdhZhBzWM9I5CHJvC78CT5KjWoRSaI
         YMzEn64lLecRyWTMhmh0DrHudZ2V8CW8H/fh2J5A0kUiPIXFaaiKzPzEaOeWTlieEib0
         RzNwvSJPuZS6TGyznaBwVLM9izVf6IwyagW8sNL0vyHz9rXDH9/INPnaOfE4mNWGB6+j
         EHtJnShucEnJpz2SjeJ3B06AvpibDKU7g8RGBvsSTA6UqjenJhNn4rlQ3c05GJmR4qcl
         Lk+TrcPs0cWqt6+Kmek4rYYmJccguriPiiBOQudPQNC9JtmDL6HWcSgH0IN2z+JLduXZ
         gFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cFzsYDSniCnlBZ03HwKNu3S5QmFfxy2xvMgtRDJMZis=;
        b=hdlfb9mPeid6Lr9U0IsRVOHOgm9U0Gq/G8TfEgFh1C43iIBlOjNM7ZEG4w6SBbGbQv
         Ns2piuQ4rv3y7DcAD/JwxRUF0/7FhIkVNB/XxuWlmm3xr7PGNsxxv+g5AeWwJEAEQENI
         5JaQ7VRZ8psyOeYDqy07GTG8wrP8jMZrCASYtOzzRTQWU2NHD2x4/FaNnNJ4FDR5wfYo
         iEY+Q+vDHibxvFH4NTvV745fa1NoPIv2lpeiJjohyRuIBApJXiNAsayFjGiCAhP69kvq
         CjxqxAyVkLzcCIvQi4/RxqwmiBRIQQw4vaCMobAeSgmXM/HV3nB10otX5jh0m0Rnn5pu
         vVbQ==
X-Gm-Message-State: AJIora9r4xGBN2yzZlWkQ9CWzXeuuyioe4bpLdllTuow7K77YOusEBc1
        4W6t9EPj97tWEx5LFS2XxFqAHw==
X-Google-Smtp-Source: AGRyM1sMApCNujHeAcMS6o2le4b1Rwn51Wk9w2AAmuhkBTXz7YYbL0AMbuIim8kFUBy3QBW5KtcrJg==
X-Received: by 2002:a17:90b:4c86:b0:1ec:cc0f:32da with SMTP id my6-20020a17090b4c8600b001eccc0f32damr18286077pjb.66.1656295384629;
        Sun, 26 Jun 2022 19:03:04 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([103.135.249.206])
        by smtp.gmail.com with ESMTPSA id g8-20020a056a00078800b0050e006279bfsm5834982pfu.137.2022.06.26.19.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 19:03:04 -0700 (PDT)
Date:   Mon, 27 Jun 2022 10:02:56 +0800
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
Subject: Re: [PATCH v9 5/8] perf tool: Add support for HiSilicon PCIe Tune
 and Trace device driver
Message-ID: <20220627020256.GB143063@leoy-ThinkPad-X240s>
References: <20220606115555.41103-1-yangyicong@hisilicon.com>
 <20220606115555.41103-6-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606115555.41103-6-yangyicong@hisilicon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 06, 2022 at 07:55:52PM +0800, Yicong Yang wrote:
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

Just one minor comment.

[...]

> diff --git a/tools/perf/util/hisi-ptt.h b/tools/perf/util/hisi-ptt.h
> new file mode 100644
> index 000000000000..2db9b4056214
> --- /dev/null
> +++ b/tools/perf/util/hisi-ptt.h
> @@ -0,0 +1,19 @@
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
> +int hisi_ptt_process_auxtrace_info(union perf_event *event,
> +				   struct perf_session *session);

The function hisi_ptt_process_auxtrace_info() is introduced by next
patch for support PTT decoding, for good practice (e.g. keep
bisection), it's good to introduce function declaration and definition
in one patch.

With this fixing, this patch looks good to me:

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> +
> +#endif
> -- 
> 2.24.0
