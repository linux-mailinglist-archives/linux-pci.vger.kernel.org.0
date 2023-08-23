Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3314F784D95
	for <lists+linux-pci@lfdr.de>; Wed, 23 Aug 2023 02:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjHWACs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Aug 2023 20:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjHWACs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Aug 2023 20:02:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B801FB;
        Tue, 22 Aug 2023 17:02:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28DD46151A;
        Wed, 23 Aug 2023 00:02:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7FDC433C8;
        Wed, 23 Aug 2023 00:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692748965;
        bh=ctdCJfL67RtKCkpOnTUgVh2uDuaL/GwwnDDhyi3PCTw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UhnLUUvfdySw2w4ijgC9BvYkVmDrTPblB96PrgJsVG3X15mtylUcjS0Ae5EWiMRfv
         8gwnSXsSF9JCVnID8g8bA2bU9XJwPCvebqxHcsc5gPCPZ0BJCDPKeO62J4vJJ16Ows
         znxOdJtpbnG8uOFU5A8bSDRpe3NRaDYCmIairamVNGfGJKHHqg9zTxZ20wxBVO+PH6
         NMe4TI+NyZh/9v+3GRrSP3pZLM5xWwJsPJr+CUYEAk5CdXzEvDLn9UddZqR5qw10pp
         o7c3d64FFGIty7NaSO2YoBImNopsUpy4xocQ4qRGwofyBFWGVYk5rXjqjDD9T82Xpw
         OnI91RwI/hJWQ==
Date:   Tue, 22 Aug 2023 19:02:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, Iain Lane <iain@orangesquash.org.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v14.a 1/1] PCI: Only put Intel PCIe ports >= 2015 into D3
Message-ID: <20230823000243.GA391238@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hU3mWFaaujWozHnPw8+A=bf2OwzcendXjpP35wCv_B6g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 22, 2023 at 12:11:10PM +0200, Rafael J. Wysocki wrote:
> On Tue, Aug 22, 2023 at 12:42 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Aug 18, 2023 at 02:39:32PM -0500, Mario Limonciello wrote:
> > > commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> > > changed pci_bridge_d3_possible() so that any vendor's PCIe ports
> > > from modern machines (>=2015) are allowed to be put into D3.
> > >
> > > Iain reports that USB devices can't be used to wake a Lenovo Z13
> > > from suspend. This is because the PCIe root port has been put
> > > into D3 and AMD's platform can't handle USB devices waking in this
> > > case.
> > >
> > > This behavior is only reported on Linux. Comparing the behavior
> > > on Windows and Linux, Windows doesn't put the root ports into D3.
> > >
> > > To fix the issue without regressing existing Intel systems,
> > > limit the >=2015 check to only apply to Intel PCIe ports.

> > > @@ -3037,10 +3037,15 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
> > >                       return false;
> > >
> > >               /*
> > > -              * It should be safe to put PCIe ports from 2015 or newer
> > > -              * to D3.
> > > +              * Allow Intel PCIe ports from 2015 onward to go into D3 to
> > > +              * achieve additional energy conservation on some platforms.
> > > +              *
> > > +              * This is only set for Intel PCIe ports as it causes problems
> > > +              * on both AMD Rembrandt and Phoenix platforms where USB keyboards
> > > +              * can not be used to wake the system from suspend.
> > >                */
> > > -             if (dmi_get_bios_year() >= 2015)
> > > +             if (bridge->vendor == PCI_VENDOR_ID_INTEL &&
> > > +                 dmi_get_bios_year() >= 2015)
> > >                       return true;
> >
> > Hmm.  I'm really not a fan of checks like this that aren't connected
> > to an actual property of the platform.  The Intel Vendor ID tells us
> > nothing about what the actual problem is, which makes it really hard
> > to maintain in the future.  It's also very AMD- and Intel-centric,
> > when this code is ostensibly arch-agnostic, so this potentially
> > regresses ARM64, RISC-V, powerpc, etc.
> 
> That's a fair point.
> 
> Would it be better to reverse this and filter out AMD systems as they
> are affected by the existing check?

Since we're trying to avoid an issue on AMD systems, I would
definitely prefer to have the code change mention AMD instead of
Intel.

> > It's bad enough that we check for 2015.  A BIOS security update to a
> > 2014 platform will break things,
> 
> Well, not necessarily.  Pre-2015 systems already worked and the check
> was added as "surely, everything 2015 or newer should work either".
> While it is true that putting PCIe Root Ports into D3hot was necessary
> for extra energy conservation on Intel systems, it actually has been
> expected to work everywhere.

This is a tangent; I was just trying to make the point that the date
check means a BIOS update may change Linux behavior even if the update
has nothing to do with PM, and I think that's a bad thing even if the
new behavior is not a failure.  But this is water under the bridge and
is probably not going to cause problems in the future.

> > even though the update has nothing to do with D3.  We're stuck
> > with that one, and it's old enough that maybe it won't bite us any
> > more, but I hate to add more.
> 
> Well, how would you like to deal with the systems that don't work
> today, because they expect a different behavior?
>
> Effectively, the current behavior for all modern systems is to allow
> bridge D3 if there are no indications that it shouldn't be allowed.
> The platforms in question assume the reverse, so what else can be
> done?
> 
> > The list of conditions in pci_bridge_d3_possible() is a pretty good
> > clue that we don't really know what we're doing, and all we can do is
> > find configurations that happen to work.
> 
> Yes, because by the spec it all should work just fine.  The PCI PM 1.2
> specification defines the expected behavior for bridges and the PCIe
> specification claims to be a superset of that.
> 
> What we need to deal with here is basically non-compliant systems and
> so we have to catch the various forms of non-compliance.

Thanks for this, that helps.  If pci_bridge_d3_possible() is a list of
quirks for systems that are known to be broken (or at least not known
to work correctly and avoiding D3 is acceptable), then we should
document and use it that way.

The current documentation ("checks if it is possible to move to D3")
frames it as "does the bridge have the required features?" instead of
"do we know about something broken in this bridge or this platform?"

If something is broken, I would expect tests based on the device or
DMI check.  But several some are not obvious defects.  E.g.,
"bridge->is_hotplug_bridge && !pciehp_is_native(bridge)" -- what
defect are we finding there?  What does the spec require that isn't
happening?

In this particular patch, apparently we assume any non-Intel port or
any BIOS before 2015 is broken.  Obviously way too general.  We know
"USB keyboards don't wake from suspend," but I think we need something
at the PCI level like "PME interrupt doesn't happen when bridge is in
state X" (i.e., the part that is non-compliant), and "one consequence
is that downstream devices can't wake from suspend."

> > I don't have any better suggestions, other than that this should be
> > described somehow via ACPI (and not in vendor-specific stuff like
> > PNP0D80).
> 
> Well, it isn't in practice.

If this is basically quirks and we treat it that way (comments about
the breakage and references to what the spec violations are), maybe
this is the best we can do.

Bjorn
