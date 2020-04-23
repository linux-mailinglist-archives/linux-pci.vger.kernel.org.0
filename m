Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD061B63E4
	for <lists+linux-pci@lfdr.de>; Thu, 23 Apr 2020 20:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbgDWSly (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Apr 2020 14:41:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:32962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730056AbgDWSly (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Apr 2020 14:41:54 -0400
Received: from localhost (mobile-166-175-187-210.mycingular.net [166.175.187.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90E96205C9;
        Thu, 23 Apr 2020 18:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587667313;
        bh=RcvFhwo+iTQ+j1jd5GXxYkxy/29au0MbVxNhWBfkFeI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OouVI9OPpLgZiYEwgVi1fKogZ7UWnX29DFiUxYL1oijPSSIdZ/rrUG4JunXcOJcdM
         XP78J8pX3qlSB4AHkkl4kADZGv96Mm0wl6rbvbeOBnPmgPddAbqv5RFAxqhQ7arhl8
         HaBTu/AKDD8dF04EP9tLFV+NS9SFVkkgX4KkGmgk=
Date:   Thu, 23 Apr 2020 13:41:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
Cc:     linux-pci@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 4/9] PCI: aardvark: issue PERST via GPIO
Message-ID: <20200423184151.GA202247@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200421111701.17088-5-marek.behun@nic.cz>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rob]

On Tue, Apr 21, 2020 at 01:16:56PM +0200, Marek Behún wrote:
> From: Pali Rohár <pali@kernel.org>
> 
> Add support for issuing PERST via GPIO specified in 'reset-gpios'
> property (as described in PCI device tree bindings).
> 
> Some buggy cards (e.g. Compex WLE900VX or WLE1216) are not detected
> after reboot when PERST is not issued during driver initialization.

Does this slot support hotplug?  If so, I don't think this fix will
help the hot-add case, will it?

> Tested on Turris MOX.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  drivers/pci/controller/pci-aardvark.c | 32 +++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index 606bae1e7a88..e2d18094d8ca 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -9,6 +9,7 @@
>   */
>  
>  #include <linux/delay.h>
> +#include <linux/gpio.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/irqdomain.h>
> @@ -18,6 +19,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/msi.h>
>  #include <linux/of_address.h>
> +#include <linux/of_gpio.h>
>  #include <linux/of_pci.h>
>  
>  #include "../pci.h"
> @@ -204,6 +206,7 @@ struct advk_pcie {
>  	int root_bus_nr;
>  	int link_gen;
>  	struct pci_bridge_emul bridge;
> +	struct gpio_desc *reset_gpio;
>  };
>  
>  static inline void advk_writel(struct advk_pcie *pcie, u32 val, u64 reg)
> @@ -329,10 +332,23 @@ static void advk_pcie_train_link(struct advk_pcie *pcie)
>  	dev_err(dev, "link never came up\n");
>  }
>  
> +static void advk_pcie_issue_perst(struct advk_pcie *pcie)
> +{
> +	if (!pcie->reset_gpio)
> +		return;
> +
> +	dev_info(&pcie->pdev->dev, "issuing PERST via reset GPIO for 1ms\n");
> +	gpiod_set_value_cansleep(pcie->reset_gpio, 1);
> +	usleep_range(1000, 2000);
> +	gpiod_set_value_cansleep(pcie->reset_gpio, 0);
> +}
> +
>  static void advk_pcie_setup_hw(struct advk_pcie *pcie)
>  {
>  	u32 reg;
>  
> +	advk_pcie_issue_perst(pcie);
> +
>  	/* Set to Direct mode */
>  	reg = advk_readl(pcie, CTRL_CONFIG_REG);
>  	reg &= ~(CTRL_MODE_MASK << CTRL_MODE_SHIFT);
> @@ -1045,6 +1061,22 @@ static int advk_pcie_probe(struct platform_device *pdev)
>  	}
>  	pcie->root_bus_nr = bus->start;
>  
> +	pcie->reset_gpio = devm_gpiod_get_from_of_node(dev, dev->of_node,
> +						       "reset-gpios", 0,
> +						       GPIOD_OUT_LOW,
> +						       "pcie1-reset");
> +	ret = PTR_ERR_OR_ZERO(pcie->reset_gpio);
> +	if (ret) {
> +		if (ret == -ENOENT) {
> +			pcie->reset_gpio = NULL;
> +		} else {
> +			if (ret != -EPROBE_DEFER)
> +				dev_err(dev, "Failed to get reset-gpio: %i\n",
> +					ret);
> +			return ret;
> +		}
> +	}
> +
>  	pcie->link_gen = of_pci_get_max_link_speed(dev->of_node);
>  	if (pcie->link_gen < 1 || pcie->link_gen > 2)
>  		pcie->link_gen = 2;
> -- 
> 2.24.1
> 
