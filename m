Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8725143B761
	for <lists+linux-pci@lfdr.de>; Tue, 26 Oct 2021 18:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbhJZQlK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Oct 2021 12:41:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232718AbhJZQlJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Oct 2021 12:41:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E62260EC0;
        Tue, 26 Oct 2021 16:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635266325;
        bh=M6fXJMrTGa8IExJqf4YZcO+T/hr2BeuE2gyvDrquv6o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RhaGFe3b63waVWBP7Snd1z3sMrdALWRgbSBt4CJx3rE1HEJCiIj6hrLg7aMELFpD7
         by7f39A+r6MRVe2/u4DCyGcGdCVuREUmDAHY1/EhAeMGjHB9Rm6gsGRkVj4xlHQbrR
         ljPZB6HAHz+/jbOiL575lf4rfU1agjLs/G7B6sDTuFVLD8rdiyA+YejeTLlBOCRUc2
         mQwBj3hTmvhsROvciKqMAe7rLbtGQZK+VghPee0UiFzcXTN+BZGXSnCmDr3BfvzTO4
         dfxysYQXnZyitewKkZ4luBi49tq3NKrb3cO5RTpoMY3PcLToa85S9V/T3ww+t77zcL
         OcXyjJtzqu4Ig==
Date:   Tue, 26 Oct 2021 11:38:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [RESEND v2 4/5] PCI: imx6: Fix the clock reference handling
 unbalance when link never came up
Message-ID: <20211026163844.GA145569@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR04MB867697359A6D51903D0098308C809@AS8PR04MB8676.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 22, 2021 at 08:02:17AM +0000, Richard Zhu wrote:
> <snipped ...>
> > >
> > > > > -static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie) -{
> > > > > -	clk_disable_unprepare(imx6_pcie->pcie);
> > > > > -	clk_disable_unprepare(imx6_pcie->pcie_phy);
> > > > > -	clk_disable_unprepare(imx6_pcie->pcie_bus);
> > > > > -
> > > > > -	switch (imx6_pcie->drvdata->variant) {
> > > > > -	case IMX6SX:
> > > > > -		clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
> > > > > -		break;
> > > > > -	case IMX7D:
> > > > > -		regmap_update_bits(imx6_pcie->iomuxc_gpr,
> > IOMUXC_GPR12,
> > > > > -				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
> > > > > -				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
> > > > > -		break;
> > > > > -	case IMX8MQ:
> > > > > -		clk_disable_unprepare(imx6_pcie->pcie_aux);
> > > > > -		break;
> > > > > -	default:
> > > > > -		break;
> > >
> > > While you're at it, this "default: break;" thing is pointless.
> > > Normally it's better to just *move* something without changing it at
> > > all, but this is such a simple thing I think you could drop this at
> > > the same time as the move.
> > >
> > [Richard Zhu] Okay, got that. Would remove the "default:break" later. Thanks.
> [Richard Zhu] I figure out that the default:break is required by
> IMX6Q/IMX6QP.  So I just don't drop them in v3 patch-set.

That makes no sense.  The code is:

  +static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
  +{
  +       clk_disable_unprepare(imx6_pcie->pcie);
  +       clk_disable_unprepare(imx6_pcie->pcie_phy);
  +       clk_disable_unprepare(imx6_pcie->pcie_bus);
  +
  +       switch (imx6_pcie->drvdata->variant) {
  +       case IMX6SX:
  +               clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
  +               break;
  +       case IMX7D:
  +               regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
  +                                  IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
  +                                  IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
  +               break;
  +       case IMX8MQ:
  +               clk_disable_unprepare(imx6_pcie->pcie_aux);
  +               break;
  +       default:
  +               break;
  +       }
  +}

Why do you think it makes a difference to remove the
"default: break;"?  There is no executable code after it.
I don't see how IMX6Q/IMX6QP could depend on the default
case.

BTW, I feel like a broken record, but your v3 posting still has
inconsistent subject line capitalization:

  PCI: imx6: move the clock disable function to a proper place
  PCI: dwc: add a new callback host exit function into host ops

It would be nice if they were consistent and contained more specific
information, e.g.,

  PCI: imx6: Move imx6_pcie_clk_disable() earlier
  PCI: dwc: Add dw_pcie_host_ops.host_exit() callback

Bjorn
