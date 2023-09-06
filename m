Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B110793A5D
	for <lists+linux-pci@lfdr.de>; Wed,  6 Sep 2023 12:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236732AbjIFKum (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Sep 2023 06:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjIFKum (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Sep 2023 06:50:42 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6672FE7C;
        Wed,  6 Sep 2023 03:50:38 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9936b3d0286so545084066b.0;
        Wed, 06 Sep 2023 03:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693997437; x=1694602237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nPk6ISCbpC/CANW4MjLpjXtvg/rj6Md91X1eJZ3mRGw=;
        b=iBtDr73p6AkLuN3johBuYB8+WeGqakC5kDAHVhr3BQe4tiDN81hIjKcIeAz+kzcGDd
         tozNok0unG6B1eY4S7QgTaX9OmiFQ/K8XwNjZjfsovasGxHw+wg5hqwsxPWAhibS4yLu
         Wg1NqjEdYYjAuFSD+cIAv2218ocrqLxCYyTdLrcem8W/p9h3OCm5zZpgLErXW6g04jJG
         824iKzutZSWu5Q7n9gPHTVOojoCJR4txjmn7H3suwXZ6Ljgj0XVTabct+/4n5QPliCDP
         j879bQOCtBE3OMN5f8DIvw1/VQq5Y9ViCzFTW0e0JYc+qj0Ee+jAYc7P+kEc22FeYzmB
         Edvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693997437; x=1694602237;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nPk6ISCbpC/CANW4MjLpjXtvg/rj6Md91X1eJZ3mRGw=;
        b=VnDNWdT+Y/NiCavSvehvV/Xj5oGVFYlwIBT+Vbg7sAKhu3VGT/fTu+xT58rykj1ZU0
         DtRLNs4uRBcNTUv2atOx4KmYXeqasX8AxpMviGItt3+8hg0FKzG7FpdSOxDY4Ccd2Hg4
         KU+tcBmEiGSdTpK37k0TmHXM/PZLqJ8OUJcGiOAW4VEHddBHK0ejdbncFYRG1Il6V1cl
         5e2+czjEMjYZQQqrST7V5EtzbhTJ/MLtB4XMZsfBIM7Fdlmir4fRlSRzCmPrvrvm0DU6
         QXzfsRVaAB48gG8MGYJpqQvHYw1T9jiu/uBwfBhCPScs/Tb032XklhHgjOpPWRnGi5c5
         wHzQ==
X-Gm-Message-State: AOJu0YzbO+LzWwV9WUa1mLxl/j4LAVn/EvkbfyWU6I7uedt8n5czX7bb
        m3QOXn6/Iq60xYtX9g0/OWc=
X-Google-Smtp-Source: AGHT+IFk9TQYmwQo+qVqsWZZOhkdOtC/LJqkg8MfHz53csekPCdvAFo5iqnoSkWLn7w1U6kezNBPxQ==
X-Received: by 2002:a17:906:4ad1:b0:99c:55ac:3a61 with SMTP id u17-20020a1709064ad100b0099c55ac3a61mr1964920ejt.56.1693997436639;
        Wed, 06 Sep 2023 03:50:36 -0700 (PDT)
Received: from [192.168.178.25] ([134.19.97.6])
        by smtp.gmail.com with ESMTPSA id w22-20020a170906131600b0099d9b50d786sm8880526ejb.199.2023.09.06.03.50.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 03:50:33 -0700 (PDT)
Message-ID: <4df435a0-dd9b-121a-8820-e331bb8a046f@gmail.com>
Date:   Wed, 6 Sep 2023 12:50:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Nouveau] [RFC, drm-misc-next v4 0/9] PCI/VGA: Allowing the user
 to select the primary video adapter at boot time
Content-Language: en-US
To:     Sui Jingfeng <sui.jingfeng@linux.dev>,
        suijingfeng <suijingfeng@loongson.cn>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
References: <20230904195724.633404-1-sui.jingfeng@linux.dev>
 <44ec8549-dc36-287e-4359-abd3ec8d22d6@suse.de>
 <5afd2efb-f838-f9b7-02a9-2cf4d4fd2382@loongson.cn>
 <2adfa653-ac35-d560-be52-c92848a1eef5@gmail.com>
 <873b331a-d0ce-658c-6daa-02bf816e92d1@linux.dev>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <873b331a-d0ce-658c-6daa-02bf816e92d1@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 06.09.23 um 12:31 schrieb Sui Jingfeng:
> Hi,
>
> On 2023/9/6 14:45, Christian König wrote:
>>> Firmware framebuffer device already get killed by the 
>>> drm_aperture_remove_conflicting_pci_framebuffers()
>>> function (or its siblings). So, this series is definitely not to 
>>> interact with the firmware framebuffer
>>> (or more intelligent framebuffer drivers).  It is for user space 
>>> program, such as X server and Wayland
>>> compositor. Its for Linux user or drm drivers testers, which allow 
>>> them to direct graphic display server
>>> using right hardware of interested as primary video card.
>>>
>>> Also, I believe that X server and Wayland compositor are the best 
>>> test examples.
>>> If a specific DRM driver can't work with X server as a primary,
>>> then there probably have something wrong.
>>>
>>>
>>>> But what's the use case for overriding this setting?
>>>>
>>>
>>> On a specific machine with multiple GPUs mounted,
>>> only the primary graphics get POST-ed (initialized) by the firmware.
>>> Therefore, the DRM drivers for the rest video cards, have to choose to
>>> work without the prerequisite setups done by firmware, This is 
>>> called as POST.
>>
>> Well, you don't seem to understand the background here. This is 
>> perfectly normal behavior.
>>
>> Secondary cards are posted after loading the appropriate DRM driver. 
>> At least for amdgpu this is done by calling the appropriate functions 
>> in the BIOS. 
>
>
> Well, thanks for you tell me this. You know more than me and 
> definitely have a better understanding.
>
> Are you telling me that the POST function for AMDGPU reside in the BIOS?
> The kernel call into the BIOS?

Yes, exactly that.

> Does the BIOS here refer to the UEFI runtime or ATOM BIOS or something 
> else?

On dGPUs it's the VBIOS on a flashrom on the board, for iGPUs (APUs as 
AMD calls them) it's part of the system BIOS.

UEFI is actually just a small subsystem in the system BIOS which 
replaced the old interface used between system BIOS, video BIOS and 
operating system.

>
> But the POST function for the drm ast, reside in the kernel space (in 
> other word, in ast.ko).
> Is this statement correct?

I don't know the ast driver well enough to answer that, but I assume 
they just read the BIOS and execute the appropriate functions.

>
> I means that for ASpeed BMC chip, if the firmware not POST the display 
> controller.
> Then we have to POST it at the kernel space before doing various 
> modeset option.
> We can only POST this chip by directly operate the various registers.
> Am I correct for the judgement about ast drm driver?

Well POST just means Power On Self Test, but what you mean is 
initializing the hardware.

Some drivers can of course initialize the hardware without the help of 
the BIOS, but I don't think AST can do that. As far as I know it's a 
relatively simple driver.

BTW firmware is not the same as the BIOS (which runs the POST), firmware 
usually refers to something run on microcontrollers inside the ASIC 
while the (system or video) BIOS runs on the host CPU.

Regards,
Christian.

>
> Thanks for your reviews.
>

