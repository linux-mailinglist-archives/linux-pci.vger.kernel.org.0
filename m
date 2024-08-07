Return-Path: <linux-pci+bounces-11465-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC63E94B39E
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 01:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CA502814E4
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 23:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DA9155321;
	Wed,  7 Aug 2024 23:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HBh0vmjT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2728145FF5;
	Wed,  7 Aug 2024 23:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723073255; cv=none; b=QKGTyFTOPiF2zMpGdJg0upt2et4+LUpHZAJKHFOWR/mrzpzPgxWFTnk0KX3+R5lzx9MK8jPlCHujVxT6TPoAxRyhSVgpyWfKSEvlYTbBXR6LfVBmVEe8+DBgBemP4ssb0m0/V9h7rE1opGMY8ApLO8+C4ihjcH2MMo5J6/mdkQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723073255; c=relaxed/simple;
	bh=wM1mh+Gsl+09RRRQshzCN/JpQfUTN8oNJBZOUAPQWoQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qp5rudnPZEZiOiHTF6zQhmziI/FjEBd+O0Erah3A9pUbV0/3EmQliWYqr2971mSSaN/X2F3Ol3A/Qf1A4roH856wsHs7ETZFTjSkvQb1CuSJb0WYr+fKlw98i95UrCIYYCBkuZHdA0xfiIoKPkhKUFUXn87+X3nqdDWI9T7T/Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HBh0vmjT; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723073254; x=1754609254;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=wM1mh+Gsl+09RRRQshzCN/JpQfUTN8oNJBZOUAPQWoQ=;
  b=HBh0vmjT1MxumFFEB4mRCuFZTXHrTGf2iSrECVxG2AY4Gaxn0cf1Jvik
   wLuUpTAr2G6B9GI+5DGfdnX1IYGaohYUoDGh4wDSk7OXnfhK0HqLWO6KJ
   XDk1pUbRD8iJd62e9vbFDRajyj2Z0yH8dIguo8axi3pi/z6TRyC8w3gGu
   jUq9Dqx+fgHcxbCZmFtNU5Xz8UaD2yJLRV6K/+thV5RhiHvPdKUvdbJFg
   xdFo19eDTpSz4GeMmZHkvFijcQ+iGruhPi8UDT+XrsJqJ99YWpBLiaLwt
   U079zHTAb3Y5kUni7DOUlNKaI+b1G06UqYX8jK6m0sQC9TKbmpmwJyynm
   w==;
X-CSE-ConnectionGUID: TrIOW8LATRKY8Lr+81leYw==
X-CSE-MsgGUID: XFwsxLGBT5mpqSzZrX17/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="20748561"
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="20748561"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 16:27:33 -0700
X-CSE-ConnectionGUID: E0G8VUu+ScmtbD+yobQJBA==
X-CSE-MsgGUID: f+7+FwxTRNGpCdfMPyoEhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="57585121"
Received: from ldmartin-desk2.corp.intel.com ([10.125.108.27])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 16:27:32 -0700
Message-ID: <fc0e8066b06abed97d3857c5deefb03041a0fd2e.camel@linux.intel.com>
Subject: Re: [PATCH v8 4/4] PCI/ASPM: Fix L1.2 parameters when enable link
 state
From: "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Jian-Hong Pan <jhp@endlessos.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>, Damien Le Moal
 <dlemoal@kernel.org>, Nirmal Patel <nirmal.patel@linux.intel.com>, Jonathan
 Derrick <jonathan.derrick@linux.dev>, Paul M Stillwell Jr
 <paul.m.stillwell.jr@intel.com>, linux-pci@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, linux@endlessos.org
Date: Wed, 07 Aug 2024 16:27:31 -0700
In-Reply-To: <eb900245-5e13-bc6c-994a-43f2db8322ea@linux.intel.com>
References: <20240719075200.10717-2-jhp@endlessos.org>
	 <20240719080255.10998-2-jhp@endlessos.org>
	 <CAPpJ_edybLMtrN_gxP2h9Z-BuYH+RG-qRqMqgZM1oSVoW1sP5A@mail.gmail.com>
	 <e37536a435630583398307682e1a9aadbabfb497.camel@linux.intel.com>
	 <CAPpJ_eeATLdcnH9CWpvJM_9juV5ok+OEYysTit_HparqBpQ3CQ@mail.gmail.com>
	 <eb900245-5e13-bc6c-994a-43f2db8322ea@linux.intel.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0-1build2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-07 at 14:18 +0300, Ilpo J=C3=A4rvinen wrote:
> On Wed, 7 Aug 2024, Jian-Hong Pan wrote:
>=20
> > David E. Box <david.e.box@linux.intel.com> =E6=96=BC 2024=E5=B9=B48=E6=
=9C=886=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=884:26=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > >=20
> > > Hi Jian-Hong,
> > >=20
> > > On Fri, 2024-08-02 at 16:24 +0800, Jian-Hong Pan wrote:
> > > > Jian-Hong Pan <jhp@endlessos.org> =E6=96=BC 2024=E5=B9=B47=E6=9C=88=
19=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884:04=E5=AF=AB=E9=81=93=EF=
=BC=9A
> > > > >=20
> > > > > Currently, when enable link's L1.2 features with
> > > > > __pci_enable_link_state(),
> > > > > it configs the link directly without ensuring related L1.2 parame=
ters,
> > > > > such
> > > > > as T_POWER_ON, Common_Mode_Restore_Time, and LTR_L1.2_THRESHOLD h=
ave
> > > > > been
> > > > > programmed.
> > > > >=20
> > > > > This leads the link's L1.2 between PCIe Root Port and child devic=
e
> > > > > gets
> > > > > wrong configs when a caller tries to enabled it.
> > > > >=20
> > > > > Here is a failed example on ASUS B1400CEAE with enabled VMD:
> > > > >=20
> > > > > 10000:e0:06.0 PCI bridge: Intel Corporation 11th Gen Core Process=
or
> > > > > PCIe
> > > > > Controller (rev 01) (prog-if 00 [Normal decode])
> > > > > =C2=A0=C2=A0=C2=A0 ...
> > > > > =C2=A0=C2=A0=C2=A0 Capabilities: [200 v1] L1 PM Substates
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L1SubCap: PCI-PM_L1.2+=
 PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> > > > > L1_PM_Substates+
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PortCommonModeRestoreTime=3D45us Po=
rtTPowerOnTime=3D50us
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L1SubCtl1: PCI-PM_L1.2=
- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 T_CommonMode=3D45us LTR1.2_Th=
reshold=3D101376ns
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L1SubCtl2: T_PwrOn=3D5=
0us
> > > > >=20
> > > > > 10000:e1:00.0 Non-Volatile memory controller: Sandisk Corp WD Blu=
e
> > > > > SN550
> > > > > NVMe SSD (rev 01) (prog-if 02 [NVM Express])
> > > > > =C2=A0=C2=A0=C2=A0 ...
> > > > > =C2=A0=C2=A0=C2=A0 Capabilities: [900 v1] L1 PM Substates
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L1SubCap: PCI-PM_L1.2+=
 PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > > > > L1_PM_Substates+
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PortCommonModeRestoreTime=3D32us Po=
rtTPowerOnTime=3D10us
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L1SubCtl1: PCI-PM_L1.2=
- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 T_CommonMode=3D0us LTR1.2_Thr=
eshold=3D0ns
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L1SubCtl2: T_PwrOn=3D1=
0us
> > > > >=20
> > > > > According to "PCIe r6.0, sec 5.5.4", before enabling ASPM L1.2 on=
 the
