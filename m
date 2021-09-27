Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA97E4196C8
	for <lists+linux-pci@lfdr.de>; Mon, 27 Sep 2021 16:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbhI0O5J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Sep 2021 10:57:09 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:58753 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234782AbhI0O5I (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Sep 2021 10:57:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1632754530; x=1664290530;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S9jmg+4ROAwTjgugtOdUrTGKCJgY7vbQC2MisE2rG1Y=;
  b=oVwlpt/Y2foIlEzDwJ3kZvX+oqV1VeQe5HouXjqLhFmfSSpCW7uI3JIp
   qiYm1YpjwUAOnX1BnjxpOEekd5HGK3ab6KxezrUT2pbTqYnFf01FOQAXc
   0X/QRh/+BWhmjQNuxQ1PCKtPXQ5GuSVqWGDm5Y8k+2/WKa5JWccipA31W
   iEZJTqx1kq8Rf20UxeIst8UoYeNAHFuOho/MbtpaWGNL9IwIAVfCbDj7C
   lB+ihlpEgmDP9e96jwG6jmlbi3C4KMRWnxzudZ/jjhGFBNicQS04AC8zi
   tWHJ2DJC4sxX2yiAuyId47PhKJXHEcvscybfWa1ZLiF0OiGwpOlWMzVJg
   A==;
X-IronPort-AV: E=Sophos;i="5.85,326,1624312800"; 
   d="scan'208";a="19729221"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 27 Sep 2021 16:55:29 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 27 Sep 2021 16:55:29 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 27 Sep 2021 16:55:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1632754529; x=1664290529;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S9jmg+4ROAwTjgugtOdUrTGKCJgY7vbQC2MisE2rG1Y=;
  b=AXmt5IUVDzVIIMdeAbrXfqEU6BG96c1Y6dH4QZYFi0x04KmU/6vjmae6
   XQzq++kxQvGzYIUWvnPGhhhF3xE4qNAK8Vx+urwIQZcqeLupTmyaSmt9V
   5Z4vGmCOr1w4E3TPl/B+kojx+YrBYiihnYeS7zhy3k4UFcqJbVrKrV4Tt
   uQ1byNpOqXRyRzawjGb6LYmNkkhIlLQKiJZvc7CaP0o/aU5AsAP1BL3ez
   KITrAUUxLupWl4hwWVlqz12bW+CIc4ho12QAab6SDzQsOuRBqaGnwMGA9
   OSClIcCA0XL+bkDcN/ft3IBl7FUaY8V92cq8ww/9xZEEpAO3kObcdS105
   g==;
X-IronPort-AV: E=Sophos;i="5.85,326,1624312800"; 
   d="scan'208";a="19729220"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 27 Sep 2021 16:55:29 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.121.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 245B4280070;
        Mon, 27 Sep 2021 16:55:29 +0200 (CEST)
Message-ID: <c80d5c7621bcb3d4c45bae0050595a5065d408fb.camel@ew.tq-group.com>
Subject: Re: [RFC] PCI: imx6: add support for internal oscillator on i.MX7D
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
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
Date:   Mon, 27 Sep 2021 16:55:26 +0200
In-Reply-To: <7f1fc1b299f79077b5da0bc914a7500f723ee153.camel@pengutronix.de>
References: <81c77a29362433fc5629ada442f0489046ce1051.1632319151.git.matthias.schiffer@ew.tq-group.com>
         <64913eca4ded0803a7e839902ff6d70c924c71c8.camel@pengutronix.de>
         <b4b4955e7aa3a0566840f5ae1f15f8c27874d13d.camel@ew.tq-group.com>
         <7f1fc1b299f79077b5da0bc914a7500f723ee153.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 2021-09-24 at 11:19 +0200, Lucas Stach wrote:
> Am Freitag, dem 24.09.2021 um 10:44 +0200 schrieb Matthias Schiffer:
> > On Fri, 2021-09-24 at 10:24 +0200, Lucas Stach wrote:
> > > Hi Matthias,
> > > 
> > > Am Freitag, dem 24.09.2021 um 10:05 +0200 schrieb Matthias Schiffer:
> > > > Adds support for a DT property fsl,internal-osc to select the internal
> > > > oscillator for the PCIe PHY.
> > > > 
> > > > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > > > Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> > > > ---
> > > > 
> > > > Okay, so while this patch is nice and short, I'm note sure if it's a good
> > > > solution, hence I submit it as an RFC. It is roughly based on code from
> > > > older linux-imx versions [1] - although it seems this feature was never
> > > > supported on i.MX7D even by linux-imx (possibly because of compliance
> > > > issues with the internal clock, however I haven't found a definitive
> > > > erratum backing this), but only on other SoC like i.MX6QP.
> > > > 
> > > > The device tree binding docs of the driver are somewhat lacking, but
> > > > looking at [1] it seems that an external reference clock takes the place of
> > > > the "pcie_bus" clock - various pieces of the driver skip enabling/disabling
> > > > this clock when an external clock is configured.
> > > > 
> > > > From this I've come to the conclusion that the clock settings in
> > > > imx7d.dtsi do not really make sense: The pcie_bus clock is configured to
> > > > PLL_ENET_MAIN_100M_CLK, but this seems wrong for both internal and
> > > > external reference clocks:
> > > > 
> > > > - For the internal clock, the correct clock should be PCIE_PHY_ROOT_CLK
> > > >   according to the reference manual
> > > 
> > > The pcie_bus clock should be the reference clock for the peripherals
> > > and depends on the board design. I don't think it would typically be
> > > the PCIE_PHY_ROOT_CLK, but a clock derived from the same parent PLL, if
> > > a SoC clock is used for that purpose.
> > 
> > The i.MX7D reference manual states the following:
> > 
> > - IMX7D_GPR12_PCIE_PHY_REFCLK_SEL enables internal sourcing of the PHY
> >   reference clock from a signal with the somewhat confusing name
> >   REFCLK_EXT
> > - The root of pcie_phy.REFCLK_EXT is PCIE_PHY_CLK_ROOT
> > 
> > As I understand it, "internal reference clock" means precisely that
> > this is handled entirely internal to the SoC and does not depend on the
> > board design. It may differ between different SoCs implementing this
> > PCIe controller though.
> > 
> 
> That's the clock referenced in DT as pcie_phy.
> 
> pcie_bus is whatever clock is used to drive the reference clock of the
> PCIe devices on the bus, which may be an internal or external clock,
> which might be shared between the the devices and the PHY (common
> clock) or may also be a totally different clock (split clock topology).
> The clock topology and the sourcing of those clocks is board dependent.

I'm not familiar with the split clock setup. Will the reference clock
that the devices consume still have to be input to the PHY somehow, or
can PCIe operate without a common reference clock?


On i.MX7D, there are two pairs of pads for the bus clock,
PCIE_REFCLK_IN_P/N and PCIE_REFCLK_OUT_P/N. There are two possible
modes of operation here, selectable by IMX7D_GPR12_PCIE_PHY_REFCLK_SEL:

1. Clock is generated on the board and sent to PCIE_REFCLK_IN_P/N. The
"pcie_bus" clock in DT should reflect how the clock is generated on the
board.
2. Clock is generated internally by the PCIe PHY, based on the SoC-
internal signal pcie_phy.REFCLK_EXT, which is PCIE_PHY_CLK_ROOT. The
PCIE_REFCLK_IN_P/N pads are unused in this mode.

For the second option, it seems to me that "pcie_phy" and "pcie_bus" in
DT should refer to the same clock source.


> 
> > 
> > > 
> > > > - The external clocks, this should refer to an actual external clock, or
> > > >   possibly a fixed-clock node
> > > > 
> > > 
> > > That's correct and the i.MX8MQ board DTs all point to a external clock
> > > node, as we currently default to external clocking there.
> > > 
> > > > I would be great if someone with more insight into this could chime in
> > > > and tell me if my reasoning here is correct or not.
> > > > 
> > > > Unfortunately I only have our MBa7x at my disposal for further
> > > > experimentation. This board does not have an external reference clock for
> > > > the PCIe PHY, so I cannot test the behaviour for settings that use an
> > > > external clock. Without this patch (and adding the new flag to the MBa7x
> > > > DTS), the boot will hang while waiting for the PCIe link to come up.
> > > > 
> > > > So, for the actual question (given that my thoughts above make any sense):
> > > > How do we want to implement this?
> > > > 
> > > > 1. A simple boolean flag, like this patch provides
> > > > 2. Allow Device Trees not to specify a "pcie_bus" clock at all, meaning
> > > >    it should use the internal clock
> > > 
> > > The internal clock is a bus clock that needs to be enabled as all other
> > > clocks, so this is not an option.
> > > 
> > > > 3. Special handling when the "pcie_bus" clock is configured to
> > > >    PCIE_PHY_ROOT_CLK - is such a thing even possible, or is this
> > > >    breaking the clock driver's abstraction too much?
> > > > 4. Something more involved, with a proper clock sel as the source for
> > > >    "pcie_bus"
> > > > 
> > > > Solution 4. seems difficult to implement nicely, as the PCIe driver
> > > > also fiddles with IMX7D_GPR12_PCIE_PHY_REFCLK_SEL for power management:
> > > > the clock selection is switched back to the internal clock in
> > > > imx6_pcie_clk_disable(), which also disables its source PCIE_PHY_ROOT_CLK,
> > > > effectively gating the clock.
> > > > 
> > > 
> > > There is currently work under way to support this case properly. The
> > > first step is to actually abstract the PCIe PHY in the right way,
> > > Richard has already sent some patches for this.
> > > 
> > > Then we can add support for the different possibilities of using the
> > > refclock pad, as this isn't a simple choice between using the internal
> > > clock or a externally supplied one. The options are:
> > > 
> > > 1. Use internal clock to drive the PHY, if there isn't some other path
> > > to output this clock to the board this is effectively a split clocking
> > > setup.
> > > 2. Use externally supplied clock provided to the PHY via the refclock
> > > pad.
> > > 3. Use internal clock to driver the PHY, but output this clock on the
> > > refclock pad, which is known to be possible with the i.MX8MM PCIe PHY.
> > 
> > What is the plan here for configuring which of these options to use?
> > 
> 
> The plan is to have a DT property to configure the refclock pad
> function.

Would a setup like the current imx8mq-evk.dts where "pcie_bus" refers
to a fixed-clock node be used for option 1 and 2?

It seems to me that the i.MX7D will require a slightly different
configuration, as it has separate pads for refclk input and output.

Regards,
Matthias


> Regards,
> Lucas
> 
> > 
> > > 
> > > Regards,
> > > Lucas
> > > 
> > > > Regards,
> > > > Matthias
> > > > 
> > > > 
> > > > [1] https://source.codeaurora.org/external/imx/linux-imx/tree/drivers/pci/host/pci-imx6.c?h=imx_4.1.15_2.0.0_ga
> > > > 
> > > >  drivers/pci/controller/dwc/pci-imx6.c | 8 +++++++-
> > > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > > > index 80fc98acf097..021499b9ee7c 100644
> > > > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > > > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > > > @@ -83,6 +83,7 @@ struct imx6_pcie {
> > > >  	struct regulator	*vpcie;
> > > >  	struct regulator	*vph;
> > > >  	void __iomem		*phy_base;
> > > > +	bool			internal_osc;
> > > >  
> > > >  	/* power domain for pcie */
> > > >  	struct device		*pd_pcie;
> > > > @@ -637,7 +638,9 @@ static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
> > > >  		break;
> > > >  	case IMX7D:
> > > >  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > > > -				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL, 0);
> > > > +				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
> > > > +				   imx6_pcie->internal_osc ?
> > > > +					IMX7D_GPR12_PCIE_PHY_REFCLK_SEL : 0);
> > > >  		break;
> > > >  	case IMX6SX:
> > > >  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > > > @@ -1130,6 +1133,9 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> > > >  				 &imx6_pcie->tx_swing_low))
> > > >  		imx6_pcie->tx_swing_low = 127;
> > > >  
> > > > +	if (of_property_read_bool(node, "fsl,internal-osc"))
> > > > +		imx6_pcie->internal_osc = true;
> > > > +
> > > >  	/* Limit link speed */
> > > >  	pci->link_gen = 1;
> > > >  	ret = of_property_read_u32(node, "fsl,max-link-speed", &pci->link_gen);
> > > 
> > > 
> 
> 

