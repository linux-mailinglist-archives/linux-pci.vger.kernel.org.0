Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC67A39950D
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jun 2021 23:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbhFBVCq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Jun 2021 17:02:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:57896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229467AbhFBVCq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Jun 2021 17:02:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DBF37613DC;
        Wed,  2 Jun 2021 21:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622667663;
        bh=McDhUzqzJbay/oyeCKB600HvceSnVTLSnCC3FyLLie8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ix5WlxgfkbkPtfOJ8iRsBArf39xL0dhVnu1IMeIxREYTM325r0xio068EbySpChgO
         mkIVqjxIV5F4edcWTJE7n4baq/T/ola4nxaJ83WYvB260ZBgM1aDYxLoc5mCNa9p3i
         1rI8FWhNO/mkbzjesM9dULV7PHl56kHxJKOoJON1B28Y/DYsiNJ6NF+bXHeTLiza7E
         wYzKgsbUHMH6QTd9laZIQVn2mPsOdl2ShvKDsgYDPB/t/jiO8YTflffmqxVQFOAK4R
         y3i5G7eVsvvZv94vMiFYK+V6hXV03DNtwfplr0IIpi5NyghX/Bt3bxEiRxsm6ODg4h
         opgLGdphKhlsQ==
Date:   Wed, 2 Jun 2021 16:01:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Stefan Chulski <stefanc@marvell.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Stefan Roese <sr@denx.de>, Phil Sutter <phil@nwl.cc>,
        Mario Six <mario.six@gdsys.cc>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [EXT] Re: pci mvebu issue (memory controller)
