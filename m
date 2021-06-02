Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23363994B1
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jun 2021 22:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhFBUlE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Jun 2021 16:41:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:52552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229769AbhFBUlD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Jun 2021 16:41:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE0A8613EB;
        Wed,  2 Jun 2021 20:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622666360;
        bh=RnDucqTl0DhJdwRRTFh/wYT9MGMWdrcgALIbg0jwrvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jTIEhR1a3vjDyFPdns4y8HWNNmTEKmABAei9eJAdVw8u4nU1Wl6ygcmw4lFIrxnbz
         1d+wETcCA+GxhDUCq/FBqbF2dQLIcq8YOJQ+B4NbfRFXl+Ayy74f68MVfQ65NS44+X
         GoTpUxxPOBBegUskTWoYv98wnG1nA22R2Q42LDeewSVJhgVSEN0/UKRZ8RUTMITtI+
         1ApfbEdPeodsx9vklJQ4cSajWNW1LfxCbgLIytivQBqHpiJsdwvcRA4mPKQWU5K6Ig
         ZBOcTwn4r1FrWaDLHy8SBsYYym6e4XUcDYBllYxXBa7ytlzUzlECUFZd8/cyOtgAnl
         rJEGRYXDRx3rw==
Received: by pali.im (Postfix)
        id 5B5EA1534; Wed,  2 Jun 2021 22:39:17 +0200 (CEST)
Date:   Wed, 2 Jun 2021 22:39:17 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Stefan Chulski <stefanc@marvell.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Stefan Roese <sr@denx.de>, Phil Sutter <phil@nwl.cc>,
        Mario Six <mario.six@gdsys.cc>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [EXT] Re: pci mvebu issue (memory controller)
Message-ID: <20210602203917.qmxi7tcjktg6jxva@pali>
References: <20210602110703.ymdt6nxsjl7e6glk@pali>
 <20210602191455.GA2038253@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210602191455.GA2038253@bjorn-Precision-5520>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 02 June 2021 14:14:55 Bjorn Helgaas wrote:
> On Wed, Jun 02, 2021 at 01:07:03PM +0200, Pali Rohár wrote:
> 
> > In configuration with *bad* suffix is used U-Boot which does not ignore
> > PCIe device Memory controller and configure it when U-Boot initialize.
> > In this configuration loaded kernel is unable to initialize wifi cards.
> > 
> > In configuration with *ok* suffix is U-Boot explicitly patched to
> > ignores PCIe device Memory controller and loaded kernel can use wifi
> > cards without any issue.
> > 
> > In both configurations is used same kernel version. As I wrote in
> > previous emails kernel already ignores and hides Memory controller PCIe
> > device, so lspci does not see it.
> > 
> > In attachment I'm sending dmesg and lspci outputs from Linux and pci
> > output from U-Boot.
> > 
> > What is suspicious for me is that this Memory controller device is at
> > the same bus as wifi card. PCIe is "point to point", so at the other end
> > of link should be only one device... Therefore I'm not sure if kernel
> > can handle such thing like "two PCIe devices" at other end of PCIe link.
> > 
> > Could you look at attached logs if you see something suspicious here? Or
> > if you need other logs (either from U-Boot or kernel) please let me
> > know.
> > 
> > Note that U-Boot does not see PCIe Bridge as it is emulated only by
> > kernel. So U-Boot enumerates buses from zero and kernel from one (as
> > kernel's bus zero is for emulated PCIe Bridges).
> 
> I've lost track of what the problem is or what patch we're evaluating.

With bad uboot (which enumerates and initialize all PCIe devices,
including that memory controller), linux kernel is unable to use PCIe
devices. E.g. ath10k driver fails to start. If bad uboot has disabled
PCIe device initialization then kernel has no problems.

> Here's what I see from dmesg/lspci/uboot:
> 
>   # dmesg (both bad/ok) and lspci:
>   00:01.0 [11ab:6820] Root Port to [bus 01]
>   00:02.0 [11ab:6820] Root Port to [bus 02]
>   00:03.0 [11ab:6820] Root Port to [bus 03]
>   01:00.0 [168c:002e] Atheros AR9287 NIC
>   02:00.0 [168c:0046] Atheros QCA9984 NIC
>   03:00.0 [168c:003c] Atheros QCA986x/988x NIC
> 
> The above looks perfectly reasonable.
> 
>   # uboot (bad):
>   00.00.00 [11ab:6820] memory controller
>   00.01.00 [168c:002e] NIC
>   01.00.00 [11ab:6820] memory controller
>   01.01.00 [168c:0046] NIC
>   02.00.00 [11ab:6820] memory controller
>   02.01.00 [168c:003c] NIC
> 
> The above looks dubious at best.  Bus 00 clearly must be a root bus
> because bus 00 can never be a bridge's secondary bus.
> 
> Either buses 01 and 02 need to also be root buses (e.g., if we had
> three host bridges, one leading to bus 00, another to bus 01, and
> another to bus 02), OR there must be Root Ports that act as bridges
> leading from bus 00 to bus 01 and bus 02.

There are 3 independent links from CPU, so 3 independent buses. Buses 01
and 02 are accessed directly, not via bus 00.

Linux devices 00:01.0, 00:02.0 and 00:03.0 are just virtual devices
created by kernel pci-bridge-emul.c driver. They are not real devices,
they are not present on PCIe bus and therefore they cannot be visible or
available in u-boot.

Moreover kernel pci-mvebu.c controller driver filters exactly one device
at every bus which results that "memory controller" is not visible in
lspci.

Moreover there is mvebu specific register which seems to set device
number on which is present this "memory controller". U-Boot sets this
register to zero, so at XX:00.00 is "memory controller" and on XX:01.00
is wifi card. Kernel sets this register to one, so at XX:01.00 is
"memory controller" and on XX:00.00 is wifi card. Kernel then filter
config read/write access to BDF XX:01.YY address.

> The "memory controllers"
> are vendor/device ID [11ab:6820], which Linux thinks are Root Ports,
> so I assume they are really Root Ports (or some emulation of them).

This is just coincidence that memory controller visible in PCIe config
space has same PCI device id as virtual root bridge emulated by kernel
pci-bridge-emul.c driver. These are totally different devices.

> It's *possible* to have both a Root Port and a NIC on bus 0, as shown
> here.  However, the NIC would have to be a Root Complex integrated
> Endpoint, and this NIC ([168c:002e]) is not one of those.

This is ordinary PCIe wifi card. It does not have integrated Root
Complex. Moreover that "memory controller" device is visible (in u-boot)
also when I disconnect wifi card.

> It's a
> garden-variety PCIe legacy endpoint connected by a link.  So this NIC
> cannot actually be on bus 00.
> 
> All these NICs are PCIe legacy endpoints with links, so they all must
> have a Root Port leading to them.  So this topology is not really
> possible.
> 
>   # uboot (ok):
>   00.00.00 [168c:002e] NIC
>   01.00.00 [168c:0046] NIC
>   02.00.00 [168c:003c] NIC
> 
> This topology is impossible from a PCI perspective because there's no
> way to get from bus 00 to bus 01 or 02.

This matches linux lspci output, just first bus is indexed from zero
instead of one. In linux it is indexed from one because at zero is that
fake/virtual bridge device emulated by linux kernel.

Does it make a little more sense now?
