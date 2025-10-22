Return-Path: <linux-pci+bounces-38996-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BB3BFB917
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 13:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B756419A5183
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 11:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D2C32E6A5;
	Wed, 22 Oct 2025 11:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gVrvU1Gd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5665832C955;
	Wed, 22 Oct 2025 11:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761131605; cv=none; b=trXQQZJ7lI6i+Xnjaijey/D7aQEyGEvJ9sFVs/X5HlbO0ywGuFYdX3OGAYAVMqOg9cFFRWyjdTuJJ5nF/DHkmIB+t2zvC3+BkXvbLQ5Df2XPYTedKJX13iVacHv0Uwz5AdlidsnMiExDojj2Ku4Slgzm5uDp7L6kyVo00rXxvc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761131605; c=relaxed/simple;
	bh=X0lGHb2WGeOO5nr7dVDahmE7nisGyLBCTgkhr7nxGW8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Z4MZYnmVdhP/4vSfw9uSDoH4QfcwARit+5UHmBW0tZo84QDEuao8XIRZ+xFp02XBYsZ2EK6IOr8eyTBmgOUrS1ulHI3TreGIZ+dQonf8HtC91L1G80+gJF4HE29f6UvBCNRypcpTHgA0g8G1Hlt3LyaW0Lo2n8/dUUAuY4MSipo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gVrvU1Gd; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761131603; x=1792667603;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=X0lGHb2WGeOO5nr7dVDahmE7nisGyLBCTgkhr7nxGW8=;
  b=gVrvU1GdwPAZU12JoJurVAhyZ7N3FLYVjY/5u34zsj93T+Myrt19pHNv
   w+sAo3mwSfaLe5nOJvaUt60uZr/6ptJ3tJ+Y4ndEe6pG0hko5QTgAM7HO
   xSXzC/RE111GH3rKeSBdqvXTAS31Vxns84NkScoN5MdNtYEAr4+pvlOhJ
   xPfRkKq9+BGgQGrSnxI3qMuEXdaK/nNr/Pm5rR2WpO6pVJjdHcNqssa3J
   CJsh1nWQ9PwYA2BYhK79awMKhP/2IIWQMAcn9467NA2vnBG1lNeYPbEjC
   nyahqAHRxjYKPGbbrZM2ogUsC85/1F5dqKGhR+m8SIztsRg9HnduMvCr4
   w==;
X-CSE-ConnectionGUID: O54K0hdnRAGDx1MKFD3jUw==
X-CSE-MsgGUID: QLDZXu7CQzmjTKaozSUDXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="80711870"
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="80711870"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 04:13:23 -0700
X-CSE-ConnectionGUID: U8TkTXNOTRCjf0vJbP5PFA==
X-CSE-MsgGUID: RFzDodyHTpKi2cdzBA0F0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="221038025"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.82])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 04:13:19 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 22 Oct 2025 14:13:15 +0300 (EEST)
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    Kai-Heng Feng <kaihengf@nvidia.com>, Rob Herring <robh@kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 0/3] PCI & resource: Make coalescing host bridge windows
 safer
In-Reply-To: <CAMuHMdWD_GJ0hpJODBNKeR77UhKMW2CuWWf-xJo2kuL514_Tpw@mail.gmail.com>
Message-ID: <51f363d9-9a15-763a-bc1a-be9158253a07@linux.intel.com>
References: <20251010144231.15773-1-ilpo.jarvinen@linux.intel.com> <CAMuHMdVwAkC0XOU_SZ0HeH0+oT-j5SvKyRcFcJbbes624Yu9uQ@mail.gmail.com> <89a20c14-dd0f-22ae-d998-da511a94664a@linux.intel.com> <CAMuHMdUbseFEY8AGOxm2T8W-64qT9OSvfmvu+hyTJUT+WE2cVw@mail.gmail.com>
 <20844374-d3df-cc39-a265-44a3008a3bcb@linux.intel.com> <CAMuHMdWD_GJ0hpJODBNKeR77UhKMW2CuWWf-xJo2kuL514_Tpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-694626260-1761131595=:1437"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-694626260-1761131595=:1437
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 22 Oct 2025, Geert Uytterhoeven wrote:
> On Tue, 21 Oct 2025 at 13:54, Ilpo J=C3=A4rvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> > On Tue, 21 Oct 2025, Geert Uytterhoeven wrote:
> > > On Mon, 20 Oct 2025 at 18:20, Ilpo J=C3=A4rvinen
> > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > On Mon, 20 Oct 2025, Geert Uytterhoeven wrote:
> > > > > On Fri, 10 Oct 2025 at 16:42, Ilpo J=C3=A4rvinen
> > > > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > > > Here's a series for Geert to test if this fixes the improper co=
alescing
> > > > > > of resources as was experienced with the pci_add_resource() cha=
nge (I
> > > > > > know the breaking change was pulled before 6.18 main PR but I'd=
 want to
> > > > > > retry it later once the known issues have been addressed). The =
expected
> > > > > > result is there'll be two adjacent host bridge resources in the
> > > > > > resource tree as the different name should disallow coalescing =
them
> > > > > > together, and therefore BAR0 has a window into which it belongs=
 to.
