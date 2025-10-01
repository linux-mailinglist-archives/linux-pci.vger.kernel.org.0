Return-Path: <linux-pci+bounces-37343-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AB7BB06A1
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 15:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94FBC1637D2
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 13:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A36E2DECD4;
	Wed,  1 Oct 2025 13:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WqCHPUdG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63547298CC7;
	Wed,  1 Oct 2025 13:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759323976; cv=none; b=NyuiV393NooV3LpNhunxMrJqui4FcPn05TVHaqqheVbRpj/ZapQnZo0MsfGJU43SUCxHn5S1OjkGCKtKkL6bYoHVdGuKEYGDz5Yh0WJrwkVFApLWAxZa78KmcukNfM6FgIMJLAcwJKm3XjJWePWjJHiLjkqZnjUT3rM4/Nwdg4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759323976; c=relaxed/simple;
	bh=1OvWXAsAy/BF+wJJPiElN+MW6S/Mwt/1rUX6f9nUC38=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=alyu6PEVrOCq2UkeusEK6Y7StKXKbBMSjDKupASb6Vxgsze2yHKqwjad9sG6f1TXRuJG/WOiQKDUDafh+ivvzAqqEEnrWJ02mTg7hokcoQczmTU6TNqS9H+4R57OShWTK0WAUMOM3/B7uzOYWKGX7d0I7M8oi/q7fIK+31QQGmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WqCHPUdG; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759323975; x=1790859975;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=1OvWXAsAy/BF+wJJPiElN+MW6S/Mwt/1rUX6f9nUC38=;
  b=WqCHPUdGp1N7MScBTK57F8i/uiQoyYvhqkLgfNdeKrPq7tj8h8X98zQX
   HZCUct7b1utukfxMehAxHLne+ihqOu0zk6VEK5famwkBLU/wdPRvLT+oB
   BNeMx/Z0FUN2suMx4SGHqq8LCciLCrWtzz1Mo7ENOh6+NdsdgPQXUtKUu
   bvYmE0mlOjFScs5sqwjr9pBZx8mTCW+S3sl7gFMKk7eb2Sr1C4NiP3pn5
   Okmd86aSO6jFx9M9lJr++pxeUdgiMxxJsA9zoSz7M8MOs/dCYpBiYEY9b
   hEsJEpt/SAmePZAnJbGm0Awk4PysH7e3pgUrUL2RU/ypiRWWvV0/Brrw1
   Q==;
X-CSE-ConnectionGUID: VrrjYIrfQdaD5UPwybluEA==
X-CSE-MsgGUID: 67LlVoqWSseyta55jCgXfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61304378"
X-IronPort-AV: E=Sophos;i="6.18,306,1751266800"; 
   d="scan'208";a="61304378"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 06:06:14 -0700
X-CSE-ConnectionGUID: KJ8xa463RxeQYSsGQ3Snbg==
X-CSE-MsgGUID: +GAg8q1aQJaGMen2XLcsBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,306,1751266800"; 
   d="scan'208";a="178068987"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.85])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 06:06:10 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 1 Oct 2025 16:06:06 +0300 (EEST)
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Lucas De Marchi <lucas.demarchi@intel.com>, 
    Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI: Resources outside their window must set
 IORESOURCE_UNSET
