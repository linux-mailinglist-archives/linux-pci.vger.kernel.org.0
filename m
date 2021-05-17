Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDEC383B89
	for <lists+linux-pci@lfdr.de>; Mon, 17 May 2021 19:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237222AbhEQRpC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 May 2021 13:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236945AbhEQRpB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 May 2021 13:45:01 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B24C061573
        for <linux-pci@vger.kernel.org>; Mon, 17 May 2021 10:43:44 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id t10-20020a05683022eab0290304ed8bc759so6246538otc.12
        for <linux-pci@vger.kernel.org>; Mon, 17 May 2021 10:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XLJb2IgEQ7K/5rtBcAtSxUKX2z5zxyllknUa3sXOl3g=;
        b=ZYxJcblAPpZU8V2LI3hVlKVW5Wz5qhTURVLlQyyLuk4/QBK+m4JgtOGlbbXMas51n5
         ECnv62KZTMKgiQjY1ch1scZyPlyWZ9iO2d/LcBWJniGK/T3MavCALQHKT/GTVwoFEL6Y
         A/sb76Y6cYeXGtPFI+V2StSIqI+AVhdQWIgqiifoIry4RStlNUMwgBMFYxpGQWdGfpOX
         3m+aVtT5wm+jNH0zyKk9VuKGQKgwPpUOA2TLPV5ZUcvDGX2XIgNv59B+3kie4iduZ41Y
         LgpPaWQ8lcGTrcwtLqjLfW1bIX6SRNNNAY8Ut2FNMLn3BehEwQrik0AGPCa+359ooti6
         YyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XLJb2IgEQ7K/5rtBcAtSxUKX2z5zxyllknUa3sXOl3g=;
        b=lnTfkhAy14gjC8yQ+sfqQPPYQZPcHZz0ZsP8FPi+MSFq7kgyrq8YUpdUphBpwloEzg
         uzZsGIv8Elj7A2DQ/BqzQRLecCa3JBx2Snhge8pQs6mNyPpGEarSNGu6MzCAyD+BbMU7
         8Y6R7Ln6SizLMfs1R5/BPbfs/s7WDT32PhvT7Hb4KOuNtT2INrax268FPce5Gm5wEKsW
         2oSgljFkDL6copdmeAjDf0n3rJ0Fyala3ey3YrioZVHpIuIH/tOw5fpVXpcCL4UkyZTH
         74Mjtyikkw9VQl80FiTeNCuJ1ZypOtCYCb9afs+Qu2yffdsIDlNBuOq9WyTytj151q9m
         rxjw==
X-Gm-Message-State: AOAM532tOgxLa/nFBFnBZoTcFg7P+8V9zOqmszzTVyPycGif/R5md2kI
        wXdM2w1gabeuL/EOfi2ydgy51XJKfm8Amsp6YXw=
X-Google-Smtp-Source: ABdhPJwGh1Cb43ILuKcyyuub39Gsc7SKqokFQCOnj1kkmOqfs4JHoh7R00inYAupP1KvSvDsT3Mwl0jz7zL7dcRgOCE=
X-Received: by 2002:a9d:74c6:: with SMTP id a6mr636450otl.132.1621273424021;
 Mon, 17 May 2021 10:43:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210512142648.666476-1-andrey.grodzovsky@amd.com> <20210512142648.666476-17-andrey.grodzovsky@amd.com>
In-Reply-To: <20210512142648.666476-17-andrey.grodzovsky@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 17 May 2021 13:43:33 -0400
Message-ID: <CADnq5_M-Sy3cF762044Ub9J=N_U6uQ2h2j40Y=fof04dXL5h7w@mail.gmail.com>
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

On Wed, May 12, 2021 at 10:27 AM Andrey Grodzovsky
<andrey.grodzovsky@amd.com> wrote:
>
> Access to those must be prevented post pci_remove
>
> v6: Drop BOs list, unampping VRAM BAR is enough.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 24 +++++++++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |  4 ----
>  3 files changed, 22 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index f7cca25c0fa0..73cbc3c7453f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3666,6 +3666,25 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>         return r;
>  }
>
> +static void amdgpu_device_unmap_mmio(struct amdgpu_device *adev)
> +{
> +       /* Clear all CPU mappings pointing to this device */
> +       unmap_mapping_range(adev->ddev.anon_inode->i_mapping, 0, 0, 1);
> +
> +       /* Unmap all mapped bars - Doorbell, registers and VRAM */
> +       amdgpu_device_doorbell_fini(adev);
> +
> +       iounmap(adev->rmmio);
> +       adev->rmmio = NULL;
> +       if (adev->mman.aper_base_kaddr)
> +               iounmap(adev->mman.aper_base_kaddr);
> +       adev->mman.aper_base_kaddr = NULL;
> +
> +       /* Memory manager related */

I think we need:
if (!adev->gmc.xgmi.connected_to_cpu) {
around these two to mirror amdgpu_bo_fini().

Alex

> +       arch_phys_wc_del(adev->gmc.vram_mtrr);
> +       arch_io_free_memtype_wc(adev->gmc.aper_base, adev->gmc.aper_size);
> +}
> +
>  /**
>   * amdgpu_device_fini - tear down the driver
>   *
> @@ -3712,6 +3731,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>         amdgpu_device_ip_fini_early(adev);
>
>         amdgpu_gart_dummy_page_fini(adev);
> +
> +       amdgpu_device_unmap_mmio(adev);
>  }
>
>  void amdgpu_device_fini_sw(struct amdgpu_device *adev)
> @@ -3739,9 +3760,6 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>         }
>         if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
>                 vga_client_register(adev->pdev, NULL, NULL, NULL);
> -       iounmap(adev->rmmio);
> -       adev->rmmio = NULL;
> -       amdgpu_device_doorbell_fini(adev);
>
>         if (IS_ENABLED(CONFIG_PERF_EVENTS))
>                 amdgpu_pmu_fini(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 0adffcace326..882fb49f3c41 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -533,6 +533,7 @@ static int amdgpu_bo_do_create(struct amdgpu_device *adev,
>                 return -ENOMEM;
>         drm_gem_private_object_init(adev_to_drm(adev), &bo->tbo.base, size);
>         INIT_LIST_HEAD(&bo->shadow_list);
> +
>         bo->vm_bo = NULL;
>         bo->preferred_domains = bp->preferred_domain ? bp->preferred_domain :
>                 bp->domain;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 0d54e70278ca..58ad2fecc9e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1841,10 +1841,6 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>         amdgpu_bo_free_kernel(&adev->mman.discovery_memory, NULL, NULL);
>         amdgpu_ttm_fw_reserve_vram_fini(adev);
>
> -       if (adev->mman.aper_base_kaddr)
> -               iounmap(adev->mman.aper_base_kaddr);
> -       adev->mman.aper_base_kaddr = NULL;
> -
>         amdgpu_vram_mgr_fini(adev);
>         amdgpu_gtt_mgr_fini(adev);
>         ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_GDS);
> --
> 2.25.1
>
