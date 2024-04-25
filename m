Return-Path: <linux-pci+bounces-6682-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F658B2D23
	for <lists+linux-pci@lfdr.de>; Fri, 26 Apr 2024 00:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 443CB2824E9
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 22:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0477917BB9;
	Thu, 25 Apr 2024 22:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9ZWC4j5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AAE175A5
	for <linux-pci@vger.kernel.org>; Thu, 25 Apr 2024 22:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714084341; cv=none; b=TH2MzPtVysFnyIlc1GbEFsPqModsfuQBJW9gC6ztpmsyQ0zblqij4/JUd0Zh7qlYMBMfDvasQjDHbvTatjLHECdR0lcBusXM+JQRCeRaxaDO2sS4dpNZZmrWJGLomUMExciC1NbVn5/4n9C658+sqqQFGcwFIBBeTHSmY7M437k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714084341; c=relaxed/simple;
	bh=AwlumUN5dXAkuBRxwv43Oi9CorUhyEOe+51EvU7NEqU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=R3Up1QVeq5kouxJljCzu8aySCOY6FDDscS2YKRsTP746+/LRi62g4Lqi6J8DoOPIFxmB/tNB70WjW1BLjzmEINR2bX7ibBa+3IAHl3Nuk8Lb43h1kqCu24w03VYJmhW+M50XHB5GAfT5LK1DWKA/ODtAXMRDj5ikqPeg+1ASLv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9ZWC4j5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1631FC113CC;
	Thu, 25 Apr 2024 22:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714084341;
	bh=AwlumUN5dXAkuBRxwv43Oi9CorUhyEOe+51EvU7NEqU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=N9ZWC4j5cFe+TXUO0cYIx43hADUsyjdCPSWex9Zkh2FaSbSc6VDlLlSfERxaj6CN4
	 ZXsVsM22Z8+f7U0keznnHlKJVeAjcLwzfKD9c7OqcRCQOSTf4esbYJJ8LvFDaBuuPd
	 JmX9GIgQA7S4/Q3Xww/ZLqGPds7aExGKHLCI04GzRAMfsJqjO7XsXyhBMfUAnQb7gS
	 iC39/UXXYmrN4eAvLVGNkq0VYq7EiFii12HBYyB4DDv0G0OiOO9tNOZlTeudCOMvch
	 rR8e072xWgPFXKndvsIc2TMe/JLVvqJryB/RqygS8Y6jcr2fDe9yeikxtimv9OIaeu
	 zFAmCqQnYHSbw==
Date: Thu, 25 Apr 2024 17:32:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Cc: linux-pci@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] Documentation: PCI: add vmd documentation
Message-ID: <20240425223219.GA546005@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <935baf43-791e-4c8e-9566-e05335e74cea@intel.com>

On Thu, Apr 25, 2024 at 02:43:07PM -0700, Paul M Stillwell Jr wrote:
> On 4/25/2024 10:24 AM, Bjorn Helgaas wrote:
> > On Wed, Apr 24, 2024 at 02:29:16PM -0700, Paul M Stillwell Jr wrote:
> > > On 4/23/2024 5:47 PM, Bjorn Helgaas wrote:
> ...

> > > > _OSC is the only mechanism for negotiating ownership of these
> > > > features, and PCI Firmware r3.3, sec 4.5.1, is pretty clear that _OSC
> > > > only applies to the hierarchy originated by the PNP0A03/PNP0A08 host
> > > > bridge that contains the _OSC method.  AFAICT, there's no
> > > > global/device-specific thing here.
> > > > 
> > > > The BIOS may have a single user-visible setting, and it may apply that
> > > > setting to all host bridge _OSC methods, but that's just part of the
> > > > BIOS UI, not part of the firmware/OS interface.
> > > 
> > > Fair, but we are still left with the question of how to set the _OSC bits
> > > for the VMD bridge. This would normally happen using ACPI AFAICT and we
> > > don't have that for the devices behind VMD.
> > 
> > In the absence of a mechanism for negotiating ownership, e.g., an ACPI
> > host bridge device for the hierarchy, the OS owns all the PCIe
> > features.
> 
> I'm new to this space so I don't know what it means for the OS to
> own the features. In other words, how would the vmd driver figure
> out what features are supported?

There are three things that go into this:

  - Does the OS support the feature, e.g., is CONFIG_PCIEAER enabled?

  - Has the platform granted permission to the OS to use the feature,
    either explicitly via _OSC or implicitly because there's no
    mechanism to negotiate ownership?

  - Does the device advertise the feature, e.g., does it have an AER
    Capability?

If all three are true, Linux enables the feature.

I think vmd has implicit ownership of all features because there is no
ACPI host bridge device for the VMD domain, and (IMO) that means there
is no way to negotiate ownership in that domain.

So the VMD domain starts with all the native_* bits set, meaning Linux
owns the features.  If the vmd driver doesn't want some feature to be
used, it could clear the native_* bit for it.

I don't think vmd should unilaterally claim ownership of features by
*setting* native_* bits because that will lead to conflicts with
firmware.

> > 04b12ef163d1 basically asserted "the platform knows about a hardware
> > issue between VMD and this NVMe and avoided it by disabling AER in
> > domain 0000; therefore we should also disable AER in the VMD domain."
> > 
> > Your patch at
> > https://lore.kernel.org/linux-pci/20240408183927.135-1-paul.m.stillwell.jr@intel.com/
> > says "vmd users *always* want hotplug enabled."  What happens when a
> > platform knows about a hotplug hardware issue and avoids it by
> > disabling hotplug in domain 0000?
> 
> I was thinking about this also and I could look at all the root ports
> underneath vmd and see if hotplug is set for any of them. If it is then we
> could set the native_*hotplug bits based on that.

No.  "Hotplug is set" means the device advertises the feature via
config space, in this case, it has the Hot-Plug Capable bit in the
PCIe Slot Capabilities set.  That just means the device has hardware
support for the feature.

On ACPI systems, the OS can only use pciehp on the device if firmware
has granted ownership to the OS via _OSC because the firmware may want
to use the feature itself.  If both OS and firmware think they own the
feature, they will conflict with each other.

If firmware retains owership of hotplug, it can field hotplug events
itself and notify the OS via the ACPI hotplug mechanism.  The acpiphp
driver handles those events for PCI.

Firmware may do this if it wants to work around hardware defects it
knows about, or if it wants to do OS-independent logging (more
applicable for AER), or if it wants to intercept hotplug events to do
some kind of initialization, etc.

Bjorn

