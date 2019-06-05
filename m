Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B67235C27
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2019 13:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfFEL52 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jun 2019 07:57:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:52770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727183AbfFEL52 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Jun 2019 07:57:28 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42D092075B;
        Wed,  5 Jun 2019 11:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559735846;
        bh=pOJC3GeHUz1Mg6J9DuTR5RaVhxfBT9Uwdefo5hiwznI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=166hd/QGEm5mnxjRiMGDaRmwNYuJNK4Li5kvh+BVZZrKIz0z/qcaRpGxBhRGmIhhU
         MLtjAFE5Hgm2Mno7Slc5uTsuyFtRAsyqxspWxubBn6yVvL65/yP7JRdlarSfiPqiG+
         mOom5ErwZabd+eR+WLYoVwVdg7mFnvjsMZ9HnEoQ=
Date:   Wed, 5 Jun 2019 06:57:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] PCI / PM: Don't runtime suspend when device only
 supports wakeup from D0
Message-ID: <20190605115724.GE84290@google.com>
References: <20190522181157.GC79339@google.com>
 <Pine.LNX.4.44L0.1905221433310.1410-100000@iolanthe.rowland.org>
 <20190522205231.GD79339@google.com>
 <010C1D41-C66D-45C0-8AFF-6F746306CE29@canonical.com>
 <20190527165747.GF79339@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190527165747.GF79339@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 27, 2019 at 11:57:47AM -0500, Bjorn Helgaas wrote:
