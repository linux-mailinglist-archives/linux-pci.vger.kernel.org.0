Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD96C93E8
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2019 23:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfJBV7l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Oct 2019 17:59:41 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:32962 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfJBV7l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Oct 2019 17:59:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qwaMCw5+GH89GY4D31Ks8Y7B/aUlyWSrhEUdNOLlI+o=; b=I0e08Ri3YtCzhJKOHSGe8WnDm
        6p6A5AP8uCicID35A9JaihTSz34ChubKqEJ7tugY1yQ5sUBTHO0JRJDj6gLZjfTE14RR9nUPqXZvs
        90/4/yVAlQjHkUhQX+JjPF+8+fKl/jjJe7clxYByP1+Nnr6TCPcjvK/rKTMm99TFrk7XiLlv1nUqF
        n0O9D7BI0XSz2AyUACe4iSCANRuO1iAOOnacB22Go6UAOmqTLk+tuJ3tPSoeMWRCHu5rPzYCPqK8O
        BUxz0Kx7R4ksZQyHq1y6evGKqCRnqRASLPtElVrbCCtauh9qmBWgmfSRFupq/T6i3gcDcZJIN9fpJ
        FWsBpRFrQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50976)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iFmee-0002bh-6m; Wed, 02 Oct 2019 22:59:29 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iFmeW-00014i-96; Wed, 02 Oct 2019 22:59:20 +0100
Date:   Wed, 2 Oct 2019 22:59:20 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Xiaowei Bao <xiaowei.bao@nxp.com>, mark.rutland@arm.com,
        devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, Zhiqiang.Hou@nxp.com,
        linux-kernel@vger.kernel.org, leoyang.li@nxp.com,
        Minghuan.Lian@nxp.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, andrew.murray@arm.com,
        kishon@ti.com, shawnguo@kernel.org, mingkai.hu@nxp.com
Subject: Re: [PATCH 0/6] Add the Mobiveil EP and Layerscape Gen4 EP driver
 support
Message-ID: <20191002215920.GU25745@shell.armlinux.org.uk>
References: <20190924155223.GX25745@shell.armlinux.org.uk>
 <20191002211421.GA64972@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002211421.GA64972@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 02, 2019 at 04:14:21PM -0500, Bjorn Helgaas wrote:
