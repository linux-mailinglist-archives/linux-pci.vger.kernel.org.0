Return-Path: <linux-pci+bounces-38897-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5299EBF6B84
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 15:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0C131891056
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 13:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1F12F0C79;
	Tue, 21 Oct 2025 13:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ORYUm00W"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B5027F759;
	Tue, 21 Oct 2025 13:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761052743; cv=none; b=oo0nyeC4NJLvFl2nkMmMNFxDmv6pIWJ67a5QumzYo5LUf6Tw9AdEAjNFBHabbXPeYlgSOu/ZhZfxP/ozKVJChfD5H1tfaySfsyFZsqh9GRucADvPPG2K03tp8SPjg9hyjF0IeF1FRuArFSVmwiClcSV3rVS2t48/zdwymmie6W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761052743; c=relaxed/simple;
	bh=1CqocnxLYPXxeLjuq5UmohrBCmDXaA+kDQupRU9VsM4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Qu1m47Y1U9Frg28v7IpfnGJDuEPB3Gu+jGLyxWWuPe50zGHpUhEDhXU8cf6GkIpulmxhA78NfYRYLSBdKaKkFWGCNETLgAIKiRrr8sg1wgQgMytZRVNMrGNQ6gu/7+msV29lKv2z65QUj7HI43X2d8nntnE27AMVllYjTb3nmEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ORYUm00W; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761052742; x=1792588742;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=1CqocnxLYPXxeLjuq5UmohrBCmDXaA+kDQupRU9VsM4=;
  b=ORYUm00WN7PceZ3AlDEImjIHb6rOWHO4cIr9/lAhBIvDS2vlNcZ/w9Qp
   W5fRTYweMOz7T20kncZrlgRUTZ10iTdssEmk+Q2nLdA763DUYAAQxNmuV
   rXXPJCX8ohxrYfrXsrVz7SlJvuFxEvXECOPW36gCXq4k1GLx1RZUdT/ub
   eId8C98DahOXTafMws1jdiPLBaGi9B0SqD0Aa7LOtrdZkT4XRTYGjfjk1
   PeUWRaaGFf+TXPys7qg8ZHxGA74qciqQqcjbJDiMXrbvfXccbxgDFFzkZ
   9umSMkjt25nLEYMxyVN6AQwJHfOGksBQTBrrkg+HBDagQaip6KCUG60Zj
   Q==;
X-CSE-ConnectionGUID: 58JcUWzdTdCPPw5EeNo1cw==
X-CSE-MsgGUID: lJLoo0q4RJ2AXaSVb8ffdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="85799505"
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="85799505"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 06:19:01 -0700
X-CSE-ConnectionGUID: jv73JKsWR6ueJyFvkZhc7w==
X-CSE-MsgGUID: iWoFrbT3ReKQRkH0NPEddA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="182793720"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.189])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 06:18:58 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 21 Oct 2025 16:18:54 +0300 (EEST)
To: "Rafael J. Wysocki" <rafael@kernel.org>
cc: Brian Norris <briannorris@chromium.org>, Lukas Wunner <lukas@wunner.de>, 
    Bjorn Helgaas <bhelgaas@google.com>, LKML <linux-kernel@vger.kernel.org>, 
    linux-pm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Prevent runtime suspend before devices are fully
 initialized
