Return-Path: <linux-pci+bounces-38875-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0122BF6049
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 13:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DFFC3B06AF
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 11:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A4132B9AA;
	Tue, 21 Oct 2025 11:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="arDyYrOn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99DB2F4A1B;
	Tue, 21 Oct 2025 11:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761046038; cv=none; b=frGgCyFY4q2RHNO4ceAmQnXzJZwnUipa0dj8jIOAfDwY6EwP2UPIUSql+MRsG6FgkVC1lJMGnsP0sFh6Whkf+6Kgm0mMQ21ojry2LkvEb85VJj0tXj0RMy95j+UX3d1dyA3wXzeqXDGrOwIrKtUU/aT37VXheko6/5FAzx25/8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761046038; c=relaxed/simple;
	bh=Mcw/R5C/1blOsSXxSnYelYotH/+tXWkrAqT9RAUEjyc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iuZynDft8VW2H5ltSwoikNcywllLrzFc7HDHVSemGUAmB+DEug1HMf9+sMMFjDt9Be6iOk9/4fssjqzxdYMChKKM2h91TNTGHoU2/nFBVY7GLWBLL0H8Ifmk2Pqwe7MU47LyruZQ1zcYObWykbzTPPVPrIMqjXe3qFSsJPgXgY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=arDyYrOn; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761046036; x=1792582036;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=Mcw/R5C/1blOsSXxSnYelYotH/+tXWkrAqT9RAUEjyc=;
  b=arDyYrOnGQwZJqtpCN+aUFD6I686n+AS6eqxYzaZ4tytTefGzriEjtHR
   1t3E5+B+l5aeXocEh+8PPYHJtfsxIkjZPBU3qaAL1agYWFzHBZN9MZCSt
   IpCxGjtile+cl7TBvhMXDsZS/O0gY+ZU6OsYsQmvbGMZ1yuIoErVzGSfi
   LchlDnd7ou7Jz44iiBwom9rii1mkaEAIcHxwWWoYJjeTl5Zn+2rbRtfn8
   ZBVf2KpRL6KsvlSASWc9ZLqs6BCIec0X9swXksUhbns0KFptM0p4/QqD7
   M3ONCma5HroswZpZX4Wuw68RIXQWaJ2epLvp6Fy1bTq2psecqDaj+jq5d
   A==;
X-CSE-ConnectionGUID: bU20rhQCSfSlKCPwrfwyzg==
X-CSE-MsgGUID: zIs7Qh5YT9KYh+nuJBjKdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="65784623"
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="65784623"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 04:27:16 -0700
X-CSE-ConnectionGUID: bDCDmVJ5TrC9gC94ZZ8SAA==
X-CSE-MsgGUID: MlYojyCSQQGE4SV5i27/1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="184049803"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.189])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 04:27:13 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 21 Oct 2025 14:27:09 +0300 (EEST)
To: Brian Norris <briannorris@chromium.org>
cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>, 
    LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, 
    "Rafael J . Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Prevent runtime suspend before devices are fully
 initialized
In-Reply-To: <aPaFACsVupPOe67G@google.com>
Message-ID: <06cd0121-819d-652d-afa7-eece15bf82a2@linux.intel.com>
References: <20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid> <aPH_B7SiJ8KnIAwJ@wunner.de> <67381f3b-4aee-a314-b5dd-2b7d987a7794@linux.intel.com> <aPKANja_k1gogTAU@google.com> <08976178-298f-79d9-1d63-cff5a4e56cc3@linux.intel.com>
 <aPaFACsVupPOe67G@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-479427486-1761044931=:1018"
Content-ID: <49460876-f5af-65c3-c424-466755820541@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-479427486-1761044931=:1018
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <706a33bd-aa0c-b5a8-88b0-500979f8acc2@linux.intel.com>

On Mon, 20 Oct 2025, Brian Norris wrote:

> Hi Ilpo,
>=20
> On Mon, Oct 20, 2025 at 06:56:41PM +0300, Ilpo J=E4rvinen wrote:
> > On Fri, 17 Oct 2025, Brian Norris wrote:
> >=20
> > > On Fri, Oct 17, 2025 at 02:49:35PM +0300, Ilpo J=E4rvinen wrote:
> > > > On Fri, 17 Oct 2025, Lukas Wunner wrote:
> > > >=20
> > > > > [cc +=3D Ilpo]
> > > > >=20
> > > > > On Thu, Oct 16, 2025 at 03:53:35PM -0700, Brian Norris wrote:
> > > > > > PCI devices are created via pci_scan_slot() and similar, and ar=
e
> > > > > > promptly configured for runtime PM (pci_pm_init()). They are in=
itially
> > > > > > prevented from suspending by way of pm_runtime_forbid(); howeve=
r, it's
> > > > > > expected that user space may override this via sysfs [1].
> > > >=20
> > > > Is this true as pm_runtime_forbid() also increases PM usage count?
> > >=20
> > > Yes it's true. See below.
> > >=20
> > > > "void pm_runtime_forbid(struct device *dev);
> > > >=20
> > > > unset the power.runtime_auto flag for the device and increase its=
=20
> > > > usage counter (used by the /sys/devices/.../power/control interface=
 to=20
> > > > effectively prevent the device from being power managed at run time=
)"
>=20
> I see this doc line confused you, and I can sympathize.
>=20
> IIUC, the parenthetical means that sysfs *uses* pm_runtime_forbid() to
> "effectively prevent runtime power management"; pm_runtime_forbid() does
> not block user space from doing anything.
>
> > > Right, but sysfs `echo auto > .../power/control` performs the inverse=
 --
