Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01745AF9A7
	for <lists+linux-pci@lfdr.de>; Wed,  7 Sep 2022 04:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiIGCBE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 22:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiIGCBD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 22:01:03 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06641844E8;
        Tue,  6 Sep 2022 19:01:03 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o4so13082556pjp.4;
        Tue, 06 Sep 2022 19:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=YaCijregOqOjgcZeIED7JVmldRewR4dEphbJlxDQblY=;
        b=S9pRunUxPC7r0e1w9yj0o8783wojVpjNhKP8jsT71wWMuWPsfUFzdJz0TJMPpqTsPB
         M+Ae8ANyYrV4Sep3x0VbDc+EnMue4OoEN8RpFTpOjPkluJnGT2cqlVh1JYNiO5h/tDGK
         RGVJLwVuP7GISwNRAdT5OiqdenVIGFNKEJzKBNq2q1BXIKHlp8tWKx0fxbOK8GA6DZwQ
         TZfa9JbPfMPcxWCYQlbaTpn5opve5VlejEuuBRLWTpxblG8WQDMhb5np+dyWJJ6kAEEW
         rXWcB3V4lQHvMssIFHI0kdZjP9pomfXdXnH1i/sJC8kJC91PlHbGOcBl6u1/CPq1k3ff
         5tAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=YaCijregOqOjgcZeIED7JVmldRewR4dEphbJlxDQblY=;
        b=WxDUq3Zq8X3Rgc4b4WifMHhrdfV384FmuJ8jN1TY9qpsynBbpON8npbKBu1EmbSBow
         hRx7vF9EuhuALd3eriMzTB3F9jkXpXKOprButVLbX4LgKneL69guYPbWVGvB/IjE+uBk
         hVBZPmPKjaJ2DrOgeT7bTzNTyroF0NiKXbiF1hliemI+monJP86TTYjCftE7d1d7FOm+
         r+lyCyXZecBvF93+c/rOatz0vVxdWNVLQ1iyOqR1rhG+q5cYLPv1FfwReqxZ+KjIGSqP
         CYb1w2B5crTaIM2jWuDTlGKR+8/go/hbm3HcuyfOuubDuJp2e0DeyPvuPz02B2rRGaxj
         k29Q==
X-Gm-Message-State: ACgBeo1ymCE4OcJOM8zKViDHs1TKM80vVmLyO4oYaKmb9XkOvarpPem6
        C2Vm3DhnjAKpDX+pnlnY0iw=
X-Google-Smtp-Source: AA6agR4W7OfcLFzEOrvTrf5AWbvTtcvq1nW6dbnnaSOnulUmzjwEL9HxLO3xrl5g0PyDmCwuPzMlMg==
X-Received: by 2002:a17:90b:3ec7:b0:1fa:cdc1:f66 with SMTP id rm7-20020a17090b3ec700b001facdc10f66mr28531683pjb.167.1662516062292;
        Tue, 06 Sep 2022 19:01:02 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:abc4:5d24:5a73:a96b])
        by smtp.gmail.com with ESMTPSA id a206-20020a621ad7000000b00537d74f58cbsm2322985pfa.69.2022.09.06.19.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 19:01:01 -0700 (PDT)
Date:   Tue, 6 Sep 2022 19:00:57 -0700
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
Message-ID: <Yxf7WTFG7xEh2Gv6@google.com>
References: <20220903-gpiod_get_from_of_node-remove-v1-0-b29adfb27a6c@gmail.com>
 <20220903-gpiod_get_from_of_node-remove-v1-10-b29adfb27a6c@gmail.com>
 <CAHp75Vd35EOy=mP25=9fmYfqQnbafgotHw1fxk-TdGk6Oc8g8Q@mail.gmail.com>
 <75e60144-9fa2-d6ba-bc92-edd23f7e7189@roeck-us.net>
 <CAHp75VcisCTYoRp-=713YKtwi7BQyPKGiUhF4DkpfAFtvDXCiQ@mail.gmail.com>
 <c696b9bf-d0ce-1c6a-0ee3-939b180891be@roeck-us.net>
 <YxZSUlCPEE9o/s4G@google.com>
 <73749107-35aa-0720-1a30-02a90c0540fa@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73749107-35aa-0720-1a30-02a90c0540fa@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 05, 2022 at 03:09:05PM -0700, Guenter Roeck wrote:
> On 9/5/22 12:47, Dmitry Torokhov wrote:
> [ ... ]
> > > We know that count is either 1 or 2 here, so strictly speaking
> > > 	if (count == 1) {
> > > 	} else {
> > > 	}
> > > would be sufficient. On the other side, that depends on ARRAY_SIZE() being
> > > exactly 2, so
> > > 	if (count == 1) {
> > > 	} else if (count == 2) {
> > > 	}
> > > would also make sense. Either way is fine with me. I'll leave it up
> > > to Dmitry to decide what he wants to do.
> > 
> > My goal is to drop usage of devm_gpiod_get_from_of_node(), beyond that I
> > do not have strong preferences either way really. It is probing code, so
> > performance is not critical, but I'm obviously satisfied with how the
> > code looks now, or I would not have sent it.
> > 
> 
> Good point.
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter, individual patches are going through maintainer's trees, will
you take this one?

Thanks.

-- 
Dmitry
