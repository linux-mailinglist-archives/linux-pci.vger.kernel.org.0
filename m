Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6B437A9F1
	for <lists+linux-pci@lfdr.de>; Tue, 11 May 2021 16:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbhEKOzY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 May 2021 10:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbhEKOzV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 May 2021 10:55:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B5AC061574
        for <linux-pci@vger.kernel.org>; Tue, 11 May 2021 07:54:15 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1lgTlx-0001dn-48; Tue, 11 May 2021 16:54:09 +0200
Message-ID: <2ea9546c7dc1644376576db2cb01005fb041f349.camel@pengutronix.de>
Subject: Re: [PATCH 3/7] PCI: imx6: Rework PHY search and mapping
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        Sascha Hauer <kernel@pengutronix.de>,
        patchwork-lst@pengutronix.de
Date:   Tue, 11 May 2021 16:54:08 +0200
In-Reply-To: <CAL_Jsq+dkJ+bbuQDQieHdocjLoNKN2vib8scJsdGnCnffSGAcA@mail.gmail.com>
References: <20210510141509.929120-1-l.stach@pengutronix.de>
         <20210510141509.929120-3-l.stach@pengutronix.de>
         <20210510170510.GA276768@robh.at.kernel.org>
         <854ec10d9a32df97d1f53a784dffca4e5036b059.camel@pengutronix.de>
         <CAL_Jsq+dkJ+bbuQDQieHdocjLoNKN2vib8scJsdGnCnffSGAcA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.1 (3.40.1-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Dienstag, dem 11.05.2021 um 09:21 -0500 schrieb Rob Herring:
> On Tue, May 11, 2021 at 3:11 AM Lucas Stach <l.stach@pengutronix.de> wrote:
> > 
> > Am Montag, dem 10.05.2021 um 12:05 -0500 schrieb Rob Herring:
> > > On Mon, May 10, 2021 at 04:15:05PM +0200, Lucas Stach wrote:
> > > > We don't need to have a phandle of the PHY, as we know the compatible
> > > > of the node we are looking for. This will make it easier to put add
> > > > more PHY handling for new generations later on, where the
> > > > "fsl,imx7d-pcie-phy" phandle would be a misnomer.
> > > > 
> > > > Also we can use a helper function to get the resource for us,
> > > > simplifying out driver code a bit.
> > > 
> > > Better yes, but really all the phy handling should be split out to
> > > its own driver even in the older h/w with shared phy registers.
> > > 
> > That would be a quite massive DT binding changing break, possibly even
> > a separate driver. Maybe it's time to do this for i.MX8MM, as the
> > current driver just kept piling on special cases for "almost the same"
> > hardware that by now looks quite different to the original i.MX6 PCIe
> > integration this driver was supposed to handle.
> 
> No, you don't need to change DT, and a DT change adding a phy node
> wouldn't even be correct modeling of the h/w IMO. For the i.MX6 phy, a
> separate PHY driver would have to create its own platform device in
> its initcall (if the iMX6 PCI compatible is found). Then the PCI
> driver would need to use a non-DT based phy_get() lookup. For the
> cases with a phandle to the phy, I'd assume a phy driver could be
> instantiated for that node. You'll again need a non-DT phy_get() if
> not using the phy binding.

The original i.MX6 PCIe with the internal PHY is the easy case, as you
laid out above.

What I'm more concerned about is the i.MX7 and i.MX8MQ, where we have a
MMIO mapped PHY and quite a bit of the clocks/reset/GPR handling would
need to move from the controller to the PHY driver. Without a binding
change I fear that we end up in a worst of both worlds situation, where
we have lots of code in the driver to separate resources that are
currently all attached to the PCIe controller node in the DT, without a
real gain in making the driver any simpler or easier to maintain.

But right now that's all speculation. Maybe I need to type something up
and see where it falls on the shiny/horrible scale.

Regards,
Lucas

