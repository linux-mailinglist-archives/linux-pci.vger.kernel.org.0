Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75755ADB9D
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 00:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbiIEWzB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 18:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbiIEWy7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 18:54:59 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE13F22B30;
        Mon,  5 Sep 2022 15:54:58 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id fv3so3366158pjb.0;
        Mon, 05 Sep 2022 15:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=QRQkxIGFI3OF3amcRlbkZf4vgkek6ggFXyd9zidvB8c=;
        b=gsorC9ciDElqLq5gq0tq73oj5nMDX/AJm+EMEt5M9j7Nw6OucD0+TVGBzuQn+rrtls
         0loRnw7UzHrgMM28KIGVLo7qn/bZoumg2qTw3CfDMDdQmf0bgbzpShi+kGjU7raGyx6P
         sToiGUYujxqPyCybICNsYdfYAa2jOurTif72VImXpZhCttvifys7wIqhFIW1PJR8dY03
         UzvU99z5GubsoABcuAk5rbAMv44acUIXmY5P0ep133FiqLgOHtVg+wzuulxPweHG+ula
         IzdWZ5ta3aGiqrNbwgZATXaEEWNGQRgzb+HrP6NXzuvsc0zd1wPa546sY9tkILtVErqR
         hUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=QRQkxIGFI3OF3amcRlbkZf4vgkek6ggFXyd9zidvB8c=;
        b=M/s7BGVStwTv9m1z4cz9YNSchNnSk3fSsWDH1/fgS2sWgVeZdVoC2nwqtt0CPiC/7K
         xRh8xEllVZMVWT67rD6tjFOeK9c/5s2kxu3snlB9r4WUd3IxbXXJAEfmzdkP8eyRTxb2
         wNBnlIKZhsF+qIZfNq52SAqzFyu95VYuIE2c+Qr3qRg2kVr3tASNLPMAdBBC/Se02IqW
         ix6j3OKkc0Se3DtuMQtk8gANujy0aWN5KHACJAEGidhgzzY3KdGFiNfr+n+GIbYBcaVA
         HftmH7DY+OR4wSqDjJ/BYngSFkg3w/DEYgV15YIVyWz9KVNyhiPqRpMH11dbZf3o2tnk
         u3qQ==
X-Gm-Message-State: ACgBeo3JaZi5sZV5UPunvS4jfAmDDqOyv2SpN9eiyZ24atF7DyPGd1s7
        nzZ8dKH+axeq0Xn3NpZ2KUU=
X-Google-Smtp-Source: AA6agR6BVwijybUmJvKefzrwHZ9dDsULsMfqVmOf8/ecx+Q6qQipxqieCoJRYSCXP05TF0ANy6CnCA==
X-Received: by 2002:a17:902:be03:b0:175:6397:9425 with SMTP id r3-20020a170902be0300b0017563979425mr21493671pls.26.1662418498231;
        Mon, 05 Sep 2022 15:54:58 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:1190:fbfa:ae95:111c])
        by smtp.gmail.com with ESMTPSA id d21-20020a630e15000000b0042c2def703asm6833366pgl.22.2022.09.05.15.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 15:54:57 -0700 (PDT)
Date:   Mon, 5 Sep 2022 15:54:53 -0700
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
Subject: Re: [PATCH v1 06/11] PCI: aardvark: switch to using
 devm_gpiod_get_optional()
Message-ID: <YxZ+PSDRYZnVKfFO@google.com>
References: <20220903-gpiod_get_from_of_node-remove-v1-0-b29adfb27a6c@gmail.com>
 <20220903-gpiod_get_from_of_node-remove-v1-6-b29adfb27a6c@gmail.com>
 <20220905070046.46nlhczkck2ufr4x@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220905070046.46nlhczkck2ufr4x@pali>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 05, 2022 at 09:00:46AM +0200, Pali Rohár wrote:
> On Sunday 04 September 2022 23:30:58 Dmitry Torokhov wrote:
> > I would like to stop exporting OF-specific devm_gpiod_get_from_of_node()
> > so that gpiolib can be cleaned a bit, so let's switch to the generic
> > device property API.
> > 
> > I believe that the only reason the driver, instead of the standard
> > devm_gpiod_get_optional(), used devm_gpiod_get_from_of_node() is
> > because it wanted to set up a pretty consumer name for the GPIO,
> 
> IIRC consumer name is not used at all.
> 
> The reason was to specify full name of DTS property, for easier
> identification of the code. DTS property is "reset-gpios" but API
> specify only "reset".

I see. Do you want me to reset the patch with updated desctiption as to
the reason devm_gpiod_get_from_of_node() was used?

> 
> > and we now have a special API for that.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > 
> > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > index 4834198cc86b..4a8a4a8522cb 100644
> > --- a/drivers/pci/controller/pci-aardvark.c
> > +++ b/drivers/pci/controller/pci-aardvark.c
> > @@ -1856,20 +1856,19 @@ static int advk_pcie_probe(struct platform_device *pdev)
> >  		return ret;
> >  	}
> >  
> > -	pcie->reset_gpio = devm_gpiod_get_from_of_node(dev, dev->of_node,
> > -						       "reset-gpios", 0,
> > -						       GPIOD_OUT_LOW,
> > -						       "pcie1-reset");
> > +	pcie->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> >  	ret = PTR_ERR_OR_ZERO(pcie->reset_gpio);
> >  	if (ret) {
> > -		if (ret == -ENOENT) {
> > -			pcie->reset_gpio = NULL;
> > -		} else {
> > -			if (ret != -EPROBE_DEFER)
> > -				dev_err(dev, "Failed to get reset-gpio: %i\n",
> > -					ret);
> > -			return ret;
> > -		}
> > +		if (ret != -EPROBE_DEFER)
> > +			dev_err(dev, "Failed to get reset-gpio: %i\n",
> > +				ret);
> > +		return ret;
> > +	}
> > +
> > +	ret = gpiod_set_consumer_name(pcie->reset_gpio, "pcie1-reset");
> > +	if (ret) {
> > +		dev_err(dev, "Failed to set reset gpio name: %d\n", ret);
> > +		return ret;
> >  	}
> >  
> >  	ret = of_pci_get_max_link_speed(dev->of_node);
> > 
> > -- 
> > b4 0.10.0-dev-fc921

Thanks.

-- 
Dmitry
