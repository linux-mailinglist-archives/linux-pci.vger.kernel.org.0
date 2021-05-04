Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4A7372625
	for <lists+linux-pci@lfdr.de>; Tue,  4 May 2021 09:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbhEDHEa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 May 2021 03:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbhEDHE3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 May 2021 03:04:29 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB9AC061574
        for <linux-pci@vger.kernel.org>; Tue,  4 May 2021 00:03:33 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id b25so11533844eju.5
        for <linux-pci@vger.kernel.org>; Tue, 04 May 2021 00:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=2fhSrKE7hVA9b5haW+j0vnIzqqcFF1JBi8LQ6ztAr8Y=;
        b=s3xesr1e2aBjm3xVkafMPLL/Dux1UG78NbuQuMbYkh8fUxmcOR3RgE0MXWIfaaoDSr
         NE29F6fVrNCnY+N+/noLXIX6ZBCbvGw4RjaWC2PQzKCihRnJ037M+FwY2cEd8MzSc/Ew
         lsctJtGstaUKiyu7W2P7iCnaXqoJuJkXS3dCICsGXgH349wK8gU3+I2eyz7ziieDguky
         T4iWyKDrlHgy1z8xIhtgKUIX+egQUTOQ4PhaCZ0LEjbi8rLHT82dw1gkB9k2ohcG6lae
         5/EQTN5W1zCr5VH3iviL7IZJj/nhBgQPWZT7PEOkuz2EpR9klL6m+oqlifaLONBK5JsF
         ETMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2fhSrKE7hVA9b5haW+j0vnIzqqcFF1JBi8LQ6ztAr8Y=;
        b=lmVrKT06USK7N5N2csnc6BG/4W+GdvtnWrouVn3W82gGcvva1yNG/S0QoRoo9Y0QJh
         i+snShp4KQStU1JnV8IlkUfztIc5fDyNrSdStRe3Xr9iS3q+LRrNjbcbYydAzT8eaDwB
         iIDF9w8iFCHU+U/6XdxmJBqTUyNFjsQ4AySFkTAYeNulxghSAIP2pCRl5JcT55tYrOqS
         kvjqIxxUAmesG+T13x8lplB3yvGTJgV88OjOSOaQ4ZFrNROYe4siE+h+K+5M4QHoXTW3
         Gs/jvK7nNQ4M283qjvq334YvO4k6689ppIdfDZeyeyqmyRTojWa39K4pRZyli4KUzmSr
         rFeg==
X-Gm-Message-State: AOAM53281MvGw3scIrgFZE7knmZflAGctF1k3H57WSu0hJa9PtQEgV3N
        8t6z5UQkb45oa/FSBzCtgiY=
X-Google-Smtp-Source: ABdhPJwCrbYRiYOkNmWWSKxPk2sXKMaPnXnw2Pi3Qgz/gdCd8P1JZmevTz9BfKupvCFlhADM0F7EWA==
X-Received: by 2002:a17:906:168f:: with SMTP id s15mr20056333ejd.220.1620111812403;
        Tue, 04 May 2021 00:03:32 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:b6e2:f801:3cd:9deb? ([2a02:908:1252:fb60:b6e2:f801:3cd:9deb])
        by smtp.gmail.com with ESMTPSA id t14sm882919ejc.121.2021.05.04.00.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 00:03:31 -0700 (PDT)
Subject: Re: [PATCH v5 06/27] drm/amdgpu: Handle IOMMU enabled case.
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-pci@vger.kernel.org, daniel.vetter@ffwll.ch,
        Harry.Wentland@amd.com
Cc:     ppaalanen@gmail.com, Alexander.Deucher@amd.com,
        gregkh@linuxfoundation.org, helgaas@kernel.org,
        Felix.Kuehling@amd.com
References: <20210428151207.1212258-1-andrey.grodzovsky@amd.com>
 <20210428151207.1212258-7-andrey.grodzovsky@amd.com>
 <8ba9edd8-9d6d-b6c3-342c-3f137d0cacd0@gmail.com>
 <df2bfa14-917b-939b-8ec1-f1e787313868@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <6607918c-cf02-98e1-f8a3-4106109e77cf@gmail.com>
