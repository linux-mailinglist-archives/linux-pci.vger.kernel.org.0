Return-Path: <linux-pci+bounces-13562-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 004E298745B
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 15:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5CC5280E6E
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 13:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549D31CAB8;
	Thu, 26 Sep 2024 13:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BnTk6fxv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0241E19BBC;
	Thu, 26 Sep 2024 13:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727356956; cv=none; b=gMeKJ+sp/fJP0avUhK1ItH+sZve5Z88do/MHehYgDiON6z4SyWNDvyiVPPhhlo7A53baDK7fDAH7dx7TdxZuiH7wPsK7u9rC9Hs0YWT9Pa3lVpQHwRAqqiVQAEDsmZslMk0ZnVWu+K24FBjUfaWgFfxP8zlPtjtODwUpAbz/dqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727356956; c=relaxed/simple;
	bh=grxXbyhvccywduKz9j+WojLrYDCs/yeACrqXh8j996o=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nAm6Y42doN2J1XLZ5HF6pd2jz2cDxpwuaPrrQL4ENztXRFYKdAeLvd/heu3RNo7aahVXXlDuupFAshkniP8ylA8/WtJIkFNMjomu7u8DE7KVeWsw00VU58zhFcHkhijkmrtGY8X5gNF9iO7TaiLxnPMlBfgQAp1lH9eea7m4RlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BnTk6fxv; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727356953; x=1758892953;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=grxXbyhvccywduKz9j+WojLrYDCs/yeACrqXh8j996o=;
  b=BnTk6fxvdtYO2ojFfgBwoho0KusQr3RR4eLp+syNMVMtXVgyLxq1sLiw
   wyMzZ+Ubbvbnv4MASh8Y+5x0KrhpDjGRnGrFcxd0sjhJJOfuEzbY4rq4E
   lBwiU5ijlIgOlapPm5mbgzfgXFeUi585h00khM0Seq5WldvF23ZfCmkCI
   OK53ALF6EvHe7cfqg3ND591CzpmXSqahYQukac7MzRzKZTAmQACHSrI2r
   RSRudL6LV7f9p+dubwVl7QWR1Nog+fbXfQCO/PYwvItx1+kH8XabtFQ1N
   Xe8RplMPIdBsFg+GE0yoRtEbcnaFxKdSPQqZGnxTe1XEVP9z/gV8GKcxE
   Q==;
X-CSE-ConnectionGUID: EaiWgioZS/C6jXjmbOBrFQ==
X-CSE-MsgGUID: S5sdO2O4Q7aEr1/bNVb5Zg==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="26314481"
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="26314481"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 06:22:32 -0700
X-CSE-ConnectionGUID: OnfzrkkST2m5azN+uZbNZA==
X-CSE-MsgGUID: Ygwxg8zNSQy4oHEeEkgPaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="72154766"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.208])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 06:22:28 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 26 Sep 2024 16:22:25 +0300 (EEST)
To: Jian-Hong Pan <jhp@endlessos.org>
cc: david.e.box@linux.intel.com, Bjorn Helgaas <helgaas@kernel.org>, 
    Johan Hovold <johan@kernel.org>, 
    Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
    Nirmal Patel <nirmal.patel@linux.intel.com>, 
    Jonathan Derrick <jonathan.derrick@linux.dev>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux@endlessos.org
Subject: Re: [PATCH v9 3/3] PCI: vmd: Save/restore PCIe bridge states
 before/after pci_reset_bus()
In-Reply-To: <44275137-97fc-3da9-c01a-6e747c236c8e@linux.intel.com>
Message-ID: <7ddc91f4-a68e-7186-0a02-ba0fdf1a718c@linux.intel.com>
References: <20240924070551.14976-2-jhp@endlessos.org> <20240924072858.15929-3-jhp@endlessos.org> <8050f9d4cb851fc301cc35b4fb5a839ff71fdcae.camel@linux.intel.com> <CAPpJ_ed09KJY9Gw2qGwOHdKFw4-BAMyG6jOyWHnV7brJutwfVw@mail.gmail.com>
 <44275137-97fc-3da9-c01a-6e747c236c8e@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-908422928-1727356945=:1148"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-908422928-1727356945=:1148
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 26 Sep 2024, Ilpo J=C3=A4rvinen wrote:

> On Thu, 26 Sep 2024, Jian-Hong Pan wrote:
>=20
> > David E. Box <david.e.box@linux.intel.com> =E6=96=BC 2024=E5=B9=B49=E6=
=9C=8826=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8810:51=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > >
> > > Hi Jian-Hong,
> > >
> > > On Tue, 2024-09-24 at 15:29 +0800, Jian-Hong Pan wrote:
> > > > PCI devices' parameters on the VMD bus have been programmed properl=
y
> > > > originally. But, cleared after pci_reset_bus() and have not been re=
stored
> > > > correctly. This leads the link's L1.2 between PCIe Root Port and ch=
ild
> > > > device gets wrong configs.
> > > >
> > > > Here is a failed example on ASUS B1400CEAE with enabled VMD. Both P=
CIe
> > > > bridge and NVMe device should have the same LTR1.2_Threshold value.
> > > > However, they are configured as different values in this case:
> > > >
> > > > 10000:e0:06.0 PCI bridge [0604]: Intel Corporation 11th Gen Core Pr=
ocessor
> > > > PCIe Controller [8086:9a09] (rev 01) (prog-if 00 [Normal decode])
> > > >   ...
> > > >   Capabilities: [200 v1] L1 PM Substates
> > > >     L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM=
_Substates+
> > > >       PortCommonModeRestoreTime=3D45us PortTPowerOnTime=3D50us
> > > >     L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > > >       T_CommonMode=3D0us LTR1.2_Threshold=3D0ns
> > > >     L1SubCtl2: T_PwrOn=3D0us
> > > >
> > > > 10000:e1:00.0 Non-Volatile memory controller [0108]: Sandisk Corp W=
D Blue
> > > > SN550 NVMe SSD [15b7:5009] (rev 01) (prog-if 02 [NVM Express])
> > > >   ...
> > > >   Capabilities: [900 v1] L1 PM Substates
> > > >     L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM=
_Substates+
> > > >       PortCommonModeRestoreTime=3D32us PortTPowerOnTime=3D10us
> > > >     L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > > >       T_CommonMode=3D0us LTR1.2_Threshold=3D101376ns
> > > >     L1SubCtl2: T_PwrOn=3D50us
> > > >
> > > > Here is VMD mapped PCI device tree:
> > > >
> > > > -+-[0000:00]-+-00.0  Intel Corporation Device 9a04
> > > >  | ...
> > > >  \-[10000:e0]-+-06.0-[e1]----00.0  Sandisk Corp WD Blue SN550 NVMe =
SSD
> > > >               \-17.0  Intel Corporation Tiger Lake-LP SATA Controll=
er
> > > >
> > > > When pci_reset_bus() resets the bus [e1] of the NVMe, it only saves=
 and
