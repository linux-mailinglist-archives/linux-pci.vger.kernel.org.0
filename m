Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7B636F44D
	for <lists+linux-pci@lfdr.de>; Fri, 30 Apr 2021 05:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhD3DO4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Apr 2021 23:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhD3DO4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Apr 2021 23:14:56 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55739C06138B
        for <linux-pci@vger.kernel.org>; Thu, 29 Apr 2021 20:14:07 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso61406445otb.13
        for <linux-pci@vger.kernel.org>; Thu, 29 Apr 2021 20:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QGKDqICWZ3hx8jj1ErYY72RQJQjrjjkd8N0N9mVq3ts=;
        b=S3hxMAUJ3J8gJ8cd7+cUESDWHn9xkflACC2b87KpeJDiybzjgJirlF96UTnikqsgJz
         wBNE/l3I15+2M8k+NnKuu8KJWMECZTO2zcBomIynMVsXAuPoNY5Dm1FQL5TzHwZa2P5O
         aHHLmLOtHc6et2eKsHvGB1p56OgQbFLClXOZA4lwieS2Yywd0T8W/YDI8vfxuvyQdRAL
         fD40kl8nwEDpi0p+Coqfdr3trIDLKkpXS87JWmt2Vog4ZUUxcRt8x6t6OE+UxfCoUb3H
         lby1x7/Efi5pMZjLbDt4kNc0DAPkVIpbxta0amuuSuJJ4VxXZvCEiLgEK4sth1e+mQMf
         WkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QGKDqICWZ3hx8jj1ErYY72RQJQjrjjkd8N0N9mVq3ts=;
        b=l8iXSmbKMQID4eSVo/ZxUgEo7WF+aTuL6z4i9w78+g4OINYqpkVMDFigys70vEt/uG
         C996g0j3qgMikljUfsDUeQe6HRjc+Tkzb30L2ajnIbe8oe4PjJVZ+tPj6xvDFzJRbFi/
         +tJrabEwaCn4GGIUr1khW1Y+l1iMTmoCKAe86XkjLFPFs6h0Wua1D6I6mQ6n6FGC6+7u
         g/En/uq0MBxxHYmJ922wIb7v7Bmxx/Aaej98vIyeMBjXkhjg9x6W/ZIBHXIgfO+TDBuW
         xqSYabJMNwPqMxvxmSotVkAlCUuV4Rt25W1dPcpcfr2BWpqjqLGtmM+crp+pVKZzyPUd
         5WpQ==
X-Gm-Message-State: AOAM53020bu7nk9cDRkmJFB+5mggM6EyzdvZe3ANhUo+gEwLaHpk7Rs5
        0wlS2qmTrpEqE4NDeDXVcb5H6u+ueNtGh4LXu4HwRnOAHX8=
X-Google-Smtp-Source: ABdhPJw1yGl7Ru2ixItWs6qs5kFNXuZFp5zWncR2EEmnky3sJHNEDp9f5kjzCDB6W88sTtaYpz3nK8FQ/2i/7SJt3+U=
X-Received: by 2002:a9d:8d1:: with SMTP id 75mr2025799otf.23.1619752446695;
 Thu, 29 Apr 2021 20:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210428151207.1212258-1-andrey.grodzovsky@amd.com> <20210428151207.1212258-7-andrey.grodzovsky@amd.com>
