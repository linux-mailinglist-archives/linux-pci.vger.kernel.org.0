Return-Path: <linux-pci+bounces-13377-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E97B997EC8E
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 15:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 574A3B21E4D
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 13:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B758E8172A;
	Mon, 23 Sep 2024 13:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hk0nEtzE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F35A19C551;
	Mon, 23 Sep 2024 13:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727099069; cv=none; b=GKBZIReMUiHwS0gwh4di9Ns4CvvQUGqIH1On3HCXakouKgnE8Fl6fPcQaMTe5G/v5GBoSHm7C/h/pVQLFx76kEn1z3m63rkF5imep9dkaD9JF8UtuyXYzuthgauuAba9TywWkH+yzceG8vyXZ72Eua4wP6QFE7RD1NvbWm3gN5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727099069; c=relaxed/simple;
	bh=Z6oZw7gw55Og6KEKK0b7bW3erWubAQw2OUiVEA2lr2c=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JoHVOnMS57eUWxUJcQCPm15yNeQd+ndOvVfqCld8k0kQslbzkTtfzZZDfkDcnSQPrBDtLUn2pPTAzDHs3vOvhEnCilfIeue4Cam3S6+/CdeIA/0GgNqNerrQ/IieM3JCwC15eE1djeHT+XCdqxYZjhswu0eCoSiGV5DDK9kRCuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hk0nEtzE; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727099068; x=1758635068;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Z6oZw7gw55Og6KEKK0b7bW3erWubAQw2OUiVEA2lr2c=;
  b=Hk0nEtzEHFhYnNjWi0wreTEXu8MOqOoGV5Becyrobumvi5ntuXvVg6Ej
   Z0rgGoSD8cbfX9D/gRv+umLUMXInNaMl6bAg3AWNtG4f22fT8AnjWhL0m
   X7O1B+yCEQCN97ySwSYWJcQp+IHvqxANLKBET+9qMvCFyS+NDR7b+6qjq
   3OsNMHuh0r7DVlX3AHVbzmdJnnlRtoPo0KaiAOWY3vIPDoOMKBcNIF8L8
   jiC5TOh+9VZcqQC6gkxoirH4rfX1HsSkm8yjjpScNCdBK3cGFddYE/hN/
   MnMzkiZGbq1x67+6C2HTtYJ8jVptQ6NWOUdTnuttg2CMG0U8WikkEo3Lb
   A==;
X-CSE-ConnectionGUID: XRKuxcpuTY+Upq/LlX3C5A==
X-CSE-MsgGUID: GFbU30LiRbeIZK2ySRIccQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="37418626"
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="37418626"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 06:44:27 -0700
X-CSE-ConnectionGUID: gUy7DsSCQfCimTyeDRua8g==
X-CSE-MsgGUID: CMxV1IJjQ4ucDfW6CUo5+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="71210763"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.23])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 06:44:20 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 23 Sep 2024 16:44:17 +0300 (EEST)
To: Jian-Hong Pan <jhp@endlessos.org>
cc: "David E. Box" <david.e.box@linux.intel.com>, 
    Bjorn Helgaas <helgaas@kernel.org>, Johan Hovold <johan@kernel.org>, 
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
In-Reply-To: <CAPpJ_eexU0gCHMbXw_z924WxXw0+B6SdS4eG9oGpEX1wmnMLkQ@mail.gmail.com>
Message-ID: <7940ec6f-6848-3616-f0c5-21f4937bb945@linux.intel.com>
References: <20240719075200.10717-2-jhp@endlessos.org> <20240719080255.10998-2-jhp@endlessos.org> <CAPpJ_edybLMtrN_gxP2h9Z-BuYH+RG-qRqMqgZM1oSVoW1sP5A@mail.gmail.com> <e37536a435630583398307682e1a9aadbabfb497.camel@linux.intel.com>
 <CAPpJ_eeATLdcnH9CWpvJM_9juV5ok+OEYysTit_HparqBpQ3CQ@mail.gmail.com> <eb900245-5e13-bc6c-994a-43f2db8322ea@linux.intel.com> <fc0e8066b06abed97d3857c5deefb03041a0fd2e.camel@linux.intel.com> <f9660f21-f2e8-c62c-5e86-ed4875f61701@linux.intel.com>
 <CAPpJ_eeO9j38VGaukrw79dqQAZ7Z8+QMOvTbymyV9=fbQBqFzw@mail.gmail.com> <4295d0e8-12c7-927c-2da5-682163ec3d9c@linux.intel.com> <CAPpJ_eexU0gCHMbXw_z924WxXw0+B6SdS4eG9oGpEX1wmnMLkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-746102895-1727099057=:978"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-746102895-1727099057=:978
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 23 Sep 2024, Jian-Hong Pan wrote:

> Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> =E6=96=BC 2024=E5=B9=
=B49=E6=9C=882=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8811:44=E5=AF=AB=
=E9=81=93=EF=BC=9A
> >
> > On Mon, 12 Aug 2024, Jian-Hong Pan wrote:
> >
> > > Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> =E6=96=BC 2024=E5=
=B9=B48=E6=9C=888=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=885:49=E5=AF=
=AB=E9=81=93=EF=BC=9A
> > > > On Wed, 7 Aug 2024, David E. Box wrote:
> > > > > On Wed, 2024-08-07 at 14:18 +0300, Ilpo J=C3=A4rvinen wrote:
> > > > > > On Wed, 7 Aug 2024, Jian-Hong Pan wrote:
> > > > > >
> > > > > > > David E. Box <david.e.box@linux.intel.com> =E6=96=BC 2024=E5=
=B9=B48=E6=9C=886=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=884:26=E5=AF=
=AB=E9=81=93=EF=BC=9A
> > > > > > > >
> > > > > > > > Hi Jian-Hong,
> > > > > > > >
> > > > > > > > On Fri, 2024-08-02 at 16:24 +0800, Jian-Hong Pan wrote:
> > > > > > > > > Jian-Hong Pan <jhp@endlessos.org> =E6=96=BC 2024=E5=B9=B4=
7=E6=9C=8819=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884:04=E5=AF=AB=E9=
=81=93=EF=BC=9A
> > > > > > > > > >
> > > > > > > > > > Currently, when enable link's L1.2 features with
> > > > > > > > > > __pci_enable_link_state(),
> > > > > > > > > > it configs the link directly without ensuring related L=
1.2 parameters,
> > > > > > > > > > such
> > > > > > > > > > as T_POWER_ON, Common_Mode_Restore_Time, and LTR_L1.2_T=
HRESHOLD have
> > > > > > > > > > been
> > > > > > > > > > programmed.
> > > > > > > > > >
> > > > > > > > > > This leads the link's L1.2 between PCIe Root Port and c=
hild device
> > > > > > > > > > gets
> > > > > > > > > > wrong configs when a caller tries to enabled it.
> > > > > > > > > >
> > > > > > > > > > Here is a failed example on ASUS B1400CEAE with enabled=
 VMD:
> > > > > > > > > >
> > > > > > > > > > 10000:e0:06.0 PCI bridge: Intel Corporation 11th Gen Co=
re Processor
> > > > > > > > > > PCIe
> > > > > > > > > > Controller (rev 01) (prog-if 00 [Normal decode])
> > > > > > > > > >     ...
> > > > > > > > > >     Capabilities: [200 v1] L1 PM Substates
> > > > > > > > > >         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ =
ASPM_L1.1+
> > > > > > > > > > L1_PM_Substates+
> > > > > > > > > >                   PortCommonModeRestoreTime=3D45us Port=
TPowerOnTime=3D50us
> > > > > > > > > >         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+=
 ASPM_L1.1-
> > > > > > > > > >                    T_CommonMode=3D45us LTR1.2_Threshold=
=3D101376ns
> > > > > > > > > >         L1SubCtl2: T_PwrOn=3D50us
> > > > > > > > > >
> > > > > > > > > > 10000:e1:00.0 Non-Volatile memory controller: Sandisk C=
orp WD Blue
> > > > > > > > > > SN550
> > > > > > > > > > NVMe SSD (rev 01) (prog-if 02 [NVM Express])
> > > > > > > > > >     ...
> > > > > > > > > >     Capabilities: [900 v1] L1 PM Substates
> > > > > > > > > >         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ =
ASPM_L1.1-
> > > > > > > > > > L1_PM_Substates+
> > > > > > > > > >                   PortCommonModeRestoreTime=3D32us Port=
TPowerOnTime=3D10us
> > > > > > > > > >         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+=
 ASPM_L1.1-
> > > > > > > > > >                    T_CommonMode=3D0us LTR1.2_Threshold=
=3D0ns
> > > > > > > > > >         L1SubCtl2: T_PwrOn=3D10us
> > > > > > > > > >
> > > > > > > > > > According to "PCIe r6.0, sec 5.5.4", before enabling AS=
PM L1.2 on the
> > > > > > > > > > PCIe
> > > > > > > > > > Root Port and the child NVMe, they should be programmed=
 with the same
