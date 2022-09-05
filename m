Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC8E5AD0A5
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 12:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237645AbiIEKsY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 06:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237610AbiIEKsT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 06:48:19 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380424C63C;
        Mon,  5 Sep 2022 03:48:18 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id cb8so5912944qtb.0;
        Mon, 05 Sep 2022 03:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=ocC0mA23fnRz/a4YbrfNwFrDwQYg+GSA5oW5v/yTckg=;
        b=KeR2rGIjPnYKiKG2aILzh6gWMDTnViE8fXPWXXXixLovTbpx00/oSEAU+Q4L2OCzAK
         GRraxIbhCS4mi4IuRHOlRDlrrUGLqMd7GLM+J1Hc2/d7WSNIQDHGywQYnYEyBYPDgjiz
         uY13i1u0RDIQGheVM8QVFqtoKIkC9biCE4wbzSZrKtBJ1m2pvxKw60ny4f6bBZ/B8u0u
         Zr23UPD2YvAu/KuN+tEjHJX9M8xugOLPnNs4g2YR3PzTM6X60zVPevAOqAjIm6WKdYct
         vHLBCofCn+v7V2zJuE2kdbx3Wmz7GLi7XsxEmH7dNee6uir7hoWh+8c0e9HZN2r8BTuM
         JH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ocC0mA23fnRz/a4YbrfNwFrDwQYg+GSA5oW5v/yTckg=;
        b=YvFX5RbjHPTBGm8Zh/+eZsYQzqZbr8OFmbjZvFPwMg64o6gKe5a7kLYKWU6rgB7YBD
         eyFjVDyli9GUkr/wp1T9T9+fogQ/ADCJwnOIO26VNOVywMbln7Q26KNqHyYBw0G7Xx7B
         XucJ5npZiUv6ondFcyoxhEb1X6cPEIL4Zw33M6fHkqZ+Veek1dBvctWMfdy0TNFIdLdX
         /1bvwoQQdZPIy5x3qa4dWzVZTGmYSCZYwkVtbQiiQz/uAa4FPqszHY8MY6rwnb7ZNij1
         aSe7T7W/dED94rv0AdYOoKFYVhprP15mY34GJ6IvHcLN7Ez+q80TzSK3Fvq8/Zs39XDM
         hT3A==
X-Gm-Message-State: ACgBeo3c6rMIfD3/rgmFdG9ulu+1F+ViIiQpx1ebr4guykm/2P3O+Rb6
        QXBfUQ8jkCYeNaI/Xqy31/nF1S3PsYjfjzfUIw4=
X-Google-Smtp-Source: AA6agR6PNo2Qc8lpj2itrEExN36xqc7ZpSaZEm3ZnHtwljImH3P9PTPtYv87hNYI8E9dEPcysm+pNwOsTzObwqbdpdc=
X-Received: by 2002:ac8:5786:0:b0:343:3051:170d with SMTP id
 v6-20020ac85786000000b003433051170dmr38497148qta.429.1662374897323; Mon, 05
 Sep 2022 03:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220903-gpiod_get_from_of_node-remove-v1-0-b29adfb27a6c@gmail.com>
 <20220903-gpiod_get_from_of_node-remove-v1-6-b29adfb27a6c@gmail.com> <20220905070046.46nlhczkck2ufr4x@pali>
In-Reply-To: <20220905070046.46nlhczkck2ufr4x@pali>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 5 Sep 2022 13:47:41 +0300
Message-ID: <CAHp75VcFv7ipLqXmOwbXpY-_ccYNA9PgF0h4T8RY1Z-UNNpaTg@mail.gmail.com>
Subject: Re: [PATCH v1 06/11] PCI: aardvark: switch to using devm_gpiod_get_optional()
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 5, 2022 at 10:02 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
> On Sunday 04 September 2022 23:30:58 Dmitry Torokhov wrote:
> > I would like to stop exporting OF-specific devm_gpiod_get_from_of_node(=
)
> > so that gpiolib can be cleaned a bit, so let's switch to the generic
> > device property API.
> >
> > I believe that the only reason the driver, instead of the standard
> > devm_gpiod_get_optional(), used devm_gpiod_get_from_of_node() is
> > because it wanted to set up a pretty consumer name for the GPIO,
>
> IIRC consumer name is not used at all.

It's. The user space tools use it as a label. So, GPIO line can have
"name" (this is provider specific) and "label" (which is consumer
specific, i.o.w. how we use this line).

...

> > +             if (ret !=3D -EPROBE_DEFER)
> > +                     dev_err(dev, "Failed to get reset-gpio: %i\n",
> > +                             ret);
> > +             return ret;

I understand that in the input subsystem maintainer's hat you don't
like dev_err_probe(), but it's a good case to have it here.

...

> > +     ret =3D gpiod_set_consumer_name(pcie->reset_gpio, "pcie1-reset");
> > +     if (ret) {
> > +             dev_err(dev, "Failed to set reset gpio name: %d\n", ret);
> > +             return ret;
> >       }

Ditto.


--=20
With Best Regards,
Andy Shevchenko
