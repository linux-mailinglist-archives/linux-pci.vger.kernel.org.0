Return-Path: <linux-pci+bounces-7049-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5668C8BB3C6
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 21:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00A4B281010
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 19:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1005154C19;
	Fri,  3 May 2024 19:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="enb1JtDr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A0157CBE;
	Fri,  3 May 2024 19:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714763752; cv=none; b=EHBc6osCnxlK2DpegCcF9C0tE7eNKqHF6ECNf+qQBtCMq7x5C4VuR14U7y88eTfj/vxIV0zBbYmX2k/XTXIs/8f+KsUWtDu645Sav5cAwNPriMNvhsOE2vYF99eR7G1ejlXLQNa86CXixYlahuouuXr+bZrw1DsGrg5TjxWsfDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714763752; c=relaxed/simple;
	bh=Kq0M35849WHIrXka8iBDrQj42o6265+q1sdkdJ0TUic=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H1nDxuZuV/OWgWh/PPSmrTLYszyL81DR3kGk5KLD2HO9YCqmgBKss0Ab60fZGeIUP1hvrprT/pFbNlng87faY7I6n4VAWucSw0wOZkdbXUgwCP77ahBSgk1CAvC7+s19RFdroZ2cI2J8LzCwTpBqM3VuyAonxp82x0vqN2J+hTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=enb1JtDr; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714763751; x=1746299751;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Kq0M35849WHIrXka8iBDrQj42o6265+q1sdkdJ0TUic=;
  b=enb1JtDrAKKmdZsJoHjQI2Kn0b2WQRUi/APlxd9ex+nWInnMWckhYuc3
   NsVv0Da2byC2vGDWupwaRb1pXhsoBkQYe29yT7ASFt3XoJljxb9CBCntO
   xrlifBWct4Y6aO1jEqdpO2B9fGys87mOODMDpUehvy8nfCaaIjHhTX5eP
   5AfRnrg8SEsM60c6bxmplVneMnG8klaMpfu2knQjLQpcC9LoCVYUnOaWe
   IH9mTqW2QCdDc5V5n1uPcksdt9glkZ2QLEtwHvi6TsUNC8OBSr3/ShZvD
   ttey5cZ5k0kmY0Y3CxySrQ1hTCOOEOIj+7ap8AZzBCHOzPsaABs6s+mSk
   w==;
X-CSE-ConnectionGUID: mx6lWhN7TjGUXVGMv20fOg==
X-CSE-MsgGUID: Duy0XwYYTEa8FPucG8pNZw==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="14370855"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="14370855"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 12:15:50 -0700
X-CSE-ConnectionGUID: zmOj6CXuT/SgrIzNLCYBzw==
X-CSE-MsgGUID: bQHzKLdPSd+c0ABLEs63Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="27417521"
Received: from leiwei-mobl.amr.corp.intel.com ([10.212.224.247])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 12:15:49 -0700
Message-ID: <876d19b7702dc16010b56bce049e2ab60bf68e3b.camel@linux.intel.com>
Subject: Re: [PATCH v5 4/4] PCI/ASPM: Fix L1.2 parameters when enable link
 state
From: "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To: Jian-Hong Pan <jhp@endlessos.org>, Nirmal Patel
	 <nirmal.patel@linux.intel.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>, Mika Westerberg
 <mika.westerberg@linux.intel.com>, Damien Le Moal <dlemoal@kernel.org>, 
 Jonathan Derrick <jonathan.derrick@linux.dev>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 03 May 2024 12:15:49 -0700
In-Reply-To: <CAPpJ_efYWWxGBopbSQHB=Y2+1RrXFR2XWeqEhGTgdiw3XX0Jmw@mail.gmail.com>
References: <20240424110223.21799-2-jhp@endlessos.org>
	 <f111371300624b6f94f0746dbae66bd49f405eea.camel@linux.intel.com>
	 <CAPpJ_ecOah=gYfYJVX-TypRiK8+oons3rKOVOATb4epm6sGZaw@mail.gmail.com>
	 <af74b8d4f1f7072ffebc8a7f5cf392140da73dc7.camel@linux.intel.com>
	 <CAPpJ_efYWWxGBopbSQHB=Y2+1RrXFR2XWeqEhGTgdiw3XX0Jmw@mail.gmail.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

