Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EECD837A00E
	for <lists+linux-pci@lfdr.de>; Tue, 11 May 2021 08:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhEKGxW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 May 2021 02:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhEKGxW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 May 2021 02:53:22 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18ED6C061574
        for <linux-pci@vger.kernel.org>; Mon, 10 May 2021 23:52:15 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id j26so17874771edf.9
        for <linux-pci@vger.kernel.org>; Mon, 10 May 2021 23:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Zt9EleFqgDHEIQ+oyw3ngecefo9r13zwLFGMGvURmH8=;
        b=r73SwMKHhbYruy6BCD5buaACaKWq2AQGvkxITQjYzjfzNefUgDjucpCsQOqzqEWZSk
         7r90u0g6F7Kkt9jQkY3mfalz6Tn/X6YQat7hkP60TFYGxn70hNGuANDSdkDD1VGToNCy
         6v1mo36cvSKDT8z7JVHJucgBjjUtHMx2evDc0+dMoDkrtJ2ll/VgKMTvdLvIgogGvoXq
         lL0ynfOHclDArMQIpkR6fSnltTF9NXHjL2BsHEoSaGnZM5aYUHlxjxY6+OG7nyAxjysK
         35dnpYLLxj+8UDaBxTJMTzCus6ntlgQpX/iRfYutDO81zi2ZxcnWqqvl/XwxLTa4rFBd
         q9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Zt9EleFqgDHEIQ+oyw3ngecefo9r13zwLFGMGvURmH8=;
        b=uKMDFJ4IsVvyRz4dksKpm1md/liK7/Oyay/sMV7Zrq4E5GQ0SaNXts5SRFQJzlmYuj
         FSIJV6t2vyleRnBGaWWldcnVd5vxlEOQPpk56dkwITIyJfobRnoks/bABxJEyiPmjVxl
         XPDbp9DY/NTCGhXZo98BjxWI+5m9CcQfcgZCqrZGrhPJNv0xi9yVUfjKyeIhoTQFVkVr
         KcfO/wtK7r7REe3ZSz3loAkXZ5CiyIRNxwPn+wx3q1AtjrNbWrExWvcFunKwy3t/+wkv
         N6Ri95FPFuSqnEYcsybY8DnCrHnduqPQYjoizfM3GZOviITz2XzNXHn+COqp/0DF1bup
         mNLw==
X-Gm-Message-State: AOAM533pj7p0ywothAHFtKWCOm5BE5oymSN+OLUdovFlGqPDFjBUk6lI
        giKiFNOgtlBScHX0DOkM7xB6QXn8vmY=
X-Google-Smtp-Source: ABdhPJxaATkCokEl6gpmLVR7OoX83MdgZZq/1DLhoe1faroKDNCmn4MMGzqnYoihRwxrCcsd9IGV+Q==
X-Received: by 2002:aa7:dad1:: with SMTP id x17mr34212261eds.47.1620715933847;
        Mon, 10 May 2021 23:52:13 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:c3ab:ee01:d547:2c4e? ([2a02:908:1252:fb60:c3ab:ee01:d547:2c4e])
        by smtp.gmail.com with ESMTPSA id um28sm11148190ejb.63.2021.05.10.23.52.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 23:52:13 -0700 (PDT)
Subject: Re: [PATCH v6 11/16] drm/sched: Make timeout timer rearm conditional.
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-pci@vger.kernel.org, daniel.vetter@ffwll.ch,
        Harry.Wentland@amd.com
Cc:     ppaalanen@gmail.com, Alexander.Deucher@amd.com,
        gregkh@linuxfoundation.org, helgaas@kernel.org,
        Felix.Kuehling@amd.com
References: <20210510163625.407105-1-andrey.grodzovsky@amd.com>
 <20210510163625.407105-12-andrey.grodzovsky@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <d0fb2146-7f35-9667-10d0-88424b403d85@gmail.com>
Date:   Tue, 11 May 2021 08:52:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210510163625.407105-12-andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 10.05.21 um 18:36 schrieb Andrey Grodzovsky:
> We don't want to rearm the timer if driver hook reports
> that the device is gone.
>
> v5: Update drm_gpu_sched_stat values in code.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/scheduler/sched_main.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index f4f474944169..8d1211e87101 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -314,6 +314,7 @@ static void drm_sched_job_timedout(struct work_struct *work)
>   {
>   	struct drm_gpu_scheduler *sched;
>   	struct drm_sched_job *job;
> +	enum drm_gpu_sched_stat status = DRM_GPU_SCHED_STAT_NOMINAL;
>   
>   	sched = container_of(work, struct drm_gpu_scheduler, work_tdr.work);
>   
> @@ -331,7 +332,7 @@ static void drm_sched_job_timedout(struct work_struct *work)
>   		list_del_init(&job->list);
>   		spin_unlock(&sched->job_list_lock);
>   
> -		job->sched->ops->timedout_job(job);
> +		status = job->sched->ops->timedout_job(job);
>   
>   		/*
>   		 * Guilty job did complete and hence needs to be manually removed
> @@ -345,9 +346,11 @@ static void drm_sched_job_timedout(struct work_struct *work)
>   		spin_unlock(&sched->job_list_lock);
>   	}
>   
> -	spin_lock(&sched->job_list_lock);
> -	drm_sched_start_timeout(sched);
> -	spin_unlock(&sched->job_list_lock);
> +	if (status != DRM_GPU_SCHED_STAT_ENODEV) {
> +		spin_lock(&sched->job_list_lock);
> +		drm_sched_start_timeout(sched);
> +		spin_unlock(&sched->job_list_lock);
> +	}
>   }
>   
>    /**