In-Reply-To: <CAJZ5v0giOw54L6M8rj-Q8ZELpFHx9LPKS2fAnsHHjHfhW_LZWw@mail.gmail.com>
Message-ID: <41d5c358-e469-3757-8bfb-e88c3d187e02@linux.intel.com>
References: <20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid> <aPH_B7SiJ8KnIAwJ@wunner.de> <67381f3b-4aee-a314-b5dd-2b7d987a7794@linux.intel.com> <aPKANja_k1gogTAU@google.com> <08976178-298f-79d9-1d63-cff5a4e56cc3@linux.intel.com>
 <aPaFACsVupPOe67G@google.com> <06cd0121-819d-652d-afa7-eece15bf82a2@linux.intel.com> <CAJZ5v0giOw54L6M8rj-Q8ZELpFHx9LPKS2fAnsHHjHfhW_LZWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-450250802-1761052734=:1018"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-450250802-1761052734=:1018
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 21 Oct 2025, Rafael J. Wysocki wrote:
> On Tue, Oct 21, 2025 at 1:27=E2=80=AFPM Ilpo J=C3=A4rvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> > On Mon, 20 Oct 2025, Brian Norris wrote:
> > > On Mon, Oct 20, 2025 at 06:56:41PM +0300, Ilpo J=C3=A4rvinen wrote:
> > > > On Fri, 17 Oct 2025, Brian Norris wrote:
> > > >
> > > > > On Fri, Oct 17, 2025 at 02:49:35PM +0300, Ilpo J=C3=A4rvinen wrot=
e:
> > > > > > On Fri, 17 Oct 2025, Lukas Wunner wrote:
> > > > > >
> > > > > > > [cc +=3D Ilpo]
> > > > > > >
> > > > > > > On Thu, Oct 16, 2025 at 03:53:35PM -0700, Brian Norris wrote:
> > > > > > > > PCI devices are created via pci_scan_slot() and similar, an=
d are
> > > > > > > > promptly configured for runtime PM (pci_pm_init()). They ar=
e initially
> > > > > > > > prevented from suspending by way of pm_runtime_forbid(); ho=
wever, it's
> > > > > > > > expected that user space may override this via sysfs [1].
> > > > > >
> > > > > > Is this true as pm_runtime_forbid() also increases PM usage cou=
nt?
> > > > >
> > > > > Yes it's true. See below.
> > > > >
> > > > > > "void pm_runtime_forbid(struct device *dev);
> > > > > >
> > > > > > unset the power.runtime_auto flag for the device and increase i=
ts
> > > > > > usage counter (used by the /sys/devices/.../power/control inter=
face to
> > > > > > effectively prevent the device from being power managed at run =
time)"
> > >
> > > I see this doc line confused you, and I can sympathize.
> > >
> > > IIUC, the parenthetical means that sysfs *uses* pm_runtime_forbid() t=
o
> > > "effectively prevent runtime power management"; pm_runtime_forbid() d=
oes
> > > not block user space from doing anything.
> > >
> > > > > Right, but sysfs `echo auto > .../power/control` performs the inv=
erse --
> > > > > pm_runtime_allow() -- which decrements that count.
> > > >
> > > > Fair enough, I didn't check what it does.
> > > >
> > > > IMO, the details about how the usage count behaves should be part o=
f the
> > > > changelog as that documentation I quoted sounded like user control =
is
> > > > prevented when forbidden.
> > >
> > > I tried to elaborate on the API doc confusion above. But frankly, I'm
> > > not sure how best to explain runtime PM.
> > >
> > > > I see you've put this part of the explanation
> > > > into the v2 as well so I suggest you explain the usage count in the=
 change
> > > > so it is recorded in the commit if somebody has to look at this com=
mit
> > > > years from now.
> > >
> > > Both v1 and v2 mention that the sysfs 'power/control' file can overri=
de
> > > the kernel calling pm_runtime_forbid(). They don't mention the usage
> > > count, since that's an implementation detail IMO. (To me, the mental
> > > model works best if "usage count" (usually get()/put()) is considered
> > > mostly orthogonal to forbid()/allow()/sysfs, because "forbid()" can b=
e
> > > overridden at any time.)
> > >
> > > This is also covered here:
> > >
> > > https://docs.kernel.org/power/runtime_pm.html#runtime-pm-initializati=
on-device-probing-and-removal
> > >
> > > "In principle, this mechanism may also be used by the driver to
> > > effectively turn off the runtime power management of the device until
> > > the user space turns it on."
> >
> > The problem is already rooted into the function name, when a function i=
s
> > called "forbid", anyone unfamiliar will think it really forbids
> > something.
>=20
> And it does, until the "allow" counterpart of it is called.
>=20
> The confusing part here is that the "allow" counterpart is called from
> a sysfs attribute.

Yes it is but the fact that allow then reduces usage count too even more=20
so. I understand it's necessary for allowing the functionality but I hope=
=20
you can see how illogical it sounds that usage suddenly is less because of=
=20
an user action through sysfs, it just defies normal reasoning (no offense=
=20
meant in any way to anyone :-)).

> > The docs just further reinforced the idea and the fact that it
> > also increments usage count.
> >
> > It is quite unexpected and feels quite illogical (for non-PM person lik=
e
> > me) that user interface then goes to reverse that usage count increase,
> > what would be the logical reason why there now are less users for it wh=
en
> > user wants to turn on PM? (I understand things are done that way, no ne=
ed
> > to explain that further, but there are quite a few misleading things in
> > this entire scenario, not just that parenthesis part of the docs.)
>=20
> So the purpose of this "forbid" call in pci_pm_init() is to "block"
> runtime PM for PCI devices by default, but allow user space to
> "unblock" it later.
>=20
> Would adding a comment to that effect next to that call be useful?

It would be useful to improve the wording in PM documentation which is too=
=20
ambiguous. I suggest changing this:

"void pm_runtime_forbid(struct device *dev);

unset the power.runtime_auto flag for the device and increase its
usage counter (used by the /sys/devices/.../power/control interface to=20
effectively prevent the device from being power managed at run time).

to:

"... (used to prevent the device from being power managed at run time=20
until pm_runtime_allow() or /sys/devices/.../power/control interface=20
allows it)."


I have to admit I'd still end up thinking usage count remains 1 up at this=
=20
point (if not knowing better like I do now) but at least it would
unambiguously tells what the interface does.


My another point related to whether that confusing usage count decrement=20
(solely because of user action) is worth describing in the changelog of=20
this patch (or v2 of it which follows your suggestion on moving enable=20
locatoon). IMO, it's odd/confusing enough a note would be warranted.
I know it after this discussion, obviously, but I worry over others who=20
trip over the same thing if somebody else has to look over this change.


--=20
 i.

--8323328-450250802-1761052734=:1018--

