Return-Path: <linux-pci+bounces-35413-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AB1B42D16
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 00:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 722E6189D59E
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 22:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971492EFDAC;
	Wed,  3 Sep 2025 22:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXnHhCdj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696172EFD80;
	Wed,  3 Sep 2025 22:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756940129; cv=none; b=JlgLxYUk9DhaPD/Bv3JqA65w3mNy72eWJ6y0utf02wiysUPiXTg7LvWeqf5sGRQ1hknamwrzmD16Wak2f+oADDJYzvSLlkfunaKOS+NEWOBBYmuU+y6YpFt5eqmP31w+ZCWD6kIEqt8lVKSAcdFdfu2nL/0dmcsbuIoFCrlA/Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756940129; c=relaxed/simple;
	bh=1VgGtMZsWvs80zyeZmeX0N1kSokjzXOz9E4Nb9E9dD8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Maiiw0XdHRz54JOJifMLEOc2areYNOCoJuAD4rCF9ycQ3E7xGjzAavmG6yNvU/+t4aTT7w+wZrNNIc+mQU7xDWCMV8kqYykX0I0QCbqylHVWYL7lZ3x20YBiNUqOSJLPWL3gccs/xXYmBruVYy6YH2FeGiaB6es6WSusVo4CP88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXnHhCdj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2FD3C4CEE7;
	Wed,  3 Sep 2025 22:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756940128;
	bh=1VgGtMZsWvs80zyeZmeX0N1kSokjzXOz9E4Nb9E9dD8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=lXnHhCdjC99sj9uGG9oV9sG4kb9KCqUAT4Ys+KBfjrMN9j2nv1062Z10Cc0bw8ncn
	 Gw43AHBHHydaTnX/Z2mgF5PSwEuwuRptsY9a/D7QcFym6D76UrbYEROrV3WhJST/OO
	 wUEE3J9XFZ1rRErS5mmfJf1yNb6zATqF45fxbEl5Oquy49lbqvzlkxl3yO7UwWBwK3
	 UHbv4lNgom2seevc25qo591uc9K7s8dYJYojsKTu9l9aIKcWvC0UYOiwmEVno4s5jc
	 F/veSmKPMcH/mkmzn07HNkcmrlzDxcu1Z8jYmsOfgUCx4b5mrjSy3+j3xsxphgIDH2
	 8rCDRufj1ZYug==
Date: Wed, 3 Sep 2025 17:55:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: "David E. Box" <david.e.box@linux.intel.com>, rafael@kernel.org,
	bhelgaas@google.com, vicamo.yang@canonical.com, kenny@panix.com,
	ilpo.jarvinen@linux.intel.com, nirmal.patel@linux.intel.com,
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/2] PCI/ASPM: Add host-bridge API to override default
 ASPM/CLKPM link state
Message-ID: <20250903225527.GA1236657@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fo64esrc5v5vj46iff2ptgcthaeahwicuzug46popwqrryfsi@yt62sqsnv4e3>

On Sun, Aug 31, 2025 at 06:28:53PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Aug 28, 2025 at 03:43:45PM GMT, Bjorn Helgaas wrote:
> > On Mon, Aug 25, 2025 at 01:35:22PM -0700, David E. Box wrote:
> > > Synthetic PCIe hierarchies, such as those created by Intel VMD, are not
> > > enumerated by firmware and do not receive BIOS-provided ASPM or CLKPM
> > > defaults. Devices in such domains may therefore run without the intended
> > > power management.
> > > 
> > > Add a host-bridge mechanism that lets controller drivers supply their own
> > > defaults. A new aspm_default_link_state field in struct pci_host_bridge is
> > > set via pci_host_set_default_pcie_link_state(). During link initialization,
> > > if this field is non-zero, ASPM and CLKPM defaults come from it instead of
> > > BIOS.
> > > 
> > > This enables drivers like VMD to align link power management with platform
> > > expectations and avoids embedding controller-specific quirks in ASPM core
> > > logic.
> > 
> > I think this kind of sidesteps the real issue.  Drivers for host
> > controllers or PCI devices should tell us about *broken* things, but
> > not about things advertised by the hardware and available for use.
> > 
> > The only documented policy controls I'm aware of for ASPM are:
> > 
> >   - FADT "PCIe ASPM Controls" bit ("if set, OS must not enable ASPM
> >     control on this platform")
> > 
> >   - _OSC negotiation for control of the PCIe Capability (OS is only
> >     allowed to write PCI_EXP_LNKCTL if platform has granted control to
> >     the OS)
> > 
> > I think what we *should* be doing is enabling ASPM when it's
> > advertised, subject to those platform policy controls and user choices
> > like CONFIG_PCIEASPM_PERFORMANCE/POWERSAVE/etc and sysfs attributes.
> > 
> > So basically I think link->aspm_default should be PCIE_LINK_STATE_ALL
> > without drivers doing anything at all.  Maybe we have to carve out
> > exceptions, e.g., "VMD hierarchies are exempt from _OSC," or "devices
> > on x86 systems before 2026 can't enable more ASPM than BIOS did," or
> > whatever.  Is there any baby step we can make in that direction?
> 
> I'm not sure about the ACPI world, but for devicetree platforms,
> BIOS or the bootloader won't configure ASPM for the devices
> (mostly). So the baby step would be to set PCIE_LINK_STATE_ALL for
> all devicetree platforms :)

Yes.  How likely would this be to break something?

Before doing that, I think we need to add some logging, at least at
pci_dbg(), of what is already enabled and what we change, so we have
some kind of hint when things do break.

