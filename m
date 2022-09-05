Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24AB5ADB17
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 00:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbiIEWIB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 18:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbiIEWH6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 18:07:58 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30ADF51A0D;
        Mon,  5 Sep 2022 15:07:53 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id h188so8956130pgc.12;
        Mon, 05 Sep 2022 15:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date;
        bh=DI+EGf5Iiw4yLnQOM0iLSEUhYarB1qtVETYwX3ATTlI=;
        b=KDxaSPeOmIAHodHZoxO7+rPppr+0nc84E7WjJr09aHXf0y70VUqQeiGwM4ZbMT1+IG
         aswpW6qIia4RuP0oy/zixSqOkdUMGcBdQBZ+zCXrSbs5gzJjxQbyCJKm+qaEmHP0fbLr
         p+VnLtgDb/UqRnZ5jH6rY49caFH+X+TV7pDArSwV7zY/jQ9Qvi10MQT7HP3yHqCz6Ymq
         3ER0a2FyOYkl9+aJiUSNvNKZnQFKEXdO6qjVPIArqiSCS2eFf74FcrePSlFKeiFjZiPh
         a3swNk1c3KCQbDFwBwgMcHrg1CM/Xc0KnXfSUNi2LqKeA1gvQb715UJnDwV5eFIZMn4E
         JSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=DI+EGf5Iiw4yLnQOM0iLSEUhYarB1qtVETYwX3ATTlI=;
        b=vBmhdeYALxw43twfMlS5Zd7LvvqaHOdzCCq/lo+5jKZWE+Sa/TE24Gbh9H3DLAnKXp
         oiwpsuUHxJTxrtSdu+KB+CeZWkAwbMcjsHb5/4yo/gAt81l5XpmV5S2YaM6sG7G+oPpE
         A48KR2KrVNuA3/DPyI35cAGYZzJHKGpNe8IJeKIT8FX8DnjfyOz7gDJ89OSEDg92BtRx
         cSjTMKU9U1Nu4M9zfXzNQ0vMqTfLlwPCCYPVMnR18ZVxPID6wV2IQJCoc6d8tXFBfnXV
         PCixZPH99k4zVdsSaVEcdPiKSFhRMOvzuWXHaPTbzsMRq5SODm7hgm5sfrrQHi3W+2TA
         n3sA==
X-Gm-Message-State: ACgBeo35q2vU7tTZkaJAOy4bwpZbvFRIudGhEALraggx/oIpYvzHLqHu
        PXR2iKdPaPfzXAk8gFasguY=
X-Google-Smtp-Source: AA6agR5VFvTDdUbzbYgkiV1tQs8QlnywRsbF0wBwVMI81k5tziGUND19h0NyYI/NQTVei/R57vjcgw==
X-Received: by 2002:a63:2cc2:0:b0:41c:681d:60d2 with SMTP id s185-20020a632cc2000000b0041c681d60d2mr41816293pgs.502.1662415672598;
        Mon, 05 Sep 2022 15:07:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m16-20020a170902db1000b00172dd10f64fsm8157821plx.263.2022.09.05.15.07.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 15:07:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4a0d089d-6ac6-b92e-6ac7-3d3de0144b4b@roeck-us.net>
Date:   Mon, 5 Sep 2022 15:07:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Marc Zyngier <maz@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        David Airlie <airlied@linux.ie>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
References: <20220903-gpiod_get_from_of_node-remove-v1-0-b29adfb27a6c@gmail.com>
 <20220903-gpiod_get_from_of_node-remove-v1-4-b29adfb27a6c@gmail.com>
 <CAHp75VdMr7wru-2hD1HH3OS5JTNdzt6VRqB6OFoCp2JkiuiTjw@mail.gmail.com>
 <YxZQj8bwJCx5rqDv@google.com>
 <CAHp75VdHJS4YgrTK15OuY5sxodxKObUtzturL+YPXFQ3_wpxig@mail.gmail.com>
 <YxZTS3Nl1YaMGoBC@google.com>
 <CAHp75VeNajcf-Y6xvDDVwZijg6U53ggg1HQox1AZ74=wRut+1Q@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v1 04/11] usb: phy: tegra: switch to using
 devm_gpiod_get()
In-Reply-To: <CAHp75VeNajcf-Y6xvDDVwZijg6U53ggg1HQox1AZ74=wRut+1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/5/22 12:55, Andy Shevchenko wrote:
> On Mon, Sep 5, 2022 at 10:51 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>> On Mon, Sep 05, 2022 at 10:41:40PM +0300, Andy Shevchenko wrote:
>>> On Mon, Sep 5, 2022 at 10:40 PM Dmitry Torokhov
>>> <dmitry.torokhov@gmail.com> wrote:
>>>> On Mon, Sep 05, 2022 at 01:59:44PM +0300, Andy Shevchenko wrote:
>>>>> On Mon, Sep 5, 2022 at 9:32 AM Dmitry Torokhov
>>>>> <dmitry.torokhov@gmail.com> wrote:
> 
> ...
> 
>>>>>> -               gpiod = devm_gpiod_get_from_of_node(&pdev->dev, np,
>>>>>> -                                                   "nvidia,phy-reset-gpio",
>>>>>> -                                                   0, GPIOD_OUT_HIGH,
>>>>>> -                                                   "ulpi_phy_reset_b");
>>>>>> +               gpiod = devm_gpiod_get(&pdev->dev, "nvidia,phy-reset",
>>>>>> +                                      GPIOD_OUT_HIGH);
>>>>>>                  err = PTR_ERR_OR_ZERO(gpiod);
>>>>>
>>>>> What does _OR_ZERO mean now?
>>>>
>>>> This converts a pointer to an error code if a pointer represents
>>>> ERR_PTR() encoded error, or 0 to indicate success.
>>>
>>> Yes, I know that. My point is, how is it useful now (or even before)?
>>> I mean that devm_gpio_get() never returns NULL, right?
>>
>> What does returning NULL have to do with anything.
> 
> It has to do with a dead code. If defm_gpiod_get() does not return
> NULL, then why do we even bother to check?
> 

PTR_ERR_OR_ZERO() converts into an error code (if the pointer is an
ERR_PTR) or 0 if it is a real pointer. Its purpose is not to convert
NULL into 0, its purpose is to convert a pointer either into an error
code or 0. That is what is done here, and it is done all over the place
in the kernel. I don't see your problem with it. Care to explain ?

>> It converts a pointer
>> to a "classic" return code, with negative errors and 0 on success.
>>
>> It allows to not use multiple IS_ERR/PTR_ERR in the code (I'd need 1
>> IS_ERR and 2 PTR_ERR, one in dev_err() and another to return).
> 
> I don't see how this is relevant.
> 

You lost me. Really, please explain your problem with PTR_ERR_OR_ZERO().

Thanks,
Guenter
