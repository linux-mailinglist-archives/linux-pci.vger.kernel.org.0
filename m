Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C26C6372F
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2019 15:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfGINpm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jul 2019 09:45:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:39260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbfGINpm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Jul 2019 09:45:42 -0400
Received: from localhost (249.sub-174-234-174.myvzw.com [174.234.174.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39DB3214AF;
        Tue,  9 Jul 2019 13:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562679940;
        bh=pFpOkJHiAYbGncovzMXBIx9dzH17tRDacavgDnffM50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cTwocF9iNQ/MOODLXMFPNInDXPHulYy4PTGwfoOKiR9X6a36MeEmx88KBCV69gbjY
         HrJtzhMImMqasu++slJvQEkzNZHGf6b32cvpE3dyMvgxRBw0xCDenNROkPdvJmotrN
         n5qNV764+21kArt71upxYFtC3GGq8N7nqucvZ5G4=
Date:   Tue, 9 Jul 2019 08:45:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] PCI / PM: Don't runtime suspend when device only
 supports wakeup from D0
Message-ID: <20190709134538.GA35486@google.com>
References: <20190522181157.GC79339@google.com>
 <Pine.LNX.4.44L0.1905221433310.1410-100000@iolanthe.rowland.org>
 <20190522205231.GD79339@google.com>
 <010C1D41-C66D-45C0-8AFF-6F746306CE29@canonical.com>
 <20190527165747.GF79339@google.com>
 <20190605115724.GE84290@google.com>
 <7E5CD0E5-2C23-4339-9660-74994FC5C111@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7E5CD0E5-2C23-4339-9660-74994FC5C111@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 05, 2019 at 03:02:01PM +0800, Kai-Heng Feng wrote:
> at 19:57, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Mon, May 27, 2019 at 11:57:47AM -0500, Bjorn Helgaas wrote:

> > > I'm wondering if this platform has a firmware defect.  Here's my
> > > thinking.  The xHC is a Root Complex Integrated Endpoint, so its PME
> > > signaling is a little unusual.
> > > 
> > > The typical scenario is that a PCIe device is below a Root Port.  In
> > > that case, it would send a PME Message upstream to the Root Port.  Per
> > > PCIe r4.0, sec 6.1.6, when configured for native PME support (for ACPI
> > > systems, I assume this means "when firmware has granted PME control to
> > > the OS via _OSC"), the Root Port would generate a normal PCI INTx or
> > > MSI interrupt:
> > > 
> > >   PCI Express-aware software can enable a mode where the Root Complex
> > >   signals PME via an interrupt. When configured for native PME
> > >   support, a Root Port receives the PME Message and sets the PME
> > >   Status bit in its Root Status register. If software has set the PME
> > >   Interrupt Enable bit in the Root Control register to 1b, the Root
> > >   Port then generates an interrupt.
> > > 
> > > But on this platform the xHC is a Root Complex Integrated Endpoint, so
> > > there is no Root Port upstream from it, and that mechanism can't be
> > > used.  Per PCIe r4.0, sec 1.3.2.3, RCiEPs signal PME via "the same
> > > mechanism as PCI systems" or via Root Complex Event Collectors:
> > > 
> > >   An RCiEP must signal PME and error conditions through the same
> > >   mechanisms used on PCI systems. If a Root Complex Event Collector is
> > >   implemented, an RCiEP may optionally signal PME and error conditions
> > >   through a Root Complex Event Collector.
> > > 
> > > This platform has no Root Complex Event Collectors, so the xHC should
> > > signal PME via the same mechanism as PCI systems, i.e., asserting a
> > > PME# signal.  I think this means the OS cannot use native PCIe PME
> > > control because it doesn't know what interrupt PME# is connected to.
> > > The PCI Firmware Spec r3.2, sec 4.5.1 (also quoted in ACPI v6.2, sec
> > > 6.2.11.3), says:
> > > 
> > >   PCI Express Native Power Management Events control
> > > 
> > >   The firmware sets this bit to 1 to grant control over PCI Express
> > >   native power management event interrupts (PMEs). If firmware
> > >   allows the operating system control of this feature, then in the
> > >   context of the _OSC method, it must ensure that all PMEs are
> > >   routed to root port interrupts as described in the PCI Express
> > >   Base Specification.
> > > 
> > > This platform cannot route all PMEs to Root Port interrupts because
> > > the xHC RCiEP cannot report PME via a Root Port, so I think its _OSC
> > > method should not grant control of PCIe Native Power Management Events
> > > to the OS, and I think that would mean we have to use the ACPI
> > > mechanism for PME on this platform.
> > > 
> > > Can you confirm or deny any of this line of reasoning?  I'm wondering
> > > if there's something wrong with the platform's _OSC, so Linux thinks
> > > it can use native PME, but that doesn't work for this device.
> > > 
> > > > It’s a platform in development so the name can’t be disclosed.
> > > 
> > > Please attach a complete dmesg log to the bugzilla.  You can remove
> > > identifying details like the platform name, but I want to see the
> > > results of the _OSC negotiation.
> > 
> > Thanks for the dmesg log
> > (https://bugzilla.kernel.org/attachment.cgi?id=283109).  It shows:
> > 
> >   acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> >   acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug LTR]
> >   acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
> > 
> > I think it is incorrect for the platform to give the OS native control
> > over PME because the OS has no way to know how the RCiEP PMEs are
> > routed.  But it would be interesting to know how BIOSes on other
> > platforms with RCiEPs handle this, and I did post a question to the
> > PCI-SIG to see if there's any guidance there.
> 
> Is there any update from PCI-SIG?

Yes, but I did a terrible job asking the question, so we didn't
really get an answer for this situation.  The thread on the forum is
https://forum.pcisig.com/viewtopic.php?f=85&t=1081 (requires PCI-SIG
login, unfortunately).  My question was:

  Given an RCiEP that supports PME, can firmware grant control over
  native power management events to the OS?

  The PCI Firmware spec, r3.2, sec 4.5.1, says:

    PCI Express Native Power Management Events control

    The firmware sets this bit to 1 to grant control over PCI Express
    native power management event interrupts (PMEs). If firmware
    allows the operating system control of this feature, then in the
    context of the _OSC method, it must ensure that all PMEs are
    routed to root port interrupts as described in the PCI Express
    Base Specification.

  I don't think there's a mechanism for RCiEPs to route PMEs to a Root
  Port interrupt.

  PCIe r4.0, sec 1.3.2.3, says:

    An RCiEP must signal PME and error conditions through the same
    mechanisms used on PCI systems. If a Root Complex Event Collector
    is implemented, an RCiEP may optionally signal PME and error
    conditions through a Root Complex Event Collector.

  If the OS can be granted native PME control, how does it learn where
  the RCiEP PME is routed?

And the response from Robert Gough:

  The routing of root complex devices- Root Ports and Root Complex
  Integrated Endpionts- to Event Collectors is described in the Event
  Collector's RCEC Endpoint Association Capability Structure.

  In order for OSPM to process PMEs routed to an Event Collector, the
  source of the PME is found in the PME Requester ID field within the
  Root Status register of the Event Collector, in the same way that
  PME messages from children of Root Ports are serviced.

I just posted this follow-up question:

  Thanks, that clarifies one piece. The PCI Firmware spec, r3.2, sec
  4.5.1, says that if firmware allows OSPM control of PME, all PMEs
  should be routed to Root Port interrupts. Your answer suggests that
  this should be updated to say something like "all PMEs are routed to
  Root Port *or RCEC* interrupts".

  The piece I still don't understand is what happens when firmware
  allows OSPM control of PME in a system with an RCiEP but no RCEC.
  Where are PMEs from the RCiEP routed, and how does OSPM discover
  that? Or is it simply illegal for firmware to allow OSPM control of
  PME in that case?

The system we're looking at doesn't have any RCECs, so I don't think
the Root Complex Event Collector Endpoint Association Capability (what
a mouthful :)) is applicable, but I don't think Linux currently has
any support for it, so I think we're likely to trip over similar
issues on systems that do have RCECs.

It would be good if somebody added support for that capability.

Bjorn
