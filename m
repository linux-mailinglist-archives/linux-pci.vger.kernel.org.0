Return-Path: <linux-pci+bounces-3203-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C03F84CABF
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 13:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60C1F1C23E8A
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 12:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B752B3EA67;
	Wed,  7 Feb 2024 12:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KtmoFhCs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADB076037;
	Wed,  7 Feb 2024 12:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707309248; cv=none; b=pU/M9uPj9LG1BxXONvjV9ZqJsoET0sIPOr1g9yMFoZLHK2pOMcwGvz77PK/k1C+pejOE/Urv3YfC06mzoTQ0KlTVs8UtE4F941f2LVsKoZ/XEHGskGRaAfZ3/BnZE6B2R3F0K0yqRvp6ZoQ0Ww3ChQwKUOwQFAuyDSyLRdYDOyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707309248; c=relaxed/simple;
	bh=gicNa3q2ViIvmx6Y88aUX11nhY9Sw9dGhFiEn5z6B9A=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=D1p+Mcra8dN+mKhKWk9+xgKSfM/WHaUVvWD3bv+7T91MoVl3DCB/nliQ/rdq/An1pvSxFJc6D/caIxDF6O2GXt33nB2yX2TM2hfQyXN/JFC82PLxhKacx5VTMJqPk3HNqvn49VqB8048hUZ/Fpdv1vtPApBQP02oBBt39GvLOio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KtmoFhCs; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707309246; x=1738845246;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=gicNa3q2ViIvmx6Y88aUX11nhY9Sw9dGhFiEn5z6B9A=;
  b=KtmoFhCsz2xWmuCIXQmoDWjqC6V/TFN2VB92u/WZQgB047RqATPYU73h
   Z+VuYIXxcMPbViHnmVOslKon4j0cjt78DclqxuxXp4PgDkHF3xGolrrme
   N2RvM4bbuq3K0ke92YB3meGyf5i7lAFxvlY1VhTjhKoPOO0tXWomXiLsf
   VOUJvjfdh6ZNsyAOhvfqK1wdnH8uh39LV3PWoKzrzSbrrM3fDv4oWe1u5
   gzvinOwbXaCPG1adIHtDcEVOFWw87gSdQTuG5Gb9LggtACNSlG4MdSt4l
   Nfq1G+4dIi9eVVCjo1U/QRj2FQpxQK1DZsEcBp8IvKCFfmSwz5I6jjKcc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="18490770"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="18490770"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 04:34:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="933757694"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="933757694"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.51.96])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 04:34:04 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 7 Feb 2024 14:33:58 +0200 (EET)
To: "Maciej W. Rozycki" <macro@orcam.me.uk>, 
    Bjorn Helgaas <helgaas@kernel.org>
cc: linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/2] PCI: Clear LBMS on resume to avoid Target Speed
 quirk
In-Reply-To: <d9f6efe3-3e99-0e4b-0d1c-5dc3442c2419@linux.intel.com>
Message-ID: <a0b070b7-14ce-7cc5-4e6c-6e15f3fcab75@linux.intel.com>
References: <20240129184354.GA470131@bhelgaas> <aa2d1c4e-9961-d54a-00c7-ddf8e858a9b0@linux.intel.com> <alpine.DEB.2.21.2401301537070.15781@angie.orcam.me.uk> <a7ff7695-77c5-cf5a-812a-e24b716c3842@linux.intel.com> <d5f14b8f-f935-5d5e-e098-f2e78a2766c6@linux.intel.com>
 <alpine.DEB.2.21.2402011800320.15781@angie.orcam.me.uk> <d9f6efe3-3e99-0e4b-0d1c-5dc3442c2419@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1491708970-1707308919=:1119"
Content-ID: <310c15e8-21e3-64e6-31d0-5446c450f139@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1491708970-1707308919=:1119
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <c4b4649f-fe05-1d38-cc0b-02f19b5e96cc@linux.intel.com>

On Fri, 2 Feb 2024, Ilpo J=E4rvinen wrote:
> On Thu, 1 Feb 2024, Maciej W. Rozycki wrote:
> > On Thu, 1 Feb 2024, Ilpo J=E4rvinen wrote:
> >
> > > > >  What kind of scenario does the LBMS bit get set in that you have=
 a=20
