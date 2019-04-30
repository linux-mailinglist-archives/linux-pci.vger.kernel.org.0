Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55C28FB51
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2019 16:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbfD3OW6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Apr 2019 10:22:58 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48202 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfD3OWz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Apr 2019 10:22:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42EE280D;
        Tue, 30 Apr 2019 07:22:54 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 87ECA3F719;
        Tue, 30 Apr 2019 07:22:52 -0700 (PDT)
Date:   Tue, 30 Apr 2019 15:22:49 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Trent Piepho <tpiepho@impinj.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] PCI: imx6: Simplify Kconfig depends on
Message-ID: <20190430142249.GC18742@e121166-lin.cambridge.arm.com>
References: <e3fd8e88a22468be8bd8fce85dafcc14f2e6a618.1552330407.git.leonard.crestez@nxp.com>
 <20190326181912.GB12093@e107981-ln.cambridge.arm.com>
 <VI1PR04MB5533A64718D373F9F8357BCDEE280@VI1PR04MB5533.eurprd04.prod.outlook.com>
 <1555092208.2142.50.camel@impinj.com>
 <VI1PR04MB55338F78DED082D13A78585BEE280@VI1PR04MB5533.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB55338F78DED082D13A78585BEE280@VI1PR04MB5533.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 12, 2019 at 06:20:53PM +0000, Leonard Crestez wrote:
> On 4/12/2019 9:03 PM, Trent Piepho wrote:
> > On Fri, 2019-04-12 at 17:56 +0000, Leonard Crestez wrote:
> >> On 3/26/19 8:19 PM, Lorenzo Pieralisi wrote:
> >>> On Mon, Mar 11, 2019 at 06:59:28PM +0000, Leonard Crestez wrote:
> >>>> In theory this driver can be used on imx6sx without enabling support for
> >>>> imx6q or imx7d but the "depends on" condition doesn't allow that.
> >>>>
> >>>> Instead of making the condition even longer just make it depend on
> >>>> "ARCH_MXC || COMPILE_TEST" instead.
> >>>>
> >>>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> >>>> ---
> >>>>    drivers/pci/controller/dwc/Kconfig | 2 +-
> >>>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> >>>> index 6ea74b1c0d94..21747fd0e799 100644
> >>>> --- a/drivers/pci/controller/dwc/Kconfig
> >>>> +++ b/drivers/pci/controller/dwc/Kconfig
> >>>> @@ -88,11 +88,11 @@ config PCI_EXYNOS
> >>>>            depends on PCI_MSI_IRQ_DOMAIN
> >>>>            select PCIE_DW_HOST
> >>>>
> >>>>    config PCI_IMX6
> >>>>            bool "Freescale i.MX6/7/8 PCIe controller"
> >>>> - depends on SOC_IMX6Q || SOC_IMX7D || (ARM64 && ARCH_MXC) || COMPILE_TEST
> >>>> + depends on ARCH_MXC || COMPILE_TEST
> >>>>            depends on PCI_MSI_IRQ_DOMAIN
> >>>>            select PCIE_DW_HOST
> >>>
> >>> If Lucas does not spot any problem with this patch I would request his
> >>> ACK to merge it, thanks.
> >>
> >> Lucas: Can you please ack this? It's a bit old but applies cleanly and
> >> resend shouldn't be required.
> > 
> > The IMX7s does not have a PCI-e controller.  The IMX7d does have one,
> > but not the "s".
> > 
> > Enabling the controller driver on an IMX SoC that doesn't have it is
> > not exactly the end of the world and having to keep adding new IMX SOCs
> > to the list here is annoying.  So IMHO, it's ok to make this change
> > even if the controller is allowed on a superset of the SoCs that have
> > it.
> 
> There is no separate config option for IMX7S and I don't think it will 
> be ever added. There is however a CONFIG_SOC_IMX6SX.
> 
> There were attempts to add "depends on"/"selected by" IMX8MQ to various 
> drivers but arm64 maintainers disagreed. This is why this patch fixes 
> the "depends on" list for 6sx pcie by dropping per-SOC logic on 32-bit 
> arm as well.
> 
> People who want very small kernels for their boards will likely fiddle 
> with their specific defconfig anyway so maybe complex logic in Kconfig 
> is not very helpful.

My request still stands, please let me know.

Thanks,
Lorenzo
