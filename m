Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE937433F68
	for <lists+linux-pci@lfdr.de>; Tue, 19 Oct 2021 21:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhJSTsC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Oct 2021 15:48:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230147AbhJSTsA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Oct 2021 15:48:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F58960F02;
        Tue, 19 Oct 2021 19:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634672747;
        bh=Kt0AlgCnA2CCkwUWkmwrgijsbjnxUNTjrXExJc4067Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZQ2ekrgapNYGiJEhyAne+AuIDwhvbAlMAdhgFNLyAcyHb4zqKBZ9TUWsGniOYrPMB
         tqpeouJPddT5+T8S1zm2cOnM1snf4/Ij9wY/Y1QqZUJKuljJu4qNJlum5HNtml0Oiq
         r5Z8hch+Ts8uGkRWL6hGdyys/9NtHtk9H9oioQWqOKPVeReHIMCVSKUv/IAzUO5xbC
         DsJiN6+H0fLjgYEsVVEUFiDdoOJeLU0x4DDzm5yqDrXo1tLQl4cKYFrl+lkXJIaEsf
         6lfLoQsD4NCvqZsS2Clyt0UzN9A3TTigGOjVQ0cA2NdthrmMOzubrqPAc0NWQomrAI
         gyP0pRRBc5tFQ==
Date:   Tue, 19 Oct 2021 14:45:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
Cc:     hongxing.zhu@nxp.com, l.stach@pengutronix.de,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci-imx6: replacing legacy gpio interface for gpiod
Message-ID: <20211019194545.GA2393463@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YW7jvR/2jpAwSpvd@fedora>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[fixed "linux-pci@vger.kernel.org" in cc]

On Tue, Oct 19, 2021 at 12:26:53PM -0300, Maíra Canal wrote:
> Removing all dependencies of linux/gpio.h and linux/of_gpio.h and replacing
> it with linux/gpio/consumer.h

Run "git log --oneline drivers/pci/controller/dwc/pci-imx6.c" and make
your subject line match -- capitalization, sentence structure, etc.

Write commit log in imperative mood, i.e., "Remove" instead of
"Removing": https://chris.beams.io/posts/git-commit/

The commit log mentions the trivial part but omits the important part
(converting from gpio to gpiod model).

> Signed-off-by: Maíra Canal <maira.canal@usp.br>
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
