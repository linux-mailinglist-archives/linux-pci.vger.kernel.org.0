Return-Path: <linux-pci+bounces-35463-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5C3B442E9
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 18:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD3E31CC2B4B
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 16:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E0A23507B;
	Thu,  4 Sep 2025 16:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fn3N8jCy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827C3230BEC;
	Thu,  4 Sep 2025 16:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003750; cv=none; b=AONh0Zrs2m5mWjT+q/IwFCLQ6PFe8Ix8nIXi066ELnoSa0czuJlie3uCVEvJDqxplwC9y/F7w7ozaLmgIVkxCh1wo2AYKhT4BHErRlktvPbsLtZU1DB+0U01Qc8ZC/asMstqjG3RAdV6E6kaO4THLMDbSvUPrsbN5YXgETBLswY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003750; c=relaxed/simple;
	bh=licaZp2ybh8noYPh9P971ur58m6wEBdUMOVNCc7Es9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AuTNI1zuQCs9MMIoaBvGxRiS/2gccNRDTeMI//HRPyh7IjTsxpUMR3vc+kzgZf6Bl6oIE9gOCjuRB/Vb/WWVRt1qJQ56ogKRF9Cj+SJCHY+pD24bV+TDVSSjJ0YEvSFog1K0Vr4wNN6djPXO9z1IV43zc9Y87ViBwpsEX3D8sMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fn3N8jCy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F27FC4CEF0;
	Thu,  4 Sep 2025 16:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757003750;
	bh=licaZp2ybh8noYPh9P971ur58m6wEBdUMOVNCc7Es9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fn3N8jCya+OEPCs9oBYZply8Iq7u146UCHkl8NI7Ks+J0dCCYHDEjvhktJ9fEFARD
	 7gyiILo7qFQz7gYLy0mFEHIugCVvw84/a6yAT98sQXUBe98Ma8svlRbBg9ePG+Bfiu
	 +akXBeYnsAKaUoVOH+cJxKKZmDxjic7J5L5l6sVdYBHQKCkSnKe/IUkc6KkmKZvd4f
	 IBcKu/TYuzTctbKsviy1td2Za8jDwaR9roOUAXaG2u/XTZrIUHWAugfJrDzo1PmimJ
	 mm+LXaUJmApZkdpIjFQJkRVY5IigpQNAs7baA/xjXXzczYKgkw/F7dE9em8Pkd/pMY
	 n9TpaFQdcH0Qw==
Date: Thu, 4 Sep 2025 22:05:38 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: David Box <david.e.box@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, rafael@kernel.org, 
	bhelgaas@google.com, vicamo.yang@canonical.com, kenny@panix.com, 
	ilpo.jarvinen@linux.intel.com, nirmal.patel@linux.intel.com, linux-pm@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/2] PCI/ASPM: Add host-bridge API to override default
 ASPM/CLKPM link state
Message-ID: <edsuntasypojlpegqec4chsixmxvutcetnklkglah5dooe5xai@y6vh6lrnp72f>
References: <ng67s7imjpj7i5ym7unvmewzhyk4ybgpkgw5aizicfs423vsxh@hvpfmk32ooe4>
 <20250903230450.GA1236832@bhelgaas>
 <ywuno3ssrgl3limng35j4hep6l7qvx5zmyuutrv4nqhd7r34pf@4apznk3xyyiv>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ywuno3ssrgl3limng35j4hep6l7qvx5zmyuutrv4nqhd7r34pf@4apznk3xyyiv>

On Thu, Sep 04, 2025 at 09:02:38AM GMT, David Box wrote:
> On Wed, Sep 03, 2025 at 06:04:50PM -0500, Bjorn Helgaas wrote:
> > On Fri, Aug 29, 2025 at 12:54:20PM -0700, David Box wrote:
> > > On Thu, Aug 28, 2025 at 03:43:45PM -0500, Bjorn Helgaas wrote:
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
> > > 
> > > I agree with the principle. The intent isn’t for VMD (or any controller) to
> > > override valid platform policy. It’s to handle synthetic domains where the
> > > platform doesn’t provide any policy path (no effective _OSC/FADT for the child
> > > hierarchy). In those cases, the controller is the only agent that knows the
> > > topology and can supply sane defaults.
> > > 
> > > I’m happy to tighten the patch to explicitly cover synthetic domains only.
> > > Instead of an API, we could have a boolean flag 'aspm_synthetic_domain'. When
> > > set by the controller, we can do:
> > > 
> > >     if (host_bridge->aspm_synthetic_domain)
> > >             link->aspm_default = PCIE_LINK_STATE_ALL;
> > > 
> > > This at least addresses your concern about policy decision, leaving it to the
> > > core to determine how these domains are handled rather than an ABI that lets
> > > domains set policy.
> > > 
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
> > > > 
> > > > This feels a little scary, so feel free to convince me it can't be
> > > > done :)
> > > 
> > > I understand your direction of enabling all advertised states by
> > > default (subject to FADT/_OSC and user settings). To explore that,
> > > I’ll send an RFC in parallel with this patch that proposes a baby
> > > step, e.g.  add instrumentation so we can see where BIOS left
> > > capabilities unused, and make it opt-in via a boot param so we can
> > > evaluate impact safely.
> > 
> > The instrumentation, absolutely.  We need something about what was
> > already enabled and when we change things.
> > 
> > > So this series will handle the VMD gap directly, and the RFC can
> > > kick off the wider discussion about defaults on ACPI-managed hosts.
> > > Does that sound like a reasonable approach and split?
> > 
> > I don't really want a parallel approach because I don't think it would
> > ever converge again.  BUT I think you're still OK for VMD, because I
> > think the default should be PCIE_LINK_STATE_ALL, and when we carve out
> > the exceptions that would not be in vmd.c, and it's easy to say that
> > there's no exception for VMD.
> 
> While I agree this is a better overall direction, it still won’t cover VMD in
> the “FADT disallows OS ASPM control” case. VMD (and others) are already using
> pci_enable_link_state() to set PCIE_LINK_STATE_ALL. But that doesn’t apply when
> aspm_disabled = 1, which is the primary issue this patch addresses — moving away
> from a runtime control setting to init-time and allowing policy to be set even
> when aspm_disabled = 1.
> 
> I want to be clear that this is needed because VMD is NOT fully ACPI-compliant.
> There is AML code, but it’s deliberately obfuscated to prevent the OS from
> enumerating the devices natively [1]. VMD was designed to give the driver
> complete control over the domain configuration, and that includes power
> management settings.
> 
> So I can send a patch to make the default PCIE_LINK_STATE_ALL, but I would still
> need a follow-on in that series that does something like:
> 
> 	if (host_bridge->synthetic_domain)
> 		link->aspm_default = PCIE_LINK_STATE_ALL;
> 
> 
> That carve-out is still required, because without it synthetic domains like VMD
> would inherit invalid or nonexistent BIOS defaults. The key difference is that
> only vmd.c would set itself as synthetic_domain; ASPM core still decides what
> policy applies.
> 

Both VMD and the non-ACPI host bridge controllers are mostly same functionality
wise, so I don't think the 'synthetic_domain' property makes sense.

IMO, it is better to go with the API introduced in this patch for VMD as it
clearly tells us the host bridge driver is overriding for a purpose and I can
set PCIE_LINK_STATE_ALL for DT based platforms separately.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

