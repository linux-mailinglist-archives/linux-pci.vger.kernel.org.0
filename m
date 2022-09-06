Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED945AF765
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 23:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiIFVxG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 17:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiIFVxF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 17:53:05 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38079F1AB;
        Tue,  6 Sep 2022 14:52:46 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id b144so7931961pfb.7;
        Tue, 06 Sep 2022 14:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=+Et9MmweN+DC1/7aGd3iRv+9KNgQJ+BWA4HEwqHAlqs=;
        b=QiBHtOUjW2RTg2Za00jxPBq984muY/XaqcNLY79InU3y4wb6ro84s4QynOClg0f0QP
         qiucL1QFYCItSpaBPTmQFZSU4nd6YA1EvBQB532srC72tLuKzNRRL4jXInPsXWDHcscl
         hljEDaUEKRTeug/zZ6OkPE9VCElJQ9x8e++sKK/KGFF1NNH5UyoXNDnD1n+paICY12c4
         d05ujw2OGU7E5SI1/PSvvkaZpw2HSPbA23BtSwWa4YPa3Z9ZfP1mMvd4O9iVoT3f9FbC
         9vbt8+IziM/gU9oYG6996eyvmzvTlgOqjjo6XlM26gQfPi7HcQ+Wo0TlEGWczRHlLmVJ
         j3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=+Et9MmweN+DC1/7aGd3iRv+9KNgQJ+BWA4HEwqHAlqs=;
        b=M+8N/Ds8Vi5ZIe/3n62aJh51txxl+bLlVVQgL+YoqIVvxiBRrRTvEb6RBg83Z0h4en
         pIORKKM5i1Jl2F8gDf2r7lxVM3mgr+fLWBvVh28WCUht9g3go9InQ22GF8UasQVD6oDS
         Di52mtt/TbP7SYe+qcFoeRbrQFWhddMHj4KI35nihkFVLH9Wek5NsI4QpzT2GOCtLyuS
         woSf0FF9bTo74TILJ+FXjZGzBwPb6DeBCe57QJY70am+nn2QK1VUwYwTyRVHk5EuIFbS
         CXZBar8QcwBzklgSs2qevKnz4dWdJ83clKkco6mrwCM2/3f8xLYPdCV43VEWCiB3lvtE
         LTjA==
X-Gm-Message-State: ACgBeo3+sSksqdoBQiKnTkAZtlOCViEoxYvDG6QIL2X6eNoHx7kpaRio
        nO6EStQ8bIeNCZVNP4/XJpc=
X-Google-Smtp-Source: AA6agR7wW3UJiwvQm/A/eztJY3H9HhhJrV2IFYlG1jU5x1vWymhq6I9q/rFbRPfR+VKTMIhsp5yuIA==
X-Received: by 2002:a63:d607:0:b0:427:bc0c:55c8 with SMTP id q7-20020a63d607000000b00427bc0c55c8mr615802pgg.402.1662501165814;
        Tue, 06 Sep 2022 14:52:45 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:abc4:5d24:5a73:a96b])
        by smtp.gmail.com with ESMTPSA id 205-20020a6217d6000000b00537b8deef41sm10734197pfx.136.2022.09.06.14.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 14:52:45 -0700 (PDT)
Date:   Tue, 6 Sep 2022 14:52:42 -0700
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
Message-ID: <YxfBKkqce/IQQLk9@google.com>
References: <20220906204301.3736813-1-dmitry.torokhov@gmail.com>
 <20220906204301.3736813-2-dmitry.torokhov@gmail.com>
 <20220906211628.6u4hbpn4shjcvqel@pali>
 <Yxe7CJnIT5AiUilL@google.com>
 <20220906214114.vj3v32dzwxz6uqik@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220906214114.vj3v32dzwxz6uqik@pali>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 06, 2022 at 11:41:14PM +0200, Pali Rohár wrote:
