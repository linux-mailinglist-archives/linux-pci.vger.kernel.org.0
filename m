Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5192636F5E3
	for <lists+linux-pci@lfdr.de>; Fri, 30 Apr 2021 08:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhD3GsY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Apr 2021 02:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbhD3GsY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Apr 2021 02:48:24 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DD0C06138B
        for <linux-pci@vger.kernel.org>; Thu, 29 Apr 2021 23:47:35 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id q6so22074294edr.3
        for <linux-pci@vger.kernel.org>; Thu, 29 Apr 2021 23:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=wr7vkFvkOO9C1IiTbS217AA3btEZiiIRnKxh2CRGTTk=;
        b=uvCDiVu1TLau3jWTAMHvbKhSSKcZ5RPZ9i3rCtgeHza9t9mivBL4f//W7bhJUmKx8b
         3AItqMKspCOq1l5OF3dg2IxU/kX30WEhIV2Nc2K5RHwr8Tged4hycBy88y6qpVTGUP4B
         BmcBShN7h8zSGCq966NAvaAtlwZ771UzGln3JIXxe/DU2YE3GWIeL303lNjKcw5+Z2dM
         uz1BG1ZlZmt85KefQeVyaWxm/fiKVq24YuUiEBdtZQ8rfdUAIBWumnyNgYg3r3UqeUdd
         DL8P3uP7nnnOSylX7a/0t8rkf5kPMezhiAcXD0D4s+5TVDOzJJxwkhEFxu6D3PX5MYtA
         1KOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=wr7vkFvkOO9C1IiTbS217AA3btEZiiIRnKxh2CRGTTk=;
        b=YH67zfRl4pCbxgZ24G7/WbjsK7ToZV6CE3sLhuO3gk52iGfSqm4D4mjVbIr1qUf637
         +I5nhem1+E28CeKNUqfPqIfu/lXj+MiXvJJQUElHTwGefbwGUsKXe58mQsWxIHhuwQUy
         n5ka13QJi342HwaZQyPGwykYG2aHGz0dUGvmGAqBEdXWWYVLgUy+YwzBD9t8gnbZqMe3
         LGydV2QTM01Aul77syPlnFrAeToWJpyJekoE7DZVj8cCRoETDe7SpddKTvPpyIpoiy2+
         vqLpNSyN/3+qbHA4i0fW0KZbDmSfCrwMtHq5Uo47ODIDmscbxWHXdM3tXzI0BH0EyWr8
         JhXg==
X-Gm-Message-State: AOAM532W2lmkblqsSexKx6LWpCHvEYPieRk7WW4bN7+IRkTx178W1x6r
        PJ87T7M9pdjCjRmYPgEZ8CI=
X-Google-Smtp-Source: ABdhPJwvoIifIFy/20SIXJ/P+khoyaIP/F2WPtFaEJQ7tN06ppU13Nhn43CHFIFRYobFTqFdRLUQ3Q==
X-Received: by 2002:aa7:cf06:: with SMTP id a6mr3836998edy.340.1619765254710;
        Thu, 29 Apr 2021 23:47:34 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:476:af65:610b:2d5d? ([2a02:908:1252:fb60:476:af65:610b:2d5d])
        by smtp.gmail.com with ESMTPSA id dk13sm562944edb.34.2021.04.29.23.47.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 23:47:34 -0700 (PDT)
Subject: Re: [PATCH v5 15/27] drm/scheduler: Fix hang when sched_entity
 released
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-pci@vger.kernel.org, daniel.vetter@ffwll.ch,
        Harry.Wentland@amd.com
Cc:     ppaalanen@gmail.com, Alexander.Deucher@amd.com,
        gregkh@linuxfoundation.org, helgaas@kernel.org,
        Felix.Kuehling@amd.com
References: <20210428151207.1212258-1-andrey.grodzovsky@amd.com>
 <20210428151207.1212258-16-andrey.grodzovsky@amd.com>
 <a8314d77-578f-e0df-5c49-77d5f10c76c7@amd.com>
 <9cb771f2-d52f-f14e-f3d4-b9488b353ae3@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <0c598888-d7d4-451a-3d4a-01c46ddda397@gmail.com>
Date:   Fri, 30 Apr 2021 08:47:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <9cb771f2-d52f-f14e-f3d4-b9488b353ae3@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



