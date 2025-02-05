Return-Path: <linux-pci+bounces-20729-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD34EA285B1
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 09:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8470F1884C97
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 08:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7937422A1E2;
	Wed,  5 Feb 2025 08:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZKXMwOD/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4577A25A647;
	Wed,  5 Feb 2025 08:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738744716; cv=none; b=GGVUNkWNZ5DluQr2p3HfTMvq9r3c13cRfH/3NJIix7MqD3dz9oWwBeDlH7SWO36CAYEkyY4vjLo02qvJBSfFNv0TVUS4LzZifOU60pmuh2yCiVfs9IPhB31RLJB/gzkU4Cy82Jxsr/EEO2QJvrJYT2fuX0vDvx0xwZn7Opi/fX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738744716; c=relaxed/simple;
	bh=hCn8Ja0aF5qI1W8zJGAjEyMWnMlwnm7iTjUTLNxsfrE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=S0DEg8dpE52x+o2cyQ8wWAjVZcI3iq6Kti1QRRqk/HxnTRZ9mEqSJBCDgzOJNPDn6eaEvx80UYBtijPtwkTFIkl2gl83E424UuozgYAWnwd30Q2Q959QTe7L4FJKlWfKxUYytoMvER8xGWHZxecRVmnLAGVzLd9G0aFTKhXD3qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZKXMwOD/; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738744715; x=1770280715;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=hCn8Ja0aF5qI1W8zJGAjEyMWnMlwnm7iTjUTLNxsfrE=;
  b=ZKXMwOD/RiWH16XtzLUqumeF5pG4O4MzMOz+u091juLw7fS1EJKtsT1e
   uSzLsBfqyczDTzIB73Kmi0bR/ibVSTnF5+oTEOtHTJCgbhw0cr02kNrP9
   YiX0QNkKjl1qB9v8PTUH/WLifdi1FCLEEA0Tn49+WqGbK9VXe9anNrGK4
   KOGJWGX4nAhrePMRS2AbQjX44CtwVAjpSQtkEIx4ygrPIYdsSuVtQqxLZ
   27Woj8qVQhleC0rarIZcTXhE4Oqfx8OTKhQMDSK83cFYWE3DUTe9UCvIZ
   mwVpJA0G9ikM00O0Cz2o4h/zco9oARwOBB1I89ex8sQa8HwCG81kzmfeY
   w==;
X-CSE-ConnectionGUID: yA1eDlrkRsSlZN2hHLHTlA==
X-CSE-MsgGUID: scKuQkXvRMSvp1MUkNJEXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="42959023"
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; 
   d="scan'208";a="42959023"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 00:38:32 -0800
X-CSE-ConnectionGUID: s9SjnFjWQeu+4HEZiq/9VA==
X-CSE-MsgGUID: Faohey4BRkmGPmuZsWK0JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="110819020"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.255])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 00:38:28 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 5 Feb 2025 10:38:24 +0200 (EET)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Bjorn Helgaas <bhelgaas@google.com>, Jian-Hong Pan <jhp@endlessos.org>, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    =?UTF-8?Q?Nikl=C4=81vs_Ko=C4=BCes=C5=86ikovs?= <pinkflames.linux@gmail.com>, 
    "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/1] PCI/ASPM: Fix L1SS saving
In-Reply-To: <20250204203936.GA860339@bhelgaas>
Message-ID: <167dfe31-89cb-6135-aafc-ece0cb234daa@linux.intel.com>
References: <20250204203936.GA860339@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1665104094-1738743386=:1070"
Content-ID: <493144ab-66ef-a752-cf72-761c1caefffa@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1665104094-1738743386=:1070
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <14f2b18f-e2ff-1440-6b17-6ae62f125f79@linux.intel.com>

On Tue, 4 Feb 2025, Bjorn Helgaas wrote:

> [+cc Rafael]
>=20
> On Fri, Jan 31, 2025 at 05:29:13PM +0200, Ilpo J=C3=A4rvinen wrote:
> > The commit 1db806ec06b7 ("PCI/ASPM: Save parent L1SS config in
> > pci_save_aspm_l1ss_state()") aimed to perform L1SS config save for both
> > the Upstream Port and its upstream bridge when handling an Upstream
> > Port, which matches what the L1SS restore side does. However,
> > parent->state_saved can be set true at an earlier time when the
> > upstream bridge saved other parts of its state.=20
>=20
> So I guess the scenario is that we got here because some driver called
> pci_save_state(pdev):
>=20
>   pci_save_state
>     dev->state_saved =3D true                <--
>     pci_save_pcie_state
>       pci_save_aspm_l1ss_state
>         if (pcie_downstream_port(pdev))
>           return
>         # save pdev L1SS state here
>         if (parent->state_saved)           <--
>           return
>         # save parent L1SS state here
>=20
> and the problem is that we previously called pci_save_state(parent),
> which set "parent->state_saved =3D true" but did not save its L1SS state
> because pci_save_aspm_l1ss_state() is a no-op for Downstream Ports,
> right?

Yes! An unfortunate interaction between those two checks.

> But I would think this would be a very common situation because
> pcie_portdrv_probe() calls pci_save_state() for Downstream Ports when
> pciehp, AER, PME, etc, are enabled, and this would happen before the
> pci_save_state() calls from Endpoint drivers.
>=20
> So I'm a little surprised that this didn't blow up for everybody
> immediately.  Is there something that makes this unusual?

I agree it should be very common and was quite surprised that -next
did not catch it. What I recall though is you modified the patch while=20
applying it by adding those Downstream Port checks so the fix=20
patch's Tested-by was for different code from what got applied (and it=20
would have been caught would the original author have tested also the=20
modified commit).

Unfortunately, I cannot think of anything that would be so unusual to=20
warrant not detecting it earlier. Maybe it was just the holiday period=20
causing less testing and lower level of awareness in general? The machine=
=20
doesn't always hang because of the problem as was the case with Nikl=C4=81v=
s,
so it might have occurred but went unnoticed if it occurred for a device=20
that is not critical.

> > Then later when
> > attempting to save the L1SS config while handling the Upstream Port,
> > parent->state_saved is true in pci_save_aspm_l1ss_state() resulting in
> > early return and skipping saving bridge's L1SS config because it is
> > assumed to be already saved. Later on restore, junk is written into
> > L1SS config which causes issues with some devices.
> >=20
> > Remove parent->state_saved check and unconditionally save L1SS config
> > also for the upstream bridge from an Upstream Port which ought to be
> > harmless from correctness point of view. With the Upstream Port check
> > now present, saving the L1SS config more than once for the bridge is no
> > longer a problem (unlike when the parent->state_saved check got
> > introduced into the fix during its development).
> >=20
> > Fixes: 1db806ec06b7 ("PCI/ASPM: Save parent L1SS config in pci_save_asp=
m_l1ss_state()")
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219731
> > Reported-by: Nikl=C4=81vs Ko=C4=BCes=C5=86ikovs <pinkflames.linux@gmail=
=2Ecom>
> > Tested-by: Nikl=C4=81vs Ko=C4=BCes=C5=86ikovs <pinkflames.linux@gmail.c=
om>
> > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  drivers/pci/pcie/aspm.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >=20
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index e0bc90597dca..da3e7edcf49d 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -108,9 +108,6 @@ void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
> >  =09pci_read_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL2, cap++);
> >  =09pci_read_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL1, cap++);
> > =20
> > -=09if (parent->state_saved)
> > -=09=09return;
> > -
> >  =09/*
> >  =09 * Save parent's L1 substate configuration so we have it for
> >  =09 * pci_restore_aspm_l1ss_state(pdev) to restore.
> >=20
> > base-commit: 72deda0abee6e705ae71a93f69f55e33be5bca5c
> > --=20
> > 2.39.5
> >=20
>=20

--=20
 i.
--8323328-1665104094-1738743386=:1070--

