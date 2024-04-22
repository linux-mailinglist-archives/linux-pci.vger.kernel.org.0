Return-Path: <linux-pci+bounces-6544-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4C68AD868
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 01:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 946C1B24747
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 23:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45CA181326;
	Mon, 22 Apr 2024 22:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMuEuw3R"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F531181325
	for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2024 22:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713826377; cv=none; b=REZYejGWINCF8yW+8gRWa0JguNCqIPlWeXXxDF/i1orZF3MPnBADsARvpCykXWK+W6sZBxYwxDkwTe06DZ1JvgByKK0irFnPq5IB767DyarRLV4WxiXHnr7MgRFd35q6NCW6wBrgxqNBGzEVNKeNDdXfQXdc4eWK0sI0IS5nwbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713826377; c=relaxed/simple;
	bh=WA2HzIxe19OolAiE2Ffa22JSNPMSIdh8a4ZUV4ljiak=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NLCXmid3YcseeYpBCu/884ipYm3ju+Qt5685zrZWBamTfrOj4yOFW4E8AnmH+Z4AaGp1G3LVcuxifAsvW9HeqxSMq0uloi12PzT3Io33Cjsmtk8cHJ3dQpgutClFa0JFmB4VUx2KmsBzyEcxbeIcYm9RLBW2a1eGQrBBHzgn4UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMuEuw3R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01D6C2BD11;
	Mon, 22 Apr 2024 22:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713826377;
	bh=WA2HzIxe19OolAiE2Ffa22JSNPMSIdh8a4ZUV4ljiak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=MMuEuw3Rq8WVZZRJaOngg4dWZ3qN02X92RsSOI9DZ02pREpSEHvTLL4DFK4uZxCDy
	 xWRsgCVXVWzFyoGNgCHjooqQA9q4VWSdzyDOzHSMTG7CUyfT2spkGiQL+xKrPqFYni
	 ifAQNMlBJDpN+ptjWZrfniEP8dPcD+wQmhjEvMYZypqTOF0YJX083awKXmNf3/Hurh
	 t1p3ct+1vDxs/y7mHsYZZunqNzdaqzG9MJZdmYwP616pS6p0D/SAka5XYrunINJgBA
	 wUIvFXOfq2IXpLnppVomlyF0T7bZrVKu2Pb2goB4iWu5uBhM6QkYRRo9eSj6vNy6R4
	 34m4Q/hgKu4aA==
Date: Mon, 22 Apr 2024 17:52:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Cc: linux-pci@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] Documentation: PCI: add vmd documentation
Message-ID: <20240422225255.GA419484@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ba96aab-10ee-41b4-988b-2609b4d39f33@intel.com>

