Return-Path: <linux-pci+bounces-6492-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1838AB64E
	for <lists+linux-pci@lfdr.de>; Fri, 19 Apr 2024 23:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9F0A2814BE
	for <lists+linux-pci@lfdr.de>; Fri, 19 Apr 2024 21:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3945110A3B;
	Fri, 19 Apr 2024 21:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NX0t9UXq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146B310A2C
	for <linux-pci@vger.kernel.org>; Fri, 19 Apr 2024 21:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713561243; cv=none; b=lcpoAEhPLzCFnfzR46Mde8QYHlJk63qnlf2sXiiQ3RwaIPV60hvYa91k34sS5tRSyTWCrD6VdhC9TbS7vOJxqb88YJ1HWQJ4ce06GSuUuEwfUtMRY3/PCNa9J0cKlKnhg1R3Xbs/xwFzPYz9qLLAKFqsPsGpJiRMUgh0MIYsSJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713561243; c=relaxed/simple;
	bh=gZRtt/tYWXbXu6EWt8HLYKp4pjpwttkjS13UQWgNH+s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lI967ScUN2OAPh5G3BdPaU5D73Yl+ZMsP5dSK7IzgapIUop2s48wPz+BZFWNv9eDlxDAJ3buqMZDZfMlDl/oaCoMjN+h85pNlqcjHIIO1LseDtVCYAeHf3Qy8VvsMtO4ulLecq9u6evyiGzGRfYIxZLSIkcbAW6qHRG+VPVSv5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NX0t9UXq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2C4C072AA;
	Fri, 19 Apr 2024 21:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713561242;
	bh=gZRtt/tYWXbXu6EWt8HLYKp4pjpwttkjS13UQWgNH+s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NX0t9UXqs7zd+CVjGBizVXaGLzkVieyVIsW6yjiCLcijHk1f9jzzggNmTmLJjIX/B
	 4LqnNvl5ezD+1VNLhW+yHhTkxWaCTwEBVPXpTYrmmQRWM+ruQyv0aXZWPEZXutI1VG
	 +S6kyVM36ZRDmMvwLrXjN3ecHWldV0QUiQ/yEY5vXSKDfJ/JKgmNpHsdY6TQpYsL/f
	 kOkyEwkLv+u3XltUaBqpLgvavJQzXSAS7dBBHZZ5W6bedPdHusnkvZo4+Qerxaq+E5
	 JhJlypA0OxkuzVDplORKF0ZdF4tz5exkyzNGqE7XNHV78owmqiFcKmsSn2uk8OQ31z
	 QK5FCxxqg2TlQ==
Date: Fri, 19 Apr 2024 16:14:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Cc: linux-pci@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] Documentation: PCI: add vmd documentation
Message-ID: <20240419211400.GA295110@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68b92dca-2e51-4604-99e8-58a42459218a@intel.com>

[+cc Kai-Heng, Rafael, Lorenzo since we're talking about 04b12ef163d1
("PCI: vmd: Honor ACPI _OSC on PCIe features")]

On Thu, Apr 18, 2024 at 02:51:19PM -0700, Paul M Stillwell Jr wrote:
> On 4/18/2024 11:26 AM, Bjorn Helgaas wrote:
> > On Wed, Apr 17, 2024 at 01:15:42PM -0700, Paul M Stillwell Jr wrote:
> > > Adding documentation for the Intel VMD driver and updating the index
> > > file to include it.
> > > 
> > > Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> > > ---
> > >   Documentation/PCI/controller/vmd.rst | 51 ++++++++++++++++++++++++++++
> > >   Documentation/PCI/index.rst          |  1 +
> > >   2 files changed, 52 insertions(+)
> > >   create mode 100644 Documentation/PCI/controller/vmd.rst
> > > 
> > > diff --git a/Documentation/PCI/controller/vmd.rst b/Documentation/PCI/controller/vmd.rst
> > > new file mode 100644
> > > index 000000000000..e1a019035245
> > > --- /dev/null
> > > +++ b/Documentation/PCI/controller/vmd.rst
> > > @@ -0,0 +1,51 @@
> > > +.. SPDX-License-Identifier: GPL-2.0+
> > > +
> > > +=================================================================
> > > +Linux Base Driver for the Intel(R) Volume Management Device (VMD)
> > > +=================================================================
> > > +
> > > +Intel vmd Linux driver.
> > > +
> > > +Contents
> > > +========
> > > +
> > > +- Overview
> > > +- Features
> > > +- Limitations
> > > +
> > > +The Intel VMD provides the means to provide volume management across separate
> > > +PCI Express HBAs and SSDs without requiring operating system support or
> > > +communication between drivers. It does this by obscuring each storage
> > > +controller from the OS, but allowing a single driver to be loaded that would
> > > +control each storage controller. A Volume Management Device (VMD) provides a
> > > +single device for a single storage driver. The VMD resides in the IIO root
> > 
> > I'm not sure IIO (and PCH below) are really relevant to this.  I think
> 
> I'm trying to describe where in the CPU architecture VMD exists because it's
> not like other devices. It's not like a storage device or networking device
> that is plugged in somewhere; it exists as part of the CPU (in the IIO). I'm
> ok removing it, but it might be confusing to someone looking at the
> documentation. I'm also close to this so it may be clear to me, but
> confusing to others (which I know it is) so any help making it clearer would
> be appreciated.

