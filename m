Return-Path: <linux-pci+bounces-6673-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D774E8B278A
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 19:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0674A1C2169F
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 17:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B472314E2DF;
	Thu, 25 Apr 2024 17:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMbIzAGS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA0A14BF87
	for <linux-pci@vger.kernel.org>; Thu, 25 Apr 2024 17:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714065889; cv=none; b=hTnAF6Hqdbx5Sbn+FjlKJBLLJ65EGLLXqKvuaK65dmPR8wwrLssu2LGo1QBKEbHBiP0UgSsQ7WNPnofNKFE0GAE8IqouanyFe7XKwN5hYfgY7/S870BxKefjPfoGL9cD/j3z4QKN8hEJ0FrWi/2LPHKfjxwg3bwTlS6bCE6nr44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714065889; c=relaxed/simple;
	bh=jNFpnh3HyLLxWL/YN18Uqjqmaq1zQ8ASAb16mxVpTlI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=R8NIPbSAxEPl1Bbu5Mrwz0t+4TP8hb4xJ1ihu5DC5/dcIshhMA11h6lL0o+jgPKn0KsNOm6YvJxcFoWV4R7GDq8bohrHRZFI43R5U9/uD+p6APp3lTcI5q5fO/xV7y/VwWBorfpAWw649yrKODxQeT4QC9nF8xv94NPyrYQvhzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMbIzAGS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7BFC113CC;
	Thu, 25 Apr 2024 17:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714065889;
	bh=jNFpnh3HyLLxWL/YN18Uqjqmaq1zQ8ASAb16mxVpTlI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GMbIzAGS7QaNPuG7F4tbTrBlr1EEdQn7GkajgdTgJr72k7beVsgsk/KdzhCeiwNYq
	 lSvs4J2G+ujTeWwHypovH1SJ+i9y1cXmRlSIj/BvW4wqlMJ0qu431JAgHGhjSYGck3
	 0KCs/QfqK/aS4+XdbKmzj/UlmAOXRE7poh/sE+78xuoJ1tungMB9hA/0wotbDYimbU
	 w43WAH4cWZUTQi3MJPFwwgqdGsNgCmkl5bBdcjfmtNYAeJeBV3cugl6qUT26UHm3R4
	 PYhpC8dH5n66NGQxtTNUa901qXKP+X9NVnpyy8xw01ly7KUyoUqNWIXH83b+olHnyf
	 Zmwt2FGfTXUqg==
Date: Thu, 25 Apr 2024 12:24:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Cc: linux-pci@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] Documentation: PCI: add vmd documentation
Message-ID: <20240425172447.GA511062@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56d5ca30-de62-4f7e-a43e-2affd2d1059a@intel.com>

On Wed, Apr 24, 2024 at 02:29:16PM -0700, Paul M Stillwell Jr wrote:
> On 4/23/2024 5:47 PM, Bjorn Helgaas wrote:
> > On Tue, Apr 23, 2024 at 04:10:37PM -0700, Paul M Stillwell Jr wrote:
> > > On 4/23/2024 2:26 PM, Bjorn Helgaas wrote:
> > > > On Mon, Apr 22, 2024 at 04:39:19PM -0700, Paul M Stillwell Jr wrote:
> > > > > On 4/22/2024 3:52 PM, Bjorn Helgaas wrote:
> > > > > > On Mon, Apr 22, 2024 at 02:39:16PM -0700, Paul M Stillwell Jr wrote:
> > > > > > > On 4/22/2024 1:27 PM, Bjorn Helgaas wrote:
> > > > > ...
> > > > 
> > > > > > > > _OSC negotiates ownership of features between platform firmware and
> > > > > > > > OSPM.  The "native_pcie_hotplug" and similar bits mean that "IF a
> > > > > > > > device advertises the feature, the OS can use it."  We clear those
> > > > > > > > native_* bits if the platform retains ownership via _OSC.
> > > > > > > > 
> > > > > > > > If BIOS doesn't enable the VMD host bridge and doesn't supply _OSC for
> > > > > > > > the domain below it, why would we assume that BIOS retains ownership
> > > > > > > > of the features negotiated by _OSC?  I think we have to assume the OS
> > > > > > > > owns them, which is what happened before 04b12ef163d1.
> > > > > > > 
> > > > > > > Sorry, this confuses me :) If BIOS doesn't enable VMD (i.e. VMD is disabled)
> > > > > > > then all the root ports and devices underneath VMD are visible to the BIOS
> > > > > > > and OS so ACPI would run on all of them and the _OSC bits should be set
> > > > > > > correctly.
> > > > > > 
> > > > > > Sorry, that was confusing.  I think there are two pieces to enabling
> > > > > > VMD:
> > > > > > 
> > > > > >      1) There's the BIOS "VMD enable" switch.  If set, the VMD device
> > > > > >      appears as an RCiEP and the devices behind it are invisible to the
> > > > > >      BIOS.  If cleared, VMD doesn't exist; the VMD RCiEP is hidden and
> > > > > >      the devices behind it appear as normal Root Ports with devices below
> > > > > >      them.
> > > > > > 
> > > > > >      2) When the BIOS "VMD enable" is set, the OS vmd driver configures
> > > > > >      the VMD RCiEP and enumerates things below the VMD host bridge.
> > > > > > 
> > > > > >      In this case, BIOS enables the VMD RCiEP, but it doesn't have a
> > > > > >      driver for it and it doesn't know how to enumerate the VMD Root
> > > > > >      Ports, so I don't think it makes sense for BIOS to own features for
> > > > > >      devices it doesn't know about.
> > > > > 
> > > > > That makes sense to me. It sounds like VMD should own all the features, I
> > > > > just don't know how the vmd driver would set the bits other than hotplug
> > > > > correctly... We know leaving them on is problematic, but I'm not sure what
> > > > > method to use to decide which of the other bits should be set or not.
> > > > 
> > > > My starting assumption would be that we'd handle the VMD domain the
> > > > same as other PCI domains: if a device advertises a feature, the
> > > > kernel includes support for it, and the kernel owns it, we enable it.
> > > 
> > > I've been poking around and it seems like some things (I was looking for
> > > AER) are global to the platform. In my investigation (which is a small
> > > sample size of machines) it looks like there is a single entry in the BIOS
> > > to enable/disable AER so whatever is in one domain should be the same in all
> > > the domains. I couldn't find settings for LTR or the other bits, but I'm not
> > > sure what to look for in the BIOS for those.
> > > 
> > > So it seems that there are 2 categories: platform global and device
> > > specific. AER and probably some of the others are global and can be copied
> > > from one domain to another, but things like hotplug are device specific and
> > > should be handled that way.
> > 
> > _OSC is the only mechanism for negotiating ownership of these
> > features, and PCI Firmware r3.3, sec 4.5.1, is pretty clear that _OSC
> > only applies to the hierarchy originated by the PNP0A03/PNP0A08 host
> > bridge that contains the _OSC method.  AFAICT, there's no
> > global/device-specific thing here.
> > 
> > The BIOS may have a single user-visible setting, and it may apply that
> > setting to all host bridge _OSC methods, but that's just part of the
> > BIOS UI, not part of the firmware/OS interface.
> 
> Fair, but we are still left with the question of how to set the _OSC bits
> for the VMD bridge. This would normally happen using ACPI AFAICT and we
> don't have that for the devices behind VMD.

