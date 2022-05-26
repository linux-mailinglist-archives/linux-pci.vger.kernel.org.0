Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A0353551F
	for <lists+linux-pci@lfdr.de>; Thu, 26 May 2022 22:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiEZUyC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 May 2022 16:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348691AbiEZUyB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 May 2022 16:54:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2251967D1E;
        Thu, 26 May 2022 13:54:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C53561B43;
        Thu, 26 May 2022 20:53:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728F5C385A9;
        Thu, 26 May 2022 20:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653598438;
        bh=3fivRCkd5fSNHIxjV+5VCoZjgLoG/bfYfiExSsl/3qU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=papothjgQFrzOlwxukQRagU21y+cRRYK/3NXsssOkQafGmTRgV8fwVLNrVAn82I+0
         e8ffES34AXbRQgeSJMzp2DCzsfTx8iXrJg64CaCzVmpxetOZYAyRSPIO4PlfpwmtUN
         Ie9x9ASbgRJrHvfjCv/cl6GyUHAlqk8eVGG5bRJoecdZIgIFpqDxlBhjTcm3IsVGLc
         wGcqgn5mSAff7pcR3gSg17u7z0LQEOAI9AM3GjpXyYveSZ8P0icVNl5Nlys+MhlU+c
         sJFYruG/NePrYmz+7/3zRcy4z3myes/pJ+QJucoxvPd6Kq6vXEC75q2VfWySbwAxen
         CO0EnreDDoBjg==
Date:   Thu, 26 May 2022 15:53:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        James Dutton <james.dutton@gmail.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1] PCI: brcmstb: Fix regression regarding missing PCIe
 linkup
Message-ID: <20220526205355.GA344519@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526192512.GH54904-robh@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 26, 2022 at 02:25:12PM -0500, Rob Herring wrote:
> On Mon, May 23, 2022 at 05:10:36PM -0500, Bjorn Helgaas wrote:
> > On Sat, May 21, 2022 at 02:51:42PM -0400, Jim Quinlan wrote:
> > > On Sat, May 21,
> > > 2CONFIG_INITRAMFS_SOURCE="/work3/jq921458/cpio/54-arm64-rootfs.cpio022
> > > at 12:43 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Wed, May 18, 2022 at 03:42:11PM -0400, Jim Quinlan wrote:

> > > > I added Rafael because this seems vaguely similar to runtime power
> > > > management, and if we can integrate with that somehow, I'd sure like
> > > > to avoid building a parallel infrastructure for it.
> > > >
> > > > The current path we're on is to move some of this code that's
> > > > currently in pcie-brcmstb.c to the PCIe portdrv [0].  I'm a little
> > > > hesitant about that because ACPI does just fine without it.  If we're
> > > > adding new DT functionality that could not be implemented via ACPI,
> > > > that's one thing.  But I'm not convinced this is that new.
> > >
> > > AFAICT, Broadcom STB and Cable Modem products do not have/use/want
> > > ACPI.  We are fine with keeping this "PCIe regulator" feature
> > > private to our driver and giving you speedy and full support in
> > > maintaining it.
> > 
> > I don't mean that you should use ACPI, only that ACPI platforms can do
> > this sort of power control using the existing PCI core infrastructure,
> > and maybe there's a way for OF/DT platforms to hook into that same
> > infrastructure to minimize the driver-specific work.  E.g., maybe
> > there's a way to extend platform_pci_set_power_state() and similar to
> > manage these regulators.
> 
> The big difference is ACPI abstracts how to control power for a device. 
> The OS just knows D0, D3, etc. states. For DT, there is no such 
> abstraction. You need device specific code to do device specific power 
> management.

I'm thinking about the PCI side of the host controller, which should
live by the PCI rules.  There are device-specific ways to control
power, clocks, resets, etc on the PCI side, but drivers for PCI
devices (as opposed to drivers for the host controllers) can't really
call that code directly.

There are some exceptions, but generally speaking I don't think PCI
drivers that use generic power management need to use PCI_D0,
PCI_D3hot, etc directly.  Generic PM uses interfaces like
pci_pm_suspend() that keep most of the PCI details in the PCI core
instead of the endpoint driver, e.g., [3].

The PCI core has a bunch of interfaces:

  platform_pci_power_manageable()
  platform_pci_set_power_state()
  platform_pci_get_power_state()
  platform_pci_choose_state()

that currently mostly use ACPI.  So I'm wondering whether there's some
way to extend those platform_*() interfaces to call the native host
controller device-specific power control code via an ops structure.

Otherwise it feels like the native host controller drivers are in a
different world than the generic PM world, and we'll end up with every
host controller driver reimplementing things.

For example, how would we runtime suspend a Root Port and turn off
power for PCI devices below it?  Obviously that requires
device-specific code to control the power.  Do we have some common
interface to it, or do we have to trap config writes to PCI_PM_CTRL or
something?

[3] https://git.kernel.org/linus/cd97b7e0d780

> > > > [0] https://lore.kernel.org/r/20211110221456.11977-6-jim2101024@gmail.com

> > > > IIUC, this path:
> > > >
> > > >   pci_alloc_child_bus
> > > >     brcm_pcie_add_bus                   # .add_bus method
> > > >       pci_subdev_regulators_add_bus     # in pcie-brcmstb.c for now
> > > >         alloc_subdev_regulators         # in pcie-brcmstb.c for now
> > > >         regulator_bulk_get
> > > >         regulator_bulk_enable
> > > >       brcm_pcie_linkup                  # bring link up
> > > >
> > > > is basically so we can leave power to downstream devices off, then
> > > > turn it on when we're ready to enumerate those downstream devices.
> > >
> > > Yes  -- it is the "chicken-and-egg" problem.  Ideally, we would like
> > > for the endpoint driver to turn on its own regulators, but even to
> > > know which endpoint driver to probe we must turn on the regulator to
> > > establish linkup.
> > 
> > I don't think having an endpoint driver turn on power to its device is
> > the right goal.  
> 
> DT requires device specific code to control a specific device. That 
> belongs in the driver for that device.

I must be talking about something different than you are.  I see that
brcmstb has device-specific code to control the brcmstb device as well
as power for PCI devices downstream from that device.

When I read "endpoint driver" I think of a PCIe Endpoint device like a
NIC.  That's just a random PCI device, and I read "endpoint driver to
turn on its own regulators" as suggesting that the NIC driver (e1000,
etc) would turn on power to the NIC.  Is that the intent?

Bjorn
