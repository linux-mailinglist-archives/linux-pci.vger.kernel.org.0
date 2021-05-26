Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C129539193E
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 15:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbhEZN5I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 May 2021 09:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbhEZN5I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 May 2021 09:57:08 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992F7C061574;
        Wed, 26 May 2021 06:55:36 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id q5so1248067wrs.4;
        Wed, 26 May 2021 06:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=TU3P0IKFMilt8ibVl4VKMuJHkoYIAn/qixm+CzZt3XY=;
        b=T+HcjrsEUXOWGUaWTnZju5AIaSnH3PqjPOwPYW4ipUV9yRsxBetzMULBBoAT56Qtpf
         H/M3FCtNPj8Iwtl2jeHEFPrmL/YVEhWJC+Q3TI00deH4ryOMAcie/C7EJpO/dF3jMS6i
         8eMb0/A2yCsXyQFkjK22XArq2m4ne2dnuCxkwBWln8tZ40wLcaPxyeBo7fx5/0Qj2Ulk
         ZqVpUlFcSWiIxmmiBpq/dvfLyuNDZEeLU749VaEK5j8EcbkbW9uHJTqGbpIPgjAgLHY+
         Favy5rTCkaS96KEiLjFbk0btiPUpw4/dgL4n9SAGqMUVoeRP1HLKcEY4wgmIk2qe89nP
         iXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=TU3P0IKFMilt8ibVl4VKMuJHkoYIAn/qixm+CzZt3XY=;
        b=eheUH/IQlUOfpfUR2+yIKwwoV4LueTCpktaJ6M4qAYiAu+SxJ/t+cr3ZZrR7P2Z/4v
         cWjtm3o3BVv++vV5iQLlCyDmb6NhdgZPb4iA/kHaOWNEy8fjUot6DGi9JSvOEVeLyxZt
         29lKZYXTkUktBWGft5rWhg1lQuhGWO4aukcW8BOr7d0E9pZDnzBQ0mMdwNvmvTCI90nq
         xI/NMJ3yJxXA9K4FIcRD2Jjzt5U/ObbUqGds+gNEUmAqCmHnB+RFCvBp2jG9IvY4LHLl
         NmAFG0fgrP2Ao0IKV0a33ioVgqFb4TKIqBc5Pi8WzAtc0tYvLZluXnvVgZ2vn3oEs4zk
         R7Uw==
X-Gm-Message-State: AOAM532Le8fLl8JLGR04/0r1AO9VPvU+ypY1bsd6rg/DzvtwRazEs008
        4pxnCTkgbwVLxev7hnNiEc0OkcRYRao=
X-Google-Smtp-Source: ABdhPJycBxK7z+PqUyXbcZFcoctpc91ER13IQRbQetENRae626IdwcBDhfNknbM4cqForIgAI2dTYQ==
X-Received: by 2002:a5d:6c61:: with SMTP id r1mr33494342wrz.309.1622037334799;
        Wed, 26 May 2021 06:55:34 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:1950:35e:cae9:5bed? ([2a02:908:1252:fb60:1950:35e:cae9:5bed])
        by smtp.gmail.com with ESMTPSA id l188sm2272741wmf.27.2021.05.26.06.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 06:55:34 -0700 (PDT)
Subject: Re: [BUG] rockpro64: PCI BAR reassignment broken by commit
 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource flags for 64-bit
 memory addresses")
To:     Ard Biesheuvel <ardb@kernel.org>, Peter Geis <pgwipeout@gmail.com>
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Leonardo Bras <leobras.c@gmail.com>,
        Rob Herring <robh@kernel.org>, PCI <linux-pci@vger.kernel.org>
References: <7a1e2ebc-f7d8-8431-d844-41a9c36a8911@arm.com>
 <01efd004-1c50-25ca-05e4-7e4ef96232e2@arm.com> <87eedxbtkn.fsf@stealth>
 <CAMj1kXE3U+16A6bO0UHG8=sx45DE6u0FtdSnoLDvfGnFJYTDrg@mail.gmail.com>
 <877djnaq11.fsf@stealth>
 <CAMj1kXFk2u=tbTYpa6Vqz5ihATFq61pCDiEbfRgXL_Rw+q_9Fg@mail.gmail.com>
 <CAMdYzYo-vdJvT_MPNTYvdveG3W8na7qMVEZFL4AjyQWqcLZi=Q@mail.gmail.com>
 <CAMj1kXEBePfKDOc6eo9yjZPnVeFimX-zxR+R3As+2pP9XnZkuQ@mail.gmail.com>
 <CAMdYzYrH_M92Pc6AqTgagtATr1TPq7Pdm57hadZeAmMBF2f0nA@mail.gmail.com>
 <CAMj1kXHsGgFedbhW2CiS5gveK3=ZxhXQ5siDeHJyttkOVKBQrQ@mail.gmail.com>
 <CAMdYzYruNYtJ8hwKPBUHPed1-=tV=CWDd_oSQtRmr4BJHp=YxA@mail.gmail.com>
 <CAMj1kXHLCJbzRpic-kkdWh5wKTE=6fqkesYbB6XoeJELKn93tw@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <9b99d520-e4b1-ae44-44eb-93c2e3d0c0cb@gmail.com>