> > > > > > > > > > LTR1.2_Threshold value. However, they have different va=
lues in this
> > > > > > > > > > case.
> > > > > > > > > >
> > > > > > > > > > Invoke aspm_calc_l12_info() to program the L1.2 paramet=
ers properly
> > > > > > > > > > before
> > > > > > > > > > enable L1.2 bits of L1 PM Substates Control Register in
> > > > > > > > > > __pci_enable_link_state().
> > > > > > > > > >
> > > > > > > > > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218=
394
> > > > > > > > > > Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> > > > > > > > > > ---
> > > > > > > > > > v2:
> > > > > > > > > > - Prepare the PCIe LTR parameters before enable L1 Subs=
tates
> > > > > > > > > >
> > > > > > > > > > v3:
> > > > > > > > > > - Only enable supported features for the L1 Substates p=
art
> > > > > > > > > >
> > > > > > > > > > v4:
> > > > > > > > > > - Focus on fixing L1.2 parameters, instead of re-initia=
lizing whole
> > > > > > > > > > L1SS
> > > > > > > > > >
> > > > > > > > > > v5:
> > > > > > > > > > - Fix typo and commit message
> > > > > > > > > > - Split introducing aspm_get_l1ss_cap() to "PCI/ASPM: I=
ntroduce
> > > > > > > > > >   aspm_get_l1ss_cap()"
> > > > > > > > > >
> > > > > > > > > > v6:
> > > > > > > > > > - Skipped
> > > > > > > > > >
> > > > > > > > > > v7:
> > > > > > > > > > - Pick back and rebase on the new version kernel
> > > > > > > > > > - Drop the link state flag check. And, always config li=
nk state's
> > > > > > > > > > timing
> > > > > > > > > >   parameters
> > > > > > > > > >
> > > > > > > > > > v8:
> > > > > > > > > > - Because pcie_aspm_get_link() might return the link as=
 NULL, move
> > > > > > > > > >   getting the link's parent and child devices after che=
ck the link is
> > > > > > > > > >   not NULL. This avoids NULL memory access.
> > > > > > > > > >
> > > > > > > > > >  drivers/pci/pcie/aspm.c | 15 +++++++++++++++
> > > > > > > > > >  1 file changed, 15 insertions(+)
> > > > > > > > > >
> > > > > > > > > > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie=
/aspm.c
> > > > > > > > > > index 5db1044c9895..55ff1d26fcea 100644
> > > > > > > > > > --- a/drivers/pci/pcie/aspm.c
> > > > > > > > > > +++ b/drivers/pci/pcie/aspm.c
> > > > > > > > > > @@ -1411,9 +1411,15 @@ EXPORT_SYMBOL(pci_disable_link_s=
tate);
> > > > > > > > > >  static int __pci_enable_link_state(struct pci_dev *pde=
v, int state,
> > > > > > > > > > bool
> > > > > > > > > > locked)
> > > > > > > > > >  {
> > > > > > > > > >         struct pcie_link_state *link =3D pcie_aspm_get_=
link(pdev);
> > > > > > > > > > +       u32 parent_l1ss_cap, child_l1ss_cap;
> > > > > > > > > > +       struct pci_dev *parent, *child;
> > > > > > > > > >
> > > > > > > > > >         if (!link)
> > > > > > > > > >                 return -EINVAL;
> > > > > > > > > > +
> > > > > > > > > > +       parent =3D link->pdev;
> > > > > > > > > > +       child =3D link->downstream;
> > > > > > > > > > +
> > > > > > > > > >         /*
> > > > > > > > > >          * A driver requested that ASPM be enabled on t=
his device, but
> > > > > > > > > >          * if we don't have permission to manage ASPM (=
e.g., on ACPI
> > > > > > > > > > @@ -1428,6 +1434,15 @@ static int __pci_enable_link_sta=
te(struct
> > > > > > > > > > pci_dev
> > > > > > > > > > *pdev, int state, bool locked)
> > > > > > > > > >         if (!locked)
> > > > > > > > > >                 down_read(&pci_bus_sem);
> > > > > > > > > >         mutex_lock(&aspm_lock);
> > > > > > > > > > +       /*
> > > > > > > > > > +        * Ensure L1.2 parameters: Common_Mode_Restore_=
Times,
> > > > > > > > > > T_POWER_ON and
> > > > > > > > > > +        * LTR_L1.2_THRESHOLD are programmed properly b=
efore enable
> > > > > > > > > > bits for
> > > > > > > > > > +        * L1.2, per PCIe r6.0, sec 5.5.4.
> > > > > > > > > > +        */
> > > > > > > > > > +       parent_l1ss_cap =3D aspm_get_l1ss_cap(parent);
> > > > > > > > > > +       child_l1ss_cap =3D aspm_get_l1ss_cap(child);
> > > > > > > > > > +       aspm_calc_l12_info(link, parent_l1ss_cap, child=
_l1ss_cap);
> > > > > > > >
> > > > > > > > I still don't think this is the place to recalculate the L1=
=2E2 parameters
> > > > > > > > especially when know the calculation was done but was clear=
ed by
> > > > > > > > pci_bus_reset(). Can't we just do a pci_save/restore_state(=
) before/after
> > > > > > > > pci_bus_reset() in vmd.c?
> > > > > > >
> > > > > > > I have not thought pci_save/restore_state() around pci_bus_re=
set()
> > > > > > > before.  It is an interesting direction.
> > > > > > >
> > > > > > > So, I prepare modification below for test.  Include "[PATCH v=
8 1/4]
> > > > > > > PCI: vmd: Set PCI devices to D0 before enable PCI PM's L1 sub=
states",
> > > > > > > too.  Then, both the PCIe bridge and the PCIe device have the=
 same
