Return-Path: <linux-pci+bounces-32846-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3BEB0FC20
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 23:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88E073BE934
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 21:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FC026CE35;
	Wed, 23 Jul 2025 21:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JfJg+OhV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453F514A4F9;
	Wed, 23 Jul 2025 21:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753306029; cv=none; b=gzSb/Oa/CYX+vH+Vq9jIdexLkre4FpNKRKgJjhNFR2vLCrIRwRAoJ5mMv6JyJ2FHcQKojWN4AOVa3PMeCxFXbAHe0btruQbqj2vC8fR2i9HlqjeWAHGp/2JfjIms81GLFXeV/9HzezDHPKavJx1lb6aPCs5yY33AUUdK+VQd/XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753306029; c=relaxed/simple;
	bh=cA/SGAqz/8JFQkMlHpWRDuBeufFCogtYY0VC0L0pYGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iuck1B7/FrZ1tjYcYS/sgkA7mGIfcwIBhXDfjXnIjMWFJw+zLs3vPQku/GWNYUJOf70KlCR4b9to5ZwRfBgx52Bm0UgwKs1WUNCZSYL2+iz7sQWtIWdmt7/MuyanzC/Y6XuwLHuCjlvzi1QuOJKFLqqC98iy1O4MkE6gVfvhu1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JfJg+OhV; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753306027; x=1784842027;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=cA/SGAqz/8JFQkMlHpWRDuBeufFCogtYY0VC0L0pYGE=;
  b=JfJg+OhVF/iDyp7Wx8wpLzGB4N+cTOmoK1LT19jIxN22jURSL0tXlFAR
   v1pBq3glbE2UrDYm0waeuSgnSbntY9pvWT83j2kryK2An7+d8OM07F3D1
   +w37cXN6bMYwIL3KQVyJJct/LfTkbfFQeUixUPFpm8/Lq9ujTFWp5GCzR
   GFJl2e5ero72joUzkA0A4WoVP8bD/r7IMZ2ywVeQZQkH5tszLh23V68bQ
   FbEo+Xnbz9eUKuLCKFJrpZgVGTmAVBZctLIGT0o+UuKMfBumabXUITsun
   evmiBh2ufJKa64fLd+pdGzRKBEer2xG8b+bx2HQGGMhGxIEg3JPy1FCqj
   g==;
X-CSE-ConnectionGUID: m2ZjVLzwQEC5rW5vz48znQ==
X-CSE-MsgGUID: CD8kVt6xRWCIj/7atkqaKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="66168974"
X-IronPort-AV: E=Sophos;i="6.16,335,1744095600"; 
   d="scan'208";a="66168974"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 14:27:06 -0700
X-CSE-ConnectionGUID: 6rmpO4iYS32zmaJxNAXVrg==
X-CSE-MsgGUID: K3el9AvMSz+Mut/5Suv2mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,335,1744095600"; 
   d="scan'208";a="159042739"
Received: from inaky-mobl1.amr.corp.intel.com (HELO localhost) ([10.124.223.13])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 14:27:06 -0700
Date: Wed, 23 Jul 2025 14:27:04 -0700
From: David Box <david.e.box@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, bhelgaas@google.com, 
	vicamo.yang@canonical.com, kenny@panix.com, ilpo.jarvinen@linux.intel.com, 
	nirmal.patel@linux.intel.com, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/ASPM: Allow controller drivers to override default
 ASPM and CLKPM link state
Message-ID: <arotuyooaoo6ustmp5gnoj64pkpyvcc3plekh4yt46siuemlik@sv6tjxnggznx>
References: <20250720190140.2639200-1-david.e.box@linux.intel.com>
 <c6757u3xdyxxuodcjsbpdje7m4qiq26tug5lfxvpbs5wm7r56l@ksy4yge7kg35>
 <CAJZ5v0jZrPyW9+Ccoo955Y4oje2SiAQA9aCChAoPgM28SJqf5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jZrPyW9+Ccoo955Y4oje2SiAQA9aCChAoPgM28SJqf5g@mail.gmail.com>

