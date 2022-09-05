Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D5E5AD05F
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 12:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237330AbiIEKlW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 06:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236511AbiIEKlT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 06:41:19 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2927F4C624;
        Mon,  5 Sep 2022 03:41:19 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id g14so5837143qto.11;
        Mon, 05 Sep 2022 03:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=kd7g7axcQ4As/Ok0I5izIzwGPbtYaPyDkbWIGk2kRMc=;
        b=a4V6ibAx1P4YjsDZwhtMLMuWUwWCK3+Yn9JF3VwjA4fF5N0JKuAGKvW0x7Oeq36vRu
         ZD2NpBYMNC8pDvV3B9bTynqivMhFDkGOtzwr7JY7i6mY6fQ9mOwr7PCsrNfMvKVlTB6m
         AQwPmzkKfJqq/qd3lYrZAvkeG/klQ18FzMuuftSPGpjscQilPNTppd9oLyhCECyBTnmS
         uo+4FUsm1gWsG4XuM9BafRncQA8YVM65g/X3SPg8260dxRuAheVR5JT3lXCfMda99osm
         3ghxFB0uVJftBWwHDXIPOXJK9RgFq/ZehUGlD71aQbbwaHNfsi/Wi+FWVWYy7rB5ueEz
         4ZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=kd7g7axcQ4As/Ok0I5izIzwGPbtYaPyDkbWIGk2kRMc=;
        b=fS38WuL+y89CFcR4bObI+GY0Jt70yC4nxDJvdd+qk11KLxRHNaV0zKSRBZcJNleBGX
         CkriUpWIID6NE6uRoc6tq7qKOJichj79PcUGs6nL6yM+ISSYeLZnUuOAvrsrLj4nfXYB
         XSqs/koI41Rgj/Zznv+A+FfLktK/lsx5o6Hdl6AC7AWY/RrWBibSglHr1WKFz7oU+ruB
         mGe11AbjQaDuydcgcUcsV2aLlVpd75wJ2yzx73GaGPAKy8BGi8Po0t9kFBB0odiAnLMO
         0oq6iCGI24zSt5TDPuPHlT14w/e3zWUUhS1jevfDVip3ZyuP8D2mjZNx7UJrqPM85wSV
         /kVg==
X-Gm-Message-State: ACgBeo3wLJBBYCGCx0ilDr3W3hnKIF9+sMSnU3a2PCmnOA45cVmhXF03
        JmpoJP0D2vWhNH5xfzYiVTE+2IhpoBk61Lg2ffQ=
X-Google-Smtp-Source: AA6agR5jckAzCxTGD9mkHIt9A012zarGH47OL+wuWeavoOdmt2QYtP37qTO1N0BzU0mjGhkgR0fMvN19uxKTRqEH6ZQ=
X-Received: by 2002:ac8:7dd0:0:b0:344:afc1:b11d with SMTP id
 c16-20020ac87dd0000000b00344afc1b11dmr37941390qte.195.1662374478234; Mon, 05
 Sep 2022 03:41:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220903-gpiod_get_from_of_node-remove-v1-0-b29adfb27a6c@gmail.com>
 <20220903-gpiod_get_from_of_node-remove-v1-9-b29adfb27a6c@gmail.com>
In-Reply-To: <20220903-gpiod_get_from_of_node-remove-v1-9-b29adfb27a6c@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 5 Sep 2022 13:40:42 +0300
Message-ID: <CAHp75VeA+oVPmsEOg+y0cvRcTU5qA+Y+9=Byp0C982EB7SAArQ@mail.gmail.com>
Subject: Re: [PATCH v1 09/11] regulator: bd9576: switch to using devm_fwnode_gpiod_get()
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
> bd957x_probe() to the generic device property API as well.

With or without below addressed,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> diff --git a/drivers/regulator/bd9576-regulator.c b/drivers/regulator/bd9576-regulator.c
> index aa42da4d141e..393c8693b327 100644
> --- a/drivers/regulator/bd9576-regulator.c
> +++ b/drivers/regulator/bd9576-regulator.c
> @@ -12,6 +12,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/regulator/driver.h>
>  #include <linux/regulator/machine.h>
>  #include <linux/regulator/of_regulator.h>
> @@ -939,8 +940,8 @@ static int bd957x_probe(struct platform_device *pdev)
>         }
>
>         ic_data->regmap = regmap;
> -       vout_mode = of_property_read_bool(pdev->dev.parent->of_node,
> -                                        "rohm,vout1-en-low");
> +       vout_mode = device_property_read_bool(pdev->dev.parent,
> +                                             "rohm,vout1-en-low");

They all using parent device and you may make code neater by adding

  struct device *parent = pdev->dev.parent;

at the definition block of the probe function.

>         if (vout_mode) {
>                 struct gpio_desc *en;
>
> @@ -948,10 +949,10 @@ static int bd957x_probe(struct platform_device *pdev)
>
>                 /* VOUT1 enable state judged by VOUT1_EN pin */
>                 /* See if we have GPIO defined */
> -               en = devm_gpiod_get_from_of_node(&pdev->dev,
> -                                                pdev->dev.parent->of_node,
> -                                                "rohm,vout1-en-gpios", 0,
> -                                                GPIOD_OUT_LOW, "vout1-en");
> +               en = devm_fwnode_gpiod_get(&pdev->dev,
> +                                          dev_fwnode(pdev->dev.parent),
> +                                          "rohm,vout1-en", GPIOD_OUT_LOW,
> +                                          "vout1-en");
>                 if (!IS_ERR(en)) {
>                         /* VOUT1_OPS gpio ctrl */
>                         /*
> @@ -986,8 +987,8 @@ static int bd957x_probe(struct platform_device *pdev)
>          * like DDR voltage selection.
>          */
>         platform_set_drvdata(pdev, ic_data);
> -       ddr_sel =  of_property_read_bool(pdev->dev.parent->of_node,
> -                                        "rohm,ddr-sel-low");
> +       ddr_sel = device_property_read_bool(pdev->dev.parent,
> +                                           "rohm,ddr-sel-low");
>         if (ddr_sel)
>                 ic_data->regulator_data[2].desc.fixed_uV = 1350000;
>         else
>
> --
> b4 0.10.0-dev-fc921



-- 
With Best Regards,
Andy Shevchenko
