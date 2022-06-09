Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8449E54452C
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jun 2022 09:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbiFIHzZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jun 2022 03:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbiFIHzY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jun 2022 03:55:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342A72E4
        for <linux-pci@vger.kernel.org>; Thu,  9 Jun 2022 00:55:23 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1nzD0c-0002lU-Le; Thu, 09 Jun 2022 09:55:14 +0200
Message-ID: <e496d9d52064d25a8a0ce3c6aa1debfc134b8147.camel@pengutronix.de>
Subject: Re: [PATCH v9 6/8] PCI: imx6: Disable clocks and regulators after
 link is down
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
Date:   Thu, 09 Jun 2022 09:55:13 +0200
In-Reply-To: <AS8PR04MB86763AE6FF5BABE3EBED833B8CA79@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1651801629-30223-1-git-send-email-hongxing.zhu@nxp.com>
         <1651801629-30223-7-git-send-email-hongxing.zhu@nxp.com>
         <5be4f4322e00e33fa9417280b0d74ecb7aab913e.camel@pengutronix.de>
         <AS8PR04MB86763AE6FF5BABE3EBED833B8CA79@AS8PR04MB8676.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Donnerstag, dem 09.06.2022 um 06:17 +0000 schrieb Hongxing Zhu:
> > -----Original Message-----
> > From: Lucas Stach <l.stach@pengutronix.de>
> > Sent: 2022年6月8日 15:35
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>; bhelgaas@google.com;
> > robh+dt@kernel.org; broonie@kernel.org; lorenzo.pieralisi@arm.com;
> > jingoohan1@gmail.com; festevam@gmail.com;
> > francesco.dolcini@toradex.com
> > Cc: linux-pci@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; kernel@pengutronix.de; dl-linux-imx
> > <linux-imx@nxp.com>
> > Subject: Re: [PATCH v9 6/8] PCI: imx6: Disable clocks and
> > regulators after link is
> > down
> > 
> > Am Freitag, dem 06.05.2022 um 09:47 +0800 schrieb Richard Zhu:
> > > Since i.MX PCIe doesn't support hot-plug, reduce power
> > > consumption as
> > > much as possible by disabling clocks and regulators and returning
> > > error when the link is down.
> > > 
> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > ---
> > >  drivers/pci/controller/dwc/pci-imx6.c | 19 +++++++++++++++----
> > >  1 file changed, 15 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > > b/drivers/pci/controller/dwc/pci-imx6.c
> > > index 3ce3993d5797..d122c12193a6 100644
> > > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > > @@ -845,7 +845,9 @@ static int imx6_pcie_start_link(struct
> > > dw_pcie *pci)
> > >  	/* Start LTSSM. */
> > >  	imx6_pcie_ltssm_enable(dev);
> > > 
> > > -	dw_pcie_wait_for_link(pci);
> > > +	ret = dw_pcie_wait_for_link(pci);
> > > +	if (ret)
> > > +		goto err_out;
> > 
> > This adds back error handling that has been intentionally removed
> > in
> > f81f095e8771 ("PCI: imx6: Allow to probe when
> > dw_pcie_wait_for_link() fails").
> > While I agree that disabling the clocks and regulators is the right
> > thing to do
> > when we don't manage to get a link, we should still allow the
> > driver to probe,
> > so please add a "ret = 0" to this newly added non-fatal error
> > paths.
> > 
> Thanks for your review comments.
> There would be a long latency if the link is down and probe is
> finished
>  successfully.
> Since the dw_pcie_wait_for_link() would be invoked twice in every
> driver probe
>  and resume operation later. Each dw_pcie_wait_for_link() would
> consume about
>  90,000*10 ~ 100,000*10 u-seconds. I'm afraid that such a long
> latency would
>  bring bad user experience.
> 
> Here are the logs when probe is allowed when PCIe link is down:
> [   55.045954][ T1835] imx6q-pcie 5f000000.pcie: PM: calling
> imx6_pcie_resume_noirq.742dfa074b40dca7ca925f0c49c905ec.cfi_jt+0x0/0x
> 8 @ 1835, parent: bus@5f000000
> ...
> [   56.074566][ T1835] imx6q-pcie 5f000000.pcie: Phy link never came
> up
> [   57.074816][ T1835] imx6q-pcie 5f000000.pcie: Phy link never came
> up
> ...
> [   57.182300][ T1835] imx6q-pcie 5f000000.pcie: PM:
> imx6_pcie_resume_noirq.742dfa074b40dca7ca925f0c49c905ec.cfi_jt+0x0/0x
> 8 returned 0 after 2136334 usecs
> 
> [   57.182347][ T1835] imx6q-pcie 5f010000.pcie: PM: calling
> imx6_pcie_resume_noirq.742dfa074b40dca7ca925f0c49c905ec.cfi_jt+0x0/0x
> 8 @ 1835, parent: bus@5f000000
> ...
> [   58.210584][ T1835] imx6q-pcie 5f010000.pcie: Phy link never came
> up
> [   59.210831][ T1835] imx6q-pcie 5f010000.pcie: Phy link never came
> up
> ...
> [   59.318313][ T1835] imx6q-pcie 5f010000.pcie: PM:
> imx6_pcie_resume_noirq.742dfa074b40dca7ca925f0c49c905ec.cfi_jt+0x0/0x
> 8 returned 0 after 2135949 usecs
> 
> So, I'm prefer that it's better to let the probe failed when link is
> down. 
> How do you think about that?

It different from the behavior of other platforms, that still show the
root bridge in lspci, even if the link is down. I've seen people
confused by this behavior. Come to think about it: does lspci work when
all the clocks are disabled?

The latency in the probe path is not that relevant, as it is done
asynchronous, so it doesn't stall the boot process. You have a point on
the suspend/resume path however. Maybe we need to remember the link
state in suspend to know if resume should even do anything useful?

Regards,
Lucas

> 
> > > 
> > >  	if (pci->link_gen == 2) {
> > >  		/* Allow Gen2 mode after the link is up. */ @@ -
> > > 876,12 +878,14
> > @@
> > > static int imx6_pcie_start_link(struct dw_pcie *pci)
> > >  			ret =
> > > imx6_pcie_wait_for_speed_change(imx6_pcie);
> > >  			if (ret) {
> > >  				dev_err(dev, "Failed to bring
> > > link up!\n");
> > > -				goto err_reset_phy;
> > > +				goto err_out;
> > >  			}
> > >  		}
> > > 
> > >  		/* Make sure link training is finished as well!
> > > */
> > > -		dw_pcie_wait_for_link(pci);
> > > +		ret = dw_pcie_wait_for_link(pci);
> > > +		if (ret)
> > > +			goto err_out;
> > >  	} else {
> > >  		dev_info(dev, "Link: Gen2 disabled\n");
> > >  	}
> > > @@ -890,11 +894,18 @@ static int imx6_pcie_start_link(struct
> > > dw_pcie
> > *pci)
> > >  	dev_info(dev, "Link up, Gen%i\n", tmp &
> > > PCI_EXP_LNKSTA_CLS);
> > >  	return 0;
> > > 
> > > -err_reset_phy:
> > > +err_out:
> > >  	dev_dbg(dev, "PHY DEBUG_R0=0x%08x DEBUG_R1=0x%08x\n",
> > >  		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0),
> > >  		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG1));
> > >  	imx6_pcie_reset_phy(imx6_pcie);
> > > +	imx6_pcie_clk_disable(imx6_pcie);
> > > +	if (imx6_pcie->phy != NULL) {
> > 
> > Please use the more common if (imx6_pcie->phy) here.
> > 
> Okay. Thanks.
> 
> Best Regards
> Richard Zhu
> 
> > Regards,
> > Lucas
> > 
> > > +		phy_power_off(imx6_pcie->phy);
> > > +		phy_exit(imx6_pcie->phy);
> > > +	}
> > > +	if (imx6_pcie->vpcie)
> > > +		regulator_disable(imx6_pcie->vpcie);
> > >  	return ret;
> > >  }
> > > 
> > 
> 


