Return-Path: <linux-pci+bounces-37279-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C852BAE0C6
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 18:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C69463B0EF4
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 16:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A1823ABAF;
	Tue, 30 Sep 2025 16:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ksuiz7AO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2521BF58;
	Tue, 30 Sep 2025 16:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759249964; cv=none; b=bcF9L5XorkfSMI4JOERRxuIESJphApUzESPE3ODNQRynAPN0TtikXoZbvr2NbyX1nw3UFFPndHIwweHcGYfVSlLfbxLhiq6BsfX+vlyTMslDNcXbvJpMh1qk/at2X5hOf+bAUo/K2Ij/pdAT0ga/0iEyHJkFJPa517d7wtYVInQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759249964; c=relaxed/simple;
	bh=o0O7XZ0Rycray72JiL0dDnyRZgrblyLdXNaQAkJKmCM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=g6DCNnduwCptbtojDynUhZIXrihXxS2qcyJR1yW20Wij6gLk0P7UqzuO4pQ0yX0VjAvVYSL4+t8ZdFlEiX39s7KCspFvqEAkvEAp3urpNXCaLEGfLdgxCqVM2H3ZfweBizWgEu9IIkhXJuMW8ggyGJtXAzyUWrdnk6FLrOysV3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ksuiz7AO; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759249962; x=1790785962;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=o0O7XZ0Rycray72JiL0dDnyRZgrblyLdXNaQAkJKmCM=;
  b=ksuiz7AOLWYGxvKHmOtuD3TaMj+nGQLUx2doEYDEhhKxkA3Vz376Qezs
   P5AU7V8FBU4InQd/R7FQN0FKK+WmYcu0DEqE42hmrz40PTVRkx4fMXbKv
   kQ+mI0RoGZTCtqZmL0qLLrcoX1E8gPuQDPgCcwcZz1rJGEvooM0cYlPvN
   B/AsXoZ4Mjgmoh0VhmTYhDI1JE8TH+LeGLVXnNyytS5V4abnuFj2d1b3m
   gNu8/T4+kRxabwJSGjiRsAp9m4umJfVLq1y0SfLpyo82Ke8zpOFtzZmem
   0PvmpC+tFbaLT7BgypmPEwlHzHLQlieIbtccKHbfcnVh+K91viny/ormJ
   A==;
X-CSE-ConnectionGUID: Sw5R6KVjSQu/uUpc3KsbYg==
X-CSE-MsgGUID: DQaA3eLoRp6tRKd1D/yhtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="64132830"
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="64132830"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 09:32:41 -0700
X-CSE-ConnectionGUID: pcNBjeiDQi+lYKkZ+CjsRg==
X-CSE-MsgGUID: QP0TblbyR2O4ZvVIMfF1uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="182866967"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.162])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 09:32:38 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 30 Sep 2025 19:32:34 +0300 (EEST)
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Lucas De Marchi <lucas.demarchi@intel.com>, 
    Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI: Resources outside their window must set
 IORESOURCE_UNSET
In-Reply-To: <CAMuHMdVtVzcL3AX0uetNhKr-gLij37Ww+fcWXxnYpO3xRAOthA@mail.gmail.com>
Message-ID: <4c28cd58-fd0d-1dff-ad31-df3c488c464f@linux.intel.com>
References: <20250924134228.1663-1-ilpo.jarvinen@linux.intel.com> <20250924134228.1663-3-ilpo.jarvinen@linux.intel.com> <CAMuHMdVtVzcL3AX0uetNhKr-gLij37Ww+fcWXxnYpO3xRAOthA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1633079381-1759248837=:937"
Content-ID: <4fb2cf65-9fc0-f97d-0c21-4a641f58811e@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1633079381-1759248837=:937
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <05b2fe41-fa8a-874a-59be-9fef78b16bc7@linux.intel.com>

