Return-Path: <linux-pci+bounces-35143-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7C3B3C367
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 21:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C0FF7B7DAA
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 19:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DD622D4F1;
	Fri, 29 Aug 2025 19:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IlGoXjak"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B092566;
	Fri, 29 Aug 2025 19:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756497264; cv=none; b=qWaUcFQ9wtB1bEaEz5XMGS5LJH3B943GfQ0X8RCRKtk9M/sPufBhQIqo3dF+t1zHoGnujRki6HTzgdaf9WJnmedvDD34wFY27XR4sPztP28A0u+/ce0YAzIbHXVbg30/lwkCd5yrm+cOhNIyOiUnkFefQUzyfT0zNI0GoRDFEeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756497264; c=relaxed/simple;
	bh=T3UBBOZlqKJig0jZysKSF3BxzvTAu4H/69urY0rfYOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLmzb8kD7F6YVQ+tVnVcn0oqVvpHngHzuzx8L8tFzGEyMv0kJVespCofmpnzVDiTw0fTz7YamT8EEZ/HLtjJkAEReKUx7SeoDlrahAApy/iqUpWkzv41G9cBvvewJ0hHsi7B1FIyC1gPZchq25T9odj1KtjoSd/WMKXttpVF/Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IlGoXjak; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756497263; x=1788033263;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=T3UBBOZlqKJig0jZysKSF3BxzvTAu4H/69urY0rfYOo=;
  b=IlGoXjakLVBBaNbB4FBgxVmIwKottaCSOJoBmEGvTsdZ4PZcKHOdA6yx
   hSVZQD0ZSwVycqWNnOvKysrhwo+UwX+dDI8uJStC4I4ET0ZecVwG1Q3Zh
   6wrlKUHQwsisDF6ZoTdWUxuzDHNCL8VmRHy6shLMa2WAEVu3lWQ7Ffyps
   i44HdVV36BYQsEUr3NPwykJiqwNSfxGKqlY+ofeJhz2Wi9fVx7puzF/oi
   ja8Or/jvgu5Q0efpsB2IV6ayh9H17rilErTWftRzoPrbYmafTDP2/cZ/q
   3OX67JAEO+T/pvvBKqCkUr1h+rQfjFG46/CyUU80gNMwI1MKWmeMLWBdJ
   w==;
X-CSE-ConnectionGUID: f5sqf0NxSMSwZ9sLlt3jLA==
X-CSE-MsgGUID: 9EFVoDBNRKuSufiSWoxVTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="81383561"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="81383561"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 12:54:22 -0700
X-CSE-ConnectionGUID: G2Uf9fqxQVexfUAEWEPS0Q==
X-CSE-MsgGUID: RfFZ+qHsTjuTFAC2qX1Gxw==
X-ExtLoop1: 1
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO localhost) ([10.124.220.169])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 12:54:21 -0700
Date: Fri, 29 Aug 2025 12:54:20 -0700
From: David Box <david.e.box@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: rafael@kernel.org, bhelgaas@google.com, vicamo.yang@canonical.com, 
	kenny@panix.com, ilpo.jarvinen@linux.intel.com, nirmal.patel@linux.intel.com, 
	mani@kernel.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/2] PCI/ASPM: Add host-bridge API to override default
 ASPM/CLKPM link state
Message-ID: <ng67s7imjpj7i5ym7unvmewzhyk4ybgpkgw5aizicfs423vsxh@hvpfmk32ooe4>
References: <20250825203542.3502368-1-david.e.box@linux.intel.com>
 <20250828204345.GA958461@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250828204345.GA958461@bhelgaas>

On Thu, Aug 28, 2025 at 03:43:45PM -0500, Bjorn Helgaas wrote:
> On Mon, Aug 25, 2025 at 01:35:22PM -0700, David E. Box wrote:
> > Synthetic PCIe hierarchies, such as those created by Intel VMD, are not
> > enumerated by firmware and do not receive BIOS-provided ASPM or CLKPM
> > defaults. Devices in such domains may therefore run without the intended
> > power management.
> > 
> > Add a host-bridge mechanism that lets controller drivers supply their own
> > defaults. A new aspm_default_link_state field in struct pci_host_bridge is
> > set via pci_host_set_default_pcie_link_state(). During link initialization,
> > if this field is non-zero, ASPM and CLKPM defaults come from it instead of
> > BIOS.
> > 
> > This enables drivers like VMD to align link power management with platform
> > expectations and avoids embedding controller-specific quirks in ASPM core
> > logic.
> 
> I think this kind of sidesteps the real issue.  Drivers for host
> controllers or PCI devices should tell us about *broken* things, but
> not about things advertised by the hardware and available for use.

