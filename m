Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCA75AD64B
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 17:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238919AbiIEPWt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 11:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238810AbiIEPW0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 11:22:26 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E5F5E65A;
        Mon,  5 Sep 2022 08:22:19 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id s22so6492937qkj.3;
        Mon, 05 Sep 2022 08:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=+ZiqcY4iwW4z7/E7mCAKrjs2qkOwesFoeuU+408Ac8o=;
        b=VFmGFDTElC9gVBP4IH125hq51A7FGr51vQ9KGLGqsDH5FAEMbMbUXIVHi85ww+a0fI
         GziSfVv/AV96vVMyihm0a9WLMAOVaqURD6Z6C0QYsgp+rD6u9b5XKuySpRwB9/4ukD5r
         ntRcngBKUZIdj1p7dnKxVpS61IIJC70YsoWsdaYgU3yQ1OeaPC6Dp8pG57kfBWmOL/93
         L/IFFf00dHT3zgOp5UKnif6AxMU2wmHM+SIXzgJwfA+idsrUzSPhTV0Cy8bk19HNDekI
         +ldaJp7J0Y+v4fVjKkwUglDoR826zDL6l5uW2KrYqW3xGquKc2bpuTp1y4lh/YVJ6mAK
         GUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=+ZiqcY4iwW4z7/E7mCAKrjs2qkOwesFoeuU+408Ac8o=;
        b=X6vXErVPMJY7d1KHJ77+zIPQCFI0nwzh7fnLnnmSbuQktl5hH9FtjLRDtYuOI0WmG6
         Kz7kh8TDh2HB3DV5mlOrGD2uV8vB4EWEZrp4W0faBhfTjKk3giHYFE1KfO4Xvd24RhM6
         aGp5qEDIxfTWy6MfSwEpxi4bDypI5y4zEcgpC3G94j1LW3ESHj1f0BbMKhwwxMN4sv4E
         vFgzPkpOJsMXgVTHijBSspw7sYMW878mYTkjqwPrSXHqe1MQBOTAGhMogWGD3hUipc0a
         kVNiJsvM6x1bBO4kvgBNpqQZsEMHHMN20n3o/yiYOtxdZ5IGI3dOsp6NSzUj5IjgEv5J
         8YYQ==
X-Gm-Message-State: ACgBeo35E66bskPTI7omOBhSkr9TDFyyrrO6OkACMhX9OBlca8TALC2y
        un8UsY7S4/gZYKkpzPLRtYb2NQaXKfBvEVr6xv4=
X-Google-Smtp-Source: AA6agR6eqDleGJQNbmaUKo+DXkG0Owzp6XfxQg6gg92/7A34V7uBDxuh7YdkC5fcKcuRE7T6e8KsWIJlWSuvkZ2TzuU=
X-Received: by 2002:a05:620a:410e:b0:6bc:5cdc:88ec with SMTP id
 j14-20020a05620a410e00b006bc5cdc88ecmr33187504qko.734.1662391338268; Mon, 05
 Sep 2022 08:22:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220903-gpiod_get_from_of_node-remove-v1-0-b29adfb27a6c@gmail.com>
 <20220903-gpiod_get_from_of_node-remove-v1-10-b29adfb27a6c@gmail.com>
 <CAHp75Vd35EOy=mP25=9fmYfqQnbafgotHw1fxk-TdGk6Oc8g8Q@mail.gmail.com> <75e60144-9fa2-d6ba-bc92-edd23f7e7189@roeck-us.net>
In-Reply-To: <75e60144-9fa2-d6ba-bc92-edd23f7e7189@roeck-us.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 5 Sep 2022 18:21:42 +0300
Message-ID: <CAHp75VcisCTYoRp-=713YKtwi7BQyPKGiUhF4DkpfAFtvDXCiQ@mail.gmail.com>
Subject: Re: [PATCH v1 10/11] watchdog: bd9576_wdt: switch to using devm_fwnode_gpiod_get()
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Mon, Sep 5, 2022 at 6:13 PM Guenter Roeck <linux@roeck-us.net> wrote:
> On 9/5/22 04:09, Andy Shevchenko wrote:
> > On Mon, Sep 5, 2022 at 9:33 AM Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:

...

> >> +       count = device_property_count_u32(dev->parent, "rohm,hw-timeout-ms");
> >> +       if (count < 0 && count != -EINVAL)
> >> +               return count;
> >> +
> >> +       if (count > 0) {
> >
> >> +               if (count > ARRAY_SIZE(hw_margin))
> >> +                       return -EINVAL;
> >
> > Why double check? You may move it out of the (count > 0).
>
> Two checks will always be needed, so I don't entirely see
> how that would be better.

But not nested. That's my point:

if (count > ARRAY_SIZE())
  return ...
if (count > 0)
  ...

> >> -       if (ret == 1)
> >> -               hw_margin_max = hw_margin[0];
> >
> >> +               ret = device_property_read_u32_array(dev->parent,
> >> +                                                    "rohm,hw-timeout-ms",
> >> +                                                    hw_margin, count);
> >> +               if (ret < 0)
> >> +                       return ret;
> >
> > So, only this needs the count > 0 check since below already has it implicitly.
> >
> Sorry, I don't understand this comment.

if (count > 0) {
  ret = device_property_read_u32_array(...);
  ...
}
if (count == 1)
 ...
if (count == 2)
 ...

But here it might be better to have the nested conditionals.

> >> -       if (ret == 2) {
> >> -               hw_margin_max = hw_margin[1];
> >> -               hw_margin_min = hw_margin[0];
> >> +               if (count == 1)
> >> +                       hw_margin_max = hw_margin[0];
> >> +
> >> +               if (count == 2) {
> >> +                       hw_margin_max = hw_margin[1];
> >> +                       hw_margin_min = hw_margin[0];
> >> +               }
> >>          }

-- 
With Best Regards,
Andy Shevchenko
