Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A93383DE1
	for <lists+linux-pci@lfdr.de>; Mon, 17 May 2021 21:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236743AbhEQT4N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 May 2021 15:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235960AbhEQT4N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 May 2021 15:56:13 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3D3C061573
        for <linux-pci@vger.kernel.org>; Mon, 17 May 2021 12:54:55 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id w12so608264edx.1
        for <linux-pci@vger.kernel.org>; Mon, 17 May 2021 12:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=pn6HLbkhe5VCCVD8p9BJTvIle8DzSLJAN/Z44NE5Q+g=;
        b=apCiEthUVlP2NlT+C8Te9m9pRQ2UgK4Lz295b27m4exzjTU36lXw6MuTJ+P9r1vhty
         wfWBo7Db1LxxhRTbgSXIrW4veo4yEouJUhPCyIwnJn0HwL8zZYHL/bEIMUkUXw0pmP/t
         LQLUsxLLYMQZuMgOrzBa/LjgLj9yg7h5r2msGWnvpTfR/hUCRZavAekoRnNBIuWpYBE2
         rc9MEuJ9z3U8aEbVEhAWjrbF3so4M7eMpJxMG+EeGN5HXOmVOOQifQdy/KWvm29SpcfY
         7CAgOCPb8TiTkilzFnJPIk0PvZnAgWnh2f+StKbt4RW3NykdmU1h2MFUjE9auENdGv8X
         RG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pn6HLbkhe5VCCVD8p9BJTvIle8DzSLJAN/Z44NE5Q+g=;
        b=dnpzx4TFVuCYS2AwMDBr3RLioBC6/hO79cP4fRZQxSP3znoWPMIeIrPnchmpBf2sZT
         kEtwpixP3ooHvkaxyD8OfTDCu3zYOoijifX/4znPTKa5fMy6nADrQv1yLoV9HTRx5Uhu
         feePVGuOoWZ06ZguYC8Rd6MRCII6WEouKqhu8elktRWxs12NahlYeVX84pJg0KjjJuE6
         ksLMoYg2a23IT4D5TkVPNOm/Mhc+jZdmjqgv/U2Q52gXbkwB547M9+YLBnzk+djZ3K5/
         uo2tB4uXjICAJOQUPlDSp4mrqhG1cWdDbEMyfd3B5GVwHASO1XEQkKT73Qr+Ilq/f5xp
         O7jg==
X-Gm-Message-State: AOAM531RtSCA0hIbNE8xIVReQNeGfiVjrtW9XSPe0+BSazS4lY0xDT/L
        RbomKGC45I13QxaQbqLLg8U=
X-Google-Smtp-Source: ABdhPJwEUvHkx4T4Q0SBXMBXCMLzw48OpqBIGVTD30mquW99ltdMw2k1zLH76+AGg8ZzkYSyWkWjbA==
X-Received: by 2002:a05:6402:19a:: with SMTP id r26mr2090474edv.44.1621281294033;
        Mon, 17 May 2021 12:54:54 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:bd86:58d9:7c79:a095? ([2a02:908:1252:fb60:bd86:58d9:7c79:a095])
        by smtp.gmail.com with ESMTPSA id i19sm282060eds.65.2021.05.17.12.54.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 12:54:53 -0700 (PDT)
Subject: Re: [PATCH v7 12/16] drm/amdgpu: Fix hang on device removal.
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-pci@vger.kernel.org, daniel.vetter@ffwll.ch,
        Harry.Wentland@amd.com
Cc:     ppaalanen@gmail.com, Alexander.Deucher@amd.com,
        gregkh@linuxfoundation.org, helgaas@kernel.org,
        Felix.Kuehling@amd.com
References: <20210512142648.666476-1-andrey.grodzovsky@amd.com>
 <20210512142648.666476-13-andrey.grodzovsky@amd.com>
 <0e13e0fb-5cf8-30fa-6ed8-a0648f8fe50b@amd.com>
 <a589044b-8dac-e573-e864-4093e24574a3@amd.com>
 <356d03bf-e221-86b1-f133-83def9d956bd@gmail.com>
 <8997d1b0-8f7a-e8dd-fabe-212fd181e24a@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <12f790fa-836f-c323-b8c5-dc565ee39a99@gmail.com>
Date:   Mon, 17 May 2021 21:54:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <8997d1b0-8f7a-e8dd-fabe-212fd181e24a@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ok, then putting that on my TODO list for tomorrow.

I've already found a problem with how we finish of fences, going to 
write more on this tomorrow.

Christian.

Am 17.05.21 um 21:46 schrieb Andrey Grodzovsky:
> Yep, you can take a look.
>
> Andrey
>
> On 2021-05-17 3:39 p.m., Christian König wrote:
>> You need to note who you are pinging here.
>>
>> I'm still assuming you wait for feedback from Daniel. Or should I 
>> take a look?
>>
>> Christian.
>>
>> Am 17.05.21 um 16:40 schrieb Andrey Grodzovsky:
>>> Ping
>>>
>>> Andrey
>>>
>>> On 2021-05-14 10:42 a.m., Andrey Grodzovsky wrote:
>>>> Ping
>>>>
>>>> Andrey
>>>>
>>>> On 2021-05-12 10:26 a.m., Andrey Grodzovsky wrote:
>>>>> If removing while commands in flight you cannot wait to flush the
>>>>> HW fences on a ring since the device is gone.
>>>>>
>>>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 16 ++++++++++------
>>>>>   1 file changed, 10 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>> index 1ffb36bd0b19..fa03702ecbfb 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>> @@ -36,6 +36,7 @@
>>>>>   #include <linux/firmware.h>
>>>>>   #include <linux/pm_runtime.h>
>>>>> +#include <drm/drm_drv.h>
>>>>>   #include "amdgpu.h"
>>>>>   #include "amdgpu_trace.h"
>>>>> @@ -525,8 +526,7 @@ int amdgpu_fence_driver_init(struct 
>>>>> amdgpu_device *adev)
>>>>>    */
>>>>>   void amdgpu_fence_driver_fini_hw(struct amdgpu_device *adev)
>>>>>   {
>>>>> -    unsigned i, j;
>>>>> -    int r;
>>>>> +    int i, r;
>>>>>       for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
>>>>>           struct amdgpu_ring *ring = adev->rings[i];
>>>>> @@ -535,11 +535,15 @@ void amdgpu_fence_driver_fini_hw(struct 
>>>>> amdgpu_device *adev)
>>>>>               continue;
>>>>>           if (!ring->no_scheduler)
>>>>>               drm_sched_fini(&ring->sched);
>>>>> -        r = amdgpu_fence_wait_empty(ring);
>>>>> -        if (r) {
>>>>> -            /* no need to trigger GPU reset as we are unloading */
>>>>> +        /* You can't wait for HW to signal if it's gone */
>>>>> +        if (!drm_dev_is_unplugged(&adev->ddev))
>>>>> +            r = amdgpu_fence_wait_empty(ring);
>>>>> +        else
>>>>> +            r = -ENODEV;
>>>>> +        /* no need to trigger GPU reset as we are unloading */
>>>>> +        if (r)
>>>>>               amdgpu_fence_driver_force_completion(ring);
>>>>> -        }
>>>>> +
>>>>>           if (ring->fence_drv.irq_src)
>>>>>               amdgpu_irq_put(adev, ring->fence_drv.irq_src,
>>>>>                          ring->fence_drv.irq_type);
>>>>>
>>

