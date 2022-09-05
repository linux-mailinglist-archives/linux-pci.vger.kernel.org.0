Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6195AD9C5
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 21:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiIETkH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 15:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbiIETkF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 15:40:05 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F2B286FF;
        Mon,  5 Sep 2022 12:40:04 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 78so8741810pgb.13;
        Mon, 05 Sep 2022 12:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=CBRkTEdupwBv7lUysuAAHCWeUeGOXoPs3goZlUKIChI=;
        b=AoB/BB+wDCEOf3ollKTlkOpFH5ZdJcaYtYObH7F+USml96PL05nQZdIxn7ekRew/5b
         7EIcLBlc3MsHwZ5Sf25zmIO3Px5fO4gvhdDaBRhf9uOzwFLARLpmd1bM870f8lIBNHD3
         gytJZ2ifVtaupmJ3QTM9/NdK15W4dYwrMCBg6SW65U1OqgtNyXc84pbod89bIQ6BXjDU
         8DjK9Glh1ftaKc4OO8CDr320e11XRL2oTkt0sdDZYfOg6PUIpHo4y/CMFZXvXzFkVUsb
         WSwJf6gJvfOXaQ8gaip6aWRNOqu2Fi4hdJAIEf0y3X+J6pOHAoM+5/JGDwZcC7JNH7er
         c8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=CBRkTEdupwBv7lUysuAAHCWeUeGOXoPs3goZlUKIChI=;
        b=Pd1C8yk8nAtmUD5aDewV6uFkU9X7LFIDK9FEVBqbRLq6Bymdkwk6J9B56uy85QorVj
         NitnN2JRYc9FSlJyQVDjs737QWb3eKNB545Ooo5GicdY4/YbnbE2ordnYz5ywDuiNw1+
         XMo6NFw6hUIq3h3sWfeIXXvK0MjRUgE/Wc4gbyubMFmtrjIQxaYxsVzktfT5R54lsLE7
         YK+VZy89lq1RV5n6ku6s1+NB/9iyuSmYF49BuUlALqnMFY+m1EW4RWjEzIOZGZ3qlg5q
         4CrCppbJsrfQLgEKRhm7uNn84+NJfEdyaOMuRJPHwwiIagCCjmAcdkdUV9it48VRlEoT
         eAWg==
X-Gm-Message-State: ACgBeo39K1nVDiFwBj9ub+IelnML3OQhkva8SrppZdAaSAWkH9ajHdnx
        WmKEEu3QlY3qB3Z0E+qyb6BhAVhKZbE=
X-Google-Smtp-Source: AA6agR57aEnMQb2MM+YsWuK1Qvz4a+9OpUI4vj1PStOfsBOdRv0ywrZ084st51jWLHlWq8m5GTSO4g==
X-Received: by 2002:a65:6255:0:b0:42c:87b1:485b with SMTP id q21-20020a656255000000b0042c87b1485bmr29214848pgv.491.1662406803892;
        Mon, 05 Sep 2022 12:40:03 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:7332:f188:2984:5930])
        by smtp.gmail.com with ESMTPSA id p14-20020a170902780e00b00176b4f9d871sm2199498pll.70.2022.09.05.12.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 12:40:03 -0700 (PDT)
Date:   Mon, 5 Sep 2022 12:39:59 -0700
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
Message-ID: <YxZQj8bwJCx5rqDv@google.com>
References: <20220903-gpiod_get_from_of_node-remove-v1-0-b29adfb27a6c@gmail.com>
 <20220903-gpiod_get_from_of_node-remove-v1-4-b29adfb27a6c@gmail.com>
 <CAHp75VdMr7wru-2hD1HH3OS5JTNdzt6VRqB6OFoCp2JkiuiTjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdMr7wru-2hD1HH3OS5JTNdzt6VRqB6OFoCp2JkiuiTjw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 05, 2022 at 01:59:44PM +0300, Andy Shevchenko wrote:
> On Mon, Sep 5, 2022 at 9:32 AM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > I would like to stop exporting OF-specific devm_gpiod_get_from_of_node()
> > so that gpiolib can be cleaned a bit, so let's switch to the generic
> > device property API.
> >
> > I believe that the only reason the driver, instead of the standard
> > devm_gpiod_get(), used devm_gpiod_get_from_of_node() is because it
> > wanted to set up a pretty consumer name for the GPIO, and we now have
> > a special API for that.
> 
> ...
> 
> > -               gpiod = devm_gpiod_get_from_of_node(&pdev->dev, np,
> > -                                                   "nvidia,phy-reset-gpio",
> > -                                                   0, GPIOD_OUT_HIGH,
> > -                                                   "ulpi_phy_reset_b");
> > +               gpiod = devm_gpiod_get(&pdev->dev, "nvidia,phy-reset",
> > +                                      GPIOD_OUT_HIGH);
> >                 err = PTR_ERR_OR_ZERO(gpiod);
> 
> What does _OR_ZERO mean now?

This converts a pointer to an error code if a pointer represents
ERR_PTR() encoded error, or 0 to indicate success.

static inline int __must_check PTR_ERR_OR_ZERO(__force const void *ptr)
{
	if (IS_ERR(ptr))
		return PTR_ERR(ptr);
	else
		return 0;
}

Thanks.

-- 
Dmitry
