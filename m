Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEABF55D8AD
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 15:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237064AbiF0Tvi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jun 2022 15:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239950AbiF0Tvi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jun 2022 15:51:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278D31BE99;
        Mon, 27 Jun 2022 12:51:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC6BCB81AB3;
        Mon, 27 Jun 2022 19:51:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574A4C34115;
        Mon, 27 Jun 2022 19:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656359494;
        bh=3otX2NoyAQa4cw1EZY5RmMIqpix1XymGVycKAikl4KQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QlV4MVKzgkZLU1h4Kp2+KckYfxL5yL+SKnHnXsyW9kwJXaA8VZ9cS2FsO/oRRxbL1
         3UOdjw95cMEBLBMqFdH/F28N4AAVuX3LuPctFCx0+T2IO6XdYm3wX5IjaSu0i2evcq
         13CEEa9j/LvY7nRpAvV5pVci9BrslWy+x6QdxAswikVESI9dgXAn1vPGCZTeD0kAqZ
         vo6sIsfttXhA9lVayw5wuKrL97chJxzGQ2j/6na+5fmgjvk1nhH621HSeJryWElnZK
         hRIEfarx8+UWpcWWuc+1Ja31O2EJMdpRfJ/cRtTRY7al6dfeNlNJ6uGvaXgjsnsbWf
         aEc7UxvCUMM5g==
Date:   Mon, 27 Jun 2022 14:51:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hongxing Zhu <hongxing.zhu@nxp.com>
Cc:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "francesco.dolcini@toradex.com" <francesco.dolcini@toradex.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v13 10/15] PCI: imx6: Turn off regulator when system is
 in suspend mode
