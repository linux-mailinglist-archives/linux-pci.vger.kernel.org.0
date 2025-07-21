Return-Path: <linux-pci+bounces-32643-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10545B0C2E9
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 13:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA7991AA12B8
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 11:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EED29C340;
	Mon, 21 Jul 2025 11:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lj4ANwo0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7CF29B8D2;
	Mon, 21 Jul 2025 11:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753097318; cv=none; b=F6RLIU7deOpzjlQ+88lZw2gfVtSuqkm8Ba7UqZ02M8NRs5AMyOLtCtI5/MIlXZD0HYmb7A+6YXrzVXyajWNa0enWcD/fQpw1YWqMRoWLuh6I50v0eD6h6WSGlq7/R974segBjhXU0mph/3SRV/AM/juiwnjpJbDpq4DKhUHLxKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753097318; c=relaxed/simple;
	bh=eQezYz66/+XQz7IKViqI2K/mgmBuRA+/oJUk8NS0y3M=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bRDdGtPzT0AG8CqnX3duvmfJwP508WoNRsuq6Te8vQ9sw2s9YpweP5mL5dVwMS6N/BiNZghtngXuHgoOQUb0rkOJUFklXenbdVrHuqcBSryOYAcPddwQYtGvG3eQWAymD+Q5wBJ/yX15qqCnDGhJQf/7KJc85ZNOb3oX0uvkvWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lj4ANwo0; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753097316; x=1784633316;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=eQezYz66/+XQz7IKViqI2K/mgmBuRA+/oJUk8NS0y3M=;
  b=lj4ANwo0meC48397Hxv9AzSuT6pQuuOOwuIznqYjjcp+5jxreqN2rytu
   PI55FQJ+yfUoc3J2/s/3jDvhXQc4YmpQ6D09fKrDkUeUW6DgESUOIG6nW
   JtsiDKjJAoklUbMNJYit2El20Z5vbk8V1TdwLWtZmIlDDUsfq7CRXx1rp
   gSH0OI6n0eRPDvllh6nyHyKURGDnyRea2DNiSrE4LlhfGfk8LkQf6cDch
   AgHRoHuf0YEKmifGQI2hJsg9jF9aiF367bFNTWsc9utOb3YvF7p6CC/oS
   aZEBLc3c8i9q9HG2ypfjbNZzfcgUmzPvjR3nH0d+i8Pa4gUdGC8/95n8N
   Q==;
X-CSE-ConnectionGUID: 8UA/VAeMT2qYOz6pBKNj+Q==
X-CSE-MsgGUID: B/JnR9MGQomVEL/8K0hrnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="65568039"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="65568039"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 04:28:35 -0700
X-CSE-ConnectionGUID: 1/T2S8u1Q2a/5Zgu9KCCcA==
X-CSE-MsgGUID: p+6P3nXnQ1a2p9PTO3h6zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="158471166"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 04:28:28 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 21 Jul 2025 14:28:24 +0300 (EEST)
To: Manivannan Sadhasivam <mani@kernel.org>, 
    "Rafael J. Wysocki" <rafael@kernel.org>
cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
    Jeff Johnson <jjohnson@kernel.org>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>, 
    Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
    Nirmal Patel <nirmal.patel@linux.intel.com>, 
    Jonathan Derrick <jonathan.derrick@linux.dev>, 
    linux-wireless@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    ath12k@lists.infradead.org, ath11k@lists.infradead.org, 
    ath10k@lists.infradead.org, Bjorn Helgaas <helgaas@kernel.org>, 
    linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
    Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
    Qiang Yu <qiang.yu@oss.qualcomm.com>
Subject: Re: [PATCH 4/6] wifi: ath12k: Use pci_{enable/disable}_link_state()
 APIs to enable/disable ASPM states
In-Reply-To: <je7sz6lgig3picksxv4ncfjcnnw2sdsp5ja6bwofqjuydhc4v6@b3kavwicxggu>
Message-ID: <fdfcc2c8-c749-2616-9295-7f4aa37fb0a4@linux.intel.com>
References: <20250716-ath-aspm-fix-v1-0-dd3e62c1b692@oss.qualcomm.com> <20250716-ath-aspm-fix-v1-4-dd3e62c1b692@oss.qualcomm.com> <7a97d075-2e37-5f40-5247-867146938613@linux.intel.com> <3q2gqo6ipzyqr7i64yhndtpg4etwep4lgffk7emxluxuhjfya5@vt7czmsgpbuw>
 <52baf40b-41ed-2588-7817-4d8cd859e0d1@linux.intel.com> <je7sz6lgig3picksxv4ncfjcnnw2sdsp5ja6bwofqjuydhc4v6@b3kavwicxggu>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1126931654-1753097304=:69097"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1126931654-1753097304=:69097
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 21 Jul 2025, Manivannan Sadhasivam wrote:

> On Mon, Jul 21, 2025 at 01:09:05PM GMT, Ilpo J=C3=A4rvinen wrote:
> > On Mon, 21 Jul 2025, Manivannan Sadhasivam wrote:
> > > On Mon, Jul 21, 2025 at 11:04:10AM GMT, Ilpo J=C3=A4rvinen wrote:
> > > > On Wed, 16 Jul 2025, Manivannan Sadhasivam via B4 Relay wrote:
> > > > > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.c=
om>
> > > > >=20
> > > > > It is not recommended to enable/disable the ASPM states on the ba=
ck of the
> > > > > PCI core directly using the LNKCTL register. It will break the PC=
I core's
> > > > > knowledge about the device ASPM states. So use the APIs exposed b=
y the PCI
> > > > > core to enable/disable ASPM states.
> > > > >=20
> > > > > Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.=
0_V2.0_SILICONZ-3
> > > > >=20
> > > > > Reported-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> > > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.q=
ualcomm.com>
> > > > > ---
> > > > >  drivers/net/wireless/ath/ath.h        | 14 ++++++++++++++
> > > > >  drivers/net/wireless/ath/ath12k/pci.c | 10 ++++------
> > > > >  2 files changed, 18 insertions(+), 6 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/net/wireless/ath/ath.h b/drivers/net/wireles=
s/ath/ath.h
> > > > > index 34654f710d8a1e63f65a47d4602e2035262a4d9e..ef685123b66bf4f41=
428fec67c1967f242a9ef27 100644
> > > > > --- a/drivers/net/wireless/ath/ath.h
> > > > > +++ b/drivers/net/wireless/ath/ath.h
> > > > > @@ -21,6 +21,8 @@
> > > > >  #include <linux/skbuff.h>
> > > > >  #include <linux/if_ether.h>
> > > > >  #include <linux/spinlock.h>
> > > > > +#include <linux/pci.h>
> > > > > +#include <linux/pci_regs.h>
> > > > >  #include <net/mac80211.h>
> > > > > =20
> > > > >  /*
> > > > > @@ -336,4 +338,16 @@ static inline const char *ath_bus_type_to_st=
ring(enum ath_bus_type bustype)
> > > > >  =09return ath_bus_type_strings[bustype];
> > > > >  }
> > > > > =20
> > > > > +static inline int ath_pci_aspm_state(u16 lnkctl)
> > > > > +{
> > > > > +=09int state =3D 0;
> > > > > +
> > > > > +=09if (lnkctl & PCI_EXP_LNKCTL_ASPM_L0S)
> > > > > +=09=09state |=3D PCIE_LINK_STATE_L0S;
> > > > > +=09if (lnkctl & PCI_EXP_LNKCTL_ASPM_L1)
> > > > > +=09=09state |=3D PCIE_LINK_STATE_L1;
> > > > > +
> > > > > +=09return state;
> > > > > +}
> > > > > +
> > > > >  #endif /* ATH_H */
> > > > > diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/=
wireless/ath/ath12k/pci.c
> > > > > index 489d546390fcdab8f615cc9184006a958d9f140a..a5e11509e3ab8faad=
6638ff78ce6a8a5e9c3cbbd 100644
> > > > > --- a/drivers/net/wireless/ath/ath12k/pci.c
> > > > > +++ b/drivers/net/wireless/ath/ath12k/pci.c
> > > > > @@ -16,6 +16,8 @@
> > > > >  #include "mhi.h"
> > > > >  #include "debug.h"
> > > > > =20
> > > > > +#include "../ath.h"
> > > > > +
> > > > >  #define ATH12K_PCI_BAR_NUM=09=090
> > > > >  #define ATH12K_PCI_DMA_MASK=09=0936
> > > > > =20
> > > > > @@ -928,8 +930,7 @@ static void ath12k_pci_aspm_disable(struct at=
h12k_pci *ab_pci)
> > > > >  =09=09   u16_get_bits(ab_pci->link_ctl, PCI_EXP_LNKCTL_ASPM_L1))=
;
> > > > > =20
> > > > >  =09/* disable L0s and L1 */
> > > > > -=09pcie_capability_clear_word(ab_pci->pdev, PCI_EXP_LNKCTL,
> > > > > -=09=09=09=09   PCI_EXP_LNKCTL_ASPMC);
> > > > > +=09pci_disable_link_state(ab_pci->pdev, PCIE_LINK_STATE_L0S | PC=
IE_LINK_STATE_L1);
> > > >=20
> > > > I'd remove to comment too as the code is self-explanatory after thi=
s=20
> > > > change.
> > > >=20
> > >=20
> > > Ack
> > >=20
> > > > > =20
> > > > >  =09set_bit(ATH12K_PCI_ASPM_RESTORE, &ab_pci->flags);
> > > > >  }
> > > > > @@ -958,10 +959,7 @@ static void ath12k_pci_aspm_restore(struct a=
th12k_pci *ab_pci)
> > > > >  {
> > > > >  =09if (ab_pci->ab->hw_params->supports_aspm &&
> > > > >  =09    test_and_clear_bit(ATH12K_PCI_ASPM_RESTORE, &ab_pci->flag=
s))
> > > > > -=09=09pcie_capability_clear_and_set_word(ab_pci->pdev, PCI_EXP_L=
NKCTL,
> > > > > -=09=09=09=09=09=09   PCI_EXP_LNKCTL_ASPMC,
> > > > > -=09=09=09=09=09=09   ab_pci->link_ctl &
> > > > > -=09=09=09=09=09=09   PCI_EXP_LNKCTL_ASPMC);
> > > > > +=09=09pci_enable_link_state(ab_pci->pdev, ath_pci_aspm_state(ab_=
pci->link_ctl));
> > > > >  }
> > > > > =20
> > > > >  static void ath12k_pci_cancel_workqueue(struct ath12k_base *ab)
> > > >=20
> > > > As you now depend on ASPM driver being there, these should also add=
 to=20