The vmd driver binds to a PCI device, and it doesn't matter where it's
physically implemented.

> > we really just care about the PCI topology enumerable by the OS.  If
> > they are relevant, expand them on first use as you did for VMD so we
> > have a hint about how to learn more about it.
> 
> I don't fully understand this comment. The PCI topology behind VMD is not
> enumerable by the OS unless we are considering the vmd driver the OS. If the
> user enables VMD in the BIOS and the vmd driver isn't loaded, then the OS
> never sees the devices behind VMD.
> 
> The only reason the devices are seen by the OS is that the VMD driver does
> some mapping when the VMD driver loads during boot.

Yes.  I think it's worth mentioning these details about the hierarchy
behind VMD, e.g., how their config space is reached, how driver MMIO
accesses are routed, how device interrupts are routed, etc.

The 185a383ada2e ("x86/PCI: Add driver for Intel Volume Management
Device (VMD)") commit log mentioned by Keith is a fantastic start
and answers several things below.  Putting it in this doc would be
great because that commit is not very visible.

> > > +the VMD is in a central location to manipulate access to storage devices which
> > > +may be attached directly to the IIO or indirectly through the PCH. Instead of
> > > +allowing individual storage devices to be detected by the OS and allow it to
> > > +load a separate driver instance for each, the VMD provides configuration
> > > +settings to allow specific devices and root ports on the root bus to be
> > > +invisible to the OS.
> > 
> > How are these settings configured?  BIOS setup menu?
> 
> I believe there are 2 ways this is done:
> 
> The first is that the system designer creates a design such that some root
> ports and end points are behind VMD. If VMD is enabled in the BIOS then
> these devices don't show up to the OS and require a driver to use them (the
> vmd driver). If VMD is disabled in the BIOS then the devices are seen by the
> OS at boot time.
> 
> The second way is that there are settings in the BIOS for VMD. I don't think
> there are many settings... it's mostly enable/disable VMD

I think what I want to know here is just "there's a BIOS switch that
enables VMD, resulting in only the VMD RCiEP being visible, or
disables VMD, resulting in the VMD RCiEP not being visible (?) and the
VMD Root Ports and downstream hierarchies being just normal Root
Ports."  You can wordsmith that; I just wanted to know what
"configuration settings" referred to so users would know where they
live and what they mean.

> > > +VMD works by creating separate PCI domains for each VMD device in the system.
> > > +This makes VMD look more like a host bridge than an endpoint so VMD must try
> > > +to adhere to the ACPI Operating System Capabilities (_OSC) flags of the system.

> > I think "creating a separate PCI domain" is a consequence of providing
> > a new config access mechanism, e.g., a new ECAM region, for devices
> > below the VMD bridge.  That hardware mechanism is important to
> > understand because it means those downstream devices are unknown to
> > anything that doesn't grok the config access mechanism.  For example,
> > firmware wouldn't know anything about them unless it had a VMD driver.

> >    - Which devices (VMD bridge, VMD Root Ports, devices below VMD Root
> >      Ports) are enumerated in the host?
> 
> Only the VMD device (as a PCI end point) are seen by the OS without the vmd
> driver

This is the case when VMD is enabled by BIOS, right?  And when the vmd
driver sets up the new config space and enumerates behind VMD, we'll
find the VMD Root Ports and the hierarchies below them?

If BIOS leaves the VMD functionality disabled, I guess those VMD Root
Ports and the hierarchies below them are enumerated normally, without
the vmd driver being involved?  (Maybe the VMD RCiEP itself is
disabled, so we won't enumerate it and we won't try to bind the vmd
driver to it?)

> >    - Which devices are passed through to a virtual guest and enumerated
> >      there?
> 
> All devices under VMD are passed to a virtual guest

