Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A3E37A01D
	for <lists+linux-pci@lfdr.de>; Tue, 11 May 2021 08:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhEKG4G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 May 2021 02:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhEKG4G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 May 2021 02:56:06 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C603C061574
        for <linux-pci@vger.kernel.org>; Mon, 10 May 2021 23:54:59 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id j10so1087662ejb.3
        for <linux-pci@vger.kernel.org>; Mon, 10 May 2021 23:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=waA0vA7ImjwNlWKbyTucsiUS1QU1A20aczJWgwdqypM=;
        b=Or/x8J+Trc3vk4FGAnkN2jkdqWbGCW6p+sJeVNL91D3DRU6T7pyL2yYQafEowX8n6q
         acx5VM2IER2bbqZiBLjxW4Sdw1THlxgqRViD1zoTdjkIUGW1tVdBPw5DMoDkxE13Xj3j
         4WYBut0L9kIFwc/rSPvbBtLbKn21OmWfbxxy/gtTWlfgRwTBhZAp24J22tbWOQr5Hpie
         KRHWl8ZrQoNyImugWFeq9aR1peSAhwaT+2CuQhBDfVMfY/19O/FDGDiuLnzEXDPDxVZe
         5ewchq7TgoP1cAn0WwBV4s+9iGjZ4m6qGCe51CdbxEf6U+/lQ/iDej+Lgvdfd67LWZdt
         k+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=waA0vA7ImjwNlWKbyTucsiUS1QU1A20aczJWgwdqypM=;
        b=TPyjivu8BIJ/Ibgj/G3WGOeMdY4JRTOShpfK2Zrygnmqij3bJMFhkoQ46CgHgoP60M
         1LPJ4q8WxqjVngkCZmZDa2WiVDnvm4AEJGHnthDiCtxYMfSuI679+4TVBEMUYRHcdbRD
         GXkkUeTUsAU2zhRByF153TGboby/Gt5cTxCNcTlyZMbotfVDW9x46K4d0/MjDnsvhi7Z
         O/tKHfWip8brd7P7oQBph68tEkNaWL7EXlpRec1tpPFupo/ZeZOuBxz+5abbbIVM8Gvx
         pIQqk3PWHsYfGp/YtJXPpIgAbG3H4Bx9j/17mIKmKZDZI151oHdRotO6Y9+XDBVShZoo
         sCXQ==
X-Gm-Message-State: AOAM531Bm4jXNlT73m18sb+dU/EjwSh19AAjTk8eLlzdWTf6oIC5cv/o
        JJekFTwd/v43yapBOQr6grg=
X-Google-Smtp-Source: ABdhPJwSQ3m3CsmdDqav2iZ3ID5dd0ZHCHRdW720vSmokH1GPExvOekTg1gQBfP5ZcbBESTqk6DCfQ==
X-Received: by 2002:a17:906:80cd:: with SMTP id a13mr29716576ejx.109.1620716097868;
        Mon, 10 May 2021 23:54:57 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:c3ab:ee01:d547:2c4e? ([2a02:908:1252:fb60:c3ab:ee01:d547:2c4e])
        by smtp.gmail.com with ESMTPSA id c7sm13613328ede.37.2021.05.10.23.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 23:54:57 -0700 (PDT)
Subject: Re: [PATCH v6 13/16] drm/amdgpu: Fix hang on device removal.
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-pci@vger.kernel.org, daniel.vetter@ffwll.ch,
        Harry.Wentland@amd.com
Cc:     ppaalanen@gmail.com, Alexander.Deucher@amd.com,
        gregkh@linuxfoundation.org, helgaas@kernel.org,
        Felix.Kuehling@amd.com
References: <20210510163625.407105-1-andrey.grodzovsky@amd.com>
 <20210510163625.407105-14-andrey.grodzovsky@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <fa76e577-b483-0ef4-57db-cea7b3a988c8@gmail.com>
Date:   Tue, 11 May 2021 08:54:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210510163625.407105-14-andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



Am 10.05.21 um 18:36 schrieb Andrey Grodzovsky:
> If removing while commands in flight you cannot wait to flush the
> HW fences on a ring since the device is gone.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 1ffb36bd0b19..fa03702ecbfb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -36,6 +36,7 @@
>   #include <linux/firmware.h>
>   #include <linux/pm_runtime.h>
>   
> +#include <drm/drm_drv.h>
>   #include "amdgpu.h"
>   #include "amdgpu_trace.h"
>   
> @@ -525,8 +526,7 @@ int amdgpu_fence_driver_init(struct amdgpu_device *adev)
>    */
>   void amdgpu_fence_driver_fini_hw(struct amdgpu_device *adev)
>   {
> -	unsigned i, j;
> -	int r;
> +	int i, r;

Is j not used here any more?

Christian.

>   
>   	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
>   		struct amdgpu_ring *ring = adev->rings[i];
> @@ -535,11 +535,15 @@ void amdgpu_fence_driver_fini_hw(struct amdgpu_device *adev)
>   			continue;
>   		if (!ring->no_scheduler)
>   			drm_sched_fini(&ring->sched);
> -		r = amdgpu_fence_wait_empty(ring);
> -		if (r) {
> -			/* no need to trigger GPU reset as we are unloading */
> +		/* You can't wait for HW to signal if it's gone */
> +		if (!drm_dev_is_unplugged(&adev->ddev))
> +			r = amdgpu_fence_wait_empty(ring);
> +		else
> +			r = -ENODEV;
> +		/* no need to trigger GPU reset as we are unloading */
> +		if (r)
>   			amdgpu_fence_driver_force_completion(ring);
> -		}
> +
>   		if (ring->fence_drv.irq_src)
>   			amdgpu_irq_put(adev, ring->fence_drv.irq_src,
>   				       ring->fence_drv.irq_type);

