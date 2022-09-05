Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC21E5AD0BC
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 12:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237741AbiIEKxz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 06:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237659AbiIEKxq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 06:53:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0876057541;
        Mon,  5 Sep 2022 03:53:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AEC161208;
        Mon,  5 Sep 2022 10:53:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD170C43141;
        Mon,  5 Sep 2022 10:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662375225;
        bh=KnM89UV/QXbr+bD5uW61IQuouhORuL6HjctA/n6mRg0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YXsW4xMlqP5G1yqVn2Vnp7wQDcPAoNf58U0cr8myKFBfvUzkhpC+Iscqcyg5rEIhZ
         0PMTgWItYJNmw8Z400ucNJ5B0XE0lekJpX4qyetV4qePiVhpwNvYixfPDpcUp14ikB
         22T/9xIpoVj9aJjbUdIR8NPhsD59irNN093isONgtwU/IDqAU6CwhROyPAZqKJ3Ax2
         Sj/95TQsCXTmoey/B358xD1yE1qexDQ+Le/UUWfUT+rUg92OQbc5mebVHkcJj3e8vm
         1Cb0U86VmYuGN9CH7WKr97gNp1kG1ChXDQHt2IQgh1P4RW98tzTzb6AB6Z4u/ySvYP
         V7b5ELppG5LAQ==
Received: by pali.im (Postfix)
        id E35A67D7; Mon,  5 Sep 2022 12:53:41 +0200 (CEST)
Date:   Mon, 5 Sep 2022 12:53:41 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
Subject: Re: [PATCH v1 01/11] PCI: tegra: switch to using
 devm_fwnode_gpiod_get
Message-ID: <20220905105341.z2pjlpljitws3j6l@pali>
References: <20220903-gpiod_get_from_of_node-remove-v1-0-b29adfb27a6c@gmail.com>
 <20220903-gpiod_get_from_of_node-remove-v1-1-b29adfb27a6c@gmail.com>
 <20220905071902.fv4uozrsttk3mosu@pali>
 <CAHp75Vf5R03nq6JmpVcVNX9L5CwM-uOmF39oHSZFP3QJe+GExQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vf5R03nq6JmpVcVNX9L5CwM-uOmF39oHSZFP3QJe+GExQ@mail.gmail.com>
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

On Monday 05 September 2022 13:49:21 Andy Shevchenko wrote:
> On Mon, Sep 5, 2022 at 10:23 AM Pali Rohár <pali@kernel.org> wrote:
> > On Sunday 04 September 2022 23:30:53 Dmitry Torokhov wrote:
> 
> ...
> 
> > > -             rp->reset_gpio = devm_gpiod_get_from_of_node(dev, port,
> > > -                                                          "reset-gpios", 0,
> > > -                                                          GPIOD_OUT_LOW,
> > > -                                                          label);
> > > +             rp->reset_gpio = devm_fwnode_gpiod_get(dev,
> > > +                                                    of_fwnode_handle(port),
> > > +                                                    "reset",
> > > +                                                    GPIOD_OUT_LOW,
> > > +                                                    label);
> >
> > Why in pci-aardvark.c for PERST# reset-gpio you have used
> > devm_gpiod_get_optional() and here in pci-tegra.c you have used
> > devm_fwnode_gpiod_get()? I think that PERST# logic is same in both
> > drivers.
> 
> It's not the same dev and its node in this case. There is one reset
> for _all_ ports, here is the reset on _per port_ basis.

aardvark is single port controller. So it is basically same.
