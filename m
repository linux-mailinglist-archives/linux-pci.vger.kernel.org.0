Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3DB383DA3
	for <lists+linux-pci@lfdr.de>; Mon, 17 May 2021 21:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234957AbhEQTlR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 May 2021 15:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbhEQTlQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 May 2021 15:41:16 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F57C061573
        for <linux-pci@vger.kernel.org>; Mon, 17 May 2021 12:39:59 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id u21so10847695ejo.13
        for <linux-pci@vger.kernel.org>; Mon, 17 May 2021 12:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=38ziZcYcZr57KsHEyvHZhQV5MTnxcJn5y4DdrSJQiwY=;
        b=QEu511/bsk+JD0G5PmN5tLFhHqljFLF/7D5v/wslkHlrRvVQsuPwtv3myKNMgQDyCN
         uVq9XOP2RU+7Zo2jIzsn3hoiMa4YVW9YWgpH4ExrUHrUTQyKLSCvW78cgmhZpYTnpdUX
         IuKqzQSQ3unrumnWX6h5sLExuzRc3C1Hgu/uOdpToyPraYs6vW0/dvoqLVbomOSYqvml
         TuCBk8eaSVWYCDDqGAmHiNkCNIFCBvAV+6xIsVQubqziCgLACIV+Oi8JU6DKkZ5YN7LG
         58Rk+zQ+0NzdyJWmeGlh8Bfddl28vKw2GQrzXswX9rH3xnPkxRhEf/g9KKBK1iCl8vqu
         dV7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=38ziZcYcZr57KsHEyvHZhQV5MTnxcJn5y4DdrSJQiwY=;
        b=rIodjRTHsrPi6JtMMhDxsIE3E/EfdzagmB8XfnTsmI/zOucukKqurACuuP7rhyLzoJ
         TAho5WkIomE6lfm6KlfLLUlDjhmeKXFcuN07K0S0paxwfYEph3KZ0VWfXkIFAB9G5SuG
         WUa44CI2FHZPda5inhZK1PDK17XW4yB+VizVx9HvZCdLJYJsfyqywY0PRexWNGHA7HjR
         71tFEgiOe7OoLpzucijlPKA/HBYl9cCxpnUKIPcnD1qtwj5OVQL0LLDpe0ZTaHNlbpbK
         c7he16C7A9OZv4cGK0kTisRKLtoeK9TGNdnuoGCRG0BKv0rfoUZ4t2UIYuW16K5nBSSI
         R6Aw==
X-Gm-Message-State: AOAM5303KFu42TOJhn9zFXNChmEXO8DnJ501ePVNy+XQiu8vKc4tTa18
        uCVQMuJ60bx9ln4Dyi7rCEk=
X-Google-Smtp-Source: ABdhPJwwxfd2fPAJc2OXSfYAbVpwpof6Ye0W4UuLSzuIf3R7gbpdKVyI0Ez/ieb3VCy7w6My8thk4A==
X-Received: by 2002:a17:906:fa90:: with SMTP id lt16mr1555668ejb.411.1621280397777;
        Mon, 17 May 2021 12:39:57 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:bd86:58d9:7c79:a095? ([2a02:908:1252:fb60:bd86:58d9:7c79:a095])
        by smtp.gmail.com with ESMTPSA id z12sm5356339edq.77.2021.05.17.12.39.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 12:39:57 -0700 (PDT)
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
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <356d03bf-e221-86b1-f133-83def9d956bd@gmail.com>
Date:   Mon, 17 May 2021 21:39:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <a589044b-8dac-e573-e864-4093e24574a3@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

You need to note who you are pinging here.

I'm still assuming you wait for feedback from Daniel. Or should I take a 
look?

Christian.

Am 17.05.21 um 16:40 schrieb Andrey Grodzovsky:
> Ping
>
> Andrey
>
> On 2021-05-14 10:42 a.m., Andrey Grodzovsky wrote:
>> Ping
>>
>> Andrey
>>
>> On 2021-05-12 10:26 a.m., Andrey Grodzovsky wrote:
>>> If removing while commands in flight you cannot wait to flush the
>>> HW fences on a ring since the device is gone.
>>>
>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 16 ++++++++++------
>>>   1 file changed, 10 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> index 1ffb36bd0b19..fa03702ecbfb 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> @@ -36,6 +36,7 @@
>>>   #include <linux/firmware.h>
>>>   #include <linux/pm_runtime.h>
>>> +#include <drm/drm_drv.h>
>>>   #include "amdgpu.h"
>>>   #include "amdgpu_trace.h"
>>> @@ -525,8 +526,7 @@ int amdgpu_fence_driver_init(struct 
>>> amdgpu_device *adev)
>>>    */
>>>   void amdgpu_fence_driver_fini_hw(struct amdgpu_device *adev)
>>>   {
>>> -    unsigned i, j;
>>> -    int r;
>>> +    int i, r;
>>>       for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
>>>           struct amdgpu_ring *ring = adev->rings[i];
>>> @@ -535,11 +535,15 @@ void amdgpu_fence_driver_fini_hw(struct 
>>> amdgpu_device *adev)
>>>               continue;
>>>           if (!ring->no_scheduler)
>>>               drm_sched_fini(&ring->sched);
>>> -        r = amdgpu_fence_wait_empty(ring);
>>> -        if (r) {
>>> -            /* no need to trigger GPU reset as we are unloading */
>>> +        /* You can't wait for HW to signal if it's gone */
>>> +        if (!drm_dev_is_unplugged(&adev->ddev))
>>> +            r = amdgpu_fence_wait_empty(ring);
>>> +        else
>>> +            r = -ENODEV;
>>> +        /* no need to trigger GPU reset as we are unloading */
>>> +        if (r)
>>>               amdgpu_fence_driver_force_completion(ring);
>>> -        }
>>> +
>>>           if (ring->fence_drv.irq_src)
>>>               amdgpu_irq_put(adev, ring->fence_drv.irq_src,
>>>                          ring->fence_drv.irq_type);
>>>