I agree with the principle. The intent isn’t for VMD (or any controller) to
override valid platform policy. It’s to handle synthetic domains where the
platform doesn’t provide any policy path (no effective _OSC/FADT for the child
hierarchy). In those cases, the controller is the only agent that knows the
topology and can supply sane defaults.

I’m happy to tighten the patch to explicitly cover synthetic domains only.
Instead of an API, we could have a boolean flag 'aspm_synthetic_domain'. When
set by the controller, we can do:

    if (host_bridge->aspm_synthetic_domain)
            link->aspm_default = PCIE_LINK_STATE_ALL;

This at least addresses your concern about policy decision, leaving it to the
core to determine how these domains are handled rather than an ABI that lets
domains set policy.

> 
> The only documented policy controls I'm aware of for ASPM are:
> 
>   - FADT "PCIe ASPM Controls" bit ("if set, OS must not enable ASPM
>     control on this platform")
> 
>   - _OSC negotiation for control of the PCIe Capability (OS is only
>     allowed to write PCI_EXP_LNKCTL if platform has granted control to
>     the OS)
> 
> I think what we *should* be doing is enabling ASPM when it's
> advertised, subject to those platform policy controls and user choices
> like CONFIG_PCIEASPM_PERFORMANCE/POWERSAVE/etc and sysfs attributes.
> 
> So basically I think link->aspm_default should be PCIE_LINK_STATE_ALL
> without drivers doing anything at all.  Maybe we have to carve out
> exceptions, e.g., "VMD hierarchies are exempt from _OSC," or "devices
> on x86 systems before 2026 can't enable more ASPM than BIOS did," or
> whatever.  Is there any baby step we can make in that direction?
> 
> This feels a little scary, so feel free to convince me it can't be
> done :)

I understand your direction of enabling all advertised states by default
(subject to FADT/_OSC and user settings). To explore that, I’ll send an RFC in
parallel with this patch that proposes a baby step, e.g.  add instrumentation so
we can see where BIOS left capabilities unused, and make it opt-in via a boot
param so we can evaluate impact safely.

So this series will handle the VMD gap directly, and the RFC can kick off the
wider discussion about defaults on ACPI-managed hosts. Does that sound like a
reasonable approach and split?

David

