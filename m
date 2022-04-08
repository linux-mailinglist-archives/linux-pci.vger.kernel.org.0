Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEC94F97F3
	for <lists+linux-pci@lfdr.de>; Fri,  8 Apr 2022 16:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236841AbiDHOZp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Apr 2022 10:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbiDHOZo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Apr 2022 10:25:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 21EEDAE52;
        Fri,  8 Apr 2022 07:23:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D473C113E;
        Fri,  8 Apr 2022 07:23:40 -0700 (PDT)
Received: from lpieralisi (unknown [10.57.11.200])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 065833F73B;
        Fri,  8 Apr 2022 07:23:37 -0700 (PDT)
Date:   Fri, 8 Apr 2022 15:23:39 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>,
        l.stach@pengutronix.de
Cc:     hongxing.zhu@nxp.com, robh@kernel.org, bhelgaas@google.com,
        helgaas@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: imx6: Replace legacy gpio interface for gpiod
 interface
Message-ID: <YlBFa46v5NtWxGLt@lpieralisi>
References: <YYCOTx68LXu1Tn1i@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YYCOTx68LXu1Tn1i@fedora>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 01, 2021 at 10:03:11PM -0300, Maíra Canal wrote:
> Considering the current transition of the GPIO subsystem, remove all
> dependencies of the legacy GPIO interface (linux/gpio.h and linux
> /of_gpio.h) and replace it with the descriptor-based GPIO approach.
> 
> Signed-off-by: Maíra Canal <maira.canal@usp.br>
> ---
> V1 -> V2: Rewrite commit log and subject line to match PCI subsystem standard
> V2 -> v3: Change gpiod_set_value_cansleep for gpiod_set_raw_value_cansleep
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 30 +++++++++------------------
>  1 file changed, 10 insertions(+), 20 deletions(-)

Maira, Lucas,

what's this patch status ? Please let me know.

Thanks,
Lorenzo

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 80fc98acf097..f08865ac0b40 100644
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
> +		gpiod_set_raw_value_cansleep(imx6_pcie->reset_gpio,
>  					imx6_pcie->gpio_active_high);
>  		msleep(100);
> -		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
> +		gpiod_set_raw_value_cansleep(imx6_pcie->reset_gpio,
>  					!imx6_pcie->gpio_active_high);
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
> -- 
> 2.31.1
> 
