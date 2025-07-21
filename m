Return-Path: <linux-pci+bounces-32636-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7333B0C0F1
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 12:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 170464E2757
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 10:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF16D28DF0F;
	Mon, 21 Jul 2025 10:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XpybSCZZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7399528DF02;
	Mon, 21 Jul 2025 10:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753092555; cv=none; b=HRv3LBpsCa6Ay06RapiuTPf5WHK2PnWIx6yezJe/DOifikewx1mNNJj07jfl5SVs+8E7QMrM+acv+t/Qw/noClLsAtv2VZ9VxZHFj9zpA6ZZTBDVF4ln8Hn4kOI/lbOSwa4hxMnCUduWv1LR6VXoHP+rOHZWTRqbi9OZSfV4K/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753092555; c=relaxed/simple;
	bh=Tg/4b4h6qnSre5IgdRyMFBoGmhuuaYdECJxsVV1WJdo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=j8w7tpfM+1tmXg4M6Dbrxzv0O8j3ExT7UaqKWS9WGxCqn1979EkYBLeYE1v1luVOCp2pYZFa+vFqqI7Jxm7Cn/eAQgYZvKo+PIqidpTNQ2d2RcIP2Ourvbf4FJbUaOsKMp1IA0QhCtvKDbgxVLVpeOeQEGILhXGPBzx5RCM+Hzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XpybSCZZ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753092554; x=1784628554;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Tg/4b4h6qnSre5IgdRyMFBoGmhuuaYdECJxsVV1WJdo=;
  b=XpybSCZZc/r2WTg/RcbO9GeeYIAERMN1M0r4Xl4rCmeyBCiiSH/2ABga
   ZzMC25ENr/tVzIQXFifXKP887gH8DGmgo5wEoH8RI1hgicamjR1zGMOdL
   TQH2KQu/CuDSAffVYqPtg2oEvf/ujGBTqxRt2cyZ0c859rePTrJhbCbfc
   QUS2nGdRNwHY23H7MszWLb7BlcUX8oTPgbZHKiPkMmwnqU7/VdDURtjeM
   CmPygcLAv3DhjVt3I2gEDGTYlKdXWrP7H9SZj6hIXEpBISeeQHQe6xwm6
   JaCnN/eG17HZuy0Nk4lvqCs2DpLTHwNyKWcChy8JMrQ8l7H09qcRQcIuR
   w==;
