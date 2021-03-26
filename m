Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2AA34AFEA
	for <lists+linux-pci@lfdr.de>; Fri, 26 Mar 2021 21:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhCZUMM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 16:12:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230043AbhCZULp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Mar 2021 16:11:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EED77619AB;
        Fri, 26 Mar 2021 20:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616789505;
        bh=Ru9PAn9AhDlLPLT3H01toIEKOAnuuXkC7hSMGZTcr8s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KqlxHp4gKO68e39TXLb0k4RPISO7MBOYcghFQmprxwSSM/ZLwL9uKU9SNQYPfY6S9
         660QDp06LfyWwJ2bylCPR1RpP07+pv/5RS0frrFvpafLvY3E75DREW2BrRu2tftx2e
         mWYoqbITk8Qu1/98HJ2UGVlXrc5L3w5R3bPNVH/JKljNAmQknZGxPHyMBwFCwQJLWh
         iUUA/9eaQU/uT7uCrvaIoLGs3MwBFco+rVspb87WLoNJ3BQu/LH7AHJFzcawJzTU2k
         8at/2xJ43Adaidp4JCTBTdkxGOOqASqcj+XDObE7P1mwlKEyeu9CbhzpNhF2e2BiTt
         sQz66aC2ILYQw==
Date:   Fri, 26 Mar 2021 15:11:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/6] PCI: brcmstb: Add control of EP voltage regulators
Message-ID: <20210326201143.GA903800@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326191906.43567-3-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 26, 2021 at 03:19:00PM -0400, Jim Quinlan wrote:
> Control of EP regulators by the RC is needed because of the chicken-and-egg

Can you expand "EP"?  Not sure if this refers to "endpoint" or
something else.

If this refers to a device in a slot, I guess it isn't necessarily a
PCIe *endpoint*; it could also be a switch upstream port.

> situation: although the regulator is "owned" by the EP and would be best
> handled on its driver, the EP cannot be discovered and probed unless its
> regulator is already turned on.
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 90 ++++++++++++++++++++++++++-
>  1 file changed, 87 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index e330e6811f0b..b76ec7d9af32 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -24,6 +24,7 @@
>  #include <linux/pci.h>
>  #include <linux/pci-ecam.h>
>  #include <linux/printk.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/reset.h>
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
> @@ -169,6 +170,7 @@
>  #define SSC_STATUS_SSC_MASK		0x400
>  #define SSC_STATUS_PLL_LOCK_MASK	0x800
>  #define PCIE_BRCM_MAX_MEMC		3
> +#define PCIE_BRCM_MAX_EP_REGULATORS	4
>  
>  #define IDX_ADDR(pcie)			(pcie->reg_offsets[EXT_CFG_INDEX])
>  #define DATA_ADDR(pcie)			(pcie->reg_offsets[EXT_CFG_DATA])
> @@ -295,8 +297,27 @@ struct brcm_pcie {
>  	u32			hw_rev;
>  	void			(*perst_set)(struct brcm_pcie *pcie, u32 val);
>  	void			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
> +	struct regulator_bulk_data supplies[PCIE_BRCM_MAX_EP_REGULATORS];
> +	unsigned int		num_supplies;
>  };
>  
> +static int brcm_set_regulators(struct brcm_pcie *pcie, bool on)
> +{
> +	struct device *dev = pcie->dev;
> +	int ret;
> +
> +	if (!pcie->num_supplies)
> +		return 0;
> +	if (on)
> +		ret = regulator_bulk_enable(pcie->num_supplies, pcie->supplies);
> +	else
> +		ret = regulator_bulk_disable(pcie->num_supplies, pcie->supplies);
> +	if (ret)
> +		dev_err(dev, "failed to %s EP regulators\n",
> +			on ? "enable" : "disable");
> +	return ret;
> +}
> +
>  /*
>   * This is to convert the size of the inbound "BAR" region to the
>   * non-linear values of PCIE_X_MISC_RC_BAR[123]_CONFIG_LO.SIZE
> @@ -1141,16 +1162,63 @@ static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
>  	pcie->bridge_sw_init_set(pcie, 1);
>  }
>  
> +static int brcm_pcie_get_regulators(struct brcm_pcie *pcie)
> +{
> +	struct device_node *child, *parent = pcie->np;
> +	const unsigned int max_name_len = 64 + 4;
> +	struct property *pp;
> +
> +	/* Look for regulator supply property in the EP device subnodes */
> +	for_each_available_child_of_node(parent, child) {
> +		/*
> +		 * Do a santiy test to ensure that this is an EP node

s/santiy/sanity/

> +		 * (e.g. node name: "pci-ep@0,0").  The slot number
> +		 * should always be 0 as our controller only has a single
> +		 * port.
> +		 */
> +		const char *p = strstr(child->full_name, "@0");
> +
> +		if (!p || (p[2] && p[2] != ','))
> +			continue;
> +
> +		/* Now look for regulator supply properties */
> +		for_each_property_of_node(child, pp) {
> +			int i, n = strnlen(pp->name, max_name_len);
> +
> +			if (n <= 7 || strncmp("-supply", &pp->name[n - 7], 7))
> +				continue;
> +
> +			/* Make sure this is not a duplicate */
> +			for (i = 0; i < pcie->num_supplies; i++)
> +				if (strncmp(pcie->supplies[i].supply,
> +					    pp->name, max_name_len) == 0)
> +					continue;
> +
> +			if (pcie->num_supplies < PCIE_BRCM_MAX_EP_REGULATORS)
> +				pcie->supplies[pcie->num_supplies++].supply = pp->name;
> +			else
> +				dev_warn(pcie->dev, "No room for EP supply %s\n",
> +					 pp->name);
> +		}
> +	}
> +	/*
> +	 * Get the regulators that the EP devices require.  We cannot use
> +	 * pcie->dev as the device argument in regulator_bulk_get() since
> +	 * it will not find the regulators.  Instead, use NULL and the
> +	 * regulators are looked up by their name.

The comment doesn't explain the interesting part of why you need NULL
instead of "pcie->dev".  I assume it has something to do with the
platform topology and its DT description.

This appears to be the only instance in the whole kernel of a use of
regulator_bulk_get() or devm_regulator_bulk_get() with NULL.  That
definitely warrants a comment, so I'm glad you've got something here.

The regulator_bulk_get() function comment doesn't mention the
possibility of "dev == NULL", although regulator_dev_lookup(),
create_regulator(), device_link_add() do check for it being NULL, so I
guess it's not a surprise.  We may call dev_err(NULL), which I think
will *work* without crashing even though it will look like a mistake
on the output.

> +	 */
> +	return regulator_bulk_get(NULL, pcie->num_supplies, pcie->supplies);