On Mon, Apr 22, 2024 at 02:39:16PM -0700, Paul M Stillwell Jr wrote:
> On 4/22/2024 1:27 PM, Bjorn Helgaas wrote:
> > On Fri, Apr 19, 2024 at 03:18:19PM -0700, Paul M Stillwell Jr wrote:
> > > On 4/19/2024 2:14 PM, Bjorn Helgaas wrote:
> > > > On Thu, Apr 18, 2024 at 02:51:19PM -0700, Paul M Stillwell Jr wrote:
> > > > > On 4/18/2024 11:26 AM, Bjorn Helgaas wrote:
> > > > > > On Wed, Apr 17, 2024 at 01:15:42PM -0700, Paul M Stillwell Jr wrote:
> > > > > > > Adding documentation for the Intel VMD driver and updating the index
> > > > > > > file to include it.
> > 
> > > > > >      - Which devices are passed through to a virtual guest and enumerated
> > > > > >        there?
> > > > > 
> > > > > All devices under VMD are passed to a virtual guest
> > > > 
> > > > So the guest will see the VMD Root Ports, but not the VMD RCiEP
> > > > itself?
> > > 
> > > The guest will see the VMD device and then the vmd driver in the guest will
> > > enumerate the devices behind it is my understanding
> > > 
> > > > > >      - Where does the vmd driver run (host or guest or both)?
> > > > > 
> > > > > I believe the answer is both.
> > > > 
> > > > If the VMD RCiEP isn't passed through to the guest, how can the vmd
> > > > driver do anything in the guest?
> > > 
> > > The VMD device is passed through to the guest. It works just like bare metal
> > > in that the guest OS detects the VMD device and loads the vmd driver which
> > > then enumerates the devices into the guest
> > 
> > I guess it's obvious that the VMD RCiEP must be passed through to the
> > guest because the whole point of
> > https://lore.kernel.org/linux-pci/20240408183927.135-1-paul.m.stillwell.jr@intel.com/
> > is to do something in the guest.
> > 
> > It does puzzle me that we have two copies of the vmd driver (one in
> > the host OS and another in the guest OS) that think they own the same
> > physical device.  I'm not a virtualization guru but that sounds
> > potentially problematic.
> > 
> > > > IIUC, the current situation is "regardless of what firmware said, in
> > > > the VMD domain we want AER disabled and hotplug enabled."
> > > 
> > > We aren't saying we want AER disabled, we are just saying we want hotplug
> > > enabled. The observation is that in a hypervisor scenario AER is going to be
> > > disabled because the _OSC bits are all 0.
> > 
> > 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe features") is saying
> > we want AER disabled for the VMD domain, isn't it?
> 
> I don't see it that way, but maybe I'm misunderstanding something. Here is
> the code from that commit (only the portion of interest):
> 
> +/*
> + * Since VMD is an aperture to regular PCIe root ports, only allow it to
> + * control features that the OS is allowed to control on the physical PCI
> bus.
> + */
> +static void vmd_copy_host_bridge_flags(struct pci_host_bridge *root_bridge,
> +                                      struct pci_host_bridge *vmd_bridge)
> +{
> +       vmd_bridge->native_pcie_hotplug = root_bridge->native_pcie_hotplug;
> +       vmd_bridge->native_shpc_hotplug = root_bridge->native_shpc_hotplug;
> +       vmd_bridge->native_aer = root_bridge->native_aer;
> +       vmd_bridge->native_pme = root_bridge->native_pme;
> +       vmd_bridge->native_ltr = root_bridge->native_ltr;
> +       vmd_bridge->native_dpc = root_bridge->native_dpc;
> +}
> +
> 
> When I look at this, we are copying whatever is in the root_bridge to the
> vmd_bridge.

Right.  We're copying the results of the _OSC that applies to the VMD
RCiEP (not an _OSC that applies to the VMD domain).

> In a bare metal scenario, this is correct and AER will be whatever
> the BIOS set up (IIRC on my bare metal system AER is enabled).

I think the first dmesg log at
https://bugzilla.kernel.org/show_bug.cgi?id=215027 is from a host OS:

  [    0.000000] DMI: Dell Inc. Dell G15 Special Edition 5521/, BIOS 0.4.3 10/20/2021
  [    0.408990] ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-e0])
  [    0.410076] acpi PNP0A08:00: _OSC: platform does not support [AER]
  [    0.412207] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME PCIeCapability LTR]
  [    1.367220] vmd 0000:00:0e.0: PCI host bridge to bus 10000:e0
  [    1.486704] pcieport 10000:e0:06.0: AER: enabled with IRQ 146