> > > > > trouble with?  You write that in your case the downstream device =
has been=20
> > > > > disconnected while the bug hierarchy was suspended and it is not =
present=20
> > > > > anymore at resume, is that correct?
> > > > >
> > > > >  But in that case no link negotiation could have been possible an=
d=20
> > > > > consequently the LBMS bit mustn't have been set by hardware (acco=
rding to=20
> > > > > my understanding of PCIe), because (for compliant, non-broken dev=
ices=20
> > > > > anyway) it is only specified to be set for ports that can communi=
cate with=20
> > > > > the other link end (the spec explicitly says there mustn't have b=
een a=20
> > > > > transition through the DL_Down status for the port).
> > > > >
> > > > >  Am I missing something?
> > > >=20
> > > > Yes, when resuming the device is already gone but the bridge still =
has=20
> > > > LBMS set. My understanding is that it was set because it was there
> > > > from pre-suspend time but I've not really taken a deep look into it=
=20
> > > > because the problem and fix seemed obvious.
> >=20
> >  I've always been confused with the suspend/resume terminology: I'd hav=
e=20
> > assumed this would have gone through a power cycle, in which case the L=
BMS=20
> > bit would have necessarily been cleared in the transition, because its=
=20
> > required state at power-up/reset is 0, so the value of 1 observed would=
 be=20
> > a result of what has happened solely through the resume stage.  Otherwi=
se=20
> > it may make sense to clear the bit in the course of the suspend stage,=
=20
> > though it wouldn't be race-free I'm afraid.
>=20
> I also thought suspend as one possibility but yes, it racy. Mika also=20
> suggested clearing LBMS after each successful retrain but that wouldn't=
=20
> cover all possible ways to get LBMS set as devices can set it=20
> independently of OS. Keeping it cleared constantly is pretty much what=20
> will happen with the bandwidth controller anyway.
>=20
> > > > I read that "without the Port transitioning through DL_Down status"=
=20
> > > > differently than you, I only interpret that it relates to the two=
=20
> > > > bullets following it. ...So if retrain bit is set, and link then go=
es=20
> > > > down, the bullet no longer applies and LBMS should not be set becau=
se=20
> > > > there was transition through DL_Down. But I could well be wrong...
> >=20
> > What I refer to is that if you suspend your system, remove the device=
=20
> > that originally caused the quirk to trigger and then resume your system=
=20
> > with the device absent,
>=20
> A small correction here, the quirk didn't trigger initially for the=20
> device, it does that only after resume. And even then quirk is called=20
> only because the link doesn't come up.
>=20
> On longer term, I'd actually want to have hotplug resumed earlier so the=
=20
> disconnect could be detected before/while all this waiting related to lin=
k=20
> up is done. But that's very complicated to realize in practice because=20
> hotplug lurks behind portdrv so resuming it earlier isn't going to be=20
> about just moving a few lines around.
>=20
> > then LBMS couldn't have been set in the course of=20
> > resume, because the port couldn't have come out of the DL_Down status i=
n=20
> > the absence of the downstream device.  Do you interpret it differently?
>=20
> That's a good question and I don't have an answer to this yet, that is,
> I don't fully understand what happens to those device during runtime=20
> suspend/resume cycle and what is the exact mechanism that preserves the=
=20
> LBMS bit, I'll look more into it.
>=20
> But I agree that if the device goes cold enough and downstream is=20
> disconnected, the port should no longer have a way to reassert LBMS.

It seems that the root cause here is that the bridge ports do not enter=20
D3cold but remain in D3hot because of an ACPI power resource that is=20
shared (with Thunderbolt in this case but that's just one example, there=20
could be other similar sharings outside of what PCI controls).

There is an attempt to power off the entire hierarchy into D3cold on=20
suspend but the ports won't reach that state. Because the port remains in=
=20
D3hot, the config space is preserved and LBMS bit along with it.

So it seems that we cannot make the assumption that a device enters D3cold=
=20
just because it was suspended.


On the positive side, it was also tested that the logic fix I sent earlier=
=20
solved the most visible problem which is the delay on resume. It doesn't=20
address the false activation of Target Speed quirk because LBMS bit is=20
still set but the symptoms are no longer the same because of the=20
corrected logic.

So to solve the main issue with delay, there's no need to clear the LBMS=20
and the patch you're preparing/testing for pcie_failed_link_retrain()
together with the logic fix on its caller are enough to address the first=
=20
issue.

I still think those two should be put into the same commit because the
true <-> false changes, if made separately, lead to additional
incoherent states but if Bjorn wants them separately, at least they=20
should be put back-to-back so the brokeness is just within a single=20
commit in the history.

In addition, my 2nd patch addresses another issue which is unrelated=20
to this despite similar symptoms with extra delay on resume. I'll send v2=
=20
of that 2nd path separately with the inverted return value.

> > > Because if it is constantly picking another speed, it would mean you =
get=20
> > > LBMS set over and over again, no? If that happens 34-35 times per sec=
ond,=20
> > > it should be set already again when we get into that quirk because th=
ere=20
> > > was some wait before it gets called.
> >=20
> >  I'll see if I can experiment with the hardware over the next couple of=
=20
> > days and come back with my findings.
>=20
> Okay thanks.

One point I'd be very interested to know if the link actually comes up=20
successfully (even if briefly) because this has large implications whether=
=20
the quirk can actually be invoked from the bandwidth controller code.


--=20
 i.
--8323328-1491708970-1707308919=:1119--

