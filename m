Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8CB379FD7
	for <lists+linux-pci@lfdr.de>; Tue, 11 May 2021 08:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhEKGmW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 May 2021 02:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhEKGmW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 May 2021 02:42:22 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038CCC061574
        for <linux-pci@vger.kernel.org>; Mon, 10 May 2021 23:41:15 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id l4so28081924ejc.10
        for <linux-pci@vger.kernel.org>; Mon, 10 May 2021 23:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=SqLXrgHTQKBQUkfoeKxW1AiDv/6zlWyzUyAbUcsN3tw=;
        b=Pah/bTVct0bvjJWThdhhqzCCsfI1OeUc8dymCWXSrQzjaNKvThhwHRlebtDk/Lj6O8
         4CU8Jo2EUWxsi5lMXoTZgYkJhX4fgs0KwZJTygDa8INJohDpuH4yMNKEbxc8z0z2hU4W
         6c4W4xk2pW0gQIyjyys/dx1StxuSxqiHYdZVDB8PF9xhZyxwk3nWQm7ewp6OwGXxK9y2
         Hx4BaEZCav+oLJb8JPHfHrP5rx+XlYvfz6TR9G5XLe1ivN1VTtL6NkZZ5yZQ8ZYVkAQT
         bSt+T3p42SZaHcPqAficG0Zk8OdEw0VurdtFpQebgMa9sGh8kA7ZUjq+3aYq+qvvL8qC
         lLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=SqLXrgHTQKBQUkfoeKxW1AiDv/6zlWyzUyAbUcsN3tw=;
        b=L+wJPWel5FZD+Ho7tBmSLXw2I52Isxy0kz6UhzN2ReeeDg+R75Xw4tsPycvlm7GliP
         7sG2NPr6ifLtv2xbPM0YErHlqJNILEe0epirxkAIr/708C7jb+TVss3Vb+OqOnLfoQuE
         cCqvihu6nBi7hi947mAsitCL+KF6RMI2CPzjd/Fu8YV//M0QpMJzQ10Y01oo/gZYG0WC
         OYftE5xv3GpsKT6wtgF7DydA3cbQvBOnLhqgEIRlkDTJZ4knM3/vBRm0Zraw+EYDC+Ro
         shyBlSw7cZ/xefpwfLl2vTWOccUF2Sw/VIbgcuD+LvDHUfkjxjItTW3jK7c0TnWX+q98
         r7CQ==
X-Gm-Message-State: AOAM5300arWx69Y+Sxr892xlZuSU8zd359R8ObyoQ2eU5svM0B+px8j8
        1urAqWvfgZdbT6j7Mx2lHhQ=
X-Google-Smtp-Source: ABdhPJzytkJeXeUuFfVIxHq6hZAnJnsfPWfhCjBdK1Vy11j3f9/y8e/dwXxm+TnFv1rn/GuPREtJlQ==
X-Received: by 2002:a17:906:2854:: with SMTP id s20mr2862323ejc.335.1620715273680;
        Mon, 10 May 2021 23:41:13 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:c3ab:ee01:d547:2c4e? ([2a02:908:1252:fb60:c3ab:ee01:d547:2c4e])
        by smtp.gmail.com with ESMTPSA id t7sm13623349eds.26.2021.05.10.23.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 23:41:13 -0700 (PDT)
Subject: Re: [PATCH v6 05/16] drm/amdgpu: Add early fini callback
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-pci@vger.kernel.org, daniel.vetter@ffwll.ch,
        Harry.Wentland@amd.com
Cc:     ppaalanen@gmail.com, Alexander.Deucher@amd.com,
        gregkh@linuxfoundation.org, helgaas@kernel.org,
        Felix.Kuehling@amd.com
References: <20210510163625.407105-1-andrey.grodzovsky@amd.com>
 <20210510163625.407105-6-andrey.grodzovsky@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <0fcb6729-1cf1-69f9-ac63-0e9764933e63@gmail.com>
