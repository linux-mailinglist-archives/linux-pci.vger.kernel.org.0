Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E365B167F
	for <lists+linux-pci@lfdr.de>; Thu,  8 Sep 2022 10:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbiIHILh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Sep 2022 04:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbiIHILB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Sep 2022 04:11:01 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F147AD9E99
        for <linux-pci@vger.kernel.org>; Thu,  8 Sep 2022 01:10:42 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id l14so12738688eja.7
        for <linux-pci@vger.kernel.org>; Thu, 08 Sep 2022 01:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=j4bs3PwCf8LAGt65QBrJwkN23+x5pcdlnIufUSNJIIQ=;
        b=XlFrs6f1Ru6mfmrDHSloR2yePiVJ+BuOhZJkeSnSJ/SOiEPgkH7fc5Qh53N1oKwQvH
         +OoAiOMDe47PpbvHsnBhm6aYdjqjrlxYnSo7yiZbqsAzABr7z6IbsSFiYRJdU8C2FmM8
         5DH3vl93eI862Lj3YGNPcem5IKwqOFLfYUBV/2qlp66cAcJz+GK/kSoE2Nn6RNzXIdZ9
         oJUIG5tDSXTW/MSaMC7qK7mdrhaTxlGrLwOPowZ4WpaBUKmm7LiCFjVvj0ZXOF9c8KIJ
         SNp39mJEoQxBFUzec2wJzhGoK5rRNZ4WQVIZ8FGwGa0dLMi1y1WJKYonoLdQWd7mN1KK
         y6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=j4bs3PwCf8LAGt65QBrJwkN23+x5pcdlnIufUSNJIIQ=;
        b=vgtLFIYYLGL+BWjoshKPlpuXFRrWZ0V7KuZY4xIayvOhesrkjyt0Fmh/hukpNqf2fo
         8RXsKtfPIUiKmlWZj/C72/2uANIZRbJh57aPeHg03rx0J21QOwHcorIcqVOU4S+kQkhH
         PSBBAcruJZzTKRNWqa94TAGHacNpTaldvpna5AA4F0PlyUhUFufQNs6o9cTEIqz33F4Q
         ego29gVxNQx349M5C8Unx07Xkj7XwAcB1M2gAswTO5PImgjVCpZ6pljOXZ3bCAVwW7lW
         GD1Jx7KejijDj0RA/0sPAd6vI2ktA6gM2Nf7Zi9QBDihZB0fCgFQFdrx7/gpvxhxHTEt
         gEMQ==
X-Gm-Message-State: ACgBeo248zfp5edxM3d1jmukF2WZVz72vrAry/tS51w2ivxQ7ml41JOA
        drKMhpSMiSaO47VAfUHc1/gbQ24AViEasNldjlpmLA==
X-Google-Smtp-Source: AA6agR5SiTp1RzXd7QfGvIaagW9XneozTUfgGg71dHg/7zkzwgHHmEoyMH3isqJfBMUwPz7K/i/VjO5b2+tszIQ2lUg=
X-Received: by 2002:a17:907:1c89:b0:741:4453:75be with SMTP id
 nb9-20020a1709071c8900b00741445375bemr5269882ejc.208.1662624640469; Thu, 08
 Sep 2022 01:10:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220903-gpiod_get_from_of_node-remove-v1-0-b29adfb27a6c@gmail.com>
 <20220903-gpiod_get_from_of_node-remove-v1-8-b29adfb27a6c@gmail.com>
In-Reply-To: <20220903-gpiod_get_from_of_node-remove-v1-8-b29adfb27a6c@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 8 Sep 2022 10:10:29 +0200
Message-ID: <CACRpkdakswdcFTgEGX-+2fgOHZ+VsDsRe+yj8hnExKuugnO9xQ@mail.gmail.com>
Subject: Re: [PATCH v1 08/11] regulator: bd71815: switch to using devm_fwnode_gpiod_get()
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
        linux-watchdog@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 5, 2022 at 8:31 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> I would like to stop exporting OF-specific devm_gpiod_get_from_of_node()
> so that gpiolib can be cleaned a bit, so let's switch to the generic
> fwnode property API.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
