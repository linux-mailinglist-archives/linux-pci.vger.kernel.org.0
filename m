Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0305AD9D3
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 21:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbiIETm7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 15:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbiIETm6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 15:42:58 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28B25142A;
        Mon,  5 Sep 2022 12:42:56 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id 67so9684880vsv.2;
        Mon, 05 Sep 2022 12:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=wO/CS8iR8KxuQ0QSMzm6/WiY5ujYMWA4u/2Kf3nOOU4=;
        b=JSci26HogKWKQ4bQAPYj/qj3KQoQKdAM0djoTD3V3pfJRNYBkb/crHGNg1ZxmTaRZt
         Y2OeStRuHo3E/9wsjJPHVnMww72oojhAo7UJLNnJ0gRUC+nhaCUEHH9ZmDdynKfHloX2
         0bjx9qX1YL+G8A4rsdAU0h6gp40P8lRhXVGDtlCWUMjl1D8b39ZkjvsqK3cSjapHLUZz
         EVRCqi1r10xb9iSsdWdvvlb6dzMQ8cDz9uv1Pe05ngskplsNCt6Z3TRknJQasbAHVJ+g
         GwNPbWO8101YPtZqf6x/GwXmJmCDOz+EBKotqmHSc5fKyGy5JGnKrxr8z/8BsuU8OywW
         Yx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=wO/CS8iR8KxuQ0QSMzm6/WiY5ujYMWA4u/2Kf3nOOU4=;
        b=0h+wlIvdtxqhDv95hO/P0h/erE724dlsng8G4p99avVZEeYIKM17TyGaoQoQYO8IRi
         ROR8Uwzu9NlXHl4ZHviIyWstpRWj5oruIyXZJjvHzHpW8NVKwwJNYLA/lAxxmLgqTqwd
         FcXB6+eeSGCmzFvYb9WPNaHDveyOBLHMlYzGmM8hexMLxMjmsIqZXTlYxlUv2u+ZiJ0a
         6XBetqtlExsTmIZ7LT3rtLtGr6IjuxSqPcfVeozFrSNbZQxcsXNNwEMqssYlbRg2bOYr
         jOeqC7Im7cgwLYsFX5olY+q6FHr0PBLvoyeAMN/RpUDlc4WQQ8iH0ypvQJU8SgSVG2c8
         mHxg==
X-Gm-Message-State: ACgBeo2i11kvwNAUhKkuSRQqxBPDoh0oQ6kkUCOTRu3iEmZkUHruxvyh
        TvtAOWDx6OGfvxRoyOtUfeG7fVyxkaB9imd5Zvm0cVOM8bE=
X-Google-Smtp-Source: AA6agR5H6mS5M0XhYTx5eUbgZC+0kKZN7MbCqjw2PbBKrxMbH7D52IRk52ma02TgJgjEDCJnQoQg6/wvHDVlYSC2VyU=
X-Received: by 2002:a67:c097:0:b0:390:d097:df91 with SMTP id
 x23-20020a67c097000000b00390d097df91mr12625663vsi.85.1662406976034; Mon, 05
 Sep 2022 12:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220903-gpiod_get_from_of_node-remove-v1-0-b29adfb27a6c@gmail.com>
 <20220903-gpiod_get_from_of_node-remove-v1-4-b29adfb27a6c@gmail.com>
 <CAHp75VdMr7wru-2hD1HH3OS5JTNdzt6VRqB6OFoCp2JkiuiTjw@mail.gmail.com> <YxZQj8bwJCx5rqDv@google.com>
In-Reply-To: <YxZQj8bwJCx5rqDv@google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 5 Sep 2022 22:41:40 +0300
Message-ID: <CAHp75VdHJS4YgrTK15OuY5sxodxKObUtzturL+YPXFQ3_wpxig@mail.gmail.com>
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

On Mon, Sep 5, 2022 at 10:40 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Mon, Sep 05, 2022 at 01:59:44PM +0300, Andy Shevchenko wrote:
> > On Mon, Sep 5, 2022 at 9:32 AM Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:

...

> > > -               gpiod = devm_gpiod_get_from_of_node(&pdev->dev, np,
> > > -                                                   "nvidia,phy-reset-gpio",
> > > -                                                   0, GPIOD_OUT_HIGH,
> > > -                                                   "ulpi_phy_reset_b");
> > > +               gpiod = devm_gpiod_get(&pdev->dev, "nvidia,phy-reset",
> > > +                                      GPIOD_OUT_HIGH);
> > >                 err = PTR_ERR_OR_ZERO(gpiod);
> >
> > What does _OR_ZERO mean now?
>
> This converts a pointer to an error code if a pointer represents
> ERR_PTR() encoded error, or 0 to indicate success.

Yes, I know that. My point is, how is it useful now (or even before)?
I mean that devm_gpio_get() never returns NULL, right?

-- 
With Best Regards,
Andy Shevchenko
