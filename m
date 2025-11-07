Return-Path: <linux-pci+bounces-40590-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A5DC40DC0
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 17:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A3463A8B04
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 16:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D6E270568;
	Fri,  7 Nov 2025 16:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V+8OX2QJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A589A25743D
	for <linux-pci@vger.kernel.org>; Fri,  7 Nov 2025 16:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762532555; cv=none; b=ot08YTMTw9n4cigH4iXc9oIqk98s08JWwNR0502qmMiC464YzaoIQT9LRVOVKR3Vji2ap5AiVWoEILt3COgmfQicKPD0OMHpSxjqIMn2jeVVX5aK5/RXhnsCx3wKjLnNabagrDCmrjgS0qKnw5REtJ8UfGx/JpZe1C7AIt5/BSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762532555; c=relaxed/simple;
	bh=M3hIRl80Q5O96AMnys0mCWCGm7+oZD+i2AUZ9a42n70=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=T7RcwtiEgZLqkyh1V43ArB2lRc6x6Ebz5c5GNkI363C0MBvTxEmj8qErbvNYJQFOfnQQ+w8XrjXzIc8/o0u6vvFgR2aYZk0FyHI/hQMcX8X2rz30adudZjPiGBWQYLLRnLmoRK+WC6UEgZLtt50TDNS6tl8zJJ20EDhn2BrgHwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V+8OX2QJ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762532544; x=1794068544;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=M3hIRl80Q5O96AMnys0mCWCGm7+oZD+i2AUZ9a42n70=;
  b=V+8OX2QJEex1pC6vD/TmluvZ9CGglP45V/ZOpY96MBmr1qbv0EayYe4I
   DdG0dzjDv3aYC4ZPW+zc5TvYW33D05oATb598Hh1OazuEer/OWKDCCbZ8
   O+JnXCGi87kHcA+nnf4ZAD7BRZ9uU/UOd9lPmNKYSwfzmd3wXUdz+h1x9
   qm880JNA/3IbgOeTLwUrzDtdUbEIGiYCm4WNltMNZMKXn6+AWX56x0OPn
   M+QqNoreIaS9Cm67BJ807YJGKhqG9Izg/WVCebrHZUF3Cu+6iZFrcg8/Z
   dvuqoPtbCp6tyHmHtXbveSzlzWG3pbU87GXI2wmnAEmFXW9JrTWwKTpR8
   g==;
X-CSE-ConnectionGUID: iYfJEDqwQmSPG1pYCsWmBA==
X-CSE-MsgGUID: EO8n+Tw2QJK9oN37J0v4aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="64724202"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="64724202"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 08:22:23 -0800
X-CSE-ConnectionGUID: 8R6kkMOVSImKBg4MFpbuJw==
X-CSE-MsgGUID: HZdBvog6Rei0tVV5DV4VJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="188239894"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.71])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 08:22:22 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 7 Nov 2025 18:22:18 +0200 (EET)
To: Steve Oswald <stevepeter.oswald@gmail.com>
cc: linux-pci@vger.kernel.org
Subject: Re: [BUG] Thunderbolt eGPU PCI BARs incorrectly assigned, fails to
 assign memory
In-Reply-To: <CAN95MYG_hRKrLWVLD9+BFeikOy7W5GN1px3kG8mE0p-DO0aAGA@mail.gmail.com>
Message-ID: <d2372a56-6b49-fe4f-4993-6e386f14852e@linux.intel.com>
References: <CAN95MYEaO8QYYL=5cN19nv_qDGuuP5QOD17pD_ed6a7UqFVZ-g@mail.gmail.com> <9254be77-46ea-992f-a1bd-98bea3943520@linux.intel.com> <f743efbe-56b7-ad85-f278-743af9385f10@linux.intel.com> <82ac5594-61c0-fece-1d9c-7c10316df384@linux.intel.com>
 <CAN95MYHpdz0u6-J_=7_enxq-TMzRJJJntfjYxBRgrG8UYbhQ1A@mail.gmail.com> <eb70b817-175c-7a34-d2bf-9472019afa47@linux.intel.com> <0263ea7c-8df9-1dba-f797-f18e253b3f30@linux.intel.com> <CAN95MYG_hRKrLWVLD9+BFeikOy7W5GN1px3kG8mE0p-DO0aAGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-636551309-1762532538=:1070"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-636551309-1762532538=:1070
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 11 Oct 2025, Steve Oswald wrote:

