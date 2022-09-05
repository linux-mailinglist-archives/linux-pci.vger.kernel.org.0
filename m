Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819F65ADB23
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 00:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbiIEWIh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 18:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbiIEWIg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 18:08:36 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BAF52478;
        Mon,  5 Sep 2022 15:08:35 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id w63so517473pgb.7;
        Mon, 05 Sep 2022 15:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=5z1ooZsxXJhukGg5jtTnKIsDm0LxvDPLLdQBFIOg9Mo=;
        b=YgTpoNtQskYKJFiEm9roM8UsHLvYEBNA1mL8ijvR43dcIl3qE9TJ2QJ31Crw3ouUSM
         iI8m5cQ7oncVgCHnH06GZ7ixBdCItXBCOTQ0lnmtukCsaxmucAabTpdrPK7wJWhoEWT7
         cgfEiI7IXkgrurTPX8XkkJoSsKsg9OzznrhVAXoVVoMju1sc4m7PY17g3MSbb/mrzdVs
         e0eC6TEC3Uajc8BSqN8s3bXjyqbHUencfLf3ZSqIc6lxiBQcd3c3TAVmvjecPrYNaR0z
         fbBCLNGPTSjT+MdQuaaUYKGVdpkhWWf3pd/I4UIY2tn2zmhrhfXgmb3XRio80gdSixHJ
         PRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=5z1ooZsxXJhukGg5jtTnKIsDm0LxvDPLLdQBFIOg9Mo=;
        b=yat+9I01hLst202T647S0z2g9y0kdL8Xyp4Gg++SUhMwcWKG2uTirDTAyP8BHHYoJ3
         gbCeedtBkmz6mBCClWEX9YybLEF3zYkQUgqKrG2zsB3/+Yalvkz9k+jkhaOdLa98sOIf
         c/ygC9czFQf160u+Nnzw/558B8MgL0618I5O60atsccMKw27+T7BPyFVPcCTYdrXksVX
         tea2nrHzY6nblaP4xYSyZo/sitg0X5PLtrWDSukhuF5qYekJ7ycW8djLg+5KBYxTrBdY
         Ai+CSaCmc/ZUv9aseu/F7pAdmzwSm2CyL/cLXhBHqGqWzpp7nhT8l65R/SlUpK8U/sZJ
         r6Ag==
X-Gm-Message-State: ACgBeo2FGl3dNjwYgZt3fu5h86GhQqTWnawRZ9PbJjNsL+n5q68M0joH
        VvdXfRDLIGYuY6rBJOalPrg=
X-Google-Smtp-Source: AA6agR7YbREIA01VRSmP+zvXlY2q8iiOZpKUEqi6KFy5cemoOzMeF56ZDQMRUefeyhXXs1gJaKAhsA==
X-Received: by 2002:a63:4719:0:b0:42c:5586:de2 with SMTP id u25-20020a634719000000b0042c55860de2mr31993067pga.158.1662415714908;
        Mon, 05 Sep 2022 15:08:34 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:1190:fbfa:ae95:111c])
        by smtp.gmail.com with ESMTPSA id a12-20020a170902710c00b00172f1d0825esm8092373pll.113.2022.09.05.15.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 15:08:34 -0700 (PDT)
Date:   Mon, 5 Sep 2022 15:08:30 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
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
Subject: Re: [PATCH v1 02/11] drm/tegra: switch to using devm_fwnode_gpiod_get
Message-ID: <YxZzXqJiOPDVmACo@google.com>
References: <20220903-gpiod_get_from_of_node-remove-v1-0-b29adfb27a6c@gmail.com>
 <20220903-gpiod_get_from_of_node-remove-v1-2-b29adfb27a6c@gmail.com>
 <CAHp75Vc4yfh0JcY0B-vNawHTay5QNuhd7GAm86QZZZvUnQaMzQ@mail.gmail.com>
 <YxZP/exeVD7DQ5Hx@google.com>
 <CACRpkda0iUTV=71eQf5_FdKWLe3Bu=U+Zny9_uJJL=5xXtnrnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkda0iUTV=71eQf5_FdKWLe3Bu=U+Zny9_uJJL=5xXtnrnQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 05, 2022 at 11:03:38PM +0200, Linus Walleij wrote:
> On Mon, Sep 5, 2022 at 9:37 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Mon, Sep 05, 2022 at 01:57:01PM +0300, Andy Shevchenko wrote:
> > > On Mon, Sep 5, 2022 at 9:32 AM Dmitry Torokhov
> > > <dmitry.torokhov@gmail.com> wrote:
> > > >
> > > > I would like to limit (or maybe even remove) use of
> > > > [devm_]gpiod_get_from_of_node in drivers so that gpiolib can be cleaned
> > > > a bit, so let's switch to the generic device property API.
> > >
> > > > It may even
> > > > help with handling secondary fwnodes when gpiolib is taught to handle
> > > > gpios described by swnodes.
> > >
> > > I would remove this sentence from all commit messages since it's a
> > > debatable thing and might even not happen, so the above is a pure
> > > speculation.
> >
> > I have the patches. Granted, I had them since '19 ;) but I'm rebasing
> > them and going to push them. I need them to convert bunch of input
> > drivers away from platform data.
> 
> That's good news!
> 
> Are you referring to this patch set mentioned in a discussion
> from 2017 thru 2020?
> https://lore.kernel.org/linux-input/20200826161222.GA1665100@dtor-ws/
> 
> I put aside GPIO descriptor conversion for input devices (keys, buttons)
> in board files anticipating a swnode mechanism.

Yep, that one, exactly. It is taking a bit longer than I anticipated ;)

Thanks.

-- 
Dmitry
