Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A3536E588
	for <lists+linux-pci@lfdr.de>; Thu, 29 Apr 2021 09:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239364AbhD2HGH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Apr 2021 03:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239792AbhD2HF6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Apr 2021 03:05:58 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7291C06138D
        for <linux-pci@vger.kernel.org>; Thu, 29 Apr 2021 00:04:23 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u21so98315401ejo.13
        for <linux-pci@vger.kernel.org>; Thu, 29 Apr 2021 00:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=SE3xojx5Z+N2qvWsuhUpDJLqJXYDIQuF1234TsF25vc=;
        b=nHheVccea0QtvqT6YMHxrCEZ9X36niWimVEn4SMMZL45i8m+xSed4H6dwphKAgylig
         CsC+DKpFNGUsirfYS16ffxOMFTILX1waws9SyZGC2h5/4EInjSu40wxx0NE4k0f9H8VH
         DFyPQls7SnrV1kvy8UVRehXuJnJ4afyQKPdJ7wGdHXjuloRYA2uB6NlkwFKRzoNsiAOu
         WRBpqzsEyW5+HEqQi5U9uL9gZtoWndKvZazwikoo0E/z2H3QmDrbWGJ3I+1W0vjDiwwq
         G1j7RhvqrqX2GJ9mt1qdUgBWDwueD/HAs8kMRpmW8JHrYrQ+TYHvqVbZ7+BK2pz3mBpn
         4lfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=SE3xojx5Z+N2qvWsuhUpDJLqJXYDIQuF1234TsF25vc=;
        b=qp8Tda3OgadZ1MtAWyt7FzIB+tSwUfAZo/F6XxX1qhDrCv7seey4SlizLsCrXsdjXS
         0jPvKRwWjO+dDbPSw2x31wx/Ozih4zsxa2uC6PbigTfg0O6ersL5zgOXi7Bp9iqLI+TN
         e7r0bcUV1yCwCk8IkXpjV6pa8UIpoG9mGz637JFocEhLMNr0Wo5lWn8/pJjgCihukOaA
         00V66aTvYXQLGW8wlWiWnhwMm1m+S2sdBVlm9iF67ukWO7o0x2OOieij+pJs1kLbKvCJ
         2Qs0enAg4cojCE/aECglXj9jEVZBk8+d/xnB1uVEt6DRDU58VjWflhvpxGZWywSDrGXG
         +B8g==
X-Gm-Message-State: AOAM532cuIBtcxRYh2PIUEFxv9KNMMqOt9Pj6YYaI7z/Z1uyEHZXtsKO
        Mke9+3lxorZfY1+MH9lJB2M=
X-Google-Smtp-Source: ABdhPJx44nAKemhzjjFUnV4nwXVE1qxPaV7o1yBQz85YWCsNSZXKs1Pssja1ZyqRc1x6/WwzYpnkIg==
X-Received: by 2002:a17:906:5902:: with SMTP id h2mr32867555ejq.416.1619679862525;
        Thu, 29 Apr 2021 00:04:22 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:49f7:8b5a:d7ab:5e3e? ([2a02:908:1252:fb60:49f7:8b5a:d7ab:5e3e])
        by smtp.gmail.com with ESMTPSA id d12sm1253600ejd.8.2021.04.29.00.04.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 00:04:22 -0700 (PDT)
Subject: Re: [PATCH v5 03/27] drm/amdgpu: Split amdgpu_device_fini into early
 and late
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-pci@vger.kernel.org, daniel.vetter@ffwll.ch,
        Harry.Wentland@amd.com
Cc:     ppaalanen@gmail.com, Alexander.Deucher@amd.com,
        gregkh@linuxfoundation.org, helgaas@kernel.org,
        Felix.Kuehling@amd.com
References: <20210428151207.1212258-1-andrey.grodzovsky@amd.com>
 <20210428151207.1212258-4-andrey.grodzovsky@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <9276d340-261a-c96d-fe18-2d6b71ecd738@gmail.com>
Date:   Thu, 29 Apr 2021 09:04:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210428151207.1212258-4-andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



Am 28.04.21 um 17:11 schrieb Andrey Grodzovsky:
> Some of the stuff in amdgpu_device_fini such as HW interrupts
> disable and pending fences finilization must be done right away on
> pci_remove while most of the stuff which relates to finilizing and
> releasing driver data structures can be kept until
> drm_driver.release hook is called, i.e. when the last device
> reference is dropped.
>
> v4: Change functions prefix early->hw and late->sw
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

