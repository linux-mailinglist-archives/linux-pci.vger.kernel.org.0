Return-Path: <linux-pci+bounces-6902-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E7B8B7FA7
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 20:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB6581C2361A
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 18:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2577518132F;
	Tue, 30 Apr 2024 18:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l/1ARkfa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAFE180A65;
	Tue, 30 Apr 2024 18:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714501609; cv=none; b=T+n1a1GVvu0klJ356eMduInehHbiy7CgZ9KEFguoUxXdWqj4osJY+HXLWNRsSbQuG3JI0X0QOFYc2c+4EQUVfGWhl5zLPCzzmM3fjuwGXLFOMQ65i5i1UT34VR7cUg3nIeawQsh0/fzy7hC2IxAZrUTMo5HZrr3erJscd1gsjUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714501609; c=relaxed/simple;
	bh=q6GSO0vShRvzB0fJQFwWUZC3SEy36XnWlE2lgKvUMOI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l3hNg67ds1MhrMlWGjrYwhTFSb6HKESUS2ZTSeRtwqu9ZXi16GMGMwREEmrLPJqqb8Q46P6muQJIBHfZA5YZWI/pbYJ4eY1DlBdjT7sJFatQZSllJ7mGrN8bmcA2KzRNSqoHkySHj8WDuscqeH5xLw38GHmCLP9uXWA9UMmo6J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l/1ARkfa; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714501607; x=1746037607;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=q6GSO0vShRvzB0fJQFwWUZC3SEy36XnWlE2lgKvUMOI=;
  b=l/1ARkfac6Jt67bP/5TYe//BdQsoj29tBtjsjTLkudS704PHp5/T4sDo
   UFlm+4DB0JDniMucV1BHJpJ5I58QQz1oyEncxi8OwXdcdhEqN3Zzu6gEL
   i+P9LibGVrcpeLiyuofCxDvRgtEsPqzxaFKsP0VrMJQFIuDD+0pWliydd
   rcPC9+5lBSU1DctCa2YucUgbk8KlSA8JIclQG8xG2+KliL10+kk8YTGzQ
   AVbRXI6O0xd+71+/Camn7wkXLCc43XpJDL33xpJajvJED/4JxMD8ix75/
   2Acrg1MFscd1IGT5YXzM/kfnmohV7tSTVBguWMNJDWrP3BaNteEX8ExUx
   A==;
X-CSE-ConnectionGUID: 9jL/dwm9TvKohmSwhEdZVg==
X-CSE-MsgGUID: lcJ6d/eOSQiNp9ErExh5wQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10399388"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10399388"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 11:26:46 -0700
X-CSE-ConnectionGUID: CB56jFGiQqaNSbfdW3guLA==
X-CSE-MsgGUID: BxU+BYfJTQ6TWewJCU8Ecw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26556260"
Received: from jdwelch-mobl.amr.corp.intel.com ([10.209.113.84])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 11:26:47 -0700
Message-ID: <af74b8d4f1f7072ffebc8a7f5cf392140da73dc7.camel@linux.intel.com>
Subject: Re: [PATCH v5 4/4] PCI/ASPM: Fix L1.2 parameters when enable link
 state
From: "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To: Jian-Hong Pan <jhp@endlessos.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>, Damien Le Moal
 <dlemoal@kernel.org>,  Nirmal Patel <nirmal.patel@linux.intel.com>,
 Jonathan Derrick <jonathan.derrick@linux.dev>,  linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 30 Apr 2024 11:26:46 -0700
In-Reply-To: <CAPpJ_ecOah=gYfYJVX-TypRiK8+oons3rKOVOATb4epm6sGZaw@mail.gmail.com>
References: <20240424110223.21799-2-jhp@endlessos.org>
	 <f111371300624b6f94f0746dbae66bd49f405eea.camel@linux.intel.com>
	 <CAPpJ_ecOah=gYfYJVX-TypRiK8+oons3rKOVOATb4epm6sGZaw@mail.gmail.com>
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