Date:   Wed, 26 May 2021 15:55:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAMj1kXHLCJbzRpic-kkdWh5wKTE=6fqkesYbB6XoeJELKn93tw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Ard,

Am 25.05.21 um 19:18 schrieb Ard Biesheuvel:
> [SNIP]
>>> I seriously doubt that this is what is going on here.
>>>
>>> lspci -x will give you the bare BAR values - I suspect that those are
>>> probably fine.
>> lspci -x
>> 00:00.0 PCI bridge: Fuzhou Rockchip Electronics Co., Ltd Device 3566 (rev 01)
>> 00: 87 1d 66 35 07 05 10 40 01 00 04 06 00 00 01 00
>> 10: 00 00 00 00 00 00 00 00 00 01 ff 00 10 10 00 20
>> 20: 00 10 00 10 01 00 f1 0f 00 00 00 00 00 00 00 00
>> 30: 00 00 00 00 40 00 00 00 00 00 00 00 5f 01 02 00
>>
>> 01:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
>> [AMD/ATI] Turks PRO [Radeon HD 7570]
>> 00: 02 10 5d 67 07 00 10 20 00 00 00 03 00 00 80 00
>> 10: 0c 00 00 00 00 00 00 00
> This is a 64-bit prefetchable BAR programmed with bus address 0x0
>
>> 04 00 00 10 00 00 00 00
> This is a 64-bit non-prefetchable BAR programmed with bus address 0x1000_0000
>
> (https://en.wikipedia.org/wiki/PCI_configuration_space describes the
> meaning of the low order BAR bits)

Sorry for jumping into the middle of the discussion and to be honest I 
haven't fully read it.

This looks a bit odd since on AMD VGA hardware the non-prefetchable BAR 
is usually only 32bit, not 64bit.

But this hardware generation is rather old and I'm not sure what the BAR 
assignment for that generation was. I would need to dig up the register 
description in our archives as well.

Christian.

>
>> 20: 01 10 70 3f 00 00 00 00
> This looks odd. This looks like a 32-bit MMIO address poked into a I/O BAR.
>
>
>> 00 00 00 00 28 10 20 2b
>> 30: 00 00 02 10 50 00 00 00 00 00 00 00 5f 01 00 00
>>
>> 01:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Turks
>> HDMI Audio [Radeon HD 6500/6600 / 6700M Series]
>> 00: 02 10 90 aa 06 00 10 20 00 00 03 04 00 00 80 00
>> 10: 04 00 04 10 00 00 00 00 00 00 00 00 00 00 00 00
>> 20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 90 aa
>> 30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 02 00 00
>>
>>>
>>>>>> Also, if <0x82000000> (32 bit) is changed to <0x83000000> (64 bit),
>>>>>> most of the allocations for the dGPU fail due to no valid regions
>>>>>> available.
>>>>>>
>>>>> But wasn't the original problem that the resource window was 64-bit to
>>>>> begin with? Are you sure we are talking about the same problem here?
>>>> The rk3399 in the original report has a 32MB memory window in the
>>>> upper end of the 4GB range.
>>>> The rk356x has a similar layout, or it can use a 1GB window available
>>>> at <0x3 0x00000000>.
>>>> Rockchip's default windows are defined as 64bit.
>>>>
>>>> The rk3399 doesn't have enough space to reasonably define two windows,
>>>> one 32bit, one 64bit, to work around an allocation bug.
>>>> These are the defined regions in the rk3399:
>>>> ranges = <0x83000000 0x0 0xfa000000 0x0 0xfa000000 0x0 0x1e00000>,
>>>> <0x81000000 0x0 0xfbe00000 0x0 0xfbe00000 0x0 0x100000>;
>>>>
>>> All you really need is a 32-bit non-prefetchable resource window: any
>>> BAR can be allocated from that. A 64-bit BAR can carry a 32-bit number
>>> (just add zeroes at the top), and a prefetchable BAR can happily live
>>> in a non-prefetchable window, with a theoretical performance impact if
>>> the OS actually does use different memory attributes for the
>>> prefetchable window (but I don't think Linux ever handles it this way)
>> So is the IO range necessary as well or will it be automatically
>> allocated as well?
>>
> You need one I/O range and one 32-bit non-prefetchable MMIO window at
> the very least, even though the I/O range is rarely used, even by
> endpoints that expose I/O BARs.
>
> The translation is tricky to get right, and confuses some drivers, so
> it is better avoided if possible. If you do need translation, make
> sure to translate in the right direction.
>
>>>
>>>>>
>>>>>>>> I am happy to put something together once I understand the preferred way
>>>>>>>> to go about it.
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Punit
>>>>>>>>
>>>>>>>> [...]
>>>>>>>>
>>>>>>> _______________________________________________
>>>>>>> Linux-rockchip mailing list
>>>>>>> Linux-rockchip@lists.infradead.org
>>>>>>> http://lists.infradead.org/mailman/listinfo/linux-rockchip