In the absence of a mechanism for negotiating ownership, e.g., an ACPI
host bridge device for the hierarchy, the OS owns all the PCIe
features.

> > > > If a device advertises a feature but there's a hardware problem with
> > > > it, the usual approach is to add a quirk to work around the problem.
> > > > The Correctable Error issue addressed by 04b12ef163d1 ("PCI: vmd:
> > > > Honor ACPI _OSC on PCIe features"), looks like it might be in this
> > > > category.
> > > 
> > > I don't think we had a hardware problem with these Samsung (IIRC) devices;
> > > the issue was that the vmd driver were incorrectly enabling AER because
> > > those native_* bits get set automatically.
> > 
> > Where do all the Correctable Errors come from?  IMO they're either
> > caused by some hardware issue or by a software error in programming
> > AER.  It's possible we forget to clear the errors and we just see the
> > same error reported over and over.  But I don't think the answer is
> > to copy the AER ownership from a different domain.
> 
> I looked back at the original bugzilla and I feel like the AER errors are a
> red herring. AER was *supposed* to be disabled, but was incorrectly enabled
> by VMD so we are seeing errors. Yes, they may be real errors, but my point
> is that the user had disabled AER so they didn't care if there were errors
> or not (i.e. if AER had been correctly disabled by VMD then the user would
> not have AER errors in the dmesg output).

04b12ef163d1 basically asserted "the platform knows about a hardware
issue between VMD and this NVMe and avoided it by disabling AER in
domain 0000; therefore we should also disable AER in the VMD domain."

Your patch at
https://lore.kernel.org/linux-pci/20240408183927.135-1-paul.m.stillwell.jr@intel.com/
says "vmd users *always* want hotplug enabled."  What happens when a
platform knows about a hotplug hardware issue and avoids it by
disabling hotplug in domain 0000?

I think 04b12ef163d1 would avoid it in the VMD domain, but your patch
would expose the hotplug issue.

> Kai-Heng even says this in one of his responses here https://lore.kernel.org/linux-pci/CAAd53p6hATV8TOcJ9Qi2rMwVi=y_9+tQu6KhDkAm6Y8=cQ_xoA@mail.gmail.com/.
> A quote from his reply "To be more precise, AER is disabled by the platform
> vendor in BIOS to paper over the issue."

I suspect there's a real hardware issue between the VMD and the
Samsung NVMe that causes these Correctable Errors.  I think disabling
AER via _OSC is a bad way to work around it because:

  - it disables AER for *everything* in domain 0000, when other
    devices probably work perfectly fine,

  - it assumes the OS vmd driver applies domain 0000 _OSC to the VMD
    domain, which isn't required by any spec, and

  - it disables *all* of AER, including Uncorrectable Errors, and I'd
    like to know about those, even if we have to mask the Correctable
    Errors.

In https://bugzilla.kernel.org/show_bug.cgi?id=215027#c5, Kai-Heng did
not see the Correctable Error flood when VMD was turned off and
concluded that the issue is VMD specific.

But I think it's likely that the errors still occur even when VMD is
turned off, and we just don't see the flood because AER is disabled.
I suggested an experiment with "pcie_ports=native", which should
enable AER even if _OSC doesn't grant ownership:
https://bugzilla.kernel.org/show_bug.cgi?id=215027#c9 

Bjorn

