Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F4C36F43D
	for <lists+linux-pci@lfdr.de>; Fri, 30 Apr 2021 05:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhD3DLh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Apr 2021 23:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhD3DLh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Apr 2021 23:11:37 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCDEC06138B
        for <linux-pci@vger.kernel.org>; Thu, 29 Apr 2021 20:10:49 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id k26-20020a4adfba0000b02901f992c7ec7bso1729031ook.13
        for <linux-pci@vger.kernel.org>; Thu, 29 Apr 2021 20:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UF/lSvUut0wTX/5Q3Ag04kXxOsjZz8sIbrC77QnXiwE=;
        b=teMUdHYMmdPpw8azIPWS4FU9BtwUqtUIiXyoJVoKrzmyr2z3YhziaHwiKo9mKY8R8u
         WZBb4ZUUHOkRQ/mLb3ZLxdMUUW/b8TYJVi5wg/jgoMiL/VGAhTJKV8rzGcY7cHAckyiI
         4h8CEpsPvCuPn4XPjWDZUoFToFGaGINzogD4+BB2a5NxWHdSAgU1sat5QS57SoSC+k6x
         vSfkA3p8ZCdljSKmBX7Ba056kKZZUb+Vrg3czi8OEjG70p+i5p1axxYhS1j5WINsyZ7h
         bLVZyVWWEZeV1JjeEyZ8s1OC4gyzQePnZiGliUtZac/MpwUJU7/SEPec2PYjUN0ED1B5
         ORoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UF/lSvUut0wTX/5Q3Ag04kXxOsjZz8sIbrC77QnXiwE=;
        b=NxqqCypK6q4Q5LlEx6oea2hBhLpCKiDeJfavdBM05QdtKsrSB1YrutohLWXj/ISM1d
         jlQUbv8mnpI8s39qExJQhPDXLnGwVVLwlONRM7SjA9yHUMJOcvS4/EPasIMyV7CgWjyt
         gICKjoNcyCdd45HTsu3DCEH42zA6fpiO+00zt95iVBDColfnEu2lwT6zMxDbeJfkhu6V
         ih9jIJLb2MMSDKrGZMzbYwcmt8KwWvGo7Fahqwu5K3hObje3viPzFgsrty78P1LvYXhE
         2XzqzSHnY4UFW1z6WgqQ5sjpCnLwsyS85YWDQo4s1SjdzfVSmEOWcZRG/Mb2vsUSGijX
         jH/w==
X-Gm-Message-State: AOAM5300uunWClctVfmKRrQGv60RxQ/CR0k70FRn+rXMh+S6pmeVFb/9
        wtNMmHLvjmOTZsZdXICwbckb6J9eB1D5Aip0uv0=
X-Google-Smtp-Source: ABdhPJxNnelQ1tEIWLZ1EC2n1y47RUx6vgv9vOBSaaly27xdeVZrp7mmMrdJ8UulxkOF0vh6bUvlDtKtpq1+vttCOis=
X-Received: by 2002:a4a:d02a:: with SMTP id w10mr2598985oor.72.1619752248990;
 Thu, 29 Apr 2021 20:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210428151207.1212258-1-andrey.grodzovsky@amd.com>
 <20210428151207.1212258-4-andrey.grodzovsky@amd.com> <9276d340-261a-c96d-fe18-2d6b71ecd738@gmail.com>
In-Reply-To: <9276d340-261a-c96d-fe18-2d6b71ecd738@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 29 Apr 2021 23:10:38 -0400
Message-ID: <CADnq5_MOHbn+09XBi9jVM4J5t-18Piyt47TUPmQ0Hh=rGGSOZA@mail.gmail.com>
Subject: Re: [PATCH v5 03/27] drm/amdgpu: Split amdgpu_device_fini into early
 and late
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 29, 2021 at 3:04 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
>
>
> Am 28.04.21 um 17:11 schrieb Andrey Grodzovsky:
> > Some of the stuff in amdgpu_device_fini such as HW interrupts
> > disable and pending fences finilization must be done right away on
> > pci_remove while most of the stuff which relates to finilizing and
> > releasing driver data structures can be kept until
> > drm_driver.release hook is called, i.e. when the last device
> > reference is dropped.
> >
> > v4: Change functions prefix early->hw and late->sw
> >
> > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> But Alex should acknowledge this as well since it is general driver desig=
n.