> > > > > > > LTR_L1.2_THRESHOLD 101376ns as expected.
> > > > > > >
> > > > > > > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/contr=
oller/vmd.c
> > > > > > > index bbf4a47e7b31..6b8dd4f30127 100644
> > > > > > > --- a/drivers/pci/controller/vmd.c
> > > > > > > +++ b/drivers/pci/controller/vmd.c
> > > > > > > @@ -727,6 +727,18 @@ static void vmd_copy_host_bridge_flags(s=
truct
> > > > > > > pci_host_bridge *root_bridge,
> > > > > > >         vmd_bridge->native_dpc =3D root_bridge->native_dpc;
> > > > > > >  }
> > > > > > >
> > > > > > > +static int vmd_pci_save_state(struct pci_dev *pdev, void *us=
erdata)
> > > > > > > +{
> > > > > > > +       pci_save_state(pdev);
> > > > > > > +       return 0;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static int vmd_pci_restore_state(struct pci_dev *pdev, void =
*userdata)
> > > > > > > +{
> > > > > > > +       pci_restore_state(pdev);
> > > > > > > +       return 0;
> > > > > > > +}
> > > > > > > +
> > > > > > >  /*
> > > > > > >   * Enable ASPM and LTR settings on devices that aren't confi=
gured by BIOS.
> > > > > > >   */
> > > > > > > @@ -927,6 +939,7 @@ static int vmd_enable_domain(struct vmd_d=
ev *vmd,
> > > > > > > unsigned long features)
> > > > > > >         pci_scan_child_bus(vmd->bus);
> > > > > > >         vmd_domain_reset(vmd);
> > > > > > >
> > > > > > > +       pci_walk_bus(vmd->bus, vmd_pci_save_state, NULL);
> > > > > > >         /* When Intel VMD is enabled, the OS does not discove=
r the Root
> > > > > > > Ports
> > > > > > >          * owned by Intel VMD within the MMCFG space. pci_res=
et_bus()
> > > > > > > applies
> > > > > > >          * a reset to the parent of the PCI device supplied a=
s argument.
> > > > > > > This
> > > > > > > @@ -945,6 +958,7 @@ static int vmd_enable_domain(struct vmd_d=
ev *vmd,
> > > > > > > unsigned long features)
> > > > > > >                         break;
> > > > > > >                 }
> > > > > > >         }
> > > > > > > +       pci_walk_bus(vmd->bus, vmd_pci_restore_state, NULL);
> > > > > >
> > > > > > Why not call pci_reset_bus() (or __pci_reset_bus()) then in
> > > > > > vmd_enable_domain() which preserves state unlike pci_reset_bus(=
)?
> > > > > >
> > > > > > (Don't tell me naming of these functions is a horrible mess. :-=
/)
> > > > >
> > > > > Hmm. So this *is* calling pci_reset_bus().
> > > >
> > > > Yeah, I managed to get confused by the names myself, I somehow
> > > > ended up thinking it calls pci_bus_reset() which is not correct...
> > > >
> > > > > L1.2 configuration has specific
> > > > > ordering requirements for changes to parent & child devices. Coul=
d be why it's
> > > > > not getting restored properly.
> > > >
> > > > Indeed, it has to be something else since the patch above doesn't e=
ven
> > > > restore anything because dev->state_saved should get set to false b=
y the
> > > > first pci_restore_state() called from
> > > > __pci_reset_bus() -> pci_bus_restore_locked() -> pci_dev_restore(),=
 I
> > > > think!?
> > >
> > > Inspired by Ilpo's comment.  I add some debug messages based on
> > > linux-next's tag 'next-20240809' to understand the code path of
> > > pci_reset_bus():
> > >
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index ffaaca0978cb..3ee71374f1de 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -5133,8 +5133,10 @@ static void pci_dev_save_and_disable(struct pc=
i_dev *dev)
> > >          * races with ->remove() by the device lock, which must be he=
ld by
> > >          * the caller.
> > >          */
> > > -       if (err_handler && err_handler->reset_prepare)
> > > +       if (err_handler && err_handler->reset_prepare) {
> > > +               pci_info(dev, "%s: %pF\n", __func__,
> > > err_handler->reset_prepare);
> > >                 err_handler->reset_prepare(dev);
> > > +       }
> > >
> > >         /*
> > >          * Wake-up device prior to save.  PM registers default to D0 =
after
> > > @@ -5144,6 +5146,7 @@ static void pci_dev_save_and_disable(struct pci=
_dev *dev)
> > >         pci_set_power_state(dev, PCI_D0);
> > >
> > >         pci_save_state(dev);
> > > +       pci_info(dev, "%s: PCI state_saved is %s\n", __func__,
> > > dev->state_saved ? "true" : "false");
> > >         /*
> > >          * Disable the device by clearing the Command register, excep=
t for
> > >          * INTx-disable which is set.  This not only disables MMIO an=
d I/O port
> > > @@ -5655,6 +5658,10 @@ static void
> > > pci_bus_save_and_disable_locked(struct pci_bus *bus)
> > >         struct pci_dev *dev;
> > >
> > >         list_for_each_entry(dev, &bus->devices, bus_list) {
> > > +               pci_info(dev, "%s: PCI state_saved is %s, and %s subo=
rdinate\n",
> > > +                        __func__,
> > > +                        dev->state_saved ? "true" : "false",
> > > +                        dev->subordinate ? "has" : "does not have");
> > >                 pci_dev_save_and_disable(dev);
> > >                 if (dev->subordinate)
> > >                         pci_bus_save_and_disable_locked(dev->subordin=
ate);
> > > @@ -5671,6 +5678,10 @@ static void pci_bus_restore_locked(struct pci_=
bus *bus)
> > >         struct pci_dev *dev;
> > >
> > >         list_for_each_entry(dev, &bus->devices, bus_list) {
> > > +               pci_info(dev, "%s: PCI state_saved is %s, and %s subo=
rdinate\n",
> > > +                        __func__,
> > > +                        dev->state_saved ? "true" : "false",
> > > +                        dev->subordinate ? "has" : "does not have");
> > >                 pci_dev_restore(dev);
> > >                 if (dev->subordinate)
> > >                         pci_bus_restore_locked(dev->subordinate);
> > > @@ -5786,8 +5797,10 @@ static int pci_bus_reset(struct pci_bus *bus, =
bool probe)
> > >         if (!bus->self || !pci_bus_resettable(bus))
> > >                 return -ENOTTY;
> > >
> > > -       if (probe)
> > > +       if (probe) {
> > > +               pci_info(bus->self, "%s: probe is true.  So return 0
> > > directly", __func__);
> > >                 return 0;
> > > +       }
> > >
> > >         pci_bus_lock(bus);
> > >
> > > @@ -5858,10 +5871,12 @@ static int __pci_reset_bus(struct pci_bus *bu=
s)
> > >         int rc;
> > >
> > >         rc =3D pci_bus_reset(bus, PCI_RESET_PROBE);
> > > +       pci_info(bus->self, "%s: pci_bus_reset() returns %d\n", __fun=
c__, rc);
> > >         if (rc)
> > >                 return rc;
> > >
> > >         if (pci_bus_trylock(bus)) {
> > > +               pci_info(bus->self, "%s: pci_bus_trylock() returns
> > > true\n", __func__);
> > >                 pci_bus_save_and_disable_locked(bus);
> > >                 might_sleep();
> > >                 rc =3D pci_bridge_secondary_bus_reset(bus->self);
> > > @@ -5881,6 +5896,7 @@ static int __pci_reset_bus(struct pci_bus *bus)
> > >   */
> > >  int pci_reset_bus(struct pci_dev *pdev)
> > >  {
> > > +       pci_info(pdev, "%s: %s", __func__,
> > > !pci_probe_reset_slot(pdev->slot) ? "true" : "false");
> > >         return (!pci_probe_reset_slot(pdev->slot)) ?
> > >             __pci_reset_slot(pdev->slot) : __pci_reset_bus(pdev->bus)=
;
> > >  }
> > >
> > > And, have the information of VMD PCIe devices with the built kernel:
> > >
> > > 10000:e0:06.0 PCI bridge [0604]: Intel Corporation 11th Gen Core
> > > Processor PCIe Controller [8086:9a09] (rev 01) (prog-if 00 [Normal
> > > decode])
> > >   ...
> > >   Capabilities: [200 v1] L1 PM Substates
> > >     L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_S=
ubstates+
> > >       PortCommonModeRestoreTime=3D45us PortTPowerOnTime=3D50us
> > >     L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > >       T_CommonMode=3D0us LTR1.2_Threshold=3D0ns
> > >     L1SubCtl2: T_PwrOn=3D0us
> > >
> > > 10000:e1:00.0 Non-Volatile memory controller [0108]: Sandisk Corp WD
> > > Blue SN550 NVMe SSD [15b7:5009] (rev 01) (prog-if 02 [NVM Express])
> > >   ...
> > >   Capabilities: [900 v1] L1 PM Substates
> > >     L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_S=
ubstates+
> > >       PortCommonModeRestoreTime=3D32us PortTPowerOnTime=3D10us
> > >     L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > >       T_CommonMode=3D0us LTR1.2_Threshold=3D101376ns
> > >     L1SubCtl2: T_PwrOn=3D50us
> > >
> > > We can see the NVMe has expected LTR1.2_Threshold=3D101376ns, but the
> > > PCIe bridge has LTR1.2_Threshold=3D0ns.
> >
> > This is now the other way around as in the original posting that had
> > 0ns for 10000:e1:00.0 ??
> >
> > Is this behavior even consistent or did you e.g. mess up some copy
> > pasting somewhere?
> >
> > > Then, check the dmesg.  I notice the debug messages:
> > >
> > > pci 10000:e0:06.0: PCI bridge to [bus e1]
> > > pci 10000:e0:06.0: Primary bus is hard wired to 0
> > > pci 10000:e1:00.0: pci_reset_bus: false
> > > pci 10000:e0:06.0: pci_bus_reset: probe is true.  So return 0 directl=
y
> > > pci 10000:e0:06.0: __pci_reset_bus: pci_bus_reset() returns 0
> > > pci 10000:e0:06.0: __pci_reset_bus: pci_bus_trylock() returns true
> > > pci 10000:e1:00.0: pci_bus_save_and_disable_locked: PCI state_saved i=
s
> > > false, and does not have subordinate
> > > pci 10000:e1:00.0: pci_dev_save_and_disable: PCI state_saved is true
> > > Freeing initrd memory: 75236K
> > > pci 10000:e1:00.0: pci_bus_restore_locked: PCI state_saved is true,
> > > and does not have subordinate
> > >
> > > So, the code path is:
> > >
> > > vmd_enable_domain()
> > >   pci_reset_bus()
> > >     __pci_reset_bus()
> > >       pci_bus_reset()
> > >         pci_bus_save_and_disable_locked()
> > >           pci_dev_save_and_disable()
> > >         pci_bus_restore_locked()
> > >           pci_dev_restore()
> > >
> > > And, from the debug messages, I learned only NVMe 10000:e1:00.0 does
> > > pci_save/restore_state.  But, the PCIe bridge 10000:e0:06.0 does not.
> > > So, PCIe bridge 10000:e0:06.0 does not restore state correctly.
> >
> > It should not be necessary to restore the bridge's configuration as it
> > ought to not be changed by the SBR itself, PCIe6 spec 7.5.1.3.13:
> >
> > "Port configuration registers must not be changed, except as required t=
o
> > update Port status."
> >
> > While the second part wording leaves some leeway, I don't think any of
> > these field really fall under "Port status".
> >
> > > Besides, it is NVMe 10000:e1:00.0's bus [e1] been reset, not the VMD'=
s
> > > bus in vmd_enable_domain().
> > > * Bus "e1" has only NVMe 10000:e1:00.0
> > > * VMD's bus in vmd_enable_domain() has PCIe bridge 10000:e0:06.0, NVM=
e
> > > 10000:e1:00.0 and SATA Controller 10000:e0:17.0.
> >
> > ...But even if those registers on the PCIe bridge were changed undernea=
th
> > against the spec, it's not clear from your debug log why pci_dev_restor=
e()
> > -> pci_restore_state() -> pci_restore_pcie_state() ->
> > pci_restore_aspm_l1ss_state() did not restore also parent's
> > LTR1.2_Threshold?? I think it should attempt to do that.
> >
> > --
> >  i.
> >
> > > Here is the PCI tree:
> > >
> > > -+-[0000:00]-+-00.0  Intel Corporation Device 9a04
> > >  |           +-02.0  Intel Corporation Tiger Lake-LP GT2 [UHD Graphic=
s G4]
> > >  |           +-04.0  Intel Corporation TigerLake-LP Dynamic Tuning
> > > Processor Participant
> > >  |           +-06.0  Intel Corporation RST VMD Managed Controller
> > >  |           +-07.0-[01-2b]--
> > >  |           +-08.0  Intel Corporation GNA Scoring Accelerator module
> > >  |           +-0a.0  Intel Corporation Tigerlake Telemetry Aggregator=
 Driver
> > >  |           +-0d.0  Intel Corporation Tiger Lake-LP Thunderbolt 4 US=
B
> > > Controller
> > >  |           +-0d.2  Intel Corporation Tiger Lake-LP Thunderbolt 4 NH=
I #0
> > >  |           +-0e.0  Intel Corporation Volume Management Device NVMe
> > > RAID Controller
> > >  |           +-14.0  Intel Corporation Tiger Lake-LP USB 3.2 Gen 2x1
> > > xHCI Host Controller
> > >  |           +-14.2  Intel Corporation Tiger Lake-LP Shared SRAM
> > >  |           +-14.3  Intel Corporation Wi-Fi 6 AX201
> > >  |           +-15.0  Intel Corporation Tiger Lake-LP Serial IO I2C Co=
ntroller #0
> > >  |           +-15.1  Intel Corporation Tiger Lake-LP Serial IO I2C Co=
ntroller #1
> > >  |           +-16.0  Intel Corporation Tiger Lake-LP Management Engin=
e Interface
> > >  |           +-17.0  Intel Corporation RST VMD Managed Controller
> > >  |           +-1f.0  Intel Corporation Tiger Lake-LP LPC Controller
> > >  |           +-1f.3  Intel Corporation Tiger Lake-LP Smart Sound
> > > Technology Audio Controller
> > >  |           +-1f.4  Intel Corporation Tiger Lake-LP SMBus Controller
> > >  |           +-1f.5  Intel Corporation Tiger Lake-LP SPI Controller
> > >  |           \-1f.6  Intel Corporation Ethernet Connection (13) I219-=
V
> > >  \-[10000:e0]-+-06.0-[e1]----00.0  Sandisk Corp WD Blue SN550 NVMe SS=
D
> > >               \-17.0  Intel Corporation Tiger Lake-LP SATA Controller
> > >
> > > According the findings above, to ensure the devices on the VMD bus
> > > have correctly states, seems pci_save_state() all the devices before
> > > pci_reset_bus(), and pci_restore_state() all the devices after
> > > pci_reset_bus() is the correct answer.
>=20
> I add some debug messages based on v6.11 as following:
>=20
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index cee2365e54b8..404ce92f0152 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -109,21 +109,28 @@ void pci_restore_aspm_l1ss_state(struct pci_dev *pd=
ev)
>         u32 cl_ctl1, cl_ctl2, cl_l1_2_enable;
>         u16 clnkctl, plnkctl;
>=20
> +       pci_info(pdev, "%s", __func__);
>         /*
>          * In case BIOS enabled L1.2 when resuming, we need to disable it=
 first
>          * on the downstream component before the upstream. So, don't att=
empt to
>          * restore either until we are at the downstream component.
>          */
> -       if (pcie_downstream_port(pdev) || !parent)
> +       if (pcie_downstream_port(pdev) || !parent) {
> +               pci_info(pdev, "%s: %s", __func__,
> pcie_downstream_port(pdev) ? "is downstream port" : "not parent");
>                 return;
> +       }
>=20
> -       if (!pdev->l1ss || !parent->l1ss)
> +       if (!pdev->l1ss || !parent->l1ss) {
> +               pci_info(pdev, "%s: %sdoes not have l1ss", __func__,
> !pdev->l1ss ? "" : "parent ");
>                 return;
> +       }
>=20
>         cl_save_state =3D pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_L1S=
S);
>         pl_save_state =3D pci_find_saved_ext_cap(parent, PCI_EXT_CAP_ID_L=
1SS);
> -       if (!cl_save_state || !pl_save_state)
> +       if (!cl_save_state || !pl_save_state) {
> +               pci_info(pdev, "%s: %sdid not save ext_cap", __func__,
> !cl_save_state ? "" : "parent ");
>                 return;
> +       }
>=20
>         cap =3D &cl_save_state->cap.data[0];
>         cl_ctl2 =3D *cap++;
> @@ -131,6 +138,7 @@ void pci_restore_aspm_l1ss_state(struct pci_dev *pdev=
)
>         cap =3D &pl_save_state->cap.data[0];
>         pl_ctl2 =3D *cap++;
>         pl_ctl1 =3D *cap;
> +       pci_info(pdev, "%s: cl_ctl1: 0x%08x, cl_ctl2: 0x%08x, pl_ctl1:
> 0x%08x, pl_ctl2: 0x%08x", __func__, cl_ctl1, cl_ctl2, pl_ctl1,
> pl_ctl2);
>=20
>         /* Make sure L0s/L1 are disabled before updating L1SS config */
>         pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &clnkctl);
>=20
> Here is the corresponding log:
>=20
> [    0.418931] pci 10000:e0:06.0: PCI bridge to [bus e1]
> [    0.418936] pci 10000:e0:06.0: Primary bus is hard wired to 0
> [    0.447474] Freeing initrd memory: 24700K
> [    0.670789] pci 10000:e1:00.0: pci_restore_aspm_l1ss_state
> [    0.670807] pci 10000:e1:00.0: pci_restore_aspm_l1ss_state:
> cl_ctl1: 0x40630000, cl_ctl2: 0x00000029, pl_ctl1: 0x00000000,
> pl_ctl2: 0x00000000
> [    0.670862] pci 10000:e0:06.0: bridge window [mem
> 0x76000000-0x760fffff]: assigned
> [    0.670864] pci 10000:e0:17.0: BAR 0 [mem 0x76100000-0x76101fff]: assi=
gned
> [    0.670881] pci 10000:e0:06.0: bridge window [io  size 0x1000]:
> can't assign; no space
> [    0.670882] pci 10000:e0:06.0: bridge window [io  size 0x1000]:
> failed to assign
> [    0.670884] pci 10000:e0:17.0: BAR 5 [mem 0x76102000-0x761027ff]: assi=
gned
> [    0.670893] pci 10000:e0:17.0: BAR 1 [mem 0x76102800-0x761028ff]: assi=
gned
> [    0.670896] pci 10000:e0:17.0: BAR 4 [io  size 0x0020]: can't
> assign; no space
> [    0.670897] pci 10000:e0:17.0: BAR 4 [io  size 0x0020]: failed to assi=
gn
> [    0.670898] pci 10000:e0:17.0: BAR 2 [io  size 0x0008]: can't
> assign; no space
> [    0.670898] pci 10000:e0:17.0: BAR 2 [io  size 0x0008]: failed to assi=
gn
> [    0.670899] pci 10000:e0:17.0: BAR 3 [io  size 0x0004]: can't
> assign; no space
> [    0.670900] pci 10000:e0:17.0: BAR 3 [io  size 0x0004]: failed to assi=
gn
> [    0.670901] pci 10000:e1:00.0: BAR 0 [mem 0x76000000-0x76003fff
> 64bit]: assigned
> [    0.670909] pci 10000:e1:00.0: BAR 4 [mem 0x76004000-0x760040ff
> 64bit]: assigned
> [    0.670918] pci 10000:e0:06.0: PCI bridge to [bus e1]
> [    0.670921] pci 10000:e0:06.0:   bridge window [mem 0x76000000-0x760ff=
fff]
> [    0.670950] pci 10000:e1:00.0: VMD: Default LTR value set by driver
> [    0.670977] pcieport 10000:e0:06.0: can't derive routing for PCI INT D
> [    0.670979] pcieport 10000:e0:06.0: PCI INT D: no GSI
> [    0.671043] pcieport 10000:e0:06.0: PME: Signaling with IRQ 143
> [    0.671092] vmd 0000:00:0e.0: Bound to PCI domain 10000
>=20
> We can notice both pl_ctl1 and pl_ctl2 are 0x0.  Because, the link's
> parent device (PCIe bridge 10000:e0:06.0) did not save state before
> reset.  So, pci_restore_aspm_l1ss_state() restores parent's
> LTR1.2_Threshold with a wrong value 0.

Okay, this is very useful finding because it leads us to the root cause,=20
which is the disparity between pci_save_aspm_l1ss_state() and=20
pci_restore_aspm_l1ss_state(). The latter restores both dev and its=20
parent, yet the save state side only saves the ASPM state for the dev=20
itself, not for the parent.

--=20
 i.

--8323328-746102895-1727099057=:978--

