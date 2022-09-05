Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C545E5AD0F9
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 13:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbiIEK5k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 06:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbiIEK5j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 06:57:39 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D1A4363A;
        Mon,  5 Sep 2022 03:57:38 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id cr9so5845617qtb.13;
        Mon, 05 Sep 2022 03:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=SceFooGsQvk4/DBXpk/M7nv2E1Tqfm+MkuaSRZ3qev8=;
        b=QgN1fKt4DP2kb7sAiv+5KFok8U8dxv0x5611ZTop3HKEETihbtz9RufJ5RUJvT6oy3
         NsDYXvFgWk/79gT0t031cWuTJ9+0anNKT0/QMVUymrmw27VD2+Q9Fvf/a4F1TUNnaeSG
         rqxNiZxP2226FfdS2mZJiVeLEcQ2F7NOQTCivGpJw3EJafbSCKZtnmajkVfO//JmwESc
         OQ+A5m2uZ9uWB9V0ddapJ9/fH/JlBtRhD0Pv/BF1sgrOUoMmJeKFvXNsijHb3izSghCC
         dWQbrWPcWtAWtUFpsLJaj3WsvtsNYlDXfe5EMqd/eXC/8JZqf2A/mHdQZ+FdhXMyXOQX
         cbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=SceFooGsQvk4/DBXpk/M7nv2E1Tqfm+MkuaSRZ3qev8=;
        b=GDkYK206D1NTUpXQXPtAGeJT8YJxC8XI6e4VXWkPrLsdM7NAmOA+B4fB/IODN1qCL0
         dGgFnuI+ru876fJ5/pZot4/4yLeZHYbsvLI3/wZuojabqf6F93xkGnMWtHr0HBxB/Mr3
         fHUrHHpMyfpgzi+ywxaJz94cFtHrOBE6bsJ70lXPY4g2kZcUotLA7DfzF1LgqzDXR009
         lrFxBLOCmZOhlZABZGIwd/Yb5bTzcfUnuAae78pBHgRGT2wiAs951Nb608R8pjxrrPMs
         ABedwI5QV+uLe9OiVoIB8vKI4aWrVkJHTV4RLjB+C2B1dEseBci9hPSyCDzat2OJSgUO
         hfYQ==
X-Gm-Message-State: ACgBeo0MNNxdvkE4hxd06zN6DTKQplCyvb/710rPR4rFFlmH6gdfTjJc
        tgnS+lUR3HUvrKYmundjxarRpnQ94iQo8gQiglA=
X-Google-Smtp-Source: AA6agR60W0s2Xg2TAEJ7W+zD52eGjGAMZEZ33WklScUG5wc6dHREuBxFFHnQsCibmN0jWps5VKuSjG68kRfEhV6Vu4I=
X-Received: by 2002:a05:622a:40a:b0:343:77ba:727f with SMTP id
 n10-20020a05622a040a00b0034377ba727fmr39279991qtx.481.1662375457185; Mon, 05
 Sep 2022 03:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220903-gpiod_get_from_of_node-remove-v1-0-b29adfb27a6c@gmail.com>
 <20220903-gpiod_get_from_of_node-remove-v1-2-b29adfb27a6c@gmail.com>
In-Reply-To: <20220903-gpiod_get_from_of_node-remove-v1-2-b29adfb27a6c@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 5 Sep 2022 13:57:01 +0300
Message-ID: <CAHp75Vc4yfh0JcY0B-vNawHTay5QNuhd7GAm86QZZZvUnQaMzQ@mail.gmail.com>
Subject: Re: [PATCH v1 02/11] drm/tegra: switch to using devm_fwnode_gpiod_get
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
> I would like to limit (or maybe even remove) use of
> [devm_]gpiod_get_from_of_node in drivers so that gpiolib can be cleaned
> a bit, so let's switch to the generic device property API.

> It may even
> help with handling secondary fwnodes when gpiolib is taught to handle
> gpios described by swnodes.

I would remove this sentence from all commit messages since it's a
debatable thing and might even not happen, so the above is a pure
speculation.


-- 
With Best Regards,
Andy Shevchenko
