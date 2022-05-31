Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDCF53974E
	for <lists+linux-pci@lfdr.de>; Tue, 31 May 2022 21:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242918AbiEaTqm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 May 2022 15:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242945AbiEaTqm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 May 2022 15:46:42 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C57BDF;
        Tue, 31 May 2022 12:46:41 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id r65so13680827oia.9;
        Tue, 31 May 2022 12:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Oap3nD3B2RMKJZbp1rzvvdgE3lcyL1foSb5mHMQ6p08=;
        b=b07nnY7ZuczD1JLduQqd/NxjPQYQSYGdbXE37PcoCDE+bGScyxiLH8D2i+BDJ0qUCE
         lGc/VWP6Sho2V8mYdSUcX7yFK1GljHROztKm4vTxhVH89637Z85iJUCxorqO1dTLBwOg
         4PrU30EK7A4YZOK26Y28Uji5hAEo9WHYvAqFuGtAG4NMKBeiHE76LLx4d6ZTbwbvTX3r
         AHqSBXCpjkL3pufHdjYyWTaU0hP0jjDwayPQw36+hHYZtu4KiGGcIqZajf6cJ3QJmBos
         wOgnYiIzPCV5cy2kZ1TbUHdSsnBdNzbDXU/y36ItKjhj0iPwFQiVM3fMUImQjVenEKX6
         ldzg==
X-Gm-Message-State: AOAM5335Kjl9JhS/6c01E6HP4JTjwG7DDk5kQkWiPFr01nUHgEUCN19N
        A5eK/IgWjrCPOlcg4BSpwg==
X-Google-Smtp-Source: ABdhPJx3JD85SLuE7QUjAkBXQ8a+GqhL3vvQu7XquyZqVdiwqA5/hRB0tqClL8AdBFFVfbTzj7HoAQ==
X-Received: by 2002:a05:6808:1592:b0:32b:aa3d:39aa with SMTP id t18-20020a056808159200b0032baa3d39aamr13224226oiw.241.1654026400478;
        Tue, 31 May 2022 12:46:40 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y24-20020a056808061800b0032c14a97747sm3008367oih.56.2022.05.31.12.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 12:46:40 -0700 (PDT)
Received: (nullmailer pid 2166285 invoked by uid 1000);
        Tue, 31 May 2022 19:46:39 -0000
Date:   Tue, 31 May 2022 14:46:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <20220531194639.GB1808817-robh@kernel.org>
References: <20220526192512.GH54904-robh@kernel.org>
 <20220526205355.GA344519@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526205355.GA344519@bhelgaas>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 26, 2022 at 03:53:55PM -0500, Bjorn Helgaas wrote:
> On Thu, May 26, 2022 at 02:25:12PM -0500, Rob Herring wrote:
> > On Mon, May 23, 2022 at 05:10:36PM -0500, Bjorn Helgaas wrote:
> > > On Sat, May 21, 2022 at 02:51:42PM -0400, Jim Quinlan wrote:
> > > > On Sat, May 21,
> > > > 2CONFIG_INITRAMFS_SOURCE="/work3/jq921458/cpio/54-arm64-rootfs.cpio022
> > > > at 12:43 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > On Wed, May 18, 2022 at 03:42:11PM -0400, Jim Quinlan wrote:
> 
> > > > > I added Rafael because this seems vaguely similar to runtime power
> > > > > management, and if we can integrate with that somehow, I'd sure like
> > > > > to avoid building a parallel infrastructure for it.
> > > > >
> > > > > The current path we're on is to move some of this code that's
> > > > > currently in pcie-brcmstb.c to the PCIe portdrv [0].  I'm a little
> > > > > hesitant about that because ACPI does just fine without it.  If we're
> > > > > adding new DT functionality that could not be implemented via ACPI,
> > > > > that's one thing.  But I'm not convinced this is that new.
> > > >
> > > > AFAICT, Broadcom STB and Cable Modem products do not have/use/want
> > > > ACPI.  We are fine with keeping this "PCIe regulator" feature
> > > > private to our driver and giving you speedy and full support in
> > > > maintaining it.
> > > 
> > > I don't mean that you should use ACPI, only that ACPI platforms can do
> > > this sort of power control using the existing PCI core infrastructure,
> > > and maybe there's a way for OF/DT platforms to hook into that same
> > > infrastructure to minimize the driver-specific work.  E.g., maybe
> > > there's a way to extend platform_pci_set_power_state() and similar to
> > > manage these regulators.
> > 
> > The big difference is ACPI abstracts how to control power for a device. 
> > The OS just knows D0, D3, etc. states. For DT, there is no such 
> > abstraction. You need device specific code to do device specific power 
> > management.
> 
> I'm thinking about the PCI side of the host controller, which should
> live by the PCI rules.  There are device-specific ways to control
> power, clocks, resets, etc on the PCI side, but drivers for PCI
> devices (as opposed to drivers for the host controllers) can't really
> call that code directly.

