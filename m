Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4B7362F59
	for <lists+linux-pci@lfdr.de>; Sat, 17 Apr 2021 12:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236006AbhDQKv5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 17 Apr 2021 06:51:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:55712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229972AbhDQKvz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 17 Apr 2021 06:51:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5370606A5;
        Sat, 17 Apr 2021 10:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618656689;
        bh=9/tc/wXYRdUG9mbYlOPIkpy2FgsFbviR+V3KchkASus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=erFgjgVe401+n/oW1Hd169bCXH1l6m0QQpzE0y0a283DsaleeoJf5VAivuyQsPFCf
         mK2KoN6wD9yj0MOB2PmxytRqp3MibeN3+6wtTC90/Z/dV1tScMqSsQxqfK/6i0k6BY
         cEy1E1JZ8V2To+zy1y/DeNoFaNZZ8fCxo1SAxxZomKqJE7cYKBSGoE4qbHkRjvmVWO
         RnCYS+XtYzoAN4z0SdmbtgU9dpFa3WVyLUFf3fBZUYeddp+TYWAt4AqX9mBD7ULiR+
         F287YJ8TmILBxIHOlmvdH/Y5HSA2W5i8JWCYKvc12Be7pEFYEBBzPVWaG0tLqbI+91
         RAfL6XklHE2uA==
Received: by pali.im (Postfix)
        id 453B09F7; Sat, 17 Apr 2021 12:51:26 +0200 (CEST)
Date:   Sat, 17 Apr 2021 12:51:26 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     bpeled@marvell.com
Cc:     thomas.petazzoni@bootlin.com, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, sebastian.hesselbarth@gmail.com,
        gregory.clement@bootlin.com, andrew@lunn.ch, robh+dt@kernel.org,
        mw@semihalf.com, jaz@semihalf.com, kostap@marvell.com,
        nadavh@marvell.com, stefanc@marvell.com, oferh@marvell.com
Subject: Re: =?utf-8?B?W+KAnVBBVENI?= =?utf-8?B?4oCd?= v2 2/5] PCI: armada8k:
 Add link-down handle
Message-ID: <20210417105126.qrqmviqnbppktzw7@pali>
References: <1618406454-7953-1-git-send-email-bpeled@marvell.com>
 <1618406454-7953-3-git-send-email-bpeled@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618406454-7953-3-git-send-email-bpeled@marvell.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 14 April 2021 16:20:51 bpeled@marvell.com wrote:
> From: Ben Peled <bpeled@marvell.com>
> 
> In PCIE ISR routine caused by RST_LINK_DOWN
> we schedule work to handle the link-down procedure.
> Link-down procedure will:
> 1. Remove PCIe bus
> 2. Reset the MAC
> 3. Reconfigure link back up
> 4. Rescan PCIe bus

Hello! This looks like a part of PCIe Hot Plug procedure, which is
already handled by kernel pci hotplug code, it can detect link down
interrupt and remove PCI device from the bus. I'm not sure if it would
not be better to use existing "infrastructure" for hotplug rather then
implementing new in controller driver. But I do not know what is
"correct" way, so I hope that other people (maybe Bjorn?) would say
something about this topic.

