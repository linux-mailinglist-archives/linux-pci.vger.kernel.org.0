Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A44F609FFF
	for <lists+linux-pci@lfdr.de>; Mon, 24 Oct 2022 13:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiJXLOe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Oct 2022 07:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiJXLOb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Oct 2022 07:14:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0663BE01F
        for <linux-pci@vger.kernel.org>; Mon, 24 Oct 2022 04:14:28 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1omvPW-0004su-Pc; Mon, 24 Oct 2022 13:14:26 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1omvPW-0008Ab-8M; Mon, 24 Oct 2022 13:14:26 +0200
Date:   Mon, 24 Oct 2022 13:14:26 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH] PCI: imx6: Fix link initialisation when the phy is ref
 clk provider
Message-ID: <20221024111426.GM6702@pengutronix.de>
References: <20221012132634.267970-1-s.hauer@pengutronix.de>
 <20221013140450.GA3244741@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013140450.GA3244741@bhelgaas>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 13, 2022 at 09:04:50AM -0500, Bjorn Helgaas wrote:
> Would you mind rewording the subject so it says something more
> specific about what the patch does?  E.g.,
> 
>   PCI: imx6: Initialize PHY before deasserting core reset

Ok.

> 
> It may be that this ordering is only *required* when the PHY is the
> ref clk provider, but the patch doesn't test for that; it *always*
> initializes the PHY first.

Yes, it is only required when the PHY is the ref clk provider.
It shouldn't hurt though when the ref clk is generated elsewhere.

The PCI host driver doesn't know about the ref clk provider, that
knowledge is limited to the phy driver only.

Sascha

> 
> On Wed, Oct 12, 2022 at 03:26:34PM +0200, Sascha Hauer wrote:
> > When the phy is the reference clock provider then it must be initialised
> > and powered on before the reset on the client is deasserted, otherwise
> > the link will never come up. The order was changed in cf236e0c0d59.
> > Restore the correct order to make the driver work again on boards where
> > the phy provides the reference clock.
> 
> s/phy/PHY/ several places above
> 
> > Fixes: cf236e0c0d59 ("PCI: imx6: Do not hide PHY driver callbacks and refine the error handling")
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index b5f0de455a7bd..211eb55d6d34b 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -942,12 +942,6 @@ static int imx6_pcie_host_init(struct dw_pcie_rp *pp)
> >  		}
> >  	}
> >  
> > -	ret = imx6_pcie_deassert_core_reset(imx6_pcie);
> > -	if (ret < 0) {
> > -		dev_err(dev, "pcie deassert core reset failed: %d\n", ret);
> > -		goto err_phy_off;
> > -	}
> > -
> >  	if (imx6_pcie->phy) {
> >  		ret = phy_power_on(imx6_pcie->phy);
> >  		if (ret) {
> > @@ -955,6 +949,13 @@ static int imx6_pcie_host_init(struct dw_pcie_rp *pp)
> >  			goto err_phy_off;
> >  		}
> >  	}
> > +
> > +	ret = imx6_pcie_deassert_core_reset(imx6_pcie);
> > +	if (ret < 0) {
> > +		dev_err(dev, "pcie deassert core reset failed: %d\n", ret);
> > +		goto err_phy_off;
> > +	}
> > +
> >  	imx6_setup_phy_mpll(imx6_pcie);
> >  
> >  	return 0;
> > -- 
> > 2.30.2
> > 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
