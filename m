Return-Path: <linux-pci+bounces-2916-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3292B84547F
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 10:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEDF528724B
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 09:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE794D9E5;
	Thu,  1 Feb 2024 09:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZX3x6Hfw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9B04D9FC;
	Thu,  1 Feb 2024 09:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706780868; cv=none; b=tQwacElF3Do/Y5c1PKZUGIEWERi6dRLvVGeobhHrw640f9ssKmObUo6PNlynKO7wvEYuB7wieWETPEczbb3Rdg040PMp6ZMwinDYVDBJbCQJrJ1G538cxfiIo/srrwt7j2JoQ44Kd8leEf8Pgp71JJUXEG/R7ZjRFEtBLO70p/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706780868; c=relaxed/simple;
	bh=ojcSkXlz2RRabTXBWkspP5EDTZLEIi8uQ4kSGlO3ehY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Rt3X7aemH/0C9fKsun+j+T67KGhF/92/G3fxtrhYj14DgF/+fW0MTaTEgCaRTrvH0euGdnkq3eVs1hai6RN9mtLTbfhPAXC5+3Y0YviQA7B1jMMr9+EOPmuaPLDYqVt6lW68ZB4Bm0EtEOUXKQwZjo+U9xCi44pSKo58hFO5hkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZX3x6Hfw; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706780867; x=1738316867;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ojcSkXlz2RRabTXBWkspP5EDTZLEIi8uQ4kSGlO3ehY=;
  b=ZX3x6HfwLHZ9i1iVXOQvQO3UrvQpkLeiG2P1SjCTivpO1V/tvryVqC3w
   C5+nXzr35pyi0+xlrM6n/EBreD8SRGh33I+7ipduoUZsns8JEIqqASp5/
   SUUcEfG44h9PgC26ZKtvgX9EDUMJBNFBJpZdOchGviiPF29iEpLrLQzhG
   FDW8tBvi9Dj2IqfxJuVwY5Xo9nLnMAURwKvvKnZw+oOSG7vxfjln4YkyO
   igYfVdMvUG0ltTbRpds1pI0haW3kJRmA3lzbsldbjai7lkf8Lu98jj1JF
   hKpPplEnhQ4eWTej2qdNBO6DS7HnRqTCx8dtSn78/ipOT0pzJmR29vRsQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="402702305"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="402702305"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 01:47:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="788897871"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="788897871"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.33.1])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 01:47:42 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 1 Feb 2024 11:47:38 +0200 (EET)
To: "Maciej W. Rozycki" <macro@orcam.me.uk>, 
    Bjorn Helgaas <helgaas@kernel.org>
cc: linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/2] PCI: Clear LBMS on resume to avoid Target Speed
 quirk
In-Reply-To: <a7ff7695-77c5-cf5a-812a-e24b716c3842@linux.intel.com>
Message-ID: <d5f14b8f-f935-5d5e-e098-f2e78a2766c6@linux.intel.com>
References: <20240129184354.GA470131@bhelgaas> <aa2d1c4e-9961-d54a-00c7-ddf8e858a9b0@linux.intel.com> <alpine.DEB.2.21.2401301537070.15781@angie.orcam.me.uk> <a7ff7695-77c5-cf5a-812a-e24b716c3842@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-292880410-1706780858=:1028"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-292880410-1706780858=:1028
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 30 Jan 2024, Ilpo J=C3=A4rvinen wrote:

> On Tue, 30 Jan 2024, Maciej W. Rozycki wrote:
>=20
> > On Tue, 30 Jan 2024, Ilpo J=C3=A4rvinen wrote:
> >=20
> > > First of all, this is not true for pcie_failed_link_retrain():
> > >  * Return TRUE if the link has been successfully retrained, otherwise=
 FALSE.
> > > If LBMS is not set, the Target Speed quirk is not applied but the fun=
ction=20
> > > still returns true. I think that should be changed to early return fa=
lse
> > > when no LBMS is present.
> >=20
> >  I think there is a corner case here indeed.  If Link Active reporting =
is=20
> > supported and neither DLLLA nor LBMS are set at entry, then the functio=
n=20
> > indeed returns success even though the link is down and no attempt to=
=20
> > retrain will have been made.  So this does indeed look a case for a ret=
urn=20
> > with the FALSE result.
> >=20
> >  I think most easily this can be sorted by delegating the return result=
 to=20
