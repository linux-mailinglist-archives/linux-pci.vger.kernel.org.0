Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513CE37AA5A
	for <lists+linux-pci@lfdr.de>; Tue, 11 May 2021 17:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbhEKPNf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 May 2021 11:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbhEKPNe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 May 2021 11:13:34 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F503C061574
        for <linux-pci@vger.kernel.org>; Tue, 11 May 2021 08:12:26 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id l7so23338145edb.1
        for <linux-pci@vger.kernel.org>; Tue, 11 May 2021 08:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=zKRbLMLHni1uSr1DImbAUndUBx0nq2VWk5639tbMukI=;
        b=oBjNWH+WMgcbpyfUM7y/7U5RBqMsqb/sqyJokcI0nVOjPMgU7E5yqQWVcjEv/PjMmN
         Cr8+ptcFICXfuEvAZy9hxh5QxmBikJZbYvKgTjKfi1ykRPIdfBSByZHdRC+kfV+f9r1H
         A6q6geTsFSf+VdXPbQ9z2KJ2hd12ES7AiN9CyujUJeWh2arLPCjZKNjED9JwxN7/D/oX
         Ll4nJxRfmIZCE3bYOy9FzWLfUZGMjkeVagE6cK4T4q2zZ8UOcrornFh0Eh0t+o/14EE2
         906Qknh9z2WD0K/3MdOUiMomDYRuBJF3+QuxIzSWtvlxPK5nrhsel2NqehAQSIkNk0jf
         toVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zKRbLMLHni1uSr1DImbAUndUBx0nq2VWk5639tbMukI=;
        b=BF6pisK4ro77q0i3Sf9khRhnJXMdM9w6PdPTIr8leRgdCC51XZa8sCIBroKSNZ965G
         qIWLiR2pWSOyRtZ7vQPoTGxY1OvTurAO/Ght1BEVFYoXBRUSUSEF349hga5zGFBTYEEN
         bLB4ClKxcFaduIXwkX7yQre8WS/rFmv+mxzUPns/S/fma2irUWjT32srOmHI9nWUykjM
         JQsjYDb/+9a0aaexOj9YZ0lJFB4M/74iot0Vt0VdqDP8olo9I39u5uUTqAqmCe9qsmJc
         Z5n2tRhZQOYH81HIP72BxOYhU+MDAMzfZWxSmDSSJhFe/2xM8e0Sxsytc4pYsUwDYrLe
         dVsg==
X-Gm-Message-State: AOAM533Y0Q6k2l1n09hih5jrkz+leVe41XPKzCswco3ktLMkQqNaG/YV
        hvqq1RKuR6PFc9lOpWho6k0=
X-Google-Smtp-Source: ABdhPJw6vg98A40F++SSvvN1acf7Y11Xa7T1+np+N+ENc/IjZMEtCTj4xHR3SDcUUvBc46sA42hKyw==
X-Received: by 2002:a05:6402:1c07:: with SMTP id ck7mr37282815edb.149.1620745944768;
        Tue, 11 May 2021 08:12:24 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:5935:8b67:3cdd:7cc1? ([2a02:908:1252:fb60:5935:8b67:3cdd:7cc1])
        by smtp.gmail.com with ESMTPSA id p14sm14552993eds.28.2021.05.11.08.12.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 08:12:24 -0700 (PDT)
Subject: Re: [PATCH v6 01/16] drm/ttm: Remap all page faults to per process
 dummy page.
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-pci@vger.kernel.org, daniel.vetter@ffwll.ch,
        Harry.Wentland@amd.com
Cc:     ppaalanen@gmail.com, Alexander.Deucher@amd.com,
        gregkh@linuxfoundation.org, helgaas@kernel.org,
        Felix.Kuehling@amd.com
References: <20210510163625.407105-1-andrey.grodzovsky@amd.com>
 <20210510163625.407105-2-andrey.grodzovsky@amd.com>
 <e4bb49b1-393d-10aa-7e18-f445d7e71ef7@gmail.com>
 <897f1ca4-9e78-1136-961e-18e6c2cbab50@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <2d46bfc0-1aed-4c9c-272e-8ceb619c999b@gmail.com>
Date:   Tue, 11 May 2021 17:12:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <897f1ca4-9e78-1136-961e-18e6c2cbab50@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