In-Reply-To: <CAMuHMdUbaQDXsowZETimLJ-=gLCofeP+LnJp_txetuBQ0hmcPQ@mail.gmail.com>
Message-ID: <c17c5ec1-132d-3588-2a4d-a0e6639cf748@linux.intel.com>
References: <20250924134228.1663-1-ilpo.jarvinen@linux.intel.com> <20250924134228.1663-3-ilpo.jarvinen@linux.intel.com> <CAMuHMdVtVzcL3AX0uetNhKr-gLij37Ww+fcWXxnYpO3xRAOthA@mail.gmail.com> <4c28cd58-fd0d-1dff-ad31-df3c488c464f@linux.intel.com>
 <CAMuHMdUbaQDXsowZETimLJ-=gLCofeP+LnJp_txetuBQ0hmcPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-270159347-1759323966=:982"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-270159347-1759323966=:982
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 1 Oct 2025, Geert Uytterhoeven wrote:
> On Tue, 30 Sept 2025 at 18:32, Ilpo J=C3=A4rvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> > On Tue, 30 Sep 2025, Geert Uytterhoeven wrote:
> > > On Fri, 26 Sept 2025 at 04:40, Ilpo J=C3=A4rvinen
> > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > PNP resources are checked for conflicts with the other resource in =
the
> > > > system by quirk_system_pci_resources() that walks through all PCI
> > > > resources. quirk_system_pci_resources() correctly filters out resou=
rce
> > > > with IORESOURCE_UNSET.
> > > >
> > > > Resources that do not reside within their bridge window, however, a=
re
> > > > not properly initialized with IORESOURCE_UNSET resulting in bogus
> > > > conflicts detected in quirk_system_pci_resources():
> > > >
> > > > pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0x1fffffff 64bit pref]
> > > > pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0xdfffffff 64bit pref]: =
contains BAR 2 for 7 VFs
> > > > ...
> > > > pci 0000:03:00.0: VF BAR 2 [mem 0x00000000-0x1ffffffff 64bit pref]
> > > > pci 0000:03:00.0: VF BAR 2 [mem 0x00000000-0x3dffffffff 64bit pref]=
: contains BAR 2 for 31 VFs
> > > > ...
> > > > pnp 00:04: disabling [mem 0xfc000000-0xfc00ffff] because it overlap=
s 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > pnp 00:05: disabling [mem 0xc0000000-0xcfffffff] because it overlap=
s 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
> > > > pnp 00:05: disabling [mem 0xfedc0000-0xfedc7fff] because it overlap=
s 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > pnp 00:05: disabling [mem 0xfeda0000-0xfeda0fff] because it overlap=
s 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > pnp 00:05: disabling [mem 0xfeda1000-0xfeda1fff] because it overlap=
s 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > pnp 00:05: disabling [mem 0xc0000000-0xcfffffff disabled] because i=
t overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > pnp 00:05: disabling [mem 0xfed20000-0xfed7ffff] because it overlap=
s 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > pnp 00:05: disabling [mem 0xfed90000-0xfed93fff] because it overlap=
s 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > pnp 00:05: disabling [mem 0xfed45000-0xfed8ffff] because it overlap=
s 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > > pnp 00:05: disabling [mem 0xfee00000-0xfeefffff] because it overlap=
s 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > > >
> > > > Mark resources that are not contained within their bridge window wi=
th
> > > > IORESOURCE_UNSET in __pci_read_base() which resolves the false
> > > > positives for the overlap check in quirk_system_pci_resources().
> > > >
> > > > Fixes: f7834c092c42 ("PNP: Don't check for overlaps with unassigned=
 PCI BARs")
> > > > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > >
> > > Thanks for your patch, which is now commit 06b77d5647a4d6a7 ("PCI:
> > > Mark resources IORESOURCE_UNSET when outside bridge windows") in
> > > linux-next/master next-20250929 pci/next
>=20
> > > This replaces the actual resources by their sizes in the boot log on
> > > e.g. on R-Car M2-W:
> > >
> > >      pci-rcar-gen2 ee090000.pci: host bridge /soc/pci@ee090000 ranges=
:
> > >      pci-rcar-gen2 ee090000.pci:      MEM 0x00ee080000..0x00ee08ffff =
-> 0x00ee080000
> > >      pci-rcar-gen2 ee090000.pci: PCI: revision 11
> > >      pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
> > >      pci_bus 0000:00: root bus resource [bus 00]
> > >      pci_bus 0000:00: root bus resource [mem 0xee080000-0xee08ffff]
> > >      pci 0000:00:00.0: [1033:0000] type 00 class 0x060000 conventiona=
l PCI endpoint
> > >     -pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff]
> > >     -pci 0000:00:00.0: BAR 1 [mem 0x40000000-0x7fffffff pref]
> >
> > What is going to be the parent of these resources? They don't seem to f=
all
> > under the root bus resource above in which case the output change is
> > intentional so they don't appear as if address range would be "okay".
>=20
> >From /proc/iomem:
>=20
>     ee080000-ee08ffff : pci@ee090000
>       ee080000-ee080fff : 0000:00:01.0
>         ee080000-ee080fff : ohci_hcd
>       ee081000-ee0810ff : 0000:00:02.0
>         ee081000-ee0810ff : ehci_hcd
>     ee090000-ee090bff : ee090000.pci pci@ee090000

Okay, so this seem to appear in the resource tree but not among the root=20
bus resources.

>     ee0c0000-ee0cffff : pci@ee0d0000
>       ee0c0000-ee0c0fff : 0001:01:01.0
>         ee0c0000-ee0c0fff : ohci_hcd
>       ee0c1000-ee0c10ff : 0001:01:02.0
>         ee0c1000-ee0c10ff : ehci_hcd
>=20
> > When IORESOURCE_UNSET is set in a resource, %pR does not print the star=
t
> > and end addresses.
>=20
> Yeah, that's how I found this commit, without bisecting ;-)
>=20
> > >     +pci 0000:00:00.0: BAR 0 [mem size 0x00000400]
> > >     +pci 0000:00:00.0: BAR 1 [mem size 0x40000000 pref]
> > >      pci 0000:00:01.0: [1033:0035] type 00 class 0x0c0310 conventiona=
l PCI endpoint
> > >     -pci 0000:00:01.0: BAR 0 [mem 0x00000000-0x00000fff]
> > >     +pci 0000:00:01.0: BAR 0 [mem size 0x00001000]
> >
> > For this resource, it's very much intentional. It's a zero-based BAR wh=
ich
> > was left without IORESOURCE_UNSET prior to my patch leading to others p=
art
> > of the kernel to think that resource range valid and in use (in your
> > case it's so small it wouldn't collide with anything but it wasn't
> > properly set up resource, nonetheless).
> >
> > >      pci 0000:00:01.0: supports D1 D2
> > >      pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot
> > >      pci 0000:00:02.0: [1033:00e0] type 00 class 0x0c0320 conventiona=
l PCI endpoint
> > >     -pci 0000:00:02.0: BAR 0 [mem 0x00000000-0x000000ff]
> > >     +pci 0000:00:02.0: BAR 0 [mem size 0x00000100]
> >
> > And this as well is very much intentional.
> >
> > >      pci 0000:00:02.0: supports D1 D2
> > >      pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
> > >      PCI: bus0: Fast back to back transfers disabled
> > >      pci 0000:00:01.0: BAR 0 [mem 0xee080000-0xee080fff]: assigned
> > >      pci 0000:00:02.0: BAR 0 [mem 0xee081000-0xee0810ff]: assigned
> > >      pci_bus 0000:00: resource 4 [mem 0xee080000-0xee08ffff]
> > >
> > > Is that intentional?
> >
> > There's also that pci_dbg() in the patch which would show the original
> > addresses (print the resource before setting IORESOURCE_UNSET) but to s=
ee
> > it one would need to enable it with dyndbg=3D... Bjorn was thinking of
> > making that pci_info() though so it would appear always.
> >
> > Was this the entire PCI related diff? I don't see those 0000:00:00.0 BA=
Rs
> > getting assigned anywhere.
>=20
> The above log is almost complete (lacked enabling the device afterwards).
>=20
> AFAIU, the BARs come from the reg and ranges properties in the
> PCI controller nodes;
> https://elixir.bootlin.com/linux/v6.17/source/arch/arm/boot/dts/renesas/r=
8a7791.dtsi#L1562

Thanks, although I had already found this line by grep. I was just=20
expecting the address appear among root bus resources too.

Curiously enough, pci_register_host_bridge() seems to try to add some=20
resource from that list into bus and it's what prints those "root bus=20
resource" lines and ee090000 is not among the printed lines despite=20
appearing in /proc/iomem. As is, the resource tree and PCI bus view on the=
=20
resources seems to be in disagreement and I'm not sure what to make of it.

But before considering going into that direction or figuring out why this=
=20
ee090000 resource does not appear among root bus resources, could you=20
check if the attached patch changes behavior for the resource which are=20
non-zero based?

--=20
 i.

> The full related log for this device, for both instances, with the pci_db=
g()
> changes to pci_info():
>=20
>      pci-rcar-gen2 ee090000.pci: host bridge /soc/pci@ee090000 ranges:
>      pci-rcar-gen2 ee090000.pci:      MEM 0x00ee080000..0x00ee08ffff
> -> 0x00ee080000
>      pci-rcar-gen2 ee090000.pci: PCI: revision 11
>      pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
>      pci_bus 0000:00: root bus resource [bus 00]
>      pci_bus 0000:00: root bus resource [mem 0xee080000-0xee08ffff]
>      pci 0000:00:00.0: [1033:0000] type 00 class 0x060000 conventional
> PCI endpoint
>     -pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff]
>     -pci 0000:00:00.0: BAR 1 [mem 0x40000000-0x7fffffff pref]
>     +pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff]: no initial
> claim (no window)
>     +pci 0000:00:00.0: BAR 0 [mem size 0x00000400]
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
>      pci 0000:00:01.0: enabling device (0140 -> 0142)
>      pci 0000:00:02.0: enabling device (0140 -> 0142)
>      pci-rcar-gen2 ee0d0000.pci: host bridge /soc/pci@ee0d0000 ranges:
>      pci-rcar-gen2 ee0d0000.pci:      MEM 0x00ee0c0000..0x00ee0cffff
> -> 0x00ee0c0000
>      pci-rcar-gen2 ee0d0000.pci: PCI: revision 11
>      pci-rcar-gen2 ee0d0000.pci: PCI host bridge to bus 0001:01
>      pci_bus 0001:01: root bus resource [bus 01]
>      pci_bus 0001:01: root bus resource [mem 0xee0c0000-0xee0cffff]
>      pci 0001:01:00.0: [1033:0000] type 00 class 0x060000 conventional
> PCI endpoint
>     -pci 0001:01:00.0: BAR 0 [mem 0xee0d0800-0xee0d0bff]
>     -pci 0001:01:00.0: BAR 1 [mem 0x40000000-0x7fffffff pref]
>     +pci 0001:01:00.0: BAR 0 [mem 0xee0d0800-0xee0d0bff]: no initial
> claim (no window)
>     +pci 0001:01:00.0: BAR 0 [mem size 0x00000400]
>     +pci 0001:01:00.0: BAR 1 [mem 0x40000000-0x7fffffff pref]: no
> initial claim (no window)
>     +pci 0001:01:00.0: BAR 1 [mem size 0x40000000 pref]
>      pci 0001:01:01.0: [1033:0035] type 00 class 0x0c0310 conventional
> PCI endpoint
>     -pci 0001:01:01.0: BAR 0 [mem 0x00000000-0x00000fff]
>     +pci 0001:01:01.0: BAR 0 [mem 0x00000000-0x00000fff]: no initial
> claim (no window)
>     +pci 0001:01:01.0: BAR 0 [mem size 0x00001000]
>      pci 0001:01:01.0: supports D1 D2
>      pci 0001:01:01.0: PME# supported from D0 D1 D2 D3hot
>      pci 0001:01:02.0: [1033:00e0] type 00 class 0x0c0320 conventional
> PCI endpoint
>     -pci 0001:01:02.0: BAR 0 [mem 0x00000000-0x000000ff]
>     +pci 0001:01:02.0: BAR 0 [mem 0x00000000-0x000000ff]: no initial
> claim (no window)
>     +pci 0001:01:02.0: BAR 0 [mem size 0x00000100]
>      pci 0001:01:02.0: supports D1 D2
>      pci 0001:01:02.0: PME# supported from D0 D1 D2 D3hot
>      PCI: bus1: Fast back to back transfers disabled
>      pci 0001:01:01.0: BAR 0 [mem 0xee0c0000-0xee0c0fff]: assigned
>      pci 0001:01:02.0: BAR 0 [mem 0xee0c1000-0xee0c10ff]: assigned
>      pci_bus 0001:01: resource 4 [mem 0xee0c0000-0xee0cffff]
>      pci 0001:01:01.0: enabling device (0140 -> 0142)
>      pci 0001:01:02.0: enabling device (0140 -> 0142)
>=20
> > You didn't report any issues beyond textual changes in the log, I suppo=
se
> > there were none beyond the log differences?
>=20
> Sorry, I should have done a little bit more testing.  This is the funny
> on-chip Renesas R-Car Gen2 PCI host controller with integrated OHCI/EHCI
> PCI devices.  I don't have any USB devices connected, but "lspci -v"
> output is the same before/after, and the OHCI/EHCI drivers probe fine.
>=20
> BTW, I am seeing similar changes on rts7751r2d (qemu SuperH target r2d):
>=20
>      PCI host bridge to bus 0000:00
>      pci_bus 0000:00: root bus resource [io  0x1000-0x3fffff]
>      pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfdffffff]
>      pci_bus 0000:00: No busn resource found for root bus, will use [bus =
00-ff]
>      pci 0000:00:00.0: [1054:350e] type 00 class 0x060000 conventional
> PCI endpoint
>      pci 0000:00:00.0: [Firmware Bug]: BAR 0: invalid; can't size
>      pci 0000:00:00.0: [Firmware Bug]: BAR 1: invalid; can't size
>      pci 0000:00:00.0: [Firmware Bug]: BAR 2: invalid; can't size
>      pci 0000:00:02.0: [10ec:8139] type 00 class 0x020000 conventional
> PCI endpoint
>     -pci 0000:00:02.0: BAR 0 [io  0x0000-0x00ff]
>     -pci 0000:00:02.0: BAR 1 [mem 0x00000000-0x000000ff]
>     -pci 0000:00:02.0: ROM [mem 0x00000000-0x0007ffff pref]
>     +pci 0000:00:02.0: BAR 0 [io  0x0000-0x00ff]: no initial claim (no wi=
ndow)
>     +pci 0000:00:02.0: BAR 0 [io  size 0x0100]
>     +pci 0000:00:02.0: BAR 1 [mem 0x00000000-0x000000ff]: no initial
> claim (no window)
>     +pci 0000:00:02.0: BAR 1 [mem size 0x00000100]
>     +pci 0000:00:02.0: ROM [mem 0x00000000-0x0007ffff pref]: no
> initial claim (no window)
>     +pci 0000:00:02.0: ROM [mem size 0x00080000 pref]
>      pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 00
>      pci 0000:00:02.0: ROM [mem 0xfd000000-0xfd07ffff pref]: assigned
>      pci 0000:00:02.0: BAR 0 [io  0x1000-0x10ff]: assigned
>      pci 0000:00:02.0: BAR 1 [mem 0xfd080000-0xfd0800ff]: assigned
>=20
> All of these look legitimate to me, as they all start at zero.
>=20
> Thanks!
>=20
>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>=20
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
>=20
--8323328-270159347-1759323966=:982
Content-Type: text/x-diff; name=host_bridge_res.patch
Content-Transfer-Encoding: BASE64
Content-ID: <e5962baa-c2fa-b608-eaf0-852bf3a88a79@linux.intel.com>
Content-Description: 
Content-Disposition: attachment; filename=host_bridge_res.patch

