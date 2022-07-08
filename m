Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718B556C1E2
	for <lists+linux-pci@lfdr.de>; Sat,  9 Jul 2022 01:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239194AbiGHW1n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jul 2022 18:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238673AbiGHW1m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jul 2022 18:27:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269A613B44E;
        Fri,  8 Jul 2022 15:27:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A934A61CB4;
        Fri,  8 Jul 2022 22:27:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DFAC341C0;
        Fri,  8 Jul 2022 22:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657319260;
        bh=NSKccF3DfSf79IP1kjoG4Ian4S3QUmuWsZN59jOWDzs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PINXnhFYC3EAMo/hvIMd6vsKBQapyiIq2lYJwGqxJwontcKB+Xv0UsJ819bDj/m+R
         dpwwfJk8s0erz6ygHJ+FPyr7mK4MfGSxukUmSQW6gy8G5rvTMIneTr6g2BykHaSscv
         e++5ZtKOt9ZoTKOj7BlvPWtYoLnkepCMU3/Mx3o/rB4v673eUmJCsPD8pkZ/qQvvPG
         SRvVNe61zX4/hsWv7bMG5hejBpU80CmbniFcmmcJBRCVqDmAbJ2R7Km4OZ4XL261b0
         9zDOVhiojEIRsTvioZbTcIXA92RDWBdemjRb3aDJllHjfxE1IBDT5juix3zfU1vnHF
         XO0pMGYt9aVow==
Date:   Fri, 8 Jul 2022 17:27:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/4] PCI: brcmstb: Split brcm_pcie_setup() into two
 funcs
