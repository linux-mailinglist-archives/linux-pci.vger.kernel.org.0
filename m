Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5180537A026
	for <lists+linux-pci@lfdr.de>; Tue, 11 May 2021 08:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhEKG5K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 May 2021 02:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhEKG5K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 May 2021 02:57:10 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9B9C061574
        for <linux-pci@vger.kernel.org>; Mon, 10 May 2021 23:56:03 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id l4so28133140ejc.10
        for <linux-pci@vger.kernel.org>; Mon, 10 May 2021 23:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=1toSUP/AaDQn+kpmlAa3khwelYYn5sPMI8SmjGTagCQ=;
        b=N/J54ruGrwq8pFl23R0IhoJx5i5wz54wTHbAhpylgexUUJ7nBAq4f942QlHcIssvJG
         X+If8eJtXAJ4mCMZ+LuRjODG8BmDmVsINFFfgUHGqHPUKDRjAOi4sXcSbvzk/K9M+Zcg
         7f0j8T0fSMu2k83PwnQ7PTR08uSCRRNR7T37VCojHcqcyhbD5iseJgf5gSt9aT0+oQjH
         7B1fSfggVhA035Co+rwxVP/fAOpzv8oNzsLRLXdqQEOIYKOT2bVVHULwv2fiAF1mRb0H
         vay8+a3E4NEIjMCstMTt9hNAUMq4o+d2K5Tn+/aOJJ1QinOGaD6Ktr/DvmBNGPh/GcTo
         apsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1toSUP/AaDQn+kpmlAa3khwelYYn5sPMI8SmjGTagCQ=;
        b=JUq4w28PIhaFqFM6FFAW4B7voNdM/IXEWLt4niIvrs1KXG0VSPOSWC6Qq2gWFKongb
         xs6Odv+estanYMfB98MlKa7/ZXZQCbHEZPYKM76yDL9ugtHIWphpyqyBy92WlOQkCmns
         xR9NjEdNiwiTkJQFqHDfcbgxgpTNHJLXDV4E6UZT1BwcQmNs7eWTC103gVlc6J1bdHPw
         BAj/S1CJXrqMVkmajHIjv3u0u1qzKNKbZSauSWODx4rLOWgXgGXnlPGy4Koa43C4N/cZ
         N9sUmFWadDSbkCEfb3PZX+5g2IbWRHgyHSl831k1xJ4d/nzLVz4GrcOPwqn6f/auUHmH
         oSow==
X-Gm-Message-State: AOAM5320Od0KXN30lwAnFZQq+VbbTvUDXHMEOOFu69jAvlx/q2jLCRWd
        0ytTBxcqPgAOAtZTHoSjj+s=
X-Google-Smtp-Source: ABdhPJz2Xs+emszyd7P6ez0qEzKjruy/WoTOQ1rs7N8d7ThB9eLy0tSAfXUL8Y8cv7KFVTtVFChCbg==
X-Received: by 2002:a17:906:8307:: with SMTP id j7mr28982463ejx.420.1620716161994;
        Mon, 10 May 2021 23:56:01 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:c3ab:ee01:d547:2c4e? ([2a02:908:1252:fb60:c3ab:ee01:d547:2c4e])
        by smtp.gmail.com with ESMTPSA id w6sm8003653edc.25.2021.05.10.23.56.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 23:56:01 -0700 (PDT)
Subject: Re: [PATCH v6 16/16] drm/amdgpu: Verify DMA opearations from device
 are done
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-pci@vger.kernel.org, daniel.vetter@ffwll.ch,
        Harry.Wentland@amd.com
Cc:     ppaalanen@gmail.com, Alexander.Deucher@amd.com,
        gregkh@linuxfoundation.org, helgaas@kernel.org,
        Felix.Kuehling@amd.com
References: <20210510163625.407105-1-andrey.grodzovsky@amd.com>
 <20210510163625.407105-17-andrey.grodzovsky@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <2660cf0e-d312-787d-3100-8e1006d8cc35@gmail.com>
Date:   Tue, 11 May 2021 08:56:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210510163625.407105-17-andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 10.05.21 um 18:36 schrieb Andrey Grodzovsky:
> In case device remove is just simualted by sysfs then verify
> device doesn't keep doing DMA to the released memory after
> pci_remove is done.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 83006f45b10b..5e6af9e0b7bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1314,7 +1314,13 @@ amdgpu_pci_remove(struct pci_dev *pdev)
>   	drm_dev_unplug(dev);
>   	amdgpu_driver_unload_kms(dev);
>   
> +	/*
> +	 * Flush any in flight DMA operations from device.
> +	 * Clear the Bus Master Enable bit and then wait on the PCIe Device
> +	 * StatusTransactions Pending bit.
> +	 */
>   	pci_disable_device(pdev);
> +	pci_wait_for_pending_transaction(pdev);
>   }
>   
>   static void

