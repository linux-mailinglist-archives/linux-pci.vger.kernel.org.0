Return-Path: <linux-pci+bounces-18501-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121399F314D
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 14:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B77601639DD
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 13:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E4019066D;
	Mon, 16 Dec 2024 13:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W8V08crD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C604F1119A;
	Mon, 16 Dec 2024 13:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734354733; cv=none; b=Bs+OJX6vbxasHf0fzCmduJSQS3zcWE6a6a3n6KjTGpjuIJZzcDJ2XDo9n3zvZ0xIvNKZ9RjitmO9Su9LOaBQ5Q3TA984hbEBQmt1Fqh0fWbmkfSRWQCrAj5kUNzr+amPGymdcSGbrFJKHvWHvLr4AoJYn0e2MNIkW/KNqL4I8Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734354733; c=relaxed/simple;
	bh=HR5XRJX2uwRRxUgogWrxKcaLUe14YMlruuHhky1uYFo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nbpA0YzScM1PIizjb4ay3svIsJsWh2h1Zf3QdQS1I0/i174QjU92v/XbnNl9iEfG8YkN6CDNTmGCmZepCZtLeTYx7ENu2VwG0yiZzRpA8QfeKZMPMdtcO9vJk1hcleSa747BXQ1TlkimfW5teWh35eU4yn3+IPGYN5xkCyZLMKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W8V08crD; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734354732; x=1765890732;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=HR5XRJX2uwRRxUgogWrxKcaLUe14YMlruuHhky1uYFo=;
  b=W8V08crDXCCGfNYVglkeVkmqYlFLjwbQJ1HERbT0UJOrXQzZYNVr3i+O
   1amBC+NapaN8E0TL83saIBsPGMvAI1x2MWNqn5bemUKEqbN8xWvqCyM9X
   4nY0JbCfLjRrtubQt5ZU1uDdOwOgdnUb6gAqd/sAcw1+iI13HYYnYeis7
   8H5FYHbooM2DTiOnxIXZWyfYuCV1bhYwcv7AS5ZmPFV26m4gjBmPE0m4J
   7U5z8KOjYjOEhjAGRivwXE8AgeLjL7fuTkwK4quzs6hcjzPKwLDQ/6seT
   XU80ymznZy1nkRs0SzRzaJ+4CCGfK8n96V04qZ60UmDbpiSu58Vg1pphg
   A==;
X-CSE-ConnectionGUID: WGidqSR3QvuwRzxatDbl5Q==
X-CSE-MsgGUID: BVRlAZItT1K6aQ5Mo+bcGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="34616793"
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; 
   d="scan'208";a="34616793"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 05:12:12 -0800
X-CSE-ConnectionGUID: yAZR0EbHTOaFFdtAZ+uYXg==
X-CSE-MsgGUID: 7nvxPvybQfukdarTEuZTCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; 
   d="scan'208";a="127997718"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 05:12:08 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 16 Dec 2024 15:12:04 +0200 (EET)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Jian-Hong Pan <jhp@endlessos.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
    Nirmal Patel <nirmal.patel@linux.intel.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux@endlessos.org, 
    "David E. Box" <david.e.box@linux.intel.com>
Subject: Re: [PATCH v13] PCI/ASPM: Make pci_save_aspm_l1ss_state save both
 child and parent's L1SS configuration
In-Reply-To: <20241213182845.GA3423569@bhelgaas>
Message-ID: <e3318648-b3cb-51c0-f879-0cb005a2ef36@linux.intel.com>
References: <20241213182845.GA3423569@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1224168302-1734354724=:941"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1224168302-1734354724=:941
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 13 Dec 2024, Bjorn Helgaas wrote:

> On Fri, Dec 13, 2024 at 12:37:24PM +0800, Jian-Hong Pan wrote:
> > Bjorn Helgaas <helgaas@kernel.org> =E6=96=BC 2024=E5=B9=B412=E6=9C=8813=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=887:03=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > > On Fri, Nov 15, 2024 at 03:22:02PM +0800, Jian-Hong Pan wrote:
> > > > PCI devices' parameters on the VMD bus have been programmed properl=
y
> > > > originally. But, cleared after pci_reset_bus() and have not been re=
stored
> > > > correctly. This leads the link's L1.2 between PCIe Root Port and ch=
ild
> > > > device gets wrong configs.
> > ...
>=20
> > > I think the important thing here is that currently
> > > pci_save_aspm_l1ss_state() saves only the child L1SS state, but
> > > pci_restore_aspm_l1ss_state() restores both parent and child, and the
> > > parent state is garbage.
> > >
> > > Obviously nothing specific to VMD or NVMe or SATA.
> > >
> > > > To avoid pci_restore_aspm_l1ss_state() restore wrong value to the p=
arent's
> > > > L1SS config like this example, make pci_save_aspm_l1ss_state() save=
 the
