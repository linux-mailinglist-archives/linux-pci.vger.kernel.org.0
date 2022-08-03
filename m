Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC5A5885D6
	for <lists+linux-pci@lfdr.de>; Wed,  3 Aug 2022 04:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235494AbiHCChg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Aug 2022 22:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbiHCChf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Aug 2022 22:37:35 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5358119295
        for <linux-pci@vger.kernel.org>; Tue,  2 Aug 2022 19:37:33 -0700 (PDT)
Received: from ip6-localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 2732V8XV017460;
        Tue, 2 Aug 2022 21:31:09 -0500
Message-ID: <bb5ae0c2a2011f4728ed9e0b2d0b7f6dbd9caaf5.camel@kernel.crashing.org>
Subject: Re: arm64 PCI resource allocation issue
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        Jeremy Linton <jeremy.linton@arm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Robin Murphy <robin.murphy@arm.com>
Date:   Wed, 03 Aug 2022 12:31:08 +1000
In-Reply-To: <CAMj1kXFWN80TENuP-0E09LEqrqqL2zoS3SDCeQE7aMZuBPA53Q@mail.gmail.com>
References: <204dda77248a7c95787e27fc7a382f514341c88e.camel@kernel.crashing.org>
         <CAMj1kXFWN80TENuP-0E09LEqrqqL2zoS3SDCeQE7aMZuBPA53Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2022-08-02 at 09:46 +0200, Ard Biesheuvel wrote:
> 
> > A few years back, I updated the PCIe resource allocation code to be a
> > bit more in line with what other architectures do. That said, once
> > thing we couldn't agree on was to do like x86 and default to preserving
> > the firmware provided resources by default.
> > 
> > On x86, the kernel "allocates" (claims) the resources (unless it finds
> > something obviously wrong), then allocates anything left unallocated.
> > 
> > On arm64, we use to just re-allocate everything. I changed this to
> > first use some more common code for doing all that, but also to have
> > the option to claim existing resources if _DSM tells us to preserve
> > them for a given host brigde.
> > 
> > I still think this is the wrong way to go and that we should preserve
> > the UEFI resources by default unless told not to :-)
> > 
> 
> +1
> 
> Using _DSM #5 also prevents, e.g., the AMD GPU driver from resizing
> its BARs, which is unfortunate.

Why ? It doesn't have to as long as there's space available somewhere
for it. Note that most x86 UEFIs have specific options to enable BAR
resizing, probably for that specific reason but I don't know for sure
what that option really  does.

But re-assigning under driver control is always ok if the space is
available somewhere.

What I want is the behaviour we have on x86 which is to honor what was
assigned by default. It doesnt' prevent explicit re-assignment under
driver control later on. (Well it shouldn't). Same goes with VFIO
etc...

>  And the CXL stuff that is layered on
> top of PCIe is going to get trickier when the OS is free to reassign
> resources, so I expect _DSM #5 to be used more widely in that context.
> 
> So are there any other reasons to avoid _DSM #5 in your case?

We currently use _DSM #5 to force the use of the firmware allocation on
our metal systems, but here too, simply honoring existing resources at
boot would be a viable alternative.

We could fix the serial console problem I mentioned further down by
extending the use of _DSM #5 but I don't like it. First it's an ad-hoc
fix for us and doesn't fix the general problem that SPRC for PCI based
UART is basically broken unless we have _DSM in firwmare. Secondly, in
our specific case, changing this would mean a potentially disruptive
change to the PCI layout of existing instance types, which is the kind
of change we prefer not exposing our customers to.  

> > The case back then was that there existed some (how many ? there was
> > one real example if I remember correctly) bogus firwmares that came out
> > of UEFI with too small windows. We could just quirk those ....
> > 
> 
> Agreed. We could add another hint at the firmware level that the PCIe
> resources have been assigned, and as far as the firmware is concerned,
> no changes are needed.

I don't think we need the firmware to set a hint. Fundamentally a UEFI
firmware is supposed to do it. Additionally, it's perfectly fine for
firmware to only assign *some* resources and Linux already knows how to
pick it up from there and assign what's left. This is how x86 works.

If what we are trying to deal is known broken UEFI implementations on
specific hardware, I'd rather we add a quirk mechanism to force re-
assignment on selected firmwares to deal with them.

For DT platforms, I don't mind having "reassign all" be the default
with potentially a DT property to flip that around. That makes sense.
But for UEFI+ACPI platforms, I think the default really should be to
honor what's been assigned.

>  This would be weaker than _DSM #5 (which means
> 'resource allocations *must* be honored for some unspecified reason,
> which is similar to 'probe-only' on DT, i.e., any problems will not be
> fixed)

One can be a bit pedantic.... Linux will still assign what was left
unassigned and will still force-reassign a range of "really broken"
setups (such as devices that appear to be outside of their bridges
etc...). Just like x86 :-)

It's also capable of reallocating of asked for and there's space
available under the host bridge (or in the top address space).

The general expectation however is that if a UEFI+ACPI platform has
assigned resources at boot, we should probably honor them unless we
have a very good reason not to.

