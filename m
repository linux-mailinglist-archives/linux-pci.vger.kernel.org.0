Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D17236E597
	for <lists+linux-pci@lfdr.de>; Thu, 29 Apr 2021 09:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbhD2HKD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Apr 2021 03:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhD2HKC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Apr 2021 03:10:02 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C863C06138B
        for <linux-pci@vger.kernel.org>; Thu, 29 Apr 2021 00:09:16 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id r9so98311273ejj.3
        for <linux-pci@vger.kernel.org>; Thu, 29 Apr 2021 00:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=fJ60lp/Vnw50Vur34GigsubluFywhAviHZLw7QnlBAQ=;
        b=ibVWxEmnYr7rMn6hIfTI5JAdGHeU0XHA0uuhd7n3YVRg1o7pDSavYAfwpKIKDmErSW
         eJGo/8jc9noRAOXU46xY5/W4VHngg14ErHAA6xu+D167XIjtNaxr81Y3XIf8SwDHhbcI
         YOyYMb9NX9FpjKo4zCj1VHa0kC5X4XiwyXeQkLak9GlHNlFkxcVpRi4UeIDmiX6p23SA
         nYJXMC+bN3ysSAkxOYXURPghdUitD1DlitGJT0mlLvDsFCHQ70H1prp6XVKnaBS/OvxK
         ooxfGZezddjOfRc0RS/iEpUZYm1i707S2D2J6l5W19FTMnQiQqftH8uJ93gAK42/Qqwc
         eCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=fJ60lp/Vnw50Vur34GigsubluFywhAviHZLw7QnlBAQ=;
        b=p29bCYf4KObIHJJTDbjusLs7YIhWQhzDYGiP/fOjtmy9mPw56iz0Bs8BE/FIchBjj7
         DYJpoXHE2yL8Nb53AxeHxXp3W13Q+MUQPgvbgdThkrDty834hSnPsHZAtDRu4h2537aX
         kEPbg1RO9i2WpaX57VYiT03FW0W89PMnBNE4yiulp+GfL1tjUb/OI6k1D+ap42qmbn7A
         7fqcBOpX6sayprx87AVmAQ/aFS2tINHhxx4FvqRkrn5DLylCpudDjfqIxFlcTK6ODrPl
         UIYSkWjeRzIa4ZeUMTDG+f3CZY7RPyk2r4abWSFBBk109d5JrWC9DbBCM1gWWjdlggZR
         HOhw==
X-Gm-Message-State: AOAM532DXg27xPkMM/W/wJ+mYoyJ2WfCBIHcFbs178muoetxPvGpXqFB
        7t8YdnzohAlVjmP0buzk0fY=
X-Google-Smtp-Source: ABdhPJwP1LEe9bSRkNBoejBAGjjh+TiSX9ZWrbX9LSdYQZ42acp8oPY1wAG4xCk2H1bosXkKnduy3g==
X-Received: by 2002:a17:906:6544:: with SMTP id u4mr33130515ejn.455.1619680155095;
        Thu, 29 Apr 2021 00:09:15 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:49f7:8b5a:d7ab:5e3e? ([2a02:908:1252:fb60:49f7:8b5a:d7ab:5e3e])
        by smtp.gmail.com with ESMTPSA id w13sm1627636edx.80.2021.04.29.00.09.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 00:09:14 -0700 (PDT)
Subject: Re: [PATCH v5 07/27] drm/amdgpu: Remap all page faults to per process
 dummy page.
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-pci@vger.kernel.org, daniel.vetter@ffwll.ch,
        Harry.Wentland@amd.com
Cc:     ppaalanen@gmail.com, Alexander.Deucher@amd.com,
        gregkh@linuxfoundation.org, helgaas@kernel.org,
        Felix.Kuehling@amd.com
References: <20210428151207.1212258-1-andrey.grodzovsky@amd.com>
 <20210428151207.1212258-8-andrey.grodzovsky@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <abeb278f-64a1-fa14-c0ed-3d8bf9681518@gmail.com>
Date:   Thu, 29 Apr 2021 09:09:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210428151207.1212258-8-andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 28.04.21 um 17:11 schrieb Andrey Grodzovsky:
> On device removal reroute all CPU mappings to dummy page
> per drm_file instance or imported GEM object.
>
> v4:
> Update for modified ttm_bo_vm_dummy_page
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 21 ++++++++++++++++-----
>   1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index a785acc09f20..93163b220e46 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -49,6 +49,7 @@
>   
>   #include <drm/drm_debugfs.h>
>   #include <drm/amdgpu_drm.h>
> +#include <drm/drm_drv.h>
>   
>   #include "amdgpu.h"
>   #include "amdgpu_object.h"
> @@ -1982,18 +1983,28 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
>   static vm_fault_t amdgpu_ttm_fault(struct vm_fault *vmf)
>   {
>   	struct ttm_buffer_object *bo = vmf->vma->vm_private_data;
> +	struct drm_device *ddev = bo->base.dev;
>   	vm_fault_t ret;
> +	int idx;
>   
>   	ret = ttm_bo_vm_reserve(bo, vmf);
>   	if (ret)
>   		return ret;
>   
> -	ret = amdgpu_bo_fault_reserve_notify(bo);
> -	if (ret)
> -		goto unlock;
> +	if (drm_dev_enter(ddev, &idx)) {
> +		ret = amdgpu_bo_fault_reserve_notify(bo);
> +		if (ret) {
> +			drm_dev_exit(idx);
> +			goto unlock;
> +		}
>   
> -	ret = ttm_bo_vm_fault_reserved(vmf, vmf->vma->vm_page_prot,
> -				       TTM_BO_VM_NUM_PREFAULT, 1);
> +		 ret = ttm_bo_vm_fault_reserved(vmf, vmf->vma->vm_page_prot,
> +						TTM_BO_VM_NUM_PREFAULT, 1);
> +
> +		 drm_dev_exit(idx);
> +	} else {
> +		ret = ttm_bo_vm_dummy_page(vmf, vmf->vma->vm_page_prot);
> +	}
>   	if (ret == VM_FAULT_RETRY && !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
>   		return ret;
>   

