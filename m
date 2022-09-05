Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02635AD167
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 13:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237712AbiIELJt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 07:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236361AbiIELJr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 07:09:47 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DE411C24;
        Mon,  5 Sep 2022 04:09:46 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id u5so1861496qvv.3;
        Mon, 05 Sep 2022 04:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ZD4YC1HXrtSaQEFJiBqrgz0UPEGxSAaPa+lNAJ8WZi0=;
        b=W0LYg/x6oLLMVr5A9MMBVb+TxN0pk4+3xuh3Q/ipfqH1hrq5kvR4C13ZGg+8+DEqSd
         gi1J5ByiQnS+4NrTCIvUT/kKaXn5hL9zW9YV18N0SnlPLU0irWOq7beGGmmV2it9I/V8
         TSz0IwHJZsNw1mnLJ+EmjO0aVsfTD6x8QeroaNTk/ISAjEimxSO9AuqJQS/RTnqxI8me
         UqWOiBI+Wn0HCU5QQ9nYXLzwM0PBRWriqZaCP3K1erw3D5FZR6d/x6x4b60TAHtECET6
         J6AxXbDHgN6gXzpMM9fNWwiGiQLT2KqoyWZt7c52eyHpDdJ+EY+BURgwhcI9q/0V9kVd
         TT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ZD4YC1HXrtSaQEFJiBqrgz0UPEGxSAaPa+lNAJ8WZi0=;
        b=wgLBpPrCJtmuZyoijHMihtDHYBEW+ru+RpIM5l52k2AICyBfqCvug8AXnCI+zl+cOU
         824F4rle26spkOdSyQogcWIjYp6zprOu0XpQM3OuMn2lIPTfSko2ek6tH0VtV6fqZeFO
         iTSM1UOHdgdp//z6Au/vn/DjgkHgnBajR+RAzTQBZslY2g5FBaEeEEUHrRv8SeG9LFjd
         yzMcJSObkjlTivsPW/kb0xq85xLQyEM3Od9rFGmQjZpOM1M0t2RF2j7+OyeH4unLMjZB
         t2X8C3ySFPAFcVShz9PHY4vcoCj/fW39i2MbjKcw8yl7e1nN9eH3mgQxfBa+FGImkuV4
         3Tsw==
X-Gm-Message-State: ACgBeo3uOVs6S9ovaZb+/NCbe+gy+Nqg5i4hC9Hw4w6w8anUqJIx7+Hf
        tOjbXRSrHn5MDp5fzWhCuXLWekXve1GAaCOjPY4=
X-Google-Smtp-Source: AA6agR5jCq5/GjKb+apw06fa/2t9tC05H0ZPM5KdsjnljOtEm1B4hEVBpVM1iH3NQHKg14ReUnIBjf+3AuFTQfBZ7lg=
X-Received: by 2002:a0c:e24b:0:b0:4a1:d41b:e280 with SMTP id
 x11-20020a0ce24b000000b004a1d41be280mr5474897qvl.11.1662376185481; Mon, 05
 Sep 2022 04:09:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220903-gpiod_get_from_of_node-remove-v1-0-b29adfb27a6c@gmail.com>
 <20220903-gpiod_get_from_of_node-remove-v1-10-b29adfb27a6c@gmail.com>
In-Reply-To: <20220903-gpiod_get_from_of_node-remove-v1-10-b29adfb27a6c@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 5 Sep 2022 14:09:09 +0300
Message-ID: <CAHp75Vd35EOy=mP25=9fmYfqQnbafgotHw1fxk-TdGk6Oc8g8Q@mail.gmail.com>
Subject: Re: [PATCH v1 10/11] watchdog: bd9576_wdt: switch to using devm_fwnode_gpiod_get()
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
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
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
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
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 5, 2022 at 9:33 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> I would like to stop exporting OF-specific devm_gpiod_get_from_of_node()
> so that gpiolib can be cleaned a bit, so let's switch to the generic
> fwnode property API.
>
> While at it switch the rest of the calls to read properties in

it, switch

> bd9576_wdt_probe() to the generic device property API as well.

...

>         struct device *dev = &pdev->dev;

struct device *parent = dev->parent;

can make your code slightly neater.

...

> +       count = device_property_count_u32(dev->parent, "rohm,hw-timeout-ms");
> +       if (count < 0 && count != -EINVAL)
> +               return count;
> +
> +       if (count > 0) {

> +               if (count > ARRAY_SIZE(hw_margin))
> +                       return -EINVAL;

Why double check? You may move it out of the (count > 0).

...

> -       if (ret == 1)
> -               hw_margin_max = hw_margin[0];

> +               ret = device_property_read_u32_array(dev->parent,
> +                                                    "rohm,hw-timeout-ms",
> +                                                    hw_margin, count);
> +               if (ret < 0)
> +                       return ret;

So, only this needs the count > 0 check since below already has it implicitly.

> -       if (ret == 2) {
> -               hw_margin_max = hw_margin[1];
> -               hw_margin_min = hw_margin[0];
> +               if (count == 1)
> +                       hw_margin_max = hw_margin[0];
> +
> +               if (count == 2) {
> +                       hw_margin_max = hw_margin[1];
> +                       hw_margin_min = hw_margin[0];
> +               }
>         }

-- 
With Best Regards,
Andy Shevchenko