Message-ID: <20220708222738.GA378386@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-6iNxDTTKfxKbNPVnRaKmbXuy8cJAr22mws50=GkX3ncxWgA@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 08, 2022 at 04:38:30PM -0400, Jim Quinlan wrote:
> On Fri, Jul 8, 2022 at 3:59 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Jul 08, 2022 at 03:40:43PM -0400, Jim Quinlan wrote:
> > > On Fri, Jul 8, 2022 at 3:04 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Fri, Jul 08, 2022 at 09:29:27AM -0400, Jim Quinlan wrote:
> > > > > On Wed, Jul 6, 2022 at 5:56 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > On Fri, Jul 01, 2022 at 12:27:22PM -0400, Jim Quinlan wrote:
> > > > > > > We need to take some code in brcm_pcie_setup() and put it in a new function
> > > > > > > brcm_pcie_linkup().  In future commits the brcm_pcie_linkup() function will
> > > > > > > be called indirectly by pci_host_probe() as opposed to the host driver
> > > > > > > invoking it directly.
> > > > > > >
> > > > > > > Some code that was executed after the PCIe linkup is now placed so that it
> > > > > > > executes prior to linkup, since this code has to run prior to the
> > > > > > > invocation of pci_host_probe().
> > > > > >
> > > > > > This says we need to move some code from brcm_pcie_setup() to
> > > > > > brcm_pcie_linkup(), but not *why* we need to do that.
> > > > > I will elaborate in the commit message.
> > > > > >
> > > > > > In brcm_pcie_resume(), they're called together:
> > > > > >
> > > > > >   brcm_pcie_resume
> > > > > >     brcm_pcie_setup
> > > > > >     brcm_pcie_linkup
> > > > > >
> > > > > > In the probe path, they're not called together, but they're in the
> > > > > > same order:
> > > > > >
> > > > > >   brcm_pcie_probe
> > > > > >     brcm_pcie_setup
> > > > > >     pci_host_probe
> > > > > >       ...
> > > > > >         brcm_pcie_add_bus               # bus->ops->add_bus
> > > > > >           brcm_pcie_linkup
> > > > > >
> > > > > > Is there something that must happen *between* them in the probe path?
> > > > >
> > > > > Yes.  In the probe() case, we must do things in this order:
> > > > >
> > > > > 1. brcm_pcie_setup()
> > > > > 2. Turn on regulators
> > > > > 3. brcm_pcie_linkup()
> > > >
> > > > Ah, I see, both 2) and 3) happen in brcm_pcie_add_bus:
> > > >
> > > >   brcm_pcie_add_bus                    # bus->ops->add_bus
> > > >     pci_subdev_regulators_add_bus
> > > >       regulator_bulk_enable            # turn on regulators
> > > >     brcm_pcie_linkup
> > > >
> > > > > Since the voltage regulators are turned on during enumeration,
> > > > > pci_host_probe() must be invoked prior to 3.  Before regulators, we
> > > > > did not care.
> > > >
> > > > I guess in the pre-regulator case, i.e., pcie->sr not set, the power
> > > > for downstream devices must always be on.
> > > >
> > > > > In the resume case, there is no enumeration of course but our driver
> > > > > has a handle to the regulators and can turn them on/off w/o help.
> > > >
> > > > And I guess we don't need brcm_pcie_setup() in the resume path because
> > > > suspend turns off power only for downstream devices, not for the root
> > > > port itself, so the programming done by brcm_pcie_setup() doesn't need
> > > > to be done again.
> > >
> > > I'm not sure I understand what you are saying -- brcm_pcie_setup()  is
> > > called by brcm_pcie_resume()
> > > because it is needed.  brcm_pcie_setup() isn't concerned with power it
> > >  just does the preparation
> > > required before attempting link-up.
> >
> > Oh, sorry, I totally misread that.
> >
> > But I wonder about the fact that probe and resume do these in
> > different orders:
> >
> >   brcm_pcie_probe
> >     brcm_pcie_setup                          # setup
> >     pci_host_probe
> >       ...
> >         brcm_pcie_add_bus
> >           pci_subdev_regulators_add_bus
> >             regulator_bulk_enable            # regulators on
> >           brcm_pcie_linkup                   # linkup
> >
> >   brcm_pcie_resume
> >     regulator_bulk_enable                    # regulators on
> >     brcm_pcie_setup                          # setup
> >     brcm_pcie_linkup                         # linkup
> >
> brcm_pcie_setup() should be order-independent of brcm_pcie_linkup(),
> but your point is valid -- it is prudent to keep the orders
> consistent. Let me think
> about this.
> 
> > Maybe pci_subdev_regulators_add_bus() could be done directly from
> > brcm_pcie_probe() instead of in brcm_pcie_add_bus()?
> > regulators must be directly under the root port node in DT, it seems
> > like it would be reasonable to look for them in the probe path, which
> > seems like what pcie-dw-rockchip.c, pcie-tegra194.c, and
> > pcie-rockchip-host.c do.
> At some point in the original patchset -- IIRC -- the RC driver was
> searching the DT
> tree for regulators.  However, doing a "get" on these regulators is pretty much
> impossible if the "owning" device does not exist.  I even had a version that
> partially created the downstream device;  this pullreq was a mess and
> got feedback which  put me on the current approach.

Ah, I suppose because the regulators are not under the host bridge
itself, but under the *root port*, which is a PCI device that doesn't
exist until we enumerate it.  Although I guess the root port is
described in the DT, and the regulators are connected with that DT
description, not directly with the pci_dev.

> Reviews suggested  that the best location for the regulators should be located
> in the root port DT node(s).  I agree with this. In addition, there
> was a request to allow multiple regulators
> to exist at each of the root ports in the downstream tree.

Makes sense.

> So if the RC driver
> has to  potentially add multiple buses.  I really don't know how it
> would do that,
> and then call the pci_host_probe() w/o it failing.  Perhaps this is what ACPI
> does before boot  -- I'm guessing here -- but I would also guess that it is
> a decent amount of code as it is not far from doing enumeration.
> 
> One thing I could do is to allow the port driver's suspend/resume to do the
> turning off/on of the regulators.  There are two issues with this: (1)
> feedback suggested
> to put the code local to the Brcmstb driver and (2) the "ep wakeup_capable"
> code would also have to live in the port driver and I'm not sure this
> would be welcome.
> 
> > Or maybe brcm_pcie_resume() should enable the regulators after
> > brcm_pcie_setup() so it's the same order as the probe path?
> I  think I'll do this.

Yep, sounds like the right thing.

Bjorn
