Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B28F78B929
	for <lists+linux-pci@lfdr.de>; Mon, 28 Aug 2023 22:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjH1ULB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Aug 2023 16:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbjH1UKw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Aug 2023 16:10:52 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30045195;
        Mon, 28 Aug 2023 13:10:49 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 5ADED30000085;
        Mon, 28 Aug 2023 22:10:47 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 38C422ED8B1; Mon, 28 Aug 2023 22:10:47 +0200 (CEST)
Date:   Mon, 28 Aug 2023 22:10:47 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, Iain Lane <iain@orangesquash.org.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v14.a 1/1] PCI: Only put Intel PCIe ports >= 2015 into D3
Message-ID: <20230828201047.GA3545@wunner.de>
References: <20230823050453.GA9103@wunner.de>
 <20230823114619.GA414059@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823114619.GA414059@bhelgaas>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 23, 2023 at 06:46:19AM -0500, Bjorn Helgaas wrote:
> On Wed, Aug 23, 2023 at 07:04:53AM +0200, Lukas Wunner wrote:
> > On Tue, Aug 22, 2023 at 07:02:43PM -0500, Bjorn Helgaas wrote:
> > > On Tue, Aug 22, 2023 at 12:11:10PM +0200, Rafael J. Wysocki wrote:
> > > > What we need to deal with here is basically non-compliant systems and
> > > > so we have to catch the various forms of non-compliance.
> > > 
> > > Thanks for this, that helps.  If pci_bridge_d3_possible() is a list of
> > > quirks for systems that are known to be broken (or at least not known
> > > to work correctly and avoiding D3 is acceptable), then we should
> > > document and use it that way.
> > > 
> > > The current documentation ("checks if it is possible to move to D3")
> > > frames it as "does the bridge have the required features?" instead of
> > > "do we know about something broken in this bridge or this platform?"
> > > 
> > > If something is broken, I would expect tests based on the device or
> > > DMI check.  But several some are not obvious defects.  E.g.,
> > > "bridge->is_hotplug_bridge && !pciehp_is_native(bridge)" -- what
> > > defect are we finding there?  What does the spec require that isn't
> > > happening?
> > 
> > This particular check doesn't pertain to a defect, but indeed
> > follows from the spec:
> > 
> > If hotplug control wasn't granted to the OS, the OS shall not put
> > the hotplug port in D3 behind firmware's back because the power state
> > affects accessibility of devices downstream of the hotplug port.
> > 
> > Put another way, the firmware expects to have control of hotplug
> > and hotplug may break if the OS fiddles with the power state of the
> > hotplug port.
> > 
> > Here's a bugzilla where this caused issues:
> > https://bugzilla.kernel.org/show_bug.cgi?id=53811
> > 
> > On the other hand Thunderbolt hotplug ports are required to runtime
> > suspend to D3 in order to save power.  
> 
> Sounds like there may be a requirement in a Thunderbolt spec about
> this, so maybe we could add that citation?  I guess this goes with the
> "bridge->is_thunderbolt" check?

Right, that's the check I was referring to.  But I'm afraid there is
no explicit rule in Thunderbolt / USB4 specs that hotplug ports must
be runtime suspended in order to save power, at least to the best
of my knowledge.

In practice, Thunderbolt controllers come in one of two forms,
discrete or integrated into the CPU.  Originally only discrete
controllers existed, but over time it became more and more common
to integrate them.

Apple was pretty much the only vendor which sold larger quantities
of Thunderbolt 1 and 2 chips in the 2010 to 2016 era.  Back in the day,
only discrete controllers existed and they consumed around 1.5 to 2 W.
On laptops, that's a significant amount of energy, so from day 1, Apple
put load switches on their motherboards which allowed the Thunderbolt
controllers to be powered down if nothing is plugged in.

With the *integrated* Thunderbolt controllers, powering down on idle
is usually likewise required to allow the entire CPU package to enter
a low power state.

