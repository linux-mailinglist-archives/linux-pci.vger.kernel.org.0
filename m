Return-Path: <linux-pci+bounces-31933-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE70B01F77
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 16:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14BF81CA7F21
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 14:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388442EA147;
	Fri, 11 Jul 2025 14:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JWbtNUjV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6072E975D;
	Fri, 11 Jul 2025 14:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752245352; cv=none; b=tyPUN1AlXRur/KQTYV8f2kuDc/jx8nPFsBTRYw63qU7kT3DgGk3FIIk4YDUzMZ6Srtq0MLwG71xUIrDtgeFpkLhlASC2kSHsyuqW7CxeHqMtyvDCjBNDoY7jsMqDR6JkHY+yLQnDUsTXq9OewQXPkDcQRDbqIoGEkWgzI1trTbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752245352; c=relaxed/simple;
	bh=idf/M1bAjL2R1ka5G2ArHGmd/sBN0/C/Nk7iPrx63rU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AcA69DTizMWSoa28sFxY9fv/BtGv+CysMIY0RSdRdGdyhtPIhSHxOdnYCzNrSAFd3my0cyjQlVnNYPtnobhYDBSF7Fy5JM0mvaPKMcgdpn1V2wwOz4goah9quj4hYO98AzdNRbJPFXRNl2tv6wGEPJiFI7IP0Jvj3zuEx1aVo3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JWbtNUjV; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752245350; x=1783781350;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=idf/M1bAjL2R1ka5G2ArHGmd/sBN0/C/Nk7iPrx63rU=;
  b=JWbtNUjVr2XeJe5N+0m5GHd5osEQTu0nAXReUIHwsDJuQtugZuebDdRU
   cyMwgsFBEss/XX8xYLDdAXEcddJfTAXE8k5UUk5WkAXEO+yz1jtfcDgcG
   EebLoTXI2AalMRQEx9eRVYW0o8MafRxk8ntE48BM2kfXcv0ap2O+v6ZfY
   pXp3eveijb0fKnphbB0KpihZ9ME5FOW71haPDc19Bp7+cD8I7dbq7RzL2
   fQhYpNeyf2RiquxheHTdHtOv9FwFJejCp7z43dXtshvKqtxi2/9Xj3b//
   gSvnQXjwrLS0Ulv2lwJAW/4nXvjjwvjZYvq18olBO1NvaxCMxWtqAROvJ
   A==;
X-CSE-ConnectionGUID: 8AISo7tTSWu8/fSHz/8Gtg==
X-CSE-MsgGUID: rE6xkEC4QlCpg5fbPN5tCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="65610150"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="65610150"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 07:49:09 -0700
X-CSE-ConnectionGUID: 6BpdHmF0RNS7QeSUKOWg8A==
X-CSE-MsgGUID: 2BR9mh1TSNW0G2ES8biirw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="156013659"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.249])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 07:49:06 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 11 Jul 2025 17:49:03 +0300 (EEST)
To: David Box <david.e.box@linux.intel.com>
cc: "Rafael J. Wysocki" <rafael@kernel.org>, bhelgaas@google.com, 
    andrea.righi@canonical.com, vicamo.yang@canonical.com, kenny@panix.com, 
    nirmal.patel@linux.intel.com, linux-pm@vger.kernel.org, 
    linux-pci@vger.kernel.org, ilpo.jarvinen@linux.intel.com, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI/ASPM: Allow ASPM enablement for devices behind Intel
 VMD
In-Reply-To: <yqtsfh4pmbnogt67m6tk6pqpdcbz3kx3xx4lpinbgfvq4yi5wn@leoipmcnqsgs>
Message-ID: <19452e8c-4e29-4703-afc9-3257a2d1183d@linux.intel.com>
References: <20250710011647.990046-1-david.e.box@linux.intel.com> <CAJZ5v0iWAaj5_hBC_1pZcA-cQ0Yz6hvQjbsv3Gmv6jN_utt4OQ@mail.gmail.com> <yqtsfh4pmbnogt67m6tk6pqpdcbz3kx3xx4lpinbgfvq4yi5wn@leoipmcnqsgs>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-827757273-1752245343=:933"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-827757273-1752245343=:933
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 11 Jul 2025, David Box wrote:

> Hey Rafael,
>=20
> On Thu, Jul 10, 2025 at 09:53:18PM +0200, Rafael J. Wysocki wrote:
> > On Thu, Jul 10, 2025 at 3:16=E2=80=AFAM David E. Box
> > <david.e.box@linux.intel.com> wrote:
> > >
> > > Devices behind Intel's Volume Management Device (VMD) controller resi=
de on
> > > a synthetic PCI hierarchy that is intentionally hidden from ACPI and
> > > firmware. As such, BIOS does not configure ASPM for these devices, an=
d the
> > > responsibility for link power management, including ASPM and LTR, fal=
ls
> > > entirely to the VMD driver.
> > >
> > > However, the current PCIe ASPM code prevents ASPM configuration when =
the
> > > ACPI_FADT_NO_ASPM flag is set, disallowing OS management. This leaves=
 ASPM
> > > permanently disabled for these devices, contrary to the platform's de=
sign
> > > intent.
> > >
> > > Introduce a callback mechanism that allows the VMD driver to enable A=
SPM
> > > for its domain, bypassing the global ACPI_FADT_NO_ASPM restriction th=
at is
> > > not applicable in this context. This ensures that devices behind VMD =
can
> > > benefit from ASPM savings as originally intended.
> > >
> > > Link: https://lore.kernel.org/linux-pm/0b166ece-eeec-ba5d-2212-50d995=
611cef@panix.com
> > > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> >=20
> > First of all, thanks for doing this work, much appreciated!
> >=20
> > > ---
> > >  drivers/pci/controller/vmd.c | 28 ++++++++++++++++++++++++++--
> > >  drivers/pci/pci.h            |  8 ++++++++
> > >  drivers/pci/pcie/aspm.c      | 36 ++++++++++++++++++++++++++++++++++=
+-
> > >  3 files changed, 69 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vm=
d.c
> > > index 8df064b62a2f..e685586dc18b 100644
> > > --- a/drivers/pci/controller/vmd.c
> > > +++ b/drivers/pci/controller/vmd.c
> > > @@ -21,6 +21,8 @@
> > >
> > >  #include <asm/irqdomain.h>
> > >
> > > +#include "../pci.h"
> > > +
> > >  #define VMD_CFGBAR     0
> > >  #define VMD_MEMBAR1    2
> > >  #define VMD_MEMBAR2    4
> > > @@ -730,7 +732,7 @@ static void vmd_copy_host_bridge_flags(struct pci=
_host_bridge *root_bridge,
> > >  }
> > >
> > >  /*
> > > - * Enable ASPM and LTR settings on devices that aren't configured by=
 BIOS.
> > > + * Enable LTR settings on devices that aren't configured by BIOS.
> > >   */
> > >  static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
> > >  {
> > > @@ -770,10 +772,27 @@ static int vmd_pm_enable_quirk(struct pci_dev *=
pdev, void *userdata)
> > >          * PCIe r6.0, sec 5.5.4.
> > >          */
> > >         pci_set_power_state_locked(pdev, PCI_D0);
> > > -       pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
> >=20
> > Do I think correctly that this doesn't work because of the
> > aspm_disabled check in __pci_enable_link_state()?
>=20
> Yes.
>=20
> >=20
> > >         return 0;
> > >  }
> > >
> > > +static long vmd_get_link_state(struct pci_dev *pdev, void *data)
> > > +{
> > > +       struct pci_bus *vmd_bus =3D data;
> > > +       struct pci_bus *bus =3D pdev->bus;
> > > +
> > > +       while (bus) {
> > > +               if (bus =3D=3D vmd_bus)
> > > +                       return PCIE_LINK_STATE_ALL;
> > > +
> > > +               if (!bus->self)
> > > +                       break;
> > > +
> > > +               bus =3D bus->self->bus;
> > > +       }
> >=20
> > If I'm not mistaken, it would be sufficient to do a check like
> >=20
> >     if (pci_dev->bus->ops =3D=3D &vmd_ops)
> >             return PCIE_LINK_STATE_ALL;
> >=20
> > instead of the above, or if not then why not?
>=20
> As a replacement in the loop, that does look sufficient. I'm not sure if
> you're also suggesting replacing the loop itself.
>=20
> >=20
> > > +
> > > +       return -ENODEV;
> > > +}
> > > +
> > >  static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long feat=
ures)
> > >  {
> > >         struct pci_sysdata *sd =3D &vmd->sysdata;
> > > @@ -785,6 +804,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd,=
 unsigned long features)
