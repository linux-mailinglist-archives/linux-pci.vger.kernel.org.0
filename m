Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E28441C87
	for <lists+linux-pci@lfdr.de>; Mon,  1 Nov 2021 15:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbhKAOY3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Nov 2021 10:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbhKAOY3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Nov 2021 10:24:29 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2792C061714
        for <linux-pci@vger.kernel.org>; Mon,  1 Nov 2021 07:21:55 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1mhYC2-0001s4-WA; Mon, 01 Nov 2021 15:21:47 +0100
Message-ID: <4f1b60bab451b219c7139e2204eb5b9f462ee4e0.camel@pengutronix.de>
Subject: Re: [PATCH v2 RESEND] PCI: imx6: Replace legacy gpio interface for
 gpiod interface
From:   Lucas Stach <l.stach@pengutronix.de>
To:     =?ISO-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>,
        hongxing.zhu@nxp.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        bhelgaas@google.com, helgaas@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 01 Nov 2021 15:21:44 +0100
In-Reply-To: <YX/zlRqmxbLRnTqT@fedora>
References: <YX/zlRqmxbLRnTqT@fedora>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Montag, dem 01.11.2021 um 11:03 -0300 schrieb Maíra Canal:
> Considering the current transition of the GPIO subsystem, remove all
> dependencies of the legacy GPIO interface (linux/gpio.h and linux
> /of_gpio.h) and replace it with the descriptor-based GPIO approach.
> 
> Signed-off-by: Maíra Canal <maira.canal@usp.br>
> ---
> V1 -> V2: Rewrite commit log and subject line to match PCI subsystem standard
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 30 +++++++++------------------
>  1 file changed, 10 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 80fc98acf097..589cbd600d17 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -11,13 +11,12 @@
>  #include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/kernel.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
>  #include <linux/mfd/syscon/imx7-iomuxc-gpr.h>
>  #include <linux/module.h>
> -#include <linux/of_gpio.h>
>  #include <linux/of_device.h>
>  #include <linux/of_address.h>
>  #include <linux/pci.h>
> @@ -63,7 +62,7 @@ struct imx6_pcie_drvdata {
>  
>  struct imx6_pcie {
>  	struct dw_pcie		*pci;
> -	int			reset_gpio;
> +	struct gpio_desc	*reset_gpio;
>  	bool			gpio_active_high;
>  	struct clk		*pcie_bus;
>  	struct clk		*pcie_phy;
> @@ -526,11 +525,11 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  	usleep_range(200, 500);
>  
>  	/* Some boards don't have PCIe reset GPIO. */
> -	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
> -		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
> +	if (imx6_pcie->reset_gpio) {
> +		gpiod_set_value_cansleep(imx6_pcie->reset_gpio,
>  					imx6_pcie->gpio_active_high);
>  		msleep(100);
> -		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
> +		gpiod_set_value_cansleep(imx6_pcie->reset_gpio,
>  					!imx6_pcie->gpio_active_high);

I don't think this is correct. gpiod_set_value sets the logical line
state, so if the GPIO is specified as active-low in the DT, the real
line state will be negated. The only reason why the reset-gpio-active-
high property even exists is that old DTs might specify the wrong GPIO
polarity in the reset-gpio DT description. I think you need to use to
gpiod_set_raw_value API here to get the expected real line state even
with a broken DT description.

Regards,
Lucas

>  	}
>  
> @@ -1025,22 +1024,13 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  		return PTR_ERR(pci->dbi_base);
>  
>  	/* Fetch GPIOs */
> -	imx6_pcie->reset_gpio = of_get_named_gpio(node, "reset-gpio", 0);
>  	imx6_pcie->gpio_active_high = of_property_read_bool(node,
>  						"reset-gpio-active-high");
> -	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
> -		ret = devm_gpio_request_one(dev, imx6_pcie->reset_gpio,
> -				imx6_pcie->gpio_active_high ?
> -					GPIOF_OUT_INIT_HIGH :
> -					GPIOF_OUT_INIT_LOW,
> -				"PCIe reset");
> -		if (ret) {
> -			dev_err(dev, "unable to get reset gpio\n");
> -			return ret;
> -		}
> -	} else if (imx6_pcie->reset_gpio == -EPROBE_DEFER) {
> -		return imx6_pcie->reset_gpio;
> -	}
> +	imx6_pcie->reset_gpio = devm_gpiod_get_optional(dev, "reset",
> +			imx6_pcie->gpio_active_high ?  GPIOD_OUT_HIGH : GPIOD_OUT_LOW);
> +	if (IS_ERR(imx6_pcie->reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(imx6_pcie->reset_gpio),
> +				"unable to get reset gpio\n");
>  
>  	/* Fetch clocks */
>  	imx6_pcie->pcie_phy = devm_clk_get(dev, "pcie_phy");