On Wed, Jul 23, 2025 at 01:54:41PM +0200, Rafael J. Wysocki wrote:
> On Mon, Jul 21, 2025 at 10:24 AM Manivannan Sadhasivam <mani@kernel.org> wrote:
> >
> > On Sun, Jul 20, 2025 at 12:01:37PM GMT, David E. Box wrote:
> > > Synthetic PCIe hierarchies, such as those created by Intel VMD, are not
> > > visible to firmware and do not receive BIOS-provided default ASPM and CLKPM
> > > configuration. As a result, devices behind such domains operate without
> > > proper power management, regardless of platform intent.
> > >
> > > To address this, allow controller drivers to supply an override for the
> > > default link state by setting aspm_dflt_link_state for their associated
> > > pci_host_bridge. During link initialization, if this field is non-zero,
> > > ASPM and CLKPM defaults are derived from its value instead of being taken
> > > from BIOS.
> > >
> > > This mechanism enables drivers like VMD to achieve platform-aligned power
> > > savings by statically defining the expected link configuration at
> > > enumeration time, without relying on runtime calls such as
> > > pci_enable_link_state(), which are ineffective when ASPM is disabled
> > > globally.
> > >
> > > This approach avoids per-controller hacks in ASPM core logic and provides a
> > > general mechanism for domains that require explicit control over link power
> > > state defaults.
> > >
> > > Link: https://lore.kernel.org/linux-pm/0b166ece-eeec-ba5d-2212-50d995611cef@panix.com
> > > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > > ---
> > >
> > > Changes from RFC:
> > >
> > >   -- Rename field to aspm_dflt_link_state since it stores
> > >      PCIE_LINK_STATE_XXX flags, not a policy enum.
> > >   -- Move the field to struct pci_host_bridge since it's being applied to
> > >      the entire host bridge per Mani's suggestion.
> > >   -- During testing noticed that clkpm remained disabled and this was
> > >      also handled by the formerly used pci_enable_link_state(). Add a
> > >      check in pcie_clkpm_cap_init() as well to enable clkpm during init.
> > >
> > >  drivers/pci/controller/vmd.c | 12 +++++++++---
> > >  drivers/pci/pcie/aspm.c      | 13 +++++++++++--
> > >  include/linux/pci.h          |  4 ++++
> > >  3 files changed, 24 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> > > index 8df064b62a2f..6f0de95c87fd 100644
> > > --- a/drivers/pci/controller/vmd.c
> > > +++ b/drivers/pci/controller/vmd.c
> > > @@ -730,7 +730,7 @@ static void vmd_copy_host_bridge_flags(struct pci_host_bridge *root_bridge,
> > >  }
> > >
> > >  /*
> > > - * Enable ASPM and LTR settings on devices that aren't configured by BIOS.
> > > + * Enable LTR settings on devices that aren't configured by BIOS.
> > >   */
> > >  static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
> > >  {
> > > @@ -770,7 +770,6 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
> > >        * PCIe r6.0, sec 5.5.4.
> > >        */
> > >       pci_set_power_state_locked(pdev, PCI_D0);
> >
> > This call becomes useless now.

Missed this. I'll remove it.

> >
> > > -     pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
> > >       return 0;
> > >  }
> > >
> > > @@ -785,6 +784,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
> > >       resource_size_t membar2_offset = 0x2000;
> > >       struct pci_bus *child;
> > >       struct pci_dev *dev;
> > > +     struct pci_host_bridge *vmd_host_bridge;
> > >       int ret;
> > >
> > >       /*
> > > @@ -911,8 +911,14 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
> > >               return -ENODEV;
> > >       }
> > >
> > > +     vmd_host_bridge = to_pci_host_bridge(vmd->bus->bridge);
> > > +
> > > +#ifdef CONFIG_PCIEASPM
> > > +     vmd_host_bridge->aspm_dflt_link_state = PCIE_LINK_STATE_ALL;
> > > +#endif
> >
> > I think it is better to provide an API that accepts the link state. We can
> > provide a stub if CONFIG_PCIEASPM is not selected. This will avoid the ifdef
> > clutter in the callers. Like:
> >
> > void pci_set_default_link_state(struct pci_host_bridge *host_bridge,
> >                                 unsigned int state)
> > {
> > #ifdef CONFIG_PCIEASPM
> >          host_bridge->aspm_default_link_state = state;
> > #endif
> > }
> >
> > Or you can stub the entire function to align with other ASPM APIs.
> >
> > One more thought: Since this API is only going to be called by the host bridge
> > drivers, we can place it in drivers/pci/controller/pci-host-common.c and name it
> > as pci_host_common_set_default_link_state().

This would require VMD to select PCI_HOST_COMMON just to set one field in a
common struct. Seems heavy-handed. Thoughts? Also, with this and dropping the D0
call, I'll split the VMD cleanup into a separate patch again.

> 
> I agree with the above except for the new function name.  I'd call it
> pci_host_set_default_pcie_link_state()

Sounds good.

> 
> > > +
> > >       vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
> > > -                                to_pci_host_bridge(vmd->bus->bridge));
> > > +                                vmd_host_bridge);
> > >
> > >       vmd_attach_resources(vmd);
> > >       if (vmd->irq_domain)
> > > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > > index 29fcb0689a91..6f5b34b172f9 100644
> > > --- a/drivers/pci/pcie/aspm.c
> > > +++ b/drivers/pci/pcie/aspm.c
> > > @@ -380,6 +380,7 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
> > >       u16 reg16;
> > >       struct pci_dev *child;
> > >       struct pci_bus *linkbus = link->pdev->subordinate;
> > > +     struct pci_host_bridge *host = pci_find_host_bridge(link->pdev->bus);
> > >
> > >       /* All functions should have the same cap and state, take the worst */
> > >       list_for_each_entry(child, &linkbus->devices, bus_list) {
> > > @@ -394,7 +395,10 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
> > >                       enabled = 0;
> > >       }
> > >       link->clkpm_enabled = enabled;
> > > -     link->clkpm_default = enabled;
> > > +     if (host && host->aspm_dflt_link_state & PCIE_LINK_STATE_CLKPM)
> > > +             link->clkpm_default = 1;
> > > +     else
> > > +             link->clkpm_default = enabled;
> > >       link->clkpm_capable = capable;
> > >       link->clkpm_disable = blacklist ? 1 : 0;
> > >  }
> > > @@ -794,6 +798,7 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
> > >       u32 parent_lnkcap, child_lnkcap;
> > >       u16 parent_lnkctl, child_lnkctl;
> > >       struct pci_bus *linkbus = parent->subordinate;
> > > +     struct pci_host_bridge *host;
> > >
> > >       if (blacklist) {
> > >               /* Set enabled/disable so that we will disable ASPM later */
> > > @@ -866,7 +871,11 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
> > >       }
> > >
> > >       /* Save default state */
> > > -     link->aspm_default = link->aspm_enabled;
> > > +     host = pci_find_host_bridge(parent->bus);
> >
> > You can initialize 'host' while defining it.
> >
> > Also, please add a comment on why we are doing this. The inline comment for the
> > member is not elaborate enough:
> >
> >         /*
> >          * Use the default link state provided by the Host Bridge driver if
> >          * available. If the BIOS is not able to provide default ASPM link
> >          * state for some reason, the Host Bridge driver could do.
> >          */
> >
> > > +     if (host && host->aspm_dflt_link_state)
> > > +             link->aspm_default = host->aspm_dflt_link_state;
> > > +     else
> > > +             link->aspm_default = link->aspm_enabled;
> 
> Or
> 
> link->aspm_default = pci_host_get_default_pcie_link_state(parent);
> if (link->aspm_default)
>         link->aspm_default = link->aspm_enabled;
> 
> and make pci_host_get_default_pcie_link_state() return 0 on failures.
> 
> Then you can put all of the relevant information into the
> pci_host_get_default_pcie_link_state() kerneldoc comment.

Sure. I'll add get/set APIs (plus the !) and put the comment there.

> 
> > >
> > >       /* Setup initial capable state. Will be updated later */
> > >       link->aspm_capable = link->aspm_support;
> > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > index 05e68f35f392..930028bf52b4 100644
> > > --- a/include/linux/pci.h
> > > +++ b/include/linux/pci.h
> > > @@ -614,6 +614,10 @@ struct pci_host_bridge {
> > >       unsigned int    size_windows:1;         /* Enable root bus sizing */
> > >       unsigned int    msi_domain:1;           /* Bridge wants MSI domain */
> > >
> > > +#ifdef CONFIG_PCIEASPM
> > > +     unsigned int    aspm_dflt_link_state;   /* Controller provided link state */
> >
> >         /* Controller provided default link state */
> >
> >
> > Nit: Please expand 'default' as 'dflt' is not a commonly used acronym for
> > 'default'.
> 
> I agree.

Will do.