devm_regulator_bulk_get()?

> +}
> +
>  static int brcm_pcie_suspend(struct device *dev)
>  {
>  	struct brcm_pcie *pcie = dev_get_drvdata(dev);
> -	int ret;
>  
>  	brcm_pcie_turn_off(pcie);
> -	ret = brcm_phy_stop(pcie);
> +	brcm_phy_stop(pcie);

If we no longer care whether brcm_phy_stop() returns an error, nobody
looks at the return value and it could be void.

>  	clk_disable_unprepare(pcie->clk);
>  
> -	return ret;
> +	return brcm_set_regulators(pcie, false);
>  }
>  
>  static int brcm_pcie_resume(struct device *dev)
> @@ -1163,6 +1231,10 @@ static int brcm_pcie_resume(struct device *dev)
>  	base = pcie->base;
>  	clk_prepare_enable(pcie->clk);
>  
> +	ret = brcm_set_regulators(pcie, true);
> +	if (ret)
> +		return ret;
> +
>  	ret = brcm_phy_start(pcie);
>  	if (ret)
>  		goto err;
> @@ -1199,6 +1271,8 @@ static void __brcm_pcie_remove(struct brcm_pcie *pcie)
>  	brcm_phy_stop(pcie);
>  	reset_control_assert(pcie->rescal);
>  	clk_disable_unprepare(pcie->clk);
> +	brcm_set_regulators(pcie, false);
> +	regulator_bulk_free(pcie->num_supplies, pcie->supplies);
>  }
>  
>  static int brcm_pcie_remove(struct platform_device *pdev)
> @@ -1289,6 +1363,16 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	ret = brcm_pcie_get_regulators(pcie);
> +	if (ret) {
> +		dev_err(pcie->dev, "failed to get regulators (err=%d)\n", ret);
> +		goto fail;
> +	}
> +
> +	ret = brcm_set_regulators(pcie, true);
> +	if (ret)
> +		goto fail;
> +
>  	ret = brcm_pcie_setup(pcie);
>  	if (ret)
>  		goto fail;
> -- 
> 2.17.1
> 
