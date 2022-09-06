Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F3E5AF6BD
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 23:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiIFV0j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 17:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiIFV0i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 17:26:38 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4EDB08BE;
        Tue,  6 Sep 2022 14:26:36 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso16309091pjk.0;
        Tue, 06 Sep 2022 14:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=cY0dA7NTrnBDKCwwHO063u9MDnaKebMrdSPsmytPTS4=;
        b=Oyq1k7hEQu7PHNNqzRvhH1N/D98ZvJOMLXtyV1meo6F0ZVYOQ4qI1M8+9aFj0KDMJh
         Vo/UTpMomeF6SX8U5t4CfCferZ3isMoONuaHOhfX+gxsjOaJOVcpptAzDp/AiXn+d5jg
         2zcGf+a2WxBG67+CvJl+EuXpgC0/VN0Giv6oQPuN2ivzwvahKEbesIgEcltbZdr4NfB4
         Rgqf9sGvQANJwcLvhRtI3W61DXfE6djFhiY2NRQ5wJaqR3hm8mzvVMOZYkD6u7osLLJt
         jD6DOnLau8WdASq6H8CTIR6c2RCQfXdg2oNfbApH1UsD4EYLzrvgDDcmI/cs0CUsTk76
         lBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=cY0dA7NTrnBDKCwwHO063u9MDnaKebMrdSPsmytPTS4=;
        b=FLfGbNqwCMk3zV9giutOk9d/9GWhfOa4vLHj1bO390z3oyBh9LxaYNeaCA4VqHnb+t
         mgM+i5qIy6q9lacDCSNoe3k/qoerwWEnF9NvpzpbNKYRCPYugJ7Fe5f0tj8vqXv3Grtp
         Yrp9qSc5J4qJ/F05shxK3hDHNNq7yglsysjt7CQ6mIrcV6zs4y+3ERO6PvFnMO0ykCPr
         2p3gc+SZ1gR+yjKixkfX6HaA6PUFapmGw4k7eYplY6k3vEuC1M4AqJ6lm/a5H456TZ1D
         +yykiZ18i6HScENdYTLbXEmu5pfIrKu5b+2quc7X9weDDQUBl0LZCGmsFYS7YghI7K5d
         Dm9A==
X-Gm-Message-State: ACgBeo1R2enMlJSWo/zeHqEhVZJtDd8YFpa0ZE90XytTG/r4EkNIWrEz
        7cIVphBgvkW0HyyN2uu4oGw=
X-Google-Smtp-Source: AA6agR7jpSDz8yhWV2rYovKCfP7SO0Nd0qXv7A5NLmOWP68qSPfxBINaKNFP5S447hhXGHR/Kp+G4g==
X-Received: by 2002:a17:902:7d86:b0:170:a752:cbd1 with SMTP id a6-20020a1709027d8600b00170a752cbd1mr250537plm.17.1662499595887;
        Tue, 06 Sep 2022 14:26:35 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:abc4:5d24:5a73:a96b])
        by smtp.gmail.com with ESMTPSA id v28-20020aa799dc000000b00537ab89c66csm11137493pfi.143.2022.09.06.14.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 14:26:35 -0700 (PDT)
Date:   Tue, 6 Sep 2022 14:26:32 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
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
Message-ID: <Yxe7CJnIT5AiUilL@google.com>
References: <20220906204301.3736813-1-dmitry.torokhov@gmail.com>
 <20220906204301.3736813-2-dmitry.torokhov@gmail.com>
 <20220906211628.6u4hbpn4shjcvqel@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220906211628.6u4hbpn4shjcvqel@pali>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Pali,

On Tue, Sep 06, 2022 at 11:16:28PM +0200, Pali Rohár wrote:
> Hello!
> 
> On Tuesday 06 September 2022 13:43:01 Dmitry Torokhov wrote:
> > This patch switches the driver away from legacy gpio/of_gpio API to
> > gpiod API, and removes use of of_get_named_gpio_flags() which I want to
> > make private to gpiolib.
> 
> There are many pending pci-mvebu.c patches waiting for review and merge,
> so I would suggest to wait until all other mvebu patches are processed
> and then process this one... longer waiting period :-(

OK, it is not super urgent. OTOH it is a very simple patch :)