> > > > parent's L1SS config, if the PCI device has a parent.
> > >
> > > I tried to simplify the commit log and the patch so it's a little mor=
e
> > > parallel with pci_restore_aspm_l1ss_state().  Please comment and test=
=2E
> > >
> > > Bjorn
> > >
> > > commit c93935e3ac92 ("PCI/ASPM: Save parent L1SS config in pci_save_a=
spm_l1ss_state()")
> > > Author: Jian-Hong Pan <jhp@endlessos.org>
> > > Date:   Fri Nov 15 15:22:02 2024 +0800
> > >
> > >     PCI/ASPM: Save parent L1SS config in pci_save_aspm_l1ss_state()
> > >
> > >     After 17423360a27a ("PCI/ASPM: Save L1 PM Substates Capability fo=
r
> > >     suspend/resume"), pci_save_aspm_l1ss_state(dev) saves the L1SS st=
ate for
> > >     "dev", and pci_restore_aspm_l1ss_state(dev) restores the state fo=
r both
> > >     "dev" and its parent.
> > >
> > >     The problem is that unless pci_save_state() has been used in some=
 other
> > >     path and has already saved the parent L1SS state, we will restore=
 junk to
> > >     the parent, which means the L1 Substates likely won't work correc=
tly.
> > >
> > >     Save the L1SS config for both the device and its parent in
> > >     pci_save_aspm_l1ss_state().  When restoring, we need both because=
 L1SS must
> > >     be enabled at the parent (the Downstream Port) before being enabl=
ed at the
> > >     child (the Upstream Port).
> > >
> > >     Link: https://lore.kernel.org/r/20241115072200.37509-3-jhp@endles=
sos.org
> > >     Fixes: 17423360a27a ("PCI/ASPM: Save L1 PM Substates Capability f=
or suspend/resume")
> > >     Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218394
> > >     Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > >     Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> > >     [bhelgaas: parallel save/restore structure, simplify commit log]
> >=20
> > Thanks for the simplification!
> > Tested on my Asus B1400CEAE. Both the "dev" (NVMe) and the parent (PCI
> > bridge) keep the correct L1SS config.
> >=20
> > Tested-by: Jian-Hong Pan <jhp@endlessos.org>
>=20
> Thanks, I applied this on pci/aspm for v6.14 since this is a pretty
> old problem, and AFAICT it's a power consumption issue, not something
> that is functionally broken.  We might be able to make a case for
> v6.13 if my understanding is incorrect.
>=20
> Ilpo, David, I dropped your reviewed-by since I changed the patch
> significantly; let me know if you see any issue or if you want to add
> your reviewed-by.

The updated version seems fine too.

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--
 i.

> > > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > > index 28567d457613..e0bc90597dca 100644
> > > --- a/drivers/pci/pcie/aspm.c
> > > +++ b/drivers/pci/pcie/aspm.c
> > > @@ -81,24 +81,47 @@ void pci_configure_aspm_l1ss(struct pci_dev *pdev=
)
> > >
> > >  void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
> > >  {
> > > +       struct pci_dev *parent =3D pdev->bus->self;
> > >         struct pci_cap_saved_state *save_state;
> > > -       u16 l1ss =3D pdev->l1ss;
> > >         u32 *cap;
> > >
> > > +       /*
> > > +        * If this is a Downstream Port, we never restore the L1SS st=
ate
> > > +        * directly; we only restore it when we restore the state of =
the
> > > +        * Upstream Port below it.
> > > +        */
> > > +       if (pcie_downstream_port(pdev) || !parent)
> > > +               return;
> > > +
> > > +       if (!pdev->l1ss || !parent->l1ss)
> > > +               return;
> > > +
> > >         /*
> > >          * Save L1 substate configuration. The ASPM L0s/L1 configurat=
ion
> > >          * in PCI_EXP_LNKCTL_ASPMC is saved by pci_save_pcie_state().
> > >          */
> > > -       if (!l1ss)
> > > -               return;
> > > -
> > >         save_state =3D pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_L1=
SS);
> > >         if (!save_state)
> > >                 return;
> > >
> > >         cap =3D &save_state->cap.data[0];
> > > -       pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL2, cap++);
> > > -       pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL1, cap++);
> > > +       pci_read_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL2, cap++=
);
> > > +       pci_read_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL1, cap++=
);
> > > +
> > > +       if (parent->state_saved)
> > > +               return;
> > > +
> > > +       /*
> > > +        * Save parent's L1 substate configuration so we have it for
> > > +        * pci_restore_aspm_l1ss_state(pdev) to restore.
> > > +        */
> > > +       save_state =3D pci_find_saved_ext_cap(parent, PCI_EXT_CAP_ID_=
L1SS);
> > > +       if (!save_state)
> > > +               return;
> > > +
> > > +       cap =3D &save_state->cap.data[0];
> > > +       pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL2, c=
ap++);
> > > +       pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1, c=
ap++);
> > >  }
> > >
> > >  void pci_restore_aspm_l1ss_state(struct pci_dev *pdev)
>=20
--8323328-1224168302-1734354724=:941--