Yes, there are PCI specific ways to handle some of this when it is 
signals or power for standard PCI slots. But then it's also possible 
that you have a soldered down device that has extra or different 
interfaces.

When this Broadcom thread was reviewed originally, I was the one pushing 
this towards doing this in the portdrv. That seems like the more 
logical place at least to control the root port state even if we need 
host controller specific routines to do the work. It's all related to 
how do we separate out host bridge and root port operations. 

> There are some exceptions, but generally speaking I don't think PCI
> drivers that use generic power management need to use PCI_D0,
> PCI_D3hot, etc directly.  Generic PM uses interfaces like
> pci_pm_suspend() that keep most of the PCI details in the PCI core
> instead of the endpoint driver, e.g., [3].

Yeah, I think that's a different issue.


> The PCI core has a bunch of interfaces:
> 
>   platform_pci_power_manageable()
>   platform_pci_set_power_state()
>   platform_pci_get_power_state()
>   platform_pci_choose_state()
> 
> that currently mostly use ACPI.  So I'm wondering whether there's some
> way to extend those platform_*() interfaces to call the native host
> controller device-specific power control code via an ops structure.
> 
> Otherwise it feels like the native host controller drivers are in a
> different world than the generic PM world, and we'll end up with every
> host controller driver reimplementing things.
> 
> For example, how would we runtime suspend a Root Port and turn off
> power for PCI devices below it?  Obviously that requires
> device-specific code to control the power.  Do we have some common
> interface to it, or do we have to trap config writes to PCI_PM_CTRL or
> something?

Shrug. Honestly, the PCI specific power management stuff is not 
something I've studied. I'm a bit more fluent runtime PM.

Somewhat related to all this is this thread[4] where I've suggested that 
the right way to save power when there's no link (or child device 
really) is using runtime PM rather than just failing probe. We also 
don't need each host controller doing their own conformance test hacks 
either.


> [3] https://git.kernel.org/linus/cd97b7e0d780
> 
> > > > > [0] https://lore.kernel.org/r/20211110221456.11977-6-jim2101024@gmail.com
> 
> > > > > IIUC, this path:
> > > > >
> > > > >   pci_alloc_child_bus
> > > > >     brcm_pcie_add_bus                   # .add_bus method
> > > > >       pci_subdev_regulators_add_bus     # in pcie-brcmstb.c for now
> > > > >         alloc_subdev_regulators         # in pcie-brcmstb.c for now
> > > > >         regulator_bulk_get
> > > > >         regulator_bulk_enable
> > > > >       brcm_pcie_linkup                  # bring link up
> > > > >
> > > > > is basically so we can leave power to downstream devices off, then
> > > > > turn it on when we're ready to enumerate those downstream devices.
> > > >
> > > > Yes  -- it is the "chicken-and-egg" problem.  Ideally, we would like
> > > > for the endpoint driver to turn on its own regulators, but even to
> > > > know which endpoint driver to probe we must turn on the regulator to
> > > > establish linkup.
> > > 
> > > I don't think having an endpoint driver turn on power to its device is
> > > the right goal.  
> > 
> > DT requires device specific code to control a specific device. That 
> > belongs in the driver for that device.
> 
> I must be talking about something different than you are.  I see that
> brcmstb has device-specific code to control the brcmstb device as well
> as power for PCI devices downstream from that device.
> 
> When I read "endpoint driver" I think of a PCIe Endpoint device like a
> NIC.  That's just a random PCI device, and I read "endpoint driver to
> turn on its own regulators" as suggesting that the NIC driver (e1000,
> etc) would turn on power to the NIC.  Is that the intent?

Yes! A NIC as an add-in card doesn't need anything because it's just a 
standard PCI connector with standard power sequencing. But take that 
same NIC chip and solder it down on a board. Then the board designers 
start cost saving and remove components. For example, there's no need 
for standard PCI supply to chip supply regulators (e.g. 12V/3.3V to 
whatever the chip has). Who needs an EEPROM with a MAC address either.

I think there's roughly 2 cases we're dealing with. The platform 
specific ways to do power control on standard PCIe slots/connectors, and 
then non-standard connections that need downstream device specific ways 
to do power management (including powering on to be discovered). The 
line is blurred a bit because the latter case needs some of the former 
case (at least any in-band PCI power management). The problem I see all 
the time (not just PCI) is people trying to implement something 
generic/common rather than device specific which then makes its way into 
bindings. The only way something generic works is if there's a spec 
behind it. For PCI slots there is, but it is important we distinguish 
the 2 cases.

Rob

[4] https://lore.kernel.org/linux-pci/YksDJfterGl9uPjs@robh.at.kernel.org/