We evaluated _OSC for domain 0000 with OSC_QUERY_ENABLE ("Query
Support Flag" in the specs) and learned the platform doesn't support
AER, so we removed that from the features we request.  We don't
request control of AER in domain 0000, so native_aer will be 0.  AER
might be enabled by firmware, but the host Linux should not enable it
in domain 0000.

In domain 10000, the host Linux *does* enable AER because all new host
bridges (including the new VMD domain 10000) assume native control to
start with, and we update that based on _OSC results.  There's no ACPI
device describing the VMD host bridge, so there's no _OSC that applies
to it, so Linux assumes it owns everything.

> In a hypervisor scenario the root_bridge bits will all be 0 which
> effectively disables AER and all the similar bits.

I don't think https://bugzilla.kernel.org/show_bug.cgi?id=215027
includes a dmesg log from a hypervisor guest, so I don't know what
happens there.

The host_bridge->native_* bits always start as 1 (OS owns the feature)
and they only get cleared if there's an _OSC that retains firmware
ownership.

> Prior to this commit all the native_* bits were set to 1 because
> pci_init_host_bridge() sets them all to 1 so we were enabling AER et all
> despite what the OS may have wanted. With the commit we are setting the bits
> to whatever the BIOS has set them to.

Prior to 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe features"),
the host OS owned all features in the VMD domain.  After 04b12ef163d1,
it depended on whatever the _OSC for the VMD RCiEP said.

On the Dell mentioned in that bugzilla, the domain 0000 _OSC said AER
wasn't supported, and 04b12ef163d1 applied that to the VMD domain as
well, so the host OS didn't enable AER in either domain.

But other machines would have different answers.  On a machine that
supports AER and grants ownership to the OS, 04b12ef163d1 would enable
AER in both domain 0000 and the VMD domain.

I don't think we know the root cause of the Correctable Errors from
that bugzilla.  But it's likely that they would still occur on a
machine that granted AER to the OS, and if we enable AER in the VMD
domain, we would probably still have the flood.

That's is why I think 04b12ef163d1 is problematic: it only disables
AER in the VMD domain when AER happens to be disabled in domain 0000. 

> > > > It seems like the only clear option is to say "the vmd driver owns all
> > > > PCIe services in the VMD domain, the platform does not supply _OSC for
> > > > the VMD domain, the platform can't do anything with PCIe services in
> > > > the VMD domain, and the vmd driver needs to explicitly enable/disable
> > > > services as it needs."
> > > 
> > > I actually looked at this as well :) I had an idea to set the _OSC bits to 0
> > > when the vmd driver created the domain. The look at all the root ports
> > > underneath it and see if AER and PM were set. If any root port underneath
> > > VMD set AER or PM then I would set the _OSC bit for the bridge to 1. That
> > > way if any root port underneath VMD had enabled AER (as an example) then
> > > that feature would still work. I didn't test this in a hypervisor scenario
> > > though so not sure what I would see.
> > 
> > _OSC negotiates ownership of features between platform firmware and
> > OSPM.  The "native_pcie_hotplug" and similar bits mean that "IF a
> > device advertises the feature, the OS can use it."  We clear those
> > native_* bits if the platform retains ownership via _OSC.
> > 
> > If BIOS doesn't enable the VMD host bridge and doesn't supply _OSC for
> > the domain below it, why would we assume that BIOS retains ownership
> > of the features negotiated by _OSC?  I think we have to assume the OS
> > owns them, which is what happened before 04b12ef163d1.
> 
> Sorry, this confuses me :) If BIOS doesn't enable VMD (i.e. VMD is disabled)
> then all the root ports and devices underneath VMD are visible to the BIOS
> and OS so ACPI would run on all of them and the _OSC bits should be set
> correctly.

Sorry, that was confusing.  I think there are two pieces to enabling
VMD:

  1) There's the BIOS "VMD enable" switch.  If set, the VMD device
  appears as an RCiEP and the devices behind it are invisible to the
  BIOS.  If cleared, VMD doesn't exist; the VMD RCiEP is hidden and
  the devices behind it appear as normal Root Ports with devices below
  them.

  2) When the BIOS "VMD enable" is set, the OS vmd driver configures
  the VMD RCiEP and enumerates things below the VMD host bridge.

  In this case, BIOS enables the VMD RCiEP, but it doesn't have a
  driver for it and it doesn't know how to enumerate the VMD Root
  Ports, so I don't think it makes sense for BIOS to own features for
  devices it doesn't know about.

Bjorn