Date:   Tue, 4 May 2021 09:03:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <df2bfa14-917b-939b-8ec1-f1e787313868@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 03.05.21 um 22:43 schrieb Andrey Grodzovsky:
>
>
> On 2021-04-29 3:08 a.m., Christian König wrote:
>> Am 28.04.21 um 17:11 schrieb Andrey Grodzovsky:
>>> Handle all DMA IOMMU gropup related dependencies before the
>>> group is removed.
>>>
>>> v5: Drop IOMMU notifier and switch to lockless call to 
>>> ttm_tt_unpopulate
>>
>> Maybe split that up into more patches.
>>
>>>
>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 31 
>>> ++++++++++++++++++++--
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c   |  3 +--
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h   |  1 +
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c    |  9 +++++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 13 ++++++++-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  2 ++
>>>   drivers/gpu/drm/amd/amdgpu/cik_ih.c        |  1 -
>>>   drivers/gpu/drm/amd/amdgpu/cz_ih.c         |  1 -
>>>   drivers/gpu/drm/amd/amdgpu/iceland_ih.c    |  1 -
>>>   drivers/gpu/drm/amd/amdgpu/navi10_ih.c     |  3 ---
>>>   drivers/gpu/drm/amd/amdgpu/si_ih.c         |  1 -
>>>   drivers/gpu/drm/amd/amdgpu/tonga_ih.c      |  1 -
>>>   drivers/gpu/drm/amd/amdgpu/vega10_ih.c     |  3 ---
>>>   14 files changed, 56 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index fddb82897e5d..30a24db5f4d1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -1054,6 +1054,8 @@ struct amdgpu_device {
>>>       bool                            in_pci_err_recovery;
>>>       struct pci_saved_state          *pci_state;
>>> +
>>> +    struct list_head                device_bo_list;
>>>   };
>>>   static inline struct amdgpu_device *drm_to_adev(struct drm_device 
>>> *ddev)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 46d646c40338..91594ddc2459 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -70,6 +70,7 @@
>>>   #include <drm/task_barrier.h>
>>>   #include <linux/pm_runtime.h>
>>> +
>>>   MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
>>>   MODULE_FIRMWARE("amdgpu/vega12_gpu_info.bin");
>>>   MODULE_FIRMWARE("amdgpu/raven_gpu_info.bin");
>>> @@ -3211,7 +3212,6 @@ static const struct attribute 
>>> *amdgpu_dev_attributes[] = {
>>>       NULL
>>>   };
>>> -
>>>   /**
>>>    * amdgpu_device_init - initialize the driver
>>>    *
>>> @@ -3316,6 +3316,8 @@ int amdgpu_device_init(struct amdgpu_device 
>>> *adev,
>>>       INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
>>> +    INIT_LIST_HEAD(&adev->device_bo_list);
>>> +
>>>       adev->gfx.gfx_off_req_count = 1;
>>>       adev->pm.ac_power = power_supply_is_system_supplied() > 0;
>>> @@ -3601,6 +3603,28 @@ int amdgpu_device_init(struct amdgpu_device 
>>> *adev,
>>>       return r;
>>>   }
>>> +static void amdgpu_clear_dma_mappings(struct amdgpu_device *adev)
>>> +{
>>> +    struct amdgpu_bo *bo = NULL;
>>> +
>>> +    /*
>>> +     * Unmaps all DMA mappings before device will be removed from it's
>>> +     * IOMMU group otherwise in case of IOMMU enabled system a crash
>>> +     * will happen.
>>> +     */
>>> +
>>> +    spin_lock(&adev->mman.bdev.lru_lock);
>>> +    while (!list_empty(&adev->device_bo_list)) {
>>> +        bo = list_first_entry(&adev->device_bo_list, struct 
>>> amdgpu_bo, bo);
>>> +        list_del_init(&bo->bo);
>>> +        spin_unlock(&adev->mman.bdev.lru_lock);
>>> +        if (bo->tbo.ttm)
>>> +            ttm_tt_unpopulate(bo->tbo.bdev, bo->tbo.ttm);
>>> +        spin_lock(&adev->mman.bdev.lru_lock);
>>> +    }
>>> +    spin_unlock(&adev->mman.bdev.lru_lock);
>>
>> Can you try to use the same approach as amdgpu_gtt_mgr_recover() 
>> instead of adding something to the BO?
>>
>> Christian.
>
> Are you sure that dma mappings limit themself only to GTT BOs
> which have allocated mm nodes ?

