Return-Path: <linux-pci+bounces-39027-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3250BFC3FC
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 15:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 097B36624FF
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 13:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2003B338904;
	Wed, 22 Oct 2025 13:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gDzsdu1f"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303A126ED48;
	Wed, 22 Oct 2025 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140340; cv=none; b=dGPXceHq+hmc+kBHJ2PdjW6Y3KDb/SVjY3YH2C8KObS1wiZh+ozN/tX/BxdPGWhibXn0Tg9IvXTZ3uruwceGzFiK5ZQSczzpfCuR/FGYtMMmd6gKyVIhlGLTvsremBNE4HW76jCQqiQaNQo+rJPESnmxtAJdrggr4HnYvV+6rGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140340; c=relaxed/simple;
	bh=9xHnWopWkQrZTSIZReWuDxrkg9Vvp+TNHnqnazJ6M+U=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LtDxQ1ni2INijHxZSAq1MSDqL8flk0qsrzFXI8XfyGUlI1k2oB12dXWLhj9tCcw0+mp8EhXzs6HiUMRi9y3Qi6iN+V0HFab06kNewNAoc1KLpl2MYTm5iq0ZFYoWESM0BNJoFvTZRZ5BvRqmNsbaXfmvZQGDE5+XOBDRXDkLbOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gDzsdu1f; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761140338; x=1792676338;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9xHnWopWkQrZTSIZReWuDxrkg9Vvp+TNHnqnazJ6M+U=;
  b=gDzsdu1fn4bBon7EsuJ4yBObq6s4KkBzYNFvJ/zqO/879tFgKWMO8o6x
   kpc5nYz7N8ld23O1wit7+9/F8sv5WCu1NjI3WibyzY8mP+QmzECAuKW3Y
   zd9NCkwoqy2WSmBiGD2soV3ZSOfaSn4m/rk0MPhi7DSt8eZ2llsNZxhdj
   czW4kZwfkG9ZvglAG3DPXBUM5VY7h/Rc8uudj000JJaWkoO4wPqi2QMBM
   2QsY4EOUZfzZC8gsaIZiJYSvP5F5yo4QSDe/kHTa942AurLM7e/Jxjzq5
   LnrLJLfv76nx06aioCKwiT0rUH2+pNWiaWetZ1n+m4T4cZXqpUvCBglXP
   Q==;
X-CSE-ConnectionGUID: UwfjMMi+Q+WcVt4GT1nyEA==
X-CSE-MsgGUID: nIGsH9NURvCyv29WFTea8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="50862756"
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="50862756"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 06:38:57 -0700
X-CSE-ConnectionGUID: 1mHcS7JnSmSw2nYkxDxU2w==
X-CSE-MsgGUID: oBGb3J9jQnWNz8Wtb2VP/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="207544375"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.82])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 06:38:54 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 22 Oct 2025 16:38:50 +0300 (EEST)
To: Brian Norris <briannorris@chromium.org>
cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>, 
    LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, 
    "Rafael J . Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Prevent runtime suspend before devices are fully
 initialized
In-Reply-To: <aPfNY9Yig2cR-Fua@google.com>
Message-ID: <7aceeac4-1cbe-590b-c1b7-5c62375cadd6@linux.intel.com>
References: <20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid> <aPH_B7SiJ8KnIAwJ@wunner.de> <67381f3b-4aee-a314-b5dd-2b7d987a7794@linux.intel.com> <aPKANja_k1gogTAU@google.com> <08976178-298f-79d9-1d63-cff5a4e56cc3@linux.intel.com>
 <aPaFACsVupPOe67G@google.com> <06cd0121-819d-652d-afa7-eece15bf82a2@linux.intel.com> <aPfNY9Yig2cR-Fua@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-793806919-1761140330=:1437"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-793806919-1761140330=:1437
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 21 Oct 2025, Brian Norris wrote:
> On Tue, Oct 21, 2025 at 02:27:09PM +0300, Ilpo J=E4rvinen wrote:
> > On Mon, 20 Oct 2025, Brian Norris wrote:
> > > On Mon, Oct 20, 2025 at 06:56:41PM +0300, Ilpo J=E4rvinen wrote:
> > > > On Fri, 17 Oct 2025, Brian Norris wrote:
> > > > > On Fri, Oct 17, 2025 at 02:49:35PM +0300, Ilpo J=E4rvinen wrote:
> > > > > > On Fri, 17 Oct 2025, Lukas Wunner wrote:
> > > > > > > On Thu, Oct 16, 2025 at 03:53:35PM -0700, Brian Norris wrote:
> > > > > > > > PCI devices are created via pci_scan_slot() and similar, an=
d are
> > > > > > > > promptly configured for runtime PM (pci_pm_init()). They ar=
e initially
> > > > > > > > prevented from suspending by way of pm_runtime_forbid(); ho=
wever, it's
> > > > > > > > expected that user space may override this via sysfs [1].
> > > > > >=20
> > > > > > Is this true as pm_runtime_forbid() also increases PM usage cou=
nt?
> > > > >=20
> > > > > Yes it's true. See below.
> > > > >=20
> > > > > > "void pm_runtime_forbid(struct device *dev);
> > > > > >=20
> > > > > > unset the power.runtime_auto flag for the device and increase i=
ts=20
> > > > > > usage counter (used by the /sys/devices/.../power/control inter=
face to=20
> > > > > > effectively prevent the device from being power managed at run =
time)"
> > >=20
> > > I see this doc line confused you, and I can sympathize.
> > >=20
> > > IIUC, the parenthetical means that sysfs *uses* pm_runtime_forbid() t=
o
> > > "effectively prevent runtime power management"; pm_runtime_forbid() d=
oes
> > > not block user space from doing anything.
> > >
> > > > > Right, but sysfs `echo auto > .../power/control` performs the inv=
erse --
> > > > > pm_runtime_allow() -- which decrements that count.
> > > >=20
> > > > Fair enough, I didn't check what it does.
> > > >=20
> > > > IMO, the details about how the usage count behaves should be part o=
f the=20
> > > > changelog as that documentation I quoted sounded like user control =
is=20
> > > > prevented when forbidden.
> > >=20
> > > I tried to elaborate on the API doc confusion above. But frankly, I'm
> > > not sure how best to explain runtime PM.
> > >=20
> > > > I see you've put this part of the explanation=20
> > > > into the v2 as well so I suggest you explain the usage count in the=
 change=20
