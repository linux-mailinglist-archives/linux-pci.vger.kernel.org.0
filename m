Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BC75B843D
	for <lists+linux-pci@lfdr.de>; Wed, 14 Sep 2022 11:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiINJJB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Sep 2022 05:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiINJH5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2022 05:07:57 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8DF7757A
        for <linux-pci@vger.kernel.org>; Wed, 14 Sep 2022 02:04:01 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id lc7so33235984ejb.0
        for <linux-pci@vger.kernel.org>; Wed, 14 Sep 2022 02:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=2xFQv0dOdJKb95Wd52ZeBzrP/3JRmzYEfTP9dP/98H4=;
        b=RLBIWqZnYnI3EjGAWujHA3PWk6TX04RgKH4IZiRrqrWoyEd1MT4hyALqpZgWuxSJkB
         6xUSzA6vHNR8C6GDK1YylTSzAzYTHHNvbjX8x/je8Pn71yKcIrV2yqa986db/irSkf1G
         IE2pmhpzSyr4ZUJYIjIOfraAdaHiX87A/5eFC9QdMCqLSPbLiV4I6wibbftpoPtK/z/s
         gmdD6o/ema0uRR0VlSA0kR7K0hmioE69hK7F5o5U3f+hE+GbxUa8FIbiBEdlkTTC+RJ6
         e+EPmlD3uFNWwMqpHboeCofe78a5FJIKoJyT6z2rE6y5CTTjAlS4oT5WrkSU8dUng4Te
         5Q1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=2xFQv0dOdJKb95Wd52ZeBzrP/3JRmzYEfTP9dP/98H4=;
        b=ykHLSy2dtbQqOF6xH/W94jCKG8s55NAvBCEBCledn9zfDj6h3F6HmH1ZkdCcDFVeev
         tPxepNP/xjkKniudcrBsgjxf3UHBmW7/8FgCEuxwsmyZy9IhnD6zCUkxz8SoC80d8qJ4
         G1hnOq/bfuEYLTqDlislB4vzKIfx13uL3n23C88rgt0jNtlprmSjEa4IbxEai9hywuI/
         RUmC86aIC5SS9H1o85Pb+NcGnYTOpG6Zb5T3XuelhbubXpv1au+qMClhVH7nW9S3ZpxW
         g7mxBOUW0xCxIObuMzMBzF5smYbmAtcrfOnF5hVjsjAbIGkGo63VcNZoDIi6VAnWW4OD
         A97w==
X-Gm-Message-State: ACgBeo0BdPcZT6wxAUQ1cT/Val2lmU92vd2ayVVWWXHAV8cg/OSERTq2
        WZt8QvAgMWFGRWFrW3YEgZo=
X-Google-Smtp-Source: AA6agR5tOiQNQ/Vm7mTy5vmSrBVaYccu0A48CR07xMvtQNpHjOVB9mw/UrXPlA9nHeiFY3BQIqzNCQ==
X-Received: by 2002:a17:907:6ea0:b0:77e:c2e5:a35b with SMTP id sh32-20020a1709076ea000b0077ec2e5a35bmr8047131ejc.566.1663146235575;
        Wed, 14 Sep 2022 02:03:55 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:158e:603b:8394:aba3? ([2a02:908:1256:79a0:158e:603b:8394:aba3])
        by smtp.gmail.com with ESMTPSA id v17-20020aa7d9d1000000b0044f21c69608sm9443663eds.10.2022.09.14.02.03.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 02:03:55 -0700 (PDT)
Message-ID: <0fdecd48-46ec-c69e-79d5-a2e0db3d5a37@gmail.com>
Date:   Wed, 14 Sep 2022 11:03:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/3] drm/amdgpu: make sure to init common IP before gmc
Content-Language: en-US
To:     Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org, helgaas@kernel.org
Cc:     regressions@lists.linux.dev, airlied@linux.ie,
        linux-pci@vger.kernel.org, m.seyfarth@gmail.com,
        tseewald@gmail.com, kai.heng.feng@canonical.com, daniel@ffwll.ch,
        sr@denx.de
References: <20220913144832.2784012-1-alexander.deucher@amd.com>
 <20220913144832.2784012-4-alexander.deucher@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220913144832.2784012-4-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 13.09.22 um 16:48 schrieb Alex Deucher:
> Move common IP init before GMC init so that HDP gets
> remapped before GMC init which uses it.

At some point we should improve this so that we have the common and GMC 
stuff in the hardware init as first thing without those hacks.

But anyway Acked-by for now since this is higher level design work.

Regards,
Christian.

>
> This fixes the Unsupported Request error reported through
> AER during driver load. The error happens as a write happens
> to the remap offset before real remapping is done.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216373
>
> The error was unnoticed before and got visible because of the commit
> referenced below. This doesn't fix anything in the commit below, rather
> fixes the issue in amdgpu exposed by the commit. The reference is only
> to associate this commit with below one so that both go together.
>
> Fixes: 8795e182b02d ("PCI/portdrv: Don't disable AER reporting in get_port_device_capability()")
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 899564ea8b4b..4da85ce9e3b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2375,8 +2375,16 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>   		}
>   		adev->ip_blocks[i].status.sw = true;
>   
> -		/* need to do gmc hw init early so we can allocate gpu mem */
> -		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC) {
> +		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON) {
> +			/* need to do common hw init early so everything is set up for gmc */
> +			r = adev->ip_blocks[i].version->funcs->hw_init((void *)adev);
> +			if (r) {
> +				DRM_ERROR("hw_init %d failed %d\n", i, r);
> +				goto init_failed;
> +			}
> +			adev->ip_blocks[i].status.hw = true;
> +		} else if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC) {
> +			/* need to do gmc hw init early so we can allocate gpu mem */
>   			/* Try to reserve bad pages early */
>   			if (amdgpu_sriov_vf(adev))
>   				amdgpu_virt_exchange_data(adev);
> @@ -3062,8 +3070,8 @@ static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
>   	int i, r;
>   
>   	static enum amd_ip_block_type ip_order[] = {
> -		AMD_IP_BLOCK_TYPE_GMC,
>   		AMD_IP_BLOCK_TYPE_COMMON,
> +		AMD_IP_BLOCK_TYPE_GMC,
>   		AMD_IP_BLOCK_TYPE_PSP,
>   		AMD_IP_BLOCK_TYPE_IH,
>   	};

