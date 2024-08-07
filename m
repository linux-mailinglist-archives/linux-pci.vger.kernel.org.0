Return-Path: <linux-pci+bounces-11428-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B2B94A6D2
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 13:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2203B1C2185F
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 11:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCE81C8FB7;
	Wed,  7 Aug 2024 11:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gZSM7oWV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01351E3CA2;
	Wed,  7 Aug 2024 11:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723029657; cv=none; b=Hl5PObGijv6mcwh7jDmq1wfwug9Fgj3Hcia/XP6Kg0cchiNzMzM1xHQ5HrS53nvflVD+wTJfS3gzwNlW97uGyBmKxQYm7UEaJFR/bL+oxV3ZIC79p3VetpCoZ3l89jVtvkoZe2d08A3Vpeg3GsrHlRVoocUnC4ql91GwcIomX70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723029657; c=relaxed/simple;
	bh=IgSNN/sCJu3ISYNhHA9lUgEWt2hNzGyi0aYfmAPu5iU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HGdDmv2KNEn2v0CjFqRp0eOvd0BUgtelZKaZAVQEO5ZWtYHZRVW990jfL+6309XQ/8fYVIRiDmTlUbOSWIwrPCZct5SWAyBHAayQIOtVbOfq7xDiUaiNUJk9HHiyBTpK/aZ0cTXqw+Jy4W7AHCIW9P1Dr0cEGPibe6zctcJEEu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gZSM7oWV; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723029655; x=1754565655;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=IgSNN/sCJu3ISYNhHA9lUgEWt2hNzGyi0aYfmAPu5iU=;
  b=gZSM7oWVK8FgL6NWadfkhM6VQEKQQnevXjIkhFAOmGWgZE2nWkHYj8Ra
   FhO+GOVH7TMHfk2EQJiY+Humur/gxdnNRtfJn2e3ANK3iRNO6qf255IqS
   4QN0l59Wc2aF7j17PzZIUEF23A4y+qHZbQ94Y/EVxpZlrnqAThFGhzI2S
   ISNXxqGqhSaZV5vATRRFdn4SmfUZY0sHD3aeMUj9SjZY8ZSqi3GH4s32o
   QTxbLNl+KsnB/virVTIDh6CwNCWaBYpwgxIzA0Y8+7baOE3rf94V73rMK
   UZobvj7b6MOw3P3weunN6wgam1+4CPQT0DhuT+xTtgjwKCPiK847P2mJF
   g==;
X-CSE-ConnectionGUID: 79DMSpyxSjaE70qhnSpLFQ==
X-CSE-MsgGUID: O5ZQhDXmQRCnq/dyuMqpxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="31722592"
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="31722592"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 04:20:53 -0700
X-CSE-ConnectionGUID: 98N6okx5R+u24jFbxz3orQ==
X-CSE-MsgGUID: E3RK+MBXTJezhyXhRcjbkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="61703544"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.202])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 04:18:58 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 7 Aug 2024 14:18:54 +0300 (EEST)
To: Jian-Hong Pan <jhp@endlessos.org>
cc: david.e.box@linux.intel.com, Bjorn Helgaas <helgaas@kernel.org>, 
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
In-Reply-To: <CAPpJ_eeATLdcnH9CWpvJM_9juV5ok+OEYysTit_HparqBpQ3CQ@mail.gmail.com>
Message-ID: <eb900245-5e13-bc6c-994a-43f2db8322ea@linux.intel.com>
References: <20240719075200.10717-2-jhp@endlessos.org> <20240719080255.10998-2-jhp@endlessos.org> <CAPpJ_edybLMtrN_gxP2h9Z-BuYH+RG-qRqMqgZM1oSVoW1sP5A@mail.gmail.com> <e37536a435630583398307682e1a9aadbabfb497.camel@linux.intel.com>
 <CAPpJ_eeATLdcnH9CWpvJM_9juV5ok+OEYysTit_HparqBpQ3CQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-402323662-1723029534=:1138"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-402323662-1723029534=:1138
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 7 Aug 2024, Jian-Hong Pan wrote:

> David E. Box <david.e.box@linux.intel.com> =E6=96=BC 2024=E5=B9=B48=E6=9C=
=886=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=884:26=E5=AF=AB=E9=81=93=
=EF=BC=9A
> >
> > Hi Jian-Hong,
> >
> > On Fri, 2024-08-02 at 16:24 +0800, Jian-Hong Pan wrote:
> > > Jian-Hong Pan <jhp@endlessos.org> =E6=96=BC 2024=E5=B9=B47=E6=9C=8819=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884:04=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > > >
> > > > Currently, when enable link's L1.2 features with __pci_enable_link_=
state(),
> > > > it configs the link directly without ensuring related L1.2 paramete=
rs, such
> > > > as T_POWER_ON, Common_Mode_Restore_Time, and LTR_L1.2_THRESHOLD hav=
e been
> > > > programmed.
> > > >
> > > > This leads the link's L1.2 between PCIe Root Port and child device =
gets
> > > > wrong configs when a caller tries to enabled it.
> > > >
> > > > Here is a failed example on ASUS B1400CEAE with enabled VMD:
> > > >
> > > > 10000:e0:06.0 PCI bridge: Intel Corporation 11th Gen Core Processor=
 PCIe
> > > > Controller (rev 01) (prog-if 00 [Normal decode])
> > > >     ...
> > > >     Capabilities: [200 v1] L1 PM Substates
> > > >         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> > > > L1_PM_Substates+
> > > >                   PortCommonModeRestoreTime=3D45us PortTPowerOnTime=
=3D50us
> > > >         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > > >                    T_CommonMode=3D45us LTR1.2_Threshold=3D101376ns
> > > >         L1SubCtl2: T_PwrOn=3D50us
> > > >
> > > > 10000:e1:00.0 Non-Volatile memory controller: Sandisk Corp WD Blue =
SN550
> > > > NVMe SSD (rev 01) (prog-if 02 [NVM Express])
> > > >     ...
> > > >     Capabilities: [900 v1] L1 PM Substates
> > > >         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > > > L1_PM_Substates+
> > > >                   PortCommonModeRestoreTime=3D32us PortTPowerOnTime=
=3D10us
> > > >         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > > >                    T_CommonMode=3D0us LTR1.2_Threshold=3D0ns
> > > >         L1SubCtl2: T_PwrOn=3D10us
> > > >
> > > > According to "PCIe r6.0, sec 5.5.4", before enabling ASPM L1.2 on t=
he PCIe
> > > > Root Port and the child NVMe, they should be programmed with the sa=
me
> > > > LTR1.2_Threshold value. However, they have different values in this=
 case.
> > > >
> > > > Invoke aspm_calc_l12_info() to program the L1.2 parameters properly=
 before
> > > > enable L1.2 bits of L1 PM Substates Control Register in
> > > > __pci_enable_link_state().
> > > >
> > > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218394
> > > > Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> > > > ---
> > > > v2:
> > > > - Prepare the PCIe LTR parameters before enable L1 Substates
> > > >
> > > > v3:
> > > > - Only enable supported features for the L1 Substates part
> > > >
> > > > v4:
> > > > - Focus on fixing L1.2 parameters, instead of re-initializing whole=
 L1SS