X-CSE-ConnectionGUID: 47E4lQb8TbSKNnum6r1GOA==
X-CSE-MsgGUID: AXGNc6g+SBGFNQHfhKsDbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="65871295"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="65871295"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 03:09:13 -0700
X-CSE-ConnectionGUID: sMxoJNNaT4yHMxM6NSHEbg==
X-CSE-MsgGUID: 0+HhGTpLSaOxpNGsGjeLzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="162835086"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 03:09:08 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 21 Jul 2025 13:09:05 +0300 (EEST)
To: Manivannan Sadhasivam <mani@kernel.org>
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
In-Reply-To: <3q2gqo6ipzyqr7i64yhndtpg4etwep4lgffk7emxluxuhjfya5@vt7czmsgpbuw>
Message-ID: <52baf40b-41ed-2588-7817-4d8cd859e0d1@linux.intel.com>
References: <20250716-ath-aspm-fix-v1-0-dd3e62c1b692@oss.qualcomm.com> <20250716-ath-aspm-fix-v1-4-dd3e62c1b692@oss.qualcomm.com> <7a97d075-2e37-5f40-5247-867146938613@linux.intel.com> <3q2gqo6ipzyqr7i64yhndtpg4etwep4lgffk7emxluxuhjfya5@vt7czmsgpbuw>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-917264169-1753092545=:945"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-917264169-1753092545=:945
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 21 Jul 2025, Manivannan Sadhasivam wrote:
> On Mon, Jul 21, 2025 at 11:04:10AM GMT, Ilpo J=C3=A4rvinen wrote:
> > On Wed, 16 Jul 2025, Manivannan Sadhasivam via B4 Relay wrote:
> > > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > >=20
> > > It is not recommended to enable/disable the ASPM states on the back o=
f the
> > > PCI core directly using the LNKCTL register. It will break the PCI co=
re's
> > > knowledge about the device ASPM states. So use the APIs exposed by th=
e PCI
> > > core to enable/disable ASPM states.
> > >=20
> > > Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2=
=2E0_SILICONZ-3
> > >=20
> > > Reported-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualc=
omm.com>
> > > ---
> > >  drivers/net/wireless/ath/ath.h        | 14 ++++++++++++++
> > >  drivers/net/wireless/ath/ath12k/pci.c | 10 ++++------
> > >  2 files changed, 18 insertions(+), 6 deletions(-)
> > >=20
> > > diff --git a/drivers/net/wireless/ath/ath.h b/drivers/net/wireless/at=
h/ath.h
> > > index 34654f710d8a1e63f65a47d4602e2035262a4d9e..ef685123b66bf4f41428f=
ec67c1967f242a9ef27 100644
> > > --- a/drivers/net/wireless/ath/ath.h
> > > +++ b/drivers/net/wireless/ath/ath.h
> > > @@ -21,6 +21,8 @@
> > >  #include <linux/skbuff.h>
> > >  #include <linux/if_ether.h>
> > >  #include <linux/spinlock.h>
> > > +#include <linux/pci.h>
> > > +#include <linux/pci_regs.h>
> > >  #include <net/mac80211.h>
> > > =20
> > >  /*
> > > @@ -336,4 +338,16 @@ static inline const char *ath_bus_type_to_string=
(enum ath_bus_type bustype)
> > >  =09return ath_bus_type_strings[bustype];
> > >  }
> > > =20
> > > +static inline int ath_pci_aspm_state(u16 lnkctl)
> > > +{
> > > +=09int state =3D 0;
> > > +
> > > +=09if (lnkctl & PCI_EXP_LNKCTL_ASPM_L0S)
> > > +=09=09state |=3D PCIE_LINK_STATE_L0S;
> > > +=09if (lnkctl & PCI_EXP_LNKCTL_ASPM_L1)
> > > +=09=09state |=3D PCIE_LINK_STATE_L1;
> > > +
> > > +=09return state;
> > > +}
> > > +
> > >  #endif /* ATH_H */
> > > diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wire=
less/ath/ath12k/pci.c
> > > index 489d546390fcdab8f615cc9184006a958d9f140a..a5e11509e3ab8faad6638=
ff78ce6a8a5e9c3cbbd 100644
> > > --- a/drivers/net/wireless/ath/ath12k/pci.c
> > > +++ b/drivers/net/wireless/ath/ath12k/pci.c
> > > @@ -16,6 +16,8 @@
> > >  #include "mhi.h"
> > >  #include "debug.h"
> > > =20
> > > +#include "../ath.h"
> > > +
> > >  #define ATH12K_PCI_BAR_NUM=09=090
> > >  #define ATH12K_PCI_DMA_MASK=09=0936
> > > =20
> > > @@ -928,8 +930,7 @@ static void ath12k_pci_aspm_disable(struct ath12k=
_pci *ab_pci)
> > >  =09=09   u16_get_bits(ab_pci->link_ctl, PCI_EXP_LNKCTL_ASPM_L1));
> > > =20
> > >  =09/* disable L0s and L1 */
> > > -=09pcie_capability_clear_word(ab_pci->pdev, PCI_EXP_LNKCTL,
> > > -=09=09=09=09   PCI_EXP_LNKCTL_ASPMC);
> > > +=09pci_disable_link_state(ab_pci->pdev, PCIE_LINK_STATE_L0S | PCIE_L=
INK_STATE_L1);
> >=20
> > I'd remove to comment too as the code is self-explanatory after this=20
> > change.
> >=20
>=20
> Ack
>=20
> > > =20
> > >  =09set_bit(ATH12K_PCI_ASPM_RESTORE, &ab_pci->flags);
> > >  }
> > > @@ -958,10 +959,7 @@ static void ath12k_pci_aspm_restore(struct ath12=
k_pci *ab_pci)
> > >  {
> > >  =09if (ab_pci->ab->hw_params->supports_aspm &&
> > >  =09    test_and_clear_bit(ATH12K_PCI_ASPM_RESTORE, &ab_pci->flags))
> > > -=09=09pcie_capability_clear_and_set_word(ab_pci->pdev, PCI_EXP_LNKCT=
L,
> > > -=09=09=09=09=09=09   PCI_EXP_LNKCTL_ASPMC,
> > > -=09=09=09=09=09=09   ab_pci->link_ctl &
> > > -=09=09=09=09=09=09   PCI_EXP_LNKCTL_ASPMC);
> > > +=09=09pci_enable_link_state(ab_pci->pdev, ath_pci_aspm_state(ab_pci-=
>link_ctl));
> > >  }
> > > =20
> > >  static void ath12k_pci_cancel_workqueue(struct ath12k_base *ab)
> >=20
> > As you now depend on ASPM driver being there, these should also add to=
=20
> > Kconfig:
> >=20
> > depends on PCIEASPM
> >=20
>=20
> I thought about it, but since this driver doesn't necessarily enable ASPM=
 for
> all the devices it supports, I didn't add the dependency. But looking at =
it
> again, I think makes sense to add the dependency since the driver cannot =
work
> reliably without disabling ASPM (for the supported devices).