Date:   Tue, 11 May 2021 08:41:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210510163625.407105-6-andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 10.05.21 um 18:36 schrieb Andrey Grodzovsky:
> Use it to call disply code dependent on device->drv_data
> before it's set to NULL on device unplug
>
> v5: Move HW finilization into this callback to prevent MMIO accesses
>      post cpi remove.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 59 +++++++++++++------
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 +++-
>   drivers/gpu/drm/amd/include/amd_shared.h      |  2 +
>   3 files changed, 52 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 3760ce7d8ff8..18598eda18f6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2558,34 +2558,26 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> -/**
> - * amdgpu_device_ip_fini - run fini for hardware IPs
> - *
> - * @adev: amdgpu_device pointer
> - *
> - * Main teardown pass for hardware IPs.  The list of all the hardware
> - * IPs that make up the asic is walked and the hw_fini and sw_fini callbacks
> - * are run.  hw_fini tears down the hardware associated with each IP
> - * and sw_fini tears down any software state associated with each IP.
> - * Returns 0 on success, negative error code on failure.
> - */
> -static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
> +static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
>   {
>   	int i, r;
>   
> -	if (amdgpu_sriov_vf(adev) && adev->virt.ras_init_done)
> -		amdgpu_virt_release_ras_err_handler_data(adev);
> +	for (i = 0; i < adev->num_ip_blocks; i++) {
> +		if (!adev->ip_blocks[i].version->funcs->early_fini)
> +			continue;
>   
> -	amdgpu_ras_pre_fini(adev);
> +		r = adev->ip_blocks[i].version->funcs->early_fini((void *)adev);
> +		if (r) {
> +			DRM_DEBUG("early_fini of IP block <%s> failed %d\n",
> +				  adev->ip_blocks[i].version->funcs->name, r);
> +		}
> +	}
>   
> -	if (adev->gmc.xgmi.num_physical_nodes > 1)
> -		amdgpu_xgmi_remove_device(adev);
> +	amdgpu_amdkfd_suspend(adev, false);
>   
>   	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
>   	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
>   
> -	amdgpu_amdkfd_device_fini(adev);
> -
>   	/* need to disable SMC first */
>   	for (i = 0; i < adev->num_ip_blocks; i++) {
>   		if (!adev->ip_blocks[i].status.hw)
> @@ -2616,6 +2608,33 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
>   		adev->ip_blocks[i].status.hw = false;
>   	}
>   
> +	return 0;
> +}
> +
> +/**
> + * amdgpu_device_ip_fini - run fini for hardware IPs
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Main teardown pass for hardware IPs.  The list of all the hardware
> + * IPs that make up the asic is walked and the hw_fini and sw_fini callbacks
> + * are run.  hw_fini tears down the hardware associated with each IP
> + * and sw_fini tears down any software state associated with each IP.
> + * Returns 0 on success, negative error code on failure.
> + */
> +static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
> +{
> +	int i, r;
> +
> +	if (amdgpu_sriov_vf(adev) && adev->virt.ras_init_done)
> +		amdgpu_virt_release_ras_err_handler_data(adev);
> +
> +	amdgpu_ras_pre_fini(adev);
> +
> +	if (adev->gmc.xgmi.num_physical_nodes > 1)
> +		amdgpu_xgmi_remove_device(adev);
> +
> +	amdgpu_amdkfd_device_fini_sw(adev);
>   
>   	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
>   		if (!adev->ip_blocks[i].status.sw)
> @@ -3683,6 +3702,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>   	amdgpu_fbdev_fini(adev);
>   
>   	amdgpu_irq_fini_hw(adev);
> +
> +	amdgpu_device_ip_fini_early(adev);
>   }
>   
>   void amdgpu_device_fini_sw(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 296704ce3768..6c2c6a51ce6c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1251,6 +1251,15 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>   	return -EINVAL;
>   }
>   
> +static int amdgpu_dm_early_fini(void *handle)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +
> +	amdgpu_dm_audio_fini(adev);
> +
> +	return 0;
> +}
> +
>   static void amdgpu_dm_fini(struct amdgpu_device *adev)
>   {
>   	int i;
> @@ -1259,8 +1268,6 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
>   		drm_encoder_cleanup(&adev->dm.mst_encoders[i].base);
>   	}
>   
> -	amdgpu_dm_audio_fini(adev);
> -
>   	amdgpu_dm_destroy_drm_device(&adev->dm);
>   
>   #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
> @@ -2298,6 +2305,7 @@ static const struct amd_ip_funcs amdgpu_dm_funcs = {
>   	.late_init = dm_late_init,
>   	.sw_init = dm_sw_init,
>   	.sw_fini = dm_sw_fini,
> +	.early_fini = amdgpu_dm_early_fini,
>   	.hw_init = dm_hw_init,
>   	.hw_fini = dm_hw_fini,
>   	.suspend = dm_suspend,
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index 43ed6291b2b8..1ad56da486e4 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -240,6 +240,7 @@ enum amd_dpm_forced_level;
>    * @late_init: sets up late driver/hw state (post hw_init) - Optional
>    * @sw_init: sets up driver state, does not configure hw
>    * @sw_fini: tears down driver state, does not configure hw
> + * @early_fini: tears down stuff before dev detached from driver
>    * @hw_init: sets up the hw state
>    * @hw_fini: tears down the hw state
>    * @late_fini: final cleanup
> @@ -268,6 +269,7 @@ struct amd_ip_funcs {
>   	int (*late_init)(void *handle);
>   	int (*sw_init)(void *handle);
>   	int (*sw_fini)(void *handle);
> +	int (*early_fini)(void *handle);
>   	int (*hw_init)(void *handle);
>   	int (*hw_fini)(void *handle);
>   	void (*late_fini)(void *handle);