Message-ID: <20210602210101.GA2046447@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210602203917.qmxi7tcjktg6jxva@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 02, 2021 at 10:39:17PM +0200, Pali Rohár wrote:
> On Wednesday 02 June 2021 14:14:55 Bjorn Helgaas wrote:
> > On Wed, Jun 02, 2021 at 01:07:03PM +0200, Pali Rohár wrote:
> > 
> > > In configuration with *bad* suffix is used U-Boot which does not ignore
> > > PCIe device Memory controller and configure it when U-Boot initialize.
> > > In this configuration loaded kernel is unable to initialize wifi cards.
> > > 
> > > In configuration with *ok* suffix is U-Boot explicitly patched to
> > > ignores PCIe device Memory controller and loaded kernel can use wifi
> > > cards without any issue.
> > > 
> > > In both configurations is used same kernel version. As I wrote in
> > > previous emails kernel already ignores and hides Memory controller PCIe
> > > device, so lspci does not see it.
> > > 
> > > In attachment I'm sending dmesg and lspci outputs from Linux and pci
> > > output from U-Boot.
> > > 
> > > What is suspicious for me is that this Memory controller device is at
> > > the same bus as wifi card. PCIe is "point to point", so at the other end
> > > of link should be only one device... Therefore I'm not sure if kernel
> > > can handle such thing like "two PCIe devices" at other end of PCIe link.
> > > 
> > > Could you look at attached logs if you see something suspicious here? Or
> > > if you need other logs (either from U-Boot or kernel) please let me
> > > know.
> > > 
> > > Note that U-Boot does not see PCIe Bridge as it is emulated only by
> > > kernel. So U-Boot enumerates buses from zero and kernel from one (as
> > > kernel's bus zero is for emulated PCIe Bridges).
> > 
> > I've lost track of what the problem is or what patch we're evaluating.
> 
> With bad uboot (which enumerates and initialize all PCIe devices,
> including that memory controller), linux kernel is unable to use PCIe
> devices. E.g. ath10k driver fails to start. If bad uboot has disabled
> PCIe device initialization then kernel has no problems.
> 
> > Here's what I see from dmesg/lspci/uboot:
> > 
> >   # dmesg (both bad/ok) and lspci:
> >   00:01.0 [11ab:6820] Root Port to [bus 01]
> >   00:02.0 [11ab:6820] Root Port to [bus 02]
> >   00:03.0 [11ab:6820] Root Port to [bus 03]
> >   01:00.0 [168c:002e] Atheros AR9287 NIC
> >   02:00.0 [168c:0046] Atheros QCA9984 NIC
> >   03:00.0 [168c:003c] Atheros QCA986x/988x NIC
> > 
> > The above looks perfectly reasonable.
> > 
> >   # uboot (bad):
> >   00.00.00 [11ab:6820] memory controller
> >   00.01.00 [168c:002e] NIC
> >   01.00.00 [11ab:6820] memory controller
> >   01.01.00 [168c:0046] NIC
> >   02.00.00 [11ab:6820] memory controller
> >   02.01.00 [168c:003c] NIC
> > 
> > The above looks dubious at best.  Bus 00 clearly must be a root bus
> > because bus 00 can never be a bridge's secondary bus.
> > 
> > Either buses 01 and 02 need to also be root buses (e.g., if we had
> > three host bridges, one leading to bus 00, another to bus 01, and
> > another to bus 02), OR there must be Root Ports that act as bridges
> > leading from bus 00 to bus 01 and bus 02.
> 
> There are 3 independent links from CPU, so 3 independent buses. Buses 01
> and 02 are accessed directly, not via bus 00.

That sounds like the "three host bridges leading to three root buses"
scenario.  If the NICs are ordinary endpoints (not Root Complex
integrated endpoints), there must be a Root Port on each root bus, and
the Root Port and the endpoint must be on different buses (just like
any other bridge).

For example, you could have this (which seems to be what you describe
above):

  host bridge A to domain 0000 [bus 00-01]:
    00:00.0 Root Port to [bus 01]
    01:00.0 Atheros AR9287 NIC

  host bridge B to domain 0000 [bus 02-03]:
    02:00.0 Root Port to [bus 03]
    03:00.0 Atheros QCA9984 NIC

  host bridge C to domain 0000 [bus 04-05]:
    04:00.0 Root Port to [bus 05]
    05:00.0 Atheros QCA986x/988x NIC

Or, since each host bridge spawns a separate PCI hierarchy, you could
have each one in its own domain.  If the host bridges are truly
independent, this is probably a software choice and could look like
this:

  host bridge A to domain 0000 [bus 00-ff]:
    0000:00:00.0 Root Port to [bus 01]
    0000:01:00.0 Atheros AR9287 NIC

  host bridge B to domain 0001 [bus 00-ff]:
    0001:00:00.0 Root Port to [bus 01]
    0001:01:00.0 Atheros QCA9984 NIC

  host bridge C to domain 0002 [bus 00-ff]:
    0002:00:00.0 Root Port to [bus 01]
    0002:01:00.0 Atheros QCA986x/988x NIC

> Linux devices 00:01.0, 00:02.0 and 00:03.0 are just virtual devices
> created by kernel pci-bridge-emul.c driver. They are not real devices,
> they are not present on PCIe bus and therefore they cannot be visible or
> available in u-boot.

If the NICs are ordinary PCIe endpoints there must be *something* to
terminate the other end of the link.  Maybe it has some sort of
non-standard programming interface, but from a PCIe topology point of
view, it's a root port.

I don't think I can contribute anything to the stuff below.  It sounds
like there's some confusion about how to handle these root ports that
aren't exactly root ports.  That's really up to uboot and the mvebu
driver to figure out.

> Moreover kernel pci-mvebu.c controller driver filters exactly one device
> at every bus which results that "memory controller" is not visible in
> lspci.
> 
> Moreover there is mvebu specific register which seems to set device
> number on which is present this "memory controller". U-Boot sets this
> register to zero, so at XX:00.00 is "memory controller" and on XX:01.00
> is wifi card. Kernel sets this register to one, so at XX:01.00 is
> "memory controller" and on XX:00.00 is wifi card. Kernel then filter
> config read/write access to BDF XX:01.YY address.
> 
> > The "memory controllers"
> > are vendor/device ID [11ab:6820], which Linux thinks are Root Ports,
> > so I assume they are really Root Ports (or some emulation of them).
> 
> This is just coincidence that memory controller visible in PCIe config
> space has same PCI device id as virtual root bridge emulated by kernel
> pci-bridge-emul.c driver. These are totally different devices.
> 
> > It's *possible* to have both a Root Port and a NIC on bus 0, as shown
> > here.  However, the NIC would have to be a Root Complex integrated
> > Endpoint, and this NIC ([168c:002e]) is not one of those.
> 
> This is ordinary PCIe wifi card. It does not have integrated Root
> Complex. Moreover that "memory controller" device is visible (in u-boot)
> also when I disconnect wifi card.
> 
> > It's a
> > garden-variety PCIe legacy endpoint connected by a link.  So this NIC
> > cannot actually be on bus 00.
> > 
> > All these NICs are PCIe legacy endpoints with links, so they all must
> > have a Root Port leading to them.  So this topology is not really
> > possible.
> > 
> >   # uboot (ok):
> >   00.00.00 [168c:002e] NIC
> >   01.00.00 [168c:0046] NIC
> >   02.00.00 [168c:003c] NIC
> > 
> > This topology is impossible from a PCI perspective because there's no
> > way to get from bus 00 to bus 01 or 02.
> 
> This matches linux lspci output, just first bus is indexed from zero
> instead of one. In linux it is indexed from one because at zero is that
> fake/virtual bridge device emulated by linux kernel.
> 
> Does it make a little more sense now?