> 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/pci/controller/pci-mvebu.c | 48 +++++++++---------------------
> >  1 file changed, 14 insertions(+), 34 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> > index 1ced73726a26..a54beb8f611c 100644
> > --- a/drivers/pci/controller/pci-mvebu.c
> > +++ b/drivers/pci/controller/pci-mvebu.c
> > @@ -11,14 +11,13 @@
> >  #include <linux/bitfield.h>
> >  #include <linux/clk.h>
> >  #include <linux/delay.h>
> > -#include <linux/gpio.h>
> > +#include <linux/gpio/consumer.h>
> >  #include <linux/init.h>
> >  #include <linux/mbus.h>
> >  #include <linux/slab.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/of_address.h>
> >  #include <linux/of_irq.h>
> > -#include <linux/of_gpio.h>
> >  #include <linux/of_pci.h>
> >  #include <linux/of_platform.h>
> >  
> > @@ -1261,9 +1260,8 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
> >  	struct mvebu_pcie_port *port, struct device_node *child)
> >  {
> >  	struct device *dev = &pcie->pdev->dev;
> > -	enum of_gpio_flags flags;
> >  	u32 slot_power_limit;
> > -	int reset_gpio, ret;
> > +	int ret;
> >  	u32 num_lanes;
> >  
> >  	port->pcie = pcie;
> > @@ -1327,40 +1325,22 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
> >  			 port->name, child);
> >  	}
> >  
> > -	reset_gpio = of_get_named_gpio_flags(child, "reset-gpios", 0, &flags);
> > -	if (reset_gpio == -EPROBE_DEFER) {
> > -		ret = reset_gpio;
> > +	port->reset_name = devm_kasprintf(dev, GFP_KERNEL, "%s-reset",
> > +					  port->name);
> > +	if (!port->reset_name) {
> > +		ret = -ENOMEM;
> >  		goto err;
> >  	}
> >  
> > -	if (gpio_is_valid(reset_gpio)) {
> > -		unsigned long gpio_flags;
> > -
> > -		port->reset_name = devm_kasprintf(dev, GFP_KERNEL, "%s-reset",
> > -						  port->name);
> > -		if (!port->reset_name) {
> > -			ret = -ENOMEM;
> > +	port->reset_gpio = devm_fwnode_gpiod_get(dev, of_fwnode_handle(child),
> > +						 "reset", GPIOD_OUT_HIGH,
> 
> What does it mean that there is a new GPIOD_OUT_HIGH flag passed to the
> devm_fwnode_gpiod_get() function?

This means that we drive the line as "active" as soon as we successfully
grab GPIO. This is the same as we had with devm_gpio_request_one(), but
we do not need to figure out actual polarity.

> 
> > +						 port->name);
> > +	ret = PTR_ERR_OR_ZERO(port->reset_gpio);
> > +	if (ret) {
> > +		if (ret	!= -ENOENT)
> >  			goto err;
> > -		}
> > -
> > -		if (flags & OF_GPIO_ACTIVE_LOW) {
> > -			dev_info(dev, "%pOF: reset gpio is active low\n",
> > -				 child);
> > -			gpio_flags = GPIOF_ACTIVE_LOW |
> > -				     GPIOF_OUT_INIT_LOW;
> > -		} else {
> > -			gpio_flags = GPIOF_OUT_INIT_HIGH;
> > -		}
> > -
> > -		ret = devm_gpio_request_one(dev, reset_gpio, gpio_flags,
> > -					    port->reset_name);
> > -		if (ret) {
> > -			if (ret == -EPROBE_DEFER)
> > -				goto err;
> > -			goto skip;
> > -		}
> > -
> > -		port->reset_gpio = gpio_to_desc(reset_gpio);
> > +		/* reset gpio is optional */
> > +		port->reset_gpio = NULL;
> 
> Maybe you can also release port->reset_name as it is not used at this
> stage?

OK, I figured it was just a few bytes, but sure, I'll add devm_kfree().

Thanks for the review.

-- 
Dmitry
