Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDBF5AD152
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 13:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238184AbiIELNu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 07:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236467AbiIELNr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 07:13:47 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821C05A832;
        Mon,  5 Sep 2022 04:13:45 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id d1so6244264qvs.0;
        Mon, 05 Sep 2022 04:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=7iAktJHc3w6rPsnzClYi6h63eWPfDzaVzHqTBIckRp4=;
        b=R7t2Qcp1lBflY1vcWSAvFGDpL1wm70fCepnWH+zrAbiof4E0R0r6MaodmK99KC/uqU
         lkRNi47VWEdS1Mh0Cq7rMIeuWmncJJ2cOty+OFE/rSCBYVUer1tDhNIt1xJajNoN+pha
         9hYFjgcUDhUv9vg4Rsjx4Td0f/j+c8XAElCdXPkz1XbyGCnZFSRjvecB8Dt/V/2ytwns
         pr0+QJCk5ml5PiGLXoq+OBMZT8nSbzyKkmBD4jlfWYYC6/a2AVD44sThrAdLIlOLbLDI
         BjJuCJ4ppbMAAjAsrBVEK+NW8M6uu3+DQvsU1sl/6kNwDh7BxhDa793GpPoaKD+rDvK/
         /Y2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=7iAktJHc3w6rPsnzClYi6h63eWPfDzaVzHqTBIckRp4=;
        b=0NK01ckdL5j08V3YQTtYIo+1OBWkYlmtcmdswdYO+H7A5QSouGw0BokAEpXPvOHI/j
         9UR9Hu15qKJstZLHr0/Nw4/hSgsRwZLzaXeE/zi76ph9hAAna5w9VWLslzkw5gmqkeQJ
         bM2Z+MPrDcDeUPQ0HefwQ0EZ1t1zsyJ8gnOtqEmgTpOa125/bf/JQiYwYY8vM/rIXY3T
         SxTZhKLCs6m+pVM81zZfnzruyNJUogTqaYa21kzWlVxBiTwev3n9PVT+373wABUO4k44
         kgVjMuMHVKqk2d6IdogMm2gjevbFOZ+ZIH0/u4N9ZJL+dHrlC//y7g3S1eUQ8ljKZiQI
         MJDQ==
X-Gm-Message-State: ACgBeo0u/g86km4ZaPLA5q6xuhhjOs7ZlRawnPW+dndLmH6gbLVU8ddI
        OJHwG50ko/PlU8FAOLy7Sn7XcrZnsTAEe2jQtMY=
X-Google-Smtp-Source: AA6agR7NrRmeK1sjqt1ZjgVXwez7kxeuRCTCLwTPPcAUxaHLOiRLXkVvjX6xUtf8npwaMKmSjSHhnRIt4pJmIe7SA1s=
X-Received: by 2002:a05:6214:19cf:b0:4a9:4241:2399 with SMTP id
 j15-20020a05621419cf00b004a942412399mr1093930qvc.64.1662376424240; Mon, 05
 Sep 2022 04:13:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220903-gpiod_get_from_of_node-remove-v1-0-b29adfb27a6c@gmail.com>
In-Reply-To: <20220903-gpiod_get_from_of_node-remove-v1-0-b29adfb27a6c@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 5 Sep 2022 14:13:08 +0300
Message-ID: <CAHp75Vc5cEs6mPSL1fkHBT2hw-CbmbELFwkEGvwxkrdEVF2K_Q@mail.gmail.com>
Subject: Re: [PATCH v1 00/11] Get rid of [devm_]gpiod_get_from_of_node()
 public APIs
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
> I would like to stop exporting OF-specific [devm_]gpiod_get_from_of_node()
> so that gpiolib can be cleaned a bit. We can do that by switching drivers
> to use generic fwnode API ([devm_]fwnode_gpiod_get()). By doing so we open
> the door to augmenting device tree and ACPI information through secondary
> software properties (once we teach gpiolib how to handle those).
>
> I hope that relevant maintainers will take patches through their trees and
> then we could merge the last one some time after -rc1.

I'm in favour of the series, but some comments would be good to be addressed.

-- 
With Best Regards,
Andy Shevchenko
