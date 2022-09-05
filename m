Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05D35AD3C7
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 15:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236776AbiIENXs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 09:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237774AbiIENXn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 09:23:43 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0C043E6C;
        Mon,  5 Sep 2022 06:23:42 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id a10so6256336qkl.13;
        Mon, 05 Sep 2022 06:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=xqnaWRmSxWCHIXi5Qlq2gni2AdAVZeps2ahh12VkulY=;
        b=nOletpYDW/GRPvkaWSlAC0rzt34URfVHbiUKwVMsxFl09VUwy8XOqhWqRsptamq/Dg
         II+253/l3T6DgJP066py1bWTdICT2vRCXvzy2Ur+pO4VC493+7Sqn84yvDmlJFGAVdYl
         5PZSVDMi1QDxBMQa2pV/FSXYTAwvX/lFVcFPmgHoO3U8MnbkwA9h7jonAO1nFwBsGmoW
         q5f2ZglIOVt/xEgJLA6EBKdc3gOuFnoMDDVILIKTeoTg7qTOPypEYwVwaO1cq1N6YfbI
         me+dt6lOnpM5B3FzI09ooPbgjOvgXIow30OcLwUv/NaL/eE7AkZh0zMQ2HIMHBfa4q7S
         WwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=xqnaWRmSxWCHIXi5Qlq2gni2AdAVZeps2ahh12VkulY=;
        b=jqQdg8BxLosraqQCfd9lNYRj44R8VGOYDLtQkmJNyGTN8C81d2BO20UqvTzU0j0DYw
         BAvksOa1oZjPRPIRA0sMTE3lnFJn4W76aeFW0sjQjGBpVNc6kENdK8cQwt0XTjjXhOcg
         8n5iw7mkFHa9+CWmh36xGFjnXZqL94zHzcOYOd8XnyZaQmk99bZkXe0Rrn6+kZjTZBvC
         fDKp18Cr9zomFfwHfuXOsIximcIF9ivWpfT32vyyn8JMzrIpZ4e5l/+mm8xnA989rTJV
         sPjGWdI1ACS4MLN9SUCQcVdVvz26obXpPILihd3g2tiVFTWHYyV9AwQDdQAduLvS7CB/
         vNwg==
X-Gm-Message-State: ACgBeo07YvOXT2oBdHAvPvRlA1VRBDOTiB4LAt5/lj3sVstnukwhjeaq
        4yEwJtBNPotuAkXmBQlNv4STLWjSTV98ZECDKn4=
X-Google-Smtp-Source: AA6agR5sttgUX/02ygd4oRH8E7CwuO10nDnWttnl6PSpdnCic7gOwb1KDafibQkxIBgdBbgVXC2AwvPX08spe4Hyycw=
X-Received: by 2002:a05:620a:288a:b0:6b8:fcfe:db02 with SMTP id
 j10-20020a05620a288a00b006b8fcfedb02mr33223900qkp.504.1662384221554; Mon, 05
 Sep 2022 06:23:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220903-gpiod_get_from_of_node-remove-v1-0-b29adfb27a6c@gmail.com>
 <20220903-gpiod_get_from_of_node-remove-v1-9-b29adfb27a6c@gmail.com>
 <CAHp75VeA+oVPmsEOg+y0cvRcTU5qA+Y+9=Byp0C982EB7SAArQ@mail.gmail.com> <0fa0c09f-c801-a0c7-1f6e-b6cc8b45d961@gmail.com>
In-Reply-To: <0fa0c09f-c801-a0c7-1f6e-b6cc8b45d961@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 5 Sep 2022 16:23:05 +0300
Message-ID: <CAHp75Vek1WOyEdkfCgrcH2FL6GA5gTtxXaV5Qy9aJMCQ3qGxyg@mail.gmail.com>
Subject: Re: [PATCH v1 09/11] regulator: bd9576: switch to using devm_fwnode_gpiod_get()
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
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

On Mon, Sep 5, 2022 at 4:19 PM Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> On 9/5/22 13:40, Andy Shevchenko wrote:
> > On Mon, Sep 5, 2022 at 9:33 AM Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:

...

> >> +       vout_mode = device_property_read_bool(pdev->dev.parent,
> >> +                                             "rohm,vout1-en-low");
> >
> > They all using parent device and you may make code neater by adding
> >
> >    struct device *parent = pdev->dev.parent;
>
> This is a matter of personal preference. I prefer seeing
> pdev->dev.parent - as it is more obvious (to me) what the 'pdev' is than
> what 'parent' would be.
>
> I'd use the local variable only when it shortens at least one of the
> lines so that we avoid splitting it. After that being said - I'm not
> going to argue over this change either if one who is improving the
> driver wants to use the "helper" variable here.

And I believe the quoted one is exactly the case of what you are saying above.

-- 
With Best Regards,
Andy Shevchenko
