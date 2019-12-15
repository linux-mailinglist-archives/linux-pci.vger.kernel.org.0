Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3275F11F771
	for <lists+linux-pci@lfdr.de>; Sun, 15 Dec 2019 12:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbfLOL37 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Dec 2019 06:29:59 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:56737 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfLOL37 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 Dec 2019 06:29:59 -0500
Received: from localhost (unknown [88.190.179.123])
        (Authenticated sender: repk@triplefau.lt)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id F41F9200003;
        Sun, 15 Dec 2019 11:29:55 +0000 (UTC)
Date:   Sun, 15 Dec 2019 12:38:20 +0100
From:   Remi Pommarel <repk@triplefau.lt>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Yue Wang <yue.wang@amlogic.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: amlogic: Use PCIe pll gate when available
Message-ID: <20191215113820.GC7304@voidbox>
References: <20191208210320.15539-1-repk@triplefau.lt>
 <20191208210320.15539-3-repk@triplefau.lt>
 <20191209110314.GQ18399@e119886-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209110314.GQ18399@e119886-lin.cambridge.arm.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 09, 2019 at 11:03:15AM +0000, Andrew Murray wrote:
> On Sun, Dec 08, 2019 at 10:03:20PM +0100, Remi Pommarel wrote:
> > In order to get PCIe working reliably on some AXG platforms, PCIe pll
> > cml needs to be enabled. This is done by using the PCIE_PLL_CML_ENABLE
> > clock gate.
> 
> s/cml/CML/
> 
> In addition to Jerome's feedback - it would also be helpful to explain
> when CML outputs should be enabled, i.e. which platforms and why those
> ones?
> 
> > 
> > This clock gate is optional, so do not fail if it is missing in the
> > devicetree.
> 
> If certain platforms require PCIE_PLL_CML_ENABLE to work reliably and
> thus the clock is specified in the device tree - then surely if there
> is an error in enabling the clock we should fail? I.e. should you only
> ignore -ENOENT here?

Good point. Will do.

Thanks

-- 
Remi

> 
> Thanks,
> 
> Andrew Murray
> 
> > 
> > Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> > ---
> >  drivers/pci/controller/dwc/pci-meson.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
> > index 3772b02a5c55..32b70ea9a426 100644
> > --- a/drivers/pci/controller/dwc/pci-meson.c
> > +++ b/drivers/pci/controller/dwc/pci-meson.c
> > @@ -89,6 +89,7 @@ struct meson_pcie_clk_res {
> >  	struct clk *mipi_gate;
> >  	struct clk *port_clk;
> >  	struct clk *general_clk;
> > +	struct clk *pll_cml_gate;
> >  };
> >  
> >  struct meson_pcie_rc_reset {
> > @@ -300,6 +301,10 @@ static int meson_pcie_probe_clocks(struct meson_pcie *mp)
> >  	if (IS_ERR(res->clk))
> >  		return PTR_ERR(res->clk);
> >  
> > +	res->pll_cml_gate = meson_pcie_probe_clock(dev, "pll_cml_en", 0);
> > +	if (IS_ERR(res->pll_cml_gate))
> > +		res->pll_cml_gate = NULL;
> > +
> >  	return 0;
> >  }
> >  
> > -- 
> > 2.24.0
> > 
