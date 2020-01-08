Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13D46134DD1
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2020 21:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgAHUnd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jan 2020 15:43:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:51574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbgAHUnd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Jan 2020 15:43:33 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6E0820692;
        Wed,  8 Jan 2020 20:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578516212;
        bh=NYesMAyYE+lar+MD4dIozxGFUae0go0spw8Mv3XHHYA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AQyzvT0EbFdQDUX5OdTSxlQ/LeTUSiqF+bncIFJFnR0ejKjex7RWTp3MZS0QSHiaz
         iQoqev/IvtSk7i/aUGGuezi1mLhvhJoTuAq1smeimJFlkjhlTtenpkYdMqRFtjeM5W
         EpSkg682Sm+d6hbFXyDbbH1b7SaOCJ3HV9Y6h5A4=
Date:   Wed, 8 Jan 2020 14:43:30 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: histb: improve GPIO reset implementation
Message-ID: <20200108204330.GA203835@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107121256.16207-1-shawn.guo@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 07, 2020 at 08:12:56PM +0800, Shawn Guo wrote:
> It switches GPIO reset code to use gpio_desc, so that the code becomes
> simpler and cleaner.  Also the GPIO signal should be implemented as
> a pulse to trigger a reset, let's correct that in the meantime.

The changelog makes it sound like this is a cleanup + a bug fix.  If
so, please put them in separate patches and describe the effect of the
bug, e.g., "reset doesn't work before this fix" or whatever.

Capitalize the subject ("PCI: histb: Improve...").

> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-histb.c | 35 ++++++++++---------------
>  1 file changed, 14 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
> index 811b5c6d62ea..d47a8e6d6fa3 100644
> --- a/drivers/pci/controller/dwc/pcie-histb.c
> +++ b/drivers/pci/controller/dwc/pcie-histb.c
> @@ -60,7 +60,7 @@ struct histb_pcie {
>  	struct reset_control *sys_reset;
>  	struct reset_control *bus_reset;
>  	void __iomem *ctrl;
> -	int reset_gpio;
> +	struct gpio_desc *reset_gpio;
>  	struct regulator *vpcie;
>  };
>  
> @@ -219,9 +219,6 @@ static void histb_pcie_host_disable(struct histb_pcie *hipcie)
>  	clk_disable_unprepare(hipcie->sys_clk);
>  	clk_disable_unprepare(hipcie->bus_clk);
>  
> -	if (gpio_is_valid(hipcie->reset_gpio))
> -		gpio_set_value_cansleep(hipcie->reset_gpio, 0);
> -
>  	if (hipcie->vpcie)
>  		regulator_disable(hipcie->vpcie);
>  }
> @@ -242,9 +239,6 @@ static int histb_pcie_host_enable(struct pcie_port *pp)
>  		}
>  	}
>  
> -	if (gpio_is_valid(hipcie->reset_gpio))
> -		gpio_set_value_cansleep(hipcie->reset_gpio, 1);
> -
>  	ret = clk_prepare_enable(hipcie->bus_clk);
>  	if (ret) {
>  		dev_err(dev, "cannot prepare/enable bus clk\n");
> @@ -278,6 +272,14 @@ static int histb_pcie_host_enable(struct pcie_port *pp)
>  	reset_control_assert(hipcie->bus_reset);
>  	reset_control_deassert(hipcie->bus_reset);
>  
> +	if (hipcie->reset_gpio) {
> +		gpiod_set_value_cansleep(hipcie->reset_gpio, 1);
> +		usleep_range(100, 200);
> +		gpiod_set_value_cansleep(hipcie->reset_gpio, 0);
> +		/* wait for 1ms */
> +		usleep_range(1000, 2000);
> +	}
> +
>  	return 0;
>  
>  err_aux_clk:
> @@ -305,10 +307,7 @@ static int histb_pcie_probe(struct platform_device *pdev)
>  	struct dw_pcie *pci;
>  	struct pcie_port *pp;
>  	struct resource *res;
> -	struct device_node *np = pdev->dev.of_node;
>  	struct device *dev = &pdev->dev;
> -	enum of_gpio_flags of_flags;
> -	unsigned long flag = GPIOF_DIR_OUT;
>  	int ret;
>  
>  	hipcie = devm_kzalloc(dev, sizeof(*hipcie), GFP_KERNEL);
> @@ -345,17 +344,11 @@ static int histb_pcie_probe(struct platform_device *pdev)
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
> +						     GPIOD_OUT_LOW);
> +	if (IS_ERR(hipcie->reset_gpio)) {
> +		ret = PTR_ERR(hipcie->reset_gpio);
> +		return ret;
>  	}
>  
>  	hipcie->aux_clk = devm_clk_get(dev, "aux");
> -- 
> 2.17.1
> 
