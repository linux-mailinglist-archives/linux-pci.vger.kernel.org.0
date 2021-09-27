Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA40419C85
	for <lists+linux-pci@lfdr.de>; Mon, 27 Sep 2021 19:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237888AbhI0R3t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Sep 2021 13:29:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238019AbhI0R0P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Sep 2021 13:26:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 82FB160E08;
        Mon, 27 Sep 2021 17:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632762995;
        bh=fiFXcjAyr/xbXvMc5MGt+1jLB423H4t84TnDpKWaMik=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=P5L1ZpilVa8FWpVdXv+LcxwmF4pAThXyw9LbPnxzSqk34x5HsQKMngUyiQ6TV/WDw
         0oL3V+UbXcrKOqk+62vEypWryPX4oSQHXNp/Vd2rgq+YbZTMXTZS8Se9KY2uE/OXEW
         ACAcBD1Bc5J8lA/55oY/22TRuUTw13vfwd9ZjSw/w/7FsFxWyr26X8kQvwBtqugDZw
         up79h8bkFPqU234Zjsg9ccWWJ3QlXSJk42E7LErMoQgT39J3jDtB+gxCV5xHMHkUdR
         Z4/BtEkEVeHXSthBOyKwSYPSxa3SYrh210IZlDnvuw/BjJWSlJKKPeMkJLKjGCI8oW
         Kc5CurkAwpOdg==
Date:   Mon, 27 Sep 2021 12:16:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: Re: [RFC] PCI: imx6: add support for internal oscillator on i.MX7D
Message-ID: <20210927171634.GA658570@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81c77a29362433fc5629ada442f0489046ce1051.1632319151.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 24, 2021 at 10:05:15AM +0200, Matthias Schiffer wrote:
> Adds support for a DT property fsl,internal-osc to select the internal
> oscillator for the PCIe PHY.

If you repost this, please update the subject to match the conventions
(use "git log --oneline drivers/pci/controller/dwc/pci-imx6.c" and
note capitalization).

> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> ---
> 
> Okay, so while this patch is nice and short, I'm note sure if it's a good
> solution, hence I submit it as an RFC. It is roughly based on code from
> older linux-imx versions [1] - although it seems this feature was never
> supported on i.MX7D even by linux-imx (possibly because of compliance
> issues with the internal clock, however I haven't found a definitive
> erratum backing this), but only on other SoC like i.MX6QP.
> 
> The device tree binding docs of the driver are somewhat lacking, but
> looking at [1] it seems that an external reference clock takes the place of
> the "pcie_bus" clock - various pieces of the driver skip enabling/disabling
> this clock when an external clock is configured.
> 
> From this I've come to the conclusion that the clock settings in
> imx7d.dtsi do not really make sense: The pcie_bus clock is configured to
> PLL_ENET_MAIN_100M_CLK, but this seems wrong for both internal and
> external reference clocks:
> 
> - For the internal clock, the correct clock should be PCIE_PHY_ROOT_CLK
>   according to the reference manual
> - The external clocks, this should refer to an actual external clock, or
>   possibly a fixed-clock node
> 
> I would be great if someone with more insight into this could chime in
> and tell me if my reasoning here is correct or not.
> 
> Unfortunately I only have our MBa7x at my disposal for further
> experimentation. This board does not have an external reference clock for
> the PCIe PHY, so I cannot test the behaviour for settings that use an
> external clock. Without this patch (and adding the new flag to the MBa7x
> DTS), the boot will hang while waiting for the PCIe link to come up.
> 
> So, for the actual question (given that my thoughts above make any sense):
> How do we want to implement this?
> 
> 1. A simple boolean flag, like this patch provides
> 2. Allow Device Trees not to specify a "pcie_bus" clock at all, meaning
>    it should use the internal clock
> 3. Special handling when the "pcie_bus" clock is configured to
>    PCIE_PHY_ROOT_CLK - is such a thing even possible, or is this
>    breaking the clock driver's abstraction too much?
> 4. Something more involved, with a proper clock sel as the source for
>    "pcie_bus"
> 
> Solution 4. seems difficult to implement nicely, as the PCIe driver
> also fiddles with IMX7D_GPR12_PCIE_PHY_REFCLK_SEL for power management:
> the clock selection is switched back to the internal clock in
> imx6_pcie_clk_disable(), which also disables its source PCIE_PHY_ROOT_CLK,
> effectively gating the clock.
> 
> Regards,
> Matthias
> 
> 
> [1] https://source.codeaurora.org/external/imx/linux-imx/tree/drivers/pci/host/pci-imx6.c?h=imx_4.1.15_2.0.0_ga
> 
>  drivers/pci/controller/dwc/pci-imx6.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 80fc98acf097..021499b9ee7c 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -83,6 +83,7 @@ struct imx6_pcie {
>  	struct regulator	*vpcie;
>  	struct regulator	*vph;
>  	void __iomem		*phy_base;
> +	bool			internal_osc;

Prefer bitfield ("unsigned int internal_osc:1") over bool in structs.

>  	/* power domain for pcie */
>  	struct device		*pd_pcie;
> @@ -637,7 +638,9 @@ static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
>  		break;
>  	case IMX7D:
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL, 0);
> +				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
> +				   imx6_pcie->internal_osc ?
> +					IMX7D_GPR12_PCIE_PHY_REFCLK_SEL : 0);
>  		break;
>  	case IMX6SX:
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> @@ -1130,6 +1133,9 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  				 &imx6_pcie->tx_swing_low))
>  		imx6_pcie->tx_swing_low = 127;
>  
> +	if (of_property_read_bool(node, "fsl,internal-osc"))
> +		imx6_pcie->internal_osc = true;
> +
>  	/* Limit link speed */
>  	pci->link_gen = 1;
>  	ret = of_property_read_u32(node, "fsl,max-link-speed", &pci->link_gen);
> -- 
> 2.17.1
> 
