Return-Path: <linux-pci+bounces-16113-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 226F19BE4DC
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 11:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4264C1C20E0B
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 10:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA191DD525;
	Wed,  6 Nov 2024 10:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jcavy66q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A844E193094;
	Wed,  6 Nov 2024 10:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730890461; cv=none; b=dx0GhxaALdtdAXLtJoatJzstXxGbm3+CwlwzMAugghDTtTB+Hb3Ke3VVK8MRleO7pSpt37neBJlUPhIuyuzN1g19tEz8oi3Fbf+a9rXKlk9ZizuMUMoZi59vMsvs2QH9vG9QXoDIlQGU8VLbpsGWqbEqcD1+flm432TxvtkKjpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730890461; c=relaxed/simple;
	bh=EVLel/BpIW9ZJ2k6oBxp60z3pvlEjqawY1CsripKoLk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cW0o87bJmQX1Hl+3HFKtWargquFh1RYW3KwsuxeY7TctK7zE5KFf/fyL8fLdEFO7/JW7XZYAcsbr+WTm13whl1hwN3bE1vAvPsR/qKkdj6xYCx86PNCJzfdL0Gk88fmUgJz5Favl7l4rG/2+/OyZdJY2Zinmoq2VcpQVS5ArcUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jcavy66q; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730890460; x=1762426460;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=EVLel/BpIW9ZJ2k6oBxp60z3pvlEjqawY1CsripKoLk=;
  b=Jcavy66q4hjg8Ngv2OSvkrqwOcxhLJ0Y0cngjQ/iorBnYyGm4mr6ca2z
   ni8P0bMzGu/vyiVWMF1jrRSjaOhI18Y/uiqstzYdn/HRExrRqguC9BuUW
   vQUefiGVRDJ1mepWbdEYlsFRRbXsxZp9ZgerrX0yPx4S03lsL+cM1+www
   eXrnRmv3bEEnFDuVTnKAk+Z38AZwoNjvroJqH7R8bu9EOr6DOXkgqv1Sb
   ifsF0B9d2KXmA6seljV+MJcE3g3iJJNNVzjI/s450PukgbaMiSPFfKIkw
   s+Kt9yr0K+bTx2edEMqKwUIxnh0M72eJiBGlX7kYi8IgcHRXJ2SyvAyqZ
   w==;
X-CSE-ConnectionGUID: 07eHyPI9SUW4sLMpwI+CsQ==
X-CSE-MsgGUID: v/O5i9JNTDugloGiRuL9qA==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="18302276"
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="18302276"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 02:54:19 -0800
X-CSE-ConnectionGUID: SkB0hNp0T0OHzWshhSB97Q==
X-CSE-MsgGUID: 4ruixzv0QDakWrKF0eaUcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="121994029"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.110])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 02:54:15 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 6 Nov 2024 12:54:12 +0200 (EET)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Jian-Hong Pan <jhp@endlessos.org>, Johan Hovold <johan@kernel.org>, 
    David Box <david.e.box@linux.intel.com>, 
    Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
    Nirmal Patel <nirmal.patel@linux.intel.com>, 
    Jonathan Derrick <jonathan.derrick@linux.dev>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux@endlessos.org
Subject: Re: [PATCH v12 3/3] PCI/ASPM: Make pci_save_aspm_l1ss_state save
 both child and parent's L1SS configuration
In-Reply-To: <20241105225949.GA1493775@bhelgaas>
Message-ID: <04b86150-c6f5-2898-5b43-dcf14c19845e@linux.intel.com>
References: <20241105225949.GA1493775@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-371933605-1730890452=:928"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-371933605-1730890452=:928
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 5 Nov 2024, Bjorn Helgaas wrote:

> On Tue, Oct 01, 2024 at 04:34:42PM +0800, Jian-Hong Pan wrote:
> > PCI devices' parameters on the VMD bus have been programmed properly
> > originally. But, cleared after pci_reset_bus() and have not been restor=
ed
> > correctly. This leads the link's L1.2 between PCIe Root Port and child
> > device gets wrong configs.
> >=20
> > Here is a failed example on ASUS B1400CEAE with enabled VMD. Both PCIe
> > bridge and NVMe device should have the same LTR1.2_Threshold value.
> > However, they are configured as different values in this case:
> >=20
> > 10000:e0:06.0 PCI bridge [0604]: Intel Corporation 11th Gen Core Proces=
sor PCIe Controller [8086:9a09] (rev 01) (prog-if 00 [Normal decode])
> >   ...
> >   Capabilities: [200 v1] L1 PM Substates
> >     L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Sub=
states+
> >       PortCommonModeRestoreTime=3D45us PortTPowerOnTime=3D50us
> >     L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> >       T_CommonMode=3D0us LTR1.2_Threshold=3D0ns
> >     L1SubCtl2: T_PwrOn=3D0us
> >=20
> > 10000:e1:00.0 Non-Volatile memory controller [0108]: Sandisk Corp WD Bl=
ue SN550 NVMe SSD [15b7:5009] (rev 01) (prog-if 02 [NVM Express])
> >   ...
> >   Capabilities: [900 v1] L1 PM Substates
> >     L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Sub=
states+
> >       PortCommonModeRestoreTime=3D32us PortTPowerOnTime=3D10us
> >     L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> >       T_CommonMode=3D0us LTR1.2_Threshold=3D101376ns
> >     L1SubCtl2: T_PwrOn=3D50us
> >=20
> > Here is VMD mapped PCI device tree:
> >=20
> > -+-[0000:00]-+-00.0  Intel Corporation Device 9a04
> >  | ...
> >  \-[10000:e0]-+-06.0-[e1]----00.0  Sandisk Corp WD Blue SN550 NVMe SSD
> >               \-17.0  Intel Corporation Tiger Lake-LP SATA Controller
> >
> > When pci_reset_bus() resets the bus [e1] of the NVMe, it only saves and
> > restores NVMe's state before and after reset. Then, when it restores th=
e
> > NVMe's state, ASPM code restores L1SS for both the parent bridge and th=
e
> > NVMe in pci_restore_aspm_l1ss_state(). The NVMe's L1SS is restored
> > correctly. But, the parent bridge's L1SS is restored with a wrong value=
 0x0
