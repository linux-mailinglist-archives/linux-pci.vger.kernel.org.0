Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2E122C986
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jul 2020 17:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgGXP4F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jul 2020 11:56:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbgGXP4E (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Jul 2020 11:56:04 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBBA62064B
        for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2020 15:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595606163;
        bh=nBkXBU1PEnIqdu0INOmexlVBu+Is+rdiH2TEDqeKe70=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xkG0PTQofe4aiUDkHNJoEiFQH6S87dXTIOZdBOfMJey0KISPi0t4QuHrvQv679CH4
         8OCyhEqh435b69TVgeZWT2bjODKsG1VYpDnNfX1tFyWRvWz932ZxaoGOpX3SOFiaXi
         2SDOok3bbwtQmVWKJOjMP9hl/fDzc26YnWRNibeQ=
Received: by mail-ot1-f49.google.com with SMTP id o72so1757096ota.11
        for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2020 08:56:03 -0700 (PDT)
X-Gm-Message-State: AOAM533HwEQ+zB91SuW/7Nr/iukS5w1xAtedTIsCYeEZ3Ibe8QL4zF/p
        6tkj2I+DWZIiR6Jca3gHbyVgn3YQu1AVUJo9rQ==
X-Google-Smtp-Source: ABdhPJzYPFzw3uOZNPgNUhY0afV4137sfQty5BIx/9GBZ4/IIibxGwKG4eKRrC3XC1pE6HV8t/0lCZUh+X03h+7TKwU=
X-Received: by 2002:a9d:2646:: with SMTP id a64mr8950113otb.107.1595606162993;
 Fri, 24 Jul 2020 08:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200723103926.GA7926@e121166-lin.cambridge.arm.com> <20200723230118.GA1467373@bjorn-Precision-5520>
In-Reply-To: <20200723230118.GA1467373@bjorn-Precision-5520>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 24 Jul 2020 09:55:50 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKA69z2MOAdxRTihjCFvFQjSC_jgiAfhqH3C7v4LxXvWw@mail.gmail.com>
Message-ID: <CAL_JsqKA69z2MOAdxRTihjCFvFQjSC_jgiAfhqH3C7v4LxXvWw@mail.gmail.com>
Subject: Re: [PATCH 00/19] PCI: Another round of host clean-ups
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Tom Joseph <tjoseph@cadence.com>,
        PCI <linux-pci@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 23, 2020 at 5:01 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Kishon, -cc non Cadence folks]