> > The reason I'm bringing this back is that re-allocating resources for
> > system devices cause problems.
> > 
> > The most obvious one today that is affecting EC2 instances is that the
> > UART address specified in SPCR is no longer valid, causing issues
> > ranging from the console not working to MMIO to what becomes "random
> > addresses". Typically today this is "worked around" by using
> > console=ttyS0 to force selection of the first detected PCI UART,
> > because the match against SPCR is based on address and it won't match,
> > but there's always the underlying risk that things like earlycon starts
> > poking at now-incorrect addresses until 8250 takes over.
> > 
> > This is the most obvious problem. Any other "system" device that
> > happens to be PCIe based (anything detected early, via device-tree,
> > ACPI or otherwise) is at risk of a similar issue. On x86 that could be
> > catastrophic because near everything looks like a PCI device, on arm64
> > we seem to have been getting away with it a bit more easily ... so far.
> > 
> 
> So what is the reason you are avoiding _DSM #5?

The reason *we* (EC2) specifically is that historically we didn't have
it on virtual instances and it would be a disruptive change. x86 never
needed it.

But there are other reasons. For example we only know how to honor it
for the entire hierarchy below a root bridge, it's not granular. 

> > The alternative here would be to use ad-hock kludges for such system
> > devices, to "register" the addresses early, and have some kind of hook
> > in the PCI code that keeps track of them as they get remapped.
> > 
> 
> Yeah, we did this for the EFI framebuffer but this doesn't really
> scale IMHO so I would prefer to avoid that.

Ah I missed that bit.

> > If we want this, I would propose (happy to provide the implementation
> > but let's discuss the design first) something along the line of a
> > generic mechanism to "register" such a system device, which would add
> > it to a list. That list would be scanned on PCI device discovery for
> > BAR address matches, and the pci_dev/BAR# added to the entry (that or
> > put a pointer to the entry into pci_dev for speed/efficiency).
> > 
> 
> This means that bus numbers cannot be reassigned, which I don't think
> we rely on today.

Not sure why we would have that limitation. My idea was to match the
address at discovery time and link to the struct pci_dev, which should
be agnostic to bus numbering.

>  To positively identify a PCI device, you'll need
> some kind of path notation to avoid relying on the bus numbers
> assigned by the firmware (this could happen for hot-pluggable root
> ports where no bus range has been reserved by the firmware)

No, we would match the firmware provided address with the resource
location at probe time. But that's just one idea... anotehr one could
be to have a list of such "firmware" devices at boot and at probe time,
when such a device is detected, we "flag" it.

Then we introduce a pass that force the resource allocation for those
flagged devices (and the parents)

> > The difficulty is how is that update propagated:
> > 
> > This is of course fiddly. For example, the serial info is passed via
> > two different ways, one being earlycon (and probably the easiest to
> > track), the other one an ASCII string passed to
> > add_preferred_console(), which would require more significant hackery
> > (the code dealing with console mathing is a gothic horror).
> > 
> > Also if such a system device is in continuous use during the boot
> > process (UART ?) it needs to be "updated" as soon as possible after the
> > BARs (and parent BARs) have been also updated (in fact this is
> > generally why PCI debug dies horribly when using PCI based UARTs).
> > Maybe an (optional) callback that earlycon can add ?
> > 
> > Additionally, this would only work if such system devices are
> > "registered" before they get remapped...
> > 
> > Another approach would be to have pci_dev keep a copy of the original
> > resources (at least for the primary BARs) and provide an accessor for
> > use by things like earlycon or 8250 to compare against these, though
> > that doesn't solve the problem of promptly "updating" drivers for
> > system devices.
> > 
> > Opinions ?
> > 
> 
> I don't think working around it like this is going to be maintainable
> in the long term. 

I don't like it either, just trying to layout all the options :)

> I would much rather move to a model where the OS
> [conditionally] preserves the bus and BAR assignments, perhaps in a
> more fine-grained way than _DSM #5? Or at least more permissive.

Fine grained is always difficult since we always have to escalate up
the parent chain but yes. Maybe the approach I described above, ie,
mark those devices when we "detect" them early (fb, serial spcr, ...),
keep a list of addresses, which we then match at probe time with the
original firmware allocation, and mark those devices for resource
allocation.

Then we do a pass of allocation for those resources and their parents
only.

> The last time this came up in the PCI firmware SIG, we did discuss
> _DSM #5 at intermediate levels of the resource tree IIRC, which could
> be one way around this. But I'd still prefer a model where the
> resource assignments are guaranteed to be preserved if they meet some
> kind of agreed standard between the OS and the firmware.

I don't necessarily want to make it something that require firmware
changes and even less firmware standard changes. We are broken today.
SPCR is broken today. I think any case where we use an address provided
by firmware which might correspond to a PCI device to be later
reallocated is going to break.

x86 lived with honoring UEFI allocations forever, with a few quirks but
overall it has worked well. I really wonder why we can't do the same.

If we really feel bad about it, then I would suggest that approach
described above, where we keep a list of those early obtained addresses
and later at PCI discovery, match them to devices and force those to be
allocated.

Opinions ?

Cheers
Ben.

