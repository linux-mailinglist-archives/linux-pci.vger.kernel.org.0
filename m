Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5EC5AF7AD
	for <lists+linux-pci@lfdr.de>; Wed,  7 Sep 2022 00:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiIFWJM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 18:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiIFWJL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 18:09:11 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9229081F;
        Tue,  6 Sep 2022 15:09:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5934DCE1915;
        Tue,  6 Sep 2022 22:09:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AED5C433B5;
        Tue,  6 Sep 2022 22:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662502145;
        bh=c5W9qdT744PR+A/TstUwQ2PRhkv1q1nV5gZWREyGFKg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qT4E66S7SeeNvv7UXmEagfVquC2MqZQYFeZhaFyDnegqruyqefOwUWqwYPUwU7vWw
         vnCNTJRDHYuEWU/EKljmffnzNvyof/WXick9uhlmftI0r8XxlVvGODhk/rtFTS4xSv
         6kki4X8AhmZSpBRMABrCWZIuN8Nk4fJEzLJJk9yNE49jUg4S2wdlhhVDpT+VlZXUmc
         OKPcmuKE9rUAN89PDsyfUaxGfYl8jnBml/WBBQriN8FitEv387LFB+zHfU56N0oaWY
         gzV1e0SFNt7i6IHqwyAU8l6YL2EudK9eESohOtHyQn7MUioRsDoD02/pbotujAke5N
         7zbmbF2Kq1m1w==
Received: by pali.im (Postfix)
        id 0B277742; Wed,  7 Sep 2022 00:09:01 +0200 (CEST)
Date:   Wed, 7 Sep 2022 00:09:01 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Shawn Guo <shawn.guo@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: mvebu: switch to using gpiod API
Message-ID: <20220906220901.p2c44we7i4c35uvx@pali>
References: <20220906204301.3736813-1-dmitry.torokhov@gmail.com>
 <20220906204301.3736813-2-dmitry.torokhov@gmail.com>
 <20220906211628.6u4hbpn4shjcvqel@pali>
 <Yxe7CJnIT5AiUilL@google.com>
 <20220906214114.vj3v32dzwxz6uqik@pali>
 <YxfBKkqce/IQQLk9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YxfBKkqce/IQQLk9@google.com>
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

