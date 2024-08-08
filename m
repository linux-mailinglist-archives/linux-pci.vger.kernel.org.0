Return-Path: <linux-pci+bounces-11479-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E02794BA14
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 11:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 906761C21D47
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 09:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB9A148832;
	Thu,  8 Aug 2024 09:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TOQ1+6RS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55031148FEC;
	Thu,  8 Aug 2024 09:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723110552; cv=none; b=ZzD2MU1uxuFLooJePPN1Xmr+SwT6fT8klsRlCXUyYgCD+Ts1QrIJBoXwo4N/O8aWQg5B0McRBB6zimr3pWbiyTzP+5uq6vimL4YM5qavxnWwfoJHraxdpBR3n87efn0pFAfWsKr+YLxmhaxIoyFegoBTILim7N6LglkvJ/I8TAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723110552; c=relaxed/simple;
	bh=kGtjpZg3iL+8ogvI6HrYSfWKzI7+g9yg3iYTBkdlMG4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZLtxPrswV8+pOF+DEqAwUQZpagB+L/9LlQAF+BmPMMEI/ryD6PedcQdtPByFQy+TtJi+OubmSRhY/LHtfrnpgI177hZoUs8n8wi4mcn5v4Zmh3uV8RNXGQ/iUW+1eUC1X0tIZ7GNDxpbgXWogldYmVS2nSb76IgGooLZ/fG7vNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TOQ1+6RS; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723110550; x=1754646550;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=kGtjpZg3iL+8ogvI6HrYSfWKzI7+g9yg3iYTBkdlMG4=;
  b=TOQ1+6RS5ijAdWfz0KVLi1m3DC8qBJ2l93fy7Bnck5lS9odRvDtXjrxE
   37LrI1yO7SIzUqOLa4KfaiQhsUT/zqZaBzAPBD3W6dmfDbanBOAlnJHOS
   1Fk4ooQxff7aWwZQdkSCnfv5jXXoMWSxBB6y/ng+bkby89OX3R4RFB4qg
   vVC9It8uQA1GnvFz6fzRF/CzEmIzdjtJf2HBx5qfpwbdIc1csG3iQehaV
   Ro/C9brlm3cycnuD4Bls+S2hZMylZspXRw7UMhqEdItgWo7Kx8YVUgnY6
   82iDdlsfy2lTA0BOaCyP2qlO0Kmm41H7HoYz56e/1UKxkgCEuwaLhPsJ9
   w==;
X-CSE-ConnectionGUID: A6bEPxtjRGG462W6yPf/ag==
X-CSE-MsgGUID: sLHhJOMjSUuUT0cdHpwQnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="21036605"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="21036605"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 02:49:09 -0700
X-CSE-ConnectionGUID: T5M0+7qBSJCsibhsZNuOsw==
X-CSE-MsgGUID: LvZ3CFTNQi+Sreg6KR1rxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="57257579"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.125.108.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 02:49:04 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 8 Aug 2024 12:48:59 +0300 (EEST)
To: "David E. Box" <david.e.box@linux.intel.com>
cc: Jian-Hong Pan <jhp@endlessos.org>, Bjorn Helgaas <helgaas@kernel.org>, 
    Johan Hovold <johan@kernel.org>, 
    Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    Damien Le Moal <dlemoal@kernel.org>, 
    Nirmal Patel <nirmal.patel@linux.intel.com>, 
    Jonathan Derrick <jonathan.derrick@linux.dev>, 
    Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux@endlessos.org
Subject: Re: [PATCH v8 4/4] PCI/ASPM: Fix L1.2 parameters when enable link
 state
