Return-Path: <linux-pci+bounces-20702-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF700A27684
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 16:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43FB63A22BE
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 15:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748752147F0;
	Tue,  4 Feb 2025 15:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fQlEng11"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDAB21422A;
	Tue,  4 Feb 2025 15:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738684485; cv=none; b=P5S7Sq5ZMZlxLDzZ2YSnyMait1GYIRD60T/T5X/R3F0NpYv1F0v2HnG6k7tV8nGcXQmEZSlPo9rDkSf9S4/peIFczB0/k2WMdVHeCvBq+XJ85bq/i93vIQTz6rT5fNcw7jcWeKZZEb6Z2kMzLgqTmaLYFcIkx1DkOEz6ve7LuVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738684485; c=relaxed/simple;
	bh=8qlqVQxK47MfXuz/IlMtI71awf0Ys/kb2XmTpoJdOdo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KatUeVZuDRGaiqpi1scyteqJDbg4MLtdF/vlOfWNQm9DUG75+MCewTAN05QgZldTkA0x4NGrh//Ym1u91csEyNzskMQKsdiNvWzt7IZa2dlBFGhanyvUXv8X6Yj0ttleXI0Gbl4JFDB1ntg7satfQy3VFD8AY72gcyceUXPmzY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fQlEng11; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738684483; x=1770220483;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=8qlqVQxK47MfXuz/IlMtI71awf0Ys/kb2XmTpoJdOdo=;
  b=fQlEng117QykcwGDOf9H83SDYv/RZRT/G0C/6Cri5kANxbut94jNP0nu
   s664oakwU2rYNJNha7XHrGASV/Jimoe30PksN5SfJgo+mLKXkPa7gellN
   SOPax2M3voOXSu9dq4NEIKWSHzN4D3Z2EMKsNLwJyVkzG4eJALrp6VlfW
   MldfysraWiV0bmNNjwLZUpRpaNKqMXSL+zu4FLCm7xE/OtTGHiABJqpEg
   zn+pE5S4QShPUmXFPqIuvQ7kTGv7zrvq0EOG2UP5x40IwNwySTH5T6DyN
   g/v8tTYEFRg0ggvkDqqE/5UM2WBnIdn+Aj4YKnr/6oaH+pfLSg1/3U6qy
   w==;
X-CSE-ConnectionGUID: VaBYEXT6QpOWaq6v+/sUew==
X-CSE-MsgGUID: iEJCzG2AQhCGLWWNRHxC8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50211143"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="50211143"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 07:54:42 -0800
X-CSE-ConnectionGUID: 6zwWWK+4RduVnwixzY+yxA==
X-CSE-MsgGUID: K3ArKRGWRoaFSmTTIvDfkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="115621647"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.75])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 07:54:40 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 4 Feb 2025 17:54:36 +0200 (EET)
To: "Rafael J. Wysocki" <rafael@kernel.org>
cc: Bjorn Helgaas <bhelgaas@google.com>, Jian-Hong Pan <jhp@endlessos.org>, 
    Linux PCI <linux-pci@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
    "Thorsten Leemhuis (regressions address)" <regressions@leemhuis.info>, 
    Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [Regression in 6.14-rc1] System suspend/resume broken by PCI
 commit 1db806ec06b7c
In-Reply-To: <CAJZ5v0j157A=v6S8X4+QXRrmUfk2uN5DkRJ5RXd4e4o3hVucqg@mail.gmail.com>
Message-ID: <f903a3fb-5f5a-0bc9-92cf-34d151d234dc@linux.intel.com>
References: <CAJZ5v0iKmynOQ5vKSQbg1J_FmavwZE-nRONovOZ0mpMVauheWg@mail.gmail.com> <CAJZ5v0i=yBSFW82E=s=mx7ztVzmnoUwbxkDRnYyDztAWK9VcsQ@mail.gmail.com> <9aa469fd-da5b-70fc-147e-dd4a50cf5af6@linux.intel.com>
 <CAJZ5v0j157A=v6S8X4+QXRrmUfk2uN5DkRJ5RXd4e4o3hVucqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1985544570-1738684476=:10958"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1985544570-1738684476=:10958
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 4 Feb 2025, Rafael J. Wysocki wrote:

