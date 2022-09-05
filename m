Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6CA5AD0D5
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 12:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237971AbiIEKz0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 06:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237258AbiIEKzP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 06:55:15 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2E1422EE;
        Mon,  5 Sep 2022 03:55:12 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id m5so6089163qkk.1;
        Mon, 05 Sep 2022 03:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=u5wXdybY4V4FdQrWKDhVN8YtAVKPzLButJ1sTRP8l1Y=;
        b=fN9ls9YPkyuUBAxr4wBmegmBCd5C9P/xaFPwXqy2FgkVzhIWNFNVR0bIehn1eXCf3d
         zobAQyMxj0Z6zjuSqQChSLqXx/lGBZnOoXZuh0swZ9USSGOks25+oXU6FAesXBD3v2DQ
         L68l4C/DyY0LtBFJIREWTz0QAYiKWOW4FJBp9fKNmjWxzb09XWs8F+aM06q4SUWIESBO
         xHTM6IpS/sM1qQMre3AApRlHWbfBdhbDuAOnnGrdzMosW5f0QYLusQvgZq38fCbtCj8+
         st+OCZ16eP1EI4yU9tRWvtbyzF+xtAD5mGA4eMQrLw3MtKQV7zXu1TtVJ7pKICr8G27y
         D+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=u5wXdybY4V4FdQrWKDhVN8YtAVKPzLButJ1sTRP8l1Y=;
        b=iCF+vFyW1X0U5onqqsgr4WsMGvgQc8QdesqcUTSXerfcDdDTdP+BHyAHrkvJJmJVmw
         7gmYHEsmRvaYihzi/LOTQ1wK7NhiGLL68nV1Tob0bvzvrfeNO0QeCTfBaUStLn1LX8QC
         JyKEWD5DrH+zo7QoiLjBIHtaX561FaQVYxG8JikTiudYBRJGmG1FaZqOSEK5N+Qwoqd2
         xnwpbht2Z3qLzlEhiOIDMevMkuMbTJHQ8EfqyKIsR1ly/1CTNJP9n1golQWQ0GIyAaFR
         ihIQ7Y2+GM6H1/KAj3Mfc1zB3sTwnzn99vD5xl58i8knNEwZDPizWHdR1cAVBRYpB4+c
         VvhQ==
X-Gm-Message-State: ACgBeo3PEoA0wyl9AnwO90gb2PLcVqzya8eCKckLHIcLbfN+GkyOWR5R
        Sv9oIjoYodvjpUT/OK90SdzSaL3hcl9mevGSE2g=
X-Google-Smtp-Source: AA6agR4kYjGXWf3gIvqIWbBUJGizexBviWISl//lL9gbx6ZDHQvEVsxtbzoy40VfO0zOsVmlCvX9hRiizwzJ1xcnYOU=
X-Received: by 2002:a05:620a:2987:b0:6ba:dc04:11ae with SMTP id
 r7-20020a05620a298700b006badc0411aemr31582222qkp.748.1662375311598; Mon, 05
 Sep 2022 03:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220903-gpiod_get_from_of_node-remove-v1-0-b29adfb27a6c@gmail.com>
 <20220903-gpiod_get_from_of_node-remove-v1-1-b29adfb27a6c@gmail.com>
 <20220905071902.fv4uozrsttk3mosu@pali> <CAHp75Vf5R03nq6JmpVcVNX9L5CwM-uOmF39oHSZFP3QJe+GExQ@mail.gmail.com>
 <20220905105341.z2pjlpljitws3j6l@pali>
In-Reply-To: <20220905105341.z2pjlpljitws3j6l@pali>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 5 Sep 2022 13:54:35 +0300
Message-ID: <CAHp75VedhWXbEG6kpObbpnyPE3M3dCM7nEyupJr+rwKj0kVC8w@mail.gmail.com>
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

On Mon, Sep 5, 2022 at 1:53 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
> On Monday 05 September 2022 13:49:21 Andy Shevchenko wrote:

...

> > It's not the same dev and its node in this case. There is one reset
> > for _all_ ports, here is the reset on _per port_ basis.
>
> aardvark is single port controller. So it is basically same.

Yep, just replied to my message.

--=20
With Best Regards,
Andy Shevchenko
