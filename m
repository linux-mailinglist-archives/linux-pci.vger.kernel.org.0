Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F72B3081F9
	for <lists+linux-pci@lfdr.de>; Fri, 29 Jan 2021 00:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhA1XeA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jan 2021 18:34:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:51072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229530AbhA1Xca (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Jan 2021 18:32:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA82364DFA;
        Thu, 28 Jan 2021 23:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611876709;
        bh=JSf3KXQzZzdKJi8SkvGxvcdaO3L0ednDXW8ZLuAudRI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=j47gCH5EXzb2Zwh3Z5CKZPEPOr7WUx6QyfDxD4l3TMVBroKWRdS08yi+aGiYkqIjc
         S6mZFZMg4/D6uavjuhpN3LpLc7HOO+zRi9x6CMcZxIDZXPkiFyvRDQr6VexDbuDAC6
         SlZUdTYBFHVPdmIhbsnO/fLOS5Wa0B5AcByJCmH7+WI4iOfkIraT+VBB6gK4Pc3LTB
         lBjtb4D0OeKP6OOwRbNVYHROnSI1Y4RW3DTXWM8rvpMGIPXvG56YqxL4y5v15Z3l2z
         rv9kL+Hx1m3lRSIuJfbmI51EUQJFQgA2rKUuDdP99NnpcTMPZ39ICRiAjdonYXRqGU
         fCauzqY4le1eQ==
Date:   Thu, 28 Jan 2021 17:31:47 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        mark.rutland@arm.com, Jon Masters <jcm@jonmasters.org>,
        linux-pci@vger.kernel.org, sudeep.holla@arm.com,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        bhelgaas@google.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: PCI: Enable SMC conduit
Message-ID: <20210128233147.GA28434@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c2db08d-ccc4-05eb-6b7b-5fd7d07dd11e@arm.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 26, 2021 at 10:46:04AM -0600, Jeremy Linton wrote:
> On 1/22/21 1:48 PM, Will Deacon wrote:
> > On Fri, Jan 08, 2021 at 10:32:16AM +0000, Lorenzo Pieralisi wrote:
> > > On Thu, Jan 07, 2021 at 04:05:48PM -0500, Jon Masters wrote:
> > > > On 1/7/21 1:14 PM, Will Deacon wrote:
> > > > > On Mon, Jan 04, 2021 at 10:57:35PM -0600, Jeremy Linton wrote:
> > > > > > Given that most arm64 platform's PCI implementations needs quirks
> > > > > > to deal with problematic config accesses, this is a good place to
> > > > > > apply a firmware abstraction. The ARM PCI SMMCCC spec details a
> > > > > > standard SMC conduit designed to provide a simple PCI config
> > > > > > accessor. This specification enhances the existing ACPI/PCI
> > > > > > abstraction and expects power, config, etc functionality is handled
> > > > > > by the platform. It also is very explicit that the resulting config
> > > > > > space registers must behave as is specified by the pci specification.
> > > > > > 
> > > > > > Lets hook the normal ACPI/PCI config path, and when we detect
> > > > > > missing MADT data, attempt to probe the SMC conduit. If the conduit
> > > > > > exists and responds for the requested segment number (provided by the
> > > > > > ACPI namespace) attach a custom pci_ecam_ops which redirects
> > > > > > all config read/write requests to the firmware.
> > > > > > 
> > > > > > This patch is based on the Arm PCI Config space access document @
> > > > > > https://developer.arm.com/documentation/den0115/latest
> > > > > 
> > > > > Why does firmware need to be involved with this at all? Can't we just
> > > > > quirk Linux when these broken designs show up in production? We'll need
> > > > > to modify Linux _anyway_ when the firmware interface isn't implemented
> > > > > correctly...
> > > > 
> > > > I agree with Will on this. I think we want to find a way to address some
> > > > of the non-compliance concerns through quirks in Linux. However...
> > > 
> > > I understand the concern and if you are asking me if this can be fixed
> > > in Linux it obviously can. The point is, at what cost for SW and
> > > maintenance - in Linux and other OSes, I think Jeremy summed it up
> > > pretty well:
> > > 
> > > https://lore.kernel.org/linux-pci/61558f73-9ac8-69fe-34c1-2074dec5f18a@arm.com
> > > 
> > > The issue here is that what we are asked to support on ARM64 ACPI is a
> > > moving target and the target carries PCI with it.
> > > 
> > > This potentially means that all drivers in:
> > > 
> > > drivers/pci/controller
> > > 
> > > may require an MCFG quirk and to implement it we may have to:
> > > 
> > > - Define new ACPI bindings (that may need AML and that's already a
> > >    showstopper for some OSes)
> > > - Require to manage clocks in the kernel (see link-up checks)
> > > - Handle PCI config space faults in the kernel
> > > 
> > > Do we really want to do that ? I don't think so. Therefore we need
> > > to have a policy to define what constitutes a "reasonable" quirk and
> > > that's not objective I am afraid, however we slice it (there is no
> > > such a thing as eg 90% ECAM).
> > 
> > Without a doubt, I would much prefer to see these quirks and workarounds
> > in Linux than hidden behind a firmware interface. Every single time.
> > 
> > This isn't like the usual fragmentation problems, where firmware swoops in
> > to save the day; CPU onlining, spectre mitigations, early entropy etc. All
> > of these problems exist because there isn't a standard method to implement
> > them outside of firmware, and so adding a layer of abstraction there makes
> > sense.