Looks good to me as well.
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Christian.
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  6 ++++-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26 +++++++++++++++------=
-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  7 ++----
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 15 ++++++++++++-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c    | 26 +++++++++++++--------=
-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h    |  3 ++-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 12 +++++++++-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    |  1 +
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |  3 ++-
> >   drivers/gpu/drm/amd/amdgpu/cik_ih.c        |  2 +-
> >   drivers/gpu/drm/amd/amdgpu/cz_ih.c         |  2 +-
> >   drivers/gpu/drm/amd/amdgpu/iceland_ih.c    |  2 +-
> >   drivers/gpu/drm/amd/amdgpu/navi10_ih.c     |  2 +-
> >   drivers/gpu/drm/amd/amdgpu/si_ih.c         |  2 +-
> >   drivers/gpu/drm/amd/amdgpu/tonga_ih.c      |  2 +-
> >   drivers/gpu/drm/amd/amdgpu/vega10_ih.c     |  2 +-
> >   drivers/gpu/drm/amd/amdgpu/vega20_ih.c     |  2 +-
> >   17 files changed, 79 insertions(+), 36 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu.h
> > index 1af2fa1591fd..fddb82897e5d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -1073,7 +1073,9 @@ static inline struct amdgpu_device *amdgpu_ttm_ad=
ev(struct ttm_device *bdev)
> >
> >   int amdgpu_device_init(struct amdgpu_device *adev,
> >                      uint32_t flags);
> > -void amdgpu_device_fini(struct amdgpu_device *adev);
> > +void amdgpu_device_fini_hw(struct amdgpu_device *adev);
> > +void amdgpu_device_fini_sw(struct amdgpu_device *adev);
> > +
> >   int amdgpu_gpu_wait_for_idle(struct amdgpu_device *adev);
> >
> >   void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos=
,
> > @@ -1289,6 +1291,8 @@ void amdgpu_driver_lastclose_kms(struct drm_devic=
e *dev);
> >   int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *f=
ile_priv);
> >   void amdgpu_driver_postclose_kms(struct drm_device *dev,
> >                                struct drm_file *file_priv);
> > +void amdgpu_driver_release_kms(struct drm_device *dev);
> > +
> >   int amdgpu_device_ip_suspend(struct amdgpu_device *adev);
> >   int amdgpu_device_suspend(struct drm_device *dev, bool fbcon);
> >   int amdgpu_device_resume(struct drm_device *dev, bool fbcon);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index 6447cd6ca5a8..8d22b79fc1cd 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -3590,14 +3590,12 @@ int amdgpu_device_init(struct amdgpu_device *ad=
ev,
> >    * Tear down the driver info (all asics).
> >    * Called at driver shutdown.
> >    */
> > -void amdgpu_device_fini(struct amdgpu_device *adev)
> > +void amdgpu_device_fini_hw(struct amdgpu_device *adev)
> >   {
> >       dev_info(adev->dev, "amdgpu: finishing device.\n");
> >       flush_delayed_work(&adev->delayed_init_work);
> >       adev->shutdown =3D true;
> >
> > -     kfree(adev->pci_state);
> > -
> >       /* make sure IB test finished before entering exclusive mode
> >        * to avoid preemption on IB test
> >        * */
> > @@ -3614,11 +3612,24 @@ void amdgpu_device_fini(struct amdgpu_device *a=
dev)
> >               else
> >                       drm_atomic_helper_shutdown(adev_to_drm(adev));
> >       }
> > -     amdgpu_fence_driver_fini(adev);
> > +     amdgpu_fence_driver_fini_hw(adev);
> > +
> >       if (adev->pm_sysfs_en)
> >               amdgpu_pm_sysfs_fini(adev);
> > +     if (adev->ucode_sysfs_en)
> > +             amdgpu_ucode_sysfs_fini(adev);
> > +     sysfs_remove_files(&adev->dev->kobj, amdgpu_dev_attributes);
> > +
> > +
> >       amdgpu_fbdev_fini(adev);
> > +
> > +     amdgpu_irq_fini_hw(adev);
> > +}
> > +
> > +void amdgpu_device_fini_sw(struct amdgpu_device *adev)
> > +{
> >       amdgpu_device_ip_fini(adev);
> > +     amdgpu_fence_driver_fini_sw(adev);
> >       release_firmware(adev->firmware.gpu_info_fw);
> >       adev->firmware.gpu_info_fw =3D NULL;
> >       adev->accel_working =3D false;
> > @@ -3647,14 +3658,13 @@ void amdgpu_device_fini(struct amdgpu_device *a=
dev)
> >       adev->rmmio =3D NULL;
> >       amdgpu_device_doorbell_fini(adev);
> >
> > -     if (adev->ucode_sysfs_en)
> > -             amdgpu_ucode_sysfs_fini(adev);
> > -
> > -     sysfs_remove_files(&adev->dev->kobj, amdgpu_dev_attributes);
> >       if (IS_ENABLED(CONFIG_PERF_EVENTS))
> >               amdgpu_pmu_fini(adev);
> >       if (adev->mman.discovery_bin)
> >               amdgpu_discovery_fini(adev);
> > +
> > +     kfree(adev->pci_state);
> > +
> >   }
> >
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_drv.c
> > index 671ec1002230..54cb5ee2f563 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -1249,14 +1249,10 @@ amdgpu_pci_remove(struct pci_dev *pdev)
> >   {
> >       struct drm_device *dev =3D pci_get_drvdata(pdev);
> >
> > -#ifdef MODULE
> > -     if (THIS_MODULE->state !=3D MODULE_STATE_GOING)
> > -#endif
> > -             DRM_ERROR("Hotplug removal is not supported\n");
> >       drm_dev_unplug(dev);
> >       amdgpu_driver_unload_kms(dev);
> > +
> >       pci_disable_device(pdev);
> > -     pci_set_drvdata(pdev, NULL);
> >   }
> >
> >   static void
> > @@ -1587,6 +1583,7 @@ static const struct drm_driver amdgpu_kms_driver =
=3D {
> >       .dumb_create =3D amdgpu_mode_dumb_create,
> >       .dumb_map_offset =3D amdgpu_mode_dumb_mmap,
> >       .fops =3D &amdgpu_driver_kms_fops,
> > +     .release =3D &amdgpu_driver_release_kms,
> >
> >       .prime_handle_to_fd =3D drm_gem_prime_handle_to_fd,
> >       .prime_fd_to_handle =3D drm_gem_prime_fd_to_handle,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_fence.c
> > index 8e0a5650d383..34d51e962799 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > @@ -523,7 +523,7 @@ int amdgpu_fence_driver_init(struct amdgpu_device *=
adev)
> >    *
> >    * Tear down the fence driver for all possible rings (all asics).
> >    */
> > -void amdgpu_fence_driver_fini(struct amdgpu_device *adev)
> > +void amdgpu_fence_driver_fini_hw(struct amdgpu_device *adev)
> >   {
> >       unsigned i, j;
> >       int r;
> > @@ -544,6 +544,19 @@ void amdgpu_fence_driver_fini(struct amdgpu_device=
 *adev)
> >               if (!ring->no_scheduler)
> >                       drm_sched_fini(&ring->sched);
> >               del_timer_sync(&ring->fence_drv.fallback_timer);
> > +     }
> > +}
> > +
> > +void amdgpu_fence_driver_fini_sw(struct amdgpu_device *adev)
> > +{
> > +     unsigned int i, j;
> > +
> > +     for (i =3D 0; i < AMDGPU_MAX_RINGS; i++) {
> > +             struct amdgpu_ring *ring =3D adev->rings[i];
> > +
> > +             if (!ring || !ring->fence_drv.initialized)
> > +                     continue;
> > +
> >               for (j =3D 0; j <=3D ring->fence_drv.num_fences_mask; ++j=
)
> >                       dma_fence_put(ring->fence_drv.fences[j]);
> >               kfree(ring->fence_drv.fences);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_irq.c
> > index afbbec82a289..63e815c27585 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> > @@ -49,6 +49,7 @@
> >   #include <drm/drm_irq.h>
> >   #include <drm/drm_vblank.h>
> >   #include <drm/amdgpu_drm.h>
> > +#include <drm/drm_drv.h>
> >   #include "amdgpu.h"
> >   #include "amdgpu_ih.h"
> >   #include "atom.h"
> > @@ -313,6 +314,20 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
> >       return 0;
> >   }
> >
> > +
> > +void amdgpu_irq_fini_hw(struct amdgpu_device *adev)
> > +{
> > +     if (adev->irq.installed) {
> > +             drm_irq_uninstall(&adev->ddev);
> > +             adev->irq.installed =3D false;
> > +             if (adev->irq.msi_enabled)
> > +                     pci_free_irq_vectors(adev->pdev);
> > +
> > +             if (!amdgpu_device_has_dc_support(adev))
> > +                     flush_work(&adev->hotplug_work);
> > +     }
> > +}
> > +
> >   /**
> >    * amdgpu_irq_fini - shut down interrupt handling
> >    *
> > @@ -322,19 +337,10 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
> >    * functionality, shuts down vblank, hotplug and reset interrupt hand=
ling,
> >    * turns off interrupts from all sources (all ASICs).
> >    */
> > -void amdgpu_irq_fini(struct amdgpu_device *adev)
> > +void amdgpu_irq_fini_sw(struct amdgpu_device *adev)
> >   {
> >       unsigned i, j;
> >
> > -     if (adev->irq.installed) {
> > -             drm_irq_uninstall(adev_to_drm(adev));
> > -             adev->irq.installed =3D false;
> > -             if (adev->irq.msi_enabled)
> > -                     pci_free_irq_vectors(adev->pdev);
> > -             if (!amdgpu_device_has_dc_support(adev))
> > -                     flush_work(&adev->hotplug_work);
> > -     }
> > -
> >       for (i =3D 0; i < AMDGPU_IRQ_CLIENTID_MAX; ++i) {
> >               if (!adev->irq.client[i].sources)
> >                       continue;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_irq.h
> > index ac527e5deae6..392a7324e2b1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> > @@ -104,7 +104,8 @@ void amdgpu_irq_disable_all(struct amdgpu_device *a=
dev);
> >   irqreturn_t amdgpu_irq_handler(int irq, void *arg);
> >
> >   int amdgpu_irq_init(struct amdgpu_device *adev);
> > -void amdgpu_irq_fini(struct amdgpu_device *adev);
> > +void amdgpu_irq_fini_sw(struct amdgpu_device *adev);
> > +void amdgpu_irq_fini_hw(struct amdgpu_device *adev);
> >   int amdgpu_irq_add_id(struct amdgpu_device *adev,
> >                     unsigned client_id, unsigned src_id,
> >                     struct amdgpu_irq_src *source);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_kms.c
> > index 64beb3399604..1af3fba7bfd4 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > @@ -29,6 +29,7 @@
> >   #include "amdgpu.h"
> >   #include <drm/drm_debugfs.h>
> >   #include <drm/amdgpu_drm.h>
> > +#include <drm/drm_drv.h>
> >   #include "amdgpu_uvd.h"
> >   #include "amdgpu_vce.h"
> >   #include "atom.h"
> > @@ -93,7 +94,7 @@ void amdgpu_driver_unload_kms(struct drm_device *dev)
> >       }
> >
> >       amdgpu_acpi_fini(adev);
> > -     amdgpu_device_fini(adev);
> > +     amdgpu_device_fini_hw(adev);
> >   }
> >
> >   void amdgpu_register_gpu_instance(struct amdgpu_device *adev)
> > @@ -1151,6 +1152,15 @@ void amdgpu_driver_postclose_kms(struct drm_devi=
ce *dev,
> >       pm_runtime_put_autosuspend(dev->dev);
> >   }
> >
> > +
> > +void amdgpu_driver_release_kms(struct drm_device *dev)
> > +{
> > +     struct amdgpu_device *adev =3D drm_to_adev(dev);
> > +
> > +     amdgpu_device_fini_sw(adev);
> > +     pci_set_drvdata(adev->pdev, NULL);
> > +}
> > +
> >   /*
> >    * VBlank related functions.
> >    */
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ras.c
> > index 1fb2a91ad30a..c0a16eac4923 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > @@ -2142,6 +2142,7 @@ int amdgpu_ras_pre_fini(struct amdgpu_device *ade=
v)
> >       if (!con)
> >               return 0;
> >
> > +
> >       /* Need disable ras on all IPs here before ip [hw/sw]fini */
> >       amdgpu_ras_disable_all_features(adev, 0);
> >       amdgpu_ras_recovery_fini(adev);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ring.h
> > index 56acec1075ac..0f195f7bf797 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > @@ -107,7 +107,8 @@ struct amdgpu_fence_driver {
> >   };
> >
> >   int amdgpu_fence_driver_init(struct amdgpu_device *adev);
> > -void amdgpu_fence_driver_fini(struct amdgpu_device *adev);
> > +void amdgpu_fence_driver_fini_hw(struct amdgpu_device *adev);
> > +void amdgpu_fence_driver_fini_sw(struct amdgpu_device *adev);
> >   void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
> >
> >   int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c b/drivers/gpu/drm/amd/=
amdgpu/cik_ih.c
> > index d3745711d55f..183d44a6583c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
> > @@ -309,7 +309,7 @@ static int cik_ih_sw_fini(void *handle)
> >   {
> >       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> >
> > -     amdgpu_irq_fini(adev);
> > +     amdgpu_irq_fini_sw(adev);
> >       amdgpu_ih_ring_fini(adev, &adev->irq.ih);
> >       amdgpu_irq_remove_domain(adev);
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c b/drivers/gpu/drm/amd/a=
mdgpu/cz_ih.c
> > index 307c01301c87..d32743949003 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
> > @@ -301,7 +301,7 @@ static int cz_ih_sw_fini(void *handle)
> >   {
> >       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> >
> > -     amdgpu_irq_fini(adev);
> > +     amdgpu_irq_fini_sw(adev);
> >       amdgpu_ih_ring_fini(adev, &adev->irq.ih);
> >       amdgpu_irq_remove_domain(adev);
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c b/drivers/gpu/drm/=
amd/amdgpu/iceland_ih.c
> > index cc957471f31e..da96c6013477 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
> > @@ -300,7 +300,7 @@ static int iceland_ih_sw_fini(void *handle)
> >   {
> >       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> >
> > -     amdgpu_irq_fini(adev);
> > +     amdgpu_irq_fini_sw(adev);
> >       amdgpu_ih_ring_fini(adev, &adev->irq.ih);
> >       amdgpu_irq_remove_domain(adev);
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/a=
md/amdgpu/navi10_ih.c
> > index f4e4040bbd25..5eea4550b856 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> > @@ -569,7 +569,7 @@ static int navi10_ih_sw_fini(void *handle)
> >   {
> >       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> >
> > -     amdgpu_irq_fini(adev);
> > +     amdgpu_irq_fini_sw(adev);
> >       amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);
> >       amdgpu_ih_ring_fini(adev, &adev->irq.ih2);
> >       amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c b/drivers/gpu/drm/amd/a=
mdgpu/si_ih.c
> > index 51880f6ef634..751307f3252c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
> > @@ -175,7 +175,7 @@ static int si_ih_sw_fini(void *handle)
> >   {
> >       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> >
> > -     amdgpu_irq_fini(adev);
> > +     amdgpu_irq_fini_sw(adev);
> >       amdgpu_ih_ring_fini(adev, &adev->irq.ih);
> >
> >       return 0;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/am=
d/amdgpu/tonga_ih.c
> > index 249fcbee7871..973d80ec7f6c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> > @@ -312,7 +312,7 @@ static int tonga_ih_sw_fini(void *handle)
> >   {
> >       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> >
> > -     amdgpu_irq_fini(adev);
> > +     amdgpu_irq_fini_sw(adev);
> >       amdgpu_ih_ring_fini(adev, &adev->irq.ih);
> >       amdgpu_irq_remove_domain(adev);
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/a=
md/amdgpu/vega10_ih.c
> > index 88626d83e07b..2d0094c276ca 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> > @@ -523,7 +523,7 @@ static int vega10_ih_sw_fini(void *handle)
> >   {
> >       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> >
> > -     amdgpu_irq_fini(adev);
> > +     amdgpu_irq_fini_sw(adev);
> >       amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);
> >       amdgpu_ih_ring_fini(adev, &adev->irq.ih2);
> >       amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/a=
md/amdgpu/vega20_ih.c
> > index 5a3c867d5881..9059b21b079f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> > @@ -558,7 +558,7 @@ static int vega20_ih_sw_fini(void *handle)
> >   {
> >       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> >
> > -     amdgpu_irq_fini(adev);
> > +     amdgpu_irq_fini_sw(adev);
> >       amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);
> >       amdgpu_ih_ring_fini(adev, &adev->irq.ih2);
> >       amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