+Nirmal,

Thanks Jian-Hong. This is a good find.

On Fri, 2024-05-03 at 17:45 +0800, Jian-Hong Pan wrote:
> David E. Box <david.e.box@linux.intel.com> =E6=96=BC 2024=E5=B9=B45=E6=9C=
=881=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=882:26=E5=AF=AB=E9=81=93=
=EF=BC=9A
> >=20
> > On Tue, 2024-04-30 at 15:46 +0800, Jian-Hong Pan wrote:
> > > David E. Box <david.e.box@linux.intel.com> =E6=96=BC 2024=E5=B9=B44=
=E6=9C=8827=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=888:03=E5=AF=AB=E9=
=81=93=EF=BC=9A
> > > >=20
> > > > Hi Jian-Hong,
> > > >=20
> > > > On Wed, 2024-04-24 at 19:02 +0800, Jian-Hong Pan wrote:
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
> > > > > NVMe
> > > > > SSD (rev 01) (prog-if 02 [NVM Express])
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
> > > > > =C2=A0drivers/pci/pcie/aspm.c | 12 ++++++++++++
> > > > > =C2=A01 file changed, 12 insertions(+)
> > > > >=20
> > > > > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > > > > index c55ac11faa73..553327dee991 100644
> > > > > --- a/drivers/pci/pcie/aspm.c
> > > > > +++ b/drivers/pci/pcie/aspm.c
> > > > > @@ -1402,6 +1402,8 @@ EXPORT_SYMBOL(pci_disable_link_state);
> > > > > =C2=A0static int __pci_enable_link_state(struct pci_dev *pdev, in=
t state,
> > > > > bool
> > > > > locked)
> > > > > =C2=A0{
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pcie_link_state=
 *link =3D pcie_aspm_get_link(pdev);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pci_dev *child =3D l=
ink->downstream, *parent =3D link-
> > > > > >pdev;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 parent_l1ss_cap, child_=
l1ss_cap;
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!link)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
> > > > > @@ -1433,6 +1435,16 @@ static int __pci_enable_link_state(struct
> > > > > pci_dev
> > > > > *pdev, int state, bool locked)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 link->aspm_default |=3D ASPM_STATE_L1_1_PCIPM |
> > > > > ASPM_STATE_L1;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (state & PCIE_LINK_=
STATE_L1_2_PCIPM)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 link->aspm_default |=3D ASPM_STATE_L1_2_PCIPM |
> > > > > ASPM_STATE_L1;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Ensure L1.2 paramet=
ers: Common_Mode_Restore_Times,
> > > > > T_POWER_ON
> > > > > and
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * LTR_L1.2_THRESHOLD =
are programmed properly before enable
> > > > > bits
> > > > > for
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * L1.2, per PCIe r6.0=
, sec 5.5.4.
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (state & link->aspm_capa=
ble & ASPM_STATE_L1_2_MASK) {
> > > >=20
> > > > This is still mixing PCIE_LINK_STATE flags with ASPM_STATE flags.
> > >=20
> > > Thanks for your review, but I notice some description in PCIe spec,
> > > 5.5.4 L1 PM Substates Configuration:
> > > "Prior to setting either or both of the enable bits for L1.2, the
> > > values for TPOWER_ON, Common_Mode_Restore_Time, and, if the ASPM L1.2
> > > Enable bit is to be Set, the LTR_L1.2_THRESHOLD (both Value and Scale
> > > fields) must be programmed." =3D> I think this includes both "ASPM L1=
.2
> > > Enable" and "PCI-PM L1.2 Enable" bits.
> >=20
> > That's fine. While the spec clearly calls out the ASPM L1.2 Enable bit =
here,
> > I
> > see no harm in including PCI-PM L1.2 in that check. This is what the co=
de
> > already does in aspm_l1ss_init().
> >=20
> > The issue is the mixed used of two different types of flags that don't =
have
> > the
> > same meaning. 'state' contains PCIE_LINK_STATE flags which are part of =
the
> > caller API to the pci_<enabled/disable>_link_state() functions. The
> > ASPM_STATE
> > flags are used internally to aspm.c to track all states and their meani=
ngful
> > combinations such as ASPM_STATE_L1_2_MASK which includes ASPM L1.2 and =
PCI-
> > PM
> > L1.2. You should not do bit operations between them.
> >=20
> > Also, you should not require that the timings be calculated only if L1_=
2 is
> > enabled. You should calculate the timings as long as it's capable. This=
 is
> > also
> > what aspm_l1ss_init() does.
> >=20
> > The confusion might be over the fact that you are having
> > __pci_enable_link_state() call aspm_calc_l12_info(). This should have b=
een
> > handled during initialization of the link in aspm_l1ss_init() and I'm n=
ot
> > sure
> > why it didn't. Maybe it's because, for VMD, ASPM default state would ha=
ve
> > started out all disabled and this somehow led to aspm_l1ss_init() not
> > getting
> > called. But looking through the code I don't see it. It would be great =
if
> > you
> > can confirm why they weren't calculated before.
>=20
> I debug it again.=C2=A0 If I delete the pci_reset_bus() in vmd controller=
 like:
>=20
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 87b7856f375a..39bfda4350bf 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -930,25 +930,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd,
> unsigned long features)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_scan_child_bus(vmd->bus);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vmd_domain_reset(vmd);
>=20
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* When Intel VMD is enabled, the O=
S does not discover the Root Ports
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * owned by Intel VMD within t=
he MMCFG space. pci_reset_bus() applies
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * a reset to the parent of th=
e PCI device supplied as argument. This
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * is why we pass a child devi=
ce, so the reset can be triggered at
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the Intel bridge level and =
propagated to all the children in the
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * hierarchy.
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_for_each_entry(child, &vmd->bu=
s->children, node) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if (!list_empty(&child->devices)) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev =3D list_f=
irst_entry(&child->devices,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pci_dev, bus_list);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D pci_re=
set_bus(dev);