> > > > restores NVMe's state before and after reset. Because bus [e1] has =
only one
> > > > device: 10000:e1:00.0 NVMe. The PCIe bridge is missed. However, whe=
n it
> > > > restores the NVMe's state, it also restores the ASPM L1SS between t=
he PCIe
> > > > bridge and the NVMe by pci_restore_aspm_l1ss_state(). The NVMe's L1=
SS is
> > > > restored correctly. But, the PCIe bridge's L1SS is restored with th=
e wrong
> > > > value 0x0. Becuase, the PCIe bridge's state is not saved before res=
et.
> > > > That is why pci_restore_aspm_l1ss_state() gets the parent device (P=
CIe
> > > > bridge)'s saved state capability data and restores L1SS with value =
0.
> > > >
> > > > So, save the PCIe bridge's state before pci_reset_bus(). Then, rest=
ore the
> > > > state after pci_reset_bus(). The restoring state also consumes the =
saving
> > > > state.
> > > >
> > > > Link: https://www.spinics.net/lists/linux-pci/msg159267.html
> > > > Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> > > > ---
> > > > v9:
> > > > - Drop the v8 fix about drivers/pci/pcie/aspm.c. Use this in VMD in=
stead.
> > > >
> > > >  drivers/pci/controller/vmd.c | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > >
> > > > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/=
vmd.c
> > > > index 11870d1fc818..2820005165b4 100644
> > > > --- a/drivers/pci/controller/vmd.c
> > > > +++ b/drivers/pci/controller/vmd.c
> > > > @@ -938,9 +938,16 @@ static int vmd_enable_domain(struct vmd_dev *v=
md,
> > > > unsigned long features)
> > > >               if (!list_empty(&child->devices)) {
> > > >                       dev =3D list_first_entry(&child->devices,
> > > >                                              struct pci_dev, bus_li=
st);
> > >
> > > Newline here
> > > > +                     /* To avoid pci_reset_bus restore wrong ASPM =
L1SS
> > > > +                      * configuration due to missed saving parent =
device's
> > > > +                      * states, save & restore the parent device's=
 states
> > > > +                      * as well.
> > > > +                      */
> > >
> > > No text on first line of comment.
> >=20
> > Oops!  Thanks
> >=20
> > >     /*
> > >      * To avoid pci_reset_bus restore wrong ASPM L1SS
> > >      * ...
> > >      */
> > >
> > > > +                     pci_save_state(dev->bus->self);
> > > >                       ret =3D pci_reset_bus(dev);
> > > >                       if (ret)
> > > >                               pci_warn(dev, "can't reset device: %d=
\n",
> > > > ret);
> > > > +                     pci_restore_state(dev->bus->self);
> > >
> > > I think Ilpo's point was that pci_save_aspm_l1ss_state() and
> > > pci_restore_aspm_l1ss_state() should be more symmetric. If
> > > pci_save_aspm_l1ss_state() is changed to also handle the state for th=
e device
> > > and its parent in the same call, then no change is needed here. But t=
hat would
> > > only handle L1SS settings and not anything else that might need to be=
 restored
> > > after the bus reset. So I'm okay with it either way.
>=20
> Why would something else need to be restored? The spec explicitly says th=
e=20
> bus reset should not cause config changes on the parent other than=20
> to status bits.
>=20
> Based on what is seen so far, the problem here is not the reset itself=20
> breaking parent's config but ASPM code restoring values from state beyond=
=20
> what it had saved and thus it programs pseudogarbage into the L1SS=20
> settings.
>=20
> > Yes, that made me think the whole day before I sent out this patch. I
> > do not know what is the best reset bus procedure, especially how other
> > drivers reset the bus.
> >=20
> > If trace the code path:
> > pci_reset_bus()
> >   __pci_reset_bus()
> >     pci_bus_reset()
> >       pci_bus_save_and_disable_locked()
> >=20
> > pci_bus_save_and_disable_locked()'s comment shows "Save and disable
> > devices from the top of the tree down while holding the @dev mutex
> > lock for the entire tree". I think that means the PCI(e) bridge should
> > save state first, then the following bus' devices. However, VMD resets
> > the child device (10000:e1:00.0 NVMe)'s bus first and only saves the
> > child device (10000:e1:00.0 NVMe)'s state. It does not visit the tree
> > from the top to down. So, it misses the PCIe bridge.  Therefore, I
> > make it save & restore its parent (10000:e0:06.0 PCIe bridge)'s state
> > as compensation.
>=20
> The problem with your fix is it only takes care of part of the cases (i.e=
=2E=20
> VMD). But there are other callers of pci_reset_bus() which would also=20
> restore incorrect L1SS settings, no?
>=20
> I'd suggest making the L1SS code symmetric on this, even if it means=20
> saving the register value twice when walking the tree downwards (it seems=
=20
> harmless to write the same value twice).

Perhaps parent->state_saved =3D=3D true could even be used to avoid doing i=
t=20
twice/unnecessarily if the parent is already saved.

--=20
 i.

--8323328-908422928-1727356945=:1148--