> > > > Kconfig:
> > > >=20
> > > > depends on PCIEASPM
> > > >=20
> > >=20
> > > I thought about it, but since this driver doesn't necessarily enable =
ASPM for
> > > all the devices it supports, I didn't add the dependency. But looking=
 at it
> > > again, I think makes sense to add the dependency since the driver can=
not work
> > > reliably without disabling ASPM (for the supported devices).
> >=20
> > PCIEASPM is already default y and if EXPERT so it is not something=20
> > that is expected to be disabled.
> >=20
> > You also no longer need to move the ASPM link state defines LKP found o=
ut=20
> > about after adding the depends on.
> >=20
>=20
> Yes, it will fix the reported issue, but guarding the definitions feels w=
rong to
> me still. Maybe that's something we can worry later.
>=20
> > I'm a bit worried this series will regress in the cases where OS doesn'=
t=20
> > control ASPM so it might be necessary to include something along the=20
> > lines of the patch below too (the earlier discussion on this is in Link=
=20
> > tags):
> >=20
>=20
> atheros drivers didn't have such comment (why they were manually changing=
 the
> LNKCTL register), but I agree that there is a chance that they could caus=
e issue
> on platforms where BIOS didn't give ASPM control to the OS.
>=20
> But as a non-ACPI developer, I don't know what does 'ACPI doesn't give
> permission to manage ASPM' mean exactly. Does ACPI allow to disable ASPM =
but not
> enable it?

While others are likely better qualified to answer this, my impression is=
=20
that even disabling ASPM is not allowed when OS does has not been granted=
=20
control over ASPM (OS should not change the value of ASPM Control in=20
LNKCTL at all).

The obvious trouble then is, if a driver/hw needs ASPM to be disabled over=
=20
certain period of its operation or entirely to ensure stable operation,=20
and ASPM is enabled, we're between a rock and a hard place when changes to=
=20
ASPM Control field are disallowed.

Because the ASPM driver took a hard stance of conformance here and did=20
not let touching the ASPM Control field, we ended up having drivers that=20
then write ASPM Control on their own to work around HW problems (see e.g.=
=20
the comments in drivers/net/ethernet/intel/e1000e/netdev.c that make it=20
very clear it was intentional from the driver) so it was considered that=20
allowing disabling ASPM might be acceptable compromise over drivers doing=
=20
it on their own (and leaving the ASPM driver out of the loop because it=20
cannot be relied to disable ASPM consistently in all cases).

--=20
 i.