> On Tuesday 06 September 2022 14:26:32 Dmitry Torokhov wrote:
> > Hi Pali,
> > 
> > On Tue, Sep 06, 2022 at 11:16:28PM +0200, Pali Rohár wrote:
> > > Hello!
> > > 
> > > On Tuesday 06 September 2022 13:43:01 Dmitry Torokhov wrote:
> > > > This patch switches the driver away from legacy gpio/of_gpio API to
> > > > gpiod API, and removes use of of_get_named_gpio_flags() which I want to
> > > > make private to gpiolib.
> > > 
> > > There are many pending pci-mvebu.c patches waiting for review and merge,
> > > so I would suggest to wait until all other mvebu patches are processed
> > > and then process this one... longer waiting period :-(
> > 
> > OK, it is not super urgent. OTOH it is a very simple patch :)
> 
> In the worst case, I will take it into my pending list of pci-mvebu.c
> patches, so it would not be lost. Just yesterday I collected patches and
> created pending list:
> https://git.kernel.org/pub/scm/linux/kernel/git/pali/linux.git/log/?h=pci-mvebu-pending
> 
> > > 
> > > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > > ---
> > > >  drivers/pci/controller/pci-mvebu.c | 48 +++++++++---------------------
> > > >  1 file changed, 14 insertions(+), 34 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> > > > index 1ced73726a26..a54beb8f611c 100644
> > > > --- a/drivers/pci/controller/pci-mvebu.c
> > > > +++ b/drivers/pci/controller/pci-mvebu.c
> > > > @@ -11,14 +11,13 @@
> > > >  #include <linux/bitfield.h>
> > > >  #include <linux/clk.h>
> > > >  #include <linux/delay.h>
> > > > -#include <linux/gpio.h>
> > > > +#include <linux/gpio/consumer.h>
> > > >  #include <linux/init.h>
> > > >  #include <linux/mbus.h>
> > > >  #include <linux/slab.h>
> > > >  #include <linux/platform_device.h>
> > > >  #include <linux/of_address.h>
> > > >  #include <linux/of_irq.h>
> > > > -#include <linux/of_gpio.h>
> > > >  #include <linux/of_pci.h>
> > > >  #include <linux/of_platform.h>
> > > >  
> > > > @@ -1261,9 +1260,8 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
> > > >  	struct mvebu_pcie_port *port, struct device_node *child)
> > > >  {
> > > >  	struct device *dev = &pcie->pdev->dev;
> > > > -	enum of_gpio_flags flags;
> > > >  	u32 slot_power_limit;
> > > > -	int reset_gpio, ret;
> > > > +	int ret;
> > > >  	u32 num_lanes;
> > > >  
> > > >  	port->pcie = pcie;
> > > > @@ -1327,40 +1325,22 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
> > > >  			 port->name, child);
> > > >  	}
> > > >  
> > > > -	reset_gpio = of_get_named_gpio_flags(child, "reset-gpios", 0, &flags);
> > > > -	if (reset_gpio == -EPROBE_DEFER) {
> > > > -		ret = reset_gpio;
> > > > +	port->reset_name = devm_kasprintf(dev, GFP_KERNEL, "%s-reset",
> > > > +					  port->name);
> > > > +	if (!port->reset_name) {
> > > > +		ret = -ENOMEM;
> > > >  		goto err;
> > > >  	}
> > > >  
> > > > -	if (gpio_is_valid(reset_gpio)) {
> > > > -		unsigned long gpio_flags;
> > > > -
> > > > -		port->reset_name = devm_kasprintf(dev, GFP_KERNEL, "%s-reset",
> > > > -						  port->name);
> > > > -		if (!port->reset_name) {
> > > > -			ret = -ENOMEM;
> > > > +	port->reset_gpio = devm_fwnode_gpiod_get(dev, of_fwnode_handle(child),
> > > > +						 "reset", GPIOD_OUT_HIGH,
> > > 
> > > What does it mean that there is a new GPIOD_OUT_HIGH flag passed to the
> > > devm_fwnode_gpiod_get() function?
> > 
> > This means that we drive the line as "active" as soon as we successfully
> > grab GPIO. This is the same as we had with devm_gpio_request_one(), but
> 
> Ah :-( Another thing to fix. Driver should not change the signal line at
> this stage, but only when it is explicitly asked - at later stage. Some
> PCIe card do not like flipping reset line too quick. I see this fix

As far as I can see the driver has a delay of 100 usec before releasing
reset line, plus additional delay for post-reset. Is this really not
sufficient?

> would not be such easy as during startup we need to reset endpoint card.
> Normally just putting it from reset, but if card was not reset state
> prior probing driver then it is needed to first put it into reset...
> 
> I would fix it this issue after your patch is merged to prevent any
> other merge conflicts.
> 
> How to tell devm_fwnode_gpiod_get() function that caller is not
> interested in changing signal line? Just by changing GPIOD_OUT_HIGH to 0?

I think there are 2 options:

1. Start with GPIOD_OUT_LOW (i.e. reset is explicitly deasserted), and
then in powerup/powerdown you do explicit on/off transitions with proper
timings.

2. Start with GPIOD_ASIS (i.e. do not configure line at all), and then
when powering up you need

	gpiod_direction_output(port->reset_gpio, GPIOD_OUT_HIGH);

on the first invocation (and you can skip call to
gpiod_set_value_cansleep(port->reset_gpio, 1) in that case).

> 
> > we do not need to figure out actual polarity.
> > 
> > > 
> > > > +						 port->name);
> > > > +	ret = PTR_ERR_OR_ZERO(port->reset_gpio);
> > > > +	if (ret) {
> > > > +		if (ret	!= -ENOENT)
> 
> Just one check, I think that between "ret" and "!=" is TAB instead of
> space. But I'm not sure if it was mangled by email client or of there is
> really TAB.

Ah, indeed, sorry about that.

> 
> > > >  			goto err;
> > > > -		}
> > > > -
> > > > -		if (flags & OF_GPIO_ACTIVE_LOW) {
> > > > -			dev_info(dev, "%pOF: reset gpio is active low\n",
> > > > -				 child);
> > > > -			gpio_flags = GPIOF_ACTIVE_LOW |
> > > > -				     GPIOF_OUT_INIT_LOW;
> > > > -		} else {
> > > > -			gpio_flags = GPIOF_OUT_INIT_HIGH;
> > > > -		}
> > > > -
> > > > -		ret = devm_gpio_request_one(dev, reset_gpio, gpio_flags,
> > > > -					    port->reset_name);
> > > > -		if (ret) {
> > > > -			if (ret == -EPROBE_DEFER)
> > > > -				goto err;
> > > > -			goto skip;
> > > > -		}
> > > > -
> > > > -		port->reset_gpio = gpio_to_desc(reset_gpio);
> > > > +		/* reset gpio is optional */
> > > > +		port->reset_gpio = NULL;
> > > 
> > > Maybe you can also release port->reset_name as it is not used at this
> > > stage?
> > 
> > OK, I figured it was just a few bytes, but sure, I'll add devm_kfree().
> > 
> > Thanks for the review.
> > 
> > -- 
> > Dmitry

-- 
Dmitry
