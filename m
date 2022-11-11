Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EED625DCF
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 16:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbiKKPEf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 10:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234900AbiKKPDz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 10:03:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21C87F556;
        Fri, 11 Nov 2022 07:01:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA1F061FFF;
        Fri, 11 Nov 2022 15:01:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C0BC433D7;
        Fri, 11 Nov 2022 15:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668178883;
        bh=3IpjaTnl0Pjxf4MekfmGVUqIt/pNy0uUtZS+fnyoQHM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VajMEA22U/Utg14uq5jSsHUpldLMZT6ifoAgAby85B+8j8I2p5gHiuUAr5vRPPkyp
         CzgOR6e7M9/ejoSFAPFdwsr7Y3LdB8Z9Pb2uKjDQ7siJt8kq9ZfWbIsoMfUwa3U+JA
         A2wLVSTTeKNUthcPqZ6Vwksy3eJoJAqKGbdNa7n54F65vpPIQSCKSRv+hIqOYRAsn1
         vNQ1Y8myyNnK2Oty8cIND0IYa49YZ/ZJPSniRpxDHWZoCNjFq4eq9m+QZrj0YehwBx
         9TYKgpS5DuCl3giZHdUH0UR1c7sUOz2w9uFsXemYahKYP/iew+SbJHijtbtrWJWqIQ
         bQ3SGuvKt6Oyw==
Date:   Fri, 11 Nov 2022 16:01:15 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Shawn Guo <shawn.guo@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: histb: switch to using gpiod API
Message-ID: <Y25juwnlU+ujvue9@lpieralisi>
References: <20220906204301.3736813-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906204301.3736813-1-dmitry.torokhov@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 06, 2022 at 01:43:00PM -0700, Dmitry Torokhov wrote:
> This patch switches the driver away from legacy gpio/of_gpio API to
> gpiod API, and removes use of of_get_named_gpio_flags() which I want to
> make private to gpiolib.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Should I pick this up ? On patch (2/2) I am not sure we reached
a consensus - please let me know.

Thanks,
Lorenzo

> ---
>  drivers/pci/controller/dwc/pcie-histb.c | 39 ++++++++++++-------------
>  1 file changed, 19 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
> index e2b80f10030d..43c27812dd6d 100644
> --- a/drivers/pci/controller/dwc/pcie-histb.c
> +++ b/drivers/pci/controller/dwc/pcie-histb.c
> @@ -10,11 +10,11 @@
>  
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_gpio.h>
>  #include <linux/pci.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> @@ -60,7 +60,7 @@ struct histb_pcie {
>  	struct reset_control *sys_reset;
>  	struct reset_control *bus_reset;
>  	void __iomem *ctrl;
> -	int reset_gpio;
> +	struct gpio_desc *reset_gpio;
>  	struct regulator *vpcie;
>  };
>  
> @@ -212,8 +212,8 @@ static void histb_pcie_host_disable(struct histb_pcie *hipcie)
>  	clk_disable_unprepare(hipcie->sys_clk);
>  	clk_disable_unprepare(hipcie->bus_clk);
>  
> -	if (gpio_is_valid(hipcie->reset_gpio))
> -		gpio_set_value_cansleep(hipcie->reset_gpio, 0);
> +	if (hipcie->reset_gpio)
> +		gpiod_set_value_cansleep(hipcie->reset_gpio, 1);
>  
>  	if (hipcie->vpcie)
>  		regulator_disable(hipcie->vpcie);
> @@ -235,8 +235,8 @@ static int histb_pcie_host_enable(struct dw_pcie_rp *pp)
>  		}
>  	}
>  
> -	if (gpio_is_valid(hipcie->reset_gpio))
> -		gpio_set_value_cansleep(hipcie->reset_gpio, 1);
> +	if (hipcie->reset_gpio)
> +		gpiod_set_value_cansleep(hipcie->reset_gpio, 0);
>  
>  	ret = clk_prepare_enable(hipcie->bus_clk);
>  	if (ret) {
> @@ -298,10 +298,7 @@ static int histb_pcie_probe(struct platform_device *pdev)
>  	struct histb_pcie *hipcie;
>  	struct dw_pcie *pci;
>  	struct dw_pcie_rp *pp;
> -	struct device_node *np = pdev->dev.of_node;
>  	struct device *dev = &pdev->dev;
> -	enum of_gpio_flags of_flags;
> -	unsigned long flag = GPIOF_DIR_OUT;
>  	int ret;
>  
>  	hipcie = devm_kzalloc(dev, sizeof(*hipcie), GFP_KERNEL);
> @@ -336,17 +333,19 @@ static int histb_pcie_probe(struct platform_device *pdev)
>  		hipcie->vpcie = NULL;
>  	}
>  
> -	hipcie->reset_gpio = of_get_named_gpio_flags(np,
> -				"reset-gpios", 0, &of_flags);
> -	if (of_flags & OF_GPIO_ACTIVE_LOW)
> -		flag |= GPIOF_ACTIVE_LOW;
> -	if (gpio_is_valid(hipcie->reset_gpio)) {
> -		ret = devm_gpio_request_one(dev, hipcie->reset_gpio,
> -				flag, "PCIe device power control");
> -		if (ret) {
> -			dev_err(dev, "unable to request gpio\n");
> -			return ret;
> -		}
> +	hipcie->reset_gpio = devm_gpiod_get_optional(dev, "reset",
> +						     GPIOD_OUT_HIGH);
> +	ret = PTR_ERR_OR_ZERO(hipcie->reset_gpio);
> +	if (ret) {
> +		dev_err(dev, "unable to request reset gpio: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = gpiod_set_consumer_name(hipcie->reset_gpio,
> +				      "PCIe device power control");
> +	if (ret) {
> +		dev_err(dev, "unable to set reset gpio name: %d\n", ret);
> +		return ret;
>  	}
>  
>  	hipcie->aux_clk = devm_clk_get(dev, "aux");
> -- 
> 2.37.2.789.g6183377224-goog
> 
