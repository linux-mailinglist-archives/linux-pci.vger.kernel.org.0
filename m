Return-Path: <linux-pci+bounces-35414-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F90B42D2B
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 01:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F39F918968E8
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 23:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFF02EBDE9;
	Wed,  3 Sep 2025 23:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MF9Whsl2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABD52EA17B;
	Wed,  3 Sep 2025 23:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756940693; cv=none; b=rLNi4RbbSI3SGrBf4XUH9sqpoUWa9MILXVVMrGwCEqAsvvR1IKQ1W302ogsc1BFm1JkYijMGfOpoILd48zcw28eO1H+mGOY6q3uGzOB7g0mCEgNBpyr6kgELtNi0nqQ7N+n9jLdoNma8ZQqJBdwLAknMsJ0fJ9gJ7KBaKgojGGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756940693; c=relaxed/simple;
	bh=pixD2eN8dunhZH5Jtt5km52Vej0Uu1/pEJTGRmEeGyA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MSHzldpKl9PSZBSIfvHPrWEFrLODIqHOGj+yna31/w5z+SmHB59XEF+mAcSL07cYuG6Kh4ZTpjoFvACRK3DQIW5eSXiMxNwYikaD5kJ6j4Bosw/snRIIu/Mm/7OlSsgnn6Rc8Y2kIRO/gZviXhtzSvrXWp0E1QDFu2j+bEI/hKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MF9Whsl2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B208C4CEE7;
	Wed,  3 Sep 2025 23:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756940692;
	bh=pixD2eN8dunhZH5Jtt5km52Vej0Uu1/pEJTGRmEeGyA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=MF9Whsl2udzrNQKRG4tXMfwuJUUrP90EgPJyAYGwoRLafhBEE8oHu5v+Y5KXXsWEp
	 ZlwgNwsEx1KSla3bdRSyJ72z3bduKn05bX/mBGXdTsvCy3FDbIsTU8lXY2vQtRW+ty
	 EGIwAxA01m3tyIRXKG5N3m9HruGKZ9l1aTEIgN4zIVQ8JQ8UQZmBp+UyicyzNFX57k
	 K/Uq2JzTsFVbd8Rd/GjcvkBSYiSS5fppu0mgChLPma1JI69yWIaTYJlWDUqyyU/oi3
	 xEi1E5QF2fJ0Ue3tD47xuVS4F2Ozle3J/Z/HplqBRfzIQQC3xb9OGh60TyID6VKDEG
	 JFye6hOXCLEeg==
Date: Wed, 3 Sep 2025 18:04:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Box <david.e.box@linux.intel.com>
Cc: rafael@kernel.org, bhelgaas@google.com, vicamo.yang@canonical.com,
	kenny@panix.com, ilpo.jarvinen@linux.intel.com,
	nirmal.patel@linux.intel.com, mani@kernel.org,
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/2] PCI/ASPM: Add host-bridge API to override default
 ASPM/CLKPM link state
Message-ID: <20250903230450.GA1236832@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ng67s7imjpj7i5ym7unvmewzhyk4ybgpkgw5aizicfs423vsxh@hvpfmk32ooe4>

On Fri, Aug 29, 2025 at 12:54:20PM -0700, David Box wrote:
> On Thu, Aug 28, 2025 at 03:43:45PM -0500, Bjorn Helgaas wrote:
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
> 
> I agree with the principle. The intent isn’t for VMD (or any controller) to
> override valid platform policy. It’s to handle synthetic domains where the
> platform doesn’t provide any policy path (no effective _OSC/FADT for the child
> hierarchy). In those cases, the controller is the only agent that knows the
> topology and can supply sane defaults.
> 
> I’m happy to tighten the patch to explicitly cover synthetic domains only.
> Instead of an API, we could have a boolean flag 'aspm_synthetic_domain'. When
> set by the controller, we can do:
> 
>     if (host_bridge->aspm_synthetic_domain)
>             link->aspm_default = PCIE_LINK_STATE_ALL;
> 
> This at least addresses your concern about policy decision, leaving it to the
> core to determine how these domains are handled rather than an ABI that lets
> domains set policy.
> 
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
> > 
> > This feels a little scary, so feel free to convince me it can't be
> > done :)
> 
> I understand your direction of enabling all advertised states by
> default (subject to FADT/_OSC and user settings). To explore that,
> I’ll send an RFC in parallel with this patch that proposes a baby
> step, e.g.  add instrumentation so we can see where BIOS left
> capabilities unused, and make it opt-in via a boot param so we can
> evaluate impact safely.

The instrumentation, absolutely.  We need something about what was
already enabled and when we change things.

> So this series will handle the VMD gap directly, and the RFC can
> kick off the wider discussion about defaults on ACPI-managed hosts.
> Does that sound like a reasonable approach and split?

I don't really want a parallel approach because I don't think it would
ever converge again.  BUT I think you're still OK for VMD, because I
think the default should be PCIE_LINK_STATE_ALL, and when we carve out
the exceptions that would not be in vmd.c, and it's easy to say that
there's no exception for VMD.