To the operating system, a Thunderbolt controller is visible as a
PCIe switch with an NHI device below one of the Downstream Ports
and hotplugged devices appearing below the other Downstream Ports.
The NHI is a vendor-agnostic Native Host Interface for tunnel setup,
similar to the OHCI, EHCI, XHCI interface definitions that are in use
with USB and FireWire controllers.

Linux uses a hierarchical power management model, i.e. parent devices
cannot runtime suspend unless their children runtime suspend.  Thus,
the hotplug ports need to runtime suspend and then the Switch Upstream
Port can runtime suspend and that triggers powerdown of the controller.

To cut a long story short, in *practice* Thunderbolt hotplug ports need
to be put into D3hot in order to save power, so that's what we do.
And we know from experience that they're all *safe* to be put into D3hot.
Hence we're whitelisting them in pci_bridge_d3_possible().

By contrast, I recall that we got MCEs on Xeon-SP processors back in
the day when their Root Ports were put into D3hot.  Hence the rather
conservative approach taken in pci_bridge_d3_possible() to whitelist
only known-good, newer hardware.


> > On Macs they're always handled
> > natively by the OS.  Hence the code comment.
> 
> And I guess this goes with the "System Management Mode" and
> "Thunderbolt on non-Macs" comments?  A citation to the source behind
> "OS shall not put the hotplug port in D3 behind firmware's back" would
> be super helpful here.

So I've just looked through the PCI Firmware Spec and can't find that
mentioned anywhere explicitly, but it's pretty obvious if you think
about it:

If the OS puts the hotplug port in D3hot, its downstream bus transitions
to either B2 or B3 (PCI Power Management Spec r1.2 sec 4.7.1).

Which means devices downstream of the hotplug port become inaccessible.
If hotplug control wasn't granted to the OS, firmware expects it may
handle the hotplug port without interference by the OS.

If the OS fiddles with the hotplug port's power state, that expectation
is no longer met.  Let's say the firmware reads the downstream device's
Vendor ID register to probe whether the device is there.  That'll no
longer work as expected once the hotplug port is transitioned to D3hot
by the operating system.

In retrospect, this code comment is probably confusing:

		/*
		 * Hotplug ports handled by firmware in System Management Mode
		 * may not be put into D3 by the OS (Thunderbolt on non-Macs).
		 */
		if (bridge->is_hotplug_bridge && !pciehp_is_native(bridge))
			return false;

This is not in any way specific to Thunderbolt.  It's just that
back in the day, Thunderbolt tunnel management was done natively
on Macs, whereas non-Macs did it in firmware.  That has since
changed and most vendors have adopted native tunnel management.
So the code comment is outdated.  The following would probably
be more accurate today:

		/*
		 * Hotplug ports handled by firmware in System Management Mode
		 * may not be put into D3 by the OS (behind firmware's back).
		 */


> > A somewhat longer explanation I gave in 2016:
> > https://lore.kernel.org/all/20160617213209.GA1927@wunner.de/
> > 
> > Perhaps the code comment preceding that check can be rephrased to
> > convey its meaning more clearly...
> 
> Thanks!  I think it would be worth trying to separate out the "normal"
> things that correspond to the spec from the "quirk" things that work
> around defects.  That's not material for *this* patch, though.
> 
> It's also a little weird that pci_bridge_d3_possible() itself looks
> like it's invariant for the life of the system, but we call it several
> times (pci_pm_init(), pci_bridge_d3_update(), pcie_portdrv_probe(),
> etc).  I guess this is because we save the result in dev->bridge_d3,
> but then pci_bridge_d3_update() updates dev->bridge_d3 based on other
> things, so the original value is lost.  Maybe another bit or two could
> avoid those extra calls.

Right on all accounts.  Those invocations of pci_bridge_d3_possible()
are all in code paths which run only once, e.g. on enumeration and removal
of the PCIe port and on shutdown.  We figured that it's not worth it
to cache the return value of pci_bridge_d3_possible() for these few
invocations, none of which are in hot paths.  ("We" is mostly Mika and
yours truly, who introduced this for Thunderbolt power management.)

Thanks,

Lukas
