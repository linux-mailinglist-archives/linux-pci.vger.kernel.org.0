Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9B75AD06D
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 12:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237435AbiIEKnD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 06:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237017AbiIEKnC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 06:43:02 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D751A81B;
        Mon,  5 Sep 2022 03:43:01 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id y18so5859628qtv.5;
        Mon, 05 Sep 2022 03:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=GuGrKhvALB+DYbg9DByJZaidZTqMxf1dKNyNwmUzn6Y=;
        b=hdRIxx5gYJprXyb7McPED88U6CjGFW4/o/oE2UEQDAnFQvuRdKTBrAbPBTxaUJ9avf
         ZhONilidxc49jl4KtjO3UBa42TeRciWGfG7/aHWNdgw4HkempGiN+R8+n9bi+njwfvsf
         u5vMv6wXB1Ye3Gbinm5yEMDUAfvTO2BfwcWFUoinJoVc2JXFHnCdTpKgEEuyojVrDzWD
         W+9CAhZTdkGDNzhki05EKQP0hWG3s9bgvQRV731RyOIqcTlNyTSHFHR46gnhjmW/VUhN
         vl25c1uxIRcxwJheohCT5s/0OzbaRy4WbiXoQTG++iLwB5P3a5Gf9fVcIKfh7m5uIR41
         Lt4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=GuGrKhvALB+DYbg9DByJZaidZTqMxf1dKNyNwmUzn6Y=;
        b=0KTCgkOPfJGLo8UvnDOxHYj9//dODkVaZcqXgN/FMjRu5o97E4RZEI6s/utlVpj84V
         9b/VTMPBSHpTYsGg69Gjeabjxgl1wPS5zddaa+pmsKYcgveposZ4bJWMg7oFTEBQkdHw
         Lsl1cJLYXYHvMP6YGQUyKIwpOa8P6NBwkCCti7/ImiUFcDhnXpD7I0uTLziPq9l32vCq
         7Rfp3Pr5F5Dm16Sv88O6l7n41wP0IA9qjvSxS+5yDkP13eS4PhvE9TsWkm0ieDPd0EGg
         rYU9cMNrWmcFSBELu8Z+CaIFY0bsUXv6D/TF4Py6ut3UeVc5lWujIfzJRUpJkXFarfMB
         55gQ==
X-Gm-Message-State: ACgBeo3jcEgEfADTeeI/+R9TFrRNyqY8D29yC48pZzyScqVuKqXxwpDJ
        6uUwqXz7tVwaUTV1MkZzpj3BINf7+1O8o9fxq2w=
X-Google-Smtp-Source: AA6agR5J+1DJZPHd8O1DpA1QnLoQwr6drCn2l0fANuHmNbkAQyCPYj0H4aQjgFElwOjCvL9IFnO1bhj11LsfyBavbIE=
X-Received: by 2002:a05:622a:491:b0:344:95bf:8f05 with SMTP id
 p17-20020a05622a049100b0034495bf8f05mr38933704qtx.61.1662374580142; Mon, 05
 Sep 2022 03:43:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220903-gpiod_get_from_of_node-remove-v1-0-b29adfb27a6c@gmail.com>
 <20220903-gpiod_get_from_of_node-remove-v1-8-b29adfb27a6c@gmail.com>
In-Reply-To: <20220903-gpiod_get_from_of_node-remove-v1-8-b29adfb27a6c@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 5 Sep 2022 13:42:24 +0300
Message-ID: <CAHp75Vfza3ubqwSDWnYidAjw52_zRp6sff6xhugXJNwHvRaXew@mail.gmail.com>
Subject: Re: [PATCH v1 08/11] regulator: bd71815: switch to using devm_fwnode_gpiod_get()
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

Special thanks for using dev_fwnode().
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
(Dunno if my suggestion about parent applies here)

> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> diff --git a/drivers/regulator/bd71815-regulator.c b/drivers/regulator/bd71815-regulator.c
> index acaa6607898e..c2b8b8be7824 100644
> --- a/drivers/regulator/bd71815-regulator.c
> +++ b/drivers/regulator/bd71815-regulator.c
> @@ -571,11 +571,10 @@ static int bd7181x_probe(struct platform_device *pdev)
>                 dev_err(&pdev->dev, "No parent regmap\n");
>                 return -ENODEV;
>         }
> -       ldo4_en = devm_gpiod_get_from_of_node(&pdev->dev,
> -                                             pdev->dev.parent->of_node,
> -                                                "rohm,vsel-gpios", 0,
> -                                                GPIOD_ASIS, "ldo4-en");
>
> +       ldo4_en = devm_fwnode_gpiod_get(&pdev->dev,
> +                                       dev_fwnode(pdev->dev.parent),
> +                                       "rohm,vsel", GPIOD_ASIS, "ldo4-en");
>         if (IS_ERR(ldo4_en)) {
>                 ret = PTR_ERR(ldo4_en);
>                 if (ret != -ENOENT)
>
> --
> b4 0.10.0-dev-fc921



-- 
With Best Regards,
Andy Shevchenko