> Hi Ilpo,
> sorry for the late reply. It took me quite a while.
> The patch you sent was probably not based off of
> f6d41443f54856ceece0d5b584f47f681513bde4, because I used the
> linux-stable git and there was no pci_resource_num.
> I used git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
> @ f6d41443f548 added the missing function from the mainline repo.
>=20
> Hotplugging works now,

Thanks for testing.

> it still crashes the gpu driver on unplugging
> at runtime though, might still be related or just a driver bug.
> Here is the dmesg output:
> https://gist.githubusercontent.com/stepeos/cd060c7d66ab195f51ab4d5675b4e4=
af/raw/048752be295efe536c4f453938aac6e47e2429a3/patched%2520kernel

Those warnings look amdgpu driver state machine problem which have=20
nothing to do with PCI core code.

> Thanks for the fix!

I finally remembered to submit the fix officially. I you feel like it, you=
=20
can give your Tested-by tag if you want to be credited for your testing=20
efforts (in the thread where the official patch submission is so=20
maintainer's tools will pick it up automatically into the commit message).


--=20
 i.


> Am Mi., 8. Okt. 2025 um 13:43 Uhr schrieb Ilpo J=C3=A4rvinen
> <ilpo.jarvinen@linux.intel.com>:
> >
> > On Wed, 3 Sep 2025, Ilpo J=C3=A4rvinen wrote:
> >
> > > On Mon, 1 Sep 2025, Steve Oswald wrote:
> > >
> > > > I've added the dmesg output fordyndbg=3D"file drivers/pci/*. I wasn=
't
> > > > sure if I added it with the escaped quotes correctly.
> > > > https://gist.github.com/stepeos/cd060c7d66ab195f51ab4d5675b4e4af/ra=
w/9cf5fc3a8c4f13588a33d61865f804f85e50470a/dmesg_linux_6.11.0_dyndbg.log
> > >
> > > Hi again,
> > >
> > > I think the patch below should solve your issue. If you manage to get=
 it
> > > tested and are confident enough it fixed your issue, you may provide =
your
> > > Tested-by tag so I can include it into the official submission of the=
 fix.
> >
> > Hi Steve,
> >
> > Did you manage to test this patch?
> >
> > --
> >  i.
> >
> > >
> > >
> > > From 1c8ef31c6ac6616869b447a473e879b233df62db Mon Sep 17 00:00:00 200=
1
> > > From: =3D?UTF-8?q?Ilpo=3D20J=3DC3=3DA4rvinen?=3D <ilpo.jarvinen@linux=
=2Eintel.com>
> > > Date: Wed, 3 Sep 2025 15:53:48 +0300
> > > Subject: [PATCH 1/1] PCI: Prevent shrinking bridge window from its re=
quired
> > >  size
> > > MIME-Version: 1.0
> > > Content-Type: text/plain; charset=3DUTF-8
> > > Content-Transfer-Encoding: 8bit
> > >
> > > pci_bridge_distribute_available_resources() -> ... ->
> > > adjust_bridge_window() is called in between __pci_bus_size_bridges()
> > > and assigning the resources. Since the commit 948675736a77 ("PCI: All=
ow
> > > adjust_bridge_window() to shrink resource if necessary")
> > > adjust_bridge_window() can also shrink the bridge window to force it =
to
> > > a smaller size. The shrunken size, however, conflicts what
> > > __pci_bus_size_bridges() -> pbus_size_mem() calculated as the require=
d
> > > bridge window size. By shrinking the resource size,
> > > adjust_bridge_window() prevents rest of the resource fitting algorith=
m
> > > working as intended. Resource fitting logic is expecting assignment
> > > failures when bridge windows need resizing, but there are cases where
> > > failures are no longer happening after the commit 948675736a77 ("PCI:
> > > Allow adjust_bridge_window() to shrink resource if necessary").
> > >
> > > The commit 948675736a77 ("PCI: Allow adjust_bridge_window() to shrink
> > > resource if necessary") justifies the change by the extra reservation
> > > made due to hpmemsize parameter, however, the kernel code contradicts
> > > with that statement. (For simplicity, finer-grained hpmmiosize and
> > > hpmmiopref parameters that can be used to the same effect as hpmemsiz=
e
> > > are ignored in this description.)
> > >
> > > pbus_size_mem() calls calculate_memsize() twice. First with add_size=
=3D0
> > > to find out the minimal required resource size. The second call occur=
s
> > > with add_size=3Dhpmemsize (effectively) but the result does not direc=
tly
> > > affect the resource size only resulting in an entry on the realloc_he=
ad
> > > list (a.k.a. add_list). Yet, adjust_bridge_window() directly changes
> > > the resource size which does not include what is reserved due to
> > > hpmemsize. Also, if the required size for the bridge window exceeds
> > > hpmemsize, the parameter does not have any effect even on the second
> > > size calculcation made by pbus_size_mem(); from calculate_memsize():
> > >
> > >   size =3D max(size, add_size) + children_add_size;
> > >
> > > The commit ae4611f1d7e9 ("PCI: Set resource size directly in
> > > adjust_bridge_window()") that precedes the commit 948675736a77 ("PCI:
> > > Allow adjust_bridge_window() to shrink resource if necessary") is als=
o
> > > related to causing this problem. Its changelog explicitly states
> > > adjust_bridge_window() wants to "guarantee" allocation success.
> > > Guaranteed allocations, however, are incompatible with how the other
> > > parts of the resource fitting algorithm work. The given justification
> > > fails to explain why guaranteed allocations at this stage are require=
d
> > > nor why forcing window to a smaller value than what was calculated by
> > > pbus_size_mem() is correct. The the change might have worked by chanc=
e
> > > in some test scenario, too small bridge window does not "guarantee"
> > > success from the point of view of the endpoint device resource
> > > assignments. No issue is mentioned within the changelog so it's uncle=
ar
> > > if the change was made to fix some observed issue nor and what that
> > > issue was.
> > >
> > > The unwanted shrinking of a bridge window occurs, e.g., when a device
> > > with large BARs such as eGPU is attached using Thunderbolt and the Ro=
ot
> > > Port holds less than enough resource space for the eGPU. The GPU
> > > resources are in order of GBs and the default hotplug allocation is
> > > mere 2M (DEFAULT_HOTPLUG_MMIO_PREF_SIZE). The problem is illustrated =
by
> > > this log (filtered to the relevant content only):
> > >
> > > pci 0000:00:07.0: PCI bridge to [bus 03-2c]
> > > pci 0000:00:07.0:   bridge window [mem 0x6000000000-0x601bffffff 64bi=
t pref]
> > > pci 0000:03:00.0: PCI bridge to [bus 00]
> > > pci 0000:03:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pr=
ef]
> > > pci 0000:03:00.0: bridge configuration invalid ([bus 00-00]), reconfi=
guring
> > > pci 0000:03:00.0: PCI bridge to [bus 04-2c]
> > > pcieport 0000:00:07.0: Assigned bridge window [mem 0x6000000000-0x601=
bffffff 64bit pref] to [bus 03-2c] cannot fit 0xc00000000 required for 0000=
:03:00.0 bridging to [bus 04-2c]
> > > pci 0000:03:00.0: bridge window [mem 0x800000000-0x10003fffff 64bit p=
ref] to [bus 04-2c] add_size 100000 add_align 100000
> > > pcieport 0000:00:07.0: distributing available resources
> > > pci 0000:03:00.0: bridge window [mem 0x800000000-0x10003fffff 64bit p=
ref] shrunken by 0x00000007e4400000
> > > pci 0000:03:00.0: bridge window [mem 0x6000000000-0x601bffffff 64bit =
pref]: assigned
> > >
> > > The initial size of the Root Port's window is 448MB (0x601bffffff -
> > > 0x6000000000). __pci_bus_size_bridges() -> pbus_size_mem() calculates
> > > the required size to be 32772 MB (0x10003fffff - 0x800000000) which
> > > would fit the eGPU resources. adjust_bridge_window() then shrinks the
> > > bridge window down to what is guaranteed to fit into the Root Port's
> > > bridge window. The bridge window for 03:00.0 is also eliminated from
> > > the add_list (a.k.a. realloc_head) list by adjust_bridge_window().
> > >
> > > After adjustment, the resources are assigned and as the bridge window
> > > for 03:00.0 is assigned successfully, no failure is recorded. Without=
 a
> > > failure, no attempt to resize the window of the Root Port is required=
=2E
> > > The end result is eGPU not having large enough resources to work.
> > >
> > > The commit 948675736a77 ("PCI: Allow adjust_bridge_window() to shrink
> > > resource if necessary") also claims nested bridge windows are sized t=
he
> > > same, which is false. pbus_size_mem() calculates the size for the
> > > parent bridge window by summing all the downstream resources so the
> > > resource fitting calculates larger bridge window for the parent to
> > > accomodate the childen. That is, hpmemsize does not result the same
> > > size for the case where there are nested bridge windows.
> > >
> > > In order to fix the most immediate problem, don't shrink the resource
> > > size as hpmemsize had nothing to do with it. When considering add_siz=
e,
> > > only reduce it up to what is added due to hpmemsize (if required size
> > > is larger than hpmemsize, the parameter has no impact, see
> > > calculate_memsize()).
> > >
> > > This is not exactly a revert of the commits e4611f1d7e9 ("PCI: Set
> > > resource size directly in adjust_bridge_window()") and 948675736a77
> > > ("PCI: Allow adjust_bridge_window() to shrink resource if necessary")
> > > as shrinking still remains in place but is implemented differently,
> > > and the end result behaves very differently.
> > >
> > > It is possible that those two commits fixed some other issue that is
> > > not described with enough detail in the changelog and undoing parts o=
f
> > > them results in another regression due to behavioral change.
> > > Nonetheless, as described above, the solution by those two commits wa=
s
> > > flawed and the issue, if one exists, should be solved in a way that i=
s
> > > compatible with the rest of the resource fitting algorithm instead of
> > > working against it.
> > >
> > > Besides shrinking, the case where adjust_bridge_window() expands the
> > > bridge window is likely somewhat wrong as well because it removes the
> > > entry from add_list (a.k.a. realloc_head), but it is less damaging as
> > > that only impacts optional resources and may have no impact if
> > > expanding by hpmemsize is larger than what add_size was. Fixing it is
> > > left as further work.
> > >
> > > Reported-by: Steve Oswald <stevepeter.oswald@gmail.com>
> > > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > > ---
> > >  drivers/pci/setup-bus.c | 42 +++++++++++++++++++++++++++++++++++++++=
--
> > >  1 file changed, 40 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > > index 23082bc0ca37..4dd618bc4196 100644
> > > --- a/drivers/pci/setup-bus.c
> > > +++ b/drivers/pci/setup-bus.c
> > > @@ -1828,6 +1828,7 @@ static void adjust_bridge_window(struct pci_dev=
 *bridge, struct resource *res,
> > >                                resource_size_t new_size)
> > >  {
> > >       resource_size_t add_size, size =3D resource_size(res);
> > > +     struct pci_dev_resource *dev_res;
> > >
> > >       if (res->parent)
> > >               return;
> > > @@ -1840,9 +1841,46 @@ static void adjust_bridge_window(struct pci_de=
v *bridge, struct resource *res,
> > >               pci_dbg(bridge, "bridge window %pR extended by %pa\n", =
res,
> > >                       &add_size);
> > >       } else if (new_size < size) {
> > > +             int idx =3D pci_resource_num(bridge, res);
> > > +
> > > +             /*
> > > +              * hpio/mmio/mmioprefsize hasn't been included at all? =
See the
> > > +              * add_size param at the callsites of calculate_memsize=
().
> > > +              */
> > > +             if (!add_list)
> > > +                     return;
> > > +
> > > +             /* Only shrink if the hotplug extra relates to window s=
ize. */
> > > +             switch (idx) {
> > > +                     case PCI_BRIDGE_IO_WINDOW:
> > > +                             if (size > pci_hotplug_io_size)
> > > +                                     return;
> > > +                             break;
> > > +                     case PCI_BRIDGE_MEM_WINDOW:
> > > +                             if (size > pci_hotplug_mmio_size)
> > > +                                     return;
> > > +                             break;
> > > +                     case PCI_BRIDGE_PREF_MEM_WINDOW:
> > > +                             if (size > pci_hotplug_mmio_pref_size)
> > > +                                     return;
> > > +                             break;
> > > +                     default:
> > > +                             break;
> > > +             }
> > > +
> > > +             dev_res =3D res_to_dev_res(add_list, res);
> > >               add_size =3D size - new_size;
> > > -             pci_dbg(bridge, "bridge window %pR shrunken by %pa\n", =
res,
> > > -                     &add_size);
> > > +             if (add_size < dev_res->add_size) {
> > > +                     dev_res->add_size -=3D add_size;
> > > +                     pci_dbg(bridge, "bridge window %pR optional siz=
e shrunken by %pa\n",
> > > +                             res, &add_size);
> > > +             } else {
> > > +                     pci_dbg(bridge, "bridge window %pR optional siz=
e removed\n",
> > > +                             res);
> > > +                     remove_from_list(add_list, res);
> > > +             }
> > > +             return;
> > > +
> > >       } else {
> > >               return;
> > >       }
> > >
> > > base-commit: f6d41443f54856ceece0d5b584f47f681513bde4
> > >
>=20
--8323328-636551309-1762532538=:1070--