> > > >
> > > > v5:
> > > > - Fix typo and commit message
> > > > - Split introducing aspm_get_l1ss_cap() to "PCI/ASPM: Introduce
> > > >   aspm_get_l1ss_cap()"
> > > >
> > > > v6:
> > > > - Skipped
> > > >
> > > > v7:
> > > > - Pick back and rebase on the new version kernel
> > > > - Drop the link state flag check. And, always config link state's t=
iming
> > > >   parameters
> > > >
> > > > v8:
> > > > - Because pcie_aspm_get_link() might return the link as NULL, move
> > > >   getting the link's parent and child devices after check the link =
is
> > > >   not NULL. This avoids NULL memory access.
> > > >
> > > >  drivers/pci/pcie/aspm.c | 15 +++++++++++++++
> > > >  1 file changed, 15 insertions(+)
> > > >
> > > > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > > > index 5db1044c9895..55ff1d26fcea 100644
> > > > --- a/drivers/pci/pcie/aspm.c
> > > > +++ b/drivers/pci/pcie/aspm.c
> > > > @@ -1411,9 +1411,15 @@ EXPORT_SYMBOL(pci_disable_link_state);
> > > >  static int __pci_enable_link_state(struct pci_dev *pdev, int state=
, bool
> > > > locked)
> > > >  {
> > > >         struct pcie_link_state *link =3D pcie_aspm_get_link(pdev);
> > > > +       u32 parent_l1ss_cap, child_l1ss_cap;
> > > > +       struct pci_dev *parent, *child;
> > > >
> > > >         if (!link)
> > > >                 return -EINVAL;
> > > > +
> > > > +       parent =3D link->pdev;
> > > > +       child =3D link->downstream;
> > > > +
> > > >         /*
> > > >          * A driver requested that ASPM be enabled on this device, =
but
> > > >          * if we don't have permission to manage ASPM (e.g., on ACP=
I
> > > > @@ -1428,6 +1434,15 @@ static int __pci_enable_link_state(struct pc=
i_dev
> > > > *pdev, int state, bool locked)
> > > >         if (!locked)
> > > >                 down_read(&pci_bus_sem);
> > > >         mutex_lock(&aspm_lock);
> > > > +       /*
> > > > +        * Ensure L1.2 parameters: Common_Mode_Restore_Times, T_POW=
ER_ON and
> > > > +        * LTR_L1.2_THRESHOLD are programmed properly before enable=
 bits for
> > > > +        * L1.2, per PCIe r6.0, sec 5.5.4.
> > > > +        */
> > > > +       parent_l1ss_cap =3D aspm_get_l1ss_cap(parent);
> > > > +       child_l1ss_cap =3D aspm_get_l1ss_cap(child);
> > > > +       aspm_calc_l12_info(link, parent_l1ss_cap, child_l1ss_cap);
> >
> > I still don't think this is the place to recalculate the L1.2 parameter=
s
> > especially when know the calculation was done but was cleared by
> > pci_bus_reset(). Can't we just do a pci_save/restore_state() before/aft=
er
> > pci_bus_reset() in vmd.c?
>=20
> I have not thought pci_save/restore_state() around pci_bus_reset()
> before.  It is an interesting direction.
>=20
> So, I prepare modification below for test.  Include "[PATCH v8 1/4]
> PCI: vmd: Set PCI devices to D0 before enable PCI PM's L1 substates",
> too.  Then, both the PCIe bridge and the PCIe device have the same
> LTR_L1.2_THRESHOLD 101376ns as expected.
>=20
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index bbf4a47e7b31..6b8dd4f30127 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -727,6 +727,18 @@ static void vmd_copy_host_bridge_flags(struct
> pci_host_bridge *root_bridge,
>         vmd_bridge->native_dpc =3D root_bridge->native_dpc;
>  }
>=20
> +static int vmd_pci_save_state(struct pci_dev *pdev, void *userdata)
> +{
> +       pci_save_state(pdev);
> +       return 0;
> +}
> +
> +static int vmd_pci_restore_state(struct pci_dev *pdev, void *userdata)
> +{
> +       pci_restore_state(pdev);
> +       return 0;
> +}
> +
>  /*
>   * Enable ASPM and LTR settings on devices that aren't configured by BIO=
S.
>   */
> @@ -927,6 +939,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd,
> unsigned long features)
>         pci_scan_child_bus(vmd->bus);
>         vmd_domain_reset(vmd);
>=20
> +       pci_walk_bus(vmd->bus, vmd_pci_save_state, NULL);
>         /* When Intel VMD is enabled, the OS does not discover the Root P=
orts
>          * owned by Intel VMD within the MMCFG space. pci_reset_bus() app=
lies
>          * a reset to the parent of the PCI device supplied as argument. =
This
> @@ -945,6 +958,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd,
> unsigned long features)
>                         break;
>                 }
>         }
> +       pci_walk_bus(vmd->bus, vmd_pci_restore_state, NULL);

Why not call pci_reset_bus() (or __pci_reset_bus()) then in=20
vmd_enable_domain() which preserves state unlike pci_reset_bus()?

(Don't tell me naming of these functions is a horrible mess. :-/)

--=20
 i.


>=20
>         pci_assign_unassigned_bus_resources(vmd->bus);
>=20
>=20
> Jian-Hong Pan
>=20
> > > > +
> > > >         link->aspm_default =3D pci_calc_aspm_enable_mask(state);
> > > >         pcie_config_aspm_link(link, policy_to_aspm_state(link));
> > > >
> > > > --
> > > > 2.45.2
> > > >
> > >
> > > Hi Nirmal and Paul,
> > >
> > > It will be great to have your review here.
> > >
> > > I had tried to "set the threshold value in vmd_pm_enable_quirk()"
> > > directly as Paul said [1].  However, it still needs to get the PCIe
> > > link from the PCIe device to set the threshold value.
> > > And, pci_enable_link_state_locked() gets the link. Then, it will be
> > > great to calculate and programm L1 sub-states' parameters properly
> > > before configuring the link's ASPM there.
> > >
> > > [1]:
> > > https://lore.kernel.org/linux-kernel/20240624081108.10143-2-jhp@endle=
ssos.org/T/#mc467498213fe1a6116985c04d714dae378976124
> > >
> > > Jian-Hong Pan
> >
>=20
--8323328-402323662-1723029534=:1138--