> On Thu, May 23, 2019 at 12:39:23PM +0800, Kai-Heng Feng wrote:
> > at 04:52, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Wed, May 22, 2019 at 02:39:56PM -0400, Alan Stern wrote:
> > > > On Wed, 22 May 2019, Bjorn Helgaas wrote:
> > > > > On Wed, May 22, 2019 at 11:46:25PM +0800, Kai Heng Feng wrote:
> > > > > > > On May 22, 2019, at 9:48 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > > On Wed, May 22, 2019 at 11:42:14AM +0800, Kai Heng Feng wrote:
> > > > > > > > at 6:23 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > > > > On Wed, May 22, 2019 at 12:31:04AM +0800, Kai-Heng Feng wrote:
> > > > > > > > > > There's an xHC device that doesn't wake when
> > > > > > > > > > a USB device gets plugged
> > > > > > > > > > to its USB port. The driver's own runtime
> > > > > > > > > > suspend callback was called,
> > > > > > > > > > PME signaling was enabled, but it stays at PCI D0.
> > > > > 
> > > > > > > ...
> > > > > > > And I guess this patch basically means we wouldn't call
> > > > > > > the driver's suspend callback if we're merely going to
> > > > > > > stay at D0, so the driver would have no idea anything
> > > > > > > happened.  That might match Documentation/power/pci.txt
> > > > > > > better, because it suggests that the suspend callback is
> > > > > > > related to putting a device in a low-power state, and D0
> > > > > > > is not a low-power state.
> > > > > > 
> > > > > > Yes, the patch is to let the device stay at D0 and don’t run
> > > > > > driver’s own runtime suspend routine.
> > > > > > 
> > > > > > I guess I’ll just proceed to send a V2 with updated commit message?
> > > > > 
> > > > > Now that I understand what "runtime suspended to D0" means, help me
> > > > > understand what's actually wrong.
> > > > 
> > > > Kai's point is that the xhci-hcd driver thinks the device is now
> > > > in runtime suspend, because the runtime_suspend method has been
> > > > executed.  But in fact the device is still in D0, and as a
> > > > result, PME signalling may not work correctly.
> > > 
> > > The device claims to be able to signal PME from D0 (this is from the lspci
> > > in https://bugzilla.kernel.org/show_bug.cgi?id=203673):
> > > 
> > >   00:10.0 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB XHCI Controller (rev 20) (prog-if 30 [XHCI])
> > >     Capabilities: [50] Power Management version 3
> > >       Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> > > 
> > > From the xHCI spec r1.0, sec 4.15.2.3, it looks like a connect
> > > detected while in D0 should assert PME# if enabled (and WCE is
> > > set).
> > 
> > I think section 4.15.2.3 is about S3 wake up, no S0 we are
> > discussing here.
> 
> S0 and S3 are system-level ideas and have no meaning to an individual
> PCI device.  The xHC is a PCI device and can't tell whether the system
> as a whole is in S0 or S3.  If a PCI device claims to be able to
> generate PME while in D0, that applies regardless of the system state.
> 
> xHCI r1.0, sec A.1 says "The host controller should be capable of
> asserting PME# when in any supported device state."  In sec 4.19.2,
> Figure 42 says PME# should be asserted whenever PMCSR.PME_En=1 and
> WCE=1 and a connection is detected.
> 
> Figure 42 also shows that CSC (Connect Status Change) and related bits
> feed into Port Status Change Event Generation.  So I assume the xhci
> driver normally detects connect/disconnect via CSC, but the runtime
> suspend method makes it use PME# instead?
> 
> And the way your patch works is by avoiding that xhci runtime suspend
> method, so it *always* uses CSC and never uses PME#?  If that's the
> case, we're just papering over a problem without really understanding
> it.
> 
> I'm wondering if this platform has a firmware defect.  Here's my
> thinking.  The xHC is a Root Complex Integrated Endpoint, so its PME
> signaling is a little unusual.
> 
> The typical scenario is that a PCIe device is below a Root Port.  In
> that case, it would send a PME Message upstream to the Root Port.  Per
> PCIe r4.0, sec 6.1.6, when configured for native PME support (for ACPI
> systems, I assume this means "when firmware has granted PME control to
> the OS via _OSC"), the Root Port would generate a normal PCI INTx or
> MSI interrupt:
> 
>   PCI Express-aware software can enable a mode where the Root Complex
>   signals PME via an interrupt. When configured for native PME
>   support, a Root Port receives the PME Message and sets the PME
>   Status bit in its Root Status register. If software has set the PME
>   Interrupt Enable bit in the Root Control register to 1b, the Root
>   Port then generates an interrupt.
> 
> But on this platform the xHC is a Root Complex Integrated Endpoint, so
> there is no Root Port upstream from it, and that mechanism can't be
> used.  Per PCIe r4.0, sec 1.3.2.3, RCiEPs signal PME via "the same
> mechanism as PCI systems" or via Root Complex Event Collectors:
> 
>   An RCiEP must signal PME and error conditions through the same
>   mechanisms used on PCI systems. If a Root Complex Event Collector is
>   implemented, an RCiEP may optionally signal PME and error conditions
>   through a Root Complex Event Collector.
> 
> This platform has no Root Complex Event Collectors, so the xHC should
> signal PME via the same mechanism as PCI systems, i.e., asserting a
> PME# signal.  I think this means the OS cannot use native PCIe PME
> control because it doesn't know what interrupt PME# is connected to.
> The PCI Firmware Spec r3.2, sec 4.5.1 (also quoted in ACPI v6.2, sec
> 6.2.11.3), says:
> 
>   PCI Express Native Power Management Events control
> 
>   The firmware sets this bit to 1 to grant control over PCI Express
>   native power management event interrupts (PMEs). If firmware
>   allows the operating system control of this feature, then in the
>   context of the _OSC method, it must ensure that all PMEs are
>   routed to root port interrupts as described in the PCI Express
>   Base Specification.
> 
> This platform cannot route all PMEs to Root Port interrupts because
> the xHC RCiEP cannot report PME via a Root Port, so I think its _OSC
> method should not grant control of PCIe Native Power Management Events
> to the OS, and I think that would mean we have to use the ACPI
> mechanism for PME on this platform.
> 
> Can you confirm or deny any of this line of reasoning?  I'm wondering
> if there's something wrong with the platform's _OSC, so Linux thinks
> it can use native PME, but that doesn't work for this device.
> 
> > It’s a platform in development so the name can’t be disclosed.
> 
> Please attach a complete dmesg log to the bugzilla.  You can remove
> identifying details like the platform name, but I want to see the
> results of the _OSC negotiation.

Thanks for the dmesg log
(https://bugzilla.kernel.org/attachment.cgi?id=283109).  It shows:

  acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
  acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug LTR]
  acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]

I think it is incorrect for the platform to give the OS native control
over PME because the OS has no way to know how the RCiEP PMEs are
routed.  But it would be interesting to know how BIOSes on other
platforms with RCiEPs handle this, and I did post a question to the
PCI-SIG to see if there's any guidance there.

Bjorn
