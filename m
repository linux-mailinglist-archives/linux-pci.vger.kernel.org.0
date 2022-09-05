Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E7D5AD3AE
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 15:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237632AbiIENTq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 09:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237183AbiIENTn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 09:19:43 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EEAB1C5;
        Mon,  5 Sep 2022 06:19:32 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id x10so9240661ljq.4;
        Mon, 05 Sep 2022 06:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date;
        bh=pGQesGh0xflxM2NNiwrV3vQAVchzpYhzdahDdSNlBVo=;
        b=aEV1rqBvjxeacCvbFAd75H8X+CLchRyr/9zk9hD5i+6fjI5goF+z+vIzX1EGx55/p9
         IfgVdpjG1lFai91AKbjODKz/lHpxARajtjO0/XKEwTClgiAl+jHg1q1ZtcTqJSaZrYig
         kR3nTls+hkJUs4NpQl2JVkq0vuRSRbe2NpaIwzLJ3K0lc2PYHZIJgtnpLxVkCAdOdqcg
         ifK8uUxAARVYld1UXOrpCEvf1+8Q58EAJpFgdgBI0Ykb1k2J1j5CvEJW09aSZVHcvkGr
         fxrI6jqgvxBr8C13oZ4g0Qi71fqmPNdwqufFP+tdxrdtH88X4uGtw6Kli6+zcfTbP5V8
         zGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=pGQesGh0xflxM2NNiwrV3vQAVchzpYhzdahDdSNlBVo=;
        b=ScP/FYc4oSCqNZbi81FaP1IWftipB9u2UGXmlodqkoj9CRxSAhSuumIRkA7ZHlhadp
         PHEXKLpiRGljP0ZDjZP/lHyFw5lP70jZ3AM1CIvC7oYZsXptnYLcdmGxN0hA5oPQwUBY
         Z1Y7iaQryCHtMYCsjul6WOz52N0GDnjymYklQPMPm3JQe3JkVgnKdvSXYkaNH1Dr9gSH
         PrpBBcGl0OGTbtKTE3NL8S1aWFDY2VN6EJ/wKUhXLzVvia1AAeOsoEgh/a6HvCiIwnWE
         wjLPuzcsFA3vB35E7cNIyEml9DXobEuj13pTnc9P1izEtqkF6NmBn4wFu2Gwn2TNK15R
         KMrQ==
X-Gm-Message-State: ACgBeo12RUSUXKRr/JjUWLomU6BF5mVeL8cswwrNbEgFS4uLJ7N5w0aG
        xD+tvKOQH1rf91S+2dDm5K8=
X-Google-Smtp-Source: AA6agR6wIqHobJs4RjQ5AZ5zLGEJ30t4jOYW4FD1Y52S1XDgSMO7S1BLZYEyclCz9BqREtsj5+Cabg==
X-Received: by 2002:a05:651c:54c:b0:25f:dd42:5d06 with SMTP id q12-20020a05651c054c00b0025fdd425d06mr15535256ljp.161.1662383969981;
        Mon, 05 Sep 2022 06:19:29 -0700 (PDT)
Received: from [172.16.194.195] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 11-20020a05651c128b00b00261e8f25460sm1409150ljc.14.2022.09.05.06.19.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 06:19:29 -0700 (PDT)
Message-ID: <0fa0c09f-c801-a0c7-1f6e-b6cc8b45d961@gmail.com>
Date:   Mon, 5 Sep 2022 16:19:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
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
 <20220903-gpiod_get_from_of_node-remove-v1-9-b29adfb27a6c@gmail.com>
 <CAHp75VeA+oVPmsEOg+y0cvRcTU5qA+Y+9=Byp0C982EB7SAArQ@mail.gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v1 09/11] regulator: bd9576: switch to using
 devm_fwnode_gpiod_get()
In-Reply-To: <CAHp75VeA+oVPmsEOg+y0cvRcTU5qA+Y+9=Byp0C982EB7SAArQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/5/22 13:40, Andy Shevchenko wrote:
> On Mon, Sep 5, 2022 at 9:33 AM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>>
>> I would like to stop exporting OF-specific devm_gpiod_get_from_of_node()
>> so that gpiolib can be cleaned a bit, so let's switch to the generic
>> fwnode property API.
>>
>> While at it switch the rest of the calls to read properties in
>> bd957x_probe() to the generic device property API as well.
> 
> With or without below addressed,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>
>> diff --git a/drivers/regulator/bd9576-regulator.c b/drivers/regulator/bd9576-regulator.c
>> index aa42da4d141e..393c8693b327 100644
>> --- a/drivers/regulator/bd9576-regulator.c
>> +++ b/drivers/regulator/bd9576-regulator.c
>> @@ -12,6 +12,7 @@
>>   #include <linux/module.h>
>>   #include <linux/of.h>
>>   #include <linux/platform_device.h>
>> +#include <linux/property.h>
>>   #include <linux/regulator/driver.h>
>>   #include <linux/regulator/machine.h>
>>   #include <linux/regulator/of_regulator.h>
>> @@ -939,8 +940,8 @@ static int bd957x_probe(struct platform_device *pdev)
>>          }
>>
>>          ic_data->regmap = regmap;
>> -       vout_mode = of_property_read_bool(pdev->dev.parent->of_node,
>> -                                        "rohm,vout1-en-low");
>> +       vout_mode = device_property_read_bool(pdev->dev.parent,
>> +                                             "rohm,vout1-en-low");
> 
> They all using parent device and you may make code neater by adding
> 
>    struct device *parent = pdev->dev.parent;

This is a matter of personal preference. I prefer seeing 
pdev->dev.parent - as it is more obvious (to me) what the 'pdev' is than 
what 'parent' would be.

I'd use the local variable only when it shortens at least one of the 
lines so that we avoid splitting it. After that being said - I'm not 
going to argue over this change either if one who is improving the 
driver wants to use the "helper" variable here.

Best Regards
	-- Matti


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
