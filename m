Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC96F6097B
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2019 17:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbfGEPlS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Jul 2019 11:41:18 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56089 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbfGEPlS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Jul 2019 11:41:18 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1hjQKh-00065s-CS; Fri, 05 Jul 2019 17:41:07 +0200
Message-ID: <1562341265.2321.21.camel@pengutronix.de>
Subject: Re: [PATCH] PCI: imx6: Simplify Kconfig depends on
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Trent Piepho <tpiepho@impinj.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Date:   Fri, 05 Jul 2019 17:41:05 +0200
In-Reply-To: <20190430142249.GC18742@e121166-lin.cambridge.arm.com>
References: <e3fd8e88a22468be8bd8fce85dafcc14f2e6a618.1552330407.git.leonard.crestez@nxp.com>
         <20190326181912.GB12093@e107981-ln.cambridge.arm.com>
         <VI1PR04MB5533A64718D373F9F8357BCDEE280@VI1PR04MB5533.eurprd04.prod.outlook.com>
         <1555092208.2142.50.camel@impinj.com>
         <VI1PR04MB55338F78DED082D13A78585BEE280@VI1PR04MB5533.eurprd04.prod.outlook.com>
         <20190430142249.GC18742@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Dienstag, den 30.04.2019, 15:22 +0100 schrieb Lorenzo Pieralisi:
> On Fri, Apr 12, 2019 at 06:20:53PM +0000, Leonard Crestez wrote:
> > On 4/12/2019 9:03 PM, Trent Piepho wrote:
> > > On Fri, 2019-04-12 at 17:56 +0000, Leonard Crestez wrote:
> > > > On 3/26/19 8:19 PM, Lorenzo Pieralisi wrote:
> > > > > On Mon, Mar 11, 2019 at 06:59:28PM +0000, Leonard Crestez wrote:
> > > > > > In theory this driver can be used on imx6sx without enabling support for
> > > > > > imx6q or imx7d but the "depends on" condition doesn't allow that.
> > > > > > 
> > > > > > Instead of making the condition even longer just make it depend on
> > > > > > "ARCH_MXC || COMPILE_TEST" instead.
> > > > > > 
> > > > > > > > > > > > Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> > > > > > ---
> > > > > >    drivers/pci/controller/dwc/Kconfig | 2 +-
> > > > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > > > > > index 6ea74b1c0d94..21747fd0e799 100644
> > > > > > --- a/drivers/pci/controller/dwc/Kconfig
> > > > > > +++ b/drivers/pci/controller/dwc/Kconfig
> > > > > > @@ -88,11 +88,11 @@ config PCI_EXYNOS
> > > > > >            depends on PCI_MSI_IRQ_DOMAIN
> > > > > >            select PCIE_DW_HOST
> > > > > > 
> > > > > >    config PCI_IMX6
> > > > > >            bool "Freescale i.MX6/7/8 PCIe controller"
> > > > > > - depends on SOC_IMX6Q || SOC_IMX7D || (ARM64 && ARCH_MXC) || COMPILE_TEST
> > > > > > + depends on ARCH_MXC || COMPILE_TEST
> > > > > >            depends on PCI_MSI_IRQ_DOMAIN
> > > > > >            select PCIE_DW_HOST
> > > > > 
> > > > > If Lucas does not spot any problem with this patch I would request his
> > > > > ACK to merge it, thanks.
> > > > 
> > > > Lucas: Can you please ack this? It's a bit old but applies cleanly and
> > > > resend shouldn't be required.
> > > 
> > > The IMX7s does not have a PCI-e controller.  The IMX7d does have one,
> > > but not the "s".
> > > 
> > > Enabling the controller driver on an IMX SoC that doesn't have it is
> > > not exactly the end of the world and having to keep adding new IMX SOCs
> > > to the list here is annoying.  So IMHO, it's ok to make this change
> > > even if the controller is allowed on a superset of the SoCs that have
> > > it.
> > 
> > There is no separate config option for IMX7S and I don't think it will 
> > be ever added. There is however a CONFIG_SOC_IMX6SX.
> > 
> > There were attempts to add "depends on"/"selected by" IMX8MQ to various 
> > drivers but arm64 maintainers disagreed. This is why this patch fixes 
> > the "depends on" list for 6sx pcie by dropping per-SOC logic on 32-bit 
> > arm as well.
> > 
> > People who want very small kernels for their boards will likely fiddle 
> > with their specific defconfig anyway so maybe complex logic in Kconfig 
> > is not very helpful.
> 
> My request still stands, please let me know.

I've acked the resend, but that one doesn't show up in patchwork for
some reason, so:

Acked-by: Lucas Stach <l.stach@pengutronix.de>

Regards,
Lucas

