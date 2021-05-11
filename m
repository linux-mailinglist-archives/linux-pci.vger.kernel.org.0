Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1069637A019
	for <lists+linux-pci@lfdr.de>; Tue, 11 May 2021 08:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhEKGyW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 May 2021 02:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbhEKGyW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 May 2021 02:54:22 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22874C061574
        for <linux-pci@vger.kernel.org>; Mon, 10 May 2021 23:53:16 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id t4so28214901ejo.0
        for <linux-pci@vger.kernel.org>; Mon, 10 May 2021 23:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=2jkTp6CRBtUK9Xe7YzSIk6qlU4V38aTXcT5xUBl3Hx0=;
        b=TOUNaz+xsdqPimiz469u/x3purtYPRpRu6hBR8TLs9nUC5429LO7mY/QovOL1CGetx
         0vfxSSIxgPzdCvBgiuxzs/f/IdmuMkS5GK7bp5LaEly41GRegKJoTHJ/+U6NpmkZ32Jl
         KCXYWQQwisf9fsFZSN9LfcL97bmWnXk1typUHtQ68YQTF3CH9uBkvt28fnjV7X+njtVB
         2lz4t/YwrPYWfb2TIPnEwldLbizJ67I6fbJM3hlG7BeOkkgj1bkAaaJJprKxsGJv4V0l
         Iav4m40VIVWWRtrezVGUnmY4pzS+Fv5He53U+Svw4XIqIOqSgIbj1y/VT9xVGPBuy/WS
         sZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2jkTp6CRBtUK9Xe7YzSIk6qlU4V38aTXcT5xUBl3Hx0=;
        b=h9IcMNMsHXclmq+QwAuIjgf631lDwsyJ6kBPw3BuFn6TyVl1lW5jrdtPxp2pBuNy5s
         UdRUbM57yGtc+NFriW3e9reoJpMtHWsCBOfbooHfQJ232MozJqAlHrUIdJDTyKl/jv1b
         a9SAECcTniExmPxtJCcy1bEWAeLR+U00T18Jv2x1c5lK6Jg9Fdtj7EK73evB754IvesQ
         WQontGRxgf7p/TsrD7nbdN699ttzaAu9doRFd84PE6WyCKm3u4s2SlzJnNXEL4NZXAFv
         MJCRfyGbVbm8/1rralTxp+GC6qy8/zbDOUTzROaKB7sIiv4zp6fz6niklZ8OBJoUHw1l
         k4wg==
X-Gm-Message-State: AOAM531sTjr0FjLsf1Whpyn9jS7ryqWst/xuNtAAduO2h/zXFayF6ZZE
        uW6hbnWILlmClAgnYPwLN/o=
X-Google-Smtp-Source: ABdhPJyS74P0xsvp+V+uc1STXMetJ1Q2dQ8sWN37hGTxDoTUr8uQnue5LZRPSJSug9rxYuPW/UstOA==
X-Received: by 2002:a17:906:a403:: with SMTP id l3mr30693501ejz.251.1620715994883;
        Mon, 10 May 2021 23:53:14 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:c3ab:ee01:d547:2c4e? ([2a02:908:1252:fb60:c3ab:ee01:d547:2c4e])
        by smtp.gmail.com with ESMTPSA id ch30sm13573570edb.92.2021.05.10.23.53.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 23:53:14 -0700 (PDT)
Subject: Re: [PATCH v6 12/16] drm/amdgpu: Prevent any job recoveries after
 device is unplugged.
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-pci@vger.kernel.org, daniel.vetter@ffwll.ch,
        Harry.Wentland@amd.com
Cc:     ppaalanen@gmail.com, Alexander.Deucher@amd.com,
        gregkh@linuxfoundation.org, helgaas@kernel.org,
        Felix.Kuehling@amd.com
References: <20210510163625.407105-1-andrey.grodzovsky@amd.com>
 <20210510163625.407105-13-andrey.grodzovsky@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <eda13789-95c7-42c2-320b-b29d5d95e465@gmail.com>
Date:   Tue, 11 May 2021 08:53:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210510163625.407105-13-andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 10.05.21 um 18:36 schrieb Andrey Grodzovsky:
> Return DRM_TASK_STATUS_ENODEV back to the scheduler when device
> is not present so they timeout timer will not be rearmed.
>
> v5: Update to match updated return values in enum drm_gpu_sched_stat
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 19 ++++++++++++++++---
>   1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 759b34799221..d33e6d97cc89 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -25,6 +25,8 @@
>   #include <linux/wait.h>
>   #include <linux/sched.h>
>   
> +#include <drm/drm_drv.h>
> +
>   #include "amdgpu.h"
>   #include "amdgpu_trace.h"
>   
> @@ -34,6 +36,15 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   	struct amdgpu_job *job = to_amdgpu_job(s_job);
>   	struct amdgpu_task_info ti;
>   	struct amdgpu_device *adev = ring->adev;
> +	int idx;
> +
> +	if (!drm_dev_enter(&adev->ddev, &idx)) {
> +		DRM_INFO("%s - device unplugged skipping recovery on scheduler:%s",
> +			 __func__, s_job->sched->name);
> +
> +		/* Effectively the job is aborted as the device is gone */
> +		return DRM_GPU_SCHED_STAT_ENODEV;
> +	}
>   
>   	memset(&ti, 0, sizeof(struct amdgpu_task_info));
>   
> @@ -41,7 +52,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   	    amdgpu_ring_soft_recovery(ring, job->vmid, s_job->s_fence->parent)) {
>   		DRM_ERROR("ring %s timeout, but soft recovered\n",
>   			  s_job->sched->name);
> -		return DRM_GPU_SCHED_STAT_NOMINAL;
> +		goto exit;
>   	}
>   
>   	amdgpu_vm_get_task_info(ring->adev, job->pasid, &ti);
> @@ -53,13 +64,15 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   
>   	if (amdgpu_device_should_recover_gpu(ring->adev)) {
>   		amdgpu_device_gpu_recover(ring->adev, job);
> -		return DRM_GPU_SCHED_STAT_NOMINAL;
>   	} else {
>   		drm_sched_suspend_timeout(&ring->sched);
>   		if (amdgpu_sriov_vf(adev))
>   			adev->virt.tdr_debug = true;
> -		return DRM_GPU_SCHED_STAT_NOMINAL;
>   	}
> +
> +exit:
> +	drm_dev_exit(idx);
> +	return DRM_GPU_SCHED_STAT_NOMINAL;
>   }
>   
>   int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned num_ibs,

