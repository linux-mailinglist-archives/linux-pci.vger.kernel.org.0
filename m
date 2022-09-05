Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56925AD9DC
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 21:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbiIETri (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 15:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbiIETrg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 15:47:36 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9B5550BE;
        Mon,  5 Sep 2022 12:47:35 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o4so9169330pjp.4;
        Mon, 05 Sep 2022 12:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=G9Qf5nb4X9K1i84KXH4HdM00CRNAf5tzFBdtc+b4TKE=;
        b=cWny7dbbvfDII4XkGp5mcFhDW7xnoXHh4AKp8q/idS35yLNxXCSkBzhGNbyJdfKcgw
         I98s6U9AGgEVnvf/Otkfnonv1p93zecPAa1Wxa3KSM+UL95+uWumTNi/u3z4jHg0grzX
         JtIxbBCRknabFNdt+fjzwr65uC6OsrsW5a4sEZz0NEuBTvgOr4Bn6uiqxSSkgXONv6VT
         dMkF/Ehj96BrC/2YGY47othtHiCKBlZNyPsKpaY7eBC/Q5vm7GnaEikiaZ3BvOwvpZmX
         nN/ytcT90lHjiXGbNBizBZZroVETT+W7vOuh6f97BaXqY726iRuZQ2CjSiog5B/naWka
         hITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=G9Qf5nb4X9K1i84KXH4HdM00CRNAf5tzFBdtc+b4TKE=;
        b=6U10j9hf0Ix6pdhcruQhYGd2uldeJwqCn2lb1Hu4FuyskOA1ZS8LBOyuICyhQqJgi1
         SrQd/wq3H/avtn64tNeS7diVHCMnVFMjov4yz6l/WxBKGB1qrCN1fR0tXT94kXKiiRtY
         0hogn+RqtOj8G2caYkB1zrbembYm5hS1ReZQrYqMXy1R5friaDrcoPMlfRT74fzDgD6P
         gv1k4AzoQKJ4pkodFIhffxNUQLU6dBE1wV1R7l+nlmJq3zz6i5/be2W9n7ySCLAYTCUr
         +GO9qzW6CPeogw2l9h5OAqSpwKZ0w3+VQ5S7/AJpo8bb6rYL2zHeTcqMqvXIInVSV/zr
         0Y0w==
X-Gm-Message-State: ACgBeo2ko67eL+r3qHHLx75mJR2rphPlhCDIMtRvlG0Y4NYUFU/gyB/s
        TBfwWY4JmMMlDeRrSW68Ks0=
X-Google-Smtp-Source: AA6agR4rG9EXV1E/55fesrVFOXE77lWvaBqXkzFJkUjVwNbVeqHEEiHG7UvgGt+kX2D0zKBcZVYK9g==
X-Received: by 2002:a17:90a:3c89:b0:1fa:acc2:bafe with SMTP id g9-20020a17090a3c8900b001faacc2bafemr21251569pjc.84.1662407254825;
        Mon, 05 Sep 2022 12:47:34 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:7332:f188:2984:5930])
        by smtp.gmail.com with ESMTPSA id v63-20020a622f42000000b0053e20a0333fsm27362pfv.93.2022.09.05.12.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 12:47:34 -0700 (PDT)
Date:   Mon, 5 Sep 2022 12:47:30 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
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
Subject: Re: [PATCH v1 10/11] watchdog: bd9576_wdt: switch to using
 devm_fwnode_gpiod_get()
Message-ID: <YxZSUlCPEE9o/s4G@google.com>
References: <20220903-gpiod_get_from_of_node-remove-v1-0-b29adfb27a6c@gmail.com>
 <20220903-gpiod_get_from_of_node-remove-v1-10-b29adfb27a6c@gmail.com>
 <CAHp75Vd35EOy=mP25=9fmYfqQnbafgotHw1fxk-TdGk6Oc8g8Q@mail.gmail.com>
 <75e60144-9fa2-d6ba-bc92-edd23f7e7189@roeck-us.net>
 <CAHp75VcisCTYoRp-=713YKtwi7BQyPKGiUhF4DkpfAFtvDXCiQ@mail.gmail.com>
 <c696b9bf-d0ce-1c6a-0ee3-939b180891be@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c696b9bf-d0ce-1c6a-0ee3-939b180891be@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 05, 2022 at 08:49:58AM -0700, Guenter Roeck wrote:
> On 9/5/22 08:21, Andy Shevchenko wrote:
> > On Mon, Sep 5, 2022 at 6:13 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > On 9/5/22 04:09, Andy Shevchenko wrote:
> > > > On Mon, Sep 5, 2022 at 9:33 AM Dmitry Torokhov
> > > > <dmitry.torokhov@gmail.com> wrote:
> > 
> > ...
> > 
> > > > > +       count = device_property_count_u32(dev->parent, "rohm,hw-timeout-ms");
> > > > > +       if (count < 0 && count != -EINVAL)
> > > > > +               return count;
> > > > > +
> > > > > +       if (count > 0) {
> > > > 
> > > > > +               if (count > ARRAY_SIZE(hw_margin))
> > > > > +                       return -EINVAL;
> > > > 
> > > > Why double check? You may move it out of the (count > 0).
> >
> > > Two checks will always be needed, so I don't entirely see
> > > how that would be better.
> > 
> > But not nested. That's my point:
> > 
> > if (count > ARRAY_SIZE())
> >    return ...
> > if (count > 0)
> >    ...
> > 
> 
> The old code has either 1 or two checks if there is no error.
> Your suggested code has always two checks. I don't see how that
> is an improvement.
> 
> > > > > -       if (ret == 1)
> > > > > -               hw_margin_max = hw_margin[0];
> > > > 
> > > > > +               ret = device_property_read_u32_array(dev->parent,
> > > > > +                                                    "rohm,hw-timeout-ms",
> > > > > +                                                    hw_margin, count);
> > > > > +               if (ret < 0)
> > > > > +                       return ret;
> > > > 
> > > > So, only this needs the count > 0 check since below already has it implicitly.
> > > > 
> > > Sorry, I don't understand this comment.
> > 
> > if (count > 0) {
> >    ret = device_property_read_u32_array(...);
> >    ...
> > }
> > if (count == 1)
> >   ...
> > if (count == 2)
> >   ...
> > 
> > But here it might be better to have the nested conditionals.
> > 
> 
> We know that count is either 1 or 2 here, so strictly speaking
> 	if (count == 1) {
> 	} else {
> 	}
> would be sufficient. On the other side, that depends on ARRAY_SIZE() being
> exactly 2, so
> 	if (count == 1) {
> 	} else if (count == 2) {
> 	}
> would also make sense. Either way is fine with me. I'll leave it up
> to Dmitry to decide what he wants to do.

My goal is to drop usage of devm_gpiod_get_from_of_node(), beyond that I
do not have strong preferences either way really. It is probing code, so
performance is not critical, but I'm obviously satisfied with how the
code looks now, or I would not have sent it.

Thanks.

-- 
Dmitry
