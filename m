Return-Path: <linux-pci+bounces-31939-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B94B02136
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 18:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED228A416F7
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 16:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A082EF291;
	Fri, 11 Jul 2025 16:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U8g3zL/I"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEF02ED157;
	Fri, 11 Jul 2025 16:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752249992; cv=none; b=TxJAt9OuMDIFuiWonq3lkrAyQfeRusy3Bw/KwkRY5vFIIZPy+ageQI0q3FmTdwCbja7feWTUZohceu2JnJoFzWwaF03XLj9RqQ5gKgELAdMkrN/QfxKktRGH8AoT0E24t/mYb4P6RCLLLzCEwFQ1Vm9POyKbWTxrvLXDqKMX70k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752249992; c=relaxed/simple;
	bh=gyygkwnlqgj+Ov8y4CqMkvfV3CoErDvnIRS3g++BM68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=siMIoWwgo+A2/Tjd2XjF3hFEsB6CeNnSyrEpIRBz9NIZboAWtNU0Xkj+59F4a7J7SV75xiSeuPG01SGn7gaf5CamN/deEoezMlbCGJ+PqRatbbfKtI0s56Qdunr0/9N9us1MDW6KsrOTPrv7AKdcwdHsADRXZrimBFZJjHlhPPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U8g3zL/I; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752249990; x=1783785990;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=gyygkwnlqgj+Ov8y4CqMkvfV3CoErDvnIRS3g++BM68=;
  b=U8g3zL/Iq20r2ZIb8xb/Y+N03biTV+tgamc5S278hc2+8D0M/Uju2zYh
   WJ4G6QivnxOrsciRQiffA/pm92x7OyAAmZmcaR2Z4IcaKvSOVrmJuv5mI
   tbgp9UNG+NNyUcI8U0Rn0jeZL2BGkGL5k5jGQmJZ3tGpkVryYt3R1scK+
   0JLT702zdoPD6OICAogg+gTwKyQoHkKMA2fl7rY/I0/hN0Pv4eWSHvXVB
   /WzL7DEk8247Nj5jGNHEVSkl1QuPJauCoW2TyQXPSbMJYIJ0oJVp6eOkC
   LP/LItj595Lg1i2FciCngaPki0xXHF/qx6emeQVDeVrX3LIJY+sYTUIDx
   A==;
X-CSE-ConnectionGUID: R5X8koboTZ6br5Fyfi9BPQ==
X-CSE-MsgGUID: 5r+htBMhRR2RhPCBHc0Klw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="65901893"
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="65901893"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 09:06:30 -0700
X-CSE-ConnectionGUID: BkDcskpFSfSCWmPPvvE3Jg==
X-CSE-MsgGUID: YuCwvXE6S1aMokbQ2GVYeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="156492160"
Received: from mgerlach-mobl1.amr.corp.intel.com (HELO localhost) ([10.124.222.101])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 09:06:29 -0700
Date: Fri, 11 Jul 2025 09:06:27 -0700
From: David Box <david.e.box@linux.intel.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	bhelgaas@google.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, vicamo.yang@canonical.com, 
	kenny@panix.com, nirmal.patel@linux.intel.com, linux-pm@vger.kernel.org, 
	linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI/ASPM: Allow ASPM enablement for devices behind Intel
 VMD
Message-ID: <ohil4of5wkoowdwouawjwlrmmmpeim2miscynn35v4ddg7zaoh@rebfuhcozirz>
References: <20250710011647.990046-1-david.e.box@linux.intel.com>
 <CAJZ5v0iWAaj5_hBC_1pZcA-cQ0Yz6hvQjbsv3Gmv6jN_utt4OQ@mail.gmail.com>
 <yqtsfh4pmbnogt67m6tk6pqpdcbz3kx3xx4lpinbgfvq4yi5wn@leoipmcnqsgs>
 <19452e8c-4e29-4703-afc9-3257a2d1183d@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19452e8c-4e29-4703-afc9-3257a2d1183d@linux.intel.com>

