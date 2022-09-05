Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DABE25AD9E9
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 21:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiIETvr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 15:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiIETvq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 15:51:46 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBD9102A;
        Mon,  5 Sep 2022 12:51:44 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id o4so9175743pjp.4;
        Mon, 05 Sep 2022 12:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=y3Qjjf92TYynwevE3H2ZfJzfWM4V6u0gYdLfjE+80ak=;
        b=p8fQjE0a0ZYjZfKRTjHpT3euYQsGr97PlI4J+3Etag+6i4rW86Bv40nzZOUk7I+O74
         6AB3V55fbqVv7uRxcLJ9p+i6cEGfvUhY3Kul9eRBDmP4APZA6HSJroq5lt4nanlf+S4D
         WzL8qbprYpzsZPbHTw91TVqhBBtGkTVEuU+NWJvf9meD6jRYOhrvpxBh2bEHlWS2vOzN
         /mMdK+1vtePGkD0+o2tcKMw1L7TbtR/LY2u3VdsMAB8lgT9qdQtRVvzA9MzGS4jTHM2e
         Y8DXi1ZE+gjUnF3/4YvRqKEtHb92EDRaHq/IKZmP1TBDcFx5o+n/mIkQoIp34EalsnaQ
         zoGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=y3Qjjf92TYynwevE3H2ZfJzfWM4V6u0gYdLfjE+80ak=;
        b=65jBx1SPF8ACMmQQMnnL1NYV4PW0trSkojJeIJcn2ybZ2YqAmYtOeSjqlUZ6HVOkG0
         UdLTc5EWYIigTiAvlG8+QPqKrSklmDW1GJ+h3mYTkxlLSWvKqtQ+L+PF6A71Zoneu8Hf
         VNUA+4bLYfFczaH6FQF/wI/Ozp6HSAMNKZwDtzqGRko6Rvq19umG0NOgLjRMw2jQcYez
         eyHQDvl6YqgQORUiAbRX9QYKHbdSR7VpviOObmZrY/VvaspNczM7pmpCDSgdN1NWVJqE
         o4Ftltve40Jwgoy3uxDPV9qkAcs4g+bc1TULDCXoP/NYVGqIqb9EOrkeQErCM9FgvK4c
         GXzA==
X-Gm-Message-State: ACgBeo1asBlZBe8ebSID/OV4QWG3fm7cXOfxvyZxhBQKaR8efjhKF81D
        AIjbT4nBTuvnLzwLq1lcXNkUKsFFn/Q=
X-Google-Smtp-Source: AA6agR6jLyMlXDr8IPeAvG3W5MKsqN0u+BmkWQrSPGBis9zvMHZVJmB1Wm8c2BJ+cKCgBoks41PKTg==
X-Received: by 2002:a17:902:f68d:b0:16f:2314:7484 with SMTP id l13-20020a170902f68d00b0016f23147484mr49230641plg.136.1662407504235;
        Mon, 05 Sep 2022 12:51:44 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:7332:f188:2984:5930])
        by smtp.gmail.com with ESMTPSA id g5-20020a17090adac500b001fd8316db51sm7191722pjx.7.2022.09.05.12.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 12:51:43 -0700 (PDT)
Date:   Mon, 5 Sep 2022 12:51:39 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
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
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
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
Subject: Re: [PATCH v1 04/11] usb: phy: tegra: switch to using
 devm_gpiod_get()
Message-ID: <YxZTS3Nl1YaMGoBC@google.com>
References: <20220903-gpiod_get_from_of_node-remove-v1-0-b29adfb27a6c@gmail.com>
 <20220903-gpiod_get_from_of_node-remove-v1-4-b29adfb27a6c@gmail.com>
 <CAHp75VdMr7wru-2hD1HH3OS5JTNdzt6VRqB6OFoCp2JkiuiTjw@mail.gmail.com>
 <YxZQj8bwJCx5rqDv@google.com>
 <CAHp75VdHJS4YgrTK15OuY5sxodxKObUtzturL+YPXFQ3_wpxig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdHJS4YgrTK15OuY5sxodxKObUtzturL+YPXFQ3_wpxig@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 05, 2022 at 10:41:40PM +0300, Andy Shevchenko wrote:
> On Mon, Sep 5, 2022 at 10:40 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Mon, Sep 05, 2022 at 01:59:44PM +0300, Andy Shevchenko wrote:
> > > On Mon, Sep 5, 2022 at 9:32 AM Dmitry Torokhov
> > > <dmitry.torokhov@gmail.com> wrote:
> 
> ...
> 
> > > > -               gpiod = devm_gpiod_get_from_of_node(&pdev->dev, np,
> > > > -                                                   "nvidia,phy-reset-gpio",
> > > > -                                                   0, GPIOD_OUT_HIGH,
> > > > -                                                   "ulpi_phy_reset_b");
> > > > +               gpiod = devm_gpiod_get(&pdev->dev, "nvidia,phy-reset",
> > > > +                                      GPIOD_OUT_HIGH);
> > > >                 err = PTR_ERR_OR_ZERO(gpiod);
> > >
> > > What does _OR_ZERO mean now?
> >
> > This converts a pointer to an error code if a pointer represents
> > ERR_PTR() encoded error, or 0 to indicate success.
> 
> Yes, I know that. My point is, how is it useful now (or even before)?
> I mean that devm_gpio_get() never returns NULL, right?

What does returning NULL have to do with anything. It converts a pointer
to a "classic" return code, with negative errors and 0 on success.

It allows to not use multiple IS_ERR/PTR_ERR in the code (I'd need 1
IS_ERR and 2 PTR_ERR, one in dev_err() and another to return).

Thanks.

-- 
Dmitry
