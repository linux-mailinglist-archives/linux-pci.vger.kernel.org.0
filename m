Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A08D166C0
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2019 17:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfEGPbZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 May 2019 11:31:25 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57676 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfEGPbY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 May 2019 11:31:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6805E374;
        Tue,  7 May 2019 08:31:24 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E120D3F5AF;
        Tue,  7 May 2019 08:31:22 -0700 (PDT)
Date:   Tue, 7 May 2019 16:31:17 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 00/3] MIPS: SGI-IP27 rework part2
Message-ID: <20190507153117.GA21665@e121166-lin.cambridge.arm.com>
References: <20190319154755.31049-1-tbogendoerfer@suse.de>
 <20190418205726.GB126710@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418205726.GB126710@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 18, 2019 at 03:57:26PM -0500, Bjorn Helgaas wrote:
> Hi Thomas,
> 
> On Tue, Mar 19, 2019 at 04:47:49PM +0100, Thomas Bogendoerfer wrote:
> > SGI IP27 (Origin/Onyx2) and SGI IP30 (Octane) have a similair
> > architecture and share some hardware (ioc3/bridge). To share
> > the software parts this patchset reworks SGI IP27 interrupt
> > and pci bridge code. By using features Linux gained during the
> > many years since SGI IP27 code was integrated this even results
> > in code reduction and IMHO cleaner code.
> > 
> > Tests have been done on a two module O200 (4 CPUs) and an
> > Origin 2000 (8 CPUs).
> 
> Thanks for doing all this work!  It seems like it basically converts
> some of the SGI PCI code to the structure typical of current host
> controller drivers and moves it to drivers/pci/controller, which all
> seems great to me.

I had a look and the code is really, really MIPS specific, actually
I would be interested in understanding how many platforms it supports,
it is not even FW configurable.

To give another piece of evidence why some PCI driver code is still in
arch code, look at arch/arm, we did not move it to
drivers/pci/controller for the same reasons, eg lack of DT support.

With hard-coded resources, <asm/...> includes in driver code and MIPS
specific kludges even if it does reuse some APIs shared with controller
drivers I am not 100% certain that moving it to drivers/pci/controller
buys us anything, this is really arch specific code, however we slice
it.

The line between what stays in arch and what goes to
drivers/pci/controller is thin but this code is definitely more on the
arch side IMHO.

I do not question Thomas' effort, which I appreciate, I question
the end result and its usefulness, this series is even increasing
lines of kernel code, I would like to see the benefits.

Lorenzo

> The patches were kind of in limbo as far as Patchwork.  Lorenzo
> handles the native host controller drivers, so I just delegated them
> to him, so now they should be on his radar.
> 
> Bjorn
> 
> > My next step in integrating SGI IP30 support is splitting ioc3eth
> > into a MFD and subdevice drivers, which will be submitted soon.
> > 
> > Changes in v3:
> > 
> > - dropped patches accepted by Paul
> > - moved IP27 specific __phys_to_dma/__dma_to_phys into its own file
> > - moved pcibios_to_node into IP27 specific file
> > - moved PCI bus address resources setup out of pci-xtalk code into
> >   IP27 specific code
> > - dropped bit from hub_irq_data and use hwirq from irq_data
> > - introduced intr_addr for setting up bridge interrupts (IP30 preperation)
> > 
> > Changes in v2:
> > 
> > - replaced HUB_L/HUB_S by __raw_readq/__raw_writeq
> > - removed union bridge_ate
> > - replaced remaing fields in slice_data by per_cpu data
> > - use generic_handle_irq instead of do_IRQ
> > - use hierarchy irq domain for stacking bridge and hub interrupt
> > - moved __dma_to_phys/__phy_to_dma to mach-ip27/dma-direct.h
> > - use dev_to_node() for pcibus_to_node() implementation
> > 
> > Thomas Bogendoerfer (3):
> >   MIPS: SGI-IP27: move IP27 specific code out of pci-ip27.c into new
> >     file
> >   MIPS: SGI-IP27: use generic PCI driver
> >   MIPS: SGI-IP27: abstract chipset irq from bridge
> > 
> >  arch/mips/Kconfig                          |   3 +
> >  arch/mips/include/asm/mach-ip27/topology.h |  11 +-
> >  arch/mips/include/asm/pci/bridge.h         |  14 +-
> >  arch/mips/include/asm/sn/irq_alloc.h       |  11 +
> >  arch/mips/include/asm/xtalk/xtalk.h        |   9 -
> >  arch/mips/pci/Makefile                     |   1 -
> >  arch/mips/pci/ops-bridge.c                 | 302 --------------
> >  arch/mips/pci/pci-ip27.c                   | 214 ----------
> >  arch/mips/sgi-ip27/Makefile                |   4 +-
> >  arch/mips/sgi-ip27/ip27-init.c             |   2 +
> >  arch/mips/sgi-ip27/ip27-irq.c              | 191 ++++-----
> >  arch/mips/sgi-ip27/ip27-pci.c              |  30 ++
> >  arch/mips/sgi-ip27/ip27-xtalk.c            |  61 ++-
> >  drivers/pci/controller/Kconfig             |   3 +
> >  drivers/pci/controller/Makefile            |   1 +
> >  drivers/pci/controller/pci-xtalk-bridge.c  | 610 +++++++++++++++++++++++++++++
> >  include/linux/platform_data/xtalk-bridge.h |  22 ++
> >  17 files changed, 822 insertions(+), 667 deletions(-)
> >  create mode 100644 arch/mips/include/asm/sn/irq_alloc.h
> >  delete mode 100644 arch/mips/pci/ops-bridge.c
> >  delete mode 100644 arch/mips/pci/pci-ip27.c
> >  create mode 100644 arch/mips/sgi-ip27/ip27-pci.c
> >  create mode 100644 drivers/pci/controller/pci-xtalk-bridge.c
> >  create mode 100644 include/linux/platform_data/xtalk-bridge.h
> > 
> > -- 
> > 2.13.7
> > 
