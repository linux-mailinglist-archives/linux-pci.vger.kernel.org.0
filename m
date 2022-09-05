Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7685ADBD0
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 01:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbiIEXSw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 19:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiIEXSv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 19:18:51 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3A757240;
        Mon,  5 Sep 2022 16:18:50 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id io18so928989plb.10;
        Mon, 05 Sep 2022 16:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=/jqGrlOkEmBNjfkgs8nQW3ROS8ZrNR4/ALxdUn5IrPk=;
        b=ilcjNtA9e+sPl0lsYgQkDwLCllTb2CiNUB5lHZ6JeNqUXFPhLppke4bm+tXK6piFK1
         OXX3EAUgJSmDrfpfXWx/gxfIHEm2Ll5i3Co8kZmFkD+xJ+3h2g4/t3iiwcCHTb2nJzBQ
         lbOD/k+fLbzcC8HBgysilDjSnQ1ZbXkHWL+70V9Wt9ed7HVcmNaLtsVWn3S7QudoyNrm
         Tq2TeNuUosg71GwV6fxG+rz0aEcyELSi2RShJByRv/vyFIdszNuT6j8i8+cZEV+vX59E
         NXtPK9gzYwxXVVePAldhDwWgJuboRZn5lOgdBc1/dRtrt2Cv4uHi9z8kuWuYzv1zT79p
         tLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/jqGrlOkEmBNjfkgs8nQW3ROS8ZrNR4/ALxdUn5IrPk=;
        b=ySBRpTA1b6JusI8Kf1A1FM6IEFoTWFhZY6G5kgeFcRL7UBeDHQJJcFX8c9MmJcs2kd
         dSkOG1uotE8lKE44mHr1JobvKEr0u/m8ZNXUBskC1TfgkC8VKh8ceuZyfPPLeRj3MF17
         8XSOoGmhyybrNAweazD7FCxelViI9mzWO1jrSTYqoUNypXGWBUBCRFZkl3ExUM5FFqA1
         Wpg9JFKoKUF1oLOnp+kzesv9MkrfP/VNDlXRZA3OxvSEOCyoF1HlQuFTkRcZTRmm/U16
         88EuCxt/kD77VUficdHX24T0DixriJNgl/kwpTig5tUNRm3U/1Cte7OV3Ct2ieo35o0x
         nHEw==
X-Gm-Message-State: ACgBeo03OzI0xUivlsh0Kb1bJ2FuarEpn2M5sWHlgIvk2CEIK240Ajoa
        VbN87eYRl+F0cLYnZPCEcZU=
X-Google-Smtp-Source: AA6agR7SONkgr8pjyY4NZ8VXkSKoPY330/BgoAO00Ts+AQQkwdonx5V0WIHgyPBEPyBYuNfJLCJm0Q==
X-Received: by 2002:a17:903:186:b0:176:6615:cb8d with SMTP id z6-20020a170903018600b001766615cb8dmr19721305plg.135.1662419929430;
        Mon, 05 Sep 2022 16:18:49 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:1190:fbfa:ae95:111c])
        by smtp.gmail.com with ESMTPSA id 5-20020a17090a190500b001fe444b2245sm7375447pjg.25.2022.09.05.16.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 16:18:48 -0700 (PDT)
Date:   Mon, 5 Sep 2022 16:18:44 -0700
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
Message-ID: <YxaD1Luja4T/osP5@google.com>
References: <20220903-gpiod_get_from_of_node-remove-v1-0-b29adfb27a6c@gmail.com>
 <20220903-gpiod_get_from_of_node-remove-v1-6-b29adfb27a6c@gmail.com>
 <20220905070046.46nlhczkck2ufr4x@pali>
 <YxZ+PSDRYZnVKfFO@google.com>
 <20220905231010.ojl4i4ph27qtebiy@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220905231010.ojl4i4ph27qtebiy@pali>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 06, 2022 at 01:10:10AM +0200, Pali Rohár wrote:
> On Monday 05 September 2022 15:54:53 Dmitry Torokhov wrote:
> > On Mon, Sep 05, 2022 at 09:00:46AM +0200, Pali Rohár wrote:
> > > On Sunday 04 September 2022 23:30:58 Dmitry Torokhov wrote:
> > > > I would like to stop exporting OF-specific devm_gpiod_get_from_of_node()
> > > > so that gpiolib can be cleaned a bit, so let's switch to the generic
> > > > device property API.
> > > > 
> > > > I believe that the only reason the driver, instead of the standard
> > > > devm_gpiod_get_optional(), used devm_gpiod_get_from_of_node() is
> > > > because it wanted to set up a pretty consumer name for the GPIO,
> > > 
> > > IIRC consumer name is not used at all.
> > > 
> > > The reason was to specify full name of DTS property, for easier
> > > identification of the code. DTS property is "reset-gpios" but API
> > > specify only "reset".
> > 
> > I see. Do you want me to reset the patch with updated desctiption as to
> > the reason devm_gpiod_get_from_of_node() was used?
> 
> I think it is fine. So add my:
> 
> Acked-by: Pali Rohár <pali@kernel.org>
> 
> Anyway as another improvement for future I would suggest some API
> function with _optional_ logic, so it could be used for more PCIe

I think we need to see how many are attaching reset lines to subnodes.
If there are multiple then I agree we could add _optional. So far I see:

dtor@dtor-ws:~/kernel/linux-next (gpiod_get_from_of_node-remove)$ git grep '"reset"' -- drivers/pci/controller/
drivers/pci/controller/cadence/pci-j721e.c:             gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
drivers/pci/controller/dwc/pci-keystone.c:      gpiod = devm_gpiod_get_optional(dev, "reset",
drivers/pci/controller/dwc/pci-meson.c: mp->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
drivers/pci/controller/dwc/pcie-dw-rockchip.c:  rockchip->rst_gpio = devm_gpiod_get_optional(&pdev->dev, "reset",
drivers/pci/controller/dwc/pcie-fu740.c:        afp->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
drivers/pci/controller/dwc/pcie-intel-gw.c:     pcie->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
drivers/pci/controller/dwc/pcie-keembay.c:      pcie->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
drivers/pci/controller/dwc/pcie-qcom-ep.c:      pcie_ep->reset = devm_gpiod_get(dev, "reset", GPIOD_IN);
drivers/pci/controller/dwc/pcie-tegra194.c:     pcie->pex_rst_gpiod = devm_gpiod_get(pcie->dev, "reset", GPIOD_IN);
drivers/pci/controller/pci-aardvark.c:  pcie->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
drivers/pci/controller/pci-tegra.c:                                                    "reset",
drivers/pci/controller/pcie-apple.c:                                   "reset", 0, GPIOD_OUT_LOW, "PERST#");
drivers/pci/controller/pcie-mt7621.c:   port->gpio_rst = devm_gpiod_get_index_optional(dev, "reset", slot,

So majority have reset lines attached to the "main" node and thus can use
devm_gpiod_get_optional().

Thanks.

-- 
Dmitry
