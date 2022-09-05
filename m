Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4523B5ADBBD
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 01:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbiIEXK3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 19:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbiIEXKW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 19:10:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E68183B3;
        Mon,  5 Sep 2022 16:10:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1525B815E6;
        Mon,  5 Sep 2022 23:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 323CBC433D7;
        Mon,  5 Sep 2022 23:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662419413;
        bh=QhxqwrmKqk3hcDpE+kAWZJMWXWXiMx7OLmYa5+ea15I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cRSoeEfIVpvF6cCwlub3pnSJQf8zKCY4aEUPtHMtOkNaxfZe1+RUfK+stOROQ5pnl
         7FbU956qU800+Jb6U6hwdOBoxO4x2FzlbVVVUaZEp0hQquPlSpxbMl7gPJHmGlip/q
         WXeDk2lh/TK49oBj/AAQP6Dst1Z5bl84IrLyRgMJAafIN0kMLxsIsEAjQNvYyihGG9
         h4xRjXdkiTaHf2hIJ2Yatpca7TxPs6KBGxO+xPjerqLTUmJvu4k28lZ30772rihPEH
         I7n720bv3M7ihVFZNddbLANnIMiG1BrKlgvb+eKgjpWzR8KT6CpP2IYFa+iRtTPNF6
         YocV+oaaQMIFA==
Received: by pali.im (Postfix)
        id 400A37D7; Tue,  6 Sep 2022 01:10:10 +0200 (CEST)
Date:   Tue, 6 Sep 2022 01:10:10 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
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
Message-ID: <20220905231010.ojl4i4ph27qtebiy@pali>
References: <20220903-gpiod_get_from_of_node-remove-v1-0-b29adfb27a6c@gmail.com>
 <20220903-gpiod_get_from_of_node-remove-v1-6-b29adfb27a6c@gmail.com>
 <20220905070046.46nlhczkck2ufr4x@pali>
 <YxZ+PSDRYZnVKfFO@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YxZ+PSDRYZnVKfFO@google.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday 05 September 2022 15:54:53 Dmitry Torokhov wrote:
> On Mon, Sep 05, 2022 at 09:00:46AM +0200, Pali Rohár wrote:
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
> > 
> > The reason was to specify full name of DTS property, for easier
> > identification of the code. DTS property is "reset-gpios" but API
> > specify only "reset".
> 
> I see. Do you want me to reset the patch with updated desctiption as to
> the reason devm_gpiod_get_from_of_node() was used?

I think it is fine. So add my:

Acked-by: Pali Rohár <pali@kernel.org>

Anyway as another improvement for future I would suggest some API
function with _optional_ logic, so it could be used for more PCIe
controller drivers (e.g. also tegra) without need to reimplement
-ENOENT handling. It is really strange if for acquiring same PERST#
line via GPIO ("reset-gpios" DT property) are used more API functions
in different PCIe drivers.

> > 
> > > and we now have a special API for that.
> > > 
> > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > 
> > > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > > index 4834198cc86b..4a8a4a8522cb 100644
> > > --- a/drivers/pci/controller/pci-aardvark.c
> > > +++ b/drivers/pci/controller/pci-aardvark.c
> > > @@ -1856,20 +1856,19 @@ static int advk_pcie_probe(struct platform_device *pdev)
> > >  		return ret;
> > >  	}
> > >  
> > > -	pcie->reset_gpio = devm_gpiod_get_from_of_node(dev, dev->of_node,
> > > -						       "reset-gpios", 0,
> > > -						       GPIOD_OUT_LOW,
> > > -						       "pcie1-reset");
> > > +	pcie->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> > >  	ret = PTR_ERR_OR_ZERO(pcie->reset_gpio);
> > >  	if (ret) {
> > > -		if (ret == -ENOENT) {
> > > -			pcie->reset_gpio = NULL;
> > > -		} else {
> > > -			if (ret != -EPROBE_DEFER)
> > > -				dev_err(dev, "Failed to get reset-gpio: %i\n",
> > > -					ret);
> > > -			return ret;
> > > -		}
> > > +		if (ret != -EPROBE_DEFER)
> > > +			dev_err(dev, "Failed to get reset-gpio: %i\n",
> > > +				ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	ret = gpiod_set_consumer_name(pcie->reset_gpio, "pcie1-reset");
> > > +	if (ret) {
> > > +		dev_err(dev, "Failed to set reset gpio name: %d\n", ret);
> > > +		return ret;
> > >  	}
> > >  
> > >  	ret = of_pci_get_max_link_speed(dev->of_node);
> > > 
> > > -- 
> > > b4 0.10.0-dev-fc921
> 
> Thanks.
> 
> -- 
> Dmitry
