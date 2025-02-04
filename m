Return-Path: <linux-pci+bounces-20687-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AB3A26CCF
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 08:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE5857A1BF5
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 07:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988482063C2;
	Tue,  4 Feb 2025 07:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EEM0Dbhb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E6718B494;
	Tue,  4 Feb 2025 07:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738655307; cv=none; b=ufMUhxwOnkFpz4NmKdGAAqzbh2ghorsVp4zzWRdnQhgD5MkgxPXCmbPA14/jSGxEUPZEfK7hxGYsEHPi5y4r0X3nRTOdvWvPAaqcDjh0XqGWVf4EA8nIgmwqhG0TBfoSQFOe7g8Q1nL7OijobSRekmwlCFZDzcDLRjWyTjFUAAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738655307; c=relaxed/simple;
	bh=PHPbFfxd4PoN/8hUEayeHJE+d2SjCCEAqdBeVbnf1OY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZvpMyveo5dQM4ESLyKBoE6I0H2yNXKKlgeABnMukdKiAg9W1C7QaHM4poij2edwHI1ycxkge0T8iw5h6+qHm4ONbpsz9/IkZmGNtWH6GyAL+UpdwN6Ub18+OmzPr0ahcLcaQZHf4xzsnQpQaqURnwtL0gbYn2MearI6kPJpByuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EEM0Dbhb; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738655304; x=1770191304;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=PHPbFfxd4PoN/8hUEayeHJE+d2SjCCEAqdBeVbnf1OY=;
  b=EEM0DbhbzPmEjUCP/LY6wncqvHN7w04gStnHldYpdOWeEFwcbNVH7KCH
   5Bu1kY1NwI18DBjYjCf6Eu+SQ5j96B9ecNR5emq/akDX9kl3sPmsjYjGY
   kKdM+rTSpy5mh8UbgQsJgUTJ/MKbSToJiYD3qTOXfPXj3SUVsrZ0Paft1
   /m/EG7bADUjtv2qF1FOjQfzXayDZiGMxmup73OuYJfkETyJKoePvOzJYp
   8Ru6EuvKQHHtERIo8+UOI4IHCZSobmF+dW3UnR5vF/6cXa116tbwpZBOo
   O8DgfvtTuAHIvq0zFX0/6HHAuRzBgRcV1mJYFwmOwozSp3DmrqDRFy7aP
   Q==;
X-CSE-ConnectionGUID: LrkiGP6TTPy1VNodMP/MJA==
X-CSE-MsgGUID: QVecScAUS4aV10h+J0B+3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="39323880"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="39323880"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 23:48:22 -0800
X-CSE-ConnectionGUID: HCLipMDFQcmDRry5t9IVpA==
X-CSE-MsgGUID: TBL5DaWnSDenYU0QEuTOfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="115520840"
Received: from oandoniu-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.75])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 23:48:19 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 4 Feb 2025 09:48:15 +0200 (EET)
To: "Rafael J. Wysocki" <rafael@kernel.org>
cc: Bjorn Helgaas <bhelgaas@google.com>, Jian-Hong Pan <jhp@endlessos.org>, 
    Linux PCI <linux-pci@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
    "Thorsten Leemhuis (regressions address)" <regressions@leemhuis.info>, 
    Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [Regression in 6.14-rc1] System suspend/resume broken by PCI
 commit 1db806ec06b7c
In-Reply-To: <CAJZ5v0i=yBSFW82E=s=mx7ztVzmnoUwbxkDRnYyDztAWK9VcsQ@mail.gmail.com>
Message-ID: <9aa469fd-da5b-70fc-147e-dd4a50cf5af6@linux.intel.com>
References: <CAJZ5v0iKmynOQ5vKSQbg1J_FmavwZE-nRONovOZ0mpMVauheWg@mail.gmail.com> <CAJZ5v0i=yBSFW82E=s=mx7ztVzmnoUwbxkDRnYyDztAWK9VcsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1986258784-1738655026=:1609"
Content-ID: <5be0ceb7-b569-5b1f-6635-7ad6318f540e@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1986258784-1738655026=:1609
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <d9a4dd33-9aa6-f9fb-99e4-67e607e89262@linux.intel.com>

On Mon, 3 Feb 2025, Rafael J. Wysocki wrote:

> On Mon, Feb 3, 2025 at 9:12=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
> >
> > Hi,

Hi Rafael,

> > The following commit:
> >
> > commit 1db806ec06b7c6e08e8af57088da067963ddf117
> > Author: Jian-Hong Pan <jhp@endlessos.org>
> > Date:   Fri Nov 15 15:22:02 2024 +0800
> >
> >    PCI/ASPM: Save parent L1SS config in pci_save_aspm_l1ss_state()
> >
> >    After 17423360a27a ("PCI/ASPM: Save L1 PM Substates Capability for
> >    suspend/resume"), pci_save_aspm_l1ss_state(dev) saves the L1SS state=
 for
> >    "dev", and pci_restore_aspm_l1ss_state(dev) restores the state for b=
oth
> >    "dev" and its parent.
> >
> >    The problem is that unless pci_save_state() has been used in some ot=
her
> >    path and has already saved the parent L1SS state, we will restore ju=
nk to
> >    the parent, which means the L1 Substates likely won't work correctly=
=2E
> >
> >    Save the L1SS config for both the device and its parent in
> >    pci_save_aspm_l1ss_state().  When restoring, we need both because L1=
SS must
> >    be enabled at the parent (the Downstream Port) before being enabled =
at the
> >    child (the Upstream Port).
> >
> >    Link: https://lore.kernel.org/r/20241115072200.37509-3-jhp@endlessos=
=2Eorg
> >    Fixes: 17423360a27a ("PCI/ASPM: Save L1 PM Substates Capability for
> > suspend/resume")
> >    Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218394
> >    Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> >    Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> >    [bhelgaas: parallel save/restore structure, simplify commit log, pat=
ch at
> >    https://lore.kernel.org/r/20241212230340.GA3267194@bhelgaas]
> >    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> >    Tested-by: Jian-Hong Pan <jhp@endlessos.org> # Asus B1400CEAE
> >
> > broke system suspend/resume on my Dell XPS13 9360.  It doesn't even
> > pass suspend/resume testing after "echo devices > /sys/power/pm_test".
> >
> > It looks like PCIe links are all down during resume after the above
> > commit, but it is rather hard to collect any data in that state.
> >
> > Reverting the above commit on top of 6.14-rc1 makes things work again,
> > no problem.
> >
> > I'm unsure what exactly the problem is ATM, but I'm going to check a
> > couple of theories.
>=20
> The attached change makes it work again, FWIW, but moving the
> parent->l1ss check alone below the pdev l1ss saving doesn't help.
>=20
> So it is either the parent check against NULL or the
> pcie_downstream_port(pdev) one that breaks it.  I guess the former,
> but I'll test it tomorrow.

Neither of those is the root cause but it's bit hard to see from the code=
=20
itself because the parent->saved_state check your test patch also removed=
=20
looks very logical on a glance (but that's the problematic line).

The fix is already here with the explanation:

https://lore.kernel.org/linux-pci/20250131152913.2507-1-ilpo.jarvinen@linux=
=2Eintel.com/T/#u

--=20
 i.
--8323328-1986258784-1738655026=:1609--