> 
> > Link: https://patchwork.ozlabs.org/project/linux-pci/patch/20250720190140.2639200-1-david.e.box%40linux.intel.com/
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > Tested-by: Manivannan Sadhasivam <mani@kernel.org>
> > Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> > ---
> > Changes in V3:
> >   -- Changed pci_host_get_default_pcie_link_state() argument name from
> >      parent to dev.
> >   -- Applied changelog tags
> > 
> > Changes in V2:
> > 
> >   -- Host field name changed to aspm_default_link_state.
> >   -- Added get/set functions for aspm_default_link_state. Only the
> >      setter is exported. Added a kernel-doc describing usage and
> >      particulars around meaning of 0.
> > 
> > Changes in V1 from RFC:
> > 
> >   -- Rename field to aspm_dflt_link_state since it stores
> >      PCIE_LINK_STATE_XXX flags, not a policy enum.
> >   -- Move the field to struct pci_host_bridge since it's being applied to
> >      the entire host bridge per Mani's suggestion.
> >   -- During testing noticed that clkpm remained disabled and this was
> >      also handled by the formerly used pci_enable_link_state(). Add a
> >      check in pcie_clkpm_cap_init() as well to enable clkpm during init.
> > 
> >  drivers/pci/pcie/aspm.c | 42 +++++++++++++++++++++++++++++++++++++++--
> >  include/linux/pci.h     |  9 +++++++++
> >  2 files changed, 49 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index 919a05b97647..851ca3d68e55 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -373,6 +373,39 @@ static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
> >  	pcie_set_clkpm_nocheck(link, enable);
> >  }
> >  
> > +/**
> > + * pci_host_set_default_pcie_link_state - set controller-provided default ASPM/CLKPM mask
> > + * @host: host bridge on which to apply the defaults
> > + * @state: PCIE_LINK_STATE_XXX flags
> > + *
> > + * Allows a PCIe controller driver to specify the default ASPM and/or
> > + * Clock Power Management (CLKPM) link state mask that will be used
> > + * for links under this host bridge during ASPM/CLKPM capability init.
> > + *
> > + * The value is consumed in pcie_aspm_cap_init() and pcie_clkpm_cap_init()
> > + * to override the firmware-discovered defaults.
> > + *
> > + * Interpretation of aspm_default_link_state:
> > + *   - Nonzero: bitmask of PCIE_LINK_STATE_* values to be used as defaults
> > + *   - Zero:    no override provided; ASPM/CLKPM defaults fall back to
> > + *              values discovered in hardware/firmware
> > + *
> > + * Note: zero is always treated as "unset", not as "force ASPM/CLKPM off".
> > + */
> > +void pci_host_set_default_pcie_link_state(struct pci_host_bridge *host,
> > +					  unsigned int state)
> > +{
> > +	host->aspm_default_link_state = state;
> > +}
> > +EXPORT_SYMBOL_GPL(pci_host_set_default_pcie_link_state);
> > +
> > +static u32 pci_host_get_default_pcie_link_state(struct pci_dev *dev)
> > +{
> > +	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
> > +
> > +	return host ? host->aspm_default_link_state : 0;
> > +}
> > +
> >  static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
> >  {
> >  	int capable = 1, enabled = 1;
> > @@ -394,7 +427,10 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
> >  			enabled = 0;
> >  	}
> >  	link->clkpm_enabled = enabled;
> > -	link->clkpm_default = enabled;
> > +	if (pci_host_get_default_pcie_link_state(link->pdev) & PCIE_LINK_STATE_CLKPM)
> > +		link->clkpm_default = 1;
> > +	else
> > +		link->clkpm_default = enabled;
> >  	link->clkpm_capable = capable;
> >  	link->clkpm_disable = blacklist ? 1 : 0;
> >  }
> > @@ -866,7 +902,9 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
> >  	}
> >  
> >  	/* Save default state */
> > -	link->aspm_default = link->aspm_enabled;
> > +	link->aspm_default = pci_host_get_default_pcie_link_state(parent);
> > +	if (!link->aspm_default)
> > +		link->aspm_default = link->aspm_enabled;
> >  
> >  	/* Setup initial capable state. Will be updated later */
> >  	link->aspm_capable = link->aspm_support;
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 59876de13860..8947cbaf9fa6 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -620,6 +620,10 @@ struct pci_host_bridge {
> >  	unsigned int	size_windows:1;		/* Enable root bus sizing */
> >  	unsigned int	msi_domain:1;		/* Bridge wants MSI domain */
> >  
> > +#ifdef CONFIG_PCIEASPM
> > +	unsigned int	aspm_default_link_state;	/* Controller-provided default */
> > +#endif
> > +
> >  	/* Resource alignment requirements */
> >  	resource_size_t (*align_resource)(struct pci_dev *dev,
> >  			const struct resource *res,
> > @@ -1849,6 +1853,8 @@ int pci_disable_link_state(struct pci_dev *pdev, int state);
> >  int pci_disable_link_state_locked(struct pci_dev *pdev, int state);
> >  int pci_enable_link_state(struct pci_dev *pdev, int state);
> >  int pci_enable_link_state_locked(struct pci_dev *pdev, int state);
> > +void pci_host_set_default_pcie_link_state(struct pci_host_bridge *host,
> > +					  unsigned int state);
> >  void pcie_no_aspm(void);
> >  bool pcie_aspm_support_enabled(void);
> >  bool pcie_aspm_enabled(struct pci_dev *pdev);
> > @@ -1861,6 +1867,9 @@ static inline int pci_enable_link_state(struct pci_dev *pdev, int state)
> >  { return 0; }
> >  static inline int pci_enable_link_state_locked(struct pci_dev *pdev, int state)
> >  { return 0; }
> > +static inline void
> > +pci_host_set_default_pcie_link_state(struct pci_host_bridge *host,
> > +				     unsigned int state) { }
> >  static inline void pcie_no_aspm(void) { }
> >  static inline bool pcie_aspm_support_enabled(void) { return false; }
> >  static inline bool pcie_aspm_enabled(struct pci_dev *pdev) { return false; }
> > 
> > base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
> > -- 
> > 2.43.0
> > 