> > a temporary variable, preset to FALSE and then only updated from result=
s=20
> > of the calls to `pcie_retrain_link'.  I can offer a patch as the author=
 of=20
> > the code and one who has means to verify it right away if that helped.
>=20
> I already wrote a patch which addresses this together with the caller=20
> site changes.
>=20
> >  Overall I guess it's all legacy of how this code evolved before it's b=
een=20
> > finally merged.
>=20
> Indeed, it looks the step by step changed didn't yield good result here.
>=20
> > > > >   3. pci_bridge_wait_for_secondary_bus() then calls pci_dev_wait(=
) which
> > > > >      cannot succeed (but waits ~1 minute, delaying the resume).
> > > > >=20
> > > > > The Target Speed trick (in step 2) is only used if LBMS bit (PCIe=
 r6.1
> > > > > sec 7.5.3.8) is set. For links that have been operational before
> > > > > suspend, it is well possible that LBMS has been set at the bridge=
 and
> > > > > remains on. Thus, after resume, LBMS does not indicate the link n=
eeds
> > > > > the Target Speed quirk. Clear LBMS on resume for bridges to avoid=
 the
> > > > > issue.
> >=20
> >  This can be problematic AFAICT however.  While I am not able to verify=
=20
> > suspend/resume operation with my devices, I expect the behaviour to be=
=20
> > exactly the same after resume as after a bus reset: the link will fail =
to=20
> > negotiate and the LBMS and DLLLA bits will be respectively set and clea=
r. =20
> > Consequently if you clear LBMS at resume, then the workaround won't=20
> > trigger and the link will remain inoperational in its limbo state.
>=20
> How do you get the LBMS set in the first place? Isn't that because the=20
> link tries to come up so shouldn't it reassert that bit again before the=
=20
> code ends up into the target speed quirk? That is, I assumed you actually=
=20
> wanted to detect LBMS getting set during pcie_wait_for_link_status() call=
=20
> preceeding pcie_failed_link_retrain() call?
>=20
> There's always an option to store it into pci_dev for later use when the=
=20
> quirk is found to be working for the first time if other solutions don't=
=20
> work.
>=20
> In any case and unrelated to this patch, the way this quirk monopolizes=
=20
> LBMS bit is going to have to be changed because it won't be reliable with=
=20
> the PCIe BW controller that sets up and irq for LBMS (and clears the bit)=
=2E
> In bwctrl v5 (yet to be posted) I'll add LBMS counter into bwctrl to allo=
w=20
> this quirk to keep working (which will need to be confirmed).
>=20
> >  What kind of scenario does the LBMS bit get set in that you have a=20
> > trouble with?  You write that in your case the downstream device has be=
en=20
> > disconnected while the bug hierarchy was suspended and it is not presen=
t=20
> > anymore at resume, is that correct?
> >
> >  But in that case no link negotiation could have been possible and=20
> > consequently the LBMS bit mustn't have been set by hardware (according =
to=20
> > my understanding of PCIe), because (for compliant, non-broken devices=
=20
> > anyway) it is only specified to be set for ports that can communicate w=
ith=20
> > the other link end (the spec explicitly says there mustn't have been a=
=20
> > transition through the DL_Down status for the port).
> >
> >  Am I missing something?
>=20
> Yes, when resuming the device is already gone but the bridge still has=20
> LBMS set. My understanding is that it was set because it was there
> from pre-suspend time but I've not really taken a deep look into it=20
> because the problem and fix seemed obvious.
>=20
> I read that "without the Port transitioning through DL_Down status"=20
> differently than you, I only interpret that it relates to the two=20
> bullets following it. ...So if retrain bit is set, and link then goes=20
> down, the bullet no longer applies and LBMS should not be set because=20
> there was transition through DL_Down. But I could well be wrong...

Hi again,

I went to check Root Ports on some machines and toggled their Link=20
Disable bit on. None of the Root Ports I tested cleared LBMS. That means
LBMS being on after resume is not enough to differentiate the HW which=20
needs Target Speed quirk and which does not. Unless we clear LBMS at some=
=20
point which was what this patch tried to do.

So this misidentification problem in the quirk looks quite widespread but=
=20
is mostly dormant because Links do come up normally so the quirk code is=20
never called.

I might conduct even larger set of tests once I script a way to=20
automatically pick a "safe" Root Port (something that is connected to a=20
device but unused, I manually picked Root Ports above unused NICs for the=
=20
manual tests I already did). But I don't believe it changes anything and=20
in the end I won't find any Root Ports that would actually clear LBMS on=20
their own when Link goes down.

So I would be really curious now to know how you get the LBMS on the=20
device that needs the Target Speed quirk? Is this true (from the commit=20
a89c82249c37 ("PCI: Work around PCIe link training failures")):

"Instead the link continues oscillating between the two speeds, at the=20
rate of 34-35 times per second, with link training reported repeatedly=20
active ~84% of the time."

?

Because if it is constantly picking another speed, it would mean you get=20
LBMS set over and over again, no? If that happens 34-35 times per second,=
=20
it should be set already again when we get into that quirk because there=20
was some wait before it gets called.

--=20
 i.

--8323328-292880410-1706780858=:1028--