On Tue, 2024-04-30 at 15:46 +0800, Jian-Hong Pan wrote:
> David E. Box <david.e.box@linux.intel.com> =E6=96=BC 2024=E5=B9=B44=E6=9C=
=8827=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=888:03=E5=AF=AB=E9=81=93=
=EF=BC=9A
> >=20
> > Hi Jian-Hong,
> >=20
> > On Wed, 2024-04-24 at 19:02 +0800, Jian-Hong Pan wrote:
> > > Currently, when enable link's L1.2 features with
> > > __pci_enable_link_state(),
> > > it configs the link directly without ensuring related L1.2 parameters=
,
> > > such
> > > as T_POWER_ON, Common_Mode_Restore_Time, and LTR_L1.2_THRESHOLD have =
been
> > > programmed.
> > >=20
> > > This leads the link's L1.2 between PCIe Root Port and child device ge=
ts
> > > wrong configs when a caller tries to enabled it.
> > >=20
> > > Here is a failed example on ASUS B1400CEAE with enabled VMD:
> > >=20
> > > 10000:e0:06.0 PCI bridge: Intel Corporation 11th Gen Core Processor P=
CIe
> > > Controller (rev 01) (prog-if 00 [Normal decode])
> > > =C2=A0=C2=A0=C2=A0 ...
> > > =C2=A0=C2=A0=C2=A0 Capabilities: [200 v1] L1 PM Substates
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L1SubCap: PCI-PM_L1.2+ PCI=
-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> > > L1_PM_Substates+
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PortCommonModeRestoreTime=3D45us PortTPow=
erOnTime=3D50us
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L1SubCtl1: PCI-PM_L1.2- PC=
I-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 T_CommonMode=3D45us LTR1.2_Threshol=
d=3D101376ns
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L1SubCtl2: T_PwrOn=3D50us
> > >=20
> > > 10000:e1:00.0 Non-Volatile memory controller: Sandisk Corp WD Blue SN=
550
> > > NVMe
> > > SSD (rev 01) (prog-if 02 [NVM Express])
> > > =C2=A0=C2=A0=C2=A0 ...
> > > =C2=A0=C2=A0=C2=A0 Capabilities: [900 v1] L1 PM Substates
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L1SubCap: PCI-PM_L1.2+ PCI=
-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > > L1_PM_Substates+
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PortCommonModeRestoreTime=3D32us PortTPow=
erOnTime=3D10us
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L1SubCtl1: PCI-PM_L1.2- PC=
I-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 T_CommonMode=3D0us LTR1.2_Threshold=
=3D0ns
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L1SubCtl2: T_PwrOn=3D10us
> > >=20
> > > According to "PCIe r6.0, sec 5.5.4", before enabling ASPM L1.2 on the=
 PCIe
> > > Root Port and the child NVMe, they should be programmed with the same
> > > LTR1.2_Threshold value. However, they have different values in this c=
ase.
> > >=20
> > > Invoke aspm_calc_l12_info() to program the L1.2 parameters properly b=
efore
> > > enable L1.2 bits of L1 PM Substates Control Register in
> > > __pci_enable_link_state().
> > >=20
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218394
> > > Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> > > ---
> > > v2:
> > > - Prepare the PCIe LTR parameters before enable L1 Substates
> > >=20
> > > v3:
> > > - Only enable supported features for the L1 Substates part
> > >=20
> > > v4:
> > > - Focus on fixing L1.2 parameters, instead of re-initializing whole L=
1SS
> > >=20
> > > v5:
> > > - Fix typo and commit message
> > > - Split introducing aspm_get_l1ss_cap() to "PCI/ASPM: Introduce
> > > =C2=A0 aspm_get_l1ss_cap()"
> > >=20
> > > =C2=A0drivers/pci/pcie/aspm.c | 12 ++++++++++++
> > > =C2=A01 file changed, 12 insertions(+)
> > >=20
> > > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > > index c55ac11faa73..553327dee991 100644
> > > --- a/drivers/pci/pcie/aspm.c
> > > +++ b/drivers/pci/pcie/aspm.c
> > > @@ -1402,6 +1402,8 @@ EXPORT_SYMBOL(pci_disable_link_state);
> > > =C2=A0static int __pci_enable_link_state(struct pci_dev *pdev, int st=
ate, bool
> > > locked)
> > > =C2=A0{
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pcie_link_state *li=
nk =3D pcie_aspm_get_link(pdev);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pci_dev *child =3D link-=
>downstream, *parent =3D link->pdev;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 parent_l1ss_cap, child_l1ss=
_cap;
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!link)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
> > > @@ -1433,6 +1435,16 @@ static int __pci_enable_link_state(struct pci_=
dev
> > > *pdev, int state, bool locked)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 link->aspm_default |=3D ASPM_STATE_L1_1_PCIPM |
> > > ASPM_STATE_L1;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (state & PCIE_LINK_STAT=
E_L1_2_PCIPM)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 link->aspm_default |=3D ASPM_STATE_L1_2_PCIPM |
> > > ASPM_STATE_L1;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Ensure L1.2 parameters:=
 Common_Mode_Restore_Times, T_POWER_ON