In-Reply-To: <20210428151207.1212258-7-andrey.grodzovsky@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 29 Apr 2021 23:13:55 -0400
Message-ID: <CADnq5_NtyLBon0Tk_BHh=XOprMPrAcKf8LN8b-bdmy1-D1Uzhg@mail.gmail.com>
Subject: Re: [PATCH v5 06/27] drm/amdgpu: Handle IOMMU enabled case.
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc:     Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 28, 2021 at 11:13 AM Andrey Grodzovsky
<andrey.grodzovsky@amd.com> wrote:
>
> Handle all DMA IOMMU gropup related dependencies before the
> group is removed.
>
> v5: Drop IOMMU notifier and switch to lockless call to ttm_tt_unpopulate
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 31 ++++++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c   |  3 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h   |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c    |  9 +++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 13 ++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  2 ++
>  drivers/gpu/drm/amd/amdgpu/cik_ih.c        |  1 -
>  drivers/gpu/drm/amd/amdgpu/cz_ih.c         |  1 -
>  drivers/gpu/drm/amd/amdgpu/iceland_ih.c    |  1 -
>  drivers/gpu/drm/amd/amdgpu/navi10_ih.c     |  3 ---
>  drivers/gpu/drm/amd/amdgpu/si_ih.c         |  1 -
>  drivers/gpu/drm/amd/amdgpu/tonga_ih.c      |  1 -
>  drivers/gpu/drm/amd/amdgpu/vega10_ih.c     |  3 ---
>  14 files changed, 56 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index fddb82897e5d..30a24db5f4d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1054,6 +1054,8 @@ struct amdgpu_device {
>
>         bool                            in_pci_err_recovery;
>         struct pci_saved_state          *pci_state;
> +
> +       struct list_head                device_bo_list;
>  };
>
>  static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 46d646c40338..91594ddc2459 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -70,6 +70,7 @@
>  #include <drm/task_barrier.h>
>  #include <linux/pm_runtime.h>
>
> +
>  MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
>  MODULE_FIRMWARE("amdgpu/vega12_gpu_info.bin");
>  MODULE_FIRMWARE("amdgpu/raven_gpu_info.bin");
> @@ -3211,7 +3212,6 @@ static const struct attribute *amdgpu_dev_attributes[] = {
>         NULL
>  };
>
> -
>  /**
>   * amdgpu_device_init - initialize the driver
>   *
> @@ -3316,6 +3316,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>
>         INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
>
> +       INIT_LIST_HEAD(&adev->device_bo_list);
> +
>         adev->gfx.gfx_off_req_count = 1;
>         adev->pm.ac_power = power_supply_is_system_supplied() > 0;
>
> @@ -3601,6 +3603,28 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>         return r;
>  }
>
> +static void amdgpu_clear_dma_mappings(struct amdgpu_device *adev)

Prefix this with amdgpu_device for consistency.  E.g.,
amdgpu_device_clear_dma_mappings()

> +{
> +       struct amdgpu_bo *bo = NULL;
> +
> +       /*
> +        * Unmaps all DMA mappings before device will be removed from it's
> +        * IOMMU group otherwise in case of IOMMU enabled system a crash
> +        * will happen.
> +        */
> +
> +       spin_lock(&adev->mman.bdev.lru_lock);
> +       while (!list_empty(&adev->device_bo_list)) {
> +               bo = list_first_entry(&adev->device_bo_list, struct amdgpu_bo, bo);
> +               list_del_init(&bo->bo);
> +               spin_unlock(&adev->mman.bdev.lru_lock);
> +               if (bo->tbo.ttm)
> +                       ttm_tt_unpopulate(bo->tbo.bdev, bo->tbo.ttm);
> +               spin_lock(&adev->mman.bdev.lru_lock);
> +       }
> +       spin_unlock(&adev->mman.bdev.lru_lock);
> +}
> +
>  /**
>   * amdgpu_device_fini - tear down the driver
>   *
> @@ -3639,12 +3663,15 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>                 amdgpu_ucode_sysfs_fini(adev);
>         sysfs_remove_files(&adev->dev->kobj, amdgpu_dev_attributes);
>
> -
>         amdgpu_fbdev_fini(adev);
>
>         amdgpu_irq_fini_hw(adev);
>
>         amdgpu_device_ip_fini_early(adev);
> +
> +       amdgpu_clear_dma_mappings(adev);
> +
> +       amdgpu_gart_dummy_page_fini(adev);
>  }
>
>  void amdgpu_device_fini_sw(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> index fde2d899b2c4..49cdcaf8512d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> @@ -92,7 +92,7 @@ static int amdgpu_gart_dummy_page_init(struct amdgpu_device *adev)
>   *
>   * Frees the dummy page used by the driver (all asics).
>   */
> -static void amdgpu_gart_dummy_page_fini(struct amdgpu_device *adev)
> +void amdgpu_gart_dummy_page_fini(struct amdgpu_device *adev)
>  {
>         if (!adev->dummy_page_addr)
>                 return;
> @@ -397,5 +397,4 @@ void amdgpu_gart_fini(struct amdgpu_device *adev)
>         vfree(adev->gart.pages);
>         adev->gart.pages = NULL;
>  #endif
> -       amdgpu_gart_dummy_page_fini(adev);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
> index afa2e2877d87..5678d9c105ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
> @@ -61,6 +61,7 @@ int amdgpu_gart_table_vram_pin(struct amdgpu_device *adev);
>  void amdgpu_gart_table_vram_unpin(struct amdgpu_device *adev);
>  int amdgpu_gart_init(struct amdgpu_device *adev);
>  void amdgpu_gart_fini(struct amdgpu_device *adev);
> +void amdgpu_gart_dummy_page_fini(struct amdgpu_device *adev);
>  int amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
>                        int pages);
>  int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index 63e815c27585..a922154953a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -326,6 +326,15 @@ void amdgpu_irq_fini_hw(struct amdgpu_device *adev)
>                 if (!amdgpu_device_has_dc_support(adev))
>                         flush_work(&adev->hotplug_work);
>         }
> +
> +       if (adev->irq.ih_soft.ring)
> +               amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);
> +       if (adev->irq.ih.ring)
> +               amdgpu_ih_ring_fini(adev, &adev->irq.ih);
> +       if (adev->irq.ih1.ring)
> +               amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
> +       if (adev->irq.ih2.ring)
> +               amdgpu_ih_ring_fini(adev, &adev->irq.ih2);
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 485f249d063a..62d829f5e62c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -68,8 +68,13 @@ static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
>                 list_del_init(&bo->shadow_list);
>                 mutex_unlock(&adev->shadow_list_lock);
>         }
> -       amdgpu_bo_unref(&bo->parent);
>
> +
> +       spin_lock(&adev->mman.bdev.lru_lock);
> +       list_del(&bo->bo);
> +       spin_unlock(&adev->mman.bdev.lru_lock);
> +
> +       amdgpu_bo_unref(&bo->parent);
>         kfree(bo->metadata);
>         kfree(bo);
>  }
> @@ -585,6 +590,12 @@ static int amdgpu_bo_do_create(struct amdgpu_device *adev,
>         if (bp->type == ttm_bo_type_device)
>                 bo->flags &= ~AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
>
> +       INIT_LIST_HEAD(&bo->bo);
> +
> +       spin_lock(&adev->mman.bdev.lru_lock);
> +       list_add_tail(&bo->bo, &adev->device_bo_list);
> +       spin_unlock(&adev->mman.bdev.lru_lock);
> +
>         return 0;
>
>  fail_unreserve:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 9ac37569823f..5ae8555ef275 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -110,6 +110,8 @@ struct amdgpu_bo {
>         struct list_head                shadow_list;
>
>         struct kgd_mem                  *kfd_bo;
> +
> +       struct list_head                bo;
>  };
>
>  static inline struct amdgpu_bo *ttm_to_amdgpu_bo(struct ttm_buffer_object *tbo)
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
> index 183d44a6583c..df385ffc9768 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
> @@ -310,7 +310,6 @@ static int cik_ih_sw_fini(void *handle)
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>
>         amdgpu_irq_fini_sw(adev);
> -       amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>         amdgpu_irq_remove_domain(adev);
>
>         return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
> index d32743949003..b8c47e0cf37a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
> @@ -302,7 +302,6 @@ static int cz_ih_sw_fini(void *handle)
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>
>         amdgpu_irq_fini_sw(adev);
> -       amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>         amdgpu_irq_remove_domain(adev);
>
>         return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
> index da96c6013477..ddfe4eaeea05 100644
> --- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
> @@ -301,7 +301,6 @@ static int iceland_ih_sw_fini(void *handle)
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>
>         amdgpu_irq_fini_sw(adev);
> -       amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>         amdgpu_irq_remove_domain(adev);
>
>         return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> index 5eea4550b856..e171a9e78544 100644
> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> @@ -571,9 +571,6 @@ static int navi10_ih_sw_fini(void *handle)
>
>         amdgpu_irq_fini_sw(adev);
>         amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);

Shouldn't the soft ring be removed as well?

> -       amdgpu_ih_ring_fini(adev, &adev->irq.ih2);
> -       amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
> -       amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c b/drivers/gpu/drm/amd/amdgpu/si_ih.c
> index 751307f3252c..9a24f17a5750 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
> @@ -176,7 +176,6 @@ static int si_ih_sw_fini(void *handle)
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>
>         amdgpu_irq_fini_sw(adev);
> -       amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> index 973d80ec7f6c..b08905d1c00f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> @@ -313,7 +313,6 @@ static int tonga_ih_sw_fini(void *handle)
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>
>         amdgpu_irq_fini_sw(adev);
> -       amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>         amdgpu_irq_remove_domain(adev);
>
>         return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> index 2d0094c276ca..8c8abc00f710 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> @@ -525,9 +525,6 @@ static int vega10_ih_sw_fini(void *handle)
>
>         amdgpu_irq_fini_sw(adev);
>         amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);

Same here?

> -       amdgpu_ih_ring_fini(adev, &adev->irq.ih2);
> -       amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
> -       amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>
>         return 0;
>  }
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
