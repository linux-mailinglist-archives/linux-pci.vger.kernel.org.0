Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEAF140BB2
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2020 14:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgAQNwT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jan 2020 08:52:19 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50389 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbgAQNwS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jan 2020 08:52:18 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1isS2q-0003bt-CJ; Fri, 17 Jan 2020 14:52:16 +0100
Message-ID: <e880aba2725afe2aa5f10c4ba69366d0b0de29bb.camel@pengutronix.de>
Subject: Re: [EXT] [PATCH] PCI: imx6: Add L1SS support for i.MX8MQ
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Chris Healy <cphealy@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Fri, 17 Jan 2020 14:52:14 +0100
In-Reply-To: <CAHQ1cqFg_EcLRUtOO65P-K4hFdkx0OyzxOupqdqwicnhROiZ6A@mail.gmail.com>
References: <20200114170231.16421-1-andrew.smirnov@gmail.com>
         <AM0PR0402MB35708B48AF371E81BFCCED158C370@AM0PR0402MB3570.eurprd04.prod.outlook.com>
         <CAHQ1cqFg_EcLRUtOO65P-K4hFdkx0OyzxOupqdqwicnhROiZ6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Do, 2020-01-16 at 06:37 -0800, Andrey Smirnov wrote:
> On Tue, Jan 14, 2020 at 7:26 PM Richard Zhu <hongxing.zhu@nxp.com> wrote:
> > 
> > > -----Original Message-----
> > > From: Andrey Smirnov <andrew.smirnov@gmail.com>
> > > Sent: 2020年1月15日 1:03
> > > To: linux-pci@vger.kernel.org
> > > Cc: Andrey Smirnov <andrew.smirnov@gmail.com>; Lorenzo Pieralisi
> > > <lorenzo.pieralisi@arm.com>; Bjorn Helgaas <bhelgaas@google.com>; Chris
> > > Healy <cphealy@gmail.com>; Lucas Stach <l.stach@pengutronix.de>; Richard
> > > Zhu <hongxing.zhu@nxp.com>; dl-linux-imx <linux-imx@nxp.com>;
> > > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> > > Subject: [EXT] [PATCH] PCI: imx6: Add L1SS support for i.MX8MQ
> > > 
> > > Caution: EXT Email
> > > 
> > > Add code to configure PCI IP block to utilize supported ASPM features.
> > > 
> > > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > [Richard Zhu]  HI Andrey:
> > This patch does the regmap to the src region, right?
> 
> Indeed.
> 
> > How about to add another reset to manipulate the *_OVERRIDE bit.
> > Just like the following bits.
> >                         resets = <&src IMX8MQ_RESET_PCIEPHY>,
> >                                  <&src IMX8MQ_RESET_PCIE_CTRL_APPS_EN>,
> >                                  <&src IMX8MQ_RESET_PCIE_CTRL_APPS_TURNOFF>;
> >                         reset-names = "pciephy", "apps", "turnoff";
> > 
> 
> Last time I talked to Philipp Zabel (maintainer of reset subsystem) he
> made it pretty clear that he though that exposing those PCIe related
> bits via reset subsystem (for both imx7 and imx8mq) was a mistake and
> going forward he'd like to see only true reset functionality to be
> exposed that way. IMX8MQ_PCIE_CTRL_APPS_CLK_REQ is definitely not a
> reset line, so the case for adding it to reset driver is even weaker.
> 
> Lucas, do you mind sharing your thoughts on this?

While I'm not too happy that we are now going to have multiple paths to
those PCIe related control bits in the driver, I totally agree that we
should stop abusing the reset API for things that aren't a reset.

Maybe we should even go all the way and switch the APPS_EN bit
manipulation to use the regmap instead of the reset. This would be a DT
compatible change, as we would just ignore the apps reset specified in
old DTs and don't require any DT changes for this to work if the regmap
is looked up by compatible.

Regards,
Lucas