> > >         resource_size_t membar2_offset =3D 0x2000;
> > >         struct pci_bus *child;
> > >         struct pci_dev *dev;
> > > +       struct pcie_aspm_vmd_link_state vmd_link_state;
> > >         int ret;
> > >
> > >         /*
> > > @@ -911,6 +931,10 @@ static int vmd_enable_domain(struct vmd_dev *vmd=
, unsigned long features)
> > >                 return -ENODEV;
> > >         }
> > >
> > > +       vmd_link_state.cb =3D vmd_get_link_state;
> > > +       vmd_link_state.data =3D vmd->bus;
> > > +       pci_register_vmd_link_state_cb(&vmd_link_state);
> > > +
> > >         vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus=
),
> > >                                    to_pci_host_bridge(vmd->bus->bridg=
e));
> > >
> > > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > > index 12215ee72afb..dcf7d39c660f 100644
> > > --- a/drivers/pci/pci.h
> > > +++ b/drivers/pci/pci.h
> > > @@ -821,6 +821,12 @@ void pci_configure_aspm_l1ss(struct pci_dev *dev=
);
> > >  void pci_save_aspm_l1ss_state(struct pci_dev *dev);
> > >  void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
> > >
> > > +
> > > +struct pcie_aspm_vmd_link_state {
> > > +       long (*cb)(struct pci_dev *pdev, void *data);
> > > +       void *data;
> > > +};
> > > +
> > >  #ifdef CONFIG_PCIEASPM
> > >  void pcie_aspm_init_link_state(struct pci_dev *pdev);
> > >  void pcie_aspm_exit_link_state(struct pci_dev *pdev);
> > > @@ -828,6 +834,7 @@ void pcie_aspm_pm_state_change(struct pci_dev *pd=
ev, bool locked);
> > >  void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
> > >  void pci_configure_ltr(struct pci_dev *pdev);
> > >  void pci_bridge_reconfigure_ltr(struct pci_dev *pdev);
> > > +void pci_register_vmd_link_state_cb(struct pcie_aspm_vmd_link_state =
*state);
> > >  #else
> > >  static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) {=
 }
> > >  static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) {=
 }
> > > @@ -835,6 +842,7 @@ static inline void pcie_aspm_pm_state_change(stru=
ct pci_dev *pdev, bool locked)
> > >  static inline void pcie_aspm_powersave_config_link(struct pci_dev *p=
dev) { }
> > >  static inline void pci_configure_ltr(struct pci_dev *pdev) { }
> > >  static inline void pci_bridge_reconfigure_ltr(struct pci_dev *pdev) =
{ }
> > > +void pci_register_vmd_link_state_cb(struct pcie_aspm_vmd_link_state =
*state) { }
> > >  #endif
> > >
> > >  #ifdef CONFIG_PCIE_ECRC
> > > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > > index 29fcb0689a91..c609d3c309be 100644
> > > --- a/drivers/pci/pcie/aspm.c
> > > +++ b/drivers/pci/pcie/aspm.c
> > > @@ -320,6 +320,27 @@ static int policy_to_clkpm_state(struct pcie_lin=
k_state *link)
> > >         return 0;
> > >  }
> > >
> > > +static struct pcie_aspm_vmd_link_state vmd_state;
> > > +
> > > +void pci_register_vmd_link_state_cb(struct pcie_aspm_vmd_link_state =
*state)
> > > +{
> > > +       mutex_lock(&aspm_lock);
> > > +       vmd_state.cb =3D state->cb;
> > > +       vmd_state.data =3D state->data;
> > > +       mutex_unlock(&aspm_lock);
> > > +}
> > > +EXPORT_SYMBOL_GPL(pci_register_vmd_link_state_cb);
> > > +
> > > +static long pci_get_vmd_link_state(struct pci_dev *pdev)
> > > +{
> > > +       int state =3D -ENODEV;
> > > +
> > > +       if (vmd_state.cb)
> > > +               state =3D vmd_state.cb(pdev, vmd_state.data);
> > > +
> > > +       return state;
> > > +}
> > > +
> > >  static void pci_update_aspm_saved_state(struct pci_dev *dev)
> > >  {
> > >         struct pci_cap_saved_state *save_state;
> > > @@ -794,6 +815,7 @@ static void pcie_aspm_cap_init(struct pcie_link_s=
tate *link, int blacklist)
> > >         u32 parent_lnkcap, child_lnkcap;
> > >         u16 parent_lnkctl, child_lnkctl;
> > >         struct pci_bus *linkbus =3D parent->subordinate;
> > > +       int vmd_aspm_default;
> > >
> > >         if (blacklist) {
> > >                 /* Set enabled/disable so that we will disable ASPM l=
ater */
> > > @@ -865,8 +887,20 @@ static void pcie_aspm_cap_init(struct pcie_link_=
state *link, int blacklist)
> > >                 pcie_capability_write_word(child, PCI_EXP_LNKCTL, chi=
ld_lnkctl);
> > >         }
> > >
> > > +       /*
> > > +        * Devices behind Intel VMD operate on a synthetic PCI bus th=
at BIOS
> > > +        * and ACPI do not enumerate or configure. ASPM for these dev=
ices must
> > > +        * be managed by the VMD driver itself, independent of global=
 ACPI ASPM
> > > +        * constraints. This callback mechanism allows selective ASPM
> > > +        * enablement for such domains.
> > > +        */
> > > +       vmd_aspm_default =3D pci_get_vmd_link_state(parent);
> > > +
> > >         /* Save default state */
> > > -       link->aspm_default =3D link->aspm_enabled;
> > > +       if (vmd_aspm_default < 0)
> > > +               link->aspm_default =3D link->aspm_enabled;
> > > +       else
> > > +               link->aspm_default =3D vmd_aspm_default;
> >=20
> > Well, this is not nice.
> >=20
> > First off, it adds VMD-specific stuff to otherwise generic ASPM code.
> > Second, it doesn't actually do anything about the aspm_disabled checks
> > all over the place, so they will still trigger even though ASPM will
> > be effectively enabled for devices on the VMD bus.
>=20
> I agree that it's not nice to be mixing VMD specific code here. It's a
> working bad solution to come up with a working good solution :)
>=20
> The reason this patch works is that the aspm_disabled checks only gate
> OS-controlled ASPM configuration. They don't affect the BIOS default
> values, which are what we're setting in link->aspm_default. The ASPM
> code uses link->aspm_default as the fallback when ASPM is globally
> disabled, which is exactly what we want for devices behind VMD where the
> driver, not BIOS, effectively is the platform provider of the defaults.