Am 11.05.21 um 16:44 schrieb Andrey Grodzovsky:
>
> On 2021-05-11 2:38 a.m., Christian König wrote:
>> Am 10.05.21 um 18:36 schrieb Andrey Grodzovsky:
>>> On device removal reroute all CPU mappings to dummy page.
>>>
>>> v3:
>>> Remove loop to find DRM file and instead access it
>>> by vma->vm_file->private_data. Move dummy page installation
>>> into a separate function.
>>>
>>> v4:
>>> Map the entire BOs VA space into on demand allocated dummy page
>>> on the first fault for that BO.
>>>
>>> v5: Remove duplicate return.
>>>
>>> v6: Polish ttm_bo_vm_dummy_page, remove superflous code.
>>>
>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>> ---
>>>   drivers/gpu/drm/ttm/ttm_bo_vm.c | 57 
>>> ++++++++++++++++++++++++++++++++-
>>>   include/drm/ttm/ttm_bo_api.h    |  2 ++
>>>   2 files changed, 58 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c 
>>> b/drivers/gpu/drm/ttm/ttm_bo_vm.c
>>> index b31b18058965..e5a9615519d1 100644
>>> --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
>>> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
>>> @@ -34,6 +34,8 @@
>>>   #include <drm/ttm/ttm_bo_driver.h>
>>>   #include <drm/ttm/ttm_placement.h>
>>>   #include <drm/drm_vma_manager.h>
>>> +#include <drm/drm_drv.h>
>>> +#include <drm/drm_managed.h>
>>>   #include <linux/mm.h>
>>>   #include <linux/pfn_t.h>
>>>   #include <linux/rbtree.h>
>>> @@ -380,19 +382,72 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct 
>>> vm_fault *vmf,
>>>   }
>>>   EXPORT_SYMBOL(ttm_bo_vm_fault_reserved);
>>>   +static void ttm_bo_release_dummy_page(struct drm_device *dev, 
>>> void *res)
>>> +{
>>> +    struct page *dummy_page = (struct page *)res;
>>> +
>>> +    __free_page(dummy_page);
>>> +}
>>> +
>>> +vm_fault_t ttm_bo_vm_dummy_page(struct vm_fault *vmf, pgprot_t prot)
>>> +{
>>> +    struct vm_area_struct *vma = vmf->vma;
>>> +    struct ttm_buffer_object *bo = vma->vm_private_data;
>>> +    struct drm_device *ddev = bo->base.dev;
>>> +    vm_fault_t ret = VM_FAULT_NOPAGE;
>>> +    unsigned long address;
>>> +    unsigned long pfn;
>>> +    struct page *page;
>>> +
>>> +    /* Allocate new dummy page to map all the VA range in this VMA 
>>> to it*/
>>> +    page = alloc_page(GFP_KERNEL | __GFP_ZERO);
>>> +    if (!page)
>>> +        return VM_FAULT_OOM;
>>> +
>>> +    pfn = page_to_pfn(page);
>>> +
>>> +    /* Prefault the entire VMA range right away to avoid further 
>>> faults */
>>> +    for (address = vma->vm_start; address < vma->vm_end; address += 
>>> PAGE_SIZE) {
>>> +
>>
>>> +        if (unlikely(address >= vma->vm_end))
>>> +            break;
>>
>> That extra check can be removed as far as I can see.
>>
>>
>>> +
>>> +        if (vma->vm_flags & VM_MIXEDMAP)
>>> +            ret = vmf_insert_mixed_prot(vma, address,
>>> +                            __pfn_to_pfn_t(pfn, PFN_DEV),
>>> +                            prot);
>>> +        else
>>> +            ret = vmf_insert_pfn_prot(vma, address, pfn, prot);
>>> +    }
>>> +
>>
>>> +    /* Set the page to be freed using drmm release action */
>>> +    if (drmm_add_action_or_reset(ddev, ttm_bo_release_dummy_page, 
>>> page))
>>> +        return VM_FAULT_OOM;
>>
>> You should probably move that before inserting the page into the VMA 
>> and also free the allocated page if it goes wrong.
>
>
> drmm_add_action_or_reset will automatically release the page if the 
> add action fails, that the 'reset' part of the function.

Ah! Ok that makes it even more important that you do this before you 
insert the page into any VMA.

Otherwise userspace has access to a freed page with the rather ugly 
consequences.

Christian.

>
> Andrey
>
>
>>
>> Apart from that patch looks good to me,
>> Christian.
>>
>>> +
>>> +    return ret;
>>> +}
>>> +EXPORT_SYMBOL(ttm_bo_vm_dummy_page);
>>> +
>>>   vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
>>>   {
>>>       struct vm_area_struct *vma = vmf->vma;
>>>       pgprot_t prot;
>>>       struct ttm_buffer_object *bo = vma->vm_private_data;
>>> +    struct drm_device *ddev = bo->base.dev;
>>>       vm_fault_t ret;
>>> +    int idx;
>>>         ret = ttm_bo_vm_reserve(bo, vmf);
>>>       if (ret)
>>>           return ret;
>>>         prot = vma->vm_page_prot;
>>> -    ret = ttm_bo_vm_fault_reserved(vmf, prot, 
>>> TTM_BO_VM_NUM_PREFAULT, 1);
>>> +    if (drm_dev_enter(ddev, &idx)) {
>>> +        ret = ttm_bo_vm_fault_reserved(vmf, prot, 
>>> TTM_BO_VM_NUM_PREFAULT, 1);
>>> +        drm_dev_exit(idx);
>>> +    } else {
>>> +        ret = ttm_bo_vm_dummy_page(vmf, prot);
>>> +    }
>>>       if (ret == VM_FAULT_RETRY && !(vmf->flags & 
>>> FAULT_FLAG_RETRY_NOWAIT))
>>>           return ret;
>>>   diff --git a/include/drm/ttm/ttm_bo_api.h 
>>> b/include/drm/ttm/ttm_bo_api.h
>>> index 639521880c29..254ede97f8e3 100644
>>> --- a/include/drm/ttm/ttm_bo_api.h
>>> +++ b/include/drm/ttm/ttm_bo_api.h
>>> @@ -620,4 +620,6 @@ int ttm_bo_vm_access(struct vm_area_struct *vma, 
>>> unsigned long addr,
>>>                void *buf, int len, int write);
>>>   bool ttm_bo_delayed_delete(struct ttm_device *bdev, bool remove_all);
>>>   +vm_fault_t ttm_bo_vm_dummy_page(struct vm_fault *vmf, pgprot_t 
>>> prot);
>>> +
>>>   #endif
>>

