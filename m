Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82655AD094
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 12:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237448AbiIEKuC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 06:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236609AbiIEKuA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 06:50:00 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B926D29C9F;
        Mon,  5 Sep 2022 03:49:58 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id g4so3682298qvo.5;
        Mon, 05 Sep 2022 03:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=c2nRQWb+fQUQq5AQnrIySgvmnHVhBaOL/o7B8oGby/I=;
        b=bJcqTGACtFXLmXsUFqpw+PFDufx4FlXQ9j/RFhHUQVHKZqoTndY/JkV19g6BLOeeUo
         4hwSoSeec32Tbw+OMHEGG0r6M3e1GMJ/NJcg/FZwHW1SClzced4lWIu+/ZShrdu3JDTD
         V762GqyZZIhqeYexr860HlDH8BBXqi/Xiv+2j3KgGGGsMmOP08meZgz/a8ltQBauY42v
         3tIliUsfRb5Lb2wvCwZlmuODmHlyxQTZ+r40eHwZ7AsK+hrNiFx9jEpz+HZY8XcSMnnB
         5QEIV3Pay913kDLF3Na3+KE+sGrpwp4YFq2VvbdqUoXS9I37A0JHt+Mwwdcik+o8Vvzp
         uBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=c2nRQWb+fQUQq5AQnrIySgvmnHVhBaOL/o7B8oGby/I=;
        b=rsZtkOuls+CtRdDM2lsXT/JDBraVTCPpRpDQwdd/grk40urKoLmJoUGkhP1gZrX3QX
         wFcFL7K+8n+VyPkoqOIMmgl3KWb79AmYFvBjrqmRIlyo1Uq6uidEOObYkKWsetBI2gQ3
         DNi0mohtozgaDYrwWWBTq4y1pFsDEnQfgLvRURg/FqlqqYa8SqaTCzl/+efKVbx/sD0u
         lFIqjZVd72QPmKcMyMMrhRep20Jv3j8qlnD+esnk48KxZSKv6iiDpRoCHaM7bTsAGnmw
         9BLdjo5SRGltnritBMn9wy6gyqOF9WaQhAtbpUj7kegttalqMp9s4sSZXtpnZ7wl3RVB
         Z0YQ==
X-Gm-Message-State: ACgBeo07f8dScQHXkO/HLJH3RTv3vrIGn65BsXcw7wfze5gzDnpdj/4p
        2P4k3nTeDq/SIR7IhBroar+Qn3QYK5DqrfPe8vFaYtXkZ7w=
X-Google-Smtp-Source: AA6agR4zgtLgNA+6EPAv70W9Z01Gulpe7vTobIsUEmKS5Gup9hLVk95/eNnOn1IhVSGIautSBTqi9ZJMAl53duUVpgY=
X-Received: by 2002:ad4:5f8f:0:b0:4a9:b75a:e33c with SMTP id
 jp15-20020ad45f8f000000b004a9b75ae33cmr746972qvb.82.1662374997159; Mon, 05
 Sep 2022 03:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220903-gpiod_get_from_of_node-remove-v1-0-b29adfb27a6c@gmail.com>
 <20220903-gpiod_get_from_of_node-remove-v1-1-b29adfb27a6c@gmail.com> <20220905071902.fv4uozrsttk3mosu@pali>
In-Reply-To: <20220905071902.fv4uozrsttk3mosu@pali>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 5 Sep 2022 13:49:21 +0300
Message-ID: <CAHp75Vf5R03nq6JmpVcVNX9L5CwM-uOmF39oHSZFP3QJe+GExQ@mail.gmail.com>
Subject: Re: [PATCH v1 01/11] PCI: tegra: switch to using devm_fwnode_gpiod_get
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

On Mon, Sep 5, 2022 at 10:23 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
> On Sunday 04 September 2022 23:30:53 Dmitry Torokhov wrote:

...

> > -             rp->reset_gpio =3D devm_gpiod_get_from_of_node(dev, port,
> > -                                                          "reset-gpios=
", 0,
> > -                                                          GPIOD_OUT_LO=
W,
> > -                                                          label);
> > +             rp->reset_gpio =3D devm_fwnode_gpiod_get(dev,
> > +                                                    of_fwnode_handle(p=
ort),
> > +                                                    "reset",
> > +                                                    GPIOD_OUT_LOW,
> > +                                                    label);
>
> Why in pci-aardvark.c for PERST# reset-gpio you have used
> devm_gpiod_get_optional() and here in pci-tegra.c you have used
> devm_fwnode_gpiod_get()? I think that PERST# logic is same in both
> drivers.

It's not the same dev and its node in this case. There is one reset
for _all_ ports, here is the reset on _per port_ basis.

--=20
With Best Regards,
Andy Shevchenko
