Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0317416EBE
	for <lists+linux-pci@lfdr.de>; Fri, 24 Sep 2021 11:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244505AbhIXJVJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Sep 2021 05:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244462AbhIXJVJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Sep 2021 05:21:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70218C061574
        for <linux-pci@vger.kernel.org>; Fri, 24 Sep 2021 02:19:36 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1mThMd-00010f-Nw; Fri, 24 Sep 2021 11:19:27 +0200
Message-ID: <7f1fc1b299f79077b5da0bc914a7500f723ee153.camel@pengutronix.de>
Subject: Re: [RFC] PCI: imx6: add support for internal oscillator on i.MX7D
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>
Date:   Fri, 24 Sep 2021 11:19:25 +0200
In-Reply-To: <b4b4955e7aa3a0566840f5ae1f15f8c27874d13d.camel@ew.tq-group.com>
References: <81c77a29362433fc5629ada442f0489046ce1051.1632319151.git.matthias.schiffer@ew.tq-group.com>
         <64913eca4ded0803a7e839902ff6d70c924c71c8.camel@pengutronix.de>
         <b4b4955e7aa3a0566840f5ae1f15f8c27874d13d.camel@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Freitag, dem 24.09.2021 um 10:44 +0200 schrieb Matthias Schiffer:
> On Fri, 2021-09-24 at 10:24 +0200, Lucas Stach wrote:
> > Hi Matthias,
> > 
> > Am Freitag, dem 24.09.2021 um 10:05 +0200 schrieb Matthias Schiffer:
> > > Adds support for a DT property fsl,internal-osc to select the internal
> > > oscillator for the PCIe PHY.
> > > 
> > > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > > Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> > > ---
> > > 
> > > Okay, so while this patch is nice and short, I'm note sure if it's a good
> > > solution, hence I submit it as an RFC. It is roughly based on code from
> > > older linux-imx versions [1] - although it seems this feature was never
> > > supported on i.MX7D even by linux-imx (possibly because of compliance
> > > issues with the internal clock, however I haven't found a definitive
> > > erratum backing this), but only on other SoC like i.MX6QP.
> > > 
> > > The device tree binding docs of the driver are somewhat lacking, but
> > > looking at [1] it seems that an external reference clock takes the place of
> > > the "pcie_bus" clock - various pieces of the driver skip enabling/disabling
> > > this clock when an external clock is configured.
> > > 
> > > From this I've come to the conclusion that the clock settings in
> > > imx7d.dtsi do not really make sense: The pcie_bus clock is configured to
> > > PLL_ENET_MAIN_100M_CLK, but this seems wrong for both internal and
> > > external reference clocks:
> > > 
> > > - For the internal clock, the correct clock should be PCIE_PHY_ROOT_CLK
> > >   according to the reference manual
> > 
> > The pcie_bus clock should be the reference clock for the peripherals
> > and depends on the board design. I don't think it would typically be
> > the PCIE_PHY_ROOT_CLK, but a clock derived from the same parent PLL, if
> > a SoC clock is used for that purpose.
> 
> The i.MX7D reference manual states the following:
> 
> - IMX7D_GPR12_PCIE_PHY_REFCLK_SEL enables internal sourcing of the PHY
>   reference clock from a signal with the somewhat confusing name
>   REFCLK_EXT
> - The root of pcie_phy.REFCLK_EXT is PCIE_PHY_CLK_ROOT
> 
> As I understand it, "internal reference clock" means precisely that
> this is handled entirely internal to the SoC and does not depend on the
> board design. It may differ between different SoCs implementing this
> PCIe controller though.
> 
That's the clock referenced in DT as pcie_phy.

pcie_bus is whatever clock is used to drive the reference clock of the
PCIe devices on the bus, which may be an internal or external clock,
which might be shared between the the devices and the PHY (common
clock) or may also be a totally different clock (split clock topology).
The clock topology and the sourcing of those clocks is board dependent.

