Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755B45AD9F9
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 21:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbiIET4L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 15:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbiIET4K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 15:56:10 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D240C5C9E4;
        Mon,  5 Sep 2022 12:56:07 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id u189so39493vsb.4;
        Mon, 05 Sep 2022 12:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=TxtKuUqRxkHzFdFIsdOfwVRYln8Ru/gjD+KQXu9iPWk=;
        b=oOTNddka/G5MmOs10MprjSwOych3GIj7p+oXSDb0g7K+MumOQ7dZI9fvJZbh5v/ZDF
         DkO1HuuP77CxrZ+nX3N/Lzhn/vUJoUctJFw7B5StarCr4bF9V9vn6OWirRi6MzdQqj30
         RSw/5Gc1rkcPkllIbByQHmgIVNflrb//j8OILQCPlm+kfxjDVj7A+Lyb1H1czT3F4/xi
         bz15Ht8yFZoqUyi30wGVEJqKiyzB6caNlhd6ZUpR1ANYxl8eNvELSRuii9PJ3S+s4ley
         Rp+HaIIqJfxdvV1TQotcVRJ+vu/DyoG1JpVG2rEiNSh0BPI5uNW/2ybVsLc3YOQ/Kl+P
         cZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=TxtKuUqRxkHzFdFIsdOfwVRYln8Ru/gjD+KQXu9iPWk=;
        b=WCNvLWtUi9w+FeNCZsflRjF0ID4ugtaZ1mWZ96XyT+k5DHV9Hzxmk66CzHhReHP2xQ
         gslr33mwb7MnynctUuRUVY/jIMPLXnp93aWP5tTFcZb8OHtFoFbykjmaugXEN2xsWeyy
         ZU/TD1wLGg1a9h1BIGDWIBZhBT5CLt4dhiuT3/LBIYM+a/9f1LQcBPB1SSidHhyB7gGd
         pOFpzHYLve6Ytr1/ezGFJ83KdKu0QaEPT4lJFxUBsQPKxGJbkfnysEiYxzyryBzy3hIM
         BQEvVqIlDIgwMLi+vyGnbcM5vKDFUra+ni0bSC3iaYNGyNtALLHIyDynNqerXiLdd72U
         Sj/w==
X-Gm-Message-State: ACgBeo2+3fYXbaK1o8VmPejQWJZuEquxkNw60FOJRn2x0oCmU4yMt6vv
        PyTMiF1bcNjwSyUPCSQPnLSnxTverdHKRhcUQT4=
X-Google-Smtp-Source: AA6agR40buubTfPsstG80DF+s22ldT4F+qiWGt4P8UBWfLfejzg6ynm6XI4ScnPvxtGB0Oeq1Upf5TBcnrM6rSa5o+Y=
X-Received: by 2002:a67:e058:0:b0:390:e62d:8976 with SMTP id
 n24-20020a67e058000000b00390e62d8976mr11716363vsl.31.1662407766752; Mon, 05
 Sep 2022 12:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220903-gpiod_get_from_of_node-remove-v1-0-b29adfb27a6c@gmail.com>
 <20220903-gpiod_get_from_of_node-remove-v1-4-b29adfb27a6c@gmail.com>
 <CAHp75VdMr7wru-2hD1HH3OS5JTNdzt6VRqB6OFoCp2JkiuiTjw@mail.gmail.com>
 <YxZQj8bwJCx5rqDv@google.com> <CAHp75VdHJS4YgrTK15OuY5sxodxKObUtzturL+YPXFQ3_wpxig@mail.gmail.com>
 <YxZTS3Nl1YaMGoBC@google.com>
In-Reply-To: <YxZTS3Nl1YaMGoBC@google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 5 Sep 2022 22:55:30 +0300
Message-ID: <CAHp75VeNajcf-Y6xvDDVwZijg6U53ggg1HQox1AZ74=wRut+1Q@mail.gmail.com>
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

On Mon, Sep 5, 2022 at 10:51 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Mon, Sep 05, 2022 at 10:41:40PM +0300, Andy Shevchenko wrote:
> > On Mon, Sep 5, 2022 at 10:40 PM Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> > > On Mon, Sep 05, 2022 at 01:59:44PM +0300, Andy Shevchenko wrote:
> > > > On Mon, Sep 5, 2022 at 9:32 AM Dmitry Torokhov
> > > > <dmitry.torokhov@gmail.com> wrote:

...

> > > > > -               gpiod = devm_gpiod_get_from_of_node(&pdev->dev, np,
> > > > > -                                                   "nvidia,phy-reset-gpio",
> > > > > -                                                   0, GPIOD_OUT_HIGH,
> > > > > -                                                   "ulpi_phy_reset_b");
> > > > > +               gpiod = devm_gpiod_get(&pdev->dev, "nvidia,phy-reset",
> > > > > +                                      GPIOD_OUT_HIGH);
> > > > >                 err = PTR_ERR_OR_ZERO(gpiod);
> > > >
> > > > What does _OR_ZERO mean now?
> > >
> > > This converts a pointer to an error code if a pointer represents
> > > ERR_PTR() encoded error, or 0 to indicate success.
> >
> > Yes, I know that. My point is, how is it useful now (or even before)?
> > I mean that devm_gpio_get() never returns NULL, right?
>
> What does returning NULL have to do with anything.

It has to do with a dead code. If defm_gpiod_get() does not return
NULL, then why do we even bother to check?

> It converts a pointer
> to a "classic" return code, with negative errors and 0 on success.
>
> It allows to not use multiple IS_ERR/PTR_ERR in the code (I'd need 1
> IS_ERR and 2 PTR_ERR, one in dev_err() and another to return).

I don't see how this is relevant.

-- 
With Best Regards,
Andy Shevchenko