> On Tue, Sep 24, 2019 at 04:52:23PM +0100, Russell King - ARM Linux admin wrote:
> > On Tue, Sep 24, 2019 at 03:18:47PM +0100, Russell King - ARM Linux admin wrote:
> > > On Mon, Sep 16, 2019 at 10:17:36AM +0800, Xiaowei Bao wrote:
> > > > This patch set are for adding Mobiveil EP driver and adding PCIe Gen4
> > > > EP driver of NXP Layerscape platform.
> > > > 
> > > > This patch set depends on:
> > > > https://patchwork.kernel.org/project/linux-pci/list/?series=159139
> > > > 
> > > > Xiaowei Bao (6):
> > > >   PCI: mobiveil: Add the EP driver support
> > > >   dt-bindings: Add DT binding for PCIE GEN4 EP of the layerscape
> > > >   PCI: mobiveil: Add PCIe Gen4 EP driver for NXP Layerscape SoCs
> > > >   PCI: mobiveil: Add workaround for unsupported request error
> > > >   arm64: dts: lx2160a: Add PCIe EP node
> > > >   misc: pci_endpoint_test: Add the layerscape PCIe GEN4 EP device
> > > >     support
> > > > 
> > > >  .../bindings/pci/layerscape-pcie-gen4.txt          |  28 +-
> > > >  MAINTAINERS                                        |   3 +
> > > >  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     |  56 ++
> > > >  drivers/misc/pci_endpoint_test.c                   |   2 +
> > > >  drivers/pci/controller/mobiveil/Kconfig            |  22 +-
> > > >  drivers/pci/controller/mobiveil/Makefile           |   2 +
> > > >  .../controller/mobiveil/pcie-layerscape-gen4-ep.c  | 169 ++++++
> > > >  drivers/pci/controller/mobiveil/pcie-mobiveil-ep.c | 568 +++++++++++++++++++++
> > > >  drivers/pci/controller/mobiveil/pcie-mobiveil.c    |  99 +++-
> > > >  drivers/pci/controller/mobiveil/pcie-mobiveil.h    |  72 +++
> > > >  10 files changed, 1009 insertions(+), 12 deletions(-)
> > > >  create mode 100644 drivers/pci/controller/mobiveil/pcie-layerscape-gen4-ep.c
> > > >  create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil-ep.c
> > > 
> > > Hi,
> > > 
> > > I've applied "PCI: mobiveil: Fix the CPU base address setup in inbound
> > > window" and your patch set to 5.3, which seems to be able to detect the
> > > PCIe card I have plugged in:
> > > 
> > > layerscape-pcie-gen4 3800000.pcie: host bridge /soc/pcie@3800000 ranges:
> > > layerscape-pcie-gen4 3800000.pcie:   MEM 0xa040000000..0xa07fffffff -> 0x40000000
> > > layerscape-pcie-gen4 3800000.pcie: PCI host bridge to bus 0000:00
> > > pci_bus 0000:00: root bus resource [bus 00-ff]
> > > pci_bus 0000:00: root bus resource [mem 0xa040000000-0xa07fffffff] (bus address
> > > [0x40000000-0x7fffffff])
> > > pci 0000:00:00.0: [1957:8d90] type 01 class 0x060400
> > > pci 0000:00:00.0: enabling Extended Tags
> > > pci 0000:00:00.0: supports D1 D2
> > > pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> > > pci 0000:01:00.0: [15b3:6750] type 00 class 0x020000
> > > pci 0000:01:00.0: reg 0x10: [mem 0xa040000000-0xa0400fffff 64bit]
> > > pci 0000:01:00.0: reg 0x18: [mem 0xa040800000-0xa040ffffff 64bit pref]
> > > pci 0000:01:00.0: reg 0x30: [mem 0xa041000000-0xa0410fffff pref]
> > > pci 0000:00:00.0: up support 3 enabled 0
> > > pci 0000:00:00.0: dn support 1 enabled 0
> > > pci 0000:00:00.0: BAR 9: assigned [mem 0xa040000000-0xa0407fffff 64bit pref]
> > > pci 0000:00:00.0: BAR 8: assigned [mem 0xa040800000-0xa0409fffff]
> > > pci 0000:01:00.0: BAR 2: assigned [mem 0xa040000000-0xa0407fffff 64bit pref]
> > > pci 0000:01:00.0: BAR 0: assigned [mem 0xa040800000-0xa0408fffff 64bit]
> > > pci 0000:01:00.0: BAR 6: assigned [mem 0xa040900000-0xa0409fffff pref]
> > > pci 0000:00:00.0: PCI bridge to [bus 01-ff]
> > > pci 0000:00:00.0:   bridge window [mem 0xa040800000-0xa0409fffff]
> > > pci 0000:00:00.0:   bridge window [mem 0xa040000000-0xa0407fffff 64bit pref]
> > > pci 0000:00:00.0: Max Payload Size set to  256/ 256 (was  128), Max Read Rq  256pci 0000:01:00.0: Max Payload Size set to  256/ 256 (was  128), Max Read Rq  256pcieport 0000:00:00.0: PCIe capabilities: 0x13
> > > pcieport 0000:00:00.0: init_service_irqs: -19
> > > 
> > > However, a bit later in the kernel boot, I get:
> > > 
> > > SError Interrupt on CPU1, code 0xbf000002 -- SError
> > > CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.3.0+ #392
> > > Hardware name: SolidRun LX2160A COM express type 7 module (DT)
> > > pstate: 60400085 (nZCv daIf +PAN -UAO)
> > > pc : pci_generic_config_read+0xb0/0xc0
> > > lr : pci_generic_config_read+0x1c/0xc0
> > > sp : ffffff8010f9baf0
> > > x29: ffffff8010f9baf0 x28: ffffff8010d620a0
> > > x27: ffffff8010d79000 x26: ffffff8010d62000
> > > x25: ffffff8010cb06d4 x24: 0000000000000000
> > > x23: ffffff8010e499b8 x22: ffffff8010f9bbaf
> > > x21: 0000000000000000 x20: ffffffe2eda11800
> > > x19: ffffff8010f62158 x18: ffffff8010bdede0
> > > x17: ffffff8010bdede8 x16: ffffff8010b96970
> > > x15: ffffffffffffffff x14: ffffffffff000000
> > > x13: ffffffffffffffff x12: 0000000000000030
> > > x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f
> > > x9 : 2dff716475687163 x8 : ffffffffffffffff
> > > x7 : fefefefefefefefe x6 : 0000000000000000
> > > x5 : 0000000000000000 x4 : ffffff8010f9bb6c
> > > x3 : 0000000000000001 x2 : 0000000000000003
> > > x1 : 0000000000000000 x0 : 0000000000000000
> > > Kernel panic - not syncing: Asynchronous SError Interrupt
> > > CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.3.0+ #392
> > > Hardware name: SolidRun LX2160A COM express type 7 module (DT)
> > > Call trace:
> > >  dump_backtrace+0x0/0x120
> > >  show_stack+0x14/0x1c
> > >  dump_stack+0x9c/0xc0
> > >  panic+0x148/0x34c
> > >  print_tainted+0x0/0xa8
> > >  arm64_serror_panic+0x74/0x80
> > >  do_serror+0x8c/0x13c
> > >  el1_error+0xbc/0x160
> > >  pci_generic_config_read+0xb0/0xc0
> > >  pci_bus_read_config_byte+0x64/0x90
> > >  pci_read_config_byte+0x40/0x48
> > >  pci_assign_irq+0x34/0xc8
> > >  pci_device_probe+0x28/0x148
> > >  really_probe+0x1c4/0x2d0
> > >  driver_probe_device+0x58/0xfc
> > >  device_driver_attach+0x68/0x70
> > >  __driver_attach+0x94/0xdc
> > >  bus_for_each_dev+0x50/0xa0
> > >  driver_attach+0x20/0x28
> > >  bus_add_driver+0x14c/0x200
> > >  driver_register+0x6c/0x124
> > >  __pci_register_driver+0x48/0x50
> > >  mlx4_init+0x154/0x180
> > >  do_one_initcall+0x30/0x250
> > >  kernel_init_freeable+0x23c/0x32c
> > >  kernel_init+0x10/0xfc
> > >  ret_from_fork+0x10/0x18
> > > SMP: stopping secondary CPUs
> > > Kernel Offset: disabled
> > > CPU features: 0x0002,21006008
> > > Memory Limit: none
> > > 
> > > and there it dies.  Any ideas?
> > 
> > The failing access seems to be:
> > 
> >         pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
> > 
> > for the Mellanox Ethernet card.  Presumably, being a PCIe ethernet
> > card, it doesn't implement this register (just a guess), and aborts
> > the PCI transaction, which is presumably triggering the above SError.
> 
> PCIe r5.0, sec 7.5.1.1.13, says Interrupt Pin is a read-only register,
> so there shouldn't be an issue with reading it.
> 
> mobiveil_pcie_ops uses the generic pci_generic_config_read(), which
> will perform a readb() in this case.  Could mobiveil be a bridge that
> only supports 32-bit config accesses?

