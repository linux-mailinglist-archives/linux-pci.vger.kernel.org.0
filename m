Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E872EF0B5
	for <lists+linux-pci@lfdr.de>; Fri,  8 Jan 2021 11:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbhAHKdK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jan 2021 05:33:10 -0500
Received: from foss.arm.com ([217.140.110.172]:48718 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbhAHKdJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Jan 2021 05:33:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85034D6E;
        Fri,  8 Jan 2021 02:32:23 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 366793F70D;
        Fri,  8 Jan 2021 02:32:22 -0800 (PST)
Date:   Fri, 8 Jan 2021 10:32:16 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jon Masters <jcm@jonmasters.org>
Cc:     Will Deacon <will@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>, mark.rutland@arm.com,
        linux-pci@vger.kernel.org, sudeep.holla@arm.com,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        bhelgaas@google.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: PCI: Enable SMC conduit
Message-ID: <20210108103216.GA17931@e121166-lin.cambridge.arm.com>
References: <20210105045735.1709825-1-jeremy.linton@arm.com>
 <20210107181416.GA3536@willie-the-truck>
 <56375cd8-8e11-aba6-9e11-1e0ec546e423@jonmasters.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56375cd8-8e11-aba6-9e11-1e0ec546e423@jonmasters.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 07, 2021 at 04:05:48PM -0500, Jon Masters wrote:
> Hi will, everyone,
> 
> On 1/7/21 1:14 PM, Will Deacon wrote:
> 
> > On Mon, Jan 04, 2021 at 10:57:35PM -0600, Jeremy Linton wrote:
> > > Given that most arm64 platform's PCI implementations needs quirks
> > > to deal with problematic config accesses, this is a good place to
> > > apply a firmware abstraction. The ARM PCI SMMCCC spec details a
> > > standard SMC conduit designed to provide a simple PCI config
> > > accessor. This specification enhances the existing ACPI/PCI
> > > abstraction and expects power, config, etc functionality is handled
> > > by the platform. It also is very explicit that the resulting config
> > > space registers must behave as is specified by the pci specification.
> > > 
> > > Lets hook the normal ACPI/PCI config path, and when we detect
> > > missing MADT data, attempt to probe the SMC conduit. If the conduit
> > > exists and responds for the requested segment number (provided by the
> > > ACPI namespace) attach a custom pci_ecam_ops which redirects
> > > all config read/write requests to the firmware.
> > > 
> > > This patch is based on the Arm PCI Config space access document @
> > > https://developer.arm.com/documentation/den0115/latest
> > 
> > Why does firmware need to be involved with this at all? Can't we just
> > quirk Linux when these broken designs show up in production? We'll need
> > to modify Linux _anyway_ when the firmware interface isn't implemented
> > correctly...
> 
> I agree with Will on this. I think we want to find a way to address some
> of the non-compliance concerns through quirks in Linux. However...

I understand the concern and if you are asking me if this can be fixed
in Linux it obviously can. The point is, at what cost for SW and
maintenance - in Linux and other OSes, I think Jeremy summed it up
pretty well:

https://lore.kernel.org/linux-pci/61558f73-9ac8-69fe-34c1-2074dec5f18a@arm.com

The issue here is that what we are asked to support on ARM64 ACPI is a
moving target and the target carries PCI with it.

This potentially means that all drivers in:

drivers/pci/controller

may require an MCFG quirk and to implement it we may have to:

- Define new ACPI bindings (that may need AML and that's already a
  showstopper for some OSes)
- Require to manage clocks in the kernel (see link-up checks)
- Handle PCI config space faults in the kernel

Do we really want to do that ? I don't think so. Therefore we need
to have a policy to define what constitutes a "reasonable" quirk and
that's not objective I am afraid, however we slice it (there is no
such a thing as eg 90% ECAM).

The SMC is an olive branch and just to make sure it is crystal clear
there won't be room for adding quirks if the implementation turns out
to be broken, if a line in the sand is what we want here it is.

The question is: is there a reason we must not implement SMC support
given the above ?

As I said and you could imagine, I am the first who has concerns over
deviating from ECAM but if we do want ACPI support for platforms that
are not ECAM compliant something has to be done (HW may take years to
comply).

> Several folks here (particularly Lorenzo) have diligently worked hard
> over the past few years - and pushed their patience - to accommodate
> hardware vendors with early "not quite compliant" systems. They've taken
> lots of quirks that frankly shouldn't continue to be necessary were it
> even remotely a priority in the vendor ecosystem to get a handle on
> addressing PCIe compliance once and for all. But, again frankly, it
> hasn't been enough of a priority to get this fixed. The third party IP
> vendors *need* to address this, and their customers *need* to push back.
> 
> We can't keep having a situation in which kinda-sorta compliant stuff
> comes to market that would work out of the box but for whatever the quirk
> is this time around. There have been multiple OS releases for the past
> quite a few years on which this stuff could be tested prior to ever
> taping out a chip, and so it ought not to be possible to come to market
> now with an excuse that it wasn't tested. And yet here we still are. All
> these years and still the message isn't quite being received properly. I
> do know it takes time to make hardware, and some of it was designed years
> before and is still trickling down into these threads. But I also think
> there are cases where much more could have been done earlier.
> 
> None of these vendors can possibly want this deep down. Their engineers
> almost certainly realize that just having compliant ECAM would mean that
> the hardware was infinitely more valuable being able to run out of the
> box software that much more easily. And it's not just ECAM. Inevitably,
> that is just the observable syndrome for worse issues, often with the ITS
> and forcing quirked systems to have lousy legacy interrupts, etc. Alas,
> this level of nuance is likely lost by the time it reaches upper
> management, where "Linux" is all the same to them. I would hope that can
> change. I would also remind them that if they want to run non-Linux OSes,
> they will also want to be actually compliant. The willingness of kind
> folks like Lorenzo and others here to entertain quirks is not necessarily
> something you will find in every part of the industry.
> 
> But that all said, we have a situation in which there are still platforms
> out there that aren't fully compliant and something has to be done to
> support them because otherwise it's going to be even more ugly with
> vendor trees, distro hacks, and other stuff.
> 
> Some of you in recent weeks have asked what I and others can do to help
> from the distro and standardization side of things. To do my part, I'm
> going to commit to reach out to assorted vendors and have a heart to
> heart with them about really, truly fully addressing their compliance
> issues. That includes Cadence, Synopsys, and others who need to stop
> shipping IP that requires quirks, as well as SoC vendors who need to do
> more to test their silicon with stock kernels prior to taping out. And I
> would like to involve the good folks here who are trying to navigate.
> 
> I would also politely suggest that we collectively consider how much
> wiggle room there can be to use quirks for what we are stuck with rather
> than an SMC-based solution. We all know that quirks can't be a free ride
> forever. Those who need them should offer something strong in return. A
> firm commitment that they will never come asking for the same stuff in
> the future. Is there a way we can do something like that?

It depends on what we are asked to support and consequently what we
are willing to accept (and to be honest it is more Bjorn's patience
than mine that was exercised over the last few years on this topic).

Thanks,
Lorenzo
