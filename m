Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B342379FE2
	for <lists+linux-pci@lfdr.de>; Tue, 11 May 2021 08:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhEKGpY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 May 2021 02:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhEKGpY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 May 2021 02:45:24 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC02C061574
        for <linux-pci@vger.kernel.org>; Mon, 10 May 2021 23:44:16 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id s6so21493798edu.10
        for <linux-pci@vger.kernel.org>; Mon, 10 May 2021 23:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=EjGFTDi2E6QAktR52Oi81JrStSsiVRqJYuc2OahOedw=;
        b=JNAnLRvKnXdpxhGrOhRYGL2hHp656pZ2w66UNuV2LOipjGr+5mP41VfKO0zfy8eXpq
         b4jV/n2NJLZomOUfzuOrGmDkkB1beeOixZdCFCz6qLLdS8FqZ7AtNFWavzP9nX1DbTpf
         +UMO9B+Aq8VevnK75X8ha0sF8iwrv2/nqqv4GRDPli8cZw9a8i4cwxUtBm4AHgttL/XS
         PzFrthITiBDZhVMv4m2OyyJDkB8H693GPS4z3lsEW/t59c9vV28ude0YtDY4V8XFgF91
         5jixUwXLnnenk9S4F78CqTjdtvaVg29VJJL7Xh2S2/MOq8JHnKr8Q0TAMuyHgE18QO8U
         y2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=EjGFTDi2E6QAktR52Oi81JrStSsiVRqJYuc2OahOedw=;
        b=II8O9/x3RX55I8n3J94WvWfZg4FnX5W334YYYIdnAT02O2y2v0zcXBDXG4/GsBPch0
         FKWjq9oGChWBRZ+FbLq75lnQPG5yyJgVr6bY9cKGn4Ojfn+RRZJhNvooniUrW6om5uIk
         fL0P14xvbMF2Ufwkcvfh+DV901zieXfDSD34pgRQVslJf5mOSyn2ePWAYnNCL6cXXSUA
         dJcY7NbTlnLmQJWA4ndYBhz1wkr8HYrjNMxOiR+VM7GraT/aZ7cOK6O4tupXjwjj1RCF
         nlzpTgZrEAb7lOdb9ZxaNMHU/WotoGPgncf8n57RC1Md/3aBVFj5FLTsKmSmnj82T2PX
         bW1g==
X-Gm-Message-State: AOAM530gvhnvag2RQ1KxjbClOci5e+Qeg6hCIconIAAkcgN62iurreGA
        PVTwJQv25nYDKFK/rHJvST8=
X-Google-Smtp-Source: ABdhPJyhdTWSVirGUhoMnOMV2CCtbk93+keU6unscGaW/NIZYhbqBFpgD1rIOQ0EqqJjl4Kf95QmUg==
X-Received: by 2002:aa7:cf8d:: with SMTP id z13mr34621718edx.104.1620715455607;
        Mon, 10 May 2021 23:44:15 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:c3ab:ee01:d547:2c4e? ([2a02:908:1252:fb60:c3ab:ee01:d547:2c4e])
        by smtp.gmail.com with ESMTPSA id p13sm10604117ejr.87.2021.05.10.23.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 23:44:15 -0700 (PDT)
Subject: Re: [PATCH v6 06/16] drm/amdgpu: Handle IOMMU enabled case.
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-pci@vger.kernel.org, daniel.vetter@ffwll.ch,
        Harry.Wentland@amd.com
Cc:     ppaalanen@gmail.com, Alexander.Deucher@amd.com,
        gregkh@linuxfoundation.org, helgaas@kernel.org,
        Felix.Kuehling@amd.com
References: <20210510163625.407105-1-andrey.grodzovsky@amd.com>
 <20210510163625.407105-7-andrey.grodzovsky@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <2debf57e-e775-8e47-6862-489bada7701c@gmail.com>