So the guest will see the VMD Root Ports, but not the VMD RCiEP
itself?

> >    - Where does the vmd driver run (host or guest or both)?
> 
> I believe the answer is both.

If the VMD RCiEP isn't passed through to the guest, how can the vmd
driver do anything in the guest?

> >    - Who (host or guest) runs the _OSC for the new VMD domain?
> 
> I believe the answer here is neither :) This has been an issue since commit
> 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe features"). I've submitted
> this patch (https://lore.kernel.org/linux-pci/20240408183927.135-1-paul.m.stillwell.jr@intel.com/)
> to attempt to fix the issue.

IIUC we make no attempt to evaluate _OSC for the new VMD domain (and
firmware likely would not supply one anyway since it doesn't know how
to enumerate anything there).  So 04b12ef163d1 just assumes the _OSC
that applies to the VMD RCiEP also applies to the new VMD domain below
the VMD.

If that's what we want to happen, we should state this explicitly.
But I don't think it *is* what we want; see below.

> You are much more of an expert in this area than I am, but as far as I can
> tell the only way the _OSC bits get cleared is via ACPI (specifically this
> code https://elixir.bootlin.com/linux/latest/source/drivers/acpi/pci_root.c#L1038).
> Since ACPI doesn't run on the devices behind VMD the _OSC bits don't get set
> properly for them.

Apparently there's *something* in ACPI related to the VMD domain
because 59dc33252ee7 ("PCI: VMD: ACPI: Make ACPI companion lookup work
for VMD bus") seems to add support for ACPI companions for devices in
the VMD domain?

I don't understand what's going on here because if BIOS enables VMD,
firmware would see the VMD RCiEP but not devices behind it.  And if
BIOS disables VMD, those devices should all appear normally and we
wouldn't need 59dc33252ee7.

> Ultimately the only _OSC bits that VMD cares about are the hotplug bits
> because that is a feature of our device; it enables hotplug in guests where
> there is no way to enable it. That's why my patch is to set them all the
> time and copy the other _OSC bits because there is no other way to enable
> this feature (i.e. there is no user space tool to enable/disable it).

And here's the problem, because the _OSC that applies to domain X that
contains the VMD RCiEP may result in the platform retaining ownership
of all these PCIe features (hotplug, AER, PME, etc), but you want OSPM
to own them for the VMD domain Y, regardless of whether it owns them
for domain X.

OSPM *did* own all PCIe features before 04b12ef163d1 because the new
VMD "host bridge" got native owership by default.

> >    - What happens to interrupts generated by devices downstream from
> >      VMD, e.g., AER interrupts from VMD Root Ports, hotplug interrupts
> >      from VMD Root Ports or switch downstream ports?  Who fields them?
> >      In general firmware would field them unless it grants ownership
> >      via _OSC.  If firmware grants ownership (or the OS forcibly takes
> >      it by overriding it for hotplug), I guess the OS that requested
> >      ownership would field them?
> 
> The interrupts are passed through VMD to the OS. This was the AER issue that
> resulted in commit 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe
> features"). IIRC AER was disabled in the BIOS, but is was enabled in the VMD
> host bridge because pci_init_host_bridge() sets all the bits to 1 and that
> generated an AER interrupt storm.
>
> In bare metal scenarios the _OSC bits are correct, but in a hypervisor
> scenario the bits are wrong because they are all 0 regardless of what the
> ACPI tables indicate. The challenge is that the VMD driver has no way to
> know it's in a hypervisor to set the hotplug bits correctly.

This is the problem.  We claim "the bits are wrong because they are
all 0", but I don't think we can derive that conclusion from anything
in the ACPI, PCIe, or PCI Firmware specs, which makes it hard to
maintain.

IIUC, the current situation is "regardless of what firmware said, in
the VMD domain we want AER disabled and hotplug enabled."

04b12ef163d1 disabled AER by copying the _OSC that applied to the VMD
RCiEP (although this sounds broken because it probably left AER
*enabled* if that _OSC happened to grant ownership to the OS).

And your patch at
https://lore.kernel.org/linux-pci/20240408183927.135-1-paul.m.stillwell.jr@intel.com/ 
enables hotplug by setting native_pcie_hotplug to 1.

It seems like the only clear option is to say "the vmd driver owns all
PCIe services in the VMD domain, the platform does not supply _OSC for
the VMD domain, the platform can't do anything with PCIe services in
the VMD domain, and the vmd driver needs to explicitly enable/disable
services as it needs."

Bjorn