> > because the parent bridge's L1SS wasn't saved by pci_save_aspm_l1ss_sta=
te()
> > before reset.
>=20
> There's nothing specific to VMD here, is there?  This whole log looks
> like it should be made generic.  The VMD *example* is OK, but the
> justification should not be VMD-specific.  This last paragraph seems
> to be the kernel of the whole thing, and I don't think it's specific
> to either VMD or NVMe.
>=20
> > So, if the PCI device has a parent, make pci_save_aspm_l1ss_state() sav=
e
> > the parent's L1SS configuration, too. This is symmetric on
> > pci_restore_aspm_l1ss_state().
> >=20
> > Link: https://lore.kernel.org/linux-pci/CAPpJ_eexU0gCHMbXw_z924WxXw0+B6=
SdS4eG9oGpEX1wmnMLkQ@mail.gmail.com/
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218394
> > Fixes: 17423360a27a ("PCI/ASPM: Save L1 PM Substates Capability for sus=
pend/resume")
> > Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> > ---
> > v9:
> > - Drop the v8 fix about drivers/pci/pcie/aspm.c. Use this in VMD instea=
d.
> >=20
> > v10:
> > - Drop the v9 fix about drivers/pci/controller/vmd.c
> > - Fix in PCIe ASPM to make it symmetric between pci_save_aspm_l1ss_stat=
e()
> >   and pci_restore_aspm_l1ss_state()
> >=20
> > v11:
> > - Introduce __pci_save_aspm_l1ss_state as a resusable helper function
> >   which is same as the original pci_configure_aspm_l1ss
> > - Make pci_save_aspm_l1ss_state invoke __pci_save_aspm_l1ss_state for
> >   both child and parent devices
> > - Smooth the commit message
> >=20
> > v12:
> > - Update the commit message
> >=20
> >  drivers/pci/pcie/aspm.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index bd0a8a05647e..17cdf372f7e0 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -79,7 +79,7 @@ void pci_configure_aspm_l1ss(struct pci_dev *pdev)
> >  =09=09=09ERR_PTR(rc));
> >  }
> > =20
> > -void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
> > +static void __pci_save_aspm_l1ss_state(struct pci_dev *pdev)
> >  {
> >  =09struct pci_cap_saved_state *save_state;
> >  =09u16 l1ss =3D pdev->l1ss;
> > @@ -101,6 +101,24 @@ void pci_save_aspm_l1ss_state(struct pci_dev *pdev=
)
> >  =09pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL1, cap++);
> >  }
> > =20
> > +void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
> > +{
> > +=09struct pci_dev *parent;
> > +
> > +=09__pci_save_aspm_l1ss_state(pdev);
>=20
> Is there any point in saving the "pdev" state if there's no parent?
>=20
> > +=09/*
> > +=09 * To be symmetric on pci_restore_aspm_l1ss_state(), save parent's =
L1
> > +=09 * substate configuration, if the parent has not saved state.
> > +=09 */
> > +=09if (!pdev->bus || !pdev->bus->self)
> > +=09=09return;
>=20
> Is "pdev->bus =3D=3D NULL" possible here even though it doesn't seem
> possible in pci_restore_aspm_l1ss_state()?
>=20
> > +=09parent =3D pdev->bus->self;
> > +=09if (!parent->state_saved)
> > +=09=09__pci_save_aspm_l1ss_state(parent);
> > +}
>=20
> I see the suggestion for a helper here, but I'm not convinced.
> pci_save_aspm_l1ss_state() and pci_restore_aspm_l1ss_state() should
> *look* similar, and a helper makes them less similar.
>=20
> I think you should go to some effort to follow the
> pci_restore_aspm_l1ss_state() structure, as much as possible doing the
> same declarations, checks, and lookups in the same order, e.g.:
>
>   struct pci_cap_saved_state *pl_save_state, *cl_save_state;
>   struct pci_dev *parent =3D pdev->bus->self;
>=20
>   if (pcie_downstream_port(pdev) || !parent)
> =09  return;
>=20
>   if (!pdev->l1ss || !parent->l1ss)
> =09  return;
>=20
>   cl_save_state =3D pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_L1SS);
>   pl_save_state =3D pci_find_saved_ext_cap(parent, PCI_EXT_CAP_ID_L1SS);
>   if (!cl_save_state || !pl_save_state)
> =09  return;

Hi,

I understand I'm not the one who has the final say in this, but the reason=
=20
why restore has to be done the way it is (the long way), is because of the=
=20
strict ordering requirement of operations it performs.

There are no similar ordering requirements on the save side AFAIK.

--=20
 i.

--8323328-371933605-1730890452=:928--