In-Reply-To: <fc0e8066b06abed97d3857c5deefb03041a0fd2e.camel@linux.intel.com>
Message-ID: <f9660f21-f2e8-c62c-5e86-ed4875f61701@linux.intel.com>
References: <20240719075200.10717-2-jhp@endlessos.org>  <20240719080255.10998-2-jhp@endlessos.org>  <CAPpJ_edybLMtrN_gxP2h9Z-BuYH+RG-qRqMqgZM1oSVoW1sP5A@mail.gmail.com>  <e37536a435630583398307682e1a9aadbabfb497.camel@linux.intel.com> 
 <CAPpJ_eeATLdcnH9CWpvJM_9juV5ok+OEYysTit_HparqBpQ3CQ@mail.gmail.com>  <eb900245-5e13-bc6c-994a-43f2db8322ea@linux.intel.com> <fc0e8066b06abed97d3857c5deefb03041a0fd2e.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1062509429-1723109545=:1044"
Content-ID: <2fe17f17-a8ac-762e-99be-a38fd5a41481@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1062509429-1723109545=:1044
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <1a4fa72b-9bd7-5863-65fb-2a8c1bea1a4a@linux.intel.com>

On Wed, 7 Aug 2024, David E. Box wrote:

> On Wed, 2024-08-07 at 14:18 +0300, Ilpo J=C3=A4rvinen wrote:
> > On Wed, 7 Aug 2024, Jian-Hong Pan wrote:
> >=20
> > > David E. Box <david.e.box@linux.intel.com> =E6=96=BC 2024=E5=B9=B48=
=E6=9C=886=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=884:26=E5=AF=AB=E9=
=81=93=EF=BC=9A
> > > >=20
> > > > Hi Jian-Hong,
> > > >=20
> > > > On Fri, 2024-08-02 at 16:24 +0800, Jian-Hong Pan wrote:
> > > > > Jian-Hong Pan <jhp@endlessos.org> =E6=96=BC 2024=E5=B9=B47=E6=9C=
=8819=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884:04=E5=AF=AB=E9=81=93=
=EF=BC=9A
> > > > > >=20
> > > > > > Currently, when enable link's L1.2 features with
> > > > > > __pci_enable_link_state(),
> > > > > > it configs the link directly without ensuring related L1.2 para=
meters,
> > > > > > such
> > > > > > as T_POWER_ON, Common_Mode_Restore_Time, and LTR_L1.2_THRESHOLD=
 have
