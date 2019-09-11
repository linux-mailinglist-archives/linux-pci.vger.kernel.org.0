Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5B4AFD38
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2019 14:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbfIKM6S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Sep 2019 08:58:18 -0400
Received: from foss.arm.com ([217.140.110.172]:47142 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbfIKM6S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Sep 2019 08:58:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19AE81000;
        Wed, 11 Sep 2019 05:58:17 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 838DC3F59C;
        Wed, 11 Sep 2019 05:58:16 -0700 (PDT)
Date:   Wed, 11 Sep 2019 13:58:14 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, yue.wang@Amlogic.com, kishon@ti.com,
        repk@triplefau.lt, maz@kernel.org,
        linux-amlogic@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] PCI: amlogic: meson: Add support for G12A
Message-ID: <20190911125814.GV9720@e119886-lin.cambridge.arm.com>
References: <1567950178-4466-1-git-send-email-narmstrong@baylibre.com>
 <1567950178-4466-4-git-send-email-narmstrong@baylibre.com>
 <20190911113633.GR9720@e119886-lin.cambridge.arm.com>
 <bb5794e7-44c6-c889-b555-21c531003548@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb5794e7-44c6-c889-b555-21c531003548@baylibre.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 11, 2019 at 02:39:42PM +0200, Neil Armstrong wrote:
