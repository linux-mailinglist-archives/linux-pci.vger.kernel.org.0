Return-Path: <linux-pci+bounces-35458-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB59B44224
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 18:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1EA77B94B9
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 16:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92022D23AD;
	Thu,  4 Sep 2025 16:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FwmLMlkD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFB021ABB1;
	Thu,  4 Sep 2025 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757001763; cv=none; b=Tb3wa7kYzmiXkw2BUjAF/cpeMwWTqjZsPSTUF5o/a2V4VBYh2cgqlFdv5DQPofDMNcIzR2ZvqQK6bHLl+T6Jzf2xAMlb/2ZO4UfzEPZrX2wy1XLf1NHVjYUg6XxgFPd7O/0z6Fek0PDCfNGSJ70zi81vDQX1QrJw00Mb8Ddnrko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757001763; c=relaxed/simple;
	bh=pheMGAkf0K4IQpbn9e9J7dH+mfy1I5P57UhKPRN2+9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mc1QhABdk1+Wu1vRbxWg8NI6UNwufKcBZlS1kJczgV2n6L/PcWsTpkZe7tKVnf5TNVg9lVySy46laaCrcX2ILpTALc7g+46IUq3d1+Fr0+mTYyVdjVdzS74Ahga5laIVlub9UYV3q7Zqzl8ibZZu4lVYDNX3uJ/kkKKcxUNEYzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FwmLMlkD; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757001762; x=1788537762;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=pheMGAkf0K4IQpbn9e9J7dH+mfy1I5P57UhKPRN2+9E=;
  b=FwmLMlkDh0NLHWQ6w2MfJYTWNdZy5DJAvt6mdm/SftJcdYIi0ybd9pSg
   up4joPsi+PjkcHIJUwCKNtnc10fbMCP7yWRIoNG7bKJsxlmGOlLnnq4d1
   dP7grKwxa25c1laTIReif41Htx81vviGckfNIcgBs36Pn+91j9LPV2hiY
   FtUdff8qzbhHtjDeFXMAfU17MpiZwCPLehI5xFXdNaw6rdIsoCtZKnWtp
   OAl3wQMRjKqc0eRSI/DZ26wOpMbcR9wYTYO4eMsbbqU7tAjV1ayyN50N1
   eMW4OxmyqWYrjUe0Ga1Ww0tAuTqkuODlLT8X9tnwuZijAjRT1Viq3G9rj
   w==;
X-CSE-ConnectionGUID: +nczk9iOQtG9W1JvHxNn9w==
X-CSE-MsgGUID: Mn0dZ2xuTd+jpm8u2+1ULg==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="70052121"
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="70052121"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 09:02:41 -0700
X-CSE-ConnectionGUID: 6JtMA/ekS4WYbDsrSQY6Ug==
X-CSE-MsgGUID: 9My3ZJtmQ9aLsqt9H3Ce7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="171162722"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.85])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 09:02:40 -0700
Date: Thu, 4 Sep 2025 09:02:38 -0700
From: David Box <david.e.box@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: rafael@kernel.org, bhelgaas@google.com, vicamo.yang@canonical.com, 
	kenny@panix.com, ilpo.jarvinen@linux.intel.com, nirmal.patel@linux.intel.com, 
	mani@kernel.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/2] PCI/ASPM: Add host-bridge API to override default
 ASPM/CLKPM link state
Message-ID: <ywuno3ssrgl3limng35j4hep6l7qvx5zmyuutrv4nqhd7r34pf@4apznk3xyyiv>
References: <ng67s7imjpj7i5ym7unvmewzhyk4ybgpkgw5aizicfs423vsxh@hvpfmk32ooe4>
 <20250903230450.GA1236832@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250903230450.GA1236832@bhelgaas>