> > > > > >
> > > > > > Generic info for the series:
> > > > > >
> > > > > > PCI host bridge windows were coalesced in place into one of the=
 structs
> > > > > > on the resources list. The host bridge window coalescing code d=
oes not
> > > > > > know who holds references and still needs the struct resource i=
t's
> > > > > > coalescing from/to so it is safer to perform coalescing into en=
tirely
> > > > > > a new struct resource instead and leave the old resource addres=
ses as
> > > > > > they were.
> > > > > >
> > > > > > The checks when coalescing is allowed are also made stricter so=
 that
> > > > > > only resources that have identical the metadata can be coalesce=
d.
> > > > > >
> > > > > > As a bonus, there's also a bit of framework to easily create ku=
nit
> > > > > > tests for resource tree functions (beyond just resource_coalesc=
e()).
> > > > > >
> > > > > > Ilpo J=C3=A4rvinen (3):
> > > > > >   PCI: Refactor host bridge window coalescing loop to use prev
> > > > > >   PCI: Do not coalesce host bridge resource structs in place
> > > > > >   resource, kunit: add test case for resource_coalesce()
> > > > >
> > > > > Thanks for your series!
> > > > >
> > > > > I have applied this on top of commit 06b77d5647a4d6a7 ("PCI:
> > > > > Mark resources IORESOURCE_UNSET when outside bridge windows"), an=
d
> > > > > gave it a a try on Koelsch (R-Car M2-W).
> > > >
> > > > So the pci_bus_add_resource() patch to rcar_pci_probe() was not inc=
luded?
> > > > No coalescing would be attempted without that change.
> > >
> > > Sorry, I didn't realize you wanted that (and anything else) to be
> > > included, too.  Please tell me the exact base I should use for testin=
g,
> > > and I will give it another run.
> >
> > I'm sorry, it's indeed a bit confusing as some of these patches never
> > have been in Linus' tree.
> >
> > So I'm interested on what's the result with these changes/series togeth=
er:
> >
> > [PATCH 1/2] PCI: Setup bridge resources earlier
> > [PATCH 2/2] PCI: Resources outside their window must set IORESOURCE_UNS=
ET
> > [PATCH 1/1] PCI: rcar-gen2: Add BAR0 into host bridge resources
> > [PATCH 1/3] PCI: Refactor host bridge window coalescing loop to use pre=
v
> > [PATCH 2/3] PCI: Do not coalesce host bridge resource structs in place
> > [PATCH 3/3] resource, kunit: add test case for resource_coalesce()
> >
> > You might also want to change that pci_dbg() in the IORESOURCE_UNSET pa=
tch
> > to pci_info() (as otherwise dyndbg is necessary to make it visible).
>=20
> Thanks, all done:
>=20
>     $ git cherry -v --abbrev=3D1 v6.18-rc2^
>     + 211ddde0 Linux 6.18-rc2
>     + 3fdaf2 PCI: Setup bridge resources earlier
>     + 5be02e5 PCI: Resources outside their window must set IORESOURCE_UNS=
ET
>     + adf6f11 PCI: rcar-gen2: Add BAR0 into host bridge resources
>     + eecb500 PCI: Refactor host bridge window coalescing loop to use pre=
v
>     + 60470b3 PCI: Do not coalesce host bridge resource structs in place
>     + afe3ec resource, kunit: add test case for resource_coalesce()
>     + 487c98 Use dev_info() in drivers/pci/probe.c:__pci_read_base()
> IORESOURCE_UNSET path
>=20
> Compared to v6.18-rc2, dmesg changed (for the first PCI/USB instance)
> like:
>=20
>      pci-rcar-gen2 ee090000.pci: host bridge /soc/pci@ee090000 ranges:
>      pci-rcar-gen2 ee090000.pci:      MEM 0x00ee080000..0x00ee08ffff
> -> 0x00ee080000
>      pci-rcar-gen2 ee090000.pci: PCI: revision 11
>      pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
>      pci_bus 0000:00: root bus resource [bus 00]
>      pci_bus 0000:00: root bus resource [mem 0xee080000-0xee08ffff]
>     +pci_bus 0000:00: root bus resource [mem 0xee090000-0xee090bff]
>      pci 0000:00:00.0: [1033:0000] type 00 class 0x060000 conventional
> PCI endpoint
>      pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff]
>     -pci 0000:00:00.0: BAR 1 [mem 0x40000000-0x7fffffff pref]
>     +pci 0000:00:00.0: BAR 1 [mem 0x40000000-0x7fffffff pref]: no
> initial claim (no window)
>     +pci 0000:00:00.0: BAR 1 [mem size 0x40000000 pref]
>      pci 0000:00:01.0: [1033:0035] type 00 class 0x0c0310 conventional
> PCI endpoint
>     -pci 0000:00:01.0: BAR 0 [mem 0x00000000-0x00000fff]
>     +pci 0000:00:01.0: BAR 0 [mem 0x00000000-0x00000fff]: no initial
> claim (no window)
>     +pci 0000:00:01.0: BAR 0 [mem size 0x00001000]
>      pci 0000:00:01.0: supports D1 D2
>      pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot
>      pci 0000:00:02.0: [1033:00e0] type 00 class 0x0c0320 conventional
> PCI endpoint
>     -pci 0000:00:02.0: BAR 0 [mem 0x00000000-0x000000ff]
>     +pci 0000:00:02.0: BAR 0 [mem 0x00000000-0x000000ff]: no initial
> claim (no window)
>     +pci 0000:00:02.0: BAR 0 [mem size 0x00000100]
>      pci 0000:00:02.0: supports D1 D2
>      pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
>      PCI: bus0: Fast back to back transfers disabled
>      pci 0000:00:01.0: BAR 0 [mem 0xee080000-0xee080fff]: assigned
>      pci 0000:00:02.0: BAR 0 [mem 0xee081000-0xee0810ff]: assigned
>      pci_bus 0000:00: resource 4 [mem 0xee080000-0xee08ffff]
>     +pci_bus 0000:00: resource 5 [mem 0xee090000-0xee090bff]
>      pci 0000:00:01.0: enabling device (0140 -> 0142)
>      pci 0000:00:02.0: enabling device (0140 -> 0142)
>=20
> > The expected result is that those usb resources are properly parented a=
nd
> > the ee080000-ee08ffff and ee090000-ee090bff are not coalesced together =
(as
> > that would destroy information). So something along the lines of:
> >
> >     ee080000-ee08ffff : pci@ee090000
> >       ee080000-ee080fff : 0000:00:01.0
> >         ee080000-ee080fff : ohci_hcd
> >       ee081000-ee0810ff : 0000:00:02.0
> >         ee081000-ee0810ff : ehci_hcd
> >     ee090000-ee090bff : ee090000.pci pci@ee090000
>=20
> Compared to v6.18-rc2, the output of "lspci -v" or "cat /proc/iomem"
> did not change.  Hence for the two PCI/USB instances:
>=20
>     ee080000-ee08ffff : pci@ee090000
>       ee080000-ee080fff : 0000:00:01.0
>         ee080000-ee080fff : ohci_hcd
>       ee081000-ee0810ff : 0000:00:02.0
>         ee081000-ee0810ff : ehci_hcd
>     ee090000-ee090bff : ee090000.pci pci@ee090000
>     ee0c0000-ee0cffff : pci@ee0d0000
>       ee0c0000-ee0c0fff : 0001:01:01.0
>         ee0c0000-ee0c0fff : ohci_hcd
>       ee0c1000-ee0c10ff : 0001:01:02.0
>         ee0c1000-ee0c10ff : ehci_hcd
>     ee0d0000-ee0d0bff : ee0d0000.pci pci@ee0d0000

Looks it works now when it comes to what PCI: Resources outside their=20
window must set IORESOURCE_UNSET tried to achieve.

Thanks a lot for all the testing!

--=20
 i.

--8323328-694626260-1761131595=:1437--

