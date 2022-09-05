Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9335E5AD121
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 13:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238193AbiIELBV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 07:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238194AbiIELA4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 07:00:56 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CA052FC0;
        Mon,  5 Sep 2022 04:00:21 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id f4so6074068qkl.7;
        Mon, 05 Sep 2022 04:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ZeMo2PWVWCCE4kicxMFOEAyAOyDB4gnn7oyqH8IifhU=;
        b=CTOoiLvwwBkvtH32c6w60zEVvHcTnoXO3ACu0Ys4kWjZ2v5rcWsBDH+vdDx4TQZ9hd
         zoXITcV3yQclTjF5bSmp+qDBSGLQc9kK7p/Q6MVruLaf+yQ2ieawJUD0vtr6jFmlqqb5
         VM0HxdCbbCyt9e3B0tD+nb2kHG9B39a4RXdVZ+gBaJ13JI/Bhg4cILs9FZoegyTQ+F+6
         8fPJkAuVnPubU2LSPwAtno5IP1SguIVrVU1uTopFif2u8b6jICrnPWEduG2jMRNf+dw3
         TOSVD6xw70ivt4BkffpLzGj1KiFTvRTD6M32zkdDHIex4lTV6wIEhedGMFPH+v+dK0yQ
         6+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ZeMo2PWVWCCE4kicxMFOEAyAOyDB4gnn7oyqH8IifhU=;
        b=ID92ImmyxY0COELUroDibC5SKWV7+XouiP+dUQ8KZU4XR4iRRmZ5L2mFhBHOrYTBev
         c+/S8AHasfjjynWxAH+6quE6nKUVk+RMhNcBOKEZ7/hlr9xpzXoNz3wdrpsnIyWKsZ3H
         aMnDtjcNlYFSKyk1IIAVOn7reJVoaK2qfRHozwoWs5r+lww3Eq9AeLasXd9cphc9A/AB
         vkfDE9MWlrHfC12CThsgnnMtgwR6PqoYSmhkRPaZ7h9/jVHw84ccBlgmlh3SsVezrJJq
         fqqNNNRStmWa49v/MUZmfPeuPakS2QrO0D+38W35gguIZPhK6yqvRtd1Z3GVQEhPNuuA
         MX1w==
X-Gm-Message-State: ACgBeo0wQw6Q+I300V/d4+Y5eAH1s6TPLkKdnwspDkpJk/vrBt1JznS+
        yutQ5fd/PS2bULzANnZM+DrmEZBWPqXipJpkAcU=
X-Google-Smtp-Source: AA6agR5QfYlB3faOXg1Xo9fT2kr66lBEoMt1tUwQEmf4Hjj69mFUh3WyFYB6EU5cllnnLi+qXnfCb/Dp4e9d3zghof0=
X-Received: by 2002:a05:620a:288a:b0:6b8:fcfe:db02 with SMTP id
 j10-20020a05620a288a00b006b8fcfedb02mr32736370qkp.504.1662375620030; Mon, 05
 Sep 2022 04:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220903-gpiod_get_from_of_node-remove-v1-0-b29adfb27a6c@gmail.com>
 <20220903-gpiod_get_from_of_node-remove-v1-4-b29adfb27a6c@gmail.com>
In-Reply-To: <20220903-gpiod_get_from_of_node-remove-v1-4-b29adfb27a6c@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 5 Sep 2022 13:59:44 +0300
Message-ID: <CAHp75VdMr7wru-2hD1HH3OS5JTNdzt6VRqB6OFoCp2JkiuiTjw@mail.gmail.com>
Subject: Re: [PATCH v1 04/11] usb: phy: tegra: switch to using devm_gpiod_get()
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

On Mon, Sep 5, 2022 at 9:32 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> I would like to stop exporting OF-specific devm_gpiod_get_from_of_node()
> so that gpiolib can be cleaned a bit, so let's switch to the generic
> device property API.
>
> I believe that the only reason the driver, instead of the standard
> devm_gpiod_get(), used devm_gpiod_get_from_of_node() is because it
> wanted to set up a pretty consumer name for the GPIO, and we now have
> a special API for that.

...

> -               gpiod = devm_gpiod_get_from_of_node(&pdev->dev, np,
> -                                                   "nvidia,phy-reset-gpio",
> -                                                   0, GPIOD_OUT_HIGH,
> -                                                   "ulpi_phy_reset_b");
> +               gpiod = devm_gpiod_get(&pdev->dev, "nvidia,phy-reset",
> +                                      GPIOD_OUT_HIGH);
>                 err = PTR_ERR_OR_ZERO(gpiod);

What does _OR_ZERO mean now?

>                 if (err) {
>                         dev_err(&pdev->dev,
>                                 "Request failed for reset GPIO: %d\n", err);
>                         return err;
>                 }



-- 
With Best Regards,
Andy Shevchenko
