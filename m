Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B5A544515
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jun 2022 09:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237725AbiFIHre (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jun 2022 03:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbiFIHre (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jun 2022 03:47:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBCB42EC6
        for <linux-pci@vger.kernel.org>; Thu,  9 Jun 2022 00:47:30 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1nzCsy-0001aH-Ju; Thu, 09 Jun 2022 09:47:20 +0200
Message-ID: <ce3bf1e3ea155a45bd903c1506ed433fdc3026e3.camel@pengutronix.de>
Subject: Re: [PATCH v9 5/8] PCI: imx6: Refine the regulator usage
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Hongxing Zhu <hongxing.zhu@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "francesco.dolcini@toradex.com" <francesco.dolcini@toradex.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Date:   Thu, 09 Jun 2022 09:47:18 +0200
In-Reply-To: <AS8PR04MB8676708D899DCE93F14A28DB8CA79@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1651801629-30223-1-git-send-email-hongxing.zhu@nxp.com>
         <1651801629-30223-6-git-send-email-hongxing.zhu@nxp.com>
         <2427cef355dc1b9d1667a2c80448d2e23b97c447.camel@pengutronix.de>
         <AS8PR04MB8676708D899DCE93F14A28DB8CA79@AS8PR04MB8676.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Donnerstag, dem 09.06.2022 um 06:17 +0000 schrieb Hongxing Zhu:
> > -----Original Message-----
> > From: Lucas Stach <l.stach@pengutronix.de>
> > Sent: 2022年6月8日 15:27
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>; bhelgaas@google.com;
> > robh+dt@kernel.org; broonie@kernel.org; lorenzo.pieralisi@arm.com;
> > jingoohan1@gmail.com; festevam@gmail.com;
> > francesco.dolcini@toradex.com
> > Cc: linux-pci@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; kernel@pengutronix.de; dl-linux-imx
> > <linux-imx@nxp.com>
> > Subject: Re: [PATCH v9 5/8] PCI: imx6: Refine the regulator usage
> > 
> > Am Freitag, dem 06.05.2022 um 09:47 +0800 schrieb Richard Zhu:
> > > The driver should undo any enables it did itself. The regulator
> > > disable shouldn't be basing decisions on regulator_is_enabled().
> > > 
> > > To keep the balance of the regulator usage counter, disable the
> > > regulator just behind of imx6_pcie_assert_core_reset() in resume
> > > and
> > shutdown.
> > > 
> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > ---
> > >  drivers/pci/controller/dwc/pci-imx6.c | 19 +++++++------------
> > >  1 file changed, 7 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > > b/drivers/pci/controller/dwc/pci-imx6.c
> > > index 7005a7910003..3ce3993d5797 100644
> > > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > > @@ -369,8 +369,6 @@ static int imx6_pcie_attach_pd(struct device
> > > *dev)
> > > 
> > >  static void imx6_pcie_assert_core_reset(struct imx6_pcie
> > > *imx6_pcie)
> > > {
> > > -	struct device *dev = imx6_pcie->pci->dev;
> > > -
> > >  	switch (imx6_pcie->drvdata->variant) {
> > >  	case IMX7D:
> > >  	case IMX8MQ:
> > > @@ -400,14 +398,6 @@ static void
> > > imx6_pcie_assert_core_reset(struct
> > imx6_pcie *imx6_pcie)
> > >  				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 0
> > > << 16);
> > >  		break;
> > >  	}
> > > -
> > > -	if (imx6_pcie->vpcie && regulator_is_enabled(imx6_pcie-
> > > >vpcie) > 0) {
> > > -		int ret = regulator_disable(imx6_pcie->vpcie);
> > > -
> > > -		if (ret)
> > > -			dev_err(dev, "failed to disable vpcie
> > > regulator: %d\n",
> > > -				ret);
> > > -	}
> > >  }
> > > 
> > >  static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie
> > > *imx6_pcie) @@ -580,7 +570,7 @@ static int
> > imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
> > >  	struct device *dev = pci->dev;
> > >  	int ret, err;
> > > 
> > > -	if (imx6_pcie->vpcie && !regulator_is_enabled(imx6_pcie-
> > > >vpcie)) {
> > > +	if (imx6_pcie->vpcie) {
> > >  		ret = regulator_enable(imx6_pcie->vpcie);
> > >  		if (ret) {
> > >  			dev_err(dev, "failed to enable vpcie
> > > regulator: %d\n", @@
> > -653,7
> > > +643,7 @@ static int imx6_pcie_deassert_core_reset(struct
> > > imx6_pcie
> > *imx6_pcie)
> > >  	return 0;
> > > 
> > >  err_clks:
> > > -	if (imx6_pcie->vpcie && regulator_is_enabled(imx6_pcie-
> > > >vpcie) > 0) {
> > > +	if (imx6_pcie->vpcie) {
> > >  		ret = regulator_disable(imx6_pcie->vpcie);
> > >  		if (ret)
> > >  			dev_err(dev, "failed to disable vpcie
> > > regulator: %d\n", @@
> > -1026,6
> > > +1016,9 @@ static int imx6_pcie_resume_noirq(struct device *dev)
> > >  		return 0;
> > > 
> > >  	imx6_pcie_assert_core_reset(imx6_pcie);
> > > +	if (imx6_pcie->vpcie)
> > > +		regulator_disable(imx6_pcie->vpcie);
> > > +
> > This one looks misplaced. Surely you want the regulator to be on
> > when
> > resuming the PCIe subsystem. Isn't this just papering over a wrong
> > usage count
> > here, because there is no regulator_disable in
> > imx6_pcie_suspend_noirq,
> > where I would expect this to happen?
> > 
> Hi Lucas:
> Thanks for your comments.
> There was one regulator_disable() operation at the end of the
>  imx6_pcie_assert_core_reset() function before.
> When create the 5/8 patch, I follow the same behavior to disable the
> regulator just behind the imx6_pcie_assert_core_reset() function.
> 
> Yes, it is. Imx6_pcie_suspend_noirq doesn't have the
> regulator_disable.
> The regulaor_enable is contained in imx6_pcie_deassert_core_reset().
> Both of the regulator_disable and regulator_enabe are invoked once in
>  imx6_pcie_resume_noirq.
> So, the regulator is on and has a balanced usage count after resume.
> 

Yea, my argument is that when we are moving around the regulator
handling anyways, we should move the regulator_disable into the suspend
function. It's the right thing to do: we don't want the bus to be
powered when the system is in suspend and while the use-count is
correct, it's confusing to read the resume function otherwise.

Regards,
Lucas