Date:   Tue, 11 May 2021 08:44:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210510163625.407105-7-andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 10.05.21 um 18:36 schrieb Andrey Grodzovsky:
> Handle all DMA IOMMU gropup related dependencies before the
> group is removed.
>
> v5: Drop IOMMU notifier and switch to lockless call to ttm_tt_unpopulate
> v6: Drop the BO unamp list
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c   | 3 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h   | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c    | 9 +++++++++
>   drivers/gpu/drm/amd/amdgpu/cik_ih.c        | 1 -
>   drivers/gpu/drm/amd/amdgpu/cz_ih.c         | 1 -
>   drivers/gpu/drm/amd/amdgpu/iceland_ih.c    | 1 -
>   drivers/gpu/drm/amd/amdgpu/navi10_ih.c     | 3 ---
>   drivers/gpu/drm/amd/amdgpu/si_ih.c         | 1 -
>   drivers/gpu/drm/amd/amdgpu/tonga_ih.c      | 1 -
>   drivers/gpu/drm/amd/amdgpu/vega10_ih.c     | 3 ---
>   11 files changed, 13 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 18598eda18f6..a0bff4713672 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3256,7 +3256,6 @@ static const struct attribute *amdgpu_dev_attributes[] = {
>   	NULL
>   };
>   
> -
>   /**
>    * amdgpu_device_init - initialize the driver
>    *
> @@ -3698,12 +3697,13 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>   		amdgpu_ucode_sysfs_fini(adev);
>   	sysfs_remove_files(&adev->dev->kobj, amdgpu_dev_attributes);
>   
> -
>   	amdgpu_fbdev_fini(adev);
>   
>   	amdgpu_irq_fini_hw(adev);
>   
>   	amdgpu_device_ip_fini_early(adev);
> +
> +	amdgpu_gart_dummy_page_fini(adev);

I think you should probably just call amdgpu_gart_fini() here.

>   }
>   
>   void amdgpu_device_fini_sw(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> index c5a9a4fb10d2..354e68081b53 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> @@ -92,7 +92,7 @@ static int amdgpu_gart_dummy_page_init(struct amdgpu_device *adev)
>    *
>    * Frees the dummy page used by the driver (all asics).
>    */
> -static void amdgpu_gart_dummy_page_fini(struct amdgpu_device *adev)
> +void amdgpu_gart_dummy_page_fini(struct amdgpu_device *adev)
>   {
>   	if (!adev->dummy_page_addr)
>   		return;
> @@ -375,5 +375,4 @@ int amdgpu_gart_init(struct amdgpu_device *adev)
>    */
>   void amdgpu_gart_fini(struct amdgpu_device *adev)
>   {
> -	amdgpu_gart_dummy_page_fini(adev);
>   }

Well either you remove amdgpu_gart_fini() or just call 
amdgpu_gart_fini() instead of amdgpu_gart_dummy_page_fini().

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
> index a25fe97b0196..78dc7a23da56 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
> @@ -58,6 +58,7 @@ int amdgpu_gart_table_vram_pin(struct amdgpu_device *adev);
>   void amdgpu_gart_table_vram_unpin(struct amdgpu_device *adev);
>   int amdgpu_gart_init(struct amdgpu_device *adev);
>   void amdgpu_gart_fini(struct amdgpu_device *adev);
> +void amdgpu_gart_dummy_page_fini(struct amdgpu_device *adev);
>   int amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
>   		       int pages);
>   int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index 233b64dab94b..a14973a7a9c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -361,6 +361,15 @@ void amdgpu_irq_fini_hw(struct amdgpu_device *adev)
>   		if (!amdgpu_device_has_dc_support(adev))
>   			flush_work(&adev->hotplug_work);
>   	}
> +
> +	if (adev->irq.ih_soft.ring)
> +		amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);
> +	if (adev->irq.ih.ring)
> +		amdgpu_ih_ring_fini(adev, &adev->irq.ih);
> +	if (adev->irq.ih1.ring)
> +		amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
> +	if (adev->irq.ih2.ring)
> +		amdgpu_ih_ring_fini(adev, &adev->irq.ih2);

You should probably make the function NULL save instead of checking here.

Christian.

>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
> index 183d44a6583c..df385ffc9768 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
> @@ -310,7 +310,6 @@ static int cik_ih_sw_fini(void *handle)
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
>   	amdgpu_irq_fini_sw(adev);
> -	amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>   	amdgpu_irq_remove_domain(adev);
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
> index d32743949003..b8c47e0cf37a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
> @@ -302,7 +302,6 @@ static int cz_ih_sw_fini(void *handle)
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
>   	amdgpu_irq_fini_sw(adev);
> -	amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>   	amdgpu_irq_remove_domain(adev);
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
> index da96c6013477..ddfe4eaeea05 100644
> --- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
> @@ -301,7 +301,6 @@ static int iceland_ih_sw_fini(void *handle)
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
>   	amdgpu_irq_fini_sw(adev);
> -	amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>   	amdgpu_irq_remove_domain(adev);
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> index 5eea4550b856..e171a9e78544 100644
> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> @@ -571,9 +571,6 @@ static int navi10_ih_sw_fini(void *handle)
>   
>   	amdgpu_irq_fini_sw(adev);
>   	amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);
> -	amdgpu_ih_ring_fini(adev, &adev->irq.ih2);
> -	amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
> -	amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c b/drivers/gpu/drm/amd/amdgpu/si_ih.c
> index 751307f3252c..9a24f17a5750 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
> @@ -176,7 +176,6 @@ static int si_ih_sw_fini(void *handle)
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
>   	amdgpu_irq_fini_sw(adev);
> -	amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> index 973d80ec7f6c..b08905d1c00f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> @@ -313,7 +313,6 @@ static int tonga_ih_sw_fini(void *handle)
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
>   	amdgpu_irq_fini_sw(adev);
> -	amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>   	amdgpu_irq_remove_domain(adev);
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> index dead9c2fbd4c..d78b8abe993a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> @@ -515,9 +515,6 @@ static int vega10_ih_sw_fini(void *handle)
>   
>   	amdgpu_irq_fini_sw(adev);
>   	amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);
> -	amdgpu_ih_ring_fini(adev, &adev->irq.ih2);
> -	amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
> -	amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>   
>   	return 0;
>   }

