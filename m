Return-Path: <linux-pci+bounces-13706-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1140098CE54
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 10:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 348C61C2119C
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 08:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0333194A73;
	Wed,  2 Oct 2024 08:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uj/40B8H"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E24194A45;
	Wed,  2 Oct 2024 08:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727856171; cv=none; b=G1j1z+WjTfjqsybMHsqhzS/vjHJfJuchrDfLO4Cm6VFfxhdUOiaejzd320ZvDfav2FT2KlMNimNzdT3glSdVDe0iG4ZTnmxn3OB1EFBw/MjH0ZfLTwW//5gOCFEmVgXh6JOGgcfXPGsZa5+gQMtHsT/39Gw/MdTlmtfyUgOPCdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727856171; c=relaxed/simple;
	bh=ggCowaCdQwXRHWd+YmFhvpSzviPL5tf0cn0ZrAUBFiA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kgd2UbdEeB+yoTJ6nCesOlEwW/doD/lXU6cCp1S3MJptA5ZmSEuHogkHtsatj4v4VByi0Ip7eEnNQJR0222FmMg/NmUcLLh6y9WHougurZgm9CCMnWMh/dY9y/g/9WHaWozt7Nl6oyB3uY0H8hMz6Cp+BI6niXPKKbBBCfYDXDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uj/40B8H; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727856170; x=1759392170;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=ggCowaCdQwXRHWd+YmFhvpSzviPL5tf0cn0ZrAUBFiA=;
  b=Uj/40B8HvkvojEDcWGi99MZC9EWYXyvp3VQjAp9xCoBqyo7FQtFUuPTr
   7kgqIIEjQSL69iAe2mqoOEfH0p9f11GE5P91yVBLVIQmTjp8hFKimUah3
   KgGOoMVFChFk5QUfAz1zZiAPBiFw+NbNa2tSWXB/7G5ZUqfyWNNa6F1Rp
   vGT0tnjf3Phz+FLBvrfhCXpkq/JOqxYHu94GJ8VJvvaz6UMdd4kAZaxt/
   AJhhjXr4zUGzTHkP2bPjDmXJiYmPC/+ChnaAXSGJ2Z8iYLs6JwlA0qTlN
   GNAfmbwWzZy1qyxsDjyQ0yfPCIJJe4kYoJCZNeeDH/k+9Ey+zoXeYsNeA
   w==;
X-CSE-ConnectionGUID: Nvr2fGClTxyewf0IdXoqYQ==
X-CSE-MsgGUID: aKdYWBdqTjmCURuZ+jjkJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="44537514"
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="44537514"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 01:02:49 -0700
X-CSE-ConnectionGUID: 3SCt58XsSqSY+NeKiNEt1w==
X-CSE-MsgGUID: iA/lt6d3S3uF4dGp8SyW/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="73809301"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.31])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 01:02:45 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 2 Oct 2024 11:02:41 +0300 (EEST)
To: "David E. Box" <david.e.box@linux.intel.com>
cc: Jian-Hong Pan <jhp@endlessos.org>, Bjorn Helgaas <helgaas@kernel.org>, 
    Johan Hovold <johan@kernel.org>, 
    Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
    Nirmal Patel <nirmal.patel@linux.intel.com>, 
    Jonathan Derrick <jonathan.derrick@linux.dev>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux@endlessos.org
Subject: Re: [PATCH v12 3/3] PCI/ASPM: Make pci_save_aspm_l1ss_state save
 both child and parent's L1SS configuration
In-Reply-To: <f6745fbafbcb25a560bf7e342523570a4158136a.camel@linux.intel.com>
Message-ID: <b1dd3463-74ee-7d3c-4258-6ca37358c2cf@linux.intel.com>
References: <20241001083438.10070-2-jhp@endlessos.org>  <20241001083438.10070-8-jhp@endlessos.org> <f6745fbafbcb25a560bf7e342523570a4158136a.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1310662475-1727856013=:933"
Content-ID: <6620c943-542c-b742-a9f4-8402602775b8@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1310662475-1727856013=:933
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <e945454d-9049-4eec-8b28-ba2f241d478a@linux.intel.com>

On Tue, 1 Oct 2024, David E. Box wrote:

> Hi Jian-Hong,
>=20
> On Tue, 2024-10-01 at 16:34 +0800, Jian-Hong Pan wrote:
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
sor
> > PCIe Controller [8086:9a09] (rev 01) (prog-if 00 [Normal decode])
> > =A0 ...
> > =A0 Capabilities: [200 v1] L1 PM Substates
> > =A0=A0=A0 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_=
PM_Substates+
> > =A0=A0=A0=A0=A0 PortCommonModeRestoreTime=3D45us PortTPowerOnTime=3D50u=
s
> > =A0=A0=A0 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > =A0=A0=A0=A0=A0 T_CommonMode=3D0us LTR1.2_Threshold=3D0ns
> > =A0=A0=A0 L1SubCtl2: T_PwrOn=3D0us
> >=20
> > 10000:e1:00.0 Non-Volatile memory controller [0108]: Sandisk Corp WD Bl=
ue
> > SN550 NVMe SSD [15b7:5009] (rev 01) (prog-if 02 [NVM Express])
> > =A0 ...
> > =A0 Capabilities: [900 v1] L1 PM Substates
> > =A0=A0=A0 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_=
PM_Substates+
> > =A0=A0=A0=A0=A0 PortCommonModeRestoreTime=3D32us PortTPowerOnTime=3D10u=
s
> > =A0=A0=A0 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > =A0=A0=A0=A0=A0 T_CommonMode=3D0us LTR1.2_Threshold=3D101376ns
> > =A0=A0=A0 L1SubCtl2: T_PwrOn=3D50us
> >=20
> > Here is VMD mapped PCI device tree:
> >=20
> > -+-[0000:00]-+-00.0=A0 Intel Corporation Device 9a04
> > =A0| ...
> > =A0\-[10000:e0]-+-06.0-[e1]----00.0=A0 Sandisk Corp WD Blue SN550 NVMe =
SSD
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \-17.0=A0 Intel Corporation Tig=
er Lake-LP SATA Controller
> >=20
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
> >=20
> > So, if the PCI device has a parent, make pci_save_aspm_l1ss_state() sav=
e
> > the parent's L1SS configuration, too. This is symmetric on
> > pci_restore_aspm_l1ss_state().
> >=20
> > Link:
> > https://lore.kernel.org/linux-pci/CAPpJ_eexU0gCHMbXw_z924WxXw0+B6SdS4eG=
9oGpEX1wmnMLkQ@mail.gmail.com/
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218394
> > Fixes: 17423360a27a ("PCI/ASPM: Save L1 PM Substates Capability for
> > suspend/resume")
> > Suggested-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
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
> > =A0 and pci_restore_aspm_l1ss_state()
> >=20
> > v11:
> > - Introduce __pci_save_aspm_l1ss_state as a resusable helper function
> > =A0 which is same as the original pci_configure_aspm_l1ss
> > - Make pci_save_aspm_l1ss_state invoke __pci_save_aspm_l1ss_state for
> > =A0 both child and parent devices
> > - Smooth the commit message
> >=20
> > v12:
> > - Update the commit message
> >=20
> > =A0drivers/pci/pcie/aspm.c | 20 +++++++++++++++++++-
> > =A01 file changed, 19 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index bd0a8a05647e..17cdf372f7e0 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -79,7 +79,7 @@ void pci_configure_aspm_l1ss(struct pci_dev *pdev)
> > =A0=09=09=09ERR_PTR(rc));
> > =A0}
> > =A0
> > -void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
> > +static void __pci_save_aspm_l1ss_state(struct pci_dev *pdev)
> > =A0{
> > =A0=09struct pci_cap_saved_state *save_state;
> > =A0=09u16 l1ss =3D pdev->l1ss;
> > @@ -101,6 +101,24 @@ void pci_save_aspm_l1ss_state(struct pci_dev *pdev=
)
> > =A0=09pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL1, cap++);
> > =A0}
> > =A0
> > +void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
> > +{
> > +=09struct pci_dev *parent;
> > +
> > +=09__pci_save_aspm_l1ss_state(pdev);
> > +
> > +=09/*
> > +=09 * To be symmetric on pci_restore_aspm_l1ss_state(), save parent's =
L1
> > +=09 * substate configuration, if the parent has not saved state.
> > +=09 */
> > +=09if (!pdev->bus || !pdev->bus->self)
> > +=09=09return;
> > +
> > +=09parent =3D pdev->bus->self;
> > +=09if (!parent->state_saved)
> > +=09=09__pci_save_aspm_l1ss_state(parent);
> > +}
> > +
> > =A0void pci_restore_aspm_l1ss_state(struct pci_dev *pdev)
> > =A0{
> > =A0=09struct pci_cap_saved_state *pl_save_state, *cl_save_state;
>=20
> This took a while to debug and find a solution. Thanks for continuing to =
work on
> this.
>=20
> Reviewed-by: David E. Box <david.e.box@linux.intel.com

The tag is missing the closing >.=20

Repeating the correct one here for the purpose of patchwork to pick up the=
=20
correct tag:

Reviewed-by: David E. Box <david.e.box@linux.intel.com>

=2E..But I suppose patchwork might now record both the wrong and the correc=
t=20
tag so heads up to maintainers if applying this version of the patch.

--=20
 i.
--8323328-1310662475-1727856013=:933--

