Return-Path: <linux-pci+bounces-16518-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABE49C523B
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 10:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DAB51F220CA
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 09:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0140B20E013;
	Tue, 12 Nov 2024 09:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="kPHXM9GX"
X-Original-To: linux-pci@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7DF20D4F4;
	Tue, 12 Nov 2024 09:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731404456; cv=none; b=PihhcnKPkb6zwbywVwp/03+oIn1LqTSVf8Nz1IvJnvJPmMI1wu/98DZOWuMWDi6gRoL3eP7p2iWnlmeSc7OaD5zEfrnMV0QBt1dksLsQFHjvYY9S791sOoLQXilNLZGS+4um7pGTUWGAkWAr6rNUeXLtwrhDEB8G1aLKH5jyJJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731404456; c=relaxed/simple;
	bh=NXriVagQ0yrjgcrlGD1x8haugZBG9rXpwaNoXOSMM+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AU7ftepeC3ULLyz/Cw8j9JV7CxEt/wbF3jJoGmrYXgZaIWRj0u3Ed0QhxuupWHn4hDj/7McTDkB+A4RD2UTc8QUWjqjSsZ4lNtJN2/WErZ5TtofCpO9CGd1ocIfaW7uhtcT6SlMNScoF2KQM7JHNVWdInxEjmPOCGNjt92U3lLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=kPHXM9GX; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zRK4dwC2pj8x4oVLThLt6Q7pXDWIdqXmbFkswTXuyXQ=; b=kPHXM9GXG96w7IN0GlLAObo5lV
	1QxeaPf++7UefKmxBpPnEpLAqQRuJinzjST0By27abht9f83scNlYMNROnKbSrvn7L2hE7FvXXP2e
	z/ex5HCrEDmHwEthspY5FYW5+bKz9C4RcYy61cdClki+DJPerd9SELs1xNW5EkI+gR5JsB6CN8EK4
	AJaWYdBe4GRLaSyrlZJdbRKaU9kGRkQkd5bHVQeL4Ar2hFSQBbNQ4KjgzVUVce7rjIpEHaCif5R7j
	0VwDIWC00Y+V8qfPZP9C+b9cMFuk9W+XtepOdXtmDJXokvAhRp71FJQa+dXEUnD2TiOGgkCI6lH51
	uKTrvLAA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38390)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tAnO9-0003qe-2d;
	Tue, 12 Nov 2024 09:40:46 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tAnO6-0007MY-39;
	Tue, 12 Nov 2024 09:40:42 +0000
Date: Tue, 12 Nov 2024 09:40:42 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
Cc: lpieralisi@kernel.org, thomas.petazzoni@bootlin.com, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	salee@marvell.com, dingwei@marvell.com
Subject: Re: [PATCH 1/1] PCI: armada8k: add device reset to link-down handle
Message-ID: <ZzMimiRUAV6ecx1s@shell.armlinux.org.uk>
References: <20241112070310.757856-1-jpatel2@marvell.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112070310.757856-1-jpatel2@marvell.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Nov 11, 2024 at 11:03:10PM -0800, Jenishkumar Maheshbhai Patel wrote:
> diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
> index b1b48c2016f7..9a48ef60be51 100644
> --- a/drivers/pci/controller/dwc/pcie-armada8k.c
> +++ b/drivers/pci/controller/dwc/pcie-armada8k.c
> @@ -23,6 +23,7 @@
>  #include <linux/of_pci.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/regmap.h>
> +#include <linux/of_gpio.h>
>  
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
> +		gpiod_set_value_cansleep(pcie->reset_gpio,
> +					 (pcie->flags & OF_GPIO_ACTIVE_LOW) ? 0 : 1);

This looks wrong. resets are normally active-low.
gpiod_set_value_cansleep() should be called with '1' to indicate active
state, and '0' to indicate de-active state. DT should specify whether
the signal is active high or active low.

> +	/* Config reset gpio for pcie if the reset connected to gpio */
> +	reset_gpio = of_get_named_gpio_flags(pdev->dev.of_node,
> +					     "reset-gpios", 0,
> +					     &pcie->flags);
> +	if (gpio_is_valid(reset_gpio))
> +		pcie->reset_gpio = gpio_to_desc(reset_gpio);
> +

Just use devm_fwnode_gpiod_get() here, which will also handle the
cleanup.

To see how this should be done, look at
drivers/pci/controller/pci-mvebu.c which gets the polarity settings
correct too, as mentioned above.

Lastly, as this patch is related to the breaking DT change, it
_should_ have been sent as a patch series (which means the same
Cc list on each patch) so that reviewers can see the full story
and comments on the other patches.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