> Signed-off-by: Ben Peled <bpeled@marvell.com>
> ---
>  drivers/pci/controller/dwc/pcie-armada8k.c | 69 ++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
> index b2278b1..34b253c 100644
> --- a/drivers/pci/controller/dwc/pcie-armada8k.c
> +++ b/drivers/pci/controller/dwc/pcie-armada8k.c
> @@ -22,6 +22,8 @@
>  #include <linux/resource.h>
>  #include <linux/of_pci.h>
>  #include <linux/of_irq.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
>  
>  #include "pcie-designware.h"
>  
> @@ -33,6 +35,9 @@ struct armada8k_pcie {
>  	struct clk *clk_reg;
>  	struct phy *phy[ARMADA8K_PCIE_MAX_LANES];
>  	unsigned int phy_count;
> +	struct regmap *sysctrl_base;
> +	u32 mac_rest_bitmask;
> +	struct work_struct recover_link_work;
>  };
>  
>  #define PCIE_VENDOR_REGS_OFFSET		0x8000
> @@ -73,6 +78,8 @@ struct armada8k_pcie {
>  #define AX_USER_DOMAIN_MASK		0x3
>  #define AX_USER_DOMAIN_SHIFT		4
>  
> +#define UNIT_SOFT_RESET_CONFIG_REG	0x268
> +
>  #define to_armada8k_pcie(x)	dev_get_drvdata((x)->dev)
>  
>  static void armada8k_pcie_disable_phys(struct armada8k_pcie *pcie)
> @@ -225,6 +232,50 @@ static int armada8k_pcie_host_init(struct pcie_port *pp)
>  	return 0;
>  }
>  
> +static void armada8k_pcie_recover_link(struct work_struct *ws)
> +{
> +	struct armada8k_pcie *pcie = container_of(ws, struct armada8k_pcie, recover_link_work);
> +	struct pcie_port *pp = &pcie->pci->pp;
> +	struct pci_bus *bus = pp->bridge->bus;
> +	struct pci_dev *root_port;
> +	int ret;
> +
> +	root_port = pci_get_slot(bus, 0);
> +	if (!root_port) {
> +		dev_err(pcie->pci->dev, "failed to get root port\n");
> +		return;
> +	}
> +	pci_lock_rescan_remove();
> +	pci_stop_and_remove_bus_device(root_port);
> +	/*
> +	 * Sleep needed to make sure all pcie transactions and access
> +	 * are flushed before resetting the mac
> +	 */
> +	msleep(100);
> +
> +	/* Reset mac */
> +	regmap_update_bits_base(pcie->sysctrl_base, UNIT_SOFT_RESET_CONFIG_REG,
> +				pcie->mac_rest_bitmask, 0, NULL, false, true);
> +	udelay(1);
> +	regmap_update_bits_base(pcie->sysctrl_base, UNIT_SOFT_RESET_CONFIG_REG,
> +				pcie->mac_rest_bitmask, pcie->mac_rest_bitmask,
> +				NULL, false, true);
> +	udelay(1);
> +	ret = armada8k_pcie_host_init(pp);
> +	if (ret) {
> +		dev_err(pcie->pci->dev, "failed to initialize host: %d\n", ret);
> +		pci_unlock_rescan_remove();
> +		pci_dev_put(root_port);
> +		return;
> +	}
> +
> +	bus = NULL;
> +	while ((bus = pci_find_next_bus(bus)) != NULL)
> +		pci_rescan_bus(bus);
> +	pci_unlock_rescan_remove();
> +	pci_dev_put(root_port);
> +}
> +
>  static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
>  {
>  	struct armada8k_pcie *pcie = arg;
> @@ -262,6 +313,9 @@ static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
>  		 * initiate a link retrain. If link retrains were
>  		 * possible, that is.
>  		 */
> +		if (pcie->sysctrl_base && pcie->mac_rest_bitmask)
> +			schedule_work(&pcie->recover_link_work);
> +
>  		dev_dbg(pci->dev, "%s: link went down\n", __func__);
>  	}
>  
> @@ -330,6 +384,8 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
>  
>  	pcie->pci = pci;
>  
> +	INIT_WORK(&pcie->recover_link_work, armada8k_pcie_recover_link);
> +
>  	pcie->clk = devm_clk_get(dev, NULL);
>  	if (IS_ERR(pcie->clk))
>  		return PTR_ERR(pcie->clk);
> @@ -357,6 +413,19 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
>  		goto fail_clkreg;
>  	}
>  
> +	pcie->sysctrl_base = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
> +						       "marvell,system-controller");
> +	if (IS_ERR(pcie->sysctrl_base)) {
> +		dev_warn(dev, "failed to find marvell,system-controller\n");
> +		pcie->sysctrl_base = 0x0;
> +	}
> +
> +	ret = of_property_read_u32(pdev->dev.of_node, "marvell,mac-reset-bit-mask",
> +				   &pcie->mac_rest_bitmask);
> +	if (ret < 0) {
> +		dev_warn(dev, "couldn't find mac reset bit mask: %d\n", ret);
> +		pcie->mac_rest_bitmask = 0x0;
> +	}
>  	ret = armada8k_pcie_setup_phys(pcie);
>  	if (ret)
>  		goto fail_clkreg;
> -- 
> 2.7.4
> 