> > -----
> > From: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > Subject: [PATCH] PCI/ASPM: Always disable ASPM when driver requests it
> >=20
> > PCI core/ASPM service driver allows controlling ASPM state through
> > pci_disable_link_state() API. It was decided earlier (see the Link
> > below), to not allow ASPM changes when OS does not have control over it
> > but only log a warning about the problem (commit 2add0ec14c25
> > ("PCI/ASPM: Warn when driver asks to disable ASPM, but we can't do
> > it")).
> >=20
> > A number of drivers have added workarounds to force ASPM off with own
> > writes into the Link Control Register (some even with comments
> > explaining why PCI core does not disable it under some circumstances).
> > According to the comments, some drivers require ASPM to be off for
> > reliable operation.
> >=20
> > Having custom ASPM handling in drivers is problematic because the state
> > kept in the ASPM service driver is not updated by the changes made
> > outside the link state management API.
> >=20
> > As the first step to address this issue, make pci_disable_link_state()
> > to unconditionally disable ASPM so the motivation for drivers to come
> > up with custom ASPM handling code is eliminated.
> >=20
> > To fully take advantage of the ASPM handling core provides, the drivers
> > that need to quirk ASPM have to be altered depend on PCIEASPM and the
> > custom ASPM code is removed. This is to be done separately. As PCIEASPM
> > is already behind EXPERT, it should be no problem to limit disabling it
> > for configurations that do not require touching ASPM.
> >=20
> > Make pci_disable_link_state() function comment to comply kerneldoc
> > formatting while changing the description.
> >=20
> > Link: https://lore.kernel.org/all/CANUX_P3F5YhbZX3WGU-j1AGpbXb_T9Bis2Er=
hvKkFMtDvzatVQ@mail.gmail.com/
> > Link: https://lore.kernel.org/all/20230511131441.45704-1-ilpo.jarvinen@=
linux.intel.com/
> > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> >=20
> > ---
> >  drivers/pci/pcie/aspm.c | 33 ++++++++++++++++++++-------------
> >  1 file changed, 20 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index 5721ebfdea71..11732031e342 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -1382,16 +1382,23 @@ static int __pci_disable_link_state(struct pci_=
dev *pdev, int state, bool locked
> >  =09=09return -EINVAL;
> >  =09/*
> >  =09 * A driver requested that ASPM be disabled on this device, but
> > -=09 * if we don't have permission to manage ASPM (e.g., on ACPI
> > +=09 * if we might not have permission to manage ASPM (e.g., on ACPI
> >  =09 * systems we have to observe the FADT ACPI_FADT_NO_ASPM bit and
> > -=09 * the _OSC method), we can't honor that request.  Windows has
> > -=09 * a similar mechanism using "PciASPMOptOut", which is also
> > -=09 * ignored in this situation.
> > +=09 * the _OSC method), previously we chose to not honor disable
> > +=09 * request in that case. Windows has a similar mechanism using
> > +=09 * "PciASPMOptOut", which is also ignored in this situation.
> > +=09 *
> > +=09 * Not honoring the requests to disable ASPM, however, led to
> > +=09 * drivers forcing ASPM off on their own. As such changes of ASPM
> > +=09 * state are not tracked by this service driver, the state kept her=
e
> > +=09 * became out of sync.
> > +=09 *
> > +=09 * Therefore, honor ASPM disable requests even when OS does not hav=
e
> > +=09 * ASPM control. Plain disable for ASPM is assumed to be slightly
> > +=09 * safer than fully managing it.
> >  =09 */
> > -=09if (aspm_disabled) {
> > -=09=09pci_warn(pdev, "can't disable ASPM; OS doesn't have ASPM control=
\n");
> > -=09=09return -EPERM;
> > -=09}
> > +=09if (aspm_disabled)
> > +=09=09pci_warn(pdev, "OS doesn't have ASPM control, disabling ASPM any=
way\n");
> > =20
> >  =09if (!locked)
> >  =09=09down_read(&pci_bus_sem);
> > @@ -1418,13 +1425,13 @@ int pci_disable_link_state_locked(struct pci_de=
v *pdev, int state)
> >  EXPORT_SYMBOL(pci_disable_link_state_locked);
> > =20
> >  /**
> > - * pci_disable_link_state - Disable device's link state, so the link w=
ill
> > - * never enter specific states.  Note that if the BIOS didn't grant AS=
PM
> > - * control to the OS, this does nothing because we can't touch the LNK=
CTL
> > - * register. Returns 0 or a negative errno.
> > - *
> > + * pci_disable_link_state - Disable device's link state
> >   * @pdev: PCI device
> >   * @state: ASPM link state to disable
> > + *
> > + * Disable device's link state so the link will never enter specific s=
tates.
> > + *
> > + * Return: 0 or a negative errno
> >   */
> >  int pci_disable_link_state(struct pci_dev *pdev, int state)
> >  {
> >=20
> > --=20
> > tg: (9f4972a5d481..) aspm/disable-always (depends on: pci/set-default-c=
omment2)
>=20
>=20
>=20
--8323328-1126931654-1753097304=:69097--