Message-ID: <20220627195132.GA1542863@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB8676C6B250ECFC44E120D8188CB49@AS8PR04MB8676.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 24, 2022 at 05:05:00AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: 2022年6月24日 6:20
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: l.stach@pengutronix.de; bhelgaas@google.com; robh+dt@kernel.org;
> > broonie@kernel.org; lorenzo.pieralisi@arm.com; festevam@gmail.com;
> > francesco.dolcini@toradex.com; linux-pci@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > kernel@pengutronix.de; dl-linux-imx <linux-imx@nxp.com>
> > Subject: Re: [PATCH v13 10/15] PCI: imx6: Turn off regulator when system is in
> > suspend mode
> > 
> > On Fri, Jun 17, 2022 at 06:31:09PM +0800, Richard Zhu wrote:
> > > The driver should undo any enables it did itself. The regulator
> > > disable shouldn't be basing decisions on regulator_is_enabled().
> > >
> > > Move the regulator_disable to the suspend function, turn off regulator
> > > when the system is in suspend mode.
> > >
> > > To keep the balance of the regulator usage counter, disable the
> > > regulator in shutdown.
> > >
> > > Link:
> > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore
> > > .kernel.org%2Fr%2F1655189942-12678-6-git-send-email-hongxing.z&amp;d
> > at
> > >
> > a=05%7C01%7Chongxing.zhu%40nxp.com%7C5633fa1bf3c443e203e108da55
> > 667dc2%
> > >
> > 7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6379161959277276
> > 04%7CUnkn
> > >
> > own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1
> > haWwi
> > >
> > LCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=1Kbzn3XSVvt3gGPrEy%2
> > BET8EZn4I
> > > dwS%2BhUZ3AalZ2YZ0%3D&amp;reserved=0
> > > hu@nxp.com
> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > > ---
> > >  drivers/pci/controller/dwc/pci-imx6.c | 19 +++++++------------
> > >  1 file changed, 7 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > > b/drivers/pci/controller/dwc/pci-imx6.c
> > > index 2b42c37f1617..f72eb609769b 100644
> > > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > > @@ -670,8 +670,6 @@ static void imx6_pcie_clk_disable(struct imx6_pcie
> > > *imx6_pcie)
> > >
> > >  static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
> > > {
> > > -	struct device *dev = imx6_pcie->pci->dev;
> > > -
> > >  	switch (imx6_pcie->drvdata->variant) {
> > >  	case IMX7D:
> > >  	case IMX8MQ:
> > > @@ -702,14 +700,6 @@ static void imx6_pcie_assert_core_reset(struct
> > imx6_pcie *imx6_pcie)
> > >  		break;
> > >  	}
> > >
> > > -	if (imx6_pcie->vpcie && regulator_is_enabled(imx6_pcie->vpcie) > 0) {
> > > -		int ret = regulator_disable(imx6_pcie->vpcie);
> > > -
> > > -		if (ret)
> > > -			dev_err(dev, "failed to disable vpcie regulator: %d\n",
> > > -				ret);
> > > -	}
> > > -
> > >  	/* Some boards don't have PCIe reset GPIO. */
> > >  	if (gpio_is_valid(imx6_pcie->reset_gpio))
> > >  		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
> > > @@ -722,7 +712,7 @@ static int imx6_pcie_deassert_core_reset(struct
> > imx6_pcie *imx6_pcie)
> > >  	struct device *dev = pci->dev;
> > >  	int ret;
> > >
> > > -	if (imx6_pcie->vpcie && !regulator_is_enabled(imx6_pcie->vpcie)) {
> > > +	if (imx6_pcie->vpcie) {
> > >  		ret = regulator_enable(imx6_pcie->vpcie);
> > >  		if (ret) {
> > >  			dev_err(dev, "failed to enable vpcie regulator: %d\n", @@
> > -795,7
> > > +785,7 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie
> > *imx6_pcie)
> > >  	return 0;
> > >
> > >  err_clks:
> > > -	if (imx6_pcie->vpcie && regulator_is_enabled(imx6_pcie->vpcie) > 0) {
> > > +	if (imx6_pcie->vpcie) {
> > >  		ret = regulator_disable(imx6_pcie->vpcie);
> > >  		if (ret)
> > >  			dev_err(dev, "failed to disable vpcie regulator: %d\n", @@
> > -1022,6
> > > +1012,9 @@ static int imx6_pcie_suspend_noirq(struct device *dev)
> > >  		break;
> > >  	}
> > >
> > > +	if (imx6_pcie->vpcie)
> > > +		regulator_disable(imx6_pcie->vpcie);
> > > +
> > >  	return 0;
> > >  }
> > 
> > The suspend and resume methods should be symmetric, and they should
> > *look* symmetric.
> > 
> > imx6_pcie_suspend_noirq() disables the regulator, so
> > imx6_pcie_resume_noirq() should enable it.
> > 
> > imx6_pcie_suspend_noirq() calls imx6_pcie_clk_disable() to disable
> > several clocks.  imx6_pcie_resume_noirq() should call
> > imx6_pcie_clk_enable() to enable them.
> > 
> > imx6_pcie_clk_enable() *is* called in the resume path, but it's
> > buried inside imx6_pcie_host_init() and
> > imx6_pcie_deassert_core_reset().  That makes it hard to analyze.
> > 
> > We should be able to look at imx6_pcie_suspend_noirq() and
> > imx6_pcie_resume_noirq() and easily see that the resume path
> > resumes everything that was suspended in the suspend path.
>
> Yes, it is. It's better to keep suspend/resume symmetric as much as
> possible.  In resume, the host_init is invoked, clocks, regulators
> and so on would be initialized properly. 
>
> Unfortunately, there is no according host_exit() that can be called
> to do the reversed clocks, regulators disable operations in the
> suspend.  So, the clocks and regulator disable are explicitly
> invoked in suspend callback.
> 
> How about to do the incremental updates if the .host_exit can be
> added later?

This doesn't seem very convincing because everything here is in the
imx6 domain.  The only DWC core thing here is the dw_pcie_setup_rc() 
called in imx6_pcie_resume_noirq(), and it doesn't call back to any
imx6 code.

So you should be able to make an imx6_pcie_host_exit() or whatever
that corresponds to imx6_pcie_host_init().