> > > pm_runtime_allow() -- which decrements that count.
> >=20
> > Fair enough, I didn't check what it does.
> >=20
> > IMO, the details about how the usage count behaves should be part of th=
e=20
> > changelog as that documentation I quoted sounded like user control is=
=20
> > prevented when forbidden.
>=20
> I tried to elaborate on the API doc confusion above. But frankly, I'm
> not sure how best to explain runtime PM.
>=20
> > I see you've put this part of the explanation=20
> > into the v2 as well so I suggest you explain the usage count in the cha=
nge=20
> > so it is recorded in the commit if somebody has to look at this commit=
=20
> > years from now.
>=20
> Both v1 and v2 mention that the sysfs 'power/control' file can override
> the kernel calling pm_runtime_forbid(). They don't mention the usage
> count, since that's an implementation detail IMO. (To me, the mental
> model works best if "usage count" (usually get()/put()) is considered
> mostly orthogonal to forbid()/allow()/sysfs, because "forbid()" can be
> overridden at any time.)
>=20
> This is also covered here:
>=20
> https://docs.kernel.org/power/runtime_pm.html#runtime-pm-initialization-d=
evice-probing-and-removal
>=20
> "In principle, this mechanism may also be used by the driver to
> effectively turn off the runtime power management of the device until
> the user space turns it on."

The problem is already rooted into the function name, when a function is=20
called "forbid", anyone unfamiliar will think it really forbids=20
something. The docs just further reinforced the idea and the fact that it=
=20
also increments usage count.

It is quite unexpected and feels quite illogical (for non-PM person like=20
me) that user interface then goes to reverse that usage count increase,=20
what would be the logical reason why there now are less users for it when=
=20
user wants to turn on PM? (I understand things are done that way, no need=
=20
to explain that further, but there are quite a few misleading things in=20
this entire scenario, not just that parenthesis part of the docs.)

> But admittedly, I find the runtime PM API surface to be enormous, and
> its documentation ... not very helpful to outsiders. It's pretty much
> written by and for PM experts. Case in point: you read and quoted the
> appropriate docs, but it still misled you quite a bit :(
>=20
> I'm more tempted to try to improve the runtime PM docs than to try to
> make up for them in the commit message, but maybe I can be convinced
> otherwise.

My personal approach is that if something comes up during review, it=20
likely is something also the next person to look at this change (from=20
history, maybe years from now) could similarly stumbles on when trying to=
=20
understand the change. Thus, it often is worth to mention such things in=20
the changelog too.

While I'm definitely not against improvements to docs too, the changelog=20
for any patch should help to understand why the change was made. And=20
IMO, this unexpected "internal detail" related to usage count which is=20
quite significant here, if user interface wouldn't lower it, runtime PM=20
would remain forbidden as forbid() promised.

> > > > > Patch LGTM in principle, but adding Ilpo to cc who is refactoring=
 PCI
> > > > > resource allocation and may judge whether this can actually happe=
n.
> > > >=20
> > > > I can see there could be other failure modes besides just saving wr=
ong=20
> > > > config if devices get suspended underneath the resource assignment=
=20
> > > > algorithm.
> > > >=20
> > > > Besides hotplug, also BAR resize does changes the resources and BAR=
s.
> > > > This case is not helped by this patch.
> > >=20
> > > Is that the 'resource_N_resize' sysfs attributes? Becuase that holds =
PM
> > > references (pci_config_pm_runtime_{get,put}()) and therefore should n=
ot
> > > generally have the same problem.
> >=20
> > Okay, seem fine for the PCI core part.
> >=20
> > Driver's can also trigger BAR resize by calling pci_resize_resource()=
=20
> > directly but I've no idea how the usage counts behave (TBH, PM isn't my=
=20
> > strongest forte even if Lukas pulled me in to comment).
>=20
> There are only 3 drivers that call pci_resize_resource(). I looked into
> them, and it looks like they all hold pm_runtime_* references while
> doing this, or are calling it during pci_driver probe(), which docs say
> will hold a reference.
>=20
> https://docs.kernel.org/power/pci.html#device-runtime-power-management
>=20
> So they should all be OK too.

Thanks for checking.

--=20
 i.
--8323328-479427486-1761044931=:1018--

