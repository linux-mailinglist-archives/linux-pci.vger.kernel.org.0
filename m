Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A73A388C29
	for <lists+linux-pci@lfdr.de>; Wed, 19 May 2021 12:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240188AbhESK6e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 May 2021 06:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhESK6e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 May 2021 06:58:34 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9EFC06175F
        for <linux-pci@vger.kernel.org>; Wed, 19 May 2021 03:57:14 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id z12so17870026ejw.0
        for <linux-pci@vger.kernel.org>; Wed, 19 May 2021 03:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=eIfk0EYHcUWSLcvMPAirbEiPk6baNKVTiRgoiVmFRVQ=;
        b=sEREbwW6YA7K89gV4VdyhKBYItBL1dOXIUIpz6vkHYFaX579lrecFp4BlVvi4bLDV2
         7mmDvwGebhf89186JpwcGkqyXiAJ2M211zM5uwf0YaTBnLC/+Z/MOfODzLC+wwE8zC/N
         Bh7jLqfIMWLuYvonHfsRPYtJby1hoc3APTq6BrjlcEMikEaueNp8RW+xHAleSETAJTSV
         o2PRo/svgwJZzHBC9/TCiBk/GON7VcGpAPMlpf7YvHb9OsD2R9HIqiXuZh6jMa5JcYe2
         ZESHC6zwqPHrU1JqqaIzvM5gXN7rt7ActRQ82pfTrEcgwmk/QsAtBlcai9GPXZB8MC3H
         HY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=eIfk0EYHcUWSLcvMPAirbEiPk6baNKVTiRgoiVmFRVQ=;
        b=HMBnLP3z6RU8NyFXLX+ywuZPp1pymyAGaSqRLd+uuY0Rp8EURL9X3U615AAcRfel+X
         iJqicGxsQg+jesGoH8+f9JNMaHJNd2V8EHBVOz83G1keevNF1SDBKC7LGWISvs+chwHP
         ZCLXCOOhSk8onWsXA8SAgw7TyBTvm0WpB0HisCVNQiLnK7QyR2VHKj5SQvsNDMod20x1
         ldof/PfUvRBmDhwB9t/HpB9ivCV+9YmlrZqjOjYWkf6Fp30i7OIPTg5EvcRmMdLRa0DA
         wONqUCuL0on3DpDZbG1MYMMcQrmIOoTifMxavER1yrgQZ+VrQEoDKL8lwbAkBE+TOdmG
         T0kQ==
X-Gm-Message-State: AOAM5315qUO2iSEQNPgjvhDwoE37nDk8qLcRutcI2nQOFMs+KKDbInbC
        9l2C3+KsfS3gblJTlsuODWM=
X-Google-Smtp-Source: ABdhPJz4gO4nMeqvJ32qure4n+cnMraucNdsIEccSVII0cCqiNIIAIHE/k+gVZhf+Wfa/zWhifB1JA==
X-Received: by 2002:a17:906:f84:: with SMTP id q4mr12165250ejj.442.1621421833266;
        Wed, 19 May 2021 03:57:13 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:8e28:1d3:41f3:e15a? ([2a02:908:1252:fb60:8e28:1d3:41f3:e15a])
        by smtp.gmail.com with ESMTPSA id g4sm5902727edm.83.2021.05.19.03.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 03:57:12 -0700 (PDT)
Subject: Re: [PATCH v7 13/16] drm/scheduler: Fix hang when sched_entity
 released
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-pci@vger.kernel.org, daniel.vetter@ffwll.ch,
        Harry.Wentland@amd.com
Cc:     ppaalanen@gmail.com, Alexander.Deucher@amd.com,
        gregkh@linuxfoundation.org, helgaas@kernel.org,
        Felix.Kuehling@amd.com
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
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <77efa177-f313-5f1e-e273-6672ed46a90a@gmail.com>
Date:   Wed, 19 May 2021 12:57:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <cd6bbe33-cbc5-43cb-80f7-1cb82a81e65d@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 18.05.21 um 20:48 schrieb Andrey Grodzovsky:
> [SNIP]
>>>
>>> Would this be the right way to do it ?
>>
>> Yes, it is at least a start. Question is if we can wait blocking here 
>> or not.
>>
>> We install a callback a bit lower to avoid blocking, so I'm pretty 
>> sure that won't work as expected.
>>
>> Christian.
>
> I can't see why this would create problems, as long as the dependencies
> complete or force competed if they are from same device (extracted) but
> on a different ring then looks to me it should work. I will give it
> a try.

Ok, but please also test the case for a killed process.

Christian.

>
> Andrey

