Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07C037AB32
	for <lists+linux-pci@lfdr.de>; Tue, 11 May 2021 17:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbhEKP5u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 May 2021 11:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbhEKP5u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 May 2021 11:57:50 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9807EC061574
        for <linux-pci@vger.kernel.org>; Tue, 11 May 2021 08:56:43 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id w22so5579680oiw.9
        for <linux-pci@vger.kernel.org>; Tue, 11 May 2021 08:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h7iIYF45nkSj7+g5JYXYO46CGjK7fSopGYuVYNTNps0=;
        b=I9MP1cP7gv8cqPNcmQDtTYNtqJ4PB4CylSFQh+goQYWbz50b9wOkMIhOszhCNA4BJX
         bAq6J7wjlHz4WfQ9Vc/N64YcxTTYOefrdjPVvErHp8kFfo1f2eFHWQCseZbUwoaKFGn1
         TU3Gmhrnx7oqRdejuwja+Ta2yxvk0X8uAGRPyo/zwzP6wVEV5fjx0/aJj4M62cKfPryV
         g5UnifHf7U1sA/v7IbNcCYLUP/yCwoJyO0bRg6Ls18RptGpVYKa7Wy5COmVAVqld/4Gk
         nWrMIz7B2JffLhfBAQus5CwtCeFfObhVkGE8/rc01pi8M41At4brUFPpl1LRm3uOU26M
         s/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h7iIYF45nkSj7+g5JYXYO46CGjK7fSopGYuVYNTNps0=;
        b=bEmbCfvdiAPmKxNI7oR97lsKRekCTFzok1eYW/Ytckaemm3sUa5xAN5MtwFunbJWIF
         PIr15NnxqQtTdkVCZTj4vU7fnjPnXl89Lp9wPT9C0f0FUri8p6HQjWDRcIAuAD+CHOzS
         un9o0+RbVAZV4HsUrimyaKVBObi4KUGAZi8PnicI1LyELBTW7LyG7Swzhj4pQancfP1l
         et8JGGWdJEkyzjaeSCIAPgMLW6L5wTu66L7sSzQ2gmpXZekeEERWrP9jXthCbIIQrXYN
         QOQLa7ORdV+2hX9oTvFuLa7cKkjjk6P3TtY+o5j5PqJcM5YQ45pfYGD2PTJJnfzcCVqm
         Kc3Q==
X-Gm-Message-State: AOAM531pKaGiNGU50hGpV6eGWN1RjckMY/6lzYgThvMoXDBS00bAwjjk
        O/SzksNVNFQ/DBjCrGKGl1iWMnwEUYxezGOsrfA=
X-Google-Smtp-Source: ABdhPJwRvCxLeiNcki/dxN9rN0hqGVEzuBvVEkbqHLe4xF644D25Kdv7Sq8e4RZJx6qQwPZlDrpnT6JzIew7eUKFWzA=
X-Received: by 2002:aca:fc50:: with SMTP id a77mr22893488oii.123.1620748603019;
 Tue, 11 May 2021 08:56:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210510163625.407105-1-andrey.grodzovsky@amd.com> <20210510163625.407105-7-andrey.grodzovsky@amd.com>
In-Reply-To: <20210510163625.407105-7-andrey.grodzovsky@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 11 May 2021 11:56:32 -0400
Message-ID: <CADnq5_MNd+2BLV-v9EJPR-zwW_qT4UVLMRowyY2_tEvsQRYvew@mail.gmail.com>
Subject: Re: [PATCH v6 06/16] drm/amdgpu: Handle IOMMU enabled case.
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

On Mon, May 10, 2021 at 12:37 PM Andrey Grodzovsky
<andrey.grodzovsky@amd.com> wrote:
>
> Handle all DMA IOMMU gropup related dependencies before the
> group is removed.
>
> v5: Drop IOMMU notifier and switch to lockless call to ttm_tt_unpopulate
> v6: Drop the BO unamp list
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c   | 3 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h   | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c    | 9 +++++++++
>  drivers/gpu/drm/amd/amdgpu/cik_ih.c        | 1 -
>  drivers/gpu/drm/amd/amdgpu/cz_ih.c         | 1 -
>  drivers/gpu/drm/amd/amdgpu/iceland_ih.c    | 1 -
>  drivers/gpu/drm/amd/amdgpu/navi10_ih.c     | 3 ---
>  drivers/gpu/drm/amd/amdgpu/si_ih.c         | 1 -
>  drivers/gpu/drm/amd/amdgpu/tonga_ih.c      | 1 -
>  drivers/gpu/drm/amd/amdgpu/vega10_ih.c     | 3 ---
>  11 files changed, 13 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 18598eda18f6..a0bff4713672 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3256,7 +3256,6 @@ static const struct attribute *amdgpu_dev_attributes[] = {
>         NULL
>  };
>
> -
>  /**
>   * amdgpu_device_init - initialize the driver
>   *
> @@ -3698,12 +3697,13 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
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
> +       amdgpu_gart_dummy_page_fini(adev);
>  }
>
>  void amdgpu_device_fini_sw(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> index c5a9a4fb10d2..354e68081b53 100644
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
> @@ -375,5 +375,4 @@ int amdgpu_gart_init(struct amdgpu_device *adev)
>   */
>  void amdgpu_gart_fini(struct amdgpu_device *adev)
>  {
> -       amdgpu_gart_dummy_page_fini(adev);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
> index a25fe97b0196..78dc7a23da56 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
> @@ -58,6 +58,7 @@ int amdgpu_gart_table_vram_pin(struct amdgpu_device *adev);
>  void amdgpu_gart_table_vram_unpin(struct amdgpu_device *adev);
>  int amdgpu_gart_init(struct amdgpu_device *adev);
>  void amdgpu_gart_fini(struct amdgpu_device *adev);
> +void amdgpu_gart_dummy_page_fini(struct amdgpu_device *adev);
>  int amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
>                        int pages);
>  int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index 233b64dab94b..a14973a7a9c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -361,6 +361,15 @@ void amdgpu_irq_fini_hw(struct amdgpu_device *adev)
>                 if (!amdgpu_device_has_dc_support(adev))
>                         flush_work(&adev->hotplug_work);
>         }
> +
> +       if (adev->irq.ih_soft.ring)
> +               amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);

Why is the ih_soft handled here and in the various ih sw_fini functions?

> +       if (adev->irq.ih.ring)
> +               amdgpu_ih_ring_fini(adev, &adev->irq.ih);
> +       if (adev->irq.ih1.ring)
> +               amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
> +       if (adev->irq.ih2.ring)
> +               amdgpu_ih_ring_fini(adev, &adev->irq.ih2);
>  }
>
>  /**
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
> index dead9c2fbd4c..d78b8abe993a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> @@ -515,9 +515,6 @@ static int vega10_ih_sw_fini(void *handle)
>
>         amdgpu_irq_fini_sw(adev);
>         amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);
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
