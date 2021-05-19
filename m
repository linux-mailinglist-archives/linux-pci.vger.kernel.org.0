Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE37A388D52
	for <lists+linux-pci@lfdr.de>; Wed, 19 May 2021 13:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240448AbhESL5q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 May 2021 07:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352823AbhESL5o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 May 2021 07:57:44 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD82C06175F
        for <linux-pci@vger.kernel.org>; Wed, 19 May 2021 04:56:23 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id r11so14964810edt.13
        for <linux-pci@vger.kernel.org>; Wed, 19 May 2021 04:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=kMwtQn6dV3yt3Ot507gI7+kLTeD78TGfI26lLWSJ/c4=;
        b=OPRSudK29E1xqPKA4nzwRHZmiy8tPSCdaTH2oQIa4jgyGW7GROLeGAWFha4fTXBRQv
         f12rebmAxnRqfoav2+mPoI2oJfxwPqOtlvuaSm/wYvzWe30STVRwMb0/8Hl34cv8QlLl
         svuSp4yMqsuAUL1g/eYEe0QbKNERq5P4Sw8r1PNSB0Iu2y/Cc5aeEIKZd/YmPr8xXd7Z
         U2t9GiiVk2Fj5wQYMygbAlw4V7qp+pCShHnx1E52JLoJI+z9I/eVwvXFzwMfbutGOAUV
         HiUjDEaa61Yx+s2T/hcg1qWK0QOFbkMSbC068iPmFLJ7gG+BndP1OU42pGBILTTxe2QN
         jvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=kMwtQn6dV3yt3Ot507gI7+kLTeD78TGfI26lLWSJ/c4=;
        b=JcUwUeB7Py7cUI7BoFitO7AltIIICZC4DhmHqyqMyhdg+PLJAsDX1dMR1w0FEAAr2R
         qAclxzhEZfDIFQY7Ch9iRzQ67JnoQHDG7QIwCYzzbBq9RpOxa49Qit3rdHlPJc/qJw9Q
         ocoLZmIqPiv28uZVSbPoRnTKj7sn1wQL0gBw5V5yGVHLB0Y45ms5vz5zbVGR0AmLAEmi
         AaC8JsrVTlj9UuONTB7FkgBwyprOfiHix19gku/C674GjkfSAWCssJv1DsktOuUPlEDx
         OZMYx70DKs3aESwq+fERU/sRdUGA9JN7olzIOFmIiab3u0c5ajq2oVKEpqC9HP1C0na5
         xfhA==
X-Gm-Message-State: AOAM532NFXU7FM0T85QlYdi8SGh5KyeaQN3UEQxFKzQZed1rvNVtB95S
        aom6Ke+DEjIG/3VsT025B6s=
X-Google-Smtp-Source: ABdhPJwtcTnsX9qzeGwPKZ/RMedIxGukbaLl5MGcU5rIZW83uBy37Pu5ENlyzkncBPUylzWbAksKhg==
X-Received: by 2002:aa7:de8b:: with SMTP id j11mr14010358edv.363.1621425382249;
        Wed, 19 May 2021 04:56:22 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:8e28:1d3:41f3:e15a? ([2a02:908:1252:fb60:8e28:1d3:41f3:e15a])
        by smtp.gmail.com with ESMTPSA id u11sm15608540edr.13.2021.05.19.04.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 04:56:21 -0700 (PDT)
Subject: Re: [PATCH v7 13/16] drm/scheduler: Fix hang when sched_entity
 released
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-pci@vger.kernel.org, daniel.vetter@ffwll.ch,
        Harry.Wentland@amd.com
Cc:     Alexander.Deucher@amd.com, gregkh@linuxfoundation.org,
        ppaalanen@gmail.com, helgaas@kernel.org, Felix.Kuehling@amd.com
References: <20210512142648.666476-1-andrey.grodzovsky@amd.com>
 <20210512142648.666476-14-andrey.grodzovsky@amd.com>
 <9e1270bf-ab62-5d76-b1de-e6cd49dc4841@amd.com>
 <f0c5dea7-af35-9ea5-028e-6286e57a469a@amd.com>
 <34d4e4a8-c577-dfe6-3190-28a5c63a2d23@amd.com>
 <da1f9706-d918-cff8-2807-25da0c01fcde@amd.com>
 <8228ea6b-4faf-bb7e-aaf4-8949932e869a@amd.com>
 <ec157a35-85fb-11e5-226a-c25d699102c6@amd.com>
 <53f281cc-e4c0-ea5d-9415-4413c85a6a16@amd.com>
 <0b49fc7b-ca0b-58c4-3f76-c4a5fab97bdc@amd.com>
 <31febf08-e9c9-77fa-932d-a50505866ec4@amd.com>
 <cd6bbe33-cbc5-43cb-80f7-1cb82a81e65d@amd.com>
 <77efa177-f313-5f1e-e273-6672ed46a90a@gmail.com>
 <4a9af53a-564d-62ae-25e1-06ca4129857f@amd.com>
 <1622338a-d95a-fe13-e4a4-c99cb4a31f6c@amd.com>
 <bc94fbc3-8e02-c860-fc58-6301219b84e5@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <fa81de6a-e272-66cf-61d8-5bb2d0ebcb03@gmail.com>
Date:   Wed, 19 May 2021 13:56:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <bc94fbc3-8e02-c860-fc58-6301219b84e5@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 19.05.21 um 13:51 schrieb Andrey Grodzovsky:
>
>
> On 2021-05-19 7:46 a.m., Christian König wrote:
>> Am 19.05.21 um 13:03 schrieb Andrey Grodzovsky:
>>>
>>>
>>> On 2021-05-19 6:57 a.m., Christian König wrote:
>>>> Am 18.05.21 um 20:48 schrieb Andrey Grodzovsky:
>>>>> [SNIP]
>>>>>>>
>>>>>>> Would this be the right way to do it ?
>>>>>>
>>>>>> Yes, it is at least a start. Question is if we can wait blocking 
>>>>>> here or not.
>>>>>>
>>>>>> We install a callback a bit lower to avoid blocking, so I'm 
>>>>>> pretty sure that won't work as expected.
>>>>>>
>>>>>> Christian.
>>>>>
>>>>> I can't see why this would create problems, as long as the 
>>>>> dependencies
>>>>> complete or force competed if they are from same device 
>>>>> (extracted) but
>>>>> on a different ring then looks to me it should work. I will give it
>>>>> a try.
>>>>
>>>> Ok, but please also test the case for a killed process.
>>>>
>>>> Christian.
>>>
>>> You mean something like run glxgears and then simply
>>> terminate it ? Because I done that. Or something more ?
>>
>> Well glxgears is a bit to lightweight for that.
>>
>> You need at least some test which is limited by the rendering pipeline.
>>
>> Christian.
>
> You mean something that fill the entity queue faster then sched thread
> empties it so when we kill the process we actually need to explicitly go
> through remaining jobs termination ? I done that too by inserting
> artificial delay in drm_sched_main.

Yeah, something like that.

Ok in that case I would say that this should work then.

Christian.

>
> Andrey
>
>>
>>>
>>> Andrey
>>>
>>>
>>>>
>>>>>
>>>>> Andrey
>>>>
>>>> _______________________________________________
>>>> amd-gfx mailing list
>>>> amd-gfx@lists.freedesktop.org
>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7Cce1252e55fae4338710d08d91ab4de01%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637570186393107071%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=vGqxY5sxpEIiQGFBNn2PWkKqVjviM29r34Yjv0wujf4%3D&amp;reserved=0 
>>>>
>>