On Fri, Jul 11, 2025 at 05:49:03PM +0300, Ilpo Järvinen wrote:
> On Fri, 11 Jul 2025, David Box wrote:
> 
> > Hey Rafael,
> > 
> > On Thu, Jul 10, 2025 at 09:53:18PM +0200, Rafael J. Wysocki wrote:
> > > On Thu, Jul 10, 2025 at 3:16 AM David E. Box
> > > <david.e.box@linux.intel.com> wrote:
> > > >
> > > > Devices behind Intel's Volume Management Device (VMD) controller reside on
> > > > a synthetic PCI hierarchy that is intentionally hidden from ACPI and
> > > > firmware. As such, BIOS does not configure ASPM for these devices, and the
> > > > responsibility for link power management, including ASPM and LTR, falls
> > > > entirely to the VMD driver.
> > > >
> > > > However, the current PCIe ASPM code prevents ASPM configuration when the
> > > > ACPI_FADT_NO_ASPM flag is set, disallowing OS management. This leaves ASPM
> > > > permanently disabled for these devices, contrary to the platform's design
> > > > intent.
> > > >
> > > > Introduce a callback mechanism that allows the VMD driver to enable ASPM
> > > > for its domain, bypassing the global ACPI_FADT_NO_ASPM restriction that is
> > > > not applicable in this context. This ensures that devices behind VMD can
> > > > benefit from ASPM savings as originally intended.
> > > >
> > > > Link: https://lore.kernel.org/linux-pm/0b166ece-eeec-ba5d-2212-50d995611cef@panix.com
> > > > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > > 
> > > First of all, thanks for doing this work, much appreciated!
> > > 
> > > > ---
> > > >  drivers/pci/controller/vmd.c | 28 ++++++++++++++++++++++++++--
> > > >  drivers/pci/pci.h            |  8 ++++++++
> > > >  drivers/pci/pcie/aspm.c      | 36 +++++++++++++++++++++++++++++++++++-
> > > >  3 files changed, 69 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> > > > index 8df064b62a2f..e685586dc18b 100644
> > > > --- a/drivers/pci/controller/vmd.c
> > > > +++ b/drivers/pci/controller/vmd.c
> > > > @@ -21,6 +21,8 @@
> > > >
> > > >  #include <asm/irqdomain.h>
> > > >
> > > > +#include "../pci.h"
> > > > +
> > > >  #define VMD_CFGBAR     0
> > > >  #define VMD_MEMBAR1    2
> > > >  #define VMD_MEMBAR2    4
> > > > @@ -730,7 +732,7 @@ static void vmd_copy_host_bridge_flags(struct pci_host_bridge *root_bridge,
> > > >  }
> > > >
> > > >  /*
> > > > - * Enable ASPM and LTR settings on devices that aren't configured by BIOS.
> > > > + * Enable LTR settings on devices that aren't configured by BIOS.
> > > >   */
> > > >  static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
> > > >  {
> > > > @@ -770,10 +772,27 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
> > > >          * PCIe r6.0, sec 5.5.4.
> > > >          */
> > > >         pci_set_power_state_locked(pdev, PCI_D0);
> > > > -       pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
> > > 
> > > Do I think correctly that this doesn't work because of the
> > > aspm_disabled check in __pci_enable_link_state()?
> > 
> > Yes.
> > 
> > > 
> > > >         return 0;
> > > >  }
> > > >
> > > > +static long vmd_get_link_state(struct pci_dev *pdev, void *data)
> > > > +{
> > > > +       struct pci_bus *vmd_bus = data;
> > > > +       struct pci_bus *bus = pdev->bus;
> > > > +
> > > > +       while (bus) {
> > > > +               if (bus == vmd_bus)
> > > > +                       return PCIE_LINK_STATE_ALL;
> > > > +
> > > > +               if (!bus->self)
> > > > +                       break;
> > > > +
> > > > +               bus = bus->self->bus;
> > > > +       }
> > > 
> > > If I'm not mistaken, it would be sufficient to do a check like
> > > 
> > >     if (pci_dev->bus->ops == &vmd_ops)
> > >             return PCIE_LINK_STATE_ALL;
> > > 
> > > instead of the above, or if not then why not?
> > 
> > As a replacement in the loop, that does look sufficient. I'm not sure if
> > you're also suggesting replacing the loop itself.
> > 
> > > 
> > > > +
> > > > +       return -ENODEV;
> > > > +}
> > > > +
> > > >  static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
> > > >  {
> > > >         struct pci_sysdata *sd = &vmd->sysdata;
> > > > @@ -785,6 +804,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
> > > >         resource_size_t membar2_offset = 0x2000;
> > > >         struct pci_bus *child;
> > > >         struct pci_dev *dev;
> > > > +       struct pcie_aspm_vmd_link_state vmd_link_state;
> > > >         int ret;
> > > >
> > > >         /*
> > > > @@ -911,6 +931,10 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
> > > >                 return -ENODEV;
> > > >         }
> > > >
> > > > +       vmd_link_state.cb = vmd_get_link_state;
> > > > +       vmd_link_state.data = vmd->bus;
> > > > +       pci_register_vmd_link_state_cb(&vmd_link_state);
> > > > +
> > > >         vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
> > > >                                    to_pci_host_bridge(vmd->bus->bridge));
> > > >
> > > > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > > > index 12215ee72afb..dcf7d39c660f 100644
> > > > --- a/drivers/pci/pci.h
> > > > +++ b/drivers/pci/pci.h
> > > > @@ -821,6 +821,12 @@ void pci_configure_aspm_l1ss(struct pci_dev *dev);
> > > >  void pci_save_aspm_l1ss_state(struct pci_dev *dev);
> > > >  void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
> > > >
> > > > +
> > > > +struct pcie_aspm_vmd_link_state {
> > > > +       long (*cb)(struct pci_dev *pdev, void *data);
> > > > +       void *data;
> > > > +};
> > > > +
> > > >  #ifdef CONFIG_PCIEASPM
> > > >  void pcie_aspm_init_link_state(struct pci_dev *pdev);
> > > >  void pcie_aspm_exit_link_state(struct pci_dev *pdev);
> > > > @@ -828,6 +834,7 @@ void pcie_aspm_pm_state_change(struct pci_dev *pdev, bool locked);
> > > >  void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
> > > >  void pci_configure_ltr(struct pci_dev *pdev);
> > > >  void pci_bridge_reconfigure_ltr(struct pci_dev *pdev);
> > > > +void pci_register_vmd_link_state_cb(struct pcie_aspm_vmd_link_state *state);
> > > >  #else
> > > >  static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
> > > >  static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
> > > > @@ -835,6 +842,7 @@ static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev, bool locked)
> > > >  static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
> > > >  static inline void pci_configure_ltr(struct pci_dev *pdev) { }
> > > >  static inline void pci_bridge_reconfigure_ltr(struct pci_dev *pdev) { }
> > > > +void pci_register_vmd_link_state_cb(struct pcie_aspm_vmd_link_state *state) { }
> > > >  #endif
> > > >
> > > >  #ifdef CONFIG_PCIE_ECRC
> > > > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > > > index 29fcb0689a91..c609d3c309be 100644
> > > > --- a/drivers/pci/pcie/aspm.c
> > > > +++ b/drivers/pci/pcie/aspm.c
> > > > @@ -320,6 +320,27 @@ static int policy_to_clkpm_state(struct pcie_link_state *link)
> > > >         return 0;
> > > >  }
> > > >
> > > > +static struct pcie_aspm_vmd_link_state vmd_state;
> > > > +
> > > > +void pci_register_vmd_link_state_cb(struct pcie_aspm_vmd_link_state *state)
> > > > +{
> > > > +       mutex_lock(&aspm_lock);
> > > > +       vmd_state.cb = state->cb;
> > > > +       vmd_state.data = state->data;
> > > > +       mutex_unlock(&aspm_lock);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(pci_register_vmd_link_state_cb);
> > > > +
> > > > +static long pci_get_vmd_link_state(struct pci_dev *pdev)
> > > > +{
> > > > +       int state = -ENODEV;
> > > > +
> > > > +       if (vmd_state.cb)
> > > > +               state = vmd_state.cb(pdev, vmd_state.data);
> > > > +
> > > > +       return state;
> > > > +}
> > > > +
> > > >  static void pci_update_aspm_saved_state(struct pci_dev *dev)
> > > >  {
> > > >         struct pci_cap_saved_state *save_state;
> > > > @@ -794,6 +815,7 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
> > > >         u32 parent_lnkcap, child_lnkcap;
> > > >         u16 parent_lnkctl, child_lnkctl;
> > > >         struct pci_bus *linkbus = parent->subordinate;
> > > > +       int vmd_aspm_default;
> > > >
> > > >         if (blacklist) {
> > > >                 /* Set enabled/disable so that we will disable ASPM later */
> > > > @@ -865,8 +887,20 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
> > > >                 pcie_capability_write_word(child, PCI_EXP_LNKCTL, child_lnkctl);
> > > >         }
> > > >
> > > > +       /*
> > > > +        * Devices behind Intel VMD operate on a synthetic PCI bus that BIOS
> > > > +        * and ACPI do not enumerate or configure. ASPM for these devices must
> > > > +        * be managed by the VMD driver itself, independent of global ACPI ASPM
> > > > +        * constraints. This callback mechanism allows selective ASPM
> > > > +        * enablement for such domains.
> > > > +        */
> > > > +       vmd_aspm_default = pci_get_vmd_link_state(parent);
> > > > +
> > > >         /* Save default state */
> > > > -       link->aspm_default = link->aspm_enabled;
> > > > +       if (vmd_aspm_default < 0)
> > > > +               link->aspm_default = link->aspm_enabled;
> > > > +       else
> > > > +               link->aspm_default = vmd_aspm_default;
> > > 
> > > Well, this is not nice.
> > > 
> > > First off, it adds VMD-specific stuff to otherwise generic ASPM code.
> > > Second, it doesn't actually do anything about the aspm_disabled checks
> > > all over the place, so they will still trigger even though ASPM will
> > > be effectively enabled for devices on the VMD bus.
> > 
> > I agree that it's not nice to be mixing VMD specific code here. It's a
> > working bad solution to come up with a working good solution :)
> > 
> > The reason this patch works is that the aspm_disabled checks only gate
> > OS-controlled ASPM configuration. They don't affect the BIOS default
> > values, which are what we're setting in link->aspm_default. The ASPM
> > code uses link->aspm_default as the fallback when ASPM is globally
> > disabled, which is exactly what we want for devices behind VMD where the
> > driver, not BIOS, effectively is the platform provider of the defaults.
> 
> Oh, this was a big news to me.
> 
> So what you're saying is that if aspm_disabled is set, ->aspm_disable 
> cannot be set and thus pcie_config_aspm_link() that is not gated by 
> aspm_disabled can alter ASPM state despite OS not having ASPM control???