> Hi Ilpo,
>=20
> On Tue, Feb 4, 2025 at 8:48=E2=80=AFAM Ilpo J=C3=A4rvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> >
> > On Mon, 3 Feb 2025, Rafael J. Wysocki wrote:
> >
> > > On Mon, Feb 3, 2025 at 9:12=E2=80=AFPM Rafael J. Wysocki <rafael@kern=
el.org> wrote:
> > > >
> > > > Hi,
> >
> > Hi Rafael,
> >
> > > > The following commit:
> > > >
> > > > commit 1db806ec06b7c6e08e8af57088da067963ddf117
> > > > Author: Jian-Hong Pan <jhp@endlessos.org>
> > > > Date:   Fri Nov 15 15:22:02 2024 +0800
> > > >
> > > >    PCI/ASPM: Save parent L1SS config in pci_save_aspm_l1ss_state()
> > > >
> > > >    After 17423360a27a ("PCI/ASPM: Save L1 PM Substates Capability f=
or
> > > >    suspend/resume"), pci_save_aspm_l1ss_state(dev) saves the L1SS s=
tate for
> > > >    "dev", and pci_restore_aspm_l1ss_state(dev) restores the state f=
or both
> > > >    "dev" and its parent.
> > > >
> > > >    The problem is that unless pci_save_state() has been used in som=
e other
> > > >    path and has already saved the parent L1SS state, we will restor=
e junk to
> > > >    the parent, which means the L1 Substates likely won't work corre=
ctly.
> > > >
> > > >    Save the L1SS config for both the device and its parent in
> > > >    pci_save_aspm_l1ss_state().  When restoring, we need both becaus=
e L1SS must
> > > >    be enabled at the parent (the Downstream Port) before being enab=
led at the
> > > >    child (the Upstream Port).
> > > >
> > > >    Link: https://lore.kernel.org/r/20241115072200.37509-3-jhp@endle=
ssos.org
> > > >    Fixes: 17423360a27a ("PCI/ASPM: Save L1 PM Substates Capability =
for
> > > > suspend/resume")
> > > >    Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218394
> > > >    Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > > >    Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> > > >    [bhelgaas: parallel save/restore structure, simplify commit log,=
 patch at
> > > >    https://lore.kernel.org/r/20241212230340.GA3267194@bhelgaas]
> > > >    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > > >    Tested-by: Jian-Hong Pan <jhp@endlessos.org> # Asus B1400CEAE
> > > >
> > > > broke system suspend/resume on my Dell XPS13 9360.  It doesn't even
> > > > pass suspend/resume testing after "echo devices > /sys/power/pm_tes=
t".
> > > >
> > > > It looks like PCIe links are all down during resume after the above
> > > > commit, but it is rather hard to collect any data in that state.
> > > >
> > > > Reverting the above commit on top of 6.14-rc1 makes things work aga=
in,
> > > > no problem.
> > > >
> > > > I'm unsure what exactly the problem is ATM, but I'm going to check =
a
> > > > couple of theories.
> > >
> > > The attached change makes it work again, FWIW, but moving the
> > > parent->l1ss check alone below the pdev l1ss saving doesn't help.
> > >
> > > So it is either the parent check against NULL or the
> > > pcie_downstream_port(pdev) one that breaks it.  I guess the former,
> > > but I'll test it tomorrow.
> >
> > Neither of those is the root cause
>=20
> Well, not quite.
>=20
> > but it's bit hard to see from the code
> > itself because the parent->saved_state check your test patch also remov=
ed
>=20
> My patch hasn't removed that check.

Ah, I'm sorry, I read too quickly and assumed the first checks were just=20
moved to where the parent->state_saved check is, replacing it.

> Besides, suspend/resume works on my system without commit
> 1db806ec06b7c6e0 and the parent->saved_state only affects the parent,
> so it clearly cannot be the culprit here.
>=20
> > looks very logical on a glance (but that's the problematic line).
> >
> > The fix is already here with the explanation:
> >
> > https://lore.kernel.org/linux-pci/20250131152913.2507-1-ilpo.jarvinen@l=
inux.intel.com/T/#u
>=20
> So it turns out that the minimum fux that works here is what I posted.
> That is, the upfront pcie_downstream_port(pdev) check needs to be
> dropped and the !parent check needs to be moved after saving the
> pdev's state.
>=20
> IOW, it looks like on this platform, it is necessary to save the l1ss
> state for a Root Port.

The restore side, though, does also contains that pcie_downstream_port()=20
so nothing would be restored.

Could a downstream component attempt to restore L1SS config while never=20
having called the save beforehand? In such case your patch would make some=
=20
meaningful difference which could explain the outcome.

--=20
 i.

--8323328-1985544570-1738684476=:10958--

