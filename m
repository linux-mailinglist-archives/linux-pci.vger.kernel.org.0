Return-Path: <linux-pci+bounces-16601-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0019C637D
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 22:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B25091F2557B
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 21:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F6321A4AD;
	Tue, 12 Nov 2024 21:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElakLreo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D3E204930;
	Tue, 12 Nov 2024 21:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731447371; cv=none; b=d3o5nzPERcRBUzm7QXEzaUThJMPxytOcuE+reUgUDhn/0A+pFtHJJ81RIzrv0/qqkR0RaDBBTMBXfEXOIfJdSCyq3smNXw281o6/93cU9Cgc/uPVcBHYkbzQRLsfxdTPEtWpgKs4ADorB41csZ3V4w2pX1cYvZh4NVgwIul4nI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731447371; c=relaxed/simple;
	bh=YT8QiaKYc6WikadvMwOhGhXCA4jctxjY4UC9dlIgrcA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EShJxVWyaB0zaIMPJvNp+E+AhG6F1YEItRFFHT1Ok/WiGSOVMciDlpFj+aX7XCg4Crihmy12cGRwecyuOPXDDaTNuS6x4tChF20gKPU8OLKCcdXpNQqn/6SJIL+d90CvPQeIjCyeLGiWCj9MshmpddrMyE6pTT2ew6mBLFGnvzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElakLreo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18BCFC4CECD;
	Tue, 12 Nov 2024 21:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731447371;
	bh=YT8QiaKYc6WikadvMwOhGhXCA4jctxjY4UC9dlIgrcA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ElakLreoUElzFc7nu+uUsrDpPS++A0T23q9ciRXNhxC/vItSuDw56NpCqpiFxi7QK
	 vEvTsi/Pbdi8S96yxwOII1A5naDXEQ4ffh+1vyaw3dpzrkGhsNb/Gc5mDahZOpP2cZ
	 wJiVxI+shzQqIcniXTTKnr1NDwX7858vpglbmRj67KkQXYwoGke+TODCw0Gshy5FH8
	 uVlyvrTpkWdyz/ZHXIi2JytmXQ7uIGo4+V9sGOy3/rUFVBD8TSM/ezEJrn9d/G1Wra
	 d2rqYXbIpDZRPUHSUV7Zc+8/vY8bkhdq1VF7BwEfB8GYtgJFTZCsAj5lOKyDNcuwRL
	 gwF3luLnvkVTQ==
Date: Tue, 12 Nov 2024 15:36:08 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
Cc: lpieralisi@kernel.org, thomas.petazzoni@bootlin.com, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	salee@marvell.com, dingwei@marvell.com
Subject: Re: [PATCH 1/1] PCI: armada8k: add device reset to link-down handle
Message-ID: <20241112213608.GA1861480@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112070310.757856-1-jpatel2@marvell.com>

In subject, follow capitalization convention.  Use "git log
--oneline".

On Mon, Nov 11, 2024 at 11:03:10PM -0800, Jenishkumar Maheshbhai Patel wrote:
> Added pcie reset via gpio support as described in the
> designware-pcie.txt DT binding document.
> In cases link down cause still exist in device.
> The device need to be reset to reestablish the link.
> If reset-gpio pin provided in the device tree, then the linkdown
> handle resets the device before reestablishing link.

s/pcie/PCIe/
s/gpio/GPIO/

Add blank lines between paragraphs.  Rewrap to fill 75 columns.

> Signed-off-by: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
> ---
>  drivers/pci/controller/dwc/pcie-armada8k.c | 24 ++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
> index b1b48c2016f7..9a48ef60be51 100644
> --- a/drivers/pci/controller/dwc/pcie-armada8k.c
> +++ b/drivers/pci/controller/dwc/pcie-armada8k.c
> @@ -23,6 +23,7 @@
>  #include <linux/of_pci.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/regmap.h>
> +#include <linux/of_gpio.h>

Preserve (mostly) alpha sorted list of includes.

>  #include "pcie-designware.h"
>  
> @@ -37,6 +38,8 @@ struct armada8k_pcie {
>  	struct regmap *sysctrl_base;
>  	u32 mac_rest_bitmask;
>  	struct work_struct recover_link_work;
> +	enum of_gpio_flags flags;
> +	struct gpio_desc *reset_gpio;
>  };
>  
>  #define PCIE_VENDOR_REGS_OFFSET		0x8000
> @@ -238,9 +241,18 @@ static void armada8k_pcie_recover_link(struct work_struct *ws)
>  	}
>  	pci_lock_rescan_remove();
>  	pci_stop_and_remove_bus_device(root_port);
> +	/* Reset device if reset gpio is set */
> +	if (pcie->reset_gpio) {
> +		/* assert and then deassert the reset signal */
> +		gpiod_set_value_cansleep(pcie->reset_gpio, 0);
> +		msleep(100);

Needs some sort of #define for this 100 ms.

> +		gpiod_set_value_cansleep(pcie->reset_gpio,
> +					 (pcie->flags & OF_GPIO_ACTIVE_LOW) ? 0 : 1);
> +	}
>  	/*
> -	 * Sleep needed to make sure all pcie transactions and access
> -	 * are flushed before resetting the mac
> +	 * Sleep used for two reasons.
> +	 * First make sure all pcie transactions and access are flushed before resetting the mac
> +	 * and second to make sure pci device is ready in case we reset the device
>  	 */
>  	msleep(100);

s/pcie/PCIe/ (throughout)
s/mac/MAC/

Explain the 100ms.  Hopefully this is something defined by PCIe base
or CEM spec.  Use or add #define as needed.

> @@ -376,6 +388,7 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
>  	struct armada8k_pcie *pcie;
>  	struct device *dev = &pdev->dev;
>  	struct resource *base;
> +	int reset_gpio;
>  	int ret;
>  
>  	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> @@ -420,6 +433,13 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
>  		goto fail_clkreg;
>  	}
>  
> +	/* Config reset gpio for pcie if the reset connected to gpio */
> +	reset_gpio = of_get_named_gpio_flags(pdev->dev.of_node,
> +					     "reset-gpios", 0,
> +					     &pcie->flags);
> +	if (gpio_is_valid(reset_gpio))
> +		pcie->reset_gpio = gpio_to_desc(reset_gpio);
> +
>  	pcie->sysctrl_base = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
>  						       "marvell,system-controller");
>  	if (IS_ERR(pcie->sysctrl_base)) {
> -- 
> 2.25.1
> 