> > > > > > been
> > > > > > programmed.
> > > > > >=20
> > > > > > This leads the link's L1.2 between PCIe Root Port and child dev=
ice
> > > > > > gets
> > > > > > wrong configs when a caller tries to enabled it.
> > > > > >=20
> > > > > > Here is a failed example on ASUS B1400CEAE with enabled VMD:
> > > > > >=20
> > > > > > 10000:e0:06.0 PCI bridge: Intel Corporation 11th Gen Core Proce=
ssor
> > > > > > PCIe
> > > > > > Controller (rev 01) (prog-if 00 [Normal decode])
> > > > > > =C2=A0=C2=A0=C2=A0 ...
> > > > > > =C2=A0=C2=A0=C2=A0 Capabilities: [200 v1] L1 PM Substates
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L1SubCap: PCI-PM_L1.=
2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> > > > > > L1_PM_Substates+
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PortCommonModeRestoreTime=3D45us Po=
rtTPowerOnTime=3D50us
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L1SubCtl1: PCI-PM_L1=
=2E2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 T_CommonMode=3D45us LTR1.2_Th=
reshold=3D101376ns
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L1SubCtl2: T_PwrOn=
=3D50us
> > > > > >=20
> > > > > > 10000:e1:00.0 Non-Volatile memory controller: Sandisk Corp WD B=
lue
> > > > > > SN550
> > > > > > NVMe SSD (rev 01) (prog-if 02 [NVM Express])
> > > > > > =C2=A0=C2=A0=C2=A0 ...
> > > > > > =C2=A0=C2=A0=C2=A0 Capabilities: [900 v1] L1 PM Substates
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L1SubCap: PCI-PM_L1.=
2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > > > > > L1_PM_Substates+
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PortCommonModeRestoreTime=3D32us Po=
rtTPowerOnTime=3D10us
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L1SubCtl1: PCI-PM_L1=
=2E2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 T_CommonMode=3D0us LTR1.2_Thr=
eshold=3D0ns
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L1SubCtl2: T_PwrOn=
=3D10us
> > > > > >=20
> > > > > > According to "PCIe r6.0, sec 5.5.4", before enabling ASPM L1.2 =
on the
> > > > > > PCIe
> > > > > > Root Port and the child NVMe, they should be programmed with th=
e same
> > > > > > LTR1.2_Threshold value. However, they have different values in =
this
> > > > > > case.
> > > > > >=20
> > > > > > Invoke aspm_calc_l12_info() to program the L1.2 parameters prop=
erly
> > > > > > before
> > > > > > enable L1.2 bits of L1 PM Substates Control Register in
> > > > > > __pci_enable_link_state().
> > > > > >=20
> > > > > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218394
> > > > > > Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> > > > > > ---
> > > > > > v2:
> > > > > > - Prepare the PCIe LTR parameters before enable L1 Substates
> > > > > >=20
> > > > > > v3:
> > > > > > - Only enable supported features for the L1 Substates part
> > > > > >=20
> > > > > > v4:
> > > > > > - Focus on fixing L1.2 parameters, instead of re-initializing w=
hole
> > > > > > L1SS
> > > > > >=20
> > > > > > v5:
> > > > > > - Fix typo and commit message
> > > > > > - Split introducing aspm_get_l1ss_cap() to "PCI/ASPM: Introduce
> > > > > > =C2=A0 aspm_get_l1ss_cap()"
> > > > > >=20
> > > > > > v6:
> > > > > > - Skipped
> > > > > >=20
> > > > > > v7:
> > > > > > - Pick back and rebase on the new version kernel
> > > > > > - Drop the link state flag check. And, always config link state=
's
> > > > > > timing
> > > > > > =C2=A0 parameters
> > > > > >=20
> > > > > > v8:
> > > > > > - Because pcie_aspm_get_link() might return the link as NULL, m=
ove
> > > > > > =C2=A0 getting the link's parent and child devices after check =
the link is
> > > > > > =C2=A0 not NULL. This avoids NULL memory access.
> > > > > >=20
> > > > > > =C2=A0drivers/pci/pcie/aspm.c | 15 +++++++++++++++
> > > > > > =C2=A01 file changed, 15 insertions(+)
> > > > > >=20
> > > > > > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > > > > > index 5db1044c9895..55ff1d26fcea 100644
> > > > > > --- a/drivers/pci/pcie/aspm.c
> > > > > > +++ b/drivers/pci/pcie/aspm.c
> > > > > > @@ -1411,9 +1411,15 @@ EXPORT_SYMBOL(pci_disable_link_state);
> > > > > > =C2=A0static int __pci_enable_link_state(struct pci_dev *pdev, =
int state,
> > > > > > bool
> > > > > > locked)
> > > > > > =C2=A0{
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pcie_link_sta=
te *link =3D pcie_aspm_get_link(pdev);
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 parent_l1ss_cap, chil=
d_l1ss_cap;
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pci_dev *parent, *=
child;
> > > > > >=20
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!link)
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
> > > > > > +
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 parent =3D link->pdev;
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 child =3D link->downstrea=
m;
> > > > > > +
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * A driver req=
uested that ASPM be enabled on this device, but
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * if we don't =
have permission to manage ASPM (e.g., on ACPI
> > > > > > @@ -1428,6 +1434,15 @@ static int __pci_enable_link_state(struc=
t
> > > > > > pci_dev
> > > > > > *pdev, int state, bool locked)
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!locked)
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 down_read(&pci_bus_sem);
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&aspm_loc=
k);
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Ensure L1.2 param=
eters: Common_Mode_Restore_Times,
> > > > > > T_POWER_ON and
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * LTR_L1.2_THRESHOL=
D are programmed properly before enable
> > > > > > bits for
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * L1.2, per PCIe r6=
=2E0, sec 5.5.4.
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 parent_l1ss_cap =3D aspm_=
get_l1ss_cap(parent);
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 child_l1ss_cap =3D aspm_g=
et_l1ss_cap(child);
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aspm_calc_l12_info(link, =
parent_l1ss_cap, child_l1ss_cap);
> > > >=20
> > > > I still don't think this is the place to recalculate the L1.2 param=
eters
> > > > especially when know the calculation was done but was cleared by
> > > > pci_bus_reset(). Can't we just do a pci_save/restore_state() before=
/after
> > > > pci_bus_reset() in vmd.c?
> > >=20
> > > I have not thought pci_save/restore_state() around pci_bus_reset()
> > > before.=C2=A0 It is an interesting direction.
> > >=20
> > > So, I prepare modification below for test.=C2=A0 Include "[PATCH v8 1=
/4]
> > > PCI: vmd: Set PCI devices to D0 before enable PCI PM's L1 substates",
> > > too.=C2=A0 Then, both the PCIe bridge and the PCIe device have the sa=
me
> > > LTR_L1.2_THRESHOLD 101376ns as expected.
> > >=20
> > > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vm=
d.c
> > > index bbf4a47e7b31..6b8dd4f30127 100644
> > > --- a/drivers/pci/controller/vmd.c
> > > +++ b/drivers/pci/controller/vmd.c
> > > @@ -727,6 +727,18 @@ static void vmd_copy_host_bridge_flags(struct
> > > pci_host_bridge *root_bridge,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vmd_bridge->native_dpc =3D=
 root_bridge->native_dpc;
> > > =C2=A0}
> > >=20
> > > +static int vmd_pci_save_state(struct pci_dev *pdev, void *userdata)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_save_state(pdev);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > +}
> > > +
> > > +static int vmd_pci_restore_state(struct pci_dev *pdev, void *userdat=
a)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_restore_state(pdev);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > +}
> > > +
> > > =C2=A0/*
> > > =C2=A0 * Enable ASPM and LTR settings on devices that aren't configur=
ed by BIOS.
> > > =C2=A0 */
> > > @@ -927,6 +939,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd,
> > > unsigned long features)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_scan_child_bus(vmd->bu=
s);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vmd_domain_reset(vmd);
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_walk_bus(vmd->bus, vmd_pci_=
save_state, NULL);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* When Intel VMD is enabl=
ed, the OS does not discover the Root
> > > Ports
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * owned by Intel VMD=
 within the MMCFG space. pci_reset_bus()
> > > applies
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * a reset to the par=
ent of the PCI device supplied as argument.
> > > This
> > > @@ -945,6 +958,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd,
> > > unsigned long features)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break=
;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_walk_bus(vmd->bus, vmd_pci_=
restore_state, NULL);
> >=20
> > Why not call pci_reset_bus() (or __pci_reset_bus()) then in=20
> > vmd_enable_domain() which preserves state unlike pci_reset_bus()?
> >=20
> > (Don't tell me naming of these functions is a horrible mess. :-/)
>=20
> Hmm. So this *is* calling pci_reset_bus().

Yeah, I managed to get confused by the names myself, I somehow=20
ended up thinking it calls pci_bus_reset() which is not correct...

> L1.2 configuration has specific
> ordering requirements for changes to parent & child devices. Could be why=
 it's
> not getting restored properly.

Indeed, it has to be something else since the patch above doesn't even=20
restore anything because dev->state_saved should get set to false by the=20
first pci_restore_state() called from=20
__pci_reset_bus() -> pci_bus_restore_locked() -> pci_dev_restore(), I=20
think!?

--=20
 i.
--8323328-1062509429-1723109545=:1044--

