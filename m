Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA435AD9BE
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 21:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbiIEThj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 15:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiIEThi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 15:37:38 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64699501B6;
        Mon,  5 Sep 2022 12:37:38 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id mj6so9182808pjb.1;
        Mon, 05 Sep 2022 12:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=UX/1xWsBuUZKNpnGbmaCNyLgDKXUyHyjW7LSvfviiGM=;
        b=Jq6z0TjBOs+Trb+l/l0E6v2zXWY5HGZUjeUfFoj6h1dgSSPD3CMOMJzKW/FgRblSih
         9XKG/JuD76vNnuQGH4IReEwETm+svg5j/jghxR4WWjXAxOGp9pztBXjFtpMn9fKYvJDF
         mXDcmytCgAWXvi4BSG5pj9Y0FI8rlxUZq6PAQAUnNGkrMF0VrQAsHOOkpAHrZbr3nOJS
         i68fopwEQC0oJscyLwdmpyB8JB1DvXhZEhs94bZIP7npUYVRKyMbaEZFnY/EWTOyJFcw
         6eno1/ywfeqqOcLh7eCoxWyTJI1hItySN2zX1dRx/cdYZr0XNXm5Jc2yy3MvF+522GeF
         f4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=UX/1xWsBuUZKNpnGbmaCNyLgDKXUyHyjW7LSvfviiGM=;
        b=51rjBqNdzYfljuefi+NTR5VYmhd5/2hwdQZG4bx0jWBG9PHNg71wmR3BGysNHkpPE3
         y3/I3m2Hc6DaT62Ieakfnnn9VIQQLz3PMJFD7qa1fnkQnj4AcySqyItcawA1k9K0NwYi
         8FMJ160IJ1AjPYIBzIRyTS+S/gKOMaP+vXaJ4oRsUZDLHw6H7t6FTR9qFFWlcR892sSJ
         O3YXiAzAXZaL3t2AT+Wvcuw0FZHW/sKg/TqyUkMmmPgxS3MeL9+kjZxTrIE8/jtDctUw
         GsALYIsU7bNMrv8Uq4D3w2CJU7fOUv5cQeWMDFsFXYqqyvkUZaXPFWA2SKUeEdvlNY4N
         uucA==
X-Gm-Message-State: ACgBeo0WeFusS8+usdwj2PrAvb09DLWlfzsu3hvZupVCdko6O2ZcrRrx
        zDEh5MHGkCktjor5OwA/tRQ=
X-Google-Smtp-Source: AA6agR70u6IDqbN3XobJcWbGlwEoBHj5+DIO4sKvf09Hb5lknd4pdCEXQAQd60uZG48UmUAgfPRBLA==
X-Received: by 2002:a17:902:edd5:b0:174:a6e6:51f4 with SMTP id q21-20020a170902edd500b00174a6e651f4mr40804784plk.82.1662406657709;
        Mon, 05 Sep 2022 12:37:37 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:7332:f188:2984:5930])
        by smtp.gmail.com with ESMTPSA id u1-20020a170902e5c100b00176b5035045sm2216157plf.202.2022.09.05.12.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 12:37:37 -0700 (PDT)
Date:   Mon, 5 Sep 2022 12:37:33 -0700
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
Subject: Re: [PATCH v1 02/11] drm/tegra: switch to using devm_fwnode_gpiod_get
Message-ID: <YxZP/exeVD7DQ5Hx@google.com>
References: <20220903-gpiod_get_from_of_node-remove-v1-0-b29adfb27a6c@gmail.com>
 <20220903-gpiod_get_from_of_node-remove-v1-2-b29adfb27a6c@gmail.com>
 <CAHp75Vc4yfh0JcY0B-vNawHTay5QNuhd7GAm86QZZZvUnQaMzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vc4yfh0JcY0B-vNawHTay5QNuhd7GAm86QZZZvUnQaMzQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 05, 2022 at 01:57:01PM +0300, Andy Shevchenko wrote:
> On Mon, Sep 5, 2022 at 9:32 AM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > I would like to limit (or maybe even remove) use of
> > [devm_]gpiod_get_from_of_node in drivers so that gpiolib can be cleaned
> > a bit, so let's switch to the generic device property API.
> 
> > It may even
> > help with handling secondary fwnodes when gpiolib is taught to handle
> > gpios described by swnodes.
> 
> I would remove this sentence from all commit messages since it's a
> debatable thing and might even not happen, so the above is a pure
> speculation.

I have the patches. Granted, I had them since '19 ;) but I'm rebasing
them and going to push them. I need them to convert bunch of input
drivers away from platform data.

Thanks.

-- 
Dmitry
