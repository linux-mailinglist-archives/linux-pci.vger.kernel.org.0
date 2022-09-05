Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39005AD9F0
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 21:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbiIETya (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 15:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiIETy2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 15:54:28 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7185B10F9;
        Mon,  5 Sep 2022 12:54:27 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so12952259pjq.3;
        Mon, 05 Sep 2022 12:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=zxa96jF7Tq2NFS5Z0f+Vbe6tPHaqlTK7+tACu1Wc1bY=;
        b=p+w40zBKb360cS3t/20RQ9fj87kNmL9+wV2DVi2rkEnZbxImbIJc7pte6gUegPMA8a
         sFBB5aUkvaOM6b3Kj9qmd2ut1NKgO+CDhyFT91dG8+KUVoVf0gInhE/UOnfhB92XkSNY
         u8qMra/sYBIyNm2Awyf4P1TWUIjbeQASP/d7P9T5CM2s7DH926t2/T3HcNVk1DoW+UGS
         v796lRquHF7Qmw7ptQ1DqA4ajtoKb1+hxfBI6rfUByvolTPU6//4uMw0nmTfqEuWbj/R
         2Evodr6uEdppBL0mwTkx6onhEejt0ETyPcrx+UWGe+X8/pqjNco8n2BX6gqU3Djw+OmE
         nbNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zxa96jF7Tq2NFS5Z0f+Vbe6tPHaqlTK7+tACu1Wc1bY=;
        b=RSJjMfuF6ngpVq+vXWxHlqZoGHbAZ9SoIQewFohQDNVCQI4vHAEhsRh2bMIo1+7IXn
         XWIOTTvU07XJILzoeXM+8tP6dJk0xV5y+mnEfHikFjkBOfCzmbIr3HykhOJV1+CgRXx3
         iMkA5BObGeacvieQYIv2pKqXljpLWXoNbUkaLkxnHOmNxcMRjkgCDbztVPJpsVCcLvwv
         9dpMu7UWCVOICz1DbDIBvGADK5kdcWohiDIp/CEEa4vsrFlQw/C1c7CuJ7PgtI8rasCL
         dXN/YJW+c8z775X8I/hppyw23CbZCfvrcsn3MTh3ZN6vuzkAKAnNg/9jo97RpFJSQbWg
         O11w==
X-Gm-Message-State: ACgBeo2J0zs4fRqrfdcsGaSy/1VzGqIMJ3Hd32IPI0wFhkX7WwjWZrfM
        pJJYILlrt9IbDGli99rC9/k=
X-Google-Smtp-Source: AA6agR5Cv7sHKUo7MkZvN9NCQW+TEQYIAszXUVs54FMP1ugGloikm17da8wbNClAm9HOmIskUrqfng==
X-Received: by 2002:a17:903:248:b0:172:7520:db07 with SMTP id j8-20020a170903024800b001727520db07mr50029962plh.76.1662407666780;
        Mon, 05 Sep 2022 12:54:26 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:7332:f188:2984:5930])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902dace00b001754a3c5404sm7987874plx.212.2022.09.05.12.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 12:54:26 -0700 (PDT)
Date:   Mon, 5 Sep 2022 12:54:22 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
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
Subject: Re: [PATCH v1 06/11] PCI: aardvark: switch to using
 devm_gpiod_get_optional()
Message-ID: <YxZT7tDhW/7T+Snl@google.com>
References: <20220903-gpiod_get_from_of_node-remove-v1-0-b29adfb27a6c@gmail.com>
 <20220903-gpiod_get_from_of_node-remove-v1-6-b29adfb27a6c@gmail.com>
 <20220905070046.46nlhczkck2ufr4x@pali>
 <CAHp75VcFv7ipLqXmOwbXpY-_ccYNA9PgF0h4T8RY1Z-UNNpaTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VcFv7ipLqXmOwbXpY-_ccYNA9PgF0h4T8RY1Z-UNNpaTg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 05, 2022 at 01:47:41PM +0300, Andy Shevchenko wrote:
> On Mon, Sep 5, 2022 at 10:02 AM Pali Rohár <pali@kernel.org> wrote:
> > On Sunday 04 September 2022 23:30:58 Dmitry Torokhov wrote:
> > > I would like to stop exporting OF-specific devm_gpiod_get_from_of_node()
> > > so that gpiolib can be cleaned a bit, so let's switch to the generic
> > > device property API.
> > >
> > > I believe that the only reason the driver, instead of the standard
> > > devm_gpiod_get_optional(), used devm_gpiod_get_from_of_node() is
> > > because it wanted to set up a pretty consumer name for the GPIO,
> >
> > IIRC consumer name is not used at all.
> 
> It's. The user space tools use it as a label. So, GPIO line can have
> "name" (this is provider specific) and "label" (which is consumer
> specific, i.o.w. how we use this line).
> 
> ...
> 
> > > +             if (ret != -EPROBE_DEFER)
> > > +                     dev_err(dev, "Failed to get reset-gpio: %i\n",
> > > +                             ret);
> > > +             return ret;
> 
> I understand that in the input subsystem maintainer's hat you don't
> like dev_err_probe(), but it's a good case to have it here.

The driver currently does not use this API, so I elected not to
introduce it in this series.

Thanks,

-- 
Dmitry