Yes, you would also need the system domain BOs. But those can be put on 
a similar list.

> Otherwsie we will crash and burn
> on missing IOMMU group when unampping post device remove.
> Problem for me to test this as in 5.12 kernel I don't crash even
> when removing this entire patch.  Looks like iommu_dma_unmap_page
> was changed since 5.9 when I introdiced this patch.

Do we really still need that stuff then? What exactly has changed?

Christian.

>
> Andrey
>
>>
>>> +}
>>> +
>>>   /**
>>>    * amdgpu_device_fini - tear down the driver
>>>    *
>>> @@ -3639,12 +3663,15 @@ void amdgpu_device_fini_hw(struct 
>>> amdgpu_device *adev)
>>>           amdgpu_ucode_sysfs_fini(adev);
>>>       sysfs_remove_files(&adev->dev->kobj, amdgpu_dev_attributes);
>>> -
>>>       amdgpu_fbdev_fini(adev);
>>>       amdgpu_irq_fini_hw(adev);
>>>       amdgpu_device_ip_fini_early(adev);
>>> +
>>> +    amdgpu_clear_dma_mappings(adev);
>>> +
>>> +    amdgpu_gart_dummy_page_fini(adev);
>>>   }
>>>   void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>>> index fde2d899b2c4..49cdcaf8512d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>>> @@ -92,7 +92,7 @@ static int amdgpu_gart_dummy_page_init(struct 
>>> amdgpu_device *adev)
>>>    *
>>>    * Frees the dummy page used by the driver (all asics).
>>>    */
>>> -static void amdgpu_gart_dummy_page_fini(struct amdgpu_device *adev)
>>> +void amdgpu_gart_dummy_page_fini(struct amdgpu_device *adev)
>>>   {
>>>       if (!adev->dummy_page_addr)
>>>           return;
>>> @@ -397,5 +397,4 @@ void amdgpu_gart_fini(struct amdgpu_device *adev)
>>>       vfree(adev->gart.pages);
>>>       adev->gart.pages = NULL;
>>>   #endif
>>> -    amdgpu_gart_dummy_page_fini(adev);
>>>   }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
>>> index afa2e2877d87..5678d9c105ab 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
>>> @@ -61,6 +61,7 @@ int amdgpu_gart_table_vram_pin(struct 
>>> amdgpu_device *adev);
>>>   void amdgpu_gart_table_vram_unpin(struct amdgpu_device *adev);
>>>   int amdgpu_gart_init(struct amdgpu_device *adev);
>>>   void amdgpu_gart_fini(struct amdgpu_device *adev);
>>> +void amdgpu_gart_dummy_page_fini(struct amdgpu_device *adev);
>>>   int amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
>>>                  int pages);
>>>   int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>> index 63e815c27585..a922154953a7 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>> @@ -326,6 +326,15 @@ void amdgpu_irq_fini_hw(struct amdgpu_device 
>>> *adev)
>>>           if (!amdgpu_device_has_dc_support(adev))
>>>               flush_work(&adev->hotplug_work);
>>>       }
>>> +
>>> +    if (adev->irq.ih_soft.ring)
>>> +        amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);
>>> +    if (adev->irq.ih.ring)
>>> +        amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>>> +    if (adev->irq.ih1.ring)
>>> +        amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
>>> +    if (adev->irq.ih2.ring)
>>> +        amdgpu_ih_ring_fini(adev, &adev->irq.ih2);
>>>   }
>>>   /**
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> index 485f249d063a..62d829f5e62c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> @@ -68,8 +68,13 @@ static void amdgpu_bo_destroy(struct 
>>> ttm_buffer_object *tbo)
>>>           list_del_init(&bo->shadow_list);
>>>           mutex_unlock(&adev->shadow_list_lock);
>>>       }
>>> -    amdgpu_bo_unref(&bo->parent);
>>> +
>>> +    spin_lock(&adev->mman.bdev.lru_lock);
>>> +    list_del(&bo->bo);
>>> +    spin_unlock(&adev->mman.bdev.lru_lock);
>>> +
>>> +    amdgpu_bo_unref(&bo->parent);
>>>       kfree(bo->metadata);
>>>       kfree(bo);
>>>   }
>>> @@ -585,6 +590,12 @@ static int amdgpu_bo_do_create(struct 
>>> amdgpu_device *adev,
>>>       if (bp->type == ttm_bo_type_device)
>>>           bo->flags &= ~AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
>>> +    INIT_LIST_HEAD(&bo->bo);
>>> +
>>> +    spin_lock(&adev->mman.bdev.lru_lock);
>>> +    list_add_tail(&bo->bo, &adev->device_bo_list);
>>> +    spin_unlock(&adev->mman.bdev.lru_lock);
>>> +
>>>       return 0;
>>>   fail_unreserve:
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>> index 9ac37569823f..5ae8555ef275 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>> @@ -110,6 +110,8 @@ struct amdgpu_bo {
>>>       struct list_head        shadow_list;
>>>       struct kgd_mem                  *kfd_bo;
>>> +
>>> +    struct list_head        bo;
>>>   };
>>>   static inline struct amdgpu_bo *ttm_to_amdgpu_bo(struct 
>>> ttm_buffer_object *tbo)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c 
>>> b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
>>> index 183d44a6583c..df385ffc9768 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
>>> @@ -310,7 +310,6 @@ static int cik_ih_sw_fini(void *handle)
>>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>       amdgpu_irq_fini_sw(adev);
>>> -    amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>>>       amdgpu_irq_remove_domain(adev);
>>>       return 0;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c 
>>> b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>>> index d32743949003..b8c47e0cf37a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>>> @@ -302,7 +302,6 @@ static int cz_ih_sw_fini(void *handle)
>>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>       amdgpu_irq_fini_sw(adev);
>>> -    amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>>>       amdgpu_irq_remove_domain(adev);
>>>       return 0;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c 
>>> b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>>> index da96c6013477..ddfe4eaeea05 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>>> @@ -301,7 +301,6 @@ static int iceland_ih_sw_fini(void *handle)
>>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>       amdgpu_irq_fini_sw(adev);
>>> -    amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>>>       amdgpu_irq_remove_domain(adev);
>>>       return 0;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c 
>>> b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>> index 5eea4550b856..e171a9e78544 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>> @@ -571,9 +571,6 @@ static int navi10_ih_sw_fini(void *handle)
>>>       amdgpu_irq_fini_sw(adev);
>>>       amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);
>>> -    amdgpu_ih_ring_fini(adev, &adev->irq.ih2);
>>> -    amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
>>> -    amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>>>       return 0;
>>>   }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c 
>>> b/drivers/gpu/drm/amd/amdgpu/si_ih.c
>>> index 751307f3252c..9a24f17a5750 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
>>> @@ -176,7 +176,6 @@ static int si_ih_sw_fini(void *handle)
>>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>       amdgpu_irq_fini_sw(adev);
>>> -    amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>>>       return 0;
>>>   }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c 
>>> b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>>> index 973d80ec7f6c..b08905d1c00f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>>> @@ -313,7 +313,6 @@ static int tonga_ih_sw_fini(void *handle)
>>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>       amdgpu_irq_fini_sw(adev);
>>> -    amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>>>       amdgpu_irq_remove_domain(adev);
>>>       return 0;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c 
>>> b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>>> index 2d0094c276ca..8c8abc00f710 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>>> @@ -525,9 +525,6 @@ static int vega10_ih_sw_fini(void *handle)
>>>       amdgpu_irq_fini_sw(adev);
>>>       amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);
>>> -    amdgpu_ih_ring_fini(adev, &adev->irq.ih2);
>>> -    amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
>>> -    amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>>>       return 0;
>>>   }
>>

