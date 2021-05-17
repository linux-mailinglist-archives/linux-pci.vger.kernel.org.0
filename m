Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450E3383CC7
	for <lists+linux-pci@lfdr.de>; Mon, 17 May 2021 20:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237346AbhEQS6I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 May 2021 14:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbhEQS6I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 May 2021 14:58:08 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B19C061573
        for <linux-pci@vger.kernel.org>; Mon, 17 May 2021 11:56:50 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so6476775otg.2
        for <linux-pci@vger.kernel.org>; Mon, 17 May 2021 11:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kgCDzON2LQ0I20HT7JO8ZVEI4np/E0DaLMXnfz3i4GE=;
        b=P7SNNSD5yGtQfHlkILGXWUu95Q0ZJd2msjwte0cOVeZdVJWoeD0yLN0gBgtCyh9w2Y
         fSzBDa3iSa/t7Fu7CQ5yM/e4Tz0gCFmMNc4eczEY9Nd0MnUIaB2BcIFbK3GqDDWOC/EQ
         +fVY0Lm24w1dP98sbalitITWUn/8etAv108hNRXAOg/e6tlPA53Lde8an1WZesv9TxUh
         FTEx0C8xd2UPsq5TkjFoh3mv1hGLIhccrHM+rvRA4A3/tulmhUFaCmKa82J7Z0oHePot
         97F+6pyNNnQnWSYpTvAlMT2vjBI8PAq32jqWyU8u+n2usxaEtvXeNdzJ4Wi3bWfM1JRx
         L8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kgCDzON2LQ0I20HT7JO8ZVEI4np/E0DaLMXnfz3i4GE=;
        b=gDMh4M4iXAEVzGNeEkVG9tgPtRZdIg8O2bQayeM6eOgp4AHT9AAUzvw8aRH20m8NB9
         ypPrrGQV0URwSK8NuM/I8nPjRIlBDwPZMysQynZJdv7ETctNkmNke3fV96KWamEv3iEE
         b67NkP1U5U9ZJGOC2RKflB1xD96y4NjFT9YDj9AjNFOHaO/NADvJnU5dp1lmViN2gitT
         Jwmod4d5S2/TBTAOfkBI7aNxwS3dbc5dDKPA94u9HYvcyQspRCCur4UXGWUcr6DU5COA
         UBs4eM9K7B13kdH6uAukQsAKyZKVAk4fhe1EAyPQL0aZhu1LNWcXPuHDysuloXvNrFZq
         YRmg==
X-Gm-Message-State: AOAM5322xQotB+KTRfw0rlTtekxbNgGb5VIo+QaqXD31WjGQwSzzAkKn
        7g7MBRu/oavnwAdRwr2JFtIam5EQXkflaS3SiMc=
X-Google-Smtp-Source: ABdhPJxexUIKMJXrucoug+LNQa5T+ojtNy+qPzeMwkirJhW3hSi5bzxgX3KFHSrO3FPq50K/B0WYcUis0+Z1tPRnsns=
X-Received: by 2002:a9d:57cd:: with SMTP id q13mr860880oti.23.1621277810147;
 Mon, 17 May 2021 11:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210512142648.666476-1-andrey.grodzovsky@amd.com>
 <20210512142648.666476-17-andrey.grodzovsky@amd.com> <CADnq5_M-Sy3cF762044Ub9J=N_U6uQ2h2j40Y=fof04dXL5h7w@mail.gmail.com>
 <1882dd85-7ac6-8e54-b66d-fe09718d0262@amd.com>