RnJvbTogSWxwbyBKw6RydmluZW4gPGlscG8uamFydmluZW5AbGludXguaW50
ZWwuY29tPg0KU3ViamVjdDogW1BBVENIXSBQQ0k6IENoZWNrIGFsc28gaG9z
dCBicmlkZ2Ugd2luZG93cyBpbiBwYnVzX3NlbGVjdF93aW5kb3dfZm9yX3Jl
c19hZGRyKCkNCg0KQ2hlY2sgYWxzbyBob3N0IGJyaWRnZSB3aW5kb3dzIGlu
IHBidXNfc2VsZWN0X3dpbmRvd19mb3JfcmVzX2FkZHIoKSBhcw0KdGhleSBk
b24ndCBzZWVtIHRvIGFwcGVhciBpbiBhcHBlYXIgYXMgcm9vdCBidXMgcmVz
b3VyY2VzLg0KDQpTaWduZWQtb2ZmLWJ5OiBJbHBvIErDpHJ2aW5lbiA8aWxw
by5qYXJ2aW5lbkBsaW51eC5pbnRlbC5jb20+DQoNCi0tLQ0KIGRyaXZlcnMv
cGNpL3Byb2JlLmMgfCAxNyArKysrKysrKysrKysrKysrLQ0KIDEgZmlsZSBj
aGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9wcm9iZS5jIGIvZHJpdmVycy9wY2kv
cHJvYmUuYw0KaW5kZXggMDk3Mzg5ZjI1ODUzLi42NmYwNzYzMTEzY2IgMTAw
NjQ0DQotLS0gYS9kcml2ZXJzL3BjaS9wcm9iZS5jDQorKysgYi9kcml2ZXJz
L3BjaS9wcm9iZS5jDQpAQCAtMjA2LDEwICsyMDYsMTIgQEAgc3RhdGljIHZv
aWQgX19wY2lfc2l6ZV9yb20oc3RydWN0IHBjaV9kZXYgKmRldiwgdW5zaWdu
ZWQgaW50IHBvcywgdTMyICpzaXplcykNCiB9DQogDQogc3RhdGljIHN0cnVj
dCByZXNvdXJjZSAqcGJ1c19zZWxlY3Rfd2luZG93X2Zvcl9yZXNfYWRkcigN
Ci0JCQkJCWNvbnN0IHN0cnVjdCBwY2lfYnVzICpidXMsDQorCQkJCQlzdHJ1
Y3QgcGNpX2J1cyAqYnVzLA0KIAkJCQkJY29uc3Qgc3RydWN0IHJlc291cmNl
ICpyZXMpDQogew0KIAl1bnNpZ25lZCBsb25nIHR5cGUgPSByZXMtPmZsYWdz
ICYgSU9SRVNPVVJDRV9UWVBFX0JJVFM7DQorCXN0cnVjdCBwY2lfaG9zdF9i
cmlkZ2UgKmhvc3RfYnJpZGdlOw0KKwlzdHJ1Y3QgcmVzb3VyY2VfZW50cnkg
KndpbmRvdzsNCiAJc3RydWN0IHJlc291cmNlICpyOw0KIA0KIAlwY2lfYnVz
X2Zvcl9lYWNoX3Jlc291cmNlKGJ1cywgcikgew0KQEAgLTIyMiw2ICsyMjQs
MTkgQEAgc3RhdGljIHN0cnVjdCByZXNvdXJjZSAqcGJ1c19zZWxlY3Rfd2lu
ZG93X2Zvcl9yZXNfYWRkcigNCiAJCWlmIChyZXNvdXJjZV9jb250YWlucyhy
LCByZXMpKQ0KIAkJCXJldHVybiByOw0KIAl9DQorDQorCWlmICghcGNpX2lz
X3Jvb3RfYnVzKGJ1cykpDQorCQlyZXR1cm4gTlVMTDsNCisNCisJaG9zdF9i
cmlkZ2UgPSBwY2lfZmluZF9ob3N0X2JyaWRnZShidXMpOw0KKwlyZXNvdXJj
ZV9saXN0X2Zvcl9lYWNoX2VudHJ5KHdpbmRvdywgJmhvc3RfYnJpZGdlLT53
aW5kb3dzKSB7DQorCQlpZiAoKHdpbmRvdy0+cmVzLT5mbGFncyAmIElPUkVT
T1VSQ0VfVFlQRV9CSVRTKSAhPSB0eXBlKQ0KKwkJCWNvbnRpbnVlOw0KKw0K
KwkJaWYgKHJlc291cmNlX2NvbnRhaW5zKHdpbmRvdy0+cmVzLCByZXMpKQ0K
KwkJCXJldHVybiByOw0KKwl9DQorDQogCXJldHVybiBOVUxMOw0KIH0NCiAN
Cg0KLS0gDQp0ZzogKDc5NzBlNWQwMzhkNS4uKSBmaXgvY2hlY2staG9zdC1i
cmlkZ2Utd2luZG93cyAoZGVwZW5kcyBvbjogZml4L2lvdi1yZXNvdXJjZS1p
bml0KQ0K

--8323328-270159347-1759323966=:982--