> > > and
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * LTR_L1.2_THRESHOLD are =
programmed properly before enable bits
> > > for
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * L1.2, per PCIe r6.0, se=
c 5.5.4.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (state & link->aspm_capable =
& ASPM_STATE_L1_2_MASK) {
> >=20
> > This is still mixing PCIE_LINK_STATE flags with ASPM_STATE flags.
>=20
> Thanks for your review, but I notice some description in PCIe spec,
> 5.5.4 L1 PM Substates Configuration:
> "Prior to setting either or both of the enable bits for L1.2, the
> values for TPOWER_ON, Common_Mode_Restore_Time, and, if the ASPM L1.2
> Enable bit is to be Set, the LTR_L1.2_THRESHOLD (both Value and Scale
> fields) must be programmed." =3D> I think this includes both "ASPM L1.2
> Enable" and "PCI-PM L1.2 Enable" bits.

That's fine. While the spec clearly calls out the ASPM L1.2 Enable bit here=
, I
see no harm in including PCI-PM L1.2 in that check. This is what the code
already does in aspm_l1ss_init().

The issue is the mixed used of two different types of flags that don't have=
 the
same meaning. 'state' contains PCIE_LINK_STATE flags which are part of the
caller API to the pci_<enabled/disable>_link_state() functions. The ASPM_ST=
ATE
flags are used internally to aspm.c to track all states and their meaningfu=
l
combinations such as ASPM_STATE_L1_2_MASK which includes ASPM L1.2 and PCI-=
PM
L1.2. You should not do bit operations between them.

Also, you should not require that the timings be calculated only if L1_2 is
enabled. You should calculate the timings as long as it's capable. This is =
also
what aspm_l1ss_init() does.

The confusion might be over the fact that you are having
__pci_enable_link_state() call aspm_calc_l12_info(). This should have been
handled during initialization of the link in aspm_l1ss_init() and I'm not s=
ure
why it didn't. Maybe it's because, for VMD, ASPM default state would have
started out all disabled and this somehow led to aspm_l1ss_init() not getti=
ng
called. But looking through the code I don't see it. It would be great if y=
ou
can confirm why they weren't calculated before.

David

>=20
> Jain-Hong Pan
>=20
> > 'state' should not even matter.
> > The timings should always be calculated and programmed as long
> > as L1_2 is capable. That way the timings are ready even if L1_2 isn't b=
eing
> > enabled now (in case the user enables it later).
> >=20
> > David
> >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 parent_l1ss_cap =3D aspm_get_l1ss_cap(parent);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 child_l1ss_cap =3D aspm_get_l1ss_cap(child);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 aspm_calc_l12_info(link, parent_l1ss_cap, child_l1ss_cap=
);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcie_config_aspm_link(link=
, policy_to_aspm_state(link));
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 link->clkpm_default =3D (s=
tate & PCIE_LINK_STATE_CLKPM) ? 1 : 0;
> >=20