PCIEASPM is already default y and if EXPERT so it is not something=20
that is expected to be disabled.

You also no longer need to move the ASPM link state defines LKP found out=
=20
about after adding the depends on.

I'm a bit worried this series will regress in the cases where OS doesn't=20
control ASPM so it might be necessary to include something along the=20
lines of the patch below too (the earlier discussion on this is in Link=20
tags):

-----
From: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH] PCI/ASPM: Always disable ASPM when driver requests it

PCI core/ASPM service driver allows controlling ASPM state through
pci_disable_link_state() API. It was decided earlier (see the Link
below), to not allow ASPM changes when OS does not have control over it
but only log a warning about the problem (commit 2add0ec14c25
("PCI/ASPM: Warn when driver asks to disable ASPM, but we can't do
it")).

A number of drivers have added workarounds to force ASPM off with own
writes into the Link Control Register (some even with comments
explaining why PCI core does not disable it under some circumstances).
According to the comments, some drivers require ASPM to be off for
reliable operation.

Having custom ASPM handling in drivers is problematic because the state
kept in the ASPM service driver is not updated by the changes made
outside the link state management API.

As the first step to address this issue, make pci_disable_link_state()
to unconditionally disable ASPM so the motivation for drivers to come
up with custom ASPM handling code is eliminated.

To fully take advantage of the ASPM handling core provides, the drivers
that need to quirk ASPM have to be altered depend on PCIEASPM and the
custom ASPM code is removed. This is to be done separately. As PCIEASPM
is already behind EXPERT, it should be no problem to limit disabling it
for configurations that do not require touching ASPM.

Make pci_disable_link_state() function comment to comply kerneldoc
formatting while changing the description.

Link: https://lore.kernel.org/all/CANUX_P3F5YhbZX3WGU-j1AGpbXb_T9Bis2ErhvKk=
FMtDvzatVQ@mail.gmail.com/
Link: https://lore.kernel.org/all/20230511131441.45704-1-ilpo.jarvinen@linu=
x.intel.com/
Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

---
 drivers/pci/pcie/aspm.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 5721ebfdea71..11732031e342 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1382,16 +1382,23 @@ static int __pci_disable_link_state(struct pci_dev =
*pdev, int state, bool locked
 =09=09return -EINVAL;
 =09/*
 =09 * A driver requested that ASPM be disabled on this device, but
-=09 * if we don't have permission to manage ASPM (e.g., on ACPI
+=09 * if we might not have permission to manage ASPM (e.g., on ACPI
 =09 * systems we have to observe the FADT ACPI_FADT_NO_ASPM bit and
-=09 * the _OSC method), we can't honor that request.  Windows has
-=09 * a similar mechanism using "PciASPMOptOut", which is also
-=09 * ignored in this situation.
+=09 * the _OSC method), previously we chose to not honor disable
+=09 * request in that case. Windows has a similar mechanism using
+=09 * "PciASPMOptOut", which is also ignored in this situation.
+=09 *
+=09 * Not honoring the requests to disable ASPM, however, led to
+=09 * drivers forcing ASPM off on their own. As such changes of ASPM
+=09 * state are not tracked by this service driver, the state kept here
+=09 * became out of sync.
+=09 *
+=09 * Therefore, honor ASPM disable requests even when OS does not have
+=09 * ASPM control. Plain disable for ASPM is assumed to be slightly
+=09 * safer than fully managing it.
 =09 */
-=09if (aspm_disabled) {
-=09=09pci_warn(pdev, "can't disable ASPM; OS doesn't have ASPM control\n")=
;
-=09=09return -EPERM;
-=09}
+=09if (aspm_disabled)
+=09=09pci_warn(pdev, "OS doesn't have ASPM control, disabling ASPM anyway\=
n");
=20
 =09if (!locked)
 =09=09down_read(&pci_bus_sem);
@@ -1418,13 +1425,13 @@ int pci_disable_link_state_locked(struct pci_dev *p=
dev, int state)
 EXPORT_SYMBOL(pci_disable_link_state_locked);
=20
 /**
- * pci_disable_link_state - Disable device's link state, so the link will
- * never enter specific states.  Note that if the BIOS didn't grant ASPM
- * control to the OS, this does nothing because we can't touch the LNKCTL
- * register. Returns 0 or a negative errno.
- *
+ * pci_disable_link_state - Disable device's link state
  * @pdev: PCI device
  * @state: ASPM link state to disable
+ *
+ * Disable device's link state so the link will never enter specific state=
s.
+ *
+ * Return: 0 or a negative errno
  */
 int pci_disable_link_state(struct pci_dev *pdev, int state)
 {

--=20
tg: (9f4972a5d481..) aspm/disable-always (depends on: pci/set-default-comme=
nt2)
--8323328-917264169-1753092545=:945--