On Tuesday 06 September 2022 14:52:42 Dmitry Torokhov wrote:
> On Tue, Sep 06, 2022 at 11:41:14PM +0200, Pali Rohár wrote:
> > On Tuesday 06 September 2022 14:26:32 Dmitry Torokhov wrote:
> > > Hi Pali,
> > > 
> > > On Tue, Sep 06, 2022 at 11:16:28PM +0200, Pali Rohár wrote:
> > > > Hello!
> > > > 
> > > > On Tuesday 06 September 2022 13:43:01 Dmitry Torokhov wrote:
> > > > > This patch switches the driver away from legacy gpio/of_gpio API to
> > > > > gpiod API, and removes use of of_get_named_gpio_flags() which I want to
> > > > > make private to gpiolib.
> > > > 
> > > > There are many pending pci-mvebu.c patches waiting for review and merge,
> > > > so I would suggest to wait until all other mvebu patches are processed
> > > > and then process this one... longer waiting period :-(
> > > 
> > > OK, it is not super urgent. OTOH it is a very simple patch :)
> > 
> > In the worst case, I will take it into my pending list of pci-mvebu.c
> > patches, so it would not be lost. Just yesterday I collected patches and
> > created pending list:
> > https://git.kernel.org/pub/scm/linux/kernel/git/pali/linux.git/log/?h=pci-mvebu-pending
> > 
> > > > 
> > > > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > > > ---
> > > > >  drivers/pci/controller/pci-mvebu.c | 48 +++++++++---------------------
> > > > >  1 file changed, 14 insertions(+), 34 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> > > > > index 1ced73726a26..a54beb8f611c 100644
> > > > > --- a/drivers/pci/controller/pci-mvebu.c
> > > > > +++ b/drivers/pci/controller/pci-mvebu.c
> > > > > @@ -11,14 +11,13 @@
> > > > >  #include <linux/bitfield.h>
> > > > >  #include <linux/clk.h>
> > > > >  #include <linux/delay.h>
> > > > > -#include <linux/gpio.h>
> > > > > +#include <linux/gpio/consumer.h>
> > > > >  #include <linux/init.h>
> > > > >  #include <linux/mbus.h>
> > > > >  #include <linux/slab.h>
> > > > >  #include <linux/platform_device.h>
> > > > >  #include <linux/of_address.h>
> > > > >  #include <linux/of_irq.h>
> > > > > -#include <linux/of_gpio.h>
> > > > >  #include <linux/of_pci.h>
> > > > >  #include <linux/of_platform.h>
> > > > >  
> > > > > @@ -1261,9 +1260,8 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
> > > > >  	struct mvebu_pcie_port *port, struct device_node *child)
> > > > >  {
> > > > >  	struct device *dev = &pcie->pdev->dev;
> > > > > -	enum of_gpio_flags flags;
> > > > >  	u32 slot_power_limit;
> > > > > -	int reset_gpio, ret;
> > > > > +	int ret;
> > > > >  	u32 num_lanes;
> > > > >  
> > > > >  	port->pcie = pcie;
> > > > > @@ -1327,40 +1325,22 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
> > > > >  			 port->name, child);
> > > > >  	}
> > > > >  
> > > > > -	reset_gpio = of_get_named_gpio_flags(child, "reset-gpios", 0, &flags);
> > > > > -	if (reset_gpio == -EPROBE_DEFER) {
> > > > > -		ret = reset_gpio;
> > > > > +	port->reset_name = devm_kasprintf(dev, GFP_KERNEL, "%s-reset",
> > > > > +					  port->name);
> > > > > +	if (!port->reset_name) {
> > > > > +		ret = -ENOMEM;
> > > > >  		goto err;
> > > > >  	}
> > > > >  
> > > > > -	if (gpio_is_valid(reset_gpio)) {
> > > > > -		unsigned long gpio_flags;
> > > > > -
> > > > > -		port->reset_name = devm_kasprintf(dev, GFP_KERNEL, "%s-reset",
> > > > > -						  port->name);
> > > > > -		if (!port->reset_name) {
> > > > > -			ret = -ENOMEM;
> > > > > +	port->reset_gpio = devm_fwnode_gpiod_get(dev, of_fwnode_handle(child),
> > > > > +						 "reset", GPIOD_OUT_HIGH,
> > > > 
> > > > What does it mean that there is a new GPIOD_OUT_HIGH flag passed to the
> > > > devm_fwnode_gpiod_get() function?
> > > 
> > > This means that we drive the line as "active" as soon as we successfully
> > > grab GPIO. This is the same as we had with devm_gpio_request_one(), but
> > 
> > Ah :-( Another thing to fix. Driver should not change the signal line at
> > this stage, but only when it is explicitly asked - at later stage. Some
> > PCIe card do not like flipping reset line too quick. I see this fix
> 
> As far as I can see the driver has a delay of 100 usec before releasing
> reset line, plus additional delay for post-reset. Is this really not
> sufficient?

I do not know right now. Something which I planning to measure and check
after this... One point is that we do not want to sleep in kernel probe
functions for a longer time than needed as it is serialized and slow
down kernel boot. And another point is that there is still open question
how long must kernel hold reset line of endpoint card to ensure that any
connected PCIe card is properly reset... I remember from past testing
that some Qualcomm wifi ath10k cards requires at least 10ms.

> > would not be such easy as during startup we need to reset endpoint card.
> > Normally just putting it from reset, but if card was not reset state
> > prior probing driver then it is needed to first put it into reset...
> > 
> > I would fix it this issue after your patch is merged to prevent any
> > other merge conflicts.
> > 
> > How to tell devm_fwnode_gpiod_get() function that caller is not
> > interested in changing signal line? Just by changing GPIOD_OUT_HIGH to 0?
> 
> I think there are 2 options:
> 
> 1. Start with GPIOD_OUT_LOW (i.e. reset is explicitly deasserted), and
> then in powerup/powerdown you do explicit on/off transitions with proper
> timings.

PERST# is active-low. So deasserting means to put it into high state.
But device tree can specify if line is active-high as on some board
designs is GPIO output connected to inverter (or to level shifter with
additional logic of signal inversion). So what [GPIOD_]OUT_LOW means in
this context? Just it is needed that from driver point of view always
value 1 means reset active and 0 means reset inactive, independently of
double (triple?) inversions.

> 2. Start with GPIOD_ASIS (i.e. do not configure line at all), and then
> when powering up you need
> 
> 	gpiod_direction_output(port->reset_gpio, GPIOD_OUT_HIGH);
> 
> on the first invocation (and you can skip call to
> gpiod_set_value_cansleep(port->reset_gpio, 1) in that case).

This option is probably better as reset line logic is only at
appropriate place. And also this was my idea.

Anyway, in the past I wrote proposal how to cleanup and fixup it:
https://lore.kernel.org/linux-pci/20211022183808.jdeo7vntnagqkg7g@pali/

> > 
> > > we do not need to figure out actual polarity.
> > > 
> > > > 
> > > > > +						 port->name);
> > > > > +	ret = PTR_ERR_OR_ZERO(port->reset_gpio);
> > > > > +	if (ret) {
> > > > > +		if (ret	!= -ENOENT)
> > 
> > Just one check, I think that between "ret" and "!=" is TAB instead of
> > space. But I'm not sure if it was mangled by email client or of there is
> > really TAB.
> 
> Ah, indeed, sorry about that.
> 
> > 
> > > > >  			goto err;
> > > > > -		}
> > > > > -
> > > > > -		if (flags & OF_GPIO_ACTIVE_LOW) {
> > > > > -			dev_info(dev, "%pOF: reset gpio is active low\n",
> > > > > -				 child);
> > > > > -			gpio_flags = GPIOF_ACTIVE_LOW |
> > > > > -				     GPIOF_OUT_INIT_LOW;
> > > > > -		} else {
> > > > > -			gpio_flags = GPIOF_OUT_INIT_HIGH;
> > > > > -		}
> > > > > -
> > > > > -		ret = devm_gpio_request_one(dev, reset_gpio, gpio_flags,
> > > > > -					    port->reset_name);
> > > > > -		if (ret) {
> > > > > -			if (ret == -EPROBE_DEFER)
> > > > > -				goto err;
> > > > > -			goto skip;
> > > > > -		}
> > > > > -
> > > > > -		port->reset_gpio = gpio_to_desc(reset_gpio);
> > > > > +		/* reset gpio is optional */
> > > > > +		port->reset_gpio = NULL;
> > > > 
> > > > Maybe you can also release port->reset_name as it is not used at this
> > > > stage?
> > > 
> > > OK, I figured it was just a few bytes, but sure, I'll add devm_kfree().
> > > 
> > > Thanks for the review.
> > > 
> > > -- 
> > > Dmitry
> 
> -- 
> Dmitry
