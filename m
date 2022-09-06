Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442D65AF6AF
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 23:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiIFVQe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 17:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiIFVQd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 17:16:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA69B6038;
        Tue,  6 Sep 2022 14:16:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABE6F616DC;
        Tue,  6 Sep 2022 21:16:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB8FC433C1;
        Tue,  6 Sep 2022 21:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662498992;
        bh=sVuWZnqLoj4l9MNbzmsDD+UtWcj257PSVSx0lB6fMZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ovTGqYhiT0B8njP05KAmUT2IN18ttiBJOQhf8050EZfwdy5NglPFiPs9CZ7unFnlr
         WgUOeLWE6YxW3pPPp6qQ8HVdz4UPcOip9Q3uFLOVJumiC+o5TeyHq/EHc4VosUymkD
         989b37rUbFs0+Udx/F22XflLKT4tGE1uXKoqBuDXbPPReKpn8gGQKFSSHA3jTIk7E6
         k8w6XqEHgp3d7luKSnn0TItLiq1SznTpMGkviHEKW7Y+T+4qx3EYqmIBxVi8Q2fFAY
         AT25+4b3Ua05d1M3FEKQomRgU5SVwM9agc64GzEk3zB0E5OtKDeX5njy6X25ZJZik9
         TFDFOUCzjL2Ng==
Received: by pali.im (Postfix)
        id 90E7D72C; Tue,  6 Sep 2022 23:16:28 +0200 (CEST)
Date:   Tue, 6 Sep 2022 23:16:28 +0200
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
Message-ID: <20220906211628.6u4hbpn4shjcvqel@pali>
References: <20220906204301.3736813-1-dmitry.torokhov@gmail.com>
 <20220906204301.3736813-2-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906204301.3736813-2-dmitry.torokhov@gmail.com>
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

Hello!

On Tuesday 06 September 2022 13:43:01 Dmitry Torokhov wrote:
> This patch switches the driver away from legacy gpio/of_gpio API to
> gpiod API, and removes use of of_get_named_gpio_flags() which I want to
> make private to gpiolib.

There are many pending pci-mvebu.c patches waiting for review and merge,
so I would suggest to wait until all other mvebu patches are processed
and then process this one... longer waiting period :-(

> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/pci/controller/pci-mvebu.c | 48 +++++++++---------------------
>  1 file changed, 14 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> index 1ced73726a26..a54beb8f611c 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -11,14 +11,13 @@
>  #include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/init.h>
>  #include <linux/mbus.h>
>  #include <linux/slab.h>
>  #include <linux/platform_device.h>
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
> -#include <linux/of_gpio.h>
>  #include <linux/of_pci.h>
>  #include <linux/of_platform.h>
>  
> @@ -1261,9 +1260,8 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
>  	struct mvebu_pcie_port *port, struct device_node *child)
>  {
>  	struct device *dev = &pcie->pdev->dev;
> -	enum of_gpio_flags flags;
>  	u32 slot_power_limit;
> -	int reset_gpio, ret;
> +	int ret;
>  	u32 num_lanes;
>  
>  	port->pcie = pcie;
> @@ -1327,40 +1325,22 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
>  			 port->name, child);
>  	}
>  
> -	reset_gpio = of_get_named_gpio_flags(child, "reset-gpios", 0, &flags);
> -	if (reset_gpio == -EPROBE_DEFER) {
> -		ret = reset_gpio;
> +	port->reset_name = devm_kasprintf(dev, GFP_KERNEL, "%s-reset",
> +					  port->name);
> +	if (!port->reset_name) {
> +		ret = -ENOMEM;
>  		goto err;
>  	}
>  
> -	if (gpio_is_valid(reset_gpio)) {
> -		unsigned long gpio_flags;
> -
> -		port->reset_name = devm_kasprintf(dev, GFP_KERNEL, "%s-reset",
> -						  port->name);
> -		if (!port->reset_name) {
> -			ret = -ENOMEM;
> +	port->reset_gpio = devm_fwnode_gpiod_get(dev, of_fwnode_handle(child),
> +						 "reset", GPIOD_OUT_HIGH,

What does it mean that there is a new GPIOD_OUT_HIGH flag passed to the
devm_fwnode_gpiod_get() function?

> +						 port->name);
> +	ret = PTR_ERR_OR_ZERO(port->reset_gpio);
> +	if (ret) {
> +		if (ret	!= -ENOENT)
>  			goto err;
> -		}
> -
> -		if (flags & OF_GPIO_ACTIVE_LOW) {
> -			dev_info(dev, "%pOF: reset gpio is active low\n",
> -				 child);
> -			gpio_flags = GPIOF_ACTIVE_LOW |
> -				     GPIOF_OUT_INIT_LOW;
> -		} else {
> -			gpio_flags = GPIOF_OUT_INIT_HIGH;
> -		}
> -
> -		ret = devm_gpio_request_one(dev, reset_gpio, gpio_flags,
> -					    port->reset_name);
> -		if (ret) {
> -			if (ret == -EPROBE_DEFER)
> -				goto err;
> -			goto skip;
> -		}
> -
> -		port->reset_gpio = gpio_to_desc(reset_gpio);
> +		/* reset gpio is optional */
> +		port->reset_gpio = NULL;

Maybe you can also release port->reset_name as it is not used at this
stage?

>  	}
>  
>  	slot_power_limit = of_pci_get_slot_power_limit(child,
> -- 
> 2.37.2.789.g6183377224-goog
> 