On Tue, 30 Sep 2025, Geert Uytterhoeven wrote:
> On Fri, 26 Sept 2025 at 04:40, Ilpo J=E4rvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> > PNP resources are checked for conflicts with the other resource in the
> > system by quirk_system_pci_resources() that walks through all PCI
> > resources. quirk_system_pci_resources() correctly filters out resource
> > with IORESOURCE_UNSET.
> >
> > Resources that do not reside within their bridge window, however, are
> > not properly initialized with IORESOURCE_UNSET resulting in bogus
> > conflicts detected in quirk_system_pci_resources():
> >
> > pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0x1fffffff 64bit pref]
> > pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0xdfffffff 64bit pref]: cont=
ains BAR 2 for 7 VFs
> > ...
> > pci 0000:03:00.0: VF BAR 2 [mem 0x00000000-0x1ffffffff 64bit pref]
> > pci 0000:03:00.0: VF BAR 2 [mem 0x00000000-0x3dffffffff 64bit pref]: co=
ntains BAR 2 for 31 VFs
> > ...
> > pnp 00:04: disabling [mem 0xfc000000-0xfc00ffff] because it overlaps 00=
00:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > pnp 00:05: disabling [mem 0xc0000000-0xcfffffff] because it overlaps 00=
00:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
> > pnp 00:05: disabling [mem 0xfedc0000-0xfedc7fff] because it overlaps 00=
00:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > pnp 00:05: disabling [mem 0xfeda0000-0xfeda0fff] because it overlaps 00=
00:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > pnp 00:05: disabling [mem 0xfeda1000-0xfeda1fff] because it overlaps 00=
00:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > pnp 00:05: disabling [mem 0xc0000000-0xcfffffff disabled] because it ov=
erlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > pnp 00:05: disabling [mem 0xfed20000-0xfed7ffff] because it overlaps 00=
00:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > pnp 00:05: disabling [mem 0xfed90000-0xfed93fff] because it overlaps 00=
00:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > pnp 00:05: disabling [mem 0xfed45000-0xfed8ffff] because it overlaps 00=
00:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> > pnp 00:05: disabling [mem 0xfee00000-0xfeefffff] because it overlaps 00=
00:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
> >
> > Mark resources that are not contained within their bridge window with
> > IORESOURCE_UNSET in __pci_read_base() which resolves the false
> > positives for the overlap check in quirk_system_pci_resources().
> >
> > Fixes: f7834c092c42 ("PNP: Don't check for overlaps with unassigned PCI=
 BARs")
> > Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
>=20
> Thanks for your patch, which is now commit 06b77d5647a4d6a7 ("PCI:
> Mark resources IORESOURCE_UNSET when outside bridge windows") in
> linux-next/master next-20250929 pci/next

Hi Geert,

I really appreciate you paying attention!!

> This replaces the actual resources by their sizes in the boot log on
> e.g. on R-Car M2-W:
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

What is going to be the parent of these resources? They don't seem to fall
under the root bus resource above in which case the output change is=20
intentional so they don't appear as if address range would be "okay".

When IORESOURCE_UNSET is set in a resource, %pR does not print the start=20
and end addresses.

>     +pci 0000:00:00.0: BAR 0 [mem size 0x00000400]
>     +pci 0000:00:00.0: BAR 1 [mem size 0x40000000 pref]
>      pci 0000:00:01.0: [1033:0035] type 00 class 0x0c0310 conventional
> PCI endpoint
>     -pci 0000:00:01.0: BAR 0 [mem 0x00000000-0x00000fff]
>     +pci 0000:00:01.0: BAR 0 [mem size 0x00001000]

For this resource, it's very much intentional. It's a zero-based BAR which=
=20
was left without IORESOURCE_UNSET prior to my patch leading to others part=
=20
of the kernel to think that resource range valid and in use (in your=20
case it's so small it wouldn't collide with anything but it wasn't=20
properly set up resource, nonetheless).

>      pci 0000:00:01.0: supports D1 D2
>      pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot
>      pci 0000:00:02.0: [1033:00e0] type 00 class 0x0c0320 conventional
> PCI endpoint
>     -pci 0000:00:02.0: BAR 0 [mem 0x00000000-0x000000ff]
>     +pci 0000:00:02.0: BAR 0 [mem size 0x00000100]

And this as well is very much intentional.

>      pci 0000:00:02.0: supports D1 D2
>      pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
>      PCI: bus0: Fast back to back transfers disabled
>      pci 0000:00:01.0: BAR 0 [mem 0xee080000-0xee080fff]: assigned
>      pci 0000:00:02.0: BAR 0 [mem 0xee081000-0xee0810ff]: assigned
>      pci_bus 0000:00: resource 4 [mem 0xee080000-0xee08ffff]
>=20
> Is that intentional?

There's also that pci_dbg() in the patch which would show the original=20
addresses (print the resource before setting IORESOURCE_UNSET) but to see=
=20
it one would need to enable it with dyndbg=3D... Bjorn was thinking of=20
making that pci_info() though so it would appear always.

Was this the entire PCI related diff? I don't see those 0000:00:00.0 BARs=
=20
getting assigned anywhere.

You didn't report any issues beyond textual changes in the log, I suppose=
=20
there were none beyond the log differences?

--=20
 i.

> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -205,6 +205,26 @@ static void __pci_size_rom(struct pci_dev *dev, un=
signed int pos, u32 *sizes)
> >         __pci_size_bars(dev, 1, pos, sizes, true);
> >  }
> >
> > +static struct resource *pbus_select_window_for_res_addr(
> > +                                       const struct pci_bus *bus,
> > +                                       const struct resource *res)
> > +{
> > +       unsigned long type =3D res->flags & IORESOURCE_TYPE_BITS;
> > +       struct resource *r;
> > +
> > +       pci_bus_for_each_resource(bus, r) {
> > +               if (!r || r =3D=3D &ioport_resource || r =3D=3D &iomem_=
resource)
> > +                       continue;
> > +
> > +               if ((r->flags & IORESOURCE_TYPE_BITS) !=3D type)
> > +                       continue;
> > +
> > +               if (resource_contains(r, res))
> > +                       return r;
> > +       }
> > +       return NULL;
> > +}
> > +
> >  /**
> >   * __pci_read_base - Read a PCI BAR
> >   * @dev: the PCI device
> > @@ -329,6 +349,18 @@ int __pci_read_base(struct pci_dev *dev, enum pci_=
bar_type type,
> >                          res_name, (unsigned long long)region.start);
> >         }
> >
> > +       if (!(res->flags & IORESOURCE_UNSET)) {
> > +               struct resource *b_res;
> > +
> > +               b_res =3D pbus_select_window_for_res_addr(dev->bus, res=
);
> > +               if (!b_res ||
> > +                   b_res->flags & (IORESOURCE_UNSET | IORESOURCE_DISAB=
LED)) {
> > +                       pci_dbg(dev, "%s %pR: no initial claim (no wind=
ow)\n",
> > +                               res_name, res);
> > +                       res->flags |=3D IORESOURCE_UNSET;
> > +               }
> > +       }
> > +
> >         goto out;
> >
> >
>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20
>=20
--8323328-1633079381-1759248837=:937--

