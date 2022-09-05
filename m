Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685755ADB85
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 00:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiIEWuI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 18:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbiIEWtv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 18:49:51 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594682CE18;
        Mon,  5 Sep 2022 15:49:48 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id fa2so9483272pjb.2;
        Mon, 05 Sep 2022 15:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=Nz+uqA7e4/P8W1+vztFIrzinPtJHEHUsBZrInKc0qlM=;
        b=QV/OF44k3joZDZETl0+ZlAcG808nTpQ+6yaZoVIx1EasnMTt4l9JtEqbk6ylV1sjPH
         CpsCnzKXD1yaRjJY8yjGFM/Rgnq9yiszyTc8TCHLEugHFhpgglTtFg/61iYR6lNKhfNX
         n+f8CJcsIFbu92wir0N7hH/bTYw1QemkS4mo8z9i7RazUS8WbaVUlDCuaya5GJBZu9IE
         QvA+bSBWFp0EO1XhWI8AaZpOPguSsXCXaTdXXwJTBB7rNsozxl6OvfDIM+wu5p0E19qV
         /OGRMYL6CRqyQ5aXHZUHHnxJTRmKFDJXhnoU6eq51SznMODXDCf9krZ5aKy7RCOTOjHC
         Ptlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Nz+uqA7e4/P8W1+vztFIrzinPtJHEHUsBZrInKc0qlM=;
        b=LevFqHsaCX0jtoBjPgrY+4f9HyEU1IaOKcwTIryijHGPv36tl/PeTX98Q/zlAat7Q2
         FZGVDRUTFzWtVQ/Z0kaf9bIXJD48v+GuZsh/lkc4ZxUr/KacoM0SecYl2CiptDpBpS+j
         i7QeJaov1VRUYoynqSSWf1iY9rBmWBhQ7GRcFDsgFcGETHnH7UUYOLeLcGBvFf+diHWg
         qRqu0YerXewOhHOjfgWb8hsQP86gcFj1ZKyYer74tPGDOYnueuEAqywchRXoMcI/oSWP
         /inqPBH/BlKsRmueIyGDV/jdKrJsAU470khVnJQiJJMcYpiiOvz+Y4x0sM84qYhDYA28
         vm1g==
X-Gm-Message-State: ACgBeo1W/TYni+exhOcn7oPMW+8KPWEddi+4/Ty2eBOqYD/5Ir7XVeqs
        wZilEV+GQcAGxPGWZu9UbL4=
X-Google-Smtp-Source: AA6agR4K6lIuAxsSdVJ0oNphFJqoDM1Qz4a/ewauw+FqqlvVaYz09d/58GCWTrClE39lnwuTI3+EHg==
X-Received: by 2002:a17:902:d4c4:b0:172:f328:e474 with SMTP id o4-20020a170902d4c400b00172f328e474mr51321307plg.144.1662418187481;
        Mon, 05 Sep 2022 15:49:47 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:1190:fbfa:ae95:111c])
        by smtp.gmail.com with ESMTPSA id x10-20020a170902a38a00b0017300ec80b0sm8054511pla.308.2022.09.05.15.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 15:49:46 -0700 (PDT)
Date:   Mon, 5 Sep 2022 15:49:42 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
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
        linux-watchdog@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 01/11] PCI: tegra: switch to using
 devm_fwnode_gpiod_get
Message-ID: <YxZ9BkBnQOUpXt/O@google.com>
References: <20220903-gpiod_get_from_of_node-remove-v1-0-b29adfb27a6c@gmail.com>
 <20220903-gpiod_get_from_of_node-remove-v1-1-b29adfb27a6c@gmail.com>
 <20220905071902.fv4uozrsttk3mosu@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220905071902.fv4uozrsttk3mosu@pali>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 05, 2022 at 09:19:02AM +0200, Pali Rohár wrote:
> On Sunday 04 September 2022 23:30:53 Dmitry Torokhov wrote:
> > I would like to limit (or maybe even remove) use of
> > [devm_]gpiod_get_from_of_node in drivers so that gpiolib can be cleaned
> > a bit, so let's switch to the generic device property API. It may even
> > help with handling secondary fwnodes when gpiolib is taught to handle
> > gpios described by swnodes.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > 
> > diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> > index 8e323e93be91..929f9363e94b 100644
> > --- a/drivers/pci/controller/pci-tegra.c
> > +++ b/drivers/pci/controller/pci-tegra.c
> > @@ -2202,10 +2202,11 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
> >  		 * and in this case fall back to using AFI per port register
> >  		 * to toggle PERST# SFIO line.
> >  		 */
> > -		rp->reset_gpio = devm_gpiod_get_from_of_node(dev, port,
> > -							     "reset-gpios", 0,
> > -							     GPIOD_OUT_LOW,
> > -							     label);
> > +		rp->reset_gpio = devm_fwnode_gpiod_get(dev,
> > +						       of_fwnode_handle(port),
> > +						       "reset",
> > +						       GPIOD_OUT_LOW,
> > +						       label);
> 
> Why in pci-aardvark.c for PERST# reset-gpio you have used
> devm_gpiod_get_optional() and here in pci-tegra.c you have used
> devm_fwnode_gpiod_get()? I think that PERST# logic is same in both
> drivers.

I believe Andy already answered that, but in this driver we can have
several root ports described via subnodes of dev->of_node, and reset
GPIOs are attached to those subnodes. We are forced to use
devm_fwnode_gpiod_get() instead of devm_gpiod_get_optional() as we need
to supply the exact fwnode we need to look up GPIO in, and can not infer
it from the 'dev' parameter of devm_gpiod_get().

Thanks.

-- 
Dmitry
