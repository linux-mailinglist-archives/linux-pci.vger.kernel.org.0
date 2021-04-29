Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8AF36E5A4
	for <lists+linux-pci@lfdr.de>; Thu, 29 Apr 2021 09:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhD2HMp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Apr 2021 03:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237427AbhD2HMk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Apr 2021 03:12:40 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC22DC06138F
        for <linux-pci@vger.kernel.org>; Thu, 29 Apr 2021 00:11:51 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id e7so77184875edu.10
        for <linux-pci@vger.kernel.org>; Thu, 29 Apr 2021 00:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Jn5U6akZgJwNINcyqEMCuCOFUOlyC2zESuTYJ6gZC1w=;
        b=Q4OrK4sLYf+sr0G+AZAvx7m0ErUN8MRcuO3thGDiX/czkL7IeOvZd8D183xQwtOIwq
         Oy8ZPwEU2/l0kyAZ/Bdoreh48nG1gbw8wq1OLNwSZcGxZj+Ax//sMojbAXN652pzmfHw
         LrG38Rkt9JaS0MqQuL9Vaa5DTOEm3mj2AXzwvEySk1RNc0GUf13DsjuoR7jtlS2B+dOR
         al18/5IhRrVhSKWtUE0aIDzxMHJfbJxZjyRpVN53+UZg/VloxclQMNHmqfSX6HIsgSDZ
         pycwvCY7iPaY+0oco7fd/c7ZQR4E922COW3WTPgXhcw5E7CvhTRcb+kfKFZn1Eh1qOO7
         yp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Jn5U6akZgJwNINcyqEMCuCOFUOlyC2zESuTYJ6gZC1w=;
        b=j92NjZpg7MpVGo/wc0cEKYxzoiF+apqYkwnCa33S6j7Omg0eXZg+m87GK0BZpu3nl/
         OhZFPeYPEoxnyLOVEcquYc13pYKWJXeDSpnlb6QUwyy+1ZpW5jXgTAgkBD+QrJErIz+l
         YdNVc+v56a++xJwetPXGxGQ8ifD6EbhEKt0NVn59u298izhUdy+IEnKn/XUsaFHCTarN
         tQoay5m58jUUhrPolqNWdjSEgcXmH5lyg+b6eH0JgNDGiLYjSjqWDC64TLaC7hNaykc+
         dmAIVX65WfjR4ytgI8k+63egxrIdM6SUv/1scGg3DgLBZNstzew93BZApPdn9IRfjLUQ
         06HQ==
X-Gm-Message-State: AOAM530Bj4T4RSvk3Auz0CNux9ZpNDq9UZ7r6aa8xfScvHDy6v3+YO/u
        99F0tR5gtxIXcMvYcoqEqHg=
X-Google-Smtp-Source: ABdhPJw5eFAOIuF2IpbkUdPLIJKycxsO/i6UIIE2NnOEmvL9oiwfdshnV6rFaK+WXZ8qXLDpKejzEA==
X-Received: by 2002:a05:6402:26c9:: with SMTP id x9mr16060534edd.322.1619680310691;
        Thu, 29 Apr 2021 00:11:50 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:49f7:8b5a:d7ab:5e3e? ([2a02:908:1252:fb60:49f7:8b5a:d7ab:5e3e])
        by smtp.gmail.com with ESMTPSA id w19sm1610189edd.52.2021.04.29.00.11.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 00:11:50 -0700 (PDT)
Subject: Re: [PATCH v5 09/27] dmr/amdgpu: Move some sysfs attrs creation to
 default_attr
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-pci@vger.kernel.org, daniel.vetter@ffwll.ch,
        Harry.Wentland@amd.com
Cc:     ppaalanen@gmail.com, Alexander.Deucher@amd.com,
        gregkh@linuxfoundation.org, helgaas@kernel.org,
        Felix.Kuehling@amd.com
References: <20210428151207.1212258-1-andrey.grodzovsky@amd.com>
 <20210428151207.1212258-10-andrey.grodzovsky@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <e8793ff7-5b80-1df1-46e4-3fba8172cdfc@gmail.com>
Date:   Thu, 29 Apr 2021 09:11:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210428151207.1212258-10-andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 28.04.21 um 17:11 schrieb Andrey Grodzovsky:
> This allows to remove explicit creation and destruction
> of those attrs and by this avoids warnings on device
> finilizing post physical device extraction.
>
> v5: Use newly added pci_driver.dev_groups directly
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Looks like a nice cleanup to me, but this is beyond my understand of sysfs.