> > > > so it is recorded in the commit if somebody has to look at this com=
mit=20
> > > > years from now.
> > >=20
> > > Both v1 and v2 mention that the sysfs 'power/control' file can overri=
de
> > > the kernel calling pm_runtime_forbid(). They don't mention the usage
> > > count, since that's an implementation detail IMO. (To me, the mental
> > > model works best if "usage count" (usually get()/put()) is considered
> > > mostly orthogonal to forbid()/allow()/sysfs, because "forbid()" can b=
e
> > > overridden at any time.)
> > >=20
> > > This is also covered here:
> > >=20
> > > https://docs.kernel.org/power/runtime_pm.html#runtime-pm-initializati=
on-device-probing-and-removal
> > >=20
> > > "In principle, this mechanism may also be used by the driver to
> > > effectively turn off the runtime power management of the device until
> > > the user space turns it on."
> >=20
> > The problem is already rooted into the function name, when a function i=
s=20
> > called "forbid", anyone unfamiliar will think it really forbids=20
> > something. The docs just further reinforced the idea and the fact that =
it=20
> > also increments usage count.
> >=20
> > It is quite unexpected and feels quite illogical (for non-PM person lik=
e=20
> > me) that user interface then goes to reverse that usage count increase,=
=20
> > what would be the logical reason why there now are less users for it wh=
en=20
> > user wants to turn on PM? (I understand things are done that way, no ne=
ed=20
> > to explain that further, but there are quite a few misleading things in=
=20
> > this entire scenario, not just that parenthesis part of the docs.)
>=20
> Ack. I'm definitely not defending the API names or the docs. I'm
> frustrated by the same, by how long it took me to figure out what
> everything really means, and by how the same footguns hit everyone I
> work with, and we have to write these essays to explain it every time.
>=20
> > > But admittedly, I find the runtime PM API surface to be enormous, and
> > > its documentation ... not very helpful to outsiders. It's pretty much
> > > written by and for PM experts. Case in point: you read and quoted the
> > > appropriate docs, but it still misled you quite a bit :(
> > >=20
> > > I'm more tempted to try to improve the runtime PM docs than to try to
> > > make up for them in the commit message, but maybe I can be convinced
> > > otherwise.
> >=20
> > My personal approach is that if something comes up during review, it=20
> > likely is something also the next person to look at this change (from=
=20
> > history, maybe years from now) could similarly stumbles on when trying =
to=20
> > understand the change. Thus, it often is worth to mention such things i=
n=20
> > the changelog too.
>=20
> Yes, I like that approach too. Unfortunately in this case, it feels like
> most of the confusion stems from the existing API and docs, and not from
> anything in the description. I never even mentioned the usage count,
> because frankly, I don't think it's relevant to the forbid()/allow()
> topic. In fact, the whole bug is because forbid() does *not* guarantee
> anything from the kernel's point of view -- it doesn't really hold a
> "usage count" for functional correctness in the way get()/put() do.
>=20
> Regardless, I can try to insert some language. Here's an attempt at yet
> another footnote for a v3:
>=20
> """
> [**] The relationship between pm_runtime_forbid(), pm_runtime_allow(),
> /sys/.../power/control, and the runtime PM usage counter can be subtle.
> It appears that the intention of pm_runtime_forbid() /
> pm_runtime_allow() is twofold:
>=20
> 1. Allow the user to disable runtime_pm (force device to always be
>    powered on) through sysfs.
> 2. Allow the driver to start with runtime_pm disabled (device forced
>    on) and user space could later enable runtime_pm.
>=20
> This conclusion comes from reading `Documentation/power/runtime_pm.rst`,
> specifically the section starting "The user space can effectively
> disallow".
>=20
> This means that while pm_runtime_forbid() does technically increase the
> runtime PM usage counter, this usage counter is not a guarantee of
> functional correctness from the kernel's point of view, because user
> space can decrease that count again via sysfs.
> """
>=20
> Let me know what you think.

I'm fine with that, it explains well where the problem stems from.
Thanks.

--
 i.

> Or feel free to tweak my v2 message and send
> a rewrite back to me (seriously! I'd like to see an outsider's view on
> what would explain it best).
>
> (And if that footnote is useful: I think part of that could belong in
> the actual docs.)
>=20
> > While I'm definitely not against improvements to docs too, the changelo=
g=20
> > for any patch should help to understand why the change was made. And=20
> > IMO, this unexpected "internal detail" related to usage count which is=
=20
> > quite significant here, if user interface wouldn't lower it, runtime PM=
=20
> > would remain forbidden as forbid() promised.
>=20
> I think improving the docs would reap rewards. Like I said, this is by
> far not the first time that developers have had significant problems due
> to API confusion.
>=20
> Brian
>=20
--8323328-793806919-1761140330=:1437--