> > > > > PCIe
> > > > > Root Port and the child NVMe, they should be programmed with the =
same
> > > > > LTR1.2_Threshold value. However, they have different values in th=
is
> > > > > case.
> > > > >=20
> > > > > Invoke aspm_calc_l12_info() to program the L1.2 parameters proper=
ly
> > > > > before
> > > > > enable L1.2 bits of L1 PM Substates Control Register in
> > > > > __pci_enable_link_state().
> > > > >=20
> > > > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218394
> > > > > Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> > > > > ---
> > > > > v2:
> > > > > - Prepare the PCIe LTR parameters before enable L1 Substates
> > > > >=20
> > > > > v3:
> > > > > - Only enable supported features for the L1 Substates part
> > > > >=20
> > > > > v4:
> > > > > - Focus on fixing L1.2 parameters, instead of re-initializing who=
le
> > > > > L1SS
> > > > >=20
> > > > > v5:
> > > > > - Fix typo and commit message
> > > > > - Split introducing aspm_get_l1ss_cap() to "PCI/ASPM: Introduce
> > > > > =C2=A0 aspm_get_l1ss_cap()"
> > > > >=20
> > > > > v6:
> > > > > - Skipped
> > > > >=20
> > > > > v7:
> > > > > - Pick back and rebase on the new version kernel
> > > > > - Drop the link state flag check. And, always config link state's
> > > > > timing
> > > > > =C2=A0 parameters
> > > > >=20
> > > > > v8:
> > > > > - Because pcie_aspm_get_link() might return the link as NULL, mov=
e
> > > > > =C2=A0 getting the link's parent and child devices after check th=
e link is
> > > > > =C2=A0 not NULL. This avoids NULL memory access.
> > > > >=20
> > > > > =C2=A0drivers/pci/pcie/aspm.c | 15 +++++++++++++++
> > > > > =C2=A01 file changed, 15 insertions(+)
> > > > >=20
> > > > > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > > > > index 5db1044c9895..55ff1d26fcea 100644
> > > > > --- a/drivers/pci/pcie/aspm.c
> > > > > +++ b/drivers/pci/pcie/aspm.c
> > > > > @@ -1411,9 +1411,15 @@ EXPORT_SYMBOL(pci_disable_link_state);
> > > > > =C2=A0static int __pci_enable_link_state(struct pci_dev *pdev, in=
t state,
> > > > > bool
> > > > > locked)
> > > > > =C2=A0{
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pcie_link_state=
 *link =3D pcie_aspm_get_link(pdev);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 parent_l1ss_cap, child_=
l1ss_cap;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pci_dev *parent, *ch=
ild;
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!link)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
> > > > > +
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 parent =3D link->pdev;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 child =3D link->downstream;
> > > > > +
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * A driver reque=
sted that ASPM be enabled on this device, but
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * if we don't ha=
ve permission to manage ASPM (e.g., on ACPI
> > > > > @@ -1428,6 +1434,15 @@ static int __pci_enable_link_state(struct
> > > > > pci_dev
> > > > > *pdev, int state, bool locked)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!locked)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 down_read(&pci_bus_sem);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&aspm_lock)=
;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Ensure L1.2 paramet=
ers: Common_Mode_Restore_Times,
> > > > > T_POWER_ON and
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * LTR_L1.2_THRESHOLD =
are programmed properly before enable
> > > > > bits for
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * L1.2, per PCIe r6.0=
, sec 5.5.4.
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 parent_l1ss_cap =3D aspm_ge=
t_l1ss_cap(parent);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 child_l1ss_cap =3D aspm_get=
_l1ss_cap(child);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aspm_calc_l12_info(link, pa=
rent_l1ss_cap, child_l1ss_cap);
> > >=20
> > > I still don't think this is the place to recalculate the L1.2 paramet=
ers
> > > especially when know the calculation was done but was cleared by
> > > pci_bus_reset(). Can't we just do a pci_save/restore_state() before/a=
fter
> > > pci_bus_reset() in vmd.c?
> >=20
> > I have not thought pci_save/restore_state() around pci_bus_reset()
> > before.=C2=A0 It is an interesting direction.
> >=20
> > So, I prepare modification below for test.=C2=A0 Include "[PATCH v8 1/4=
]
> > PCI: vmd: Set PCI devices to D0 before enable PCI PM's L1 substates",
> > too.=C2=A0 Then, both the PCIe bridge and the PCIe device have the same
> > LTR_L1.2_THRESHOLD 101376ns as expected.
> >=20
> > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.=
c
> > index bbf4a47e7b31..6b8dd4f30127 100644
> > --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c
> > @@ -727,6 +727,18 @@ static void vmd_copy_host_bridge_flags(struct
> > pci_host_bridge *root_bridge,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vmd_bridge->native_dpc =3D r=
oot_bridge->native_dpc;
> > =C2=A0}
> >=20
> > +static int vmd_pci_save_state(struct pci_dev *pdev, void *userdata)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_save_state(pdev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > +}
> > +
> > +static int vmd_pci_restore_state(struct pci_dev *pdev, void *userdata)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_restore_state(pdev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > +}
> > +
> > =C2=A0/*
> > =C2=A0 * Enable ASPM and LTR settings on devices that aren't configured=
 by BIOS.
> > =C2=A0 */
> > @@ -927,6 +939,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd,
> > unsigned long features)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_scan_child_bus(vmd->bus)=
;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vmd_domain_reset(vmd);
> >=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_walk_bus(vmd->bus, vmd_pci_sa=
ve_state, NULL);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* When Intel VMD is enabled=
, the OS does not discover the Root
> > Ports
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * owned by Intel VMD w=
ithin the MMCFG space. pci_reset_bus()
> > applies
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * a reset to the paren=
t of the PCI device supplied as argument.
> > This
> > @@ -945,6 +958,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd,
> > unsigned long features)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break=
;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_walk_bus(vmd->bus, vmd_pci_re=
store_state, NULL);
>=20
> Why not call pci_reset_bus() (or __pci_reset_bus()) then in=20
> vmd_enable_domain() which preserves state unlike pci_reset_bus()?
>=20
> (Don't tell me naming of these functions is a horrible mess. :-/)
>=20

Hmm. So this *is* calling pci_reset_bus(). L1.2 configuration has specific
ordering requirements for changes to parent & child devices. Could be why i=
t's
not getting restored properly.

David