But Alex should acknowledge this as well since it is general driver design.

Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  6 ++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26 +++++++++++++++-------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  7 ++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 15 ++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c    | 26 +++++++++++++---------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h    |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 12 +++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/cik_ih.c        |  2 +-
>   drivers/gpu/drm/amd/amdgpu/cz_ih.c         |  2 +-
>   drivers/gpu/drm/amd/amdgpu/iceland_ih.c    |  2 +-
>   drivers/gpu/drm/amd/amdgpu/navi10_ih.c     |  2 +-
>   drivers/gpu/drm/amd/amdgpu/si_ih.c         |  2 +-
>   drivers/gpu/drm/amd/amdgpu/tonga_ih.c      |  2 +-
>   drivers/gpu/drm/amd/amdgpu/vega10_ih.c     |  2 +-
>   drivers/gpu/drm/amd/amdgpu/vega20_ih.c     |  2 +-
>   17 files changed, 79 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 1af2fa1591fd..fddb82897e5d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1073,7 +1073,9 @@ static inline struct amdgpu_device *amdgpu_ttm_adev(struct ttm_device *bdev)
>   
>   int amdgpu_device_init(struct amdgpu_device *adev,
>   		       uint32_t flags);
> -void amdgpu_device_fini(struct amdgpu_device *adev);
> +void amdgpu_device_fini_hw(struct amdgpu_device *adev);
> +void amdgpu_device_fini_sw(struct amdgpu_device *adev);
> +
>   int amdgpu_gpu_wait_for_idle(struct amdgpu_device *adev);
>   
>   void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
> @@ -1289,6 +1291,8 @@ void amdgpu_driver_lastclose_kms(struct drm_device *dev);
>   int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv);
>   void amdgpu_driver_postclose_kms(struct drm_device *dev,
>   				 struct drm_file *file_priv);
> +void amdgpu_driver_release_kms(struct drm_device *dev);
> +
>   int amdgpu_device_ip_suspend(struct amdgpu_device *adev);
>   int amdgpu_device_suspend(struct drm_device *dev, bool fbcon);
>   int amdgpu_device_resume(struct drm_device *dev, bool fbcon);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 6447cd6ca5a8..8d22b79fc1cd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3590,14 +3590,12 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>    * Tear down the driver info (all asics).
>    * Called at driver shutdown.
>    */
> -void amdgpu_device_fini(struct amdgpu_device *adev)
> +void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>   {
>   	dev_info(adev->dev, "amdgpu: finishing device.\n");
>   	flush_delayed_work(&adev->delayed_init_work);
>   	adev->shutdown = true;
>   
> -	kfree(adev->pci_state);
> -
>   	/* make sure IB test finished before entering exclusive mode
>   	 * to avoid preemption on IB test
>   	 * */
> @@ -3614,11 +3612,24 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
>   		else
>   			drm_atomic_helper_shutdown(adev_to_drm(adev));
>   	}
> -	amdgpu_fence_driver_fini(adev);
> +	amdgpu_fence_driver_fini_hw(adev);
> +
>   	if (adev->pm_sysfs_en)
>   		amdgpu_pm_sysfs_fini(adev);
> +	if (adev->ucode_sysfs_en)
> +		amdgpu_ucode_sysfs_fini(adev);
> +	sysfs_remove_files(&adev->dev->kobj, amdgpu_dev_attributes);
> +
> +
>   	amdgpu_fbdev_fini(adev);
> +
> +	amdgpu_irq_fini_hw(adev);
> +}
> +
> +void amdgpu_device_fini_sw(struct amdgpu_device *adev)
> +{
>   	amdgpu_device_ip_fini(adev);
> +	amdgpu_fence_driver_fini_sw(adev);
>   	release_firmware(adev->firmware.gpu_info_fw);
>   	adev->firmware.gpu_info_fw = NULL;
>   	adev->accel_working = false;
> @@ -3647,14 +3658,13 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
>   	adev->rmmio = NULL;
>   	amdgpu_device_doorbell_fini(adev);
>   
> -	if (adev->ucode_sysfs_en)
> -		amdgpu_ucode_sysfs_fini(adev);
> -
> -	sysfs_remove_files(&adev->dev->kobj, amdgpu_dev_attributes);
>   	if (IS_ENABLED(CONFIG_PERF_EVENTS))
>   		amdgpu_pmu_fini(adev);
>   	if (adev->mman.discovery_bin)
>   		amdgpu_discovery_fini(adev);
> +
> +	kfree(adev->pci_state);
> +
>   }
>   
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 671ec1002230..54cb5ee2f563 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1249,14 +1249,10 @@ amdgpu_pci_remove(struct pci_dev *pdev)
>   {
>   	struct drm_device *dev = pci_get_drvdata(pdev);
>   
> -#ifdef MODULE
> -	if (THIS_MODULE->state != MODULE_STATE_GOING)
> -#endif
> -		DRM_ERROR("Hotplug removal is not supported\n");
>   	drm_dev_unplug(dev);
>   	amdgpu_driver_unload_kms(dev);
> +
>   	pci_disable_device(pdev);
> -	pci_set_drvdata(pdev, NULL);
>   }
>   
>   static void
> @@ -1587,6 +1583,7 @@ static const struct drm_driver amdgpu_kms_driver = {
>   	.dumb_create = amdgpu_mode_dumb_create,
>   	.dumb_map_offset = amdgpu_mode_dumb_mmap,
>   	.fops = &amdgpu_driver_kms_fops,
> +	.release = &amdgpu_driver_release_kms,
>   
>   	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
>   	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 8e0a5650d383..34d51e962799 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -523,7 +523,7 @@ int amdgpu_fence_driver_init(struct amdgpu_device *adev)
>    *
>    * Tear down the fence driver for all possible rings (all asics).
>    */
> -void amdgpu_fence_driver_fini(struct amdgpu_device *adev)
> +void amdgpu_fence_driver_fini_hw(struct amdgpu_device *adev)
>   {
>   	unsigned i, j;
>   	int r;
> @@ -544,6 +544,19 @@ void amdgpu_fence_driver_fini(struct amdgpu_device *adev)
>   		if (!ring->no_scheduler)
>   			drm_sched_fini(&ring->sched);
>   		del_timer_sync(&ring->fence_drv.fallback_timer);
> +	}
> +}
> +
> +void amdgpu_fence_driver_fini_sw(struct amdgpu_device *adev)
> +{
> +	unsigned int i, j;
> +
> +	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
> +		struct amdgpu_ring *ring = adev->rings[i];
> +
> +		if (!ring || !ring->fence_drv.initialized)
> +			continue;
> +
>   		for (j = 0; j <= ring->fence_drv.num_fences_mask; ++j)
>   			dma_fence_put(ring->fence_drv.fences[j]);
>   		kfree(ring->fence_drv.fences);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index afbbec82a289..63e815c27585 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -49,6 +49,7 @@
>   #include <drm/drm_irq.h>
>   #include <drm/drm_vblank.h>
>   #include <drm/amdgpu_drm.h>
> +#include <drm/drm_drv.h>
>   #include "amdgpu.h"
>   #include "amdgpu_ih.h"
>   #include "atom.h"
> @@ -313,6 +314,20 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> +
> +void amdgpu_irq_fini_hw(struct amdgpu_device *adev)
> +{
> +	if (adev->irq.installed) {
> +		drm_irq_uninstall(&adev->ddev);
> +		adev->irq.installed = false;
> +		if (adev->irq.msi_enabled)
> +			pci_free_irq_vectors(adev->pdev);
> +
> +		if (!amdgpu_device_has_dc_support(adev))
> +			flush_work(&adev->hotplug_work);
> +	}
> +}
> +
>   /**
>    * amdgpu_irq_fini - shut down interrupt handling
>    *
> @@ -322,19 +337,10 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
>    * functionality, shuts down vblank, hotplug and reset interrupt handling,
>    * turns off interrupts from all sources (all ASICs).
>    */
> -void amdgpu_irq_fini(struct amdgpu_device *adev)
> +void amdgpu_irq_fini_sw(struct amdgpu_device *adev)
>   {
>   	unsigned i, j;
>   
> -	if (adev->irq.installed) {
> -		drm_irq_uninstall(adev_to_drm(adev));
> -		adev->irq.installed = false;
> -		if (adev->irq.msi_enabled)
> -			pci_free_irq_vectors(adev->pdev);
> -		if (!amdgpu_device_has_dc_support(adev))
> -			flush_work(&adev->hotplug_work);
> -	}
> -
>   	for (i = 0; i < AMDGPU_IRQ_CLIENTID_MAX; ++i) {
>   		if (!adev->irq.client[i].sources)
>   			continue;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> index ac527e5deae6..392a7324e2b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> @@ -104,7 +104,8 @@ void amdgpu_irq_disable_all(struct amdgpu_device *adev);
>   irqreturn_t amdgpu_irq_handler(int irq, void *arg);
>   
>   int amdgpu_irq_init(struct amdgpu_device *adev);
> -void amdgpu_irq_fini(struct amdgpu_device *adev);
> +void amdgpu_irq_fini_sw(struct amdgpu_device *adev);
> +void amdgpu_irq_fini_hw(struct amdgpu_device *adev);
>   int amdgpu_irq_add_id(struct amdgpu_device *adev,
>   		      unsigned client_id, unsigned src_id,
>   		      struct amdgpu_irq_src *source);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 64beb3399604..1af3fba7bfd4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -29,6 +29,7 @@
>   #include "amdgpu.h"
>   #include <drm/drm_debugfs.h>
>   #include <drm/amdgpu_drm.h>
> +#include <drm/drm_drv.h>
>   #include "amdgpu_uvd.h"
>   #include "amdgpu_vce.h"
>   #include "atom.h"
> @@ -93,7 +94,7 @@ void amdgpu_driver_unload_kms(struct drm_device *dev)
>   	}
>   
>   	amdgpu_acpi_fini(adev);
> -	amdgpu_device_fini(adev);
> +	amdgpu_device_fini_hw(adev);
>   }
>   
>   void amdgpu_register_gpu_instance(struct amdgpu_device *adev)
> @@ -1151,6 +1152,15 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>   	pm_runtime_put_autosuspend(dev->dev);
>   }
>   
> +
> +void amdgpu_driver_release_kms(struct drm_device *dev)
> +{
> +	struct amdgpu_device *adev = drm_to_adev(dev);
> +
> +	amdgpu_device_fini_sw(adev);
> +	pci_set_drvdata(adev->pdev, NULL);
> +}
> +
>   /*
>    * VBlank related functions.
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 1fb2a91ad30a..c0a16eac4923 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2142,6 +2142,7 @@ int amdgpu_ras_pre_fini(struct amdgpu_device *adev)
>   	if (!con)
>   		return 0;
>   
> +
>   	/* Need disable ras on all IPs here before ip [hw/sw]fini */
>   	amdgpu_ras_disable_all_features(adev, 0);
>   	amdgpu_ras_recovery_fini(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 56acec1075ac..0f195f7bf797 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -107,7 +107,8 @@ struct amdgpu_fence_driver {
>   };
>   
>   int amdgpu_fence_driver_init(struct amdgpu_device *adev);
> -void amdgpu_fence_driver_fini(struct amdgpu_device *adev);
> +void amdgpu_fence_driver_fini_hw(struct amdgpu_device *adev);
> +void amdgpu_fence_driver_fini_sw(struct amdgpu_device *adev);
>   void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
>   
>   int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
> index d3745711d55f..183d44a6583c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
> @@ -309,7 +309,7 @@ static int cik_ih_sw_fini(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> -	amdgpu_irq_fini(adev);
> +	amdgpu_irq_fini_sw(adev);
>   	amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>   	amdgpu_irq_remove_domain(adev);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
> index 307c01301c87..d32743949003 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
> @@ -301,7 +301,7 @@ static int cz_ih_sw_fini(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> -	amdgpu_irq_fini(adev);
> +	amdgpu_irq_fini_sw(adev);
>   	amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>   	amdgpu_irq_remove_domain(adev);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
> index cc957471f31e..da96c6013477 100644
> --- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
> @@ -300,7 +300,7 @@ static int iceland_ih_sw_fini(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> -	amdgpu_irq_fini(adev);
> +	amdgpu_irq_fini_sw(adev);
>   	amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>   	amdgpu_irq_remove_domain(adev);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> index f4e4040bbd25..5eea4550b856 100644
> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> @@ -569,7 +569,7 @@ static int navi10_ih_sw_fini(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> -	amdgpu_irq_fini(adev);
> +	amdgpu_irq_fini_sw(adev);
>   	amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);
>   	amdgpu_ih_ring_fini(adev, &adev->irq.ih2);
>   	amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c b/drivers/gpu/drm/amd/amdgpu/si_ih.c
> index 51880f6ef634..751307f3252c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
> @@ -175,7 +175,7 @@ static int si_ih_sw_fini(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> -	amdgpu_irq_fini(adev);
> +	amdgpu_irq_fini_sw(adev);
>   	amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> index 249fcbee7871..973d80ec7f6c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> @@ -312,7 +312,7 @@ static int tonga_ih_sw_fini(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> -	amdgpu_irq_fini(adev);
> +	amdgpu_irq_fini_sw(adev);
>   	amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>   	amdgpu_irq_remove_domain(adev);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> index 88626d83e07b..2d0094c276ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> @@ -523,7 +523,7 @@ static int vega10_ih_sw_fini(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> -	amdgpu_irq_fini(adev);
> +	amdgpu_irq_fini_sw(adev);
>   	amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);
>   	amdgpu_ih_ring_fini(adev, &adev->irq.ih2);
>   	amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> index 5a3c867d5881..9059b21b079f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> @@ -558,7 +558,7 @@ static int vega20_ih_sw_fini(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> -	amdgpu_irq_fini(adev);
> +	amdgpu_irq_fini_sw(adev);
>   	amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);
>   	amdgpu_ih_ring_fini(adev, &adev->irq.ih2);
>   	amdgpu_ih_ring_fini(adev, &adev->irq.ih1);