Hi Nirmal. It's not clear to me from the comment why there's a need to do a=
 bus
reset. It looks like it is causing misconfiguration of the ASPM L1.2 timing=
s
which would have been done above in pci_scan_child_bus(). Jian-Hong discove=
red
that without the above reset code, the timings are correct.

This patch recalculates the timings during the call to pci_enable_link_stat=
e()
which is called during pci_bus_walk() below. Originally I thought the
recalculation might have been needed by all callers to pci_enabled_link_sta=
te()
since it changes the default BIOS configuration. But it looks like the rese=
t is
the cause and only the VMD driver would need the recalculation as a result.=
 I
don't see qcom doing a reset.

Jian-Hong, given this (and assuming the reset is needed) I would not call
aspm_calc_l12_info() from pci_enable_link_state() but instead try redoing t=
he
whole ASPM initialization right after the resets are done, maybe by calling
pci_scan_child_bus() again. What do you think Bjorn?

David

> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_warn(dev, "can't reset device: %d\n",
> ret);
> -
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 }
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> -
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_assign_unassigned_bus_reso=
urces(vmd->bus);
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_walk_bus(vmd->bus, vmd_pm_=
enable_quirk, &features);
>=20
> Although PCI-PM_L1.2 is disabled, both PCI bridge and the NVMe's
> LTR1.2_Threshold are configured as 101376ns:
>=20
> 10000:e0:06.0 PCI bridge [0604]: Intel Corporation 11th Gen Core
> Processor PCIe Controller [8086:9a09] (rev 01) (prog-if 00 [Normal
> decode])
> ...
> =C2=A0 Capabilities: [200 v1] L1 PM Substates
> =C2=A0 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Su=
bstates+
> =C2=A0=C2=A0=C2=A0 PortCommonModeRestoreTime=3D45us PortTPowerOnTime=3D50=
us
> =C2=A0 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> =C2=A0=C2=A0=C2=A0=C2=A0 T_CommonMode=3D45us LTR1.2_Threshold=3D101376ns
> =C2=A0 L1SubCtl2: T_PwrOn=3D50us
>=20
> 10000:e1:00.0 Non-Volatile memory controller [0108]: Sandisk Corp WD
> Blue SN550 NVMe SSD [15b7:5009] (rev 01) (prog-if 02 [NVM Express])
> ...
> =C2=A0 Capabilities: [900 v1] L1 PM Substates
> =C2=A0 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Su=
bstates+
> =C2=A0=C2=A0=C2=A0 PortCommonModeRestoreTime=3D32us PortTPowerOnTime=3D10=
us
> =C2=A0 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> =C2=A0=C2=A0=C2=A0=C2=A0 T_CommonMode=3D0us LTR1.2_Threshold=3D101376ns
> =C2=A0 L1SubCtl2: T_PwrOn=3D50us
>=20
> Then, I apply the patch "PCI: vmd: Set PCI devices to D0 before enable
> PCI PM's L1 substates".=C2=A0 Both PCI bridge and the NVMe's PCI-PM_L1.2 =
is
> enabled and LTR1.2_Threshold is configured as 101376ns.
>=20
> 10000:e0:06.0 PCI bridge [0604]: Intel Corporation 11th Gen Core
> Processor PCIe Controller [8086:9a09] (rev 01) (prog-if 00 [Normal
> decode])
> ...
> =C2=A0 Capabilities: [200 v1] L1 PM Substates
> =C2=A0 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Su=
bstates+
> =C2=A0=C2=A0=C2=A0 PortCommonModeRestoreTime=3D45us PortTPowerOnTime=3D50=
us
> =C2=A0 L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> =C2=A0=C2=A0=C2=A0=C2=A0 T_CommonMode=3D45us LTR1.2_Threshold=3D101376ns
> =C2=A0 L1SubCtl2: T_PwrOn=3D50us
>=20
> 10000:e1:00.0 Non-Volatile memory controller [0108]: Sandisk Corp WD
> Blue SN550 NVMe SSD [15b7:5009] (rev 01) (prog-if 02 [NVM Express])
> ...
> =C2=A0 Capabilities: [900 v1] L1 PM Substates
> =C2=A0 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Su=
bstates+
> =C2=A0=C2=A0=C2=A0 PortCommonModeRestoreTime=3D32us PortTPowerOnTime=3D10=
us
> =C2=A0 L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> =C2=A0=C2=A0=C2=A0=C2=A0 T_CommonMode=3D0us LTR1.2_Threshold=3D101376ns
> =C2=A0 L1SubCtl2: T_PwrOn=3D50us
>=20
> I do not know VMD very much.=C2=A0 However, from the test result, it look=
s
> like LTR1.2_Threshold has been configured properly originally.=C2=A0 But,
> LTR1.2_Threshold is misconfigured by 'pci_reset_bus()'.
>=20
> Jian-Hong Pan
>=20
>=20
>=20
> > >=20
> > > Jain-Hong Pan
> > >=20
> > > > 'state' should not even matter.
> > > > The timings should always be calculated and programmed as long
> > > > as L1_2 is capable. That way the timings are ready even if L1_2 isn=
't
> > > > being
> > > > enabled now (in case the user enables it later).
> > > >=20
> > > > David
> > > >=20
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 parent_l1ss_cap =3D aspm_get_l1ss_cap(parent);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 child_l1ss_cap =3D aspm_get_l1ss_cap(child);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 aspm_calc_l12_info(link, parent_l1ss_cap,
> > > > > child_l1ss_cap);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcie_config_aspm_link(=
link, policy_to_aspm_state(link));
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 link->clkpm_default =
=3D (state & PCIE_LINK_STATE_CLKPM) ? 1 : 0;
> > > >=20
> >=20