> 
> > 
> > > - The external clocks, this should refer to an actual external clock, or
> > >   possibly a fixed-clock node
> > > 
> > 
> > That's correct and the i.MX8MQ board DTs all point to a external clock
> > node, as we currently default to external clocking there.
> > 
> > > I would be great if someone with more insight into this could chime in
> > > and tell me if my reasoning here is correct or not.
> > > 
> > > Unfortunately I only have our MBa7x at my disposal for further
> > > experimentation. This board does not have an external reference clock for
> > > the PCIe PHY, so I cannot test the behaviour for settings that use an
> > > external clock. Without this patch (and adding the new flag to the MBa7x
> > > DTS), the boot will hang while waiting for the PCIe link to come up.
> > > 
> > > So, for the actual question (given that my thoughts above make any sense):
> > > How do we want to implement this?
> > > 
> > > 1. A simple boolean flag, like this patch provides
> > > 2. Allow Device Trees not to specify a "pcie_bus" clock at all, meaning
> > >    it should use the internal clock
> > 
> > The internal clock is a bus clock that needs to be enabled as all other
> > clocks, so this is not an option.
> > 
> > > 3. Special handling when the "pcie_bus" clock is configured to
> > >    PCIE_PHY_ROOT_CLK - is such a thing even possible, or is this
> > >    breaking the clock driver's abstraction too much?
> > > 4. Something more involved, with a proper clock sel as the source for
> > >    "pcie_bus"
> > > 
> > > Solution 4. seems difficult to implement nicely, as the PCIe driver
> > > also fiddles with IMX7D_GPR12_PCIE_PHY_REFCLK_SEL for power management:
> > > the clock selection is switched back to the internal clock in
> > > imx6_pcie_clk_disable(), which also disables its source PCIE_PHY_ROOT_CLK,
> > > effectively gating the clock.
> > > 
> > 
> > There is currently work under way to support this case properly. The
> > first step is to actually abstract the PCIe PHY in the right way,
> > Richard has already sent some patches for this.
> > 
> > Then we can add support for the different possibilities of using the
> > refclock pad, as this isn't a simple choice between using the internal
> > clock or a externally supplied one. The options are:
> > 
> > 1. Use internal clock to drive the PHY, if there isn't some other path
> > to output this clock to the board this is effectively a split clocking
> > setup.
> > 2. Use externally supplied clock provided to the PHY via the refclock
> > pad.
> > 3. Use internal clock to driver the PHY, but output this clock on the
> > refclock pad, which is known to be possible with the i.MX8MM PCIe PHY.
> 
> What is the plan here for configuring which of these options to use?
> 
The plan is to have a DT property to configure the refclock pad
function.

Regards,
Lucas

> 
> > 
> > Regards,
> > Lucas
> > 
> > > Regards,
> > > Matthias
> > > 
> > > 
> > > [1] https://source.codeaurora.org/external/imx/linux-imx/tree/drivers/pci/host/pci-imx6.c?h=imx_4.1.15_2.0.0_ga
> > > 
> > >  drivers/pci/controller/dwc/pci-imx6.c | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > > index 80fc98acf097..021499b9ee7c 100644
> > > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > > @@ -83,6 +83,7 @@ struct imx6_pcie {
> > >  	struct regulator	*vpcie;
> > >  	struct regulator	*vph;
> > >  	void __iomem		*phy_base;
> > > +	bool			internal_osc;
> > >  
> > >  	/* power domain for pcie */
> > >  	struct device		*pd_pcie;
> > > @@ -637,7 +638,9 @@ static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
> > >  		break;
> > >  	case IMX7D:
> > >  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > > -				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL, 0);
> > > +				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
> > > +				   imx6_pcie->internal_osc ?
> > > +					IMX7D_GPR12_PCIE_PHY_REFCLK_SEL : 0);
> > >  		break;
> > >  	case IMX6SX:
> > >  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > > @@ -1130,6 +1133,9 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> > >  				 &imx6_pcie->tx_swing_low))
> > >  		imx6_pcie->tx_swing_low = 127;
> > >  
> > > +	if (of_property_read_bool(node, "fsl,internal-osc"))
> > > +		imx6_pcie->internal_osc = true;
> > > +
> > >  	/* Limit link speed */
> > >  	pci->link_gen = 1;
> > >  	ret = of_property_read_u32(node, "fsl,max-link-speed", &pci->link_gen);
> > 
> > 
> 


