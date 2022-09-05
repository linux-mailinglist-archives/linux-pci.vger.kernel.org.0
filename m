Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD62B5AD5E8
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 17:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238434AbiIEPOA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 11:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238414AbiIEPN6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 11:13:58 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E597664;
        Mon,  5 Sep 2022 08:13:55 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id c2so8787376plo.3;
        Mon, 05 Sep 2022 08:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date;
        bh=BaV7TSh2pF8riJo3FYVJlB4Fd0IV89ZBF58eyTHpzCY=;
        b=hkkpU5LscmWAGSEo3MfEtadx9VW4xDHJEup50A1r2cVLlq4cuETMEDvzQMWJ+25cub
         uKJeKBqoA/7oOn5M03KfF2SrWzMp8y/6jxlU6IOGtXhf5NBV25gS8epBm0aJ0S2QGuaI
         RjUYEWJv07AS8q77FSCkemAnzO0cF5SSPIB8vUM+JQ9+01vDbgKIvCwDLFJ0pxGW/o9D
         wfMCMCN77OXaTjmH8xcwvQmxfsPP25DPJzASvB1sg54cKUVgwF0SrI+mVebrCUQXQcEH
         UD6AosLEX29RH6M8jzXceVG7LBfIA3BiQKPCSDkkI0IwATFYFoPoughaGzGm0KCEERIH
         sz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=BaV7TSh2pF8riJo3FYVJlB4Fd0IV89ZBF58eyTHpzCY=;
        b=aJuGClc5tsjvscvnXjLkITqG7kkRJKt0VYNN4nqudjk8DVvHZzg4x3tbSk83CUttlc
         Tu7sqHtw//lwqErYKL0WZ3vrKcGa1mddPu2VbpgMNpmwiWFw2vcYJ8vTJefX5n65+hhc
         ZvsKIl1w+wZwkDredb5vdHhXLWUBewrUZHYSFWH2Del4ShJSmvLLLv8aAHn69LvOJ+kG
         QspDNpbDkqNTJ3/xqzY2trU9Upz7S78y3vSTivt89btLgnyg6yxSILsFrMFH3xoSfKql
         FUI7U8OX+rnyS1UC/AmWo0YMD6yU3g27qI/vom/gezR6JD5Yl1glpyA60Rt0JC2FuTY0
         0PRg==
X-Gm-Message-State: ACgBeo2cpgXXYUWGipEzw/Lk26jegq+zhZmBLHSTifyMgkXebA1Q+MzK
        Z3auTeBbDRF9AedLJFFJmd0=
X-Google-Smtp-Source: AA6agR759HBK1+PQYcZT7IJSAKYI4KNMvzd+GSuzCkEXpLGsOPIUySqoQ8VGjyqne3MH/nAfFroOyA==
X-Received: by 2002:a17:90b:164f:b0:1f5:4ced:ed81 with SMTP id il15-20020a17090b164f00b001f54ceded81mr19722762pjb.122.1662390835165;
        Mon, 05 Sep 2022 08:13:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u15-20020a170903124f00b00176ba091cd3sm1684281plh.196.2022.09.05.08.13.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 08:13:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <75e60144-9fa2-d6ba-bc92-edd23f7e7189@roeck-us.net>
Date:   Mon, 5 Sep 2022 08:13:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 10/11] watchdog: bd9576_wdt: switch to using
 devm_fwnode_gpiod_get()
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
 <20220903-gpiod_get_from_of_node-remove-v1-10-b29adfb27a6c@gmail.com>
 <CAHp75Vd35EOy=mP25=9fmYfqQnbafgotHw1fxk-TdGk6Oc8g8Q@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAHp75Vd35EOy=mP25=9fmYfqQnbafgotHw1fxk-TdGk6Oc8g8Q@mail.gmail.com>
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

On 9/5/22 04:09, Andy Shevchenko wrote:
> On Mon, Sep 5, 2022 at 9:33 AM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>>
>> I would like to stop exporting OF-specific devm_gpiod_get_from_of_node()
>> so that gpiolib can be cleaned a bit, so let's switch to the generic
>> fwnode property API.
>>
>> While at it switch the rest of the calls to read properties in
> 
> it, switch
> 
>> bd9576_wdt_probe() to the generic device property API as well.
> 
> ...
> 
>>          struct device *dev = &pdev->dev;
> 
> struct device *parent = dev->parent;
> 
> can make your code slightly neater.
> 
> ...
> 
>> +       count = device_property_count_u32(dev->parent, "rohm,hw-timeout-ms");
>> +       if (count < 0 && count != -EINVAL)
>> +               return count;
>> +
>> +       if (count > 0) {
> 
>> +               if (count > ARRAY_SIZE(hw_margin))
>> +                       return -EINVAL;
> 
> Why double check? You may move it out of the (count > 0).
> 

Two checks will always be needed, so I don't entirely see
how that would be better.

> ...
> 
>> -       if (ret == 1)
>> -               hw_margin_max = hw_margin[0];
> 
>> +               ret = device_property_read_u32_array(dev->parent,
>> +                                                    "rohm,hw-timeout-ms",
>> +                                                    hw_margin, count);
>> +               if (ret < 0)
>> +                       return ret;
> 
> So, only this needs the count > 0 check since below already has it implicitly.
> 
Sorry, I don't understand this comment.

Guenter

>> -       if (ret == 2) {
>> -               hw_margin_max = hw_margin[1];
>> -               hw_margin_min = hw_margin[0];
>> +               if (count == 1)
>> +                       hw_margin_max = hw_margin[0];
>> +
>> +               if (count == 2) {
>> +                       hw_margin_max = hw_margin[1];
>> +                       hw_margin_min = hw_margin[0];
>> +               }
>>          }
> 