I have it solved through private discussion.

Essentially, however, the patch set which has been sent for mainline
seems to fail for (some? all?) PCIe cards in this way.  I'm lead to
believe that the work-arounds for this for the LX2160A can't be
mainlined.

There's two patches published in the publically available QiorQ tree
that seem to be necessary:

PCI: mobiveil: ls_pcie_g4: add Workaround for A-011577

    PCIe configuration access to non-existent function triggered
    SERROR interrupt exception.

    Workaround:
    Disable error reporting on AXI bus during the Vendor ID read
    transactions in enumeration.

    This ERRATA is only for LX2160A Rev1.0, and it will be fixed
    in Rev2.0.

PCI: mobiveil: ls_pcie_g4: add Workaround for A-011451

    When LX2 PCIe controller is sending multiple split completions and
    ACK latency expires indicating that ACK should be send at priority.
    But because of large number of split completions and FC update DLLP,
    the controller does not give priority to ACK transmission. This
    results into ACK latency timer timeout error at the link partner and
    the pending TLPs are replayed by the link partner again.

    Workaround:
    1. Reduce the ACK latency timeout value to a very small value.
    2. Restrict the number of completions from the LX2 PCIe controller
       to 1, by changing the Max Read Request Size (MRRS) of link partner
       to the same value as Max Packet size (MPS).

    This patch implemented part 1, the part 2 can be set by kernel parameter
    'pci=pcie_bus_perf'

    This ERRATA is only for LX2160A Rev1.0, and it will be fixed
    in Rev2.0.

and a third to fix the problem I'm seeing (which modifies the first
of the above two patches), which afaik has not been published in
the QiorQ tree.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