Am 29.04.21 um 19:06 schrieb Andrey Grodzovsky:
>
>
> On 2021-04-29 3:18 a.m., Christian König wrote:
>> I need to take another look at this part when I don't have a massive 
>> headache any more.
>>
>> Maybe split the patch set up into different parts, something like:
>> 1. Adding general infrastructure.
>> 2. Making sure all memory is unpolated.
>> 3. Job and fence handling
>
> I am not sure you mean this patch here, maybe another one ?
> Also note you already RBed it.

No what I meant was to send out the patches before this one as #1 and #2.

That is the easier stuff which can easily go into the drm-misc-next or 
amd-staging-drm-next branch.

The scheduler stuff certainly need to go into drm-misc-next.

Christian.

>
> Andrey
>
>>
>> Christian.
>>
>> Am 28.04.21 um 17:11 schrieb Andrey Grodzovsky:
>>> Problem: If scheduler is already stopped by the time sched_entity
>>> is released and entity's job_queue not empty I encountred
>>> a hang in drm_sched_entity_flush. This is because 
>>> drm_sched_entity_is_idle
>>> never becomes false.
>>>
>>> Fix: In drm_sched_fini detach all sched_entities from the
>>> scheduler's run queues. This will satisfy drm_sched_entity_is_idle.
>>> Also wakeup all those processes stuck in sched_entity flushing
>>> as the scheduler main thread which wakes them up is stopped by now.
>>>
>>> v2:
>>> Reverse order of drm_sched_rq_remove_entity and marking
>>> s_entity as stopped to prevent reinserion back to rq due
>>> to race.
>>>
>>> v3:
>>> Drop drm_sched_rq_remove_entity, only modify entity->stopped
>>> and check for it in drm_sched_entity_is_idle
>>>
>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>> ---
>>>   drivers/gpu/drm/scheduler/sched_entity.c |  3 ++-
>>>   drivers/gpu/drm/scheduler/sched_main.c   | 24 
>>> ++++++++++++++++++++++++
>>>   2 files changed, 26 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c 
>>> b/drivers/gpu/drm/scheduler/sched_entity.c
>>> index f0790e9471d1..cb58f692dad9 100644
>>> --- a/drivers/gpu/drm/scheduler/sched_entity.c
>>> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
>>> @@ -116,7 +116,8 @@ static bool drm_sched_entity_is_idle(struct 
>>> drm_sched_entity *entity)
>>>       rmb(); /* for list_empty to work without lock */
>>>       if (list_empty(&entity->list) ||
>>> -        spsc_queue_count(&entity->job_queue) == 0)
>>> +        spsc_queue_count(&entity->job_queue) == 0 ||
>>> +        entity->stopped)
>>>           return true;
>>>       return false;
>>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c 
>>> b/drivers/gpu/drm/scheduler/sched_main.c
>>> index 908b0b56032d..ba087354d0a8 100644
>>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>>> @@ -897,9 +897,33 @@ EXPORT_SYMBOL(drm_sched_init);
>>>    */
>>>   void drm_sched_fini(struct drm_gpu_scheduler *sched)
>>>   {
>>> +    struct drm_sched_entity *s_entity;
>>> +    int i;
>>> +
>>>       if (sched->thread)
>>>           kthread_stop(sched->thread);
>>> +    for (i = DRM_SCHED_PRIORITY_COUNT - 1; i >= 
>>> DRM_SCHED_PRIORITY_MIN; i--) {
>>> +        struct drm_sched_rq *rq = &sched->sched_rq[i];
>>> +
>>> +        if (!rq)
>>> +            continue;
>>> +
>>> +        spin_lock(&rq->lock);
>>> +        list_for_each_entry(s_entity, &rq->entities, list)
>>> +            /*
>>> +             * Prevents reinsertion and marks job_queue as idle,
>>> +             * it will removed from rq in drm_sched_entity_fini
>>> +             * eventually
>>> +             */
>>> +            s_entity->stopped = true;
>>> +        spin_unlock(&rq->lock);
>>> +
>>> +    }
>>> +
>>> +    /* Wakeup everyone stuck in drm_sched_entity_flush for this 
>>> scheduler */
>>> +    wake_up_all(&sched->job_scheduled);
>>> +
>>>       /* Confirm no work left behind accessing device structures */
>>>       cancel_delayed_work_sync(&sched->work_tdr);
>>