On Wed, Sep 03, 2025 at 06:04:50PM -0500, Bjorn Helgaas wrote:
> On Fri, Aug 29, 2025 at 12:54:20PM -0700, David Box wrote:
> > On Thu, Aug 28, 2025 at 03:43:45PM -0500, Bjorn Helgaas wrote:
> > > On Mon, Aug 25, 2025 at 01:35:22PM -0700, David E. Box wrote:
> > > > Synthetic PCIe hierarchies, such as those created by Intel VMD, are not
> > > > enumerated by firmware and do not receive BIOS-provided ASPM or CLKPM
> > > > defaults. Devices in such domains may therefore run without the intended
> > > > power management.
> > > > 
> > > > Add a host-bridge mechanism that lets controller drivers supply their own
> > > > defaults. A new aspm_default_link_state field in struct pci_host_bridge is
> > > > set via pci_host_set_default_pcie_link_state(). During link initialization,
> > > > if this field is non-zero, ASPM and CLKPM defaults come from it instead of
> > > > BIOS.
> > > > 
> > > > This enables drivers like VMD to align link power management with platform
> > > > expectations and avoids embedding controller-specific quirks in ASPM core
> > > > logic.
> > > 
> > > I think this kind of sidesteps the real issue.  Drivers for host
> > > controllers or PCI devices should tell us about *broken* things, but
> > > not about things advertised by the hardware and available for use.
> > 
> > I agree with the principle. The intent isn’t for VMD (or any controller) to
> > override valid platform policy. It’s to handle synthetic domains where the
> > platform doesn’t provide any policy path (no effective _OSC/FADT for the child
> > hierarchy). In those cases, the controller is the only agent that knows the
> > topology and can supply sane defaults.
> > 
> > I’m happy to tighten the patch to explicitly cover synthetic domains only.
> > Instead of an API, we could have a boolean flag 'aspm_synthetic_domain'. When
> > set by the controller, we can do:
> > 
> >     if (host_bridge->aspm_synthetic_domain)
> >             link->aspm_default = PCIE_LINK_STATE_ALL;
> > 
> > This at least addresses your concern about policy decision, leaving it to the
> > core to determine how these domains are handled rather than an ABI that lets
> > domains set policy.
> > 
> > > The only documented policy controls I'm aware of for ASPM are:
> > > 
> > >   - FADT "PCIe ASPM Controls" bit ("if set, OS must not enable ASPM
> > >     control on this platform")
> > > 
> > >   - _OSC negotiation for control of the PCIe Capability (OS is only
> > >     allowed to write PCI_EXP_LNKCTL if platform has granted control to
> > >     the OS)
> > > 
> > > I think what we *should* be doing is enabling ASPM when it's
> > > advertised, subject to those platform policy controls and user choices
> > > like CONFIG_PCIEASPM_PERFORMANCE/POWERSAVE/etc and sysfs attributes.
> > > 
> > > So basically I think link->aspm_default should be PCIE_LINK_STATE_ALL
> > > without drivers doing anything at all.  Maybe we have to carve out
> > > exceptions, e.g., "VMD hierarchies are exempt from _OSC," or "devices
> > > on x86 systems before 2026 can't enable more ASPM than BIOS did," or
> > > whatever.  Is there any baby step we can make in that direction?
> > > 
> > > This feels a little scary, so feel free to convince me it can't be
> > > done :)
> > 
> > I understand your direction of enabling all advertised states by
> > default (subject to FADT/_OSC and user settings). To explore that,
> > I’ll send an RFC in parallel with this patch that proposes a baby
> > step, e.g.  add instrumentation so we can see where BIOS left
> > capabilities unused, and make it opt-in via a boot param so we can
> > evaluate impact safely.
> 
> The instrumentation, absolutely.  We need something about what was
> already enabled and when we change things.
> 
> > So this series will handle the VMD gap directly, and the RFC can
> > kick off the wider discussion about defaults on ACPI-managed hosts.
> > Does that sound like a reasonable approach and split?
> 
> I don't really want a parallel approach because I don't think it would
> ever converge again.  BUT I think you're still OK for VMD, because I
> think the default should be PCIE_LINK_STATE_ALL, and when we carve out
> the exceptions that would not be in vmd.c, and it's easy to say that
> there's no exception for VMD.

While I agree this is a better overall direction, it still won’t cover VMD in
the “FADT disallows OS ASPM control” case. VMD (and others) are already using
pci_enable_link_state() to set PCIE_LINK_STATE_ALL. But that doesn’t apply when
aspm_disabled = 1, which is the primary issue this patch addresses — moving away
from a runtime control setting to init-time and allowing policy to be set even
when aspm_disabled = 1.

I want to be clear that this is needed because VMD is NOT fully ACPI-compliant.
There is AML code, but it’s deliberately obfuscated to prevent the OS from
enumerating the devices natively [1]. VMD was designed to give the driver
complete control over the domain configuration, and that includes power
management settings.

So I can send a patch to make the default PCIE_LINK_STATE_ALL, but I would still
need a follow-on in that series that does something like:

	if (host_bridge->synthetic_domain)
		link->aspm_default = PCIE_LINK_STATE_ALL;


That carve-out is still required, because without it synthetic domains like VMD
would inherit invalid or nonexistent BIOS defaults. The key difference is that
only vmd.c would set itself as synthetic_domain; ASPM core still decides what
policy applies.

[1] https://lore.kernel.org/linux-pci/4352365.LvFx2qVVIh@kreacher/

David