Yes, that’s correct. Bjorn can confirm, but I believe this is by design. The
aspm_disabled flag is really a bit of a misnomer. It probably should have been
called something like os_aspm_disabled. The intent as I understand it is that,
when disallowed, the OS cannot select or manage the active ASPM policy,
but it can still configure the link to match the BIOS provided policy.

In other words, ASPM isn’t fully disabled. It’s just not under OS control. The
BIOS values, reflected in link->aspm_default, remain valid and
pcie_config_aspm_link() can apply them regardless of the aspm_disabled setting.

David

> 
> ...That's really odd logic which the ASPM driver seems to be full of.
> 
> -- 
>  i.
> 
> > I put it here using a callback value because this where the BIOS
> > defaults are saved for each device.
> > 
> > > 
> > > >
> > > >         /* Setup initial capable state. Will be updated later */
> > > >         link->aspm_capable = link->aspm_support;
> > > >
> > > > base-commit: d0b3b7b22dfa1f4b515fd3a295b3fd958f9e81af
> > > > --
> > > 
> > > It appears to me that the underlying problem is that aspm_disabled is
> > > global and it is set during PCI root bus creation in
> > > acpi_pci_root_add().  Thus it affects all of the PCI buses even though
> > > the BIOS says that it wants to control ASPM for this particular PCIe
> > > hierarchy. If there were another PCI root enumerated by ACPI where
> > > the OS would be allowed to control ASPM, it would not work just like
> > > the VMD case.
> > 
> > It would work in the non-VMD case because it has the BIOS default to
> > use. VMD does not.
> > 
> > > 
> > > To me, this suggests an approach based on moving the "ASPM disabled
> > > because the BIOS wants to control it" setting to pci_bus_flags_t and
> > > setting it on a per-hierarchy basis.  Since the VMD bus is a separate
> > > PCIe hierarchy from the kernel perspective, it will not have this flag
> > > set and the OS should be able to configure ASPM for devices on that
> > > bus.
> > > 
> > > Do I think correctly or am I overlooking something here?
> > 
> > It’s definitely along those lines. The issue is really caused by two
> > things:
> > 
> >     1. aspm_disabled global prevents OS control of ASPM
> >     2. For VMD, there’s no BIOS provided link->aspm_default
> > 
> > The solution I proposed addresses the problem by having a mechanism for
> > the VMD driver to supply its own defaults in place of the missing BIOS
> > configuration.
> > 
> > Using pci_bus_flags_t could work as well, but would rather just say that
> > aspm_disabled doesn't apply to the bus hierarchy, allowing the current
> > pci_enable_link_state_locked() solution to work all the time. Either
> > way, I'm definitely looking for a cleaner solution. The above hopefully
> > clarifies the situation.
> > 
> > David
> > 