Oh, this was a big news to me.

So what you're saying is that if aspm_disabled is set, ->aspm_disable=20
cannot be set and thus pcie_config_aspm_link() that is not gated by=20
aspm_disabled can alter ASPM state despite OS not having ASPM control???

=2E..That's really odd logic which the ASPM driver seems to be full of.

--=20
 i.

> I put it here using a callback value because this where the BIOS
> defaults are saved for each device.
>=20
> >=20
> > >
> > >         /* Setup initial capable state. Will be updated later */
> > >         link->aspm_capable =3D link->aspm_support;
> > >
> > > base-commit: d0b3b7b22dfa1f4b515fd3a295b3fd958f9e81af
> > > --
> >=20
> > It appears to me that the underlying problem is that aspm_disabled is
> > global and it is set during PCI root bus creation in
> > acpi_pci_root_add().  Thus it affects all of the PCI buses even though
> > the BIOS says that it wants to control ASPM for this particular PCIe
> > hierarchy. If there were another PCI root enumerated by ACPI where
> > the OS would be allowed to control ASPM, it would not work just like
> > the VMD case.
>=20
> It would work in the non-VMD case because it has the BIOS default to
> use. VMD does not.
>=20
> >=20
> > To me, this suggests an approach based on moving the "ASPM disabled
> > because the BIOS wants to control it" setting to pci_bus_flags_t and
> > setting it on a per-hierarchy basis.  Since the VMD bus is a separate
> > PCIe hierarchy from the kernel perspective, it will not have this flag
> > set and the OS should be able to configure ASPM for devices on that
> > bus.
> >=20
> > Do I think correctly or am I overlooking something here?
>=20
> It=E2=80=99s definitely along those lines. The issue is really caused by =
two
> things:
>=20
>     1. aspm_disabled global prevents OS control of ASPM
>     2. For VMD, there=E2=80=99s no BIOS provided link->aspm_default
>=20
> The solution I proposed addresses the problem by having a mechanism for
> the VMD driver to supply its own defaults in place of the missing BIOS
> configuration.
>=20
> Using pci_bus_flags_t could work as well, but would rather just say that
> aspm_disabled doesn't apply to the bus hierarchy, allowing the current
> pci_enable_link_state_locked() solution to work all the time. Either
> way, I'm definitely looking for a cleaner solution. The above hopefully
> clarifies the situation.
>=20
> David
>=20
--8323328-827757273-1752245343=:933--

