Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E3054E66E
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jun 2022 17:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241576AbiFPP41 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jun 2022 11:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235974AbiFPP40 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jun 2022 11:56:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6932F645;
        Thu, 16 Jun 2022 08:56:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4DC71B8247C;
        Thu, 16 Jun 2022 15:56:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9C9C3411A;
        Thu, 16 Jun 2022 15:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655394982;
        bh=Uig/+Nmy6hndeL7nse9511BoQKMIV0erkOstTyQxEHA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=m52+t7VdmErDE6JLTaYv5tPzbMcsH8lDIk30SC0M9sEAzEL4LWH2xbmEWh+OIWUl8
         YpHijZwpGHzCd7JW2zDYLHi2Nr17I6wRaS/ofWLWldMDIKyRrabQDsFnwU1dyKjmOJ
         uVcpWJM0jlllMZdKeQYhT+Ok3ixw04Cx6RBPnjRvvbi795CgScI4IOKk5V6CuA//Z6
         7VUkZILF01TXh5iAf9RdSa9hrjuFGeYiWyxPjiWFJurf1aBrfhOHjsiW1wWqifOEms
         sEjUuUBpBjfK/mEGXiQ3KiUBwriy0QCje4/lqu+e6OrkNzvYyYK6eHn2gpU8vPMP8R
         LOCZf1WcS20uA==
Date:   Thu, 16 Jun 2022 10:56:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hongxing Zhu <hongxing.zhu@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Fabio Estevam <festevam@gmail.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v12 09/13] PCI: imx6: Turn off regulator when system is
 in suspend mode
Message-ID: <20220616155619.GA1089749@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB8676919AEB21FDA9F632CA4A8CAC9@AS8PR04MB8676.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 16, 2022 at 02:23:29AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: 2022年6月16日 7:31
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>; Lucas Stach
> > <l.stach@pengutronix.de>; Rob Herring <robh+dt@kernel.org>; Mark Brown
> > <broonie@kernel.org>; Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>; Fabio
> > Estevam <festevam@gmail.com>; Francesco Dolcini
> > <francesco.dolcini@toradex.com>
> > Cc: linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; kernel@pengutronix.de; dl-linux-imx
> > <linux-imx@nxp.com>; Bjorn Helgaas <bhelgaas@google.com>
> > Subject: Re: [PATCH v12 09/13] PCI: imx6: Turn off regulator when system is in
> > suspend mode
> > 
> > On Wed, Jun 15, 2022 at 06:15:47PM -0500, Bjorn Helgaas wrote:
> > > From: Richard Zhu <hongxing.zhu@nxp.com>
> > >
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
> > a=05%7C01%7Chongxing.zhu%40nxp.com%7C8dea46d908d34cb4825808da4
> > f270eaf%
> > >
> > 7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6379093264156415
> > 35%7CUnkn
> > >
> > own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1
> > haWwi
> > >
> > LCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=tqzlcCmtSkUNxNzJ0Fr5o
> > CR3X2CTH
> > > 4dwUJS4NXt5KRc%3D&amp;reserved=0
> > > hu@nxp.com
> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > > ---
> > >  drivers/pci/controller/dwc/pci-imx6.c | 19 +++++++------------
> > >  1 file changed, 7 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > > b/drivers/pci/controller/dwc/pci-imx6.c
> > > index 6eddd0b5f628..537b8a2e0e3b 100644
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
> > >  	int ret, err;
> > >
> > > -	if (imx6_pcie->vpcie && !regulator_is_enabled(imx6_pcie->vpcie)) {
> > > +	if (imx6_pcie->vpcie) {
> > >  		ret = regulator_enable(imx6_pcie->vpcie);
> > >  		if (ret) {
> > >  			dev_err(dev, "failed to enable vpcie regulator: %d\n", @@
> > -796,7
> > > +786,7 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie
> > *imx6_pcie)
> > >  	return 0;
> > >
> > >  err_clks:
> > > -	if (imx6_pcie->vpcie && regulator_is_enabled(imx6_pcie->vpcie) > 0) {
> > > +	if (imx6_pcie->vpcie) {
> > >  		ret = regulator_disable(imx6_pcie->vpcie);
> > >  		if (ret)
> > >  			dev_err(dev, "failed to disable vpcie regulator: %d\n", @@
> > -1023,6
> > > +1013,9 @@ static int imx6_pcie_suspend_noirq(struct device *dev)
> > >  		break;
> > >  	}
> > >
> > > +	if (imx6_pcie->vpcie)
> > > +		regulator_disable(imx6_pcie->vpcie);
> > 
> > This is a little bit ugly because imx6_pcie_suspend_noirq() and
> > imx6_pcie_resume_noirq() are not symmetric.
> > 
> > We call regulator_disable() directly here in imx6_pcie_suspend_noirq(), but the
> > corresponding regulator_enable() is buried in imx6_pcie_deassert_core_reset().
> > 
> > It would be nicer if the suspend and resume paths looked more similar, as
> > rockchip_pcie_suspend_noirq() and rockchip_pcie_resume_noirq() do, for
> > example.
> Yes, it is. The regulator_disable()/regulator_enable() are not invoked
>  symmetrically.
> 
> In the original codes, the regulator_disable() is contained in
> imx6_pcie_assert_core_reset() and with _eanbled() check.
> And regulator_enable() is embedded in imx6_pcie_deassert_core_reset().
> Both the regulator disable and enable are invoked in resume before.
> I move the regulator_disable to suspend mode refer to Lucas' comments.
> 
> Refer to the current situation, how about to move the regulator_disable()
>  out of imx6_pcie_deassert_core_reset() too?

I think it's important to tweak this closer to the pattern of other
drivers like exynos and rockchip.

exynos_pcie_resume_noirq() calls exynos_pcie_host_init().
imx6_pcie_resume_noirq() is VERY similar to imx6_pcie_host_init(), and
I think it should call imx6_pcie_host_init() instead of duplicating
that code.  The only real difference is that imx6_pcie_host_init()
calls imx6_setup_phy_mpll() while imx6_pcie_resume_noirq() does not.
I suspect that's a bug.

I don't think "regulator_enable(imx6_pcie->vpcie)" really has anything
to do with imx6_pcie_deassert_core_reset() and it should be moved out.
The typical pattern is to enable regulators in *_probe() and
*_resume_noirq() and disable them in *_remove() and *_suspend_noirq().
I think you should do the same unless there's some reason you can't.

Can you give this a try, starting with this v12 posting?

Bjorn