> Hi Andrew,
> 
> On 11/09/2019 13:36, Andrew Murray wrote:
> > On Sun, Sep 08, 2019 at 01:42:55PM +0000, Neil Armstrong wrote:
> >> Add support for the Amlogic G12A SoC using a separate shared PHY.
> >>
> >> This adds support for fetching a PHY phandle and call the PHY init,
> >> reset and power on/off calls instead of writing in the PHY register or
> >> toggling the PHY reset line.
> >>
> >> The MIPI clock is also made optional since it is used for setting up
> > 
> > Is it worth indicating here that the MIPI clock is *only required* for
> > the G12A (or controllers with a shared phy)? It's still required for
> > AXG. It's not optional for G12A - it's ignored.
> 
> Indeed it's ignored, I'll reword it.
> 
> > 
> >> the PHY reference clock chared with the DSI controller on AXG.
> > 
> > s/chared/shared/
> 
> Ack
> 
> > 
> >>
> >> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> >> ---
> >>  drivers/pci/controller/dwc/pci-meson.c | 101 ++++++++++++++++++++-----
> >>  1 file changed, 84 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
> >> index ab79990798f8..3fadad381762 100644
> >> --- a/drivers/pci/controller/dwc/pci-meson.c
> >> +++ b/drivers/pci/controller/dwc/pci-meson.c
> >> @@ -16,6 +16,7 @@
> >>  #include <linux/reset.h>
> >>  #include <linux/resource.h>
> >>  #include <linux/types.h>
> >> +#include <linux/phy/phy.h>
> >>  
> >>  #include "pcie-designware.h"
> >>  
> >> @@ -96,12 +97,18 @@ struct meson_pcie_rc_reset {
> >>  	struct reset_control *apb;
> >>  };
> >>  
> >> +struct meson_pcie_param {
> >> +	bool has_shared_phy;
> >> +};
> >> +
> >>  struct meson_pcie {
> >>  	struct dw_pcie pci;
> >>  	struct meson_pcie_mem_res mem_res;
> >>  	struct meson_pcie_clk_res clk_res;
> >>  	struct meson_pcie_rc_reset mrst;
> >>  	struct gpio_desc *reset_gpio;
> >> +	struct phy *phy;
> >> +	const struct meson_pcie_param *param;
> >>  };
> >>  
> >>  static struct reset_control *meson_pcie_get_reset(struct meson_pcie *mp,
> >> @@ -123,10 +130,12 @@ static int meson_pcie_get_resets(struct meson_pcie *mp)
> >>  {
> >>  	struct meson_pcie_rc_reset *mrst = &mp->mrst;
> >>  
> >> -	mrst->phy = meson_pcie_get_reset(mp, "phy", PCIE_SHARED_RESET);
> >> -	if (IS_ERR(mrst->phy))
> >> -		return PTR_ERR(mrst->phy);
> >> -	reset_control_deassert(mrst->phy);
> >> +	if (!mp->param->has_shared_phy) {
> >> +		mrst->phy = meson_pcie_get_reset(mp, "phy", PCIE_SHARED_RESET);
> >> +		if (IS_ERR(mrst->phy))
> >> +			return PTR_ERR(mrst->phy);
> >> +		reset_control_deassert(mrst->phy);
> >> +	}
> >>  
> >>  	mrst->port = meson_pcie_get_reset(mp, "port", PCIE_NORMAL_RESET);
> >>  	if (IS_ERR(mrst->port))
> >> @@ -180,6 +189,9 @@ static int meson_pcie_get_mems(struct platform_device *pdev,
> >>  	if (IS_ERR(mp->mem_res.cfg_base))
> >>  		return PTR_ERR(mp->mem_res.cfg_base);
> >>  
> >> +	if (mp->param->has_shared_phy)
> >> +		return 0;
> >> +
> > 
> > It may be more consistent if, rather than returning here, you wrapped
> > the following 3 lines by the if statement.
> 
> ok
> 
> > 
> >>  	/* Meson SoC has two PCI controllers use same phy register*/
> > 
> > I guess this comment should now be updated to refer to AXG?
> 
> Indeed
> 
> > 
> >>  	mp->mem_res.phy_base = meson_pcie_get_mem_shared(pdev, mp, "phy");
> >>  	if (IS_ERR(mp->mem_res.phy_base))
> >> @@ -188,19 +200,33 @@ static int meson_pcie_get_mems(struct platform_device *pdev,
> >>  	return 0;
> >>  }
> >>  
> >> -static void meson_pcie_power_on(struct meson_pcie *mp)
> >> +static int meson_pcie_power_on(struct meson_pcie *mp)
> >>  {
> >> -	writel(MESON_PCIE_PHY_POWERUP, mp->mem_res.phy_base);
> >> +	int ret = 0;
> >> +
> >> +	if (mp->param->has_shared_phy)
> >> +		ret = phy_power_on(mp->phy);
> > 
> > I haven't seen any phy_[init/exit] calls, should there be any?
> 
> There is no _init() needed, but indeed we should still call them even it's
> a no-op.

Yes - and that makes it easier for someone to modify the phy driver and not
have to worry that there may be users that don't call init.

> 
> > 
> >> +	else
> >> +		writel(MESON_PCIE_PHY_POWERUP, mp->mem_res.phy_base);
> >> +
> >> +	return ret;
> >>  }
> >>  
> >> -static void meson_pcie_reset(struct meson_pcie *mp)
> >> +static int meson_pcie_reset(struct meson_pcie *mp)
> >>  {
> >>  	struct meson_pcie_rc_reset *mrst = &mp->mrst;
> >> -
> >> -	reset_control_assert(mrst->phy);
> >> -	udelay(PCIE_RESET_DELAY);
> >> -	reset_control_deassert(mrst->phy);
> >> -	udelay(PCIE_RESET_DELAY);
> >> +	int ret = 0;
> >> +
> >> +	if (mp->param->has_shared_phy) {
> >> +		ret = phy_reset(mp->phy);
> >> +		if (ret)
> >> +			return ret;
> >> +	} else {
> >> +		reset_control_assert(mrst->phy);
> >> +		udelay(PCIE_RESET_DELAY);
> >> +		reset_control_deassert(mrst->phy);
> >> +		udelay(PCIE_RESET_DELAY);
> >> +	}
> >>  
> >>  	reset_control_assert(mrst->port);
> >>  	reset_control_assert(mrst->apb);
> >> @@ -208,6 +234,8 @@ static void meson_pcie_reset(struct meson_pcie *mp)
> >>  	reset_control_deassert(mrst->port);
> >>  	reset_control_deassert(mrst->apb);
> >>  	udelay(PCIE_RESET_DELAY);
> >> +
> >> +	return 0;
> >>  }
> >>  
> >>  static inline struct clk *meson_pcie_probe_clock(struct device *dev,
> >> @@ -250,9 +278,11 @@ static int meson_pcie_probe_clocks(struct meson_pcie *mp)
> >>  	if (IS_ERR(res->port_clk))
> >>  		return PTR_ERR(res->port_clk);
> >>  
> >> -	res->mipi_gate = meson_pcie_probe_clock(dev, "mipi", 0);
> >> -	if (IS_ERR(res->mipi_gate))
> >> -		return PTR_ERR(res->mipi_gate);
> >> +	if (!mp->param->has_shared_phy) {
> >> +		res->mipi_gate = meson_pcie_probe_clock(dev, "mipi", 0);
> >> +		if (IS_ERR(res->mipi_gate))
> >> +			return PTR_ERR(res->mipi_gate);
> >> +	}
> >>  
> >>  	res->general_clk = meson_pcie_probe_clock(dev, "general", 0);
> >>  	if (IS_ERR(res->general_clk))
> >> @@ -524,6 +554,7 @@ static const struct dw_pcie_ops dw_pcie_ops = {
> >>  
> >>  static int meson_pcie_probe(struct platform_device *pdev)
> >>  {
> >> +	const struct meson_pcie_param *match_data;
> >>  	struct device *dev = &pdev->dev;
> >>  	struct dw_pcie *pci;
> >>  	struct meson_pcie *mp;
> >> @@ -537,6 +568,20 @@ static int meson_pcie_probe(struct platform_device *pdev)
> >>  	pci->dev = dev;
> >>  	pci->ops = &dw_pcie_ops;
> >>  
> >> +	match_data = of_device_get_match_data(dev);
> >> +	if (!match_data) {
> >> +		dev_err(dev, "failed to get match data\n");
> >> +		return -ENODEV;
> >> +	}
> >> +	mp->param = match_data;
> >> +
> >> +	if (mp->param->has_shared_phy) {
> >> +		mp->phy = devm_phy_get(dev, "pcie");
> >> +		if (IS_ERR(mp->phy)) {
> >> +			return PTR_ERR(mp->phy);
> >> +		}
> >> +	}
> >> +
> >>  	mp->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> >>  	if (IS_ERR(mp->reset_gpio)) {
> >>  		dev_err(dev, "get reset gpio failed\n");
> >> @@ -555,8 +600,17 @@ static int meson_pcie_probe(struct platform_device *pdev)
> >>  		return ret;
> >>  	}
> >>  
> >> -	meson_pcie_power_on(mp);
> >> -	meson_pcie_reset(mp);
> >> +	ret = meson_pcie_power_on(mp);
> >> +	if (ret) {
> >> +		dev_err(dev, "phy power on failed, %d\n", ret);
> >> +		return ret;
> >> +	}
> >> +
> >> +	ret = meson_pcie_reset(mp);
> >> +	if (ret) {
> >> +		dev_err(dev, "reset failed, %d\n", ret);
> >> +		return ret;
> >> +	}
> >>  
> >>  	ret = meson_pcie_probe_clocks(mp);
> >>  	if (ret) {
> >> @@ -575,9 +629,22 @@ static int meson_pcie_probe(struct platform_device *pdev)
> >>  	return 0;
> >>  }
> >>  
> >> +static struct meson_pcie_param meson_pcie_axg_param = {
> >> +	.has_shared_phy = false,
> >> +};
> >> +
> >> +static struct meson_pcie_param meson_pcie_g12a_param = {
> >> +	.has_shared_phy = true,
> >> +};
> >> +
> >>  static const struct of_device_id meson_pcie_of_match[] = {
> >>  	{
> >>  		.compatible = "amlogic,axg-pcie",
> >> +		.data = &meson_pcie_axg_param,
> >> +	},
> >> +	{
> >> +		.compatible = "amlogic,g12a-pcie",
> >> +		.data = &meson_pcie_g12a_param,
> > 
> > Here, we hard-code knowledge about the SOCs regarding if they have shared phys
> > or not. I guess the alternative would have been to assume there is a shared
> > phy if the DT has a phandle for it. I.e. instead of mp->param->has_shared_phy
> > everywhere you could test for mp->phy. Though I guess at least with the
> > current approach you guard against bad DTs, this seems OK.
> 
> I could split with if(mp->phy) and .needs_mipi_clk, but overall it would
> be the same, and I wouldn't know how to react if we forget the PHY in g12a DT
> since we wouldn't have the PHY register memory zone.
> On G12A, the PHY is mandatory unlike AXG.

Indeed.

> 
> And finally this MIPI clock is part of the PHY ref clock, so I think
> it's fine to wrap it in the .has_shared_phy knowledge.

I feel like the naming of "mipi" is unfortunate as ideally it'd be something
like "ref" or similar. Especially if another SoC uses meson PCI, without a
shared phy but with a reference clock that isn't MIPI. But I don't think
anyone wants to change the existing bindings.

I think your current approach is robust, I have no objections.

> 
> Thanks for the review,

Thanks,

Andrew Murray

> Neil
> 
> > 
> > Thanks,
> > 
> > Andrew Murray
> > 
> >>  	},
> >>  	{},
> >>  };
> >> -- 
> >> 2.17.1
> >>
> 