> > But PCIe is already a standard!
> 
> And it says that ECAM is optional, particularly if there are
> firmware/platform standardized ways of accessing the config space.

This is really a tangent to the main discussion, but I don't read it
quite that way.  PCIe r5.0, sec 7.2.2 says:

  For systems that are PC-compatible, or that do not implement a
  processor-architecture-specific firmware interface standard that
  allows access to the Configuration Space, the Enhanced Configuration
  Access Mechanism (ECAM) is required as defined in this section.

I read that as "ECAM is *required* unless you have a standard firmware
interface."  I think the firmware interface originally referred to
ia64 SAL, but I would say this new ARM thing also qualifies.

But the bottom line is we all want to make it so new hardware works
with old kernels.  Nobody wants to ask distros to release updates just
to boot a new platform.  That means a generic host bridge driver (like
the ACPI pci_root.c) and generic config access (like ECAM or SAL).

> > I appreciate the sentiment, but you're not solving the problem
> > here. You're moving it somewhere else. Somewhere where you don't
> > have to deal with it (and I honestly can't blame you for that),
> > but also somewhere where you _can't_ necessarily deal with it. The
> > inevitable outcome is an endless succession of crappy,
> > non-compliant machines which only appear to operate correctly with
> > particularly kernel/firmware combinations. Imagine trying to use
> > something like that?
> > 
> > The approach championed here actively discourages vendors from
> > building spec-compliant hardware and reduces our ability to work
> > around problems on such hardware at the same time.

That's a pretty good argument.  And it's true that there are
subtleties even in seemingly trivial interface like this.
Synchronization and error handling are common problem areas.

> Does that mean its open season for ECAM quirks, and we can expect
> them to start being merged now?

"Open season" makes me cringe because it suggests we have a license to
use quirks indiscriminately forever, and I hope that's not the case.

Lorenzo is closer to this issue than I am and has much better insight
into the mess this could turn into.  From my point of view, it's
shocking how much of a hassle this is compared to x86.  There just
aren't ECAM quirks, in-kernel clock management, or any of that crap.
I don't know how they do it on x86 and I don't have to care.  Whatever
they need to do, they apparently do in AML.  Eventually ARM64 has to
get there as well if vendors want distro support.

I don't want to be in the position of enforcing a draconian "no more
quirks ever" policy.  The intent -- to encourage/force vendors to
develop spec-compliant machines -- is good, but it seems like the
reward of having compliant machines "just work" vs the penalty of
having to write quirks and shepherd them upstream and into distros
will probably be more effective and not much slower.

Bjorn
