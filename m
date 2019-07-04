Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B03E25FA4D
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2019 16:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfGDOsc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Jul 2019 10:48:32 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:5731 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727345AbfGDOsc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Jul 2019 10:48:32 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d1e11c20000>; Thu, 04 Jul 2019 07:48:34 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 04 Jul 2019 07:48:30 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 04 Jul 2019 07:48:30 -0700
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Jul
 2019 14:48:27 +0000
Subject: Re: [PATCH V6 26/27] PCI: tegra: Add support for GPIO based PERST#
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <lorenzo.pieralisi@arm.com>, <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20190618180206.4908-1-mmaddireddy@nvidia.com>
 <20190618180206.4908-27-mmaddireddy@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <a4ddd0a3-f0b4-23de-fb0e-91a417d20362@nvidia.com>
Date:   Thu, 4 Jul 2019 15:48:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190618180206.4908-27-mmaddireddy@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1562251714; bh=cG4zcDQijcebW1bCHiUojwr/G/YHen9uYPlSOLisbAU=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=T4PPCTPCEBCeUuifSI8z5hnNsJP2XP55T3rYCjLrKZ9PmGXq+rdX0xDzxAoRc+PgX
         E5bqQw1K+mIC513UHhqOB88NNj/ihTYZKOM+5vA0HxfwS8S1jYqrxCXUDrzT936mqf
         dfo5Ni1W1wnvdwe31zLmfuDvewpQIrYbrX6o0ECcOVpKL7EzuNgojATaARJsvUxGkT
         8q59hfI0jUy1pfwEGOo+RBx1iRET6BMaoL9Gj37V2tZF9FMZe2SzZ0WX25R7TDHthR
         6kBwEakdaVe/SFgAgZIi91Cp0w4b1AUcGp6rSHkZihHZFFDVVIHKS0/f26F79mBlUY
         ZMPO7li58JMow==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 18/06/2019 19:02, Manikanta Maddireddy wrote:
> Tegra PCIe has fixed per port SFIO line to signal PERST#, which can be
> controlled by AFI port register. However, if a platform routes a different
> GPIO to the PCIe slot, then port register cannot control it. Add support
> for GPIO based PERST# signal for such platforms. GPIO number comes from per
> port PCIe device tree node. PCIe driver probe doesn't fail if per port
> "reset-gpios" property is not populated, make sure that DT property is not
> missed for such platforms.

Really? So how come on Jetson TK1 I see ...

[    1.073165] tegra-pcie 1003000.pcie: failed to get reset GPIO: -2


[    1.073210] tegra-pcie: probe of 1003000.pcie failed with error -2

And now ethernet is broken? Why has this not been tested on all Tegra
platforms? There is no reason why code submitted to upstream by us
(people at NVIDIA) have not tested this on our internal test farm. This
is disappointing.

> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---
> V6: No change
> 
> V5:
> * Updated reset gpio toggle logic to reflect active low usage
> * Replaced kasprintf() with devm_kasprintf()
> * Updated commit message with more information.
> 
> V4: Using devm_gpiod_get_from_of_node() to get reset-gpios
> 
> V3: Using helper function to get reset-gpios
> 
> V2: Using standard "reset-gpio" property
> 
>  drivers/pci/controller/pci-tegra.c | 45 ++++++++++++++++++++++++++----
>  1 file changed, 39 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index d2841532ff0e..a819bc087a05 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -17,6 +17,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/delay.h>
>  #include <linux/export.h>
> +#include <linux/gpio.h>
>  #include <linux/interrupt.h>
>  #include <linux/iopoll.h>
>  #include <linux/irq.h>
> @@ -399,6 +400,8 @@ struct tegra_pcie_port {
>  	unsigned int lanes;
>  
>  	struct phy **phys;
> +
> +	struct gpio_desc *reset_gpio;
>  };
>  
>  struct tegra_pcie_bus {
> @@ -544,15 +547,23 @@ static void tegra_pcie_port_reset(struct tegra_pcie_port *port)
>  	unsigned long value;
>  
>  	/* pulse reset signal */
> -	value = afi_readl(port->pcie, ctrl);
> -	value &= ~AFI_PEX_CTRL_RST;
> -	afi_writel(port->pcie, value, ctrl);
> +	if (port->reset_gpio) {
> +		gpiod_set_value(port->reset_gpio, 1);
> +	} else {
> +		value = afi_readl(port->pcie, ctrl);
> +		value &= ~AFI_PEX_CTRL_RST;
> +		afi_writel(port->pcie, value, ctrl);
> +	}
>  
>  	usleep_range(1000, 2000);
>  
> -	value = afi_readl(port->pcie, ctrl);
> -	value |= AFI_PEX_CTRL_RST;
> -	afi_writel(port->pcie, value, ctrl);
> +	if (port->reset_gpio) {
> +		gpiod_set_value(port->reset_gpio, 0);
> +	} else {
> +		value = afi_readl(port->pcie, ctrl);
> +		value |= AFI_PEX_CTRL_RST;
> +		afi_writel(port->pcie, value, ctrl);
> +	}
>  }
>  
>  static void tegra_pcie_enable_rp_features(struct tegra_pcie_port *port)
> @@ -2199,6 +2210,7 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
>  		struct tegra_pcie_port *rp;
>  		unsigned int index;
>  		u32 value;
> +		char *label;
>  
>  		err = of_pci_get_devfn(port);
>  		if (err < 0) {
> @@ -2257,6 +2269,27 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
>  		if (IS_ERR(rp->base))
>  			return PTR_ERR(rp->base);
>  
> +		label = devm_kasprintf(dev, GFP_KERNEL, "pex-reset-%u", index);
> +		if (!label) {
> +			dev_err(dev, "failed to create reset GPIO label\n");
> +			return -ENOMEM;
> +		}
> +
> +		/*
> +		 * Returns null if reset-gpios property is not populated and
> +		 * fall back to using AFI per port register to toggle PERST#
> +		 * SFIO line.
> +		 */
> +		rp->reset_gpio = devm_gpiod_get_from_of_node(dev, port,
> +							     "reset-gpios", 0,
> +							     GPIOD_OUT_LOW,
> +							     label);
> +		if (IS_ERR(rp->reset_gpio)) {
> +			err = PTR_ERR(rp->reset_gpio);
> +			dev_err(dev, "failed to get reset GPIO: %d\n", err);
> +			return err;
> +		}
> +

So I believe that we can just remove the above. I will give it a test
and see.

Cheers
Jon

-- 
nvpublic