Acked-by: Christian König <christian.koenig@amd.com>

Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 17 ++++++-------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      | 13 ++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c  | 25 ++++++++------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 14 ++++-------
>   4 files changed, 37 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> index 86add0f4ea4d..0346e124ab8c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> @@ -1953,6 +1953,15 @@ static ssize_t amdgpu_atombios_get_vbios_version(struct device *dev,
>   static DEVICE_ATTR(vbios_version, 0444, amdgpu_atombios_get_vbios_version,
>   		   NULL);
>   
> +static struct attribute *amdgpu_vbios_version_attrs[] = {
> +	&dev_attr_vbios_version.attr,
> +	NULL
> +};
> +
> +const struct attribute_group amdgpu_vbios_version_attr_group = {
> +	.attrs = amdgpu_vbios_version_attrs
> +};
> +
>   /**
>    * amdgpu_atombios_fini - free the driver info and callbacks for atombios
>    *
> @@ -1972,7 +1981,6 @@ void amdgpu_atombios_fini(struct amdgpu_device *adev)
>   	adev->mode_info.atom_context = NULL;
>   	kfree(adev->mode_info.atom_card_info);
>   	adev->mode_info.atom_card_info = NULL;
> -	device_remove_file(adev->dev, &dev_attr_vbios_version);
>   }
>   
>   /**
> @@ -1989,7 +1997,6 @@ int amdgpu_atombios_init(struct amdgpu_device *adev)
>   {
>   	struct card_info *atom_card_info =
>   	    kzalloc(sizeof(struct card_info), GFP_KERNEL);
> -	int ret;
>   
>   	if (!atom_card_info)
>   		return -ENOMEM;
> @@ -2027,12 +2034,6 @@ int amdgpu_atombios_init(struct amdgpu_device *adev)
>   		amdgpu_atombios_allocate_fb_scratch(adev);
>   	}
>   
> -	ret = device_create_file(adev->dev, &dev_attr_vbios_version);
> -	if (ret) {
> -		DRM_ERROR("Failed to create device file for VBIOS version\n");
> -		return ret;
> -	}
> -
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 54cb5ee2f563..f799c40d7e72 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1605,6 +1605,18 @@ static struct pci_error_handlers amdgpu_pci_err_handler = {
>   	.resume		= amdgpu_pci_resume,
>   };
>   
> +extern const struct attribute_group amdgpu_vram_mgr_attr_group;
> +extern const struct attribute_group amdgpu_gtt_mgr_attr_group;
> +extern const struct attribute_group amdgpu_vbios_version_attr_group;
> +
> +static const struct attribute_group *amdgpu_sysfs_groups[] = {
> +	&amdgpu_vram_mgr_attr_group,
> +	&amdgpu_gtt_mgr_attr_group,
> +	&amdgpu_vbios_version_attr_group,
> +	NULL,
> +};
> +
> +
>   static struct pci_driver amdgpu_kms_pci_driver = {
>   	.name = DRIVER_NAME,
>   	.id_table = pciidlist,
> @@ -1613,6 +1625,7 @@ static struct pci_driver amdgpu_kms_pci_driver = {
>   	.shutdown = amdgpu_pci_shutdown,
>   	.driver.pm = &amdgpu_pm_ops,
>   	.err_handler = &amdgpu_pci_err_handler,
> +	.dev_groups = amdgpu_sysfs_groups,
>   };
>   
>   static int __init amdgpu_init(void)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> index 8980329cded0..3b7150e1c5ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> @@ -77,6 +77,16 @@ static DEVICE_ATTR(mem_info_gtt_total, S_IRUGO,
>   static DEVICE_ATTR(mem_info_gtt_used, S_IRUGO,
>   	           amdgpu_mem_info_gtt_used_show, NULL);
>   
> +static struct attribute *amdgpu_gtt_mgr_attributes[] = {
> +	&dev_attr_mem_info_gtt_total.attr,
> +	&dev_attr_mem_info_gtt_used.attr,
> +	NULL
> +};
> +
> +const struct attribute_group amdgpu_gtt_mgr_attr_group = {
> +	.attrs = amdgpu_gtt_mgr_attributes
> +};
> +
>   static const struct ttm_resource_manager_func amdgpu_gtt_mgr_func;
>   /**
>    * amdgpu_gtt_mgr_init - init GTT manager and DRM MM
> @@ -91,7 +101,6 @@ int amdgpu_gtt_mgr_init(struct amdgpu_device *adev, uint64_t gtt_size)
>   	struct amdgpu_gtt_mgr *mgr = &adev->mman.gtt_mgr;
>   	struct ttm_resource_manager *man = &mgr->manager;
>   	uint64_t start, size;
> -	int ret;
>   
>   	man->use_tt = true;
>   	man->func = &amdgpu_gtt_mgr_func;
> @@ -104,17 +113,6 @@ int amdgpu_gtt_mgr_init(struct amdgpu_device *adev, uint64_t gtt_size)
>   	spin_lock_init(&mgr->lock);
>   	atomic64_set(&mgr->available, gtt_size >> PAGE_SHIFT);
>   
> -	ret = device_create_file(adev->dev, &dev_attr_mem_info_gtt_total);
> -	if (ret) {
> -		DRM_ERROR("Failed to create device file mem_info_gtt_total\n");
> -		return ret;
> -	}
> -	ret = device_create_file(adev->dev, &dev_attr_mem_info_gtt_used);
> -	if (ret) {
> -		DRM_ERROR("Failed to create device file mem_info_gtt_used\n");
> -		return ret;
> -	}
> -
>   	ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_TT, &mgr->manager);
>   	ttm_resource_manager_set_used(man, true);
>   	return 0;
> @@ -144,9 +142,6 @@ void amdgpu_gtt_mgr_fini(struct amdgpu_device *adev)
>   	drm_mm_takedown(&mgr->mm);
>   	spin_unlock(&mgr->lock);
>   
> -	device_remove_file(adev->dev, &dev_attr_mem_info_gtt_total);
> -	device_remove_file(adev->dev, &dev_attr_mem_info_gtt_used);
> -
>   	ttm_resource_manager_cleanup(man);
>   	ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_TT, NULL);
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index c89b66bb70e2..68369b38aebb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -154,7 +154,7 @@ static DEVICE_ATTR(mem_info_vis_vram_used, S_IRUGO,
>   static DEVICE_ATTR(mem_info_vram_vendor, S_IRUGO,
>   		   amdgpu_mem_info_vram_vendor, NULL);
>   
> -static const struct attribute *amdgpu_vram_mgr_attributes[] = {
> +static struct attribute *amdgpu_vram_mgr_attributes[] = {
>   	&dev_attr_mem_info_vram_total.attr,
>   	&dev_attr_mem_info_vis_vram_total.attr,
>   	&dev_attr_mem_info_vram_used.attr,
> @@ -163,6 +163,10 @@ static const struct attribute *amdgpu_vram_mgr_attributes[] = {
>   	NULL
>   };
>   
> +const struct attribute_group amdgpu_vram_mgr_attr_group = {
> +	.attrs = amdgpu_vram_mgr_attributes
> +};
> +
>   static const struct ttm_resource_manager_func amdgpu_vram_mgr_func;
>   
>   /**
> @@ -176,7 +180,6 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_vram_mgr *mgr = &adev->mman.vram_mgr;
>   	struct ttm_resource_manager *man = &mgr->manager;
> -	int ret;
>   
>   	ttm_resource_manager_init(man, adev->gmc.real_vram_size >> PAGE_SHIFT);
>   
> @@ -187,11 +190,6 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
>   	INIT_LIST_HEAD(&mgr->reservations_pending);
>   	INIT_LIST_HEAD(&mgr->reserved_pages);
>   
> -	/* Add the two VRAM-related sysfs files */
> -	ret = sysfs_create_files(&adev->dev->kobj, amdgpu_vram_mgr_attributes);
> -	if (ret)
> -		DRM_ERROR("Failed to register sysfs\n");
> -
>   	ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_VRAM, &mgr->manager);
>   	ttm_resource_manager_set_used(man, true);
>   	return 0;
> @@ -229,8 +227,6 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev)
>   	drm_mm_takedown(&mgr->mm);
>   	spin_unlock(&mgr->lock);
>   
> -	sysfs_remove_files(&adev->dev->kobj, amdgpu_vram_mgr_attributes);
> -
>   	ttm_resource_manager_cleanup(man);
>   	ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_VRAM, NULL);
>   }

