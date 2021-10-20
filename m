Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C76DA434E68
	for <lists+linux-pci@lfdr.de>; Wed, 20 Oct 2021 16:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhJTPAt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Oct 2021 11:00:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:43302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229570AbhJTPAt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Oct 2021 11:00:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C3B2611EF;
        Wed, 20 Oct 2021 14:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634741914;
        bh=sp4qR7s1fV+iZP+uIu6mtMZe0a47ZjWyonweUvCQqtg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Z3mipcjJVlZSv3QT2R0Z2dfmtfo3zKUMp9cEr8u8j8uIuGEdeT0aolGBk4v/GeBV6
         OLJTK9f0YI8Q5105e1hfv4Oy0FBVln2RsQnqTwq6b0UrZnIN9cUPQqmZ8VqdIdZvHo
         4ZVCZiPpg4YXZGuZBrHdKmZxmEwxlsRq2ZnCYSGzyzhTfcZHcpT9WQdtJClVuj9iHK
         nVNf45uc+dFh72hFfNDNntdJgwtgJFY7POkCvPrPau+uzbSAJMHtmmmtmQujOAX7Fw
         Yx8vOabi926XFOH64WAuxBp3GsbOIgHrCrPdjU8ApQf8MO2/b2Ppg1FLFj9xeDxjs2
         lbph4j8yk6H5Q==
Date:   Wed, 20 Oct 2021 09:58:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
Cc:     hongxing.zhu@nxp.com, l.stach@pengutronix.de,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: imx6: Replace legacy gpio interface for gpiod
 interface
Message-ID: <20211020145833.GA2616210@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YW9bPy5IHzuROhrl@fedora>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 19, 2021 at 08:56:47PM -0300, Maíra Canal wrote:
> Considering the current transition of the GPIO subsystem, remove all
> dependencies of the legacy GPIO interface (linux/gpio.h and linux
> /of_gpio.h) and replace it with the descriptor-based GPIO approach.
> 
> Signed-off-by: Maíra Canal <maira.canal@usp.br>
> ---
> V1 -> V2: Rewrite commit log and subject line to match PCI subsystem standard

Thanks, I appreciate that! Lorenzo will take a look when it gets to
the front of his queue.

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 31 ++++++++++-----------------
>  1 file changed, 11 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 80fc98acf097..e5ee54e37d05 100644
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
> +	struct gpio_desc    *reset_gpio;
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
>  	}
>  
> @@ -1025,22 +1024,14 @@ static int imx6_pcie_probe(struct platform_device *pdev)
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
> +			imx6_pcie->gpio_active_high ?  GPIOD_OUT_HIGH :
> +				GPIOD_OUT_LOW);
> +	if (IS_ERR(imx6_pcie->reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(imx6_pcie->reset_gpio),
> +					  "unable to get reset gpio\n");
>  
>  	/* Fetch clocks */
>  	imx6_pcie->pcie_phy = devm_clk_get(dev, "pcie_phy");
> -- 
> 2.31.1
> 