In-Reply-To: <1882dd85-7ac6-8e54-b66d-fe09718d0262@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 17 May 2021 14:56:38 -0400
Message-ID: <CADnq5_N1EDO326hwG_3QKk9hsDwVZq1CqbEHgveN4pg6rF3zww@mail.gmail.com>
Subject: Re: [PATCH v7 16/16] drm/amdgpu: Unmap all MMIO mappings
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc:     Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 17, 2021 at 2:46 PM Andrey Grodzovsky
<andrey.grodzovsky@amd.com> wrote:
>
>
>
> On 2021-05-17 1:43 p.m., Alex Deucher wrote:
> > On Wed, May 12, 2021 at 10:27 AM Andrey Grodzovsky
> > <andrey.grodzovsky@amd.com> wrote:
> >>
> >> Access to those must be prevented post pci_remove
> >>
> >> v6: Drop BOs list, unampping VRAM BAR is enough.
> >>
> >> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 24 +++++++++++++++++++---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  1 +
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |  4 ----
> >>   3 files changed, 22 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> index f7cca25c0fa0..73cbc3c7453f 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> @@ -3666,6 +3666,25 @@ int amdgpu_device_init(struct amdgpu_device *adev,
> >>          return r;
> >>   }
> >>
> >> +static void amdgpu_device_unmap_mmio(struct amdgpu_device *adev)
> >> +{
> >> +       /* Clear all CPU mappings pointing to this device */
> >> +       unmap_mapping_range(adev->ddev.anon_inode->i_mapping, 0, 0, 1);
> >> +
> >> +       /* Unmap all mapped bars - Doorbell, registers and VRAM */
> >> +       amdgpu_device_doorbell_fini(adev);
> >> +
> >> +       iounmap(adev->rmmio);
> >> +       adev->rmmio = NULL;
> >> +       if (adev->mman.aper_base_kaddr)
> >> +               iounmap(adev->mman.aper_base_kaddr);
> >> +       adev->mman.aper_base_kaddr = NULL;
> >> +
> >> +       /* Memory manager related */
> >
> > I think we need:
> > if (!adev->gmc.xgmi.connected_to_cpu) {
> > around these two to mirror amdgpu_bo_fini().
> >
> > Alex
>
> I am working of off drm-misc-next and here amdgpu_xgmi
> doesn't have connected_to_cpu yet.

Ah, right.  Ok.  Do we need to remove the code from bo_fini() if we
handle it here now?

Alex


>
> Andrey
>
> >
> >> +       arch_phys_wc_del(adev->gmc.vram_mtrr);
> >> +       arch_io_free_memtype_wc(adev->gmc.aper_base, adev->gmc.aper_size);
> >> +}
> >> +
> >>   /**
> >>    * amdgpu_device_fini - tear down the driver
> >>    *
> >> @@ -3712,6 +3731,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
> >>          amdgpu_device_ip_fini_early(adev);
> >>
> >>          amdgpu_gart_dummy_page_fini(adev);
> >> +
> >> +       amdgpu_device_unmap_mmio(adev);
> >>   }
> >>
> >>   void amdgpu_device_fini_sw(struct amdgpu_device *adev)
> >> @@ -3739,9 +3760,6 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
> >>          }
> >>          if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
> >>                  vga_client_register(adev->pdev, NULL, NULL, NULL);
> >> -       iounmap(adev->rmmio);
> >> -       adev->rmmio = NULL;
> >> -       amdgpu_device_doorbell_fini(adev);
> >>
> >>          if (IS_ENABLED(CONFIG_PERF_EVENTS))
> >>                  amdgpu_pmu_fini(adev);
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> >> index 0adffcace326..882fb49f3c41 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> >> @@ -533,6 +533,7 @@ static int amdgpu_bo_do_create(struct amdgpu_device *adev,
> >>                  return -ENOMEM;
> >>          drm_gem_private_object_init(adev_to_drm(adev), &bo->tbo.base, size);
> >>          INIT_LIST_HEAD(&bo->shadow_list);
> >> +
> >>          bo->vm_bo = NULL;
> >>          bo->preferred_domains = bp->preferred_domain ? bp->preferred_domain :
> >>                  bp->domain;
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >> index 0d54e70278ca..58ad2fecc9e3 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >> @@ -1841,10 +1841,6 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
> >>          amdgpu_bo_free_kernel(&adev->mman.discovery_memory, NULL, NULL);
> >>          amdgpu_ttm_fw_reserve_vram_fini(adev);
> >>
> >> -       if (adev->mman.aper_base_kaddr)
> >> -               iounmap(adev->mman.aper_base_kaddr);
> >> -       adev->mman.aper_base_kaddr = NULL;
> >> -
> >>          amdgpu_vram_mgr_fini(adev);
> >>          amdgpu_gtt_mgr_fini(adev);
> >>          ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_GDS);
> >> --
> >> 2.25.1
> >>
