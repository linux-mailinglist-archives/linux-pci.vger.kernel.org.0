Return-Path: <linux-pci+bounces-2962-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52172846288
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 22:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B7EA28D14F
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 21:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B372FC29;
	Thu,  1 Feb 2024 21:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuxrvAm6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F35012FB2F
	for <linux-pci@vger.kernel.org>; Thu,  1 Feb 2024 21:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706822182; cv=none; b=Ax2F41vqOsy0gK0zoFwGrGxHO2Kop0CifjA5l36fIs3RZDiJfrYFKbR0czvN9sfxL6/irpwP3uZlGe5eIBui2jxktLo3HPRK1uMF27bZp5G3j9AeZ8Hfquk93VB0wxCsJKc44sLVKKNMu2Bl2TTL9casB7mEsY/RfpmKUaDlDhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706822182; c=relaxed/simple;
	bh=qbW9DK7L944s8BNUje6TmqoIvzhQJgYCR+lgg5j0QRY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=W+0p7s0ZORt+1wiaoQ/v+S9rxoCUMcWnK3ql0Z9GiObd2WbwyLUS0gX1M8nJ/KWKBDyDLXornXKjvjfQEKHPv4cWHs/6Y1N7mSFKjGDa321RHaZpvB5F+aDo9pplno2jtdhwwzEupejB2iSGWOjd+rQQJT8+B5fuxxHff1QKv2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LuxrvAm6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D0EC433F1;
	Thu,  1 Feb 2024 21:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706822182;
	bh=qbW9DK7L944s8BNUje6TmqoIvzhQJgYCR+lgg5j0QRY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=LuxrvAm61UJBwZDNiuBoJbY3KXNwoN9subOBRJ2BG6GI30C75p3AyiH34DdIitevH
	 +hKLFR+s+n2Tg2v5aq3nEkIopkBGF8wWxVCcCixs/sRosBGIhY4UKg66D49sGf1w0I
	 OQa4JNBqjvvUIm/L1C6izzadmqr1BybuCU1V7VNQTQcpMhplEfo8gqu9f+xVKMyGQe
	 4cyHetJAynf+b5uKs8Fac+u84khEI5tVTGXtACS5VIK9HlJLj4hc7TzlVx9e72e10k
	 BZ2flGpZQzSJl5oUPzBFRneblxmKu+cqjWOC9Vt0boVktBapBuzNI39n66DHRldfXl
	 kXPHK5/D73Rug==
Date: Thu, 1 Feb 2024 15:16:20 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: linux-pci@vger.kernel.org, samruddh.dhope@intel.com,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v2] PCI: vmd: Enable Hotplug based on BIOS setting on VMD
 rootports
Message-ID: <20240201211620.GA650432@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117004933.GA108810@bhelgaas>

On Tue, Jan 16, 2024 at 06:49:33PM -0600, Bjorn Helgaas wrote:
> On Tue, Jan 16, 2024 at 01:37:32PM -0700, Nirmal Patel wrote:
> > On Fri, 2024-01-12 at 16:55 -0600, Bjorn Helgaas wrote:
> > ...
> > > Maybe it will help if we can make the
> > > situation more concrete.  I'm basing this on the logs at
> > > https://bugzilla.kernel.org/show_bug.cgi?id=215027.  I assume the
> > > 10000:e0:06.0 Root Port and the 10000:e1:00.0 NVMe device are both
> > > passed through to the guest.  I'm sure I got lots wrong here, so
> > > please correct me :)
> > > 
> > >   Host OS sees:
> > > 
> > >     PNP0A08 host bridge to 0000 [bus 00-ff]
> > >       _OSC applies to domain 0000
> > >       OS owns [PCIeHotplug SHPCHotplug PME PCIeCapability LTR] in
> > > domain 0000
> > >     vmd 0000:00:0e.0: PCI host bridge to domain 10000 [bus e0-ff]
> > >       no _OSC applies in domain 10000;
> > >       host OS owns all PCIe features in domain 10000
> > >     pci 10000:e0:06.0: [8086:464d]             # VMD root port
> > >     pci 10000:e0:06.0: PCI bridge to [bus e1]
> > >     pci 10000:e0:06.0: SltCap: HotPlug+        # Hotplug Capable
> > >     pci 10000:e1:00.0: [144d:a80a]             # nvme
> > > 
> > >   Guest OS sees:
> > > 
> > >     PNP0A03 host bridge to 0000 [bus 00-ff]
> > >       _OSC applies to domain 0000
> > >       platform owns [PCIeHotplug ...]          # _OSC doesn't grant
> > > to OS
> > >     pci 0000:e0:06.0: [8086:464d]              # VMD root port
> > >     pci 0000:e0:06.0: PCI bridge to [bus e1]
> > >     pci 0000:e0:06.0: SltCap: HotPlug+         # Hotplug Capable
> > >     pci 0000:e1:00.0: [144d:a80a]             # nvme
> > > 
> > > So the guest OS sees that the VMD Root Port supports hotplug, but
> > > it can't use it because it was not granted ownership of the
> > > feature?
> >
> > You are correct about _OSC not granting access in Guest.
> 
> I was assuming the VMD Endpoint itself was not visible in the guest
> and the VMD Root Ports appeared in domain 0000 described by the guest
> PNP0A03.  The PNP0A03 _OSC would then apply to the VMD Root Ports.
> But my assumption appears to be wrong:
> 
> > This is what I see on my setup.
> > 
> >   Host OS:
> > 
> >     ACPI: PCI Root Bridge [PC11] (domain 0000 [bus e2-fa])
> >     acpi PNP0A08:0b: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
> >     acpi PNP0A08:0b: _OSC: platform does not support [SHPCHotplug AER DPC]
> >     acpi PNP0A08:0b: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> >     PCI host bridge to bus 0000:e2
> > 
> >     vmd 0000:e2:00.5: PCI host bridge to bus 10007:00
> >     vmd 0000:e2:00.5: Bound to PCI domain 10007
> > 
> >   Guest OS:
> > 
> >     ACPI: PCI Root Bridge [PC0G] (domain 0000 [bus 03])
> >     acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
> >     acpi PNP0A08:01: _OSC: platform does not support [PCIeHotplug SHPCHotplug PME AER LTR DPC]
> >     acpi PNP0A08:01: _OSC: OS now controls [PCIeCapability]
> > 
> >     vmd 0000:03:00.0: Bound to PCI domain 10000
> > 
> >     SltCap: PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
> 
> Your example above suggests that the guest has a PNP0A08 device for
> domain 0000, with an _OSC, the guest sees the VMD Endpoint at
> 0000:03:00.0, and the VMD Root Ports and devices below them are in
> domain 10000.  Right?

Is my assumption here correct?  Do the VMD Endpoint, the VMD Root
Ports, and the devices below those Root Ports all visible to the
guest?

If so, it sounds like the VMD Endpoint is visible to both the host and
the guest?  I assume you only want it claimed by the vmd driver in
*one* of them?  If it's visible in both, how do you prevent one from
claiming it?

> If we decide the _OSC that covers the VMD Endpoint does *not* apply to
> the domain below the VMD bridge, the guest has no _OSC for domain
> 10000, so the guest OS should default to owning all the PCIe features
> in that domain.

I assume the guest sees the VMD Endpoint in domain 0000, right?

Does the guest have an _OSC for domain 0000?  If so, that would
clearly apply to the VMD Endpoint.

I think the guest sees the VMD Root Ports in domain 10000, along with
the devices below them, right?

I'm pretty sure the guest has no _OSC for domain 10000, i.e., for the
the VMD Root Ports and below, right?

Bjorn

