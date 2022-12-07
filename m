Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0131C6463E0
	for <lists+linux-pci@lfdr.de>; Wed,  7 Dec 2022 23:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiLGWJF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Dec 2022 17:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLGWJE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Dec 2022 17:09:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380694E41B;
        Wed,  7 Dec 2022 14:09:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93BB2B81E65;
        Wed,  7 Dec 2022 22:08:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14FCFC433C1;
        Wed,  7 Dec 2022 22:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670450932;
        bh=CiqpI/crF3uh/C4PoPa1whlwowTYXxeodgTYpcn99UY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kghdk/Yunvzp5xwjQ3Su0WxUsNAqtZY2hrhTRM8GRfc1oO1xDoGUS1ka0d33VvMNp
         K+YiTHlO6nJZy4ntVCwkfiq5Y4ie7VN7mxyW0v/xDv0RmIe+3ZyxJ0uaWKZQgEu1fN
         /Fc2HIAAQwaMoXeh3YyS1hC4ZiP0htLZImZR1CV9cqDhWLxosikKLyBJg00ixI4hjz
         qOQc4k1pBXD52o0HZ35qK9OWxJHlAg4GBk0kru1fC5A9pOPbh8EWrK67UGDSV643pS
         uvO32MZwAM+d56FgDNhkMpj1mohmGrcp0gPV7rdc++I1LCHLitofcT32nD1VH0Wo3f
         yd0YJiLCRq2dw==
Date:   Wed, 7 Dec 2022 16:08:50 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: mvebu: switch to using gpiod API
Message-ID: <20221207220850.GA1479029@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5EAft42YiT66mVj@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 07, 2022 at 01:07:10PM -0800, Dmitry Torokhov wrote:
> This patch switches the driver away from legacy gpio/of_gpio API to
> gpiod API, and removes use of of_get_named_gpio_flags() which I want to
> make private to gpiolib.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Applied to pci/ctrl/mvebu for v6.2, thanks, Dmitry!

> ---
> 
> v3:
>  - add #include <linux/irqchip/chained_irq.h> to avoid compile errors.
>    This was previously included indirectly via linux/of_gpio.h ->
>    linux/gpio/driver.h
> 
> v2:
>  - free port->reset_name when reset GPIO is not found (Pali)
>  - remove stray tab (Pali)
> 
> This is the last user of of_get_named_gpio_flags() in the "next" tree.
> 
> Thanks!
> 
>  drivers/pci/controller/pci-mvebu.c | 51 ++++++++++--------------------
>  1 file changed, 17 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> index 73db99035c2b..600964ba174c 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -11,15 +11,15 @@
>  #include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/init.h>
>  #include <linux/irqdomain.h>
> +#include <linux/irqchip/chained_irq.h>
>  #include <linux/mbus.h>
>  #include <linux/slab.h>
>  #include <linux/platform_device.h>
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
> -#include <linux/of_gpio.h>
>  #include <linux/of_pci.h>
>  #include <linux/of_platform.h>
>  
> @@ -1262,9 +1262,8 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
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
> @@ -1328,40 +1327,24 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
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
> +						 port->name);
> +	ret = PTR_ERR_OR_ZERO(port->reset_gpio);
> +	if (ret) {
> +		if (ret != -ENOENT)
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
> +		devm_kfree(dev, port->reset_name);
> +		port->reset_name = NULL;
>  	}
>  
>  	slot_power_limit = of_pci_get_slot_power_limit(child,
> -- 
> 2.39.0.rc0.267.gcb52ba06e7-goog
> 
> 
> -- 
> Dmitry
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
