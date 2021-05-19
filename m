Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E4238908B
	for <lists+linux-pci@lfdr.de>; Wed, 19 May 2021 16:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347318AbhESOT2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 May 2021 10:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354008AbhESOTE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 May 2021 10:19:04 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB281C061349
        for <linux-pci@vger.kernel.org>; Wed, 19 May 2021 07:15:12 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id s6so15514170edu.10
        for <linux-pci@vger.kernel.org>; Wed, 19 May 2021 07:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=TtP8WVW+tcp98Fr66u48tzo0yVxMukLz/us7XyyQfO0=;
        b=L3fd4Ue0cwgbLoLKhQ0G1QwPmmtSSs0L+08FFlHNTTc3XxvGzkcE59S22AlHvuGBno
         MWgkJzcAeHdJKWqnCJmrBGDNYJx5dca9GGbXyBdy10DwiiL0xli+qbDu95FEFKhS12hh
         ydthdRpENL5mo7MFuIgzVmzoD1hsyXggBWcx8zpE66J2ps4NHqSinXjh7Y/I7rkk88+1
         PiH+1aYmU5w7obWmZ4CFZzpMXYe6oUECKkO79DLhjD+AQrLc4fyNqpPcJfs5IqbN19Ja
         JWnf9n608wLrgMvBmxcZYRS9GYMnxufXBV6fAE+/AnOU5jEQgfSc+3fupuZeQfVyfsew
         cmJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=TtP8WVW+tcp98Fr66u48tzo0yVxMukLz/us7XyyQfO0=;
        b=ZOkg9GRXxJALbVJxBPgsxA8gwk78m3wirCQA4MsZ2U5YT8227l1bV/C3j1H+LuJTPJ
         6my6M27+P2oqyEI0YBShiKt8jaf/jrTTfmelZ+Iulo4zxIv5JkUmiiy5kQiDMJOc3Wj7
         /kxctXRUX0a6ukF6De55bw6peW3VYr70arv9RF5zwOQS5D1huD78KfXeFTlSgXHwudPV
         hSR4CHt6qFYpRlwUrI9JLSXCPKUlg/J80hri47qHmm/cVnBT4vGDhfU9mEqoy236W1rE
         8WV6bYfugtj7SQRWWxhI5rGmKONiRfUfkrlWMNrbwW3qd4KAdtT+7GybDUUf9xW/K/hv
         HKDA==
X-Gm-Message-State: AOAM531167YH0A+H+fjnwYgbA5SU+pzDebL0CaSdnINso2gkCV6vCsNz
        LotaNwz6yEJpEGKDUEzeSR8=
X-Google-Smtp-Source: ABdhPJzJUFi4X4JkOfXlS4GBwyBhso5zyGqdyI0xZ4exkwDbf4pf9WqJu+3fM53IHc7WvecZOLXQPw==
X-Received: by 2002:aa7:d413:: with SMTP id z19mr14809405edq.37.1621433711484;
        Wed, 19 May 2021 07:15:11 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:8e28:1d3:41f3:e15a? ([2a02:908:1252:fb60:8e28:1d3:41f3:e15a])
        by smtp.gmail.com with ESMTPSA id c3sm16593506edn.16.2021.05.19.07.15.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 07:15:11 -0700 (PDT)
Subject: Re: [PATCH] drm/sched: Avoid data corruptions
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-pci@vger.kernel.org, daniel.vetter@ffwll.ch,
        Harry.Wentland@amd.com
Cc:     ppaalanen@gmail.com, Alexander.Deucher@amd.com,
        gregkh@linuxfoundation.org, helgaas@kernel.org,
        Felix.Kuehling@amd.com
References: <fa81de6a-e272-66cf-61d8-5bb2d0ebcb03@gmail.com>
 <20210519141407.88444-1-andrey.grodzovsky@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <ce0d6f1c-4cb6-e21f-28c5-93531b687976@gmail.com>
Date:   Wed, 19 May 2021 16:15:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210519141407.88444-1-andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 19.05.21 um 16:14 schrieb Andrey Grodzovsky:
> Wait for all dependencies of a job  to complete before
> killing it to avoid data corruptions.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/scheduler/sched_entity.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
> index 2e93e881b65f..d5cf61972558 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -222,11 +222,16 @@ static void drm_sched_entity_kill_jobs_cb(struct dma_fence *f,
>   static void drm_sched_entity_kill_jobs(struct drm_sched_entity *entity)
>   {
>   	struct drm_sched_job *job;
> +	struct dma_fence *f;
>   	int r;
>   
>   	while ((job = to_drm_sched_job(spsc_queue_pop(&entity->job_queue)))) {
>   		struct drm_sched_fence *s_fence = job->s_fence;
>   
> +		/* Wait for all dependencies to avoid data corruptions */
> +		while ((f = job->sched->ops->dependency(job, entity)))
> +			dma_fence_wait(f);
> +
>   		drm_sched_fence_scheduled(s_fence);
>   		dma_fence_set_error(&s_fence->finished, -ESRCH);
>   