>
> On Thu, Jul 23, 2020 at 11:39:26AM +0100, Lorenzo Pieralisi wrote:
> > On Tue, Jul 21, 2020 at 08:24:55PM -0600, Rob Herring wrote:
> > > Here's another round PCI host bridge clean-ups. This one aims to
> > > reduce the amount of duplication in host probe functions by providing
> > > more default initialization of the pci_host_bridge. With the prior
> > > clean-ups, it's now possible to alloc and initialize the pci_host_bridge
> > > struct from DT in one step.
> > >
> > > Patches 2 and 3 drop some pci_host_bridge init. Patches 4-11 clean-up
> > > handling of root bus number and bus ranges. Patches 12 and 13 are cleanups
> > > for Cadence driver. Patches 14 and 15 are clean-ups for rCar driver. Patch
> > > 16 makes missing non-prefetchable region just a warning instead of an
> > > error in order to work with rcar-gen2. Patch 17 converts rcar-gen2 to not
> > > use the arm32 specific PCI setup. Patch 18 updates how the DT resource
> > > parsing is done for all the controller drivers. Any other new controller
> > > drivers will need updating. Patch 19 moves the default IRQ mapping to
> > > the bridge init core code.
> > >
> > > This is based on my previous series of clean-ups[1].
> > >
> > > Compile tested only. Any testing would be appreciated as I don't have
> > > any of this h/w (well, I have a rock960c, but have not gotten PCIe to work
> > > on it).
> > >
> > > Rob
> > >
> > > [1] https://lore.kernel.org/linux-pci/20200522234832.954484-1-robh@kernel.org/
> > >
> > > Rob Herring (19):
> > >   PCI: versatile: Drop flag PCI_ENABLE_PROC_DOMAINS
> > >   PCI: Set default bridge parent device
> > >   PCI: Drop unnecessary zeroing of bridge fields
> > >   PCI: aardvark: Use pci_is_root_bus() to check if bus is root bus
> > >   PCI: designware: Use pci_is_root_bus() to check if bus is root bus
> > >   PCI: mobiveil: Use pci_is_root_bus() to check if bus is root bus
> > >   PCI: xilinx-nwl: Use pci_is_root_bus() to check if bus is root bus
> > >   PCI: xilinx: Use pci_is_root_bus() to check if bus is root bus
> > >   PCI: rockchip: Use pci_is_root_bus() to check if bus is root bus
> > >   PCI: rcar: Use pci_is_root_bus() to check if bus is root bus
> > >   PCI: Move setting pci_host_bridge.busnr out of host drivers
> > >   PCI: cadence: Use bridge resources for outbound window setup
> > >   PCI: cadence: Remove private bus number and range storage
> > >   PCI: rcar: Use devm_pci_alloc_host_bridge()
> > >   PCI: rcar: Use struct pci_host_bridge.windows list directly
> > >   PCI: of: Reduce missing non-prefetchable memory region to a warning
> > >   PCI: rcar-gen2: Convert to use modern host bridge probe functions
> > >   PCI: Move DT resource setup into devm_pci_alloc_host_bridge()
> > >   PCI: Set bridge map_irq and swizzle_irq to default functions
> > >
> > >  .../pci/controller/cadence/pcie-cadence-ep.c  |   6 +-
> > >  .../controller/cadence/pcie-cadence-host.c    |  65 +++----
> > >  drivers/pci/controller/cadence/pcie-cadence.c |   9 +-
> > >  drivers/pci/controller/cadence/pcie-cadence.h |   8 +-
> > >  drivers/pci/controller/dwc/pci-imx6.c         |   2 +-
> > >  drivers/pci/controller/dwc/pci-keystone.c     |   4 +-
> > >  .../pci/controller/dwc/pcie-designware-host.c |  28 +--
> > >  drivers/pci/controller/dwc/pcie-designware.h  |   2 -
> > >  .../controller/mobiveil/pcie-mobiveil-host.c  |  21 +--
> > >  .../pci/controller/mobiveil/pcie-mobiveil.h   |   1 -
> > >  drivers/pci/controller/pci-aardvark.c         |  25 +--
> > >  drivers/pci/controller/pci-ftpci100.c         |  10 --
> > >  drivers/pci/controller/pci-host-common.c      |  17 +-
> > >  drivers/pci/controller/pci-loongson.c         |   8 -
> > >  drivers/pci/controller/pci-mvebu.c            |   4 -
> > >  drivers/pci/controller/pci-rcar-gen2.c        | 162 +++++-------------
> > >  drivers/pci/controller/pci-tegra.c            |  10 --
> > >  drivers/pci/controller/pci-v3-semi.c          |  12 --
> > >  drivers/pci/controller/pci-versatile.c        |  13 +-
> > >  drivers/pci/controller/pci-xgene.c            |   9 -
> > >  drivers/pci/controller/pcie-altera.c          |  10 --
> > >  drivers/pci/controller/pcie-brcmstb.c         |   9 -
> > >  drivers/pci/controller/pcie-iproc-platform.c  |  10 +-
> > >  drivers/pci/controller/pcie-iproc.c           |   3 -
> > >  drivers/pci/controller/pcie-mediatek.c        |  16 --
> > >  drivers/pci/controller/pcie-rcar-host.c       |  73 +-------
> > >  drivers/pci/controller/pcie-rockchip-host.c   |  24 +--
> > >  drivers/pci/controller/pcie-rockchip.h        |   1 -
> > >  drivers/pci/controller/pcie-xilinx-nwl.c      |  20 +--
> > >  drivers/pci/controller/pcie-xilinx.c          |  22 +--
> > >  drivers/pci/of.c                              |  45 +++--
> > >  drivers/pci/pci.h                             |   8 +
> > >  drivers/pci/probe.c                           |   7 +
> > >  include/linux/pci.h                           |  12 --
> > >  34 files changed, 160 insertions(+), 516 deletions(-)
> >
> > Applied to pci/misc with Bjorn's ACK - I had to tweak:
> >
> > https://patchwork.kernel.org/patch/11677011
>
> There are significant conflicts between this series and Kishon's TI
> J721E work on Lorenzo's pci/cadence branch.
>
> This series on pci/misc touches many drivers, so I'll merge it last.
> It wasn't obvious to me how to resolve some of the conflicts, so I
> dropped pci/misc from my merge today.
>
> Any chance you could rebase this on top of Lorenzo's pci/cadence
> branch, Rob?  I think it would probably merge cleanly then.

Here's a branch with pci/misc and pci/cadence merged:

git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git pci-merge

Rob
