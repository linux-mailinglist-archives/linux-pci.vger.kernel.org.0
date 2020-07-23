Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C0522B9DF
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jul 2020 01:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgGWXBV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jul 2020 19:01:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:57520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbgGWXBV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Jul 2020 19:01:21 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3669420792;
        Thu, 23 Jul 2020 23:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595545280;
        bh=jqEWenYPA5Fxe9Hs+zOMf8lLA83tElk/YttMQKjz2Xc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FYQlwqeFaTRPDB1QU43tNOKhvTREx5Gc9hwBldambmYgPbW+mLD/WKcgRVn8fesKb
         w0vwQ/0JDNGLef+svw4ss7zLGDCN2NuFCnLfK5jrzUXYktjs7rv6n19IFD25wcVBec
         CmikSK1asUnVVaLZC/J/HYAMaUM0+6i8tUkoqISQ=
Date:   Thu, 23 Jul 2020 18:01:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Tom Joseph <tjoseph@cadence.com>, linux-pci@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 00/19] PCI: Another round of host clean-ups
Message-ID: <20200723230118.GA1467373@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723103926.GA7926@e121166-lin.cambridge.arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Kishon, -cc non Cadence folks]

On Thu, Jul 23, 2020 at 11:39:26AM +0100, Lorenzo Pieralisi wrote:
> On Tue, Jul 21, 2020 at 08:24:55PM -0600, Rob Herring wrote:
> > Here's another round PCI host bridge clean-ups. This one aims to
> > reduce the amount of duplication in host probe functions by providing
> > more default initialization of the pci_host_bridge. With the prior
> > clean-ups, it's now possible to alloc and initialize the pci_host_bridge
> > struct from DT in one step.
> > 
> > Patches 2 and 3 drop some pci_host_bridge init. Patches 4-11 clean-up
> > handling of root bus number and bus ranges. Patches 12 and 13 are cleanups
> > for Cadence driver. Patches 14 and 15 are clean-ups for rCar driver. Patch
> > 16 makes missing non-prefetchable region just a warning instead of an
> > error in order to work with rcar-gen2. Patch 17 converts rcar-gen2 to not
> > use the arm32 specific PCI setup. Patch 18 updates how the DT resource
> > parsing is done for all the controller drivers. Any other new controller
> > drivers will need updating. Patch 19 moves the default IRQ mapping to
> > the bridge init core code.
> > 
> > This is based on my previous series of clean-ups[1].
> > 
> > Compile tested only. Any testing would be appreciated as I don't have
> > any of this h/w (well, I have a rock960c, but have not gotten PCIe to work
> > on it).
> > 
> > Rob
> > 
> > [1] https://lore.kernel.org/linux-pci/20200522234832.954484-1-robh@kernel.org/
> > 
> > Rob Herring (19):
> >   PCI: versatile: Drop flag PCI_ENABLE_PROC_DOMAINS
> >   PCI: Set default bridge parent device
> >   PCI: Drop unnecessary zeroing of bridge fields
> >   PCI: aardvark: Use pci_is_root_bus() to check if bus is root bus
> >   PCI: designware: Use pci_is_root_bus() to check if bus is root bus
> >   PCI: mobiveil: Use pci_is_root_bus() to check if bus is root bus
> >   PCI: xilinx-nwl: Use pci_is_root_bus() to check if bus is root bus
> >   PCI: xilinx: Use pci_is_root_bus() to check if bus is root bus
> >   PCI: rockchip: Use pci_is_root_bus() to check if bus is root bus
> >   PCI: rcar: Use pci_is_root_bus() to check if bus is root bus
> >   PCI: Move setting pci_host_bridge.busnr out of host drivers
> >   PCI: cadence: Use bridge resources for outbound window setup
> >   PCI: cadence: Remove private bus number and range storage
> >   PCI: rcar: Use devm_pci_alloc_host_bridge()
> >   PCI: rcar: Use struct pci_host_bridge.windows list directly
> >   PCI: of: Reduce missing non-prefetchable memory region to a warning
> >   PCI: rcar-gen2: Convert to use modern host bridge probe functions
> >   PCI: Move DT resource setup into devm_pci_alloc_host_bridge()
> >   PCI: Set bridge map_irq and swizzle_irq to default functions
> > 
> >  .../pci/controller/cadence/pcie-cadence-ep.c  |   6 +-
> >  .../controller/cadence/pcie-cadence-host.c    |  65 +++----
> >  drivers/pci/controller/cadence/pcie-cadence.c |   9 +-
> >  drivers/pci/controller/cadence/pcie-cadence.h |   8 +-
> >  drivers/pci/controller/dwc/pci-imx6.c         |   2 +-
> >  drivers/pci/controller/dwc/pci-keystone.c     |   4 +-
> >  .../pci/controller/dwc/pcie-designware-host.c |  28 +--
> >  drivers/pci/controller/dwc/pcie-designware.h  |   2 -
> >  .../controller/mobiveil/pcie-mobiveil-host.c  |  21 +--
> >  .../pci/controller/mobiveil/pcie-mobiveil.h   |   1 -
> >  drivers/pci/controller/pci-aardvark.c         |  25 +--
> >  drivers/pci/controller/pci-ftpci100.c         |  10 --
> >  drivers/pci/controller/pci-host-common.c      |  17 +-
> >  drivers/pci/controller/pci-loongson.c         |   8 -
> >  drivers/pci/controller/pci-mvebu.c            |   4 -
> >  drivers/pci/controller/pci-rcar-gen2.c        | 162 +++++-------------
> >  drivers/pci/controller/pci-tegra.c            |  10 --
> >  drivers/pci/controller/pci-v3-semi.c          |  12 --
> >  drivers/pci/controller/pci-versatile.c        |  13 +-
> >  drivers/pci/controller/pci-xgene.c            |   9 -
> >  drivers/pci/controller/pcie-altera.c          |  10 --
> >  drivers/pci/controller/pcie-brcmstb.c         |   9 -
> >  drivers/pci/controller/pcie-iproc-platform.c  |  10 +-
> >  drivers/pci/controller/pcie-iproc.c           |   3 -
> >  drivers/pci/controller/pcie-mediatek.c        |  16 --
> >  drivers/pci/controller/pcie-rcar-host.c       |  73 +-------
> >  drivers/pci/controller/pcie-rockchip-host.c   |  24 +--
> >  drivers/pci/controller/pcie-rockchip.h        |   1 -
> >  drivers/pci/controller/pcie-xilinx-nwl.c      |  20 +--
> >  drivers/pci/controller/pcie-xilinx.c          |  22 +--
> >  drivers/pci/of.c                              |  45 +++--
> >  drivers/pci/pci.h                             |   8 +
> >  drivers/pci/probe.c                           |   7 +
> >  include/linux/pci.h                           |  12 --
> >  34 files changed, 160 insertions(+), 516 deletions(-)
> 
> Applied to pci/misc with Bjorn's ACK - I had to tweak:
> 
> https://patchwork.kernel.org/patch/11677011

There are significant conflicts between this series and Kishon's TI
J721E work on Lorenzo's pci/cadence branch.

This series on pci/misc touches many drivers, so I'll merge it last.
It wasn't obvious to me how to resolve some of the conflicts, so I
dropped pci/misc from my merge today.

Any chance you could rebase this on top of Lorenzo's pci/cadence
branch, Rob?  I think it would probably merge cleanly then.

Bjorn
