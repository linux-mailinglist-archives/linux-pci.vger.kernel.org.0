Return-Path: <linux-pci+bounces-35467-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FC6B44418
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 19:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15F4A5A4696
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 17:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410713093C3;
	Thu,  4 Sep 2025 17:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0bxKWok"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145092FE04B;
	Thu,  4 Sep 2025 17:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757005920; cv=none; b=QSZJ7IPID4fxUP5831J+MX+CWmh7M0KhBCIO8RNcYlUWZGvrXB62/uyxK87cC0tEhtlUPSIPxR4K+boY7cOUKGj1thovVg+uCV007tcwGUpE32YFBBSe2rkBhnDjAUXi+4DKIBcSaGezrFBtwjJ9tcIewFYS4+cacZvAYrMUei8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757005920; c=relaxed/simple;
	bh=f7w3DBoJ9ODVGCtDdMJAlM4c3N8LvQ5pSyBZEoaI1Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FsSrGa9GqEkBSgTjP7Dqopmtnp24xOiq2u/GgdVsE5bkbYBT6u8sdxxoMpnHhoavQbxuUosDbOtbnNk2iJ3Sc73GX3fwwoI3tF6s9xFZjpZbmEu5bawEFqEpbHW+NPWV0XBXojqRVWrWNYb1J+/X2D2CqvRKajUlG8WMzBDdLzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0bxKWok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896ACC4CEF0;
	Thu,  4 Sep 2025 17:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757005919;
	bh=f7w3DBoJ9ODVGCtDdMJAlM4c3N8LvQ5pSyBZEoaI1Cc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=o0bxKWok9GRdQgM3wXsBgRWWdIaD8bRw2Z3CwNfbzghaTAdsu/dtADJwCiZ9AgRX5
	 oXgsBK/UNI6xe+qQjjBN6Ab8ezqp4h7a4AinCVymE4eWvxw0D0XpOzkR+Z9rfL/Cml
	 UY9fqrkFNqD/tDYnnabV8y24J7NJ8MKuQEk//UFUXQCd/lc+Yfbe4y+aSUrNR1bmnJ
	 AKQomkwWym9Did3RImhyuJ8FfMHHapgV25Fq1nov2S7nrriSDs5JXnrZWNFlYblfnH
	 enN0bdwngy9YAJvg1f+F7niADqj5Kj5gD7isApxzNT11rGw4+9gxijnnP8lhHB8RFd
	 vkZs9q/ecNGpQ==
Date: Thu, 4 Sep 2025 12:11:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: "David E. Box" <david.e.box@linux.intel.com>, rafael@kernel.org,
	bhelgaas@google.com, vicamo.yang@canonical.com, kenny@panix.com,
	ilpo.jarvinen@linux.intel.com, nirmal.patel@linux.intel.com,
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/2] PCI/ASPM: Add host-bridge API to override default
 ASPM/CLKPM link state
Message-ID: <20250904171158.GA1268495@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a47sg5ahflhvzyzqnfxvpk3dw4clkhqlhznjxzwqpf4nyjx5dk@bcghz5o6zolk>

On Thu, Sep 04, 2025 at 10:15:44PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Sep 03, 2025 at 05:55:27PM GMT, Bjorn Helgaas wrote:
> > On Sun, Aug 31, 2025 at 06:28:53PM +0530, Manivannan Sadhasivam wrote:
> > > On Thu, Aug 28, 2025 at 03:43:45PM GMT, Bjorn Helgaas wrote:
> > > > On Mon, Aug 25, 2025 at 01:35:22PM -0700, David E. Box wrote:
> > > > > Synthetic PCIe hierarchies, such as those created by Intel VMD, are not
> > > > > enumerated by firmware and do not receive BIOS-provided ASPM or CLKPM
> > > > > defaults. Devices in such domains may therefore run without the intended
> > > > > power management.
> > > > > 
> > > > > Add a host-bridge mechanism that lets controller drivers supply their own
> > > > > defaults. A new aspm_default_link_state field in struct pci_host_bridge is
> > > > > set via pci_host_set_default_pcie_link_state(). During link initialization,
> > > > > if this field is non-zero, ASPM and CLKPM defaults come from it instead of
> > > > > BIOS.
> > > > > 
> > > > > This enables drivers like VMD to align link power management with platform
> > > > > expectations and avoids embedding controller-specific quirks in ASPM core
> > > > > logic.
> > > > 
> > > > I think this kind of sidesteps the real issue.  Drivers for host
> > > > controllers or PCI devices should tell us about *broken* things, but
> > > > not about things advertised by the hardware and available for use.
> > > > 
> > > > The only documented policy controls I'm aware of for ASPM are:
> > > > 
> > > >   - FADT "PCIe ASPM Controls" bit ("if set, OS must not enable ASPM
> > > >     control on this platform")
> > > > 
> > > >   - _OSC negotiation for control of the PCIe Capability (OS is only
> > > >     allowed to write PCI_EXP_LNKCTL if platform has granted control to
> > > >     the OS)
> > > > 
> > > > I think what we *should* be doing is enabling ASPM when it's
> > > > advertised, subject to those platform policy controls and user choices
> > > > like CONFIG_PCIEASPM_PERFORMANCE/POWERSAVE/etc and sysfs attributes.
> > > > 
> > > > So basically I think link->aspm_default should be PCIE_LINK_STATE_ALL
> > > > without drivers doing anything at all.  Maybe we have to carve out
> > > > exceptions, e.g., "VMD hierarchies are exempt from _OSC," or "devices
> > > > on x86 systems before 2026 can't enable more ASPM than BIOS did," or
> > > > whatever.  Is there any baby step we can make in that direction?
> > > 
> > > I'm not sure about the ACPI world, but for devicetree platforms,
> > > BIOS or the bootloader won't configure ASPM for the devices
> > > (mostly). So the baby step would be to set PCIE_LINK_STATE_ALL for
> > > all devicetree platforms :)
> > 
> > Yes.  How likely would this be to break something?
> 
> I don't know :) If we want to bite the bullet, let's do it.
> Otherwise, let's keep waiting for the time to come ;) For sure there
> will be breakages reported, but it won't be like on x86 which people
> use for day to day work.  There are IBM Power and MIPS based servers
> using devicetree as well, so they might also get impacted.
> 
> But it would be the optimal test bed if we ever want to start
> enabling ASPM by default.
> 
> > Before doing that, I think we need to add some logging, at least
> > at pci_dbg(), of what is already enabled and what we change, so we
> > have some kind of hint when things do break.
> 
> Sure. Even if we want to make it pci_info(), I think it would be
> worth doing it as it will make the reporting much easier.
> 
> Let me know if I can proceed with this.

Yes, I think so.  I would likely target v6.19 for upstream to give us
more time, but if we can get in -next for a bit now, that would be
great.  

